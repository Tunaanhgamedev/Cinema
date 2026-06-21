<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch chiếu phim | Admin</title>
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
        <jsp:param name="activeTab" value="showtimes" />
    </jsp:include>

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
                                    <div class="flex flex-col gap-1">
                                        <div class="flex items-center gap-2">
                                            <span class="px-2 py-0.5 rounded bg-indigo-500/20 text-indigo-300 text-[10px] font-black uppercase">
                                                <i class="far fa-calendar-check mr-1"></i>
                                                <fmt:formatDate value="${s.startTime}" pattern="dd/MM/yyyy" />
                                            </span>
                                        </div>
                                        <div class="flex items-center gap-2">
                                            <span class="text-white font-bold text-sm">
                                                <fmt:formatDate value="${s.startTime}" pattern="HH:mm" />
                                            </span>
                                            <span class="text-slate-600 text-xs">→</span>
                                            <span class="text-slate-400 text-xs font-medium">
                                                <fmt:formatDate value="${s.endTime}" pattern="HH:mm" />
                                            </span>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-8 py-5">
                                    <span class="font-black text-emerald-400"><fmt:formatNumber value="${s.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></span>
                                </td>
                                <td class="px-8 py-5 text-right">
                                    <div class="flex justify-end gap-3">
                                        <button class="w-9 h-9 rounded-lg bg-indigo-500/10 text-indigo-400 flex items-center justify-center hover:bg-indigo-500 hover:text-white transition-all" 
                                                title="Chỉnh sửa" onclick="prepareEdit('${s.showtimeId}', '${s.movieId}', '${s.roomId}', '<fmt:formatDate value="${s.startTime}" pattern="yyyy-MM-dd HH:mm" />', '<fmt:formatDate value="${s.endTime}" pattern="yyyy-MM-dd HH:mm" />', '${s.price}')">
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
    .form-control, .form-select { background: rgba(15,23,42,0.5) !important; border: 1px solid rgba(255,255,255,0.1) !important; color: white !important; border-radius: 12px !important; padding: 12px 16px !important; }
    .input-group-text { background: rgba(15,23,42,0.8) !important; border-color: rgba(255,255,255,0.1) !important; color: #94a3b8 !important; }
    .form-label { color: #94a3b8; font-weight: 600; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 0.5rem; }
    option { background-color: #1e293b; color: white; }
</style>

<!-- Showtime Modal -->
<div class="modal fade" id="showtimeModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <form action="${pageContext.request.contextPath}/admin/showtimes" method="POST" class="modal-content !bg-[#1e293b] !rounded-[2.5rem] border-none shadow-2xl overflow-hidden">
            <input type="hidden" name="action" id="modalAction" value="add">
            <input type="hidden" name="showtimeId" id="modalId">
            
            <div class="modal-header border-0 p-6">
                <h5 class="modal-title text-xl font-black text-white" id="modalTitle">Thêm suất chiếu</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body p-6 pt-0">
                <div class="row g-4">
                    <div class="col-12">
                        <label class="form-label">Chọn phim</label>
                        <select name="movieId" id="inputMovieId" class="form-select" required>
                            <option value="">-- Chọn phim --</option>
                            <c:forEach var="m" items="${movieList}">
                                <option value="${m.movieId}" data-duration="${m.duration}">${m.title} (${m.duration} phút)</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Chọn phòng chiếu</label>
                        <select name="roomId" id="inputRoomId" class="form-select" required>
                            <option value="">-- Chọn phòng --</option>
                            <c:forEach var="r" items="${roomList}">
                                <option value="${r.roomId}">${r.roomName} (ID: ${r.roomId})</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Thời gian bắt đầu</label>
                        <input type="datetime-local" name="startTime" id="inputStartTime" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Thời gian kết thúc</label>
                        <input type="datetime-local" name="endTime" id="inputEndTime" class="form-control" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Giá vé niêm yết</label>
                        <div class="input-group">
                            <span class="input-group-text">₫</span>
                            <input type="number" name="price" id="inputPrice" class="form-control" placeholder="75000" required>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 p-6 pt-0">
                <button type="button" class="text-slate-400 hover:text-white font-bold px-4 py-2 transition-colors" data-bs-dismiss="modal">Hủy bỏ</button>
                <button type="submit" class="bg-indigo-600 hover:bg-indigo-500 text-white font-bold py-2.5 px-8 rounded-xl transition-all">Lưu lịch chiếu</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function formatForInput(dateStr) {
        if(!dateStr) return "";
        // dateStr is in yyyy-MM-dd HH:mm format from fmt:formatDate
        const parts = dateStr.split(' ');
        if(parts.length < 2) return "";
        return parts[0] + 'T' + parts[1];
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
        document.getElementById('inputPrice').value = Math.round(price);
        
        var myModal = new bootstrap.Modal(document.getElementById('showtimeModal'));
        myModal.show();
    }

    // Tự động tính thời gian kết thúc
    const inputMovie = document.getElementById('inputMovieId');
    const inputStart = document.getElementById('inputStartTime');
    const inputEnd = document.getElementById('inputEndTime');

    function calculateEndTime() {
        const selectedOption = inputMovie.options[inputMovie.selectedIndex];
        if (!selectedOption) return;
        const duration = parseInt(selectedOption.getAttribute('data-duration'));
        const startTimeStr = inputStart.value;

        if (startTimeStr && !isNaN(duration)) {
            const startDate = new Date(startTimeStr);
            // Cộng thời lượng phim + 15 phút dọn phòng (buffer)
            const endDate = new Date(startDate.getTime() + (duration + 15) * 60000);
            
            // Format sang định dạng yyyy-MM-ddTHH:mm cho datetime-local
            const year = endDate.getFullYear();
            const month = String(endDate.getMonth() + 1).padStart(2, '0');
            const day = String(endDate.getDate()).padStart(2, '0');
            const hours = String(endDate.getHours()).padStart(2, '0');
            const minutes = String(endDate.getMinutes()).padStart(2, '0');
            
            inputEnd.value = `${year}-${month}-${day}T${hours}:${minutes}`;
        }
    }

    inputMovie.addEventListener('change', calculateEndTime);
    inputStart.addEventListener('change', calculateEndTime);
</script>
</body>
</html>
