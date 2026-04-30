<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Phim | Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .movie-card-glow { transition: all 0.3s ease; }
        .movie-card-glow:hover { box-shadow: 0 0 20px rgba(99, 102, 241, 0.2); border-color: rgba(99, 102, 241, 0.4); }
        .custom-scrollbar::-webkit-scrollbar { width: 6px; }
        .custom-scrollbar::-webkit-scrollbar-track { background: transparent; }
        .custom-scrollbar::-webkit-scrollbar-thumb { background: #334155; border-radius: 10px; }
    </style>
</head>
<body class="bg-[#0f172a] text-slate-200 custom-scrollbar">

<jsp:include page="/common/admin-sidebar.jsp">
    <jsp:param name="activeTab" value="movies" />
</jsp:include>

<div class="main-content min-h-screen">
    <!-- Header Section -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4 mb-8">
        <div>
            <h1 class="text-3xl font-extrabold text-white tracking-tight">Quản lý Kho Phim</h1>
            <p class="text-slate-400 mt-1">Quản lý thông tin, poster và trạng thái công chiếu của phim.</p>
        </div>
        <button class="bg-indigo-600 hover:bg-indigo-500 text-white font-bold py-3 px-6 rounded-2xl flex items-center gap-2 transition-all shadow-lg shadow-indigo-600/20 group"
                data-bs-toggle="modal" data-bs-target="#movieModal" onclick="prepareAdd()">
            <i class="fas fa-plus group-hover:rotate-90 transition-transform"></i>
            <span>Thêm Phim Mới</span>
        </button>
    </div>

    <!-- Stats Mini Grid -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div class="glass-effect p-6 rounded-3xl flex items-center gap-4">
            <div class="w-12 h-12 bg-emerald-500/10 rounded-2xl flex items-center justify-center text-emerald-500">
                <i class="fas fa-play text-xl"></i>
            </div>
            <div>
                <p class="text-slate-500 text-xs font-bold uppercase tracking-widest">Đang chiếu</p>
                <h3 class="text-2xl font-bold text-white">12</h3>
            </div>
        </div>
        <div class="glass-effect p-6 rounded-3xl flex items-center gap-4">
            <div class="w-12 h-12 bg-amber-500/10 rounded-2xl flex items-center justify-center text-amber-500">
                <i class="fas fa-clock text-xl"></i>
            </div>
            <div>
                <p class="text-slate-500 text-xs font-bold uppercase tracking-widest">Sắp công chiếu</p>
                <h3 class="text-2xl font-bold text-white">5</h3>
            </div>
        </div>
        <div class="glass-effect p-6 rounded-3xl flex items-center gap-4">
            <div class="w-12 h-12 bg-indigo-500/10 rounded-2xl flex items-center justify-center text-indigo-500">
                <i class="fas fa-star text-xl"></i>
            </div>
            <div>
                <p class="text-slate-500 text-xs font-bold uppercase tracking-widest">Đánh giá trung bình</p>
                <h3 class="text-2xl font-bold text-white">8.5</h3>
            </div>
        </div>
    </div>

    <!-- Data Table Card -->
    <div class="glass-effect rounded-3xl overflow-hidden border border-slate-800 shadow-2xl">
        <div class="overflow-x-auto">
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr class="bg-slate-800/50">
                        <th class="p-5 text-[11px] font-extrabold text-slate-400 uppercase tracking-widest">Thông tin phim</th>
                        <th class="p-5 text-[11px] font-extrabold text-slate-400 uppercase tracking-widest">Thời lượng</th>
                        <th class="p-5 text-[11px] font-extrabold text-slate-400 uppercase tracking-widest">Khởi chiếu</th>
                        <th class="p-5 text-[11px] font-extrabold text-slate-400 uppercase tracking-widest">Đánh giá</th>
                        <th class="p-5 text-[11px] font-extrabold text-slate-400 uppercase tracking-widest">Trạng thái</th>
                        <th class="p-5 text-[11px] font-extrabold text-slate-400 uppercase tracking-widest text-right">Thao tác</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-800">
                    <c:forEach var="m" items="${movieList}">
                        <tr class="hover:bg-slate-800/30 transition-colors group">
                            <td class="p-5">
                                <div class="flex items-center gap-4">
                                    <div class="relative group">
                                        <img src="${pageContext.request.contextPath}/${m.poster}" 
                                             class="w-14 h-20 rounded-xl object-cover shadow-lg border border-slate-700 group-hover:scale-105 transition-transform" 
                                             alt="${m.title}">
                                        <div class="absolute inset-0 bg-indigo-600/20 rounded-xl opacity-0 group-hover:opacity-100 transition-opacity"></div>
                                    </div>
                                    <div class="max-w-[250px]">
                                        <h4 class="text-white font-bold text-base truncate">${m.title}</h4>
                                        <p class="text-slate-500 text-xs mt-1 line-clamp-1">${m.description}</p>
                                    </div>
                                </div>
                            </td>
                            <td class="p-5">
                                <span class="bg-slate-800 text-slate-300 text-[11px] font-bold px-3 py-1.5 rounded-lg border border-slate-700">
                                    ${m.duration} PHÚT
                                </span>
                            </td>
                            <td class="p-5 text-slate-400 text-sm font-medium">
                                <fmt:formatDate value="${m.releaseDate}" pattern="dd/MM/yyyy" />
                            </td>
                            <td class="p-5">
                                <div class="flex items-center gap-1.5 text-amber-400">
                                    <i class="fas fa-star text-xs"></i>
                                    <span class="font-bold text-sm text-slate-200">${m.rating}</span>
                                </div>
                            </td>
                            <td class="p-5">
                                <c:choose>
                                    <c:when test="${m.status == 'NOW_SHOWING'}">
                                        <span class="bg-emerald-500/10 text-emerald-500 text-[10px] font-black uppercase px-3 py-1.5 rounded-full border border-emerald-500/20">
                                            Đang chiếu
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="bg-amber-500/10 text-amber-500 text-[10px] font-black uppercase px-3 py-1.5 rounded-full border border-amber-500/20">
                                            Sắp chiếu
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="p-5">
                                <div class="flex justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                                    <!-- Hidden data for robust JS access -->
                                    <div class="hidden" id="data-${m.movieId}">
                                        <span class="d-title">${m.title}</span>
                                        <span class="d-desc">${m.description}</span>
                                        <span class="d-dur">${m.duration}</span>
                                        <span class="d-date"><fmt:formatDate value="${m.releaseDate}" pattern="yyyy-MM-dd" /></span>
                                        <span class="d-rate">${m.rating}</span>
                                        <span class="d-poster">${m.poster}</span>
                                        <span class="d-status">${m.status}</span>
                                    </div>
                                    <button class="w-10 h-10 rounded-xl bg-indigo-500/10 text-indigo-400 hover:bg-indigo-500 hover:text-white transition-all flex items-center justify-center border border-indigo-500/20"
                                            onclick="prepareEdit('${m.movieId}')">
                                        <i class="fas fa-edit text-xs"></i>
                                    </button>
                                    <form action="${pageContext.request.contextPath}/admin/movies" method="POST" class="inline" onsubmit="return confirm('Xóa phim này?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${m.movieId}">
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

<!-- Movie Modal (Styled with Tailwind Utility Classes) -->
<div class="modal fade" id="movieModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <form action="${pageContext.request.contextPath}/admin/movies" method="POST" class="modal-content !bg-[#1e293b] !rounded-[2rem] border-none shadow-2xl">
            <input type="hidden" name="action" id="modalAction" value="add">
            <input type="hidden" name="movieId" id="modalMovieId">
            
            <div class="modal-header border-none p-8 flex justify-between items-center">
                <h5 class="text-2xl font-black text-white tracking-tight" id="modalTitle">Thêm phim mới</h5>
                <button type="button" class="w-10 h-10 rounded-full hover:bg-slate-700 flex items-center justify-center text-slate-400" data-bs-dismiss="modal">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body p-8 pt-0">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="md:col-span-2">
                        <label class="block text-[11px] font-black text-slate-500 uppercase tracking-widest mb-2">Tên phim</label>
                        <input type="text" name="title" id="inputTitle" 
                               class="w-full bg-slate-900 border-2 border-slate-800 rounded-2xl px-5 py-3.5 text-white focus:border-indigo-600 focus:outline-none transition-all placeholder:text-slate-600" 
                               placeholder="Ví dụ: Avengers: Endgame" required>
                    </div>
                    <div>
                        <label class="block text-[11px] font-black text-slate-500 uppercase tracking-widest mb-2">Đánh giá (0.0 - 10.0)</label>
                        <input type="number" step="0.1" name="rating" id="inputRating" 
                               class="w-full bg-slate-900 border-2 border-slate-800 rounded-2xl px-5 py-3.5 text-white focus:border-indigo-600 focus:outline-none transition-all placeholder:text-slate-600" required>
                    </div>
                    <div>
                        <label class="block text-[11px] font-black text-slate-500 uppercase tracking-widest mb-2">Trạng thái</label>
                        <select name="status" id="inputStatus" class="w-full bg-slate-900 border-2 border-slate-800 rounded-2xl px-5 py-3.5 text-white focus:border-indigo-600 focus:outline-none transition-all appearance-none cursor-pointer">
                            <option value="NOW_SHOWING">Đang chiếu</option>
                            <option value="COMING_SOON">Sắp chiếu</option>
                        </select>
                    </div>
                    <div class="md:col-span-2">
                        <label class="block text-[11px] font-black text-slate-500 uppercase tracking-widest mb-2">Mô tả phim</label>
                        <textarea name="description" id="inputDescription" rows="4"
                               class="w-full bg-slate-900 border-2 border-slate-800 rounded-2xl px-5 py-3.5 text-white focus:border-indigo-600 focus:outline-none transition-all placeholder:text-slate-600" 
                               placeholder="Nhập nội dung tóm tắt của phim..."></textarea>
                    </div>
                    <div>
                        <label class="block text-[11px] font-black text-slate-500 uppercase tracking-widest mb-2">Thời lượng (phút)</label>
                        <input type="number" name="duration" id="inputDuration" 
                               class="w-full bg-slate-900 border-2 border-slate-800 rounded-2xl px-5 py-3.5 text-white focus:border-indigo-600 focus:outline-none transition-all" required>
                    </div>
                    <div>
                        <label class="block text-[11px] font-black text-slate-500 uppercase tracking-widest mb-2">Ngày khởi chiếu</label>
                        <input type="date" name="releaseDate" id="inputReleaseDate" 
                               class="w-full bg-slate-900 border-2 border-slate-800 rounded-2xl px-5 py-3.5 text-white focus:border-indigo-600 focus:outline-none transition-all" required>
                    </div>
                    <div class="md:col-span-2">
                        <label class="block text-[11px] font-black text-slate-500 uppercase tracking-widest mb-2">Đường dẫn Poster</label>
                        <input type="text" name="poster" id="inputPoster" 
                               class="w-full bg-slate-900 border-2 border-slate-800 rounded-2xl px-5 py-3.5 text-white focus:border-indigo-600 focus:outline-none transition-all placeholder:text-slate-600" 
                               placeholder="assets/images/movies/poster.jpg">
                    </div>
                </div>
            </div>
            <div class="modal-footer border-none p-8 pt-0 flex gap-4">
                <button type="button" class="flex-1 py-4 px-6 rounded-2xl text-slate-400 font-bold hover:bg-slate-700/50 transition-all" data-bs-dismiss="modal">Hủy bỏ</button>
                <button type="submit" class="flex-[2] py-4 px-6 rounded-2xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold transition-all shadow-xl shadow-indigo-600/20">
                    Lưu thông tin Phim
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function prepareAdd() {
        document.getElementById('modalTitle').innerText = 'Thêm phim mới';
        document.getElementById('modalAction').value = 'add';
        document.getElementById('modalMovieId').value = '';
        document.getElementById('inputTitle').value = '';
        document.getElementById('inputDescription').value = '';
        document.getElementById('inputDuration').value = '';
        document.getElementById('inputReleaseDate').value = '';
        document.getElementById('inputRating').value = '';
        document.getElementById('inputPoster').value = '';
        document.getElementById('inputStatus').value = 'NOW_SHOWING';
    }

    function prepareEdit(id) {
        const container = document.getElementById('data-' + id);
        
        document.getElementById('modalTitle').innerText = 'Chỉnh sửa phim';
        document.getElementById('modalAction').value = 'update';
        document.getElementById('modalMovieId').value = id;
        
        document.getElementById('inputTitle').value = container.querySelector('.d-title').innerText;
        document.getElementById('inputDescription').value = container.querySelector('.d-desc').innerText;
        document.getElementById('inputDuration').value = container.querySelector('.d-dur').innerText;
        document.getElementById('inputReleaseDate').value = container.querySelector('.d-date').innerText;
        document.getElementById('inputRating').value = container.querySelector('.d-rate').innerText;
        document.getElementById('inputPoster').value = container.querySelector('.d-poster').innerText;
        document.getElementById('inputStatus').value = container.querySelector('.d-status').innerText;
        
        var myModal = new bootstrap.Modal(document.getElementById('movieModal'));
        myModal.show();
    }
</script>
</body>
</html>
