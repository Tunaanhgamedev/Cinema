package com.cinema.controller.Admin;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.dao.BookingAdminDAO;

@WebServlet("/admin/bookings")
public class AdminBookingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final BookingAdminDAO dao = new BookingAdminDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String bookingIdStr = req.getParameter("bookingId");
		if (bookingIdStr != null && !bookingIdStr.trim().isEmpty()) {
			try {
				int bookingId = Integer.parseInt(bookingIdStr.trim());

				BookingAdminDAO.BookingDetail detail = dao.getBookingDetail(bookingId);
				req.setAttribute("detail", detail);

				req.getRequestDispatcher("/pages/admin/booking-detail.jsp").forward(req, resp);
				return;

			} catch (NumberFormatException e) {
				resp.sendRedirect(req.getContextPath() + "/admin/bookings");
				return;
			}
		}

		req.setAttribute("bookingList", dao.getAllBookings());
		req.getRequestDispatcher("/pages/admin/booking-manage.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		String action = req.getParameter("action");
		if ("status".equals(action)) {
			try {
				int bookingId = Integer.parseInt(req.getParameter("bookingId"));
				String status = req.getParameter("status");
				dao.updateStatus(bookingId, status);

				// quay lại đúng trang detail
				resp.sendRedirect(req.getContextPath() + "/admin/bookings?bookingId=" + bookingId);
				return;
			} catch (Exception e) {
				resp.sendRedirect(req.getContextPath() + "/admin/bookings");
				return;
			}
		}

		resp.sendRedirect(req.getContextPath() + "/admin/bookings");
	}
}
