<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Phim | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
                        <th style="width: 300px;">Thông tin phim</th>
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
                                    <img src="${pageContext.request.contextPath}/${m.poster}" class="movie-poster-sm me-3" alt="${m.title}">
                                    <div style="max-width: 200px;">
                                        <div class="fw-bold text-white text-truncate">${m.title}</div>
                                        <div class="text-muted small text-truncate-2">${m.description}</div>
                                    </div>
                                </div>
                            </td>
                            <td><span class="badge bg-dark border border-secondary">${m.duration} phút</span></td>
                            <td><fmt:formatDate value="${m.releaseDate}" pattern="dd/MM/yyyy" /></td>
                            <td><span class="text-warning"><i class="fas fa-star me-1"></i></span> ${m.rating}</td>
                            <td>
                                <span class="badge ${m.status == 'NOW_SHOWING' ? 'bg-success' : 'bg-warning'} rounded-pill px-3">
                                    ${m.status == 'NOW_SHOWING' ? 'Đang chiếu' : 'Sắp chiếu'}
                                </span>
                            </td>
                            <td class="text-end">
                                <!-- Hidden data for robust JS access -->
                                <div class="d-none" id="data-${m.movieId}">
                                    <span class="d-title">${m.title}</span>
                                    <span class="d-desc">${m.description}</span>
                                    <span class="d-dur">${m.duration}</span>
                                    <span class="d-date"><fmt:formatDate value="${m.releaseDate}" pattern="yyyy-MM-dd" /></span>
                                    <span class="d-rate">${m.rating}</span>
                                    <span class="d-poster">${m.poster}</span>
                                    <span class="d-status">${m.status}</span>
                                </div>
                                <button class="btn btn-outline-info btn-action me-1" onclick="prepareEdit('${m.movieId}')">
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
                        <input type="text" name="title" id="inputTitle" class="form-control" placeholder="Ví dụ: Avengers: Endgame" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small text-muted fw-bold">Đánh giá (Rating)</label>
                        <input type="number" step="0.1" name="rating" id="inputRating" class="form-control" placeholder="0.0 - 10.0" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label small text-muted fw-bold">Mô tả phim</label>
                        <textarea name="description" id="inputDescription" class="form-control" rows="4" placeholder="Nhập nội dung tóm tắt của phim..."></textarea>
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
                        <div class="input-group">
                            <span class="input-group-text bg-dark border-secondary text-muted"><i class="fas fa-image"></i></span>
                            <input type="text" name="poster" id="inputPoster" class="form-control" placeholder="assets/images/movies/poster.jpg">
                        </div>
                        <p class="text-muted x-small mt-1">Đường dẫn tương đối từ gốc thư mục web.</p>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 p-4 pt-0">
                <button type="button" class="btn btn-link text-white text-decoration-none" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" class="btn btn-primary px-4 rounded-3 shadow">Lưu thông tin</button>
            </div>
        </form>
    </div>
</div>

<style>
    .text-truncate-2 {
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        font-size: 0.8rem;
    }
    .x-small { font-size: 0.75rem; }
</style>

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
