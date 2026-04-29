<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">


<div class="search-results-page">
	<div class="search-header">
		<div class="container">
			<h1>Kết quả tìm kiếm</h1>

			<div class="search-form">
				<form action="${pageContext.request.contextPath}/search"
					method="get">
					<div class="search-input-group">
						<input type="text" name="q" value="${param.q}"
							placeholder="Tìm kiếm phim, rạp, tin tức..." class="search-input"
							autofocus />
						<button type="submit" class="btn-search">
							<i class="fa-solid fa-magnifying-glass"></i>Tìm kiếm
						</button>
					</div>
				</form>
			</div>

			<c:if test="${not empty param.q}">
				<div class="search-info">
					<p>
						Tìm thấy <strong>${totalResults}</strong> kết quả cho "<strong>${param.q}</strong>"
					</p>
				</div>
			</c:if>
		</div>
	</div>

	<div class="search-content">
		<div class="container">
			<!-- Filter Tabs -->
			<div class="search-tabs">
				<button
					class="tab-btn ${empty param.type || param.type == 'all' ? 'active' : ''}"
					onclick="filterResults('all')">Tất cả (${totalResults})</button>
				<button class="tab-btn ${param.type == 'movies' ? 'active' : ''}"
					onclick="filterResults('movies')">Phim
					(${movieResults.size()})</button>
				<button class="tab-btn ${param.type == 'cinemas' ? 'active' : ''}"
					onclick="filterResults('cinemas')">Rạp
					(${cinemaResults.size()})</button>
				<button class="tab-btn ${param.type == 'news' ? 'active' : ''}"
					onclick="filterResults('news')">Tin tức
					(${newsResults.size()})</button>
			</div>

			<!-- Search Results -->
			<div class="results-container">
				<!-- Movie Results -->
				<c:if
					test="${not empty movieResults && (empty param.type || param.type == 'all' || param.type == 'movies')}">
					<div class="results-section movie-results">
						<h2 class="section-title">
							<i class='bx bx-movie-play'></i> Phim
						</h2>

						<div class="results-grid">
							<c:forEach items="${movieResults}" var="movie">
								<div class="movie-result-card">
									<div class="movie-poster">
										<a
											href="${pageContext.request.contextPath}/movies/${movie.slug}">
											<img
											src="${pageContext.request.contextPath}/assets/images/movies/${movie.posterImage}"
											alt="${movie.title}" />
										</a> <span class="rating-badge rating-${movie.rating}">${movie.rating}</span>
									</div>

									<div class="movie-info">
										<h3>
											<a
												href="${pageContext.request.contextPath}/movies/${movie.slug}">
												${fn:replace(movie.title, param.q, '<mark>'.concat(param.q).concat('</mark>'))}
											</a>
										</h3>

										<div class="movie-meta">
											<span>${movie.genre}</span> <span>${movie.duration}
												phút</span>
										</div>

										<p class="movie-description">
											${fn:substring(movie.description, 0, 120)}...</p>

										<div class="movie-actions">
											<a
												href="${pageContext.request.contextPath}/movies/${movie.slug}"
												class="btn-detail"> Chi tiết </a>
											<button type="button" class="btn-booking"
												onclick="quickBooking('${movie.id}')">Đặt vé</button>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>

						<c:if test="${movieResults.size() > 6 && param.type != 'movies'}">
							<div class="view-more">
								<a href="?q=${param.q}&type=movies" class="btn-view-more">
									Xem thêm ${movieResults.size() - 6} phim → </a>
							</div>
						</c:if>
					</div>
				</c:if>

				<!-- Cinema Results -->
				<c:if
					test="${not empty cinemaResults && (empty param.type || param.type == 'all' || param.type == 'cinemas')}">
					<div class="results-section cinema-results">
						<h2 class="section-title">
							<i class="fa-solid fa-film"></i> Rạp chiếu
						</h2>

						<div class="cinema-list">
							<c:forEach items="${cinemaResults}" var="cinema">
								<div class="cinema-result-card">
									<div class="cinema-image">
										<img
											src="${pageContext.request.contextPath}/resources/images/cinemas/${cinema.image}"
											alt="${cinema.name}" />
									</div>

									<div class="cinema-info">
										<h3>
											<a
												href="${pageContext.request.contextPath}/cinemas/${cinema.slug}">
												${fn:replace(cinema.name, param.q, '<mark>'.concat(param.q).concat('</mark>'))}
											</a>
										</h3>

										<div class="cinema-features">
											<c:if test="${cinema.hasIMAX}">
												<span class="feature-badge">IMAX</span>
											</c:if>
											<c:if test="${cinema.has4DX}">
												<span class="feature-badge">4DX</span>
											</c:if>
											<c:if test="${cinema.hasGoldClass}">
												<span class="feature-badge">Gold Class</span>
											</c:if>
										</div>

										<p class="cinema-address">
											<i class="fa-solid fa-location-dot"></i> ${cinema.address}
										</p>

										<div class="cinema-contact">
											<i class="fa-solid fa-phone"></i> <a
												href="tel:${cinema.phone}">${cinema.phone}</a>
										</div>

										<div class="cinema-actions">
											<a
												href="${pageContext.request.contextPath}/cinemas/${cinema.slug}"
												class="btn-view"> Xem chi tiết </a> <a
												href="${pageContext.request.contextPath}/booking/schedule?cinemaId=${cinema.id}"
												class="btn-booking"> Đặt vé </a>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>

				</c:if>

				<!-- News Results -->
				<c:if
					test="${not empty newsResults && (empty param.type || param.type == 'all' || param.type == 'news')}">
					<div class="results-section news-results">
						<h2 class="section-title">
							<i class="fa-solid fa-newspaper"></i> Tin tức & Ưu đãi
						</h2>

						<div class="news-list">
							<c:forEach items="${newsResults}" var="news">
								<div class="news-result-card">
									<div class="news-image">
										<a
											href="${pageContext.request.contextPath}/newsoffer/${news.slug}">
											<img
											src="${pageContext.request.contextPath}/resources/images/news/${news.image}"
											alt="${news.title}" />
										</a>
									</div>

									<div class="news-content">
										<div class="news-meta">
											<span class="news-category">${news.category}</span> <span
												class="news-date"> <fmt:formatDate
													value="${news.publishDate}" pattern="dd/MM/yyyy" />
											</span>
										</div>

										<h3>
											<a
												href="${pageContext.request.contextPath}/newsoffer/${news.slug}">
												${fn:replace(news.title, param.q, '<mark>'.concat(param.q).concat('</mark>'))}
											</a>
										</h3>

										<p class="news-excerpt">${fn:substring(news.content, 0, 200)}...
										</p>

										<a
											href="${pageContext.request.contextPath}/newsoffer/${news.slug}"
											class="read-more"> Đọc thêm → </a>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</c:if>

				<!-- No Results -->
				<c:if
					test="${empty movieResults && empty cinemaResults && empty newsResults}">
					<div class="no-results">
						<div class="no-results-icon">🔍</div>
						<h2>Không tìm thấy kết quả</h2>
						<p>
							Không tìm thấy kết quả nào phù hợp với "<strong>${param.q}</strong>"
						</p>

						<div class="search-suggestions">
							<h3>Gợi ý tìm kiếm:</h3>
							<ul>
								<li>Kiểm tra lỗi chính tả</li>
								<li>Thử sử dụng từ khóa khác</li>
								<li>Sử dụng từ khóa tổng quát hơn</li>
								<li>Thử tìm kiếm bằng tiếng Anh</li>
							</ul>
						</div>

						<div class="popular-searches">
							<h3>Tìm kiếm phổ biến:</h3>
							<div class="popular-tags">
								<a href="?q=phim+hành+động" class="tag">Phim hành động</a> <a
									href="?q=phim+kinh+dị" class="tag">Phim kinh dị</a> <a
									href="?q=bobixi+vincom" class="tag">BOBIXI Vincom</a> <a
									href="?q=ưu+đãi" class="tag">Ưu đãi</a> <a href="?q=4dx"
									class="tag">4DX</a>
							</div>
						</div>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
    function filterResults(type) {
        var currentUrl = new URL(window.location.href);
        if (type === 'all') {
            currentUrl.searchParams.delete('type');
        } else {
            currentUrl.searchParams.set('type', type);
        }
        window.location.href = currentUrl.toString();
    }
    
    function quickBooking(movieId) {
        window.location.href = '${pageContext.request.contextPath}/booking/schedule?movieId=' + movieId;
    }
</script>

<style>
.search-results-page {
	background: #f5f5f5;
	min-height: 100vh;
}

.search-header {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	padding: 60px 0 40px;
	color: #fff;
}

.container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 20px;
}

.search-header h1 {
	font-size: 36px;
	margin-bottom: 30px;
	text-align: center;
}

.search-form {
	max-width: 800px;
	margin: 0 auto 20px;
}

.search-input-group {
	display: flex;
	gap: 10px;
}

.search-input {
	flex: 1;
	padding: 15px 25px;
	border: none;
	border-radius: 30px;
	font-size: 16px;
}

.btn-search {
	padding: 15px 40px;
	background: #e71a0f;
	color: #fff;
	border: none;
	border-radius: 30px;
	font-weight: bold;
	cursor: pointer;
	display: flex;
	align-items: center;
	gap: 8px;
	transition: all 0.3s;
}

.btn-search:hover {
	background: #c41408;
}

.search-info {
	text-align: center;
	font-size: 16px;
}

.search-tabs {
	display: flex;
	gap: 15px;
	margin: 30px 0;
	padding: 20px;
	background: #fff;
	border-radius: 10px;
	overflow-x: auto;
}

.tab-btn {
	padding: 12px 25px;
	border: 2px solid #ddd;
	background: #fff;
	border-radius: 25px;
	cursor: pointer;
	transition: all 0.3s;
	white-space: nowrap;
	font-weight: 500;
}

.tab-btn.active {
	background: #e71a0f;
	color: #fff;
	border-color: #e71a0f;
}

.results-section {
	margin-bottom: 50px;
}

.section-title {
	font-size: 28px;
	margin-bottom: 25px;
	display: flex;
	align-items: center;
	gap: 15px;
	color: #333;
}

.section-title i {
	color: #e71a0f;
}

.results-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
	gap: 25px;
}

.movie-result-card {
	background: #fff;
	border-radius: 10px;
	overflow: hidden;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s;
}

.movie-result-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
}

.movie-poster {
	position: relative;
}

.movie-poster img {
	width: 100%;
	height: auto;
	display: block;
}

.movie-info {
	padding: 20px;
}

.movie-info h3 {
	font-size: 18px;
	margin-bottom: 10px;
}

.movie-info h3 a {
	color: #333;
	text-decoration: none;
}

.movie-info h3 a:hover {
	color: #e71a0f;
}

mark {
	background: #fff59d;
	padding: 2px 4px;
	border-radius: 3px;
}

.movie-meta {
	display: flex;
	gap: 15px;
	color: #666;
	font-size: 14px;
	margin-bottom: 10px;
}

.movie-actions {
	display: flex;
	gap: 10px;
	margin-top: 15px;
}

.btn-detail, .btn-booking {
	flex: 1;
	padding: 10px;
	text-align: center;
	border-radius: 5px;
	text-decoration: none;
	font-weight: bold;
	transition: all 0.3s;
	border: none;
	cursor: pointer;
}

.btn-detail {
	background: #f5f5f5;
	color: #333;
}

.btn-booking {
	background: #e71a0f;
	color: #fff;
}

.cinema-list, .news-list {
	display: flex;
	flex-direction: column;
	gap: 20px;
}

.cinema-result-card, .news-result-card {
	background: #fff;
	border-radius: 10px;
	overflow: hidden;
	display: flex;
	gap: 20px;
	padding: 20px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.cinema-image, .news-image {
	width: 200px;
	flex-shrink: 0;
}

.cinema-image img, .news-image img {
	width: 100%;
	height: 150px;
	object-fit: cover;
	border-radius: 8px;
}

.feature-badge {
	display: inline-block;
	padding: 4px 10px;
	background: #e71a0f;
	color: #fff;
	border-radius: 12px;
	font-size: 11px;
	margin-right: 5px;
	margin-top: 5px;
}

.no-results {
	text-align: center;
	padding: 80px 20px;
	background: #fff;
	border-radius: 10px;
}

.no-results-icon {
	font-size: 80px;
	margin-bottom: 20px;
}

.no-results h2 {
	font-size: 32px;
	margin-bottom: 15px;
	color: #333;
}

.search-suggestions {
	max-width: 500px;
	margin: 40px auto;
	text-align: left;
	background: #f8f8f8;
	padding: 30px;
	border-radius: 10px;
}

.search-suggestions ul {
	list-style-position: inside;
	color: #666;
	line-height: 2;
}

.popular-searches {
	margin-top: 40px;
}

.popular-tags {
	display: flex;
	gap: 10px;
	flex-wrap: wrap;
	justify-content: center;
	margin-top: 20px;
}

.tag {
	padding: 10px 20px;
	background: #f5f5f5;
	color: #333;
	text-decoration: none;
	border-radius: 20px;
	transition: all 0.3s;
}

.tag:hover {
	background: #e71a0f;
	color: #fff;
}

.view-more {
	text-align: center;
	margin-top: 30px;
}

.btn-view-more {
	display: inline-block;
	padding: 12px 30px;
	background: #e71a0f;
	color: #fff;
	text-decoration: none;
	border-radius: 25px;
	font-weight: bold;
	transition: all 0.3s;
}

.btn-view-more:hover {
	background: #c41408;
}

@media ( max-width : 768px) {
	.cinema-result-card, .news-result-card {
		flex-direction: column;
	}
	.cinema-image, .news-image {
		width: 100%;
	}
	.search-input-group {
		flex-direction: column;
	}
	.results-grid {
		grid-template-columns: 1fr;
	}
}
</style>