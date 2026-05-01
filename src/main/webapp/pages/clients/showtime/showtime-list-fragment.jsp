<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:choose>
    <c:when test="${not empty movieShowtimes}">
        <c:forEach var="entry" items="${movieShowtimes}">
            <c:set var="m" value="${entry.key}"/>
            <c:set var="sts" value="${entry.value}"/>
            
            <article class="st-movie animate-fade-in" data-title="${m.title.toLowerCase()}">
                <div class="st-poster">
                  <img src="${pageContext.request.contextPath}/assets/images/movies/${m.poster}" alt="${m.title}" onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie1.jpg'">
                </div>

                <div class="st-info">
                  <div class="st-topline">
                    <h3 class="st-name">${m.title}</h3>
                    <div class="st-meta">
                        <span class="genre-badge">${m.genre}</span>
                        <span class="duration-badge"><i class="far fa-clock"></i> ${m.duration} phút</span>
                        <span class="date-badge-inline"><i class="far fa-calendar-alt"></i> ${selectedDate}</span>
                        <span class="text-warning ms-2" style="font-size: 12px;"><i class="fas fa-star"></i> ${m.rating}</span>
                    </div>
                  </div>

                  <div class="st-cinema-line">
                    <span class="st-pill"><i class="fas fa-map-marker-alt"></i> BOBIXI Đà Nẵng</span>
                    <span class="st-pill pill-format">2D / Digital</span>
                  </div>

                  <div class="st-times">
                    <c:forEach var="s" items="${sts}">
                        <a class="st-time" href="${pageContext.request.contextPath}/booking-seat?showtimeId=${s.showtimeId}">
                            <div class="time-main"><fmt:formatDate value="${s.startTime}" pattern="HH:mm" /></div>
                            <div class="time-room">${s.roomName}</div>
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
            <i class="fas fa-film fa-3x mb-3 text-slate-700"></i>
            <div class="st-empty-title">Không tìm thấy suất chiếu nào</div>
            <div class="st-empty-sub">Vui lòng thử chọn ngày khác hoặc thay đổi từ khóa tìm kiếm.</div>
          </div>
        </div>
    </c:otherwise>
</c:choose>
