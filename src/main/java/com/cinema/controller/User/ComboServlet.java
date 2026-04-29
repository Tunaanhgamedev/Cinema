package com.cinema.controller.User;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.dao.impl.ComboDAOImpl;
import com.cinema.model.Combo;

@WebServlet("/combooo")
public class ComboServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final ComboDAOImpl comboDAO = new ComboDAOImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 1) Lấy bookingId nếu có (vd: /combo?bookingId=12)
		String bookingId = req.getParameter("bookingId");
		if (bookingId != null && !bookingId.trim().isEmpty()) {
			req.setAttribute("bookingId", bookingId);
		}

		// 2) Lấy danh sách combo từ DB
		List<Combo> comboList = comboDAO.findAll();
		req.setAttribute("comboList", comboList);

		// 3) Forward sang JSP
		req.getRequestDispatcher("/pages/clients/booking/combo.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
