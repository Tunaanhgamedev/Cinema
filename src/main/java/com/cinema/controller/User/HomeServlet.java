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

		BannerDAO bannerDAO = new BannerDAO();
		com.cinema.dao.MovieDAO movieDAO = new com.cinema.dao.MovieDAO();

		request.setAttribute("leftBanner", bannerDAO.getActiveBannerByPosition("LEFT"));

		request.setAttribute("rightBanner", bannerDAO.getActiveBannerByPosition("RIGHT"));
		request.setAttribute("nowShowingMovies", movieDAO.findNowShowing());

		request.getRequestDispatcher("/pages/clients/home.jsp").forward(request, response);
	}
}
