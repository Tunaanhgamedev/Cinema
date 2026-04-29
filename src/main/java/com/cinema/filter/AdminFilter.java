/*
 * package com.cinema.filter;
 * 
 * import java.io.IOException;
 * 
 * import javax.servlet.Filter; import javax.servlet.FilterChain; import
 * javax.servlet.ServletException; import javax.servlet.ServletRequest; import
 * javax.servlet.ServletResponse; import javax.servlet.annotation.WebFilter;
 * import javax.servlet.http.HttpServletRequest; import
 * javax.servlet.http.HttpServletResponse; import
 * javax.servlet.http.HttpSession;
 * 
 * @WebFilter("/admin/*") public class AdminFilter implements Filter {
 * 
 * @Override public void doFilter(ServletRequest req, ServletResponse res,
 * FilterChain chain) throws IOException, ServletException {
 * 
 * HttpServletRequest request = (HttpServletRequest) req; HttpServletResponse
 * response = (HttpServletResponse) res;
 * 
 * String uri = request.getRequestURI();
 * 
 * // cho phép truy cập trang login admin if (uri.endsWith("/admin/login")) {
 * chain.doFilter(req, res); return; }
 * 
 * HttpSession session = request.getSession(false);
 * 
 * if (session == null || session.getAttribute("adminUser") == null) {
 * response.sendRedirect(request.getContextPath() + "/admin/login"); return; }
 * 
 * chain.doFilter(req, res); } }
 */