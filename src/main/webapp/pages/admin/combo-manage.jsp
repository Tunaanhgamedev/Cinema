<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Combo | Admin</title>
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
    <jsp:include page="/common/admin/sidebar.jsp">
        <jsp:param name="activeTab" value="combos" />
    </jsp:include>

    <div class="main-content">
        <div class="flex justify-between items-center mb-12">
            <div>
                <h1 class="text-4xl font-extrabold tracking-tight text-white mb-2">Quản lý Combo</h1>
                <p class="text-slate-400">Quản lý danh sách các gói bắp và nước uống đang phục vụ.</p>
            </div>
            <button class="bg-indigo-600 hover:bg-indigo-500 text-white font-bold py-3 px-6 rounded-xl shadow-lg shadow-indigo-600/20 transition-all flex items-center gap-2" 
                    data-bs-toggle="modal" data-bs-target="#comboModal" onclick="prepareAdd()">
                <i class="fas fa-plus-circle"></i> Thêm combo mới
            </button>
        </div>

        <c:if test="${not empty error}">
            <div class="bg-rose-500/10 border border-rose-500/20 text-rose-500 px-6 py-4 rounded-xl mb-8 flex items-center gap-3">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <div class="card-glass overflow-hidden">
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="text-slate-500 text-[10px] font-black uppercase tracking-[2px] border-b border-white/5 bg-white/5">
                            <th class="px-8 py-5">HÌNH ẢNH</th>
                            <th class="px-8 py-5">TÊN COMBO</th>
                            <th class="px-8 py-5">CHI TIẾT MÔ TẢ</th>
                            <th class="px-8 py-5 text-right">GIÁ BÁN</th>
                            <th class="px-8 py-5 text-right">HÀNH ĐỘNG</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-white/5">
                        <c:forEach var="c" items="${comboList}">
                            <tr class="hover:bg-white/5 transition-colors group">
                                <td class="px-8 py-5">
                                    <div class="w-14 h-14 bg-white/5 rounded-xl flex items-center justify-center p-2 shadow-inner border border-white/5 overflow-hidden">
                                        <img src="${c.imageUrl}" class="w-full h-full object-contain group-hover:scale-110 transition-transform">
                                    </div>
                                </td>
                                <td class="px-8 py-5">
                                    <div class="font-bold text-white text-base">${c.name}</div>
                                    <div class="text-slate-500 text-[10px] font-black uppercase tracking-widest mt-1">ID: #${c.comboId}</div>
                                </td>
                                <td class="px-8 py-5 max-w-xs">
                                    <p class="text-slate-400 text-xs leading-relaxed line-clamp-2">${c.description}</p>
                                </td>
                                <td class="px-8 py-5 text-right">
                                    <span class="font-black text-emerald-400"><fmt:formatNumber value="${c.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></span>
                                </td>
                                <td class="px-8 py-5 text-right">
                                    <div class="flex justify-end gap-3">
                                        <button class="w-9 h-9 rounded-lg bg-indigo-500/10 text-indigo-400 flex items-center justify-center hover:bg-indigo-500 hover:text-white transition-all" 
                                                title="Chỉnh sửa" onclick="prepareEdit('${c.comboId}', '${c.name}', '${c.description}', '${c.price}', '${c.imageUrl}')">
                                             <i class="fas fa-edit text-xs"></i>
                                         </button>
                                         <form action="${pageContext.request.contextPath}/admin/combos" method="POST" class="inline" onsubmit="return confirm('Xóa combo này?')">
                                             <input type="hidden" name="action" value="delete">
                                             <input type="hidden" name="comboId" value="${c.comboId}">
                                             <button class="w-9 h-9 rounded-lg bg-rose-500/10 text-rose-500 flex items-center justify-center hover:bg-rose-500 hover:text-white transition-all" 
                                                     title="Xóa">
                                                 <i class="fas fa-trash-alt text-xs"></i>
                                             </button>
                                         </form>
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

<!-- Modal Restyling -->
<style>
    .modal-content { background: #1e293b !important; border: 1px solid rgba(255,255,255,0.1) !important; border-radius: 24px !important; }
    .form-control { background: rgba(15,23,42,0.5) !important; border: 1px solid rgba(255,255,255,0.1) !important; color: white !important; border-radius: 12px !important; padding: 12px 16px !important; }
    .form-control:focus { border-color: #6366f1 !important; box-shadow: 0 0 0 4px rgba(99,102,241,0.1) !important; }
</style>

<!-- Combo Modal -->
<div class="modal fade" id="comboModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <form action="${pageContext.request.contextPath}/admin/combos" method="POST" class="modal-content">
            <input type="hidden" name="action" id="modalAction" value="add">
            <input type="hidden" name="comboId" id="modalId">
            
            <div class="modal-header border-0 p-8">
                <h5 class="text-2xl font-black text-white" id="modalTitle">Thiết lập Combo</h5>
                <button type="button" class="text-slate-400 hover:text-white" data-bs-dismiss="modal"><i class="fas fa-times text-xl"></i></button>
            </div>
            <div class="modal-body p-8 pt-0 space-y-6">
                <div>
                    <label class="block text-slate-500 text-[10px] font-black uppercase tracking-widest mb-2">Tên Combo</label>
                    <input type="text" name="name" id="inputName" class="form-control w-full" placeholder="Ví dụ: Combo 2 bắp 2 nước" required>
                </div>
                <div>
                    <label class="block text-slate-500 text-[10px] font-black uppercase tracking-widest mb-2">Mô tả thành phần</label>
                    <textarea name="description" id="inputDescription" class="form-control w-full" rows="3" placeholder="Chi tiết gồm những gì..."></textarea>
                </div>
                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <label class="block text-slate-500 text-[10px] font-black uppercase tracking-widest mb-2">Giá bán (VNĐ)</label>
                        <input type="number" name="price" id="inputPrice" class="form-control w-full" placeholder="99000" required>
                    </div>
                    <div>
                        <label class="block text-slate-500 text-[10px] font-black uppercase tracking-widest mb-2">Link hình ảnh</label>
                        <input type="text" name="imageUrl" id="inputImageUrl" class="form-control w-full" placeholder="URL hình ảnh...">
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 p-8 pt-0 flex gap-4">
                <button type="button" class="flex-1 py-4 text-slate-400 font-bold hover:text-white transition-colors" data-bs-dismiss="modal">Hủy bỏ</button>
                <button type="submit" class="flex-[2] py-4 bg-indigo-600 hover:bg-indigo-500 text-white font-black rounded-xl shadow-lg shadow-indigo-600/20 transition-all">Lưu Combo</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function prepareAdd() {
        document.getElementById('modalTitle').innerText = 'Thêm Combo mới';
        document.getElementById('modalAction').value = 'add';
        document.getElementById('modalId').value = '';
        document.getElementById('inputName').value = '';
        document.getElementById('inputDescription').value = '';
        document.getElementById('inputPrice').value = '';
        document.getElementById('inputImageUrl').value = '';
    }

    function prepareEdit(id, name, desc, price, img) {
        document.getElementById('modalTitle').innerText = 'Chỉnh sửa Combo';
        document.getElementById('modalAction').value = 'update';
        document.getElementById('modalId').value = id;
        document.getElementById('inputName').value = name;
        document.getElementById('inputDescription').value = desc;
        document.getElementById('inputPrice').value = price;
        document.getElementById('inputImageUrl').value = img;
        
        var myModal = new bootstrap.Modal(document.getElementById('comboModal'));
        myModal.show();
    }
</script>
</body>
</html>
