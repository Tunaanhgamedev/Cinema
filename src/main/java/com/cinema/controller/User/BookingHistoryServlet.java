package com.cinema.controller.User;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.cinema.dao.BookingDAO;
import com.cinema.dao.MovieDAO;
import com.cinema.dao.ShowtimeDAO;
import com.cinema.model.Booking;
import com.cinema.model.Movie;
import com.cinema.model.Seat;
import com.cinema.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/booking/history")
public class BookingHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingDAO bookingDAO = new BookingDAO();
    private MovieDAO movieDAO = new MovieDAO();
    private ShowtimeDAO showtimeDAO = new ShowtimeDAO();

    public static class HistoryItem {
        public Booking booking;
        public ShowtimeDAO.ShowtimeView showtime;
        public Movie movie;
        public List<Seat> seats;

        public Booking getBooking() { return booking; }
        public ShowtimeDAO.ShowtimeView getShowtime() { return showtime; }
        public Movie getMovie() { return movie; }
        public List<Seat> getSeats() { return seats; }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User authUser = (User) session.getAttribute("authUser");

        if (authUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Booking> bookings = bookingDAO.findByUserId(authUser.getUserId());
        List<HistoryItem> historyList = new ArrayList<>();

        for (Booking b : bookings) {
            HistoryItem item = new HistoryItem();
            item.booking = b;
            item.showtime = showtimeDAO.findShowtimeViewById(b.getShowtimeId());
            if (item.showtime != null) {
                item.movie = movieDAO.findById(item.showtime.getMovieId());
            }
            item.seats = bookingDAO.getSeatsByBookingId(b.getBookingId());
            historyList.add(item);
        }

        request.setAttribute("historyList", historyList);
        request.getRequestDispatcher("/pages/clients/booking/booking-history.jsp").forward(request, response);
    }
}
