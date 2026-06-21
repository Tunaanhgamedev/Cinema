package com.cinema.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.cinema.model.Booking;
import com.cinema.utils.DBConnection;

public class BookingDAO {

	public static class BookingView extends Booking {
		private String movieTitle;
		private String moviePoster;
		private Timestamp startTime;
		private Timestamp endTime;
		private String roomName;
		private String seats; // Concatenated seat codes

		public String getMovieTitle() { return movieTitle; }
		public void setMovieTitle(String movieTitle) { this.movieTitle = movieTitle; }
		public String getMoviePoster() { return moviePoster; }
		public void setMoviePoster(String moviePoster) { this.moviePoster = moviePoster; }
		public Timestamp getStartTime() { return startTime; }
		public void setStartTime(Timestamp startTime) { this.startTime = startTime; }
		public Timestamp getEndTime() { return endTime; }
		public void setEndTime(Timestamp endTime) { this.endTime = endTime; }
		public String getRoomName() { return roomName; }
		public void setRoomName(String roomName) { this.roomName = roomName; }
		public String getSeats() { return seats; }
		public void setSeats(String seats) { this.seats = seats; }
	}

	public List<BookingView> findByUserId(int userId) {
		String sql = """
				SELECT b.booking_id, b.user_id, b.showtime_id, b.booking_time, b.total_price, b.status,
				       m.title as movie_title, m.poster as movie_poster,
				       s.start_time, s.end_time, r.room_name,
				       GROUP_CONCAT(CONCAT(se.seat_row, se.seat_number) SEPARATOR ', ') as seat_codes
				FROM bookings b
				JOIN showtimes s ON b.showtime_id = s.showtime_id
				JOIN movies m ON s.movie_id = m.movie_id
				JOIN rooms r ON s.room_id = r.room_id
				LEFT JOIN booking_seats bs ON b.booking_id = bs.booking_id
				LEFT JOIN seats se ON bs.seat_id = se.seat_id
				WHERE b.user_id = ? AND b.status = 'PAID'
				GROUP BY b.booking_id
				ORDER BY b.booking_time DESC
				""";
		List<BookingView> list = new ArrayList<>();
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, userId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					BookingView bv = new BookingView();
					bv.setBookingId(rs.getInt("booking_id"));
					bv.setUserId(rs.getInt("user_id"));
					bv.setShowtimeId(rs.getInt("showtime_id"));
					bv.setBookingTime(rs.getTimestamp("booking_time"));
					bv.setTotalPrice(rs.getLong("total_price"));
					bv.setMovieTitle(rs.getString("movie_title"));
					bv.setMoviePoster(rs.getString("movie_poster"));
					bv.setStartTime(rs.getTimestamp("start_time"));
					bv.setEndTime(rs.getTimestamp("end_time"));
					bv.setRoomName(rs.getString("room_name"));
					bv.setSeats(rs.getString("seat_codes"));
					list.add(bv);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

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

	public Integer findSeatIdByCode(Connection con, int roomId, String code) {
		if (code == null)
			return null;
		code = code.trim().toUpperCase();
		if (code.length() < 2)
			return null;

		char row = code.charAt(0);
		int num;
		try {
			num = Integer.parseInt(code.substring(1));
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

	public boolean refundBooking(int bookingId) {
		String sql = "UPDATE bookings SET status = 'REFUNDED' WHERE booking_id = ? AND status = 'PAID'";
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, bookingId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

}
