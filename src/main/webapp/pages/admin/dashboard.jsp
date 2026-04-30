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
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
</head>
<body>

<jsp:include page="/common/admin/sidebar.jsp" />

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-5">
        <div>
            <h1 class="fw-800 mb-1" style="font-weight: 800; font-size: 2.5rem;">Bảng điều khiển</h1>
            <p class="text-muted mb-0">Chào mừng trở lại! Đây là tình hình rạp phim của bạn hôm nay.</p>
        </div>
        <div class="d-flex gap-3">
            <div class="card-glass px-4 py-2 d-flex align-items-center gap-2">
                <div class="bg-success rounded-circle" style="width: 8px; height: 8px; box-shadow: 0 0 10px #198754;"></div>
                <span class="small fw-bold">Hệ thống: Ổn định</span>
            </div>
        </div>
    </div>

    <!-- Stats Grid -->
    <div class="row g-4 mb-5">
        <div class="col-md-3">
            <div class="card-glass stat-card">
                <div class="stat-icon bg-primary bg-opacity-10 text-primary">
                    <i class="fas fa-film"></i>
                </div>
                <div class="text-muted small fw-bold mb-1">TỔNG SỐ PHIM</div>
                <div class="fs-2 fw-bold">${totalMovies}</div>
                <div class="text-success small mt-2"><i class="fas fa-caret-up"></i> +2 phim mới tuần này</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card-glass stat-card">
                <div class="stat-icon bg-success bg-opacity-10 text-success">
                    <i class="fas fa-ticket-alt"></i>
                </div>
                <div class="text-muted small fw-bold mb-1">VÉ ĐÃ BÁN</div>
                <div class="fs-2 fw-bold">1,284</div>
                <div class="text-success small mt-2"><i class="fas fa-caret-up"></i> +12% so với hôm qua</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card-glass stat-card">
                <div class="stat-icon bg-warning bg-opacity-10 text-warning">
                    <i class="fas fa-dollar-sign"></i>
                </div>
                <div class="text-muted small fw-bold mb-1">DOANH THU</div>
                <div class="fs-2 fw-bold">42.8M</div>
                <div class="text-muted small mt-2">VNĐ (Tháng này)</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card-glass stat-card">
                <div class="stat-icon bg-info bg-opacity-10 text-info">
                    <i class="fas fa-users"></i>
                </div>
                <div class="text-muted small fw-bold mb-1">THÀNH VIÊN</div>
                <div class="fs-2 fw-bold">3,502</div>
                <div class="text-info small mt-2">Khách hàng đăng ký</div>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <!-- Recent Movies -->
        <div class="col-lg-8">
            <div class="card-glass p-4 h-100">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold m-0"><i class="fas fa-star text-warning me-2"></i> Phim đang công chiếu</h5>
                    <a href="${pageContext.request.contextPath}/admin/movies" class="btn btn-link text-accent text-decoration-none small">Xem tất cả</a>
                </div>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>PHIM</th>
                                <th>THỂ LOẠI</th>
                                <th>TRẠNG THÁI</th>
                                <th class="text-end">VÉ BÁN RA</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="m" items="${movieList}" varStatus="status">
                                <c:if test="${status.index < 5}">
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center gap-3">
                                                <img src="${m.poster}" class="rounded-3" style="width: 40px; height: 56px; object-fit: cover;">
                                                <span class="fw-bold">${m.title}</span>
                                            </div>
                                        </td>
                                        <td><span class="text-muted small">${m.genre}</span></td>
                                        <td><span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-3">Đang chiếu</span></td>
                                        <td class="text-end fw-bold">248</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Quick Actions / Notifications -->
        <div class="col-lg-4">
            <div class="card-glass p-4 mb-4">
                <h5 class="fw-bold mb-4">Lối tắt nhanh</h5>
                <div class="d-grid gap-3">
                    <a href="${pageContext.request.contextPath}/admin/movies" class="btn btn-primary w-100 text-start d-flex align-items-center justify-content-between">
                        <span><i class="fas fa-plus-circle me-2"></i> Đăng phim mới</span>
                        <i class="fas fa-chevron-right small opacity-50"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/showtimes" class="btn btn-outline-light w-100 text-start d-flex align-items-center justify-content-between" style="border-radius: 14px; padding: 12px 20px; border-color: var(--border-color);">
                        <span><i class="fas fa-calendar-plus me-2"></i> Tạo lịch chiếu</span>
                        <i class="fas fa-chevron-right small opacity-50"></i>
                    </a>
                </div>
            </div>
            
            <div class="card-glass p-4">
                <h5 class="fw-bold mb-4">Thông báo mới</h5>
                <div class="d-flex gap-3 mb-3 pb-3 border-bottom border-white border-opacity-10">
                    <div class="bg-warning bg-opacity-20 text-warning rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; flex-shrink: 0;">
                        <i class="fas fa-exclamation-triangle small"></i>
                    </div>
                    <div>
                        <div class="small fw-bold">Phòng 04 cần bảo trì</div>
                        <div class="text-muted" style="font-size: 11px;">Hệ thống âm thanh có dấu hiệu lỗi.</div>
                    </div>
                </div>
                <div class="d-flex gap-3">
                    <div class="bg-success bg-opacity-20 text-success rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; flex-shrink: 0;">
                        <i class="fas fa-check-circle small"></i>
                    </div>
                    <div>
                        <div class="small fw-bold">Đã thanh toán: #BK9024</div>
                        <div class="text-muted" style="font-size: 11px;">Giao dịch 450.000đ thành công.</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
