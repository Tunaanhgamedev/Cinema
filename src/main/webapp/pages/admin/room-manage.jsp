<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Phòng chiếu | Admin</title>
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
                <h1 class="text-4xl font-extrabold tracking-tight text-white mb-2">Hệ thống Phòng chiếu</h1>
                <p class="text-slate-400">Thiết lập và quản lý các phòng chiếu trong rạp của bạn.</p>
            </div>
            <button class="bg-indigo-600 hover:bg-indigo-500 text-white font-bold py-3 px-6 rounded-xl shadow-lg shadow-indigo-600/20 transition-all flex items-center gap-2" 
                    data-bs-toggle="modal" data-bs-target="#roomModal" onclick="prepareAdd()">
                <i class="fas fa-plus-circle"></i> Thêm phòng mới
            </button>
        </div>

        <c:if test="${not empty error}">
            <div class="bg-rose-500/10 border border-rose-500/20 text-rose-500 px-6 py-4 rounded-xl mb-8 flex items-center gap-3">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <c:forEach var="r" items="${roomList}">
                <div class="card-glass group hover:border-indigo-500/50 transition-all duration-500 p-8 relative overflow-hidden">
                    <div class="absolute -right-4 -top-4 w-24 h-24 bg-indigo-600/10 rounded-full blur-2xl group-hover:bg-indigo-600/20 transition-all"></div>
                    
                    <div class="flex items-start justify-between mb-6 relative z-10">
                        <div class="w-14 h-14 bg-white/5 rounded-2xl flex items-center justify-center border border-white/10 group-hover:scale-110 group-hover:rotate-6 transition-all duration-500">
                            <i class="fas fa-door-open text-2xl text-indigo-400"></i>
                        </div>
                        <div class="flex gap-2">
                            <button class="w-9 h-9 rounded-lg bg-white/5 text-slate-400 flex items-center justify-center hover:bg-emerald-500 hover:text-white transition-all" 
                                    title="Thiết lập ghế"
                                    onclick="openGenerateModal('${r.roomId}', '${r.roomName}')">
                                <i class="fas fa-th text-xs"></i>
                            </button>
                            <button class="w-9 h-9 rounded-lg bg-white/5 text-slate-400 flex items-center justify-center hover:bg-indigo-500 hover:text-white transition-all" 
                                    title="Sửa phòng"
                                    onclick="prepareEdit('${r.roomId}', '${r.roomName}', '${r.totalSeats}')">
                                <i class="fas fa-edit text-xs"></i>
                            </button>
                            <form action="${pageContext.request.contextPath}/admin/rooms" method="POST" class="inline" onsubmit="return confirm('Bạn có chắc muốn xóa phòng này?')">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="roomId" value="${r.roomId}">
                                <button class="w-9 h-9 rounded-lg bg-white/5 text-slate-400 flex items-center justify-center hover:bg-rose-500 hover:text-white transition-all">
                                    <i class="fas fa-trash-alt text-xs"></i>
                                </button>
                            </form>
                        </div>
                    </div>

                    <div class="relative z-10">
                        <h3 class="text-2xl font-black text-white mb-2">${r.roomName}</h3>
                        <div class="flex items-center gap-4">
                            <div class="flex items-center gap-2 px-3 py-1 bg-emerald-500/10 text-emerald-500 rounded-full text-[10px] font-black uppercase tracking-wider">
                                <i class="fas fa-chair"></i> ${r.totalSeats} ghế
                            </div>
                            <div class="flex items-center gap-2 px-3 py-1 bg-white/5 text-slate-400 rounded-full text-[10px] font-black uppercase tracking-wider">
                                <i class="fas fa-video"></i> Standard
                            </div>
                        </div>
                    </div>

                    <div class="mt-8 pt-6 border-t border-white/5 flex justify-between items-center relative z-10">
                        <span class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">ID: #${r.roomId}</span>
                        <div class="flex -space-x-2">
                            <div class="w-6 h-6 rounded-full bg-slate-700 border border-slate-800"></div>
                            <div class="w-6 h-6 rounded-full bg-slate-600 border border-slate-800"></div>
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
    .form-control, .form-select { background: rgba(15,23,42,0.5) !important; border: 1px solid rgba(255,255,255,0.1) !important; color: white !important; border-radius: 12px !important; padding: 12px 16px !important; }
    .form-label { color: #94a3b8; font-weight: 600; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 0.5rem; }
</style>

<div class="modal fade" id="roomModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <form action="${pageContext.request.contextPath}/admin/rooms" method="POST" class="modal-content">
            <input type="hidden" name="action" id="modalAction" value="add">
            <input type="hidden" name="roomId" id="modalRoomId">
            
            <div class="modal-header border-0 p-8">
                <h5 class="modal-title text-xl font-black text-white" id="modalTitle">Thêm phòng mới</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body p-8 pt-0">
                <div class="space-y-6">
                    <div>
                        <label class="form-label">Tên phòng chiếu</label>
                        <input type="text" name="roomName" id="inputRoomName" class="form-control" placeholder="Ví dụ: Phòng 01 - IMAX" required>
                    </div>
                    <div>
                        <label class="form-label">Tổng số ghế</label>
                        <input type="number" name="totalSeats" id="inputTotalSeats" class="form-control" placeholder="Nhập số ghế..." required>
                    </div>
                    <div>
                        <label class="form-label">Rạp (Mặc định)</label>
                        <select name="cinemaId" class="form-select">
                            <option value="1">BOBIXI Cinema Center</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 p-8 pt-0">
                <button type="button" class="text-slate-400 hover:text-white font-bold px-6 py-2 transition-colors" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" class="bg-indigo-600 hover:bg-indigo-500 text-white font-bold py-3 px-8 rounded-xl transition-all shadow-lg shadow-indigo-600/20">Lưu thông tin</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal Generate Seats -->
<div class="modal fade" id="generateSeatsModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <form action="${pageContext.request.contextPath}/admin/rooms" method="POST" class="modal-content">
            <input type="hidden" name="action" value="generateSeats">
            <input type="hidden" name="roomId" id="genRoomId">
            
            <div class="modal-header border-0 p-8">
                <h5 class="modal-title text-xl font-black text-white">Thiết lập sơ đồ ghế: <span id="genRoomName" class="text-indigo-400"></span></h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body p-8 pt-0">
                <div class="bg-indigo-500/10 border border-indigo-500/20 p-4 rounded-xl mb-6 flex items-start gap-3">
                    <i class="fas fa-info-circle text-indigo-400 mt-1"></i>
                    <p class="text-xs text-indigo-300 leading-relaxed">Hệ thống sẽ tự động tạo danh sách ghế dựa trên số hàng và số cột bạn nhập. Mọi ghế hiện có trong phòng này sẽ bị xóa trước khi tạo mới.</p>
                </div>
                <div class="row g-4">
                    <div class="col-6">
                        <label class="form-label">Số hàng (A, B, C...)</label>
                        <input type="number" name="rows" class="form-control" placeholder="VD: 10" required>
                    </div>
                    <div class="col-6">
                        <label class="form-label">Số ghế mỗi hàng</label>
                        <input type="number" name="seatsPerRow" class="form-control" placeholder="VD: 12" required>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 p-8 pt-0">
                <button type="button" class="text-slate-400 hover:text-white font-bold px-6 py-2 transition-colors" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" class="bg-emerald-600 hover:bg-emerald-500 text-white font-bold py-3 px-8 rounded-xl transition-all shadow-lg shadow-emerald-500/20">Bắt đầu tạo</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openGenerateModal(id, name) {
        document.getElementById('genRoomId').value = id;
        document.getElementById('genRoomName').innerText = name;
        var myModal = new bootstrap.Modal(document.getElementById('generateSeatsModal'));
        myModal.show();
    }

    function prepareAdd() {
        document.getElementById('modalTitle').innerText = 'Thêm phòng mới';
        document.getElementById('modalAction').value = 'add';
        document.getElementById('modalRoomId').value = '';
        document.getElementById('inputRoomName').value = '';
        document.getElementById('inputTotalSeats').value = '';
    }

    function prepareEdit(id, name, seats) {
        document.getElementById('modalTitle').innerText = 'Chỉnh sửa phòng';
        document.getElementById('modalAction').value = 'update';
        document.getElementById('modalRoomId').value = id;
        document.getElementById('inputRoomName').value = name;
        document.getElementById('inputTotalSeats').value = seats;
        
        var myModal = new bootstrap.Modal(document.getElementById('roomModal'));
        myModal.show();
    }
</script>
</body>
</html>
