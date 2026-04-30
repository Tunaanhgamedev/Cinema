<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-common.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<div class="sidebar">
    <div class="brand">BOBIXI • ADMIN</div>
    <nav>
        <a href="${pageContext.request.contextPath}/admin" class="nav-link ${param.activeTab == 'dashboard' ? 'active' : ''}"><i class="fas fa-chart-line me-2"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/movies" class="nav-link ${param.activeTab == 'movies' ? 'active' : ''}"><i class="fas fa-film me-2"></i> Quản lý Phim</a>
        <a href="${pageContext.request.contextPath}/admin/showtimes" class="nav-link ${param.activeTab == 'showtimes' ? 'active' : ''}"><i class="fas fa-calendar-alt me-2"></i> Lịch chiếu</a>
        <a href="${pageContext.request.contextPath}/admin/bookings" class="nav-link ${param.activeTab == 'bookings' ? 'active' : ''}"><i class="fas fa-ticket-alt me-2"></i> Đơn hàng</a>
        <a href="${pageContext.request.contextPath}/admin/combos" class="nav-link ${param.activeTab == 'combos' ? 'active' : ''}"><i class="fas fa-hamburger me-2"></i> Quản lý Combo</a>
        <hr class="border-light opacity-10 mx-3 my-4">
        <a href="${pageContext.request.contextPath}/home" class="nav-link"><i class="fas fa-external-link-alt me-2"></i> Về Web</a>
        <a href="${pageContext.request.contextPath}/admin/logout" class="nav-link text-danger mt-5"><i class="fas fa-sign-out-alt me-2"></i> Đăng xuất</a>
    </nav>
</div>
