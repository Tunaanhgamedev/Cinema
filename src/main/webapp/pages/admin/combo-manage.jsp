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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-style.css">
</head>
<body>

<jsp:include page="/common/admin/sidebar.jsp" />

<div class="main-content">
    <div class="mb-5">
        <h2 class="fw-bold mb-1">Quản lý Combo</h2>
        <p class="text-muted small mb-0">Quản lý các gói thực phẩm và dịch vụ đi kèm</p>
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
            <table class="table">
                <thead>
                    <tr>
                        <th style="padding-left: 30px;">HÌNH ẢNH</th>
                        <th>TÊN COMBO</th>
                        <th>CHI TIẾT MÔ TẢ</th>
                        <th>GIÁ BÁN</th>
                        <th class="text-end" style="padding-right: 30px;">HÀNH ĐỘNG</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${comboList}">
                        <tr>
                            <td style="padding-left: 30px;">
                                <img src="${c.imageUrl}" class="rounded-3 shadow-sm" style="width: 56px; height: 56px; object-fit: cover;">
                            </td>
                            <td>
                                <div class="fw-bold text-white">${c.name}</div>
                                <div class="text-muted small">Mã: #${c.comboId}</div>
                            </td>
                            <td style="max-width: 300px;"><span class="text-muted small">${c.description}</span></td>
                            <td><span class="fw-bold text-accent"><fmt:formatNumber value="${c.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></span></td>
                            <td class="text-end" style="padding-right: 30px;">
                                <div class="d-flex justify-content-end gap-2">
                                    <button class="btn-action" title="Chỉnh sửa" onclick="prepareEdit('${c.comboId}', '${c.name}', '${c.description}', '${c.price}', '${c.imageUrl}')">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <form action="${pageContext.request.contextPath}/admin/combos" method="POST" class="d-inline" onsubmit="return confirm('Xóa combo này?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="comboId" value="${c.comboId}">
                                        <button class="btn-action hover-danger" title="Xóa">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Combo Modal -->
<div class="modal fade" id="comboModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <form action="${pageContext.request.contextPath}/admin/combos" method="POST" class="modal-content">
            <input type="hidden" name="action" id="modalAction" value="add">
            <input type="hidden" name="comboId" id="modalId">
            
            <div class="modal-header border-0 p-4">
                <h5 class="modal-title fw-bold" id="modalTitle">Thiết lập Combo</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body p-4 pt-0">
                <div class="row g-4">
                    <div class="col-12">
                        <label class="form-label small text-muted fw-bold">Tên Combo bắp nước</label>
                        <input type="text" name="name" id="inputName" class="form-control" placeholder="Ví dụ: Combo 2 bắp 2 nước" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label small text-muted fw-bold">Mô tả thành phần</label>
                        <textarea name="description" id="inputDescription" class="form-control" rows="3" placeholder="Chi tiết gồm những gì..."></textarea>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small text-muted fw-bold">Giá bán (VNĐ)</label>
                        <input type="number" name="price" id="inputPrice" class="form-control" placeholder="99000" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small text-muted fw-bold">Link hình ảnh</label>
                        <input type="text" name="imageUrl" id="inputImageUrl" class="form-control" placeholder="URL hình ảnh...">
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 p-4 pt-0">
                <button type="button" class="btn btn-link text-white text-decoration-none" data-bs-dismiss="modal">Hủy bỏ</button>
                <button type="submit" class="btn btn-primary px-5">Lưu Combo</button>
            </div>
        </form>
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
