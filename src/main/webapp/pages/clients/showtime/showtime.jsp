<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Lịch chiếu | BOBIXI Cinema</title>

<!-- FontAwesome & Tailwind -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800;900&display=swap" rel="stylesheet">

<style>
  body { font-family: 'Outfit', sans-serif; background-color: #0b0f19; }
  .glass-card { 
    background: rgba(30, 41, 59, 0.4); 
    backdrop-filter: blur(20px); 
    border: 1px solid rgba(255,255,255,0.05); 
  }
  /* Hide scrollbar for Chrome, Safari and Opera */
  .scrollbar-hide::-webkit-scrollbar {
    display: none;
  }
  /* Hide scrollbar for IE, Edge and Firefox */
  .scrollbar-hide {
    -ms-overflow-style: none;  /* IE and Edge */
    scrollbar-width: none;  /* Firefox */
  }
</style>
</head>

<body class="text-slate-200 min-h-screen flex flex-col">
  <jsp:include page="/common/header.jsp" />

  <!-- Hero Section -->
  <section class="bg-slate-950/80 pt-48 pb-32 relative overflow-hidden">
    <div class="absolute inset-0 opacity-20">
        <div class="absolute inset-0 bg-gradient-to-br from-indigo-600 via-purple-600 to-transparent"></div>
        <div class="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')] opacity-10"></div>
    </div>
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10 text-center">
      <div class="inline-flex items-center gap-2 bg-indigo-600/20 text-indigo-400 px-5 py-2 rounded-full text-[11px] font-black uppercase tracking-widest mb-8 border border-indigo-500/20">
        <i class="fas fa-calendar-alt animate-bounce"></i> Hệ thống lịch chiếu thông minh
      </div>
      <h1 class="text-5xl md:text-8xl font-black text-white mb-8 tracking-tighter uppercase italic leading-none">
        Lịch <span class="text-transparent bg-clip-text bg-gradient-to-r from-indigo-400 to-purple-400">chiếu</span> phim
      </h1>
      <p class="text-slate-400 text-xl max-w-2xl mx-auto font-medium leading-relaxed">
        Cập nhật liên tục những suất chiếu mới nhất của rạp BOBIXI Cinema.
      </p>
    </div>
  </section>

  <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16 flex-grow">
    <!-- Main Toolbar Panel -->
    <div class="glass-card rounded-[3rem] p-8 md:p-12 mb-12">
      
      <!-- Date Selection Row -->
      <div class="mb-16">
        <div class="flex items-center gap-4 mb-10">
            <h2 class="text-[12px] font-black text-indigo-400 uppercase tracking-[0.4em] whitespace-nowrap">Chọn ngày công chiếu</h2>
            <div class="h-px w-full bg-white/5"></div>
        </div>
        
        <div class="flex gap-5 overflow-x-auto pb-6 scrollbar-hide snap-x">
          <c:forEach var="d" items="${availableDates}">
            <fmt:formatDate value="${d}" pattern="yyyy-MM-dd" var="iso" />
            <fmt:formatDate value="${d}" pattern="E" var="dayOfWeek" />
            <fmt:formatDate value="${d}" pattern="dd" var="day" />
            <fmt:formatDate value="${d}" pattern="MM" var="month" />
            
            <a href="${pageContext.request.contextPath}/showtime?date=${iso}" 
               class="flex-shrink-0 w-28 md:w-32 py-8 rounded-[2.5rem] flex flex-col items-center justify-center transition-all duration-500 snap-center
               ${iso == selectedDate ? 'bg-gradient-to-br from-indigo-600 to-purple-600 text-white shadow-2xl scale-110 ring-8 ring-indigo-500/10' : 'bg-slate-950/60 text-slate-400 hover:bg-slate-900/50 hover:shadow-2xl hover:text-white border border-transparent hover:border-indigo-500/20' }">
               <span class="text-[10px] font-black uppercase tracking-[0.2em] opacity-60 mb-3">${dayOfWeek}</span>
               <span class="text-4xl font-black mb-1">${day}</span>
               <span class="text-[10px] font-bold opacity-50 uppercase mt-1">Tháng ${month}</span>
            </a>
          </c:forEach>
        </div>
      </div>

      <!-- Search & Status Row -->
      <div class="flex flex-col md:flex-row justify-between items-center gap-8 pt-8 border-t border-white/5">
        <div class="flex items-center gap-4 bg-slate-950/60 border border-white/5 px-6 py-4 rounded-2xl">
            <span class="w-2.5 h-2.5 bg-red-500 rounded-full animate-ping"></span>
            <p class="text-slate-400 font-bold text-sm">
                Lịch chiếu ngày: 
                <span class="text-red-500 ml-1 font-black">
                    <fmt:parseDate value="${selectedDate}" pattern="yyyy-MM-dd" var="pd"/>
                    <fmt:formatDate value="${pd}" pattern="dd/MM/yyyy"/>
                </span>
            </p>
        </div>

        <div class="w-full md:w-[28rem] relative group">
          <form onsubmit="return false;">
            <input type="hidden" id="selectedDateVal" value="${selectedDate}">
            <i class="fas fa-search absolute left-6 top-1/2 -translate-y-1/2 text-slate-500 group-focus-within:text-red-500 transition-colors"></i>
            <input type="text" name="q" value="${param.q}" id="qInput"
                   oninput="updateList()"
                   class="w-full pl-16 pr-8 py-5 bg-slate-950/60 border-2 border-transparent rounded-[2rem] focus:bg-slate-900 focus:border-red-500/20 focus:ring-4 focus:ring-red-500/5 transition-all outline-none text-white font-bold placeholder:font-medium placeholder:text-slate-500 shadow-sm" 
                   placeholder="Tìm tên phim trong ngày...">
          </form>
        </div>
      </div>
    </div>

    <!-- Showtime List -->
    <div id="showtimeList" class="space-y-10 min-h-[400px]">
        <jsp:include page="/pages/clients/showtime/showtime-list-fragment.jsp" />
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
        
        fetch(contextPath + '/showtime?ajax=true&q=' + encodeURIComponent(q) + '&date=' + selectedDate)
            .then(res => {
                if (!res.ok) throw new Error("HTTP error " + res.status);
                return res.text();
            })
            .then(html => {
                showtimeList.innerHTML = html;
            })
            .catch(err => console.error('Error fetching showtimes:', err));
    }
  </script>
</body>
</html>
