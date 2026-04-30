<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Phim | Admin</title>
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
                <h1 class="text-4xl font-extrabold tracking-tight text-white mb-2">Quản lý Phim</h1>
                <p class="text-slate-400">Thêm, sửa và cập nhật danh sách phim đang công chiếu.</p>
            </div>
            <button class="bg-indigo-600 hover:bg-indigo-500 text-white font-bold py-3 px-6 rounded-xl shadow-lg shadow-indigo-600/20 transition-all flex items-center gap-2" 
                    data-bs-toggle="modal" data-bs-target="#movieModal" onclick="prepareAdd()">
                <i class="fas fa-plus-circle"></i> Thêm phim mới
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
                            <th class="px-8 py-5">THÔNG TIN PHIM</th>
                            <th class="px-8 py-5">THỂ LOẠI</th>
                            <th class="px-8 py-5">THỜI LƯỢNG</th>
                            <th class="px-8 py-5">TRẠNG THÁI</th>
                            <th class="px-8 py-5 text-right">HÀNH ĐỘNG</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-white/5">
                        <c:forEach var="m" items="${movieList}">
                            <tr class="hover:bg-white/5 transition-colors group">
                                <td class="px-8 py-5">
                                    <div class="flex items-center gap-4">
                                        <img src="${m.poster}" class="w-12 h-16 rounded-lg object-cover shadow-lg group-hover:scale-105 transition-transform" onerror="this.src='https://placehold.co/300x450?text=No+Poster'">
                                        <div>
                                            <div class="font-bold text-white text-base mb-1">${m.title}</div>
                                            <div class="text-slate-500 text-[11px] font-medium tracking-wider">MÃ: #${m.movieId}</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-8 py-5">
                                    <span class="px-3 py-1 bg-white/5 border border-white/10 rounded-full text-slate-400 text-xs font-medium">
                                        ${m.genre}
                                    </span>
                                </td>
                                <td class="px-8 py-5">
                                    <div class="text-white font-medium">${m.duration} <span class="text-slate-500 text-xs">phút</span></div>
                                </td>
                                <td class="px-8 py-5">
                                    <c:choose>
                                        <c:when test="${m.status == 'NOW_SHOWING'}">
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-emerald-500/10 text-emerald-500 border border-emerald-500/20 text-[10px] font-black uppercase tracking-wider">
                                                <span class="w-1 h-1 rounded-full bg-emerald-500 animate-pulse"></span> Đang chiếu
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-indigo-500/10 text-indigo-400 border border-indigo-500/20 text-[10px] font-black uppercase tracking-wider">
                                                <span class="w-1 h-1 rounded-full bg-indigo-500"></span> Sắp chiếu
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-8 py-5 text-right">
                                    <div class="flex justify-end gap-3">
                                        <button class="w-9 h-9 rounded-lg bg-indigo-500/10 text-indigo-400 flex items-center justify-center hover:bg-indigo-500 hover:text-white transition-all" 
                                                title="Chỉnh sửa" 
                                                onclick="prepareEdit('${m.movieId}', '${m.title}', '${m.genre}', '${m.duration}', '${m.poster}', '${m.trailerUrl}', '${m.status}', '${m.description}', '${m.releaseDate}', '${m.rating}')">
                                            <i class="fas fa-edit text-xs"></i>
                                        </button>
                                        <form action="${pageContext.request.contextPath}/admin/movies" method="POST" class="inline" onsubmit="return confirm('Bạn có chắc muốn xóa phim này?')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="movieId" value="${m.movieId}">
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

<!-- Modal UI Enhancement -->
<style>
    .modal-content { background: #1e293b !important; border: 1px solid rgba(255,255,255,0.1) !important; border-radius: 24px !important; }
    .form-control, .form-select { background: rgba(15,23,42,0.5) !important; border: 1px solid rgba(255,255,255,0.1) !important; color: white !important; border-radius: 12px !important; padding: 10px 16px !important; }
    .form-control:focus, .form-select:focus { border-color: #6366f1 !important; box-shadow: 0 0 0 4px rgba(99,102,241,0.1) !important; }
    .form-label { margin-bottom: 0.5rem; color: #94a3b8; font-weight: 600; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.05em; }
</style>

<div class="modal fade" id="movieModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <form action="${pageContext.request.contextPath}/admin/movies" method="POST" class="modal-content">
            <input type="hidden" name="action" id="modalAction" value="add">
            <input type="hidden" name="movieId" id="modalMovieId">
            
            <div class="modal-header border-0 p-6">
                <h5 class="modal-title text-xl font-black text-white" id="modalTitle">Thêm phim mới</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body p-6 pt-0">
                <div class="row g-4">
                    <div class="col-md-8">
                        <label class="form-label">Tiêu đề phim</label>
                        <input type="text" name="title" id="inputTitle" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Trạng thái</label>
                        <select name="status" id="inputStatus" class="form-select">
                            <option value="NOW_SHOWING">Đang chiếu</option>
                            <option value="COMING_SOON">Sắp chiếu</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Thể loại</label>
                        <input type="text" name="genre" id="inputGenre" class="form-control" placeholder="Hành động, Phiêu lưu">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Thời lượng (phút)</label>
                        <input type="number" name="duration" id="inputDuration" class="form-control" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Đánh giá (1-10)</label>
                        <input type="number" step="0.1" name="rating" id="inputRating" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Ngày khởi chiếu</label>
                        <input type="date" name="releaseDate" id="inputReleaseDate" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Đường dẫn Poster</label>
                        <input type="text" name="poster" id="inputPoster" class="form-control">
                    </div>
                    <div class="col-12">
                        <label class="form-label">Đường dẫn Trailer (Youtube)</label>
                        <input type="text" name="trailerUrl" id="inputTrailer" class="form-control">
                    </div>
                    <div class="col-12">
                        <label class="form-label">Mô tả phim</label>
                        <textarea name="description" id="inputDescription" class="form-control" rows="4"></textarea>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 p-6 pt-0">
                <button type="button" class="text-slate-400 hover:text-white font-bold px-4 py-2 transition-colors" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" class="bg-indigo-600 hover:bg-indigo-500 text-white font-bold py-2.5 px-8 rounded-xl transition-all">Lưu thông tin</button>
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
        document.getElementById('inputGenre').value = '';
        document.getElementById('inputDuration').value = '';
        document.getElementById('inputPoster').value = '';
        document.getElementById('inputTrailer').value = '';
        document.getElementById('inputDescription').value = '';
        document.getElementById('inputStatus').value = 'NOW_SHOWING';
        document.getElementById('inputReleaseDate').value = '';
        document.getElementById('inputRating').value = '0';
    }

    function prepareEdit(id, title, genre, duration, poster, trailer, status, description, releaseDate, rating) {
        document.getElementById('modalTitle').innerText = 'Chỉnh sửa phim';
        document.getElementById('modalAction').value = 'update';
        document.getElementById('modalMovieId').value = id;
        document.getElementById('inputTitle').value = title;
        document.getElementById('inputGenre').value = genre;
        document.getElementById('inputDuration').value = duration;
        document.getElementById('inputPoster').value = poster;
        document.getElementById('inputTrailer').value = trailer;
        document.getElementById('inputStatus').value = status;
        document.getElementById('inputDescription').value = description;
        document.getElementById('inputReleaseDate').value = releaseDate;
        document.getElementById('inputRating').value = rating;
        
        var myModal = new bootstrap.Modal(document.getElementById('movieModal'));
        myModal.show();
    }
</script>
</body>
</html>
