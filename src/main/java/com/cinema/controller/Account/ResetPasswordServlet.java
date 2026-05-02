package com.cinema.controller.Account;

import java.io.IOException;
import com.cinema.dao.UserDAO;
import com.cinema.dao.impl.UserDAOImpl;
import com.cinema.model.User;
import com.cinema.utils.CacheManager;
import com.cinema.utils.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/forgot-password");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String otp = request.getParameter("otp");
        String password = request.getParameter("password");

        // Kiểm tra lại OTP một lần nữa để bảo mật (tránh hack form)
        String cachedOtp = (String) CacheManager.get("OTP_" + email);
        if (cachedOtp == null || !cachedOtp.equals(otp)) {
            request.setAttribute("error", "Phiên làm việc đã hết hạn. Vui lòng thực hiện lại từ đầu!");
            request.getRequestDispatcher("/pages/clients/account/forgot-password.jsp").forward(request, response);
            return;
        }

        User user = userDAO.findByEmail(email);
        if (user != null) {
            String hashedPassword = PasswordUtil.hashPassword(password);
            userDAO.updatePassword(user.getUserId(), hashedPassword);
            
            // Xóa OTP sau khi đổi thành công
            CacheManager.clear("OTP_" + email);

            request.setAttribute("message", "Đổi mật khẩu thành công! Vui lòng đăng nhập lại.");
            request.getRequestDispatcher("/pages/clients/account/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại!");
            request.getRequestDispatcher("/pages/clients/account/forgot-password.jsp").forward(request, response);
        }
    }
}
