<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.cinema.dao.ShowtimeDAO.ShowtimeView" %>

<%!
  public static String esc(String s){
    if (s == null) return "";
    return s.replace("&","&amp;")
            .replace("<","&lt;")
            .replace(">","&gt;")
            .replace("\"","&quot;")
            .replace("'","&#39;");
  }

  // Timestamp -> yyyy-MM-ddTHH:mm cho input datetime-local
  public static String toDateTimeLocal(Timestamp ts){
    if (ts == null) return "";
    String s = ts.toString(); // yyyy-MM-dd HH:mm:ss...
    return s.substring(0,16).replace(" ", "T"); // yyyy-MM-ddTHH:mm
  }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"/>
  <title>Admin - Quản lí Suất chiếu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body{ background: linear-gradient(180deg,#2e2a44 0%,#1f1b2e 100%); color:#e5e7eb; min-height:100vh; }
    .cardx{ background: rgba(46,42,68,.85); border:1px solid rgba(255,255,255,.12); border-radius:16px; }
    .btnx{ border-radius:12px; font-weight:800; }
    .tbl th{ background: rgba(124,58,237,.25); color:#fff; }
    .tbl td,.tbl th{ border-color: rgba(255,255,255,.12) !important; vertical-align: middle; }
    input{ background: rgba(31,27,46,.9) !important; color:#e5e7eb !important; border:1px solid rgba(255,255,255,.15) !important; }
    .muted{ color: rgba(229,231,235,.75); font-size: 13px; }
  </style>
</head>

<body class="p-4">
<div class="container">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="m-0">ADMIN • Quản lí Suất chiếu</h3>
    <a class="btn btn-outline-light btnx" href="<%=request.getContextPath()%>/pages/admin/dashboard.jsp">Về Dashboard</a>
  </div>

  <%
    String error = (String) request.getAttribute("error");
    List<ShowtimeView> showtimeList = (List<ShowtimeView>) request.getAttribute("showtimeList");
    if (showtimeList == null) showtimeList = new ArrayList<>();
  %>

  <% if (error != null) { %>
    <div class="alert alert-danger"><%= error %></div>
  <% } %>

  <div class="row g-3">
    <!-- Add -->
    <div class="col-lg-4">
      <div class="cardx p-3">
        <h5 class="fw-bold">Thêm suất chiếu</h5>

        <form action="<%=request.getContextPath()%>/admin/showtimes" method="post">
          <input type="hidden" name="action" value="add"/>

          <div class="mb-2">
            <label class="form-label">ID Phim</label>
            <input class="form-control" name="movieId" type="number" min="1" required/>
          </div>

          <div class="mb-2">
            <label class="form-label">ID Phòng</label>
            <input class="form-control" name="roomId" type="number" min="1" required/>
          </div>

          <div class="mb-2">
            <label class="form-label">Bắt đầu</label>
            <input class="form-control" name="startTime" type="datetime-local" required/>
          </div>

          <div class="mb-2">
            <label class="form-label">Kết thúc</label>
            <input class="form-control" name="endTime" type="datetime-local" required/>
          </div>

          <div class="mb-3">
            <label class="form-label">Giá tiền</label>
            <input class="form-control" name="price" type="number" min="0" step="0.01" value="0.00" required/>
          </div>

          <button class="btn btn-primary btnx w-100" type="submit">Thêm</button>
        </form>
      </div>
    </div>

    <!-- List + Edit -->
    <div class="col-lg-8">
      <div class="cardx p-3">
        <h5 class="fw-bold">Danh sách suất chiếu</h5>

        <div class="table-responsive">
          <table class="table table-dark table-hover tbl">
            <thead>
              <tr>
                <th>ID</th>
                <th>Movie</th>
                <th>Room</th>
                <th>Start</th>
                <th>End</th>
                <th>Price</th>
                <th style="width:220px;">Thao tác</th>
              </tr>
            </thead>

            <tbody>
            <% if (showtimeList.isEmpty()) { %>
              <tr><td colspan="7" class="text-center text-white-50">Chưa có suất chiếu</td></tr>
            <% } else {
                 for (ShowtimeView s : showtimeList) {
                   int id = s.getShowtimeId();
                   String startLocal = toDateTimeLocal(s.getStartTime());
                   String endLocal = toDateTimeLocal(s.getEndTime());
                   String movieText = (s.getMovieName() == null ? ("Movie#" + s.getMovieId()) : s.getMovieName()) + " (ID " + s.getMovieId() + ")";
                   String roomText = (s.getRoomName() == null ? ("Room#" + s.getRoomId()) : s.getRoomName()) + " (ID " + s.getRoomId() + ")";
            %>
              <tr>
                <td><%= id %></td>
                <td><%= esc(movieText) %></td>
                <td><%= esc(roomText) %></td>
                <td><%= esc(startLocal.replace("T"," ")) %></td>
                <td><%= esc(endLocal.replace("T"," ")) %></td>
                <td><%= s.getPrice() %></td>

                <td>
                  <!-- hidden: JS lấy dữ liệu để fill form sửa -->
                  <input type="hidden" id="m_<%=id%>" value="<%= s.getMovieId() %>"/>
                  <input type="hidden" id="r_<%=id%>" value="<%= s.getRoomId() %>"/>
                  <input type="hidden" id="st_<%=id%>" value="<%= esc(startLocal) %>"/>
                  <input type="hidden" id="et_<%=id%>" value="<%= esc(endLocal) %>"/>
                  <input type="hidden" id="p_<%=id%>" value="<%= s.getPrice() %>"/>

                  <button type="button" class="btn btn-warning btnx" onclick="fillEdit(<%=id%>)">Sửa</button>

                  <form class="d-inline" action="<%=request.getContextPath()%>/admin/showtimes" method="post"
                        onsubmit="return confirm('Xóa suất chiếu này?');">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="showtimeId" value="<%= id %>"/>
                    <button class="btn btn-danger btnx" type="submit">Xóa</button>
                  </form>
                </td>
              </tr>
            <% } } %>
            </tbody>
          </table>
        </div>

        <!-- Edit form -->
        <div class="cardx p-3 mt-3">
          <h5 class="fw-bold">Sửa suất chiếu</h5>

          <form action="<%=request.getContextPath()%>/admin/showtimes" method="post">
            <input type="hidden" name="action" value="update"/>

            <div class="row g-2">
              <div class="col-md-2">
                <label class="form-label">ID Xuất Chiếu</label>
                <input id="editId" class="form-control" name="showtimeId" readonly/>
              </div>
              <div class="col-md-2">
                <label class="form-label">ID Phim</label>
                <input id="editMovieId" class="form-control" name="movieId" type="number" min="1" required/>
              </div>
              <div class="col-md-2">
                <label class="form-label">ID Phòng</label>
                <input id="editRoomId" class="form-control" name="roomId" type="number" min="1" required/>
              </div>
              <div class="col-md-3">
                <label class="form-label">Bắt đầu</label>
                <input id="editStart" class="form-control" name="startTime" type="datetime-local" required/>
              </div>
              <div class="col-md-3">
                <label class="form-label">Kết thúc</label>
                <input id="editEnd" class="form-control" name="endTime" type="datetime-local" required/>
              </div>
            </div>

            <div class="mt-2">
              <label class="form-label">Giá tiền</label>
              <input id="editPrice" class="form-control" name="price" type="number" min="0" step="0.01" required/>
            </div>

            <button class="btn btn-success btnx w-100 mt-3" type="submit">Cập nhật</button>
          </form>
        </div>

      </div>
    </div>
  </div>
</div>

<script>
  function fillEdit(id){
    document.getElementById('editId').value = id;
    document.getElementById('editMovieId').value = document.getElementById('m_' + id).value;
    document.getElementById('editRoomId').value = document.getElementById('r_' + id).value;
    document.getElementById('editStart').value = document.getElementById('st_' + id).value;
    document.getElementById('editEnd').value = document.getElementById('et_' + id).value;
    document.getElementById('editPrice').value = document.getElementById('p_' + id).value;

    window.scrollTo(0, document.body.scrollHeight);
  }
</script>

</body>
</html>
