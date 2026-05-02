<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>QUÊN MẬT KHẨU | BOBIXI Cinema</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css" />
</head>

<body>
	<div class="account-login">
		<div class="page-title">
			<h1>Quên mật khẩu</h1>
		</div>

		<div class="login-container" style="justify-content: center;">
			<div class="col-login" style="width: 100%; max-width: 500px; border-right: none;">
				<div class="col-wrapper">
					<h2>Khôi phục mật khẩu</h2>
                    <p style="margin-bottom: 20px; color: #666;">Nhập email của bạn để nhận mã xác thực (OTP).</p>

					<c:if test="${not empty error}">
						<div class="messages">
							<ul class="messages"><li class="error-msg"><ul><li><span>${error}</span></li></ul></li></ul>
						</div>
					</c:if>

					<form action="${pageContext.request.contextPath}/forgot-password" method="post">
						<div class="content">
							<ul class="form-list">
								<li>
									<label for="email" class="required"> Email đăng ký <em>*</em></label>
									<div class="input-box">
										<input type="email" name="email" id="email" class="input-text required-entry validate-email" required />
									</div>
								</li>
							</ul>
						</div>

						<div class="buttons-set" style="margin-top: 20px;">
							<button type="submit" class="button btn-login" style="width: 100%;">
								<span>Gửi mã xác thực</span>
							</button>
						</div>
                        
                        <div style="margin-top: 20px; text-align: center;">
                            <a href="${pageContext.request.contextPath}/login" style="color: #6366f1; font-weight: 600;"> Quay lại Đăng nhập </a>
                        </div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
