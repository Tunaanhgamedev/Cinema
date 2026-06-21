package com.cinema.controller.User;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.dao.ShowtimeDAO;

@WebServlet("/showtime")
public class ShowtimeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final ShowtimeDAO showtimeDAO = new ShowtimeDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String dateParam = req.getParameter("date");
		if (dateParam == null || dateParam.trim().isEmpty()) {
			dateParam = LocalDate.now().toString(); // Mặc định là hôm nay (yyyy-MM-dd)
		}

		List<ShowtimeDAO.MovieWithShowtimes> data = showtimeDAO.getMoviesWithShowtimesByDate(dateParam);
		
		req.setAttribute("moviesWithShowtimes", data);
		req.setAttribute("selectedDate", dateParam);
		
		req.getRequestDispatcher("/pages/clients/showtime/showtime.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
