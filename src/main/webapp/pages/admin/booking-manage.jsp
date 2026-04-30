<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Đơn hàng | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-style.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
    <style>
        .badge-status { font-weight: 600; font-size: 11px; text-transform: uppercase; letter-spacing: 0.5px; }
    </style>
</head>
<body>

<jsp:include page="/common/admin/sidebar.jsp" />

<div class="main-content">
    <div class="mb-5">
        <h1 class="fw-800 mb-1" style="font-weight: 800;">Quản lý Đơn hàng</h1>
        <p class="text-muted mb-0">Theo dõi trạng thái thanh toán và thông tin đặt vé của khách hàng.</p>
    </div>

    <div class="card-glass p-0 overflow-hidden">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th style="padding-left: 30px;">MÃ ĐƠN</th>
                        <th>KHÁCH HÀNG</th>
                        <th>PHIM / SUẤT CHIẾU</th>
                        <th>TỔNG TIỀN</th>
                        <th>TRẠNG THÁI</th>
                        <th class="text-end" style="padding-right: 30px;">THAO TÁC</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="b" items="${bookingList}">
                        <tr>
                            <td style="padding-left: 30px;"><span class="fw-bold text-white">#${b.bookingId}</span></td>
                            <td>
                                <div class="fw-bold text-white">${b.fullName}</div>
                                <div class="text-muted small">${b.email}</div>
                            </td>
                            <td>
                                <div class="small fw-bold text-white">${b.movieTitle}</div>
                                <div class="text-muted small">${b.roomName} • <fmt:formatDate value="${b.startTime}" pattern="dd/MM/yyyy HH:mm" /></div>
                            </td>
                            <td>
                                <div class="fw-bold text-accent"><fmt:formatNumber value="${b.grandTotal}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></div>
                                <div class="text-muted small">${b.seatCount} ghế</div>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${b.status == 'PAID'}">
                                        <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-3">ĐÃ THANH TOÁN</span>
                                    </c:when>
                                    <c:when test="${b.status == 'PENDING'}">
                                        <span class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25 px-3">CHỜ XỬ LÝ</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 px-3">ĐÃ HỦY</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-end" style="padding-right: 30px;">
                                <div class="d-flex justify-content-end gap-2 align-items-center">
                                    <a href="${pageContext.request.contextPath}/admin/bookings?bookingId=${b.bookingId}" class="btn-action" title="Xem chi tiết">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    
                                    <form action="${pageContext.request.contextPath}/admin/bookings" method="POST" class="d-inline">
                                        <input type="hidden" name="action" value="status">
                                        <input type="hidden" name="bookingId" value="${b.bookingId}">
                                        <div class="d-flex gap-1">
                                            <select name="status" class="form-select form-select-sm py-1 px-2" style="width: 110px; font-size: 11px; background: rgba(255,255,255,0.05);">
                                                <option value="PENDING" ${b.status == 'PENDING' ? 'selected' : ''}>CHỜ XỬ LÝ</option>
                                                <option value="PAID" ${b.status == 'PAID' ? 'selected' : ''}>ĐÃ THANH TOÁN</option>
                                                <option value="CANCELLED" ${b.status == 'CANCELLED' ? 'selected' : ''}>HỦY ĐƠN</option>
                                            </select>
                                            <button type="submit" class="btn btn-sm btn-primary py-1 px-2" style="border-radius: 8px;"><i class="fas fa-check small"></i></button>
                                        </div>
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
