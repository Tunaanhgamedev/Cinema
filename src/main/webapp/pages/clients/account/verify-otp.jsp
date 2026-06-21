<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>XÁC THỰC OTP | BOBIXI Cinema</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css" />
<style>
    .otp-inputs { display: flex; gap: 10px; justify-content: center; margin-bottom: 20px; }
    .otp-input { width: 45px; height: 50px; text-align: center; font-size: 24px; font-weight: bold; border: 2px solid #e2e8f0; border-radius: 8px; }
    .otp-input:focus { border-color: #6366f1; outline: none; }
</style>
</head>

<body>
	<div class="account-login">
		<div class="page-title">
			<h1>Xác thực OTP</h1>
		</div>

		<div class="login-container" style="justify-content: center;">
			<div class="col-login" style="width: 100%; max-width: 500px; border-right: none;">
				<div class="col-wrapper">
					<h2>Nhập mã OTP</h2>
                    <p style="margin-bottom: 20px; color: #666;">Mã xác thực đã được gửi tới <strong>${email}</strong>. Mã có hiệu lực trong 10 phút.</p>

					<c:if test="${not empty error}">
						<div class="messages">
							<ul class="messages"><li class="error-msg"><ul><li><span>${error}</span></li></ul></li></ul>
						</div>
					</c:if>

					<form action="${pageContext.request.contextPath}/verify-otp" method="post" id="otp-form">
                        <input type="hidden" name="email" value="${email}" />
                        
                        <div class="otp-inputs">
                            <input type="text" maxlength="1" class="otp-input" required />
                            <input type="text" maxlength="1" class="otp-input" required />
                            <input type="text" maxlength="1" class="otp-input" required />
                            <input type="text" maxlength="1" class="otp-input" required />
                            <input type="text" maxlength="1" class="otp-input" required />
                            <input type="text" maxlength="1" class="otp-input" required />
                        </div>
                        
                        <input type="hidden" name="otp" id="final-otp" />

						<div class="buttons-set">
							<button type="submit" class="button btn-login" style="width: 100%;">
								<span>Xác nhận mã</span>
							</button>
						</div>
                        
                        <div style="margin-top: 20px; text-align: center; font-size: 14px;">
                            Không nhận được mã? <a href="#" style="color: #6366f1; font-weight: 600;"> Gửi lại mã </a>
                        </div>
					</form>
				</div>
			</div>
		</div>
	</div>
    
    <script>
        const inputs = document.querySelectorAll('.otp-input');
        const finalOtpInput = document.getElementById('final-otp');
        const form = document.getElementById('otp-form');

        inputs.forEach((input, index) => {
            input.addEventListener('input', (e) => {
                if (e.target.value.length > 0 && index < inputs.length - 1) {
                    inputs[index + 1].focus();
                }
            });

            input.addEventListener('keydown', (e) => {
                if (e.key === 'Backspace' && e.target.value.length === 0 && index > 0) {
                    inputs[index - 1].focus();
                }
            });
        });

        form.addEventListener('submit', (e) => {
            let otp = "";
            inputs.forEach(input => otp += input.value);
            finalOtpInput.value = otp;
        });
    </script>
</body>
</html>
