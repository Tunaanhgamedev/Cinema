package com.cinema.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cinema.model.SeatPrice;
import com.cinema.utils.DBConnection;

public class SeatPriceDAO {

    // Lấy toàn bộ phụ phí ghế
    public List<SeatPrice> getAll() {
        String sql = "SELECT * FROM seat_prices";
        List<SeatPrice> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                SeatPrice sp = new SeatPrice();
                sp.setSeatType(rs.getString("seat_type"));
                sp.setSurcharge(rs.getBigDecimal("surcharge"));
                list.add(sp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy phụ phí của một loại ghế cụ thể
    public SeatPrice getByType(String seatType) {
        String sql = "SELECT * FROM seat_prices WHERE seat_type = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, seatType);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new SeatPrice(rs.getString("seat_type"), rs.getBigDecimal("surcharge"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật phụ phí (Dành cho Admin)
    public boolean update(SeatPrice sp) {
        String sql = "UPDATE seat_prices SET surcharge = ? WHERE seat_type = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setBigDecimal(1, sp.getSurcharge());
            ps.setString(2, sp.getSeatType());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Thêm loại ghế mới (Trường hợp chưa có)
    public boolean insert(SeatPrice sp) {
        String sql = "INSERT INTO seat_prices (seat_type, surcharge) VALUES (?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, sp.getSeatType());
            ps.setBigDecimal(2, sp.getSurcharge());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
