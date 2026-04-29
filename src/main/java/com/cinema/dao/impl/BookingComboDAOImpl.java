package com.cinema.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cinema.dao.BookingComboDAO;
import com.cinema.model.BookingCombo;
import com.cinema.utils.DBConnection;
import com.cinema.views.BookingComboDetail;

public class BookingComboDAOImpl implements BookingComboDAO {

	// INSERT – không cần id vì PK là (booking_id, combo_id)
	@Override
	public void insert(BookingCombo bc) {
		String sql = """
				INSERT INTO booking_combo (booking_id, combo_id, quantity)
				VALUES (?, ?, ?)
				""";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, bc.getBookingId());
			ps.setInt(2, bc.getComboId());
			ps.setInt(3, bc.getQuantity());
			ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// DELETE theo booking_id (xóa toàn bộ combo của booking)
	@Override
	public void deleteByBookingId(int bookingId) {
		String sql = "DELETE FROM booking_combo WHERE booking_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, bookingId);
			ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// JOIN combo để hiển thị
	@Override
	public List<BookingComboDetail> findDetailByBookingId(int bookingId) {
		List<BookingComboDetail> list = new ArrayList<>();

		String sql = """
				SELECT
				    c.combo_id,
				    c.name AS combo_name,
				    c.price,
				    bc.quantity
				FROM booking_combo bc
				JOIN combos c ON c.combo_id = bc.combo_id
				WHERE bc.booking_id = ?
				""";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, bookingId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				BookingComboDetail d = new BookingComboDetail();
				d.setComboId(rs.getInt("combo_id"));
				d.setComboName(rs.getString("combo_name"));
				d.setPrice(rs.getBigDecimal("price"));
				d.setQuantity(rs.getInt("quantity"));
				list.add(d);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}
}
