package com.cinema.controller.Admin;

import java.io.IOException;
import com.cinema.dao.MovieDAO;
import com.cinema.dao.BookingDAO;
import com.cinema.dao.VoucherDAO;
import com.cinema.dao.UserDAO;
import com.cinema.dao.impl.UserDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final MovieDAO movieDAO = new MovieDAO();
    private final BookingDAO bookingDAO = new BookingDAO();
    private final VoucherDAO voucherDAO = new VoucherDAO();
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("totalMovies", movieDAO.countTotalMovies());
        req.setAttribute("totalBookings", bookingDAO.countTotalBookings());
        req.setAttribute("totalRevenue", bookingDAO.calculateTotalRevenue());
        req.setAttribute("totalDiscount", bookingDAO.calculateTotalDiscount());
        req.setAttribute("activeVouchers", voucherDAO.countActiveVouchers());
        req.setAttribute("userCount", userDAO.countTotalUsers());
        
        // Dữ liệu biểu đồ
        req.setAttribute("revenueDaily", bookingDAO.getRevenueLast7Days());
        req.setAttribute("revenueMovie", bookingDAO.getRevenueByMovie());
        req.setAttribute("recentBookings", bookingDAO.getAllBookings().stream().limit(5).toList());

        req.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
