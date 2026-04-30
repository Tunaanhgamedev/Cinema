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
</head>
<body class="bg-[#0f172a] text-slate-200">

<jsp:include page="/common/admin-sidebar.jsp">
    <jsp:param name="activeTab" value="bookings" />
</jsp:include>

<div class="main-content min-h-screen">
    <!-- Header Section -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-6 mb-10">
        <div>
            <h1 class="text-3xl font-black text-white tracking-tight">Trung tâm Giao dịch</h1>
            <p class="text-slate-400 mt-1">Quản lý đặt vé, doanh thu và xác nhận thanh toán.</p>
        </div>
        <div class="flex items-center gap-4 w-full md:w-auto">
            <div class="relative flex-1 md:w-80">
                <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-slate-500"></i>
                <input type="text" placeholder="Tìm mã đơn, khách hàng..." 
                       class="w-full bg-slate-800/50 border border-slate-700 rounded-2xl pl-12 pr-4 py-3 text-sm focus:border-indigo-600 focus:outline-none transition-all">
            </div>
            <button class="bg-slate-800 p-3 rounded-2xl border border-slate-700 text-slate-400 hover:text-white transition-all">
                <i class="fas fa-filter"></i>
            </button>
        </div>
    </div>

    <!-- Data Table Card -->
    <div class="glass-effect rounded-[2.5rem] overflow-hidden border border-slate-800 shadow-2xl">
        <div class="overflow-x-auto">
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr class="bg-slate-900/50">
                        <th class="p-6 text-[11px] font-black text-slate-500 uppercase tracking-widest">Đơn hàng</th>
                        <th class="p-6 text-[11px] font-black text-slate-500 uppercase tracking-widest">Khách hàng</th>
                        <th class="p-6 text-[11px] font-black text-slate-500 uppercase tracking-widest">Chi tiết phim</th>
                        <th class="p-6 text-[11px] font-black text-slate-500 uppercase tracking-widest">Thanh toán</th>
                        <th class="p-6 text-[11px] font-black text-slate-500 uppercase tracking-widest">Trạng thái</th>
                        <th class="p-6 text-[11px] font-black text-slate-500 uppercase tracking-widest text-right">Quản lý</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-800/50">
                    <c:forEach var="b" items="${bookingList}">
                        <tr class="hover:bg-slate-800/30 transition-all group">
                            <td class="p-6">
                                <span class="font-black text-white bg-slate-800 px-3 py-1.5 rounded-lg border border-slate-700 text-xs">
                                    #${b.bookingId}
                                </span>
                            </td>
                            <td class="p-6">
                                <div class="flex flex-col">
                                    <span class="text-white font-bold text-sm">${b.fullName}</span>
                                    <span class="text-slate-500 text-[11px] font-medium mt-1">${b.email}</span>
                                </div>
                            </td>
                            <td class="p-6">
                                <div class="flex flex-col">
                                    <span class="text-indigo-400 font-bold text-sm">${b.movieTitle}</span>
                                    <span class="text-slate-500 text-[11px] mt-1">
                                        <i class="far fa-clock mr-1"></i>
                                        <fmt:formatDate value="${b.startTime}" pattern="dd/MM HH:mm" /> • ${b.roomName}
                                    </span>
                                </div>
                            </td>
                            <td class="p-6">
                                <div class="flex flex-col">
                                    <span class="text-white font-black text-sm">
                                        <fmt:formatNumber value="${b.grandTotal}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                    </span>
                                    <span class="text-slate-500 text-[10px] font-bold uppercase mt-1">${b.seatCount} VÉ ĐÃ ĐẶT</span>
                                </div>
                            </td>
                            <td class="p-6">
                                <c:choose>
                                    <c:when test="${b.status == 'PAID'}">
                                        <span class="bg-emerald-500/10 text-emerald-500 text-[10px] font-black uppercase px-3 py-1.5 rounded-full border border-emerald-500/20">PAID</span>
                                    </c:when>
                                    <c:when test="${b.status == 'REFUNDED'}">
                                        <span class="bg-rose-500/10 text-rose-500 text-[10px] font-black uppercase px-3 py-1.5 rounded-full border border-rose-500/20">REFUNDED</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="bg-amber-500/10 text-amber-500 text-[10px] font-black uppercase px-3 py-1.5 rounded-full border border-amber-500/20">${b.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="p-6">
                                <div class="flex justify-end gap-3">
                                    <a href="${pageContext.request.contextPath}/admin/bookings?bookingId=${b.bookingId}" 
                                       class="w-10 h-10 rounded-xl bg-indigo-500/10 text-indigo-400 hover:bg-indigo-600 hover:text-white transition-all flex items-center justify-center border border-indigo-500/20"
                                       title="Xem chi tiết">
                                        <i class="fas fa-eye text-xs"></i>
                                    </a>
                                    
                                    <form action="${pageContext.request.contextPath}/admin/bookings" method="POST" class="flex items-center gap-2">
                                        <input type="hidden" name="action" value="status">
                                        <input type="hidden" name="bookingId" value="${b.bookingId}">
                                        <select name="status" class="bg-slate-900 border-none rounded-xl text-[10px] font-black px-3 py-2 text-slate-400 focus:ring-2 ring-indigo-500 appearance-none cursor-pointer">
                                            <option value="PENDING" ${b.status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                                            <option value="PAID" ${b.status == 'PAID' ? 'selected' : ''}>PAID</option>
                                            <option value="CANCELLED" ${b.status == 'CANCELLED' ? 'selected' : ''}>CANCELLED</option>
                                        </select>
                                        <button type="submit" class="w-8 h-8 rounded-lg bg-emerald-500 hover:bg-emerald-400 text-white transition-all shadow-lg shadow-emerald-500/20 flex items-center justify-center">
                                            <i class="fas fa-check text-[10px]"></i>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
