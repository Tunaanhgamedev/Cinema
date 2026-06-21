package com.cinema.controller.Admin;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.dao.VoucherDAO;
import com.cinema.model.Voucher;

@WebServlet({ "/admin/vouchers", "/admin/vouchers/add", "/admin/vouchers/edit", "/admin/vouchers/delete", "/admin/vouchers/save" })
public class AdminVoucherServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final VoucherDAO voucherDAO = new VoucherDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {
            case "/admin/vouchers/add":
                showAddForm(req, resp);
                break;
            case "/admin/vouchers/edit":
                showEditForm(req, resp);
                break;
            case "/admin/vouchers/delete":
                deleteVoucher(req, resp);
                break;
            default:
                listVouchers(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        saveVoucher(req, resp);
    }

    private void listVouchers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Voucher> list = voucherDAO.findAll();
        req.setAttribute("vouchers", list);
        req.getRequestDispatcher("/pages/admin/voucher/voucher-manage.jsp").forward(req, resp);
    }

    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("action", "add");
        req.getRequestDispatcher("/pages/admin/voucher/voucher-form.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Voucher v = voucherDAO.findById(id);
        req.setAttribute("voucher", v);
        req.setAttribute("action", "edit");
        req.getRequestDispatcher("/pages/admin/voucher/voucher-form.jsp").forward(req, resp);
    }

    private void saveVoucher(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = 0;
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                id = Integer.parseInt(idStr);
            }

            Voucher v = new Voucher();
            v.setVoucherId(id);
            v.setCode(req.getParameter("code").toUpperCase());
            v.setDiscountValue(new BigDecimal(req.getParameter("discountValue")));
            v.setDiscountType(req.getParameter("discountType"));
            v.setMinOrderValue(new BigDecimal(req.getParameter("minOrderValue")));
            v.setValidFrom(parseTimestamp(req.getParameter("validFrom")));
            v.setValidTo(parseTimestamp(req.getParameter("validTo")));
            v.setActive(req.getParameter("isActive") != null);

            if (id == 0) {
                voucherDAO.insert(v);
            } else {
                voucherDAO.update(v);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/vouchers?success=1");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/vouchers?error=1");
        }
    }

    private void deleteVoucher(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        voucherDAO.delete(id);
        resp.sendRedirect(req.getContextPath() + "/admin/vouchers?deleted=1");
    }

    private Timestamp parseTimestamp(String datetimeLocal) {
        if (datetimeLocal == null || datetimeLocal.isEmpty()) return null;
        // datetime-local format: yyyy-MM-ddThh:mm
        return Timestamp.valueOf(datetimeLocal.replace("T", " ") + ":00");
    }
}
