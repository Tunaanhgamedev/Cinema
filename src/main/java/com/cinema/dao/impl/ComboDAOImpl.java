package com.cinema.dao.impl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cinema.dao.ComboDAO;
import com.cinema.model.Combo;
import com.cinema.utils.DBConnection;

public class ComboDAOImpl implements ComboDAO {

	@Override
	public List<Combo> findAll() {
		List<Combo> list = new ArrayList<>();
		String sql = "SELECT combo_id, name, price, description FROM combos ORDER BY combo_id DESC";

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Combo c = new Combo();
				c.setComboId(rs.getInt("combo_id"));
				c.setName(rs.getString("name"));
				c.setPrice(rs.getBigDecimal("price"));
				c.setDescription(rs.getString("description"));
				list.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Combo findById(int comboId) {
		String sql = "SELECT combo_id, name, price, description FROM combos WHERE combo_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, comboId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					Combo c = new Combo();
					c.setComboId(rs.getInt("combo_id"));
					c.setName(rs.getString("name"));
					c.setPrice(rs.getBigDecimal("price"));
					c.setDescription(rs.getString("description"));
					return c;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean insertCombo(String name, String description, BigDecimal price) {
		String sql = "INSERT INTO combos(name, price, description) VALUES(?,?,?)";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, name);
			ps.setBigDecimal(2, price);
			ps.setString(3, description);
			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean updateCombo(int comboId, String name, String description, BigDecimal price) {
		String sql = "UPDATE combos SET name=?, price=?, description=? WHERE combo_id=?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, name);
			ps.setBigDecimal(2, price);
			ps.setString(3, description);
			ps.setInt(4, comboId);
			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean deleteCombo(int comboId) {
		String sql = "DELETE FROM combos WHERE combo_id=?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, comboId);
			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
