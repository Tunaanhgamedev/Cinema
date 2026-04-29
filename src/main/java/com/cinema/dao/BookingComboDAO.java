package com.cinema.dao;

import java.util.List;

import com.cinema.model.BookingCombo;
import com.cinema.views.BookingComboDetail;

public interface BookingComboDAO {
	void insert(BookingCombo bc);

	void deleteByBookingId(int bookingId);

	List<BookingComboDetail> findDetailByBookingId(int bookingId);
}
