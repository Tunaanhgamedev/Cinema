package com.cinema.controller.User;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.dao.MovieDAO;
import com.cinema.dao.ShowtimeDAO;
import com.cinema.model.Movie;

@WebServlet("/movie")
public class MovieServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final MovieDAO movieDAO = new MovieDAO();
	private final ShowtimeDAO showtimeDAO = new ShowtimeDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String id = req.getParameter("id");

		if (id != null && !id.trim().isEmpty()) {
			int movieId = Integer.parseInt(id);

			Movie movie = movieDAO.findById(movieId);
			if (movie == null) {
				resp.sendError(HttpServletResponse.SC_NOT_FOUND);
				return;
			}

			// Lấy suất chiếu của phim này trong ngày hôm nay
			String today = LocalDate.now().toString();
			List<ShowtimeDAO.ShowtimeView> showtimes = showtimeDAO.findByMovieAndDate(movieId, today);

			req.setAttribute("movie", movie);
			req.setAttribute("showtimes", showtimes);
			req.setAttribute("today", today);
			
			req.getRequestDispatcher("/pages/clients/movie/detail.jsp").forward(req, resp);

		} else {
			List<Movie> movies = movieDAO.findAll();
			req.setAttribute("movies", movies);
			req.getRequestDispatcher("/pages/clients/movie/list.jsp").forward(req, resp);
		}
	}
}
