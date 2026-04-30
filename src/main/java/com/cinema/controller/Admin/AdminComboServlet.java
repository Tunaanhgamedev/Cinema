package com.cinema.controller.Admin;

import java.io.IOException;
import java.math.BigDecimal;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.dao.impl.ComboDAOImpl;

@WebServlet("/admin/combos")
public class AdminComboServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final ComboDAOImpl comboDAO = new ComboDAOImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Mặc định list
		req.setAttribute("comboList", comboDAO.findAll());
		req.getRequestDispatcher("/pages/admin/combo-manage.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		String action = req.getParameter("action");
		if (action == null)
			action = "add";

		try {
			if ("add".equals(action)) {
				String name = req.getParameter("name");
				String description = req.getParameter("description");
				String priceStr = req.getParameter("price");
				BigDecimal price = new BigDecimal(priceStr);

				comboDAO.insertCombo(name, description, price);

			} else if ("update".equals(action)) {
				int comboId = Integer.parseInt(req.getParameter("comboId"));
				String name = req.getParameter("name");
				String description = req.getParameter("description");
				BigDecimal price = new BigDecimal(req.getParameter("price"));
				comboDAO.updateCombo(comboId, name, description, price);
			} else if ("delete".equals(action)) {
				int comboId = Integer.parseInt(req.getParameter("comboId"));
				comboDAO.deleteCombo(comboId);
			}
		} catch (Exception e) {
			req.setAttribute("error", "Có lỗi dữ liệu: " + e.getMessage());
			req.setAttribute("comboList", comboDAO.findAll());
			req.getRequestDispatcher("/pages/admin/combo-manage.jsp").forward(req, resp);
			return;
		}

		// redirect để tránh submit lại khi F5
		resp.sendRedirect(req.getContextPath() + "/admin/combos");
	}
}
