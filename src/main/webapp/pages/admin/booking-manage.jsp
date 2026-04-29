<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.cinema.dao.BookingAdminDAO.BookingRow" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"/>
  <title>Admin - Quản lí Booking</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body{ background: linear-gradient(180deg,#2e2a44 0%,#1f1b2e 100%); color:#e5e7eb; min-height:100vh; }
    .cardx{ background: rgba(46,42,68,.85); border:1px solid rgba(255,255,255,.12); border-radius:16px; }
    .btnx{ border-radius:12px; font-weight:800; }
    .tbl th{ background: rgba(124,58,237,.25); color:#fff; }
    .tbl td,.tbl th{ border-color: rgba(255,255,255,.12) !important; vertical-align: middle; }
    select{ background: rgba(31,27,46,.9) !important; color:#e5e7eb !important; border:1px solid rgba(255,255,255,.15) !important; }
  </style>
</head>
<body class="p-4">
<div class="container">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="m-0">ADMIN • Quản lí Booking (Vé + Combo)</h3>
    <a class="btn btn-outline-light btnx" href="<%=request.getContextPath()%>/pages/admin/dashboard.jsp">Về Dashboard</a>
  </div>

  <%
    List<BookingRow> bookingList = (List<BookingRow>) request.getAttribute("bookingList");
    if (bookingList == null) bookingList = new ArrayList<>();
  %>

  <div class="cardx p-3">
    <div class="table-responsive">
      <table class="table table-dark table-hover tbl">
        <thead>
          <tr>
            <th>ID</th>
            <th>Phim</th>
            <th>Phòng</th>
            <th>Bắt đầu</th>
            <th>Ghế</th>
            <th>Tiền vé</th>
            <th>Tiền combo</th>
            <th>Tổng</th>
            <th>Trạng thái</th>
            <th style="width:320px;">Thao tác</th>
          </tr>
        </thead>
        <tbody>
        <% if (bookingList.isEmpty()) { %>
          <tr><td colspan="10" class="text-center text-white-50">Chưa có booking</td></tr>
        <% } else {
             for (BookingRow b : bookingList) {
        %>
          <tr>
            <td><%= b.getBookingId() %></td>
            <td><%= b.getMovieTitle() %></td>
            <td><%= b.getRoomName() %></td>
            <td><%= b.getStartTime() %></td>
            <td><%= b.getSeatCount() %></td>
            <td><%= b.getTicketSubtotal() %></td>
            <td><%= b.getComboSubtotal() %></td>
            <td><%= b.getGrandTotal() %></td>
            <td><%= b.getStatus() %></td>
            <td>
              <a class="btn btn-warning btnx"
                 href="<%=request.getContextPath()%>/admin/bookings?bookingId=<%=b.getBookingId()%>">
                 Chi tiết
              </a>

              <form class="d-inline" action="<%=request.getContextPath()%>/admin/bookings" method="post">
                <input type="hidden" name="action" value="status"/>
                <input type="hidden" name="bookingId" value="<%=b.getBookingId()%>"/>
                <select name="status" class="form-select form-select-sm d-inline-block" style="width:130px;">
                  <option value="PAID" <%= "PAID".equals(b.getStatus())?"selected":"" %>>PAID</option>
                  <option value="CANCELLED" <%= "CANCELLED".equals(b.getStatus())?"selected":"" %>>CANCELLED</option>
                  <option value="PENDING" <%= "PENDING".equals(b.getStatus())?"selected":"" %>>PENDING</option>
                </select>
                <button class="btn btn-success btnx btn-sm" type="submit">Lưu</button>
              </form>
            </td>
          </tr>
        <% } } %>
        </tbody>
      </table>
    </div>
  </div>

</div>
</body>
</html>
