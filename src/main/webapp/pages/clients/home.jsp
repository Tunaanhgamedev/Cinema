<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                                <img src="${pageContext.request.contextPath}/${m.poster}" alt="${m.title}"
                                    loading="lazy">
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
                                    <a href="${pageContext.request.contextPath}/movie?id=${m.movieId}"
                                        class="btn-trailer">Chi tiết</a>
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
                                <img src="${pageContext.request.contextPath}/${m.poster}" alt="${m.title}"
                                    loading="lazy">
                                <span class="movie-badge badge-blue">COMING SOON</span>
                            </div>
                            <div class="movie-body">
                                <h3>${m.title}</h3>
                                <div class="movie-meta">Ngày khởi chiếu: ${m.releaseDate}</div>
                                <div class="movie-actions">
                                    <a href="${pageContext.request.contextPath}/movie?id=${m.movieId}"
                                        class="btn-trailer w-full">Xem Trailer</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
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
                                            html += `
                                                <a href="${pageContext.request.contextPath}/booking-seat?movieId=${m.movieId}" 
                                                   class="flex items-center gap-4 p-3 hover:bg-white/5 rounded-2xl transition-all group">
                                                    <img src="${pageContext.request.contextPath}/` + m.poster + `" class="w-12 h-16 object-cover rounded-xl shadow-lg">
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
            </script>
        </body>

        </html>