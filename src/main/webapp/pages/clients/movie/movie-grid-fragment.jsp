<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="row g-4" id="movieGrid">
    <c:forEach var="m" items="${movies}">
        <div class="col-6 col-md-4 col-lg-3 animate-fade-in">
            <div class="movie-card">
                <div class="movie-poster">
                    <img src="${pageContext.request.contextPath}/assets/images/movies/${m.poster}" alt="${m.title}" onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie1.jpg'">
                    <div class="movie-overlay">
                        <a href="${pageContext.request.contextPath}/movie?id=${m.movieId}" class="btn btn-primary btn-sm rounded-pill">Chi tiết</a>
                        <a href="${pageContext.request.contextPath}/showtime?date=${selectedDate}" class="btn btn-light btn-sm rounded-pill mt-2">Đặt vé</a>
                    </div>
                </div>
                <div class="movie-info">
                    <h3 class="movie-title">${m.title}</h3>
                    <p class="movie-meta">${m.genre} • ${m.duration} phút</p>
                </div>
            </div>
        </div>
    </c:forEach>
    <c:if test="${empty movies}">
        <div class="col-12 text-center py-5">
            <i class="fas fa-search fa-3x text-muted mb-3"></i>
            <h4 class="text-muted">Không tìm thấy phim nào khớp với yêu cầu</h4>
        </div>
    </c:if>
</div>
