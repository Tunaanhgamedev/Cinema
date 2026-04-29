package com.cinema.model;

public class BookingCombo {
	private int bookingId; // FK -> booking
	private int comboId; // FK -> combo
	private int quantity;

	public BookingCombo() {
	}

	public BookingCombo(int bookingId, int comboId, int quantity) {
		this.bookingId = bookingId;
		this.comboId = comboId;
		this.quantity = quantity;
	}

	public int getBookingId() {
		return bookingId;
	}

	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}

	public int getComboId() {
		return comboId;
	}

	public void setComboId(int comboId) {
		this.comboId = comboId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
}
