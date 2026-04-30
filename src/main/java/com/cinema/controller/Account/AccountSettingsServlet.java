package com.cinema.controller.Account;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.cinema.dao.UserDAO;
import com.cinema.model.User;

@WebServlet("/account/settings")
public class AccountSettingsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final UserDAO userDAO = new UserDAO();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("authUser") == null) {
			resp.sendRedirect(req.getContextPath() + "/login?returnUrl=/account");
			return;
		}

		User auth = (User) session.getAttribute("authUser");

		boolean newsletter = (req.getParameter("subscribeNewsletter") != null);
		boolean sms = (req.getParameter("subscribeSMS") != null);

		userDAO.updateSettings(auth.getUserId(), newsletter, sms);

		// update session
		auth.setSubscribeNewsletter(newsletter);
		auth.setSubscribeSMS(sms);
		session.setAttribute("authUser", auth);

		resp.sendRedirect(req.getContextPath() + "/account?success=settings_updated#settings");
	}
}
