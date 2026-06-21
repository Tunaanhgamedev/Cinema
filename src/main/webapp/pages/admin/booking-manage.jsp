<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Đơn hàng | Admin Cinema</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-style.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
</head>
<body class="bg-[#0f172a] text-slate-200">

<div class="admin-layout">
    <jsp:include page="/common/admin/sidebar.jsp">
        <jsp:param name="activeTab" value="bookings" />
    </jsp:include>

    <div class="main-content min-h-screen">
        <div class="flex justify-between items-center mb-12">
            <div>
                <h1 class="text-4xl font-extrabold tracking-tight text-white mb-2">Quản lý Đơn hàng</h1>
                <p class="text-slate-400">Theo dõi trạng thái thanh toán và thông tin đặt vé của khách hàng.</p>
            </div>
            <div class="flex gap-4">
                <div class="card-glass px-6 py-3 flex items-center gap-3">
                    <i class="fas fa-filter text-indigo-400"></i>
                    <span class="text-sm font-bold text-slate-300">Lọc đơn hàng</span>
                </div>
            </div>
        </div>

        <div class="card-glass overflow-hidden">
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="text-slate-500 text-[10px] font-black uppercase tracking-[2px] border-b border-white/5 bg-white/5">
                            <th class="px-8 py-5">MÃ ĐƠN</th>
                            <th class="px-8 py-5">KHÁCH HÀNG</th>
                            <th class="px-8 py-5">PHIM / SUẤT CHIẾU</th>
                            <th class="px-8 py-5">TỔNG TIỀN</th>
                            <th class="px-8 py-5">TRẠNG THÁI</th>
                            <th class="px-8 py-5 text-right">THAO TÁC</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-white/5">
                        <c:forEach var="b" items="${bookingList}">
                            <tr class="hover:bg-white/5 transition-colors group">
                                <td class="px-8 py-5"><span class="font-mono text-indigo-400 font-bold">#BK${b.bookingId}</span></td>
                                <td class="px-8 py-5">
                                    <div class="font-bold text-white text-sm mb-1">${b.fullName}</div>
                                    <div class="text-slate-500 text-[11px] font-medium tracking-wider uppercase">${b.email}</div>
                                </td>
                                <td class="px-8 py-5">
                                    <div class="text-white text-sm font-bold mb-1">${b.movieTitle}</div>
                                    <div class="text-slate-500 text-[11px] font-medium tracking-wider uppercase">${b.roomName} • <fmt:formatDate value="${b.startTime}" pattern="dd/MM/yyyy HH:mm" /></div>
                                </td>
                                <td class="px-8 py-5">
                                    <div class="font-black text-white"><fmt:formatNumber value="${b.grandTotal}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></div>
                                    <div class="text-slate-500 text-[10px] uppercase font-bold">${b.seatCount} ghế</div>
                                </td>
                                <td class="px-8 py-5">
                                    <c:choose>
                                        <c:when test="${b.status == 'PAID'}">
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-emerald-500/10 text-emerald-500 border border-emerald-500/20 text-[10px] font-black uppercase tracking-wider">
                                                <i class="fas fa-check-circle text-[8px]"></i> Đã thanh toán
                                            </span>
                                        </c:when>
                                        <c:when test="${b.status == 'PENDING'}">
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-amber-500/10 text-amber-500 border border-amber-500/20 text-[10px] font-black uppercase tracking-wider">
                                                <i class="fas fa-clock text-[8px]"></i> Chờ xử lý
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-rose-500/10 text-rose-500 border border-rose-500/20 text-[10px] font-black uppercase tracking-wider">
                                                <i class="fas fa-times-circle text-[8px]"></i> Đã hủy
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-8 py-5 text-right">
                                    <div class="flex justify-end gap-4 items-center">
                                        <a href="${pageContext.request.contextPath}/admin/bookings?bookingId=${b.bookingId}" 
                                           class="w-9 h-9 rounded-lg bg-indigo-500/10 text-indigo-400 flex items-center justify-center hover:bg-indigo-500 hover:text-white transition-all" 
                                           title="Xem chi tiết">
                                             <i class="fas fa-eye text-xs"></i>
                                         </a>
                                         
                                         <form action="${pageContext.request.contextPath}/admin/bookings" method="POST" class="flex gap-2">
                                             <input type="hidden" name="action" value="status">
                                             <input type="hidden" name="bookingId" value="${b.bookingId}">
                                             <select name="status" class="bg-white/5 border border-white/10 rounded-lg text-white text-[10px] font-black uppercase px-3 py-2 focus:ring-2 focus:ring-indigo-500 outline-none cursor-pointer">
                                                 <option value="PENDING" ${b.status == 'PENDING' ? 'selected' : ''}>CHỜ XỬ LÝ</option>
                                                 <option value="PAID" ${b.status == 'PAID' ? 'selected' : ''}>ĐÃ THANH TOÁN</option>
                                                 <option value="CANCELLED" ${b.status == 'CANCELLED' ? 'selected' : ''}>HỦY ĐƠN</option>
                                             </select>
                                             <button type="submit" class="w-9 h-9 rounded-lg bg-emerald-500 text-white flex items-center justify-center hover:bg-emerald-400 shadow-lg shadow-emerald-500/20 transition-all">
                                                 <i class="fas fa-check text-xs"></i>
                                             </button>
                                         </form>
                                     </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty bookingList}">
                            <tr>
                                <td colspan="6" class="p-20 text-center flex flex-col items-center">
                                    <div class="w-20 h-20 bg-slate-800/50 rounded-full flex items-center justify-center text-slate-600 text-3xl mb-4">
                                        <i class="fas fa-receipt"></i>
                                    </div>
                                    <p class="text-slate-500 font-bold">Chưa có giao dịch nào phát sinh.</p>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
