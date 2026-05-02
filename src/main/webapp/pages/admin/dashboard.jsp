<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
            theme: {
                extend: {
                    colors: {
                        accent: '#6366f1',
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-[#0f172a] text-slate-200">

<div class="admin-layout">
    <jsp:include page="/common/admin/sidebar.jsp" />

    <div class="main-content">
        <!-- Header -->
        <div class="flex justify-between items-center mb-12">
            <div>
                <h1 class="text-4xl font-extrabold tracking-tight text-white mb-2">Chào buổi sáng, Admin!</h1>
                <p class="text-slate-400">Dưới đây là tình hình hoạt động của hệ thống BOBIXI Cinema hôm nay.</p>
            </div>
            <div class="flex items-center gap-4">
                <div class="card-glass px-4 py-2 flex items-center gap-3">
                    <div class="w-2 h-2 rounded-full bg-emerald-500 animate-pulse"></div>
                    <span class="text-xs font-bold text-slate-300 uppercase tracking-widest">Hệ thống: Ổn định</span>
                </div>
            </div>
        </div>

        <!-- Quick Stats Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-12">
            <!-- Movie Stats -->
            <div class="card-glass p-6 group hover:border-indigo-500/30 transition-all">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-2xl bg-indigo-500/10 flex items-center justify-center text-indigo-400 group-hover:scale-110 transition-transform">
                        <i class="fas fa-film text-xl"></i>
                    </div>
                </div>
                <h3 class="text-slate-400 text-xs font-black uppercase tracking-widest mb-1">Tổng Phim</h3>
                <div class="text-3xl font-black text-white">${totalMovies}</div>
            </div>

            <!-- Booking Stats -->
            <div class="card-glass p-6 group hover:border-sky-500/30 transition-all">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-2xl bg-sky-500/10 flex items-center justify-center text-sky-400 group-hover:scale-110 transition-transform">
                        <i class="fas fa-ticket-alt text-xl"></i>
                    </div>
                </div>
                <h3 class="text-slate-400 text-xs font-black uppercase tracking-widest mb-1">Vé đã bán</h3>
                <div class="text-3xl font-black text-white">${totalBookings}</div>
            </div>

            <!-- Revenue Stats -->
            <div class="card-glass p-6 group hover:border-emerald-500/30 transition-all">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-2xl bg-emerald-500/10 flex items-center justify-center text-emerald-400 group-hover:scale-110 transition-transform">
                        <i class="fas fa-coins text-xl"></i>
                    </div>
                </div>
                <h3 class="text-slate-400 text-xs font-black uppercase tracking-widest mb-1">Doanh thu</h3>
                <div class="text-3xl font-black text-white"><fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></div>
            </div>

            <!-- Discount Stats -->
            <div class="card-glass p-6 group hover:border-rose-500/30 transition-all">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-2xl bg-rose-500/10 flex items-center justify-center text-rose-400 group-hover:scale-110 transition-transform">
                        <i class="fas fa-percent text-xl"></i>
                    </div>
                </div>
                <h3 class="text-slate-400 text-xs font-black uppercase tracking-widest mb-1">Tổng Giảm giá</h3>
                <div class="text-3xl font-black text-white"><fmt:formatNumber value="${totalDiscount}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></div>
            </div>

            <!-- Voucher Stats -->
            <div class="card-glass p-6 group hover:border-amber-500/30 transition-all">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-2xl bg-amber-500/10 flex items-center justify-center text-amber-400 group-hover:scale-110 transition-transform">
                        <i class="fas fa-tags text-xl"></i>
                    </div>
                </div>
                <h3 class="text-slate-400 text-xs font-black uppercase tracking-widest mb-1">Voucher Đang Chạy</h3>
                <div class="text-3xl font-black text-white">${activeVouchers}</div>
            </div>

            <!-- User Stats -->
            <div class="card-glass p-6 group hover:border-emerald-500/30 transition-all">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-2xl bg-emerald-500/10 flex items-center justify-center text-emerald-400 group-hover:scale-110 transition-transform">
                        <i class="fas fa-users text-xl"></i>
                    </div>
                </div>
                <h3 class="text-slate-400 text-xs font-black uppercase tracking-widest mb-1">Thành viên</h3>
                <div class="text-3xl font-black text-white">${userCount}</div>
            </div>
        </div>

        <!-- Charts Section -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-12">
            <!-- Line Chart: Daily Revenue -->
            <div class="card-glass p-6">
                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-xl font-bold text-white flex items-center gap-2">
                        <i class="fas fa-chart-line text-indigo-400 text-sm"></i> Doanh thu 7 ngày qua
                    </h2>
                </div>
                <div class="h-[300px] w-full">
                    <canvas id="dailyRevenueChart"></canvas>
                </div>
            </div>

            <!-- Pie Chart: Revenue by Movie -->
            <div class="card-glass p-6">
                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-xl font-bold text-white flex items-center gap-2">
                        <i class="fas fa-chart-pie text-sky-400 text-sm"></i> Doanh thu theo Phim
                    </h2>
                </div>
                <div class="h-[300px] w-full flex justify-center">
                    <canvas id="movieRevenueChart"></canvas>
                </div>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <!-- Recent Bookings Table -->
            <div class="lg:col-span-2">
                <div class="card-glass overflow-hidden">
                    <div class="p-6 border-b border-white/5 flex justify-between items-center bg-white/5">
                        <h2 class="text-xl font-bold text-white flex items-center gap-2">
                            <i class="fas fa-history text-indigo-400 text-sm"></i> Giao dịch gần đây
                        </h2>
                        <a href="${pageContext.request.contextPath}/admin/bookings" class="text-indigo-400 text-xs font-bold hover:text-white transition-colors uppercase tracking-widest">Xem tất cả</a>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full text-left">
                            <thead>
                                <tr class="text-slate-500 text-[10px] font-black uppercase tracking-widest border-b border-white/5 bg-white/2">
                                    <th class="px-6 py-4">Mã Đơn</th>
                                    <th class="px-6 py-4">Khách hàng</th>
                                    <th class="px-6 py-4">Phim</th>
                                    <th class="px-6 py-4 text-right">Tổng tiền</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-white/5">
                                <c:forEach var="b" items="${recentBookings}">
                                    <tr class="hover:bg-white/2 transition-colors">
                                        <td class="px-6 py-4 font-mono text-indigo-400 text-xs">#BK${b.bookingId}</td>
                                        <td class="px-6 py-4">
                                            <div class="text-white font-bold text-sm">${b.fullName}</div>
                                            <div class="text-slate-500 text-[10px]">${b.email}</div>
                                        </td>
                                        <td class="px-6 py-4 text-slate-400 text-xs font-medium">${b.movieTitle}</td>
                                        <td class="px-6 py-4 text-right font-bold text-emerald-400">
                                            <fmt:formatNumber value="${b.grandTotal}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty recentBookings}">
                                    <tr><td colspan="4" class="px-6 py-12 text-center text-slate-500 text-sm italic">Chưa có giao dịch nào gần đây.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Notifications / Logs -->
            <div class="space-y-6">
                <div class="card-glass p-6">
                    <h2 class="text-xl font-bold text-white mb-6 flex items-center gap-2">
                        <i class="fas fa-bell text-amber-400 text-sm"></i> Thông báo nhanh
                    </h2>
                    <div class="space-y-6">
                        <div class="flex gap-4 group">
                            <div class="w-1.5 h-1.5 rounded-full bg-sky-500 mt-2 shadow-[0_0_10px_rgba(14,165,233,0.5)]"></div>
                            <div>
                                <p class="text-white text-sm font-bold group-hover:text-sky-400 transition-colors">5 suất chiếu mới được thêm</p>
                                <p class="text-slate-500 text-[10px] uppercase tracking-widest mt-1">Cách đây 10 phút</p>
                            </div>
                        </div>
                        <div class="flex gap-4 group">
                            <div class="w-1.5 h-1.5 rounded-full bg-emerald-500 mt-2 shadow-[0_0_10px_rgba(16,185,129,0.5)]"></div>
                            <div>
                                <p class="text-white text-sm font-bold group-hover:text-emerald-400 transition-colors">Yêu cầu thanh toán hoàn tất</p>
                                <p class="text-slate-500 text-[10px] uppercase tracking-widest mt-1">Cách đây 25 phút</p>
                            </div>
                        </div>
                        <div class="flex gap-4 group">
                            <div class="w-1.5 h-1.5 rounded-full bg-rose-500 mt-2 shadow-[0_0_10px_rgba(244,63,94,0.5)]"></div>
                            <div>
                                <p class="text-white text-sm font-bold group-hover:text-rose-400 transition-colors">Cảnh báo: Phòng chiếu số 3 lỗi đèn</p>
                                <p class="text-slate-500 text-[10px] uppercase tracking-widest mt-1">Cách đây 1 giờ</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Config Chart.js defaults
    Chart.defaults.color = '#94a3b8';
    Chart.defaults.font.family = "'Outfit', sans-serif";

    // 1. Daily Revenue Chart
    const dailyCtx = document.getElementById('dailyRevenueChart').getContext('2d');
    const dailyLabels = [
        <c:forEach var="item" items="${revenueDaily}" varStatus="loop">
            '${item.label}'${!loop.last ? ',' : ''}
        </c:forEach>
    ];
    const dailyData = [
        <c:forEach var="item" items="${revenueDaily}" varStatus="loop">
            ${item.value}${!loop.last ? ',' : ''}
        </c:forEach>
    ];

    new Chart(dailyCtx, {
        type: 'line',
        data: {
            labels: dailyLabels,
            datasets: [{
                label: 'Doanh thu (₫)',
                data: dailyData,
                borderColor: '#6366f1',
                backgroundColor: 'rgba(99, 102, 241, 0.1)',
                borderWidth: 3,
                fill: true,
                tension: 0.4,
                pointBackgroundColor: '#6366f1',
                pointBorderColor: '#fff',
                pointBorderWidth: 2,
                pointRadius: 4,
                pointHoverRadius: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { color: 'rgba(255, 255, 255, 0.05)' },
                    ticks: {
                        callback: (value) => value.toLocaleString('vi-VN') + ' ₫'
                    }
                },
                x: {
                    grid: { display: false }
                }
            }
        }
    });

    // 2. Movie Revenue Chart
    const movieCtx = document.getElementById('movieRevenueChart').getContext('2d');
    const movieLabels = [
        <c:forEach var="item" items="${revenueMovie}" varStatus="loop">
            '${item.label}'${!loop.last ? ',' : ''}
        </c:forEach>
    ];
    const movieData = [
        <c:forEach var="item" items="${revenueMovie}" varStatus="loop">
            ${item.value}${!loop.last ? ',' : ''}
        </c:forEach>
    ];

    new Chart(movieCtx, {
        type: 'doughnut',
        data: {
            labels: movieLabels,
            datasets: [{
                data: movieData,
                backgroundColor: [
                    '#6366f1', '#0ea5e9', '#f59e0b', '#10b981', '#f43f5e'
                ],
                borderWidth: 0,
                hoverOffset: 20
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'right',
                    labels: {
                        padding: 20,
                        usePointStyle: true,
                        pointStyle: 'circle'
                    }
                }
            },
            cutout: '70%'
        }
    });
</script>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
