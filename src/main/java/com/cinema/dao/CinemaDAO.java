package com.cinema.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cinema.model.Cinema;
import com.cinema.utils.DBConnection;

public class CinemaDAO {

	public List<Cinema> findAll() {
		String sql = "SELECT cinema_id, name, address, city FROM cinemas ORDER BY name ASC";
		List<Cinema> list = new ArrayList<>();
		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				list.add(new Cinema(rs.getInt("cinema_id"), rs.getString("name"), rs.getString("address"),
						rs.getString("city")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public Cinema findById(int cinemaId) {
		String sql = "SELECT cinema_id, name, address, city FROM cinemas WHERE cinema_id = ?";
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, cinemaId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return new Cinema(rs.getInt("cinema_id"), rs.getString("name"), rs.getString("address"),
							rs.getString("city"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
