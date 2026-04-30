package com.cinema.controller.User;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.dao.BannerDAO;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if ("1".equals(request.getParameter("logout"))) {
			request.setAttribute("message", "Bạn đã đăng xuất.");
		}

		// Sử dụng Cache để tối ưu tốc độ
		Object movies = com.cinema.utils.CacheManager.get("nowShowingMovies");
		Object leftBanner = com.cinema.utils.CacheManager.get("leftBanner");
		Object rightBanner = com.cinema.utils.CacheManager.get("rightBanner");

		if (movies == null || leftBanner == null || rightBanner == null) {
			BannerDAO bannerDAO = new BannerDAO();
			com.cinema.dao.MovieDAO movieDAO = new com.cinema.dao.MovieDAO();

			leftBanner = bannerDAO.getActiveBannerByPosition("LEFT");
			rightBanner = bannerDAO.getActiveBannerByPosition("RIGHT");
			movies = movieDAO.findNowShowing();

			com.cinema.utils.CacheManager.put("leftBanner", leftBanner);
			com.cinema.utils.CacheManager.put("rightBanner", rightBanner);
			com.cinema.utils.CacheManager.put("nowShowingMovies", movies);
		}

		request.setAttribute("leftBanner", leftBanner);
		request.setAttribute("rightBanner", rightBanner);
		request.setAttribute("nowShowingMovies", movies);

		request.getRequestDispatcher("/pages/clients/home.jsp").forward(request, response);
	}
}
