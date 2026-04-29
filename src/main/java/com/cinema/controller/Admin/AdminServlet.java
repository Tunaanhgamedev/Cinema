package com.cinema.controller.Admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

		req.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(req, resp);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
