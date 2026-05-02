package com.cinema.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.cinema.enums.StatusMovie;
import com.cinema.model.Movie;
import com.cinema.utils.DBConnection;

public class MovieDAO {

	private Set<String> getExistingColumns() {
		Set<String> columns = new HashSet<>();
		try (Connection cn = DBConnection.getConnection();
				ResultSet rs = cn.getMetaData().getColumns(null, null, "movies", null)) {
			while (rs.next()) {
				columns.add(rs.getString("COLUMN_NAME").toLowerCase());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return columns;
	}

	public Movie findById(int movieId) {
		String sql = "SELECT * FROM movies WHERE movie_id = ?";
		try (Connection cn = DBConnection.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
			ps.setInt(1, movieId);
			try (ResultSet rs = ps.executeQuery()) {
				if (!rs.next()) return null;
				return mapResultSetToMovie(rs);
			}
		} catch (Exception e) {
			throw new RuntimeException("MovieDAO.findById failed: " + e.getMessage(), e);
		}
	}

	public List<Movie> findAll() {
		String sql = "SELECT * FROM movies ORDER BY release_date DESC";
		List<Movie> list = new ArrayList<>();
		try (Connection cn = DBConnection.getConnection();
				PreparedStatement ps = cn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				list.add(mapResultSetToMovie(rs));
			}
			return list;
		} catch (Exception e) {
			throw new RuntimeException("MovieDAO.findAll failed: " + e.getMessage(), e);
		}
	}

	public List<Movie> findNowShowing() {
		String sql = "SELECT * FROM movies WHERE status = 'NOW_SHOWING' ORDER BY release_date DESC";
		List<Movie> list = new ArrayList<>();
		try (Connection cn = DBConnection.getConnection();
				PreparedStatement ps = cn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				list.add(mapResultSetToMovie(rs));
			}
			return list;
		} catch (Exception e) {
			throw new RuntimeException("MovieDAO.findNowShowing failed: " + e.getMessage(), e);
		}
	}

	public List<Movie> findComingSoon() {
		String sql = "SELECT * FROM movies WHERE status = 'COMING_SOON' ORDER BY release_date ASC";
		List<Movie> list = new ArrayList<>();
		try (Connection cn = DBConnection.getConnection();
				PreparedStatement ps = cn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				list.add(mapResultSetToMovie(rs));
			}
			return list;
		} catch (Exception e) {
			throw new RuntimeException("MovieDAO.findComingSoon failed: " + e.getMessage(), e);
		}
	}

	public int countTotalMovies() {
		String sql = "SELECT COUNT(*) FROM movies";
		try (Connection cn = DBConnection.getConnection();
				PreparedStatement ps = cn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next()) return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	private Movie mapResultSetToMovie(ResultSet rs) throws Exception {
		Movie m = new Movie();
		m.setMovieId(rs.getInt("movie_id"));
		m.setTitle(rs.getString("title"));
		m.setDescription(rs.getString("description"));
		m.setDuration(rs.getInt("duration"));
		m.setReleaseDate(rs.getDate("release_date"));
		m.setPoster(rs.getString("poster"));
		
		ResultSetMetaData rsmd = rs.getMetaData();
		Set<String> cols = new HashSet<>();
		for (int i = 1; i <= rsmd.getColumnCount(); i++) cols.add(rsmd.getColumnName(i).toLowerCase());

		if (cols.contains("genre")) m.setGenre(rs.getString("genre"));
		if (cols.contains("trailer_url")) m.setTrailerUrl(rs.getString("trailer_url"));
		if (cols.contains("director")) m.setDirector(rs.getString("director"));
		if (cols.contains("cast")) m.setCast(rs.getString("cast"));
		
		String ratingStr = rs.getString("rating");
		m.setRating(parseDoubleSafe(ratingStr));
		m.setStatus(toStatus(rs.getString("status")));
		return m;
	}

	private static StatusMovie toStatus(String dbValue) {
		if (dbValue == null) return null;
		try {
			return StatusMovie.valueOf(dbValue);
		} catch (Exception e) {
			return StatusMovie.NOW_SHOWING;
		}
	}

	private static double parseDoubleSafe(String s) {
		if (s == null) return 0.0;
		try {
			return Double.parseDouble(s.trim());
		} catch (Exception e) {
			return 0.0;
		}
	}

	public boolean insert(Movie m) {
		Set<String> existingCols = getExistingColumns();
		StringBuilder sql = new StringBuilder("INSERT INTO movies (title, description, duration, release_date, rating, poster, status");
		StringBuilder values = new StringBuilder("VALUES (?,?,?,?,?,?,?");
		
		boolean hasGenre = existingCols.contains("genre");
		boolean hasTrailer = existingCols.contains("trailer_url");
		
		if (hasGenre) { sql.append(", genre"); values.append(",?"); }
		if (hasTrailer) { sql.append(", trailer_url"); values.append(",?"); }
		
		sql.append(") ").append(values).append(")");
		
		try (Connection cn = DBConnection.getConnection(); PreparedStatement ps = cn.prepareStatement(sql.toString())) {
			int paramIdx = 1;
			ps.setString(paramIdx++, m.getTitle());
			ps.setString(paramIdx++, m.getDescription());
			ps.setInt(paramIdx++, m.getDuration());
			ps.setDate(paramIdx++, m.getReleaseDate() != null ? new java.sql.Date(m.getReleaseDate().getTime()) : null);
			ps.setString(paramIdx++, String.valueOf(m.getRating()));
			ps.setString(paramIdx++, m.getPoster());
			ps.setString(paramIdx++, m.getStatus() != null ? m.getStatus().name() : "NOW_SHOWING");
			
			if (hasGenre) ps.setString(paramIdx++, m.getGenre());
			if (hasTrailer) ps.setString(paramIdx++, m.getTrailerUrl());
			
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			throw new RuntimeException("MovieDAO.insert failed: " + e.getMessage(), e);
		}
	}

	public boolean update(Movie m) {
		Set<String> existingCols = getExistingColumns();
		StringBuilder sql = new StringBuilder("UPDATE movies SET title=?, description=?, duration=?, release_date=?, rating=?, poster=?, status=?");
		
		boolean hasGenre = existingCols.contains("genre");
		boolean hasTrailer = existingCols.contains("trailer_url");
		
		if (hasGenre) sql.append(", genre=?");
		if (hasTrailer) sql.append(", trailer_url=?");
		
		sql.append(" WHERE movie_id=?");
		
		try (Connection cn = DBConnection.getConnection(); PreparedStatement ps = cn.prepareStatement(sql.toString())) {
			int paramIdx = 1;
			ps.setString(paramIdx++, m.getTitle());
			ps.setString(paramIdx++, m.getDescription());
			ps.setInt(paramIdx++, m.getDuration());
			ps.setDate(paramIdx++, m.getReleaseDate() != null ? new java.sql.Date(m.getReleaseDate().getTime()) : null);
			ps.setString(paramIdx++, String.valueOf(m.getRating()));
			ps.setString(paramIdx++, m.getPoster());
			ps.setString(paramIdx++, m.getStatus() != null ? m.getStatus().name() : "NOW_SHOWING");
			
			if (hasGenre) ps.setString(paramIdx++, m.getGenre());
			if (hasTrailer) ps.setString(paramIdx++, m.getTrailerUrl());
			
			ps.setInt(paramIdx++, m.getMovieId());
			
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			throw new RuntimeException("MovieDAO.update failed: " + e.getMessage(), e);
		}
	}

	public List<Movie> findAllWithFilters(String keyword, String sort) {
		StringBuilder sql = new StringBuilder("SELECT * FROM movies WHERE 1=1 ");
		if (keyword != null && !keyword.trim().isEmpty()) {
			sql.append(" AND title LIKE ? ");
		}

		if ("newest".equals(sort)) {
			sql.append(" ORDER BY release_date DESC ");
		} else if ("oldest".equals(sort)) {
			sql.append(" ORDER BY release_date ASC ");
		} else if ("alphabetical".equals(sort)) {
			sql.append(" ORDER BY title ASC ");
		} else {
			sql.append(" ORDER BY release_date DESC ");
		}

		List<Movie> list = new ArrayList<>();
		try (Connection cn = DBConnection.getConnection(); PreparedStatement ps = cn.prepareStatement(sql.toString())) {
			if (keyword != null && !keyword.trim().isEmpty()) {
				ps.setString(1, "%" + keyword + "%");
			}
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					list.add(mapResultSetToMovie(rs));
				}
			}
			return list;
		} catch (Exception e) {
			throw new RuntimeException("MovieDAO.findAllWithFilters failed: " + e.getMessage(), e);
		}
	}

	public boolean delete(int movieId) {
		String sql = "DELETE FROM movies WHERE movie_id = ?";
		try (Connection cn = DBConnection.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
			ps.setInt(1, movieId);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			throw new RuntimeException("MovieDAO.delete failed: " + e.getMessage(), e);
		}
	}
}
