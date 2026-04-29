package com.cinema.model;

import com.cinema.enums.SeatType;

public class Seat {
	private int seatId;
	private int roomId;
	private char seatRow;
	private int seatNumber;
	private SeatType seatType;

	public Seat() {
		super();
	}

	public Seat(int seatId, int roomId, char seatRow, int seatNumber, SeatType seatType) {
		super();
		this.seatId = seatId;
		this.roomId = roomId;
		this.seatRow = seatRow;
		this.seatNumber = seatNumber;
		this.seatType = seatType;
	}

	public int getSeatId() {
		return seatId;
	}

	public void setSeatId(int seatId) {
		this.seatId = seatId;
	}

	public int getRoomId() {
		return roomId;
	}

	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}

	public char getSeatRow() {
		return seatRow;
	}

	public void setSeatRow(char seatRow) {
		this.seatRow = seatRow;
	}

	public int getSeatNumber() {
		return seatNumber;
	}

	public void setSeatNumber(int seatNumber) {
		this.seatNumber = seatNumber;
	}

	public SeatType getSeatType() {
		return seatType;
	}

	public void setSeatType(SeatType seatType) {
		this.seatType = seatType;
	}
}
