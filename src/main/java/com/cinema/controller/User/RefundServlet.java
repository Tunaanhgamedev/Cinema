package com.cinema.controller.User;

import java.io.IOException;
import java.sql.Timestamp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.cinema.dao.BookingDAO;
import com.cinema.dao.BookingAdminDAO;
import com.cinema.model.User;

@WebServlet("/profile/refund")
public class RefundServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final BookingDAO bookingDAO = new BookingDAO();
	private final BookingAdminDAO adminDAO = new BookingAdminDAO();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("authUser") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		User user = (User) session.getAttribute("authUser");
		int bookingId = Integer.parseInt(request.getParameter("bookingId"));
		
		// Re-check eligibility server-side for security
		BookingAdminDAO.BookingDetail detail = adminDAO.getBookingDetail(bookingId);
		if (detail != null && detail.getUserId() == user.getUserId() && "PAID".equals(detail.getStatus())) {
			
			long now = System.currentTimeMillis();
			long startTime = detail.getStartTime().getTime();
			long diffHours = (startTime - now) / (1000 * 60 * 60);
			
			if (diffHours >= 48) {
				boolean success = bookingDAO.refundBooking(bookingId);
				if (success) {
					response.sendRedirect(request.getContextPath() + "/profile/bookings?success=refund");
				} else {
					response.sendRedirect(request.getContextPath() + "/profile/bookings?error=refund_failed");
				}
			} else {
				response.sendRedirect(request.getContextPath() + "/profile/bookings?error=too_late");
			}
		} else {
			response.sendRedirect(request.getContextPath() + "/profile/bookings?error=invalid_request");
		}
	}
}
