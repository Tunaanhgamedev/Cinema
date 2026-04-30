package com.cinema.controller.User;

import java.io.IOException;
import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.dao.ShowtimeDAO;
import com.cinema.model.Movie;

@WebServlet("/showtime")
public class ShowtimeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ShowtimeDAO showtimeDAO = new ShowtimeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String dateStr = req.getParameter("date");
        if (dateStr == null || dateStr.isEmpty()) {
            dateStr = LocalDate.now().toString(); // YYYY-MM-DD
        }

        // Lấy danh sách phim có suất chiếu trong ngày
        List<Movie> movies = showtimeDAO.getDistinctMoviesByDate(dateStr);
        
        // Tạo map: Movie -> List<ShowtimeView>
        Map<Movie, List<ShowtimeDAO.ShowtimeView>> movieShowtimes = new LinkedHashMap<>();
        for (Movie m : movies) {
            movieShowtimes.put(m, showtimeDAO.findByMovieAndDate(m.getMovieId(), dateStr));
        }

        req.setAttribute("selectedDate", dateStr);
        req.setAttribute("movieShowtimes", movieShowtimes);
        req.getRequestDispatcher("/pages/clients/showtime/showtime.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
