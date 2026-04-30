<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>${movie.title} | BOBIXI Cinema</title>

<!-- Google Fonts & FontAwesome -->
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://cdn.tailwindcss.com"></script>

<style>
    body { font-family: 'Outfit', sans-serif; background-color: #020617; color: #f8fafc; margin: 0; }
    
    .hero-bg {
        position: fixed;
        inset: 0;
        z-index: -1;
        background: linear-gradient(to bottom, rgba(2, 6, 23, 0.85), #020617), url('${movie.poster}');
        background-size: cover;
        background-position: center;
        filter: blur(100px);
        transform: scale(1.2);
        opacity: 0.5;
    }

    .glass-panel {
        background: rgba(15, 23, 42, 0.7);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 40px;
        backdrop-filter: blur(30px);
        box-shadow: 0 50px 100px -20px rgba(0, 0, 0, 0.8);
    }

    .movie-title-premium {
        font-size: clamp(3rem, 8vw, 5.5rem);
        font-weight: 900;
        line-height: 0.95;
        letter-spacing: -4px;
        color: #ffffff;
        margin-bottom: 2rem;
    }

    .info-row {
        display: flex;
        padding: 1.2rem 0;
        border-bottom: 1px solid rgba(255, 255, 255, 0.08);
    }
    .info-label {
        width: 160px;
        font-size: 0.8rem;
        font-weight: 900;
        color: #fbbf24;
        text-transform: uppercase;
        letter-spacing: 2px;
    }
    .info-value { font-size: 1.1rem; font-weight: 600; color: #ffffff; }

    .action-btn-main {
        background: linear-gradient(135deg, #6366f1 0%, #4f46e5 100%);
        color: white;
        font-weight: 900;
        text-transform: uppercase;
        letter-spacing: 2px;
        padding: 22px 48px;
        border-radius: 24px;
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }
    .action-btn-main:hover { transform: translateY(-8px) scale(1.05); box-shadow: 0 20px 40px rgba(99, 102, 241, 0.4); }

    /* Trailer Modal Overhaul */
    #trailerModal {
        position: fixed;
        inset: 0;
        z-index: 9999;
        background: rgba(0, 0, 0, 0.98);
        backdrop-filter: blur(20px);
        display: none;
        align-items: center;
        justify-content: center;
        padding: 40px;
    }
    .trailer-content {
        width: 100%;
        max-width: 1400px;
        height: auto;
        aspect-ratio: 16/9;
        position: relative;
    }
    .trailer-close-btn {
        position: absolute;
        top: -60px;
        right: 0;
        color: white;
        font-size: 2rem;
        cursor: pointer;
        transition: 0.3s;
    }
    .trailer-close-btn:hover { color: #f43f5e; transform: rotate(90deg); }
    
    .iframe-wrap {
        width: 100%;
        height: 100%;
        border-radius: 40px;
        overflow: hidden;
        border: 1px solid rgba(255, 255, 255, 0.1);
        box-shadow: 0 0 100px rgba(99, 102, 241, 0.2);
    }
</style>
</head>

<body>
    <jsp:include page="/common/header.jsp"/>

    <div class="hero-bg"></div>

    <div class="relative z-10 min-h-screen py-16 px-6">
        <div class="max-w-7xl mx-auto">
            
            <div class="mb-12">
                <a href="${pageContext.request.contextPath}/movie" class="inline-flex items-center gap-3 text-amber-400 font-black uppercase tracking-widest text-xs hover:text-white transition-all group">
                    <i class="fas fa-chevron-left group-hover:-translate-x-2 transition-transform"></i>
                    Danh sách phim
                </a>
            </div>

            <div class="glass-panel p-10 lg:p-20 mb-16">
                <div class="flex flex-col lg:flex-row gap-20">
                    <div class="lg:w-[420px] shrink-0">
                        <div class="relative group">
                            <img src="${movie.poster}" alt="${movie.title}" 
                                 class="relative rounded-[40px] w-full shadow-2xl border border-white/10"
                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie1.jpg'">
                        </div>
                        <div class="flex gap-4 mt-10">
                            <div class="flex-1 bg-white/5 border border-white/10 p-5 rounded-[24px] text-center">
                                <p class="text-[10px] text-slate-500 font-black uppercase mb-1">Thời lượng</p>
                                <p class="text-white font-bold">${movie.duration} Phút</p>
                            </div>
                            <div class="flex-1 bg-amber-500/10 border border-amber-500/20 p-5 rounded-[24px] text-center">
                                <p class="text-[10px] text-amber-500 font-black uppercase mb-1">Trạng thái</p>
                                <p class="text-amber-400 font-bold">${movie.status}</p>
                            </div>
                        </div>
                    </div>

                    <div class="flex-1 pt-6">
                        <h1 class="movie-title-premium">${movie.title}</h1>
                        <div class="mb-12">
                            <div class="info-row">
                                <div class="info-label">Thể loại</div>
                                <div class="info-value">${movie.genre}</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Đạo diễn</div>
                                <div class="info-value">${movie.director != null ? movie.director : 'Đang cập nhật'}</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Diễn viên</div>
                                <div class="info-value">${movie.cast != null ? movie.cast : 'Đang cập nhật'}</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Khởi chiếu</div>
                                <div class="info-value"><fmt:formatDate value="${movie.releaseDate}" pattern="dd/MM/yyyy"/></div>
                            </div>
                        </div>
                        <div class="flex flex-wrap gap-8 items-center">
                            <a href="#booking-section" class="action-btn-main shadow-xl shadow-indigo-500/20">
                                <i class="fas fa-ticket-alt mr-2"></i> Mua vé ngay
                            </a>
                            <button id="btnTrailer" class="text-white font-black uppercase tracking-wider flex items-center gap-4 hover:text-amber-400 transition-all p-4">
                                <div class="w-14 h-14 rounded-full border-2 border-white/30 flex items-center justify-center hover:border-amber-400 transition-all">
                                    <i class="fas fa-play text-sm"></i>
                                </div>
                                Xem Trailer
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="booking-section" class="glass-panel p-10 lg:p-20">
                <div class="flex mb-12 border-b border-white/5 overflow-x-auto">
                    <button class="tab-trigger active whitespace-nowrap" data-tab="synopsis">Nội dung phim</button>
                    <button class="tab-trigger whitespace-nowrap" data-tab="schedule">Suất chiếu hôm nay</button>
                </div>
                <div id="tab-synopsis" class="tab-content block">
                    <p class="text-slate-300 text-xl leading-relaxed font-light italic max-w-4xl">
                        "${movie.description != null ? movie.description : 'Thông tin chi tiết về bộ phim đang được cập nhật.'}"
                    </p>
                </div>
                <div id="tab-schedule" class="tab-content hidden">
                    <c:choose>
                        <c:when test="${not empty todayShowtimes}">
                            <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-8">
                                <c:forEach var="s" items="${todayShowtimes}">
                                    <a href="${pageContext.request.contextPath}/booking-seat?showtimeId=${s.showtimeId}" class="st-chip-premium group">
                                        <div class="text-3xl font-black text-white group-hover:text-indigo-400 transition-colors">
                                            <fmt:formatDate value="${s.startTime}" pattern="HH:mm" />
                                        </div>
                                        <div class="text-[10px] font-black text-slate-500 uppercase tracking-widest mt-2">
                                            ${s.roomName}
                                        </div>
                                    </a>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-20 bg-white/5 rounded-3xl border border-dashed border-white/10">
                                <i class="fas fa-calendar-times text-5xl text-slate-700 mb-6 block"></i>
                                <h3 class="text-2xl font-bold text-slate-400">Không có suất chiếu hôm nay</h3>
                                <a href="${pageContext.request.contextPath}/showtime" class="text-indigo-400 font-bold hover:underline mt-4 inline-block">Xem lịch chiếu các ngày khác</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Trailer Modal (IMAX Screen) -->
    <div id="trailerModal">
        <div class="trailer-content">
            <div id="closeTrailer" class="trailer-close-btn">
                <i class="fas fa-times"></i>
            </div>
            <div class="iframe-wrap">
                <iframe id="trailerFrame" width="100%" height="100%" src="" 
                        title="YouTube video player" frameborder="0" 
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
                        allowfullscreen></iframe>
            </div>
        </div>
    </div>

    <jsp:include page="/common/footer.jsp"/>

    <script>
        // Tabs
        document.querySelectorAll('.tab-trigger').forEach(btn => {
            btn.addEventListener('click', () => {
                document.querySelectorAll('.tab-trigger').forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
                document.querySelectorAll('.tab-content').forEach(p => { p.classList.add('hidden'); p.classList.remove('block'); });
                const pane = document.getElementById('tab-' + btn.dataset.tab);
                pane.classList.remove('hidden'); pane.classList.add('block');
            });
        });

        // Trailer Management - IMAX Fix
        const modal = document.getElementById('trailerModal');
        const frame = document.getElementById('trailerFrame');
        const rawUrl = "${movie.trailerUrl}";

        function parseVideoId(url) {
            if (!url) return null;
            // Xử lý các dạng link phổ biến nhất
            const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
            const match = url.match(regExp);
            return (match && match[2].length === 11) ? match[2] : null;
        }

        const videoId = parseVideoId(rawUrl);
        const embedUrl = videoId ? `https://www.youtube.com/embed/${videoId}?autoplay=1&rel=0` : "";

        document.getElementById('btnTrailer').addEventListener('click', () => {
            if (!embedUrl) { alert("Trailer chưa khả dụng cho phim này."); return; }
            frame.src = embedUrl;
            modal.style.display = 'flex';
        });

        const closeT = () => { modal.style.display = 'none'; frame.src = ""; };
        document.getElementById('closeTrailer').addEventListener('click', closeT);
        modal.addEventListener('click', (e) => { if(e.target === modal) closeT(); });
        document.addEventListener('keydown', (e) => { if(e.key === 'Escape') closeT(); });
    </script>

    <style>
        .tab-trigger { font-size: 1.1rem; font-weight: 800; color: #64748b; padding: 1.5rem 0; margin-right: 3rem; border-bottom: 4px solid transparent; transition: all 0.3s; }
        .tab-trigger.active { color: #ffffff; border-bottom-color: #6366f1; }
        .st-chip-premium { background: rgba(255, 255, 255, 0.03); border: 2px solid rgba(255, 255, 255, 0.05); padding: 20px; border-radius: 24px; text-align: center; transition: all 0.3s; cursor: pointer; display: block; text-decoration: none; }
        .st-chip-premium:hover { background: rgba(99, 102, 241, 0.1); border-color: #6366f1; transform: scale(1.05); }
    </style>
</body>
</html>
