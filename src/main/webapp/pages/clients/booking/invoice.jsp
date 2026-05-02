<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hóa đơn thanh toán | BOBIXI Cinema</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { font-family: 'Outfit', sans-serif; background-color: #f1f5f9; }
        .invoice-card { background: white; border-radius: 24px; box-shadow: 0 20px 50px rgba(0,0,0,0.05); overflow: hidden; max-width: 800px; margin: 40px auto; }
        .invoice-header { background: #0f172a; color: white; padding: 40px; }
        .invoice-body { padding: 40px; }
        .ticket-stub { border: 2px dashed #e2e8f0; border-radius: 16px; padding: 20px; background: #f8fafc; }
        .qr-placeholder { width: 120px; height: 120px; background: white; border-radius: 12px; display: flex; align-items: center; justify-content: center; border: 1px solid #e2e8f0; }
        @media print {
            .no-print { display: none; }
            body { background: white; }
            .invoice-card { box-shadow: none; margin: 0; max-width: 100%; }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="invoice-card">
        <!-- Header -->
        <div class="invoice-header flex justify-between items-center">
            <div>
                <h1 class="text-3xl font-black tracking-tighter mb-1">BOBIXI CINEMA</h1>
                <p class="text-slate-400 text-sm">Hóa đơn điện tử giao dịch trực tuyến</p>
            </div>
            <div class="text-right">
                <div class="text-xs uppercase tracking-widest text-slate-400 mb-1">Mã hóa đơn</div>
                <div class="text-xl font-bold">#INV-${booking.bookingId}</div>
            </div>
        </div>

        <!-- Body -->
        <div class="invoice-body">
            <div class="row mb-12">
                <div class="col-md-6">
                    <h5 class="text-slate-400 text-[10px] uppercase font-black tracking-[2px] mb-4">THÔNG TIN KHÁCH HÀNG</h5>
                    <div class="font-bold text-lg text-slate-900">${authUser.fullName}</div>
                    <div class="text-slate-500">${authUser.email}</div>
                    <div class="text-slate-500">${authUser.phoneNumber}</div>
                </div>
                <div class="col-md-6 text-md-end">
                    <h5 class="text-slate-400 text-[10px] uppercase font-black tracking-[2px] mb-4">THỜI GIAN GIAO DỊCH</h5>
                    <div class="font-bold text-lg text-slate-900">
                        <fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy HH:mm" />
                    </div>
                    <div class="text-emerald-500 font-bold uppercase text-xs mt-2 flex items-center justify-end gap-1">
                        <i class="fas fa-check-circle"></i> Đã thanh toán
                    </div>
                </div>
            </div>

            <!-- Ticket Details -->
            <div class="ticket-stub mb-12">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h4 class="text-2xl font-black text-slate-900 mb-2">${movie.title}</h4>
                        <div class="flex gap-4 text-sm text-slate-600 mb-4">
                            <span><i class="fas fa-map-marker-alt text-indigo-500"></i> BOBIXI Đà Nẵng</span>
                            <span><i class="fas fa-door-open text-indigo-500"></i> ${showtime.roomName}</span>
                        </div>
                        <div class="row g-3">
                            <div class="col-4">
                                <div class="text-[10px] text-slate-400 uppercase font-bold">Ngày chiếu</div>
                                <div class="font-bold"><fmt:formatDate value="${showtime.startTime}" pattern="dd/MM/yyyy" /></div>
                            </div>
                            <div class="col-4">
                                <div class="text-[10px] text-slate-400 uppercase font-bold">Suất chiếu</div>
                                <div class="font-bold text-indigo-600"><fmt:formatDate value="${showtime.startTime}" pattern="HH:mm" /></div>
                            </div>
                            <div class="col-4">
                                <div class="text-[10px] text-slate-400 uppercase font-bold">Số ghế</div>
                                <div class="font-bold">
                                    <c:forEach var="s" items="${seats}" varStatus="loop">
                                        ${s.seatRow}${s.seatNumber}${!loop.last ? ', ' : ''}
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 flex justify-end">
                        <div class="qr-code-wrapper p-2 bg-white rounded-xl border border-slate-100 shadow-sm">
                            <img src="https://api.qrserver.com/v1/create-qr-code/?size=120x120&data=BOBIXI-TICKET-${booking.bookingId}" 
                                 alt="QR Code" class="w-24 h-24 md:w-32 md:h-32">
                        </div>
                    </div>
                </div>
            </div>

            <!-- Pricing -->
            <table class="w-full mb-8">
                <thead>
                    <tr class="border-b border-slate-100">
                        <th class="py-4 text-left text-[10px] uppercase font-black text-slate-400">MÔ TẢ</th>
                        <th class="py-4 text-center text-[10px] uppercase font-black text-slate-400">SỐ LƯỢNG</th>
                        <th class="py-4 text-right text-[10px] uppercase font-black text-slate-400">THÀNH TIỀN</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="border-b border-slate-50">
                        <td class="py-4">
                            <div class="font-bold text-slate-800">Vé xem phim 2D</div>
                            <div class="text-xs text-slate-400">${movie.title}</div>
                        </td>
                        <td class="py-4 text-center text-slate-600">x${seats.size()}</td>
                        <td class="py-4 text-right font-bold text-slate-800">
                            <fmt:formatNumber value="${booking.totalPrice + booking.discountAmount}" pattern="#,###"/>đ
                        </td>
                    </tr>
                    <c:if test="${booking.discountAmount > 0}">
                        <tr class="text-rose-500">
                            <td class="py-3">Mã giảm giá (Voucher)</td>
                            <td class="py-3 text-center">-</td>
                            <td class="py-3 text-right font-bold">-<fmt:formatNumber value="${booking.discountAmount}" pattern="#,###"/>đ</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>

            <div class="flex justify-end">
                <div class="w-full md:w-64">
                    <div class="flex justify-between mb-2">
                        <span class="text-slate-400">Tạm tính:</span>
                        <span class="font-bold text-slate-700"><fmt:formatNumber value="${booking.totalPrice + booking.discountAmount}" pattern="#,###"/>đ</span>
                    </div>
                    <div class="flex justify-between mb-4">
                        <span class="text-slate-400">Giảm giá:</span>
                        <span class="font-bold text-rose-500">-<fmt:formatNumber value="${booking.discountAmount}" pattern="#,###"/>đ</span>
                    </div>
                    <div class="flex justify-between items-center pt-4 border-t-2 border-slate-900">
                        <span class="font-black text-slate-900 uppercase tracking-tighter">Tổng cộng</span>
                        <span class="text-2xl font-black text-indigo-600"><fmt:formatNumber value="${booking.totalPrice}" pattern="#,###"/>đ</span>
                    </div>
                    <!-- Points Earned -->
                    <div class="mt-4 p-3 bg-indigo-50 rounded-xl flex items-center justify-between border border-indigo-100">
                        <div class="flex items-center gap-2">
                            <i class="fas fa-gift text-indigo-600"></i>
                            <span class="text-xs font-bold text-indigo-800 uppercase">Điểm thưởng vừa nhận</span>
                        </div>
                        <span class="font-black text-indigo-600">+<fmt:formatNumber value="${booking.totalPrice / 1000}" pattern="#,###"/> PTS</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer Actions -->
        <div class="p-8 bg-slate-50 border-t border-slate-100 flex justify-between no-print">
            <a href="${pageContext.request.contextPath}/home" class="text-slate-500 hover:text-slate-800 font-bold flex items-center gap-2 transition-colors">
                <i class="fas fa-arrow-left"></i> Quay lại trang chủ
            </a>
            <div class="flex gap-3">
                <button onclick="window.print()" class="bg-slate-800 hover:bg-slate-900 text-white font-bold py-2 px-6 rounded-xl transition-all flex items-center gap-2">
                    <i class="fas fa-print"></i> In hóa đơn
                </button>
                <a href="${pageContext.request.contextPath}/booking/history" class="bg-indigo-600 hover:bg-indigo-500 text-white font-bold py-2 px-6 rounded-xl transition-all shadow-lg shadow-indigo-600/20">
                    Xem lịch sử đặt vé
                </a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
