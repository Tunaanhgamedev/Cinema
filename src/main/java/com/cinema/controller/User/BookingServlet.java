package com.cinema.controller.User;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String[] seatIds = req.getParameterValues("seatIds");
		int showtimeId = Integer.parseInt(req.getParameter("showtimeId"));

		if (seatIds == null) {
			req.setAttribute("error", "Bạn chưa chọn ghế!");
			req.getRequestDispatcher("/pages/clients/seat/select-seat.jsp").forward(req, resp);
			return;
		}

		// Lưu seatIds vào session
		req.getSession().setAttribute("seatIds", seatIds);
		req.getSession().setAttribute("showtimeId", showtimeId);

		resp.sendRedirect("/pages/clients/booking/combo.jsp");
	}
}
