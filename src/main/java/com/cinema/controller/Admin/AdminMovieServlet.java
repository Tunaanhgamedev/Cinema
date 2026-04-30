package com.cinema.controller.Admin;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.dao.MovieDAO;
import com.cinema.enums.StatusMovie;
import com.cinema.model.Movie;

@WebServlet("/admin/movies")
public class AdminMovieServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final MovieDAO movieDAO = new MovieDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<Movie> movies = movieDAO.findAll();
		req.setAttribute("movieList", movies);
		req.getRequestDispatcher("/pages/admin/movie-manage.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		try {
			if ("add".equals(action)) {
				Movie m = buildMovieFromRequest(req);
				movieDAO.insert(m);
			} else if ("update".equals(action)) {
				Movie m = buildMovieFromRequest(req);
				String movieIdStr = req.getParameter("movieId");
				if (movieIdStr != null && !movieIdStr.isEmpty()) {
					m.setMovieId(Integer.parseInt(movieIdStr));
					movieDAO.update(m);
				}
			} else if ("delete".equals(action)) {
				String movieIdStr = req.getParameter("movieId");
				if (movieIdStr != null && !movieIdStr.isEmpty()) {
					movieDAO.delete(Integer.parseInt(movieIdStr));
				}
			}
			resp.sendRedirect(req.getContextPath() + "/admin/movies");
		} catch (Exception e) {
			req.setAttribute("error", "Lỗi thao tác: " + e.getMessage());
			req.setAttribute("movieList", movieDAO.findAll());
			req.getRequestDispatcher("/pages/admin/movie-manage.jsp").forward(req, resp);
		}
	}

	private Movie buildMovieFromRequest(HttpServletRequest req) {
		Movie m = new Movie();
		m.setTitle(req.getParameter("title"));
		m.setDescription(req.getParameter("description"));
		
		String durationStr = req.getParameter("duration");
		m.setDuration(durationStr != null && !durationStr.isEmpty() ? Integer.parseInt(durationStr) : 0);
		
		String releaseDateStr = req.getParameter("releaseDate");
		if (releaseDateStr != null && !releaseDateStr.isEmpty()) {
			m.setReleaseDate(Date.valueOf(releaseDateStr));
		}
		
		String ratingStr = req.getParameter("rating");
		m.setRating(ratingStr != null && !ratingStr.isEmpty() ? Double.parseDouble(ratingStr) : 0.0);
		
		m.setPoster(req.getParameter("poster"));
		m.setGenre(req.getParameter("genre"));
		m.setTrailerUrl(req.getParameter("trailerUrl"));
		
		String statusStr = req.getParameter("status");
		if (statusStr != null) {
			m.setStatus(StatusMovie.valueOf(statusStr));
		}
		
		return m;
	}
}
