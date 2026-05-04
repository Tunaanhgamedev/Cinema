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

            // Lấy danh sách phim thực tế để làm ngữ cảnh
            List<Movie> currentMovies = movieDAO.findAllWithFilters("", "newest");
            String aiResponse = "";

            if (GEMINI_API_KEY == null || GEMINI_API_KEY.equals("YOUR_GEMINI_API_KEY_HERE") || GEMINI_API_KEY.isEmpty()) {
                aiResponse = getFallbackResponse(userMessage, currentMovies);
            } else {
                aiResponse = callGeminiAI(userMessage, currentMovies);
                if (aiResponse == null || aiResponse.isEmpty()) {
                    aiResponse = getFallbackResponse(userMessage, currentMovies);
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

    private String callGeminiAI(String message, List<Movie> movies) {
        try {
            String movieContext = movies.stream()
                .limit(10)
                .map(m -> String.format("- %s (Thể loại: %s)", m.getTitle(), m.getGenre()))
                .collect(Collectors.joining("\n"));

            String systemPrompt = "Bạn là BobiBot, trợ lý AI của rạp phim BOBIXI Cinema. "
                + "Dưới đây là danh sách phim ĐANG CHIẾU THỰC TẾ tại rạp:\n" + movieContext + "\n\n"
                + "Hãy trả lời thân thiện, sử dụng icon. Nếu khách hỏi phim không có trong danh sách, hãy khéo léo gợi ý phim đang có. "
                + "Khách hàng hỏi: " + message;

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

    private String getFallbackResponse(String userMessage, List<Movie> movies) {
        if (userMessage == null || userMessage.trim().isEmpty()) {
            return "Tôi vẫn đang lắng nghe đây! Bạn muốn hỏi về phim hay dịch vụ nào tại BOBIXI Cinema?";
        }
        
        String msg = userMessage.toLowerCase();

        // 1. Kiểm tra kết hợp Tên phim + Đặt vé (Dùng contains để an toàn với tiếng Việt)
        if (movies != null) {
            for (Movie m : movies) {
                String title = m.getTitle().toLowerCase();
                if (msg.contains(title)) {
                    if (msg.contains("đặt") || msg.contains("mua") || msg.contains("book") || msg.contains("vé")) {
                        return String.format("Bạn muốn đặt vé phim **%s** đúng không? Rất đơn giản, bạn chỉ cần quay lại trang chủ, nhấn vào poster phim và chọn nút 'Đặt vé' là xong! Chúc bạn xem phim vui vẻ! 🎟️", m.getTitle());
                    }
                    return String.format("Bạn đang quan tâm đến phim **%s** đúng không? Đây là phim thuộc thể loại %s. Bạn có muốn xem lịch chiếu hoặc đặt vé cho phim này luôn không? 🎬", 
                                        m.getTitle(), m.getGenre());
                }
            }
        }

        // 2. Xử lý các câu trả lời khẳng định (Dùng contains cho các từ ngắn)
        if (msg.equals("có") || msg.equals("vâng") || msg.equals("ok") || msg.equals("yes") || msg.equals("được") || msg.equals("ừ") || msg.equals("uh")) {
            if (movies != null && !movies.isEmpty()) {
                StringBuilder sb = new StringBuilder("Tuyệt vời! Đây là danh sách phim đang chiếu thực tế để bạn chọn:\n");
                for (int i = 0; i < Math.min(movies.size(), 5); i++) {
                    Movie m = movies.get(i);
                    sb.append(String.format("%d. **%s** (%s)\n", i + 1, m.getTitle(), m.getGenre()));
                }
                return sb.toString() + "Bạn chọn được phim nào chưa?";
            }
        }

        // 3. Nhận diện nếu khách đang hỏi về một bộ phim lạ
        if ((msg.contains("có phim") || msg.contains("chiếu phim") || msg.contains("xem phim")) && !(msg.contains("giá") || msg.contains("combo") || msg.contains("đặt") || msg.contains("mua"))) {
            return "Rất tiếc, phim này hiện chưa có lịch chiếu tại BOBIXI Cinema. 😔 \nTuy nhiên, rạp đang có rất nhiều phim hot như **Lật Mặt 7** hay **Avenger**. Bạn có muốn tôi liệt kê danh sách phim đang chiếu không?";
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
            return "Để đặt vé, bạn chỉ cần chọn phim yêu thích, sau đó nhấn nút 'Đặt vé' ngay bên dưới poster phim nhé! 🎟️";
        }

        if (msg.contains("giá vé") || msg.contains("bao nhiêu") || msg.contains("tiền") || msg.contains("giá")) {
            return "Giá vé tại BOBIXI Cinema dao động từ **85.000 VNĐ** đến **150.000 VNĐ** tùy loại ghế và suất chiếu.";
        }

        if (msg.contains("combo") || msg.contains("bắp") || msg.contains("nước") || msg.contains("ăn")) {
            return "Chúng tôi có các Combo bắp nước siêu hời: \n- **Combo Solo**: 1 bắp + 1 nước\n- **Combo Couple**: 1 bắp lớn + 2 nước 🍿";
        }

        if (msg.contains("chào") || msg.contains("hello") || msg.contains("hi") || msg.contains("alo")) {
            return "Chào bạn! Tôi là **BobiBot AI** 🤖. Tôi có thể giúp bạn xem phim đang chiếu, đặt vé hoặc tư vấn combo. Bạn cần hỗ trợ gì?";
        }

        if (msg.contains("cảm ơn") || msg.contains("thanks") || msg.contains("thank")) {
            return "Rất sẵn lòng! Chúc bạn có những giây phút xem phim tuyệt vời. ❤️";
        }

        return "Câu hỏi của bạn rất thú vị! Tôi có thể hỗ trợ tốt nhất về: **Lịch chiếu, Giá vé, và Đặt vé**. Bạn thử hỏi tôi về các chủ đề này nhé!";
    }
}

