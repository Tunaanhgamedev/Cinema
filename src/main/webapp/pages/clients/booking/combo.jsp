<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn Combo Bắp Nước - BOBIXI Cinema</title>
    <!-- Fonts & Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;900&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { font-family: 'Outfit', sans-serif; }
        .glass-card { 
            background: rgba(30, 41, 59, 0.7); backdrop-blur: 20px; 
            border: 1px solid rgba(255,255,255,0.05); border-radius: 32px; 
        }
        .combo-item { transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); }
        .combo-item:hover { border-color: rgba(99, 102, 241, 0.5); transform: translateY(-2px); box-shadow: 0 10px 30px -10px rgba(99, 102, 241, 0.3); }
        /* Ẩn mũi tên của input type=number */
        input[type=number]::-webkit-inner-spin-button, 
        input[type=number]::-webkit-outer-spin-button { -webkit-appearance: none; margin: 0; }
    </style>
</head>
<body class="bg-[#0f172a] text-slate-200 overflow-x-hidden min-h-screen flex flex-col">
    <jsp:include page="/common/header.jsp" />

    <main class="flex-grow pt-24 pb-32 px-4 max-w-4xl mx-auto w-full relative">
        <div class="glass-card p-8 animate-fade-in-up">
            <div class="flex items-center gap-4 mb-10 pb-6 border-b border-white/5">
                <div class="w-14 h-14 bg-amber-500 rounded-2xl flex items-center justify-center shadow-[0_0_20px_rgba(245,158,11,0.3)]">
                    <i class="fas fa-popcorn text-white text-2xl"></i>
                </div>
                <div>
                    <h2 class="text-3xl font-black text-white uppercase italic tracking-tight">Combo Bắp Nước</h2>
                    <p class="text-[10px] font-bold text-slate-500 uppercase tracking-[0.2em] mt-1">Bước 2 / 3 - Bổ sung năng lượng</p>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/booking/combo" method="post" id="comboForm">
                <input type="hidden" name="bookingId" value="${bookingId != null ? bookingId : param.bookingId}">

                <div class="space-y-4 mb-10">
                    <c:choose>
                        <c:when test="${empty comboList}">
                            <div class="py-20 text-center border border-dashed border-white/10 rounded-3xl">
                                <i class="fas fa-box-open text-4xl text-slate-600 mb-4"></i>
                                <p class="text-slate-500 font-bold">Hiện chưa có Combo nào khả dụng.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="c" items="${comboList}">
                                <div class="combo-item p-4 bg-white/5 rounded-3xl flex gap-6 border border-white/5 items-center">
                                    <div class="w-24 h-24 bg-slate-800 rounded-2xl overflow-hidden flex-shrink-0">
                                        <!-- Nếu ảnh combo bị lỗi hoặc null thì thay bằng placeholder -->
                                        <img src="${c.imageUrl != null && c.imageUrl != '' ? c.imageUrl : 'https://placehold.co/200x200/1e293b/a855f7?text=Combo'}" 
                                             alt="Combo" class="w-full h-full object-cover">
                                    </div>
                                    <div class="flex-1">
                                        <h4 class="text-white font-black text-lg">${c.name}</h4>
                                        <p class="text-[10px] text-slate-400 font-bold uppercase tracking-widest mt-1 mb-2">Thơm ngon khó cưỡng</p>
                                        <p class="text-indigo-400 font-black text-xl"><fmt:formatNumber value="${c.price}" type="currency" currencySymbol="" />đ</p>
                                    </div>
                                    <div class="flex items-center gap-3 bg-black/40 rounded-xl p-2 mr-2">
                                        <button type="button" class="minus-btn w-8 h-8 flex items-center justify-center bg-white/5 hover:bg-white/10 text-slate-400 rounded-lg transition-colors">
                                            <i class="fas fa-minus text-xs"></i>
                                        </button>
                                        <input type="number" name="quantity_${c.comboId}" value="0" min="0" readonly
                                               class="combo-qty w-8 text-center bg-transparent border-none text-white font-black text-lg focus:ring-0 p-0" 
                                               data-price="${c.price}">
                                        <button type="button" class="plus-btn w-8 h-8 flex items-center justify-center bg-indigo-500/20 hover:bg-indigo-500/40 text-indigo-400 rounded-lg transition-colors">
                                            <i class="fas fa-plus text-xs"></i>
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Sticky Bottom Bar cho phần Tổng tiền -->
                <div class="fixed bottom-0 left-0 right-0 bg-[#0f172a]/90 backdrop-blur-xl border-t border-white/10 p-6 z-50">
                    <div class="max-w-4xl mx-auto flex items-center justify-between">
                        <div>
                            <p class="text-[10px] font-black text-slate-500 uppercase tracking-[0.2em] mb-1">Tạm tính Combo</p>
                            <p id="totalComboPrice" class="text-3xl font-black text-white italic">0đ</p>
                        </div>
                        <div class="flex gap-4">
                            <!-- Nút quay lại chỉ đơn giản là back trình duyệt hoặc về trang đặt vé với movieId tương ứng (nếu cần thiết) -->
                            <button type="button" onclick="history.back()" class="px-6 py-4 bg-white/5 hover:bg-white/10 rounded-2xl font-black text-xs text-white uppercase tracking-widest transition-colors">
                                Quay lại
                            </button>
                            <button type="submit" class="px-8 py-4 bg-indigo-600 hover:bg-indigo-500 rounded-2xl font-black text-xs text-white uppercase tracking-widest transition-all shadow-[0_0_20px_rgba(79,70,229,0.3)] hover:shadow-[0_0_30px_rgba(79,70,229,0.6)] flex items-center gap-3">
                                THANH TOÁN NGAY <i class="fas fa-arrow-right"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </main>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const updateTotalPrice = () => {
                let total = 0;
                document.querySelectorAll('.combo-qty').forEach(input => {
                    const qty = parseInt(input.value) || 0;
                    const price = parseFloat(input.dataset.price) || 0;
                    total += qty * price;
                });
                document.getElementById('totalComboPrice').textContent = total.toLocaleString('vi-VN') + 'đ';
            };

            document.querySelectorAll('.plus-btn').forEach(btn => {
                btn.addEventListener('click', () => {
                    const input = btn.previousElementSibling;
                    input.value = parseInt(input.value) + 1;
                    updateTotalPrice();
                });
            });

            document.querySelectorAll('.minus-btn').forEach(btn => {
                btn.addEventListener('click', () => {
                    const input = btn.nextElementSibling;
                    if (parseInt(input.value) > 0) {
                        input.value = parseInt(input.value) - 1;
                        updateTotalPrice();
                    }
                });
            });
        });
    </script>
</body>
</html>