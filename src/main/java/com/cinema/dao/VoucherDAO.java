package com.cinema.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.cinema.utils.DBConnection;

public class VoucherDAO {

    public static class VoucherResult {
        public boolean isValid;
        public String message;
        public double discountAmount;
        public String type; // PERCENT or FIXED_AMOUNT

        public VoucherResult(boolean isValid, String message) {
            this.isValid = isValid;
            this.message = message;
        }
    }

    public VoucherResult checkVoucher(String code, double orderTotal) {
        String sql = "SELECT * FROM vouchers WHERE code = ? AND is_active = TRUE";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, code);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // 1. Kiểm tra hạn sử dụng
                    java.sql.Timestamp now = new java.sql.Timestamp(System.currentTimeMillis());
                    java.sql.Timestamp validFrom = rs.getTimestamp("valid_from");
                    java.sql.Timestamp validTo = rs.getTimestamp("valid_to");

                    if (validFrom != null && now.before(validFrom)) {
                        return new VoucherResult(false, "Voucher chưa đến thời gian sử dụng.");
                    }
                    if (validTo != null && now.after(validTo)) {
                        return new VoucherResult(false, "Voucher đã hết hạn sử dụng.");
                    }

                    // 2. Kiểm tra giá trị đơn tối thiểu
                    double minOrder = rs.getDouble("min_order_value");
                    if (orderTotal < minOrder) {
                        return new VoucherResult(false, "Đơn hàng chưa đạt giá trị tối thiểu " + String.format("%,.0f", minOrder) + "đ");
                    }

                    // 3. Tính toán giảm giá
                    VoucherResult result = new VoucherResult(true, "Áp dụng mã giảm giá thành công!");
                    result.discountAmount = rs.getDouble("discount_value");
                    result.type = rs.getString("discount_type");
                    return result;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new VoucherResult(false, "Mã giảm giá không tồn tại hoặc đã bị vô hiệu hóa.");
    }
}
