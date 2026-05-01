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
        String keyword = req.getParameter("q");
        String sort = req.getParameter("sort");
        if (sort == null || sort.isEmpty()) sort = "newest";
        boolean isAjax = "true".equals(req.getParameter("ajax"));

        // ÉP LOGIC 7 NGÀY NGAY TẠI ĐÂY ĐỂ ĐẢM BẢO HIỂN THỊ
        List<java.sql.Date> availableDates = new java.util.ArrayList<>();
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.set(java.util.Calendar.HOUR_OF_DAY, 0);
        cal.set(java.util.Calendar.MINUTE, 0);
        cal.set(java.util.Calendar.SECOND, 0);
        cal.set(java.util.Calendar.MILLISECOND, 0);
        for (int i = 0; i < 7; i++) {
            availableDates.add(new java.sql.Date(cal.getTimeInMillis()));
            cal.add(java.util.Calendar.DAY_OF_MONTH, 1);
        }

        if (dateStr == null || dateStr.isEmpty()) {
            dateStr = availableDates.get(0).toString();
        }

        // Lấy danh sách phim theo filter
        List<Movie> movies = showtimeDAO.getMoviesWithShowtimes(dateStr, keyword, sort);
        
        Map<Movie, List<ShowtimeDAO.ShowtimeView>> movieShowtimes = new LinkedHashMap<>();
        for (Movie m : movies) {
            movieShowtimes.put(m, showtimeDAO.findByMovieAndDate(m.getMovieId(), dateStr));
        }

        req.setAttribute("availableDates", availableDates);
        req.setAttribute("selectedDate", dateStr);
        req.setAttribute("movieShowtimes", movieShowtimes);
        req.setAttribute("selectedSort", sort);

        if (isAjax) {
            req.getRequestDispatcher("/pages/clients/showtime/showtime-list-fragment.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/pages/clients/showtime/showtime.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
