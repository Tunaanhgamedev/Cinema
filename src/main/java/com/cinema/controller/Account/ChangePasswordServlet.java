package com.cinema.controller.Account;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.cinema.dao.UserDAO;
import com.cinema.dao.impl.UserDAOImpl;
import com.cinema.model.User;
import com.cinema.utils.PasswordUtil;

@WebServlet("/account/change-password")
public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final UserDAO userDAO = new UserDAOImpl();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("authUser") == null) {
			resp.sendRedirect(req.getContextPath() + "/login?returnUrl=/account");
			return;
		}

		User auth = (User) session.getAttribute("authUser");

		String current = nvl(req.getParameter("currentPassword"));
		String newPass = nvl(req.getParameter("newPassword"));
		String confirm = nvl(req.getParameter("confirmPassword"));

		if (current.isEmpty() || newPass.isEmpty() || confirm.isEmpty()) {
			resp.sendRedirect(req.getContextPath() + "/account?error=invalid_input#profile");
			return;
		}

		if (!newPass.equals(confirm)) {
			resp.sendRedirect(req.getContextPath() + "/account?error=password_mismatch#profile");
			return;
		}

		// LƯU Ý: auth trong session thường bị setPassword(null) ở LoginServlet
		// => phải lấy hash từ DB bằng email
		User dbUser = userDAO.findByEmail(auth.getEmail());
		if (dbUser == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		if (!PasswordUtil.verify(current, dbUser.getPassword())) {
			resp.sendRedirect(req.getContextPath() + "/account?error=wrong_password#profile");
			return;
		}

		String hashed = PasswordUtil.hash(newPass);
		userDAO.updatePassword(dbUser.getUserId(), hashed);

		resp.sendRedirect(req.getContextPath() + "/account?success=password_changed#profile");
	}

	private static String nvl(String s) {
		return s == null ? "" : s;
	}
}
