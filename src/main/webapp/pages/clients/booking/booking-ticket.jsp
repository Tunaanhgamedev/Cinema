<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Đặt vé: ${movie.title} | BOBIXI Cinema</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #f59e0b;
            --secondary: #6366f1;
            --bg: #070a12;
            --card-bg: rgba(15, 23, 42, 0.8);
            --seat-free: #1e293b;
            --seat-selected: #f59e0b;
            --seat-booked: #0f172a;
        }

        body {
            background: var(--bg);
            color: #fff;
            font-family: 'Inter', sans-serif;
            margin: 0;
            overflow-x: hidden;
        }

        /* Movie Theme Background */
        .movie-backdrop {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: linear-gradient(to bottom, rgba(7, 10, 18, 0.8), #070a12),
                        url('${pageContext.request.contextPath}/${movie.poster}');
            background-size: cover;
            background-position: center;
            filter: blur(40px);
            z-index: -1;
            transform: scale(1.1);
        }

        .booking-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .booking-header {
            display: flex;
            gap: 30px;
            margin-bottom: 40px;
            align-items: center;
        }

        .movie-mini-poster {
            width: 120px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.5);
        }

        .movie-info h1 {
            margin: 0;
            font-size: 2.5rem;
            font-weight: 900;
            text-transform: uppercase;
            letter-spacing: -1px;
        }

        .movie-meta-chips {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }

        .meta-chip {
            background: rgba(255,255,255,0.1);
            padding: 4px 12px;
            border-radius: 999px;
            font-size: 0.8rem;
            font-weight: 600;
            border: 1px solid rgba(255,255,255,0.1);
        }

        .main-grid {
            display: grid;
            grid-template-columns: 1fr 350px;
            gap: 30px;
        }

        @media (max-width: 1024px) {
            .main-grid { grid-template-columns: 1fr; }
        }

        .glass-card {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 24px;
            padding: 30px;
        }

        /* Screen & Seats */
        .screen-container {
            perspective: 500px;
            margin-bottom: 50px;
            text-align: center;
        }

        .screen-curve {
            height: 10px;
            width: 80%;
            margin: 0 auto;
            background: #fff;
            box-shadow: 0 10px 30px rgba(255,255,255,0.5);
            transform: rotateX(-30deg);
            border-radius: 50%;
        }

        .screen-label {
            margin-top: 20px;
            font-weight: 800;
            color: #64748b;
            letter-spacing: 5px;
            font-size: 0.75rem;
        }

        .seats-layout {
            display: flex;
            flex-direction: column;
            gap: 15px;
            align-items: center;
        }

        .seat-row {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .row-label {
            width: 30px;
            font-weight: 800;
            color: #475569;
            font-size: 0.9rem;
        }

        .seat {
            width: 36px;
            height: 36px;
            background: var(--seat-free);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75rem;
            font-weight: 700;
            cursor: pointer;
            transition: 0.2s;
        }

        .seat:hover:not(.booked):not(.other-selected) {
            background: #334155;
            transform: scale(1.1);
        }

        .seat.selected {
            background: var(--seat-selected);
            color: #000;
            box-shadow: 0 0 15px rgba(245, 158, 11, 0.5);
        }

        .seat.booked {
            background: var(--seat-booked);
            color: #475569;
            cursor: not-allowed;
            border-color: transparent;
        }

        .seat.other-selected {
            background: rgba(255, 165, 0, 0.2);
            border-color: #f59e0b;
            cursor: not-allowed;
            position: relative;
        }

        .seat.other-selected::after {
            content: "\f007";
            font-family: "Font Awesome 5 Free";
            font-weight: 900;
            font-size: 8px;
            position: absolute;
            top: 2px;
            right: 2px;
        }

        /* Summary Sidebar */
        .summary-title {
            font-weight: 800;
            font-size: 1.2rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-size: 0.95rem;
        }

        .summary-label { color: #94a3b8; }
        .summary-value { font-weight: 700; }

        .btn-confirm {
            width: 100%;
            background: linear-gradient(90deg, #f59e0b, #ef4444);
            color: #fff;
            border: none;
            padding: 18px;
            border-radius: 16px;
            font-weight: 900;
            font-size: 1.1rem;
            cursor: pointer;
            margin-top: 20px;
            transition: 0.3s;
            box-shadow: 0 10px 25px -5px rgba(239, 68, 68, 0.4);
        }

        .btn-confirm:hover:not(:disabled) {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px -5px rgba(239, 68, 68, 0.5);
        }

        .btn-confirm:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .legend {
            display: flex;
            gap: 20px;
            justify-content: center;
            margin-top: 40px;
            flex-wrap: wrap;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.85rem;
            color: #94a3b8;
            font-weight: 600;
        }

        .legend-box {
            width: 18px;
            height: 18px;
            border-radius: 4px;
        }

        .alert-error {
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.2);
            color: #fca5a5;
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 20px;
            font-weight: 600;
        }
        
        .selection-panel {
            margin-bottom: 30px;
        }
        
        .form-select-custom {
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
            color: #fff;
            padding: 10px 15px;
            border-radius: 12px;
            width: 100%;
            outline: none;
        }
    </style>
</head>
<body>

    <jsp:include page="/common/header.jsp"/>
    
    <div class="movie-backdrop"></div>

    <div class="booking-container">
        <c:if test="${not empty error}">
            <div class="alert-error"><i class="fas fa-exclamation-circle me-2"></i> ${error}</div>
        </c:if>

        <div class="booking-header">
            <img src="${pageContext.request.contextPath}/${movie.poster}" class="movie-mini-poster" alt="${movie.title}">
            <div class="movie-info">
                <h1>${movie.title}</h1>
                <div class="movie-meta-chips">
                    <span class="meta-chip"><i class="fas fa-star text-warning me-1"></i> ${movie.rating}</span>
                    <span class="meta-chip"><i class="far fa-clock me-1"></i> ${movie.duration} phút</span>
                    <span class="meta-chip"><i class="fas fa-couch me-1"></i> Đà Nẵng</span>
                </div>
            </div>
        </div>

        <div class="main-grid">
            <div class="glass-card">
                <!-- Showtime Selection (Collapsible if showtimeId exists) -->
                <div class="selection-panel" <c:if test="${not empty showtimeId}">style="display:none;"</c:if> id="showtimeCollapse">
                    <h5 class="mb-3 fw-bold">Chọn suất chiếu</h5>
                    <form id="filterForm" method="get">
                        <input type="hidden" name="movieId" value="${movieId}">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="small text-muted mb-2 fw-bold">Ngày chiếu</label>
                                <input type="date" name="showDate" id="showDateInput" class="form-select-custom" value="${showDate}">
                            </div>
                            <div class="col-md-6">
                                <label class="small text-muted mb-2 fw-bold">Suất chiếu</label>
                                <select name="showtimeId" id="showtimeSelect" class="form-select-custom">
                                    <option value="">-- Chọn giờ --</option>
                                    <c:forEach var="st" items="${showtimes}">
                                        <option value="${st.showtimeId}" <c:if test="${showtimeId == st.showtimeId}">selected</c:if>>
                                            <fmt:formatDate value="${st.startTime}" pattern="HH:mm" /> (${st.roomName})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>

                <c:if test="${not empty showtimeId}">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="badge bg-secondary px-3 py-2 rounded-pill">
                            <i class="far fa-clock me-2"></i> 
                            <c:forEach var="st" items="${showtimes}">
                                <c:if test="${st.showtimeId == showtimeId}">
                                    <fmt:formatDate value="${st.startTime}" pattern="HH:mm" /> - ${st.roomName}
                                </c:if>
                            </c:forEach>
                        </div>
                        <button class="btn btn-link text-white text-decoration-none small" onclick="document.getElementById('showtimeCollapse').style.display='block'">
                            Đổi suất chiếu <i class="fas fa-chevron-down ms-1"></i>
                        </button>
                    </div>
                </c:if>

                <div class="screen-container">
                    <div class="screen-curve"></div>
                    <div class="screen-label">MÀN HÌNH</div>
                </div>

                <div class="seats-layout" id="seatGrid">
                    <c:forEach var="r" items="${rows}">
                        <div class="seat-row">
                            <div class="row-label">${r}</div>
                            <c:forEach var="i" begin="1" end="10">
                                <c:set var="code" value="${r}${i}"/>
                                <c:choose>
                                    <c:when test="${bookedMap[code]}">
                                        <div class="seat booked" title="Đã đặt">${code}</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="seat <c:if test='${selectedMap[code]}'>selected</c:if>" 
                                             data-code="${code}" 
                                             onclick="toggleSeat(this)">${code}</div>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <div class="row-label">${r}</div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty showtimeId}">
                        <div class="py-5 text-center text-muted">
                            <i class="fas fa-couch fa-3x mb-3"></i>
                            <p>Vui lòng chọn suất chiếu để xem sơ đồ ghế</p>
                        </div>
                    </c:if>
                </div>

                <div class="legend">
                    <div class="legend-item"><div class="legend-box" style="background: var(--seat-free)"></div> Ghế trống</div>
                    <div class="legend-item"><div class="legend-box" style="background: var(--seat-selected)"></div> Ghế đang chọn</div>
                    <div class="legend-item"><div class="legend-box" style="background: var(--seat-booked)"></div> Đã đặt</div>
                    <div class="legend-item"><div class="legend-box" style="background: rgba(255, 165, 0, 0.4); border: 1px solid orange;"></div> Người khác đang chọn</div>
                </div>
            </div>

            <div class="glass-card h-fit">
                <div class="summary-title">
                    <i class="fas fa-receipt text-primary"></i> TỔNG KẾT ĐẶT VÉ
                </div>
                <form id="bookingForm" method="post" action="${pageContext.request.contextPath}/booking-seat">
                    <input type="hidden" name="showtimeId" value="${showtimeId}">
                    <input type="hidden" name="movieId" value="${movieId}">
                    <input type="hidden" name="showDate" value="${showDate}">
                    
                    <div class="summary-item">
                        <span class="summary-label">Số vé</span>
                        <div class="d-flex align-items-center gap-2">
                            <input type="number" name="ticketQty" id="ticketQty" class="form-select-custom text-center" 
                                   style="width: 60px; padding: 5px;" min="1" max="10" value="${empty ticketQty ? 1 : ticketQty}">
                        </div>
                    </div>
                    
                    <div class="summary-item">
                        <span class="summary-label">Ghế chọn</span>
                        <span class="summary-value text-primary" id="pickedSeatsDisplay">Chưa chọn</span>
                        <div id="seatsInputsContainer"></div>
                    </div>
                    
                    <div class="hr" style="background: rgba(255,255,255,0.1); height: 1px; margin: 20px 0;"></div>
                    
                    <div class="summary-item">
                        <span class="summary-label">Giá mỗi vé</span>
                        <span class="summary-value">
                            <c:forEach var="st" items="${showtimes}">
                                <c:if test="${st.showtimeId == showtimeId}">
                                    <fmt:formatNumber value="${st.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                </c:if>
                            </c:forEach>
                        </span>
                    </div>

                    <div class="summary-item mt-4">
                        <span class="fw-bold fs-5">TỔNG CỘNG</span>
                        <span class="fw-bold fs-4 text-primary" id="totalPriceDisplay">0 ₫</span>
                    </div>

                    <button type="submit" class="btn-confirm" id="btnSubmit" <c:if test="${empty showtimeId}">disabled</c:if>>
                        TIẾP TỤC <i class="fas fa-arrow-right ms-2"></i>
                    </button>
                    
                    <p class="text-muted small text-center mt-3">
                        <i class="fas fa-info-circle me-1"></i> Chỗ ngồi sẽ được giữ trong 10 phút
                    </p>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="/common/footer.jsp" />

    <script>
        const ticketQtyInput = document.getElementById('ticketQty');
        const pickedDisplay = document.getElementById('pickedSeatsDisplay');
        const totalPriceDisplay = document.getElementById('totalPriceDisplay');
        const seatsContainer = document.getElementById('seatsInputsContainer');
        const ticketPrice = ${not empty showtimeId ? showtimes[0].price : 0}; // Demo, nên lấy từ st cụ thể
        
        let selectedSeats = [];

        function toggleSeat(el) {
            const code = el.dataset.code;
            const max = parseInt(ticketQtyInput.value);

            if (selectedSeats.includes(code)) {
                selectedSeats = selectedSeats.filter(s => s !== code);
                el.classList.remove('selected');
            } else {
                if (selectedSeats.length >= max) {
                    alert('Bạn chỉ có thể chọn tối đa ' + max + ' ghế.');
                    return;
                }
                selectedSeats.push(code);
                el.classList.add('selected');
            }
            updateSummary();
        }

        function updateSummary() {
            pickedDisplay.innerText = selectedSeats.length > 0 ? selectedSeats.join(', ') : 'Chưa chọn';
            
            // Cập nhật hidden inputs cho form post
            seatsContainer.innerHTML = '';
            selectedSeats.forEach(s => {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'seats';
                input.value = s;
                seatsContainer.appendChild(input);
            });

            // Cập nhật giá (tạm tính)
            const total = selectedSeats.length * ticketPrice;
            totalPriceDisplay.innerText = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(total);
        }

        // Tự động tải showtimes khi đổi ngày
        document.getElementById('showDateInput').addEventListener('change', () => {
            document.getElementById('filterForm').submit();
        });
        
        document.getElementById('showtimeSelect').addEventListener('change', () => {
            document.getElementById('filterForm').submit();
        });

        // Khởi tạo các ghế đã chọn từ session nếu có
        window.onload = () => {
            <c:forEach var="s" items="${selectedSeats}">
                selectedSeats.push('${s}');
            </c:forEach>
            updateSummary();
        };
    </script>
</body>
</html>
