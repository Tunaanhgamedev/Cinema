package com.cinema.controller.Admin;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.dao.ShowtimeDAO;
import com.cinema.model.Showtime;

@WebServlet("/admin/showtimes")
public class AdminShowtimeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final ShowtimeDAO showtimeDAO = new ShowtimeDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("showtimeList", showtimeDAO.getAll());
		req.getRequestDispatcher("/pages/admin/showtime-manage.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		String action = req.getParameter("action");
		if (action == null)
			action = "add";

		try {
			if ("add".equals(action)) {
				Showtime st = buildShowtimeFromRequest(req, false);
				showtimeDAO.insert(st);

			} else if ("update".equals(action)) {
				Showtime st = buildShowtimeFromRequest(req, true);
				showtimeDAO.update(st);

			} else if ("delete".equals(action)) {
				int showtimeId = Integer.parseInt(req.getParameter("showtimeId"));
				showtimeDAO.delete(showtimeId);
			}

		} catch (Exception e) {
			req.setAttribute("error", "Lỗi: " + e.getMessage());
			req.setAttribute("showtimeList", showtimeDAO.getAll());
			req.getRequestDispatcher("/pages/admin/showtime-manage.jsp").forward(req, resp);
			return;
		}

		resp.sendRedirect(req.getContextPath() + "/admin/showtimes");
	}

	private Showtime buildShowtimeFromRequest(HttpServletRequest req, boolean includeId) {
		Showtime st = new Showtime();

		if (includeId) {
			st.setShowtimeId(Integer.parseInt(req.getParameter("showtimeId")));
		}

		st.setMovieId(Integer.parseInt(req.getParameter("movieId")));
		st.setRoomId(Integer.parseInt(req.getParameter("roomId")));

		st.setStartTime(parseTimestamp(req.getParameter("startTime")));
		st.setEndTime(parseTimestamp(req.getParameter("endTime")));

		String priceStr = req.getParameter("price");
		if (priceStr == null || priceStr.trim().isEmpty()) {
			st.setPrice(BigDecimal.ZERO);
		} else {
			st.setPrice(new BigDecimal(priceStr));
		}

		return st;
	}

	// input datetime-local: yyyy-MM-ddTHH:mm
	private Timestamp parseTimestamp(String s) {
		LocalDateTime ldt = LocalDateTime.parse(s);
		return Timestamp.valueOf(ldt);
	}
}
