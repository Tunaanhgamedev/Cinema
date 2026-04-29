package com.cinema.controller.User;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cinema.dao.BookingComboDAO;
import com.cinema.dao.BookingSeatDAO;
import com.cinema.dao.impl.BookingComboDAOImpl;
import com.cinema.dao.impl.BookingSeatDAOImpl;
import com.cinema.model.Seat;
import com.cinema.model.User;
import com.cinema.utils.DBConnection;
import com.cinema.views.BookingComboDetail;

@WebServlet("/booking/payment")
public class PaymentServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private BookingSeatDAO bookingSeatDAO;
	private BookingComboDAO bookingComboDAO;

	@Override
	public void init() {
		bookingSeatDAO = new BookingSeatDAOImpl();
		bookingComboDAO = new BookingComboDAOImpl();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String bookingIdStr = request.getParameter("bookingId");
		Integer bookingId = parseIntOrNull(bookingIdStr);
		if (bookingId == null) {
			response.sendRedirect(request.getContextPath() + "/home");
			return;
		}

		// 1) GHẾ theo booking
		List<Seat> seatList = bookingSeatDAO.findSeatsByBookingId(bookingId);

		// 2) COMBO theo booking
		List<BookingComboDetail> comboList = bookingComboDAO.findDetailByBookingId(bookingId);

		// 3) TÍNH TIỀN VÉ (tạm FIX 75k/ghế)
		BigDecimal ticketPrice = new BigDecimal("75000");
		BigDecimal ticketSubtotal = ticketPrice.multiply(new BigDecimal(seatList == null ? 0 : seatList.size()));

		// 4) TÍNH TIỀN COMBO
		BigDecimal comboSubtotal = BigDecimal.ZERO;
		if (comboList != null) {
			for (BookingComboDetail c : comboList) {
				BigDecimal price = (c.getPrice() != null) ? c.getPrice() : BigDecimal.ZERO;
				comboSubtotal = comboSubtotal.add(price.multiply(new BigDecimal(c.getQuantity())));
			}
		}

		BigDecimal grandTotal = ticketSubtotal.add(comboSubtotal);

		// 5) Đẩy sang JSP
		request.setAttribute("bookingId", bookingId);
		request.setAttribute("seatList", seatList);
		request.setAttribute("comboList", comboList);

		request.setAttribute("ticketPrice", ticketPrice);
		request.setAttribute("ticketSubtotal", ticketSubtotal);
		request.setAttribute("comboSubtotal", comboSubtotal);
		request.setAttribute("grandTotal", grandTotal);

		request.getRequestDispatcher("/pages/clients/booking/payment.jsp").forward(request, response);
	}

	// ✅ POST: bấm "Thanh toán" -> update bookings=PAID + insert payments
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("authUser") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		User u = (User) session.getAttribute("authUser");

		Integer bookingId = parseIntOrNull(request.getParameter("bookingId"));
		String method = trim(request.getParameter("method")); // CASH/MOMO/VNPAY
		if (bookingId == null) {
			response.sendRedirect(request.getContextPath() + "/home");
			return;
		}
		if (method.isEmpty())
			method = "CASH";

		Connection con = null;
		try {
			con = DBConnection.getConnection();
			con.setAutoCommit(false);

			// 1) check booking thuộc user + đang PENDING
			BookingInfo info = getBookingInfoForUpdate(con, bookingId);
			if (info == null) {
				con.rollback();
				response.sendRedirect(request.getContextPath() + "/home");
				return;
			}
			if (info.userId != u.getUserId()) {
				con.rollback();
				response.sendError(403, "Bạn không có quyền thanh toán booking này.");
				return;
			}
			if (!"PENDING".equals(info.status)) {
				con.rollback();
				response.sendRedirect(request.getContextPath() + "/booking/payment?bookingId=" + bookingId
						+ "&error=Booking%20khong%20o%20trang%20thai%20PENDING");
				return;
			}

			// 2) tính lại total (an toàn, không tin hidden input)
			List<Seat> seatList = bookingSeatDAO.findSeatsByBookingId(bookingId);
			List<BookingComboDetail> comboList = bookingComboDAO.findDetailByBookingId(bookingId);

			BigDecimal ticketPrice = new BigDecimal("75000");
			BigDecimal ticketSubtotal = ticketPrice.multiply(new BigDecimal(seatList == null ? 0 : seatList.size()));

			BigDecimal comboSubtotal = BigDecimal.ZERO;
			if (comboList != null) {
				for (BookingComboDetail c : comboList) {
					BigDecimal price = (c.getPrice() != null) ? c.getPrice() : BigDecimal.ZERO;
					comboSubtotal = comboSubtotal.add(price.multiply(new BigDecimal(c.getQuantity())));
				}
			}
			BigDecimal grandTotal = ticketSubtotal.add(comboSubtotal);

			// 3) update bookings => PAID + total_price
			updateBookingPaid(con, bookingId, grandTotal);

			// 4) insert payments
			insertPayment(con, bookingId, method);

			con.commit();

			// ✅ sau khi PAID: ghế sẽ khóa vĩnh viễn (bookedSeats query có b.status='PAID')
			response.sendRedirect(request.getContextPath() + "/booking/payment?bookingId=" + bookingId + "&success=1");

		} catch (Exception e) {
			if (con != null) {
				try {
					con.rollback();
				} catch (Exception ignore) {
				}
			}
			throw new ServletException(e);
		} finally {
			if (con != null) {
				try {
					con.close();
				} catch (Exception ignore) {
				}
			}
		}
	}

	// ========= SQL helpers =========

	// Lock booking row để tránh 2 tab thanh toán cùng lúc
	private BookingInfo getBookingInfoForUpdate(Connection con, int bookingId) {
		String sql = "SELECT booking_id, user_id, status FROM bookings WHERE booking_id=? FOR UPDATE";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, bookingId);
			try (ResultSet rs = ps.executeQuery()) {
				if (!rs.next())
					return null;
				BookingInfo bi = new BookingInfo();
				bi.bookingId = rs.getInt("booking_id");
				bi.userId = rs.getInt("user_id");
				bi.status = rs.getString("status");
				return bi;
			}
		} catch (Exception e) {
			throw new RuntimeException("getBookingInfoForUpdate error", e);
		}
	}

	private void updateBookingPaid(Connection con, int bookingId, BigDecimal total) {
		String sql = "UPDATE bookings SET total_price=?, status='PAID' WHERE booking_id=?";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setBigDecimal(1, total);
			ps.setInt(2, bookingId);
			int updated = ps.executeUpdate();
			if (updated != 1)
				throw new RuntimeException("updateBookingPaid failed");
		} catch (Exception e) {
			throw new RuntimeException("updateBookingPaid error", e);
		}
	}

	private void insertPayment(Connection con, int bookingId, String method) {
		String sql = "INSERT INTO payments(booking_id, method, status) VALUES (?, ?, 'SUCCESS')";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, bookingId);
			ps.setString(2, method);
			ps.executeUpdate();
		} catch (Exception e) {
			throw new RuntimeException("insertPayment error", e);
		}
	}

	// ========= utils =========
	private static Integer parseIntOrNull(String s) {
		if (s == null)
			return null;
		s = s.trim();
		if (s.isEmpty())
			return null;
		try {
			return Integer.parseInt(s);
		} catch (Exception e) {
			return null;
		}
	}

	private static String trim(String s) {
		return s == null ? "" : s.trim();
	}

	private static class BookingInfo {
		int bookingId;
		int userId;
		String status;
	}
}
