package com.cinema.model;

import java.sql.Timestamp;

import com.cinema.enums.StatusBooking;

public class Booking {

	private int bookingId; // PK
	private int userId; // FK -> users
	private int showtimeId; // FK -> showtime
	private Timestamp bookingTime;
	private long totalPrice; // DECIMAL(14,0) dùng long là chuẩn
	private long discountAmount; // Số tiền giảm giá từ voucher
	private Timestamp bookingDate; // Thời gian đặt
	private StatusBooking status; // "PAID" hoặc "CANCELLED"

	public Booking() {
	}

	public Booking(int bookingId, int userId, int showtimeId, Timestamp bookingTime, long totalPrice,
			StatusBooking status) {
		this.bookingId = bookingId;
		this.userId = userId;
		this.showtimeId = showtimeId;
		this.bookingTime = bookingTime;
		this.totalPrice = totalPrice;
		this.status = status;
	}

	public int getBookingId() {
		return bookingId;
	}

	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getShowtimeId() {
		return showtimeId;
	}

	public void setShowtimeId(int showtimeId) {
		this.showtimeId = showtimeId;
	}

	public Timestamp getBookingTime() {
		return bookingTime;
	}

	public void setBookingTime(Timestamp bookingTime) {
		this.bookingTime = bookingTime;
	}

	public long getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(long totalPrice) {
		this.totalPrice = totalPrice;
	}

	public long getDiscountAmount() {
		return discountAmount;
	}

	public void setDiscountAmount(long discountAmount) {
		this.discountAmount = discountAmount;
	}

	public Timestamp getBookingDate() {
		return bookingDate;
	}

	public void setBookingDate(Timestamp bookingDate) {
		this.bookingDate = bookingDate;
	}

	public StatusBooking getStatus() {
		return status;
	}

	public void setStatus(StatusBooking status) {
		this.status = status;
	}
}
