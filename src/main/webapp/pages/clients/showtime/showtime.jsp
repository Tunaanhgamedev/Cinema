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

  <!-- Hero Section -->
  <section class="bg-slate-900 py-16 relative overflow-hidden">
    <div class="absolute inset-0 opacity-20">
        <div class="absolute inset-0 bg-gradient-to-br from-red-600 to-transparent"></div>
    </div>
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10 text-center md:text-left">
      <div class="inline-flex items-center gap-2 bg-red-600 text-white px-4 py-1.5 rounded-full text-xs font-black uppercase tracking-widest mb-6 shadow-lg shadow-red-500/20">
        <i class="fas fa-calendar-alt"></i> Suất chiếu tại rạp
      </div>
      <h1 class="text-4xl md:text-5xl font-black text-white mb-4 tracking-tighter">
        BOBIXI Cinema • Đà Nẵng
      </h1>
      <p class="text-slate-400 text-lg max-w-2xl">
        Khám phá lịch chiếu phim mới nhất. Chọn ngày và đặt vé ngay để tận hưởng những phút giây thư giãn tuyệt vời.
      </p>
    </div>
  </section>

  <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 -mt-10 pb-20">
    <!-- Toolbar & Dates Panel -->
    <div class="bg-white rounded-[2.5rem] shadow-2xl shadow-slate-200/50 border border-slate-100 p-8 mb-12">
      <div class="flex flex-col lg:flex-row justify-between items-center gap-8 mb-10">
        <!-- Date Selection Logic moved from Movie List -->
        <div class="flex gap-3 overflow-x-auto pb-4 w-full lg:w-auto scrollbar-hide">
          <c:forEach var="d" items="${availableDates}">
            <fmt:formatDate value="${d}" pattern="yyyy-MM-dd" var="iso" />
            <fmt:formatDate value="${d}" pattern="E" var="dayOfWeek" />
            <fmt:formatDate value="${d}" pattern="dd/MM" var="label" />
            
            <a href="${pageContext.request.contextPath}/showtime?date=${iso}" 
               class="flex-shrink-0 w-24 py-4 rounded-3xl flex flex-col items-center justify-center transition-all duration-300 group
               ${iso == selectedDate ? 'bg-red-500 text-white shadow-xl shadow-red-200 scale-105' : 'bg-slate-50 text-slate-500 hover:bg-slate-100 hover:text-red-500'}">
               <span class="text-[10px] font-black uppercase tracking-widest opacity-60 mb-1">${dayOfWeek}</span>
               <span class="text-xl font-black">${label}</span>
            </a>
          </c:forEach>
        </div>

        <!-- Search Box -->
        <div class="w-full lg:w-96">
          <form action="${pageContext.request.contextPath}/showtime" method="GET" class="relative">
            <input type="hidden" name="date" value="${selectedDate}">
            <i class="fas fa-search absolute left-5 top-1/2 -translate-y-1/2 text-slate-400"></i>
            <input type="text" name="q" value="${param.q}" id="qInput"
                   class="w-full pl-14 pr-6 py-4 bg-slate-50 border-none rounded-3xl focus:ring-2 focus:ring-red-500 outline-none text-slate-700 font-bold placeholder:font-medium" 
                   placeholder="Tìm tên phim...">
          </form>
        </div>
      </div>

      <!-- Showtime List -->
      <div id="showtimeList" class="space-y-8">
        <c:choose>
            <c:when test="${not empty movieShowtimes}">
                <c:forEach var="entry" items="${movieShowtimes}">
                    <c:set var="m" value="${entry.key}"/>
                    <c:set var="sts" value="${entry.value}"/>
                    
                    <div class="group bg-white rounded-[2rem] border border-slate-100 p-6 hover:shadow-xl transition-all duration-500 flex flex-col md:flex-row gap-8">
                        <!-- Poster -->
                        <div class="w-full md:w-48 flex-shrink-0 aspect-[2/3] rounded-2xl overflow-hidden shadow-lg shadow-slate-200/50">
                            <img src="${pageContext.request.contextPath}/assets/images/movies/${m.poster}" 
                                 alt="${m.title}" 
                                 class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie1.jpg'">
                        </div>

                        <!-- Details -->
                        <div class="flex-1 flex flex-col justify-center">
                            <div class="mb-6">
                                <div class="flex items-center gap-3 mb-3">
                                    <span class="bg-red-50 text-red-500 text-[10px] font-black px-3 py-1 rounded-full uppercase tracking-widest">
                                        ${m.genre}
                                    </span>
                                    <span class="text-slate-400 text-sm font-bold">
                                        <i class="far fa-clock mr-1"></i> ${m.duration} phút
                                    </span>
                                </div>
                                <h3 class="text-2xl md:text-3xl font-black text-slate-800 mb-2 group-hover:text-red-600 transition-colors uppercase italic tracking-tighter">
                                    ${m.title}
                                </h3>
                                <div class="flex items-center gap-2 text-yellow-500 font-bold text-sm">
                                    <i class="fas fa-star"></i> ${m.rating > 0 ? m.rating : '8.5'}
                                    <span class="text-slate-300 ml-2">|</span>
                                    <span class="text-slate-500 font-medium">BOBIXI Đà Nẵng</span>
                                </div>
                            </div>

                            <div class="flex flex-wrap gap-3">
                                <c:forEach var="s" items="${sts}">
                                    <a href="${pageContext.request.contextPath}/booking-seat?showtimeId=${s.showtimeId}" 
                                       class="flex flex-col items-center bg-slate-50 hover:bg-red-500 border border-slate-100 hover:border-red-500 px-6 py-3 rounded-2xl transition-all group/btn shadow-sm hover:shadow-lg hover:shadow-red-200">
                                        <span class="text-lg font-black text-slate-800 group-hover/btn:text-white leading-none">
                                            <fmt:formatDate value="${s.startTime}" pattern="HH:mm" />
                                        </span>
                                        <span class="text-[9px] font-black uppercase tracking-widest text-slate-400 group-hover/btn:text-white/80 mt-1">
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
                <div class="py-20 text-center bg-slate-50 rounded-[2rem] border border-dashed border-slate-200">
                    <div class="w-20 h-20 bg-white rounded-full flex items-center justify-center mx-auto mb-6 text-slate-200 shadow-sm">
                        <i class="fas fa-film text-3xl"></i>
                    </div>
                    <h2 class="text-xl font-black text-slate-400 uppercase tracking-widest">Không có suất chiếu nào</h2>
                    <p class="text-slate-400 text-sm mt-2 font-medium">Vui lòng chọn ngày khác hoặc quay lại sau nhé!</p>
                </div>
            </c:otherwise>
        </c:choose>
      </div>
    </div>
  </main>

  <jsp:include page="/common/footer.jsp" />

  <script>
    const qInput = document.getElementById('qInput');
    const showtimeList = document.getElementById('showtimeList');

    function updateList() {
        const q = qInput.value;
        const date = "${selectedDate}";
        
        fetch(`${pageContext.request.contextPath}/showtime?ajax=true&q=${q}&date=${date}`)
            .then(res => res.text())
            .then(html => {
                showtimeList.innerHTML = html;
            });
    }

    let timeout;
    qInput.addEventListener('input', () => {
        clearTimeout(timeout);
        timeout = setTimeout(updateList, 500);
    });
  </script>
</body>
</html>
