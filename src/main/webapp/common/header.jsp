<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="bg-slate-900 border-b border-white/5 sticky top-0 z-[100] backdrop-blur-md">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-20">
            <!-- Logo -->
            <div class="flex-shrink-0">
                <a href="${pageContext.request.contextPath}/home" class="block">
                    <img src="${pageContext.request.contextPath}/assets/images/home/logo.jpg" 
                         alt="BOBIXI" class="h-10 w-auto rounded-lg shadow-lg">
                </a>
            </div>

            <!-- Navigation -->
            <nav class="hidden md:flex space-x-8">
                <a href="${pageContext.request.contextPath}/movie" class="text-slate-300 hover:text-white font-bold tracking-widest text-xs transition-colors">PHIM</a>
                <a href="${pageContext.request.contextPath}/showtime" class="text-slate-300 hover:text-white font-bold tracking-widest text-xs transition-colors">LỊCH CHIẾU</a>
                <a href="${pageContext.request.contextPath}/booking-seat" class="text-slate-300 hover:text-white font-bold tracking-widest text-xs transition-colors">ĐẶT VÉ</a>
                <a href="${pageContext.request.contextPath}/pages/clients/cinema/cinema-detail.jsp" class="text-slate-300 hover:text-white font-bold tracking-widest text-xs transition-colors">RẠP</a>
                <a href="${pageContext.request.contextPath}/contact" class="text-slate-300 hover:text-white font-bold tracking-widest text-xs transition-colors">LIÊN HỆ</a>
                <a href="${pageContext.request.contextPath}/pages/clients/about.jsp" class="text-slate-300 hover:text-white font-bold tracking-widest text-xs transition-colors">THÀNH VIÊN</a>
            </nav>

            <!-- User Menu -->
            <div class="flex items-center gap-4">
                <c:if test="${empty sessionScope.authUser}">
                    <div class="flex items-center gap-2">
                        <a href="${pageContext.request.contextPath}/login" class="text-slate-300 hover:text-white font-bold text-xs">Đăng nhập</a>
                        <span class="text-slate-700">/</span>
                        <a href="${pageContext.request.contextPath}/register" class="text-slate-300 hover:text-white font-bold text-xs">Đăng ký</a>
                    </div>
                </c:if>

                <c:if test="${not empty sessionScope.authUser}">
                    <div class="relative group">
                        <button class="flex items-center gap-2 text-slate-300 hover:text-white group-hover:text-white transition-all">
                            <div class="w-8 h-8 rounded-full bg-red-500/20 flex items-center justify-center text-red-500">
                                <i class="fas fa-user"></i>
                            </div>
                            <span class="text-sm font-bold truncate max-w-[120px]">
                                <c:out value="${sessionScope.authUser.fullName != null ? sessionScope.authUser.fullName : sessionScope.authUser.email}" />
                            </span>
                            <i class="fas fa-chevron-down text-[10px] opacity-50 group-hover:rotate-180 transition-transform"></i>
                        </button>

                        <!-- Dropdown Menu -->
                        <div class="absolute right-0 mt-2 w-56 bg-slate-800 border border-white/5 rounded-2xl shadow-2xl opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 transform translate-y-2 group-hover:translate-y-0 overflow-hidden">
                            <div class="px-4 py-3 bg-white/5 border-b border-white/5">
                                <p class="text-xs text-slate-500 font-bold uppercase tracking-tighter">Tài khoản</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/account" class="block px-4 py-3 text-sm text-slate-300 hover:bg-white/5 hover:text-white transition-colors">
                                <i class="fas fa-id-card w-6 opacity-50"></i> Thông tin cá nhân
                            </a>
                            <a href="${pageContext.request.contextPath}/booking/history" class="block px-4 py-3 text-sm text-slate-300 hover:bg-white/5 hover:text-white transition-colors">
                                <i class="fas fa-history w-6 opacity-50"></i> Lịch sử đặt vé
                            </a>
                            <c:if test="${sessionScope.authUser.role == 'ADMIN'}">
                                <a href="${pageContext.request.contextPath}/admin" class="block px-4 py-3 text-sm text-yellow-500 hover:bg-yellow-500/10 transition-colors">
                                    <i class="fas fa-user-shield w-6"></i> Trang quản trị
                                </a>
                            </c:if>
                            <div class="border-t border-white/5">
                                <a href="${pageContext.request.contextPath}/logout" class="block px-4 py-3 text-sm text-red-400 hover:bg-red-500/10 transition-colors">
                                    <i class="fas fa-sign-out-alt w-6"></i> Đăng xuất
                                </a>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</header>