<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>BOBIXI Cinema</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.css" />
</head>

<body>

    <jsp:include page="/common/header.jsp" />

    <!-- HERO WOW -->
    <section class="hero-wow">
        <div class="hero-bg"></div>
        <div class="container hero-inner">
            <div class="hero-left">
                <div class="hero-badge">🎬 BOBIXI Cinemas</div>
                <h1 class="hero-title">
                    Đặt vé xem phim <span>nhanh</span> – <span>đẹp</span>
                </h1>
                <p class="hero-sub">
                    Chọn phim, chọn suất, chọn ghế trong vài giây.
                </p>

                <div class="hero-actions">
                    <a href="#nowshowing" class="btn-neon">Xem phim đang chiếu</a>
                    <a href="${pageContext.request.contextPath}/pages/clients/booking-seat" class="btn-ghost">Đặt vé ngay</a>
                </div>

                <div class="hero-stats">
                    <div class="stat">
                        <div class="stat-num">50+</div>
                        <div class="stat-text">Suất chiếu mỗi ngày</div>
                    </div>
                    <div class="stat">
                        <div class="stat-num">4K</div>
                        <div class="stat-text">Phòng chiếu hiện đại</div>
                    </div>
                    <div class="stat">
                        <div class="stat-num">24/7</div>
                        <div class="stat-text">Hỗ trợ khách hàng</div>
                    </div>
                </div>
            </div>

            <div class="hero-right">
                <div class="poster-card">
                    <div class="poster-shine"></div>
                    <img src="${pageContext.request.contextPath}/assets/images/movies/avg.jpg" alt="Poster">
                    <div class="poster-info">
                        <div class="poster-name">Movie Highlight</div>
                        <div class="poster-meta">Trailer • Hot • Ưu đãi</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Nếu bạn vẫn muốn banner cũ thì để lại, không muốn thì xoá -->
    <jsp:include page="/common/banner.jsp" />

    <!-- NOW SHOWING (DYNAMIC BY SCHEDULE) -->
    <section class="home-section wow-section" id="nowshowing">
        <div class="section-head">
            <h2 class="section-title">LỊCH CHIẾU HÔM NAY</h2>
            <div class="section-line"></div>
        </div>

        <div class="movie-grid wow-grid">
            <c:forEach var="m" items="${moviesToday}">
                <div class="movie-item wow-card">
                    <div class="movie-poster">
                        <img src="${pageContext.request.contextPath}/${m.poster}" alt="${m.title}">
                        <c:if test="${m.rating >= 9}">
                            <span class="movie-badge">HOT</span>
                        </c:if>
                    </div>
                    <div class="movie-body">
                        <h3>${m.title}</h3>
                        <div class="movie-meta">${m.duration} phút • ${m.rating}/10</div>
                        
                        <div class="quick-times mt-3 mb-3">
                            <label class="small text-muted d-block mb-2">Suất chiếu:</label>
                            <div class="d-flex flex-wrap gap-1">
                                <c:forEach var="st" items="${m.showtimes}">
                                    <a href="${pageContext.request.contextPath}/booking-seat?showtimeId=${st.showtimeId}" 
                                       class="badge text-decoration-none" 
                                       style="background: rgba(34,211,238,0.1); color: #22d3ee; border: 1px solid rgba(34,211,238,0.2); padding: 6px 8px;">
                                        <fmt:formatDate value="${st.startTime}" pattern="HH:mm" />
                                    </a>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="movie-actions">
                            <a href="${pageContext.request.contextPath}/movie?id=${m.movieId}" class="btn-trailer w-100 text-center">Chi tiết phim</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty moviesToday}">
                <div class="col-12 text-center py-5">
                    <p class="text-muted">Hôm nay hiện chưa có suất chiếu nào. Vui lòng quay lại sau!</p>
                </div>
            </c:if>
        </div>
    </section>

    <button id="backToTop" class="back-to-top-btn" type="button" aria-label="Lên đầu trang">↑</button>

    <jsp:include page="/common/footer.jsp" />

    <script>
 // Hiện card khi scroll
    const cards = document.querySelectorAll(".wow-card");
    const obs = new IntersectionObserver((entries) => {
      entries.forEach(e => {
        if (e.isIntersecting) e.target.classList.add("show");
      });
    }, { threshold: 0.15 });

    cards.forEach(c => obs.observe(c));

    // Nút lên đầu trang
    const btn = document.getElementById("backToTop");
    window.addEventListener("scroll", () => {
      if (window.scrollY > 350) btn.classList.add("show");
      else btn.classList.remove("show");
    });
    btn?.addEventListener("click", () => {
      window.scrollTo({ top: 0, behavior: "smooth" });
    });

    </script>
</body>
</html>
