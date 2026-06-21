package com.cinema.controller.User;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.dao.impl.ComboDAOImpl;
import com.cinema.model.Combo;

@WebServlet("/combos")
public class ComboServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final ComboDAOImpl comboDAO = new ComboDAOImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 1) Lấy danh sách combo từ DB
		List<Combo> comboList = comboDAO.findAll();
		req.setAttribute("comboList", comboList);

		// 2) Lấy bookingId nếu có (vd: /combos?bookingId=12)
		String bookingId = req.getParameter("bookingId");
		
		if (bookingId != null && !bookingId.trim().isEmpty()) {
			req.setAttribute("bookingId", bookingId);
			// Nếu đang trong luồng đặt vé -> Chuyển sang trang chọn combo (bước 2)
			req.getRequestDispatcher("/pages/clients/booking/combo.jsp").forward(req, resp);
		} else {
			// Nếu truy cập trực tiếp -> Chuyển sang trang danh sách combo chi tiết
			req.getRequestDispatcher("/pages/clients/combos.jsp").forward(req, resp);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
