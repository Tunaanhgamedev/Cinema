<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Global UI Requirements -->
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">

<style>
  body { font-family: 'Outfit', sans-serif !important; }
</style>

<header class="bg-slate-900 border-b border-white/5 sticky top-0 z-[100] backdrop-blur-md shadow-2xl">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-20">
            <!-- Logo -->
            <div class="flex-shrink-0">
                <a href="${pageContext.request.contextPath}/home" class="block">
                    <img src="${pageContext.request.contextPath}/assets/images/home/logo.jpg" 
                         alt="BOBIXI" class="h-12 w-auto rounded-xl shadow-lg brightness-90 hover:brightness-100 transition-all">
                </a>
            </div>

            <!-- Navigation -->
            <nav class="hidden md:flex space-x-10">
                <a href="${pageContext.request.contextPath}/movie" class="text-slate-400 hover:text-white font-bold tracking-widest text-[13px] transition-colors">PHIM</a>
                <a href="${pageContext.request.contextPath}/showtime" class="text-slate-400 hover:text-white font-bold tracking-widest text-[13px] transition-colors">LỊCH CHIẾU</a>
                <a href="${pageContext.request.contextPath}/booking-seat" class="text-slate-400 hover:text-white font-bold tracking-widest text-[13px] transition-colors">ĐẶT VÉ</a>
                <a href="${pageContext.request.contextPath}/pages/clients/cinema/cinema-detail.jsp" class="text-slate-400 hover:text-white font-bold tracking-widest text-[13px] transition-colors">RẠP</a>
                <a href="${pageContext.request.contextPath}/contact" class="text-slate-400 hover:text-white font-bold tracking-widest text-[13px] transition-colors">LIÊN HỆ</a>
                <a href="${pageContext.request.contextPath}/pages/clients/about.jsp" class="text-slate-400 hover:text-white font-bold tracking-widest text-[13px] transition-colors">THÀNH VIÊN</a>
            </nav>

            <!-- User Menu -->
            <div class="flex items-center gap-6">
                <c:if test="${empty sessionScope.authUser}">
                    <div class="flex items-center gap-3">
                        <a href="${pageContext.request.contextPath}/login" class="text-slate-300 hover:text-white font-bold text-sm">Đăng nhập</a>
                        <span class="text-slate-600">|</span>
                        <a href="${pageContext.request.contextPath}/register" class="text-slate-300 hover:text-white font-bold text-sm">Đăng ký</a>
                    </div>
                </c:if>

                <c:if test="${not empty sessionScope.authUser}">
                    <div class="relative group">
                        <button class="flex items-center gap-3 text-slate-300 hover:text-white transition-all">
                            <div class="w-10 h-10 rounded-full bg-white/5 flex items-center justify-center text-slate-400 border border-white/10">
                                <i class="fas fa-user text-lg"></i>
                            </div>
                            <span class="text-sm font-bold truncate max-w-[150px]">
                                <c:out value="${sessionScope.authUser.fullName != null ? sessionScope.authUser.fullName : sessionScope.authUser.email}" />
                            </span>
                            <i class="fas fa-chevron-down text-[10px] opacity-30 group-hover:rotate-180 transition-transform"></i>
                        </button>

                        <!-- Dropdown Menu -->
                        <div class="absolute right-0 mt-3 w-64 bg-slate-800 border border-white/5 rounded-[1.5rem] shadow-2xl opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 transform translate-y-4 group-hover:translate-y-0 overflow-hidden">
                            <div class="px-6 py-4 bg-white/5 border-b border-white/5">
                                <p class="text-[10px] text-slate-500 font-black uppercase tracking-widest">Cá nhân</p>
                            </div>
                            <div class="p-2">
                                <a href="${pageContext.request.contextPath}/account" class="flex items-center gap-3 px-4 py-3 text-sm text-slate-300 hover:bg-white/5 hover:text-white rounded-xl transition-colors">
                                    <i class="fas fa-id-card opacity-40"></i> Thông tin cá nhân
                                </a>
                                <a href="${pageContext.request.contextPath}/booking/history" class="flex items-center gap-3 px-4 py-3 text-sm text-slate-300 hover:bg-white/5 hover:text-white rounded-xl transition-colors">
                                    <i class="fas fa-history opacity-40"></i> Lịch sử đặt vé
                                </a>
                                <c:if test="${sessionScope.authUser.role == 'ADMIN'}">
                                    <a href="${pageContext.request.contextPath}/admin" class="flex items-center gap-3 px-4 py-3 text-sm text-yellow-500 hover:bg-yellow-500/10 rounded-xl transition-colors font-bold">
                                        <i class="fas fa-user-shield"></i> Trang quản trị
                                    </a>
                                </c:if>
                            </div>
                            <div class="p-2 border-t border-white/5">
                                <a href="${pageContext.request.contextPath}/logout" class="flex items-center gap-3 px-4 py-3 text-sm text-red-400 hover:bg-red-500/10 rounded-xl transition-colors font-bold">
                                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                                </a>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</header>