package com.cinema.controller.Admin;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.cinema.dao.UserDAO;
import com.cinema.model.User;
import com.cinema.utils.PasswordUtil;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final UserDAO userDAO = new UserDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/pages/admin/login.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("email");
		String password = req.getParameter("password");

		User user = userDAO.findByEmail(email);

		if (user != null && "ADMIN".equals(user.getRole()) && PasswordUtil.checkPassword(password, user.getPassword())) {
			HttpSession session = req.getSession();
			session.setAttribute("authUser", user);
			resp.sendRedirect(req.getContextPath() + "/admin");
		} else {
			req.setAttribute("error", "Email hoặc mật khẩu không đúng, hoặc bạn không có quyền truy cập!");
			req.getRequestDispatcher("/pages/admin/login.jsp").forward(req, resp);
		}
	}
}