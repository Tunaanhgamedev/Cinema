<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Dashboard | Admin Cinema</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background: #0b0f19; color: #e5e7eb; font-family: 'Inter', sans-serif; }
        .sidebar { width: 260px; background: #111827; border-right: 1px solid #1f2937; min-height: 100vh; position: fixed; }
        .main-content { margin-left: 260px; padding: 40px; }
        .nav-link { color: #9ca3af; padding: 12px 20px; border-radius: 12px; margin: 4px 12px; display: block; text-decoration: none; transition: 0.3s; }
        .nav-link:hover, .nav-link.active { background: #1f2937; color: #fff; }
        .card-glass { background: rgba(17, 24, 39, 0.7); backdrop-filter: blur(10px); border: 1px solid #1f2937; border-radius: 20px; }
        .brand { padding: 24px; font-size: 24px; font-weight: 900; color: #e50914; letter-spacing: -1px; }
        .stat-card { transition: 0.3s; cursor: default; }
        .stat-card:hover { transform: translateY(-5px); border-color: #6366f1; }
        .icon-box { width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-bottom: 20px; }
    </style>
</head>
<body>

<jsp:include page="/common/admin-sidebar.jsp">
    <jsp:param name="activeTab" value="dashboard" />
</jsp:include>

<div class="main-content">
    <div class="mb-5">
        <h2 class="fw-bold mb-1">Tổng quan hệ thống</h2>
        <p class="text-muted small mb-0">Theo dõi doanh thu và hoạt động kinh doanh thời gian thực</p>
    </div>

    <div class="row g-4 mb-5">
        <div class="col-md-4">
            <div class="card-glass p-4 stat-card">
                <div class="icon-box bg-primary bg-opacity-10 text-primary">
                    <i class="fas fa-wallet fs-4"></i>
                </div>
                <div class="text-muted small mb-1">Tổng doanh thu (PAID)</div>
                <h3 class="fw-bold mb-0">
                    <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                </h3>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card-glass p-4 stat-card">
                <div class="icon-box bg-success bg-opacity-10 text-success">
                    <i class="fas fa-ticket-alt fs-4"></i>
                </div>
                <div class="text-muted small mb-1">Tổng đơn hàng</div>
                <h3 class="fw-bold mb-0">${totalBookings}</h3>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card-glass p-4 stat-card">
                <div class="icon-box bg-info bg-opacity-10 text-info">
                    <i class="fas fa-film fs-4"></i>
                </div>
                <div class="text-muted small mb-1">Phim trong kho</div>
                <h3 class="fw-bold mb-0">${totalMovies}</h3>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-lg-8">
            <div class="card-glass p-4 h-100">
                <h5 class="fw-bold mb-4">Hoạt động gần đây</h5>
                <div class="alert alert-info bg-info bg-opacity-10 border-0 text-white small">
                    <i class="fas fa-info-circle me-2"></i> Chức năng thống kê biểu đồ sẽ sớm được cập nhật.
                </div>
                <div class="py-5 text-center text-muted">
                    <i class="fas fa-chart-bar fa-4x mb-3 opacity-10"></i>
                    <p>Dữ liệu biểu đồ đang được xử lý...</p>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="card-glass p-4 h-100">
                <h5 class="fw-bold mb-4">Lối tắt nhanh</h5>
                <div class="list-group list-group-flush bg-transparent">
                    <a href="${pageContext.request.contextPath}/admin/movies" class="list-group-item bg-transparent text-white border-bottom border-light border-opacity-10 px-0 py-3 d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-plus-circle me-2 text-primary"></i> Thêm phim mới</span>
                        <i class="fas fa-chevron-right small text-muted"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/showtimes" class="list-group-item bg-transparent text-white border-bottom border-light border-opacity-10 px-0 py-3 d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-calendar-plus me-2 text-success"></i> Tạo lịch chiếu</span>
                        <i class="fas fa-chevron-right small text-muted"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/bookings" class="list-group-item bg-transparent text-white border-0 px-0 py-3 d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-check-double me-2 text-warning"></i> Duyệt đơn hàng</span>
                        <i class="fas fa-chevron-right small text-muted"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
