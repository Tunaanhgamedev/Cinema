package com.cinema.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Set;

import com.cinema.model.Seat;

public interface BookingSeatDAO {

	// CŨ (PaymentServlet đang dùng)
	List<Seat> findSeatsByBookingId(int bookingId);

	// MỚI (booking-ticket.jsp đang cần)
	Set<String> findBookedSeatCodesByShowtime(int showtimeId, int holdMinutes);

	// MỚI (giữ ghế + chống đặt trùng)
	void insertSeat(Connection con, int bookingId, int showtimeId, int seatId, int holdMinutes);

	// MỚI (timeout hold)
	int releaseExpiredHolds(Connection con, int holdMinutes);
}
