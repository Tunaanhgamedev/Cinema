package com.cinema.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import com.cinema.dao.BookingSeatDAO;
import com.cinema.enums.SeatType;
import com.cinema.model.Seat;
import com.cinema.utils.DBConnection;

public class BookingSeatDAOImpl implements BookingSeatDAO {

	// =================== CŨ: dùng cho PaymentServlet ===================
	@Override
	public List<Seat> findSeatsByBookingId(int bookingId) {
		List<Seat> list = new ArrayList<>();

		String sql = """
				    SELECT s.seat_id, s.room_id, s.seat_row, s.seat_number, s.seat_type
				    FROM booking_seat bs
				    JOIN seats s ON s.seat_id = bs.seat_id
				    WHERE bs.booking_id = ?
				    ORDER BY s.seat_row, s.seat_number
				""";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, bookingId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Seat seat = new Seat();
					seat.setSeatId(rs.getInt("seat_id"));
					seat.setRoomId(rs.getInt("room_id"));

					String rowStr = rs.getString("seat_row");
					seat.setSeatRow(rowStr != null && !rowStr.isEmpty() ? rowStr.charAt(0) : 'A');

					seat.setSeatNumber(rs.getInt("seat_number"));

					String typeStr = rs.getString("seat_type");
					SeatType type = SeatType.NORMAL;
					try {
						type = SeatType.valueOf(typeStr);
					} catch (Exception ignore) {
					}
					seat.setSeatType(type);

					list.add(seat);
				}
			}

		} catch (SQLException e) {
			throw new RuntimeException("BookingSeatDAOImpl.findSeatsByBookingId error", e);
		}

		return list;
	}

	// =================== MỚI: bookedSeats cho booking-ticket.jsp
	// ===================
	@Override
	public Set<String> findBookedSeatCodesByShowtime(int showtimeId, int holdMinutes) {
		String sql = """
				    SELECT CONCAT(s.seat_row, s.seat_number) AS seat_code
				    FROM booking_seat bs
				    JOIN seats s    ON s.seat_id = bs.seat_id
				    JOIN bookings b ON b.booking_id = bs.booking_id
				    WHERE b.showtime_id = ?
				      AND (
				            b.status = 'PAID'
				         OR (b.status = 'PENDING' AND b.booking_time >= (NOW() - INTERVAL ? MINUTE))
				      )
				""";

		Set<String> out = new LinkedHashSet<>();
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, showtimeId);
			ps.setInt(2, holdMinutes);

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next())
					out.add(rs.getString("seat_code"));
			}

		} catch (Exception e) {
			throw new RuntimeException("BookingSeatDAOImpl.findBookedSeatCodesByShowtime error", e);
		}
		return out;
	}

	// =================== MỚI: insertSeat có chống trùng (lock + check)
	// ===================
	@Override
	public void insertSeat(Connection con, int bookingId, int showtimeId, int seatId, int holdMinutes) {

		// 1) LOCK row seat => giảm race condition mạnh
		lockSeatRow(con, seatId);

		// 2) Check seat taken (PAID hoặc PENDING còn hạn)
		if (isSeatTaken(con, showtimeId, seatId, holdMinutes)) {
			throw new RuntimeException("SEAT_TAKEN");
		}

		// 3) Insert booking_seat
		String sql = "INSERT INTO booking_seat(booking_id, seat_id) VALUES (?,?)";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, bookingId);
			ps.setInt(2, seatId);
			ps.executeUpdate();
		} catch (Exception e) {
			throw new RuntimeException("BookingSeatDAOImpl.insertSeat error", e);
		}
	}

	// =================== MỚI: timeout hold 10 phút ===================
	@Override
	public int releaseExpiredHolds(Connection con, int holdMinutes) {
		String deleteSeatsSql = """
				    DELETE bs
				    FROM booking_seat bs
				    JOIN bookings b ON b.booking_id = bs.booking_id
				    WHERE b.status = 'PENDING'
				      AND b.booking_time < (NOW() - INTERVAL ? MINUTE)
				""";

		String cancelBookingsSql = """
				    UPDATE bookings
				    SET status = 'CANCELLED'
				    WHERE status = 'PENDING'
				      AND booking_time < (NOW() - INTERVAL ? MINUTE)
				""";

		try (PreparedStatement ps1 = con.prepareStatement(deleteSeatsSql);
				PreparedStatement ps2 = con.prepareStatement(cancelBookingsSql)) {

			ps1.setInt(1, holdMinutes);
			ps1.executeUpdate();

			ps2.setInt(1, holdMinutes);
			return ps2.executeUpdate();

		} catch (Exception e) {
			throw new RuntimeException("BookingSeatDAOImpl.releaseExpiredHolds error", e);
		}
	}

	// =================== helpers ===================
	private void lockSeatRow(Connection con, int seatId) {
		String sql = "SELECT seat_id FROM seats WHERE seat_id = ? FOR UPDATE";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, seatId);
			try (ResultSet rs = ps.executeQuery()) {
				/* lock only */ }
		} catch (Exception e) {
			throw new RuntimeException("BookingSeatDAOImpl.lockSeatRow error", e);
		}
	}

	private boolean isSeatTaken(Connection con, int showtimeId, int seatId, int holdMinutes) {
		String sql = """
				    SELECT 1
				    FROM booking_seat bs
				    JOIN bookings b ON b.booking_id = bs.booking_id
				    WHERE b.showtime_id = ?
				      AND bs.seat_id = ?
				      AND (
				            b.status = 'PAID'
				         OR (b.status = 'PENDING' AND b.booking_time >= (NOW() - INTERVAL ? MINUTE))
				      )
				    LIMIT 1
				""";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, showtimeId);
			ps.setInt(2, seatId);
			ps.setInt(3, holdMinutes);
			try (ResultSet rs = ps.executeQuery()) {
				return rs.next();
			}
		} catch (Exception e) {
			throw new RuntimeException("BookingSeatDAOImpl.isSeatTaken error", e);
		}
	}
}
