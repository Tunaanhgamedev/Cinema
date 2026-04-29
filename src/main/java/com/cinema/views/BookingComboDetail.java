package com.cinema.views;

import java.math.BigDecimal;

public class BookingComboDetail {
	private int comboId;
	private String comboName;
	private BigDecimal price;
	private int quantity;

	public BookingComboDetail() {
	}

	public BookingComboDetail(int comboId, String comboName, BigDecimal price, int quantity) {
		this.comboId = comboId;
		this.comboName = comboName;
		this.price = price;
		this.quantity = quantity;
	}

	public int getComboId() {
		return comboId;
	}

	public void setComboId(int comboId) {
		this.comboId = comboId;
	}

	public String getComboName() {
		return comboName;
	}

	public void setComboName(String comboName) {
		this.comboName = comboName;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
}
