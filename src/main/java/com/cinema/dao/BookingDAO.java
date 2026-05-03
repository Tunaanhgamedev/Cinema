package com.cinema.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.cinema.enums.StatusBooking;
import com.cinema.model.Booking;
import com.cinema.model.Seat;
import com.cinema.utils.DBConnection;

public class BookingDAO {

    public int createPendingBooking(Connection con, int userId, int showtimeId) {
        String sql = "INSERT INTO bookings(user_id, showtime_id, total_price, status) VALUES (?,?,?, 'PENDING')";
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.setInt(2, showtimeId);
            ps.setBigDecimal(3, BigDecimal.ZERO);
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
            throw new RuntimeException("Create booking failed (no generated key)");
        } catch (Exception e) {
            throw new RuntimeException("BookingDAO.createPendingBooking error", e);
        }
    }

    public Booking findById(int bookingId) {
        String sql = "SELECT * FROM bookings WHERE booking_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToBooking(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Booking> findByUserId(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE user_id = ? ORDER BY booking_id DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRowToBooking(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private Booking mapRowToBooking(ResultSet rs) throws Exception {
        Booking b = new Booking();
        b.setBookingId(rs.getInt("booking_id"));
        b.setUserId(rs.getInt("user_id"));
        b.setShowtimeId(rs.getInt("showtime_id"));
        b.setBookingDate(rs.getTimestamp("booking_date"));
        b.setTotalPrice(rs.getBigDecimal("total_price").longValue());
        b.setDiscountAmount(rs.getBigDecimal("discount_amount") != null ? rs.getBigDecimal("discount_amount").longValue() : 0L);
        
        // Handle voucher_id if exists in resultset
        try {
            int vId = rs.getInt("voucher_id");
            if (!rs.wasNull()) b.setVoucherId(vId);
        } catch (Exception e) {}

        String statusStr = rs.getString("status");
        try {
            b.setStatus(StatusBooking.valueOf(statusStr));
        } catch (Exception e) {
            b.setStatus(StatusBooking.PENDING);
        }
        return b;
    }

    public List<Seat> getSeatsByBookingId(int bookingId) {
        List<Seat> list = new ArrayList<>();
        String sql = "SELECT s.* FROM seats s JOIN booking_seats bs ON s.seat_id = bs.seat_id WHERE bs.booking_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Seat s = new Seat();
                    s.setSeatId(rs.getInt("seat_id"));
                    s.setSeatNumber(rs.getInt("seat_number"));
                    String rowStr = rs.getString("seat_row");
                    s.setSeatRow(rowStr != null && !rowStr.isEmpty() ? rowStr.charAt(0) : 'A');
                    list.add(s);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void updateStatus(int bookingId, StatusBooking status, String paymentMethod) {
        String sql = "UPDATE bookings SET status = ?, payment_method = ? WHERE booking_id = ?";
        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status.name());
            ps.setString(2, paymentMethod);
            ps.setInt(3, bookingId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
