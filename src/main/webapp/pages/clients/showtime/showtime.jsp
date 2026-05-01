<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
          <p class="st-sub">Lịch chiếu phim cho ngày: <span class="text-info font-bold"><fmt:parseDate value="${selectedDate}" pattern="yyyy-MM-dd" var="parsedDate"/><fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/></span></p>
        </div>
        <div class="st-filters">
          <div class="st-search">
            <i class="fas fa-search search-icon"></i>
            <input id="movieSearch" type="text" class="form-control" placeholder="Tìm tên phim...">
          </div>
          <div class="st-sort">
            <select id="movieSort" class="form-select">
              <option value="newest" ${selectedSort == 'newest' ? 'selected' : ''}>Mới nhất</option>
              <option value="hot" ${selectedSort == 'hot' ? 'selected' : ''}>Hot nhất</option>
              <option value="oldest" ${selectedSort == 'oldest' ? 'selected' : ''}>Cũ nhất</option>
              <option value="alphabetical" ${selectedSort == 'alphabetical' ? 'selected' : ''}>Tên phim (A-Z)</option>
            </select>
          </div>
        </div>
      </div>
    </section>

    <main class="container st-wrap">
      <div class="st-panel">
        <div class="st-dates" id="dates" data-selected="${selectedDate}">
          <c:forEach var="d" items="${availableDates}">
            <fmt:formatDate value="${d}" pattern="yyyy-MM-dd" var="iso"/>
            <div class="st-date ${iso == selectedDate ? 'active' : ''}" data-iso="${iso}">
              <div class="d1">
                <fmt:formatDate value="${d}" pattern="E" var="dayName"/>
                <c:choose>
                    <c:when test="${dayName == 'Mon'}">T2</c:when>
                    <c:when test="${dayName == 'Tue'}">T3</c:when>
                    <c:when test="${dayName == 'Wed'}">T4</c:when>
                    <c:when test="${dayName == 'Thu'}">T5</c:when>
                    <c:when test="${dayName == 'Fri'}">T6</c:when>
                    <c:when test="${dayName == 'Sat'}">T7</c:when>
                    <c:when test="${dayName == 'Sun'}">CN</c:when>
                    <c:otherwise>${dayName}</c:otherwise>
                </c:choose>
              </div>
              <div class="d2"><fmt:formatDate value="${d}" pattern="dd/MM"/></div>
            </div>
          </c:forEach>
        </div>
      </div>

      <div class="st-list" id="movieList">
        <c:choose>
            <c:when test="${not empty movieShowtimes}">
                <c:forEach var="entry" items="${movieShowtimes}">
                    <c:set var="m" value="${entry.key}"/>
                    <c:set var="sts" value="${entry.value}"/>
                    
                    <article class="st-movie" data-title="${m.title.toLowerCase()}">
                        <div class="st-poster">
                          <img src="${pageContext.request.contextPath}/assets/images/movies/${m.poster}" alt="${m.title}" onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie1.jpg'">
                        </div>

                        <div class="st-info">
                          <div class="st-topline">
                            <h3 class="st-name">${m.title}</h3>
                            <div class="st-meta">${m.genre} • ${m.duration} phút</div>
                          </div>

                          <div class="st-cinema-line">
                            <span class="st-pill">BOBIXI Đà Nẵng</span>
                            <span class="st-pill pill-format">2D / Digital</span>
                          </div>

                          <div class="st-times">
                            <c:forEach var="s" items="${sts}">
                                <a class="st-time" href="${pageContext.request.contextPath}/booking-seat?showtimeId=${s.showtimeId}">
                                    <fmt:formatDate value="${s.startTime}" pattern="HH:mm" />
                                    <span class="text-[8px] opacity-50 block text-center mt-1">${s.roomName}</span>
                                </a>
                            </c:forEach>
                          </div>
                        </div>
                    </article>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="st-empty">
                  <div class="st-empty-card">
                    <div class="st-empty-title">Không có suất chiếu nào</div>
                    <div class="st-empty-sub">Vui lòng chọn ngày khác hoặc quay lại sau.</div>
                  </div>
                </div>
            </c:otherwise>
        </c:choose>
      </div>
    </main>
  </div>

  <jsp:include page="/common/footer.jsp"/>
  <script src="${pageContext.request.contextPath}/assets/js/showtime.js"></script>
</body>
</html>
