<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="footer">
	<div class="footer-container">

		<!-- Cột 1 -->
		<div class="footer-col">
			<h3>BOBIXI Việt Nam</h3>
			<ul>
				<li><a href="#">Giới Thiệu</a></li>
				<li><a href="#">Tiện Ích Online</a></li>
				<li><a href="#">Thẻ Quà Tặng</a></li>
				<li><a href="#">Tuyển Dụng</a></li>
				<li><a href="#">Liên Hệ Quảng Cáo BOBIXI</a></li>
				<li><a href="#">Dành cho đối tác</a></li>
			</ul>
		</div>

		<!-- Cột 2 -->
		<div class="footer-col">
			<h3>Điều khoản sử dụng</h3>
			<ul>
				<li><a href="${pageContext.request.contextPath}/pages/terms/terms.jsp">Điều Khoản Chung</a></li>
				<li><a href="${pageContext.request.contextPath}/pages/terms/term-payment.jsp">Điều Khoản Giao Dịch</a></li>
				<li><a href="${pageContext.request.contextPath}/pages/terms/payment-policy.jsp">Chính Sách Thanh Toán</a></li>
				<li><a href="${pageContext.request.contextPath}/pages/terms/privacy-policy.jsp">Chính Sách Bảo Mật</a></li>
				<li><a href="${pageContext.request.contextPath}/pages/clients/faq.jsp">Câu Hỏi Thường Gặp</a></li>
			</ul>
		</div>

		<!-- Cột 3 -->
		<div class="footer-col">
			<h3>Kết nối với chúng tôi</h3>
			<div class="social-icons">
				<a href="#"><img
					src="${pageContext.request.contextPath}/assets/images/home/facebook.png"></a>
				<a href="#"><img
					src="${pageContext.request.contextPath}/assets/images/home/tiktok.png"></a>
				<a href="#"><img
					src="${pageContext.request.contextPath}/assets/images/home/instagram.png"></a>
				<a href="#"><img
					src="${pageContext.request.contextPath}/assets/images/home/zalo.png"></a>
			</div>
			<br>
		</div>

		<div class="footer-col">
			<h3>Chăm sóc khách hàng</h3>
			<ul>
				<li>Hotline: 1900 1111</li>
				<li>Giờ làm việc: 8:00 - 22:00</li>
				<li>Chính Sách Thanh Toán</li>
				<li>Email: hoidap@bobixi.vn</li>
			</ul>
		</div>

	</div>

	<!-- Thông tin công ty -->
	<div class="footer-company">
		<p>
			<strong>CÔNG TY TNHH DA BOBIXI VIỆT NAM</strong>
		</p>
		<p>Địa chỉ: Đà Nẵng</p>
		<p>© 2025 BOBIXI Cinemas Việt Nam</p>
		<p>Email: support@bobixi.vn | Hotline: 1900 1111</p>
	</div>

	<!-- Hình gạch -->
	<div class="footer-brick"></div>
</div>

<style>
.footer {
	background: #f7f2e8;
	padding: 40px 0;
	font-family: Arial, sans-serif;
	border-top: 2px solid #ddd;
}

.footer-container {
	width: 90%;
	margin: auto;
	display: flex;
	justify-content: space-between;
	margin-bottom: 30px;
}

.footer-col {
	width: 30%;
}

.footer-col a{
  text-decoration: none;
  color: black; 
  font-weight: 500;
}

.footer-col a:hover{
  color: blue;  
  text-decoration: underline; /* chỉ hiện khi hover (tuỳ chọn) */
}


.footer-col h3 {
	font-size: 18px;
	margin-bottom: 15px;
	font-weight: bold;
	color: black;
}

.footer-col ul {
	list-style: none;
	padding: 0;
}

.footer-col ul li {
	margin: 6px 0;
	cursor: pointer;
	color: black;
}

.social-icons img {
	width: 38px;
	margin-right: 10px;
	cursor: pointer;
}

.footer-company {
	width: 90%;
	margin: auto;
	font-size: 14px;
	color: #444;
	line-height: 1.6;
}

.footer-brick {
	margin-top: 20px;
	height: 140px;
	background-image: url('${pageContext.request.contextPath}/assets/images/home/footer1.jpg');
	background-size: cover;
}
</style>

"