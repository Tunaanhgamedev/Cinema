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
        String sql = "SELECT * FROM combos ORDER BY combo_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToCombo(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Combo findById(int comboId) {
        String sql = "SELECT * FROM combos WHERE combo_id = ?";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, comboId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCombo(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private Combo mapResultSetToCombo(ResultSet rs) throws Exception {
        Combo c = new Combo();
        c.setComboId(rs.getInt("combo_id"));
        c.setName(rs.getString("name"));
        c.setPrice(rs.getBigDecimal("price"));
        c.setDescription(rs.getString("description"));
        c.setImageUrl(rs.getString("image_url"));
        return c;
    }

    @Override
    public boolean insertCombo(String name, String description, BigDecimal price, String imageUrl) {
        String sql = "INSERT INTO combos(name, price, description, image_url) VALUES(?,?,?,?)";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setBigDecimal(2, price);
            ps.setString(3, description);
            ps.setString(4, imageUrl);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateCombo(int comboId, String name, String description, BigDecimal price, String imageUrl) {
        String sql = "UPDATE combos SET name=?, price=?, description=?, image_url=? WHERE combo_id=?";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setBigDecimal(2, price);
            ps.setString(3, description);
            ps.setString(4, imageUrl);
            ps.setInt(5, comboId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteCombo(int comboId) {
        String sql = "DELETE FROM combos WHERE combo_id=?";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, comboId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
