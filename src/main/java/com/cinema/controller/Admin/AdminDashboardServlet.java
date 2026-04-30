package com.cinema.controller.Admin;

import java.io.IOException;
import java.math.BigDecimal;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.dao.BookingAdminDAO;
import com.cinema.dao.MovieDAO;

@WebServlet("/admin")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final BookingAdminDAO bookingDAO = new BookingAdminDAO();
    private final MovieDAO movieDAO = new MovieDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // Lấy số liệu thống kê
        int totalBookings = bookingDAO.countTotalBookings();
        BigDecimal totalRevenue = bookingDAO.calculateTotalRevenue();
        int totalMovies = movieDAO.findAll().size();
        
        req.setAttribute("totalBookings", totalBookings);
        req.setAttribute("totalRevenue", totalRevenue);
        req.setAttribute("totalMovies", totalMovies);
        
        // Forward sang trang JSP mới
        req.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(req, resp);
    }
}
