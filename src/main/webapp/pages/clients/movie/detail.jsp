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

<script>
    tailwind.config = {
        darkMode: 'media',
        theme: {
            extend: {
                colors: {
                    dark: '#020617',
                },
                fontFamily: {
                    sans: ['Outfit', 'sans-serif'],
                }
            }
        }
    }
</script>

<style>
    body { font-family: 'Outfit', sans-serif; transition: background-color 0.5s, color 0.5s; }
    
    .hero-bg {
        position: fixed;
        inset: 0;
        z-index: -1;
        background-image: url('${pageContext.request.contextPath}/assets/images/movie/${movie.poster}');
        background-size: cover;
        background-position: center;
        filter: blur(80px);
        transform: scale(1.1);
        opacity: 0.15;
    }
    .dark .hero-bg { opacity: 0.3; }

    .adaptive-panel {
        background: rgba(255, 255, 255, 0.8);
        backdrop-filter: blur(24px);
        border: 1px solid rgba(0, 0, 0, 0.05);
    }
    .dark .adaptive-panel {
        background: rgba(15, 23, 42, 0.7);
        border: 1px solid rgba(255, 255, 255, 0.08);
    }

    .movie-title-premium {
        font-size: clamp(2.5rem, 6vw, 5rem);
        font-weight: 900;
        line-height: 1;
        letter-spacing: -2px;
    }

    .info-row {
        display: flex;
        padding: 1rem 0;
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
    }
    .dark .info-row { border-bottom-color: rgba(255, 255, 255, 0.08); }

    .info-label {
        width: 140px;
        font-size: 0.75rem;
        font-weight: 900;
        color: #6366f1;
        text-transform: uppercase;
        letter-spacing: 2px;
    }
    .dark .info-label { color: #fbbf24; }

    /* Trailer Modal Adaptive */
    #trailerModal {
        position: fixed;
        inset: 0;
        z-index: 9999;
        background: rgba(2, 6, 23, 0.98);
        backdrop-filter: blur(20px);
        display: none;
        align-items: center;
        justify-content: center;
        padding: 20px;
    }
</style>
</head>

<body class="bg-slate-50 dark:bg-dark text-slate-900 dark:text-slate-100 min-h-screen">
    <jsp:include page="/common/header.jsp"/>

    <div class="hero-bg"></div>

    <div class="relative z-10 py-12 px-6">
        <div class="max-w-7xl mx-auto">
            
            <div class="mb-10">
                <a href="${pageContext.request.contextPath}/movie" class="inline-flex items-center gap-3 text-indigo-600 dark:text-amber-400 font-black uppercase tracking-widest text-[10px] hover:translate-x-[-8px] transition-transform group">
                    <i class="fas fa-arrow-left"></i>
                    Quay lại danh sách
                </a>
            </div>

            <div class="adaptive-panel p-8 lg:p-20 rounded-[3rem] shadow-2xl shadow-slate-200/50 dark:shadow-none mb-12">
                <div class="flex flex-col lg:flex-row gap-16">
                    <!-- Poster Column -->
                    <div class="lg:w-[380px] shrink-0">
                        <div class="relative group shadow-2xl rounded-[2.5rem] overflow-hidden border border-white/10">
                            <img src="${pageContext.request.contextPath}/assets/images/movie/${movie.poster}" alt="${movie.title}" 
                                 class="w-full transition-transform duration-700 group-hover:scale-105"
                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie.jpg'">
                        </div>
                        <div class="grid grid-cols-2 gap-4 mt-8">
                            <div class="bg-indigo-500/5 dark:bg-white/5 p-4 rounded-2xl text-center border border-indigo-500/10">
                                <p class="text-[8px] text-slate-400 font-black uppercase tracking-widest mb-1">Thời lượng</p>
                                <p class="text-sm font-black">${movie.duration} PHÚT</p>
                            </div>
                            <div class="bg-amber-500/5 p-4 rounded-2xl text-center border border-amber-500/10">
                                <p class="text-[8px] text-amber-500 font-black uppercase tracking-widest mb-1">Trạng thái</p>
                                <p class="text-sm font-black text-amber-600 dark:text-amber-400">${movie.status}</p>
                            </div>
                        </div>
                    </div>

                    <!-- Content Column -->
                    <div class="flex-1 space-y-10">
                        <div class="space-y-4">
                            <div class="flex items-center gap-3">
                                <span class="px-3 py-1 bg-rose-500 text-white text-[9px] font-black uppercase rounded shadow-lg shadow-rose-500/20">C18</span>
                                <span class="w-10 h-px bg-slate-300 dark:bg-white/20"></span>
                                <span class="text-[10px] font-bold text-slate-400 uppercase tracking-widest">BOBIXI Premium</span>
                            </div>
                            <h1 class="movie-title-premium italic uppercase">${movie.title}</h1>
                        </div>

                        <div class="grid grid-cols-1 gap-1">
                            <div class="info-row">
                                <div class="info-label">Thể loại</div>
                                <div class="font-bold text-sm">${movie.genre}</div>
                            </div>
                             <div class="info-row">
                                <div class="info-label">Đánh giá</div>
                                <div class="font-bold text-sm text-indigo-600 dark:text-amber-400"><i class="fas fa-star mr-2"></i>${movie.rating} / 10</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Đạo diễn</div>
                                <div class="font-bold text-sm">${movie.director != null ? movie.director : 'Đang cập nhật'}</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Diễn viên</div>
                                <div class="font-bold text-sm text-slate-500 leading-relaxed">${movie.cast != null ? movie.cast : 'Đang cập nhật'}</div>
                            </div>
                        </div>

                        <div class="flex flex-wrap gap-6 pt-6">
                            <a href="${pageContext.request.contextPath}/booking-seat?movieId=${movie.id}" class="px-10 py-5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-2xl text-xs font-black uppercase tracking-widest shadow-xl shadow-indigo-500/30 transition-all hover:scale-105 active:scale-95 flex items-center gap-3">
                                <i class="fas fa-ticket-alt"></i> Mua vé ngay
                            </a>
                            <button id="btnTrailer" class="px-8 py-5 bg-white dark:bg-white/5 border border-slate-200 dark:border-white/10 rounded-2xl text-xs font-black uppercase tracking-widest hover:bg-slate-50 dark:hover:bg-white/10 transition-all flex items-center gap-3">
                                <i class="fas fa-play text-indigo-500"></i> Xem Trailer
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Content Tabs -->
            <div class="adaptive-panel p-8 lg:p-16 rounded-[3rem]">
                <div class="flex gap-10 border-b border-slate-200 dark:border-white/5 mb-10 overflow-x-auto">
                    <button class="tab-trigger active pb-6 text-sm font-black uppercase tracking-widest transition-all border-b-4 border-transparent" data-tab="synopsis">Nội dung</button>
                    <button class="tab-trigger pb-6 text-sm font-black uppercase tracking-widest transition-all border-b-4 border-transparent" data-tab="schedule">Lịch chiếu hôm nay</button>
                </div>
                
                <div id="tab-synopsis" class="tab-content block">
                    <p class="text-lg text-slate-500 dark:text-slate-400 leading-relaxed max-w-4xl italic font-medium">
                        "${movie.description != null ? movie.description : 'Thông tin chi tiết về bộ phim đang được cập nhật.'}"
                    </p>
                </div>

                <div id="tab-schedule" class="tab-content hidden">
                    <c:choose>
                        <c:when test="${not empty todayShowtimes}">
                            <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 gap-6">
                                <c:forEach var="s" items="${todayShowtimes}">
                                    <a href="${pageContext.request.contextPath}/booking-seat?showtimeId=${s.showtimeId}" class="p-6 bg-white dark:bg-white/5 border border-slate-200 dark:border-white/10 rounded-2xl text-center group hover:border-indigo-500 transition-all shadow-sm">
                                        <div class="text-2xl font-black group-hover:text-indigo-600 dark:group-hover:text-indigo-400 transition-colors">
                                            <fmt:formatDate value="${s.startTime}" pattern="HH:mm" />
                                        </div>
                                        <div class="text-[9px] font-black text-slate-400 uppercase tracking-widest mt-2">${s.roomName}</div>
                                    </a>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="py-20 text-center opacity-40">
                                <i class="fas fa-calendar-times text-5xl mb-4"></i>
                                <p class="font-black text-xs uppercase tracking-widest">Không có suất chiếu hôm nay</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Trailer Modal -->
    <div id="trailerModal">
        <div class="w-full max-w-6xl aspect-video relative">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-xl font-black italic tracking-tighter uppercase text-white">Trailer: ${movie.title}</h2>
                <div id="closeTrailer" class="w-12 h-12 rounded-full bg-white/10 flex items-center justify-center hover:bg-rose-500 transition-all text-white cursor-pointer shadow-2xl">
                    <i class="fas fa-times"></i>
                </div>
            </div>
            <div class="rounded-[2.5rem] overflow-hidden border border-white/10 shadow-2xl shadow-indigo-500/20 aspect-video">
                <iframe id="trailerFrame" width="100%" height="100%" src="" frameborder="0" allowfullscreen></iframe>
            </div>
        </div>
    </div>

    <jsp:include page="/common/footer.jsp"/>

    <script>
        // Tabs
        document.querySelectorAll('.tab-trigger').forEach(btn => {
            btn.addEventListener('click', () => {
                document.querySelectorAll('.tab-trigger').forEach(b => {
                    b.classList.remove('active', 'text-indigo-600', 'dark:text-indigo-400', 'border-indigo-600', 'dark:border-indigo-400');
                    b.classList.add('text-slate-400');
                });
                btn.classList.add('active', 'text-indigo-600', 'dark:text-indigo-400', 'border-indigo-600', 'dark:border-indigo-400');
                btn.classList.remove('text-slate-400');
                
                document.querySelectorAll('.tab-content').forEach(p => p.classList.add('hidden'));
                document.getElementById('tab-' + btn.dataset.tab).classList.remove('hidden');
            });
        });
        document.querySelector('.tab-trigger.active').click();

        // Trailer
        const modal = document.getElementById('trailerModal');
        const frame = document.getElementById('trailerFrame');
        const rawUrl = "${movie.trailerUrl}";

        function parseVideoId(url) {
            const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
            const match = url.match(regExp);
            return (match && match[2].length === 11) ? match[2] : null;
        }

        const videoId = parseVideoId(rawUrl);
        document.getElementById('btnTrailer').addEventListener('click', () => {
            if (!videoId) { alert("Trailer chưa khả dụng."); return; }
            frame.src = `https://www.youtube.com/embed/${videoId}?autoplay=1`;
            modal.style.display = 'flex';
        });

        const closeT = () => { modal.style.display = 'none'; frame.src = ""; };
        document.getElementById('closeTrailer').addEventListener('click', closeT);
        modal.addEventListener('click', (e) => { if(e.target === modal) closeT(); });
    </script>
</body>
</html>
