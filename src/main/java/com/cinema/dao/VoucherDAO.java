package com.cinema.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.cinema.model.Voucher;
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

    public List<Voucher> findAll() {
        List<Voucher> list = new ArrayList<>();
        String sql = "SELECT * FROM vouchers ORDER BY valid_to DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Voucher v = mapRow(rs);
                list.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Voucher findById(int id) {
        String sql = "SELECT * FROM vouchers WHERE voucher_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insert(Voucher v) {
        String sql = "INSERT INTO vouchers (code, discount_value, discount_type, min_order_value, valid_from, valid_to, is_active) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, v.getCode());
            ps.setBigDecimal(2, v.getDiscountValue());
            ps.setString(3, v.getDiscountType());
            ps.setBigDecimal(4, v.getMinOrderValue());
            ps.setTimestamp(5, v.getValidFrom());
            ps.setTimestamp(6, v.getValidTo());
            ps.setBoolean(7, v.isActive());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Voucher v) {
        String sql = "UPDATE vouchers SET code=?, discount_value=?, discount_type=?, min_order_value=?, valid_from=?, valid_to=?, is_active=? WHERE voucher_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, v.getCode());
            ps.setBigDecimal(2, v.getDiscountValue());
            ps.setString(3, v.getDiscountType());
            ps.setBigDecimal(4, v.getMinOrderValue());
            ps.setTimestamp(5, v.getValidFrom());
            ps.setTimestamp(6, v.getValidTo());
            ps.setBoolean(7, v.isActive());
            ps.setInt(8, v.getVoucherId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM vouchers WHERE voucher_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Voucher mapRow(ResultSet rs) throws SQLException {
        Voucher v = new Voucher();
        v.setVoucherId(rs.getInt("voucher_id"));
        v.setCode(rs.getString("code"));
        v.setDiscountValue(rs.getBigDecimal("discount_value"));
        v.setDiscountType(rs.getString("discount_type"));
        v.setMinOrderValue(rs.getBigDecimal("min_order_value"));
        v.setValidFrom(rs.getTimestamp("valid_from"));
        v.setValidTo(rs.getTimestamp("valid_to"));
        v.setActive(rs.getBoolean("is_active"));
        return v;
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
