<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Voucher | Admin</title>
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
                <h1 class="text-4xl font-extrabold tracking-tight text-white mb-2">Quản lý Voucher</h1>
                <p class="text-slate-400">Tạo mã giảm giá để thúc đẩy doanh thu rạp phim.</p>
            </div>
            <button class="bg-indigo-600 hover:bg-indigo-500 text-white font-bold py-3 px-6 rounded-xl shadow-lg shadow-indigo-600/20 transition-all flex items-center gap-2" 
                    data-bs-toggle="modal" data-bs-target="#voucherModal" onclick="prepareAdd()">
                <i class="fas fa-plus-circle"></i> Tạo mã mới
            </button>
        </div>

        <c:if test="${param.success == '1'}">
            <div class="bg-emerald-500/10 border border-emerald-500/20 text-emerald-500 px-6 py-4 rounded-xl mb-8 flex items-center gap-3">
                <i class="fas fa-check-circle"></i> Đã lưu Voucher thành công!
            </div>
        </c:if>
        <c:if test="${param.deleted == '1'}">
            <div class="bg-amber-500/10 border border-amber-500/20 text-amber-500 px-6 py-4 rounded-xl mb-8 flex items-center gap-3">
                <i class="fas fa-info-circle"></i> Đã xóa Voucher thành công!
            </div>
        </c:if>

        <div class="card-glass overflow-hidden">
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="text-slate-500 text-[10px] font-black uppercase tracking-[2px] border-b border-white/5 bg-white/5">
                            <th class="px-8 py-5">MÃ VOUCHER</th>
                            <th class="px-8 py-5">GIẢM GIÁ</th>
                            <th class="px-8 py-5">ĐƠN TỐI THIỂU</th>
                            <th class="px-8 py-5">THỜI HẠN</th>
                            <th class="px-8 py-5">TRẠNG THÁI</th>
                            <th class="px-8 py-5 text-right">HÀNH ĐỘNG</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-white/5">
                        <c:forEach var="v" items="${vouchers}">
                            <tr class="hover:bg-white/5 transition-colors group">
                                <td class="px-8 py-5">
                                    <div class="flex items-center gap-3">
                                        <div class="w-10 h-10 rounded-lg bg-indigo-500/10 flex items-center justify-center text-indigo-400 border border-indigo-500/20">
                                            <i class="fas fa-tag"></i>
                                        </div>
                                        <div>
                                            <div class="font-bold text-white text-base tracking-widest">${v.code}</div>
                                            <div class="text-slate-500 text-[10px]">ID: #${v.voucherId}</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-8 py-5">
                                    <div class="text-white font-bold">
                                        <c:choose>
                                            <c:when test="${v.discountType == 'PERCENT'}">
                                                ${v.discountValue}%
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatNumber value="${v.discountValue}" pattern="#,###"/>đ
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="text-slate-500 text-[10px] uppercase tracking-tighter">
                                        ${v.discountType == 'PERCENT' ? 'Giảm theo %' : 'Giảm số tiền'}
                                    </div>
                                </td>
                                <td class="px-8 py-5">
                                    <div class="text-slate-300 font-medium"><fmt:formatNumber value="${v.minOrderValue}" pattern="#,###"/>đ</div>
                                </td>
                                <td class="px-8 py-5">
                                    <div class="text-[11px] text-slate-400">
                                        <span class="block text-slate-500">TỪ: <fmt:formatDate value="${v.validFrom}" pattern="dd/MM/yyyy HH:mm"/></span>
                                        <span class="block text-rose-400">ĐẾN: <fmt:formatDate value="${v.validTo}" pattern="dd/MM/yyyy HH:mm"/></span>
                                    </div>
                                </td>
                                <td class="px-8 py-5">
                                    <c:choose>
                                        <c:when test="${v.active}">
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-emerald-500/10 text-emerald-500 border border-emerald-500/20 text-[10px] font-black uppercase tracking-wider">
                                                Đang hoạt động
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-rose-500/10 text-rose-500 border border-rose-500/20 text-[10px] font-black uppercase tracking-wider">
                                                Tạm khóa
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-8 py-5 text-right">
                                    <div class="flex justify-end gap-3">
                                        <button class="w-9 h-9 rounded-lg bg-indigo-500/10 text-indigo-400 flex items-center justify-center hover:bg-indigo-500 hover:text-white transition-all" 
                                                title="Chỉnh sửa" 
                                                onclick="prepareEdit('${v.voucherId}', '${v.code}', '${v.discountValue}', '${v.discountType}', '${v.minOrderValue}', '<fmt:formatDate value="${v.validFrom}" pattern="yyyy-MM-dd'T'HH:mm" />', '<fmt:formatDate value="${v.validTo}" pattern="yyyy-MM-dd'T'HH:mm" />', ${v.active})">
                                            <i class="fas fa-edit text-xs"></i>
                                        </button>
                                        <a href="${pageContext.request.contextPath}/admin/vouchers/delete?id=${v.voucherId}" 
                                           class="w-9 h-9 rounded-lg bg-rose-500/10 text-rose-500 flex items-center justify-center hover:bg-rose-500 hover:text-white transition-all" 
                                           title="Xóa" onclick="return confirm('Bạn có chắc muốn xóa Voucher này?')">
                                            <i class="fas fa-trash-alt text-xs"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Modal UI Enhancement -->
<style>
    .modal-content { background: #1e293b !important; border: 1px solid rgba(255,255,255,0.1) !important; border-radius: 24px !important; }
    .form-control, .form-select { background: rgba(15,23,42,0.5) !important; border: 1px solid rgba(255,255,255,0.1) !important; color: white !important; border-radius: 12px !important; padding: 10px 16px !important; }
    .form-control:focus, .form-select:focus { border-color: #6366f1 !important; box-shadow: 0 0 0 4px rgba(99,102,241,0.1) !important; }
    .form-label { margin-bottom: 0.5rem; color: #94a3b8; font-weight: 600; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.05em; }
</style>

<div class="modal fade" id="voucherModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <form action="${pageContext.request.contextPath}/admin/vouchers/save" method="POST" class="modal-content">
            <input type="hidden" name="id" id="modalId">
            
            <div class="modal-header border-0 p-6">
                <h5 class="modal-title text-xl font-black text-white" id="modalTitle">Tạo mã Voucher mới</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body p-6 pt-0">
                <div class="row g-4">
                    <div class="col-12">
                        <label class="form-label">Mã Code (In hoa)</label>
                        <input type="text" name="code" id="inputCode" class="form-control" placeholder="Ví dụ: GIAM50K" required style="text-transform: uppercase;">
                    </div>
                    <div class="col-6">
                        <label class="form-label">Loại giảm giá</label>
                        <select name="discountType" id="inputDiscountType" class="form-select">
                            <option value="PERCENT">Phần trăm (%)</option>
                            <option value="FIXED_AMOUNT">Số tiền cố định (đ)</option>
                        </select>
                    </div>
                    <div class="col-6">
                        <label class="form-label">Giá trị giảm</label>
                        <input type="number" name="discountValue" id="inputDiscountValue" class="form-control" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Đơn hàng tối thiểu (đ)</label>
                        <input type="number" name="minOrderValue" id="inputMinOrderValue" class="form-control" required value="0">
                    </div>
                    <div class="col-6">
                        <label class="form-label">Ngày bắt đầu</label>
                        <input type="datetime-local" name="validFrom" id="inputValidFrom" class="form-control" required>
                    </div>
                    <div class="col-6">
                        <label class="form-label">Ngày kết thúc</label>
                        <input type="datetime-local" name="validTo" id="inputValidTo" class="form-control" required>
                    </div>
                    <div class="col-12">
                        <div class="flex items-center gap-3 bg-white/5 p-4 rounded-xl border border-white/10">
                            <input type="checkbox" name="isActive" id="inputIsActive" class="w-5 h-5 rounded border-white/10 bg-slate-900 accent-indigo-600" checked>
                            <label for="inputIsActive" class="text-sm font-bold text-slate-300">Cho phép sử dụng ngay</label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 p-6 pt-0">
                <button type="button" class="text-slate-400 hover:text-white font-bold px-4 py-2 transition-colors" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" class="bg-indigo-600 hover:bg-indigo-500 text-white font-bold py-2.5 px-8 rounded-xl transition-all">Lưu Voucher</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function prepareAdd() {
        document.getElementById('modalTitle').innerText = 'Tạo mã Voucher mới';
        document.getElementById('modalId').value = '';
        document.getElementById('inputCode').value = '';
        document.getElementById('inputDiscountValue').value = '';
        document.getElementById('inputDiscountType').value = 'PERCENT';
        document.getElementById('inputMinOrderValue').value = '0';
        document.getElementById('inputValidFrom').value = '';
        document.getElementById('inputValidTo').value = '';
        document.getElementById('inputIsActive').checked = true;
    }

    function prepareEdit(id, code, val, type, min, from, to, active) {
        document.getElementById('modalTitle').innerText = 'Chỉnh sửa Voucher';
        document.getElementById('modalId').value = id;
        document.getElementById('inputCode').value = code;
        document.getElementById('inputDiscountValue').value = val;
        document.getElementById('inputDiscountType').value = type;
        document.getElementById('inputMinOrderValue').value = min;
        document.getElementById('inputValidFrom').value = from;
        document.getElementById('inputValidTo').value = to;
        document.getElementById('inputIsActive').checked = active;
        
        var myModal = new bootstrap.Modal(document.getElementById('voucherModal'));
        myModal.show();
    }
</script>
</body>
</html>
