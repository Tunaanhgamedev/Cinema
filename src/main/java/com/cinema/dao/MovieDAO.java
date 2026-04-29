package com.cinema.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cinema.enums.StatusMovie;
import com.cinema.model.Movie;
import com.cinema.utils.DBConnection;

public class MovieDAO {

	public Movie findById(int movieId) {
		String sql = "SELECT movie_id, title, description, duration, release_date, rating, poster, status "
				+ "FROM movies WHERE movie_id = ?";

		try (Connection cn = DBConnection.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {

			ps.setInt(1, movieId);

			try (ResultSet rs = ps.executeQuery()) {
				if (!rs.next())
					return null;

				Movie m = new Movie();
				m.setMovieId(rs.getInt("movie_id"));
				m.setTitle(rs.getString("title"));
				m.setDescription(rs.getString("description"));
				m.setDuration(rs.getInt("duration"));
				m.setReleaseDate(rs.getDate("release_date"));
				m.setPoster(rs.getString("poster"));

				// rating DB đang varchar(10) -> cố parse double nếu được
				String ratingStr = rs.getString("rating");
				m.setRating(parseDoubleSafe(ratingStr));

				// enum mapping
				String st = rs.getString("status");
				m.setStatus(toStatus(st));

				// các field chưa có trong DB sẽ để null: director/cast/genre/trailerUrl
				return m;
			}
		} catch (Exception e) {
			throw new RuntimeException("MovieDAO.findById failed", e);
		}
	}

	public List<Movie> findAll() {
		String sql = "SELECT movie_id, title, description, duration, release_date, rating, poster, status "
				+ "FROM movies ORDER BY release_date DESC";

		List<Movie> list = new ArrayList<>();
		try (Connection cn = DBConnection.getConnection();
				PreparedStatement ps = cn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Movie m = new Movie();
				m.setMovieId(rs.getInt("movie_id"));
				m.setTitle(rs.getString("title"));
				m.setDescription(rs.getString("description"));
				m.setDuration(rs.getInt("duration"));
				m.setReleaseDate(rs.getDate("release_date"));
				m.setPoster(rs.getString("poster"));

				String ratingStr = rs.getString("rating");
				m.setRating(parseDoubleSafe(ratingStr));

				m.setStatus(toStatus(rs.getString("status")));
				list.add(m);
			}
			return list;
		} catch (Exception e) {
			throw new RuntimeException("MovieDAO.findAll failed", e);
		}
	}

	private static StatusMovie toStatus(String dbValue) {
		if (dbValue == null)
			return null;
		try {
			return StatusMovie.valueOf(dbValue);
		} catch (Exception e) {
			return null;
		}
	}

	private static double parseDoubleSafe(String s) {
		if (s == null)
			return 0.0;
		try {
			return Double.parseDouble(s.trim());
		} catch (Exception e) {
			return 0.0;
		}
	}

	public List<Movie> findNowShowing() {
		String sql = "SELECT movie_id, title, description, duration, release_date, rating, poster, status "
				+ "FROM movies " + "WHERE status = 'NOW_SHOWING' " + "ORDER BY release_date DESC";

		List<Movie> list = new ArrayList<>();
		try (Connection cn = DBConnection.getConnection();
				PreparedStatement ps = cn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Movie m = new Movie();
				m.setMovieId(rs.getInt("movie_id"));
				m.setTitle(rs.getString("title"));
				m.setDescription(rs.getString("description"));
				m.setDuration(rs.getInt("duration"));
				m.setReleaseDate(rs.getDate("release_date"));
				m.setPoster(rs.getString("poster"));

				String ratingStr = rs.getString("rating");
				m.setRating(parseDoubleSafe(ratingStr));

				m.setStatus(toStatus(rs.getString("status")));
				list.add(m);
			}
			return list;

		} catch (Exception e) {
			throw new RuntimeException("MovieDAO.findNowShowing failed", e);
		}
	}

	public int countTotalMovies() {
		String sql = "SELECT COUNT(*) FROM movies";
		try (Connection cn = DBConnection.getConnection();
				PreparedStatement ps = cn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next())
				return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public boolean insert(Movie m) {
		String sql = "INSERT INTO movies (title, description, duration, release_date, rating, poster, status) VALUES (?,?,?,?,?,?,?)";
		try (Connection cn = DBConnection.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
			ps.setString(1, m.getTitle());
			ps.setString(2, m.getDescription());
			ps.setInt(3, m.getDuration());

			if (m.getReleaseDate() != null) {
				ps.setDate(4, new java.sql.Date(m.getReleaseDate().getTime()));
			} else {
				ps.setNull(4, java.sql.Types.DATE);
			}

			ps.setString(5, String.valueOf(m.getRating()));
			ps.setString(6, m.getPoster());
			ps.setString(7, m.getStatus() != null ? m.getStatus().name() : "NOW_SHOWING");
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean update(Movie m) {
		String sql = "UPDATE movies SET title=?, description=?, duration=?, release_date=?, rating=?, poster=?, status=? WHERE movie_id=?";
		try (Connection cn = DBConnection.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
			ps.setString(1, m.getTitle());
			ps.setString(2, m.getDescription());
			ps.setInt(3, m.getDuration());

			if (m.getReleaseDate() != null) {
				ps.setDate(4, new java.sql.Date(m.getReleaseDate().getTime()));
			} else {
				ps.setNull(4, java.sql.Types.DATE);
			}

			ps.setString(5, String.valueOf(m.getRating()));
			ps.setString(6, m.getPoster());
			ps.setString(7, m.getStatus() != null ? m.getStatus().name() : "NOW_SHOWING");
			ps.setInt(8, m.getMovieId());
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean delete(int movieId) {
		String sql = "DELETE FROM movies WHERE movie_id = ?";
		try (Connection cn = DBConnection.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
			ps.setInt(1, movieId);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

}
