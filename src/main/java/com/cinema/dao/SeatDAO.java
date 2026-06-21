package com.cinema.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.cinema.enums.SeatType;
import com.cinema.model.Seat;
import com.cinema.utils.DBConnection;

public class SeatDAO {

    public List<Seat> getSeatsByRoom(int roomId) {
        List<Seat> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection()) {
            if (con == null) return list;
            
            list = fetchSeats(con, roomId);

            // 1. Tự động khởi tạo nếu rỗng
            if (list.isEmpty()) {
                int totalSeats = 0;
                try (PreparedStatement psRoom = con.prepareStatement("SELECT total_seats FROM rooms WHERE room_id = ?")) {
                    psRoom.setInt(1, roomId);
                    try (ResultSet rsRoom = psRoom.executeQuery()) {
                        if (rsRoom.next()) totalSeats = rsRoom.getInt("total_seats");
                    }
                }

                if (totalSeats > 0) {
                    String insertSql = "INSERT INTO seats (room_id, seat_row, seat_number, seat_type, is_active) VALUES (?, ?, ?, 'NORMAL', TRUE)";
                    try (PreparedStatement psInsert = con.prepareStatement(insertSql)) {
                        for (int i = 0; i < totalSeats; i++) {
                            char row = (char) ('A' + (i / 10));
                            int num = (i % 10) + 1;
                            psInsert.setInt(1, roomId);
                            psInsert.setString(2, String.valueOf(row));
                            psInsert.setInt(3, num);
                            psInsert.addBatch();
                        }
                        psInsert.executeBatch();
                    }
                    list = fetchSeats(con, roomId);
                }
            }

            // 2. Lọc trùng lặp dữ liệu (đề phòng DB bị nhân đôi ghế)
            List<Seat> uniqueList = new ArrayList<>();
            Set<String> seen = new HashSet<>();
            for (Seat s : list) {
                String key = s.getSeatRow() + "-" + s.getSeatNumber();
                if (!seen.contains(key)) {
                    seen.add(key);
                    uniqueList.add(s);
                }
            }
            list = uniqueList;

            // 3. Ép phân bổ 4:4:2 theo hàng (Để sơ đồ luôn đẹp và nhất quán)
            if (!list.isEmpty()) {
                for (Seat s : list) {
                    String row = String.valueOf(s.getSeatRow()).toUpperCase();
                    // Nếu chưa có cấu hình hoặc đang là NORMAL, ta ép phân loại theo hàng
                    if (row.compareTo("D") <= 0) s.setSeatType(SeatType.NORMAL);
                    else if (row.compareTo("H") <= 0) s.setSeatType(SeatType.VIP);
                    else s.setSeatType(SeatType.COUPLE);
                }
            }
        } catch (Exception e) {
            System.err.println("SeatDAO Error: " + e.getMessage());
        }
        return list;
    }

    private List<Seat> fetchSeats(Connection con, int roomId) throws Exception {
        List<Seat> seats = new ArrayList<>();
        // Sắp xếp an toàn cho nhiều loại DB
        String sql = "SELECT * FROM seats WHERE room_id = ? ORDER BY seat_row, seat_number";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Seat s = new Seat();
                    s.setSeatId(rs.getInt("seat_id"));
                    s.setRoomId(rs.getInt("room_id"));
                    String rsRow = rs.getString("seat_row");
                    s.setSeatRow((rsRow != null && !rsRow.isEmpty()) ? rsRow.toUpperCase().charAt(0) : 'A');
                    s.setSeatNumber(rs.getInt("seat_number"));
                    
                     String typeStr = rs.getString("seat_type");
                     if (typeStr != null) {
                         try { s.setSeatType(SeatType.valueOf(typeStr.trim().toUpperCase())); } 
                         catch (Exception e) { s.setSeatType(SeatType.NORMAL); }
                     } else {
                         s.setSeatType(SeatType.NORMAL);
                     }
                    seats.add(s);
                }
            }
        }
        return seats;
    }

    public Set<Integer> getBookedSeatIds(int showtimeId) {
        Set<Integer> booked = new HashSet<>();
        String sql = """
            SELECT bs.seat_id 
            FROM booking_seats bs 
            JOIN bookings b ON bs.booking_id = b.booking_id 
            WHERE b.showtime_id = ? AND b.status IN ('PAID', 'PENDING')
        """;

        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, showtimeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next())
                    booked.add(rs.getInt("seat_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return booked;
    }
}
