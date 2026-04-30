<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>ĐĂNG KÝ | BOBIXI Cinema</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/register.css" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
	<div class="account-register">
		<div class="page-title">
			<h1>
				Đăng ký tài khoản
				<a href="${pageContext.request.contextPath}/home" class="btn btn-outline-primary">
					<i class="bi bi-house-door"></i> Trang chủ
				</a>
			</h1>
		</div>

		<div class="register-container">
			<div class="register-form-wrapper">

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

				<form action="${pageContext.request.contextPath}/register" method="post" id="register-form">

					<!-- Nếu bạn KHÔNG dùng Spring Security thì xóa dòng CSRF này -->
					<c:if test="${not empty _csrf}">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</c:if>

					<div class="fieldset">
						<h2 class="legend">Thông tin cá nhân</h2>

						<ul class="form-list">
							<li class="fields">
								<div class="field name-firstname">
									<label for="firstname" class="required">Họ <em>*</em></label>
									<div class="input-box">
										<input type="text" name="firstName" id="firstname"
											value="${firstName}" title="Họ"
											class="input-text required-entry" required />
									</div>
								</div>

								<div class="field name-lastname">
									<label for="lastname" class="required">Tên <em>*</em></label>
									<div class="input-box">
										<input type="text" name="lastName" id="lastname"
											value="${lastName}" title="Tên"
											class="input-text required-entry" required />
									</div>
								</div>
							</li>

							<li>
								<label for="email" class="required">Email <em>*</em></label>
								<div class="input-box">
									<input type="email" name="email" id="email"
										value="${email}" title="Email"
										class="input-text validate-email required-entry" required />
								</div>
							</li>

							<li>
								<label for="phone" class="required">Số điện thoại <em>*</em></label>
								<div class="input-box">
									<input type="tel" name="phone" id="phone"
										value="${phone}" title="Số điện thoại"
										class="input-text required-entry" pattern="[0-9]{10,11}"
										required />
									<p class="note">Ví dụ: 0912345678</p>
								</div>
							</li>

							<li class="fields">
								<div class="field">
									<label for="dob">Ngày sinh</label>
									<div class="input-box">
										<input type="date" name="dateOfBirth" id="dob"
											value="${dateOfBirth}" title="Ngày sinh"
											class="input-text" />
									</div>
								</div>

								<div class="field">
									<label for="gender">Giới tính</label>
									<div class="input-box">
										<select name="gender" id="gender" class="validate-select">
											<option value="">-- Chọn giới tính --</option>
											<option value="MALE" ${gender == 'MALE' ? 'selected' : ''}>Nam</option>
											<option value="FEMALE" ${gender == 'FEMALE' ? 'selected' : ''}>Nữ</option>
											<option value="OTHER" ${gender == 'OTHER' ? 'selected' : ''}>Khác</option>
										</select>
									</div>
								</div>
							</li>

							<li>
								<label for="address">Địa chỉ</label>
								<div class="input-box">
									<textarea name="address" id="address" title="Địa chỉ"
										class="input-text" rows="3">${address}</textarea>
								</div>
							</li>
						</ul>
					</div>

					<div class="fieldset">
						<h2 class="legend">Thông tin đăng nhập</h2>

						<ul class="form-list">
							<li>
								<label for="password" class="required">Mật khẩu <em>*</em></label>
								<div class="input-box">
									<input type="password" name="password" id="password"
										title="Mật khẩu" class="input-text required-entry" required />
									<p class="note">Mật khẩu phải có ít nhất 6 ký tự</p>
								</div>

								<!-- Bạn có thể giữ UI này, nhưng nếu bỏ JS thì nó chỉ là giao diện -->
								<div class="password-strength" id="password-strength" style="display:none;">
									<span class="strength-label">Độ mạnh:</span>
									<div class="strength-bar">
										<div class="strength-meter"></div>
									</div>
									<span class="strength-text"></span>
								</div>
							</li>

							<li>
								<label for="confirm-password" class="required">Xác nhận mật khẩu <em>*</em></label>
								<div class="input-box">
									<input type="password" name="confirmPassword"
										id="confirm-password" title="Xác nhận mật khẩu"
										class="input-text required-entry" required />
								</div>
							</li>
						</ul>
					</div>

					<div class="fieldset">
						<h2 class="legend">Tùy chọn nhận thông tin</h2>

						<ul class="form-list">
							<li class="control">
								<label class="checkbox-label">
									<input type="checkbox" name="subscribeNewsletter" id="subscribe-newsletter"
										value="true" ${subscribeNewsletter == 'true' ? 'checked' : ''} />
									<span>Nhận thông tin về phim mới, khuyến mãi qua email</span>
								</label>
							</li>

							<li class="control">
								<label class="checkbox-label">
									<input type="checkbox" name="subscribeSMS" id="subscribe-sms"
										value="true" ${subscribeSMS == 'true' ? 'checked' : ''} />
									<span>Nhận thông tin qua SMS</span>
								</label>
							</li>
						</ul>
					</div>

					<div class="fieldset">
						<ul class="form-list">
							<li class="control">
								<label class="checkbox-label">
									<input type="checkbox" name="agreeTerms" id="agree-terms" required />
									<span>
										Tôi đồng ý với
										<a href="${pageContext.request.contextPath}/pages/terms/terms.jsp" target="_blank">Điều khoản sử dụng</a>
										và
										<a href="${pageContext.request.contextPath}/pages/terms/privacy-policy.jsp" target="_blank">Chính sách bảo mật</a>
										<em>*</em>
									</span>
								</label>
							</li>
						</ul>
					</div>

					<div class="buttons-set">
						<button type="submit" class="button btn-register">
							<span><span>Đăng ký</span></span>
						</button>
					</div>
				</form>

				<div class="social-register">
					<div class="separator"><span>Hoặc đăng ký với</span></div>

					<div class="social-buttons">
						<a href="${pageContext.request.contextPath}/oauth2/authorization/facebook"
							class="btn-social btn-facebook btn btn-primary w-100">
							<i class="bi bi-facebook"></i> <span>Facebook</span>
						</a>
						<a href="${pageContext.request.contextPath}/oauth2/authorization/google"
							class="btn-social btn-google btn btn-danger w-100">
							<i class="bi bi-google"></i> <span>Google</span>
						</a>
					</div>
				</div>

				<div class="login-link">
					<p>
						Đã có tài khoản?
						<a href="${pageContext.request.contextPath}/login">Đăng nhập ngay</a>
					</p>
				</div>

			</div>
		</div>
	</div>
</body>
</html>
