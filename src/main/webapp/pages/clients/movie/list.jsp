<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

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

      <div class="movie-header">
        <h1 class="movie-title">🎬 PHIM</h1>
        <a href="${pageContext.request.contextPath}/showtime">Xem lịch chiếu</a>
      </div>

      <c:choose>
        <c:when test="${not empty movies}">
          <div class="movie-grid">
            <c:forEach items="${movies}" var="m">
              <div class="movie-card">
                <img src="${pageContext.request.contextPath}/assets/images/movies/${m.poster}"
                     alt="${m.title}"
                     onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie.jpg'">

                <div class="movie-body">
                  <h3 class="movie-name">${m.title}</h3>
                  <div class="movie-info">
                    ⏱ ${m.duration} phút<br>
                    🔞 ${m.rating}<br>
                    📌 ${m.status}
                  </div>

                  <div class="movie-actions">
                    <a class="btn-detail"
                       href="${pageContext.request.contextPath}/movie?id=${m.movieId}">
                       Chi tiết
                    </a>
                    <a class="btn-book"
                       href="${pageContext.request.contextPath}/showtime?movieId=${m.movieId}">
                       Đặt vé
                    </a>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </c:when>

        <c:otherwise>
          <div class="empty-box">
            Chưa có phim trong hệ thống. Vui lòng thêm dữ liệu vào bảng <b>movies</b>.
          </div>
        </c:otherwise>
      </c:choose>

    </div>
  </div>

  <jsp:include page="/common/footer.jsp"/>
</body>
</html>
