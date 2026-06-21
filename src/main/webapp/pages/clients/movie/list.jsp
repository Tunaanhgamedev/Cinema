<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>PHIM | BOBIXI Cinema</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background: #0b0f19; color: #fff; }
        .movie-page { padding: 40px 0; }
        .movie-container { max-width: 1200px; margin: 0 auto; padding: 0 16px; }
        .movie-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; }
        .movie-title { font-size: 2.5rem; font-weight: 900; background: linear-gradient(to right, #f59e0b, #ef4444); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .movie-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 30px; }
        .movie-card { background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 20px; overflow: hidden; transition: 0.4s; position: relative; }
        .movie-card:hover { transform: translateY(-10px); border-color: #f59e0b; box-shadow: 0 15px 35px rgba(245, 158, 11, 0.2); }
        .poster-wrapper { position: relative; aspect-ratio: 2/3; overflow: hidden; }
        .movie-card img { width: 100%; height: 100%; object-fit: cover; transition: 0.4s; }
        .movie-card:hover img { scale: 1.05; }
        .movie-overlay { position: absolute; inset: 0; background: linear-gradient(to top, rgba(0,0,0,0.9), transparent); opacity: 0; transition: 0.3s; display: flex; align-items: flex-end; padding: 20px; }
        .movie-card:hover .movie-overlay { opacity: 1; }
        .movie-body { padding: 20px; }
        .movie-name { font-size: 1.25rem; font-weight: 800; margin-bottom: 8px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .movie-meta { font-size: 0.85rem; color: #9ca3af; display: flex; gap: 15px; margin-bottom: 15px; }
        .movie-actions { display: flex; gap: 10px; }
        .btn-action { flex: 1; padding: 10px; border-radius: 12px; text-decoration: none; font-weight: 700; font-size: 0.9rem; text-align: center; transition: 0.2s; }
        .btn-detail { background: rgba(255,255,255,0.1); color: #fff; border: 1px solid rgba(255,255,255,0.1); }
        .btn-detail:hover { background: rgba(255,255,255,0.2); }
        .btn-book { background: #f59e0b; color: #000; }
        .btn-book:hover { background: #d97706; }
        .badge-status { position: absolute; top: 15px; right: 15px; padding: 5px 12px; border-radius: 999px; font-size: 0.7rem; font-weight: 900; z-index: 2; backdrop-filter: blur(10px); }
        .bg-now { background: rgba(16, 185, 129, 0.9); color: #fff; }
        .bg-soon { background: rgba(245, 158, 11, 0.9); color: #fff; }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp"/>
    <div class="movie-page">
        <div class="movie-container">
            <div class="movie-header">
                <h1 class="movie-title">PHIM ĐANG CHIẾU</h1>
                <a href="${pageContext.request.contextPath}/showtime" class="btn-action btn-book px-4">XEM LỊCH CHIẾU</a>
            </div>
            <c:choose>
                <c:when test="${not empty movies}">
                    <div class="movie-grid">
                        <c:forEach items="${movies}" var="m">
                            <div class="movie-card">
                                <span class="badge-status ${m.status == 'NOW_SHOWING' ? 'bg-now' : 'bg-soon'}">
                                    ${m.status == 'NOW_SHOWING' ? 'ĐANG CHIẾU' : 'SẮP CHIẾU'}
                                </span>
                                <div class="poster-wrapper">
                                    <img src="${pageContext.request.contextPath}/${m.poster}" 
                                         alt="${m.title}" 
                                         onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie.jpg'">
                                    <div class="movie-overlay">
                                        <a href="${pageContext.request.contextPath}/movie?id=${m.movieId}" class="btn-action btn-book w-100">XEM CHI TIẾT</a>
                                    </div>
                                </div>
                                <div class="movie-body">
                                    <h3 class="movie-name" title="${m.title}">${m.title}</h3>
                                    <div class="movie-meta">
                                        <span><i class="far fa-clock me-1 text-warning"></i> ${m.duration}m</span>
                                        <span><i class="fas fa-star me-1 text-warning"></i> ${m.rating}</span>
                                    </div>
                                    <div class="movie-actions">
                                        <a class="btn-action btn-detail" href="${pageContext.request.contextPath}/movie?id=${m.movieId}">CHI TIẾT</a>
                                        <a class="btn-action btn-book" href="${pageContext.request.contextPath}/showtime?movieId=${m.movieId}">ĐẶT VÉ</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5">
                        <i class="fas fa-film fa-4x text-muted mb-4"></i>
                        <p class="text-muted">Hiện chưa có phim nào trong danh sách. Vui lòng quay lại sau!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <jsp:include page="/common/footer.jsp"/>
</body>
</html>
