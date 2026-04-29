package com.cinema.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cinema.model.User;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;

		String uri = request.getRequestURI();

		// Cho phép truy cập trang login admin mà không cần filter
		if (uri.endsWith("/admin/login") || uri.contains("/assets/")) {
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