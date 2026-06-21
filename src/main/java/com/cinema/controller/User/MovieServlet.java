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
		String keyword = req.getParameter("q");
		// String dateStr = req.getParameter("date");
		boolean isAjax = "true".equals(req.getParameter("ajax"));

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
			req.setAttribute("todayShowtimes", showtimes);
			req.setAttribute("today", today);
			
			// Nạp danh sách review
			com.cinema.dao.ReviewDAO reviewDAO = new com.cinema.dao.ReviewDAO();
			req.setAttribute("reviews", reviewDAO.findByMovieId(movieId));
			
			req.getRequestDispatcher("/pages/clients/movie/detail.jsp").forward(req, resp);

		} else {
			// Lấy tất cả phim (không phân theo ngày)
			String sort = req.getParameter("sort");
			if (sort == null || sort.isEmpty()) sort = "newest";
			
			List<Movie> movies = movieDAO.findAllWithFilters(keyword, sort);

			req.setAttribute("movies", movies);
			req.setAttribute("selectedSort", sort);

			if (isAjax) {
				// Nếu có keyword và là AJAX, trả về JSON cho search gợi ý
				if (keyword != null && !keyword.trim().isEmpty()) {
					resp.setContentType("application/json");
					resp.setCharacterEncoding("UTF-8");
					StringBuilder json = new StringBuilder("[");
					for (int i = 0; i < movies.size(); i++) {
						Movie m = movies.get(i);
						json.append("{");
						json.append("\"movieId\":").append(m.getMovieId()).append(",");
						json.append("\"title\":\"").append(m.getTitle().replace("\"", "\\\"")).append("\",");
						json.append("\"poster\":\"").append(m.getPoster()).append("\",");
						json.append("\"genre\":\"").append(m.getGenre()).append("\",");
						json.append("\"duration\":").append(m.getDuration());
						json.append("}");
						if (i < movies.size() - 1) json.append(",");
					}
					json.append("]");
					resp.getWriter().write(json.toString());
				} else {
					req.getRequestDispatcher("/pages/clients/movie/movie-grid-fragment.jsp").forward(req, resp);
				}
			} else {
				req.getRequestDispatcher("/pages/clients/movie/list.jsp").forward(req, resp);
			}
		}
	}
}
