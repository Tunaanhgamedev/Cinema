<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>BOBIXI Cinema</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.css" />
    <style>
        @keyframes marquee {
            0% { transform: translateX(0); }
            100% { transform: translateX(calc(-350px * 5 - 1.5rem * 5)); }
        }
        .animate-marquee {
            display: flex;
            width: max-content;
            animation: marquee 30s linear infinite;
        }
        .animate-marquee:hover {
            animation-play-state: paused;
        }
    </style>
</head>

<body>

    <jsp:include page="/common/header.jsp" />

    <!-- HERO WOW -->
    <section class="hero-wow">
        <div class="hero-video-wrapper">
            <video autoplay muted loop playsinline class="hero-video" 
                   poster="${pageContext.request.contextPath}/assets/images/banners/left.jpg">
                <source src="https://assets.mixkit.co/videos/preview/mixkit-searching-in-the-dark-22122-large.mp4" type="video/mp4">
            </video>
            <div class="video-overlay"></div>
        </div>
        <div class="container hero-inner">
            <div class="hero-left">
                <div class="hero-badge">🎬 BOBIXI Cinemas</div>
                <h1 class="hero-title">
                    Đặt vé xem phim <span>nhanh</span> – <span>đẹp</span>
                </h1>
                <p class="hero-sub">
                    Chọn phim, chọn suất, chọn ghế trong vài giây.
                </p>

                <div class="search-hero-wrapper mb-8 relative">
                    <form action="${pageContext.request.contextPath}/movie" method="GET" class="search-hero-form" id="heroSearchForm">
                        <i class="fas fa-search"></i>
                        <input type="text" name="q" id="heroSearchInput" autocomplete="off"
                               placeholder="Tìm tên phim bạn muốn xem..." class="search-hero-input">
                        <button type="submit" class="btn-search-hero">Tìm kiếm</button>
                    </form>
                    <!-- Vùng kết quả AJAX -->
                    <div id="heroSearchResults" class="absolute left-0 right-0 mt-2 bg-slate-900/95 backdrop-blur-xl border border-white/10 rounded-3xl shadow-2xl z-50 hidden max-h-[400px] overflow-y-auto overflow-x-hidden">
                        <!-- Kết quả sẽ được render ở đây -->
                    </div>
                </div>

                <div class="hero-actions">
                    <a href="#nowshowing" class="btn-neon">Xem phim đang chiếu</a>
                    <a href="${pageContext.request.contextPath}/booking-seat" class="btn-ghost">Đặt vé ngay</a>
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
                    <img src="${pageContext.request.contextPath}/assets/images/movies/avg.jpg" 
                         alt="Poster" 
                         onerror="this.src='https://placehold.co/600x900?text=BOBIXI+Cinema'">
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

    <!-- PROMO & ADS SECTION -->
    <section class="promo-section home-section">
        <div class="section-head">
            <h2 class="section-title">ƯU ĐÃI & HỘI VIÊN</h2>
            <div class="section-line"></div>
        </div>
        <div class="promo-grid">
            <!-- Combo Card -->
            <div class="promo-card combo-card">
                <div class="promo-content">
                    <span class="promo-tag">Best Seller</span>
                    <h3>Combo Đôi Hoàn Hảo</h3>
                    <p>2 Bắp lớn + 2 Nước ngọt + 1 Topping bất kỳ. Tiết kiệm ngay 30%.</p>
                    <div class="price">Chỉ 129.000đ</div>
                    <a href="${pageContext.request.contextPath}/combo" class="btn-promo">Khám phá Menu</a>
                </div>
                <div class="promo-img">
                    <img src="https://images.unsplash.com/photo-1572177191856-3cde6403ec1b?q=80&w=600&auto=format&fit=crop" alt="Combo Popcorn">
                </div>
            </div>

            <!-- Loyalty Promo Card -->
            <div class="promo-card loyalty-card-promo">
                <div class="promo-content">
                    <span class="promo-tag">Membership</span>
                    <h3>Gia nhập Cộng đồng BOBIXI</h3>
                    <p>Tích điểm 5% mỗi giao dịch, đổi vé miễn phí và nhận voucher quyền năng.</p>
                    <div class="loyalty-perks">
                        <span><i class="fas fa-star"></i> Tích điểm đổi quà 24/7</span>
                        <span><i class="fas fa-gift"></i> Voucher giảm giá lên đến 100k</span>
                    </div>
                    <a href="${pageContext.request.contextPath}/register" class="btn-promo btn-gold">Đăng ký thành viên</a>
                </div>
            </div>
        </div>
    </section>

    <!-- MEMBERSHIP TIERS SECTION -->
    <section class="membership-tiers-section home-section">
        <div class="section-head">
            <h2 class="section-title">HẠNG THÀNH VIÊN</h2>
            <div class="section-line"></div>
        </div>
        <div class="tiers-grid">
            <!-- Silver -->
            <div class="tier-card tier-silver">
                <div class="tier-icon"><i class="fas fa-medal"></i></div>
                <h3>SILVER</h3>
                <p class="tier-desc">Hạng khởi đầu cho mọi hành trình điện ảnh.</p>
                <ul class="tier-list">
                    <li><i class="fas fa-check"></i> Tích lũy 5% điểm</li>
                    <li><i class="fas fa-check"></i> Voucher sinh nhật 20k</li>
                </ul>
            </div>
            <!-- Gold -->
            <div class="tier-card tier-gold">
                <div class="tier-icon"><i class="fas fa-crown"></i></div>
                <div class="tier-badge-popular">Phổ biến nhất</div>
                <h3>GOLD</h3>
                <p class="tier-desc">Nâng tầm trải nghiệm với ưu đãi nhân đôi.</p>
                <ul class="tier-list">
                    <li><i class="fas fa-check"></i> Tích lũy 7% điểm</li>
                    <li><i class="fas fa-check"></i> Voucher sinh nhật 50k</li>
                    <li><i class="fas fa-check"></i> Giảm 5% Combo bắp nước</li>
                </ul>
            </div>
            <!-- Platinum -->
            <div class="tier-card tier-platinum">
                <div class="tier-icon"><i class="fas fa-gem"></i></div>
                <h3>PLATINUM</h3>
                <p class="tier-desc">Đặc quyền tối thượng dành cho mọt phim chính hiệu.</p>
                <ul class="tier-list">
                    <li><i class="fas fa-check"></i> Tích lũy 10% điểm</li>
                    <li><i class="fas fa-check"></i> Voucher sinh nhật 100k</li>
                    <li><i class="fas fa-check"></i> Miễn phí đổi vé 2 lần/tháng</li>
                    <li><i class="fas fa-check"></i> Quà tặng đặc biệt cuối năm</li>
                </ul>
            </div>
        </div>
    </section>

    <!-- NOW SHOWING -->
    <section class="home-section wow-section" id="nowshowing">
        <div class="section-head">
            <h2 class="section-title">PHIM ĐANG CHIẾU</h2>
            <div class="section-line"></div>
        </div>

        <div class="movie-grid wow-grid">
            <c:forEach var="m" items="${nowShowingMovies}">
                <div class="movie-item wow-card">
                    <div class="movie-poster">
                        <c:set var="posterUrl" value="${m.poster}" />
                        <c:if test="${fn:startsWith(posterUrl, '/')}">
                            <c:set var="posterUrl" value="${fn:substring(posterUrl, 1, fn:length(posterUrl))}" />
                        </c:if>
                        <c:if test="${not empty posterUrl && !fn:startsWith(posterUrl, 'http') && !fn:startsWith(posterUrl, 'assets/')}">
                            <c:set var="posterUrl" value="assets/images/movies/${posterUrl}" />
                        </c:if>
                        
                        <c:set var="finalPosterUrl" value="${fn:startsWith(posterUrl, 'http') ? posterUrl : pageContext.request.contextPath.concat('/').concat(posterUrl)}" />
                        <img src="${finalPosterUrl}" 
                             alt="${m.title}"
                             loading="lazy"
                             onerror="this.src='https://placehold.co/300x450?text=No+Poster'">
                        <c:if test="${m.rating >= 9}">
                            <span class="movie-badge">HOT</span>
                        </c:if>
                    </div>
                    <div class="movie-body">
                        <h3>${m.title}</h3>
                        <div class="movie-meta">${m.duration} phút • ${m.rating}/10</div>
                        <div class="movie-actions">
                            <a href="${pageContext.request.contextPath}/booking-seat?movieId=${m.movieId}"
                                class="btn-buy btn-wow">Mua vé</a>
                            <button onclick="openTrailer('${m.trailerUrl}')"
                                class="btn-trailer">Xem Trailer</button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>

    <!-- COMING SOON -->
    <section class="home-section wow-section">
        <div class="section-head">
            <h2 class="section-title">PHIM SẮP CHIẾU</h2>
            <div class="section-line"></div>
        </div>
        <div class="movie-grid wow-grid">
            <c:forEach var="m" items="${comingSoonMovies}">
                <div class="movie-item wow-card coming-soon-card">
                    <div class="movie-poster">
                        <c:set var="posterUrlComing" value="${m.poster}" />
                        <c:if test="${fn:startsWith(posterUrlComing, '/')}">
                            <c:set var="posterUrlComing" value="${fn:substring(posterUrlComing, 1, fn:length(posterUrlComing))}" />
                        </c:if>
                        <c:if test="${not empty posterUrlComing && !fn:startsWith(posterUrlComing, 'http') && !fn:startsWith(posterUrlComing, 'assets/')}">
                            <c:set var="posterUrlComing" value="assets/images/movies/${posterUrlComing}" />
                        </c:if>
                        
                        <c:set var="finalPosterComing" value="${fn:startsWith(posterUrlComing, 'http') ? posterUrlComing : pageContext.request.contextPath.concat('/').concat(posterUrlComing)}" />
                        <img src="${finalPosterComing}" 
                             alt="${m.title}"
                             loading="lazy"
                             onerror="this.src='https://placehold.co/300x450?text=No+Poster'">
                        <span class="movie-badge badge-blue">COMING SOON</span>
                    </div>
                    <div class="movie-body">
                        <h3>${m.title}</h3>
                        <div class="movie-meta">Ngày khởi chiếu: ${m.releaseDate}</div>
                        <div class="movie-actions">
                            <button onclick="openTrailer('${m.trailerUrl}')"
                                class="btn-trailer w-full">Xem Trailer</button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>

    <!-- RECENT REVIEWS -->
    <section class="home-section wow-section">
        <div class="section-head">
            <h2 class="section-title">CẢM NHẬN KHÁN GIẢ</h2>
            <div class="section-line"></div>
        </div>
        <div class="reviews-marquee-wrapper overflow-hidden py-10">
            <div class="flex gap-6 animate-marquee">
                <c:forEach var="r" items="${recentReviews}">
                    <div class="min-w-[350px] bg-slate-800/40 backdrop-blur-xl p-8 rounded-[2rem] border border-white/5 hover:border-white/10 transition-all group">
                        <div class="flex items-center gap-4 mb-4">
                            <div class="w-10 h-10 rounded-full bg-indigo-600 flex items-center justify-center font-bold text-white shadow-lg">
                                ${fn:substring(r.userName, 0, 1).toUpperCase()}
                            </div>
                            <div>
                                <h4 class="text-white font-bold text-sm">${r.userName}</h4>
                                <p class="text-[10px] text-slate-500 italic">về ${r.movieTitle}</p>
                            </div>
                            <div class="ml-auto text-yellow-500 text-xs">
                                <c:forEach begin="1" end="${r.rating}">★</c:forEach>
                            </div>
                        </div>
                        <p class="text-slate-400 text-sm leading-relaxed line-clamp-3 group-hover:text-slate-200 transition-colors">
                            "${r.content}"
                        </p>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>

    <button id="backToTop" class="back-to-top-btn" type="button" aria-label="Lên đầu trang">↑</button>

    <jsp:include page="/common/footer.jsp" />

    <!-- Trailer Modal -->
    <div id="trailerModal" class="fixed inset-0 z-[200] hidden items-center justify-center p-4 bg-black/95 backdrop-blur-sm">
        <div class="relative w-full max-w-5xl">
            <button id="closeTrailer" class="absolute -top-12 right-0 text-white text-4xl hover:text-red-500 transition-colors">
                <i class="fas fa-times"></i>
            </button>
            <div class="aspect-video bg-black rounded-3xl overflow-hidden shadow-2xl ring-1 ring-white/20">
                <iframe id="trailerFrame" class="w-full h-full" src="" frameborder="0" allowfullscreen></iframe>
            </div>
        </div>
    </div>

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

        // Real-time Search Hero
        const heroInput = document.getElementById('heroSearchInput');
        const heroResults = document.getElementById('heroSearchResults');
        let searchTimeout = null;

        if (heroInput) {
            heroInput.addEventListener('input', (e) => {
                const q = e.target.value.trim();
                clearTimeout(searchTimeout);

                if (q.length < 2) {
                    heroResults.innerHTML = '';
                    heroResults.classList.add('hidden');
                    return;
                }

                searchTimeout = setTimeout(() => {
                    const url = '${pageContext.request.contextPath}/movie?ajax=true&q=' + encodeURIComponent(q);
                    console.log('[HeroSearch] Fetching:', url);
                    fetch(url)
                        .then(res => res.json())
                        .then(data => {
                            if (data && data.length > 0) {
                                let html = '<div class="p-4 flex flex-col gap-2">';
                                data.forEach(m => {
                                    let posterSrc = m.poster;
                                    if (posterSrc && posterSrc.startsWith('/')) {
                                        posterSrc = posterSrc.substring(1);
                                    }
                                    if (posterSrc && !posterSrc.startsWith('http') && !posterSrc.startsWith('assets/')) {
                                        posterSrc = 'assets/images/movies/' + posterSrc;
                                    }
                                    let finalSrc = (posterSrc && posterSrc.startsWith('http')) ? posterSrc : '${pageContext.request.contextPath}/' + posterSrc;
                                    html += `
                                        <a href="${pageContext.request.contextPath}/booking-seat?movieId=${m.movieId}" 
                                           class="flex items-center gap-4 p-3 hover:bg-white/5 rounded-2xl transition-all group">
                                            <img src="${finalSrc}" 
                                                 class="w-12 h-16 object-cover rounded-xl shadow-lg"
                                                 onerror="this.src='https://placehold.co/100x150?text=No+Img'">
                                            <div class="flex-1">
                                                <h4 class="text-white font-bold group-hover:text-indigo-400 transition-colors">` + m.title + `</h4>
                                                <p class="text-xs text-slate-400">` + m.genre + ` • ` + m.duration + ` phút</p>
                                            </div>
                                            <div class="text-[10px] font-black bg-indigo-600/20 text-indigo-400 px-3 py-1 rounded-full border border-indigo-500/20">
                                                ĐẶT VÉ
                                            </div>
                                        </a>
                                    `;
                                });
                                html += '</div>';
                                heroResults.innerHTML = html;
                                heroResults.classList.remove('hidden');
                            } else {
                                heroResults.innerHTML = '<div class="p-8 text-center text-slate-500 text-sm italic">Không tìm thấy phim nào khớp...</div>';
                                heroResults.classList.remove('hidden');
                            }
                        })
                        .catch(err => console.error('Search error:', err));
                }, 300);
            });

            // Đóng kết quả khi click ra ngoài
            document.addEventListener('click', (e) => {
                if (!heroInput.contains(e.target) && !heroResults.contains(e.target)) {
                    heroResults.classList.add('hidden');
                }
            });
        }

        // Trailer logic
        const modal = document.getElementById('trailerModal');
        const frame = document.getElementById('trailerFrame');

        window.openTrailer = function(url) {
            if (!url || url === 'null' || url === '') {
                alert("Trailer hiện tại không khả dụng.");
                return;
            }
            const embed = getEmbedUrl(url);
            if (!embed) {
                alert("Trailer hiện tại không khả dụng.");
                return;
            }
            frame.src = embed + "?autoplay=1";
            modal.classList.remove('hidden');
            modal.classList.add('flex');
        };

        function getEmbedUrl(url) {
            if (!url) return "";
            let id = "";
            if (url.includes("v=")) id = url.split("v=")[1].split("&")[0];
            else if (url.includes("youtu.be/")) id = url.split("youtu.be/")[1].split("?")[0];
            return id ? "https://www.youtube.com/embed/" + id : "";
        }

        const closeModal = () => {
            modal.classList.add('hidden');
            modal.classList.remove('flex');
            frame.src = "";
        };
        
        const closeBtn = document.getElementById('closeTrailer');
        if(closeBtn) closeBtn.addEventListener('click', closeModal);
        if(modal) modal.addEventListener('click', (e) => { if (e.target === modal) closeModal(); });
    </script>
</body>

</html>