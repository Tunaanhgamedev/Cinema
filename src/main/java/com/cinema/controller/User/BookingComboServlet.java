package com.cinema.controller.User;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.dao.BookingComboDAO;
import com.cinema.dao.ComboDAO;
import com.cinema.dao.impl.BookingComboDAOImpl;
import com.cinema.dao.impl.ComboDAOImpl;
import com.cinema.model.BookingCombo;
import com.cinema.model.Combo;

@WebServlet("/booking/combo")
public class BookingComboServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ComboDAO comboDAO;
	private BookingComboDAO bookingComboDAO;

	@Override
	public void init() throws ServletException {
		comboDAO = new ComboDAOImpl();
		bookingComboDAO = new BookingComboDAOImpl();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String bookingId = request.getParameter("bookingId");

		// ✅ thiếu bookingId thì quay lại trang đặt vé (không cho vào combo trực tiếp)
		if (bookingId == null || bookingId.trim().isEmpty()) {
			response.sendRedirect(
					request.getContextPath() + "/booking-seat?error=Vui lòng đặt vé trước khi chọn combo.");
			return;
		}

		request.setAttribute("bookingId", bookingId.trim());
		request.setAttribute("comboList", comboDAO.findAll());
		request.getRequestDispatcher("/pages/clients/booking/combo.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String bookingIdStr = request.getParameter("bookingId");
		if (bookingIdStr == null || bookingIdStr.trim().isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/booking-seat?error=Thiếu bookingId");
			return;
		}

		int bookingId;
		try {
			bookingId = Integer.parseInt(bookingIdStr.trim());
		} catch (Exception e) {
			response.sendRedirect(request.getContextPath() + "/booking-seat?error=bookingId không hợp lệ");
			return;
		}

		List<Combo> comboList = comboDAO.findAll();
		bookingComboDAO.deleteByBookingId(bookingId);

		for (Combo c : comboList) {
			String qStr = request.getParameter("quantity_" + c.getComboId());
			int quantity = 0;
			try {
				quantity = (qStr == null) ? 0 : Integer.parseInt(qStr);
			} catch (Exception ignore) {
			}

			if (quantity > 0) {
				bookingComboDAO.insert(new BookingCombo(bookingId, c.getComboId(), quantity));
			}
		}

		// ✅ chọn combo xong -> qua payment luôn
		response.sendRedirect(request.getContextPath() + "/booking/payment?bookingId=" + bookingId);
	}

}
