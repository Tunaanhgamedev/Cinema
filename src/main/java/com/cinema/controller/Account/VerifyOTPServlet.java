package com.cinema.controller.Account;

import java.io.IOException;
import com.cinema.utils.CacheManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/verify-otp")
public class VerifyOTPServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/forgot-password");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String otpInput = request.getParameter("otp");

        String cachedOtp = (String) CacheManager.get("OTP_" + email);

        if (cachedOtp != null && cachedOtp.equals(otpInput)) {
            // OTP đúng, chuyển sang trang đặt lại mật khẩu
            request.setAttribute("email", email);
            request.setAttribute("otp", otpInput); // Gửi kèm OTP để bảo mật bước sau
            request.getRequestDispatcher("/pages/clients/account/reset-password.jsp").forward(request, response);
        } else {
            // OTP sai hoặc hết hạn
            request.setAttribute("email", email);
            request.setAttribute("error", "Mã xác thực không chính xác hoặc đã hết hạn!");
            request.getRequestDispatcher("/pages/clients/account/verify-otp.jsp").forward(request, response);
        }
    }
}
