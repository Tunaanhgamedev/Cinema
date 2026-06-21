package com.cinema.model;

import java.math.BigDecimal;

public class Combo {
	private int comboId;
	private String name;
	private String description;
	private BigDecimal price;
	private String imageUrl;

	public Combo() {
	}

	public Combo(int comboId, String name, String description, BigDecimal price, String imageUrl) {
		this.comboId = comboId;
		this.name = name;
		this.description = description;
		this.price = price;
		this.imageUrl = imageUrl;
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

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
}
