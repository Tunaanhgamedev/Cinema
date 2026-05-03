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

    public int countTotalBookings() {
        String sql = "SELECT COUNT(*) FROM bookings WHERE status = 'PAID'";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public long calculateTotalRevenue() {
        String sql = "SELECT SUM(total_price) FROM bookings WHERE status = 'PAID'";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getBigDecimal(1) != null ? rs.getBigDecimal(1).longValue() : 0L;
        } catch (Exception e) { e.printStackTrace(); }
        return 0L;
    }

    public long calculateTotalDiscount() {
        String sql = "SELECT SUM(discount_amount) FROM bookings WHERE status = 'PAID'";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getBigDecimal(1) != null ? rs.getBigDecimal(1).longValue() : 0L;
        } catch (Exception e) { e.printStackTrace(); }
        return 0L;
    }

    public java.util.Map<String, Long> getRevenueLast7Days() {
        java.util.Map<String, Long> map = new java.util.LinkedHashMap<>();
        String sql = """
            SELECT DATE(booking_date) as d, SUM(total_price) as r 
            FROM bookings 
            WHERE status = 'PAID' AND booking_date >= DATE_SUB(NOW(), INTERVAL 7 DAY)
            GROUP BY DATE(booking_date) 
            ORDER BY d ASC
        """;
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getString("d"), rs.getBigDecimal("r").longValue());
            }
        } catch (Exception e) { e.printStackTrace(); }
        return map;
    }

    public java.util.Map<String, Long> getRevenueByMovie() {
        java.util.Map<String, Long> map = new java.util.LinkedHashMap<>();
        String sql = """
            SELECT m.title, SUM(b.total_price) as r 
            FROM bookings b 
            JOIN showtimes s ON b.showtime_id = s.showtime_id 
            JOIN movies m ON s.movie_id = m.movie_id 
            WHERE b.status = 'PAID'
            GROUP BY m.title
            ORDER BY r DESC
        """;
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getString("title"), rs.getBigDecimal("r").longValue());
            }
        } catch (Exception e) { e.printStackTrace(); }
        return map;
    }

    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM bookings ORDER BY booking_id DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRowToBooking(rs));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public int findRoomIdByShowtime(Connection con, int showtimeId) throws Exception {
        String sql = "SELECT room_id FROM showtimes WHERE showtime_id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, showtimeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("room_id");
            }
        }
        return 0;
    }

    public Integer findSeatIdByCode(Connection con, int roomId, String code) throws Exception {
        // Code format: Row + Number (e.g., A1, B12)
        if (code == null || code.length() < 2) return null;
        String row = code.substring(0, 1);
        int number = Integer.parseInt(code.substring(1));

        String sql = "SELECT seat_id FROM seats WHERE room_id = ? AND seat_row = ? AND seat_number = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ps.setString(2, row);
            ps.setInt(3, number);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("seat_id");
            }
        }
        return null;
    }
}
