<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Liên hệ | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-style.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
</head>
<body>

<jsp:include page="/common/admin/sidebar.jsp" />

<div class="main-content">
    <div class="mb-5">
        <h1 class="fw-800 mb-1" style="font-weight: 800;">Ý kiến khách hàng</h1>
        <p class="text-muted mb-0">Lắng nghe phản hồi và hỗ trợ giải đáp thắc mắc của khán giả.</p>
    </div>

    <div class="card-glass p-0 overflow-hidden">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th style="padding-left: 30px;">KHÁCH HÀNG</th>
                        <th>NỘI DUNG LIÊN HỆ</th>
                        <th>THỜI GIAN</th>
                        <th>TRẠNG THÁI</th>
                        <th class="text-end" style="padding-right: 30px;">HÀNH ĐỘNG</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${contactList}">
                        <tr>
                            <td style="padding-left: 30px;">
                                <div class="fw-bold text-white">${c.fullName}</div>
                                <div class="text-muted small">${c.email}</div>
                            </td>
                            <td style="max-width: 400px;">
                                <div class="text-white small fw-bold mb-1">${c.subject}</div>
                                <div class="text-muted small text-truncate" style="max-width: 380px;">${c.message}</div>
                            </td>
                            <td><span class="text-muted small"><fmt:formatDate value="${c.createdAt}" pattern="dd/MM/yyyy HH:mm" /></span></td>
                            <td>
                                <c:choose>
                                    <c:when test="${c.status == 'PENDING'}">
                                        <span class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25 px-3">CHƯA XEM</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-3">ĐÃ PHẢN HỒI</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-end" style="padding-right: 30px;">
                                <div class="d-flex justify-content-end gap-2">
                                    <button class="btn-action" title="Xem & Trả lời" onclick="viewContact('${c.contactId}', '${c.fullName}', '${c.message}')">
                                        <i class="fas fa-reply"></i>
                                    </button>
                                    <form action="${pageContext.request.contextPath}/admin/contacts" method="POST" class="d-inline" onsubmit="return confirm('Xóa phản hồi này?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="contactId" value="${c.contactId}">
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
