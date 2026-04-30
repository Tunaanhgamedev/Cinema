<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Dashboard | Admin Cinema</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .bento-card { transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1); }
        .bento-card:hover { transform: translateY(-5px); box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.2); }
    </style>
</head>
<body class="bg-[#0f172a] text-slate-200">

<jsp:include page="/common/admin-sidebar.jsp">
    <jsp:param name="activeTab" value="dashboard" />
</jsp:include>

<div class="main-content min-h-screen p-8">
    <!-- Welcome Header -->
    <div class="flex items-center justify-between mb-10">
        <div>
            <h1 class="text-4xl font-black text-white tracking-tight">Chào buổi tối, Admin! 👋</h1>
            <p class="text-slate-400 mt-2 text-lg">Hôm nay hệ thống của bạn đang hoạt động rất tốt.</p>
        </div>
        <div class="hidden md:flex items-center gap-4 bg-slate-800/50 p-2 rounded-2xl border border-slate-700">
            <div class="px-4 py-2 bg-indigo-600 rounded-xl text-white font-bold shadow-lg shadow-indigo-600/20">
                <i class="far fa-calendar-alt mr-2"></i>
                <%= new java.text.SimpleDateFormat("dd MMMM, yyyy").format(new java.util.Date()) %>
            </div>
        </div>
    </div>

    <!-- Stats Bento Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-10">
        <div class="bento-card glass-effect p-8 rounded-[2.5rem] relative overflow-hidden group">
            <div class="absolute top-0 right-0 w-32 h-32 bg-indigo-600/10 rounded-full -mr-16 -mt-16 transition-transform group-hover:scale-150"></div>
            <div class="w-14 h-14 bg-indigo-600 rounded-2xl flex items-center justify-center text-white text-2xl mb-6 shadow-xl shadow-indigo-600/20">
                <i class="fas fa-wallet"></i>
            </div>
            <p class="text-slate-500 font-black uppercase tracking-widest text-[11px] mb-2">Tổng doanh thu</p>
            <h3 class="text-3xl font-black text-white tracking-tight">
                <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
            </h3>
            <div class="mt-4 flex items-center text-emerald-400 text-xs font-bold">
                <i class="fas fa-arrow-up mr-1"></i> +12.5% so với tháng trước
            </div>
        </div>

        <div class="bento-card glass-effect p-8 rounded-[2.5rem] relative overflow-hidden group">
            <div class="absolute top-0 right-0 w-32 h-32 bg-emerald-600/10 rounded-full -mr-16 -mt-16 transition-transform group-hover:scale-150"></div>
            <div class="w-14 h-14 bg-emerald-600 rounded-2xl flex items-center justify-center text-white text-2xl mb-6 shadow-xl shadow-emerald-600/20">
                <i class="fas fa-ticket-alt"></i>
            </div>
            <p class="text-slate-500 font-black uppercase tracking-widest text-[11px] mb-2">Đơn hàng mới</p>
            <h3 class="text-3xl font-black text-white tracking-tight">${totalBookings}</h3>
            <div class="mt-4 flex items-center text-emerald-400 text-xs font-bold">
                <i class="fas fa-arrow-up mr-1"></i> +5.2% so với hôm qua
            </div>
        </div>

        <div class="bento-card glass-effect p-8 rounded-[2.5rem] relative overflow-hidden group">
            <div class="absolute top-0 right-0 w-32 h-32 bg-amber-600/10 rounded-full -mr-16 -mt-16 transition-transform group-hover:scale-150"></div>
            <div class="w-14 h-14 bg-amber-600 rounded-2xl flex items-center justify-center text-white text-2xl mb-6 shadow-xl shadow-amber-600/20">
                <i class="fas fa-film"></i>
            </div>
            <p class="text-slate-500 font-black uppercase tracking-widest text-[11px] mb-2">Phim đang chiếu</p>
            <h3 class="text-3xl font-black text-white tracking-tight">${totalMovies}</h3>
            <div class="mt-4 flex items-center text-slate-400 text-xs font-bold">
                Trạng thái: Hoạt động tốt
            </div>
        </div>

        <div class="bento-card glass-effect p-8 rounded-[2.5rem] relative overflow-hidden group">
            <div class="absolute top-0 right-0 w-32 h-32 bg-rose-600/10 rounded-full -mr-16 -mt-16 transition-transform group-hover:scale-150"></div>
            <div class="w-14 h-14 bg-rose-600 rounded-2xl flex items-center justify-center text-white text-2xl mb-6 shadow-xl shadow-rose-600/20">
                <i class="fas fa-users"></i>
            </div>
            <p class="text-slate-500 font-black uppercase tracking-widest text-[11px] mb-2">Khách hàng mới</p>
            <h3 class="text-3xl font-black text-white tracking-tight">1,284</h3>
            <div class="mt-4 flex items-center text-rose-400 text-xs font-bold">
                <i class="fas fa-heart mr-1"></i> Tăng trưởng mạnh
            </div>
        </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- Main Activity Chart Placeholder -->
        <div class="lg:col-span-2 glass-effect p-10 rounded-[3rem] min-h-[400px] flex flex-col">
            <div class="flex items-center justify-between mb-10">
                <div>
                    <h3 class="text-2xl font-black text-white">Phân tích doanh thu</h3>
                    <p class="text-slate-500 text-sm mt-1">Dữ liệu 7 ngày gần nhất</p>
                </div>
                <select class="bg-slate-900 border-none rounded-xl px-4 py-2 text-xs font-bold text-slate-400 focus:ring-2 ring-indigo-500 cursor-pointer">
                    <option>7 ngày qua</option>
                    <option>30 ngày qua</option>
                </select>
            </div>
            
            <div class="flex-1 flex flex-col items-center justify-center border-2 border-dashed border-slate-800 rounded-[2rem] bg-slate-900/20 group cursor-help">
                <div class="w-20 h-20 bg-indigo-500/10 rounded-full flex items-center justify-center text-indigo-500 text-3xl mb-4 group-hover:scale-110 transition-transform">
                    <i class="fas fa-chart-area"></i>
                </div>
                <p class="text-slate-500 font-bold tracking-wide">Biểu đồ đang được đồng bộ dữ liệu...</p>
                <div class="mt-6 flex gap-2">
                    <div class="w-2 h-2 bg-indigo-600 rounded-full animate-bounce"></div>
                    <div class="w-2 h-2 bg-indigo-600 rounded-full animate-bounce [animation-delay:-0.15s]"></div>
                    <div class="w-2 h-2 bg-indigo-600 rounded-full animate-bounce [animation-delay:-0.3s]"></div>
                </div>
            </div>
        </div>

        <!-- Quick Actions Sidebar -->
        <div class="flex flex-col gap-8">
            <div class="glass-effect p-10 rounded-[3rem]">
                <h3 class="text-xl font-black text-white mb-8">Lối tắt nhanh</h3>
                <div class="space-y-4">
                    <a href="${pageContext.request.contextPath}/admin/movies" class="flex items-center gap-4 p-4 rounded-2xl bg-slate-900/50 hover:bg-indigo-600 transition-all group">
                        <div class="w-12 h-12 rounded-xl bg-indigo-500/10 flex items-center justify-center text-indigo-500 group-hover:bg-white/20 group-hover:text-white transition-all">
                            <i class="fas fa-plus-circle text-xl"></i>
                        </div>
                        <span class="font-bold text-slate-300 group-hover:text-white">Thêm phim mới</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/showtimes" class="flex items-center gap-4 p-4 rounded-2xl bg-slate-900/50 hover:bg-emerald-600 transition-all group">
                        <div class="w-12 h-12 rounded-xl bg-emerald-500/10 flex items-center justify-center text-emerald-500 group-hover:bg-white/20 group-hover:text-white transition-all">
                            <i class="fas fa-calendar-plus text-xl"></i>
                        </div>
                        <span class="font-bold text-slate-300 group-hover:text-white">Tạo lịch chiếu</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/bookings" class="flex items-center gap-4 p-4 rounded-2xl bg-slate-900/50 hover:bg-amber-600 transition-all group">
                        <div class="w-12 h-12 rounded-xl bg-amber-500/10 flex items-center justify-center text-amber-500 group-hover:bg-white/20 group-hover:text-white transition-all">
                            <i class="fas fa-check-double text-xl"></i>
                        </div>
                        <span class="font-bold text-slate-300 group-hover:text-white">Duyệt đơn hàng</span>
                    </a>
                </div>
            </div>

            <!-- System Info Card -->
            <div class="bg-gradient-to-br from-indigo-600 to-purple-700 p-10 rounded-[3rem] text-white shadow-2xl shadow-indigo-600/30">
                <i class="fas fa-rocket text-4xl mb-6 opacity-40"></i>
                <h4 class="text-xl font-black mb-2">Hệ thống v2.0</h4>
                <p class="text-indigo-100 text-sm opacity-80 leading-relaxed">Giao diện đã được nâng cấp lên Tailwind CSS 4.0 mượt mà hơn.</p>
                <button class="mt-8 bg-white text-indigo-600 font-black px-6 py-3 rounded-2xl text-sm hover:bg-indigo-50 transition-all">
                    Xem nhật ký thay đổi
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
