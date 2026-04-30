<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Đơn hàng | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-style.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
</head>
<body>

<jsp:include page="/common/admin/sidebar.jsp" />

<div class="main-content">
    <div class="d-flex align-items-center gap-3 mb-5">
        <a href="${pageContext.request.contextPath}/admin/bookings" class="btn-action">
            <i class="fas fa-arrow-left"></i>
        </a>
        <c:when test="${empty detail}">
            <div class="alert alert-danger">Không tìm thấy thông tin đơn hàng.</div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="card-glass p-4 mb-4">
                        <h5 class="fw-bold mb-4">Thông tin vé xem phim</h5>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="text-muted small d-block">Phim</label>
                                <div class="fw-bold fs-5">${detail.movieTitle}</div>
                            </div>
                            <div class="col-md-6">
                                <label class="text-muted small d-block">Phòng chiếu</label>
                                <div class="fw-bold fs-5">${detail.roomName}</div>
                            </div>
                            <div class="col-md-6">
                                <label class="text-muted small d-block">Thời gian bắt đầu</label>
                                <div class="fw-bold"><fmt:formatDate value="${detail.startTime}" pattern="dd/MM/yyyy HH:mm" /></div>
                            </div>
                            <div class="col-md-6">
                                <label class="text-muted small d-block">Thời gian kết thúc</label>
                                <div class="fw-bold"><fmt:formatDate value="${detail.endTime}" pattern="dd/MM/yyyy HH:mm" /></div>
                            </div>
                            <div class="col-12 mt-4">
                                <label class="text-muted small d-block mb-2">Danh sách ghế (${detail.seatCount})</label>
                                <div>
                                    <c:forEach var="s" items="${detail.seats}">
                                        <span class="pill-seat">${s}</span>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card-glass p-4">
                        <h5 class="fw-bold mb-4">Combo thực phẩm</h5>
                        <div class="table-responsive">
                            <table class="table table-borderless">
                                <thead class="text-muted small">
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th class="text-center">Số lượng</th>
                                        <th class="text-end">Đơn giá</th>
                                        <th class="text-end">Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="c" items="${detail.combos}">
                                        <tr>
                                            <td class="fw-bold">${c.name}</td>
                                            <td class="text-center">${c.quantity}</td>
                                            <td class="text-end"><fmt:formatNumber value="${c.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></td>
                                            <td class="text-end fw-bold"><fmt:formatNumber value="${c.lineTotal}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty detail.combos}">
                                        <tr><td colspan="4" class="text-center text-muted small py-3">Không có combo đính kèm</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="card-glass p-4 mb-4">
                        <h5 class="fw-bold mb-4">Khách hàng</h5>
                        <div class="d-flex align-items-center mb-3">
                            <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 48px; height: 48px;">
                                <i class="fas fa-user text-white"></i>
                            </div>
                            <div>
                                <div class="fw-bold">${detail.fullName}</div>
                                <div class="text-muted small">${detail.email}</div>
                            </div>
                        </div>
                    </div>

                    <div class="card-glass p-4">
                        <h5 class="fw-bold mb-4">Tổng kết chi phí</h5>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Tiền vé</span>
                            <span><fmt:formatNumber value="${detail.ticketSubtotal}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></span>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Tiền Combo</span>
                            <span><fmt:formatNumber value="${detail.comboSubtotal}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></span>
                        </div>
                        <hr class="border-light opacity-25">
                        <div class="d-flex justify-content-between align-items-center mt-3 mb-4">
                            <span class="fw-bold">TỔNG CỘNG</span>
                            <span class="fw-bold fs-4 text-primary"><fmt:formatNumber value="${detail.grandTotal}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></span>
                        </div>
                        
                        <label class="small text-muted fw-bold mb-2 d-block">Trạng thái đơn hàng</label>
                        <form action="${pageContext.request.contextPath}/admin/bookings" method="POST">
                            <input type="hidden" name="action" value="status">
                            <input type="hidden" name="bookingId" value="${detail.bookingId}">
                            <div class="d-flex gap-2">
                                <select name="status" class="form-select">
                                    <option value="PENDING" ${detail.status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                                    <option value="PAID" ${detail.status == 'PAID' ? 'selected' : ''}>PAID</option>
                                    <option value="CANCELLED" ${detail.status == 'CANCELLED' ? 'selected' : ''}>CANCELLED</option>
                                </select>
                                <button type="submit" class="btn btn-success px-3">Lưu</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
