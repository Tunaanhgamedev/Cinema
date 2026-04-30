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
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://cdn.tailwindcss.com"></script>

<style>
    body { font-family: 'Outfit', sans-serif; background-color: #020617; color: #f8fafc; }
    
    .page-wrapper {
        min-height: 100vh;
        background: radial-gradient(circle at 20% 30%, rgba(99, 102, 241, 0.15) 0%, transparent 40%),
                    radial-gradient(circle at 80% 70%, rgba(34, 211, 238, 0.1) 0%, transparent 40%);
        padding-top: 2rem;
        padding-bottom: 5rem;
    }

    .glass-card {
        background: rgba(15, 23, 42, 0.6);
        backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.08);
        border-radius: 40px;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
    }

    .poster-wrapper {
        position: relative;
        border-radius: 30px;
        overflow: hidden;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.6);
        border: 1px solid rgba(255, 255, 255, 0.1);
        transition: transform 0.5s cubic-bezier(0.4, 0, 0.2, 1);
    }
    
    .poster-wrapper:hover {
        transform: scale(1.02);
    }

    .poster-glow {
        position: absolute;
        inset: -20px;
        background: radial-gradient(circle, rgba(99, 102, 241, 0.3) 0%, transparent 70%);
        z-index: -1;
        opacity: 0;
        transition: opacity 0.5s;
    }
    .poster-wrapper:hover + .poster-glow { opacity: 1; }

    .movie-title {
        font-size: 4.5rem;
        font-weight: 900;
        line-height: 0.9;
        letter-spacing: -3px;
        background: linear-gradient(to bottom right, #fff 30%, #94a3b8 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        margin-bottom: 1.5rem;
    }

    .info-table { width: 100%; border-collapse: separate; border-spacing: 0 10px; }
    .info-table td { padding: 12px 0; border-bottom: 1px solid rgba(255, 255, 255, 0.05); }
    .info-table td.label { width: 140px; font-size: 0.75rem; font-weight: 800; color: #64748b; text-transform: uppercase; letter-spacing: 2px; }
    .info-table td.value { font-weight: 500; color: #e2e8f0; }

    .btn-buy {
        background: linear-gradient(135deg, #6366f1 0%, #4f46e5 100%);
        box-shadow: 0 10px 20px -5px rgba(79, 70, 229, 0.5);
        transition: all 0.3s;
    }
    .btn-buy:hover {
        transform: translateY(-3px);
        box-shadow: 0 15px 30px -5px rgba(79, 70, 229, 0.6);
    }

    .tab-btn {
        position: relative;
        padding: 1rem 1.5rem;
        font-weight: 700;
        color: #64748b;
        transition: all 0.3s;
    }
    .tab-btn.active { color: #f8fafc; }
    .tab-btn.active::after {
        content: '';
        position: absolute;
        bottom: 0; left: 0; width: 100%; height: 3px;
        background: #6366f1;
        border-radius: 99px;
    }

    .st-time-chip {
        background: rgba(30, 41, 59, 0.8);
        border: 1px solid rgba(255, 255, 255, 0.05);
        border-radius: 20px;
        padding: 16px 24px;
        transition: all 0.3s;
    }
    .st-time-chip:hover {
        background: #6366f1;
        border-color: #6366f1;
        transform: translateY(-4px);
        box-shadow: 0 10px 20px rgba(99, 102, 241, 0.3);
    }
</style>
</head>

<body>
    <jsp:include page="/common/header.jsp"/>

    <div class="page-wrapper">
        <div class="max-w-7xl mx-auto px-6">
            <!-- Breadcrumb -->
            <div class="flex items-center gap-4 mb-10">
                <a href="${pageContext.request.contextPath}/movie" class="group flex items-center gap-2 text-slate-400 hover:text-white transition-colors">
                    <div class="w-10 h-10 rounded-full bg-white/5 flex items-center justify-center group-hover:bg-indigo-500 transition-all">
                        <i class="fas fa-arrow-left text-xs"></i>
                    </div>
                    <span class="font-bold text-sm uppercase tracking-widest">Danh sách phim</span>
                </a>
            </div>

            <!-- Main Content Card -->
            <div class="glass-card p-10 lg:p-16 mb-12">
                <div class="flex flex-col lg:flex-row gap-16">
                    <!-- Left: Poster -->
                    <div class="lg:w-[400px] shrink-0 relative">
                        <div class="poster-wrapper">
                            <img src="${movie.poster}" alt="${movie.title}" 
                                 class="w-full h-full object-cover"
                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie1.jpg'">
                        </div>
                        <div class="poster-glow"></div>
                        
                        <!-- Mini Badges -->
                        <div class="flex flex-wrap gap-3 mt-8">
                            <div class="px-4 py-2 rounded-xl bg-indigo-500/10 border border-indigo-500/20 text-indigo-400 text-[10px] font-black uppercase tracking-wider">
                                ${movie.status}
                            </div>
                            <div class="px-4 py-2 rounded-xl bg-white/5 border border-white/10 text-slate-300 text-[10px] font-black uppercase tracking-wider">
                                <i class="far fa-clock mr-1"></i> ${movie.duration} Phút
                            </div>
                        </div>
                    </div>

                    <!-- Right: Details -->
                    <div class="flex-1 pt-4">
                        <h1 class="movie-title">${movie.title}</h1>
                        
                        <div class="mb-10">
                            <table class="info-table">
                                <tr>
                                    <td class="label">Thể loại</td>
                                    <td class="value">${movie.genre}</td>
                                </tr>
                                <tr>
                                    <td class="label">Đạo diễn</td>
                                    <td class="value">${movie.director != null ? movie.director : 'Đang cập nhật'}</td>
                                </tr>
                                <tr>
                                    <td class="label">Diễn viên</td>
                                    <td class="value">${movie.cast != null ? movie.cast : 'Đang cập nhật'}</td>
                                </tr>
                                <tr>
                                    <td class="label">Khởi chiếu</td>
                                    <td class="value">
                                        <fmt:formatDate value="${movie.releaseDate}" pattern="dd/MM/yyyy"/>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="flex flex-wrap gap-6 items-center">
                            <button id="btnTrailer" class="flex items-center gap-3 px-8 py-4 rounded-2xl bg-white/5 border border-white/10 hover:bg-white/10 transition-all font-bold">
                                <i class="fas fa-play text-indigo-400"></i> Xem Trailer
                            </button>
                            <a href="#booking-section" class="btn-buy flex items-center gap-3 px-10 py-5 rounded-2xl text-white font-black uppercase tracking-wider text-sm">
                                <i class="fas fa-ticket-alt"></i> Đặt vé ngay
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tabs Section -->
            <div id="booking-section" class="glass-card p-10 lg:p-16">
                <div class="flex gap-10 border-b border-white/5 mb-10">
                    <button class="tab-btn active" data-tab="synopsis">Nội dung cốt truyện</button>
                    <button class="tab-btn" data-tab="schedule">Suất chiếu hôm nay</button>
                </div>

                <div id="tab-synopsis" class="tab-pane active">
                    <div class="max-w-3xl">
                        <h3 class="text-indigo-400 font-black uppercase tracking-[3px] text-xs mb-4">Tóm tắt phim</h3>
                        <p class="text-slate-400 text-lg leading-relaxed italic">
                            "${movie.description != null ? movie.description : 'Thông tin đang được cập nhật...'}"
                        </p>
                    </div>
                </div>

                <div id="tab-schedule" class="tab-pane">
                    <c:choose>
                        <c:when test="${not empty todayShowtimes}">
                            <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-6">
                                <c:forEach var="s" items="${todayShowtimes}">
                                    <a href="${pageContext.request.contextPath}/booking-seat?showtimeId=${s.showtimeId}" class="st-time-chip group">
                                        <div class="text-2xl font-black text-white group-hover:scale-110 transition-transform">
                                            <fmt:formatDate value="${s.startTime}" pattern="HH:mm" />
                                        </div>
                                        <div class="text-[10px] font-bold text-slate-500 group-hover:text-white uppercase tracking-widest mt-1">
                                            ${s.roomName}
                                        </div>
                                    </a>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="py-20 text-center bg-white/5 rounded-[30px] border border-dashed border-white/10">
                                <div class="w-20 h-20 bg-white/5 rounded-full flex items-center justify-center mx-auto mb-6">
                                    <i class="fas fa-calendar-times text-3xl text-slate-600"></i>
                                </div>
                                <h4 class="text-xl font-bold text-slate-300">Không có suất chiếu hôm nay</h4>
                                <p class="text-slate-500 mt-2">Vui lòng quay lại sau hoặc xem lịch chiếu các ngày tiếp theo.</p>
                                <a href="${pageContext.request.contextPath}/showtime" class="inline-block mt-8 text-indigo-400 font-bold hover:underline">
                                    Xem lịch chiếu toàn quốc <i class="fas fa-external-link-alt ml-2 text-xs"></i>
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Trailer Modal -->
    <div id="trailerModal" class="fixed inset-0 z-[100] hidden items-center justify-center p-6 bg-black/95 backdrop-blur-xl">
        <div class="w-full max-w-5xl">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-black text-white italic tracking-tighter">TRAILER: ${movie.title}</h2>
                <button id="closeTrailer" class="w-12 h-12 rounded-full bg-white/10 flex items-center justify-center hover:bg-rose-500 transition-all">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="aspect-video rounded-[40px] overflow-hidden border border-white/10 shadow-2xl bg-black">
                <iframe id="trailerFrame" width="100%" height="100%" src="" frameborder="0" allowfullscreen></iframe>
            </div>
        </div>
    </div>

    <jsp:include page="/common/footer.jsp"/>

    <script>
        // Tabs Logic
        document.querySelectorAll('.tab-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
                document.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));
                document.getElementById('tab-' + btn.dataset.tab).classList.add('active');
            });
        });

        // Trailer Logic
        const modal = document.getElementById('trailerModal');
        const frame = document.getElementById('trailerFrame');
        const trailerUrl = "${movie.trailerUrl}".replace("watch?v=", "embed/");

        document.getElementById('btnTrailer').addEventListener('click', () => {
            frame.src = trailerUrl + (trailerUrl.includes('?') ? '&' : '?') + "autoplay=1";
            modal.style.display = 'flex';
        });

        const closeModal = () => {
            modal.style.display = 'none';
            frame.src = "";
        };

        document.getElementById('closeTrailer').addEventListener('click', closeModal);
        modal.addEventListener('click', (e) => { if(e.target === modal) closeModal(); });
        document.addEventListener('keydown', (e) => { if(e.key === 'Escape') closeModal(); });
    </script>
</body>
</html>
