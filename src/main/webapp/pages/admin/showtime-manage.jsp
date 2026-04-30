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
</head>
<body>

<jsp:include page="/common/admin/sidebar.jsp" />

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-5">
        <div>
            <h1 class="fw-800 mb-1" style="font-weight: 800;">Lịch chiếu phim</h1>
            <p class="text-muted mb-0">Quản lý thời gian chiếu và giá vé cho từng suất phim.</p>
        </div>
        <button class="btn btn-primary px-4" data-bs-toggle="modal" data-bs-target="#showtimeModal" onclick="prepareAdd()">
            <i class="fas fa-calendar-plus me-2"></i> Thêm suất chiếu mới
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
                        <th style="padding-left: 30px;">ID</th>
                        <th>PHIM</th>
                        <th>PHÒNG CHIẾU</th>
                        <th>THỜI GIAN CHIẾU</th>
                        <th>GIÁ VÉ</th>
                        <th class="text-end" style="padding-right: 30px;">HÀNH ĐỘNG</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${showtimeList}">
                        <tr>
                            <td style="padding-left: 30px;"><span class="text-muted">#${s.showtimeId}</span></td>
                            <td>
                                <div class="fw-bold text-white">${s.movieName}</div>
                                <div class="text-muted small">Mã phim: ${s.movieId}</div>
                            </td>
                            <td>
                                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-3">
                                    <i class="fas fa-door-open me-1"></i> ${s.roomName}
                                </span>
                            </td>
                            <td>
                                <div class="d-flex align-items-center gap-2 mb-1">
                                    <i class="far fa-clock text-accent small"></i>
                                    <span class="fw-bold text-white"><fmt:formatDate value="${s.startTime}" pattern="dd/MM/yyyy HH:mm" /></span>
                                </div>
                                <div class="text-muted small">Kết thúc: <fmt:formatDate value="${s.endTime}" pattern="HH:mm" /></div>
                            </td>
                            <td><span class="fw-bold text-success"><fmt:formatNumber value="${s.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></span></td>
                            <td class="text-end" style="padding-right: 30px;">
                                <div class="d-flex justify-content-end gap-2">
                                    <button class="btn-action" title="Chỉnh sửa" onclick="prepareEdit('${s.showtimeId}', '${s.movieId}', '${s.roomId}', '${s.startTime}', '${s.endTime}', '${s.price}')">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <form action="${pageContext.request.contextPath}/admin/showtimes" method="POST" class="d-inline" onsubmit="return confirm('Xóa suất chiếu này?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="showtimeId" value="${s.showtimeId}">
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
