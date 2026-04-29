<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.cinema.dao.BookingAdminDAO.BookingDetail" %>
<%@ page import="com.cinema.dao.BookingAdminDAO.ComboLine" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"/>
  <title>Admin - Chi tiết Booking</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body{ background: linear-gradient(180deg,#2e2a44 0%,#1f1b2e 100%); color:#e5e7eb; min-height:100vh; }
    .cardx{ background: rgba(46,42,68,.85); border:1px solid rgba(255,255,255,.12); border-radius:16px; }
    .tbl th{ background: rgba(124,58,237,.25); color:#fff; }
    .tbl td,.tbl th{ border-color: rgba(255,255,255,.12) !important; vertical-align: middle; }
    .pill{ display:inline-block; padding:6px 10px; border-radius:999px; background:rgba(124,58,237,.18); border:1px solid rgba(255,255,255,.12); margin:4px; }
    .muted{ color: rgba(229,231,235,.75); }
  </style>
</head>
<body class="p-4">
<div class="container">

  <%
    BookingDetail detail = (BookingDetail) request.getAttribute("detail");
  %>

  <div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="m-0">ADMIN • Chi tiết Booking</h3>
    <a class="btn btn-outline-light" href="<%=request.getContextPath()%>/admin/bookings">← Quay lại danh sách</a>
  </div>

  <% if (detail == null) { %>
    <div class="alert alert-danger">Không tìm thấy booking hoặc bookingId không hợp lệ.</div>
  <% } else { %>

  <div class="cardx p-3 mb-3">
    <div class="row g-2">
      <div class="col-md-3"><b>ID:</b> <%= detail.getBookingId() %></div>
      <div class="col-md-3"><b>User:</b> <%= detail.getUserId() %></div>
      <div class="col-md-3"><b>Phim:</b> <%= detail.getMovieTitle() %></div>
      <div class="col-md-3"><b>Phòng:</b> <%= detail.getRoomName() %></div>

      <div class="col-md-6"><b>Start:</b> <span class="muted"><%= detail.getStartTime() %></span></div>
      <div class="col-md-6"><b>End:</b> <span class="muted"><%= detail.getEndTime() %></span></div>
    </div>

    <hr class="border-light opacity-25"/>

    <div class="row g-2">
      <div class="col-md-3"><b>Giá vé:</b> <%= detail.getTicketPrice() %></div>
      <div class="col-md-3"><b>Số ghế:</b> <%= detail.getSeatCount() %></div>
      <div class="col-md-3"><b>Tiền vé:</b> <%= detail.getTicketSubtotal() %></div>
      <div class="col-md-3"><b>Tiền combo:</b> <%= detail.getComboSubtotal() %></div>
      <div class="col-md-12 mt-2"><b>Tổng:</b> <span class="fw-bold"><%= detail.getGrandTotal() %></span></div>
      <div class="col-md-12"><b>Status:</b> <span class="muted"><%= detail.getStatus() %></span></div>
    </div>
  </div>

  <div class="row g-3">
    <!-- Seats -->
    <div class="col-lg-6">
      <div class="cardx p-3">
        <h5 class="fw-bold">VÉ / GHẾ ĐÃ ĐẶT</h5>
        <div>
          <%
            List<String> seats = detail.getSeats();
            if (seats == null || seats.isEmpty()) {
          %>
              <div class="text-white-50">Chưa có ghế</div>
          <%
            } else {
              for (String s : seats) {
          %>
              <span class="pill"><%= s %></span>
          <%
              }
            }
          %>
        </div>
      </div>
    </div>

    <!-- Combos -->
    <div class="col-lg-6">
      <div class="cardx p-3">
        <h5 class="fw-bold">COMBO ĐÃ CHỌN</h5>

        <div class="table-responsive">
          <table class="table table-dark tbl">
            <thead>
              <tr>
                <th>Tên combo</th>
                <th>Giá</th>
                <th>SL</th>
                <th>Thành tiền</th>
              </tr>
            </thead>
            <tbody>
            <%
              List<ComboLine> combos = detail.getCombos();
              if (combos == null || combos.isEmpty()) {
            %>
              <tr><td colspan="4" class="text-center text-white-50">Không có combo</td></tr>
            <%
              } else {
                for (ComboLine c : combos) {
                  BigDecimal lineTotal = (c.getLineTotal() != null) ? c.getLineTotal()
                      : ( (c.getPrice()==null?BigDecimal.ZERO:c.getPrice()).multiply(BigDecimal.valueOf(c.getQuantity())) );
            %>
              <tr>
                <td><%= c.getName() %></td>
                <td><%= c.getPrice() %></td>
                <td><%= c.getQuantity() %></td>
                <td><%= lineTotal %></td>
              </tr>
            <%
                }
              }
            %>
            </tbody>
          </table>
        </div>

      </div>
    </div>
  </div>

  <% } %>

</div>
</body>
</html>
