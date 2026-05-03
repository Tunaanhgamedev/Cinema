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
        String sql = "SELECT * FROM seats WHERE room_id = ? AND is_active = TRUE ORDER BY seat_row, seat_number";

        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            Set<String> seenSeats = new HashSet<>();
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String row = rs.getString("seat_row");
                    int number = rs.getInt("seat_number");
                    String key = row + "-" + number;

                    if (seenSeats.contains(key)) continue;
                    seenSeats.add(key);

                    Seat s = new Seat();
                    s.setSeatId(rs.getInt("seat_id"));
                    s.setRoomId(rs.getInt("room_id"));
                    s.setSeatRow((row != null && !row.isEmpty()) ? row.charAt(0) : 'A');
                    s.setSeatNumber(number);

                    String type = rs.getString("seat_type");
                    try {
                        s.setSeatType(SeatType.valueOf(type));
                    } catch (Exception e) {
                        s.setSeatType(SeatType.STANDARD);
                    }
                    
                    s.setGridRow(rs.getInt("grid_row"));
                    s.setGridCol(rs.getInt("grid_col"));
                    list.add(s);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
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
