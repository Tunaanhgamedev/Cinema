package com.cinema.controller.Admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.utils.DBConnection;
import com.cinema.utils.PasswordUtil;

@WebServlet("/reset-admin")
public class ResetAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html;charset=UTF-8");
		String adminEmail = "admin@gmail.com";
		String plainPass = "123";
		String hashedPass = PasswordUtil.hash(plainPass);

		try (Connection con = DBConnection.getConnection()) {
			// Check if exists
			String checkSql = "SELECT user_id FROM users WHERE email = ?";
			try (PreparedStatement ps = con.prepareStatement(checkSql)) {
				ps.setString(1, adminEmail);
				ResultSet rs = ps.executeQuery();
				
				if (rs.next()) {
					// Update
					String updateSql = "UPDATE users SET password = ?, role = 'ADMIN' WHERE email = ?";
					try (PreparedStatement ps2 = con.prepareStatement(updateSql)) {
						ps2.setString(1, hashedPass);
						ps2.setString(2, adminEmail);
						ps2.executeUpdate();
						resp.getWriter().println("<h3>Đã cập nhật mật khẩu cho " + adminEmail + " là: " + plainPass + "</h3>");
					}
				} else {
					// Insert new
					String insertSql = "INSERT INTO users (full_name, email, password, role) VALUES (?, ?, ?, 'ADMIN')";
					try (PreparedStatement ps2 = con.prepareStatement(insertSql)) {
						ps2.setString(1, "System Admin");
						ps2.setString(2, adminEmail);
						ps2.setString(3, hashedPass);
						ps2.executeUpdate();
						resp.getWriter().println("<h3>Đã tạo mới tài khoản Admin: " + adminEmail + " với mật khẩu: " + plainPass + "</h3>");
					}
				}
				resp.getWriter().println("<p><a href='" + req.getContextPath() + "/admin/login'>Đến trang đăng nhập Admin</a></p>");
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.getWriter().println("<h3>Lỗi: " + e.getMessage() + "</h3>");
		}
	}
}
