package com.cinema.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.cinema.model.Room;
import com.cinema.utils.DBConnection;

public class RoomDAO {

	private Set<String> getExistingColumns() {
		Set<String> columns = new HashSet<>();
		try (Connection cn = DBConnection.getConnection();
				ResultSet rs = cn.getMetaData().getColumns(null, null, "rooms", null)) {
			while (rs.next()) {
				columns.add(rs.getString("COLUMN_NAME").toLowerCase());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return columns;
	}

	public List<Room> findAll() {
		String sql = "SELECT * FROM rooms ORDER BY room_id ASC";
		List<Room> list = new ArrayList<>();
		try (Connection cn = DBConnection.getConnection();
				PreparedStatement ps = cn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			
			Set<String> cols = getExistingColumns();
			while (rs.next()) {
				Room r = new Room();
				r.setRoomId(rs.getInt("room_id"));
				r.setCinemaId(rs.getInt("cinema_id"));
				r.setRoomName(rs.getString("room_name"));
				r.setTotalSeats(rs.getInt("total_seats"));
				
				// Adaptive logic for extra columns
				// Note: If you want to use roomType, add it to Room model first. 
				// For now, we keep it simple or use it if metadata exists.
				list.add(r);
			}
			return list;
		} catch (Exception e) {
			throw new RuntimeException("RoomDAO.findAll failed", e);
		}
	}

	public Room findById(int roomId) {
		String sql = "SELECT * FROM rooms WHERE room_id = ?";
		try (Connection cn = DBConnection.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
			ps.setInt(1, roomId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					Room r = new Room();
					r.setRoomId(rs.getInt("room_id"));
					r.setCinemaId(rs.getInt("cinema_id"));
					r.setRoomName(rs.getString("room_name"));
					r.setTotalSeats(rs.getInt("total_seats"));
					return r;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean insert(Room r) {
		String sql = "INSERT INTO rooms (cinema_id, room_name, total_seats) VALUES (?, ?, ?)";
		try (Connection cn = DBConnection.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
			ps.setInt(1, r.getCinemaId() > 0 ? r.getCinemaId() : 1);
			ps.setString(2, r.getRoomName());
			ps.setInt(3, r.getTotalSeats());
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			throw new RuntimeException("RoomDAO.insert failed: " + e.getMessage(), e);
		}
	}

	public boolean update(Room r) {
		String sql = "UPDATE rooms SET cinema_id=?, room_name=?, total_seats=? WHERE room_id=?";
		try (Connection cn = DBConnection.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
			ps.setInt(1, r.getCinemaId() > 0 ? r.getCinemaId() : 1);
			ps.setString(2, r.getRoomName());
			ps.setInt(3, r.getTotalSeats());
			ps.setInt(4, r.getRoomId());
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			throw new RuntimeException("RoomDAO.update failed: " + e.getMessage(), e);
		}
	}

	public boolean delete(int roomId) {
		String sql = "DELETE FROM rooms WHERE room_id = ?";
		try (Connection cn = DBConnection.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
			ps.setInt(1, roomId);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			throw new RuntimeException("RoomDAO.delete failed. Note: Check if any showtimes use this room.", e);
		}
	}

	public void generateDefaultSeats(int roomId, int rows, int seatsPerRow) {
		String sql = "INSERT INTO seats (room_id, seat_row, seat_number, seat_type) VALUES (?, ?, ?, ?)";
		try (Connection cn = DBConnection.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
			for (int r = 0; r < rows; r++) {
				char rowChar = (char) ('A' + r);
				for (int s = 1; s <= seatsPerRow; s++) {
					ps.setInt(1, roomId);
					ps.setString(2, String.valueOf(rowChar));
					ps.setInt(3, s);
					ps.setString(4, "NORMAL");
					ps.addBatch();
				}
			}
			ps.executeBatch();
		} catch (Exception e) {
			throw new RuntimeException("RoomDAO.generateDefaultSeats failed: " + e.getMessage(), e);
		}
	}
}
