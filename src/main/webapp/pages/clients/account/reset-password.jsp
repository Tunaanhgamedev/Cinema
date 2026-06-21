<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>ĐẶT LẠI MẬT KHẨU | BOBIXI Cinema</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css" />
</head>

<body>
	<div class="account-login">
		<div class="page-title">
			<h1>Đặt lại mật khẩu</h1>
		</div>

		<div class="login-container" style="justify-content: center;">
			<div class="col-login" style="width: 100%; max-width: 500px; border-right: none;">
				<div class="col-wrapper">
					<h2>Nhập mật khẩu mới</h2>
                    <p style="margin-bottom: 20px; color: #666;">Vui lòng nhập mật khẩu mới và xác nhận lại.</p>

					<c:if test="${not empty error}">
						<div class="messages">
							<ul class="messages"><li class="error-msg"><ul><li><span>${error}</span></li></ul></li></ul>
						</div>
					</c:if>

					<form action="${pageContext.request.contextPath}/reset-password" method="post" id="reset-form">
                        <input type="hidden" name="email" value="${email}" />
                        <input type="hidden" name="otp" value="${otp}" />

						<div class="content">
							<ul class="form-list">
								<li>
									<label for="password" class="required"> Mật khẩu mới <em>*</em></label>
									<div class="input-box">
										<input type="password" name="password" id="password" class="input-text required-entry" required />
									</div>
								</li>
								<li>
									<label for="confirm_password" class="required"> Xác nhận mật khẩu <em>*</em></label>
									<div class="input-box">
										<input type="password" name="confirm_password" id="confirm_password" class="input-text required-entry" required />
									</div>
								</li>
							</ul>
						</div>

						<div class="buttons-set" style="margin-top: 20px;">
							<button type="submit" class="button btn-login" style="width: 100%;">
								<span>Cập nhật mật khẩu</span>
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
    
    <script>
        document.getElementById('reset-form').addEventListener('submit', function(e) {
            const pass = document.getElementById('password').value;
            const confirm = document.getElementById('confirm_password').value;
            
            if (pass !== confirm) {
                e.preventDefault();
                alert('Mật khẩu xác nhận không khớp!');
            }
        });
    </script>
</body>
</html>
