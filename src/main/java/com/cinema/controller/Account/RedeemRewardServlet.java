package com.cinema.controller.Account;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.cinema.dao.UserDAO;
import com.cinema.dao.impl.UserDAOImpl;
import com.cinema.dao.VoucherDAO;
import com.cinema.model.User;
import com.cinema.model.Voucher;

@WebServlet("/account/redeem")
public class RedeemRewardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("authUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("authUser");
        String rewardId = req.getParameter("rewardId");

        int pointsRequired = 0;
        BigDecimal discountVal = BigDecimal.ZERO;
        String rewardName = "";

        // Định nghĩa các mốc đổi quà
        switch (rewardId) {
            case "1":
                pointsRequired = 500;
                discountVal = new BigDecimal("20000");
                rewardName = "Voucher 20k";
                break;
            case "2":
                pointsRequired = 1000;
                discountVal = new BigDecimal("50000");
                rewardName = "Voucher 50k";
                break;
            case "3":
                pointsRequired = 2000;
                discountVal = new BigDecimal("100000");
                rewardName = "Voucher 100k";
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/account#vouchers?error=invalid_reward");
                return;
        }

        UserDAO userDAO = new UserDAOImpl();
        VoucherDAO voucherDAO = new VoucherDAO();

        // 1. Kiểm tra điểm
        if (user.getLoyaltyPoints() < pointsRequired) {
            resp.sendRedirect(req.getContextPath() + "/account#vouchers?error=not_enough_points");
            return;
        }

        // 2. Trừ điểm & Tặng Voucher (Atomic)
        boolean success = userDAO.subtractPoints(user.getUserId(), pointsRequired);
        if (success) {
            // Tạo mã Voucher ngẫu nhiên
            String code = "REDEEM" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            
            Voucher v = new Voucher();
            v.setCode(code);
            v.setDiscountValue(discountVal);
            v.setDiscountType("FIXED_AMOUNT");
            v.setMinOrderValue(BigDecimal.ZERO); // Không giới hạn đơn tối thiểu cho voucher đổi thưởng
            v.setValidFrom(new Timestamp(System.currentTimeMillis()));
            v.setValidTo(new Timestamp(System.currentTimeMillis() + 90L * 24 * 60 * 60 * 1000)); // Hạn 90 ngày
            v.setActive(true);
            v.setUserId(user.getUserId());
            v.setUsed(false);

            voucherDAO.insert(v);

            // Cập nhật lại session
            User updatedUser = userDAO.findByEmail(user.getEmail());
            session.setAttribute("authUser", updatedUser);

            resp.sendRedirect(req.getContextPath() + "/account#vouchers?success=reward_redeemed&code=" + code);
        } else {
            resp.sendRedirect(req.getContextPath() + "/account#vouchers?error=redeem_failed");
        }
    }
}
