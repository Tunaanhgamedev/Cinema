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
        String sql = "SELECT * FROM movies WHERE movie_id = ?";
        try (Connection cn = DBConnection.getConnection(); 
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, movieId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                return mapResultSetToMovie(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
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
            e.printStackTrace();
            return list;
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
            e.printStackTrace();
            return list;
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
            e.printStackTrace();
            return list;
        }
    }

    private Movie mapResultSetToMovie(ResultSet rs) throws Exception {
        Movie m = new Movie();
        m.setMovieId(rs.getInt("movie_id"));
        m.setTitle(rs.getString("title"));
        m.setDescription(rs.getString("description"));
        m.setDuration(rs.getInt("duration"));
        m.setReleaseDate(rs.getDate("release_date"));
        m.setPoster(rs.getString("poster"));
        m.setGenre(rs.getString("genre"));
        m.setDirector(rs.getString("director"));
        m.setCast(rs.getString("cast"));
        m.setTrailerUrl(rs.getString("trailer_url"));
        
        // Sửa lại cho khớp với table.sql (cột rating)
        String ratingVal = rs.getString("rating");
        m.setRating(ratingVal != null ? Double.parseDouble(ratingVal) : 0.0);
        
        String statusStr = rs.getString("status");
        try {
            m.setStatus(StatusMovie.valueOf(statusStr));
        } catch (Exception e) {
            m.setStatus(StatusMovie.NOW_SHOWING);
        }
        return m;
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
        try (Connection cn = DBConnection.getConnection(); 
             PreparedStatement ps = cn.prepareStatement(sql.toString())) {
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
            e.printStackTrace();
            return list;
        }
    }

    public boolean insert(Movie m) {
        String sql = """
            INSERT INTO movies (title, description, duration, release_date, poster, genre, director, cast, trailer_url, status, rating)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """;
        try (Connection cn = DBConnection.getConnection(); 
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, m.getTitle());
            ps.setString(2, m.getDescription());
            ps.setInt(3, m.getDuration());
            ps.setDate(4, m.getReleaseDate() != null ? new java.sql.Date(m.getReleaseDate().getTime()) : null);
            ps.setString(5, m.getPoster());
            ps.setString(6, m.getGenre());
            ps.setString(7, m.getDirector());
            ps.setString(8, m.getCast());
            ps.setString(9, m.getTrailerUrl());
            ps.setString(10, m.getStatus() != null ? m.getStatus().name() : "NOW_SHOWING");
            ps.setString(11, String.valueOf(m.getRating()));
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(Movie m) {
        String sql = """
            UPDATE movies SET title=?, description=?, duration=?, release_date=?, poster=?, genre=?, director=?, cast=?, trailer_url=?, status=?, rating=?
            WHERE movie_id=?
        """;
        try (Connection cn = DBConnection.getConnection(); 
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, m.getTitle());
            ps.setString(2, m.getDescription());
            ps.setInt(3, m.getDuration());
            ps.setDate(4, m.getReleaseDate() != null ? new java.sql.Date(m.getReleaseDate().getTime()) : null);
            ps.setString(5, m.getPoster());
            ps.setString(6, m.getGenre());
            ps.setString(7, m.getDirector());
            ps.setString(8, m.getCast());
            ps.setString(9, m.getTrailerUrl());
            ps.setString(10, m.getStatus() != null ? m.getStatus().name() : "NOW_SHOWING");
            ps.setString(11, String.valueOf(m.getRating()));
            ps.setInt(12, m.getMovieId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int movieId) {
        String sql = "DELETE FROM movies WHERE movie_id = ?";
        try (Connection cn = DBConnection.getConnection(); 
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, movieId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
