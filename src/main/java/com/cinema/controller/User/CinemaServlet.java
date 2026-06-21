package com.cinema.controller.User;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/cinema")
public class CinemaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// 1. Tạo dữ liệu Rạp (Cinema)
		Map<String, Object> cinema = new HashMap<>();
		cinema.put("name", "BOBIXI Premium - Đà Nẵng");
		cinema.put("address", "82/83 Nguyễn Lương Bằng, Liên Chiểu, Đà Nẵng");
		cinema.put("phone", "0236 3736 888");
		cinema.put("openingHours", "08:00 - 24:00");
		cinema.put("description", "Tọa lạc tại khu vực sầm uất bậc nhất Liên Chiểu, BOBIXI Premium Đà Nẵng mang đến không gian điện ảnh sang trọng với thiết kế hiện đại, hệ thống âm thanh vòm đỉnh cao và dịch vụ khách hàng chuyên nghiệp, hứa hẹn là điểm đến giải trí lý tưởng cho giới trẻ Đà Thành.");
		cinema.put("totalScreens", 10);
		cinema.put("hasIMAX", true);
		cinema.put("has4DX", true);
		cinema.put("hasGoldClass", true);
		cinema.put("busDirections", "Các tuyến xe buýt R16, R14 đi qua điểm dừng Nguyễn Lương Bằng.");
		cinema.put("carDirections", "Khu vực đậu xe rộng rãi ngay phía trước rạp, hoàn toàn miễn phí.");
		cinema.put("latitude", 16.0594);
		cinema.put("longitude", 108.1504);

		// Thêm bảng giá (Pricing Tables)
		List<Map<String, Object>> pricingTables = new ArrayList<>();
		
		Map<String, Object> standardTable = new HashMap<>();
		standardTable.put("name", "GIÁ VÉ 2D TIÊU CHUẨN");
		List<Map<String, Object>> rows = new ArrayList<>();
		
		Map<String, Object> row1 = new HashMap<>();
		row1.put("seatType", "GHẾ ĐƠN");
		row1.put("prices", new double[]{85000.0});
		rows.add(row1);
		
		Map<String, Object> row2 = new HashMap<>();
		row2.put("seatType", "GHẾ VIP");
		row2.put("prices", new double[]{105000.0});
		rows.add(row2);
		
		standardTable.put("rows", rows);
		pricingTables.add(standardTable);
		cinema.put("pricingTables", pricingTables);

		request.setAttribute("cinema", cinema);

		// 2. Tạo danh sách ngày chiếu (Available Dates)
		List<Date> availableDates = new ArrayList<>();
		long today = System.currentTimeMillis();
		for(int i=0; i<7; i++) {
			availableDates.add(new Date(today + (i * 24 * 60 * 60 * 1000L)));
		}
		request.setAttribute("availableDates", availableDates);

		// 3. Tạo danh sách lịch chiếu phim (Showtimes)
		List<Map<String, Object>> showtimes = new ArrayList<>();
		
		// Phim 1
		Map<String, Object> m1 = new HashMap<>();
		Map<String, Object> movie1 = new HashMap<>();
		movie1.put("title", "Kẻ Phản Diện Bi Quan");
		movie1.put("genre", "Hành Động, Viễn Tưởng");
		movie1.put("duration", 125);
		movie1.put("rating", "T16");
		movie1.put("posterImage", "movie1.jpg");
		m1.put("movie", movie1);
		
		List<Map<String, Object>> formatGroups = new ArrayList<>();
		Map<String, Object> fg1 = new HashMap<>();
		fg1.put("format", "2D PHỤ ĐỀ EN");
		fg1.put("hasSubtitle", true);
		
		List<Map<String, Object>> times = new ArrayList<>();
		Map<String, Object> t1 = new HashMap<>();
		t1.put("id", 1);
		t1.put("startTime", new Date(today + (2 * 60 * 60 * 1000L)));
		t1.put("availableSeats", 45);
		times.add(t1);
		
		Map<String, Object> t2 = new HashMap<>();
		t2.put("id", 2);
		t2.put("startTime", new Date(today + (5 * 60 * 60 * 1000L)));
		t2.put("availableSeats", 12);
		times.add(t2);
		
		fg1.put("showtimes", times);
		formatGroups.add(fg1);
		m1.put("formatGroups", formatGroups);
		showtimes.add(m1);

		request.setAttribute("showtimes", showtimes);
		
		RequestDispatcher rq = request.getRequestDispatcher("/pages/clients/cinema/cinema-detail.jsp");
		rq.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
