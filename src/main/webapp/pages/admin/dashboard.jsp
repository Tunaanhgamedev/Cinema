<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Dashboard | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-style.css">
</head>
<body>

<jsp:include page="/common/admin/sidebar.jsp" />

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-5">
        <div>
            <h2 class="fw-bold mb-1">Tổng quan hệ thống</h2>
            <p class="text-muted small mb-0">Theo dõi hiệu suất kinh doanh của rạp phim</p>
        </div>
        <div class="d-flex align-items-center">
            <span class="badge bg-primary px-3 py-2 rounded-pill">
                Admin Session Active
            </span>
        </div>
    </div>

    <div class="row g-4 mb-5">
        <div class="col-md-4">
            <div class="card-glass p-4">
                <div class="d-flex justify-content-between mb-3">
                    <div class="text-muted small fw-bold text-uppercase">Doanh thu tổng</div>
                    <i class="fas fa-dollar-sign text-primary"></i>
                </div>
                <div class="fs-2 fw-bold">
                    <fmt:formatNumber value="${totalRevenue != null ? totalRevenue : 0}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                </div>
                <div class="text-success small mt-2">
                    <i class="fas fa-arrow-up me-1"></i> +12.5% so với tháng trước
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card-glass p-4">
                <div class="d-flex justify-content-between mb-3">
                    <div class="text-muted small fw-bold text-uppercase">Tổng số phim</div>
                    <i class="fas fa-film text-info"></i>
                </div>
                <div class="fs-2 fw-bold">${totalMovies != null ? totalMovies : 0}</div>
                <div class="text-muted small mt-2">Kho phim đang được quản lý</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card-glass p-4">
                <div class="d-flex justify-content-between mb-3">
                    <div class="text-muted small fw-bold text-uppercase">Tổng đơn hàng</div>
                    <i class="fas fa-ticket-alt text-warning"></i>
                </div>
                <div class="fs-2 fw-bold">${totalBookings != null ? totalBookings : 0}</div>
                <div class="text-muted small mt-2">Đơn hàng vé và combo</div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="card-glass p-4">
                <h5 class="fw-bold mb-4">Thông báo hệ thống</h5>
                <div class="alert alert-info bg-dark border-secondary text-info rounded-3">
                    <i class="fas fa-info-circle me-2"></i>
                    Chào mừng bạn quay trở lại hệ thống quản trị BOBIXI Cinema. Mọi thay đổi về phim và suất chiếu sẽ được cập nhật trực tiếp lên trang chủ.
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
