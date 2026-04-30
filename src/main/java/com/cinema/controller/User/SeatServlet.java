package com.cinema.controller.User;

import java.io.IOException;
import java.util.List;
import java.util.Set;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.dao.SeatDAO;
import com.cinema.model.Seat;

@WebServlet("/select-seat")
public class SeatServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int roomId = Integer.parseInt(req.getParameter("roomId"));
		int showtimeId = Integer.parseInt(req.getParameter("showtimeId"));

		SeatDAO dao = new SeatDAO();

		List<Seat> seats = dao.getSeatsByRoom(roomId);
		Set<Integer> bookedSeats = dao.getBookedSeatIds(showtimeId);

		req.setAttribute("seats", seats);
		req.setAttribute("bookedSeats", bookedSeats);
		req.setAttribute("showtimeId", showtimeId);

		req.getRequestDispatcher("/pages/clients/seat/select-seat.jsp").forward(req, resp);
	}
}
