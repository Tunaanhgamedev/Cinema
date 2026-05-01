<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>PHIM | BOBIXI Cinema</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css" />

<style>
  .movie-page{
    background:#f5f6fa;
    padding:20px 0 40px;
  }
  .movie-container{
    max-width:1100px;
    margin:0 auto;
    padding:0 16px;
  }
  .movie-header{
    display:flex;
    align-items:center;
    justify-content:space-between;
    gap:12px;
    flex-wrap:wrap;
    margin-bottom:16px;
  }
  .movie-title{
    font-size:24px;
    font-weight:700;
    margin:0;
  }
  .movie-header a{
    text-decoration:none;
    background:#f39c12;
    color:#000;
    padding:8px 12px;
    border-radius:6px;
    font-weight:600;
  }

  .movie-grid{
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(220px,1fr));
    gap:16px;
  }
  .movie-card{
    background:#fff;
    border:1px solid #ddd;
    border-radius:8px;
    overflow:hidden;
  }
  .movie-card img{
    width:100%;
    height:320px;
    object-fit:cover;
    display:block;
  }
  .movie-body{
    padding:12px;
  }
  .movie-name{
    font-size:16px;
    font-weight:600;
    margin:0 0 6px;
  }
  .movie-info{
    font-size:14px;
    color:#555;
    margin-bottom:10px;
    line-height:1.4;
  }
  .movie-actions{
    display:flex;
    gap:8px;
  }
  .movie-actions a{
    flex:1;
    text-align:center;
    padding:8px 10px;
    font-size:14px;
    text-decoration:none;
    border-radius:6px;
    font-weight:600;
  }
  .btn-detail{
    background:#eee;
    color:#333;
  }
  .btn-book{
    background:#f39c12;
    color:#000;
  }

  .empty-box{
    background:#fff;
    border:1px solid #ddd;
    border-radius:8px;
    padding:16px;
    color:#333;
  }
</style>
</head>

<body>
  <jsp:include page="/common/header.jsp"/>

  <div class="movie-page">
    <div class="movie-container">

      <div class="movie-header d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
        <h1 class="movie-title mb-0">🎬 PHIM ĐANG CHIẾU</h1>
        
        <div class="header-actions d-flex gap-3 align-items-center">
            <form action="${pageContext.request.contextPath}/movie" method="GET" class="d-flex gap-2">
              <div class="input-group" style="width: 280px;">
                <span class="input-group-text bg-white border-end-0 rounded-start-pill">
                    <i class="fas fa-search text-muted"></i>
                </span>
                <input type="text" name="q" class="form-control border-start-0 rounded-end-pill ps-0" 
                       placeholder="Tìm tên phim..." value="${param.q}">
              </div>
              
              <select name="sort" class="form-select rounded-pill" style="width: 130px;" onchange="this.form.submit()">
                <option value="newest" ${selectedSort == 'newest' ? 'selected' : ''}>Mới nhất</option>
                <option value="hot" ${selectedSort == 'hot' ? 'selected' : ''}>Hot nhất</option>
                <option value="alphabetical" ${selectedSort == 'alphabetical' ? 'selected' : ''}>A - Z</option>
              </select>
              <input type="hidden" name="date" value="${selectedDate}">
            </form>
            <a href="${pageContext.request.contextPath}/showtime" class="btn btn-warning rounded-pill px-4 fw-bold shadow-sm">
                XEM LỊCH CHIẾU
            </a>
        </div>
      </div>

      <!-- Date Selection Bar -->
      <div class="date-selection mb-4">
        <div class="d-flex overflow-auto pb-2" style="gap: 10px;">
           <c:forEach var="d" items="${availableDates}">
              <fmt:formatDate value="${d}" pattern="yyyy-MM-dd" var="iso"/>
              <fmt:formatDate value="${d}" pattern="dd/MM" var="label"/>
              <a href="${pageContext.request.contextPath}/movie?date=${iso}&q=${param.q}&sort=${selectedSort}" 
                 class="btn ${iso == selectedDate ? 'btn-primary' : 'btn-outline-dark'} rounded-pill px-4 shadow-sm">
                 ${label}
              </a>
           </c:forEach>
        </div>
      </div>

      <c:choose>
        <c:when test="${not empty movies}">
          <div class="movie-grid">
            <c:forEach items="${movies}" var="m">
              <div class="movie-card shadow-sm">
                <div style="position:relative; height:320px; background:#eee;">
                  <c:choose>
                    <c:when test="${not empty m.poster}">
                      <img src="${pageContext.request.contextPath}/assets/images/movies/${m.poster}"
                           alt="${m.title}"
                           style="width:100%; height:100%; object-fit:cover;"
                           onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie1.jpg'">
                    </c:when>
                    <c:otherwise>
                      <img src="${pageContext.request.contextPath}/assets/images/movies/movie1.jpg"
                           alt="Placeholder"
                           style="width:100%; height:100%; object-fit:cover;">
                    </c:otherwise>
                  </c:choose>
                </div>

                <div class="movie-body">
                  <h3 class="movie-name text-truncate" title="${m.title}">${m.title}</h3>
                  <div class="movie-info">
                    <span class="text-warning">★ ${m.rating}</span> | ${m.duration} phút<br>
                    <span class="badge bg-light text-dark border mt-1">${m.status}</span>
                  </div>

                  <div class="movie-actions mt-2">
                    <a class="btn-detail"
                       href="${pageContext.request.contextPath}/movie?id=${m.movieId}">
                       Chi tiết
                    </a>
                    <a class="btn-book"
                       href="${pageContext.request.contextPath}/booking-seat?movieId=${m.movieId}">
                       Đặt vé
                    </a>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </c:when>
        <c:otherwise>
          <div class="text-center py-5 border rounded bg-white">
            <h4 class="text-muted">Không tìm thấy phim nào cho ngày này</h4>
            <p>Vui lòng chọn ngày khác hoặc thay đổi từ khóa tìm kiếm.</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <jsp:include page="/common/footer.jsp"/>
</body>
</html>
