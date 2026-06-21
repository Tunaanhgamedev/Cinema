package com.cinema.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cinema.enums.SeatType;
import com.cinema.model.SeatPrice;
import com.cinema.utils.DBConnection;

public class SeatPriceDAO {

    // Lấy toàn bộ phụ phí ghế (dùng cho Admin và Booking)
    public List<SeatPrice> getAllSeatPrices() {
        String sql = "SELECT * FROM seat_prices";
        List<SeatPrice> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                SeatPrice sp = new SeatPrice();
                String typeStr = rs.getString("seat_type");
                sp.setSeatType(SeatType.valueOf(typeStr));
                sp.setSurcharge(rs.getDouble("surcharge"));
                sp.setColorHex(rs.getString("color_hex"));
                list.add(sp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lưu hoặc cập nhật phụ phí ghế
    public boolean saveSeatPrice(SeatPrice sp) {
        String sql = "INSERT INTO seat_prices (seat_type, surcharge, color_hex) VALUES (?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE surcharge = VALUES(surcharge), color_hex = VALUES(color_hex)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, sp.getSeatType().name());
            ps.setDouble(2, sp.getSurcharge());
            ps.setString(3, sp.getColorHex());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy phụ phí của một loại ghế cụ thể
    public SeatPrice getByType(SeatType seatType) {
        String sql = "SELECT * FROM seat_prices WHERE seat_type = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, seatType.name());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new SeatPrice(
                        SeatType.valueOf(rs.getString("seat_type")), 
                        rs.getDouble("surcharge"),
                        rs.getString("color_hex")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
