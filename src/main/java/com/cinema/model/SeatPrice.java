package com.cinema.model;

import java.math.BigDecimal;

public class SeatPrice {
    private String seatType; // NORMAL, VIP, COUPLE
    private BigDecimal surcharge; // Phụ phí

    public SeatPrice() {
    }

    public SeatPrice(String seatType, BigDecimal surcharge) {
        this.seatType = seatType;
        this.surcharge = surcharge;
    }

    public String getSeatType() {
        return seatType;
    }

    public void setSeatType(String seatType) {
        this.seatType = seatType;
    }

    public BigDecimal getSurcharge() {
        return surcharge;
    }

    public void setSurcharge(BigDecimal surcharge) {
        this.surcharge = surcharge;
    }
}
