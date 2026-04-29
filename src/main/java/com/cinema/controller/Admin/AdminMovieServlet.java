package com.cinema.controller.Admin;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.dao.MovieDAO;
import com.cinema.enums.StatusMovie;
import com.cinema.model.Movie;

@WebServlet("/admin/movies")
public class AdminMovieServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final MovieDAO movieDAO = new MovieDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");
		if ("edit".equals(action)) {
			int id = Integer.parseInt(req.getParameter("id"));
			req.setAttribute("movie", movieDAO.findById(id));
		}
		
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
				m.setMovieId(Integer.parseInt(req.getParameter("movieId")));
				movieDAO.update(m);
			} else if ("delete".equals(action)) {
				int id = Integer.parseInt(req.getParameter("id"));
				movieDAO.delete(id);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(req.getContextPath() + "/admin/movies");
	}

	private Movie buildMovieFromRequest(HttpServletRequest req) {
		Movie m = new Movie();
		m.setTitle(req.getParameter("title"));
		m.setDescription(req.getParameter("description"));
		m.setDuration(Integer.parseInt(req.getParameter("duration")));
		m.setReleaseDate(Date.valueOf(req.getParameter("releaseDate")));
		m.setRating(Double.parseDouble(req.getParameter("rating")));
		m.setPoster(req.getParameter("poster"));
		m.setStatus(StatusMovie.valueOf(req.getParameter("status")));
		return m;
	}
}
