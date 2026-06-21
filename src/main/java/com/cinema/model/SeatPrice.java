package com.cinema.model;

import com.cinema.enums.SeatType;

public class SeatPrice {
    private SeatType seatType; // NORMAL, VIP, COUPLE
    private double surcharge;  // Phụ phí
    private String colorHex;   // Màu hiển thị trên sơ đồ

    public SeatPrice() {
    }

    public SeatPrice(SeatType seatType, double surcharge, String colorHex) {
        this.seatType = seatType;
        this.surcharge = surcharge;
        this.colorHex = colorHex;
    }

    public SeatType getSeatType() {
        return seatType;
    }

    public void setSeatType(SeatType seatType) {
        this.seatType = seatType;
    }

    public double getSurcharge() {
        return surcharge;
    }

    public void setSurcharge(double surcharge) {
        this.surcharge = surcharge;
    }

    public String getColorHex() {
        return colorHex;
    }

    public void setColorHex(String colorHex) {
        this.colorHex = colorHex;
    }
}
