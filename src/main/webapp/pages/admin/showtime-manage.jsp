<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Suất chiếu | Admin</title>
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
        .btn-action { width: 32px; height: 32px; padding: 0; border-radius: 8px; display: inline-flex; align-items: center; justify-content: center; }
        .modal-content { background: #111827; border: 1px solid #1f2937; border-radius: 20px; color: #e5e7eb; }
        .form-control, .form-select { background: #1f2937; border: 1px solid #374151; color: #fff; border-radius: 10px; }
        .form-control:focus { background: #1f2937; color: #fff; border-color: #6366f1; box-shadow: none; }
        .brand { padding: 24px; font-size: 24px; font-weight: 900; color: #e50914; letter-spacing: -1px; }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="brand">BOBIXI • ADMIN</div>
    <nav>
        <a href="${pageContext.request.contextPath}/admin" class="nav-link"><i class="fas fa-chart-line me-2"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/movies" class="nav-link"><i class="fas fa-film me-2"></i> Quản lý Phim</a>
        <a href="${pageContext.request.contextPath}/admin/showtimes" class="nav-link active"><i class="fas fa-calendar-alt me-2"></i> Lịch chiếu</a>
        <a href="${pageContext.request.contextPath}/admin/bookings" class="nav-link"><i class="fas fa-ticket-alt me-2"></i> Đơn hàng</a>
        <a href="${pageContext.request.contextPath}/home" class="nav-link"><i class="fas fa-external-link-alt me-2"></i> Về Web</a>
    </nav>
</div>

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-5">
        <div>
            <h2 class="fw-bold mb-1">Lịch chiếu phim</h2>
            <p class="text-muted small mb-0">Quản lý thời gian chiếu và giá vé cho từng suất</p>
        </div>
        <button class="btn btn-primary px-4 rounded-3" data-bs-toggle="modal" data-bs-target="#showtimeModal" onclick="prepareAdd()">
            <i class="fas fa-plus me-2"></i> Thêm suất chiếu mới
        </button>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger mb-4 rounded-3">${error}</div>
    </c:if>

    <div class="card-glass p-4">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Phim</th>
                        <th>Phòng</th>
                        <th>Thời gian</th>
                        <th>Giá vé</th>
                        <th class="text-end">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${showtimeList}">
                        <tr>
                            <td>#${s.showtimeId}</td>
                            <td><span class="fw-bold text-white">${s.movieName}</span> <span class="text-muted small">(ID: ${s.movieId})</span></td>
                            <td>${s.roomName} <span class="text-muted small">(ID: ${s.roomId})</span></td>
                            <td>
                                <div class="small"><i class="far fa-clock me-1 text-primary"></i> <fmt:formatDate value="${s.startTime}" pattern="dd/MM/yyyy HH:mm" /></div>
                                <div class="text-muted small"><i class="far fa-clock me-1"></i> <fmt:formatDate value="${s.endTime}" pattern="dd/MM/yyyy HH:mm" /></div>
                            </td>
                            <td><fmt:formatNumber value="${s.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></td>
                            <td class="text-end">
                                <button class="btn btn-outline-info btn-action me-1" onclick="prepareEdit('${s.showtimeId}', '${s.movieId}', '${s.roomId}', '${s.startTime}', '${s.endTime}', '${s.price}')">
                                    <i class="fas fa-edit small"></i>
                                </button>
                                <form action="${pageContext.request.contextPath}/admin/showtimes" method="POST" class="d-inline" onsubmit="return confirm('Xóa suất chiếu này?')">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="showtimeId" value="${s.showtimeId}">
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

<!-- Showtime Modal -->
<div class="modal fade" id="showtimeModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <form action="${pageContext.request.contextPath}/admin/showtimes" method="POST" class="modal-content">
            <input type="hidden" name="action" id="modalAction" value="add">
            <input type="hidden" name="showtimeId" id="modalId">
            
            <div class="modal-header border-0 p-4">
                <h5 class="modal-title fw-bold" id="modalTitle">Thêm suất chiếu</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4 pt-0">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label small text-muted fw-bold">ID Phim</label>
                        <input type="number" name="movieId" id="inputMovieId" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small text-muted fw-bold">ID Phòng</label>
                        <input type="number" name="roomId" id="inputRoomId" class="form-control" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label small text-muted fw-bold">Thời gian bắt đầu</label>
                        <input type="datetime-local" name="startTime" id="inputStartTime" class="form-control" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label small text-muted fw-bold">Thời gian kết thúc</label>
                        <input type="datetime-local" name="endTime" id="inputEndTime" class="form-control" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label small text-muted fw-bold">Giá vé (VNĐ)</label>
                        <input type="number" name="price" id="inputPrice" class="form-control" required>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 p-4 pt-0">
                <button type="button" class="btn btn-link text-white text-decoration-none" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" class="btn btn-primary px-4 rounded-3">Lưu suất chiếu</button>
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
