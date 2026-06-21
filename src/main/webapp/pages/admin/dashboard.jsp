<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Dashboard | Admin BOBIXI</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-style.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: { extend: { colors: { accent: '#6366f1' } } }
        }
    </script>
</head>
<body class="bg-[#0f172a] text-slate-200">

<div class="admin-layout">
    <jsp:include page="/common/admin/sidebar.jsp">
        <jsp:param name="activeTab" value="dashboard" />
    </jsp:include>

    <div class="main-content">
        <!-- Header -->
        <div class="flex justify-between items-center mb-10">
            <div>
                <h1 class="text-4xl font-extrabold tracking-tight text-white mb-2">Bảng điều khiển</h1>
                <p class="text-slate-400">Tổng quan hoạt động kinh doanh của BOBIXI Cinema.</p>
            </div>
            <div class="flex items-center gap-4">
                <div class="card-glass px-4 py-2 flex items-center gap-3">
                    <div class="w-2 h-2 rounded-full bg-emerald-500 animate-pulse"></div>
                    <span class="text-xs font-bold text-slate-300 uppercase tracking-widest">Hệ thống: Ổn định</span>
                </div>
            </div>
        </div>

        <!-- ═══════ KPI STATS ROW ═══════ -->
        <div class="grid grid-cols-2 lg:grid-cols-3 xl:grid-cols-6 gap-5 mb-10">
            <!-- Tổng Phim -->
            <div class="card-glass p-5 group hover:border-indigo-500/30">
                <div class="w-10 h-10 rounded-xl bg-indigo-500/10 flex items-center justify-center text-indigo-400 mb-3 group-hover:scale-110 transition-transform">
                    <i class="fas fa-film"></i>
                </div>
                <p class="text-[10px] text-slate-500 font-black uppercase tracking-widest mb-1">Tổng Phim</p>
                <p class="text-2xl font-black text-white">${totalMovies}</p>
            </div>
            <!-- Vé đã bán -->
            <div class="card-glass p-5 group hover:border-sky-500/30">
                <div class="w-10 h-10 rounded-xl bg-sky-500/10 flex items-center justify-center text-sky-400 mb-3 group-hover:scale-110 transition-transform">
                    <i class="fas fa-ticket-alt"></i>
                </div>
                <p class="text-[10px] text-slate-500 font-black uppercase tracking-widest mb-1">Vé đã bán</p>
                <p class="text-2xl font-black text-white">${totalBookings}</p>
            </div>
            <!-- Doanh thu -->
            <div class="card-glass p-5 group hover:border-emerald-500/30">
                <div class="w-10 h-10 rounded-xl bg-emerald-500/10 flex items-center justify-center text-emerald-400 mb-3 group-hover:scale-110 transition-transform">
                    <i class="fas fa-coins"></i>
                </div>
                <p class="text-[10px] text-slate-500 font-black uppercase tracking-widest mb-1">Doanh thu</p>
                <p class="text-2xl font-black text-white"><fmt:formatNumber value="${totalRevenue}" pattern="#,###" /> <span class="text-emerald-400/60 text-base">đ</span></p>
            </div>
            <!-- Giảm giá -->
            <div class="card-glass p-5 group hover:border-rose-500/30">
                <div class="w-10 h-10 rounded-xl bg-rose-500/10 flex items-center justify-center text-rose-400 mb-3 group-hover:scale-110 transition-transform">
                    <i class="fas fa-percent"></i>
                </div>
                <p class="text-[10px] text-slate-500 font-black uppercase tracking-widest mb-1">Giảm giá</p>
                <p class="text-2xl font-black text-white"><fmt:formatNumber value="${totalDiscount}" pattern="#,###" /> <span class="text-rose-400/60 text-base">đ</span></p>
            </div>
            <!-- Voucher -->
            <div class="card-glass p-5 group hover:border-amber-500/30">
                <div class="w-10 h-10 rounded-xl bg-amber-500/10 flex items-center justify-center text-amber-400 mb-3 group-hover:scale-110 transition-transform">
                    <i class="fas fa-tags"></i>
                </div>
                <p class="text-[10px] text-slate-500 font-black uppercase tracking-widest mb-1">Voucher</p>
                <p class="text-2xl font-black text-white">${activeVouchers}</p>
            </div>
            <!-- Thành viên -->
            <div class="card-glass p-5 group hover:border-violet-500/30">
                <div class="w-10 h-10 rounded-xl bg-violet-500/10 flex items-center justify-center text-violet-400 mb-3 group-hover:scale-110 transition-transform">
                    <i class="fas fa-users"></i>
                </div>
                <p class="text-[10px] text-slate-500 font-black uppercase tracking-widest mb-1">Thành viên</p>
                <p class="text-2xl font-black text-white">${userCount}</p>
            </div>
        </div>

        <!-- ═══════ CHARTS ROW 1: Doanh thu trend + Doanh thu theo phim ═══════ -->
        <div class="grid grid-cols-1 lg:grid-cols-5 gap-6 mb-8">
            <!-- Line Chart: 3/5 width -->
            <div class="lg:col-span-3 card-glass p-6">
                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-lg font-bold text-white flex items-center gap-2">
                        <i class="fas fa-chart-line text-indigo-400 text-sm"></i> Xu hướng Doanh thu (7 ngày)
                    </h2>
                    <span class="text-[10px] text-slate-500 font-bold uppercase tracking-widest bg-white/5 px-3 py-1 rounded-full">Tự động cập nhật</span>
                </div>
                <div class="h-[280px] w-full">
                    <canvas id="dailyRevenueChart"></canvas>
                </div>
            </div>

            <!-- Doughnut Chart: 2/5 width -->
            <div class="lg:col-span-2 card-glass p-6">
                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-lg font-bold text-white flex items-center gap-2">
                        <i class="fas fa-chart-pie text-sky-400 text-sm"></i> Doanh thu theo Phim
                    </h2>
                </div>
                <div class="h-[280px] w-full flex justify-center">
                    <canvas id="movieRevenueChart"></canvas>
                </div>
            </div>
        </div>

        <!-- ═══════ CHARTS ROW 2: Bar chart + Doanh thu net ═══════ -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
            <!-- Bar Chart: Vé bán theo phim -->
            <div class="card-glass p-6">
                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-lg font-bold text-white flex items-center gap-2">
                        <i class="fas fa-chart-bar text-amber-400 text-sm"></i> Doanh thu phim (Bar)
                    </h2>
                </div>
                <div class="h-[260px] w-full">
                    <canvas id="movieBarChart"></canvas>
                </div>
            </div>

            <!-- Area Chart: Doanh thu ròng (Revenue - Discount) -->
            <div class="card-glass p-6">
                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-lg font-bold text-white flex items-center gap-2">
                        <i class="fas fa-chart-area text-emerald-400 text-sm"></i> Doanh thu & Giảm giá (7 ngày)
                    </h2>
                </div>
                <div class="h-[260px] w-full">
                    <canvas id="revDiscountChart"></canvas>
                </div>
            </div>
        </div>

        <!-- ═══════ BOTTOM: Recent Bookings + Quick Stats ═══════ -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <!-- Giao dịch gần đây: 2/3 -->
            <div class="lg:col-span-2 card-glass overflow-hidden">
                <div class="p-6 border-b border-white/5 flex justify-between items-center bg-white/5">
                    <h2 class="text-lg font-bold text-white flex items-center gap-2">
                        <i class="fas fa-history text-indigo-400 text-sm"></i> Giao dịch gần đây
                    </h2>
                    <a href="${pageContext.request.contextPath}/admin/bookings" class="text-indigo-400 text-xs font-bold hover:text-white transition-colors uppercase tracking-widest">Xem tất cả</a>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead>
                            <tr class="text-slate-500 text-[10px] font-black uppercase tracking-widest border-b border-white/5 bg-white/2">
                                <th class="px-6 py-4">Mã Đơn</th>
                                <th class="px-6 py-4">Trạng thái</th>
                                <th class="px-6 py-4">Ngày đặt</th>
                                <th class="px-6 py-4 text-right">Tổng tiền</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-white/5">
                            <c:forEach var="b" items="${recentBookings}">
                                <tr class="hover:bg-white/2 transition-colors">
                                    <td class="px-6 py-4 font-mono text-indigo-400 text-xs font-bold">#BK${b.bookingId}</td>
                                    <td class="px-6 py-4">
                                        <c:choose>
                                            <c:when test="${b.status == 'PAID'}">
                                                <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-emerald-500/10 text-emerald-500 border border-emerald-500/20 text-[10px] font-black uppercase tracking-wider">
                                                    <span class="w-1 h-1 rounded-full bg-emerald-500"></span> Đã thanh toán
                                                </span>
                                            </c:when>
                                            <c:when test="${b.status == 'PENDING'}">
                                                <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-amber-500/10 text-amber-400 border border-amber-500/20 text-[10px] font-black uppercase tracking-wider">
                                                    <span class="w-1 h-1 rounded-full bg-amber-500 animate-pulse"></span> Chờ xử lý
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-rose-500/10 text-rose-400 border border-rose-500/20 text-[10px] font-black uppercase tracking-wider">
                                                    <span class="w-1 h-1 rounded-full bg-rose-500"></span> Đã hủy
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-6 py-4 text-slate-400 text-xs">
                                        <fmt:formatDate value="${b.bookingDate}" pattern="dd/MM/yyyy HH:mm" />
                                    </td>
                                    <td class="px-6 py-4 text-right font-bold text-emerald-400">
                                        <fmt:formatNumber value="${b.totalPrice}" pattern="#,###" /> đ
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty recentBookings}">
                                <tr><td colspan="4" class="px-6 py-12 text-center text-slate-500 text-sm italic">Chưa có giao dịch nào.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Thông báo nhanh: 1/3 -->
            <div class="space-y-6">
                <!-- Summary Card -->
                <div class="card-glass p-6">
                    <h2 class="text-lg font-bold text-white mb-5 flex items-center gap-2">
                        <i class="fas fa-tachometer-alt text-indigo-400 text-sm"></i> Tóm tắt
                    </h2>
                    <div class="space-y-4">
                        <div class="flex items-center justify-between">
                            <span class="text-slate-400 text-sm">Doanh thu ròng</span>
                            <span class="text-emerald-400 font-bold text-sm">
                                <fmt:formatNumber value="${totalRevenue - totalDiscount}" pattern="#,###" /> đ
                            </span>
                        </div>
                        <div class="w-full bg-white/5 rounded-full h-2">
                            <div class="bg-gradient-to-r from-indigo-500 to-emerald-500 h-2 rounded-full" style="width: ${totalRevenue > 0 ? ((totalRevenue - totalDiscount) * 100 / totalRevenue) : 100}%"></div>
                        </div>
                        <div class="flex items-center justify-between">
                            <span class="text-slate-400 text-sm">Tỷ lệ giảm giá</span>
                            <span class="text-rose-400 font-bold text-sm">
                                <fmt:formatNumber value="${totalRevenue > 0 ? (totalDiscount * 100.0 / totalRevenue) : 0}" maxFractionDigits="1" />%
                            </span>
                        </div>
                        <div class="flex items-center justify-between">
                            <span class="text-slate-400 text-sm">Vé TB/Phim</span>
                            <span class="text-sky-400 font-bold text-sm">
                                ${totalMovies > 0 ? Math.round(totalBookings * 1.0 / totalMovies * 10) / 10.0 : 0}
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Notifications -->
                <div class="card-glass p-6">
                    <h2 class="text-lg font-bold text-white mb-5 flex items-center gap-2">
                        <i class="fas fa-bell text-amber-400 text-sm"></i> Thông báo
                    </h2>
                    <div class="space-y-5">
                        <div class="flex gap-3 group">
                            <div class="w-1.5 h-1.5 rounded-full bg-sky-500 mt-2 shadow-[0_0_8px_rgba(14,165,233,0.5)]"></div>
                            <div>
                                <p class="text-white text-sm font-bold group-hover:text-sky-400 transition-colors">${totalBookings} đơn hàng đã hoàn tất</p>
                                <p class="text-slate-500 text-[10px] uppercase tracking-widest mt-1">Tổng cộng</p>
                            </div>
                        </div>
                        <div class="flex gap-3 group">
                            <div class="w-1.5 h-1.5 rounded-full bg-emerald-500 mt-2 shadow-[0_0_8px_rgba(16,185,129,0.5)]"></div>
                            <div>
                                <p class="text-white text-sm font-bold group-hover:text-emerald-400 transition-colors">${userCount} thành viên đã đăng ký</p>
                                <p class="text-slate-500 text-[10px] uppercase tracking-widest mt-1">Cập nhật</p>
                            </div>
                        </div>
                        <div class="flex gap-3 group">
                            <div class="w-1.5 h-1.5 rounded-full bg-amber-500 mt-2 shadow-[0_0_8px_rgba(245,158,11,0.5)]"></div>
                            <div>
                                <p class="text-white text-sm font-bold group-hover:text-amber-400 transition-colors">${activeVouchers} voucher đang hoạt động</p>
                                <p class="text-slate-500 text-[10px] uppercase tracking-widest mt-1">Khuyến mãi</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ═══════ CHART.JS ═══════ -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    Chart.defaults.color = '#94a3b8';
    Chart.defaults.font.family = "'Outfit', sans-serif";
    Chart.defaults.font.weight = 600;

    // ── Prepare data from JSP ──
    const dailyLabels = [<c:forEach var="e" items="${revenueDaily}" varStatus="s">'${e.key}'<c:if test="${!s.last}">,</c:if></c:forEach>];
    const dailyData   = [<c:forEach var="e" items="${revenueDaily}" varStatus="s">${e.value}<c:if test="${!s.last}">,</c:if></c:forEach>];
    const movieLabels  = [<c:forEach var="e" items="${revenueMovie}" varStatus="s">'${e.key}'<c:if test="${!s.last}">,</c:if></c:forEach>];
    const movieData    = [<c:forEach var="e" items="${revenueMovie}" varStatus="s">${e.value}<c:if test="${!s.last}">,</c:if></c:forEach>];

    const gridColor = 'rgba(255,255,255,0.04)';
    const vndFormat = (v) => v.toLocaleString('vi-VN') + ' ₫';

    // ═══ 1. LINE: Daily Revenue Trend ═══
    new Chart(document.getElementById('dailyRevenueChart'), {
        type: 'line',
        data: {
            labels: dailyLabels,
            datasets: [{
                label: 'Doanh thu',
                data: dailyData,
                borderColor: '#6366f1',
                backgroundColor: (ctx) => {
                    const g = ctx.chart.ctx.createLinearGradient(0, 0, 0, 280);
                    g.addColorStop(0, 'rgba(99,102,241,0.25)');
                    g.addColorStop(1, 'rgba(99,102,241,0.0)');
                    return g;
                },
                borderWidth: 3,
                fill: true,
                tension: 0.4,
                pointBackgroundColor: '#6366f1',
                pointBorderColor: '#1e293b',
                pointBorderWidth: 3,
                pointRadius: 5,
                pointHoverRadius: 8
            }]
        },
        options: {
            responsive: true, maintainAspectRatio: false,
            plugins: {
                legend: { display: false },
                tooltip: { callbacks: { label: (c) => vndFormat(c.parsed.y) } }
            },
            scales: {
                y: { beginAtZero: true, grid: { color: gridColor }, ticks: { callback: (v) => (v / 1000) + 'k' } },
                x: { grid: { display: false } }
            }
        }
    });

    // ═══ 2. DOUGHNUT: Revenue by Movie ═══
    const palette = ['#6366f1','#0ea5e9','#f59e0b','#10b981','#f43f5e','#8b5cf6','#ec4899'];
    new Chart(document.getElementById('movieRevenueChart'), {
        type: 'doughnut',
        data: {
            labels: movieLabels,
            datasets: [{ data: movieData, backgroundColor: palette, borderWidth: 0, hoverOffset: 16 }]
        },
        options: {
            responsive: true, maintainAspectRatio: false,
            cutout: '72%',
            plugins: {
                legend: { position: 'bottom', labels: { padding: 16, usePointStyle: true, pointStyle: 'circle', font: { size: 11 } } },
                tooltip: { callbacks: { label: (c) => c.label + ': ' + vndFormat(c.parsed) } }
            }
        }
    });

    // ═══ 3. BAR: Revenue by Movie ═══
    new Chart(document.getElementById('movieBarChart'), {
        type: 'bar',
        data: {
            labels: movieLabels,
            datasets: [{
                label: 'Doanh thu',
                data: movieData,
                backgroundColor: palette.map(c => c + '99'),
                borderColor: palette,
                borderWidth: 2,
                borderRadius: 8,
                borderSkipped: false
            }]
        },
        options: {
            responsive: true, maintainAspectRatio: false,
            indexAxis: 'y',
            plugins: {
                legend: { display: false },
                tooltip: { callbacks: { label: (c) => vndFormat(c.parsed.x) } }
            },
            scales: {
                x: { beginAtZero: true, grid: { color: gridColor }, ticks: { callback: (v) => (v / 1000) + 'k' } },
                y: { grid: { display: false } }
            }
        }
    });

    // ═══ 4. AREA: Revenue vs Discount comparison ═══
    // Simulate discount data as a fraction of revenue per day
    const discountRatio = ${totalRevenue > 0 ? totalDiscount * 1.0 / totalRevenue : 0};
    const dailyDiscount = dailyData.map(d => Math.round(d * discountRatio));
    
    new Chart(document.getElementById('revDiscountChart'), {
        type: 'line',
        data: {
            labels: dailyLabels,
            datasets: [
                {
                    label: 'Doanh thu',
                    data: dailyData,
                    borderColor: '#10b981',
                    backgroundColor: 'rgba(16,185,129,0.1)',
                    borderWidth: 2.5, fill: true, tension: 0.4,
                    pointRadius: 4, pointBackgroundColor: '#10b981', pointBorderColor: '#1e293b', pointBorderWidth: 2
                },
                {
                    label: 'Giảm giá',
                    data: dailyDiscount,
                    borderColor: '#f43f5e',
                    backgroundColor: 'rgba(244,63,94,0.08)',
                    borderWidth: 2.5, fill: true, tension: 0.4, borderDash: [5,5],
                    pointRadius: 4, pointBackgroundColor: '#f43f5e', pointBorderColor: '#1e293b', pointBorderWidth: 2
                }
            ]
        },
        options: {
            responsive: true, maintainAspectRatio: false,
            plugins: {
                legend: { labels: { usePointStyle: true, pointStyle: 'circle', padding: 20, font: { size: 11 } } },
                tooltip: { callbacks: { label: (c) => c.dataset.label + ': ' + vndFormat(c.parsed.y) } }
            },
            scales: {
                y: { beginAtZero: true, grid: { color: gridColor }, ticks: { callback: (v) => (v / 1000) + 'k' } },
                x: { grid: { display: false } }
            }
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
