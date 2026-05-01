<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>${movie.title} | BOBIXI Cinema</title>

<!-- FontAwesome & Google Fonts -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
<script src="https://cdn.tailwindcss.com"></script>

<style>
  body { 
    font-family: 'Roboto', sans-serif; 
    background: radial-gradient(circle at top right, #1e293b, #0f172a); 
    color: #cbd5e1; 
    margin: 0; 
    min-height: 100vh;
  }
  .mv-detail { padding-top: 50px; padding-bottom: 80px; }
  .mv-container { max-width: 1100px; margin: 0 auto; padding: 0 20px; }
  .mv-link { color: #94a3b8; text-decoration: none; font-size: 0.9rem; margin-bottom: 25px; display: inline-flex; align-items: center; gap: 8px; transition: 0.2s; }
  .mv-link:hover { color: #fff; transform: translateX(-5px); }
  
  .mv-card { 
    background: rgba(30, 41, 59, 0.7); 
    border-radius: 20px; 
    overflow: hidden; 
    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.05);
  }
  .mv-main { display: flex; gap: 40px; padding: 40px; }
  @media(max-width: 768px) { .mv-main { flex-direction: column; padding: 20px; } }
  
  .mv-poster { flex-shrink: 0; width: 300px; border-radius: 15px; overflow: hidden; box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3); }
  .mv-poster img { width: 100%; height: auto; display: block; }
  
  .mv-content { flex: 1; }
  .mv-title { font-size: 2.8rem; font-weight: 800; margin-bottom: 10px; color: #fff; line-height: 1.2; }
  
  .tag { 
    display: inline-block; 
    padding: 5px 14px; 
    background: rgba(255, 255, 255, 0.05); 
    border: 1px solid rgba(255, 255, 255, 0.1); 
    border-radius: 8px; 
    font-size: 0.8rem; 
    margin-right: 8px; 
    color: #94a3b8; 
    font-weight: 600;
  }
  
  .mv-table { width: 100%; margin-top: 25px; }
  .mv-table td { padding: 10px 0; border-bottom: 1px solid rgba(255, 255, 255, 0.05); }
  .mv-table tr:last-child td { border-bottom: none; }
  .mv-table td.label { width: 130px; color: #64748b; font-size: 0.9rem; }
  .mv-table td.value { color: #e2e8f0; font-weight: 500; }
  
  .btn-booking { 
    display: inline-flex; 
    align-items: center;
    gap: 10px;
    margin-top: 35px; 
    padding: 14px 35px; 
    background: linear-gradient(135deg, #ef4444, #b91c1c); 
    color: #fff; 
    text-decoration: none; 
    border-radius: 12px; 
    font-weight: 700; 
    box-shadow: 0 10px 15px -3px rgba(239, 68, 68, 0.3);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); 
  }
  .btn-booking:hover { transform: translateY(-3px); box-shadow: 0 20px 25px -5px rgba(239, 68, 68, 0.4); }
  
  .btn-trailer {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    margin-top: 35px;
    margin-left: 15px;
    padding: 13px 34px;
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.1);
    color: #fff;
    border-radius: 12px;
    font-weight: 600;
    transition: 0.3s;
  }
  .btn-trailer:hover { background: rgba(255, 255, 255, 0.1); border-color: rgba(255, 255, 255, 0.2); }

  /* Tabs */
  .tabs-nav { display: flex; background: rgba(0, 0, 0, 0.2); padding: 0 40px; }
  .tab-item { padding: 20px 30px; cursor: pointer; font-weight: 700; color: #64748b; position: relative; transition: 0.3s; }
  .tab-item.active { color: #fff; }
  .tab-item.active::after { content: ''; position: absolute; bottom: 0; left: 0; right: 0; height: 3px; background: #ef4444; border-radius: 3px 3px 0 0; }
  
  .tab-content { padding: 40px; background: rgba(0, 0, 0, 0.1); }
  .tab-pane { display: none; }
  .tab-pane.active { display: block; animation: fadeIn 0.4s ease; }
  
  @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

  .st-chip { 
    display: inline-flex; 
    flex-direction: column;
    align-items: center;
    padding: 12px 20px; 
    background: #1e293b; 
    border-radius: 12px; 
    margin: 6px; 
    text-decoration: none; 
    color: #fff; 
    border: 1px solid rgba(255, 255, 255, 0.1); 
    transition: all 0.2s;
  }
  .st-chip:hover { background: #334155; transform: scale(1.05); border-color: #ef4444; }
  
  /* Modal */
  .modal-overlay { 
    position: fixed; inset: 0; background: rgba(0,0,0,0.9); 
    display: none; align-items: center; justify-content: center; z-index: 1000; 
    backdrop-filter: blur(5px);
  }
  .modal-overlay.show { display: flex; }
  .modal-body { width: 90%; max-width: 960px; position: relative; }
  .btn-close-modal { position: absolute; top: -50px; right: 0; color: #fff; font-size: 2rem; cursor: pointer; opacity: 0.7; transition: 0.2s; }
  .btn-close-modal:hover { opacity: 1; }
</style>
</head>

<body>
  <jsp:include page="/common/header.jsp"/>

  <div class="mv-detail">
    <div class="mv-container">
      <a href="${pageContext.request.contextPath}/movie" class="mv-link">
        <i class="fas fa-arrow-left"></i> Danh sách phim
      </a>

      <div class="mv-card">
        <div class="mv-main">
          <div class="mv-poster">
            <img src="${pageContext.request.contextPath}/assets/images/movies/${movie.poster}" 
                 alt="${movie.title}" 
                 onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie1.jpg'">
          </div>

          <div class="mv-content">
            <div class="mb-4">
              <span class="tag">${movie.status}</span>
              <span class="tag"><i class="fas fa-star text-warning"></i> ${movie.rating}</span>
            </div>
            <h1 class="mv-title">${movie.title}</h1>
            
            <table class="mv-table">
              <tr>
                <td class="label">Thể loại</td>
                <td class="value">${movie.genre}</td>
              </tr>
              <tr>
                <td class="label">Thời lượng</td>
                <td class="value">${movie.duration} phút</td>
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
                <td class="value"><fmt:formatDate value="${movie.releaseDate}" pattern="dd/MM/yyyy"/></td>
              </tr>
            </table>

            <div class="flex flex-wrap gap-2">
              <a href="${pageContext.request.contextPath}/booking-seat?movieId=${movie.movieId}" class="btn-booking">
                <i class="fas fa-ticket-alt"></i> ĐẶT VÉ NGAY
              </a>
              <button id="btnTrailer" class="btn-trailer">
                <i class="fas fa-play"></i> XEM TRAILER
              </button>
            </div>
          </div>
        </div>

        <div class="tabs-nav">
          <div class="tab-item active" data-tab="synopsis">Nội dung</div>
          <div class="tab-item" data-tab="schedule">Suất chiếu hôm nay</div>
        </div>

        <div class="tab-content">
          <div id="tab-synopsis" class="tab-pane active">
            <p style="line-height: 1.8; color: #94a3b8;">${movie.description != null ? movie.description : 'Đang cập nhật nội dung...'}</p>
          </div>
          <div id="tab-schedule" class="tab-pane">
            <c:choose>
              <c:when test="${not empty todayShowtimes}">
                <div class="flex flex-wrap">
                  <c:forEach var="s" items="${todayShowtimes}">
                    <a href="${pageContext.request.contextPath}/booking-seat?showtimeId=${s.showtimeId}" class="st-chip">
                      <strong><fmt:formatDate value="${s.startTime}" pattern="HH:mm" /></strong>
                      <span style="font-size: 0.7rem; opacity: 0.7; margin-left: 5px;">${s.roomName}</span>
                    </a>
                  </c:forEach>
                </div>
              </c:when>
              <c:otherwise>
                <div class="py-10 text-center border border-dashed border-slate-700 rounded-lg">
                  <p class="text-slate-500">Hiện tại không có suất chiếu nào cho ngày hôm nay.</p>
                  <a href="${pageContext.request.contextPath}/showtime" class="text-blue-400 text-sm mt-2 inline-block">Xem tất cả lịch chiếu</a>
                </div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Trailer Modal -->
  <div id="trailerModal" class="modal-overlay">
    <div class="modal-body">
      <span class="btn-close-modal" id="closeTrailer">&times;</span>
      <div style="aspect-ratio: 16/9; background: #000; border-radius: 12px; overflow: hidden;">
        <iframe id="trailerFrame" width="100%" height="100%" src="" frameborder="0" allowfullscreen></iframe>
      </div>
    </div>
  </div>

  <jsp:include page="/common/footer.jsp"/>

  <script>
    // Tabs logic
    document.querySelectorAll('.tab-item').forEach(item => {
      item.addEventListener('click', () => {
        document.querySelectorAll('.tab-item').forEach(i => i.classList.remove('active'));
        item.classList.add('active');
        document.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));
        document.getElementById('tab-' + item.dataset.tab).classList.add('active');
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
      if(!embed) { alert("Trailer không khả dụng."); return; }
      frame.src = embed + "?autoplay=1";
      modal.classList.add('show');
    });

    const closeModal = () => { modal.classList.remove('show'); frame.src = ""; };
    document.getElementById('closeTrailer').addEventListener('click', closeModal);
    modal.addEventListener('click', (e) => { if(e.target === modal) closeModal(); });
  </script>
</body>
</html>
