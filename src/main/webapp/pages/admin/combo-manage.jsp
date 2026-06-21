<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Combo | Admin Cinema</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-[#0f172a] text-slate-200">

<jsp:include page="/common/admin-sidebar.jsp">
    <jsp:param name="activeTab" value="combos" />
</jsp:include>

<div class="main-content min-h-screen">
    <!-- Header -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4 mb-10">
        <div>
            <h1 class="text-3xl font-black text-white tracking-tight">Thực đơn Bắp Nước</h1>
            <p class="text-slate-400 mt-1">Quản lý các gói combo và sản phẩm lẻ tại rạp.</p>
        </div>
        <button class="bg-indigo-600 hover:bg-indigo-500 text-white font-bold py-3.5 px-8 rounded-2xl flex items-center gap-2 transition-all shadow-xl shadow-indigo-600/20 group"
                data-bs-toggle="modal" data-bs-target="#comboModal" onclick="prepareAdd()">
            <i class="fas fa-plus group-hover:rotate-90 transition-transform"></i>
            <span>Thêm Combo Mới</span>
        </button>
    </div>

    <!-- Combo Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-8">
        <c:forEach var="c" items="${comboList}">
            <div class="glass-effect rounded-[2.5rem] p-8 relative group border border-slate-800 hover:border-indigo-500/50 transition-all duration-300">
                <div class="flex justify-between items-start mb-6">
                    <div class="w-16 h-16 bg-amber-500/10 rounded-2xl flex items-center justify-center text-amber-500 text-2xl">
                        <i class="fas fa-hamburger"></i>
                    </div>
                    <div class="flex gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                        <button onclick="prepareEdit('${c.comboId}', '${c.name}', '${c.description}', '${c.price}')"
                                class="w-10 h-10 rounded-xl bg-slate-800 text-slate-400 hover:bg-indigo-600 hover:text-white transition-all flex items-center justify-center">
                            <i class="fas fa-edit text-xs"></i>
                        </button>
                        <form action="${pageContext.request.contextPath}/admin/combos" method="POST" class="inline" onsubmit="return confirm('Xóa combo này?')">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="comboId" value="${c.comboId}">
                            <button class="w-10 h-10 rounded-xl bg-slate-800 text-slate-400 hover:bg-rose-600 hover:text-white transition-all flex items-center justify-center">
                                <i class="fas fa-trash text-xs"></i>
                            </button>
                        </form>
                    </div>
                </div>
                
                <h3 class="text-xl font-black text-white mb-2">${c.name}</h3>
                <p class="text-slate-500 text-sm leading-relaxed mb-6 h-10 line-clamp-2">${c.description}</p>
                
                <div class="flex items-center justify-between pt-6 border-t border-slate-800">
                    <span class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Giá bán niêm yết</span>
                    <span class="text-2xl font-black text-emerald-400 tracking-tight">
                        <fmt:formatNumber value="${c.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                    </span>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${empty comboList}">
            <div class="col-span-full py-20 text-center flex flex-col items-center glass-effect rounded-[3rem]">
                <div class="w-24 h-24 bg-slate-800/50 rounded-full flex items-center justify-center text-slate-600 text-4xl mb-6">
                    <i class="fas fa-utensils"></i>
                </div>
                <h4 class="text-xl font-bold text-slate-400">Chưa có combo nào</h4>
                <p class="text-slate-500 mt-2">Bắt đầu bằng cách thêm sản phẩm mới vào thực đơn của bạn.</p>
            </div>
        </c:if>
    </div>
</div>

<!-- Combo Modal -->
<div class="modal fade" id="comboModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <form action="${pageContext.request.contextPath}/admin/combos" method="POST" class="modal-content !bg-[#1e293b] !rounded-[2.5rem] border-none shadow-2xl overflow-hidden">
            <input type="hidden" name="action" id="modalAction" value="add">
            <input type="hidden" name="comboId" id="modalId">
            
            <div class="bg-amber-500 p-8 text-white">
                <h5 class="text-2xl font-black tracking-tight" id="modalTitle">Thiết lập Combo</h5>
                <p class="text-amber-100 mt-1 font-medium text-sm">Cập nhật tên, mô tả và giá bán sản phẩm</p>
            </div>

            <div class="modal-body p-8">
                <div class="space-y-6">
                    <div>
                        <label class="block text-[11px] font-black text-slate-500 uppercase tracking-widest mb-3">Tên gói Combo</label>
                        <input type="text" name="name" id="inputName" 
                               class="w-full bg-slate-900 border-2 border-slate-800 rounded-2xl px-5 py-4 text-white focus:border-amber-500 focus:outline-none transition-all placeholder:text-slate-700" 
                               placeholder="Ví dụ: Combo Movie 1" required>
                    </div>
                    <div>
                        <label class="block text-[11px] font-black text-slate-500 uppercase tracking-widest mb-3">Mô tả sản phẩm</label>
                        <textarea name="description" id="inputDescription" rows="3"
                               class="w-full bg-slate-900 border-2 border-slate-800 rounded-2xl px-5 py-4 text-white focus:border-amber-500 focus:outline-none transition-all placeholder:text-slate-700" 
                               placeholder="Chi tiết gồm những gì..."></textarea>
                    </div>
                    <div>
                        <label class="block text-[11px] font-black text-slate-500 uppercase tracking-widest mb-3">Giá bán lẻ (VNĐ)</label>
                        <div class="relative group">
                            <div class="absolute left-5 top-1/2 -translate-y-1/2 text-amber-500 font-bold group-focus-within:text-indigo-500">₫</div>
                            <input type="number" name="price" id="inputPrice" 
                                   class="w-full bg-slate-900 border-2 border-slate-800 rounded-2xl pl-10 pr-5 py-4 text-white focus:border-amber-500 focus:outline-none transition-all font-bold text-lg" 
                                   required>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-none p-8 pt-0 flex gap-4">
                <button type="button" class="flex-1 py-4 px-6 rounded-2xl text-slate-400 font-bold hover:bg-slate-700/50 transition-all uppercase tracking-widest text-[11px]" data-bs-dismiss="modal">Hủy bỏ</button>
                <button type="submit" class="flex-[2] py-4 px-6 rounded-2xl bg-amber-500 hover:bg-amber-400 text-white font-black transition-all shadow-2xl shadow-amber-500/30 uppercase tracking-widest text-[11px]">
                    Lưu thông tin Combo
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function prepareAdd() {
        document.getElementById('modalTitle').innerText = 'Thiết lập Combo';
        document.getElementById('modalAction').value = 'add';
        document.getElementById('modalId').value = '';
        document.getElementById('inputName').value = '';
        document.getElementById('inputDescription').value = '';
        document.getElementById('inputPrice').value = '';
    }

    function prepareEdit(id, name, desc, price) {
        document.getElementById('modalTitle').innerText = 'Chỉnh sửa Combo';
        document.getElementById('modalAction').value = 'update';
        document.getElementById('modalId').value = id;
        document.getElementById('inputName').value = name;
        document.getElementById('inputDescription').value = desc;
        document.getElementById('inputPrice').value = price;
        
        var myModal = new bootstrap.Modal(document.getElementById('comboModal'));
        myModal.show();
    }
</script>
</body>
</html>
