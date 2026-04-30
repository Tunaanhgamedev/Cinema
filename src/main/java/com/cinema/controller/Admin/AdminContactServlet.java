package com.cinema.controller.Admin;

import java.io.IOException;
import java.util.List;

import com.cinema.dao.ContactDAO;
import com.cinema.model.Contact;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/contacts")
public class AdminContactServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ContactDAO contactDAO;

	@Override
	public void init() throws ServletException {
		contactDAO = new ContactDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Contact> list = contactDAO.getAllContacts();
		request.setAttribute("contactList", list);
		request.getRequestDispatcher("/pages/admin/contact-manage.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("delete".equals(action)) {
			int id = Integer.parseInt(request.getParameter("contactId"));
			contactDAO.deleteContact(id);
		} else if ("status".equals(action)) {
			int id = Integer.parseInt(request.getParameter("contactId"));
			String status = request.getParameter("status");
			contactDAO.updateStatus(id, status);
		}
		response.sendRedirect(request.getContextPath() + "/admin/contacts");
	}
}
