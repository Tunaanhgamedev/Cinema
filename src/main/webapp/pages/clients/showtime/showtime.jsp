<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Lịch chiếu | BOBIXI Cinema</title>
</head>

<body class="bg-slate-50">
  <jsp:include page="/common/header.jsp" />

  <!-- Hero Section (Fixed Padding to avoid overlap) -->
  <section class="bg-slate-900 pt-40 pb-24 relative overflow-hidden">
    <div class="absolute inset-0 opacity-20">
        <div class="absolute inset-0 bg-gradient-to-br from-red-600 to-transparent"></div>
    </div>
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10 text-center">
      <div class="inline-flex items-center gap-2 bg-red-600 text-white px-4 py-1.5 rounded-full text-[10px] font-black uppercase tracking-widest mb-6 shadow-lg shadow-red-500/20">
        <i class="fas fa-calendar-alt"></i> Hệ thống lịch chiếu chuyên nghiệp
      </div>
      <h1 class="text-4xl md:text-7xl font-black text-white mb-6 tracking-tighter uppercase italic">
        Lịch chiếu phim
      </h1>
      <p class="text-slate-400 text-lg max-w-2xl mx-auto font-medium">
        Khám phá lịch chiếu phim mới nhất tại BOBIXI Cinema Đà Nẵng. 
        <br class="hidden md:block">Chọn ngày và đặt vé ngay để tận hưởng những phút giây thư giãn.
      </p>
    </div>
  </section>

  <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
    <!-- Main Toolbar Panel -->
    <div class="bg-white rounded-[3rem] shadow-xl shadow-slate-200/40 border border-slate-100 p-8 md:p-12 mb-12">
      
      <!-- Date Selection Row -->
      <div class="mb-12">
        <div class="flex items-center gap-4 mb-8">
            <h2 class="text-[11px] font-black text-red-500 uppercase tracking-[0.3em] whitespace-nowrap">Chọn ngày xem phim</h2>
            <div class="h-px w-full bg-slate-100"></div>
        </div>
        
        <div class="flex gap-4 overflow-x-auto pb-4 scrollbar-hide">
          <c:forEach var="d" items="${availableDates}">
            <fmt:formatDate value="${d}" pattern="yyyy-MM-dd" var="iso" />
            <fmt:formatDate value="${d}" pattern="E" var="dayOfWeek" />
            <fmt:formatDate value="${d}" pattern="dd/MM" var="label" />
            
            <a href="${pageContext.request.contextPath}/showtime?date=${iso}" 
               class="flex-shrink-0 w-24 md:w-28 py-6 rounded-[2rem] flex flex-col items-center justify-center transition-all duration-500
               ${iso == selectedDate ? 'bg-red-500 text-white shadow-2xl shadow-red-200 scale-105 ring-4 ring-red-500/10' : 'bg-slate-50 text-slate-500 hover:bg-white hover:shadow-xl hover:text-red-500 border border-transparent hover:border-red-100'}">
               <span class="text-[10px] font-black uppercase tracking-widest opacity-60 mb-2">${dayOfWeek}</span>
               <span class="text-2xl font-black">${label}</span>
            </a>
          </c:forEach>
        </div>
      </div>

      <!-- Search & Status Row -->
      <div class="flex flex-col md:flex-row justify-between items-center gap-8 pt-8 border-t border-slate-50">
        <div class="flex items-center gap-4 bg-slate-50 px-6 py-4 rounded-2xl">
            <span class="w-2.5 h-2.5 bg-red-500 rounded-full animate-ping"></span>
            <p class="text-slate-600 font-bold text-sm">
                Lịch chiếu ngày: 
                <span class="text-red-600 ml-1 font-black">
                    <fmt:parseDate value="${selectedDate}" pattern="yyyy-MM-dd" var="pd"/>
                    <fmt:formatDate value="${pd}" pattern="dd/MM/yyyy"/>
                </span>
            </p>
        </div>

        <div class="w-full md:w-[28rem] relative group">
          <form onsubmit="return false;">
            <input type="hidden" id="selectedDateVal" value="${selectedDate}">
            <i class="fas fa-search absolute left-6 top-1/2 -translate-y-1/2 text-slate-300 group-focus-within:text-red-500 transition-colors"></i>
            <input type="text" name="q" value="${param.q}" id="qInput"
                   oninput="updateList()"
                   class="w-full pl-16 pr-8 py-5 bg-slate-50 border-2 border-transparent rounded-[2rem] focus:bg-white focus:border-red-500/20 focus:ring-4 focus:ring-red-500/5 transition-all outline-none text-slate-700 font-bold placeholder:font-medium placeholder:text-slate-400 shadow-sm" 
                   placeholder="Tìm tên phim trong ngày...">
          </form>
        </div>
      </div>
    </div>

    <!-- Showtime List -->
    <div id="showtimeList" class="space-y-10 min-h-[400px]">
        <c:choose>
            <c:when test="${not empty movieShowtimes}">
                <c:forEach var="entry" items="${movieShowtimes}">
                    <c:set var="m" value="${entry.key}"/>
                    <c:set var="sts" value="${entry.value}"/>
                    
                    <div class="group bg-white rounded-[2.5rem] border border-slate-100 p-8 hover:shadow-2xl hover:shadow-slate-200/50 transition-all duration-500 flex flex-col lg:flex-row gap-10">
                        <!-- Poster -->
                        <div class="w-full lg:w-56 flex-shrink-0 aspect-[2/3] rounded-[2rem] overflow-hidden shadow-2xl shadow-slate-300/50 relative">
                            <img src="${pageContext.request.contextPath}/assets/images/movies/${m.poster}" 
                                 alt="${m.title}" 
                                 class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie1.jpg'">
                        </div>

                        <!-- Details -->
                        <div class="flex-1 flex flex-col justify-center">
                            <div class="mb-8">
                                <div class="flex items-center gap-3 mb-4">
                                    <span class="bg-red-50 text-red-500 text-[10px] font-black px-4 py-1.5 rounded-full uppercase tracking-widest border border-red-100">
                                        ${m.genre}
                                    </span>
                                    <span class="flex items-center gap-1 text-yellow-500 font-black text-sm">
                                        <i class="fas fa-star"></i> ${m.rating}
                                    </span>
                                </div>
                                <h3 class="text-3xl md:text-4xl font-black text-slate-800 mb-4 group-hover:text-red-600 transition-colors uppercase italic tracking-tighter leading-tight">
                                    ${m.title}
                                </h3>
                                <div class="flex items-center gap-2 text-slate-400 font-bold text-sm">
                                    <i class="fas fa-map-marker-alt text-red-500"></i>
                                    <span>BOBIXI Đà Nẵng</span>
                                    <span class="mx-2 opacity-30">•</span>
                                    <span class="bg-slate-100 text-slate-500 px-3 py-0.5 rounded-lg text-[10px] uppercase tracking-widest">2D Digital</span>
                                </div>
                            </div>

                            <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-4">
                                <c:forEach var="s" items="${sts}">
                                    <a href="${pageContext.request.contextPath}/booking-seat?movieId=${m.movieId}&showDate=${selectedDate}&showtimeId=${s.showtimeId}" 
                                       class="flex flex-col items-center bg-slate-50 hover:bg-red-500 border border-slate-100 hover:border-red-500 p-4 rounded-2xl transition-all group/btn shadow-sm hover:shadow-xl hover:shadow-red-200 active:scale-95">
                                        <span class="text-xl font-black text-slate-800 group-hover/btn:text-white leading-none">
                                            <fmt:formatDate value="${s.startTime}" pattern="HH:mm" />
                                        </span>
                                        <span class="text-[9px] font-black uppercase tracking-widest text-slate-400 group-hover/btn:text-white/80 mt-2">
                                            ${s.roomName}
                                        </span>
                                    </a>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="py-32 text-center bg-white rounded-[3rem] border border-dashed border-slate-200 shadow-inner">
                    <div class="w-24 h-24 bg-slate-50 rounded-full flex items-center justify-center mx-auto mb-8 text-slate-200">
                        <i class="fas fa-film text-4xl"></i>
                    </div>
                    <h2 class="text-2xl font-black text-slate-800 uppercase tracking-widest mb-3">Chưa có suất chiếu</h2>
                    <p class="text-slate-400 text-lg font-medium">Chúng tôi đang cập nhật lịch chiếu cho ngày này. Quay lại sau nhé!</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
  </main>

  <jsp:include page="/common/footer.jsp" />

  <script>
    function updateList() {
        const qInput = document.getElementById('qInput');
        const showtimeList = document.getElementById('showtimeList');
        const selectedDate = document.getElementById('selectedDateVal').value;
        const contextPath = '${pageContext.request.contextPath}';
        
        const q = qInput.value;
        
        // Use a relative path to ensure it works across different contexts
        fetch(contextPath + '/showtime?ajax=true&q=' + encodeURIComponent(q) + '&date=' + selectedDate)
            .then(res => res.text())
            .then(html => {
                showtimeList.innerHTML = html;
            })
            .catch(err => console.error('Error fetching showtimes:', err));
    }
  </script>
</body>
</html>
