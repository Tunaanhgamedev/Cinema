/*
 * package com.cinema.controller.Admin;
 * 
 * import java.io.IOException;
 * 
 * import jakarta.servlet.ServletException; import
 * jakarta.servlet.annotation.WebServlet; import jakarta.servlet.http.HttpServlet;
 * import jakarta.servlet.http.HttpServletRequest; import
 * jakarta.servlet.http.HttpServletResponse; import
 * jakarta.servlet.http.HttpSession;
 * 
 * import com.cinema.dao.UserDAO; import com.cinema.model.User; import
 * com.cinema.utils.PasswordUtil;
 * 
 * @WebServlet("/admin/login") public class AdminLoginServlet extends
 * HttpServlet { private static final long serialVersionUID = 1L; private final
 * UserDAO userDAO = new UserDAO();
 * 
 * @Override protected void doGet(HttpServletRequest req, HttpServletResponse
 * resp) throws ServletException, IOException {
 * 
 * req.getRequestDispatcher("/pages/admin/login.jsp").forward(req, resp); }
 * 
 * @Override protected void doPost(HttpServletRequest req, HttpServletResponse
 * resp) throws ServletException, IOException {
 * 
 * String email = req.getParameter("email"); String password =
 * req.getParameter("password");
 * 
 * User u = userDAO.findByEmail(email);
 * 
 * if (u == null || !"ADMIN".equals(u.getRole()) ||
 * !PasswordUtil.verify(password, u.getPassword())) {
 * 
 * req.setAttribute("error", "Tài khoản admin không hợp lệ");
 * req.getRequestDispatcher("/pages/admin/login.jsp").forward(req, resp);
 * return; }
 * 
 * HttpSession session = req.getSession(true); u.setPassword(null);
 * 
 * session.setAttribute("adminUser", u); // 🔥 RIÊNG
 * session.setMaxInactiveInterval(30 * 60);
 * 
 * resp.sendRedirect(req.getContextPath() + "/admin/dashboard"); } }
 */