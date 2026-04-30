<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="sticky top-0 z-[100] w-full transition-all duration-500 bg-white/80 dark:bg-dark/80 backdrop-blur-xl border-b border-slate-200 dark:border-white/5">
    <div class="max-w-7xl mx-auto px-6">
        <div class="flex items-center justify-between h-20">
            
            <!-- Logo Area -->
            <div class="flex items-center gap-12">
                <a href="${pageContext.request.contextPath}/home" class="shrink-0 group">
                    <img src="${pageContext.request.contextPath}/assets/images/home/logo.jpg" 
                         alt="BOBIXI" 
                         class="h-10 w-auto rounded-lg shadow-lg group-hover:scale-110 transition-transform duration-300">
                </a>

                <!-- Main Navigation -->
                <nav class="hidden lg:flex items-center gap-8">
                    <c:set var="navClass" value="text-[11px] font-black uppercase tracking-[0.2em] transition-all hover:text-indigo-500" />
                    <a href="${pageContext.request.contextPath}/movie" class="${navClass} text-slate-600 dark:text-slate-400">Phim</a>
                    <a href="${pageContext.request.contextPath}/showtime" class="${navClass} text-slate-600 dark:text-slate-400">Lịch Chiếu</a>
                    <a href="${pageContext.request.contextPath}/booking-seat" class="${navClass} text-indigo-600 dark:text-indigo-400">Đặt Vé</a>
                    <a href="${pageContext.request.contextPath}/pages/clients/cinema/cinema-detail.jsp" class="${navClass} text-slate-600 dark:text-slate-400">Rạp</a>
                    <a href="${pageContext.request.contextPath}/contact" class="${navClass} text-slate-600 dark:text-slate-400">Liên Hệ</a>
                </nav>
            </div>

            <!-- User Menu Area -->
            <div class="flex items-center gap-6">
                
                <div class="flex items-center gap-4 py-2 px-4 rounded-full bg-slate-100 dark:bg-white/5 border border-slate-200 dark:border-white/10">
                    <c:choose>
                        <c:when test="${empty sessionScope.authUser}">
                            <a href="${pageContext.request.contextPath}/login" class="text-[10px] font-black uppercase tracking-widest text-slate-600 dark:text-slate-400 hover:text-indigo-500 transition-colors">Đăng nhập</a>
                            <span class="w-px h-3 bg-slate-300 dark:bg-white/10"></span>
                            <a href="${pageContext.request.contextPath}/register" class="text-[10px] font-black uppercase tracking-widest text-slate-600 dark:text-slate-400 hover:text-indigo-500 transition-colors">Đăng ký</a>
                        </c:when>
                        
                        <c:otherwise>
                            <div class="relative group cursor-pointer flex items-center gap-3">
                                <div class="w-8 h-8 rounded-full bg-gradient-to-tr from-indigo-500 to-purple-500 flex items-center justify-center text-white text-[10px] font-bold">
                                    ${sessionScope.authUser.fullName.substring(0,1).toUpperCase()}
                                </div>
                                <span class="text-[10px] font-black uppercase tracking-widest text-slate-700 dark:text-slate-200">
                                    <c:out value="${sessionScope.authUser.fullName != null ? sessionScope.authUser.fullName : sessionScope.authUser.email}" />
                                </span>
                                <i class="fas fa-chevron-down text-[8px] text-slate-400 group-hover:rotate-180 transition-transform"></i>

                                <!-- Dropdown Menu -->
                                <div class="absolute right-0 top-full pt-4 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 translate-y-2 group-hover:translate-y-0 z-[110]">
                                    <div class="w-56 bg-white dark:bg-slate-900 rounded-2xl shadow-2xl border border-slate-200 dark:border-white/5 overflow-hidden">
                                        <a href="${pageContext.request.contextPath}/account" class="flex items-center gap-3 px-5 py-4 text-xs font-bold text-slate-600 dark:text-slate-400 hover:bg-slate-50 dark:hover:bg-white/5 transition-colors border-b border-slate-100 dark:border-white/5">
                                            <i class="far fa-user-circle text-indigo-500"></i> Tài khoản
                                        </a>
                                        <a href="${pageContext.request.contextPath}/booking/history" class="flex items-center gap-3 px-5 py-4 text-xs font-bold text-slate-600 dark:text-slate-400 hover:bg-slate-50 dark:hover:bg-white/5 transition-colors border-b border-slate-100 dark:border-white/5">
                                            <i class="fas fa-history text-indigo-500"></i> Lịch sử đặt vé
                                        </a>
                                        <c:if test="${sessionScope.authUser.role == 'ADMIN'}">
                                            <a href="${pageContext.request.contextPath}/admin" class="flex items-center gap-3 px-5 py-4 text-xs font-bold text-amber-500 hover:bg-amber-500/5 transition-colors border-b border-slate-100 dark:border-white/5">
                                                <i class="fas fa-shield-alt"></i> Quản trị hệ thống
                                            </a>
                                        </c:if>
                                        <a href="${pageContext.request.contextPath}/logout" class="flex items-center gap-3 px-5 py-4 text-xs font-bold text-rose-500 hover:bg-rose-500/5 transition-colors">
                                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Theme Toggle -->
                <button class="w-10 h-10 rounded-full border border-slate-200 dark:border-white/10 flex items-center justify-center text-slate-500 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-white/5 transition-all">
                    <i class="fas fa-moon dark:hidden"></i>
                    <i class="fas fa-sun hidden dark:block text-amber-400"></i>
                </button>
            </div>
        </div>
    </div>
</header>