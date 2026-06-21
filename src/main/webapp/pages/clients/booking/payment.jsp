<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.cinema.model.Seat" %>
<%@ page import="com.cinema.views.BookingComboDetail" %>
<jsp:include page="/common/header.jsp" />
<%
  String ctx = request.getContextPath();

  Object bookingIdObj = request.getAttribute("bookingId");
  String bookingIdStr = (bookingIdObj != null) ? String.valueOf(bookingIdObj) : request.getParameter("bookingId");
  if (bookingIdStr == null) bookingIdStr = "";

  List<Seat> seatList = null;
  Object seatObj = request.getAttribute("seatList");
  if (seatObj instanceof List) seatList = (List<Seat>) seatObj;

  List<BookingComboDetail> comboList = null;
  Object comboObj = request.getAttribute("comboList");
  if (comboObj instanceof List) comboList = (List<BookingComboDetail>) comboObj;

  BigDecimal ticketPrice = (BigDecimal) request.getAttribute("ticketPrice");
  BigDecimal ticketSubtotal = (BigDecimal) request.getAttribute("ticketSubtotal");
  BigDecimal comboSubtotal = (BigDecimal) request.getAttribute("comboSubtotal");
  BigDecimal grandTotal = (BigDecimal) request.getAttribute("grandTotal");

  if (ticketPrice == null) ticketPrice = BigDecimal.ZERO;
  if (ticketSubtotal == null) ticketSubtotal = BigDecimal.ZERO;
  if (comboSubtotal == null) comboSubtotal = BigDecimal.ZERO;
  if (grandTotal == null) grandTotal = BigDecimal.ZERO;

  int seatCount = (seatList == null) ? 0 : seatList.size();

  DecimalFormat df = new DecimalFormat("#,##0");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Thanh toán</title>
</head>

<body>
<div class="payment-info-page">
  <!-- HERO -->
  <div class="page-header">
    <div class="header-overlay">
      <h1>Thanh toán</h1>
      <p>Kiểm tra vé – ghế – combo và xác nhận thanh toán</p>
    </div>
  </div>

  <div class="payment-container">
    <% if ("1".equals(request.getParameter("success"))) { %>
      <!-- SUCCESS TICKET VIEW -->
      <section class="success-ticket-section">
        <div class="ticket-wrapper">
            <div class="ticket-card">
                <div class="ticket-left">
                    <div class="ticket-header">
                        <div class="brand">BOBIXI CINEMA</div>
                        <div class="ticket-type">VÉ XEM PHIM</div>
                    </div>
                    <div class="ticket-body">
                        <div class="movie-title">Phim: ${seatList[0].movieName != null ? seatList[0].movieName : "Phim đang đặt"}</div>
                        <div class="ticket-info-grid">
                            <div class="info-item">
                                <div class="info-label">NGÀY</div>
                                <div class="info-value">Hôm nay</div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">SUẤT CHIẾU</div>
                                <div class="info-value">Theo lịch</div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">PHÒNG</div>
                                <div class="info-value"><%= (seatList != null && !seatList.isEmpty()) ? seatList.get(0).getRoomId() : "1" %></div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">GHẾ</div>
                                <div class="info-value">
                                    <% if (seatList != null) { 
                                        for(int i=0; i<seatList.size(); i++) {
                                            out.print(seatList.get(i).getSeatRow() + seatList.get(i).getSeatNumber() + (i < seatList.size()-1 ? ", " : ""));
                                        }
                                    } %>
                                </div>
                            </div>
                        </div>
                        <div class="ticket-footer">
                            <div class="booking-id">Mã vé: #<%= bookingIdStr %></div>
                            <div class="expiry-note">Hạn dùng: Đến khi suất chiếu kết thúc</div>
                        </div>
                    </div>
                </div>
                <div class="ticket-right">
                    <div class="qr-container">
                        <img src="https://chart.googleapis.com/chart?chs=180x180&cht=qr&chl=BOBIXI-<%= bookingIdStr %>-SUCCESS" alt="QR Code">
                        <div class="qr-label">QUÉT MÃ VÀO RẠP</div>
                    </div>
                    <div class="cut-line"></div>
                </div>
            </div>
            <div class="ticket-actions mt-5">
                <a href="<%= ctx %>/home" class="btn-confirm" style="text-decoration:none; display:inline-block; text-align:center;">VỀ TRANG CHỦ</a>
                <a href="<%= ctx %>/profile" class="btn-outline" style="text-decoration:none; display:inline-block; text-align:center;">XEM VÉ ĐÃ MUA</a>
            </div>
        </div>
      </section>
      
      <style>
          .ticket-wrapper { max-width: 800px; margin: 40px auto; }
          .ticket-card { display: flex; background: #fff; border-radius: 20px; overflow: hidden; box-shadow: 0 20px 50px rgba(0,0,0,0.2); min-height: 350px; position: relative; }
          .ticket-left { flex: 1; padding: 40px; border-right: 2px dashed #eee; background: #fff; }
          .ticket-right { width: 240px; background: #0f172a; color: #fff; display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 30px; position: relative; }
          .ticket-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
          .brand { font-weight: 900; color: #e71a0f; font-size: 1.2rem; }
          .ticket-type { background: #0f172a; color: #fff; padding: 4px 12px; border-radius: 4px; font-size: 0.7rem; font-weight: 800; }
          .movie-title { font-size: 2rem; font-weight: 900; color: #0f172a; margin-bottom: 25px; line-height: 1.1; }
          .ticket-info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
          .info-label { font-size: 0.7rem; color: #94a3b8; font-weight: 800; }
          .info-value { font-size: 1.1rem; color: #0f172a; font-weight: 800; }
          .ticket-footer { margin-top: 40px; padding-top: 20px; border-top: 1px solid #f1f5f9; display: flex; justify-content: space-between; align-items: center; }
          .booking-id { font-weight: 900; color: #64748b; }
          .expiry-note { font-size: 0.75rem; color: #ef4444; font-weight: 700; font-style: italic; }
          .qr-container { text-align: center; }
          .qr-container img { background: #fff; padding: 10px; border-radius: 12px; margin-bottom: 15px; width: 100%; }
          .qr-label { font-weight: 900; font-size: 0.8rem; letter-spacing: 2px; opacity: 0.8; }
          .cut-line { position: absolute; left: -10px; top: 0; bottom: 0; width: 20px; background-image: radial-gradient(#f5f5f5 5px, transparent 5px); background-size: 20px 20px; }
          .mt-5 { margin-top: 30px; }
          @media (max-width: 768px) {
              .ticket-card { flex-direction: column; }
              .ticket-right { width: 100%; border-left: none; border-top: 2px dashed #eee; }
              .cut-line { display: none; }
          }
      </style>
    <% } else { %>
      <!-- OVERVIEW (Original Payment Content) -->
      <section class="payment-overview">
      <h2>Thanh toán nhanh – gọn – an toàn</h2>
      <p class="overview-text">
        Bạn vui lòng kiểm tra lại ghế, combo và tổng tiền trước khi xác nhận.
        Mọi giao dịch đều được mã hóa và xử lý qua cổng thanh toán an toàn.
      </p>
    </section>

    <!-- ORDER SUMMARY -->
    <section class="order-summary">
      <h2>Thông tin đặt vé</h2>

      <div class="summary-grid">
        <!-- Tickets/Seats -->
        <div class="summary-card">
          <div class="summary-head">
            <div class="summary-icon">🎟️</div>
            <div>
              <h3>Vé & Ghế</h3>
              <p class="muted">
                Ghế bạn đã chọn cho booking #
                <b><%= bookingIdStr %></b>
                • <b><%= seatCount %></b> ghế
              </p>
            </div>
          </div>

          <div class="seat-tags">
            <%
              if (seatList == null || seatList.isEmpty()) {
            %>
              <div class="empty-box">Chưa có ghế nào được chọn.</div>
            <%
              } else {
                for (Seat s : seatList) {
                  String label = "" + s.getSeatRow() + s.getSeatNumber();
                  String type = (s.getSeatType() != null) ? s.getSeatType().name() : "NORMAL";
            %>
                <span class="seat-badge">
                  <%= label %>
                  <span class="seat-type"><%= type %></span>
                </span>
            <%
                }
              }
            %>
          </div>

          <div class="price-lines">
            <div class="line">
              <span class="label">Giá vé / ghế</span>
              <span class="value"><%= df.format(ticketPrice) %> VNĐ</span>
            </div>

            <div class="line">
              <span class="label">Tiền vé</span>
              <span class="value strong"><%= df.format(ticketSubtotal) %> VNĐ</span>
            </div>
          </div>
        </div>

        <!-- Combos -->
        <div class="summary-card">
          <div class="summary-head">
            <div class="summary-icon">🍿</div>
            <div>
              <h3>Combo</h3>
              <p class="muted">Bắp – nước – snack tuỳ chọn</p>
            </div>
          </div>

          <div class="combo-table-wrap">
            <table class="combo-table">
              <thead>
                <tr>
                  <th>Tên</th>
                  <th class="right">Giá</th>
                  <th class="center">SL</th>
                  <th class="right">Thành tiền</th>
                </tr>
              </thead>
              <tbody>
                <%
                  if (comboList == null || comboList.isEmpty()) {
                %>
                  <tr>
                    <td colspan="4" class="empty-cell">Chưa chọn combo.</td>
                  </tr>
                <%
                  } else {
                    for (BookingComboDetail c : comboList) {
                      BigDecimal price = (c.getPrice() != null) ? c.getPrice() : BigDecimal.ZERO;
                      int qty = c.getQuantity();
                      BigDecimal lineTotal = price.multiply(new BigDecimal(qty));
                %>
                  <tr>
                    <td class="name"><%= c.getComboName() %></td>
                    <td class="right"><%= df.format(price) %></td>
                    <td class="center"><%= qty %></td>
                    <td class="right strong"><%= df.format(lineTotal) %></td>
                  </tr>
                <%
                    }
                  }
                %>
              </tbody>
            </table>
          </div>

          <div class="price-lines">
            <div class="line">
              <span class="label">Tiền combo</span>
              <span class="value strong"><%= df.format(comboSubtotal) %> VNĐ</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Voucher Section -->
      <div class="voucher-card animate-fade-in">
        <div class="voucher-head">
          <i class="fas fa-ticket-alt"></i>
          <span>Bạn có mã giảm giá?</span>
        </div>
        <div class="voucher-body">
          <div class="input-group">
            <input type="text" id="voucherCode" class="form-control shadow-none" placeholder="Nhập mã (VD: BOBIXI50)">
            <button class="btn btn-apply" id="btnApplyVoucher" type="button">Áp dụng</button>
          </div>
          <div id="voucherMessage" class="mt-2 small" style="display: none;"></div>
        </div>
      </div>

      <!-- Total + actions -->
      <div class="total-card">
        <div class="total-left">
          <div class="total-title">Tổng thanh toán</div>
          <div class="total-sub">Bao gồm tiền vé và combo</div>
          <div id="discountInfo" class="discount-text" style="display: none;">
            Giảm giá: -<span id="discountValueDisplay">0</span>đ
          </div>
        </div>
        <div class="total-right">
          <div class="total-value" id="finalTotalDisplay" data-original="<%= grandTotal %>">
            <%= df.format(grandTotal) %> VNĐ
          </div>
        </div>
      </div>

      <div class="cta-row">
        <form action="<%= ctx %>/booking/payment" method="post" class="cta-form" id="paymentForm">
          <input type="hidden" name="bookingId" value="<%= bookingIdStr %>">
          <input type="hidden" name="voucherCode" id="appliedVoucherCode" value="">
          <button type="submit" class="btn-confirm">Xác nhận thanh toán</button>
        </form>

        <a class="btn-outline" href="<%= ctx %>/booking/combo<%= bookingIdStr.isEmpty() ? "" : ("?bookingId=" + bookingIdStr) %>">
          Quay lại chọn combo
        </a>
      </div>
    </section>

    <!-- PAYMENT METHODS GRID -->
    <section class="payment-methods-section">
      <h2>Phương thức thanh toán</h2>

      <div class="payment-grid">
        <div class="payment-card method-card" onclick="selectMethod('ATM', this)">
          <div class="card-header">
            <div class="fake-img">🏦</div>
            <h3>Thẻ ATM / Internet Banking</h3>
          </div>
          <div class="card-body">
            <p class="card-description">Thanh toán qua cổng nội địa an toàn.</p>
          </div>
        </div>

        <div class="payment-card method-card active" onclick="selectMethod('QR', this)" style="border: 2px solid #e71a0f;">
          <div class="card-header" style="background: linear-gradient(135deg, #fff5f5 0%, #ffe3e3 100%);">
            <div class="fake-img" style="background: #fff; border: 1px solid #ffc9c9;">📸</div>
            <h3>Chuyển khoản QR</h3>
          </div>
          <div class="card-body">
            <p class="card-description">Quét mã VietQR bằng ứng dụng Ngân hàng.</p>
            <div class="features">
               <div class="feature-item"><span class="dot ok"></span><span>Xác thực tức thì</span></div>
               <div class="feature-item"><span class="dot ok"></span><span>Không phí giao dịch</span></div>
            </div>
          </div>
        </div>

        <div class="payment-card method-card" onclick="selectMethod('CASH', this)">
          <div class="card-header">
            <div class="fake-img">🎫</div>
            <h3>Thanh toán tại quầy</h3>
          </div>
          <div class="card-body">
            <p class="card-description">Nhận vé và trả tiền trực tiếp tại rạp.</p>
          </div>
        </div>
      </div>

      <!-- QR Display Area (Show when method is QR) -->
      <div id="qrDisplay" class="mt-5 text-center" style="display: block;">
          <div class="glass-card d-inline-block p-4" style="background: #fff; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
              <h4 class="text-dark fw-bold mb-3">QUÉT MÃ ĐỂ THANH TOÁN</h4>
              <img id="vietqrImg" src="https://img.vietqr.io/image/MB-0348259461-compact.png?amount=<%= grandTotal %>&addInfo=BOBIXI%20<%= bookingIdStr %>&accountName=TRAN%20VAN%20ANH" 
                   alt="VietQR" style="width: 300px; border-radius: 10px;">
              <div class="mt-3 text-muted small">Nội dung: <b>BOBIXI <%= bookingIdStr %></b></div>
          </div>
      </div>

      <script>
          function selectMethod(method, el) {
              document.querySelectorAll('.method-card').forEach(c => {
                  c.style.border = 'none';
                  c.classList.remove('active');
              });
              el.style.border = '2px solid #e71a0f';
              el.classList.add('active');
              document.getElementById('selectedMethod').value = method;
              
              const qrDisplay = document.getElementById('qrDisplay');
              if (method === 'QR') {
                  qrDisplay.style.display = 'block';
              } else {
                  qrDisplay.style.display = 'none';
              }
          }
      </script>

      <div class="cta-row mt-5">
        <form action="<%= ctx %>/booking/payment/confirm" method="post" class="cta-form" style="max-width: 500px; margin: 0 auto;">
          <input type="hidden" name="bookingId" value="<%= bookingIdStr %>">
          <input type="hidden" name="method" id="selectedMethod" value="QR">
          <button type="submit" class="btn-confirm" style="font-size: 1.2rem; padding: 20px;">XÁC NHẬN ĐÃ THANH TOÁN</button>
        </form>
      </div>
    </section>

    <!-- PROCESS -->
    <section class="payment-process">
      <h2>Quy trình thanh toán</h2>
      <div class="process-steps">
        <div class="step">
          <div class="step-number">1</div>
          <h4>Chọn phim & ghế</h4>
          <p>Lựa chọn suất chiếu và ghế yêu thích</p>
        </div>

        <div class="step-arrow">→</div>

        <div class="step">
          <div class="step-number">2</div>
          <h4>Chọn combo</h4>
          <p>Thêm bắp – nước theo nhu cầu</p>
        </div>

        <div class="step-arrow">→</div>

        <div class="step">
          <div class="step-number">3</div>
          <h4>Thanh toán</h4>
          <p>Kiểm tra đơn và xác nhận thanh toán</p>
        </div>

        <div class="step-arrow">→</div>

        <div class="step">
          <div class="step-number">4</div>
          <h4>Nhận vé</h4>
          <p>Nhận mã và vào rạp xem phim</p>
        </div>
      </div>
    </section>

    <!-- SECURITY -->
    <section class="security-section">
      <h2>Bảo mật thanh toán</h2>
      <div class="security-features">
        <div class="security-item">
          <div class="sec-icon">🛡️</div>
          <h4>Mã hóa SSL</h4>
          <p>Thông tin giao dịch được mã hóa và bảo vệ tối đa.</p>
        </div>

        <div class="security-item">
          <div class="sec-icon">🔒</div>
          <h4>Xác thực an toàn</h4>
          <p>Tăng cường bảo mật bằng OTP/biện pháp xác thực.</p>
        </div>

        <div class="security-item">
          <div class="sec-icon">✅</div>
          <h4>Chuẩn bảo mật</h4>
          <p>Tuân thủ tiêu chuẩn bảo mật thanh toán phổ biến.</p>
        </div>

        <div class="security-item">
          <div class="sec-icon">🙈</div>
          <h4>Không lưu thẻ</h4>
          <p>Hạn chế lưu thông tin nhạy cảm trên hệ thống.</p>
        </div>
      </div>
    </section>

  </div>
</div>

<style>
  .payment-info-page{ background:#f5f5f5; }

  .page-header{
    height: 420px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    display:flex; align-items:center; justify-content:center;
  }
  .header-overlay{ text-align:center; color:#fff; padding: 0 18px; }
  .header-overlay h1{ font-size:56px; margin-bottom:16px; }
  .header-overlay p{ font-size:22px; opacity:.92; }

  .payment-container{
    max-width: 1400px;
    margin: -90px auto 0;
    padding: 0 20px 90px;
  }

  section{ margin-bottom: 80px; }
  section h2{
    font-size: 42px;
    text-align:center;
    margin-bottom: 46px;
    color:#333;
  }

  .payment-overview{
    background:#fff;
    padding: 60px;
    border-radius: 20px;
    text-align:center;
    box-shadow: 0 10px 40px rgba(0,0,0,.1);
  }
  .overview-text{
    font-size: 20px;
    line-height: 1.8;
    color:#666;
    max-width: 900px;
    margin: 0 auto;
  }

  /* ORDER SUMMARY */
  .summary-grid{
    display:grid;
    grid-template-columns: repeat(2, minmax(0,1fr));
    gap: 24px;
  }
  .summary-card{
    background:#fff;
    border-radius: 20px;
    box-shadow: 0 5px 20px rgba(0,0,0,.08);
    overflow:hidden;
  }
  .summary-head{
    display:flex;
    gap: 14px;
    padding: 22px 22px 12px;
    align-items:flex-start;
  }
  .summary-icon{
    width: 44px; height:44px;
    display:flex; align-items:center; justify-content:center;
    border-radius: 14px;
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-size: 22px;
    flex: 0 0 44px;
  }
  .summary-head h3{
    margin: 0;
    font-size: 22px;
    color:#333;
  }
  .muted{ margin: 6px 0 0; color:#777; font-size:14.5px; }

  .seat-tags{
    padding: 0 22px 10px;
    display:flex;
    flex-wrap:wrap;
    gap: 10px;
  }
  .seat-badge{
    display:inline-flex;
    align-items:center;
    gap: 8px;
    padding: 8px 12px;
    border-radius: 999px;
    background: #f3f4f6;
    color:#111;
    font-weight: 700;
    font-size: 14px;
  }
  .seat-type{
    font-weight: 800;
    font-size: 12px;
    padding: 3px 8px;
    border-radius: 999px;
    background: #e7e7ff;
    color:#3b2bd6;
  }
  .empty-box{
    width: 100%;
    padding: 14px 14px;
    border-radius: 14px;
    background:#f8f8f8;
    color:#666;
    font-weight: 700;
  }

  .price-lines{
    padding: 14px 22px 22px;
    border-top: 1px solid #eee;
  }
  .line{
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap: 10px;
    margin-top: 10px;
    color:#333;
  }
  .line .label{ color:#666; font-weight: 700; }
  .line .value{ font-weight: 800; }
  .line .strong{ color:#111; font-size: 16px; }

  .combo-table-wrap{ padding: 0 22px 6px; }
  .combo-table{
    width: 100%;
    border-collapse: collapse;
    border: 1px solid #eee;
    border-radius: 14px;
    overflow:hidden;
  }
  .combo-table thead th{
    background: #f7f7fb;
    color:#333;
    text-align:left;
    padding: 12px;
    font-size: 14px;
    border-bottom: 1px solid #eee;
  }
  .combo-table tbody td{
    padding: 12px;
    border-bottom: 1px solid #f0f0f0;
    color:#333;
    font-weight: 650;
    font-size: 14.5px;
  }
  .combo-table tbody tr:hover{ background:#fafafe; }
  .combo-table .right{ text-align:right; }
  .combo-table .center{ text-align:center; }
  .combo-table .name{ font-weight: 800; }
  .combo-table .empty-cell{
    color:#777;
    text-align:center;
    font-weight: 700;
  }

  .total-card{
    margin-top: 22px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border-radius: 20px;
    padding: 26px 26px;
    color:#fff;
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap: 16px;
    box-shadow: 0 12px 34px rgba(102,126,234,.25);
  }
  .total-title{ font-size: 18px; font-weight: 900; letter-spacing: .3px; text-transform: uppercase; }
  .total-sub{ margin-top: 6px; opacity:.9; }
  .total-value{ font-size: 30px; font-weight: 900; white-space: nowrap; }

  .cta-row{
    margin-top: 18px;
    display:flex;
    gap: 14px;
    flex-wrap: wrap;
  }
  .cta-form{ flex: 1; min-width: 260px; }
  .btn-confirm{
    width: 100%;
    border: none;
    border-radius: 999px;
    padding: 14px 18px;
    font-weight: 900;
    color:#fff;
    background: #e71a0f;
    transition: transform .15s, filter .15s;
  }
  .btn-confirm:hover{ transform: translateY(-2px); filter: brightness(1.02); }
  .btn-outline{
    flex: 1;
    min-width: 260px;
    display:flex;
    align-items:center;
    justify-content:center;
    border-radius: 999px;
    padding: 14px 18px;
    font-weight: 900;
    color:#333;
    background: #fff;
    border: 2px solid #e9e9e9;
    text-decoration:none;
    transition: transform .15s, border-color .15s;
  }
  .btn-outline:hover{ transform: translateY(-2px); border-color:#d7d7d7; }

  /* payment grid */
  .payment-grid{
    display:grid;
    grid-template-columns: repeat(auto-fit, minmax(380px, 1fr));
    gap: 30px;
  }
  .payment-card{
    background:#fff;
    border-radius: 20px;
    overflow:hidden;
    box-shadow: 0 5px 20px rgba(0,0,0,.08);
    transition: all .3s;
  }
  .payment-card:hover{
    transform: translateY(-10px);
    box-shadow: 0 15px 40px rgba(0,0,0,.15);
  }
  .card-header{
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    padding: 40px;
    text-align:center;
  }
  .fake-img{
    width: 80px;
    height: 80px;
    margin: 0 auto 18px;
    display:flex;
    align-items:center;
    justify-content:center;
    border-radius: 18px;
    background: rgba(255,255,255,.75);
    font-size: 36px;
  }
  .card-header h3{ font-size: 24px; color:#333; margin: 0; }
  .card-body{ padding: 30px; }
  .card-description{ font-size: 16px; color:#666; margin-bottom: 22px; line-height: 1.6; }

  .features{ margin-top: 18px; padding-top: 18px; border-top: 1px solid #eee; }
  .feature-item{ display:flex; align-items:center; gap: 10px; margin-bottom: 10px; color:#666; font-weight: 650; }
  .dot{ width: 10px; height: 10px; border-radius: 999px; display:inline-block; }
  .dot.ok{ background: #4CAF50; }

  /* process */
  .process-steps{
    display:flex;
    justify-content:space-between;
    align-items:center;
    background:#fff;
    padding: 60px;
    border-radius: 20px;
    gap: 12px;
  }
  .step{ flex: 1; text-align:center; }
  .step-number{
    width: 80px; height: 80px;
    margin: 0 auto 18px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border-radius: 50%;
    display:flex; align-items:center; justify-content:center;
    font-size: 36px; font-weight: bold; color:#fff;
  }
  .step h4{ font-size: 20px; margin-bottom: 10px; color:#333; }
  .step p{ color:#666; line-height: 1.6; }
  .step-arrow{ font-size: 32px; color:#e71a0f; padding: 0 14px; }

  /* security */
  .security-features{
    display:grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 30px;
  }
  .security-item{
    background:#fff;
    padding: 40px;
    border-radius: 20px;
    text-align:center;
    box-shadow: 0 5px 20px rgba(0,0,0,.08);
  }
  .sec-icon{ font-size: 54px; margin-bottom: 14px; }
  .security-item h4{ font-size: 20px; margin-bottom: 12px; color:#333; }
  .security-item p{ color:#666; line-height: 1.6; }

  /* Voucher Styles */
  .voucher-card {
    background: #fff;
    border-radius: 20px;
    padding: 24px;
    margin-bottom: 24px;
    box-shadow: 0 5px 20px rgba(0,0,0,.08);
    border: 1px solid #eee;
  }
  .voucher-head {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 15px;
    font-weight: 700;
    color: #333;
  }
  .voucher-head i { color: #e71a0f; }
  .btn-apply {
    background: #333;
    color: #fff;
    font-weight: 700;
    padding: 0 25px;
    border-radius: 0 10px 10px 0;
  }
  .btn-apply:hover { background: #000; color: #fff; }
  #voucherCode { border-radius: 10px 0 0 10px; }
  .discount-text {
    margin-top: 5px;
    font-weight: 800;
    color: #ffd43b;
    font-size: 1.1rem;
  }

  @media (max-width: 1024px){
    .summary-grid{ grid-template-columns: 1fr; }
    .process-steps{ flex-direction: column; }
    .step-arrow{ transform: rotate(90deg); padding: 18px 0; }
    .security-features{ grid-template-columns: repeat(2, 1fr); }
  }

  @media (max-width: 576px){
    .header-overlay h1{ font-size: 42px; }
    section h2{ font-size: 32px; }
    .payment-overview{ padding: 34px 18px; }
    .process-steps{ padding: 26px 16px; }
    .security-item{ padding: 26px 16px; }
  }
</style>

<script>
document.addEventListener("DOMContentLoaded", function() {
    const btnApply = document.getElementById("btnApplyVoucher");
    const inputCode = document.getElementById("voucherCode");
    const msgBox = document.getElementById("voucherMessage");
    const discountInfo = document.getElementById("discountInfo");
    const discountValueDisplay = document.getElementById("discountValueDisplay");
    const finalTotalDisplay = document.getElementById("finalTotalDisplay");
    const appliedVoucherInput = document.getElementById("appliedVoucherCode");
    
    const originalTotal = parseFloat(finalTotalDisplay.getAttribute("data-original"));

    btnApply.addEventListener("click", async function() {
        const code = inputCode.value.trim();
        if (!code) {
            msgBox.textContent = "Vui lòng nhập mã giảm giá.";
            msgBox.className = "mt-2 small text-danger";
            msgBox.style.display = "block";
            return;
        }

        btnApply.disabled = true;
        btnApply.textContent = "...";

        try {
            const res = await fetch(`<%= ctx %>/api/voucher?code=${code}&total=${originalTotal}`);
            const data = await res.json();

            msgBox.style.display = "block";
            if (data.isValid) {
                msgBox.textContent = data.message;
                msgBox.className = "mt-2 small text-success";
                
                // Tính toán giảm giá
                let discount = 0;
                if (data.type === 'PERCENT') {
                    discount = originalTotal * (data.discountAmount / 100);
                } else {
                    discount = data.discountAmount;
                }

                const newTotal = Math.max(0, originalTotal - discount);
                
                // Cập nhật UI
                discountValueDisplay.textContent = new Intl.NumberFormat('vi-VN').format(discount);
                discountInfo.style.display = "block";
                finalTotalDisplay.textContent = new Intl.NumberFormat('vi-VN').format(newTotal) + " VNĐ";
                appliedVoucherInput.value = code;
                
            } else {
                msgBox.textContent = data.message;
                msgBox.className = "mt-2 small text-danger";
                discountInfo.style.display = "none";
                finalTotalDisplay.textContent = new Intl.NumberFormat('vi-VN').format(originalTotal) + " VNĐ";
                appliedVoucherInput.value = "";
            }
        } catch (err) {
            console.error(err);
            msgBox.textContent = "Có lỗi xảy ra, vui lòng thử lại sau.";
            msgBox.className = "mt-2 small text-danger";
        } finally {
            btnApply.disabled = false;
            btnApply.textContent = "Áp dụng";
        }
    });
});
</script>
</body>
</html>
<jsp:include page="/common/footer.jsp" />
