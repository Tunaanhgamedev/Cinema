<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Suất chiếu | Admin</title>
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
                <h1 class="text-4xl font-extrabold tracking-tight text-white mb-2">Lịch chiếu phim</h1>
                <p class="text-slate-400">Quản lý thời gian chiếu và giá vé cho từng suất phim.</p>
            </div>
            <button class="bg-indigo-600 hover:bg-indigo-500 text-white font-bold py-3 px-6 rounded-xl shadow-lg shadow-indigo-600/20 transition-all flex items-center gap-2" 
                    data-bs-toggle="modal" data-bs-target="#showtimeModal" onclick="prepareAdd()">
                <i class="fas fa-calendar-plus"></i> Thêm suất chiếu mới
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
                            <th class="px-8 py-5">ID</th>
                            <th class="px-8 py-5">PHIM</th>
                            <th class="px-8 py-5">PHÒNG CHIẾU</th>
                            <th class="px-8 py-5">THỜI GIAN CHIẾU</th>
                            <th class="px-8 py-5">GIÁ VÉ</th>
                            <th class="px-8 py-5 text-right">HÀNH ĐỘNG</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-white/5">
                        <c:forEach var="s" items="${showtimeList}">
                            <tr class="hover:bg-white/5 transition-colors group">
                                <td class="px-8 py-5"><span class="text-slate-500 font-mono">#${s.showtimeId}</span></td>
                                <td class="px-8 py-5">
                                    <div class="font-bold text-white text-sm mb-1">${s.movieName}</div>
                                    <div class="text-slate-500 text-[10px] font-medium tracking-wider uppercase">MÃ PHIM: ${s.movieId}</div>
                                </td>
                                <td class="px-8 py-5">
                                    <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-indigo-500/10 text-indigo-400 border border-indigo-500/20 text-[10px] font-black uppercase tracking-wider">
                                        <i class="fas fa-door-open text-[8px]"></i> ${s.roomName}
                                    </span>
                                </td>
                                <td class="px-8 py-5">
                                    <div class="flex items-center gap-2 mb-1">
                                        <i class="far fa-calendar-alt text-indigo-400 text-xs"></i>
                                        <span class="font-bold text-white text-sm"><fmt:formatDate value="${s.startTime}" pattern="dd/MM/yyyy" /></span>
                                    </div>
                                    <div class="flex items-center gap-2">
                                        <i class="far fa-clock text-slate-500 text-xs"></i>
                                        <span class="text-slate-400 text-xs font-medium">
                                            <fmt:formatDate value="${s.startTime}" pattern="HH:mm" /> - <fmt:formatDate value="${s.endTime}" pattern="HH:mm" />
                                        </span>
                                    </div>
                                </td>
                                <td class="px-8 py-5">
                                    <span class="font-black text-emerald-400"><fmt:formatNumber value="${s.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></span>
                                </td>
                                <td class="px-8 py-5 text-right">
                                    <div class="flex justify-end gap-3">
                                        <button class="w-9 h-9 rounded-lg bg-indigo-500/10 text-indigo-400 flex items-center justify-center hover:bg-indigo-500 hover:text-white transition-all" 
                                                title="Chỉnh sửa" onclick="prepareEdit('${s.showtimeId}', '${s.movieId}', '${s.roomId}', '${s.startTime}', '${s.endTime}', '${s.price}')">
                                            <i class="fas fa-edit text-xs"></i>
                                        </button>
                                        <form action="${pageContext.request.contextPath}/admin/showtimes" method="POST" class="inline" onsubmit="return confirm('Xóa suất chiếu này?')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="showtimeId" value="${s.showtimeId}">
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

<style>
    .modal-content { background: #1e293b !important; border: 1px solid rgba(255,255,255,0.1) !important; border-radius: 24px !important; }
    .form-control { background: rgba(15,23,42,0.5) !important; border: 1px solid rgba(255,255,255,0.1) !important; color: white !important; border-radius: 12px !important; padding: 12px 16px !important; }
    .input-group-text { background: rgba(15,23,42,0.8) !important; border-color: rgba(255,255,255,0.1) !important; color: #94a3b8 !important; }
</style>

<!-- Showtime Modal -->
<div class="modal fade" id="showtimeModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <form action="${pageContext.request.contextPath}/admin/showtimes" method="POST" class="modal-content">
            <input type="hidden" name="action" id="modalAction" value="add">
            <input type="hidden" name="showtimeId" id="modalId">
            
            <div class="modal-header border-0 p-4">
                <h5 class="modal-title fw-bold" id="modalTitle">Thêm suất chiếu</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body p-4 pt-0">
                <div class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label small text-muted fw-bold">Mã phim (ID)</label>
                        <input type="number" name="movieId" id="inputMovieId" class="form-control" placeholder="Nhập ID phim" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small text-muted fw-bold">Mã phòng (ID)</label>
                        <input type="number" name="roomId" id="inputRoomId" class="form-control" placeholder="Nhập ID phòng" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label small text-muted fw-bold">Thời gian bắt đầu</label>
                        <input type="datetime-local" name="startTime" id="inputStartTime" class="form-control" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label small text-muted fw-bold">Thời gian kết thúc (Dự kiến)</label>
                        <input type="datetime-local" name="endTime" id="inputEndTime" class="form-control" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label small text-muted fw-bold">Giá vé niêm yết (VNĐ)</label>
                        <div class="input-group">
                            <span class="input-group-text bg-dark border-secondary text-muted">₫</span>
                            <input type="number" name="price" id="inputPrice" class="form-control" placeholder="75000" required>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 p-4 pt-0">
                <button type="button" class="btn btn-link text-white text-decoration-none" data-bs-dismiss="modal">Hủy bỏ</button>
                <button type="submit" class="btn btn-primary px-5">Lưu lịch chiếu</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function formatForInput(dateStr) {
        if(!dateStr) return "";
        const date = new Date(dateStr);
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        return `${year}-${month}-${day}T${hours}:${minutes}`;
    }

    function prepareAdd() {
        document.getElementById('modalTitle').innerText = 'Thêm suất chiếu';
        document.getElementById('modalAction').value = 'add';
        document.getElementById('modalId').value = '';
        document.getElementById('inputMovieId').value = '';
        document.getElementById('inputRoomId').value = '';
        document.getElementById('inputStartTime').value = '';
        document.getElementById('inputEndTime').value = '';
        document.getElementById('inputPrice').value = '';
    }

    function prepareEdit(id, movieId, roomId, start, end, price) {
        document.getElementById('modalTitle').innerText = 'Chỉnh sửa suất chiếu';
        document.getElementById('modalAction').value = 'update';
        document.getElementById('modalId').value = id;
        document.getElementById('inputMovieId').value = movieId;
        document.getElementById('inputRoomId').value = roomId;
        document.getElementById('inputStartTime').value = formatForInput(start);
        document.getElementById('inputEndTime').value = formatForInput(end);
        document.getElementById('inputPrice').value = price;
        
        var myModal = new bootstrap.Modal(document.getElementById('showtimeModal'));
        myModal.show();
    }
</script>
</body>
</html>
