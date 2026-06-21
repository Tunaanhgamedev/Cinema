<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Danh sách phim | BOBIXI Cinema</title>
  
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
  </style>
</head>

<body class="text-slate-200 min-h-screen flex flex-col">
  <jsp:include page="/common/header.jsp" />

  <main class="flex-grow pt-28 pb-20">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

      <!-- Premium Toolbar -->
      <div class="glass-card rounded-[2.5rem] p-8 mb-12">
        <div class="flex flex-col lg:flex-row justify-between items-center gap-6">
          <div>
            <h1 class="text-4xl md:text-5xl font-black text-white italic uppercase tracking-tighter flex items-center gap-3">
              <span class="text-red-500">🎬</span>
              DANH SÁCH PHIM
            </h1>
            <p class="text-xs text-slate-500 font-bold uppercase tracking-widest mt-1">Cập nhật liên tục những siêu phẩm điện ảnh</p>
          </div>

          <div class="flex flex-col md:flex-row items-center gap-4 w-full lg:w-auto">
            <form onsubmit="return false;" class="flex flex-wrap md:flex-nowrap gap-3 w-full">
              <!-- Search Input -->
              <div class="relative w-full md:w-80">
                <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-slate-500"></i>
                <input type="text" name="q" value="${param.q}"
                  class="w-full pl-12 pr-4 py-3.5 bg-slate-950/60 border border-white/5 focus:border-red-500 rounded-2xl focus:ring-0 transition-all outline-none text-white placeholder-slate-600 font-medium"
                  placeholder="Tìm tên phim...">
              </div>

              <!-- Sort Dropdown -->
              <select name="sort"
                class="px-5 py-3.5 bg-slate-950/60 border border-white/5 focus:border-red-500 rounded-2xl focus:ring-0 outline-none text-slate-400 font-bold cursor-pointer transition-all">
                <option value="newest" ${selectedSort=='newest' ? 'selected' : '' }>Mới nhất</option>
                <option value="oldest" ${selectedSort=='oldest' ? 'selected' : '' }>Cũ nhất</option>
                <option value="alphabetical" ${selectedSort=='alphabetical' ? 'selected' : '' }>A - Z</option>
              </select>
            </form>

            <a href="${pageContext.request.contextPath}/showtime"
              class="w-full md:w-auto bg-gradient-to-r from-red-600 to-rose-600 hover:from-red-500 hover:to-rose-500 text-white px-8 py-3.5 rounded-2xl font-black text-xs uppercase tracking-widest shadow-xl shadow-red-900/20 transition-all text-center whitespace-nowrap">
              XEM LỊCH CHIẾU
            </a>
          </div>
        </div>
      </div>

      <!-- Movie Grid Container -->
      <div id="movieGrid">
        <jsp:include page="/pages/clients/movie/movie-grid-fragment.jsp" />
      </div>

    </div>
  </main>

  <jsp:include page="/common/footer.jsp" />

  <script>
    // AJAX Search logic
    const searchInput = document.querySelector('input[name="q"]');
    const sortSelect = document.querySelector('select[name="sort"]');
    const movieGrid = document.getElementById('movieGrid');

    function updateGrid() {
      const q = encodeURIComponent(searchInput.value);
      const sort = sortSelect.value;
      const url = `${pageContext.request.contextPath}/movie?ajax=true&q=${q}&sort=${sort}`;
      
      console.log("[MovieSearch] Fetching from url:", url);
      fetch(url)
        .then(res => {
          if (!res.ok) throw new Error("Network response was not ok");
          return res.text();
        })
        .then(html => {
          movieGrid.innerHTML = html;
        })
        .catch(err => console.error("Error updates movie grid:", err));
    }

    let timeout;
    searchInput.addEventListener('input', () => {
      clearTimeout(timeout);
      timeout = setTimeout(updateGrid, 400);
    });
    
    sortSelect.addEventListener('change', updateGrid);
  </script>
</body>

</html>
