<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>LIÊN HỆ | BOBIXI Cinema</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/common/header.jsp" />
	<div class="contact-page">
		<div class="page-header">
			<div class="header-overlay">
				<h1>Liên hệ với chúng tôi</h1>
				<p>Chúng tôi luôn sẵn sàng lắng nghe và hỗ trợ bạn</p>
			</div>
		</div>

		<div class="contact-container">
			<!-- Quick Contact Info -->
			<div class="quick-contact">

				<div class="contact-card hotline">
					<div class="card-icon">
						<i class="fa-solid fa-phone-volume"></i>
					</div>
					<h3>Hotline</h3>
					<p class="highlight">123456</p>
					<p class="sub-text">8:00 - 22:00 (Tất cả các ngày)</p>
				</div>

				<div class="contact-card email">
					<div class="card-icon">
						<i class="fa-regular fa-envelope"></i>
					</div>
					<h3>Email</h3>
					<p class="highlight">
						<a href="mailto:hoidap@bobixi.vn">hoidap@bobixi.vn</a>
					</p>
					<p class="sub-text">Phản hồi trong 24h</p>
				</div>

				<div class="contact-card location">
					<div class="card-icon">
						<i class="fa-solid fa-location-dot"></i>
					</div>
					<h3>Văn phòng</h3>
					<p class="highlight">Đà Nẵng</p>
					<p class="sub-text">Đà Nẵng</p>
				</div>

				<div class="contact-card social">
					<div class="card-icon">
						<i class="fa-solid fa-share-nodes"></i>
					</div>
					<h3>Mạng xã hội</h3>

					<div class="social-links">
						<a href="https://web.facebook.com/tuna.anh.225285" target="_blank"
							class="social-btn facebook"> <i class="fab fa-facebook-f"></i>
						</a> <a href="#" target="_blank" class="social-btn tiktok"> <i
							class="fab fa-tiktok"></i>
						</a> <a href="#" target="_blank" class="social-btn instagram"> <i
							class="fab fa-instagram"></i>
						</a>
					</div>
				</div>
			</div>


			<!-- Contact Form Section -->
			<div class="contact-form-section">
				<div class="form-wrapper">
					<h2>Gửi thông điệp cho chúng tôi</h2>
					<p class="form-description">Vui lòng điền thông tin dưới đây,
						chúng tôi sẽ phản hồi sớm nhất có thể</p>

					<c:if test="${not empty message}">
						<div class="alert alert-success">
							<i class="fa-solid fa-circle-check"></i> ${message}
						</div>
					</c:if>

					<c:if test="${not empty error}">
						<div class="alert alert-error">
							<i class="fa-solid fa-circle-exclamation"></i> ${error}
						</div>
					</c:if>

					<form action="${pageContext.request.contextPath}/contact/send"
						method="post" id="contact-form">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />

						<div class="form-row">
							<div class="form-group">
								<label for="fullName"> Họ và tên <span class="required">*</span>
								</label> <input type="text" id="fullName" name="fullName"
									class="form-control" value="${param.fullName}"
									placeholder="Nguyễn Văn A" required />
							</div>

							<div class="form-group">
								<label for="email"> Email <span class="required">*</span>
								</label> <input type="email" id="email" name="email"
									class="form-control" value="${param.email}"
									placeholder="example@email.com" required />
							</div>
						</div>

						<div class="form-row">
							<div class="form-group">
								<label for="phone"> Số điện thoại <span class="required">*</span>
								</label> <input type="tel" id="phone" name="phone" class="form-control"
									value="${param.phone}" placeholder="0912345678"
									pattern="[0-9]{10,11}" required />
							</div>

							<div class="form-group">
								<label for="subject"> Chủ đề <span class="required">*</span>
								</label> <select id="subject" name="subject" class="form-control"
									required>
									<option value="">-- Chọn chủ đề --</option>
									<option value="booking"
										${param.subject == 'booking' ? 'selected' : ''}>Đặt
										vé & Thanh toán</option>
									<option value="member"
										${param.subject == 'member' ? 'selected' : ''}>Thành
										viên</option>
									<option value="cinema"
										${param.subject == 'cinema' ? 'selected' : ''}>Rạp
										chiếu</option>
									<option value="promotion"
										${param.subject == 'promotion' ? 'selected' : ''}>
										Khuyến mãi</option>
									<option value="technical"
										${param.subject == 'technical' ? 'selected' : ''}>Vấn
										đề kỹ thuật</option>
									<option value="feedback"
										${param.subject == 'feedback' ? 'selected' : ''}>Góp
										ý & Phản hồi</option>
									<option value="other"
										${param.subject == 'other' ? 'selected' : ''}>Khác</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="message"> Nội dung <span class="required">*</span>
							</label>
							<textarea id="message" name="message" class="form-control"
								rows="6" placeholder="Vui lòng mô tả chi tiết vấn đề của bạn..."
								required>${param.message}</textarea>
							<span class="character-count"> <span id="char-count">0</span>/1000
								ký tự
							</span>
						</div>

						<div class="form-group">
							<label class="checkbox-label"> <input type="checkbox"
								name="subscribe" value="true" /> <span>Tôi muốn nhận
									thông tin về phim mới và ưu đãi từ BOBIXI</span>
							</label>
						</div>

						<div class="form-actions">

							<button type="reset" class="btn-reset">
								<i class="fa-solid fa-rotate-right"></i> Làm mới
							</button>

							<button type="submit" class="btn-submit">
								<i class="fa-solid fa-paper-plane"></i> Gửi tin nhắn
							</button>

						</div>

					</form>
				</div>

				<!-- FAQ Quick Links -->
				<div class="faq-quick-links">
					<h3>Câu hỏi thường gặp</h3>
					<div class="faq-list">

						<a href="${pageContext.request.contextPath}/faq#booking"
							class="faq-item"> <i class="fa-solid fa-circle-question"></i>
							<span>Làm sao để đặt vé online?</span>
						</a> <a href="${pageContext.request.contextPath}/faq#payment"
							class="faq-item"> <i class="fa-solid fa-circle-question"></i>
							<span>Có những phương thức thanh toán nào?</span>
						</a> <a href="${pageContext.request.contextPath}/faq#refund"
							class="faq-item"> <i class="fa-solid fa-circle-question"></i>
							<span>Có được hoàn vé không?</span>
						</a> <a href="${pageContext.request.contextPath}/faq#member"
							class="faq-item"> <i class="fa-solid fa-circle-question"></i>
							<span>Cách tích điểm thành viên?</span>
						</a>

					</div>

					<a href="${pageContext.request.contextPath}/pages/clients/faq.jsp" class="view-all-faq"> Xem tất cả FAQ → </a>
				</div>

			</div>

			<!-- Map Section -->
			<div class="map-section">
				<h2>Vị trí văn phòng</h2>
				<div id="office-map"
					style="width: 100%; height: 450px; border-radius: 10px;"></div>
				<div class="map-info">
					<div class="info-item">
						<i class="fa-solid fa-location-dot"></i>
						<div>
							<strong>Địa chỉ:</strong>
							<p>Đà Nẵng</p>
						</div>
					</div>
					<div class="info-item">
						<i class="fa-solid fa-clock"></i>
						<div>
							<strong>Giờ làm việc:</strong>
							<p>
								Thứ 2 - Thứ 6: 8:00 - 18:00<br>Thứ 7 - CN: 9:00 - 17:00
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/common/footer.jsp" />

	<script type="text/javascript">
		// Character counter
		$j('#message').on('input', function() {
			var length = $j(this).val().length;
			$j('#char-count').text(length);

			if (length > 1000) {
				$j(this).val($j(this).val().substring(0, 1000));
				$j('#char-count').text(1000);
			}
		});

		// Form validation
		$j('#contact-form').on('submit', function(e) {
			var phone = $j('#phone').val();
			var phoneRegex = /^[0-9]{10,11}$/;

			if (!phoneRegex.test(phone)) {
				e.preventDefault();
				alert('Số điện thoại không hợp lệ. Vui lòng nhập 10-11 số.');
				return false;
			}
		});

		// Initialize Google Map
		function initMap() {
			var officeLocation = {
				lat : 16.0758889,
				lng : 108.1509444
			};

			var map = new google.maps.Map(
					document.getElementById('office-map'), {
						center : officeLocation,
						zoom : 16,
						styles : [ {
							featureType : "poi",
							elementType : "labels",
							stylers : [ {
								visibility : "off"
							} ]
						} ]
					});

			var marker = new google.maps.Marker({
				position : officeLocation,
				map : map,
				title : 'BOBIXI Cinemas Vietnam',
				animation : google.maps.Animation.DROP
			});

			var infoWindow = new google.maps.InfoWindow(
					{
						content : '<div style="padding: 10px;"><h4>BOBIXI Cinemas Vietnam</h4><p>Đà Nẵng</p></div>'
					});

			marker.addListener('click', function() {
				infoWindow.open(map, marker);
			});
		}

		$j(document).ready(function() {
			initMap();
		});
	</script>

	<style>
.contact-page {
	background: #f5f5f5;
}

.page-header {
	height: 350px;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	display: flex;
	align-items: center;
	justify-content: center;
	color: #fff;
	text-align: center;
	margin-bottom: 60px;
}

.page-header h1 {
	font-size: 48px;
	margin-bottom: 15px;
}

.page-header p {
	font-size: 20px;
	opacity: 0.9;
}

.contact-container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 20px 60px;
}

.quick-contact {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	gap: 25px;
	margin-bottom: 60px;
}

.contact-card {
	background: #fff;
	padding: 35px;
	border-radius: 15px;
	text-align: center;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
	transition: all 0.3s;
}

.contact-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.12);
}

.card-icon {
	width: 70px;
	height: 70px;
	margin: 0 auto 20px;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 32px;
	color: #fff;
}

.contact-card h3 {
	font-size: 20px;
	margin-bottom: 15px;
	color: #333;
}

.highlight {
	font-size: 22px;
	font-weight: bold;
	color: #e71a0f;
	margin-bottom: 10px;
}

.highlight a {
	color: #e71a0f;
	text-decoration: none;
}

.sub-text {
	color: #666;
	font-size: 14px;
}

.social-links {
	display: flex;
	gap: 10px;
	justify-content: center;
}

.social-btn {
	width: 45px;
	height: 45px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	text-decoration: none;
	color: #fff;
	font-size: 20px;
	transition: all 0.3s;
}

.social-btn.facebook {
	background: #1877f2;
}

.social-btn.tiktok {
	background: black;
}

.social-btn.instagram {
	background: linear-gradient(45deg, #f09433 0%, #e6683c 25%, #dc2743 50%, #cc2366 75%
		, #bc1888 100%);
}

.contact-form-section {
	display: grid;
	grid-template-columns: 2fr 1fr;
	gap: 30px;
	margin-bottom: 60px;
}

.form-wrapper {
	background: #fff;
	padding: 50px;
	border-radius: 15px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
}

.form-wrapper h2 {
	font-size: 32px;
	margin-bottom: 10px;
	color: #333;
}

.form-description {
	color: #666;
	margin-bottom: 30px;
}

.alert {
	padding: 15px 20px;
	border-radius: 8px;
	margin-bottom: 25px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.alert-success {
	background: #d4edda;
	color: #155724;
	border: 1px solid #c3e6cb;
}

.alert-error {
	background: #f8d7da;
	color: #721c24;
	border: 1px solid #f5c6cb;
}

.form-row {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
}

.form-group {
	margin-bottom: 25px;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	font-weight: 500;
	color: #333;
}

.required {
	color: #e71a0f;
}

.form-control {
	width: 100%;
	padding: 12px 15px;
	border: 1px solid #ddd;
	border-radius: 8px;
	font-size: 15px;
	transition: all 0.3s;
}

.form-control:focus {
	outline: none;
	border-color: #e71a0f;
	box-shadow: 0 0 0 3px rgba(231, 26, 15, 0.1);
}

.character-count {
	display: block;
	text-align: right;
	font-size: 13px;
	color: #666;
	margin-top: 5px;
}

.checkbox-label {
	display: flex;
	align-items: center;
	gap: 10px;
	cursor: pointer;
}

.form-actions {
	display: flex;
	gap: 15px;
	margin-top: 30px;
}

.btn-reset, .btn-submit {
	flex: 1;
	padding: 15px;
	border: none;
	border-radius: 30px;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
	transition: all 0.3s;
}

.btn-reset {
	background: #f5f5f5;
	color: #333;
}

.btn-reset:hover {
	background: #e0e0e0;
}

.btn-submit {
	background: #e71a0f;
	color: #fff;
}

.btn-submit:hover {
	background: #c41408;
}

.faq-quick-links {
	background: #fff;
	padding: 30px;
	border-radius: 15px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
}

.faq-quick-links h3 {
	font-size: 22px;
	margin-bottom: 20px;
	color: #333;
}

.faq-list {
	display: flex;
	flex-direction: column;
	gap: 15px;
}

.faq-item {
	display: flex;
	align-items: center;
	gap: 10px;
	padding: 12px;
	background: #f8f8f8;
	border-radius: 8px;
	text-decoration: none;
	color: #333;
	transition: all 0.3s;
}

.faq-item:hover {
	background: #fff5f5;
	color: #e71a0f;
}

.faq-item i {
	font-size: 20px;
	margin-right: 10px;
	color: #e50914; /* đỏ Netflix */
}

.view-all-faq {
	display: block;
	text-align: center;
	margin-top: 20px;
	color: #e71a0f;
	font-weight: bold;
	text-decoration: none;
}

.map-section {
	background: #fff;
	padding: 50px;
	border-radius: 15px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
}

.map-section h2 {
	font-size: 32px;
	margin-bottom: 30px;
	color: #333;
}

.map-info {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 30px;
	margin-top: 30px;
}

.info-item {
	display: flex;
	gap: 15px;
	align-items: flex-start;
}

.info-item i {
	font-size: 24px;
	color: #e71a0f;
}

.fa-circle-check {
	color: #28a745; /* xanh success */
}

.fa-circle-exclamation {
	color: #dc3545; /* đỏ error */
}

@media ( max-width : 1024px) {
	.contact-form-section {
		grid-template-columns: 1fr;
	}
	.form-row {
		grid-template-columns: 1fr;
	}
	.map-info {
		grid-template-columns: 1fr;
	}
}
</style>

	<script
		src="https://maps.googleapis.com/maps/api/js?key=GOOGLE_MAPS_API_KEY_REMOVED&callback=initMap"
		async defer></script>
</body>
</html>