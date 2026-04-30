<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Đơn hàng | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background: #0b0f19; color: #e5e7eb; font-family: 'Inter', sans-serif; }
        .sidebar { width: 260px; background: #111827; border-right: 1px solid #1f2937; min-height: 100vh; position: fixed; }
        .main-content { margin-left: 260px; padding: 40px; }
        .nav-link { color: #9ca3af; padding: 12px 20px; border-radius: 12px; margin: 4px 12px; display: block; text-decoration: none; transition: 0.3s; }
        .nav-link:hover, .nav-link.active { background: #1f2937; color: #fff; }
        .card-glass { background: rgba(17, 24, 39, 0.7); backdrop-filter: blur(10px); border: 1px solid #1f2937; border-radius: 20px; }
        .table { color: #e5e7eb; }
        .table thead th { border-bottom: 2px solid #1f2937; color: #9ca3af; font-weight: 600; text-transform: uppercase; font-size: 12px; }
        .table tbody td { border-bottom: 1px solid #1f2937; vertical-align: middle; padding: 15px; }
        .badge-status { font-weight: 600; font-size: 11px; text-transform: uppercase; letter-spacing: 0.5px; }
        .form-select-sm { background: #1f2937; border: 1px solid #374151; color: #fff; border-radius: 8px; font-size: 12px; }
        .brand { padding: 24px; font-size: 24px; font-weight: 900; color: #e50914; letter-spacing: -1px; }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="brand">BOBIXI • ADMIN</div>
    <nav>
        <a href="${pageContext.request.contextPath}/admin" class="nav-link"><i class="fas fa-chart-line me-2"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/movies" class="nav-link"><i class="fas fa-film me-2"></i> Quản lý Phim</a>
        <a href="${pageContext.request.contextPath}/admin/showtimes" class="nav-link"><i class="fas fa-calendar-alt me-2"></i> Lịch chiếu</a>
        <a href="${pageContext.request.contextPath}/admin/bookings" class="nav-link active"><i class="fas fa-ticket-alt me-2"></i> Đơn hàng</a>
        <a href="${pageContext.request.contextPath}/home" class="nav-link"><i class="fas fa-external-link-alt me-2"></i> Về Web</a>
    </nav>
</div>

<div class="main-content">
    <div class="mb-5">
        <h2 class="fw-bold mb-1">Quản lý Đơn hàng</h2>
        <p class="text-muted small mb-0">Theo dõi trạng thái thanh toán và thông tin đặt vé của khách hàng</p>
    </div>

    <div class="card-glass p-4">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Mã đơn</th>
                        <th>Khách hàng</th>
                        <th>Phim / Suất chiếu</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th class="text-end">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="b" items="${bookingList}">
                        <tr>
                            <td><span class="fw-bold">#${b.bookingId}</span></td>
                            <td>
                                <div class="fw-bold">${b.fullName}</div>
                                <div class="text-muted small">${b.email}</div>
                            </td>
                            <td>
                                <div class="small fw-bold text-white">${b.movieTitle}</div>
                                <div class="text-muted small">${b.roomName} • <fmt:formatDate value="${b.startTime}" pattern="dd/MM/yyyy HH:mm" /></div>
                            </td>
                            <td>
                                <div class="fw-bold text-primary"><fmt:formatNumber value="${b.grandTotal}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></div>
                                <div class="text-muted small">${b.seatCount} ghế</div>
                            </td>
                            <td>
                                <span class="badge rounded-pill badge-status px-3 py-2 
                                    ${b.status == 'PAID' ? 'bg-success-subtle text-success' : 
                                      b.status == 'PENDING' ? 'bg-warning-subtle text-warning' : 'bg-danger-subtle text-danger'}">
                                    ${b.status}
                                </span>
                            </td>
                            <td class="text-end">
                                <a href="${pageContext.request.contextPath}/admin/bookings?bookingId=${b.bookingId}" class="btn btn-sm btn-outline-info rounded-3 me-1">
                                    <i class="fas fa-eye me-1"></i> Chi tiết
                                </a>
                                
                                <form action="${pageContext.request.contextPath}/admin/bookings" method="POST" class="d-inline">
                                    <input type="hidden" name="action" value="status">
                                    <input type="hidden" name="bookingId" value="${b.bookingId}">
                                    <div class="d-inline-flex">
                                        <select name="status" class="form-select form-select-sm me-1" style="width: 110px;">
                                            <option value="PENDING" ${b.status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                                            <option value="PAID" ${b.status == 'PAID' ? 'selected' : ''}>PAID</option>
                                            <option value="CANCELLED" ${b.status == 'CANCELLED' ? 'selected' : ''}>CANCELLED</option>
                                        </select>
                                        <button type="submit" class="btn btn-sm btn-success rounded-3"><i class="fas fa-check"></i></button>
                                    </div>
                                </form>
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
