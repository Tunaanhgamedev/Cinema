<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Phụ phí Ghế | Admin</title>
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
        <div class="flex justify-between items-center mb-12">
            <div>
                <h1 class="text-4xl font-extrabold tracking-tight text-white mb-2">Cấu hình Giá Phụ Thu</h1>
                <p class="text-slate-400">Điều chỉnh mức phụ thu (surcharge) cho các loại ghế đặc biệt (VIP, COUPLE).</p>
            </div>
        </div>

        <c:if test="${not empty error}">
            <div class="bg-rose-500/10 border border-rose-500/20 text-rose-500 px-6 py-4 rounded-xl mb-8 flex items-center gap-3">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="bg-emerald-500/10 border border-emerald-500/20 text-emerald-500 px-6 py-4 rounded-xl mb-8 flex items-center gap-3">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <c:forEach var="sp" items="${seatPrices}">
                <div class="card-glass group hover:border-indigo-500/50 transition-all duration-500 p-8 relative overflow-hidden">
                    <div class="absolute -right-4 -top-4 w-24 h-24 rounded-full blur-2xl transition-all" style="background-color: ${sp.colorHex}20;"></div>
                    
                    <div class="flex items-start justify-between mb-6 relative z-10">
                        <div class="w-14 h-14 bg-white/5 rounded-2xl flex items-center justify-center border border-white/10 group-hover:scale-110 group-hover:rotate-6 transition-all duration-500">
                            <i class="fas fa-couch text-2xl" style="color: ${sp.colorHex}"></i>
                        </div>
                        <button class="w-9 h-9 rounded-lg bg-white/5 text-slate-400 flex items-center justify-center hover:bg-indigo-500 hover:text-white transition-all" 
                                title="Sửa giá"
                                onclick="prepareEdit('${sp.seatType}', '${sp.surcharge}', '${sp.colorHex}')">
                            <i class="fas fa-edit text-xs"></i>
                        </button>
                    </div>

                    <div class="relative z-10">
                        <h3 class="text-2xl font-black text-white mb-2" style="color: ${sp.colorHex}">${sp.seatType}</h3>
                        <div class="flex items-center gap-4">
                            <div class="flex items-center gap-2 px-3 py-1 bg-white/5 text-slate-300 rounded-full text-lg font-black uppercase tracking-wider">
                                + <fmt:formatNumber value="${sp.surcharge}" type="number" maxFractionDigits="0"/> đ
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<!-- Modal Style -->
<style>
    .modal-content { background: #1e293b !important; border: 1px solid rgba(255,255,255,0.1) !important; border-radius: 24px !important; }
    .form-control { background: rgba(15,23,42,0.5) !important; border: 1px solid rgba(255,255,255,0.1) !important; color: white !important; border-radius: 12px !important; padding: 12px 16px !important; }
    .form-label { color: #94a3b8; font-weight: 600; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 0.5rem; }
</style>

<!-- Edit Modal -->
<div class="modal fade" id="priceModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <form action="${pageContext.request.contextPath}/admin/seat-prices" method="POST" class="modal-content">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="seatType" id="modalSeatType">
            
            <div class="modal-header border-0 p-8">
                <h5 class="modal-title text-xl font-black text-white">Cập nhật phụ thu: <span id="modalTitleType" class="text-indigo-400"></span></h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body p-8 pt-0">
                <div class="space-y-6">
                    <div>
                        <label class="form-label">Mức phụ thu (VNĐ)</label>
                        <input type="number" name="surcharge" id="inputSurcharge" class="form-control" placeholder="VD: 15000" required>
                    </div>
                    <div>
                        <label class="form-label">Mã màu đại diện (Hex)</label>
                        <input type="text" name="colorHex" id="inputColorHex" class="form-control" placeholder="VD: #f59e0b">
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 p-8 pt-0">
                <button type="button" class="text-slate-400 hover:text-white font-bold px-6 py-2 transition-colors" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" class="bg-indigo-600 hover:bg-indigo-500 text-white font-bold py-3 px-8 rounded-xl transition-all shadow-lg shadow-indigo-600/20">Lưu thay đổi</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function prepareEdit(type, surcharge, color) {
        document.getElementById('modalTitleType').innerText = type;
        document.getElementById('modalSeatType').value = type;
        document.getElementById('inputSurcharge').value = surcharge;
        document.getElementById('inputColorHex').value = color;
        
        var myModal = new bootstrap.Modal(document.getElementById('priceModal'));
        myModal.show();
    }
</script>
</body>
</html>
