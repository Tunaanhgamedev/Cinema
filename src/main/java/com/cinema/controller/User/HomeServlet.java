package com.cinema.controller.User;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.dao.BannerDAO;
import com.cinema.dao.ShowtimeDAO;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if ("1".equals(request.getParameter("logout"))) {
			request.setAttribute("message", "Bạn đã đăng xuất.");
		}

		BannerDAO bannerDAO = new BannerDAO();
		ShowtimeDAO showtimeDAO = new ShowtimeDAO();

		request.setAttribute("leftBanner", bannerDAO.getActiveBannerByPosition("LEFT"));
		request.setAttribute("rightBanner", bannerDAO.getActiveBannerByPosition("RIGHT"));
		
		// Lấy phim có suất chiếu ngày hôm nay
		String today = LocalDate.now().toString();
		List<ShowtimeDAO.MovieWithShowtimes> data = showtimeDAO.getMoviesWithShowtimesByDate(today);
		request.setAttribute("moviesToday", data);

		request.getRequestDispatcher("/pages/clients/home.jsp").forward(request, response);
	}
}
