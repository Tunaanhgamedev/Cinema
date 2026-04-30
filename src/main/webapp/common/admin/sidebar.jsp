<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String currentUri = request.getRequestURI();
%>
<div class="sidebar">
    <div class="brand">BOBIXI • QUẢN TRỊ</div>
    <nav>
        <a href="${pageContext.request.contextPath}/admin" class="nav-link <%= currentUri.endsWith("/admin") || currentUri.endsWith("/dashboard.jsp") ? "active" : "" %>">
            <i class="fas fa-chart-pie"></i> Bảng điều khiển
        </a>
        <a href="${pageContext.request.contextPath}/admin/movies" class="nav-link <%= currentUri.contains("/movies") || currentUri.contains("/movie-manage.jsp") ? "active" : "" %>">
            <i class="fas fa-film"></i> Quản lý Phim
        </a>
        <a href="${pageContext.request.contextPath}/admin/showtimes" class="nav-link <%= currentUri.contains("/showtimes") || currentUri.contains("/showtime-manage.jsp") ? "active" : "" %>">
            <i class="fas fa-clock"></i> Lịch chiếu phim
        </a>
        <a href="${pageContext.request.contextPath}/admin/bookings" class="nav-link <%= currentUri.contains("/bookings") || currentUri.contains("/booking-manage.jsp") || currentUri.contains("/booking-detail.jsp") ? "active" : "" %>">
            <i class="fas fa-ticket-alt"></i> Quản lý Đơn hàng
        </a>
        <a href="${pageContext.request.contextPath}/admin/combos" class="nav-link <%= currentUri.contains("/combos") || currentUri.contains("/combo-manage.jsp") ? "active" : "" %>">
            <i class="fas fa-ice-cream"></i> Quản lý Combo
        </a>
        <a href="${pageContext.request.contextPath}/admin/contacts" class="nav-link <%= currentUri.contains("/contacts") || currentUri.contains("/contact-manage.jsp") ? "active" : "" %>">
            <i class="fas fa-envelope"></i> Ý kiến khách hàng
        </a>
        
        <div style="margin-top: 40px; padding: 0 16px;">
            <hr style="border-color: var(--border-color); opacity: 0.1;">
        </div>
        
        <a href="${pageContext.request.contextPath}/home" class="nav-link">
            <i class="fas fa-external-link-alt"></i> Xem Website
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="nav-link text-danger">
            <i class="fas fa-sign-out-alt"></i> Đăng xuất
        </a>
    </nav>
</div>
