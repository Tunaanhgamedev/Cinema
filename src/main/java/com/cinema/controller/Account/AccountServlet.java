package com.cinema.controller.Account;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/account")
public class AccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("authUser") == null) {
			resp.sendRedirect(req.getContextPath() + "/login?returnUrl=/account");
			return;
		}

		// forward đúng file jsp account của bạn
		req.getRequestDispatcher("/pages/clients/account/account.jsp").forward(req, resp);
	}
}
