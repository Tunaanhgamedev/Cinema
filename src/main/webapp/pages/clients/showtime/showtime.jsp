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

<body data-selected-date="${selectedDate}">
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

    <!-- MOVIE LIST (DYNAMIC) -->
    <div class="st-list" id="movieList">
      <c:forEach var="movie" items="${moviesWithShowtimes}">
          <article class="st-movie" data-title="${movie.title.toLowerCase()}">
            <div class="st-poster">
              <img src="${pageContext.request.contextPath}/${movie.poster}" alt="${movie.title}">
              <c:if test="${movie.rating >= 9}">
                  <span class="st-tag hot">HOT</span>
              </c:if>
            </div>
    
            <div class="st-info">
              <div class="st-topline">
                <h3 class="st-name">${movie.title}</h3>
                <div class="st-meta">${movie.duration} phút • Đánh giá: ${movie.rating}/10</div>
              </div>
    
              <div class="st-cinema-line">
                <span class="st-pill">BOBIXI Đà Nẵng</span>
                <span class="st-pill pill-format">2D / Digital</span>
                <span class="st-pill pill-lang">Phụ đề</span>
              </div>
    
              <div class="st-times">
                <c:forEach var="st" items="${movie.showtimes}">
                    <a class="st-time" href="${pageContext.request.contextPath}/booking-seat?showtimeId=${st.showtimeId}">
                        <fmt:formatDate value="${st.startTime}" pattern="HH:mm" />
                        <span class="small d-block text-muted" style="font-size: 10px; font-weight: normal;">${st.roomName}</span>
                    </a>
                </c:forEach>
              </div>
            </div>
          </article>
      </c:forEach>

      <c:if test="${empty moviesWithShowtimes}">
          <div class="st-empty" id="emptyState">
            <div class="st-empty-card">
              <div class="st-empty-title">Không có suất chiếu cho ngày này</div>
              <div class="st-empty-sub">Hãy chọn một ngày khác hoặc quay lại sau.</div>
            </div>
          </div>
      </c:if>

    </div>
  </main>
</div>
  <jsp:include page="/common/footer.jsp"/>

  <script src="${pageContext.request.contextPath}/assets/js/showtime.js"></script>
</body>
</html>
