package com.cinema.controller.User;

import java.io.IOException;
import java.util.List;

import com.cinema.dao.BookingDAO;
import com.cinema.dao.MovieDAO;
import com.cinema.dao.ShowtimeDAO;
import com.cinema.model.Booking;
import com.cinema.model.Movie;
import com.cinema.model.Seat;
import com.cinema.model.Showtime;
import com.cinema.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/booking/invoice")
public class InvoiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingDAO bookingDAO = new BookingDAO();
    private MovieDAO movieDAO = new MovieDAO();
    private ShowtimeDAO showtimeDAO = new ShowtimeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User authUser = (User) session.getAttribute("authUser");
        
        if (authUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String bookingIdStr = request.getParameter("bookingId");
        if (bookingIdStr == null || bookingIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try {
            int bookingId = Integer.parseInt(bookingIdStr);
            Booking booking = bookingDAO.findById(bookingId);
            
            if (booking == null || booking.getUserId() != authUser.getUserId()) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }

            Showtime showtime = showtimeDAO.findShowtimeById(booking.getShowtimeId());
            Movie movie = movieDAO.findById(showtime.getMovieId());
            List<Seat> seats = bookingDAO.getSeatsByBookingId(bookingId);

            request.setAttribute("booking", booking);
            request.setAttribute("showtime", showtime);
            request.setAttribute("movie", movie);
            request.setAttribute("seats", seats);

            request.getRequestDispatcher("/pages/clients/booking/invoice.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
