package com.cinema.model;

import java.math.BigDecimal;

public class Combo {
	private int comboId;
	private String name;
	private String description;
	private BigDecimal price; // DECIMAL(10,2) => BigDecimal

	public Combo() {
	}

	public Combo(int comboId, String name, String description, BigDecimal price) {
		this.comboId = comboId;
		this.name = name;
		this.description = description;
		this.price = price;
	}

	public int getComboId() {
		return comboId;
	}

	public void setComboId(int comboId) {
		this.comboId = comboId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}
}
