<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${movie.title} | BOBIXI Cinema</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css" />
    <style>
        .mv-detail {
            background: radial-gradient(1200px 600px at 20% 0%, rgba(139,92,246,.38), transparent 55%),
                        radial-gradient(900px 520px at 100% 20%, rgba(34,211,238,.30), transparent 55%),
                        radial-gradient(800px 520px at 40% 100%, rgba(251,191,36,.22), transparent 60%),
                        #0b1020;
            color:#f4f6fb; min-height:100vh; padding: 18px 0 50px;
        }
        .mv-container { max-width: 1150px; margin:0 auto; padding: 0 14px; }
        .mv-topbar { display:flex; align-items:center; justify-content:space-between; gap: 10px; flex-wrap:wrap; margin-bottom: 12px; }
        .mv-link { display:inline-flex; align-items:center; gap:8px; padding:10px 14px; border-radius: 16px; border:1px solid rgba(255,255,255,.16); background: rgba(255,255,255,.08); color:#f4f6fb; text-decoration:none; font-weight:800; transition:.18s ease; }
        .mv-card { border:1px solid rgba(255,255,255,.16); background: rgba(255,255,255,0.05); backdrop-filter: blur(20px); border-radius: 22px; box-shadow: 0 18px 40px rgba(0,0,0,.35); overflow:hidden; }
        .mv-main { display:grid; grid-template-columns: 360px 1fr; gap: 30px; padding: 30px; }
        @media(max-width: 920px) { .mv-main { grid-template-columns: 1fr; } }
        .mv-poster { border-radius: 18px; overflow:hidden; border:1px solid rgba(255,255,255,.14); background: rgba(0,0,0,.22); box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
        .mv-poster img { width:100%; height:auto; display:block; }
        .mv-title { margin:0; font-weight: 950; font-size: 2.5rem; letter-spacing:.2px; background: linear-gradient(to right, #fff, #9ca3af); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .mv-tags { margin-top: 15px; display:flex; gap:10px; flex-wrap:wrap; }
        .tag { padding: 6px 14px; border-radius: 999px; border:1px solid rgba(255,255,255,.16); background: rgba(255,255,255,.08); font-weight: 800; font-size: .85rem; color: rgba(244,246,251,.88); }
        .mv-table { margin-top: 20px; border:1px solid rgba(255,255,255,.14); border-radius: 18px; overflow:hidden; background: rgba(0,0,0,0.2); }
        .mv-table table { width:100%; border-collapse: collapse; }
        .mv-table td { padding: 12px 16px; border-bottom: 1px solid rgba(255,255,255,.10); }
        .mv-table td.label { width: 140px; color: rgba(244,246,251,.5); font-weight: 600; text-transform: uppercase; font-size: 0.75rem; }
        .mv-table td.value { color: #fff; font-weight: 500; }
        .mv-actions { margin-top: 25px; display:flex; gap: 15px; }
        .btn-buy { flex: 1; background: linear-gradient(90deg, #f59e0b, #ef4444); color: #fff; border: none; padding: 15px; border-radius: 14px; font-weight: 900; text-align: center; text-decoration: none; box-shadow: 0 10px 20px -5px rgba(245, 158, 11, 0.4); transition: 0.3s; }
        .btn-buy:hover { transform: translateY(-3px); box-shadow: 0 15px 25px -5px rgba(245, 158, 11, 0.5); }
        .mv-tabs { margin-top: 20px; padding: 0 30px 30px; }
        .tab-head { display:flex; gap: 10px; margin-bottom: 20px; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 10px; }
        .tab-btn { background: none; border: none; color: #9ca3af; font-weight: 700; padding: 10px 20px; cursor: pointer; position: relative; }
        .tab-btn.active { color: #fff; }
        .tab-btn.active::after { content: ''; position: absolute; bottom: -11px; left: 0; width: 100%; height: 3px; background: #6366f1; border-radius: 3px; }
        .tab-pane { display:none; line-height: 1.8; color: #d1d5db; }
        .tab-pane.active { display:block; }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp"/>
    <div class="mv-detail">
        <div class="mv-container">
            <div class="mv-topbar">
                <a class="mv-link" href="${pageContext.request.contextPath}/movie">
                    <i class="fas fa-chevron-left"></i> Danh sách phim
                </a>
            </div>
            <div class="mv-card">
                <div class="mv-main">
                    <div class="mv-poster">
                        <img src="${pageContext.request.contextPath}/${movie.poster}" 
                             alt="${movie.title}" 
                             onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie.jpg'">
                    </div>
                    <div>
                        <h1 class="mv-title">${movie.title}</h1>
                        <div class="mv-tags">
                            <span class="tag"><i class="fas fa-star text-warning me-1"></i> ${movie.rating}</span>
                            <span class="tag"><i class="far fa-clock me-1"></i> ${movie.duration} phút</span>
                            <span class="tag"><i class="fas fa-video me-1"></i> ${movie.status == 'NOW_SHOWING' ? 'Đang chiếu' : 'Sắp chiếu'}</span>
                        </div>
                        <div class="mv-table">
                            <table>
                                <tbody>
                                    <tr><td class="label">Khởi chiếu</td><td class="value"><fmt:formatDate value="${movie.releaseDate}" pattern="dd/MM/yyyy" /></td></tr>
                                    <tr><td class="label">Ngôn ngữ</td><td class="value">Tiếng Việt / Phụ đề</td></tr>
                                    <tr><td class="label">Định dạng</td><td class="value">2D / Digital</td></tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="mv-actions">
                            <a class="btn-buy" href="${pageContext.request.contextPath}/showtime?movieId=${movie.movieId}">
                                <i class="fas fa-ticket-alt me-2"></i> ĐẶT VÉ NGAY
                            </a>
                        </div>
                    </div>
                </div>
                <div class="mv-tabs">
                    <div class="tab-head">
                        <button class="tab-btn active" data-tab="synopsis">NỘI DUNG PHIM</button>
                        <button class="tab-btn" data-tab="schedule">LỊCH CHIẾU</button>
                    </div>
                    <div id="tab-synopsis" class="tab-pane active">
                        ${movie.description}
                    </div>
                    <div id="tab-schedule" class="tab-pane">
                        <div class="d-flex gap-3 flex-wrap">
                            <c:forEach var="st" items="${showtimes}">
                                <a href="${pageContext.request.contextPath}/booking-seat?showtimeId=${st.showtimeId}" 
                                   class="btn-buy" style="max-width: 120px; padding: 10px; font-size: 0.9rem;">
                                    <fmt:formatDate value="${st.startTime}" pattern="HH:mm" /><br>
                                    <span style="font-size: 0.7rem; opacity: 0.8;">${st.roomName}</span>
                                </a>
                            </c:forEach>
                            <c:if test="${empty showtimes}">
                                <p class="text-muted italic">Hiện chưa có suất chiếu cho phim này trong ngày hôm nay.</p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/common/footer.jsp"/>
    <script>
        document.querySelectorAll('.tab-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
                document.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));
                const tab = btn.getAttribute('data-tab');
                document.getElementById('tab-' + tab).classList.add('active');
            });
        });
    </script>
</body>
</html>
