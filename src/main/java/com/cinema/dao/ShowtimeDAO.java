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

	// DTO để hiển thị ở admin (có thêm tên movie/room)
	public static class ShowtimeView extends Showtime {
		private String movieName;
		private String roomName;

		public String getMovieName() {
			return movieName;
		}

		public void setMovieName(String movieName) {
			this.movieName = movieName;
		}

		public String getRoomName() {
			return roomName;
		}

		public void setRoomName(String roomName) {
			this.roomName = roomName;
		}
	}

	// Lấy danh sách showtime (join movies, rooms để lấy tên)
	public List<ShowtimeView> getAll() {
		String sql = "SELECT s.showtime_id, s.movie_id, s.room_id, s.show_date, s.start_time, s.end_time, s.price, "
				+ "       m.title AS movie_name, r.room_name AS room_name " + "FROM showtimes s "
				+ "JOIN movies m ON s.movie_id = m.movie_id " + "JOIN rooms r ON s.room_id = r.room_id "
				+ "ORDER BY s.show_date DESC, s.start_time ASC";

		List<ShowtimeView> list = new ArrayList<>();

		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				ShowtimeView st = new ShowtimeView();
				st.setShowtimeId(rs.getInt("showtime_id"));
				st.setMovieId(rs.getInt("movie_id"));
				st.setRoomId(rs.getInt("room_id"));
				// Lưu ý: Nếu Showtime model chưa có field showDate, hãy bỏ qua dòng dưới hoặc update model
				// st.setShowDate(rs.getDate("show_date")); 
				st.setStartTime(rs.getTimestamp("start_time"));
				st.setEndTime(rs.getTimestamp("end_time"));
				st.setPrice(rs.getBigDecimal("price"));

				st.setMovieName(rs.getString("movie_name"));
				st.setRoomName(rs.getString("room_name"));

				list.add(st);
			}
		} catch (SQLException e) {
			throw new RuntimeException("ShowtimeDAO.getAll error", e);
		}

		return list;
	}

	public boolean insert(Showtime st) {
		String sql = "INSERT INTO showtimes(movie_id, room_id, show_date, start_time, end_time, price) VALUES (?,?,?,?,?,?)";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, st.getMovieId());
			ps.setInt(2, st.getRoomId());
			// Tự động lấy ngày từ start_time nếu show_date null
			java.sql.Date sqlDate = (st.getStartTime() != null) ? new java.sql.Date(st.getStartTime().getTime()) : null;
			ps.setDate(3, sqlDate); 
			ps.setTimestamp(4, st.getStartTime());
			ps.setTimestamp(5, st.getEndTime());
			ps.setBigDecimal(6, st.getPrice() == null ? BigDecimal.ZERO : st.getPrice());

			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			throw new RuntimeException("ShowtimeDAO.insert error: " + e.getMessage(), e);
		}
	}

	public boolean update(Showtime st) {
		String sql = "UPDATE showtimes SET movie_id=?, room_id=?, show_date=?, start_time=?, end_time=?, price=? WHERE showtime_id=?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, st.getMovieId());
			ps.setInt(2, st.getRoomId());
			// Tự động cập nhật show_date từ start_time
			java.sql.Date sqlDate = (st.getStartTime() != null) ? new java.sql.Date(st.getStartTime().getTime()) : null;
			ps.setDate(3, sqlDate);
			ps.setTimestamp(4, st.getStartTime());
			ps.setTimestamp(5, st.getEndTime());
			ps.setBigDecimal(6, st.getPrice() == null ? BigDecimal.ZERO : st.getPrice());
			ps.setInt(7, st.getShowtimeId());

			return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("ShowtimeDAO.update error: " + e.getMessage(), e);
        }
    }

	public boolean delete(int showtimeId) {
		String sql = "DELETE FROM showtimes WHERE showtime_id=?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, showtimeId);
			return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("ShowtimeDAO.delete error: " + e.getMessage(), e);
        }
    }

	// USER: lấy suất chiếu theo movie + ngày (yyyy-MM-dd)
	// USER: lấy suất chiếu theo movie + ngày (yyyy-MM-dd)
	public List<ShowtimeView> findByMovieAndDate(int movieId, String showDate) {
		String sql = """
				    SELECT s.showtime_id, s.movie_id, s.room_id, s.show_date, s.start_time, s.end_time, s.price,
				           m.title AS movie_name, r.room_name AS room_name
				    FROM showtimes s
				    JOIN movies m ON s.movie_id = m.movie_id
				    JOIN rooms  r ON s.room_id  = r.room_id
				    WHERE s.movie_id = ?
				      AND s.show_date = ?
				    ORDER BY s.start_time ASC
				""";

		List<ShowtimeView> list = new ArrayList<>();

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, movieId);
			ps.setString(2, showDate);

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					ShowtimeView st = new ShowtimeView();
					st.setShowtimeId(rs.getInt("showtime_id"));
					st.setMovieId(rs.getInt("movie_id"));
					st.setRoomId(rs.getInt("room_id"));
					st.setShowDate(rs.getDate("show_date"));
					st.setStartTime(rs.getTimestamp("start_time"));
					st.setEndTime(rs.getTimestamp("end_time"));
					st.setPrice(rs.getBigDecimal("price"));

					st.setMovieName(rs.getString("movie_name"));
					st.setRoomName(rs.getString("room_name"));
					list.add(st);
				}
			}

		} catch (SQLException e) {
			throw new RuntimeException("ShowtimeDAO.findByMovieAndDate error", e);
		}
		return list;
	}

	public int findRoomIdByShowtime(int showtimeId) {
		String sql = "SELECT room_id FROM showtimes WHERE showtime_id = ?";
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, showtimeId);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				return rs.getInt("room_id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public List<com.cinema.model.Movie> getDistinctMoviesByDate(String showDate) {
		String sql = """
				    SELECT DISTINCT m.*
				    FROM movies m
				    JOIN showtimes s ON m.movie_id = s.movie_id
				    WHERE s.show_date = ?
				    ORDER BY m.title ASC
				""";
		List<com.cinema.model.Movie> list = new ArrayList<>();
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, showDate);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					com.cinema.model.Movie m = new com.cinema.model.Movie();
					m.setMovieId(rs.getInt("movie_id"));
					m.setTitle(rs.getString("title"));
					m.setPoster(rs.getString("poster"));
					m.setDuration(rs.getInt("duration"));
					m.setGenre(rs.getString("genre"));
					list.add(m);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("ShowtimeDAO.getDistinctMoviesByDate error", e);
		}
		return list;
	}

	public List<String> getDistinctDatesByMovie(int movieId) {
		String sql = """
				    SELECT DISTINCT show_date
				    FROM showtimes
				    WHERE movie_id = ?
				    ORDER BY show_date ASC
				""";
		List<String> list = new ArrayList<>();
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, movieId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					String dateStr = rs.getString("show_date");
					if (dateStr != null) {
						list.add(dateStr);
					}
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("ShowtimeDAO.getDistinctDatesByMovie error: " + e.getMessage(), e);
		}
		return list;
	}

	public boolean isOverlap(int roomId, Timestamp start, Timestamp end, Integer excludeId) {
		String sql = "SELECT COUNT(*) FROM showtimes WHERE room_id = ? AND start_time < ? AND end_time > ?";
		if (excludeId != null) {
			sql += " AND showtime_id <> " + excludeId;
		}

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, roomId);
			ps.setTimestamp(2, end);
			ps.setTimestamp(3, start);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next())
					return rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	// Lấy danh sách các ngày duy nhất có suất chiếu (để hiển thị thanh chọn ngày)
	public List<java.sql.Date> getAvailableDates() {
		List<java.sql.Date> list = new ArrayList<>();
		String sql = "SELECT DISTINCT CAST(show_date AS DATE) as sdate FROM showtimes WHERE show_date >= CURDATE() ORDER BY sdate ASC LIMIT 10";
		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				list.add(rs.getDate("sdate"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<com.cinema.model.Movie> getMoviesWithShowtimes(String date, String keyword, String sort) {
		StringBuilder sql = new StringBuilder("""
				    SELECT m.*, COUNT(b.booking_id) as booking_count
				    FROM movies m
				    JOIN showtimes s ON m.movie_id = s.movie_id
				    LEFT JOIN bookings b ON s.showtime_id = b.showtime_id
				    WHERE s.show_date = ?
				""");

		if (keyword != null && !keyword.trim().isEmpty()) {
			sql.append(" AND m.title LIKE ? ");
		}
		
		sql.append(" GROUP BY m.movie_id ");

		if ("newest".equals(sort)) {
			sql.append(" ORDER BY m.release_date DESC ");
		} else if ("oldest".equals(sort)) {
			sql.append(" ORDER BY m.release_date ASC ");
		} else if ("alphabetical".equals(sort)) {
			sql.append(" ORDER BY m.title ASC ");
		} else if ("hot".equals(sort)) {
			sql.append(" ORDER BY booking_count DESC ");
		} else {
			sql.append(" ORDER BY m.release_date DESC "); // Mặc định mới nhất
		}

		List<com.cinema.model.Movie> list = new ArrayList<>();
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql.toString())) {
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
					m.setReleaseDate(rs.getDate("release_date"));
					list.add(m);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("ShowtimeDAO.getMoviesWithShowtimes error", e);
		}
		return list;
	}
}
