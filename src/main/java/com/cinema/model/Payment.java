package com.cinema.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

import com.cinema.enums.StatusPayment;

public class Payment {
	private int paymentId;
	private int bookingId;
	private String method;
	private String transactionId;
	private BigDecimal amount;
	private Timestamp paymentTime;
	private StatusPayment status;

	public Payment() {
	}

	public Payment(int paymentId, int bookingId, String method, String transactionId, BigDecimal amount,
			Timestamp paymentTime, StatusPayment status) {
		this.paymentId = paymentId;
		this.bookingId = bookingId;
		this.method = method;
		this.transactionId = transactionId;
		this.amount = amount;
		this.paymentTime = paymentTime;
		this.status = status;
	}

	public int getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(int paymentId) {
		this.paymentId = paymentId;
	}

	public int getBookingId() {
		return bookingId;
	}

	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public Timestamp getPaymentTime() {
		return paymentTime;
	}

	public void setPaymentTime(Timestamp paymentTime) {
		this.paymentTime = paymentTime;
	}

	public StatusPayment getStatus() {
		return status;
	}

	public void setStatus(StatusPayment status) {
		this.status = status;
	}

}
