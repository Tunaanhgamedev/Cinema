package com.cinema.controller.Admin;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.cinema.dao.MovieDAO;
import com.cinema.dao.BookingDAO;
import com.cinema.dao.VoucherDAO;
import com.cinema.dao.UserDAO;
import com.cinema.dao.impl.UserDAOImpl;
import com.cinema.model.Booking;
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
        // Lấy các chỉ số thống kê
        int totalMovies = movieDAO.countTotalMovies();
        int totalBookings = bookingDAO.countTotalBookings();
        long totalRevenue = bookingDAO.calculateTotalRevenue();
        long totalDiscount = bookingDAO.calculateTotalDiscount();
        int activeVouchers = voucherDAO.countActiveVouchers();
        int userCount = userDAO.countTotalUsers();

        // Đưa dữ liệu lên Request
        req.setAttribute("totalMovies", totalMovies);
        req.setAttribute("totalBookings", totalBookings);
        req.setAttribute("totalRevenue", totalRevenue);
        req.setAttribute("totalDiscount", totalDiscount);
        req.setAttribute("activeVouchers", activeVouchers);
        req.setAttribute("userCount", userCount);
        
        // Dữ liệu biểu đồ và danh sách gần đây
        Map<String, Long> revenueDaily = bookingDAO.getRevenueLast7Days();
        Map<String, Long> revenueMovie = bookingDAO.getRevenueByMovie();
        List<Booking> allBookings = bookingDAO.getAllBookings();
        List<Booking> recentBookings = allBookings.stream().limit(5).toList();

        req.setAttribute("revenueDaily", revenueDaily);
        req.setAttribute("revenueMovie", revenueMovie);
        req.setAttribute("recentBookings", recentBookings);

        req.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
