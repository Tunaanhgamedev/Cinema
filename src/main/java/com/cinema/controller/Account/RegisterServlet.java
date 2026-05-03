package com.cinema.controller.Account;

import java.io.IOException;
import java.util.regex.Pattern;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.dao.UserDAO;
import com.cinema.dao.impl.UserDAOImpl;
import com.cinema.model.User;
import com.cinema.utils.PasswordUtil;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final UserDAO userDAO = new UserDAOImpl();

	private static final Pattern EMAIL_RE = Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");
	private static final Pattern PHONE_RE = Pattern.compile("^[0-9]{10,11}$");

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/pages/clients/account/register.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		// ====== lấy dữ liệu ======
		String firstName = trim(req.getParameter("firstName"));
		String lastName = trim(req.getParameter("lastName"));
		String email = trim(req.getParameter("email"));
		String phone = trim(req.getParameter("phone"));
		String password = nvl(req.getParameter("password"));
		String confirmPassword = nvl(req.getParameter("confirmPassword"));

		String dateOfBirth = trim(req.getParameter("dateOfBirth")); // hiện chưa lưu DB
		String gender = trim(req.getParameter("gender")); // hiện chưa lưu DB
		String address = trim(req.getParameter("address")); // hiện chưa lưu DB

		String subscribeNewsletter = req.getParameter("subscribeNewsletter") != null ? "true" : "false";
		String subscribeSMS = req.getParameter("subscribeSMS") != null ? "true" : "false";

		String agreeTerms = req.getParameter("agreeTerms"); // checkbox

		// ====== set lại để JSP giữ dữ liệu khi lỗi ======
		req.setAttribute("firstName", firstName);
		req.setAttribute("lastName", lastName);
		req.setAttribute("email", email);
		req.setAttribute("phone", phone);
		req.setAttribute("dateOfBirth", dateOfBirth);
		req.setAttribute("gender", gender);
		req.setAttribute("address", address);
		req.setAttribute("subscribeNewsletter", subscribeNewsletter);
		req.setAttribute("subscribeSMS", subscribeSMS);

		// ====== validate ======
		if (firstName.length() < 1) {
			forwardError(req, resp, "Vui lòng nhập Họ.");
			return;
		}
		if (lastName.length() < 1) {
			forwardError(req, resp, "Vui lòng nhập Tên.");
			return;
		}
		if (!EMAIL_RE.matcher(email).matches()) {
			forwardError(req, resp, "Email không hợp lệ.");
			return;
		}
		if (!PHONE_RE.matcher(phone).matches()) {
			forwardError(req, resp, "Số điện thoại không hợp lệ (10–11 số).");
			return;
		}
		if (password.length() < 6) {
			forwardError(req, resp, "Mật khẩu phải có ít nhất 6 ký tự.");
			return;
		}
		if (!password.equals(confirmPassword)) {
			forwardError(req, resp, "Mật khẩu xác nhận không khớp.");
			return;
		}
		if (agreeTerms == null) {
			forwardError(req, resp, "Bạn cần đồng ý Điều khoản sử dụng và Chính sách bảo mật.");
			return;
		}

		// ====== check email trùng ======
		if (userDAO.existsByEmail(email)) {
			forwardError(req, resp, "Email đã được đăng ký. Vui lòng dùng email khác.");
			return;
		}

		// ====== tạo user ======
		String fullName = (firstName + " " + lastName).trim();

		User u = new User();
		u.setFullName(fullName);
		u.setEmail(email);
		u.setPhoneNumber(phone);
		u.setRole("USER");

		// dateOfBirth: String -> java.sql.Date
		java.sql.Date dobSql = null;
		if (dateOfBirth != null && !dateOfBirth.isEmpty()) {
			dobSql = java.sql.Date.valueOf(dateOfBirth); // yyyy-MM-dd
		}
		u.setDateOfBirth(dobSql);

		u.setGender(gender == null || gender.isEmpty() ? null : gender); // MALE/FEMALE/OTHER hoặc ""
		u.setAddress(address); // có thể rỗng

		u.setSubscribeNewsletter("true".equals(subscribeNewsletter));
		u.setSubscribeSMS("true".equals(subscribeSMS));

		// ✅ BCrypt hash
		u.setPassword(PasswordUtil.hash(password));

		int id = userDAO.insert(u);
		if (id <= 0) {
			forwardError(req, resp, "Đăng ký thất bại. Vui lòng thử lại.");
			return;
		}

		// Thành công -> redirect login
		resp.sendRedirect(req.getContextPath() + "/login?registered=1");
	}

	private void forwardError(HttpServletRequest req, HttpServletResponse resp, String msg)
			throws ServletException, IOException {
		req.setAttribute("error", msg);
		req.getRequestDispatcher("/pages/clients/account/register.jsp").forward(req, resp);
	}

	private static String trim(String s) {
		return s == null ? "" : s.trim();
	}

	private static String nvl(String s) {
		return s == null ? "" : s;
	}
}
