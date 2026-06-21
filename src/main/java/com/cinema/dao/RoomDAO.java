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
		String sql = "SELECT room_id, room_name, total_seats FROM rooms";
		List<Room> list = new ArrayList<>();
		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Room r = new Room();
				r.setRoomId(rs.getInt("room_id"));
				r.setRoomName(rs.getString("room_name"));
				r.setTotalSeats(rs.getInt("total_seats"));
				list.add(r);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
