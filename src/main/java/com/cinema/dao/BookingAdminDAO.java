package com.cinema.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.cinema.utils.DBConnection;

public class BookingAdminDAO {

	// ===== DTO cho màn list =====
	public static class BookingRow {
		private int bookingId;
		private int userId;
		private String fullName;
		private String email;

		private String movieTitle;
		private String roomName;

		private Timestamp startTime;
		private Timestamp endTime;

		private String status;

		private int seatCount;
		private BigDecimal ticketSubtotal;
		private BigDecimal comboSubtotal;
		private BigDecimal grandTotal;

		public int getBookingId() {
			return bookingId;
		}

		public int getUserId() {
			return userId;
		}

		public String getFullName() {
			return fullName;
		}

		public String getEmail() {
			return email;
		}

		public String getMovieTitle() {
			return movieTitle;
		}

		public String getRoomName() {
			return roomName;
		}

		public Timestamp getStartTime() {
			return startTime;
		}

		public Timestamp getEndTime() {
			return endTime;
		}

		public String getStatus() {
			return status;
		}

		public int getSeatCount() {
			return seatCount;
		}

		public BigDecimal getTicketSubtotal() {
			return ticketSubtotal;
		}

		public BigDecimal getComboSubtotal() {
			return comboSubtotal;
		}

		public BigDecimal getGrandTotal() {
			return grandTotal;
		}
	}

	// ===== DTO cho combo detail =====
	public static class ComboLine {
		private int comboId;
		private String name;
		private BigDecimal price;
		private int quantity;
		private BigDecimal lineTotal;

		public int getComboId() {
			return comboId;
		}

		public String getName() {
			return name;
		}

		public BigDecimal getPrice() {
			return price;
		}

		public int getQuantity() {
			return quantity;
		}

		public BigDecimal getLineTotal() {
			return lineTotal;
		}
	}

	// ===== DTO cho màn detail =====
	public static class BookingDetail {
		private int bookingId;
		private int userId;
		private String fullName;
		private String email;

		private int showtimeId;
		private String movieTitle;
		private String roomName;
		private Timestamp startTime;
		private Timestamp endTime;

		private String status;

		private BigDecimal ticketPrice; // giá 1 vé (showtime.price)
		private int seatCount;
		private List<String> seats = new ArrayList<>();

		private List<ComboLine> combos = new ArrayList<>();

		private BigDecimal ticketSubtotal;
		private BigDecimal comboSubtotal;
		private BigDecimal grandTotal;

		public int getBookingId() {
			return bookingId;
		}

		public int getUserId() {
			return userId;
		}

		public String getFullName() {
			return fullName;
		}

		public String getEmail() {
			return email;
		}

		public int getShowtimeId() {
			return showtimeId;
		}

		public String getMovieTitle() {
			return movieTitle;
		}

		public String getRoomName() {
			return roomName;
		}

		public Timestamp getStartTime() {
			return startTime;
		}

		public Timestamp getEndTime() {
			return endTime;
		}

		public String getStatus() {
			return status;
		}

		public BigDecimal getTicketPrice() {
			return ticketPrice;
		}

		public int getSeatCount() {
			return seatCount;
		}

		public List<String> getSeats() {
			return seats;
		}

		public List<ComboLine> getCombos() {
			return combos;
		}

		public BigDecimal getTicketSubtotal() {
			return ticketSubtotal;
		}

		public BigDecimal getComboSubtotal() {
			return comboSubtotal;
		}

		public BigDecimal getGrandTotal() {
			return grandTotal;
		}
	}

	// =========================
	// 1) LIST ALL BOOKINGS
	// =========================
	public List<BookingRow> getAllBookings() {
		String sql = """
				    SELECT
				        b.booking_id,
				        b.user_id,
				        u.full_name,
				        u.email,
				        b.showtime_id,
				        b.status,
				        st.start_time,
				        st.end_time,
				        st.price AS ticket_price,
				        m.title AS movie_title,
				        r.room_name AS room_name,

				        -- số ghế
				        (SELECT COUNT(*) FROM booking_seat bs WHERE bs.booking_id = b.booking_id) AS seat_count,

				        -- tổng combo
				        COALESCE((
				            SELECT SUM(c.price * bc.quantity)
				            FROM booking_combo bc
				            JOIN combos c ON c.combo_id = bc.combo_id
				            WHERE bc.booking_id = b.booking_id
				        ), 0) AS combo_subtotal

				    FROM bookings b
				    JOIN users u      ON u.user_id = b.user_id
				    JOIN showtimes st ON st.showtime_id = b.showtime_id
				    JOIN movies m     ON m.movie_id = st.movie_id
				    JOIN rooms r      ON r.room_id = st.room_id
				    ORDER BY b.booking_id DESC
				""";

		List<BookingRow> list = new ArrayList<>();

		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				BookingRow row = new BookingRow();
				row.bookingId = rs.getInt("booking_id");
				row.userId = rs.getInt("user_id");
				row.fullName = rs.getString("full_name");
				row.email = rs.getString("email");

				row.movieTitle = rs.getString("movie_title");
				row.roomName = rs.getString("room_name");
				row.startTime = rs.getTimestamp("start_time");
				row.endTime = rs.getTimestamp("end_time");
				row.status = rs.getString("status");

				BigDecimal ticketPrice = nvl(rs.getBigDecimal("ticket_price"));
				int seatCount = rs.getInt("seat_count");
				row.seatCount = seatCount;

				row.ticketSubtotal = ticketPrice.multiply(BigDecimal.valueOf(seatCount));
				row.comboSubtotal = nvl(rs.getBigDecimal("combo_subtotal"));
				row.grandTotal = row.ticketSubtotal.add(row.comboSubtotal);

				list.add(row);
			}

		} catch (Exception e) {
			throw new RuntimeException("BookingAdminDAO.getAllBookings error", e);
		}

		return list;
	}

	// =========================
	// 2) GET BOOKING DETAIL
	// =========================
	public BookingDetail getBookingDetail(int bookingId) {

		String headerSql = """
				    SELECT
				        b.booking_id, b.user_id, b.showtime_id, b.status,
				        u.full_name, u.email,
				        st.start_time, st.end_time, st.price AS ticket_price,
				        m.title AS movie_title,
				        r.room_name AS room_name
				    FROM bookings b
				    JOIN users u      ON u.user_id = b.user_id
				    JOIN showtimes st ON st.showtime_id = b.showtime_id
				    JOIN movies m     ON m.movie_id = st.movie_id
				    JOIN rooms r      ON r.room_id = st.room_id
				    WHERE b.booking_id = ?
				""";

		String seatSql = """
				    SELECT CONCAT(s.seat_row, s.seat_number) AS seat_label
				    FROM booking_seat bs
				    JOIN seats s ON s.seat_id = bs.seat_id
				    WHERE bs.booking_id = ?
				    ORDER BY s.seat_row, s.seat_number
				""";

		String comboSql = """
				    SELECT
				        c.combo_id,
				        c.name,
				        c.price,
				        bc.quantity,
				        (c.price * bc.quantity) AS line_total
				    FROM booking_combo bc
				    JOIN combos c ON c.combo_id = bc.combo_id
				    WHERE bc.booking_id = ?
				    ORDER BY c.combo_id DESC
				""";

		try (Connection con = DBConnection.getConnection()) {

			BookingDetail detail = null;

			// header
			try (PreparedStatement ps = con.prepareStatement(headerSql)) {
				ps.setInt(1, bookingId);

				try (ResultSet rs = ps.executeQuery()) {
					if (!rs.next())
						return null;

					detail = new BookingDetail();
					detail.bookingId = rs.getInt("booking_id");
					detail.userId = rs.getInt("user_id");
					detail.showtimeId = rs.getInt("showtime_id");
					detail.status = rs.getString("status");

					detail.fullName = rs.getString("full_name");
					detail.email = rs.getString("email");

					detail.startTime = rs.getTimestamp("start_time");
					detail.endTime = rs.getTimestamp("end_time");
					detail.ticketPrice = nvl(rs.getBigDecimal("ticket_price"));

					detail.movieTitle = rs.getString("movie_title");
					detail.roomName = rs.getString("room_name");
				}
			}

			// seats
			try (PreparedStatement ps = con.prepareStatement(seatSql)) {
				ps.setInt(1, bookingId);
				try (ResultSet rs = ps.executeQuery()) {
					while (rs.next()) {
						detail.seats.add(rs.getString("seat_label"));
					}
				}
			}
			detail.seatCount = detail.seats.size();
			detail.ticketSubtotal = detail.ticketPrice.multiply(BigDecimal.valueOf(detail.seatCount));

			// combos
			detail.comboSubtotal = BigDecimal.ZERO;
			try (PreparedStatement ps = con.prepareStatement(comboSql)) {
				ps.setInt(1, bookingId);
				try (ResultSet rs = ps.executeQuery()) {
					while (rs.next()) {
						ComboLine line = new ComboLine();
						line.comboId = rs.getInt("combo_id");
						line.name = rs.getString("name");
						line.price = nvl(rs.getBigDecimal("price"));
						line.quantity = rs.getInt("quantity");
						line.lineTotal = nvl(rs.getBigDecimal("line_total"));

						detail.combos.add(line);
						detail.comboSubtotal = detail.comboSubtotal.add(line.lineTotal);
					}
				}
			}

			detail.grandTotal = detail.ticketSubtotal.add(detail.comboSubtotal);
			return detail;

		} catch (Exception e) {
			throw new RuntimeException("BookingAdminDAO.getBookingDetail error", e);
		}
	}

	// =========================
	// 3) UPDATE STATUS
	// =========================
	public boolean updateStatus(int bookingId, String status) {
		String sql = "UPDATE bookings SET status=? WHERE booking_id=?";
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, status);
			ps.setInt(2, bookingId);
			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			throw new RuntimeException("BookingAdminDAO.updateStatus error", e);
		}
	}

	public int countTotalBookings() {
		String sql = "SELECT COUNT(*) FROM bookings";
		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next())
				return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public BigDecimal calculateTotalRevenue() {
		String sql = "SELECT SUM(total_price) FROM bookings WHERE status = 'PAID'";
		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next())
				return nvl(rs.getBigDecimal(1));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return BigDecimal.ZERO;
	}

	// ===== DTO cho thống kê =====
	public static class StatisticDTO {
		private String label;
		private BigDecimal value;

		public StatisticDTO(String label, BigDecimal value) {
			this.label = label;
			this.value = value;
		}

		public String getLabel() { return label; }
		public BigDecimal getValue() { return value; }
	}

	public List<StatisticDTO> getRevenueLast7Days() {
		String sql = """
				SELECT DATE(IFNULL(booking_date, booking_time)) as date, SUM(total_price) as revenue 
				FROM bookings 
				WHERE status = 'PAID' 
				GROUP BY DATE(IFNULL(booking_date, booking_time))
				ORDER BY date DESC
				LIMIT 7
				""";
		List<StatisticDTO> list = new ArrayList<>();
		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				list.add(0, new StatisticDTO(rs.getString("date"), nvl(rs.getBigDecimal("revenue"))));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<StatisticDTO> getRevenueByMovie() {
		String sql = """
				SELECT m.title, SUM(b.total_price) as revenue
				FROM bookings b
				JOIN showtimes st ON b.showtime_id = st.showtime_id
				JOIN movies m ON st.movie_id = m.movie_id
				WHERE b.status = 'PAID'
				GROUP BY m.movie_id, m.title
				ORDER BY revenue DESC
				LIMIT 5
				""";
		List<StatisticDTO> list = new ArrayList<>();
		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				list.add(new StatisticDTO(rs.getString("title"), nvl(rs.getBigDecimal("revenue"))));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	private static BigDecimal nvl(BigDecimal v) {
		return v == null ? BigDecimal.ZERO : v;
	}
}
