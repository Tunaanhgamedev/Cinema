package com.cinema.controller.User;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.dao.VoucherDAO;
import com.google.gson.Gson;

@WebServlet("/api/voucher")
public class VoucherServlet extends HttpServlet {
    private final VoucherDAO voucherDAO = new VoucherDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        String totalStr = req.getParameter("total");
        
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        if (code == null || totalStr == null) {
            out.print(gson.toJson(new VoucherDAO.VoucherResult(false, "Thiếu thông tin mã hoặc tổng tiền.")));
            return;
        }

        try {
            double total = Double.parseDouble(totalStr);
            VoucherDAO.VoucherResult result = voucherDAO.checkVoucher(code, total);
            out.print(gson.toJson(result));
        } catch (NumberFormatException e) {
            out.print(gson.toJson(new VoucherDAO.VoucherResult(false, "Tổng tiền không hợp lệ.")));
        }
    }
}
