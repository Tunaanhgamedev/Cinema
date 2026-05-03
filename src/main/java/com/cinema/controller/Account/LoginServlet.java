package com.cinema.controller.Account;

import java.io.IOException;
import java.util.regex.Pattern;

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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final UserDAO userDAO = new UserDAOImpl();
	private static final Pattern EMAIL_RE = Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		if ("1".equals(req.getParameter("registered"))) {
			req.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
		}
		if ("1".equals(req.getParameter("logout"))) {
			req.setAttribute("message", "Bạn đã đăng xuất.");
		}
		req.setAttribute("returnUrl", trim(req.getParameter("returnUrl")));

		req.getRequestDispatcher("/pages/clients/account/login.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		String email = trim(req.getParameter("email"));
		String password = nvl(req.getParameter("password"));
		String returnUrl = trim(req.getParameter("returnUrl"));

		req.setAttribute("email", email);
		req.setAttribute("returnUrl", returnUrl);

		if (email.isEmpty() || password.isEmpty()) {
			forwardError(req, resp, "Vui lòng nhập đầy đủ Email và Mật khẩu.");
			return;
		}
		if (!EMAIL_RE.matcher(email).matches()) {
			forwardError(req, resp, "Email không hợp lệ.");
			return;
		}

		User u = userDAO.findByEmail(email);
		if (u == null) {
			forwardError(req, resp, "Email hoặc mật khẩu không đúng.");
			return;
		}

		if (!PasswordUtil.verify(password, u.getPassword())) {
			forwardError(req, resp, "Email hoặc mật khẩu không đúng.");
			return;
		}

		HttpSession session = req.getSession(true);
		u.setPassword(null); // không lưu hash vào session

		session.setAttribute("authUser", u);
		session.setAttribute("role", u.getRole());
		session.setMaxInactiveInterval(30 * 60);

		if (isSafeReturnUrl(returnUrl)) {
			resp.sendRedirect(req.getContextPath() + returnUrl);
		} else {
			if ("ADMIN".equals(u.getRole())) {
				resp.sendRedirect(req.getContextPath() + "/admin");
			} else {
				resp.sendRedirect(req.getContextPath() + "/home");
			}
		}
	}

	private void forwardError(HttpServletRequest req, HttpServletResponse resp, String msg)
			throws ServletException, IOException {
		req.setAttribute("error", msg);
		req.getRequestDispatcher("/pages/clients/account/login.jsp").forward(req, resp);
	}

	private static boolean isSafeReturnUrl(String returnUrl) {
		if (returnUrl == null)
			return false;
		String s = returnUrl.trim();
		if (s.isEmpty())
			return false;
		if (!s.startsWith("/"))
			return false;
		if (s.startsWith("//"))
			return false;
		if (s.contains("\r") || s.contains("\n"))
			return false;
		return true;
	}

	private static String trim(String s) {
		return s == null ? "" : s.trim();
	}

	private static String nvl(String s) {
		return s == null ? "" : s;
	}
}
