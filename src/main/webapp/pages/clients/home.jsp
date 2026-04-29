<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

    <!-- NOW SHOWING -->
    <section class="home-section wow-section" id="nowshowing">
        <div class="section-head">
            <h2 class="section-title">PHIM ĐANG CHIẾU</h2>
            <div class="section-line"></div>
        </div>

        <div class="movie-grid wow-grid">
            <div class="movie-item wow-card">
                <div class="movie-poster">
                    <img src="${pageContext.request.contextPath}/assets/images/movies/movie1.jpg" alt="Avengers">
                    <span class="movie-badge">HOT</span>
                </div>
                <div class="movie-body">
                    <h3>Avengers: Endgame</h3>
                    <div class="movie-meta">Hành động • 120 phút • 9.1/10</div>
                    <div class="movie-actions">
                        <a href="#" class="btn-buy btn-wow">Mua vé</a>
                        <a href="https://youtu.be/TcMBFSGVi1c?si=xC_nSgqxLovxX6ld" class="btn-trailer" target="_blank">Trailer</a>
                    </div>
                </div>
            </div>

            <div class="movie-item wow-card">
                <div class="movie-poster">
                    <img src="${pageContext.request.contextPath}/assets/images/movies/movie2.jpg" alt="Avatar">
                    <span class="movie-badge badge-blue">NEW</span>
                </div>
                <div class="movie-body">
                    <h3>Avatar</h3>
                    <div class="movie-meta">Phiêu lưu • 150 phút • 8.8/10</div>
                    <div class="movie-actions">
                        <a href="#" class="btn-buy btn-wow">Mua vé</a>
                        <a href="https://youtu.be/nb_fFj_0rq8" class="btn-trailer" target="_blank">Trailer</a>
                    </div>
                </div>
            </div>
            
            <div class="movie-item wow-card">
                <div class="movie-poster">
                    <img src="${pageContext.request.contextPath}/assets/images/movies/spiderman.jpg" alt="Avatar">
                    <span class="movie-badge badge-blue">NEW</span>
                </div>
                <div class="movie-body">
                    <h3>Spiderman: No Way Home</h3>
                    <div class="movie-meta">Hành Động • 148 phút • 8.8/10</div>
                    <div class="movie-actions">
                        <a href="#" class="btn-buy btn-wow">Mua vé</a>
                        <a href="https://youtu.be/JfVOs4VSpmA?si=utUVmZMbHhwna2ad" class="btn-trailer" target="_blank">Trailer</a>
                    </div>
                </div>
            </div>

            <!-- Bạn có thể nhân thêm card ở đây -->
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
