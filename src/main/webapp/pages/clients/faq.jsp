<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>FAQ | BOBIXI Cinema</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/faq.css">
</head>
<body>

  <jsp:include page="/common/header.jsp"/>

  <div class="faq-page">
    <!-- HERO -->
    <section class="faq-hero">
      <div class="container faq-hero-inner">
        <div>
          <div class="faq-badge">💡 Câu hỏi thường gặp</div>
          <h1>Giải đáp nhanh – đúng – đủ</h1>
          <p>Tìm câu trả lời theo từ khóa, danh mục hoặc câu hỏi nổi bật.</p>
        </div>

        <div class="faq-search">
          <input id="faqSearch" type="text" placeholder="Tìm câu hỏi... (vd: hoàn tiền, đặt vé, momo)" />
          <button id="btnClear" type="button">Xóa</button>
        </div>
      </div>
    </section>

    <main class="container faq-wrap">

      <!-- CHIPS: CÂU HỎI NỔI BẬT -->
      <div class="faq-hot">
        <div class="faq-hot-title">🔥 Nổi bật</div>
        <div class="faq-hot-chips">
          <button class="chip" type="button" data-key="đặt vé online">Cách đặt vé online</button>
          <button class="chip" type="button" data-key="hoàn tiền">Chính sách hoàn tiền</button>
          <button class="chip" type="button" data-key="mã giảm giá">Dùng mã giảm giá</button>
          <button class="chip" type="button" data-key="mang đồ ăn">Mang đồ ăn vào rạp</button>
          <button class="chip" type="button" data-key="điểm tích lũy">Điểm tích lũy</button>
        </div>
      </div>

      <!-- FILTER CATEGORIES -->
      <div class="faq-categories" id="faqCategories">
        <button class="cat active" type="button" data-cat="all">Tất cả</button>
        <button class="cat" type="button" data-cat="booking">Đặt vé</button>
        <button class="cat" type="button" data-cat="payment">Thanh toán</button>
        <button class="cat" type="button" data-cat="membership">Thành viên</button>
        <button class="cat" type="button" data-cat="cinema">Rạp chiếu</button>
        <button class="cat" type="button" data-cat="promotion">Khuyến mãi</button>
        <button class="cat" type="button" data-cat="other">Khác</button>

        <div class="faq-count" id="faqCount"></div>
      </div>

      <!-- FAQ LIST -->
      <section class="faq-list" id="faqList">

        <!-- ====== ĐẶT VÉ ====== -->
        <div class="faq-section" data-section="booking">
          <h2>Đặt vé</h2>

          <article class="faq-item" data-cat="booking">
            <button class="faq-q" type="button">
              <span class="faq-q-text">Làm sao để đặt vé online?</span>
              <span class="chev">▾</span>
            </button>
            <div class="faq-a">
              <p>Để đặt vé online tại BOBIXI, bạn thực hiện theo các bước sau:</p>
              <ol>
                <li>Truy cập website</li>
                <li>Chọn phim bạn muốn xem</li>
                <li>Chọn rạp, ngày và suất chiếu</li>
                <li>Chọn ghế ngồi</li>
                <li>Thanh toán trực tuyến</li>
                <li>Nhận mã QR và xuất trình tại rạp</li>
              </ol>
              <p>Bạn có thể đăng ký tài khoản để lưu lịch sử đặt vé và tích điểm thành viên.</p>
            </div>
          </article>

          <article class="faq-item" data-cat="booking">
            <button class="faq-q" type="button">
              <span class="faq-q-text">Tôi có thể đặt vé trước bao lâu?</span>
              <span class="chev">▾</span>
            </button>
            <div class="faq-a">
              <p>Bạn có thể đặt vé trước tối đa 7 ngày kể từ ngày hiện tại. Lịch chiếu được cập nhật hàng ngày.</p>
            </div>
          </article>

          <article class="faq-item" data-cat="booking">
            <button class="faq-q" type="button">
              <span class="faq-q-text">Tôi có thể đặt bao nhiêu vé trong một lần?</span>
              <span class="chev">▾</span>
            </button>
            <div class="faq-a">
              <p>Mỗi lần đặt vé, bạn có thể đặt tối đa 8 vé cho cùng một suất chiếu.</p>
            </div>
          </article>
        </div>

        <!-- ====== THANH TOÁN ====== -->
        <div class="faq-section" data-section="payment">
          <h2>Thanh toán</h2>

          <article class="faq-item" data-cat="payment">
            <button class="faq-q" type="button">
              <span class="faq-q-text">BOBIXI chấp nhận những phương thức thanh toán nào?</span>
              <span class="chev">▾</span>
            </button>
            <div class="faq-a">
              <ul>
                <li>Thẻ ATM nội địa (qua VNPay)</li>
                <li>Ví điện tử MoMo</li>
                <li>Thanh toán tại quầy vé</li>
              </ul>
            </div>
          </article>

          <article class="faq-item" data-cat="payment">
            <button class="faq-q" type="button">
              <span class="faq-q-text">Có được hoàn tiền khi hủy vé không?</span>
              <span class="chev">▾</span>
            </button>
            <div class="faq-a">
              <ul>
                <li>Trước giờ chiếu ≥ 24h: Hoàn 100%</li>
                <li>Trước giờ chiếu 12–24h: Hoàn 50%</li>
                <li>Dưới 12h: Không hoàn</li>
              </ul>
              <p>Phí hoàn vé (nếu có): 10.000 VNĐ/vé.</p>
            </div>
          </article>
        </div>

        <!-- ====== THÀNH VIÊN ====== -->
        <div class="faq-section" data-section="membership">
          <h2>Thành viên</h2>

          <article class="faq-item" data-cat="membership">
            <button class="faq-q" type="button">
              <span class="faq-q-text">Làm sao để trở thành thành viên BOBIXI?</span>
              <span class="chev">▾</span>
            </button>
            <div class="faq-a">
              <ol>
                <li>Vào website</li>
                <li>Nhấn “Đăng ký”</li>
                <li>Điền thông tin</li>
                <li>Xác nhận email</li>
              </ol>
              <p>Đăng ký hoàn toàn miễn phí.</p>
            </div>
          </article>

          <article class="faq-item" data-cat="membership">
            <button class="faq-q" type="button">
              <span class="faq-q-text">Quyền lợi của thành viên BOBIXI là gì?</span>
              <span class="chev">▾</span>
            </button>
            <div class="faq-a">
              <ul>
                <li>Tích điểm từ mỗi giao dịch</li>
                <li>Ưu đãi sinh nhật</li>
                <li>Giảm giá ngày đặc biệt</li>
                <li>Ưu tiên đặt vé phim hot</li>
              </ul>
            </div>
          </article>

          <article class="faq-item" data-cat="membership">
            <button class="faq-q" type="button">
              <span class="faq-q-text">Điểm tích lũy có thời hạn sử dụng không?</span>
              <span class="chev">▾</span>
            </button>
            <div class="faq-a">
              <p>Điểm có hiệu lực 12 tháng kể từ ngày tích. Hết hạn sẽ tự động bị xóa.</p>
            </div>
          </article>
        </div>

        <!-- ====== RẠP CHIẾU ====== -->
        <div class="faq-section" data-section="cinema">
          <h2>Rạp chiếu</h2>

          <article class="faq-item" data-cat="cinema">
            <button class="faq-q" type="button">
              <span class="faq-q-text">Tôi có thể mang đồ ăn từ bên ngoài vào rạp không?</span>
              <span class="chev">▾</span>
            </button>
            <div class="faq-a">
              <p>Khách không được mang thức ăn/đồ uống từ ngoài vào phòng chiếu. Rạp có quầy bắp nước phục vụ.</p>
            </div>
          </article>

          <article class="faq-item" data-cat="cinema">
            <button class="faq-q" type="button">
              <span class="faq-q-text">Trẻ em có cần mua vé không?</span>
              <span class="chev">▾</span>
            </button>
            <div class="faq-a">
              <p>Trẻ từ 2 tuổi trở lên phải mua vé. Trẻ dưới 13 tuổi xem phim 13+ phải có người lớn đi kèm.</p>
            </div>
          </article>
        </div>

        <!-- ====== KHUYẾN MÃI ====== -->
        <div class="faq-section" data-section="promotion">
          <h2>Khuyến mãi</h2>

          <article class="faq-item" data-cat="promotion">
            <button class="faq-q" type="button">
              <span class="faq-q-text">Làm sao để sử dụng mã giảm giá?</span>
              <span class="chev">▾</span>
            </button>
            <div class="faq-a">
              <ol>
                <li>Chọn vé</li>
                <li>Ở bước thanh toán, nhập mã vào ô “Mã khuyến mãi”</li>
                <li>Nhấn “Áp dụng”</li>
              </ol>
            </div>
          </article>
        </div>

        <!-- EMPTY STATE -->
        <div class="faq-empty" id="faqEmpty" hidden>
          <div class="faq-empty-card">
            <div class="t1">Không tìm thấy câu hỏi phù hợp</div>
            <div class="t2">Thử từ khóa khác hoặc chọn “Tất cả”.</div>
          </div>
        </div>

      </section>

      <!-- SUPPORT -->
      <section class="faq-support">
        <h3>Không tìm thấy câu trả lời?</h3>
        <p>Liên hệ để được hỗ trợ trực tiếp.</p>

        <div class="support-actions">
          <a class="support-btn" href="${pageContext.request.contextPath}/contact">✉️ Gửi câu hỏi</a>
          <a class="support-btn" href="tel:19001111">☎️ Gọi 1900 1111</a>
          <a class="support-btn" href="#" target="_blank">💬 Chat Facebook</a>
        </div>
      </section>

    </main>
  </div>

  <jsp:include page="/common/footer.jsp"/>

  <script src="${pageContext.request.contextPath}/assets/js/faq.js"></script>
</body>
</html>
