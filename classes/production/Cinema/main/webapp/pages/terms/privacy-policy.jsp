<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chính sách bảo mật</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/footer/privacy-policy.css">
</head>

<body>
    <jsp:include page="/common/header.jsp"/>

    <!-- Hero -->
    <section class="terms-hero">
        <div class="container py-5">
            <div class="terms-hero-box">
                <h1 class="terms-title mb-2">Chính sách bảo mật</h1>
                <p class="terms-sub mb-0">
                    Chúng tôi cam kết bảo vệ thông tin cá nhân và quyền riêng tư của người dùng.
                </p>
            </div>
        </div>
    </section>

    <main class="container my-5">

        <section class="terms-card mb-4">
            <div class="terms-card-header">1. Mục đích thu thập thông tin</div>
            <div class="terms-card-body">
                <p>Website thu thập thông tin cá nhân của người dùng nhằm phục vụ cho các mục đích:</p>
                <ul class="terms-list">
                    <li>Quản lý tài khoản người dùng.</li>
                    <li>Hỗ trợ đặt vé, thanh toán và quản lý lịch sử giao dịch.</li>
                    <li>Cải thiện chất lượng dịch vụ và trải nghiệm người dùng.</li>
                </ul>
            </div>
        </section>

        <section class="terms-card mb-4">
            <div class="terms-card-header">2. Phạm vi thu thập thông tin</div>
            <div class="terms-card-body">
                <ul class="terms-list">
                    <li>Họ và tên</li>
                    <li>Email</li>
                    <li>Số điện thoại</li>
                    <li>Thông tin đăng nhập tài khoản</li>
                </ul>
            </div>
        </section>

        <section class="terms-card mb-4">
            <div class="terms-card-header">3. Phạm vi sử dụng thông tin</div>
            <div class="terms-card-body">
                <ul class="terms-list">
                    <li>Thông tin chỉ được sử dụng trong nội bộ hệ thống.</li>
                    <li>Không chia sẻ, mua bán hoặc trao đổi thông tin cá nhân với bên thứ ba.</li>
                    <li>Chỉ cung cấp khi có yêu cầu hợp pháp từ cơ quan chức năng.</li>
                </ul>
            </div>
        </section>

        <section class="terms-card mb-4">
            <div class="terms-card-header">4. Thời gian lưu trữ thông tin</div>
            <div class="terms-card-body">
                <p>
                    Thông tin cá nhân của người dùng được lưu trữ trong suốt thời gian tài khoản còn hoạt động
                    hoặc theo yêu cầu của pháp luật hiện hành.
                </p>
            </div>
        </section>

        <section class="terms-card mb-4">
            <div class="terms-card-header">5. Cam kết bảo mật thông tin</div>
            <div class="terms-card-body">
                <ul class="terms-list">
                    <li>Áp dụng các biện pháp kỹ thuật để bảo vệ dữ liệu.</li>
                    <li>Ngăn chặn truy cập trái phép, mất mát hoặc rò rỉ thông tin.</li>
                    <li>Thường xuyên nâng cấp và bảo trì hệ thống.</li>
                </ul>
            </div>
        </section>

        <section class="terms-card mb-4">
            <div class="terms-card-header">6. Quyền của người dùng</div>
            <div class="terms-card-body">
                <ul class="terms-list">
                    <li>Yêu cầu xem, chỉnh sửa hoặc xóa thông tin cá nhân.</li>
                    <li>Yêu cầu ngừng sử dụng dữ liệu cá nhân.</li>
                    <li>Gửi khiếu nại khi phát hiện thông tin bị sử dụng sai mục đích.</li>
                </ul>
            </div>
        </section>

        <section class="terms-card mb-4">
            <div class="terms-card-header">7. Liên hệ</div>
            <div class="terms-card-body">
                <p>Nếu có bất kỳ câu hỏi nào liên quan đến chính sách bảo mật, vui lòng liên hệ:</p>
                <p class="mb-1">📧 Email: <strong>support@bobixi.com</strong></p>
                <p>☎ Hotline: <strong>1900 1111	</strong></p>

                <div class="text-center mt-4">
                    <a href="${pageContext.request.contextPath}/home"
                       class="btn btn-primary btn-lg">
                        Quay về trang chủ
                    </a>
                </div>
            </div>
        </section>

    </main>

    <jsp:include page="/common/footer.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
<button id="backToTop" class="back-to-top-btn" type="button" aria-label="Lên đầu trang">
  ↑
</button>

<script>
  const btn = document.getElementById("backToTop");

  // Ẩn/hiện theo cuộn
  window.addEventListener("scroll", () => {
    if (window.scrollY > 300) btn.classList.add("show");
    else btn.classList.remove("show");
  });

  // Click lên đầu
  btn.addEventListener("click", () => {
    window.scrollTo({ top: 0, behavior: "smooth" });
  });
</script>

</html>
