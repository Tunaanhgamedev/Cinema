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
  body { font-family: 'Roboto', sans-serif; background-color: #0b0f19; color: #e2e8f0; margin: 0; }
  .mv-detail { padding-top: 40px; padding-bottom: 80px; }
  .mv-container { max-width: 1200px; margin: 0 auto; padding: 0 20px; }
  .mv-link { color: #818cf8; text-decoration: none; font-weight: bold; margin-bottom: 20px; display: inline-block; }
  .mv-link:hover { text-decoration: underline; }
  
  .mv-card { 
    background: #161d2f; 
    border-radius: 12px; 
    overflow: hidden; 
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.5); 
  }
  .mv-main { display: flex; gap: 40px; padding: 30px; }
  @media(max-width: 768px) { .mv-main { flex-direction: column; } }
  
  .mv-poster { flex-shrink: 0; width: 320px; border-radius: 8px; overflow: hidden; }
  .mv-poster img { width: 100%; height: auto; display: block; }
  
  .mv-content { flex: 1; }
  .mv-title { font-size: 2.5rem; font-weight: 700; margin-bottom: 15px; color: #fff; }
  
  .tag { 
    display: inline-block; 
    padding: 4px 12px; 
    background: #1e293b; 
    border: 1px solid #334155; 
    border-radius: 6px; 
    font-size: 0.85rem; 
    margin-right: 10px; 
    color: #94a3b8; 
  }
  
  .mv-table { width: 100%; margin-top: 20px; }
  .mv-table td { padding: 8px 0; vertical-align: top; }
  .mv-table td.label { width: 120px; color: #64748b; font-weight: 600; }
  .mv-table td.value { color: #cbd5e1; }
  
  .btn-booking { 
    display: inline-block; 
    margin-top: 30px; 
    padding: 12px 30px; 
    background: #ef4444; 
    color: #fff; 
    text-decoration: none; 
    border-radius: 6px; 
    font-weight: 700; 
    transition: 0.2s; 
  }
  .btn-booking:hover { background: #dc2626; transform: scale(1.02); }
  
  .btn-trailer {
    display: inline-block;
    margin-top: 30px;
    margin-left: 15px;
    padding: 11px 29px;
    background: transparent;
    border: 1px solid #475569;
    color: #fff;
    border-radius: 6px;
    font-weight: 600;
  }
  .btn-trailer:hover { background: #1e293b; }

  /* Tabs */
  .tabs-nav { display: flex; border-bottom: 1px solid #1e293b; margin-top: 40px; padding: 0 30px; }
  .tab-item { padding: 15px 25px; cursor: pointer; font-weight: 600; color: #64748b; border-bottom: 3px solid transparent; }
  .tab-item.active { color: #ef4444; border-bottom-color: #ef4444; }
  
  .tab-content { padding: 30px; }
  .tab-pane { display: none; }
  .tab-pane.active { display: block; }
  
  .st-chip { 
    display: inline-block; 
    padding: 10px 18px; 
    background: #1e293b; 
    border-radius: 6px; 
    margin: 5px; 
    text-decoration: none; 
    color: #fff; 
    border: 1px solid #334155; 
  }
  .st-chip:hover { background: #3b82f6; border-color: #3b82f6; }
  
  /* Modal */
  .modal-overlay { 
    position: fixed; inset: 0; background: rgba(0,0,0,0.85); 
    display: none; align-items: center; justify-content: center; z-index: 1000; 
  }
  .modal-overlay.show { display: flex; }
  .modal-body { width: 90%; max-width: 900px; position: relative; }
  .btn-close-modal { position: absolute; top: -40px; right: 0; color: #fff; font-size: 1.5rem; cursor: pointer; }
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
