<%@ page contentType="text/html; charset=UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">

		<header class="bobixi-header">
			<div class="header-top">
				<div class="logo">
					<a href="${pageContext.request.contextPath}/home"> <img
							src="${pageContext.request.contextPath}/assets/images/home/logo.jpg" alt="BOBIXI">
					</a>
				</div>

				<nav class="main-menu">
					<a href="${pageContext.request.contextPath}/movie">PHIM</a>
					<a href="${pageContext.request.contextPath}/showtime">LỊCH CHIẾU</a>
					<a href="${pageContext.request.contextPath}/booking-seat">ĐẶT VÉ</a>
					<a href="${pageContext.request.contextPath}/pages/clients/cinema/cinema-detail.jsp">RẠP</a>
					<a href="${pageContext.request.contextPath}/contact">LIÊN HỆ</a>
					<a href="${pageContext.request.contextPath}/pages/clients/about.jsp">THÀNH VIÊN</a>
				</nav>

				<div class="user-menu">

					<!-- CHƯA ĐĂNG NHẬP -->
					<c:if test="${empty sessionScope.authUser}">
						<a href="${pageContext.request.contextPath}/login">Đăng nhập</a> |
						<a href="${pageContext.request.contextPath}/register">Đăng
							ký</a>
					</c:if>

					<c:if test="${not empty sessionScope.adminUser}">
						ADMIN PANEL
					</c:if>

					<c:if test="${not empty sessionScope.authUser}">
						<div class="account-wrapper">
							<span class="account-name"> 👤
								<c:out value="${sessionScope.authUser.fullName != null 
                            ? sessionScope.authUser.fullName 
                            : sessionScope.authUser.email}" />
								▾
							</span>

							<div class="account-dropdown">
								<a href="${pageContext.request.contextPath}/account"> Tài
									khoản của tôi </a> <a href="${pageContext.request.contextPath}/booking/history"> Vé
									đã mua </a>

								<c:if test="${sessionScope.authUser.role == 'ADMIN'}">
									<a href="${pageContext.request.contextPath}/admin">
										Quản trị hệ thống </a>
								</c:if>

								<a href="${pageContext.request.contextPath}/logout"> Đăng xuất
								</a>
							</div>
						</div>
					</c:if>

				</div>
			</div>
		</header>