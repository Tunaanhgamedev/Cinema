package com.cinema.filter;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(urlPatterns = { "/booking/*", "/booking-seat" })
public class AuthFilter implements Filter {

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;

		HttpSession session = request.getSession(false);

		// ✅ đồng bộ với LoginServlet: session.setAttribute("authUser", u)
		if (session == null || session.getAttribute("authUser") == null) {

			String ctx = request.getContextPath(); // /Cinema
			String uri = request.getRequestURI(); // /Cinema/booking/payment
			String path = uri.substring(ctx.length()); // /booking/payment

			String qs = request.getQueryString(); // bookingId=1
			String returnUrl = path + (qs != null ? "?" + qs : "");

			String encoded = URLEncoder.encode(returnUrl, StandardCharsets.UTF_8.name());
			response.sendRedirect(ctx + "/login?returnUrl=" + encoded);
			return;
		}

		chain.doFilter(req, res);
	}
}
