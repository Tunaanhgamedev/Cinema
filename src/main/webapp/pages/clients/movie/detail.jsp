<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>CHI TIẾT PHIM | BOBIXI Cinema</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css" />

<style>
  .mv-detail{
    background: radial-gradient(1200px 600px at 20% 0%, rgba(139,92,246,.38), transparent 55%),
                radial-gradient(900px 520px at 100% 20%, rgba(34,211,238,.30), transparent 55%),
                radial-gradient(800px 520px at 40% 100%, rgba(251,191,36,.22), transparent 60%),
                #0b1020;
    color:#f4f6fb;
    min-height:100vh;
    padding: 18px 0 50px;
  }
  .mv-container{ max-width: 1150px; margin:0 auto; padding: 0 14px; }

  .mv-topbar{
    display:flex; align-items:center; justify-content:space-between; gap: 10px; flex-wrap:wrap;
    margin-bottom: 12px;
  }
  .mv-link{
    display:inline-flex; align-items:center; gap:8px;
    padding:10px 14px;
    border-radius: 16px;
    border:1px solid rgba(255,255,255,.16);
    background: rgba(255,255,255,.08);
    color:#f4f6fb;
    text-decoration:none;
    font-weight:800;
    transition:.18s ease;
  }
  .mv-link:hover{ transform: translateY(-1px); background: rgba(255,255,255,.12); }

  .mv-card{
    border:1px solid rgba(255,255,255,.16);
    background: rgba(255,255,255,.10);
    border-radius: 22px;
    box-shadow: 0 18px 40px rgba(0,0,0,.35);
    overflow:hidden;
  }

  .mv-main{
    display:grid;
    grid-template-columns: 360px 1fr;
    gap: 14px;
    padding: 14px;
  }
  @media(max-width: 920px){ .mv-main{ grid-template-columns: 1fr; } }

  .mv-poster{
    border-radius: 18px;
    overflow:hidden;
    border:1px solid rgba(255,255,255,.14);
    background: rgba(0,0,0,.22);
    aspect-ratio: 2/3;
  }
  .mv-poster img{ width:100%; height:100%; object-fit:cover; display:block; }

  .mv-title{ margin:0; font-weight: 950; letter-spacing:.2px; }
  .mv-sub{ margin: 6px 0 0; color: rgba(244,246,251,.78); }

  .mv-tags{
    margin-top: 10px;
    display:flex; gap:10px; flex-wrap:wrap;
  }
  .tag{
    padding: 6px 10px;
    border-radius: 999px;
    border:1px solid rgba(255,255,255,.16);
    background: rgba(255,255,255,.08);
    font-weight: 800;
    font-size: .85rem;
    color: rgba(244,246,251,.88);
  }

  .mv-table{
    margin-top: 12px;
    border:1px solid rgba(255,255,255,.14);
    border-radius: 18px;
    overflow:hidden;
  }
  .mv-table table{ width:100%; border-collapse: collapse; }
  .mv-table td{
    padding: 10px 12px;
    border-bottom: 1px solid rgba(255,255,255,.10);
    vertical-align: top;
  }
  .mv-table td.label{ width: 160px; color: rgba(244,246,251,.70); font-weight: 900; }
  .mv-table td.value{ color: rgba(244,246,251,.92); }

  .mv-actions{
    margin-top: 12px;
    display:flex; gap: 10px; flex-wrap:wrap;
  }
  .btn{
    display:inline-flex; align-items:center; justify-content:center; gap:8px;
    padding: 11px 14px;
    border-radius: 16px;
    font-weight: 950;
    border:1px solid rgba(255,255,255,.16);
    background: rgba(255,255,255,.08);
    color:#f4f6fb;
    text-decoration:none;
    cursor:pointer;
    transition:.18s ease;
  }
  .btn:hover{ transform: translateY(-1px); background: rgba(255,255,255,.12); }
  .btn.primary{
    border:none;
    color:#06131f;
    background: linear-gradient(90deg, rgba(251,191,36,.95), rgba(34,211,238,.85));
  }

  .mv-tabs{
    margin-top: 14px;
    padding: 0 14px 14px;
  }
  .tab-head{
    display:flex;
    gap: 10px;
    flex-wrap:wrap;
    margin-bottom: 10px;
  }
  .tab-btn{
    padding: 10px 12px;
    border-radius: 999px;
    border:1px solid rgba(255,255,255,.16);
    background: rgba(255,255,255,.08);
    color:#f4f6fb;
    font-weight: 900;
    cursor:pointer;
    transition:.18s ease;
  }
  .tab-btn.active{
    border:none;
    color:#06131f;
    background: linear-gradient(90deg, rgba(34,211,238,.95), rgba(34,197,94,.85));
  }
  .tab-pane{ display:none; }
  .tab-pane.active{ display:block; }
  .mv-box{
    border:1px solid rgba(255,255,255,.14);
    background: rgba(255,255,255,.08);
    border-radius: 18px;
    padding: 12px;
    color: rgba(244,246,251,.90);
  }

  /* Trailer modal */
  .modal-overlay{
    position: fixed; inset:0;
    background: rgba(0,0,0,.65);
    display:none;
    align-items:center; justify-content:center;
    padding: 16px;
    z-index: 9999;
  }
  .modal-overlay.show{ display:flex; }
  .modal{
    width: min(980px, 100%);
    border-radius: 18px;
    overflow:hidden;
    border:1px solid rgba(255,255,255,.16);
    background: #0b1020;
    box-shadow: 0 30px 80px rgba(0,0,0,.55);
  }
  .modal-head{
    display:flex; align-items:center; justify-content:space-between;
    padding: 10px 12px;
    border-bottom: 1px solid rgba(255,255,255,.10);
  }
  .modal-head .t{ font-weight: 950; }
  .modal-close{
    border:1px solid rgba(255,255,255,.16);
    background: rgba(255,255,255,.08);
    color:#fff;
    border-radius: 12px;
    padding: 6px 10px;
    cursor:pointer;
    font-weight:900;
  }
  .modal-body{ aspect-ratio: 16/9; }
  .modal-body iframe{ width:100%; height:100%; border:0; display:block; }
</style>
</head>

<body>
  <jsp:include page="/common/header.jsp"/>

  <div class="mv-detail">
    <div class="mv-container">

      <div class="mv-topbar">
        <a class="mv-link" href="${pageContext.request.contextPath}/movie">← Danh sách phim</a>
        <a class="mv-link" href="${pageContext.request.contextPath}/showtime?movieId=${movieId}">Lịch chiếu</a>
      </div>

      <!-- ✅ Demo nếu chưa load movie từ DB: dùng movieId để hiển thị tạm -->
      <c:set var="demoTitle" value="Phim #${movieId}" />

      <div class="mv-card">
        <div class="mv-main">
          <div class="mv-poster">
            <img src="${pageContext.request.contextPath}/assets/images/movies/movie${movieId}.jpg"
                 alt="${demoTitle}" onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie1.jpg'">
          </div>

          <div>
            <h1 class="mv-title">${demoTitle}</h1>
            <p class="mv-sub">BOBIXI Cinema · Đà Nẵng · Trải nghiệm chuẩn rạp</p>

            <div class="mv-tags">
              <span class="tag">🔞 C13</span>
              <span class="tag">🎭 Hành động</span>
              <span class="tag">⏱ 120 phút</span>
            </div>

            <div class="mv-table">
              <table>
                <tbody>
                  <tr><td class="label">Đạo diễn</td><td class="value">Đang cập nhật</td></tr>
                  <tr><td class="label">Diễn viên</td><td class="value">Đang cập nhật</td></tr>
                  <tr><td class="label">Ngôn ngữ</td><td class="value">Tiếng Việt / Phụ đề</td></tr>
                  <tr><td class="label">Khởi chiếu</td><td class="value">Đang cập nhật</td></tr>
                </tbody>
              </table>
            </div>

            <div class="mv-actions">
              <button class="btn" type="button" id="btnTrailer">▶ Xem trailer</button>
              <a class="btn primary" href="${pageContext.request.contextPath}/showtime?movieId=${movieId}">Mua vé ngay</a>
            </div>
          </div>
        </div>

        <div class="mv-tabs">
          <div class="tab-head">
            <button class="tab-btn active" type="button" data-tab="synopsis">Nội dung</button>
            <button class="tab-btn" type="button" data-tab="schedule">Lịch chiếu</button>
            <button class="tab-btn" type="button" data-tab="reviews">Đánh giá</button>
          </div>

          <div id="tab-synopsis" class="tab-pane active">
            <div class="mv-box">
              Nội dung phim đang được cập nhật. Bạn có thể thay bằng ${movie.synopsis} khi đã nối DB.
            </div>
          </div>

          <div id="tab-schedule" class="tab-pane">
            <div class="mv-box">
              Lịch chiếu (demo): Vui lòng vào <a style="color:#22d3ee;" href="${pageContext.request.contextPath}/showtime?movieId=${movieId}">trang lịch chiếu</a>.
            </div>
          </div>

          <div id="tab-reviews" class="tab-pane">
            <div class="mv-box">
              Đánh giá đang phát triển. Khi bạn có bảng review, mình nối forEach cho bạn.
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>

  <!-- Trailer Modal (JS thuần) -->
  <div class="modal-overlay" id="trailerModal" aria-hidden="true">
    <div class="modal" role="dialog" aria-modal="true">
      <div class="modal-head">
        <div class="t">Trailer</div>
        <button class="modal-close" type="button" id="closeTrailer">Đóng ✕</button>
      </div>
      <div class="modal-body">
        <!-- Demo trailer youtube embed -->
        <iframe id="trailerFrame"
                src=""
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowfullscreen></iframe>
      </div>
    </div>
  </div>

  <script>
    // tabs
    document.querySelectorAll('.tab-btn').forEach(btn => {
      btn.addEventListener('click', () => {
        document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');

        document.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));
        const tab = btn.getAttribute('data-tab');
        document.getElementById('tab-' + tab).classList.add('active');
      });
    });

    // trailer modal (demo link)
    const modal = document.getElementById('trailerModal');
    const frame = document.getElementById('trailerFrame');

    // Bạn thay link này bằng movie.trailerUrl khi có DB
    const demoTrailer = "https://www.youtube.com/embed/6ZfuNTqbHE8?autoplay=1";

    document.getElementById('btnTrailer').addEventListener('click', () => {
      frame.src = demoTrailer;
      modal.classList.add('show');
      modal.setAttribute('aria-hidden', 'false');
    });

    function closeTrailer(){
      modal.classList.remove('show');
      modal.setAttribute('aria-hidden', 'true');
      frame.src = ""; // stop video
    }

    document.getElementById('closeTrailer').addEventListener('click', closeTrailer);
    modal.addEventListener('click', (e) => { if (e.target === modal) closeTrailer(); });
    document.addEventListener('keydown', (e) => { if (e.key === 'Escape') closeTrailer(); });
  </script>

  <jsp:include page="/common/footer.jsp"/>
</body>
</html>
