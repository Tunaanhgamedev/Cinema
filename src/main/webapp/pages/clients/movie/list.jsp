<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>PHIM ĐANG CHIẾU | BOBIXI Cinema</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/movie.css">
</head>
<body class="movie-page">
    <jsp:include page="/common/header.jsp" />

    <section class="movie-hero">
        <div class="container text-center">
            <span class="badge bg-primary mb-3 rounded-pill px-3 py-2">KHÁM PHÁ ĐIỆN ẢNH</span>
            <h1 class="hero-title">Danh Sách Phim</h1>
            <p class="hero-sub">Tìm kiếm phim yêu thích và đặt vé ngay trong tích tắc</p>
        </div>
    </section>

    <div class="container" style="position: relative; z-index: 10;">
        <div class="filter-bar">
            <div class="row align-items-center g-4">
                <div class="col-lg-3">
                    <div class="search-box">
                        <i class="fas fa-search search-icon"></i>
                        <input type="text" id="movieSearch" class="form-control shadow-none" placeholder="Tìm tên phim...">
                    </div>
                </div>
                <div class="col-lg-2">
                    <select id="movieSort" class="form-select shadow-none bg-dark text-white border-secondary rounded-3" style="padding: 11px;">
                        <option value="newest" ${selectedSort == 'newest' ? 'selected' : ''}>Mới nhất</option>
                        <option value="hot" ${selectedSort == 'hot' ? 'selected' : ''}>Hot nhất</option>
                        <option value="oldest" ${selectedSort == 'oldest' ? 'selected' : ''}>Cũ nhất</option>
                        <option value="alphabetical" ${selectedSort == 'alphabetical' ? 'selected' : ''}>A - Z</option>
                    </select>
                </div>
                <div class="col-lg-7">
                    <div class="date-scroller" id="movieDates" data-selected="${selectedDate}">
                        <c:forEach var="d" items="${availableDates}">
                            <fmt:formatDate value="${d}" pattern="yyyy-MM-dd" var="iso"/>
                            <div class="date-item ${iso == selectedDate ? 'active' : ''}" data-iso="${iso}">
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
            </div>
        </div>

        <div class="mt-5" id="movieGridContainer">
            <jsp:include page="/pages/clients/movie/movie-grid-fragment.jsp" />
        </div>
    </div>

    <jsp:include page="/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const searchInput = document.getElementById('movieSearch');
        const sortSelect = document.getElementById('movieSort');
        const gridContainer = document.getElementById('movieGridContainer');
        const dateItems = document.querySelectorAll('.date-item');
        let selectedDate = document.getElementById('movieDates').dataset.selected;

        async function updateMovies() {
            const q = searchInput.value;
            const sort = sortSelect.value;
            const url = `${window.location.pathname}?q=${encodeURIComponent(q)}&date=${selectedDate}&sort=${sort}&ajax=true`;
            
            gridContainer.style.opacity = '0.5';
            try {
                const res = await fetch(url);
                const html = await res.text();
                gridContainer.innerHTML = html;
            } catch (err) {
                console.error(err);
            } finally {
                gridContainer.style.opacity = '1';
            }
        }

        let timeout;
        searchInput.addEventListener('input', () => {
            clearTimeout(timeout);
            timeout = setTimeout(updateMovies, 500);
        });

        sortSelect.addEventListener('change', updateMovies);

        dateItems.forEach(item => {
            item.addEventListener('click', () => {
                dateItems.forEach(i => i.classList.remove('active'));
                item.classList.add('active');
                selectedDate = item.dataset.iso;
                updateMovies();
            });
        });
    </script>
</body>
</html>
