<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>

<%
if (session.getAttribute("authUser") == null) {
	response.sendRedirect(request.getContextPath() + "/login?returnUrl=/account");
	return;
}
%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Tài khoản của tôi | BOBIXI Cinema</title>

 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/account.css" />

</head>
<body>

	<div class="account-dashboard">
		<div class="page-title">
			<h1>Tài khoản của tôi</h1>
		</div>

		<div class="account-container">

			<!-- SIDEBAR -->
			<div class="account-sidebar">
				<div class="user-profile">
					<div class="user-avatar">
						<div class="avatar-placeholder">
							<c:choose>
								<c:when test="${not empty sessionScope.authUser.fullName}">
                                ${sessionScope.authUser.fullName.substring(0,1)}
                            </c:when>
								<c:otherwise>
                                ${sessionScope.authUser.email.substring(0,1)}
                            </c:otherwise>
							</c:choose>
						</div>
					</div>

					<h3 style="margin: 0;">
						<c:out value="${sessionScope.authUser.fullName}" />
					</h3>
					<p class="user-email">
						<c:out value="${sessionScope.authUser.email}" />
					</p>

					<span class="badge-role"> <c:out
							value="${sessionScope.authUser.role}" />
					</span>
				</div>

				<nav class="account-menu">
					<a href="#overview" class="menu-item active"
						onclick="showSection('overview'); return false;">Tổng quan</a> <a
						href="#profile" class="menu-item"
						onclick="showSection('profile'); return false;">Thông tin cá
						nhân</a> <a href="#settings" class="menu-item"
						onclick="showSection('settings'); return false;">Nhận thông
						báo</a> <a href="${pageContext.request.contextPath}/logout"
						class="menu-item logout">Đăng xuất</a> <a
						href="${pageContext.request.contextPath}/home"
						class="menu-item home">Trang chủ</a>
				</nav>
			</div>

			<!-- CONTENT -->
			<div class="account-content">

				<!-- OVERVIEW -->
				<div id="overview-section" class="content-section active">
					<h2 style="margin-top: 0;">Tổng quan</h2>

					<div class="grid-2" style="margin-top: 14px;">
						<div class="info-card">
							<div class="label">Ngày tạo tài khoản</div>
							<div class="value">
								<c:choose>
									<c:when test="${not empty sessionScope.authUser.createdAt}">
										<fmt:formatDate value="${sessionScope.authUser.createdAt}"
											pattern="dd/MM/yyyy HH:mm" />
									</c:when>
									<c:otherwise>—</c:otherwise>
								</c:choose>
							</div>
						</div>

						<div class="info-card">
							<div class="label">Giới tính</div>
							<div class="value">
								<c:choose>
									<c:when test="${not empty sessionScope.authUser.gender}">
										<c:out value="${sessionScope.authUser.gender}" />
									</c:when>
									<c:otherwise>—</c:otherwise>
								</c:choose>
							</div>
						</div>

						<div class="info-card">
							<div class="label">Ngày sinh</div>
							<div class="value">
								<c:choose>
									<c:when test="${not empty sessionScope.authUser.dateOfBirth}">
										<fmt:formatDate value="${sessionScope.authUser.dateOfBirth}"
											pattern="dd/MM/yyyy" />
									</c:when>
									<c:otherwise>—</c:otherwise>
								</c:choose>
							</div>
						</div>

						<div class="info-card">
							<div class="label">Số điện thoại</div>
							<div class="value">
								<c:choose>
									<c:when test="${not empty sessionScope.authUser.phoneNumber}">
										<c:out value="${sessionScope.authUser.phoneNumber}" />
									</c:when>
									<c:otherwise>—</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>

					<div class="info-card" style="margin-top: 14px;">
						<div class="label">Địa chỉ</div>
						<div class="value">
							<c:choose>
								<c:when test="${not empty sessionScope.authUser.address}">
									<c:out value="${sessionScope.authUser.address}" />
								</c:when>
								<c:otherwise>—</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>

				<!-- PROFILE -->
				<div id="profile-section" class="content-section">
					<h2 style="margin-top: 0;">Thông tin cá nhân</h2>

					<!-- Bạn có thể tạo servlet POST /account/update để lưu -->
					<form action="${pageContext.request.contextPath}/account/update"
						method="post">

						<div class="form-group">
							<label>Họ và tên *</label> <input type="text" name="fullName"
								value="${sessionScope.authUser.fullName}" required />
						</div>

						<div class="form-row">
							<div class="form-group">
								<label>Email</label> <input type="email"
									value="${sessionScope.authUser.email}" readonly />
								<div class="form-note">Email không thể thay đổi</div>
							</div>

							<div class="form-group">
								<label>Số điện thoại</label> <input type="tel"
									name="phoneNumber" value="${sessionScope.authUser.phoneNumber}" />
							</div>
						</div>

						<div class="form-row">
							<div class="form-group">
								<label>Ngày sinh</label> <input type="date" name="dateOfBirth"
									value="<fmt:formatDate value='${sessionScope.authUser.dateOfBirth}' pattern='yyyy-MM-dd'/>" />
							</div>

							<div class="form-group">
								<label>Giới tính</label> <select name="gender">
									<option value=""
										${empty sessionScope.authUser.gender ? 'selected' : ''}>--
										Chọn --</option>
									<option value="MALE"
										${sessionScope.authUser.gender == 'MALE' ? 'selected' : ''}>Nam</option>
									<option value="FEMALE"
										${sessionScope.authUser.gender == 'FEMALE' ? 'selected' : ''}>Nữ</option>
									<option value="OTHER"
										${sessionScope.authUser.gender == 'OTHER' ? 'selected' : ''}>Khác</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label>Địa chỉ</label>
							<textarea name="address" rows="3">${sessionScope.authUser.address}</textarea>
						</div>

						<div class="actions">
							<button type="submit" class="btn-save">Lưu thay đổi</button>
							<button type="button" class="btn-secondary"
								onclick="showSection('overview')">Hủy</button>
						</div>
					</form>

					<hr style="margin: 24px 0; border: 0; border-top: 1px solid #eee;" />

					<h3>Đổi mật khẩu</h3>
					<form
						action="${pageContext.request.contextPath}/account/change-password"
						method="post">
						<div class="form-group">
							<label>Mật khẩu hiện tại *</label> <input type="password"
								name="currentPassword" required />
						</div>

						<div class="form-row">
							<div class="form-group">
								<label>Mật khẩu mới *</label> <input type="password"
									name="newPassword" required />
							</div>
							<div class="form-group">
								<label>Xác nhận mật khẩu mới *</label> <input type="password"
									name="confirmPassword" required />
							</div>
						</div>

						<div class="actions">
							<button type="submit" class="btn-save">Đổi mật khẩu</button>
						</div>
					</form>
				</div>

				<!-- SETTINGS -->
				<div id="settings-section" class="content-section">
					<h2 style="margin-top: 0;">Nhận thông báo</h2>

					<form action="${pageContext.request.contextPath}/account/settings"
						method="post">

						<div class="form-group">
							<label class="checkbox-label"> <input type="checkbox"
								name="subscribeNewsletter"
								${sessionScope.authUser.subscribeNewsletter ? 'checked' : ''} />
								<span>Nhận email khuyến mãi / tin tức (Newsletter)</span>
							</label>
						</div>

						<div class="form-group">
							<label class="checkbox-label"> <input type="checkbox"
								name="subscribeSMS"
								${sessionScope.authUser.subscribeSMS ? 'checked' : ''} /> <span>Nhận
									SMS thông báo</span>
							</label>
						</div>

						<div class="actions">
							<button type="submit" class="btn-save">Lưu cài đặt</button>
						</div>
					</form>
				</div>

			</div>
			
			<c:if test="${not empty param.success}">
					<div class="alert alert-success" style="margin-bottom: 12px;">
						<c:choose>
							<c:when test="${param.success == 'profile_updated'}">✅ Cập nhật thông tin thành công.</c:when>
							<c:when test="${param.success == 'password_changed'}">✅ Đổi mật khẩu thành công.</c:when>
							<c:when test="${param.success == 'settings_updated'}">✅ Lưu cài đặt thông báo thành công.</c:when>
							<c:otherwise>✅ Thao tác thành công.</c:otherwise>
						</c:choose>
					</div>
				</c:if>

				<c:if test="${not empty param.error}">
					<div class="alert alert-danger" style="margin-bottom: 12px;">
						<c:choose>
							<c:when test="${param.error == 'password_mismatch'}">❌ Mật khẩu mới và xác nhận không khớp.</c:when>
							<c:when test="${param.error == 'wrong_password'}">❌ Mật khẩu hiện tại không đúng.</c:when>
							<c:when test="${param.error == 'invalid_input'}">❌ Dữ liệu không hợp lệ.</c:when>
							<c:otherwise>❌ Có lỗi xảy ra.</c:otherwise>
						</c:choose>
					</div>
				</c:if>
			
		</div>
	</div>

	<script type="text/javascript">
		function showSection(sectionId) {
			// menu active
			var items = document.querySelectorAll('.menu-item');
			items.forEach(function(a) {
				a.classList.remove('active');
			});
			var cur = document.querySelector('.menu-item[href="#' + sectionId
					+ '"]');
			if (cur)
				cur.classList.add('active');

			// section active
			var sections = document.querySelectorAll('.content-section');
			sections.forEach(function(s) {
				s.classList.remove('active');
			});
			var target = document.getElementById(sectionId + '-section');
			if (target)
				target.classList.add('active');

			history.pushState(null, null, '#' + sectionId);
		}

		(function initHash() {
			var hash = window.location.hash ? window.location.hash.substring(1)
					: '';
			if (hash)
				showSection(hash);
		})();
	</script>

</body>
</html>
