package com.cinema.controller.User;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.cinema.dao.BookingDAO;
import com.cinema.model.User;

@WebServlet("/profile/bookings")
public class MyBookingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final BookingDAO bookingDAO = new BookingDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("authUser") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		User user = (User) session.getAttribute("authUser");
		List<BookingDAO.BookingView> bookings = bookingDAO.findBookingViewsByUserId(user.getUserId());
		
		request.setAttribute("bookings", bookings);
		request.setAttribute("now", new java.util.Date());
		
		request.getRequestDispatcher("/pages/clients/profile/my-bookings.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
