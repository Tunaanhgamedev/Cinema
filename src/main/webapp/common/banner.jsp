<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="home-banner">
    <img src="${pageContext.request.contextPath}/assets/images/banners/left.jpg"
         alt="Home Banner">
</div>

<style>
/* Banner full màn hình ngang */
.home-banner {
  width: 100vw;
  position: relative;

  /* phá giới hạn container */
  left: 50%;
  right: 50%;
  margin-left: -50vw;
  margin-right: -50vw;

  overflow: hidden;
}

.home-banner img {
  width: 100%;
  height: auto;          /* giữ đúng tỷ lệ */
  display: block;        /* xoá khoảng trắng dưới img */
  object-fit: cover;
}

.home-banner img {
  width: 100%;
  height: 420px;         /* tuỳ chỉnh */
  object-fit: cover;
}

@media (max-width: 768px) {
  .home-banner img {
    height: 220px;
  }
}

</style>