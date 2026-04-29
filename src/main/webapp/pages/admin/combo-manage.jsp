<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.cinema.model.Combo" %>

<%!
  // Escape cho HTML attribute/value (an toàn khi đưa vào value="")
  public static String esc(String s){
    if (s == null) return "";
    return s.replace("&","&amp;")
            .replace("<","&lt;")
            .replace(">","&gt;")
            .replace("\"","&quot;")
            .replace("'","&#39;");
  }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"/>
  <title>Admin - Quản lí Combo</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body{ background: linear-gradient(180deg,#2e2a44 0%,#1f1b2e 100%); color:#e5e7eb; min-height:100vh; }
    .cardx{ background: rgba(46,42,68,.85); border:1px solid rgba(255,255,255,.12); border-radius:16px; }
    .btnx{ border-radius:12px; font-weight:800; }
    .tbl th{ background: rgba(124,58,237,.25); color:#fff; }
    .tbl td,.tbl th{ border-color: rgba(255,255,255,.12) !important; vertical-align: middle; }
    input,textarea{ background: rgba(31,27,46,.9) !important; color:#e5e7eb !important; border:1px solid rgba(255,255,255,.15) !important; }
  </style>
</head>

<body class="p-4">
<div class="container">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="m-0">ADMIN • Quản lí Combo</h3>
    <a class="btn btn-outline-light btnx" href="<%=request.getContextPath()%>/pages/admin/dashboard.jsp">Về Dashboard</a>
  </div>

  <%
    String error = (String) request.getAttribute("error");
    List<Combo> comboList = (List<Combo>) request.getAttribute("comboList");
    if (comboList == null) comboList = new ArrayList<>();
  %>

  <% if (error != null) { %>
    <div class="alert alert-danger"><%= error %></div>
  <% } %>

  <div class="row g-3">
    <!-- Form thêm combo -->
    <div class="col-lg-4">
      <div class="cardx p-3">
        <h5 class="fw-bold">Thêm combo</h5>

        <form action="<%=request.getContextPath()%>/admin/combos" method="post">
          <input type="hidden" name="action" value="add"/>

          <div class="mb-2">
            <label class="form-label">Tên</label>
            <input class="form-control" name="name" required/>
          </div>

          <div class="mb-2">
            <label class="form-label">Mô tả</label>
            <textarea class="form-control" name="description" rows="3"></textarea>
          </div>

          <div class="mb-3">
            <label class="form-label">Giá (VNĐ)</label>
            <input class="form-control" name="price" type="number" min="0" required/>
          </div>

          <button class="btn btn-primary btnx w-100" type="submit">Thêm</button>
        </form>
      </div>
    </div>

    <!-- Danh sách combo -->
    <div class="col-lg-8">
      <div class="cardx p-3">
        <h5 class="fw-bold">Danh sách combo</h5>

        <div class="table-responsive">
          <table class="table table-dark table-hover tbl">
            <thead>
              <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Mô tả</th>
                <th>Giá</th>
                <th style="width:240px;">Thao tác</th>
              </tr>
            </thead>
            <tbody>
            <% if (comboList.isEmpty()) { %>
              <tr>
                <td colspan="5" class="text-center text-white-50">Chưa có combo nào</td>
              </tr>
            <% } else {
                 for (Combo c : comboList) {
                   int id = c.getComboId();
                   String name = c.getName();
                   String desc = (c.getDescription() == null) ? "" : c.getDescription();
                   BigDecimal price = c.getPrice();
            %>
              <tr>
                <td><%= id %></td>
                <td><%= name %></td>
                <td><%= desc %></td>
                <td><%= price %> VNĐ</td>
                <td>

                  <!-- Hidden để JS lấy dữ liệu an toàn 100% -->
                  <input type="hidden" id="name_<%=id%>" value="<%= esc(name) %>"/>
                  <input type="hidden" id="desc_<%=id%>" value="<%= esc(desc) %>"/>
                  <input type="hidden" id="price_<%=id%>" value="<%= price %>"/>

                  <!-- Nút Sửa: chỉ truyền ID -->
                  <button type="button" class="btn btn-warning btnx"
                          onclick="fillEdit2(<%=id%>)">
                    Sửa
                  </button>

                  <!-- Nút Xóa -->
                  <form class="d-inline" action="<%=request.getContextPath()%>/admin/combos" method="post"
                        onsubmit="return confirm('Xóa combo này?');">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="comboId" value="<%= id %>"/>
                    <button class="btn btn-danger btnx" type="submit">Xóa</button>
                  </form>

                </td>
              </tr>
            <% } } %>
            </tbody>
          </table>
        </div>

        <!-- Form sửa combo -->
        <div class="cardx p-3 mt-3">
          <h5 class="fw-bold">Sửa combo</h5>

          <form action="<%=request.getContextPath()%>/admin/combos" method="post">
            <input type="hidden" name="action" value="update"/>

            <div class="row g-2">
              <div class="col-md-2">
                <label class="form-label">ID</label>
                <input id="editId" class="form-control" name="comboId" required/>
              </div>

              <div class="col-md-4">
                <label class="form-label">Tên</label>
                <input id="editName" class="form-control" name="name" required/>
              </div>

              <div class="col-md-4">
                <label class="form-label">Mô tả</label>
                <input id="editDesc" class="form-control" name="description"/>
              </div>

              <div class="col-md-2">
                <label class="form-label">Giá</label>
                <input id="editPrice" class="form-control" name="price" type="number" min="0" required/>
              </div>
            </div>

            <button class="btn btn-success btnx w-100 mt-3" type="submit">Cập nhật</button>
          </form>
        </div>

      </div>
    </div>
  </div>
</div>

<script>
  // Không nhét chuỗi vào onclick => không bao giờ lỗi dấu nháy
  function fillEdit2(id){
    document.getElementById('editId').value = id;
    document.getElementById('editName').value = document.getElementById('name_' + id).value;
    document.getElementById('editDesc').value = document.getElementById('desc_' + id).value;
    document.getElementById('editPrice').value = document.getElementById('price_' + id).value;

    // kéo xuống form sửa
    window.scrollTo(0, document.body.scrollHeight);
  }
</script>

</body>
</html>
