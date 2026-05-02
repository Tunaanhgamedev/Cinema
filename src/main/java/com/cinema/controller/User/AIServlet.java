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
        
        // Logic tư vấn thông minh (Demo)
        if (userMessage.contains("chào") || userMessage.contains("hi") || userMessage.contains("hello")) {
            aiResponse = "Xin chào! Tôi là **BobiBot**, trợ lý AI của BOBIXI Cinema. Tôi có thể giúp bạn tìm phim hay, kiểm tra khuyến mãi hoặc giải đáp về hạng thành viên. Bạn muốn xem gì hôm nay?";
        } 
        else if (userMessage.contains("phim") || userMessage.contains("chi chiếu") || userMessage.contains("xem gì")) {
            List<Movie> movies = movieDAO.findAllWithFilters("", "newest");
            String movieTitles = movies.stream()
                                     .limit(3)
                                     .map(m -> "• **" + m.getTitle() + "** (" + m.getGenre() + ")")
                                     .collect(Collectors.joining("<br>"));
            aiResponse = "Hiện tại rạp đang có những siêu phẩm cực hot:<br>" + movieTitles + "<br>Bạn muốn đặt vé phim nào trong số này không?";
        }
        else if (userMessage.contains("giảm giá") || userMessage.contains("khuyến mãi") || userMessage.contains("voucher")) {
            aiResponse = "BOBIXI đang có chương trình **Tích điểm 5%** cho mỗi hóa đơn! Ngoài ra, nếu bạn đổi điểm, bạn có thể nhận Voucher lên đến **100.000đ**. Hãy vào mục 'Tài khoản' để xem ví Voucher của mình nhé!";
        }
        else if (userMessage.contains("giá vé")) {
            aiResponse = "Giá vé tại BOBIXI rất cạnh tranh:<br>• Ghế Thường: từ 60.000đ<br>• Ghế VIP: +20.000đ phụ phí<br>• Ghế Đôi (Couple): +50.000đ phụ phí.<br>Giá có thể thay đổi tùy suất chiếu bạn nhé!";
        }
        else if (userMessage.contains("hành động") || userMessage.contains("kinh dị") || userMessage.contains("tình cảm")) {
            String genre = userMessage.contains("hành động") ? "Hành động" : (userMessage.contains("kinh dị") ? "Kinh dị" : "Tình cảm");
            List<Movie> filtered = movieDAO.findAllWithFilters("", "newest").stream()
                                          .filter(m -> m.getGenre().contains(genre))
                                          .limit(2)
                                          .collect(Collectors.toList());
            if (!filtered.isEmpty()) {
                String result = filtered.stream().map(m -> "**" + m.getTitle() + "**").collect(Collectors.joining(", "));
                aiResponse = "Nếu bạn thích " + genre + ", tôi gợi ý bạn xem ngay: " + result + ". Chắc chắn bạn sẽ không thất vọng!";
            } else {
                aiResponse = "Tiếc quá, hiện rạp chưa có phim " + genre + " mới. Bạn có muốn thử xem thể loại khác không?";
            }
        }
        else {
            aiResponse = "Cảm ơn bạn đã nhắn tin! Hiện tại tôi đang học hỏi thêm. Bạn có thể hỏi về 'phim đang chiếu', 'giá vé' hoặc 'khuyến mãi' để tôi hỗ trợ tốt nhất nhé! 😊";
        }

        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("reply", aiResponse);
        resp.getWriter().write(gson.toJson(jsonResponse));
    }
}
