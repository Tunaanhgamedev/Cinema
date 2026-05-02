package com.cinema.controller.Account;

import java.io.IOException;
import java.util.Random;
import com.cinema.dao.UserDAO;
import com.cinema.dao.impl.UserDAOImpl;
import com.cinema.model.User;
import com.cinema.utils.CacheManager;
import com.cinema.utils.EmailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/pages/clients/account/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        User user = userDAO.findByEmail(email);

        if (user == null) {
            request.setAttribute("error", "Email này không tồn tại trong hệ thống!");
            request.getRequestDispatcher("/pages/clients/account/forgot-password.jsp").forward(request, response);
            return;
        }

        // Tạo OTP 6 chữ số
        String otp = String.format("%06d", new Random().nextInt(999999));
        
        // Lưu vào CacheManager với key là "OTP_" + email
        CacheManager.put("OTP_" + email, otp);

        // Gửi Email
        String subject = "Mã xác thực khôi phục mật khẩu - BOBIXI Cinema";
        String body = String.format("""
            <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e2e8f0; border-radius: 12px;">
                <h1 style="color: #6366f1; text-align: center;">BOBIXI CINEMA</h1>
                <p>Chào bạn,</p>
                <p>Chúng tôi nhận được yêu cầu khôi phục mật khẩu cho tài khoản liên kết với email này.</p>
                <div style="background: #f8fafc; padding: 20px; border-radius: 8px; text-align: center; margin: 20px 0;">
                    <span style="font-size: 14px; color: #64748b; display: block; margin-bottom: 10px;">MÃ XÁC THỰC (OTP) CỦA BẠN LÀ:</span>
                    <span style="font-size: 32px; font-weight: bold; letter-spacing: 5px; color: #1e293b;">%s</span>
                </div>
                <p style="color: #ef4444; font-size: 14px;">* Lưu ý: Mã này chỉ có hiệu lực trong 10 phút. Tuyệt đối không cung cấp mã này cho bất kỳ ai.</p>
                <hr style="border: none; border-top: 1px solid #e2e8f0; margin: 20px 0;">
                <p style="font-size: 12px; color: #94a3b8; text-align: center;">Nếu bạn không yêu cầu khôi phục mật khẩu, vui lòng bỏ qua email này.</p>
            </div>
            """, otp);
        
        EmailUtil.sendEmail(email, subject, body);

        // Chuyển sang trang nhập OTP
        request.setAttribute("email", email);
        request.getRequestDispatcher("/pages/clients/account/verify-otp.jsp").forward(request, response);
    }
}
