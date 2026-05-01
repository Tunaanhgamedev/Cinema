<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String currentUri = request.getRequestURI();
%>
<aside class="sidebar group flex flex-col h-screen fixed left-0 top-0 overflow-hidden">
    <!-- Header/Logo section -->
    <div class="p-8 pb-4 shrink-0">
        <div class="flex items-center gap-3 mb-10">
            <div class="w-10 h-10 bg-indigo-600 rounded-xl flex items-center justify-center shadow-lg shadow-indigo-600/30">
                <i class="fas fa-play text-white text-xs"></i>
            </div>
            <span class="text-xl font-black tracking-tighter text-white">BOBIXI <span class="text-indigo-500">PRO</span></span>
        </div>
    </div>

    <!-- Navigation Scrollable Area -->
    <div class="flex-1 overflow-y-auto px-8 pb-32 custom-scrollbar">
        <nav class="space-y-1">
            <p class="text-[10px] font-black text-slate-500 uppercase tracking-[2px] mb-4 ml-4">QUẢN TRỊ CHÍNH</p>
            
            <a href="${pageContext.request.contextPath}/admin" 
               class="nav-link <%= currentUri.endsWith("/admin") || currentUri.endsWith("/dashboard.jsp") ? "active" : "" %>">
                <i class="fas fa-grid-2"></i> <span>Bảng điều khiển</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/movies" 
               class="nav-link <%= currentUri.contains("/movies") || currentUri.contains("/movie-manage.jsp") ? "active" : "" %>">
                <i class="fas fa-film"></i> <span>Quản lý Phim</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/showtimes" 
               class="nav-link <%= currentUri.contains("/showtimes") || currentUri.contains("/showtime-manage.jsp") ? "active" : "" %>">
                <i class="fas fa-clock"></i> <span>Lịch chiếu phim</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/rooms" 
               class="nav-link <%= currentUri.contains("/rooms") || currentUri.contains("/room-manage.jsp") ? "active" : "" %>">
                <i class="fas fa-door-open"></i> <span>Quản lý Phòng</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/seat-prices" 
               class="nav-link <%= currentUri.contains("/seat-prices") || currentUri.contains("/seat-price-manage.jsp") ? "active" : "" %>">
                <i class="fas fa-hand-holding-usd"></i> <span>Giá Phụ Thu</span>
            </a>

            <div class="pt-6">
                <p class="text-[10px] font-black text-slate-500 uppercase tracking-[2px] mb-4 ml-4">GIAO DỊCH & HỖ TRỢ</p>
                
                <a href="${pageContext.request.contextPath}/admin/bookings" 
                   class="nav-link <%= currentUri.contains("/bookings") || currentUri.contains("/booking-manage.jsp") ? "active" : "" %>">
                    <i class="fas fa-ticket-alt"></i> <span>Quản lý Đơn hàng</span>
                </a>
                
                <a href="${pageContext.request.contextPath}/admin/combos" 
                   class="nav-link <%= currentUri.contains("/combos") || currentUri.contains("/combo-manage.jsp") ? "active" : "" %>">
                    <i class="fas fa-ice-cream"></i> <span>Quản lý Combo</span>
                </a>

                <a href="${pageContext.request.contextPath}/admin/vouchers" 
                   class="nav-link <%= currentUri.contains("/vouchers") || currentUri.contains("/voucher-manage.jsp") ? "active" : "" %>">
                    <i class="fas fa-tags"></i> <span>Quản lý Voucher</span>
                </a>
                
                <a href="${pageContext.request.contextPath}/admin/contacts" 
                   class="nav-link <%= currentUri.contains("/contacts") || currentUri.contains("/contact-manage.jsp") ? "active" : "" %>">
                    <i class="fas fa-envelope"></i> <span>Ý kiến khách hàng</span>
                </a>
            </div>
        </nav>
    </div>

    <!-- Footer fixed at bottom -->
    <div class="shrink-0 p-8 border-t border-white/5 bg-slate-900/50 backdrop-blur-md">
        <a href="${pageContext.request.contextPath}/home" class="flex items-center gap-3 text-slate-400 hover:text-white transition-colors mb-4 text-sm font-bold group/link">
            <i class="fas fa-external-link-alt group-hover/link:rotate-12 transition-transform"></i> Xem Website
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="flex items-center gap-3 text-rose-500 hover:text-rose-400 transition-colors text-sm font-bold group/link">
            <i class="fas fa-sign-out-alt group-hover/link:-translate-x-1 transition-transform"></i> Đăng xuất
        </a>
    </div>
</aside>

<style>
    .custom-scrollbar::-webkit-scrollbar {
        width: 4px;
    }
    .custom-scrollbar::-webkit-scrollbar-track {
        background: transparent;
    }
    .custom-scrollbar::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.1);
        border-radius: 10px;
    }
    .custom-scrollbar::-webkit-scrollbar-thumb:hover {
        background: rgba(255, 255, 255, 0.2);
    }
</style>
