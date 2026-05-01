<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>${movie.title} | BOBIXI Cinema</title>

<!-- FontAwesome & Tailwind -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">

<style>
  body { font-family: 'Outfit', sans-serif; background-color: #0f172a; }
</style>
</head>

<body class="text-slate-200">
  <jsp:include page="/common/header.jsp"/>

  <main class="min-h-screen">
    <!-- Hero Section with Background Backdrop -->
    <div class="relative w-full py-16 lg:py-24 overflow-hidden">
      <!-- Background Image with Blur -->
      <div class="absolute inset-0 z-0">
        <img src="${pageContext.request.contextPath}/assets/images/movies/${movie.poster}" 
             class="w-full h-full object-cover blur-3xl opacity-20" alt="backdrop">
        <div class="absolute inset-0 bg-gradient-to-b from-slate-900/50 via-slate-900 to-slate-900"></div>
      </div>

      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <a href="${pageContext.request.contextPath}/movie" class="inline-flex items-center gap-2 text-slate-400 hover:text-white transition-colors mb-8 group">
          <i class="fas fa-arrow-left group-hover:-translate-x-1 transition-transform"></i>
          Quay lại danh sách
        </a>

        <div class="flex flex-col lg:flex-row gap-12">
          <!-- Poster -->
          <div class="w-full lg:w-80 flex-shrink-0">
            <div class="rounded-3xl overflow-hidden shadow-2xl shadow-black/50 border border-white/10">
              <img src="${pageContext.request.contextPath}/assets/images/movies/${movie.poster}" 
                   alt="${movie.title}" class="w-full h-auto"
                   onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie1.jpg'">
            </div>
          </div>

          <!-- Content -->
          <div class="flex-1">
            <div class="flex flex-wrap gap-3 mb-6">
              <span class="px-4 py-1.5 bg-red-500/20 text-red-400 border border-red-500/30 rounded-xl text-sm font-bold tracking-wider">
                ${movie.status}
              </span>
              <span class="px-4 py-1.5 bg-yellow-500/20 text-yellow-400 border border-yellow-500/30 rounded-xl text-sm font-bold flex items-center gap-2">
                <i class="fas fa-star"></i> ${movie.rating}
              </span>
            </div>

            <h1 class="text-4xl lg:text-6xl font-extrabold text-white mb-8 leading-tight">
              ${movie.title}
            </h1>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-y-4 gap-x-12 mb-10 text-slate-300">
              <div class="flex items-center gap-4 py-3 border-b border-white/5">
                <span class="w-24 text-slate-500 font-medium">Thể loại</span>
                <span class="font-semibold text-white">${movie.genre}</span>
              </div>
              <div class="flex items-center gap-4 py-3 border-b border-white/5">
                <span class="w-24 text-slate-500 font-medium">Thời lượng</span>
                <span class="font-semibold text-white">${movie.duration} phút</span>
              </div>
              <div class="flex items-center gap-4 py-3 border-b border-white/5">
                <span class="w-24 text-slate-500 font-medium">Đạo diễn</span>
                <span class="font-semibold text-white">${movie.director != null ? movie.director : 'Đang cập nhật'}</span>
              </div>
              <div class="flex items-center gap-4 py-3 border-b border-white/5">
                <span class="w-24 text-slate-500 font-medium">Khởi chiếu</span>
                <span class="font-semibold text-white"><fmt:formatDate value="${movie.releaseDate}" pattern="dd/MM/yyyy"/></span>
              </div>
            </div>

            <div class="flex flex-wrap gap-4">
              <a href="${pageContext.request.contextPath}/booking-seat?movieId=${movie.movieId}" 
                 class="px-10 py-4 bg-gradient-to-r from-red-600 to-rose-600 hover:from-red-500 hover:to-rose-500 text-white font-black rounded-2xl shadow-xl shadow-red-900/20 transition-all flex items-center gap-3 transform hover:-translate-y-1">
                <i class="fas fa-ticket-alt"></i> ĐẶT VÉ NGAY
              </a>
              <button id="btnTrailer" class="px-10 py-4 bg-white/5 hover:bg-white/10 text-white border border-white/10 font-bold rounded-2xl transition-all flex items-center gap-3 transform hover:-translate-y-1">
                <i class="fas fa-play"></i> XEM TRAILER
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Details Tabs Section -->
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pb-24">
      <div class="bg-slate-800/40 backdrop-blur-xl rounded-[2.5rem] border border-white/5 overflow-hidden">
        <div class="flex border-b border-white/5 bg-white/5">
          <button class="tab-item active px-10 py-6 font-bold text-slate-400 hover:text-white transition-all relative" data-tab="synopsis">
            NỘI DUNG PHIM
          </button>
          <button class="tab-item px-10 py-6 font-bold text-slate-400 hover:text-white transition-all relative" data-tab="schedule">
            LỊCH CHIẾU HÔM NAY
          </button>
        </div>

        <div class="p-10">
          <!-- Synopsis Tab -->
          <div id="tab-synopsis" class="tab-pane active animate-in fade-in slide-in-from-bottom-4 duration-500">
            <p class="text-lg leading-relaxed text-slate-400 max-w-4xl italic">
              ${movie.description != null ? movie.description : 'Đang cập nhật nội dung cho bộ phim này...'}
            </p>
          </div>

          <!-- Schedule Tab -->
          <div id="tab-schedule" class="tab-pane hidden animate-in fade-in slide-in-from-bottom-4 duration-500">
            <c:choose>
              <c:when test="${not empty todayShowtimes}">
                <div class="grid grid-cols-2 sm:grid-cols-4 lg:grid-cols-6 gap-4">
                  <c:forEach var="s" items="${todayShowtimes}">
                    <a href="${pageContext.request.contextPath}/booking-seat?showtimeId=${s.showtimeId}" 
                       class="group bg-slate-900/50 hover:bg-red-500 border border-white/5 hover:border-red-400 p-5 rounded-2xl transition-all text-center">
                      <span class="block text-2xl font-black text-white group-hover:scale-110 transition-transform">
                        <fmt:formatDate value="${s.startTime}" pattern="HH:mm" />
                      </span>
                      <span class="block text-xs text-slate-500 group-hover:text-red-100 mt-1 uppercase font-bold tracking-tighter">
                        ${s.roomName}
                      </span>
                    </a>
                  </c:forEach>
                </div>
              </c:when>
              <c:otherwise>
                <div class="py-16 text-center border-2 border-dashed border-white/5 rounded-3xl">
                  <i class="fas fa-calendar-times text-slate-700 text-5xl mb-4"></i>
                  <p class="text-slate-500 text-lg mb-6">Hiện tại không có suất chiếu nào cho ngày hôm nay.</p>
                  <a href="${pageContext.request.contextPath}/showtime" class="inline-flex items-center gap-2 text-red-500 font-bold hover:underline">
                    Xem toàn bộ lịch chiếu <i class="fas fa-chevron-right text-xs"></i>
                  </a>
                </div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </div>
  </main>

  <!-- Trailer Modal -->
  <div id="trailerModal" class="fixed inset-0 z-[100] hidden items-center justify-center p-4 bg-black/95 backdrop-blur-sm">
    <div class="relative w-full max-w-5xl">
      <button id="closeTrailer" class="absolute -top-12 right-0 text-white text-4xl hover:text-red-500 transition-colors">
        <i class="fas fa-times"></i>
      </button>
      <div class="aspect-video bg-black rounded-3xl overflow-hidden shadow-2xl">
        <iframe id="trailerFrame" class="w-full h-full" src="" frameborder="0" allowfullscreen></iframe>
      </div>
    </div>
  </div>

  <jsp:include page="/common/footer.jsp"/>

  <style>
    .tab-item.active { color: white; }
    .tab-item.active::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      height: 4px;
      background: #ef4444;
      border-radius: 4px 4px 0 0;
    }
    .animate-in { animation-name: enter; }
    @keyframes enter {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }
  </style>

  <script>
    // Tabs logic
    document.querySelectorAll('.tab-item').forEach(item => {
      item.addEventListener('click', () => {
        document.querySelectorAll('.tab-item').forEach(i => i.classList.remove('active'));
        item.classList.add('active');
        document.querySelectorAll('.tab-pane').forEach(p => p.classList.add('hidden'));
        document.getElementById('tab-' + item.dataset.tab).classList.remove('hidden');
      });
    });

    // Trailer logic
    const modal = document.getElementById('trailerModal');
    const frame = document.getElementById('trailerFrame');
    const rawUrl = "${movie.trailerUrl}";
    
    function getEmbedUrl(url) {
      if(!url) return "";
      let id = "";
      if(url.includes("v=")) id = url.split("v=")[1].split("&")[0];
      else if(url.includes("youtu.be/")) id = url.split("youtu.be/")[1].split("?")[0];
      return id ? "https://www.youtube.com/embed/" + id : "";
    }

    document.getElementById('btnTrailer').addEventListener('click', () => {
      const embed = getEmbedUrl(rawUrl);
      if(!embed) { alert("Trailer hiện tại không khả dụng."); return; }
      frame.src = embed + "?autoplay=1";
      modal.classList.remove('hidden');
      modal.classList.add('flex');
    });

    const closeModal = () => { 
      modal.classList.add('hidden'); 
      modal.classList.remove('flex'); 
      frame.src = ""; 
    };
    document.getElementById('closeTrailer').addEventListener('click', closeModal);
    modal.addEventListener('click', (e) => { if(e.target === modal) closeModal(); });
  </script>
</body>
</html>
