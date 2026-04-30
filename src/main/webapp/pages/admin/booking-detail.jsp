<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Đơn hàng | Admin Cinema</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-[#0f172a] text-slate-200">

<jsp:include page="/common/admin-sidebar.jsp">
    <jsp:param name="activeTab" value="bookings" />
</jsp:include>

<div class="main-content min-h-screen">
    <!-- Back Button & Title -->
    <div class="mb-10">
        <a href="${pageContext.request.contextPath}/admin/bookings" 
           class="inline-flex items-center gap-2 text-slate-400 hover:text-white transition-colors mb-4 group">
            <i class="fas fa-arrow-left group-hover:-translate-x-1 transition-transform"></i>
            <span class="text-sm font-bold uppercase tracking-wider">Danh sách đơn hàng</span>
        </a>
        <h1 class="text-3xl font-black text-white tracking-tight">Chi tiết Hóa đơn <span class="text-indigo-500">#${detail.bookingId}</span></h1>
    </div>

    <c:choose>
        <c:when test="${empty detail}">
            <div class="bg-rose-500/10 border border-rose-500/20 p-6 rounded-2xl text-rose-400 font-bold flex items-center gap-3">
                <i class="fas fa-exclamation-circle"></i>
                Không tìm thấy thông tin đơn hàng yêu cầu.
            </div>
        </c:when>
        <c:otherwise>
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <!-- Left Column: Order Information -->
                <div class="lg:col-span-2 space-y-8">
                    <!-- Ticket Details -->
                    <div class="glass-effect rounded-[2.5rem] p-8 border border-slate-800 shadow-xl relative overflow-hidden">
                        <div class="absolute top-0 right-0 p-8 opacity-10 pointer-events-none">
                            <i class="fas fa-ticket-alt text-8xl"></i>
                        </div>
                        <h3 class="text-xl font-black text-white mb-8 flex items-center gap-3">
                            <span class="w-8 h-8 rounded-lg bg-indigo-500 flex items-center justify-center text-xs">01</span>
                            Thông tin Vé xem phim
                        </h3>
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-y-8 gap-x-12">
                            <div>
                                <label class="text-[10px] font-black text-slate-500 uppercase tracking-widest mb-2 block">Tên phim công chiếu</label>
                                <div class="text-xl font-bold text-white group-hover:text-indigo-400 transition-colors">${detail.movieTitle}</div>
                            </div>
                            <div>
                                <label class="text-[10px] font-black text-slate-500 uppercase tracking-widest mb-2 block">Phòng chiếu</label>
                                <div class="text-xl font-bold text-indigo-400">${detail.roomName}</div>
                            </div>
                            <div>
                                <label class="text-[10px] font-black text-slate-500 uppercase tracking-widest mb-2 block">Thời điểm bắt đầu</label>
                                <div class="text-white font-bold"><fmt:formatDate value="${detail.startTime}" pattern="dd MMM, yyyy • HH:mm" /></div>
                            </div>
                            <div>
                                <label class="text-[10px] font-black text-slate-500 uppercase tracking-widest mb-2 block">Thời điểm kết thúc</label>
                                <div class="text-slate-400 font-bold"><fmt:formatDate value="${detail.endTime}" pattern="dd MMM, yyyy • HH:mm" /></div>
                            </div>
                            <div class="md:col-span-2">
                                <label class="text-[10px] font-black text-slate-500 uppercase tracking-widest mb-4 block">Vị trí ghế ngồi (${detail.seatCount})</label>
                                <div class="flex flex-wrap gap-2">
                                    <c:forEach var="s" items="${detail.seats}">
                                        <span class="px-4 py-2 rounded-xl bg-slate-900 border border-slate-700 text-white font-black text-sm shadow-inner">${s}</span>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Combo Details -->
                    <div class="glass-effect rounded-[2.5rem] p-8 border border-slate-800 shadow-xl overflow-hidden">
                        <h3 class="text-xl font-black text-white mb-8 flex items-center gap-3">
                            <span class="w-8 h-8 rounded-lg bg-amber-500 flex items-center justify-center text-xs">02</span>
                            Gói Combo Thực phẩm
                        </h3>
                        <div class="overflow-x-auto">
                            <table class="w-full text-left">
                                <thead>
                                    <tr class="border-b border-slate-800">
                                        <th class="pb-4 text-[11px] font-black text-slate-500 uppercase tracking-widest">Sản phẩm</th>
                                        <th class="pb-4 text-[11px] font-black text-slate-500 uppercase tracking-widest text-center">SL</th>
                                        <th class="pb-4 text-[11px] font-black text-slate-500 uppercase tracking-widest text-right">Đơn giá</th>
                                        <th class="pb-4 text-[11px] font-black text-slate-500 uppercase tracking-widest text-right">Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-slate-800/50">
                                    <c:forEach var="c" items="${detail.combos}">
                                        <tr>
                                            <td class="py-5 font-bold text-white">${c.name}</td>
                                            <td class="py-5 text-center text-slate-400 font-bold">${c.quantity}</td>
                                            <td class="py-5 text-right text-slate-400 font-medium">
                                                <fmt:formatNumber value="${c.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                            </td>
                                            <td class="py-5 text-right text-indigo-400 font-black">
                                                <fmt:formatNumber value="${c.lineTotal}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty detail.combos}">
                                        <tr>
                                            <td colspan="4" class="py-10 text-center text-slate-500 italic text-sm">
                                                Khách hàng không mua kèm combo thực phẩm.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Right Column: Summary -->
                <div class="space-y-8">
                    <!-- Customer Info -->
                    <div class="glass-effect rounded-[2.5rem] p-8 border border-slate-800 shadow-xl">
                        <h3 class="text-lg font-black text-white mb-6 uppercase tracking-wider">Khách hàng</h3>
                        <div class="flex items-center gap-4 bg-slate-900/50 p-5 rounded-2xl border border-slate-800">
                            <div class="w-14 h-14 rounded-xl bg-indigo-500/10 flex items-center justify-center text-indigo-500 text-xl border border-indigo-500/20">
                                <i class="fas fa-user-circle"></i>
                            </div>
                            <div class="overflow-hidden">
                                <div class="text-white font-black truncate">${detail.fullName}</div>
                                <div class="text-slate-500 text-xs truncate">${detail.email}</div>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Summary -->
                    <div class="glass-effect rounded-[2.5rem] p-8 border border-slate-800 shadow-xl relative overflow-hidden">
                        <div class="absolute -bottom-10 -left-10 opacity-5 pointer-events-none">
                            <i class="fas fa-wallet text-[12rem] -rotate-12"></i>
                        </div>
                        <h3 class="text-lg font-black text-white mb-8 uppercase tracking-wider">Tổng kết chi phí</h3>
                        
                        <div class="space-y-4 mb-8 relative z-10">
                            <div class="flex justify-between items-center text-sm">
                                <span class="text-slate-400 font-medium">Tổng tiền vé</span>
                                <span class="text-white font-bold"><fmt:formatNumber value="${detail.ticketSubtotal}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></span>
                            </div>
                            <div class="flex justify-between items-center text-sm">
                                <span class="text-slate-400 font-medium">Tổng tiền Combo</span>
                                <span class="text-white font-bold"><fmt:formatNumber value="${detail.comboSubtotal}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></span>
                            </div>
                            <div class="pt-4 border-t border-slate-800 flex justify-between items-end">
                                <span class="text-white font-black uppercase text-xs tracking-widest mb-1">Thanh toán</span>
                                <span class="text-3xl font-black text-emerald-400 tracking-tighter">
                                    <fmt:formatNumber value="${detail.grandTotal}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                </span>
                            </div>
                        </div>

                        <div class="space-y-4 relative z-10">
                            <label class="block text-[10px] font-black text-slate-500 uppercase tracking-widest mb-2">Trạng thái hiện tại</label>
                            <form action="${pageContext.request.contextPath}/admin/bookings" method="POST" class="space-y-4">
                                <input type="hidden" name="action" value="status">
                                <input type="hidden" name="bookingId" value="${detail.bookingId}">
                                <div class="relative">
                                    <select name="status" class="w-full bg-slate-900 border-2 border-slate-800 rounded-2xl px-5 py-4 text-white focus:border-indigo-600 focus:outline-none transition-all appearance-none cursor-pointer font-bold text-sm">
                                        <option value="PENDING" ${detail.status == 'PENDING' ? 'selected' : ''}>⏳ PENDING</option>
                                        <option value="PAID" ${detail.status == 'PAID' ? 'selected' : ''}>✅ PAID</option>
                                        <option value="CANCELLED" ${detail.status == 'CANCELLED' ? 'selected' : ''}>❌ CANCELLED</option>
                                    </select>
                                    <div class="absolute right-5 top-1/2 -translate-y-1/2 pointer-events-none text-slate-500">
                                        <i class="fas fa-chevron-down text-xs"></i>
                                    </div>
                                </div>
                                <button type="submit" class="w-full py-4 rounded-2xl bg-indigo-600 hover:bg-indigo-500 text-white font-black transition-all shadow-xl shadow-indigo-600/30 uppercase tracking-widest text-[11px]">
                                    Cập nhật Trạng thái
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
