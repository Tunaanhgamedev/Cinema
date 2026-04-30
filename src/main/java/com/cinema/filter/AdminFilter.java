package com.cinema.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.cinema.model.User;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;

		String uri = request.getRequestURI();

		// Cho phép truy cập các file tĩnh mà không cần filter
		if (uri.contains("/assets/")) {
			chain.doFilter(req, res);
			return;
		}

		HttpSession session = request.getSession(false);
		User user = (session != null) ? (User) session.getAttribute("authUser") : null;

		// Kiểm tra nếu chưa đăng nhập hoặc không phải ADMIN
		if (user == null || !"ADMIN".equals(user.getRole())) {
			response.sendRedirect(request.getContextPath() + "/login?error=Access Denied");
			return;
		}

		chain.doFilter(req, res);
	}
}