<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

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
        <c:set var="pUrl" value="${movie.poster}" />
        <c:if test="${not empty pUrl && !fn:startsWith(pUrl, 'http') && !fn:startsWith(pUrl, 'assets/')}">
            <c:set var="pUrl" value="assets/images/movies/${pUrl}" />
        </c:if>
        <c:set var="fPUrl" value="${fn:startsWith(pUrl, 'http') ? pUrl : pageContext.request.contextPath.concat('/').concat(pUrl)}" />
        <img src="${fPUrl}" 
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
            <div class="rounded-3xl overflow-hidden shadow-2xl shadow-black/50 border border-white/10 group">
              <img src="${fPUrl}" 
                   alt="${movie.title}" class="w-full h-auto group-hover:scale-105 transition-transform duration-700"
                   onerror="this.src='https://placehold.co/600x900?text=${movie.title}'">
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
          <button class="tab-item px-10 py-6 font-bold text-slate-400 hover:text-white transition-all relative" data-tab="reviews">
            ĐÁNH GIÁ & BÌNH LUẬN (${reviews.size()})
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

          <!-- Reviews Tab -->
          <div id="tab-reviews" class="tab-pane hidden animate-in fade-in slide-in-from-bottom-4 duration-500">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-12">
              <!-- Post Review Form -->
              <div class="lg:col-span-1">
                <div class="bg-white/5 border border-white/10 rounded-3xl p-8 sticky top-8">
                  <h3 class="text-xl font-bold text-white mb-6">Gửi đánh giá của bạn</h3>
                  <c:choose>
                    <c:when test="${not empty sessionScope.authUser}">
                      <form action="${pageContext.request.contextPath}/movie/review" method="post">
                        <input type="hidden" name="movieId" value="${movie.movieId}">
                        
                        <label class="block text-slate-400 text-sm font-bold mb-3">Xếp hạng của bạn</label>
                        <div class="flex gap-2 mb-6">
                          <div class="rating-input flex flex-row-reverse">
                            <input type="radio" id="star5" name="rating" value="5" class="hidden" required/><label for="star5" class="fas fa-star cursor-pointer text-2xl text-slate-600 hover:text-yellow-400 transition-colors"></label>
                            <input type="radio" id="star4" name="rating" value="4" class="hidden"/><label for="star4" class="fas fa-star cursor-pointer text-2xl text-slate-600 hover:text-yellow-400 transition-colors"></label>
                            <input type="radio" id="star3" name="rating" value="3" class="hidden"/><label for="star3" class="fas fa-star cursor-pointer text-2xl text-slate-600 hover:text-yellow-400 transition-colors"></label>
                            <input type="radio" id="star2" name="rating" value="2" class="hidden"/><label for="star2" class="fas fa-star cursor-pointer text-2xl text-slate-600 hover:text-yellow-400 transition-colors"></label>
                            <input type="radio" id="star1" name="rating" value="1" class="hidden"/><label for="star1" class="fas fa-star cursor-pointer text-2xl text-slate-600 hover:text-yellow-400 transition-colors"></label>
                          </div>
                        </div>

                        <label class="block text-slate-400 text-sm font-bold mb-3 flex justify-between">
                          Nội dung bình luận
                          <span id="charCount" class="text-[10px] text-slate-600 font-normal">0/500</span>
                        </label>
                        <textarea name="content" id="reviewContent" rows="4" required maxlength="500"
                                  class="w-full bg-slate-900 border border-white/10 rounded-2xl p-4 text-white placeholder-slate-600 focus:outline-none focus:border-red-500 transition-all mb-6"
                                  placeholder="Cảm nhận của bạn về phim..."></textarea>
                        
                        <button type="submit" class="w-full py-4 bg-red-600 hover:bg-red-500 text-white font-black rounded-2xl transition-all shadow-lg shadow-red-900/20">
                          GỬI BÌNH LUẬN
                        </button>
                      </form>
                    </c:when>
                    <c:otherwise>
                      <div class="text-center py-6">
                        <p class="text-slate-500 mb-6">Vui lòng đăng nhập để gửi đánh giá cho phim này.</p>
                        <a href="${pageContext.request.contextPath}/login?returnUrl=/movie?id=${movie.movieId}" 
                           class="inline-block px-8 py-3 bg-white/10 hover:bg-white/20 text-white font-bold rounded-xl transition-all border border-white/10">
                          ĐĂNG NHẬP NGAY
                        </a>
                      </div>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>

              <!-- Review List -->
              <div class="lg:col-span-2 space-y-6">
                <c:choose>
                  <c:when test="${not empty reviews}">
                    <c:forEach var="r" items="${reviews}">
                      <div class="bg-white/5 border border-white/5 p-8 rounded-3xl group hover:border-white/10 transition-all">
                        <div class="flex justify-between items-start mb-4">
                          <div class="flex items-center gap-4">
                            <div class="w-12 h-12 rounded-full bg-gradient-to-br from-red-500 to-rose-600 flex items-center justify-center font-black text-white text-lg">
                              ${r.userName.substring(0, 1).toUpperCase()}
                            </div>
                            <div>
                              <h4 class="font-bold text-white">${r.userName}</h4>
                              <p class="text-xs text-slate-500"><fmt:formatDate value="${r.createdAt}" pattern="dd/MM/yyyy HH:mm"/></p>
                            </div>
                          </div>
                          <div class="flex gap-1 text-yellow-500">
                            <c:forEach begin="1" end="${r.rating}">
                              <i class="fas fa-star text-sm"></i>
                            </c:forEach>
                            <c:forEach begin="${r.rating + 1}" end="5">
                              <i class="fas fa-star text-sm text-slate-700"></i>
                            </c:forEach>
                          </div>
                        </div>
                        <p class="text-slate-300 leading-relaxed italic">
                          "${r.content}"
                        </p>
                      </div>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <div class="text-center py-16 bg-white/5 rounded-3xl border-2 border-dashed border-white/5">
                      <i class="far fa-comment-dots text-slate-700 text-5xl mb-4"></i>
                      <p class="text-slate-500">Chưa có bình luận nào. Hãy là người đầu tiên đánh giá phim này!</p>
                    </div>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
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

    /* Rating Star Styling */
    .rating-input input:checked ~ label { color: #facc15; }
    .rating-input label:hover ~ label { color: #facc15; }
    .rating-input label:hover { color: #facc15; }
  </style>

  <script>
    // Tabs logic
    const tabItems = document.querySelectorAll('.tab-item');
    const tabPanes = document.querySelectorAll('.tab-pane');
    
    function switchTab(tabId) {
      tabItems.forEach(i => {
        if(i.dataset.tab === tabId) i.classList.add('active');
        else i.classList.remove('active');
      });
      tabPanes.forEach(p => {
        if(p.id === 'tab-' + tabId) p.classList.remove('hidden');
        else p.classList.add('hidden');
      });
    }

    tabItems.forEach(item => {
      item.addEventListener('click', () => switchTab(item.dataset.tab));
    });

    // Check URL for tab parameter
    const urlParams = new URLSearchParams(window.location.search);
    const activeTab = urlParams.get('tab');
    if (activeTab) {
      switchTab(activeTab);
      // Smooth scroll to tab container after a short delay
      setTimeout(() => {
        document.getElementById('tab-' + activeTab).scrollIntoView({ behavior: 'smooth', block: 'center' });
      }, 300);
    }

    // Character counter logic
    const textarea = document.getElementById('reviewContent');
    const charCount = document.getElementById('charCount');
    if(textarea) {
      textarea.addEventListener('input', () => {
        const length = textarea.value.length;
        charCount.textContent = length + '/500';
        if(length >= 450) charCount.classList.add('text-red-500');
        else charCount.classList.remove('text-red-500');
      });
    }

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
