<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Điều khoản sử dụng</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer/terms.css">
</head>

<body>
  <jsp:include page="/common/header.jsp"/>

  <!-- Hero -->
  <section class="terms-hero">
    <div class="container py-5">
      <div class="terms-hero-box">
        <div class="d-flex align-items-center gap-3 flex-wrap">
          <div class="terms-badge"><i class="fa-solid fa-ticket"></i></div>
          <div>
            <h1 class="terms-title mb-1">Điều khoản sử dụng</h1>
            <div class="terms-sub">
              Vui lòng đọc kỹ trước khi sử dụng dịch vụ đặt vé & quản lý vé xem phim online.
            </div>
          </div>
        </div>

        <div class="terms-actions mt-4">
          <a class="btn btn-light btn-lg" href="${pageContext.request.contextPath}/home">
            <i class="fa-solid fa-house me-2"></i>Trang chủ
          </a>
          <a class="btn btn-dark btn-lg" href="#toc">
            <i class="fa-solid fa-list-ul me-2"></i>Xem mục lục
          </a>
        </div>
      </div>
    </div>
  </section>

  <main class="container my-4 my-md-5">

    <!-- Intro + Quick note -->
    <div class="row g-4">
      <div class="col-lg-8">
        <div class="terms-card">
          <div class="terms-card-header">
            <i class="fa-solid fa-circle-info me-2"></i>Thông tin chung
          </div>
          <div class="terms-card-body">
            <p class="mb-2">
              Khi truy cập và sử dụng website <strong>Quản lý vé xem phim online</strong>,
              bạn được xem như đã đồng ý với toàn bộ các điều khoản dưới đây.
            </p>
            <div class="terms-alert">
              <i class="fa-solid fa-shield-halved me-2"></i>
              <span>Hãy đảm bảo thông tin đặt vé (phim – suất chiếu – ghế) chính xác trước khi xác nhận.</span>
            </div>
          </div>
        </div>
      </div>

      <div class="col-lg-4">
        <div class="terms-card" id="toc">
          <div class="terms-card-header">
            <i class="fa-solid fa-map me-2"></i>Mục lục
          </div>
          <div class="terms-card-body">
            <a class="toc-item" href="#sec1"><i class="fa-solid fa-layer-group me-2"></i>1. Phạm vi áp dụng</a>
            <a class="toc-item" href="#sec2"><i class="fa-solid fa-user-lock me-2"></i>2. Tài khoản người dùng</a>
            <a class="toc-item" href="#sec3"><i class="fa-solid fa-credit-card me-2"></i>3. Đặt vé & thanh toán</a>
            <a class="toc-item" href="#sec4"><i class="fa-solid fa-ban me-2"></i>4. Quy định sử dụng</a>
            <a class="toc-item" href="#sec5"><i class="fa-solid fa-scale-balanced me-2"></i>5. Quyền & trách nhiệm</a>
            <a class="toc-item" href="#sec6"><i class="fa-solid fa-rotate me-2"></i>6. Thay đổi điều khoản</a>
            <a class="toc-item" href="#sec7"><i class="fa-solid fa-headset me-2"></i>7. Liên hệ</a>
          </div>
        </div>
      </div>
    </div>

    <!-- Sections -->
    <div class="terms-grid mt-4">

      <section class="terms-card" id="sec1">
        <div class="terms-card-header">
          <i class="fa-solid fa-layer-group me-2"></i>1. Phạm vi áp dụng
        </div>
        <div class="terms-card-body">
          <ul class="terms-list">
            <li>Áp dụng cho tất cả người dùng truy cập và sử dụng website.</li>
            <li>Áp dụng cho các chức năng: đăng ký, đăng nhập, đặt vé, chọn ghế, thanh toán và quản lý vé.</li>
          </ul>
        </div>
      </section>

      <section class="terms-card" id="sec2">
        <div class="terms-card-header">
          <i class="fa-solid fa-user-lock me-2"></i>2. Tài khoản người dùng
        </div>
        <div class="terms-card-body">
          <ul class="terms-list">
            <li>Người dùng phải cung cấp thông tin chính xác khi đăng ký tài khoản.</li>
            <li>Mỗi tài khoản chỉ được sử dụng bởi một người.</li>
            <li>Người dùng có trách nhiệm bảo mật thông tin đăng nhập của mình.</li>
          </ul>
        </div>
      </section>

      <section class="terms-card" id="sec3">
        <div class="terms-card-header">
          <i class="fa-solid fa-credit-card me-2"></i>3. Quy định đặt vé và thanh toán
        </div>
        <div class="terms-card-body">
          <ul class="terms-list">
            <li>Vé đã đặt thành công không được hoàn trả trừ trường hợp hệ thống lỗi.</li>
            <li>Người dùng phải kiểm tra kỹ thông tin phim, suất chiếu và ghế trước khi xác nhận.</li>
            <li>Website không chịu trách nhiệm nếu người dùng nhập sai thông tin.</li>
          </ul>
          <div class="terms-tip mt-3">
            <i class="fa-solid fa-lightbulb me-2"></i>
            Mẹo: Bạn có thể chụp/ lưu mã vé sau khi đặt để tiện đối soát.
          </div>
        </div>
      </section>

      <section class="terms-card" id="sec4">
        <div class="terms-card-header">
          <i class="fa-solid fa-ban me-2"></i>4. Quy định sử dụng website
        </div>
        <div class="terms-card-body">
          <ul class="terms-list">
            <li>Không sử dụng website cho mục đích trái pháp luật.</li>
            <li>Không tấn công, phá hoại hoặc can thiệp vào hệ thống.</li>
            <li>Không sao chép, chỉnh sửa hoặc phân phối nội dung khi chưa được cho phép.</li>
          </ul>
        </div>
      </section>

      <section class="terms-card" id="sec5">
        <div class="terms-card-header">
          <i class="fa-solid fa-scale-balanced me-2"></i>5. Quyền và trách nhiệm của hệ thống
        </div>
        <div class="terms-card-body">
          <ul class="terms-list">
            <li>Có quyền thay đổi nội dung, giao diện và chức năng của website.</li>
            <li>Có quyền khóa hoặc xóa tài khoản vi phạm điều khoản.</li>
            <li>Cam kết bảo mật thông tin cá nhân của người dùng theo chính sách hiện hành.</li>
          </ul>
        </div>
      </section>

      <section class="terms-card" id="sec6">
        <div class="terms-card-header">
          <i class="fa-solid fa-rotate me-2"></i>6. Thay đổi điều khoản
        </div>
        <div class="terms-card-body">
          <p class="mb-0">
            Điều khoản có thể được cập nhật bất kỳ lúc nào. Người dùng nên thường xuyên kiểm tra để cập nhật nội dung mới nhất.
          </p>
        </div>
      </section>

      <section class="terms-card" id="sec7">
        <div class="terms-card-header">
          <i class="fa-solid fa-headset me-2"></i>7. Liên hệ
        </div>
        <div class="terms-card-body">
          <div class="contact-box">
            <div><i class="fa-solid fa-envelope me-2"></i>Email: <strong>support@bobixi.com</strong></div>
            <div><i class="fa-solid fa-phone me-2"></i>Hotline: <strong>1900 1111</strong></div>
          </div>

          <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-lg">
              <i class="fa-solid fa-arrow-left me-2"></i>Quay về trang chủ
            </a>
          </div>
        </div>
      </section>

    </div>
  </main>

  <!-- Back to top -->
  <a class="back-to-top" href="#top" onclick="window.scrollTo({top:0,behavior:'smooth'}); return false;">
    <i class="fa-solid fa-arrow-up"></i>
  </a>

  <jsp:include page="/common/footer.jsp"/>
</body>
</html>
