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
		com.cinema.dao.MovieDAO movieDAO = new com.cinema.dao.MovieDAO();
		com.cinema.dao.BookingAdminDAO bookingDAO = new com.cinema.dao.BookingAdminDAO();

		req.setAttribute("totalMovies", movieDAO.countTotalMovies());
		req.setAttribute("totalBookings", bookingDAO.countTotalBookings());
		req.setAttribute("totalRevenue", bookingDAO.calculateTotalRevenue());
		
		// Dữ liệu biểu đồ
		req.setAttribute("revenueDaily", bookingDAO.getRevenueLast7Days());
		req.setAttribute("revenueMovie", bookingDAO.getRevenueByMovie());

		req.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(req, resp);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
