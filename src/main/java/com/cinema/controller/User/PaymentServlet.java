package com.cinema.controller.User;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.cinema.dao.BookingComboDAO;
import com.cinema.dao.BookingSeatDAO;
import com.cinema.dao.impl.BookingComboDAOImpl;
import com.cinema.dao.impl.BookingSeatDAOImpl;
import com.cinema.model.Seat;
import com.cinema.model.User;
import com.cinema.utils.DBConnection;
import com.cinema.views.BookingComboDetail;
import com.cinema.dao.ShowtimeDAO;
import com.cinema.dao.SeatPriceDAO;
import com.cinema.model.Showtime;
import com.cinema.model.SeatPrice;

@WebServlet("/booking/payment")
public class PaymentServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private BookingSeatDAO bookingSeatDAO;
	private BookingComboDAO bookingComboDAO;
	private ShowtimeDAO showtimeDAO;
	private SeatPriceDAO seatPriceDAO;

	@Override
	public void init() {
		bookingSeatDAO = new BookingSeatDAOImpl();
		bookingComboDAO = new BookingComboDAOImpl();
		showtimeDAO = new ShowtimeDAO();
		seatPriceDAO = new SeatPriceDAO();
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

		// 2.5) Lấy showtimeId từ booking
		BookingInfo bInfo = getBookingInfoNoLock(bookingId);
		if (bInfo == null) {
			response.sendRedirect(request.getContextPath() + "/home");
			return;
		}
		Showtime st = showtimeDAO.findShowtimeById(bInfo.showtimeId);
		BigDecimal ticketPrice = (st != null && st.getPrice() != null) ? st.getPrice() : new BigDecimal("75000");

		// 3) TÍNH TIỀN VÉ thực tế (Base Price + Phụ phí từng ghế)
		BigDecimal ticketSubtotal = BigDecimal.ZERO;
		if (seatList != null) {
			for (Seat s : seatList) {
				SeatPrice sp = seatPriceDAO.getByType(s.getSeatType());
				BigDecimal surcharge = (sp != null) ? BigDecimal.valueOf(sp.getSurcharge()) : BigDecimal.ZERO;
				ticketSubtotal = ticketSubtotal.add(ticketPrice.add(surcharge));
			}
		}

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

			Showtime st = showtimeDAO.findShowtimeById(info.showtimeId);
			BigDecimal ticketPrice = (st != null && st.getPrice() != null) ? st.getPrice() : new BigDecimal("75000");

			BigDecimal ticketSubtotal = BigDecimal.ZERO;
			if (seatList != null) {
				for (Seat s : seatList) {
					SeatPrice sp = seatPriceDAO.getByType(s.getSeatType());
					BigDecimal surcharge = (sp != null) ? BigDecimal.valueOf(sp.getSurcharge()) : BigDecimal.ZERO;
					ticketSubtotal = ticketSubtotal.add(ticketPrice.add(surcharge));
				}
			}

			BigDecimal comboSubtotal = BigDecimal.ZERO;
			if (comboList != null) {
				for (BookingComboDetail c : comboList) {
					BigDecimal price = (c.getPrice() != null) ? c.getPrice() : BigDecimal.ZERO;
					comboSubtotal = comboSubtotal.add(price.multiply(new BigDecimal(c.getQuantity())));
				}
			}
			BigDecimal grandTotal = ticketSubtotal.add(comboSubtotal);

			// 2.1) Áp dụng Voucher (nếu có)
			String voucherCode = request.getParameter("voucherCode");
			if (voucherCode != null && !voucherCode.trim().isEmpty()) {
				com.cinema.dao.VoucherDAO voucherDAO = new com.cinema.dao.VoucherDAO();
				com.cinema.dao.VoucherDAO.VoucherResult vResult = voucherDAO.checkVoucher(voucherCode, grandTotal.doubleValue());
				if (vResult.isValid) {
					BigDecimal discountAmount = BigDecimal.ZERO;
					if ("PERCENT".equals(vResult.type)) {
						discountAmount = grandTotal.multiply(new BigDecimal(vResult.discountAmount / 100.0));
					} else {
						discountAmount = new BigDecimal(vResult.discountAmount);
					}
					double discountAmountValue = discountAmount.doubleValue();
					grandTotal = grandTotal.subtract(discountAmount);
					if (grandTotal.compareTo(BigDecimal.ZERO) < 0) grandTotal = BigDecimal.ZERO;
					
					request.setAttribute("discountAmountValue", discountAmountValue);
				}
			}
			
			double finalDiscount = 0;
			Object attr = request.getAttribute("discountAmountValue");
			if(attr != null) finalDiscount = (double)attr;

			// 3) update bookings => PAID + total_price + discount_amount
			updateBookingPaid(con, bookingId, grandTotal, BigDecimal.valueOf(finalDiscount));

			// 4) insert payments
			insertPayment(con, bookingId, method);

			con.commit();
			
			// ✅ Cộng điểm tích lũy (1000 VNĐ = 1 điểm)
			int pointsToAdd = grandTotal.divide(new BigDecimal("1000")).intValue();
			if (pointsToAdd > 0) {
				com.cinema.dao.UserDAO userDAO = new com.cinema.dao.UserDAO();
				userDAO.addPoints(u.getUserId(), pointsToAdd);
				
				// Cập nhật lại session user để hiển thị điểm mới
				User updatedUser = userDAO.findByEmail(u.getEmail());
				if (updatedUser != null) {
					session.setAttribute("authUser", updatedUser);
				}
			}

			// ✅ Gửi Email xác nhận (Chạy ngầm)
			try {
				final BigDecimal finalTotal = grandTotal;
				final String userEmail = u.getEmail();
				final String userName = u.getFullName();
				
				new Thread(() -> {
					try {
						StringBuilder seatsStr = new StringBuilder();
						if (seatList != null) {
							for (com.cinema.model.Seat seat : seatList) {
								if (seatsStr.length() > 0) seatsStr.append(", ");
								seatsStr.append(seat.getSeatNumber());
							}
						}

						String body = com.cinema.utils.EmailUtil.getBookingConfirmationTemplate(
							userName, 
							"Vé xem phim tại BOBIXI", 
							seatsStr.toString(), 
							"Rạp BOBIXI Đà Nẵng", 
							String.format("%,.0f", finalTotal)
						);
						
						com.cinema.utils.EmailUtil.sendEmail(userEmail, "Xác nhận đặt vé thành công - BOBIXI Cinema", body);
					} catch (Exception ex) {
						ex.printStackTrace();
					}
				}).start();
			} catch (Exception ex) {
				ex.printStackTrace();
			}

			// ✅ sau khi PAID: Chuyển sang trang Hóa đơn
			response.sendRedirect(request.getContextPath() + "/booking/invoice?bookingId=" + bookingId);

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
		String sql = "SELECT booking_id, user_id, showtime_id, status FROM bookings WHERE booking_id=? FOR UPDATE";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, bookingId);
			try (ResultSet rs = ps.executeQuery()) {
				if (!rs.next())
					return null;
				BookingInfo bi = new BookingInfo();
				bi.bookingId = rs.getInt("booking_id");
				bi.userId = rs.getInt("user_id");
				bi.showtimeId = rs.getInt("showtime_id");
				bi.status = rs.getString("status");
				return bi;
			}
		} catch (Exception e) {
			throw new RuntimeException("getBookingInfoForUpdate error", e);
		}
	}

	private BookingInfo getBookingInfoNoLock(int bookingId) {
		String sql = "SELECT booking_id, user_id, showtime_id, status FROM bookings WHERE booking_id=?";
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, bookingId);
			try (ResultSet rs = ps.executeQuery()) {
				if (!rs.next())
					return null;
				BookingInfo bi = new BookingInfo();
				bi.bookingId = rs.getInt("booking_id");
				bi.userId = rs.getInt("user_id");
				bi.showtimeId = rs.getInt("showtime_id");
				bi.status = rs.getString("status");
				return bi;
			}
		} catch (Exception e) {
			throw new RuntimeException("getBookingInfoNoLock error", e);
		}
	}

	private void updateBookingPaid(Connection con, int bookingId, BigDecimal total, BigDecimal discount) {
		String sql = "UPDATE bookings SET total_price=?, discount_amount=?, status='PAID' WHERE booking_id=?";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setBigDecimal(1, total);
			ps.setBigDecimal(2, discount);
			ps.setInt(3, bookingId);
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
		int showtimeId;
		String status;
	}
}
