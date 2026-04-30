<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="sidebar">
    <a href="${pageContext.request.contextPath}/admin" class="brand">BOBIXI • ADMIN</a>
    <nav>
        <a href="${pageContext.request.contextPath}/admin" class="nav-link ${pageContext.request.requestURI.endsWith('dashboard.jsp') || pageContext.request.requestURI.endsWith('/admin') ? 'active' : ''}">
            <i class="fas fa-chart-line"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/admin/movies" class="nav-link ${pageContext.request.requestURI.contains('movie-manage.jsp') ? 'active' : ''}">
            <i class="fas fa-film"></i> Quản lý Phim
        </a>
        <a href="${pageContext.request.contextPath}/admin/showtimes" class="nav-link ${pageContext.request.requestURI.contains('showtime-manage.jsp') ? 'active' : ''}">
            <i class="fas fa-calendar-alt"></i> Lịch chiếu
        </a>
        <a href="${pageContext.request.contextPath}/admin/bookings" class="nav-link ${pageContext.request.requestURI.contains('booking-manage.jsp') ? 'active' : ''}">
            <i class="fas fa-ticket-alt"></i> Đơn hàng
        </a>
        <a href="${pageContext.request.contextPath}/admin/contacts" class="nav-link ${pageContext.request.requestURI.contains('contact-manage.jsp') ? 'active' : ''}">
            <i class="fas fa-envelope"></i> Liên hệ
        </a>
        <a href="${pageContext.request.contextPath}/home" class="nav-link mt-5">
            <i class="fas fa-external-link-alt"></i> Về Web
        </a>
    </nav>
</div>
