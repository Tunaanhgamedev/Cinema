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
</head>
<body>

<jsp:include page="/common/admin/sidebar.jsp" />

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-5">
        <div>
            <h1 class="fw-800 mb-1" style="font-weight: 800;">Quản lý Phim</h1>
            <p class="text-muted mb-0">Thêm, sửa và cập nhật danh sách phim đang công chiếu.</p>
        </div>
        <button class="btn btn-primary px-4" data-bs-toggle="modal" data-bs-target="#movieModal" onclick="prepareAdd()">
            <i class="fas fa-plus-circle me-2"></i> Thêm phim mới
        </button>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger mb-4 rounded-4 border-0 bg-danger bg-opacity-10 text-danger">
            <i class="fas fa-exclamation-circle me-2"></i> ${error}
        </div>
    </c:if>

    <div class="card-glass p-0 overflow-hidden">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th style="padding-left: 30px;">THÔNG TIN PHIM</th>
                        <th>THỂ LOẠI</th>
                        <th>THỜI LƯỢNG</th>
                        <th>TRẠNG THÁI</th>
                        <th class="text-end" style="padding-right: 30px;">HÀNH ĐỘNG</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="m" items="${movieList}">
                        <tr>
                            <td style="padding-left: 30px;">
                                <div class="d-flex align-items-center gap-3">
                                    <img src="${m.poster}" class="rounded-3 shadow-sm" style="width: 48px; height: 68px; object-fit: cover;">
                                    <div>
                                        <div class="fw-bold text-white">${m.title}</div>
                                        <div class="text-muted small">Mã: #${m.movieId}</div>
                                    </div>
                                </div>
                            </td>
                            <td><span class="badge bg-white bg-opacity-5 text-muted fw-normal">${m.genre}</span></td>
                            <td><span class="text-white">${m.duration} <small class="text-muted">phút</small></span></td>
                            <td>
                                <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-3">Sẵn sàng</span>
                            </td>
                            <td class="text-end" style="padding-right: 30px;">
                                <div class="d-flex justify-content-end gap-2">
                                    <button class="btn-action" title="Chỉnh sửa" onclick="prepareEdit('${m.movieId}', '${m.title}', '${m.poster}', '${m.description}', '${m.genre}', '${m.duration}', '${m.trailer}')">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <form action="${pageContext.request.contextPath}/admin/movies" method="POST" class="d-inline" onsubmit="return confirm('Bạn có chắc muốn xóa phim này?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="movieId" value="${m.movieId}">
                                        <button class="btn-action hover-danger" title="Xóa">
                                            <i class="fas fa-trash-alt"></i>
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

<!-- Movie Modal -->
<div class="modal fade" id="movieModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <form action="${pageContext.request.contextPath}/admin/movies" method="POST" class="modal-content">
            <input type="hidden" name="action" id="modalAction" value="add">
            <input type="hidden" name="movieId" id="modalId">
            
            <div class="modal-header border-0 p-4">
                <h5 class="modal-title fw-bold" id="modalTitle">Thêm phim mới</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body p-4 pt-0">
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
