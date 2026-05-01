package com.cinema.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Showtime {
	private int showtimeId;
	private int movieId;
	private int roomId;
	private java.sql.Date showDate;
	private Timestamp startTime;
	private Timestamp endTime;
	private BigDecimal price;

	public Showtime() {
	}

	public Showtime(int showtimeId, int movieId, int roomId, java.sql.Date showDate, Timestamp startTime, Timestamp endTime, BigDecimal price) {
		this.showtimeId = showtimeId;
		this.movieId = movieId;
		this.roomId = roomId;
		this.showDate = showDate;
		this.startTime = startTime;
		this.endTime = endTime;
		this.price = price;
	}

	public int getShowtimeId() {
		return showtimeId;
	}

	public void setShowtimeId(int showtimeId) {
		this.showtimeId = showtimeId;
	}

	public int getMovieId() {
		return movieId;
	}

	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}

	public int getRoomId() {
		return roomId;
	}

	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}

	public Timestamp getStartTime() {
		return startTime;
	}

	public void setStartTime(Timestamp startTime) {
		this.startTime = startTime;
	}

	public Timestamp getEndTime() {
		return endTime;
	}

	public void setEndTime(Timestamp endTime) {
		this.endTime = endTime;
	}

	public java.sql.Date getShowDate() {
		return showDate;
	}

	public void setShowDate(java.sql.Date showDate) {
		this.showDate = showDate;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

}
