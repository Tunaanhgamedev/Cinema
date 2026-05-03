package com.cinema.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.cinema.model.Showtime;
import com.cinema.utils.DBConnection;

public class ShowtimeDAO {

    public static class ShowtimeView extends Showtime {
        private String movieName;
        private String roomName;

        public String getMovieName() { return movieName; }
        public void setMovieName(String movieName) { this.movieName = movieName; }
        public String getRoomName() { return roomName; }
        public void setRoomName(String roomName) { this.roomName = roomName; }
    }

    public List<ShowtimeView> getAll() {
        String sql = """
            SELECT s.showtime_id, s.movie_id, s.room_id, 
                   COALESCE(s.show_date, DATE(s.start_time)) as show_date, 
                   s.start_time, s.end_time, s.price,
                   m.title AS movie_name, r.room_name AS room_name
            FROM showtimes s
            JOIN movies m ON s.movie_id = m.movie_id
            JOIN rooms r ON s.room_id = r.room_id
            ORDER BY s.show_date DESC, s.start_time ASC
        """;
        List<ShowtimeView> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ShowtimeView st = mapRowToView(rs);
                list.add(st);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Showtime findShowtimeById(int showtimeId) {
        String sql = "SELECT *, COALESCE(show_date, DATE(start_time)) as actual_show_date FROM showtimes WHERE showtime_id = ?";
        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, showtimeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Showtime st = new Showtime();
                    st.setShowtimeId(rs.getInt("showtime_id"));
                    st.setMovieId(rs.getInt("movie_id"));
                    st.setRoomId(rs.getInt("room_id"));
                    st.setShowDate(rs.getDate("actual_show_date"));
                    st.setStartTime(rs.getTimestamp("start_time"));
                    st.setEndTime(rs.getTimestamp("end_time"));
                    st.setPrice(rs.getBigDecimal("price"));
                    return st;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public ShowtimeView findShowtimeViewById(int showtimeId) {
        String sql = """
            SELECT s.*, COALESCE(s.show_date, DATE(s.start_time)) as actual_show_date, 
                   m.title AS movie_name, r.room_name AS room_name
            FROM showtimes s
            JOIN movies m ON s.movie_id = m.movie_id
            JOIN rooms r ON s.room_id = r.room_id
            WHERE s.showtime_id = ?
        """;
        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, showtimeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToView(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private ShowtimeView mapRowToView(ResultSet rs) throws SQLException {
        ShowtimeView st = new ShowtimeView();
        st.setShowtimeId(rs.getInt("showtime_id"));
        st.setMovieId(rs.getInt("movie_id"));
        st.setRoomId(rs.getInt("room_id"));
        
        // Handle potential naming difference for the actual date
        java.sql.Date d = null;
        try { d = rs.getDate("actual_show_date"); } catch (Exception e) { d = rs.getDate("show_date"); }
        st.setShowDate(d);
        
        st.setStartTime(rs.getTimestamp("start_time"));
        st.setEndTime(rs.getTimestamp("end_time"));
        st.setPrice(rs.getBigDecimal("price"));
        st.setMovieName(rs.getString("movie_name"));
        st.setRoomName(rs.getString("room_name"));
        return st;
    }

    public boolean insert(Showtime st) {
        String sql = "INSERT INTO showtimes(movie_id, room_id, show_date, start_time, end_time, price) VALUES (?,?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, st.getMovieId());
            ps.setInt(2, st.getRoomId());
            java.sql.Date sqlDate = (st.getShowDate() != null) ? st.getShowDate() : 
                                    ((st.getStartTime() != null) ? new java.sql.Date(st.getStartTime().getTime()) : null);
            ps.setDate(3, sqlDate);
            ps.setTimestamp(4, st.getStartTime());
            ps.setTimestamp(5, st.getEndTime());
            ps.setBigDecimal(6, st.getPrice() != null ? st.getPrice() : BigDecimal.ZERO);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(Showtime st) {
        String sql = "UPDATE showtimes SET movie_id=?, room_id=?, show_date=?, start_time=?, end_time=?, price=? WHERE showtime_id=?";
        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, st.getMovieId());
            ps.setInt(2, st.getRoomId());
            java.sql.Date sqlDate = (st.getShowDate() != null) ? st.getShowDate() : 
                                    ((st.getStartTime() != null) ? new java.sql.Date(st.getStartTime().getTime()) : null);
            ps.setDate(3, sqlDate);
            ps.setTimestamp(4, st.getStartTime());
            ps.setTimestamp(5, st.getEndTime());
            ps.setBigDecimal(6, st.getPrice() != null ? st.getPrice() : BigDecimal.ZERO);
            ps.setInt(7, st.getShowtimeId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int showtimeId) {
        String sql = "DELETE FROM showtimes WHERE showtime_id=?";
        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, showtimeId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<ShowtimeView> findByMovieAndDate(int movieId, String showDate) {
        String sql = """
            SELECT s.*, COALESCE(s.show_date, DATE(s.start_time)) as actual_show_date,
                   m.title AS movie_name, r.room_name AS room_name
            FROM showtimes s
            JOIN movies m ON s.movie_id = m.movie_id
            JOIN rooms r ON s.room_id = r.room_id
            WHERE s.movie_id = ? AND COALESCE(s.show_date, DATE(s.start_time)) = ?
            ORDER BY s.start_time ASC
        """;
        List<ShowtimeView> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, movieId);
            ps.setString(2, showDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRowToView(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int findRoomIdByShowtime(int showtimeId) {
        String sql = "SELECT room_id FROM showtimes WHERE showtime_id = ?";
        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, showtimeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("room_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<java.sql.Date> getAvailableDates() {
        List<java.sql.Date> list = new ArrayList<>();
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.set(java.util.Calendar.HOUR_OF_DAY, 0);
        cal.set(java.util.Calendar.MINUTE, 0);
        cal.set(java.util.Calendar.SECOND, 0);
        cal.set(java.util.Calendar.MILLISECOND, 0);

        for (int i = 0; i < 7; i++) {
            list.add(new java.sql.Date(cal.getTimeInMillis()));
            cal.add(java.util.Calendar.DAY_OF_MONTH, 1);
        }
        return list;
    }

    public List<com.cinema.model.Movie> getMoviesWithShowtimes(String date, String keyword, String sort) {
        StringBuilder sql = new StringBuilder("""
            SELECT m.movie_id, m.title, m.poster, m.duration, m.genre, m.rating_avg, m.release_date, m.status, 
                   COUNT(b.booking_id) as booking_count
            FROM movies m
            JOIN showtimes s ON m.movie_id = s.movie_id
            LEFT JOIN bookings b ON s.showtime_id = b.showtime_id
            WHERE COALESCE(s.show_date, DATE(s.start_time)) = ?
        """);

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND m.title LIKE ? ");
        }
        
        sql.append(" GROUP BY m.movie_id, m.title, m.poster, m.duration, m.genre, m.rating_avg, m.release_date, m.status ");

        if ("newest".equals(sort)) sql.append(" ORDER BY m.release_date DESC ");
        else if ("oldest".equals(sort)) sql.append(" ORDER BY m.release_date ASC ");
        else if ("alphabetical".equals(sort)) sql.append(" ORDER BY m.title ASC ");
        else if ("hot".equals(sort)) sql.append(" ORDER BY booking_count DESC ");
        else sql.append(" ORDER BY m.release_date DESC ");

        List<com.cinema.model.Movie> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            ps.setString(1, date);
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(2, "%" + keyword + "%");
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    com.cinema.model.Movie m = new com.cinema.model.Movie();
                    m.setMovieId(rs.getInt("movie_id"));
                    m.setTitle(rs.getString("title"));
                    m.setPoster(rs.getString("poster"));
                    m.setDuration(rs.getInt("duration"));
                    m.setGenre(rs.getString("genre"));
                    m.setRating(rs.getDouble("rating_avg"));
                    m.setReleaseDate(rs.getDate("release_date"));
                    try {
                        m.setStatus(com.cinema.enums.StatusMovie.valueOf(rs.getString("status")));
                    } catch (Exception e) {
                        m.setStatus(com.cinema.enums.StatusMovie.NOW_SHOWING);
                    }
                    list.add(m);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<java.sql.Date> getDistinctDatesByMovie(int movieId) {
        String sql = "SELECT DISTINCT COALESCE(show_date, DATE(start_time)) as actual_show_date FROM showtimes WHERE movie_id = ? AND start_time >= NOW() ORDER BY actual_show_date ASC";
        List<java.sql.Date> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, movieId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getDate("actual_show_date"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
