<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>ĐĂNG NHẬP | BOBIXI Cinema</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/login.css" />
</head>

<body>
	<div class="account-login">
		<div class="page-title">
			<h1>Đăng nhập</h1>
		</div>

		<div class="login-container">
			<div class="col-login">
				<div class="col-wrapper">
					<h2>Thành viên BOBIXI</h2>

					<c:if test="${not empty error}">
						<div class="messages">
							<ul class="messages">
								<li class="error-msg">
									<ul>
										<li><span>${error}</span></li>
									</ul>
								</li>
							</ul>
						</div>
					</c:if>

					<c:if test="${not empty message}">
						<div class="messages">
							<ul class="messages">
								<li class="success-msg">
									<ul>
										<li><span>${message}</span></li>
									</ul>
								</li>
							</ul>
						</div>
					</c:if>

					<form action="${pageContext.request.contextPath}/login" method="post" id="login-form">

						<!-- ✅ Quan trọng: giữ returnUrl để login xong quay lại trang đang định vào -->
						<input type="hidden" name="returnUrl" value="${returnUrl}" />


						<div class="content">
							<ul class="form-list">
								<li>
									<label for="email" class="required"> Email <em>*</em></label>
									<div class="input-box">
										<input type="email" name="email" id="email"
											class="input-text required-entry validate-email"
											title="Email" value="${email}" required />
									</div>
								</li>

								<li>
									<label for="password" class="required"> Mật khẩu <em>*</em></label>
									<div class="input-box">
										<input type="password" name="password" id="password"
											class="input-text required-entry validate-password"
											title="Mật khẩu" required />
									</div>
								</li>
							</ul>

							<div class="remember-forgot">
								<label class="checkbox-label">
									<input type="checkbox" name="remember-me" id="remember-me" />
									<span>Ghi nhớ đăng nhập</span>
								</label>
								<a href="${pageContext.request.contextPath}/forgot-password" class="forgot-password">
									Quên mật khẩu?
								</a>
							</div>
						</div>

						<div class="buttons-set">
							<button type="submit" class="button btn-login" id="send2">
								<span>Đăng nhập</span>
							</button>
						</div>
					</form>

					<!-- Social Login -->
					<div class="social-login">
						<div class="separator">
							<span>Hoặc đăng nhập với</span>
						</div>

						<div class="social-buttons">
							<a href="${pageContext.request.contextPath}/oauth2/authorization/facebook"
								class="btn-social btn-facebook">
								<i class="bi bi-facebook"></i>
								<span>Facebook</span>
							</a>

							<a href="${pageContext.request.contextPath}/oauth2/authorization/google"
								class="btn-social btn-google">
								<i class="bi bi-google"></i>
								<span>Google</span>
							</a>
						</div>

					</div>
				</div>
			</div>

			<div class="col-register">
				<div class="col-wrapper">
					<h2>Khách hàng mới</h2>

					<div class="content">
						<p>Tạo tài khoản BOBIXI để nhận được nhiều ưu đãi hấp dẫn:</p>

						<ul class="benefits-list">
							<li><i class="bi bi-check-lg"></i> Đặt vé nhanh chóng, thuận tiện</li>
							<li><i class="bi bi-check-lg"></i> Nhận thông tin phim mới nhất</li>
							<li><i class="bi bi-check-lg"></i> Ưu đãi dành riêng cho thành viên</li>
							<li><i class="bi bi-check-lg"></i> Quản lý vé và lịch sử giao dịch</li>
						</ul>
					</div>

					<div class="buttons-set">
						<a href="${pageContext.request.contextPath}/register" class="button btn-register">
							<span>Đăng ký ngay</span>
						</a>
					</div>

					<div class="buttons-set">
						<a href="${pageContext.request.contextPath}/home" class="button btn-home">
							<span>Quay về trang chủ</span>
						</a>
					</div>

				</div>
			</div>
		</div>
	</div>

	<script>
  document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("login-form");
    const emailEl = document.getElementById("email");
    const passEl = document.getElementById("password");

    form.addEventListener("submit", function (e) {
      const email = (emailEl.value || "").trim();
      const password = passEl.value || "";

      if (!email || !password) {
        e.preventDefault();
        alert("Vui lòng nhập đầy đủ thông tin đăng nhập.");
        return;
      }
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailRegex.test(email)) {
        e.preventDefault();
        alert("Email không hợp lệ.");
      }
    });

    emailEl.focus();
  });
</script>


</body>
</html>
