package com.cinema.controller.Admin;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.dao.SeatPriceDAO;
import com.cinema.enums.SeatType;
import com.cinema.model.SeatPrice;

@WebServlet("/admin/seat-prices")
public class AdminSeatPriceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SeatPriceDAO seatPriceDAO = new SeatPriceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<SeatPrice> prices = seatPriceDAO.getAllSeatPrices();
        request.setAttribute("seatPrices", prices);
        request.getRequestDispatcher("/pages/admin/seat-price-manage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String error = null;
        String success = null;

        try {
            if ("update".equals(action)) {
                String typeStr = request.getParameter("seatType");
                String surchargeStr = request.getParameter("surcharge");
                String colorStr = request.getParameter("colorHex");

                if (typeStr != null && surchargeStr != null) {
                    SeatType type = SeatType.valueOf(typeStr);
                    double surcharge = Double.parseDouble(surchargeStr);

                    SeatPrice sp = new SeatPrice(type, surcharge, colorStr != null ? colorStr : "#FFFFFF");
                    if (seatPriceDAO.saveSeatPrice(sp)) {
                        success = "Cập nhật giá phụ thu thành công!";
                    } else {
                        error = "Lỗi khi lưu vào Database.";
                    }
                }
            }
        } catch (Exception e) {
            error = "Lỗi thao tác: " + e.getMessage();
        }

        if (error != null) {
            request.setAttribute("error", error);
        } else if (success != null) {
            request.setAttribute("success", success);
        }

        doGet(request, response);
    }
}
