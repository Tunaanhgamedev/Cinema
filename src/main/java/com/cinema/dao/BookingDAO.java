package com.cinema.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class BookingDAO {

	public int createPendingBooking(Connection con, int userId, int showtimeId) {
		String sql = "INSERT INTO bookings(user_id, showtime_id, total_price, status) VALUES (?,?,?, 'PENDING')";
		try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			ps.setInt(1, userId);
			ps.setInt(2, showtimeId);
			ps.setBigDecimal(3, BigDecimal.ZERO);
			ps.executeUpdate();

			try (ResultSet rs = ps.getGeneratedKeys()) {
				if (rs.next())
					return rs.getInt(1);
			}
			throw new RuntimeException("Create booking failed (no generated key)");
		} catch (Exception e) {
			throw new RuntimeException("BookingDAO.createPendingBooking error", e);
		}
	}

	public int findRoomIdByShowtime(Connection con, int showtimeId) {
		String sql = "SELECT room_id FROM showtimes WHERE showtime_id = ?";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, showtimeId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next())
					return rs.getInt("room_id");
			}
			throw new RuntimeException("Showtime not found: " + showtimeId);
		} catch (Exception e) {
			throw new RuntimeException("BookingDAO.findRoomIdByShowtime error", e);
		}
	}

	// seatCode: "A1", "B10"...
	public Integer findSeatIdByCode(Connection con, int roomId, String code) {
		if (code == null)
			return null;
		code = code.trim().toUpperCase(); // C5
		if (code.length() < 2)
			return null;

		char row = code.charAt(0); // C
		int num;
		try {
			num = Integer.parseInt(code.substring(1)); // 5
		} catch (Exception e) {
			return null;
		}

		String sql = "SELECT seat_id FROM seats WHERE room_id=? AND seat_row=? AND seat_number=? LIMIT 1";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, roomId);
			ps.setString(2, String.valueOf(row));
			ps.setInt(3, num);
			try (ResultSet rs = ps.executeQuery()) {
				return rs.next() ? rs.getInt("seat_id") : null;
			}
		} catch (Exception e) {
			throw new RuntimeException("BookingDAO.findSeatIdByCode error", e);
		}
	}

	public boolean existsShowtime(Connection con, int showtimeId) {
		String sql = "SELECT 1 FROM showtimes WHERE showtime_id=? LIMIT 1";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, showtimeId);
			try (ResultSet rs = ps.executeQuery()) {
				return rs.next();
			}
		} catch (Exception e) {
			throw new RuntimeException("BookingDAO.existsShowtime error", e);
		}
	}

	public com.cinema.model.Booking findById(int bookingId) {
		String sql = "SELECT * FROM bookings WHERE booking_id = ?";
		try (Connection con = com.cinema.utils.DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, bookingId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					com.cinema.model.Booking b = new com.cinema.model.Booking();
					b.setBookingId(rs.getInt("booking_id"));
					b.setUserId(rs.getInt("user_id"));
					b.setShowtimeId(rs.getInt("showtime_id"));
					try {
						b.setBookingDate(rs.getTimestamp("booking_date"));
					} catch (Exception ex) {
						b.setBookingDate(rs.getTimestamp("booking_time"));
					}
					b.setTotalPrice(rs.getLong("total_price"));
					try {
						b.setDiscountAmount(rs.getLong("discount_amount"));
					} catch (Exception ex) {
						b.setDiscountAmount(0L);
					}
					b.setStatus(com.cinema.enums.StatusBooking.valueOf(rs.getString("status")));
					return b;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public java.util.List<com.cinema.model.Booking> findByUserId(int userId) {
		java.util.List<com.cinema.model.Booking> list = new java.util.ArrayList<>();
		String sql = "SELECT * FROM bookings WHERE user_id = ? ORDER BY booking_id DESC";
		try (Connection con = com.cinema.utils.DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, userId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					com.cinema.model.Booking b = new com.cinema.model.Booking();
					b.setBookingId(rs.getInt("booking_id"));
					b.setUserId(rs.getInt("user_id"));
					b.setShowtimeId(rs.getInt("showtime_id"));
					try {
						b.setBookingDate(rs.getTimestamp("booking_date"));
					} catch (Exception ex) {
						b.setBookingDate(rs.getTimestamp("booking_time"));
					}
					b.setTotalPrice(rs.getLong("total_price"));
					try {
						b.setDiscountAmount(rs.getLong("discount_amount"));
					} catch (Exception ex) {
						b.setDiscountAmount(0L);
					}
					b.setStatus(com.cinema.enums.StatusBooking.valueOf(rs.getString("status")));
					list.add(b);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public java.util.List<com.cinema.model.Seat> getSeatsByBookingId(int bookingId) {
		java.util.List<com.cinema.model.Seat> list = new java.util.ArrayList<>();
		String sql = "SELECT s.* FROM seats s JOIN booking_seats bs ON s.seat_id = bs.seat_id WHERE bs.booking_id = ?";
		try (Connection con = com.cinema.utils.DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, bookingId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					com.cinema.model.Seat s = new com.cinema.model.Seat();
					s.setSeatId(rs.getInt("seat_id"));
					s.setSeatNumber(rs.getInt("seat_number"));
					String rowStr = rs.getString("seat_row");
					s.setSeatRow(rowStr != null && !rowStr.isEmpty() ? rowStr.charAt(0) : 'A');
					list.add(s);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
