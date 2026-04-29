package com.cinema.model;

public class Cinema {
	private int cinemaId;
	private String name;
	private String address;
	private String city;

	public Cinema() {
	}

	public Cinema(int cinemaId, String name, String address, String city) {
		this.cinemaId = cinemaId;
		this.name = name;
		this.address = address;
		this.city = city;
	}

	public int getCinemaId() {
		return cinemaId;
	}

	public void setCinemaId(int cinemaId) {
		this.cinemaId = cinemaId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}
}
