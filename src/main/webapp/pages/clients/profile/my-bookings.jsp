<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Vé của tôi | BOBIXI Cinema</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { --primary: #e71a0f; --bg: #070a12; --card: rgba(255,255,255,0.05); }
        body { background: var(--bg); color: #fff; font-family: 'Inter', sans-serif; margin: 0; }
        .page-container { max-width: 1000px; margin: 50px auto; padding: 0 20px; }
        .page-title { font-size: 2.5rem; font-weight: 900; margin-bottom: 40px; text-align: center; color: var(--primary); }
        
        .booking-list { display: grid; gap: 20px; }
        .booking-card { 
            background: var(--card); 
            border: 1px solid rgba(255,255,255,0.1); 
            border-radius: 20px; 
            padding: 24px; 
            display: flex; 
            gap: 24px; 
            transition: 0.3s;
            backdrop-filter: blur(10px);
        }
        .booking-card:hover { transform: translateY(-5px); border-color: var(--primary); }
        
        .movie-thumb { width: 120px; height: 180px; border-radius: 12px; object-fit: cover; }
        .booking-info { flex: 1; }
        .movie-name { font-size: 1.5rem; font-weight: 800; margin: 0 0 10px; }
        .detail-row { display: flex; gap: 20px; margin-bottom: 10px; font-size: 0.9rem; color: #94a3b8; }
        .detail-item b { color: #fff; margin-left: 5px; }
        
        .status-badge { 
            padding: 6px 16px; 
            border-radius: 999px; 
            font-size: 0.75rem; 
            font-weight: 800; 
            text-transform: uppercase;
        }
        .status-valid { background: rgba(34, 197, 94, 0.1); color: #22c55e; border: 1px solid rgba(34, 197, 94, 0.2); }
        .status-expired { background: rgba(239, 68, 68, 0.1); color: #ef4444; border: 1px solid rgba(239, 68, 68, 0.2); }
        
        .qr-side { display: flex; flex-direction: column; align-items: center; gap: 10px; }
        .mini-qr { background: #fff; padding: 5px; border-radius: 8px; width: 100px; height: 100px; }
        
        .empty-state { text-align: center; padding: 100px 0; opacity: 0.5; }
        .empty-state i { font-size: 4rem; margin-bottom: 20px; }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp"/>
    
    <div class="page-container">
        <h1 class="page-title">VÉ ĐÃ MUA</h1>
        
        <div class="booking-list">
            <c:forEach var="b" items="${bookings}">
                <div class="booking-card">
                    <img src="${pageContext.request.contextPath}/${b.moviePoster}" class="movie-thumb" alt="${b.movieTitle}">
                    
                    <div class="booking-info">
                        <div class="movie-name">${b.movieTitle}</div>
                        
                        <div class="detail-row">
                            <span class="detail-item"><i class="far fa-calendar-alt"></i> Ngày: <b><fmt:formatDate value="${b.startTime}" pattern="dd/MM/yyyy"/></b></span>
                            <span class="detail-item"><i class="far fa-clock"></i> Giờ: <b><fmt:formatDate value="${b.startTime}" pattern="HH:mm"/> - <fmt:formatDate value="${b.endTime}" pattern="HH:mm"/></b></span>
                        </div>
                        
                        <div class="detail-row">
                            <span class="detail-item"><i class="fas fa-couch"></i> Ghế: <b>${b.seats}</b></span>
                            <span class="detail-item"><i class="fas fa-door-open"></i> Phòng: <b>${b.roomName}</b></span>
                        </div>
                        
                        <div class="detail-row" style="margin-top: 15px;">
                            <c:choose>
                                <c:when test="${b.endTime.time > now.time}">
                                    <span class="status-badge status-valid">CÒN HẠN SỬ DỤNG</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-expired">HẾT HẠN</span>
                                </c:otherwise>
                            </c:choose>
                            <span class="ms-3 small text-muted">Mã vé: # ${b.bookingId}</span>
                        </div>
                    </div>
                    
                    <div class="qr-side">
                        <img src="https://chart.googleapis.com/chart?chs=100x100&cht=qr&chl=BOBIXI-${b.bookingId}" class="mini-qr" alt="QR">
                        <span class="small" style="font-size: 10px; font-weight: 800; opacity: 0.6;">QUÉT VÀO RẠP</span>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty bookings}">
                <div class="empty-state">
                    <i class="fas fa-ticket-alt"></i>
                    <h2>Bạn chưa có tấm vé nào</h2>
                    <p>Hãy chọn phim và trải nghiệm những phút giây giải trí tuyệt vời!</p>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary mt-3">ĐẶT VÉ NGAY</a>
                </div>
            </c:if>
        </div>
    </div>

    <jsp:include page="/common/footer.jsp"/>
</body>
</html>
