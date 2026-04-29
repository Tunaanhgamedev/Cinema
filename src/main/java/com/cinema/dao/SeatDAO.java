package com.cinema.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.cinema.enums.SeatType;
import com.cinema.model.Seat;
import com.cinema.utils.DBConnection;

public class SeatDAO {

	// Lấy toàn bộ ghế theo room
	public List<Seat> getSeatsByRoom(int roomId) {
		List<Seat> list = new ArrayList<>();

		// ✅ bảng của bạn là "seats" (không phải "seat")
		String sql = "SELECT seat_id, room_id, seat_row, seat_number, seat_type "
				+ "FROM seats WHERE room_id = ? ORDER BY seat_row, seat_number";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, roomId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Seat s = new Seat();
					s.setSeatId(rs.getInt("seat_id"));
					s.setRoomId(rs.getInt("room_id"));

					String row = rs.getString("seat_row");
					s.setSeatRow((row != null && !row.isEmpty()) ? row.charAt(0) : 'A');

					s.setSeatNumber(rs.getInt("seat_number"));

					String type = rs.getString("seat_type");
					s.setSeatType(type != null ? SeatType.valueOf(type) : SeatType.NORMAL);

					list.add(s);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// Ghế đã được đặt theo showtime (nếu bạn còn dùng)
	public Set<Integer> getBookedSeatIds(int showtimeId) {
		Set<Integer> booked = new HashSet<>();

		String sql = "SELECT bs.seat_id " + "FROM booking_seat bs " + "JOIN booking b ON bs.booking_id = b.booking_id "
				+ "WHERE b.showtime_id = ? AND b.status = 'PAID'";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, showtimeId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next())
					booked.add(rs.getInt("seat_id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return booked;
	}
}
