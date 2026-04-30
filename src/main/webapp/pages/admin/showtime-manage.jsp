<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Lịch chiếu | Admin Cinema</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-[#0f172a] text-slate-200">

<jsp:include page="/common/admin-sidebar.jsp">
    <jsp:param name="activeTab" value="showtimes" />
</jsp:include>

<div class="main-content min-h-screen">
    <!-- Header -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4 mb-10">
        <div>
            <h1 class="text-3xl font-black text-white tracking-tight">Điều phối Lịch chiếu</h1>
            <p class="text-slate-400 mt-1">Sắp xếp suất chiếu, quản lý phòng và giá vé cơ bản.</p>
        </div>
        <button class="bg-indigo-600 hover:bg-indigo-500 text-white font-bold py-3.5 px-8 rounded-2xl flex items-center gap-2 transition-all shadow-xl shadow-indigo-600/20 group"
                data-bs-toggle="modal" data-bs-target="#showtimeModal" onclick="prepareAdd()">
            <i class="fas fa-calendar-plus group-hover:scale-110 transition-transform"></i>
            <span>Tạo Suất Chiếu Mới</span>
        </button>
    </div>

    <!-- Data Table Card -->
    <div class="glass-effect rounded-[2.5rem] overflow-hidden border border-slate-800 shadow-2xl">
        <div class="p-8 border-b border-slate-800 flex items-center justify-between bg-slate-800/20">
            <h3 class="font-bold text-white flex items-center gap-2">
                <i class="fas fa-list-ul text-indigo-500"></i>
                Danh sách suất chiếu hệ thống
            </h3>
        </div>
        
        <div class="overflow-x-auto">
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr class="bg-slate-900/50">
                        <th class="p-6 text-[11px] font-black text-slate-500 uppercase tracking-widest">Phim & Thời gian</th>
                        <th class="p-6 text-[11px] font-black text-slate-500 uppercase tracking-widest text-center">Phòng</th>
                        <th class="p-6 text-[11px] font-black text-slate-500 uppercase tracking-widest text-center">Giá vé gốc</th>
                        <th class="p-6 text-[11px] font-black text-slate-500 uppercase tracking-widest text-center">Trạng thái</th>
                        <th class="p-6 text-[11px] font-black text-slate-500 uppercase tracking-widest text-right">Thao tác</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-800/50">
                    <c:forEach var="s" items="${showtimeList}">
                        <tr class="hover:bg-slate-800/30 transition-all group">
                            <td class="p-6">
                                <div class="flex items-center gap-5">
                                    <div class="w-12 h-12 rounded-2xl bg-indigo-500/10 flex flex-col items-center justify-center text-indigo-400 border border-indigo-500/20">
                                        <span class="text-[10px] font-black leading-none uppercase"><fmt:formatDate value="${s.startTime}" pattern="MMM" /></span>
                                        <span class="text-lg font-black leading-none mt-1"><fmt:formatDate value="${s.startTime}" pattern="dd" /></span>
                                    </div>
                                    <div>
                                        <h4 class="text-white font-bold text-base group-hover:text-indigo-400 transition-colors">${s.movieTitle}</h4>
                                        <p class="text-slate-500 text-xs mt-1 font-medium">
                                            <i class="far fa-clock mr-1 text-indigo-500/50"></i>
                                            <fmt:formatDate value="${s.startTime}" pattern="HH:mm" /> - <fmt:formatDate value="${s.endTime}" pattern="HH:mm" />
                                        </p>
                                    </div>
                                </div>
                            </td>
                            <td class="p-6 text-center">
                                <span class="bg-slate-800 text-slate-300 text-[11px] font-black px-4 py-2 rounded-xl border border-slate-700">
                                    ${s.roomName}
                                </span>
                            </td>
                            <td class="p-6 text-center">
                                <span class="text-emerald-400 font-black text-sm tracking-tight">
                                    <fmt:formatNumber value="${s.basePrice}" type="currency" currencySymbol="₫" />
                                </span>
                            </td>
                            <td class="p-6 text-center">
                                <span class="bg-indigo-500/10 text-indigo-400 text-[10px] font-black uppercase px-3 py-1.5 rounded-full border border-indigo-500/20">
                                    Công chiếu
                                </span>
                            </td>
                            <td class="p-6">
                                <div class="flex justify-end gap-2 opacity-0 group-hover:opacity-100 transition-all transform translate-x-2 group-hover:translate-x-0">
                                    <div class="hidden" id="data-${s.showtimeId}">
                                        <span class="d-movie">${s.movieId}</span>
                                        <span class="d-room">${s.roomId}</span>
                                        <span class="d-start"><fmt:formatDate value="${s.startTime}" pattern="yyyy-MM-dd'T'HH:mm" /></span>
                                        <span class="d-end"><fmt:formatDate value="${s.endTime}" pattern="yyyy-MM-dd'T'HH:mm" /></span>
                                        <span class="d-price">${s.basePrice}</span>
                                    </div>
                                    <button class="w-10 h-10 rounded-xl bg-indigo-500/10 text-indigo-400 hover:bg-indigo-500 hover:text-white transition-all flex items-center justify-center border border-indigo-500/20"
                                            onclick="prepareEdit('${s.showtimeId}')">
                                        <i class="fas fa-edit text-xs"></i>
                                    </button>
                                    <form action="${pageContext.request.contextPath}/admin/showtimes" method="POST" class="inline" onsubmit="return confirm('Xóa suất chiếu này?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${s.showtimeId}">
                                        <button class="w-10 h-10 rounded-xl bg-rose-500/10 text-rose-400 hover:bg-rose-500 hover:text-white transition-all flex items-center justify-center border border-rose-500/20">
                                            <i class="fas fa-trash text-xs"></i>
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

<!-- Showtime Modal -->
<div class="modal fade" id="showtimeModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <form action="${pageContext.request.contextPath}/admin/showtimes" method="POST" class="modal-content !bg-[#1e293b] !rounded-[2.5rem] border-none shadow-2xl overflow-hidden">
            <input type="hidden" name="action" id="modalAction" value="add">
            <input type="hidden" name="showtimeId" id="modalShowtimeId">
            
            <div class="bg-indigo-600 p-10 text-white relative">
                <div class="absolute top-8 right-8">
                    <button type="button" class="w-10 h-10 rounded-full bg-black/20 hover:bg-black/40 flex items-center justify-center text-white transition-colors" data-bs-dismiss="modal">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <h5 class="text-3xl font-black tracking-tight" id="modalTitle">Thiết lập Suất chiếu</h5>
                <p class="text-indigo-200 mt-2 font-medium opacity-80">Cấu hình thời gian và giá vé cho phim</p>
            </div>

            <div class="modal-body p-10">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                    <div>
                        <label class="block text-[11px] font-black text-slate-500 uppercase tracking-widest mb-3">Chọn phim công chiếu</label>
                        <select name="movieId" id="inputMovie" class="w-full bg-slate-900 border-2 border-slate-800 rounded-2xl px-5 py-4 text-white focus:border-indigo-600 focus:outline-none transition-all appearance-none cursor-pointer" required>
                            <option value="">-- Chọn phim --</option>
                            <c:forEach var="m" items="${movieList}">
                                <option value="${m.movieId}">${m.title}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <label class="block text-[11px] font-black text-slate-500 uppercase tracking-widest mb-3">Phòng chiếu</label>
                        <select name="roomId" id="inputRoom" class="w-full bg-slate-900 border-2 border-slate-800 rounded-2xl px-5 py-4 text-white focus:border-indigo-600 focus:outline-none transition-all appearance-none cursor-pointer" required>
                            <option value="">-- Chọn phòng --</option>
                            <c:forEach var="r" items="${roomList}">
                                <option value="${r.roomId}">${r.roomName} (${r.seatCount} ghế)</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <label class="block text-[11px] font-black text-slate-500 uppercase tracking-widest mb-3">Thời gian bắt đầu</label>
                        <input type="datetime-local" name="startTime" id="inputStart" 
                               class="w-full bg-slate-900 border-2 border-slate-800 rounded-2xl px-5 py-4 text-white focus:border-indigo-600 focus:outline-none transition-all" required>
                    </div>
                    <div>
                        <label class="block text-[11px] font-black text-slate-500 uppercase tracking-widest mb-3">Thời gian kết thúc (Dự kiến)</label>
                        <input type="datetime-local" name="endTime" id="inputEnd" 
                               class="w-full bg-slate-900 border-2 border-slate-800 rounded-2xl px-5 py-4 text-white focus:border-indigo-600 focus:outline-none transition-all" required>
                    </div>
                    <div class="md:col-span-2">
                        <label class="block text-[11px] font-black text-slate-500 uppercase tracking-widest mb-3">Giá vé cơ bản (VNĐ)</label>
                        <div class="relative group">
                            <div class="absolute left-5 top-1/2 -translate-y-1/2 text-emerald-500 font-bold group-focus-within:text-indigo-500">₫</div>
                            <input type="number" name="basePrice" id="inputPrice" 
                                   class="w-full bg-slate-900 border-2 border-slate-800 rounded-2xl pl-10 pr-5 py-4 text-white focus:border-indigo-600 focus:outline-none transition-all font-bold text-lg" 
                                   placeholder="Ví dụ: 80000" required>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-none p-10 pt-0 flex gap-4">
                <button type="button" class="flex-1 py-4 px-6 rounded-2xl text-slate-400 font-bold hover:bg-slate-700/50 transition-all uppercase tracking-widest text-[11px]" data-bs-dismiss="modal">Hủy bỏ</button>
                <button type="submit" class="flex-[2] py-4 px-6 rounded-2xl bg-indigo-600 hover:bg-indigo-500 text-white font-black transition-all shadow-2xl shadow-indigo-600/30 uppercase tracking-widest text-[11px]">
                    Xác nhận thiết lập
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function prepareAdd() {
        document.getElementById('modalTitle').innerText = 'Thiết lập Suất chiếu';
        document.getElementById('modalAction').value = 'add';
        document.getElementById('modalShowtimeId').value = '';
        document.getElementById('inputMovie').value = '';
        document.getElementById('inputRoom').value = '';
        document.getElementById('inputStart').value = '';
        document.getElementById('inputEnd').value = '';
        document.getElementById('inputPrice').value = '';
    }

    function prepareEdit(id) {
        const container = document.getElementById('data-' + id);
        
        document.getElementById('modalTitle').innerText = 'Chỉnh sửa Suất chiếu';
        document.getElementById('modalAction').value = 'update';
        document.getElementById('modalShowtimeId').value = id;
        
        document.getElementById('inputMovie').value = container.querySelector('.d-movie').innerText;
        document.getElementById('inputRoom').value = container.querySelector('.d-room').innerText;
        document.getElementById('inputStart').value = container.querySelector('.d-start').innerText;
        document.getElementById('inputEnd').value = container.querySelector('.d-end').innerText;
        document.getElementById('inputPrice').value = container.querySelector('.d-price').innerText;
        
        var myModal = new bootstrap.Modal(document.getElementById('showtimeModal'));
        myModal.show();
    }
</script>
</body>
</html>
