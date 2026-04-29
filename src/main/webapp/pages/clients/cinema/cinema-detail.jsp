<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/common/header.jsp" />
<div class="cinema-detail-page">
    <!-- Cinema Header -->
    <div class="cinema-header">
        <div class="cinema-banner">
            <img src="${pageContext.request.contextPath}/assets/images/cinemas/banner_cinema.jpg" 
                 alt="${cinema.name}" 
                 class="banner-image" />
            <div class="banner-overlay">
                <div class="cinema-header-info">
                    <h1>${cinema.name}</h1>
                    <div class="cinema-features">
                        <c:if test="${cinema.hasIMAX}">
                            <span class="feature-badge imax">IMAX</span>
                        </c:if>
                        <c:if test="${cinema.has4DX}">
                            <span class="feature-badge dx">4DX</span>
                        </c:if>
                        <c:if test="${cinema.hasGoldClass}">
                            <span class="feature-badge gold">Gold Class</span>
                        </c:if>
                        <c:if test="${cinema.hasScreenX}">
                            <span class="feature-badge screenx">ScreenX</span>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Cinema Navigation -->
    <div class="cinema-nav">
        <div class="nav-container">
            <a href="#overview" class="nav-link active" onclick="scrollToSection('overview')">
                Tổng quan
            </a>
            <a href="#showtimes" class="nav-link" onclick="scrollToSection('showtimes')">
                Lịch chiếu
            </a>
            <a href="#facilities" class="nav-link" onclick="scrollToSection('facilities')">
                Tiện ích
            </a>
            <a href="#pricing" class="nav-link" onclick="scrollToSection('pricing')">
                Giá vé
            </a>
            <a href="#location" class="nav-link" onclick="scrollToSection('location')">
                Vị trí
            </a>
            <a href="#gallery" class="nav-link" onclick="scrollToSection('gallery')">
                Hình ảnh
            </a>
        </div>
    </div>
    
    <div class="cinema-content">
        <!-- Overview Section -->
        <section id="overview" class="content-section">
            <div class="section-container">
                <h2 class="section-title">Thông tin rạp</h2>
                
                <div class="info-grid">
                    <div class="info-card">
                        <i class="icon-location"></i>
                        <div class="info-content">
                            <h4>Địa chỉ</h4>
                            <p>${cinema.address}</p>
                        </div>
                    </div>
                    
                    <div class="info-card">
                        <i class="icon-phone"></i>
                        <div class="info-content">
                            <h4>Hotline</h4>
                            <p><a href="tel:${cinema.phone}">${cinema.phone}</a></p>
                        </div>
                    </div>
                    
                    <div class="info-card">
                        <i class="icon-clock"></i>
                        <div class="info-content">
                            <h4>Giờ hoạt động</h4>
                            <p>${cinema.openingHours}</p>
                        </div>
                    </div>
                    
                    <div class="info-card">
                        <i class="icon-screen"></i>
                        <div class="info-content">
                            <h4>Số phòng chiếu</h4>
                            <p>${cinema.totalScreens} phòng</p>
                        </div>
                    </div>
                </div>
                
                <div class="cinema-description">
                    <h3>Giới thiệu</h3>
                    <div class="description-content">
                        ${cinema.description}
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Showtimes Section -->
        <section id="showtimes" class="content-section">
            <div class="section-container">
                <h2 class="section-title">Lịch chiếu hôm nay</h2>
                
                <!-- Date Selector -->
                <div class="date-selector">
                    <button class="date-nav prev" onclick="changeDate(-1)">
                        <i class="icon-prev"></i>
                    </button>
                    
                    <div class="dates-list">
                        <c:forEach items="${availableDates}" var="date" varStatus="status">
                            <div class="date-item ${status.first ? 'active' : ''}" 
                                 data-date="${date}" 
                                 onclick="selectDate(this, '${date}')">
                                <div class="date-day">
                                    <fmt:formatDate value="${date}" pattern="EEE"/>
                                </div>
                                <div class="date-number">
                                    <fmt:formatDate value="${date}" pattern="dd/MM"/>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <button class="date-nav next" onclick="changeDate(1)">
                        <i class="icon-next"></i>
                    </button>
                </div>
                
                <!-- Movies Showtimes -->
                <div id="showtimes-container" class="showtimes-container">
                    <c:forEach items="${showtimes}" var="movieShowtime">
                        <div class="movie-showtime-card">
                            <div class="movie-poster">
                                <img src="${pageContext.request.contextPath}/resources/images/movies/${movieShowtime.movie.posterImage}" 
                                     alt="${movieShowtime.movie.title}" />
                                <span class="rating-badge rating-${movieShowtime.movie.rating}">
                                    ${movieShowtime.movie.rating}
                                </span>
                            </div>
                            
                            <div class="movie-showtime-info">
                                <h3 class="movie-title">
                                    <a href="${pageContext.request.contextPath}/movies/${movieShowtime.movie.slug}">
                                        ${movieShowtime.movie.title}
                                    </a>
                                </h3>
                                
                                <div class="movie-meta">
                                    <span>${movieShowtime.movie.genre}</span>
                                    <span>${movieShowtime.movie.duration} phút</span>
                                </div>
                                
                                <!-- Showtimes by Format -->
                                <c:forEach items="${movieShowtime.formatGroups}" var="formatGroup">
                                    <div class="format-group">
                                        <div class="format-label">
                                            ${formatGroup.format}
                                            <c:if test="${formatGroup.hasSubtitle}">
                                                <span class="subtitle-badge">Phụ đề</span>
                                            </c:if>
                                        </div>
                                        
                                        <div class="times-list">
                                            <c:forEach items="${formatGroup.showtimes}" var="showtime">
                                                <button type="button" 
                                                        class="time-btn ${showtime.availableSeats <= 0 ? 'sold-out' : ''}"
                                                        onclick="bookShowtime('${showtime.id}')"
                                                        ${showtime.availableSeats <= 0 ? 'disabled' : ''}>
                                                    <span class="time">
                                                        <fmt:formatDate value="${showtime.startTime}" pattern="HH:mm"/>
                                                    </span>
                                                    <span class="seats">
                                                        ${showtime.availableSeats} ghế
                                                    </span>
                                                </button>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
        
        <!-- Facilities Section -->
        <section id="facilities" class="content-section">
            <div class="section-container">
                <h2 class="section-title">Tiện ích</h2>
                
                <div class="facilities-grid">
                    <c:forEach items="${cinema.facilities}" var="facility">
                        <div class="facility-card">
                            <div class="facility-icon">
                                <img src="${pageContext.request.contextPath}/resources/images/icons/${facility.icon}" 
                                     alt="${facility.name}" />
                            </div>
                            <h4>${facility.name}</h4>
                            <p>${facility.description}</p>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- Screen Rooms -->
                <div class="screen-rooms-section">
                    <h3>Phòng chiếu</h3>
                    <div class="screen-rooms-list">
                        <c:forEach items="${cinema.screenRooms}" var="room">
                            <div class="screen-room-card">
                                <div class="room-image">
                                    <img src="${pageContext.request.contextPath}/resources/images/screens/${room.image}" 
                                         alt="${room.name}" />
                                </div>
                                <div class="room-info">
                                    <h4>${room.name}</h4>
                                    <div class="room-specs">
                                        <span><i class="icon-seat"></i> ${room.totalSeats} ghế</span>
                                        <span><i class="icon-screen"></i> ${room.screenType}</span>
                                        <span><i class="icon-sound"></i> ${room.soundSystem}</span>
                                    </div>
                                    <c:if test="${not empty room.features}">
                                        <div class="room-features">
                                            <c:forEach items="${room.features}" var="feature">
                                                <span class="feature-tag">${feature}</span>
                                            </c:forEach>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Pricing Section -->
        <section id="pricing" class="content-section">
            <div class="section-container">
                <h2 class="section-title">Bảng giá vé</h2>
                
                <div class="pricing-tables">
                    <c:forEach items="${cinema.pricingTables}" var="priceTable">
                        <div class="pricing-table">
                            <h3>${priceTable.name}</h3>
                            <table class="price-table">
                                <thead>
                                    <tr>
                                        <th>Loại ghế</th>
                                        <c:forEach items="${priceTable.dayTypes}" var="dayType">
                                            <th>${dayType}</th>
                                        </c:forEach>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${priceTable.rows}" var="row">
                                        <tr>
                                            <td class="seat-type">${row.seatType}</td>
                                            <c:forEach items="${row.prices}" var="price">
                                                <td class="price">
                                                    <fmt:formatNumber value="${price}" type="currency" currencyCode="VND"/>
                                                </td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:forEach>
                </div>
                
                <div class="pricing-notes">
                    <h4>Lưu ý:</h4>
                    <ul>
                        <li>Giá vé có thể thay đổi vào các dịp lễ, tết</li>
                        <li>Áp dụng các chương trình ưu đãi cho thành viên</li>
                        <li>Trẻ em dưới 13 tuổi phải có người lớn đi cùng</li>
                    </ul>
                </div>
            </div>
        </section>
        
        <!-- Location Section -->
        <section id="location" class="content-section">
            <div class="section-container">
                <h2 class="section-title">Vị trí & Đường đi</h2>
                
                <div class="location-content">
                    <div class="map-container">
                        <div id="cinema-map" style="width: 100%; height: 400px;"></div>
                    </div>
                    
                    <div class="directions-info">
                        <h3>Cách di chuyển</h3>
                        
                        <div class="direction-item">
                            <i class="icon-bus"></i>
                            <div>
                                <h4>Xe buýt</h4>
                                <p>${cinema.busDirections}</p>
                            </div>
                        </div>
                        
                        <div class="direction-item">
                            <i class="icon-car"></i>
                            <div>
                                <h4>Ô tô</h4>
                                <p>${cinema.carDirections}</p>
                            </div>
                        </div>
                        
                        <div class="direction-item">
                            <i class="icon-parking"></i>
                            <div>
                                <h4>Bãi đỗ xe</h4>
                                <p>${cinema.parkingInfo}</p>
                            </div>
                        </div>
                        
                        <button type="button" class="btn-directions" onclick="openGoogleMaps()">
                            <i class="icon-navigation"></i>
                            Chỉ đường bằng Google Maps
                        </button>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Gallery Section -->
        <section id="gallery" class="content-section">
            <div class="section-container">
                <h2 class="section-title">Hình ảnh rạp</h2>
                
                <div class="gallery-grid">
                    <c:forEach items="${cinema.galleryImages}" var="image" varStatus="status">
                        <div class="gallery-item" onclick="openGallery(${status.index})">
                            <img src="${pageContext.request.contextPath}/assets/images/gallery/${image.thumbnail}" 
                                 alt="${image.caption}" />
                            <div class="gallery-overlay">
                                <i class="icon-zoom"></i>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />

<script type="text/javascript">
    var map;
    var marker;
    
    function scrollToSection(sectionId) {
        $j('.nav-link').removeClass('active');
        $j('.nav-link[href="#' + sectionId + '"]').addClass('active');
        
        $j('html, body').animate({
            scrollTop: $j('#' + sectionId).offset().top - 100
        }, 500);
    }
    
    function selectDate(element, date) {
        $j('.date-item').removeClass('active');
        $j(element).addClass('active');
        
        loadShowtimes(date);
    }
    
    function loadShowtimes(date) {
        $j.ajax({
            url: '${pageContext.request.contextPath}/cinemas/${cinema.id}/showtimes',
            type: 'GET',
            data: { date: date },
            beforeSend: function() {
                $j('#showtimes-container').html('<div class="loading">Đang tải...</div>');
            },
            success: function(data) {
                $j('#showtimes-container').html(data);
            }
        });
    }
    
    function bookShowtime(showtimeId) {
        window.location.href = '${pageContext.request.contextPath}/booking/seats?showtimeId=' + showtimeId;
    }
    
    function initMap() {
        var location = { lat: ${cinema.latitude}, lng: ${cinema.longitude} };
        
        map = new google.maps.Map(document.getElementById('cinema-map'), {
            center: location,
            zoom: 16
        });
        
        marker = new google.maps.Marker({
            position: location,
            map: map,
            title: '${cinema.name}'
        });
    }
    
    function openGoogleMaps() {
        var url = 'https://www.google.com/maps/dir//' + ${cinema.latitude} + ',' + ${cinema.longitude};
        window.open(url, '_blank');
    }
    
    function openGallery(index) {
        // Use colorbox or lightbox to display gallery
        $j.colorbox({
            photo: true,
            href: '${pageContext.request.contextPath}/resources/images/gallery/' + index + '.jpg'
        });
    }
    
    $j(document).ready(function() {
        initMap();
    });
</script>

<style>
/* ===== RESET NHẸ ===== */
* {
    box-sizing: border-box;
    font-family: "Segoe UI", Roboto, Arial, sans-serif;
}

body {
    margin: 0;
    background: #111;
    color: #eee;
}

/* ===== PAGE ===== */
.cinema-detail-page {
    background: #111;
}

/* ===== HEADER / BANNER ===== */
.cinema-banner {
    position: relative;
    height: 380px;
}

.banner-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    filter: brightness(0.6);
}

.banner-overlay {
    position: absolute;
    inset: 0;
    display: flex;
    align-items: flex-end;
    padding: 40px;
    background: linear-gradient(to top, rgba(0,0,0,0.9), transparent);
}

.cinema-header-info h1 {
    font-size: 40px;
    margin: 0 0 10px;
    color: #fff;
}

.cinema-features {
    display: flex;
    gap: 10px;
}

.feature-badge {
    padding: 6px 14px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: 600;
}

.imax { background: #000; color: #0af; }
.dx { background: #e50914; color: #fff; }
.gold { background: #c9a227; color: #000; }
.screenx { background: #007acc; }

/* ===== NAV ===== */
.cinema-nav {
    background: #000;
    border-bottom: 1px solid #222;
    position: sticky;
    top: 0;
    z-index: 10;
}

.nav-container {
    max-width: 1200px;
    margin: auto;
    display: flex;
    overflow-x: auto;
}

.nav-link {
    padding: 16px 22px;
    color: #aaa;
    text-decoration: none;
    font-weight: 500;
}

.nav-link.active,
.nav-link:hover {
    color: #e50914;
    border-bottom: 3px solid #e50914;
}

/* ===== SECTION ===== */
.content-section {
    padding: 60px 0;
}

.section-container {
    max-width: 1200px;
    margin: auto;
    padding: 0 16px;
}

.section-title {
    font-size: 28px;
    margin-bottom: 30px;
    color: #fff;
    border-left: 4px solid #e50914;
    padding-left: 12px;
}

/* ===== INFO ===== */
.info-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
    gap: 20px;
}

.info-card {
    background: #1c1c1c;
    padding: 20px;
    border-radius: 10px;
    display: flex;
    gap: 15px;
}

/* ===== DATE SELECT ===== */
.date-selector {
    background: #1c1c1c;
    padding: 15px;
    border-radius: 10px;
    margin-bottom: 30px;
}

.date-item {
    min-width: 90px;
    padding: 10px;
    border-radius: 8px;
    background: #111;
    border: 1px solid #333;
    cursor: pointer;
    text-align: center;
}

.date-item.active {
    background: #e50914;
    border-color: #e50914;
}

/* ===== MOVIE CARD ===== */
.movie-showtime-card {
    background: #1c1c1c;
    padding: 20px;
    border-radius: 12px;
    display: flex;
    gap: 20px;
    margin-bottom: 20px;
}

.movie-poster img {
    width: 130px;
    border-radius: 10px;
}

.movie-title a {
    color: #fff;
    text-decoration: none;
}

.movie-title a:hover {
    color: #e50914;
}

.movie-meta {
    color: #aaa;
    margin-bottom: 10px;
}

/* ===== SHOWTIME BUTTON ===== */
.time-btn {
    background: transparent;
    border: 1px solid #e50914;
    color: #fff;
    padding: 10px 14px;
    border-radius: 8px;
    cursor: pointer;
}

.time-btn:hover {
    background: #e50914;
}

.time-btn.sold-out {
    border-color: #555;
    color: #777;
}

/* ===== FACILITIES ===== */
.facilities-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 20px;
}

.facility-card {
    background: #1c1c1c;
    padding: 20px;
    border-radius: 10px;
}

/* ===== GALLERY ===== */
.gallery-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
    gap: 15px;
}

.gallery-item img {
    width: 100%;
    height: 220px;
    object-fit: cover;
    border-radius: 10px;
}

/* ===== MAP ===== */
.map-container {
    border-radius: 12px;
    overflow: hidden;
    margin-top: 20px;
}
</style>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAtoapxwmPfKBsFQgF0X69T0uZjG1pFL3U&callback=initMap" async defer></script>