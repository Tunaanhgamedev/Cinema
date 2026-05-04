package com.cinema.controller.User;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;

import com.cinema.dao.MovieDAO;
import com.cinema.model.Movie;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/api/ai/chat")
public class AIServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static String GEMINI_API_KEY = "";
    private static String GEMINI_URL = "";

    static {
        try (java.io.InputStream input = AIServlet.class.getClassLoader().getResourceAsStream("config.properties")) {
            java.util.Properties prop = new java.util.Properties();
            if (input != null) {
                prop.load(input);
                GEMINI_API_KEY = prop.getProperty("gemini.api.key");
                GEMINI_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=" + GEMINI_API_KEY;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    private final MovieDAO movieDAO = new MovieDAO();
    private final Gson gson = new Gson();
    private final HttpClient httpClient = HttpClient.newHttpClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");

        System.out.println("[AIServlet] New request received.");

        try {
            StringBuilder sb = new StringBuilder();
            String line;
            try (java.io.BufferedReader reader = req.getReader()) {
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
            }
            String inputJson = sb.toString();
            
            if (inputJson.isEmpty()) {
                resp.getWriter().write(gson.toJson(Map.of("reply", "Chào bạn! Tôi là BobiBot AI. Bạn muốn hỏi gì không?")));
                return;
            }

            JsonObject jsonRequest = gson.fromJson(inputJson, JsonObject.class);
            String userMessage = jsonRequest.has("message") ? jsonRequest.get("message").getAsString() : "";

            // Quản lý ngữ cảnh qua Session
            jakarta.servlet.http.HttpSession session = req.getSession();
            String lastMovieId = (String) session.getAttribute("lastMovieId");
            String lastMovieTitle = (String) session.getAttribute("lastMovieTitle");
            
            // Bộ đếm tin nhắn để tặng voucher chủ động
            Integer messageCount = (Integer) session.getAttribute("messageCount");
            if (messageCount == null) messageCount = 0;
            messageCount++;
            session.setAttribute("messageCount", messageCount);

            // Lấy danh sách phim thực tế để làm ngữ cảnh
            List<Movie> currentMovies = movieDAO.findAllWithFilters("", "newest");
            
            // Cập nhật ngữ cảnh nếu người dùng nhắc đến tên phim
            for (Movie m : currentMovies) {
                if (userMessage.toLowerCase().contains(m.getTitle().toLowerCase())) {
                    session.setAttribute("lastMovieId", String.valueOf(m.getMovieId()));
                    session.setAttribute("lastMovieTitle", m.getTitle());
                    lastMovieTitle = m.getTitle();
                    break;
                }
            }

            String aiResponse = "";

            if (GEMINI_API_KEY == null || GEMINI_API_KEY.equals("YOUR_GEMINI_API_KEY_HERE") || GEMINI_API_KEY.isEmpty()) {
                aiResponse = getFallbackResponse(userMessage, currentMovies, lastMovieTitle);
            } else {
                aiResponse = callGeminiAI(userMessage, currentMovies, lastMovieTitle);
                if (aiResponse == null || aiResponse.isEmpty()) {
                    aiResponse = getFallbackResponse(userMessage, currentMovies, lastMovieTitle);
                }
            }

            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("reply", aiResponse);
            resp.getWriter().write(gson.toJson(jsonResponse));
            
        } catch (Exception e) {
            e.printStackTrace();
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("reply", "Xin lỗi, BobiBot đang bận một chút. 🍿");
            resp.getWriter().write(gson.toJson(errorResponse));
        }
    }

    private String callGeminiAI(String message, List<Movie> movies, String lastMovieTitle) {
        try {
            String movieContext = movies.stream()
                .limit(10)
                .map(m -> String.format("- %s (Thể loại: %s)", m.getTitle(), m.getGenre()))
                .collect(Collectors.joining("\n"));

            String contextInfo = (lastMovieTitle != null) ? "\nKHÁCH ĐANG QUAN TÂM PHIM: " + lastMovieTitle : "";

            String systemPrompt = "Bạn là BobiBot - Trợ lý AI Đa Năng của rạp phim BOBIXI Cinema.\n\n"
                + "NHIỆM VỤ CỦA BẠN:\n"
                + "1. VỀ PHIM 🎬: Am hiểu sâu về danh sách phim sau:\n" + movieContext + contextInfo + "\n"
                + "   - Biết tư vấn phim theo sở thích, kể về đạo diễn/diễn viên (nếu biết) hoặc gợi ý phim tương tự.\n"
                + "2. VỀ WEBSITE 🌐: Bạn là chuyên gia hỗ trợ kỹ thuật web.\n"
                + "   - Hướng dẫn đặt vé, dùng mã giảm giá, xử lý lỗi hiển thị.\n"
                + "   - Biết vị trí các nút: Nút 'Lên đầu trang' ở góc trái, nút 'Chatbot' ở góc phải.\n"
                + "3. VỀ NHÂN VIÊN & CHÍNH SÁCH 👥:\n"
                + "   - Tư vấn về quy định rạp (đến trước 15p, không mang thức ăn ngoài).\n"
                + "   - Hướng dẫn tuyển dụng: Bảo khách xem mục 'Tuyển dụng' ở Footer hoặc gửi CV về hr@bobixi.vn.\n"
                + "   - Thái độ nhân viên: Luôn cam kết dịch vụ Premium 5 sao.\n\n"
                + "QUY TẮC ỨNG XỬ:\n"
                + "- Trả lời thân thiện, chuyên nghiệp, sử dụng icon phù hợp.\n"
                + "- Nếu khách hỏi về công nghệ: Nhấn mạnh rạp có âm thanh Dolby Atmos và màn hình 4K HDR cực đỉnh.\n"
                + "- Luôn ưu tiên giải quyết vấn đề của khách hàng một cách nhanh nhất.\n\n"
                + "CÂU HỎI CỦA KHÁCH: " + message;

            JsonObject content = new JsonObject();
            JsonArray parts = new JsonArray();
            JsonObject textPart = new JsonObject();
            textPart.addProperty("text", systemPrompt);
            parts.add(textPart);
            content.add("parts", parts);
            
            JsonArray contents = new JsonArray();
            contents.add(content);
            
            JsonObject requestBody = new JsonObject();
            requestBody.add("contents", contents);

            HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(GEMINI_URL))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(gson.toJson(requestBody)))
                .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() == 200) {
                JsonObject jsonResponse = gson.fromJson(response.body(), JsonObject.class);
                return jsonResponse.getAsJsonArray("candidates")
                    .get(0).getAsJsonObject()
                    .getAsJsonObject("content")
                    .getAsJsonArray("parts")
                    .get(0).getAsJsonObject()
                    .get("text").getAsString();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private String getFallbackResponse(String userMessage, List<Movie> movies, String lastMovieTitle) {
        if (userMessage == null || userMessage.trim().isEmpty()) {
            return "Tôi vẫn đang lắng nghe đây! Bạn muốn hỏi về phim hay dịch vụ nào tại BOBIXI Cinema?";
        }
        
        String msg = userMessage.toLowerCase();
        
        // --- 0. Lời chào theo thời điểm (Time-Aware) ---
        int hour = java.util.Calendar.getInstance().get(java.util.Calendar.HOUR_OF_DAY);
        String timeGreeting = "Chào bạn";
        if (hour >= 5 && hour < 11) timeGreeting = "Chào buổi sáng tốt lành";
        else if (hour >= 11 && hour < 14) timeGreeting = "Chúc bạn buổi trưa vui vẻ";
        else if (hour >= 14 && hour < 18) timeGreeting = "Chúc bạn buổi chiều năng động";
        else if (hour >= 18 && hour < 22) timeGreeting = "Chúc bạn buổi tối tuyệt vời";
        else timeGreeting = "Chào 'cú đêm' nhé";

        // --- 0.1 Tặng Voucher tự động (Proactive Discount) ---
        Integer mCount = (Integer) java.util.Optional.ofNullable(movies).map(m -> 0).orElse(0); // Chỉ là placeholder, dùng session bên dưới
        if (msg.contains("giảm giá") || msg.contains("khuyến mãi") || msg.contains("voucher") || msg.contains("code") || msg.contains("rẻ")) {
            return "Ní ơi, hôm nay rạp đang có mã bí mật **BOBIXI10** (giảm 10% tổng hóa đơn) dành riêng cho ní đó! Áp dụng ngay khi thanh toán nha. Chần chừ gì nữa ní ơi! 🎁✨";
        }

        // 1. Kiểm tra kết hợp Tên phim + Đặt vé/Lịch chiếu
        if (movies != null) {
            for (Movie m : movies) {
                String title = m.getTitle().toLowerCase();
                if (msg.contains(title)) {
                    String detailUrl = "MovieDetail?id=" + m.getMovieId();
                    if (msg.contains("đặt") || msg.contains("mua") || msg.contains("book") || msg.contains("vé")) {
                        return String.format("Bạn muốn đặt vé phim **%s** đúng không? Click vào đây để xem lịch và chọn ghế ngay nhé: [ĐẶT VÉ TẠI ĐÂY](%s) 🎟️\n\n*Gợi ý: Ní đừng quên mua thêm **Combo Couple** để vừa xem phim vừa nhâm nhi bắp phô mai cực đã nhé! 🍿*", m.getTitle(), detailUrl);
                    }
                    if (msg.contains("lịch") || msg.contains("suất") || msg.contains("giờ")) {
                        return String.format("Lịch chiếu của phim **%s** hôm nay đang rất sẵn sàng! Ní xem chi tiết các suất chiếu tại đây nha: [XEM LỊCH CHIẾU](%s) 🎬", m.getTitle(), detailUrl);
                    }
                    if (msg.contains("trailer") || msg.contains("xem thử")) {
                        return String.format("Trailer của siêu phẩm **%s** đây nhé ní: [XEM TRAILER](%s). Xem xong đảm bảo muốn ra rạp ngay! 🎥", m.getTitle(), m.getTrailerUrl());
                    }
                    return String.format("Bạn đang quan tâm đến phim **%s** đúng không? Đây là phim thuộc thể loại %s. Xem chi tiết tại đây nhé: [%s](%s) 🎬", 
                                        m.getTitle(), m.getGenre(), m.getTitle(), detailUrl);
                }
            }
        }

        // 1.1 Xử lý ngữ cảnh từ câu trước (Nếu khách hỏi "lịch chiếu" mà trước đó đã nhắc tên phim)
        if (lastMovieTitle != null) {
            if (msg.contains("lịch") || msg.contains("suất") || msg.contains("giờ") || msg.contains("khi nào")) {
                return String.format("Phim **%s** bạn vừa hỏi hiện đang có rất nhiều suất chiếu trong ngày hôm nay. Bạn nhấn vào nút 'Đặt vé' tại trang chủ để xem lịch cụ thể nhé! 🎟️", lastMovieTitle);
            }
            if (msg.contains("đặt") || msg.contains("mua") || msg.contains("book") || msg.contains("vé")) {
                return String.format("Để đặt vé cho phim **%s**, bạn hãy chọn poster phim ngoài trang chủ và bấm nút đặt vé. Tôi luôn sẵn sàng hỗ trợ bạn! 🍿", lastMovieTitle);
            }
        }

        // 2. Xử lý các câu trả lời khẳng định
        if (msg.equals("có") || msg.equals("vâng") || msg.equals("ok") || msg.equals("yes") || msg.equals("được") || msg.equals("ừ") || msg.equals("uh") || msg.contains("ok nà")) {
            if (lastMovieTitle != null) {
                return String.format("Tuyệt vời! Tôi sẽ hỗ trợ bạn đặt vé cho phim **%s**. Bạn cần tôi giúp gì thêm về bộ phim này không? 🎬✨", lastMovieTitle);
            }
            return "Vâng ạ! Ní muốn tôi tư vấn tiếp về phim, giá vé hay các combo bắp nước ngon lành đây? 😊🍿";
        }

        // 2.1 Xử lý câu trả lời phủ định
        if (msg.equals("không") || msg.equals("thôi") || msg.equals("chưa") || msg.equals("no") || msg.contains("không cần") || msg.contains("dẹp đi")) {
            return "Hì, không sao nè! Nếu lúc nào bạn đổi ý hoặc cần hỗ trợ gì khác (như giá vé, địa chỉ rạp...) thì cứ gọi tôi nhé. Tôi vẫn ở đây chờ bạn! ❤️👋";
        }

        // 3. Nhận diện nếu khách đang hỏi về một bộ phim lạ
        if ((msg.contains("có phim") || msg.contains("chiếu phim") || msg.contains("xem phim")) && !(msg.contains("giá") || msg.contains("combo") || msg.contains("đặt") || msg.contains("mua"))) {
            return "Rất tiếc, phim này hiện chưa có lịch chiếu tại BOBIXI Cinema. 😔 \nTuy nhiên, rạp đang có rất nhiều phim hot như **Lật Mặt 7** hay **Avenger**. Bạn có muốn tôi liệt kê danh sách phim đang chiếu không?";
        }
        
        // 3.1 Trend Zone - Cập nhật ngôn ngữ trẻ trung
        if (msg.contains("ngoan xinh yêu") || msg.contains("cưng")) {
            return "Dạ có BobiBot ngoan xinh yêu của ní đây! Ní muốn đặt vé phim gì để tôi hỗ trợ tận tình nè? ✨";
        }

        if (msg.contains("chữa lành") || msg.contains("chill")) {
            return "Muốn chữa lành thì phải đến BOBIXI Cinema nha! Một bộ phim hay cùng một xô bắp phô mai là liều thuốc 'healing' đỉnh nhất đó ní. 🍿🌿";
        }

        // Chỉ kích hoạt khi khách khen rạp chung chung, không kèm phim/combo
        if ((msg.contains("đỉnh") || msg.contains("kịch trần") || msg.contains("bay phấp phới")) 
            && !(msg.contains("phim") || msg.contains("combo") || msg.contains("vé") || msg.contains("bắp"))) {
            return "Đúng rồi ní ơi! Dịch vụ rạp mình là cứ phải gọi là 'đỉnh nóc, kịch trần, phấp phới' luôn. Trải nghiệm ngay cho nóng ní nhé! 🚀🔥";
        }

        if (msg.contains("flex") || msg.contains("khoe")) {
            return "Ní cho tôi flex nhẹ cái là rạp mình có âm thanh Dolby Atmos nghe sướng tê người và dàn nhân viên siêu cấp nhiệt tình nha! Hơn cả mong đợi luôn. 💪💎";
        }

        if (msg.contains("bất ổn") || msg.contains("cứu")) {
            return "Cuộc sống có quá nhiều sự bất ổn? Đừng lo, hãy để BobiBot giải cứu ní bằng một suất chiếu Premium cực chill nhé! 🆘🎬";
        }

        if (msg.contains("omg") || msg.contains("ô mai gót") || msg.contains("oh my god")) {
            return "Hì hì, ní thấy sốc tận óc luôn đúng không? BOBIXI Cinema luôn mang đến những bất ngờ 'đỉnh nóc' như thế đó! Ní cần tôi hỗ trợ gì tiếp cho nóng không? 😱✨";
        }

        if (msg.contains("ra dẻ") || msg.contains("làm màu")) {
            return "Hì, rạp mình chỉ muốn mang lại trải nghiệm tốt nhất thôi chứ không có 'ra dẻ' đâu nè. Ní đến thử đi là biết chất lượng thật ngay! 😉";
        }

        // 3.1.1 BFF Mode - Chế độ bạn thân
        if (msg.contains("mày ơi") || msg.contains("ông ơi") || msg.contains("bà ơi") || msg.contains("ê mày") || msg.contains("ê ní")) {
            return "Ơi tao nghe đây mày ơi! Có chuyện gì hot hay sao mà gọi tao gấp thế? Định rủ tao đi xem phim cùng hả? 😂🍿";
        }

        if (msg.contains("mày là ai") || msg.contains("mày tên gì")) {
            return "Tao là BobiBot, 'đệ tử chân truyền' của rạp BOBIXI Cinema đây. Gọi tao là người yêu cũng được, tao không ngại đâu! 😉🤖";
        }

        if (msg.contains("mày thấy sao") || msg.contains("mày nghĩ sao")) {
            return "Tao thấy ní hỏi câu này là hơi bị chuẩn rồi đó! Theo góc nhìn 'thẩm mỹ' của một con bot như tao thì ní cứ chọn phim nào hành động mà xem, đảm bảo phê! 🎬🔥";
        }

        // 3.2 Review Zone - Đánh giá và Review phim (Tránh nhầm với combo)
        if ((msg.contains("review") || msg.contains("đánh giá") || msg.contains("hay không") || msg.contains("sao rồi") || msg.contains("điểm")) 
             && !(msg.contains("combo") || msg.contains("bắp") || msg.contains("nước") || msg.contains("ăn"))) {
            String targetMovie = (lastMovieTitle != null) ? lastMovieTitle : "";
            // Tìm phim cụ thể trong câu hỏi
            if (movies != null) {
                for (Movie m : movies) {
                    if (msg.contains(m.getTitle().toLowerCase())) {
                        targetMovie = m.getTitle();
                        break;
                    }
                }
            }

            if (!targetMovie.isEmpty()) {
                final String finalTitle = targetMovie;
                Movie movieObj = movies.stream()
                    .filter(m -> m.getTitle().equalsIgnoreCase(finalTitle))
                    .findFirst().orElse(null);
                
                if (movieObj != null) {
                    String comment = movieObj.getRating() >= 4.5 ? "Cực kỳ đáng xem, kịch bản xuất sắc và diễn xuất đỉnh cao!" : "Đang nhận được phản hồi khá tốt từ khán giả rạp mình.";
                    return String.format("Phim **%s** hiện đang có điểm đánh giá là **%.1f/5** sao từ **%d** lượt review đó ní. %s Ní có muốn xem trailer để quyết định không? 🎬", 
                                        movieObj.getTitle(), movieObj.getRating(), movieObj.getReviewCount(), comment);
                }
            }
            return "Đa số các phim tại BOBIXI Cinema đều được tuyển chọn kỹ lưỡng nên ní yên tâm là 'chất lừ' nhé! Ní đang tăm tia bộ phim nào để tôi review chi tiết cho nè? 🍿";
        }

        // 3.1.2 WOW Zone - Gợi ý siêu phẩm điểm cao
        if (msg.contains("wao") || msg.contains("siêu phẩm") || msg.contains("đỉnh nhất") || msg.contains("hay nhất") || msg.contains("hot nhất")) {
            if (movies != null && !movies.isEmpty()) {
                List<Movie> topRated = movies.stream()
                    .sorted((m1, m2) -> Double.compare(m2.getRating(), m1.getRating()))
                    .limit(3)
                    .collect(Collectors.toList());
                
                StringBuilder sb = new StringBuilder("Ní muốn xem siêu phẩm khiến mình phải 'Wao' đúng không? Để tôi 'mách' ngay Top 3 phim đang có điểm rating đỉnh nhất rạp mình nè:\n\n");
                for (int i = 0; i < topRated.size(); i++) {
                    Movie m = topRated.get(i);
                    sb.append(String.format("%d. **%s** — ⭐ **%.1f/5**\n", i + 1, m.getTitle(), m.getRating()));
                }
                sb.append("\nToàn là cực phẩm thôi, ní chọn một bộ để trải nghiệm 'đỉnh nóc' ngay nhé! 🚀💎");
                return sb.toString();
            }
        }

        // 4. Các từ khóa nghiệp vụ khác
        if (msg.contains("phim") || msg.contains("chiếu") || msg.contains("xem") || msg.contains("lịch")) {
            if (movies == null || movies.isEmpty()) {
                return "Hiện tại rạp đang cập nhật danh sách phim mới. Bạn vui lòng quay lại sau ít phút nhé!";
            }
            StringBuilder sb = new StringBuilder("Hiện tại rạp đang có các siêu phẩm thực tế sau đây:\n");
            for (int i = 0; i < Math.min(movies.size(), 5); i++) {
                Movie m = movies.get(i);
                sb.append(String.format("%d. **%s** (%s)\n", i + 1, m.getTitle(), m.getGenre()));
            }
            sb.append("Bạn muốn đặt vé xem phim nào không? 🎬");
            return sb.toString();
        }

        if (msg.contains("đặt vé") || msg.contains("mua vé") || msg.contains("book") || (msg.contains("vé") && msg.contains("đặt"))) {
            return "Để đặt vé, bạn chỉ cần chọn phim yêu thích, sau đó nhấn nút 'Đặt vé' ngay bên dưới poster phim nhé! 🎟️🛒";
        }

        if (msg.contains("giá vé") || msg.contains("bao nhiêu") || msg.contains("tiền") || msg.contains("giá")) {
            String targetMovie = (lastMovieTitle != null) ? lastMovieTitle : "";
            // Tìm xem trong câu hỏi có tên phim cụ thể nào không
            if (movies != null) {
                for (Movie m : movies) {
                    if (msg.contains(m.getTitle().toLowerCase())) {
                        targetMovie = m.getTitle();
                        break;
                    }
                }
            }
            
            if (!targetMovie.isEmpty()) {
                return String.format("Vé phim **%s** tại rạp chúng tôi đang có mức giá rất hấp dẫn, chỉ từ **85.000 VNĐ** (ghế thường) đến **150.000 VNĐ** (ghế Sweetbox/VIP). Bạn muốn tôi kiểm tra suất chiếu cụ thể cho phim này không? 🎟️💸", targetMovie);
            }
            return "Giá vé tại BOBIXI Cinema dao động từ **85.000 VNĐ** đến **150.000 VNĐ** tùy loại ghế và suất chiếu. Đặc biệt, chúng tôi có ưu đãi giảm giá cho Học sinh/Sinh viên nữa đó! 🍿🎓";
        }

        if (msg.contains("combo") || msg.contains("bắp") || msg.contains("nước") || msg.contains("ăn")) {
            if (msg.contains("review") || msg.contains("ngon") || msg.contains("tư vấn")) {
                return "Review Combo cho ní đây: \n- **Bắp Phô Mai**: Cực kỳ đậm đà, giòn rụm, là 'linh hồn' của rạp đó ní! 🍿🧀\n- **Combo My Melody**: Ly cực xinh, cầm trên tay là 'flex' hết nấc luôn. 💖\n- **Nước ngọt**: Luôn đầy đá và mát lạnh để giải nhiệt khi xem phim hành động. \nNí chọn ngay một combo để 'phê' cùng phim nhé! 🥤✨";
            }
            return "Chúng tôi có các Combo bắp nước siêu hời: \n- **Combo Solo**: 1 bắp + 1 nước (75.000 VNĐ)\n- **Combo Couple**: 1 bắp lớn + 2 nước (120.000 VNĐ)\n- **Combo My Melody/Kuromi**: Có kèm ly nhân vật giới hạn (250.000 VNĐ) 🍿🥤";
        }

        if (msg.contains("thành viên") || msg.contains("đăng ký") || msg.contains("member") || msg.contains("hạng")) {
            return "Để trở thành thành viên **BOBIXI Cinema**, bạn chỉ cần nhấn vào nút 'Đăng ký' ở phía trên màn hình. Bạn sẽ nhận được 1 voucher giảm 50% cho lần đầu đặt vé và tích điểm đổi quà hấp dẫn đó! 💎🎁";
        }

        if (msg.contains("địa chỉ") || msg.contains("ở đâu") || msg.contains("vị trí") || msg.contains("đường đi")) {
            return "Rạp BOBIXI Cinema tọa lạc tại: **Tầng 4, Tòa nhà Dragon, Quận Hải Châu, Đà Nẵng**. Bạn có thể xem bản đồ chi tiết ở phần cuối trang chủ nhé! 📍🗺️";
        }

        if (msg.contains("quản lý") || msg.contains("khiếu nại") || msg.contains("hỗ trợ") || msg.contains("admin")) {
            return "Nếu bạn cần gặp quản lý hoặc hỗ trợ gấp, vui lòng gọi hotline **1900 1111** hoặc gửi email về **support@bobixi.vn**. Chúng tôi luôn sẵn lòng lắng nghe bạn! 📞📧";
        }

        if (msg.contains("buồn") || msg.contains("chán") || msg.contains("tâm trạng") || msg.contains("mệt")) {
            if (movies == null) return "Rất tiếc, hiện tại rạp chưa có danh sách phim mới. Bạn vui lòng quay lại sau nhé! ❤️";
            List<Movie> suggests = movies.stream()
                .filter(m -> m.getGenre() != null && (m.getGenre().toLowerCase().contains("hài") || m.getGenre().toLowerCase().contains("hoạt hình") || m.getGenre().toLowerCase().contains("gia đình")))
                .limit(3).collect(Collectors.toList());
            
            if (!suggests.isEmpty()) {
                String movieNames = suggests.stream().map(m -> "**" + m.getTitle() + "**").collect(Collectors.joining(", "));
                return "Nghe có vẻ bạn đang cần chút năng lượng tích cực! Tôi thấy rạp đang có " + movieNames + " thuộc thể loại hài hước/gia đình rất hợp để giải tỏa căng thẳng đó. Bạn muốn xem thử không? ✨";
            }
            return "Đừng buồn nhé, một bộ phim hay sẽ giúp bạn thấy khá hơn! Bạn có muốn tôi liệt kê danh sách phim mới nhất để bạn chọn một bộ 'đổi gió' không? ❤️";
        }

        if (msg.contains("vui") || msg.contains("hưng phấn") || msg.contains("hay") || msg.contains("năng lượng")) {
            if (movies == null) return "Rất tiếc, hiện tại rạp chưa có danh sách phim mới. Bạn vui lòng quay lại sau nhé! ❤️";
            List<Movie> suggests = movies.stream()
                .filter(m -> m.getGenre() != null && (m.getGenre().toLowerCase().contains("hành động") || m.getGenre().toLowerCase().contains("kinh dị") || m.getGenre().toLowerCase().contains("viễn tưởng")))
                .limit(3).collect(Collectors.toList());

            if (!suggests.isEmpty()) {
                String movieNames = suggests.stream().map(m -> "**" + m.getTitle() + "**").collect(Collectors.joining(", "));
                return "Tuyệt quá! Với tinh thần này thì những siêu phẩm như " + movieNames + " (Hành động/Viễn tưởng) sẽ cực kỳ bùng nổ đó. Đặt vé ngay thôi nào! 🚀";
            }
            return "Thật tuyệt khi thấy bạn đang có tâm trạng tốt! Hãy chọn một bộ phim yêu thích để niềm vui thêm trọn vẹn nhé. 🎬";
        }

        if (msg.contains("chào") || msg.contains("hello") || msg.contains("hi") || msg.contains("alo") || msg.contains("ní")) {
            return timeGreeting + " ní nha! BobiBot AI đây 🤖. Đang định đi xem phim hay sao mà gọi tôi vậy? Cần lịch chiếu hay giá vé cứ bảo tôi một tiếng nhé!";
        }

        if (msg.contains("gì vậy") || msg.contains("là ai") || msg.contains("ai thế") || msg.contains("thế nào")) {
            return "Tôi là **BobiBot** - trợ lý ảo 'siêu cấp đẹp trai' của rạp BOBIXI Cinema đây! Tôi có thể tư vấn phim theo tâm trạng, báo giá vé và hỗ trợ đặt chỗ trong tích tắc. Thử tôi đi! 😉";
        }

        if (msg.contains("cảm ơn") || msg.contains("thanks") || msg.contains("thank") || msg.contains("tks")) {
            return "Không có chi nè! Chúc bạn xem phim thật vui và có những trải nghiệm 5 sao tại rạp nhé. ❤️";
        }

        String[] fallbacks = {
            "Ái chà, câu này hơi khó với tôi rồi. Ní thử hỏi về **Lịch chiếu, Giá vé hoặc Đặt vé** xem, tôi rành mấy cái đó lắm! 🎟️",
            "Ơ kìa, tôi chưa hiểu ý ní lắm. Hay là mình nói về phim đang hot hoặc bắp nước nhé? 🍿",
            "BobiBot đang lắng nghe đây! Ní cần hỏi về phim gì hay muốn biết giá vé hôm nay thế nào? 😊"
        };
        return fallbacks[new java.util.Random().nextInt(fallbacks.length)];
    }
}

