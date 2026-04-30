package com.cinema.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cinema.model.Room;
import com.cinema.utils.DBConnection;

public class RoomDAO {

	public List<Room> findAll() {
		String sql = "SELECT * FROM rooms";
		List<Room> list = new ArrayList<>();
		try (Connection cn = DBConnection.getConnection();
				PreparedStatement ps = cn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				Room r = new Room();
				r.setRoomId(rs.getInt("room_id"));
				r.setCinemaId(rs.getInt("cinema_id"));
				r.setRoomName(rs.getString("room_name"));
				r.setTotalSeats(rs.getInt("total_seats"));
				list.add(r);
			}
			return list;
		} catch (Exception e) {
			throw new RuntimeException("RoomDAO.findAll failed", e);
		}
	}
}
