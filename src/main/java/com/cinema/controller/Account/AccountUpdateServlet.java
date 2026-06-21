package com.cinema.controller.Account;

import java.io.IOException;
import java.sql.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.cinema.dao.UserDAO;
import com.cinema.dao.impl.UserDAOImpl;
import com.cinema.model.User;

@WebServlet("/account/update")
public class AccountUpdateServlet extends HttpServlet {
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

		String fullName = nvl(req.getParameter("fullName")).trim();
		String phoneNumber = nvl(req.getParameter("phoneNumber")).trim();
		String gender = nvl(req.getParameter("gender")).trim(); // MALE/FEMALE/OTHER hoặc rỗng
		String address = nvl(req.getParameter("address")).trim();

		String dobStr = nvl(req.getParameter("dateOfBirth")).trim();
		Date dob = null;
		if (!dobStr.isEmpty()) {
			try {
				dob = Date.valueOf(dobStr);
			} catch (Exception e) {
				resp.sendRedirect(req.getContextPath() + "/account?error=invalid_input#profile");
				return;
			}
		}

		if (fullName.isEmpty()) {
			resp.sendRedirect(req.getContextPath() + "/account?error=invalid_input#profile");
			return;
		}

		// update DB
		userDAO.updateProfile(auth.getUserId(), fullName, phoneNumber, dob, gender.isEmpty() ? null : gender, address);

		// update lại session để hiển thị ngay
		auth.setFullName(fullName);
		auth.setPhoneNumber(phoneNumber);
		auth.setDateOfBirth(dob);
		auth.setGender(gender.isEmpty() ? null : gender);
		auth.setAddress(address);
		session.setAttribute("authUser", auth);

		resp.sendRedirect(req.getContextPath() + "/account?success=profile_updated#profile");
	}

	private static String nvl(String s) {
		return s == null ? "" : s;
	}
}
