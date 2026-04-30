<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.cinema.views.BookingComboDetail" %>
<jsp:include page="/common/header.jsp" />
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Combo đã chọn</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- CSS của bạn giữ nguyên -->
  <style>
  :root{
    /* Cinema dark (đỏ/đen) */
    --bg0:#0b0b0f;
    --bg1:#12121a;
    --card:#151521;
    --card2:#101018;
    --text:#f2f2f4;
    --muted:rgba(242,242,244,.70);
    --line:rgba(255,255,255,.10);

    --red:#e3001b;
    --red2:#b80014;

    --shadow: 0 18px 44px rgba(0,0,0,.55);
    --shadow2: 0 10px 26px rgba(0,0,0,.45);
  }

  body{
    background:
      radial-gradient(900px 420px at 15% 10%, rgba(227,0,27,.16), transparent 60%),
      radial-gradient(850px 420px at 90% 15%, rgba(255,255,255,.06), transparent 55%),
      linear-gradient(180deg, var(--bg0), var(--bg1));
    color: var(--text);
    min-height: 100vh;
    margin: 0;
    padding: 0;
  }

  .wrapper{
    max-width: 980px;
    margin: 46px auto;
    padding: 26px;
    border-radius: 16px;
    background:
      linear-gradient(180deg, rgba(21,21,33,.94), rgba(16,16,24,.92));
    border: 1px solid var(--line);
    box-shadow: var(--shadow);
  }

  /* header */
  .title{
    text-align: left;
    font-weight: 900;
    letter-spacing: .6px;
    margin: 0 0 16px;
    color: var(--text);
    text-transform: uppercase;
    position: relative;
    padding-left: 14px;
  }
  .title::before{
    content:"";
    position:absolute;
    left:0; top: 6px; bottom: 6px;
    width: 4px;
    border-radius: 999px;
    background: linear-gradient(180deg, var(--red), var(--red2));
  }

  table{
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    overflow: hidden;
    border-radius: 14px;
    background: rgba(0,0,0,.18);
    border: 1px solid var(--line);
  }

  thead th{
    background:
      linear-gradient(180deg, rgba(227,0,27,.20), rgba(227,0,27,.10));
    color: #fff;
    padding: 13px 12px;
    text-align: center;
    font-weight: 800;
    border-bottom: 1px solid rgba(255,255,255,.12);
    font-size: .95rem;
  }

  tbody td{
    padding: 13px 12px;
    text-align: center;
    color: var(--text);
    border-bottom: 1px solid rgba(255,255,255,.08);
    font-weight: 600;
  }

  tbody tr{
    transition: background .18s ease, transform .18s ease;
  }
  tbody tr:hover{
    background: rgba(255,255,255,.04);
  }

  /* cột tên combo: canh trái cho “web rạp” */
  tbody td:first-child{
    text-align: left;
    font-weight: 800;
    letter-spacing: .1px;
  }

  .price{
    color: rgba(255,255,255,.92);
    font-weight: 900;
    white-space: nowrap;
  }

  /* empty */
  .empty{
    text-align:center;
    padding: 22px;
    color: var(--muted);
    font-weight: 700;
  }

  /* total box */
  .total-box{
    margin-top: 16px;
    padding: 14px 16px;
    border-radius: 14px;
    border: 1px solid rgba(255,255,255,.10);
    background: rgba(0,0,0,.28);
    display:flex;
    justify-content: space-between;
    align-items: center;
    gap: 12px;
    box-shadow: var(--shadow2);
  }

  .total-label{
    color: var(--muted);
    font-weight: 800;
    text-transform: uppercase;
    font-size: .9rem;
    letter-spacing: .35px;
  }

  .total-value{
    font-size: 22px;
    font-weight: 900;
    color: #fff;
    white-space: nowrap;
  }

  /* buttons */
  a{ text-decoration: none; }

  .btn-pay{
    margin-top: 14px;
    width: 100%;
    padding: 13px 14px;
    font-size: 16.5px;
    font-weight: 900;
    border-radius: 12px;
    border: 1px solid rgba(255,255,255,.10);
    color: #fff;
    background: linear-gradient(180deg, var(--red), var(--red2));
    box-shadow: 0 14px 28px rgba(227,0,27,.18);
    transition: transform .15s ease, filter .15s ease, box-shadow .15s ease;
  }
  .btn-pay:hover{
    transform: translateY(-2px);
    filter: brightness(1.02);
    box-shadow: 0 18px 34px rgba(227,0,27,.22);
  }
  .btn-pay:active{
    transform: translateY(0);
  }

  .btn-back{
    width: 100%;
    margin-top: 10px;
    padding: 12px 14px;
    border-radius: 12px;
    border: 1px solid rgba(255,255,255,.16);
    background: rgba(255,255,255,.04);
    color: #fff;
    font-weight: 900;
    letter-spacing: .2px;
    display: inline-block;
    text-align: center;
    transition: background .15s ease, transform .15s ease, border-color .15s ease;
  }
  .btn-back:hover{
    background: rgba(255,255,255,.07);
    border-color: rgba(255,255,255,.24);
    transform: translateY(-1px);
  }

  /* responsive */
  @media (max-width: 576px){
    .wrapper{ margin: 18px 12px; padding: 16px; }
    thead th, tbody td{ padding: 11px 10px; font-size: .92rem; }
    .total-value{ font-size: 20px; }
  }
</style>
</head>

<body>
<%
  String ctx = request.getContextPath();

  String bookingId = (request.getAttribute("bookingId") != null)
          ? String.valueOf(request.getAttribute("bookingId"))
          : request.getParameter("bookingId");
  if (bookingId == null) bookingId = "";

  List<BookingComboDetail> bookingComboList =
          (List<BookingComboDetail>) request.getAttribute("bookingComboList");

  BigDecimal total = (BigDecimal) request.getAttribute("totalCombo");
  if (total == null) total = BigDecimal.ZERO;
%>

<div class="wrapper">
  <h2 class="title">COMBO ĐÃ CHỌN</h2>

  <table>
    <thead>
      <tr>
        <th>Tên Combo</th>
        <th>Giá</th>
        <th>Số lượng</th>
        <th>Thành tiền</th>
      </tr>
    </thead>

    <tbody>
    <%
      if (bookingComboList == null || bookingComboList.isEmpty()) {
    %>
      <tr>
        <td class="empty" colspan="4">Bạn chưa chọn combo nào.</td>
      </tr>
    <%
      } else {
        for (BookingComboDetail item : bookingComboList) {
          BigDecimal lineTotal = item.getPrice().multiply(new BigDecimal(item.getQuantity()));
    %>
      <tr>
        <td><%= item.getComboName() %></td>
        <td class="price"><%= item.getPrice() %> VNĐ</td>
        <td><%= item.getQuantity() %></td>
        <td class="price"><%= lineTotal %> VNĐ</td>
      </tr>
    <%
        }
      }
    %>
    </tbody>
  </table>

  <div class="total-box">
    <div class="total-label">Tổng tiền combo</div>
    <div class="total-value"><%= total %> VNĐ</div>
  </div>

  <form action="<%= ctx %>/booking/payment" method="get">
    <input type="hidden" name="bookingId" value="<%= bookingId %>">
    <button class="btn-pay" type="submit">Thanh toán</button>
</form>


  <!-- ✅ quay lại servlet để load combo list -->
  <a class="btn-back" href="<%= ctx %>/booking/combo<%= bookingId.isEmpty() ? "" : ("?bookingId=" + bookingId) %>">
    Quay lại chọn combo
  </a>
</div>

</body>
</html>
<jsp:include page="/common/footer.jsp" />