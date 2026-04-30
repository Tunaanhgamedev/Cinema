<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Combo | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<jsp:include page="/common/admin-sidebar.jsp">
    <jsp:param name="activeTab" value="combos" />
</jsp:include>

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-5">
        <div>
            <h2 class="fw-bold mb-1">Quản lý Bắp nước & Combo</h2>
            <p class="text-muted small mb-0">Thiết lập thực đơn và giá bán cho các gói combo</p>
        </div>
        <button class="btn btn-primary px-4 rounded-3" data-bs-toggle="modal" data-bs-target="#comboModal" onclick="prepareAdd()">
            <i class="fas fa-plus me-2"></i> Thêm Combo mới
        </button>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger mb-4 rounded-3">${error}</div>
    </c:if>

    <div class="card-glass p-4">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên Combo</th>
                        <th>Mô tả chi tiết</th>
                        <th>Đơn giá</th>
                        <th class="text-end">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${comboList}">
                        <tr>
                            <td>#${c.comboId}</td>
                            <td><span class="fw-bold text-white">${c.name}</span></td>
                            <td><span class="text-muted">${c.description}</span></td>
                            <td><fmt:formatNumber value="${c.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></td>
                            <td class="text-end">
                                <button class="btn btn-outline-info btn-action me-1" 
                                        onclick="prepareEdit('${c.comboId}', '${c.name}', '${c.description}', '${c.price}')">
                                    <i class="fas fa-edit small"></i>
                                </button>
                                <form action="${pageContext.request.contextPath}/admin/combos" method="POST" class="d-inline" onsubmit="return confirm('Xóa combo này?')">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="comboId" value="${c.comboId}">
                                    <button class="btn btn-outline-danger btn-action">
                                        <i class="fas fa-trash small"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty comboList}">
                        <tr>
                            <td colspan="5" class="text-center py-5 text-muted small">Chưa có combo nào trong danh sách.</td>
                        </tr>
                    </c:if>
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
                <h5 class="modal-title fw-bold" id="modalTitle">Thêm Combo mới</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4 pt-0">
                <div class="row g-3">
                    <div class="col-12">
                        <label class="form-label small text-muted fw-bold">Tên Combo / Đồ ăn</label>
                        <input type="text" name="name" id="inputName" class="form-control" placeholder="Ví dụ: Combo Bắp 1 Nước" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label small text-muted fw-bold">Mô tả chi tiết</label>
                        <textarea name="description" id="inputDescription" class="form-control" rows="3" placeholder="Chi tiết gồm những gì..."></textarea>
                    </div>
                    <div class="col-12">
                        <label class="form-label small text-muted fw-bold">Giá bán (VNĐ)</label>
                        <input type="number" name="price" id="inputPrice" class="form-control" required>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 p-4 pt-0">
                <button type="button" class="btn btn-link text-white text-decoration-none" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" class="btn btn-primary px-4 rounded-3">Lưu Combo</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function prepareAdd() {
        document.getElementById('modalTitle').innerText = 'Thêm Combo mới';
        document.getElementById('modalAction').value = 'add';
        document.getElementById('modalId').value = '';
        document.getElementById('inputName').value = '';
        document.getElementById('inputDescription').value = '';
        document.getElementById('inputPrice').value = '';
    }

    function prepareEdit(id, name, desc, price) {
        document.getElementById('modalTitle').innerText = 'Chỉnh sửa Combo';
        document.getElementById('modalAction').value = 'update';
        document.getElementById('modalId').value = id;
        document.getElementById('inputName').value = name;
        document.getElementById('inputDescription').value = desc;
        document.getElementById('inputPrice').value = price;
        
        var myModal = new bootstrap.Modal(document.getElementById('comboModal'));
        myModal.show();
    }
</script>
</body>
</html>
