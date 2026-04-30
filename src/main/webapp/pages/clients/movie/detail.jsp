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
    
    /* Hero Background with Poster Blur */
    .hero-bg {
        position: fixed;
        inset: 0;
        z-index: -1;
        background: linear-gradient(to bottom, rgba(2, 6, 23, 0.8), #020617), url('${movie.poster}');
        background-size: cover;
        background-position: center;
        filter: blur(80px);
        transform: scale(1.1);
        opacity: 0.4;
    }

    .glass-panel {
        background: rgba(15, 23, 42, 0.8);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 32px;
        backdrop-filter: blur(20px);
        box-shadow: 0 50px 100px -20px rgba(0, 0, 0, 0.7);
    }

    .movie-title-premium {
        font-size: 5rem;
        font-weight: 900;
        line-height: 1;
        letter-spacing: -4px;
        color: #ffffff;
        text-shadow: 0 10px 30px rgba(0,0,0,0.5);
        margin-bottom: 2rem;
    }

    .info-row {
        display: flex;
        padding: 1.5rem 0;
        border-bottom: 1px solid rgba(255, 255, 255, 0.08);
    }
    .info-label {
        width: 160px;
        font-size: 0.85rem;
        font-weight: 900;
        color: #fbbf24; /* Gold/Amber for high contrast */
        text-transform: uppercase;
        letter-spacing: 2px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .info-value {
        font-size: 1.1rem;
        font-weight: 600;
        color: #ffffff;
    }

    .action-btn-main {
        background: #6366f1;
        color: white;
        font-weight: 900;
        text-transform: uppercase;
        letter-spacing: 2px;
        padding: 20px 40px;
        border-radius: 20px;
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        box-shadow: 0 15px 30px -10px rgba(99, 102, 241, 0.6);
    }
    .action-btn-main:hover {
        transform: translateY(-5px) scale(1.05);
        background: #4f46e5;
        box-shadow: 0 20px 40px -10px rgba(99, 102, 241, 0.8);
    }

    .st-chip-premium {
        background: rgba(255, 255, 255, 0.03);
        border: 2px solid rgba(255, 255, 255, 0.05);
        padding: 20px;
        border-radius: 24px;
        text-align: center;
        transition: all 0.3s;
        cursor: pointer;
    }
    .st-chip-premium:hover {
        background: rgba(99, 102, 241, 0.1);
        border-color: #6366f1;
        transform: scale(1.05);
    }

    .tab-trigger {
        font-size: 1.1rem;
        font-weight: 800;
        color: #64748b;
        padding: 1.5rem 0;
        margin-right: 3rem;
        border-bottom: 4px solid transparent;
        transition: all 0.3s;
    }
    .tab-trigger.active {
        color: #ffffff;
        border-bottom-color: #6366f1;
    }
</style>
</head>

<body>
    <jsp:include page="/common/header.jsp"/>

    <div class="hero-bg"></div>

    <div class="relative z-10 min-h-screen py-16 px-6">
        <div class="max-w-7xl mx-auto">
            
            <!-- Breadcrumb Navigation -->
            <div class="mb-12">
                <a href="${pageContext.request.contextPath}/movie" class="inline-flex items-center gap-3 text-amber-400 font-black uppercase tracking-widest text-xs hover:text-white transition-all group">
                    <i class="fas fa-chevron-left group-hover:-translate-x-2 transition-transform"></i>
                    Danh sách phim
                </a>
            </div>

            <!-- Main Movie Card -->
            <div class="glass-panel p-12 lg:p-20 mb-16">
                <div class="flex flex-col lg:flex-row gap-20">
                    
                    <!-- Left Column: Poster -->
                    <div class="lg:w-[420px] shrink-0">
                        <div class="relative group">
                            <div class="absolute -inset-4 bg-indigo-500/20 rounded-[40px] blur-2xl opacity-0 group-hover:opacity-100 transition-opacity"></div>
                            <img src="${movie.poster}" alt="${movie.title}" 
                                 class="relative rounded-[32px] w-full shadow-2xl border border-white/10"
                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie1.jpg'">
                        </div>

                        <div class="flex gap-4 mt-10">
                            <div class="flex-1 bg-white/5 border border-white/10 p-4 rounded-2xl text-center">
                                <p class="text-[10px] text-slate-500 font-black uppercase mb-1">Thời lượng</p>
                                <p class="text-white font-bold">${movie.duration} Phút</p>
                            </div>
                            <div class="flex-1 bg-amber-500/10 border border-amber-500/20 p-4 rounded-2xl text-center">
                                <p class="text-[10px] text-amber-500 font-black uppercase mb-1">Trạng thái</p>
                                <p class="text-amber-400 font-bold">${movie.status}</p>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column: Big Details -->
                    <div class="flex-1">
                        <h1 class="movie-title-premium">${movie.title}</h1>
                        
                        <div class="movie-info-list mb-12">
                            <div class="info-row">
                                <div class="info-label"><i class="fas fa-film"></i> Thể loại</div>
                                <div class="info-value">${movie.genre}</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label"><i class="fas fa-video"></i> Đạo diễn</div>
                                <div class="info-value">${movie.director != null ? movie.director : 'Đang cập nhật'}</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label"><i class="fas fa-users"></i> Diễn viên</div>
                                <div class="info-value">${movie.cast != null ? movie.cast : 'Đang cập nhật'}</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label"><i class="fas fa-calendar-alt"></i> Khởi chiếu</div>
                                <div class="info-value"><fmt:formatDate value="${movie.releaseDate}" pattern="dd/MM/yyyy"/></div>
                            </div>
                        </div>

                        <div class="flex flex-wrap gap-8 items-center">
                            <a href="#booking-section" class="action-btn-main">
                                <i class="fas fa-ticket-alt mr-2"></i> Mua vé ngay
                            </a>
                            <button id="btnTrailer" class="text-white font-bold flex items-center gap-3 hover:text-indigo-400 transition-all p-4">
                                <div class="w-12 h-12 rounded-full border-2 border-white flex items-center justify-center hover:border-indigo-400 transition-all">
                                    <i class="fas fa-play text-xs"></i>
                                </div>
                                Xem Trailer
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Booking & Synopsis Section -->
            <div id="booking-section" class="glass-panel p-12 lg:p-20">
                <div class="flex mb-12 border-b border-white/5">
                    <button class="tab-trigger active" data-tab="synopsis">Nội dung phim</button>
                    <button class="tab-trigger" data-tab="schedule">Suất chiếu hôm nay</button>
                </div>

                <div id="tab-synopsis" class="tab-content block">
                    <div class="max-w-4xl">
                        <p class="text-slate-300 text-xl leading-relaxed font-light">
                            ${movie.description != null ? movie.description : 'Thông tin chi tiết về bộ phim đang được cập nhật. Vui lòng quay lại sau.'}
                        </p>
                    </div>
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
                            <div class="text-center py-16 bg-white/5 rounded-3xl border border-dashed border-white/10">
                                <i class="fas fa-clock text-5xl text-slate-700 mb-6 block"></i>
                                <h3 class="text-2xl font-bold text-slate-400">Không tìm thấy suất chiếu hôm nay</h3>
                                <a href="${pageContext.request.contextPath}/showtime" class="text-indigo-400 font-bold hover:underline mt-4 inline-block">Xem lịch chiếu các ngày khác</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>
    </div>

    <!-- Trailer Modal (Full Screen) -->
    <div id="trailerModal" class="fixed inset-0 z-[999] hidden items-center justify-center bg-black/98 p-6 backdrop-blur-2xl">
        <div class="w-full max-w-6xl relative">
            <button id="closeTrailer" class="absolute -top-16 right-0 text-white text-3xl hover:text-rose-500 transition-all">
                <i class="fas fa-times"></i>
            </div>
            <div class="aspect-video rounded-[40px] overflow-hidden border border-white/10 shadow-2xl">
                <iframe id="trailerFrame" width="100%" height="100%" src="" frameborder="0" allowfullscreen></iframe>
            </div>
        </div>
    </div>

    <jsp:include page="/common/footer.jsp"/>

    <script>
        // Tabs Switching
        document.querySelectorAll('.tab-trigger').forEach(btn => {
            btn.addEventListener('click', () => {
                document.querySelectorAll('.tab-trigger').forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
                document.querySelectorAll('.tab-content').forEach(p => {
                    p.classList.add('hidden');
                    p.classList.remove('block');
                });
                const pane = document.getElementById('tab-' + btn.dataset.tab);
                pane.classList.remove('hidden');
                pane.classList.add('block');
            });
        });

        // Trailer Management - Universal YouTube Parser
        const modal = document.getElementById('trailerModal');
        const frame = document.getElementById('trailerFrame');
        const rawUrl = "${movie.trailerUrl}";

        function getYoutubeEmbedUrl(url) {
            if (!url) return "";
            let videoId = "";
            
            try {
                if (url.includes('v=')) {
                    // Link dạng: https://www.youtube.com/watch?v=XXXXXXXX
                    videoId = url.split('v=')[1].split('&')[0];
                } else if (url.includes('youtu.be/')) {
                    // Link dạng: https://youtu.be/XXXXXXXX
                    videoId = url.split('youtu.be/')[1].split('?')[0];
                } else if (url.includes('embed/')) {
                    // Link đã là embed: https://www.youtube.com/embed/XXXXXXXX
                    return url;
                }
            } catch (e) {
                console.error("Error parsing YouTube URL:", e);
            }
            
            return videoId ? `https://www.youtube.com/embed/${videoId}` : url;
        }

        const embedUrl = getYoutubeEmbedUrl(rawUrl);

        document.getElementById('btnTrailer').addEventListener('click', () => {
            if (!embedUrl) {
                alert("Trailer hiện đang được cập nhật!");
                return;
            }
            frame.src = embedUrl + (embedUrl.includes('?') ? '&' : '?') + "autoplay=1";
            modal.style.display = 'flex';
        });

        const hideTrailer = () => {
            modal.style.display = 'none';
            frame.src = "";
        };

        document.getElementById('closeTrailer').addEventListener('click', hideTrailer);
        modal.addEventListener('click', (e) => { if(e.target === modal) hideTrailer(); });
    </script>
</body>
</html>
