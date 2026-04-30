<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="booking-confirmation-page">
    <div class="confirmation-container">
        <!-- Success Animation -->
        <div class="success-animation">
            <div class="checkmark-circle">
                <div class="checkmark"></div>
            </div>
            <h1>Đặt vé thành công!</h1>
            <p class="thank-you-message">Cảm ơn bạn đã đặt vé tại BOBIXI Cinemas</p>
        </div>
        
        <!-- Booking Information -->
        <div class="booking-info-card">
            <div class="card-header">
                <h2>Thông tin đặt vé</h2>
                <span class="booking-code">${booking.bookingCode}</span>
            </div>
            
            <div class="card-body">
                <div class="booking-details">
                    <!-- Movie Info -->
                    <div class="detail-section movie-section">
                        <img src="${pageContext.request.contextPath}/assets/images/movies/${booking.movie.posterImage}" 
                             alt="${booking.movie.title}" 
                             class="movie-poster" />
                        <div class="movie-info">
                            <h3>${booking.movie.title}</h3>
                            <div class="movie-meta">
                                <span class="rating-badge rating-${booking.movie.rating}">
                                    ${booking.movie.rating}
                                </span>
                                <span>${booking.movie.duration} phút</span>
                                <span>${booking.movie.genre}</span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Cinema & Showtime Info -->
                    <div class="detail-section">
                        <div class="detail-row">
                            <i class="icon-cinema"></i>
                            <div>
                                <strong>Rạp chiếu</strong>
                                <p>${booking.cinema.name}</p>
                            </div>
                        </div>
                        
                        <div class="detail-row">
                            <i class="icon-screen"></i>
                            <div>
                                <strong>Phòng chiếu</strong>
                                <p>${booking.screenRoom.name}</p>
                            </div>
                        </div>
                        
                        <div class="detail-row">
                            <i class="icon-calendar"></i>
                            <div>
                                <strong>Ngày chiếu</strong>
                                <p><fmt:formatDate value="${booking.showDate}" pattern="EEEE, dd/MM/yyyy"/></p>
                            </div>
                        </div>
                        
                        <div class="detail-row">
                            <i class="icon-clock"></i>
                            <div>
                                <strong>Suất chiếu</strong>
                                <p>
                                    <fmt:formatDate value="${booking.startTime}" pattern="HH:mm"/> - 
                                    <fmt:formatDate value="${booking.endTime}" pattern="HH:mm"/>
                                </p>
                            </div>
                        </div>
                        
                        <div class="detail-row">
                            <i class="icon-seat"></i>
                            <div>
                                <strong>Ghế ngồi</strong>
                                <p>${booking.seatNames}</p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Combo Info -->
                    <c:if test="${not empty booking.combos}">
                        <div class="detail-section">
                            <div class="detail-row">
                                <i class="icon-food"></i>
                                <div>
                                    <strong>Bắp nước</strong>
                                    <c:forEach items="${booking.combos}" var="combo">
                                        <p>${combo.name} x${combo.quantity}</p>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    
                    <!-- Payment Info -->
                    <div class="detail-section payment-section">
                        <div class="detail-row">
                            <i class="icon-payment"></i>
                            <div>
                                <strong>Phương thức thanh toán</strong>
                                <p>${booking.paymentMethod}</p>
                            </div>
                        </div>
                        
                        <div class="total-amount">
                            <span>Tổng tiền</span>
                            <strong class="amount">
                                <fmt:formatNumber value="${booking.totalPrice}" type="currency" currencyCode="VND"/>
                            </strong>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- QR Code Section -->
        <div class="qr-code-section">
            <h3>Mã QR của bạn</h3>
            <p class="qr-instruction">Xuất trình mã này tại quầy vé để nhận vé</p>
            
            <div class="qr-code-container">
                <img src="${booking.qrCodeUrl}" alt="QR Code" class="qr-code" />
                <p class="booking-code-text">Mã đặt vé: <strong>${booking.bookingCode}</strong></p>
            </div>
            
            <div class="qr-actions">
                <button type="button" class="btn-download" onclick="downloadTicket()">
                    <i class="icon-download"></i>
                    Tải vé PDF
                </button>
                <button type="button" class="btn-email" onclick="emailTicket()">
                    <i class="icon-email"></i>
                    Gửi email
                </button>
                <button type="button" class="btn-sms" onclick="smsTicket()">
                    <i class="icon-sms"></i>
                    Gửi SMS
                </button>
            </div>
        </div>
        
        <!-- Important Notes -->
        <div class="important-notes">
            <h3>
                <i class="icon-info"></i>
                Lưu ý quan trọng
            </h3>
            <ul>
                <li>Vui lòng đến rạp trước giờ chiếu <strong>15 phút</strong> để nhận vé và vào phòng</li>
                <li>Xuất trình mã QR hoặc mã đặt vé tại quầy để nhận vé</li>
                <li>Vé không được hoàn trả sau khi đã thanh toán thành công</li>
                <li>Không mang thức ăn, đồ uống từ bên ngoài vào rạp</li>
                <li>Giữ gìn vệ sinh và trật tự trong rạp</li>
            </ul>
        </div>
        
        <!-- Action Buttons -->
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/my-tickets" class="btn-view-tickets">
                <i class="icon-ticket"></i>
                Xem vé của tôi
            </a>
            <a href="${pageContext.request.contextPath}/movies/now-showing" class="btn-continue">
                <i class="icon-film"></i>
                Tiếp tục đặt vé
            </a>
            <a href="${pageContext.request.contextPath}/" class="btn-home">
                <i class="icon-home"></i>
                Về trang chủ
            </a>
        </div>
        
        <!-- Recommendations -->
        <div class="recommendations-section">
            <h3>Phim đề xuất cho bạn</h3>
            <div class="movies-slider">
                <c:forEach items="${recommendedMovies}" var="movie">
                    <div class="movie-card">
                        <a href="${pageContext.request.contextPath}/movies/${movie.slug}">
                            <img src="${pageContext.request.contextPath}/resources/images/movies/${movie.posterImage}" 
                                 alt="${movie.title}" />
                            <h4>${movie.title}</h4>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    function downloadTicket() {
        window.location.href = '${pageContext.request.contextPath}/tickets/${booking.id}/download';
    }
    
    function emailTicket() {
        $j.ajax({
            url: '${pageContext.request.contextPath}/tickets/${booking.id}/email',
            type: 'POST',
            data: { ${_csrf.parameterName}: '${_csrf.token}' },
            success: function(response) {
                if (response.success) {
                    alert('Vé đã được gửi đến email của bạn.');
                } else {
                    alert(response.message || 'Có lỗi xảy ra. Vui lòng thử lại.');
                }
            },
            error: function() {
                alert('Có lỗi xảy ra. Vui lòng thử lại.');
            }
        });
    }
    
    function smsTicket() {
        $j.ajax({
            url: '${pageContext.request.contextPath}/tickets/${booking.id}/sms',
            type: 'POST',
            data: { ${_csrf.parameterName}: '${_csrf.token}' },
            success: function(response) {
                if (response.success) {
                    alert('Thông tin vé đã được gửi qua SMS.');
                } else {
                    alert(response.message || 'Có lỗi xảy ra. Vui lòng thử lại.');
                }
            },
            error: function() {
                alert('Có lỗi xảy ra. Vui lòng thử lại.');
            }
        });
    }
    
    // Print page
    function printTicket() {
        window.print();
    }
    
    // Success animation
    $j(document).ready(function() {
        $j('.checkmark').addClass('animate');
    });
</script>

<style>
    .booking-confirmation-page {
        min-height: 100vh;
        background: #f5f5f5;
        padding: 40px 20px;
    }
    
    .confirmation-container {
        max-width: 900px;
        margin: 0 auto;
    }
    
    .success-animation {
        text-align: center;
        margin-bottom: 40px;
    }
    
    .checkmark-circle {
        width: 120px;
        height: 120px;
        margin: 0 auto 30px;
        border-radius: 50%;
        background: #4CAF50;
        position: relative;
        animation: scaleIn 0.5s ease-in-out;
    }
    
    @keyframes scaleIn {
        from { transform: scale(0); }
        to { transform: scale(1); }
    }
    
    .checkmark {
        width: 60px;
        height: 30px;
        border-left: 8px solid #fff;
        border-bottom: 8px solid #fff;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -60%) rotate(-45deg);
        opacity: 0;
    }
    
    .checkmark.animate {
        animation: checkmark 0.5s 0.3s ease-in-out forwards;
    }
    
    @keyframes checkmark {
        to { opacity: 1; }
    }
    
    .success-animation h1 {
        font-size: 36px;
        color: #4CAF50;
        margin-bottom: 15px;
    }
    
    .thank-you-message {
        font-size: 18px;
        color: #666;
    }
    
    .booking-info-card {
        background: #fff;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        margin-bottom: 30px;
        overflow: hidden;
    }
    
    .card-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: #fff;
        padding: 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .card-header h2 {
        font-size: 24px;
        margin: 0;
    }
    
    .booking-code {
        font-size: 20px;
        font-weight: bold;
        padding: 10px 20px;
        background: rgba(255,255,255,0.2);
        border-radius: 20px;
    }
    
    .card-body {
        padding: 40px;
    }
    
    .detail-section {
        margin-bottom: 30px;
        padding-bottom: 30px;
        border-bottom: 1px solid #eee;
    }
    
    .detail-section:last-child {
        border-bottom: none;
    }
    
    .movie-section {
        display: flex;
        gap: 25px;
    }
    
    .movie-poster {
        width: 120px;
        border-radius: 10px;
    }
    
    .movie-info h3 {
        font-size: 24px;
        margin-bottom: 10px;
    }
    
    .movie-meta {
        display: flex;
        gap: 15px;
        flex-wrap: wrap;
    }
    
    .detail-row {
        display: flex;
        gap: 20px;
        margin-bottom: 20px;
        align-items: flex-start;
    }
    
    .detail-row i {
        font-size: 24px;
        color: #e71a0f;
    }
    
    .detail-row strong {
        display: block;
        margin-bottom: 5px;
        color: #333;
    }
    
    .detail-row p {
        color: #666;
        line-height: 1.6;
    }
    
    .total-amount {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 20px;
        background: #f8f8f8;
        border-radius: 10px;
        margin-top: 20px;
        font-size: 20px;
    }
    
    .total-amount .amount {
        color: #e71a0f;
        font-size: 28px;
    }
    
    .qr-code-section {
        background: #fff;
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        text-align: center;
        margin-bottom: 30px;
    }
    
    .qr-code-section h3 {
        font-size: 24px;
        margin-bottom: 15px;
    }
    
    .qr-instruction {
        color: #666;
        margin-bottom: 30px;
    }
    
    .qr-code-container {
        display: inline-block;
        padding: 30px;
        background: #f8f8f8;
        border-radius: 15px;
        margin-bottom: 30px;
    }
    
    .qr-code {
        width: 250px;
        height: 250px;
        margin-bottom: 15px;
    }
    
    .booking-code-text {
        font-size: 16px;
        color: #333;
    }
    
    .qr-actions {
        display: flex;
        gap: 15px;
        justify-content: center;
        flex-wrap: wrap;
    }
    
    .btn-download,
    .btn-email,
    .btn-sms {
        padding: 12px 25px;
        border: none;
        border-radius: 25px;
        font-weight: bold;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s;
    }
    
    .btn-download {
        background: #4CAF50;
        color: #fff;
    }
    
    .btn-email {
        background: #2196F3;
        color: #fff;
    }
    
    .btn-sms {
        background: #FF9800;
        color: #fff;
    }
    
    .important-notes {
        background: #fff3cd;
        border: 1px solid #ffc107;
        padding: 30px;
        border-radius: 15px;
        margin-bottom: 30px;
    }
    
    .important-notes h3 {
        color: #856404;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .important-notes ul {
        list-style-position: inside;
        color: #856404;
        line-height: 2;
    }
    
    .action-buttons {
        display: flex;
        gap: 15px;
        justify-content: center;
        margin-bottom: 40px;
        flex-wrap: wrap;
    }
    
    .btn-view-tickets,
    .btn-continue,
    .btn-home {
        padding: 15px 30px;
        border-radius: 30px;
        text-decoration: none;
        font-weight: bold;
        display: flex;
        align-items: center;
        gap: 10px;
        transition: all 0.3s;
    }
    
    .btn-view-tickets {
        background: #e71a0f;
        color: #fff;
    }
    
    .btn-continue {
        background: #4CAF50;
        color: #fff;
    }
    
    .btn-home {
        background: #f5f5f5;
        color: #333;
    }
    
    .recommendations-section {
        background: #fff;
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    }
    
    .recommendations-section h3 {
        font-size: 24px;
        margin-bottom: 30px;
    }
    
    .movies-slider {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
        gap: 20px;
    }
    
    .movie-card img {
        width: 100%;
        border-radius: 10px;
        margin-bottom: 10px;
    }
    
    .movie-card h4 {
        font-size: 14px;
        color: #333;
    }
    
    @media (max-width: 768px) {
        .movie-section {
            flex-direction: column;
        }
        
        .card-header {
            flex-direction: column;
            gap: 15px;
            text-align: center;
        }
        
        .action-buttons {
            flex-direction: column;
        }
        
        .btn-view-tickets,
        .btn-continue,
        .btn-home {
            width: 100%;
            justify-content: center;
        }
    }
</style>