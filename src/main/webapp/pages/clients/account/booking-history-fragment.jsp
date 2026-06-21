<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${empty historyList}">
    <div class="text-center py-24 bg-white/5 rounded-[2.5rem] border border-white/10">
        <div class="w-24 h-24 bg-slate-800 rounded-full flex items-center justify-center mx-auto mb-6 text-slate-600">
            <i class="fas fa-ticket-alt text-4xl"></i>
        </div>
        <h3 class="text-2xl font-bold text-white mb-2">Chưa có giao dịch nào</h3>
        <p class="text-slate-500 mb-10 max-w-sm mx-auto">Bạn chưa thực hiện giao dịch mua vé nào. Hãy chọn phim và trải nghiệm ngay!</p>
        <a href="${pageContext.request.contextPath}/home" class="inline-block px-10 py-4 bg-primary rounded-2xl text-white font-black text-sm hover:scale-105 transition-all shadow-xl shadow-primary/20">
            ĐẶT VÉ NGAY
        </a>
    </div>
</c:if>

<div class="space-y-6">
    <c:forEach var="item" items="${historyList}">
        <div class="group relative flex flex-col md:flex-row bg-white/5 border border-white/10 rounded-[2rem] overflow-hidden hover:bg-white/10 hover:border-primary/30 transition-all duration-500">
            
            <!-- Poster Area -->
            <div class="md:w-48 shrink-0 relative overflow-hidden">
                <img src="${item.movie.poster.startsWith('http') ? item.movie.poster : pageContext.request.contextPath.concat('/assets/images/movies/').concat(item.movie.poster)}" 
                     class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" 
                     onerror="this.src='https://placehold.co/300x450?text=No+Poster'">
                <div class="absolute inset-0 bg-gradient-to-r from-slate-900/40 to-transparent"></div>
                
                <!-- Status Badge on Image -->
                <div class="absolute top-4 left-4">
                    <c:choose>
                        <c:when test="${item.booking.status == 'PAID'}">
                            <span class="px-3 py-1 rounded-lg bg-emerald-500 text-white text-[10px] font-black uppercase tracking-widest shadow-lg shadow-emerald-500/30">Đã thanh toán</span>
                        </c:when>
                        <c:when test="${item.booking.status == 'PENDING'}">
                            <span class="px-3 py-1 rounded-lg bg-amber-500 text-white text-[10px] font-black uppercase tracking-widest shadow-lg shadow-amber-500/30">Chờ xử lý</span>
                        </c:when>
                        <c:otherwise>
                            <span class="px-3 py-1 rounded-lg bg-rose-500 text-white text-[10px] font-black uppercase tracking-widest shadow-lg shadow-rose-500/30">Đã hủy</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <!-- Ticket Content -->
            <div class="flex-1 p-8 flex flex-col justify-between">
                <div>
                    <div class="flex flex-wrap justify-between items-start gap-4 mb-6">
                        <div>
                            <p class="text-[10px] text-primary font-black tracking-[0.2em] uppercase mb-1">Mã vé: #${item.booking.bookingId}</p>
                            <h3 class="text-2xl font-black text-white group-hover:text-primary transition-colors">${item.movie.title}</h3>
                        </div>
                        <div class="text-right">
                            <p class="text-[10px] text-slate-500 font-bold uppercase tracking-widest mb-1">Ngày mua</p>
                            <p class="text-sm font-bold text-slate-300"><fmt:formatDate value="${item.booking.bookingDate}" pattern="dd/MM/yyyy" /></p>
                        </div>
                    </div>

                    <div class="grid grid-cols-2 lg:grid-cols-3 gap-6 py-6 border-y border-white/5">
                        <div class="space-y-1">
                            <p class="text-[10px] text-slate-500 font-bold uppercase tracking-widest">Suất chiếu</p>
                            <p class="text-sm font-black text-white"><fmt:formatDate value="${item.showtime.startTime}" pattern="HH:mm - dd/MM" /></p>
                        </div>
                        <div class="space-y-1">
                            <p class="text-[10px] text-slate-500 font-bold uppercase tracking-widest">Phòng chiếu</p>
                            <p class="text-sm font-black text-white">${item.showtime.roomName}</p>
                        </div>
                        <div class="space-y-1 col-span-2 lg:col-span-1">
                            <p class="text-[10px] text-slate-500 font-bold uppercase tracking-widest">Ghế ngồi</p>
                            <p class="text-sm font-black text-rose-400">
                                <c:forEach var="s" items="${item.seats}" varStatus="loop">
                                    ${s.seatRow}${s.seatNumber}${!loop.last ? ', ' : ''}
                                </c:forEach>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="flex items-center justify-between mt-6">
                    <div>
                        <p class="text-[10px] text-slate-500 font-bold uppercase tracking-widest mb-1">Tổng thanh toán</p>
                        <p class="text-2xl font-black text-white"><fmt:formatNumber value="${item.booking.totalPrice}" pattern="#,###"/> <span class="text-xs">đ</span></p>
                    </div>
                    
                    <c:if test="${item.booking.status == 'PAID'}">
                        <a href="${pageContext.request.contextPath}/booking/invoice?bookingId=${item.booking.bookingId}" 
                           class="w-12 h-12 rounded-2xl bg-white/5 flex items-center justify-center text-slate-400 hover:bg-primary hover:text-white transition-all shadow-xl"
                           title="Xem hóa đơn">
                            <i class="fas fa-file-invoice text-lg"></i>
                        </a>
                    </c:if>
                </div>
            </div>

            <!-- Ticket Cut-out Decoration -->
            <div class="hidden md:block absolute left-48 top-1/2 -translate-y-1/2 -translate-x-1/2 space-y-2 opacity-20">
                <div class="w-1 h-1 bg-white rounded-full"></div>
                <div class="w-1 h-1 bg-white rounded-full"></div>
                <div class="w-1 h-1 bg-white rounded-full"></div>
                <div class="w-1 h-1 bg-white rounded-full"></div>
            </div>
        </div>
    </c:forEach>
</div>
