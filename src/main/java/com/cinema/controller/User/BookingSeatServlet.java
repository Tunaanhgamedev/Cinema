package com.cinema.controller.User;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.cinema.dao.BookingDAO;
import com.cinema.dao.BookingSeatDAO;
import com.cinema.dao.ComboDAO;
import com.cinema.dao.MovieDAO;
import com.cinema.dao.SeatDAO;
import com.cinema.dao.ShowtimeDAO;
import com.cinema.dao.ShowtimeDAO.ShowtimeView;
import com.cinema.dao.impl.BookingSeatDAOImpl;
import com.cinema.dao.impl.ComboDAOImpl;
import com.cinema.model.Movie;
import com.cinema.model.Seat;
import com.cinema.model.Showtime;
import com.cinema.model.User;
import com.cinema.model.Combo;
import com.cinema.utils.DBConnection;

@WebServlet("/booking-seat")
public class BookingSeatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final int HOLD_MINUTES = 10;

	private BookingSeatDAO bookingSeatDAO;
	private BookingDAO bookingDAO;
	private ShowtimeDAO showtimeDAO;
	private MovieDAO movieDAO;
	private SeatDAO seatDAO;
	private ComboDAO comboDAO;
	private com.cinema.dao.SeatPriceDAO seatPriceDAO;

	@Override
	public void init() {
		bookingSeatDAO = new BookingSeatDAOImpl();
		bookingDAO = new BookingDAO();
		showtimeDAO = new ShowtimeDAO();
		movieDAO = new MovieDAO();
		seatDAO = new SeatDAO();
		comboDAO = new ComboDAOImpl();
		seatPriceDAO = new com.cinema.dao.SeatPriceDAO();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String ajax = trim(req.getParameter("ajax"));
		if ("showtimes".equals(ajax)) {
			handleAjaxShowtimes(req, resp);
			return;
		}
		if ("dates".equals(ajax)) {
			handleAjaxDates(req, resp);
			return;
		}
		if ("seats".equals(ajax)) {
			handleAjaxSeats(req, resp);
			return;
		}

		// ===== Giữ form values =====
		String movieId = trim(req.getParameter("movieId"));
		String showDateRaw = trim(req.getParameter("showDate"));
		String showtimeId = trim(req.getParameter("showtimeId"));
		String ticketQty = trim(req.getParameter("ticketQty"));

		String showDate = normalizeToSqlDate(showDateRaw);
		
		req.setAttribute("movieId", movieId);
		req.setAttribute("showDate", showDate);
		req.setAttribute("showtimeId", showtimeId);
		req.setAttribute("ticketQty", ticketQty);

		// error message
		String err = trim(req.getParameter("error"));
		if (!err.isEmpty())
			req.setAttribute("error", err);

		Integer movieIdInt = parseIntOrNull(movieId);
		Movie currentMovie = null;

		// movies dropdown (luôn lấy danh sách phim để đảm bảo có dữ liệu)
		List<Movie> movies = movieDAO.findAll();
		req.setAttribute("movies", movies);
		
		// Load Combos for Step 2
		req.setAttribute("combos", comboDAO.findAll());
		
		if (movieIdInt != null) {
			// Kiểm tra xem phim đang chọn có trong danh sách đang chiếu không
			boolean exists = false;
			for(Movie m : movies) {
				if(m.getMovieId() == movieIdInt) { 
					exists = true; 
					currentMovie = m;
					break; 
				}
			}
			
			// Nếu phim không nằm trong list đang chiếu (ví dụ xem lại phim cũ), lấy riêng nó
			if(!exists) {
				currentMovie = movieDAO.findById(movieIdInt);
				if(currentMovie != null) req.setAttribute("selectedMovie", currentMovie);
			} else {
				req.setAttribute("selectedMovie", currentMovie);
			}
			
			// ✅ Chuẩn bị danh sách ngày từ DB cho phim này
			List<String> availableDates = showtimeDAO.getDistinctDatesByMovie(movieIdInt);
			req.setAttribute("availableDates", availableDates);
			
			// ✅ Nếu chưa chọn ngày nhưng có danh sách ngày, tự động lấy ngày đầu tiên
			if (showDate.isEmpty() && !availableDates.isEmpty()) {
				showDate = availableDates.get(0);
				req.setAttribute("showDate", showDate);
			}
		}

		// cleanup holds hết hạn
		try (Connection con = DBConnection.getConnection()) {
			con.setAutoCommit(false);
			bookingSeatDAO.releaseExpiredHolds(con, HOLD_MINUTES);
			con.commit();
		} catch (Exception ignore) {
		}

		// load showtimes theo movie + date
		if (movieIdInt != null && !showDate.isEmpty()) {
			req.setAttribute("showtimes", showtimeDAO.findByMovieAndDate(movieIdInt, showDate));
		}

		// ===== bookedSeats + seatList theo showtime =====
		Set<String> bookedSeats = new LinkedHashSet<>();
		List<Seat> seatList = null;

		Integer showtimeIdInt = parseIntOrNull(showtimeId);
		if (showtimeIdInt != null) {
			bookedSeats = bookingSeatDAO.findBookedSeatCodesByShowtime(showtimeIdInt, HOLD_MINUTES);

			try (Connection con = DBConnection.getConnection()) {
				int roomId = bookingDAO.findRoomIdByShowtime(con, showtimeIdInt);
				seatList = seatDAO.getSeatsByRoom(roomId);
				
				// Extract unique rows for the JSP grid
				if (seatList != null) {
					Set<String> rowSet = new TreeSet<>();
					for (Seat s : seatList) {
						rowSet.add(String.valueOf(s.getSeatRow()));
					}
					req.setAttribute("rows", rowSet);
				}
			} catch (Exception e) {
				e.printStackTrace();
				req.setAttribute("error", "Không tải được danh sách ghế.");
			}
		}

		req.setAttribute("seatList", seatList);
		req.setAttribute("bookedMap", toMap(bookedSeats));

		// selectedSeats từ session
		HttpSession session = req.getSession(false);
		@SuppressWarnings("unchecked")
		Set<String> selectedSeats = (session != null) ? (Set<String>) session.getAttribute("selectedSeats") : null;
		if (selectedSeats == null)
			selectedSeats = new LinkedHashSet<>();

		// MAP để JSP check
		req.setAttribute("bookedMap", toMap(bookedSeats));
		req.setAttribute("selectedMap", toMap(selectedSeats));
		req.setAttribute("selectedSeats", selectedSeats);
		req.setAttribute("seatPrices", seatPriceDAO.getAllSeatPrices());

		req.getRequestDispatcher("/pages/clients/booking/booking-ticket.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("authUser") == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}
		User u = (User) session.getAttribute("authUser");

		String movieId = trim(req.getParameter("movieId"));
		String showDateRaw = trim(req.getParameter("showDate"));
		String showDate = normalizeToSqlDate(showDateRaw);
		String showtimeIdStr = trim(req.getParameter("showtimeId"));
		String ticketQtyStr = trim(req.getParameter("ticketQty"));
		String[] seats = req.getParameterValues("seats");
		String ticketType = trim(req.getParameter("ticketType"));

		Integer showtimeId = parseIntOrNull(showtimeIdStr);
		if (showtimeId == null) {
			redirectBack(resp, req, movieId, showDate, showtimeIdStr, ticketQtyStr, "Vui lòng chọn suất chiếu.");
			return;
		}

		int qty = parseIntOrDefault(ticketQtyStr, 1);
		if (qty < 1 || qty > 10) {
			redirectBack(resp, req, movieId, showDate, showtimeIdStr, ticketQtyStr, "Số vé không hợp lệ (1-10).");
			return;
		}

		if (seats == null || seats.length == 0) {
			redirectBack(resp, req, movieId, showDate, showtimeIdStr, ticketQtyStr, "Vui lòng chọn ghế.");
			return;
		}

		if (seats.length != qty) {
			redirectBack(resp, req, movieId, showDate, showtimeIdStr, ticketQtyStr,
					"Số ghế phải bằng số vé đã chọn.");
			return;
		}

		// lưu selectedSeats để refresh không mất
		session.setAttribute("selectedSeats", new LinkedHashSet<>(Arrays.asList(seats)));

		Connection con = null;
		try {
			con = DBConnection.getConnection();
			con.setAutoCommit(false);

			bookingSeatDAO.releaseExpiredHolds(con, HOLD_MINUTES);

			int bookingId = bookingDAO.createPendingBooking(con, u.getUserId(), showtimeId);

			if (seats != null && seats.length > 0) {
				int roomId = bookingDAO.findRoomIdByShowtime(con, showtimeId);

				for (String code : seats) {
					Integer seatId = bookingDAO.findSeatIdByCode(con, roomId, code);
					if (seatId == null)
						throw new RuntimeException("INVALID_SEAT:" + code);

					bookingSeatDAO.insertSeat(con, bookingId, showtimeId, seatId, HOLD_MINUTES);
				}
			}

			con.commit();
			session.removeAttribute("selectedSeats");

			String actionType = req.getParameter("actionType");
			if ("checkout".equals(actionType)) {
				resp.sendRedirect(req.getContextPath() + "/booking/payment?bookingId=" + bookingId);
			} else {
				resp.sendRedirect(req.getContextPath() + "/booking/combo?bookingId=" + bookingId);
			}
			return;

		} catch (RuntimeException ex) {
			if (con != null)
				try {
					con.rollback();
				} catch (Exception ignore) {
				}

			if ("SEAT_TAKEN".equals(ex.getMessage())) {
				redirectBack(resp, req, movieId, showDate, showtimeIdStr, ticketQtyStr,
						"Ghế vừa có người khác đặt. Vui lòng chọn ghế khác.");
				return;
			}
			if (ex.getMessage() != null && ex.getMessage().startsWith("INVALID_SEAT:")) {
				redirectBack(resp, req, movieId, showDate, showtimeIdStr, ticketQtyStr,
						"Ghế không hợp lệ: " + ex.getMessage().substring("INVALID_SEAT:".length()));
				return;
			}
			throw new ServletException(ex);

		} catch (Exception e) {
			if (con != null)
				try {
					con.rollback();
				} catch (Exception ignore) {
				}
			throw new ServletException(e);

		} finally {
			if (con != null)
				try {
					con.close();
				} catch (Exception ignore) {
				}
		}
	}

	// ================= helpers =================
	private static Map<String, Boolean> toMap(Set<String> set) {
		Map<String, Boolean> m = new HashMap<>();
		for (String s : set)
			m.put(s, true);
		return m;
	}

	private static void redirectBack(HttpServletResponse resp, HttpServletRequest req, String movieId, String showDate,
			String showtimeId, String ticketQty, String msg) throws IOException {

		String ctx = req.getContextPath();
		StringBuilder sb = new StringBuilder(ctx).append("/booking-seat?error=")
				.append(URLEncoder.encode(msg, StandardCharsets.UTF_8.name()));

		if (!trim(movieId).isEmpty())
			sb.append("&movieId=").append(URLEncoder.encode(movieId, StandardCharsets.UTF_8.name()));
		if (!trim(showDate).isEmpty())
			sb.append("&showDate=").append(URLEncoder.encode(showDate, StandardCharsets.UTF_8.name()));
		if (!trim(showtimeId).isEmpty())
			sb.append("&showtimeId=").append(URLEncoder.encode(showtimeId, StandardCharsets.UTF_8.name()));
		if (!trim(ticketQty).isEmpty())
			sb.append("&ticketQty=").append(URLEncoder.encode(ticketQty, StandardCharsets.UTF_8.name()));

		resp.sendRedirect(sb.toString());
	}

	private static Integer parseIntOrNull(String s) {
		s = trim(s);
		if (s.isEmpty())
			return null;
		try {
			return Integer.parseInt(s);
		} catch (Exception e) {
			return null;
		}
	}

	private static int parseIntOrDefault(String s, int def) {
		s = trim(s);
		if (s.isEmpty())
			return def;
		try {
			return Integer.parseInt(s);
		} catch (Exception e) {
			return def;
		}
	}

	private static String trim(String s) {
		return s == null ? "" : s.trim();
	}

	// ✅ Chuẩn hoá ngày để query DB + input type="date"
	private static String normalizeToSqlDate(String s) {
		s = trim(s);
		if (s.isEmpty())
			return "";
		// yyyy-MM-dd (chuẩn)
		if (s.matches("\\d{4}-\\d{2}-\\d{2}"))
			return s; 
		// dd/MM/yyyy hoặc d/m/yyyy
		if (s.matches("\\d{1,2}/\\d{1,2}/\\d{4}")) { 
			String[] p = s.split("/");
			String d = p[0].length() == 1 ? "0" + p[0] : p[0];
			String m = p[1].length() == 1 ? "0" + p[1] : p[1];
			return p[2] + "-" + m + "-" + d;
		}
		// yyyy/MM/dd
		if (s.matches("\\d{4}/\\d{1,2}/\\d{1,2}"))
			return s.replace('/', '-'); 
		return s;
	}
	private void handleAjaxDates(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");

		Integer movieId = parseIntOrNull(req.getParameter("movieId"));
		if (movieId == null) {
			resp.getWriter().write("[]");
			return;
		}

		List<String> dates = showtimeDAO.getDistinctDatesByMovie(movieId);
		System.out.println("AJAX getDistinctDatesByMovie: movieId=" + movieId + " -> found " + dates.size() + " dates");
		StringBuilder json = new StringBuilder("[");
		for (int i = 0; i < dates.size(); i++) {
			json.append("\"").append(dates.get(i)).append("\"");
			if (i < dates.size() - 1)
				json.append(",");
		}
		json.append("]");
		resp.getWriter().write(json.toString());
	}

	private void handleAjaxShowtimes(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");

		Integer movieId = parseIntOrNull(req.getParameter("movieId"));
		String showDate = normalizeToSqlDate(req.getParameter("showDate"));

		if (movieId == null || showDate.isEmpty()) {
			resp.getWriter().write("[]");
			return;
		}

		List<ShowtimeView> list = showtimeDAO.findByMovieAndDate(movieId, showDate);
		System.out.println("AJAX findByMovieAndDate: movieId=" + movieId + ", date=" + showDate + " -> found " + list.size() + " showtimes");
		StringBuilder json = new StringBuilder("[");
		for (int i = 0; i < list.size(); i++) {
			ShowtimeView st = list.get(i);
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("HH:mm");
			String timeRange = sdf.format(st.getStartTime()) + " - " + sdf.format(st.getEndTime());

			json.append("{").append("\"id\":").append(st.getShowtimeId()).append(",").append("\"time\":\"")
					.append(timeRange).append("\",").append("\"room\":\"").append(st.getRoomName()).append("\",")
					.append("\"price\":").append(st.getPrice())
					.append("}");
			if (i < list.size() - 1)
				json.append(",");
		}
		json.append("]");
		resp.getWriter().write(json.toString());
	}

	private void handleAjaxSeats(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");

		Integer showtimeId = parseIntOrNull(req.getParameter("showtimeId"));
		if (showtimeId == null) {
			resp.getWriter().write("{}");
			return;
		}

		Set<String> booked = bookingSeatDAO.findBookedSeatCodesByShowtime(showtimeId, HOLD_MINUTES);
		Set<String> rowSet = new TreeSet<>();

		List<Seat> seatList = null;
		try (Connection con = DBConnection.getConnection()) {
			int roomId = bookingDAO.findRoomIdByShowtime(con, showtimeId);
			seatList = seatDAO.getSeatsByRoom(roomId);
			if (seatList != null) {
				for (Seat s : seatList) {
					rowSet.add(String.valueOf(s.getSeatRow()));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		StringBuilder json = new StringBuilder("{");

		// rows
		json.append("\"rows\":[");
		int idx = 0;
		for (String r : rowSet) {
			json.append("\"").append(r).append("\"");
			if (++idx < rowSet.size())
				json.append(",");
		}
		json.append("],");

		// booked
		json.append("\"booked\":[");
		idx = 0;
		for (String b : booked) {
			json.append("\"").append(b).append("\"");
			if (++idx < booked.size())
				json.append(",");
		}
		json.append("],");

		// seats (full info for layout & pricing)
		json.append("\"seats\":[");
		if (seatList != null) {
			for (int i = 0; i < seatList.size(); i++) {
				Seat s = seatList.get(i);
				String typeName = (s.getSeatType() != null) ? s.getSeatType().name() : "NORMAL";
				json.append("{")
					.append("\"code\":\"").append(s.getSeatRow()).append(s.getSeatNumber()).append("\",")
					.append("\"type\":\"").append(typeName).append("\",")
					.append("\"r\":").append(s.getGridRow() != null ? s.getGridRow() : "null").append(",")
					.append("\"c\":").append(s.getGridCol() != null ? s.getGridCol() : "null")
					.append("}");
				if (i < seatList.size() - 1) json.append(",");
			}
		}
		json.append("],");
		
		// roomInfo
		json.append("\"roomInfo\":{")
			.append("\"total\":").append(seatList != null ? seatList.size() : 0)
			.append("}");

		json.append("}");
		resp.getWriter().write(json.toString());
	}

}
