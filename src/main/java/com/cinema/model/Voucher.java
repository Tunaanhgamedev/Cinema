package com.cinema.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Voucher {
    private int voucherId;
    private String code;
    private BigDecimal discountValue;
    private String discountType; // PERCENT, FIXED_AMOUNT
    private BigDecimal minOrderValue;
    private Timestamp validFrom;
    private Timestamp validTo;
    private boolean isActive;
    private Integer userId;
    private boolean isUsed;

    public Voucher() {}

    public int getVoucherId() { return voucherId; }
    public void setVoucherId(int voucherId) { this.voucherId = voucherId; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public BigDecimal getDiscountValue() { return discountValue; }
    public void setDiscountValue(BigDecimal discountValue) { this.discountValue = discountValue; }

    public String getDiscountType() { return discountType; }
    public void setDiscountType(String discountType) { this.discountType = discountType; }

    public BigDecimal getMinOrderValue() { return minOrderValue; }
    public void setMinOrderValue(BigDecimal minOrderValue) { this.minOrderValue = minOrderValue; }

    public Timestamp getValidFrom() { return validFrom; }
    public void setValidFrom(Timestamp validFrom) { this.validFrom = validFrom; }

    public Timestamp getValidTo() { return validTo; }
    public void setValidTo(Timestamp validTo) { this.validTo = validTo; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public boolean isUsed() { return isUsed; }
    public void setUsed(boolean used) { isUsed = used; }
}
