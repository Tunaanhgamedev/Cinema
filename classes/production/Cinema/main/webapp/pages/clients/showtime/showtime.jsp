<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Lịch chiếu Đà Nẵng | BOBIXI Cinema</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/showtime.css">
</head>

<body>
  <jsp:include page="/common/header.jsp"/>

 <div class="showtime-page">
  <section class="st-hero">
    <div class="container st-hero-inner">
      <div>
        <div class="st-badge">🎬 Lịch chiếu</div>
        <h1 class="st-title">BOBIXI Cinema • Đà Nẵng</h1>
        <p class="st-sub">Chọn ngày, chọn phim, chọn giờ — đặt vé cực nhanh.</p>
      </div>

      <div class="st-search">
        <input id="q" type="text" class="form-control" placeholder="Tìm phim... (vd: Avatar, Avengers)">
        <button class="btn btn-light" id="btnClear">Xóa</button>
      </div>
    </div>
  </section>

  <main class="container st-wrap">

    <!-- FILTER BAR -->
    <div class="st-panel">
      <div class="st-row dn-only">
        <div class="st-col">
          <label class="st-label">Rạp</label>
          <div class="st-fixed">
            <span class="st-pill st-pill-fixed">BOBIXI Đà Nẵng</span>
            <span class="st-note">*Hiện tại hệ thống chỉ hoạt động tại Đà Nẵng</span>
          </div>
        </div>

        <div class="st-col">
          <label class="st-label">Định dạng</label>
          <select id="format" class="form-select st-select">
            <option value="all">Tất cả</option>
            <option value="2d">2D</option>
            <option value="3d">3D</option>
            <option value="imax">IMAX</option>
          </select>
        </div>

        <div class="st-col">
          <label class="st-label">Ngôn ngữ</label>
          <select id="lang" class="form-select st-select">
            <option value="all">Tất cả</option>
            <option value="sub">Phụ đề</option>
            <option value="dub">Lồng tiếng</option>
          </select>
        </div>

        <div class="st-col st-col-right">
          <label class="st-label">Sắp xếp</label>
          <select id="sort" class="form-select st-select">
            <option value="name">Tên phim (A→Z)</option>
            <option value="hot">Ưu tiên HOT</option>
          </select>
        </div>
      </div>

      <!-- DATE TABS -->
      <div class="st-dates" id="dates"></div>
    </div>

    <!-- MOVIE LIST -->
    <div class="st-list" id="movieList">

      <!-- Movie 1 -->
      <article class="st-movie"
        data-title="avengers"
        data-format="2d imax"
        data-lang="sub"
        data-hot="1">
        <div class="st-poster">
          <img src="${pageContext.request.contextPath}/assets/images/movies/movie1.jpg" alt="Avengers">
          <span class="st-tag hot">HOT</span>
        </div>

        <div class="st-info">
          <div class="st-topline">
            <h3 class="st-name">Avengers</h3>
            <div class="st-meta">Hành động • 120 phút • C13</div>
          </div>

          <div class="st-cinema-line">
            <span class="st-pill">BOBIXI Đà Nẵng</span>
            <span class="st-pill pill-format">IMAX</span>
            <span class="st-pill pill-lang">Phụ đề</span>
          </div>

          <div class="st-times">
            <a class="st-time" href="${pageContext.request.contextPath}/pages/clients/seat/seat.jsp">09:15</a>
            <a class="st-time" href="${pageContext.request.contextPath}/pages/clients/seat/seat.jsp">11:30</a>
            <a class="st-time" href="${pageContext.request.contextPath}/pages/clients/seat/seat.jsp">14:05</a>
            <a class="st-time" href="${pageContext.request.contextPath}/pages/clients/seat/seat.jsp">19:40</a>
            <a class="st-time" href="${pageContext.request.contextPath}/pages/clients/seat/seat.jsp">21:55</a>
          </div>
        </div>
      </article>

      <!-- Movie 2 -->
      <article class="st-movie"
        data-title="avatar"
        data-format="2d 3d"
        data-lang="sub dub"
        data-hot="0">
        <div class="st-poster">
          <img src="${pageContext.request.contextPath}/assets/images/movies/movie2.jpg" alt="Avatar">
          <span class="st-tag new">NEW</span>
        </div>

        <div class="st-info">
          <div class="st-topline">
            <h3 class="st-name">Avatar</h3>
            <div class="st-meta">Phiêu lưu • 150 phút • C13</div>
          </div>

          <div class="st-cinema-line">
            <span class="st-pill">BOBIXI Đà Nẵng</span>
            <span class="st-pill pill-format">3D</span>
            <span class="st-pill pill-lang">Phụ đề / Lồng tiếng</span>
          </div>

          <div class="st-times">
            <a class="st-time" href="${pageContext.request.contextPath}/pages/clients/seat/seat.jsp">10:10</a>
            <a class="st-time" href="${pageContext.request.contextPath}/pages/clients/seat/seat.jsp">13:25</a>
            <a class="st-time" href="${pageContext.request.contextPath}/pages/clients/seat/seat.jsp">16:40</a>
            <a class="st-time" href="${pageContext.request.contextPath}/pages/clients/seat/seat.jsp">20:05</a>
          </div>
        </div>
      </article>

      <!-- Empty -->
      <div class="st-empty" id="emptyState" style="display:none;">
        <div class="st-empty-card">
          <div class="st-empty-title">Không tìm thấy suất chiếu phù hợp</div>
          <div class="st-empty-sub">Hãy đổi định dạng / ngôn ngữ / từ khóa tìm kiếm.</div>
        </div>
      </div>

    </div>
  </main>
</div>
  <jsp:include page="/common/footer.jsp"/>

  <script src="${pageContext.request.contextPath}/assets/js/showtime.js"></script>
</body>
</html>
