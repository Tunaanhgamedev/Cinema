<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Chính Sách Thanh Toán</title>

  <!-- Boxicons (bạn có thể bỏ nếu project đã import sẵn) -->
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

  <style>
    :root{
      --bg0:#07070b;
      --bg1:#0b0b14;
      --card: rgba(255,255,255,.06);
      --stroke: rgba(255,255,255,.10);
      --text:#f2f4ff;
      --muted: rgba(242,244,255,.72);
      --neon1:#ff2d95;
      --neon2:#7c4dff;
      --neon3:#00e5ff;
      --gold:#ffcc00;
      --shadow: 0 18px 50px rgba(0,0,0,.55);
      --radius: 18px;
    }

    *{box-sizing:border-box}
    body{
      margin:0;
      color:var(--text);
      font-family: "Segoe UI", Tahoma, system-ui, -apple-system, Arial, sans-serif;
      background:
        radial-gradient(900px 520px at 15% 10%, rgba(255,45,149,.22), transparent 60%),
        radial-gradient(900px 520px at 85% 20%, rgba(0,229,255,.16), transparent 60%),
        radial-gradient(1200px 700px at 50% 100%, rgba(124,77,255,.18), transparent 60%),
        linear-gradient(180deg, var(--bg0), var(--bg1));
      overflow-x:hidden;
    }

    /* neon film grain nhẹ */
    body::before{
      content:"";
      position:fixed; inset:0;
      background-image:
        radial-gradient(rgba(255,255,255,.05) 1px, transparent 1px);
      background-size: 3px 3px;
      opacity:.12;
      pointer-events:none;
      mix-blend-mode: overlay;
    }

    .wrap{
      max-width: 1040px;
      margin: 0 auto;
      padding: 34px 18px 60px;
      animation: rise .9s ease both;
    }

    /* Top bar */
    .topbar{
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:12px;
      margin-bottom: 18px;
    }
    .brand{
      display:flex; align-items:center; gap:10px;
      user-select:none;
    }
    .brand .logo{
      width:42px; height:42px;
      border-radius: 14px;
      background:
        radial-gradient(circle at 30% 30%, rgba(255,255,255,.22), transparent 45%),
        linear-gradient(135deg, var(--neon1), var(--neon2));
      box-shadow: 0 10px 28px rgba(255,45,149,.25);
      display:grid; place-items:center;
      border: 1px solid rgba(255,255,255,.16);
    }
    .brand .logo i{ font-size:22px; }
    .brand .name{
      line-height:1.1;
    }
    .brand .name b{ letter-spacing:.6px; }
    .brand .name small{
      display:block;
      color: var(--muted);
      font-size: 12px;
      margin-top:3px;
    }

    .navbtns{
      display:flex; gap:10px; flex-wrap:wrap;
    }
    .pill{
      display:inline-flex;
      align-items:center;
      gap:8px;
      padding:10px 14px;
      border-radius: 999px;
      background: rgba(255,255,255,.05);
      border:1px solid rgba(255,255,255,.12);
      color: var(--text);
      text-decoration:none;
      transition: transform .25s ease, box-shadow .25s ease, background .25s ease;
    }
    .pill:hover{
      transform: translateY(-2px);
      background: rgba(255,255,255,.08);
      box-shadow: 0 10px 26px rgba(0,0,0,.35);
    }

    /* Hero cinema */
    .hero{
      position:relative;
      border-radius: 24px;
      padding: 28px 22px;
      background:
        radial-gradient(1200px 480px at 10% 0%, rgba(255,45,149,.22), transparent 55%),
        radial-gradient(900px 420px at 90% 10%, rgba(0,229,255,.18), transparent 55%),
        rgba(255,255,255,.04);
      border: 1px solid rgba(255,255,255,.12);
      box-shadow: var(--shadow);
      overflow:hidden;
    }
    .hero::after{
      content:"";
      position:absolute;
      inset:-2px;
      background: linear-gradient(90deg, rgba(255,45,149,.12), rgba(124,77,255,.10), rgba(0,229,255,.12));
      filter: blur(22px);
      opacity:.7;
      z-index:0;
    }
    .hero .content{ position:relative; z-index:1; }
    .kicker{
      display:inline-flex;
      align-items:center;
      gap:8px;
      padding:8px 12px;
      border-radius: 999px;
      background: rgba(0,0,0,.30);
      border:1px solid rgba(255,255,255,.14);
      color: var(--muted);
      font-size: 13px;
    }
    .kicker i{ color: var(--gold); }
    .hero h1{
      margin:14px 0 10px;
      font-size: clamp(26px, 3.2vw, 40px);
      letter-spacing:.5px;
    }
    .hero p{
      margin:0;
      color: var(--muted);
      max-width: 820px;
      line-height: 1.7;
    }

    .grid{
      display:grid;
      grid-template-columns: 1.35fr .65fr;
      gap:16px;
      margin-top: 18px;
    }
    @media (max-width: 880px){
      .grid{ grid-template-columns: 1fr; }
    }

    /* Ticket card */
    .ticket{
      position:relative;
      border-radius: var(--radius);
      background: var(--card);
      border: 1px solid rgba(255,255,255,.12);
      box-shadow: var(--shadow);
      overflow:hidden;
      transition: transform .25s ease, box-shadow .25s ease;
    }
    .ticket:hover{
      transform: translateY(-4px);
      box-shadow: 0 22px 60px rgba(0,0,0,.62);
    }
    .ticketHead{
      display:flex;
      align-items:flex-start;
      justify-content:space-between;
      gap:12px;
      padding: 18px 18px 12px;
      border-bottom: 1px dashed rgba(255,255,255,.18);
    }
    .ticketHead h2{
      margin:0;
      font-size: 18px;
      letter-spacing:.4px;
      display:flex;
      gap:10px;
      align-items:center;
    }
    .ticketHead h2 i{
      font-size: 20px;
      color: var(--neon3);
      text-shadow: 0 0 18px rgba(0,229,255,.45);
    }
    .badge{
      display:inline-flex;
      align-items:center;
      gap:6px;
      padding:8px 10px;
      border-radius: 12px;
      background: rgba(0,0,0,.28);
      border:1px solid rgba(255,255,255,.12);
      color: var(--muted);
      font-size: 12px;
      white-space:nowrap;
    }
    .badge b{ color: var(--gold); font-weight:700; }

    .ticketBody{
      padding: 16px 18px 18px;
    }
    .list{
      margin:0; padding:0; list-style:none;
      display:grid; gap:10px;
    }
    .list li{
      display:flex; gap:10px; align-items:flex-start;
      color: var(--muted);
      line-height: 1.6;
      padding: 10px 12px;
      border-radius: 14px;
      border: 1px solid rgba(255,255,255,.10);
      background: rgba(0,0,0,.20);
    }
    .list li i{
      margin-top: 2px;
      font-size: 18px;
      color: var(--neon1);
      text-shadow: 0 0 18px rgba(255,45,149,.35);
      flex: 0 0 auto;
    }
    .list li b{ color: var(--text); }

    /* Răng cưa vé (hai lỗ tròn) */
    .ticket::before,
    .ticket::after{
      content:"";
      position:absolute;
      top: 55%;
      width: 34px; height: 34px;
      border-radius: 50%;
      background: linear-gradient(180deg, var(--bg0), var(--bg1));
      border:1px solid rgba(255,255,255,.08);
      transform: translateY(-50%);
      opacity:.95;
    }
    .ticket::before{ left: -17px; }
    .ticket::after{ right: -17px; }

    /* Side panel */
    .side{
      border-radius: var(--radius);
      background: rgba(255,255,255,.04);
      border: 1px solid rgba(255,255,255,.12);
      box-shadow: var(--shadow);
      padding: 18px;
      display:flex;
      flex-direction:column;
      gap:12px;
    }
    .side h3{
      margin:0;
      font-size: 16px;
      display:flex; align-items:center; gap:10px;
    }
    .side h3 i{ color: var(--gold); }
    .mini{
      padding: 12px 12px;
      border-radius: 14px;
      border:1px solid rgba(255,255,255,.10);
      background: rgba(0,0,0,.22);
      color: var(--muted);
      line-height:1.6;
      transition: transform .25s ease, background .25s ease;
    }
    .mini:hover{
      transform: translateY(-3px);
      background: rgba(0,0,0,.28);
    }

    /* CTA buttons */
    .actions{
      margin-top: 18px;
      display:flex;
      gap:12px;
      flex-wrap:wrap;
      justify-content:center;
    }
    .btn{
      display:inline-flex;
      align-items:center;
      gap:10px;
      padding: 12px 18px;
      border-radius: 999px;
      text-decoration:none;
      font-weight: 650;
      letter-spacing:.2px;
      border:1px solid rgba(255,255,255,.14);
      transition: transform .25s ease, box-shadow .25s ease, filter .25s ease;
      user-select:none;
    }
    .btn-primary{
      background: linear-gradient(90deg, var(--neon1), var(--neon2));
      color: #fff;
      box-shadow: 0 14px 30px rgba(255,45,149,.20);
    }
    .btn-primary:hover{
      transform: translateY(-2px);
      box-shadow: 0 18px 44px rgba(124,77,255,.28);
      filter: brightness(1.06);
    }
    .btn-ghost{
      background: rgba(255,255,255,.05);
      color: var(--text);
    }
    .btn-ghost:hover{
      transform: translateY(-2px);
      box-shadow: 0 16px 40px rgba(0,0,0,.45);
    }

    /* Footer note */
    .note{
      margin-top: 14px;
      text-align:center;
      color: rgba(242,244,255,.60);
      font-size: 12px;
    }

    @keyframes rise{
      from{opacity:0; transform: translateY(18px);}
      to{opacity:1; transform: translateY(0);}
    }
  </style>
</head>

<body>
  <div class="wrap">

    <div class="topbar">
      <div class="brand">
        <div class="logo"><i class="bx bxs-movie-play"></i></div>
        <div class="name">
          <b>CINEMA TICKET</b>
          <small>Chính sách & hỗ trợ khách hàng</small>
        </div>
      </div>

      <div class="navbtns">
        <a class="pill" href="${pageContext.request.contextPath}/home">
          <i class="bx bx-home-alt-2"></i> Trang chủ
        </a>
        <a class="pill" href="${pageContext.request.contextPath}/pages/terms/terms.jsp">
          <i class="bx bx-file"></i> Điều khoản
        </a>
        <a class="pill" href="${pageContext.request.contextPath}/pages/terms/privacy-policy.jsp">
          <i class="bx bx-shield-quarter"></i> Bảo mật
        </a>
      </div>
    </div>

    <section class="hero">
      <div class="content">
        <span class="kicker"><i class="bx bxs-popcorn"></i> Rạp phim online • Thanh toán nhanh • An toàn</span>
        <h1><i class="bx bx-credit-card-front" style="color:var(--gold)"></i> Chính Sách Thanh Toán</h1>
        <p>
          Trang này mô tả các hình thức thanh toán, cách xác nhận vé điện tử và những lưu ý quan trọng
          khi bạn mua vé xem phim trực tuyến trên hệ thống.
        </p>

        <div class="grid">
          <!-- Ticket -->
          <div class="ticket">
            <div class="ticketHead">
              <h2><i class="bx bx-wallet"></i> Hình thức thanh toán</h2>
              <div class="badge"><i class="bx bxs-star"></i> Hỗ trợ <b>24/7</b></div>
            </div>
            <div class="ticketBody">
              <ul class="list">
                <li><i class="bx bx-check"></i> Thẻ <b>ATM nội địa</b> (Internet Banking)</li>
                <li><i class="bx bx-check"></i> Ví điện tử: <b>MoMo / ZaloPay / VNPay</b></li>
                <li><i class="bx bx-check"></i> Thẻ <b>Visa / MasterCard</b> (tuỳ hệ thống tích hợp)</li>
              </ul>
            </div>
          </div>

          <!-- Side -->
          <aside class="side">
            <h3><i class="bx bxs-badge-check"></i> Xác nhận vé</h3>
            <div class="mini">
              Sau khi thanh toán thành công, hệ thống sẽ tạo <b>vé điện tử</b> và hiển thị trong mục
              <b>“Vé của tôi”</b>. Đồng thời gửi email xác nhận (nếu bạn đăng ký email).
            </div>

            <h3><i class="bx bxs-error"></i> Lưu ý</h3>
            <div class="mini">
              Vui lòng kiểm tra kỹ <b>suất chiếu</b>, <b>rạp</b>, <b>ghế</b> trước khi thanh toán.
              Tránh nhập sai thông tin khiến giao dịch thất bại.
            </div>
          </aside>
        </div>

        <div class="ticket" style="margin-top:16px;">
          <div class="ticketHead">
            <h2><i class="bx bx-info-circle"></i> Điều kiện & hoàn/đổi</h2>
            <div class="badge"><i class="bx bx-time-five"></i> Cập nhật theo rạp</div>
          </div>
          <div class="ticketBody">
            <ul class="list">
              <li><i class="bx bx-x"></i> Vé đã thanh toán thường <b>không hoàn tiền</b> (trừ trường hợp rạp/hệ thống huỷ suất chiếu).</li>
              <li><i class="bx bx-x"></i> Không đổi ghế/suất chiếu sau khi xuất vé (tuỳ chính sách từng rạp).</li>
              <li><i class="bx bx-support"></i> Nếu gặp lỗi: chụp màn hình mã giao dịch và liên hệ <b>CSKH</b> để được hỗ trợ nhanh.</li>
            </ul>
          </div>
        </div>

        <div class="actions">
          <a class="btn btn-primary" href="${pageContext.request.contextPath}/home">
            <i class="bx bx-arrow-back"></i> Quay về trang chủ
          </a>
          <a class="btn btn-ghost" href="${pageContext.request.contextPath}/pages/terms/terms.jsp">
            <i class="bx bx-file"></i> Xem điều khoản giao dịch
          </a>
        </div>

        <div class="note">
          * Nội dung có thể thay đổi tuỳ theo cấu hình cổng thanh toán và chính sách của từng rạp.
        </div>
      </div>
    </section>
  </div>
</body>
</html>
