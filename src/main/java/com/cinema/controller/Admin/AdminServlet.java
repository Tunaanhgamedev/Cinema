package com.cinema.controller.Admin;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdminServlet
 */
@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		com.cinema.dao.VoucherDAO voucherDAO = new com.cinema.dao.VoucherDAO();
		com.cinema.dao.UserDAO userDAO = new com.cinema.dao.UserDAO();

		req.setAttribute("totalMovies", movieDAO.countTotalMovies());
		req.setAttribute("totalBookings", bookingDAO.countTotalBookings());
		req.setAttribute("totalRevenue", bookingDAO.calculateTotalRevenue());
		req.setAttribute("totalDiscount", bookingDAO.calculateTotalDiscount());
		req.setAttribute("activeVouchers", voucherDAO.countActiveVouchers());
		req.setAttribute("userCount", userDAO.countTotalUsers());
		
		// Dữ liệu biểu đồ
		req.setAttribute("revenueDaily", bookingDAO.getRevenueLast7Days());
		req.setAttribute("revenueMovie", bookingDAO.getRevenueByMovie());
		req.setAttribute("recentBookings", bookingDAO.getAllBookings().stream().limit(5).toList());

		req.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(req, resp);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
