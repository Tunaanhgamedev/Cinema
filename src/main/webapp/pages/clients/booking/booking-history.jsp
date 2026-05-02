<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử đặt vé - BoBiXi</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${ctx}/assets/css/header.css" />
</head>

<body class="bg-slate-50 font-sans text-slate-800">
    <!-- Header -->
    <jsp:include page="/common/header.jsp" />

    <main class="min-h-screen pt-32 pb-16">
        <div class="container mx-auto px-4 max-w-5xl">
            
            <div class="flex items-center gap-4 mb-8">
                <a href="${ctx}/home" class="w-10 h-10 rounded-full bg-white shadow-sm flex items-center justify-center text-slate-400 hover:text-indigo-600 hover:shadow-md transition-all">
                    <i class="fas fa-arrow-left"></i>
                </a>
                <h1 class="text-3xl font-black text-slate-900 tracking-tight">Lịch sử đặt vé</h1>
            </div>

            <c:if test="${empty historyList}">
                <div class="bg-white rounded-3xl p-12 text-center shadow-xl shadow-slate-200/40">
                    <div class="w-24 h-24 bg-slate-100 rounded-full flex items-center justify-center mx-auto mb-6">
                        <i class="fas fa-ticket-alt text-4xl text-slate-300"></i>
                    </div>
                    <h2 class="text-2xl font-bold text-slate-800 mb-2">Chưa có vé nào</h2>
                    <p class="text-slate-500 mb-8 max-w-md mx-auto">Bạn chưa thực hiện giao dịch mua vé nào. Hãy chọn cho mình một bộ phim hay và thưởng thức nhé!</p>
                    <a href="${ctx}/home" class="inline-flex items-center gap-2 bg-indigo-600 text-white font-bold px-8 py-3 rounded-full hover:bg-indigo-500 transition-colors shadow-lg shadow-indigo-600/30">
                        <i class="fas fa-film"></i> Xem lịch chiếu ngay
                    </a>
                </div>
            </c:if>

            <c:if test="${not empty historyList}">
                <div class="grid gap-6">
                    <c:forEach var="item" items="${historyList}">
                        <div class="bg-white rounded-2xl overflow-hidden shadow-lg shadow-slate-200/50 flex flex-col md:flex-row border border-slate-100 transition-transform hover:-translate-y-1 hover:shadow-xl">
                            
                            <!-- Movie Poster Area (Left) -->
                            <div class="md:w-48 bg-slate-100 relative shrink-0">
                                <c:choose>
                                    <c:when test="${not empty item.movie and not empty item.movie.poster}">
                                        <img src="${ctx}/${item.movie.poster}" alt="Poster" class="w-full h-48 md:h-full object-cover">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="w-full h-48 md:h-full flex items-center justify-center text-slate-300">
                                            <i class="fas fa-image text-4xl"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                
                                <div class="absolute top-4 left-4">
                                    <c:choose>
                                        <c:when test="${item.booking.status == 'PAID'}">
                                            <span class="bg-emerald-500 text-white text-xs font-bold px-3 py-1 rounded-full shadow-sm">Đã thanh toán</span>
                                        </c:when>
                                        <c:when test="${item.booking.status == 'PENDING'}">
                                            <span class="bg-amber-500 text-white text-xs font-bold px-3 py-1 rounded-full shadow-sm">Chờ thanh toán</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="bg-rose-500 text-white text-xs font-bold px-3 py-1 rounded-full shadow-sm">Đã hủy</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Ticket Info (Right) -->
                            <div class="p-6 md:p-8 flex-1 flex flex-col justify-between">
                                <div>
                                    <div class="flex flex-wrap justify-between items-start gap-4 mb-4">
                                        <div>
                                            <div class="text-xs font-bold text-indigo-500 tracking-widest uppercase mb-1">Mã vé: #${item.booking.bookingId}</div>
                                            <h3 class="text-2xl font-black text-slate-900 leading-tight">
                                                ${not empty item.movie ? item.movie.title : 'Phim không xác định'}
                                            </h3>
                                        </div>
                                        <div class="text-right">
                                            <div class="text-[10px] uppercase font-bold text-slate-400 mb-1">Ngày mua</div>
                                            <div class="text-sm font-semibold text-slate-700">
                                                <fmt:formatDate value="${item.booking.bookingDate}" pattern="dd/MM/yyyy HH:mm" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="grid grid-cols-2 sm:grid-cols-3 gap-6 mb-6">
                                        <div>
                                            <div class="text-[10px] uppercase font-bold text-slate-400 mb-1">Suất chiếu</div>
                                            <div class="font-bold text-slate-800">
                                                <c:if test="${not empty item.showtime}">
                                                    <fmt:formatDate value="${item.showtime.startTime}" pattern="HH:mm - dd/MM" />
                                                </c:if>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="text-[10px] uppercase font-bold text-slate-400 mb-1">Phòng chiếu</div>
                                            <div class="font-bold text-slate-800">
                                                ${not empty item.showtime ? item.showtime.roomName : 'N/A'}
                                            </div>
                                        </div>
                                        <div class="col-span-2 sm:col-span-1">
                                            <div class="text-[10px] uppercase font-bold text-slate-400 mb-1">Ghế ngồi</div>
                                            <div class="font-bold text-indigo-600">
                                                <c:if test="${empty item.seats}">Chưa chọn ghế</c:if>
                                                <c:forEach var="s" items="${item.seats}" varStatus="loop">
                                                    ${s.seatRow}${s.seatNumber}${!loop.last ? ', ' : ''}
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="flex items-center justify-between pt-6 border-t border-slate-100">
                                    <div>
                                        <div class="text-[10px] uppercase font-bold text-slate-400 mb-1">Tổng tiền</div>
                                        <div class="text-xl font-black text-slate-900">
                                            <fmt:formatNumber value="${item.booking.totalPrice}" pattern="#,###"/>đ
                                        </div>
                                    </div>
                                    
                                    <c:if test="${item.booking.status == 'PAID'}">
                                        <a href="${ctx}/booking/invoice?bookingId=${item.booking.bookingId}" class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-slate-100 text-slate-600 hover:bg-indigo-50 hover:text-indigo-600 transition-colors" title="Xem hóa đơn chi tiết">
                                            <i class="fas fa-file-invoice"></i>
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                            
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            
        </div>
    </main>

    <!-- Footer -->
    <jsp:include page="/common/footer.jsp" />
</body>
</html>
