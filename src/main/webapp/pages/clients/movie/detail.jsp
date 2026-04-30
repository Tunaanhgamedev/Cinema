<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>${movie.title} | BOBIXI Cinema</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
  .mv-detail{
    background: radial-gradient(1200px 600px at 20% 0%, rgba(99,102,241,.25), transparent 55%),
                radial-gradient(900px 520px at 100% 20%, rgba(34,211,238,.20), transparent 55%),
                #0b1020;
    color:#f4f6fb;
    min-height:100vh;
    padding: 18px 0 50px;
  }
  .mv-container{ max-width: 1150px; margin:0 auto; padding: 0 14px; }
  .mv-link{
    display:inline-flex; align-items:center; gap:8px;
    padding:10px 20px;
    border-radius: 16px;
    border:1px solid rgba(255,255,255,.1);
    background: rgba(255,255,255,.05);
    color:#f4f6fb;
    text-decoration:none;
    font-weight:600;
    transition:.2s ease;
  }
  .mv-link:hover{ background: rgba(99, 102, 241, 0.2); border-color: rgba(99, 102, 241, 0.4); }
  .mv-card{
    border:1px solid rgba(255,255,255,.1);
    background: rgba(30, 41, 59, 0.4);
    border-radius: 32px;
    backdrop-filter: blur(20px);
    box-shadow: 0 25px 50px -12px rgba(0,0,0,0.5);
    overflow:hidden;
    margin-top: 20px;
  }
  .mv-main{ display:grid; grid-template-columns: 360px 1fr; gap: 40px; padding: 30px; }
  @media(max-width: 920px){ .mv-main{ grid-template-columns: 1fr; } }
  .mv-poster{ border-radius: 24px; overflow:hidden; border:1px solid rgba(255,255,255,.1); aspect-ratio: 2/3; box-shadow: 0 20px 25px -5px rgba(0,0,0,0.3); }
  .mv-poster img{ width:100%; height:100%; object-fit:cover; }
  .mv-title{ font-size: 3.5rem; font-weight: 900; letter-spacing: -2px; line-height: 1; margin-bottom: 10px; background: linear-gradient(to right, #fff, #94a3b8); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
  .tag{ padding: 6px 14px; border-radius: 12px; background: rgba(99, 102, 241, 0.1); border: 1px solid rgba(99, 102, 241, 0.2); font-weight: 700; font-size: 0.8rem; color: #818cf8; }
  .mv-table{ margin-top: 30px; border-radius: 20px; background: rgba(255,255,255,0.03); padding: 10px; }
  .mv-table table{ width:100%; }
  .mv-table td{ padding: 12px 15px; border-bottom: 1px solid rgba(255,255,255,0.05); }
  .mv-table td.label{ width: 140px; color: #64748b; font-weight: 800; font-size: 0.8rem; text-transform: uppercase; letter-spacing: 1px; }
  .mv-table td.value{ color: #f1f5f9; font-weight: 500; }
  .btn.primary{ background: #6366f1; color: white; border: none; padding: 15px 40px; border-radius: 18px; font-weight: 800; transition: all 0.3s; }
  .btn.primary:hover{ background: #4f46e5; transform: scale(1.05); box-shadow: 0 10px 20px rgba(99, 102, 241, 0.3); }
  .st-time-chip{ display: inline-flex; flex-direction: column; align-items: center; padding: 12px 20px; border-radius: 16px; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: white; text-decoration: none; transition: all 0.2s; }
  .st-time-chip:hover{ background: #6366f1; border-color: #6366f1; transform: translateY(-3px); }
  
  /* Tabs */
  .tab-btn{ padding: 12px 24px; border-radius: 12px; font-weight: 800; color: #94a3b8; transition: all 0.3s; }
  .tab-btn.active{ color: #6366f1; background: rgba(99, 102, 241, 0.1); }
  .tab-pane{ display:none; padding: 20px 0; }
  .tab-pane.active{ display:block; }

  /* Modal */
  .modal-overlay{ position: fixed; inset:0; background: rgba(0,0,0,.9); display:none; align-items:center; justify-content:center; z-index: 9999; backdrop-filter: blur(10px); }
  .modal-overlay.show{ display:flex; }
  .modal-content-wrap{ width: min(1000px, 95%); }
</style>
</head>

<body>
  <jsp:include page="/common/header.jsp"/>

  <div class="mv-detail">
    <div class="mv-container">
      <div class="mv-topbar flex justify-between items-center mb-8">
        <a class="mv-link" href="${pageContext.request.contextPath}/movie"><i class="fas fa-arrow-left"></i> Quay lại</a>
      </div>

      <div class="mv-card">
        <div class="mv-main">
          <div class="mv-poster">
            <img src="${movie.poster}" alt="${movie.title}" onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie1.jpg'">
          </div>

          <div>
            <div class="flex gap-3 mb-4">
                <span class="tag">${movie.status}</span>
                <span class="tag"><i class="fas fa-clock mr-1"></i> ${movie.duration} phút</span>
            </div>
            <h1 class="mv-title">${movie.title}</h1>
            
            <div class="mv-table">
              <table>
                <tbody>
                  <tr><td class="label">Thể loại</td><td class="value">${movie.genre}</td></tr>
                  <tr><td class="label">Đạo diễn</td><td class="value">${movie.director}</td></tr>
                  <tr><td class="label">Diễn viên</td><td class="value">${movie.cast}</td></tr>
                  <tr><td class="label">Khởi chiếu</td><td class="value"><fmt:formatDate value="${movie.releaseDate}" pattern="dd/MM/yyyy"/></td></tr>
                </tbody>
              </table>
            </div>

            <div class="flex gap-4 mt-8">
              <button class="btn border border-white/10 px-8 py-4 rounded-2xl font-bold hover:bg-white/5 transition-all" id="btnTrailer">
                <i class="fas fa-play mr-2"></i> Xem Trailer
              </button>
              <a class="btn primary shadow-xl" href="#schedule-section">
                <i class="fas fa-ticket-alt mr-2"></i> Đặt vé ngay
              </a>
            </div>
          </div>
        </div>

        <div class="px-8 pb-8" id="schedule-section">
          <div class="flex gap-8 border-b border-white/5 mb-6">
            <button class="tab-btn active" data-tab="synopsis">Nội dung</button>
            <button class="tab-btn" data-tab="schedule">Suất chiếu hôm nay</button>
          </div>

          <div id="tab-synopsis" class="tab-pane active">
            <p class="text-slate-400 leading-relaxed text-lg">${movie.description}</p>
          </div>

          <div id="tab-schedule" class="tab-pane">
            <c:choose>
                <c:when test="${not empty todayShowtimes}">
                    <div class="flex flex-wrap gap-4">
                        <c:forEach var="s" items="${todayShowtimes}">
                            <a href="${pageContext.request.contextPath}/booking-seat?showtimeId=${s.showtimeId}" class="st-time-chip">
                                <span class="text-xl font-black"><fmt:formatDate value="${s.startTime}" pattern="HH:mm" /></span>
                                <span class="text-[10px] uppercase font-bold opacity-60">${s.roomName}</span>
                            </a>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="p-8 bg-white/5 rounded-2xl text-center border border-white/5">
                        <i class="fas fa-calendar-times text-4xl text-slate-600 mb-4 block"></i>
                        <p class="text-slate-400 font-bold">Hôm nay hiện chưa có suất chiếu cho phim này.</p>
                        <a href="${pageContext.request.contextPath}/showtime" class="text-indigo-400 text-sm hover:underline mt-2 inline-block">Xem lịch chiếu ngày khác</a>
                    </div>
                </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Trailer Modal -->
  <div class="modal-overlay" id="trailerModal">
    <div class="modal-content-wrap">
      <div class="flex justify-between items-center mb-4">
        <h3 class="text-xl font-bold text-white">Trailer: ${movie.title}</h3>
        <button id="closeTrailer" class="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center hover:bg-rose-500 transition-all"><i class="fas fa-times"></i></button>
      </div>
      <div class="aspect-video rounded-3xl overflow-hidden border border-white/10 shadow-2xl">
        <iframe id="trailerFrame" width="100%" height="100%" src="" frameborder="0" allowfullscreen></iframe>
      </div>
    </div>
  </div>

  <script>
    // Tabs
    document.querySelectorAll('.tab-btn').forEach(btn => {
      btn.addEventListener('click', () => {
        document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        document.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));
        document.getElementById('tab-' + btn.dataset.tab).classList.add('active');
      });
    });

    // Trailer
    const modal = document.getElementById('trailerModal');
    const frame = document.getElementById('trailerFrame');
    const trailerUrl = "${movie.trailerUrl}".replace("watch?v=", "embed/");

    document.getElementById('btnTrailer').addEventListener('click', () => {
      frame.src = trailerUrl + "?autoplay=1";
      modal.classList.add('show');
    });

    const close = () => { modal.classList.remove('show'); frame.src = ""; };
    document.getElementById('closeTrailer').addEventListener('click', close);
    modal.addEventListener('click', (e) => { if(e.target === modal) close(); });
  </script>

  <jsp:include page="/common/footer.jsp"/>
</body>
</html>
