<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Phim | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background: #0b0f19; color: #e5e7eb; font-family: 'Inter', sans-serif; }
        .sidebar { width: 260px; background: #111827; border-right: 1px solid #1f2937; min-height: 100vh; position: fixed; }
        .main-content { margin-left: 260px; padding: 40px; }
        .nav-link { color: #9ca3af; padding: 12px 20px; border-radius: 12px; margin: 4px 12px; display: block; text-decoration: none; transition: 0.3s; }
        .nav-link:hover, .nav-link.active { background: #1f2937; color: #fff; }
        .card-glass { background: rgba(17, 24, 39, 0.7); backdrop-filter: blur(10px); border: 1px solid #1f2937; border-radius: 20px; }
        .table { color: #e5e7eb; }
        .table thead th { border-bottom: 2px solid #1f2937; color: #9ca3af; font-weight: 600; text-transform: uppercase; font-size: 12px; }
        .table tbody td { border-bottom: 1px solid #1f2937; vertical-align: middle; padding: 15px; }
        .movie-poster-sm { width: 45px; height: 65px; border-radius: 8px; object-fit: cover; }
        .btn-action { width: 32px; height: 32px; padding: 0; border-radius: 8px; display: inline-flex; align-items: center; justify-content: center; }
        .modal-content { background: #111827; border: 1px solid #1f2937; border-radius: 20px; color: #e5e7eb; }
        .form-control, .form-select { background: #1f2937; border: 1px solid #374151; color: #fff; border-radius: 10px; }
        .form-control:focus { background: #1f2937; color: #fff; border-color: #6366f1; box-shadow: none; }
        .brand { padding: 24px; font-size: 24px; font-weight: 900; color: #e50914; letter-spacing: -1px; }
    </style>
</head>
<body>

<jsp:include page="/common/admin-sidebar.jsp">
    <jsp:param name="activeTab" value="movies" />
</jsp:include>

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-5">
        <div>
            <h2 class="fw-bold mb-1">Danh sách phim</h2>
            <p class="text-muted small mb-0">Quản lý kho phim và trạng thái hiển thị</p>
        </div>
        <button class="btn btn-primary px-4 rounded-3" data-bs-toggle="modal" data-bs-target="#movieModal" onclick="prepareAdd()">
            <i class="fas fa-plus me-2"></i> Thêm phim mới
        </button>
    </div>

    <div class="card-glass p-4">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Phim</th>
                        <th>Thời lượng</th>
                        <th>Khởi chiếu</th>
                        <th>Đánh giá</th>
                        <th>Trạng thái</th>
                        <th class="text-end">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="m" items="${movieList}">
                        <tr>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="${pageContext.request.contextPath}/${m.poster}" class="movie-poster-sm me-3" alt="">
                                    <div>
                                        <div class="fw-bold">${m.title}</div>
                                        <div class="text-muted small">ID: #${m.movieId}</div>
                                    </div>
                                </div>
                            </td>
                            <td>${m.duration} phút</td>
                            <td>${m.releaseDate}</td>
                            <td><span class="text-warning"><i class="fas fa-star me-1"></i></span> ${m.rating}</td>
                            <td>
                                <span class="badge ${m.status == 'NOW_SHOWING' ? 'bg-success' : 'bg-warning'} rounded-pill px-3">
                                    ${m.status == 'NOW_SHOWING' ? 'Đang chiếu' : 'Sắp chiếu'}
                                </span>
                            </td>
                            <td class="text-end">
                                <button class="btn btn-outline-info btn-action me-1" onclick="prepareEdit('${m.movieId}', '${m.title}', '${m.description}', '${m.duration}', '${m.releaseDate}', '${m.rating}', '${m.poster}', '${m.status}')">
                                    <i class="fas fa-edit small"></i>
                                </button>
                                <form action="${pageContext.request.contextPath}/admin/movies" method="POST" class="d-inline" onsubmit="return confirm('Xóa phim này?')">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${m.movieId}">
                                    <button class="btn btn-outline-danger btn-action">
                                        <i class="fas fa-trash small"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Movie Modal -->
<div class="modal fade" id="movieModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <form action="${pageContext.request.contextPath}/admin/movies" method="POST" class="modal-content">
            <input type="hidden" name="action" id="modalAction" value="add">
            <input type="hidden" name="movieId" id="modalMovieId">
            
            <div class="modal-header border-0 p-4">
                <h5 class="modal-title fw-bold" id="modalTitle">Thêm phim mới</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4 pt-0">
                <div class="row g-3">
                    <div class="col-md-8">
                        <label class="form-label small text-muted fw-bold">Tên phim</label>
                        <input type="text" name="title" id="inputTitle" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small text-muted fw-bold">Đánh giá (Rating)</label>
                        <input type="number" step="0.1" name="rating" id="inputRating" class="form-control" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label small text-muted fw-bold">Mô tả</label>
                        <textarea name="description" id="inputDescription" class="form-control" rows="3"></textarea>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small text-muted fw-bold">Thời lượng (phút)</label>
                        <input type="number" name="duration" id="inputDuration" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small text-muted fw-bold">Ngày khởi chiếu</label>
                        <input type="date" name="releaseDate" id="inputReleaseDate" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small text-muted fw-bold">Trạng thái</label>
                        <select name="status" id="inputStatus" class="form-select">
                            <option value="NOW_SHOWING">Đang chiếu</option>
                            <option value="COMING_SOON">Sắp chiếu</option>
                        </select>
                    </div>
                    <div class="col-12">
                        <label class="form-label small text-muted fw-bold">Đường dẫn Poster</label>
                        <input type="text" name="poster" id="inputPoster" class="form-control" placeholder="assets/images/movies/poster.jpg">
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 p-4 pt-0">
                <button type="button" class="btn btn-link text-white text-decoration-none" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" class="btn btn-primary px-4 rounded-3">Lưu thay đổi</button>
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

    function prepareEdit(id, title, desc, dur, date, rate, poster, status) {
        document.getElementById('modalTitle').innerText = 'Chỉnh sửa phim';
        document.getElementById('modalAction').value = 'update';
        document.getElementById('modalMovieId').value = id;
        document.getElementById('inputTitle').value = title;
        document.getElementById('inputDescription').value = desc;
        document.getElementById('inputDuration').value = dur;
        document.getElementById('inputReleaseDate').value = date;
        document.getElementById('inputRating').value = rate;
        document.getElementById('inputPoster').value = poster;
        document.getElementById('inputStatus').value = status;
        
        var myModal = new bootstrap.Modal(document.getElementById('movieModal'));
        myModal.show();
    }
</script>
</body>
</html>
