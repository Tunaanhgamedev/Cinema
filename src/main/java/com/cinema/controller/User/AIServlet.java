package com.cinema.controller.User;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.dao.MovieDAO;
import com.cinema.model.Movie;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

@WebServlet("/api/ai/chat")
public class AIServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final MovieDAO movieDAO = new MovieDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        JsonObject jsonRequest = gson.fromJson(req.getReader(), JsonObject.class);
        String userMessage = jsonRequest.get("message").getAsString().toLowerCase();

        String aiResponse = "";
        
        // 1. Chào hỏi
        if (userMessage.matches(".*(chào|hi|hello|hey).*")) {
            aiResponse = "Xin chào! Tôi là **BobiBot**, trợ lý AI của BOBIXI Cinema. Bạn cần tôi tìm phim hay, xem lịch chiếu hay giải đáp về bắp nước hôm nay?";
        } 
        // 2. Lịch chiếu & Phim đang chiếu
        else if (userMessage.contains("lịch chiếu") || userMessage.contains("suất chiếu")) {
            aiResponse = "Lịch chiếu hôm nay đang rất đầy đủ tại các phòng chiếu hiện đại. Bạn muốn xem phim vào khung giờ nào (Sáng, Chiều hay Tối) để tôi gợi ý chính xác hơn?";
        }
        else if (userMessage.contains("phim") || userMessage.contains("xem gì")) {
            List<Movie> movies = movieDAO.findAllWithFilters("", "newest");
            String movieTitles = movies.stream()
                                     .limit(3)
                                     .map(m -> "• **" + m.getTitle() + "** [" + m.getGenre() + "]")
                                     .collect(Collectors.joining("<br>"));
            aiResponse = "Đây là 3 siêu phẩm đang làm mưa làm gió tại BOBIXI:<br>" + movieTitles + "<br>Bạn đã xem qua chưa? Đặt vé ngay kẻo lỡ nhé!";
        }
        // 3. Khuyến mãi & Thành viên
        else if (userMessage.contains("giảm giá") || userMessage.contains("khuyến mãi") || userMessage.contains("voucher") || userMessage.contains("hội viên")) {
            aiResponse = "Chúng tôi có 3 hạng thành viên: **Silver**, **Gold** và **Platinum**. <br>Mỗi hạng sẽ được tích điểm từ 5% - 10%. Đặc biệt, hạng Platinum được tặng Voucher **100.000đ** vào dịp sinh nhật đó!";
        }
        // 4. Bắp nước (Combo)
        else if (userMessage.contains("bắp") || userMessage.contains("nước") || userMessage.contains("combo") || userMessage.contains("ăn gì")) {
            aiResponse = "Đến BOBIXI thì không thể bỏ qua **Combo Đôi Hoàn Hảo** (2 nước + 1 bắp lớn) chỉ với 129k. Ngoài ra còn có các Combo nhân vật theo phim cực chất nữa đấy!";
        }
        // 5. Giá vé
        else if (userMessage.contains("giá vé") || userMessage.contains("bao nhiêu tiền")) {
            aiResponse = "Giá vé cơ bản chỉ từ **60.000đ**. <br>• Ghế VIP: +20k<br>• Ghế Đôi: +50k<br>Rất phù hợp cho một buổi hẹn hò xem phim chất lượng đúng không nào?";
        }
        // 6. Hướng dẫn đặt vé
        else if (userMessage.contains("đặt vé") || userMessage.contains("mua vé") || userMessage.contains("làm sao")) {
            aiResponse = "Quy trình đặt vé rất đơn giản:<br>1. Chọn phim bạn thích.<br>2. Chọn suất chiếu phù hợp.<br>3. Chọn ghế ngồi trên sơ đồ.<br>4. Thanh toán online để nhận mã vé ngay lập tức!<br>Tôi có thể giúp bạn chọn phim ngay bây giờ không?";
        }
        // 7. Thể loại
        else if (userMessage.matches(".*(hành động|kinh dị|tình cảm|hài|hoạt hình).*")) {
            String genre = userMessage.contains("hành động") ? "Hành động" : (userMessage.contains("kinh dị") ? "Kinh dị" : "Tình cảm");
            aiResponse = "Dòng phim " + genre + " hiện đang rất được ưa chuộng. Bạn hãy vào mục 'Phim' để xem danh sách mới nhất nhé. Bạn muốn tôi giới thiệu một bộ phim cụ thể không?";
        }
        else {
            aiResponse = "Câu hỏi này thú vị quá! BobiBot đang được nâng cấp để hiểu bạn hơn. Hiện tại bạn có thể hỏi tôi về 'phim hot', 'combo bắp nước' hoặc 'cách đặt vé' nhé! 🍿";
        }

        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("reply", aiResponse);
        resp.getWriter().write(gson.toJson(jsonResponse));
    }
}
