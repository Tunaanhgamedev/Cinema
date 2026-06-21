<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.cinema.model.Combo" %>
<jsp:include page="/common/header.jsp" />
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Danh sách Combo</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    :root{
      --bg-dark:#1f1b2e;
      --bg-card:#2e2a44;
      --primary:#7C3AED;
      --text:#e5e7eb;
      --muted:#b4b6c8;
      --line:rgba(255,255,255,.15);
    }
    body{
      background: linear-gradient(180deg, #2e2a44 0%, #1f1b2e 100%);
      color: var(--text);
      min-height: 100vh;
      margin: 0;
      padding: 0;
    }
    .combo-wrapper{
      max-width: 900px;
      margin: 40px auto;
      padding: 30px;
      background: rgba(46,42,68,.85);
      border-radius: 18px;
      box-shadow: 0 20px 60px rgba(0,0,0,.35);
      border: 1px solid var(--line);
    }
    .combo-title{
      text-align: center;
      font-weight: 900;
      letter-spacing: 1px;
      margin-bottom: 30px;
      background: linear-gradient(135deg, #a78bfa, #7C3AED);
      -webkit-background-clip: text;
      color: transparent;
    }
    .muted{ color: var(--muted); font-weight: 700; }

    table{ width: 100%; border-collapse: collapse; }
    thead th{
      background: rgba(124,58,237,.25);
      color: #fff;
      padding: 14px;
      border-bottom: 1px solid var(--line);
      text-align: center;
    }
    tbody tr{ transition: background .2s; }
    tbody tr:hover{ background: rgba(124,58,237,.12); }
    td{
      padding: 14px;
      border-bottom: 1px solid var(--line);
      text-align: center;
      color: var(--text);
    }
    input[type="number"]{
      width: 90px;
      background: rgba(31,27,46,.9);
      color: var(--text);
      border: 1px solid var(--line);
      border-radius: 10px;
      padding: 6px 10px;
      text-align: center;
    }
    input[type="number"]:focus{
      outline: none;
      border-color: var(--primary);
    }
    .btn-confirm{
      margin-top: 25px;
      width: 100%;
      padding: 14px;
      font-size: 18px;
      font-weight: 800;
      border-radius: 14px;
      border: none;
      color: #fff;
      background: linear-gradient(135deg, #7C3AED, #5B21B6);
      transition: transform .15s, box-shadow .15s;
    }
    .btn-confirm:hover{
      transform: translateY(-1px);
      box-shadow: 0 10px 30px rgba(124,58,237,.4);
    }
    .price{ color: #c7d2fe; font-weight: 700; }
  </style>
</head>

<body>
<%
  String ctx = request.getContextPath();

  String bookingId = (request.getAttribute("bookingId") != null)
          ? String.valueOf(request.getAttribute("bookingId"))
          : request.getParameter("bookingId");
  if (bookingId == null) bookingId = "";

  List<Combo> comboList = (List<Combo>) request.getAttribute("comboList");
%>

<div class="combo-wrapper">
  <h2 class="combo-title">DANH SÁCH COMBO BẮP – NƯỚC</h2>

  <!-- ✅ POST về Servlet -->
  <form action="<%= ctx %>/booking/combo" method="post">
    <table>
      <thead>
        <tr>
          <th>Tên Combo</th>
          <th>Giá</th>
          <th>Số lượng</th>
        </tr>
      </thead>

      <tbody>
      <%
        if (comboList == null || comboList.isEmpty()) {
      %>
        <tr>
          <td colspan="3" class="muted">Chưa có combo nào trong hệ thống.</td>
        </tr>
      <%
        } else {
          for (Combo c : comboList) {
      %>
        <tr>
          <td><%= c.getName() %></td>
          <td class="price"><%= c.getPrice() %> VNĐ</td>
          <td>
            <input type="number" name="quantity_<%= c.getComboId() %>" value="0" min="0">
          </td>
        </tr>
      <%
          }
        }
      %>
      </tbody>
    </table>

    <input type="hidden" name="bookingId" value="<%= bookingId %>">

    <button type="submit" class="btn-confirm">Xác nhận Combo</button>
  </form>
</div>
</body>
</html>
<jsp:include page="/common/footer.jsp" />
