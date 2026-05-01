package com.cinema.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
		String sql = "SELECT s.showtime_id, s.movie_id, s.room_id, s.start_time, s.end_time, s.price, "
				+ "       m.title AS movie_name, r.room_name AS room_name " + "FROM showtimes s "
				+ "JOIN movies m ON s.movie_id = m.movie_id " + "JOIN rooms r ON s.room_id = r.room_id "
				+ "ORDER BY s.start_time DESC";

		List<ShowtimeView> list = new ArrayList<>();

		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				ShowtimeView st = new ShowtimeView();
				st.setShowtimeId(rs.getInt("showtime_id"));
				st.setMovieId(rs.getInt("movie_id"));
				st.setRoomId(rs.getInt("room_id"));
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
		String sql = "INSERT INTO showtimes(movie_id, room_id, start_time, end_time, price) VALUES (?,?,?,?,?)";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, st.getMovieId());
			ps.setInt(2, st.getRoomId());
			ps.setTimestamp(3, st.getStartTime());
			ps.setTimestamp(4, st.getEndTime());
			ps.setBigDecimal(5, st.getPrice() == null ? BigDecimal.ZERO : st.getPrice());

			return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("ShowtimeDAO.insert error: " + e.getMessage(), e);
        }
    }

	public boolean update(Showtime st) {
		String sql = "UPDATE showtimes SET movie_id=?, room_id=?, start_time=?, end_time=?, price=? WHERE showtime_id=?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, st.getMovieId());
			ps.setInt(2, st.getRoomId());
			ps.setTimestamp(3, st.getStartTime());
			ps.setTimestamp(4, st.getEndTime());
			ps.setBigDecimal(5, st.getPrice() == null ? BigDecimal.ZERO : st.getPrice());
			ps.setInt(6, st.getShowtimeId());

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
				    SELECT s.showtime_id, s.movie_id, s.room_id, s.start_time, s.end_time, s.price,
				           m.title AS movie_name, r.room_name AS room_name
				    FROM showtimes s
				    JOIN movies m ON s.movie_id = m.movie_id
				    JOIN rooms  r ON s.room_id  = r.room_id
				    WHERE s.movie_id = ?
				      AND s.start_time >= ? 
				      AND s.start_time < DATE_ADD(?, INTERVAL 1 DAY)
				    ORDER BY s.start_time ASC
				""";

		List<ShowtimeView> list = new ArrayList<>();

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, movieId);
			ps.setString(2, showDate + " 00:00:00");
			ps.setString(3, showDate + " 00:00:00");

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					ShowtimeView st = new ShowtimeView();
					st.setShowtimeId(rs.getInt("showtime_id"));
					st.setMovieId(rs.getInt("movie_id"));
					st.setRoomId(rs.getInt("room_id"));
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
				    WHERE DATE(s.start_time) = ?
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
				    SELECT DISTINCT DATE(start_time) as show_date
				    FROM showtimes
				    WHERE movie_id = ?
				    ORDER BY show_date ASC
				""";
		List<String> list = new ArrayList<>();
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, movieId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					list.add(rs.getString("show_date"));
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("ShowtimeDAO.getDistinctDatesByMovie error", e);
		}
		return list;
	}
}
