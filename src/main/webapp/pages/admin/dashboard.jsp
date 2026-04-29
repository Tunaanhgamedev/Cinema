<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"/>
  <title>Admin Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body{ background: linear-gradient(180deg,#2e2a44 0%,#1f1b2e 100%); color:#e5e7eb; min-height:100vh; }
    .cardx{ background: rgba(46,42,68,.85); border:1px solid rgba(255,255,255,.12); border-radius:16px; }
    a.navlink{ color:#e5e7eb; text-decoration:none; display:block; padding:10px 12px; border-radius:12px; }
    a.navlink:hover{ background: rgba(124,58,237,.18); }
  </style>
</head>
<body class="p-4">
<div class="container">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="m-0">ADMIN • Dashboard</h3>
    <span class="badge text-bg-dark">No Login</span>
  </div>

  <div class="row g-3">
    <div class="col-lg-3">
      <div class="cardx p-3">
        <div class="fw-bold mb-2">Chức năng</div>
        <a class="navlink" href="<%=request.getContextPath()%>/pages/admin/dashboard.jsp">Dashboard</a>
        <a class="navlink" href="<%=request.getContextPath()%>/admin/combos">Quản lí Combo</a>
        <a class="navlink" href="<%=request.getContextPath()%>/pages/admin/movie-manage.jsp">Quản lí Phim</a>
        <a class="navlink" href="<%=request.getContextPath()%>/pages/admin/contact-manage.jsp">Liên hệ</a>
        <a class="navlink" href="<%=request.getContextPath()%>/admin/showtimes">Quản lí Suất chiếu</a>     
        <a class="navlink" href="<%=request.getContextPath()%>/admin/bookings">Quản lí Booking (Vé + Combo)</a>  
      </div>
    </div>

    <div class="col-lg-9">
      <div class="cardx p-4">
        <h5 class="fw-bold">Tổng quan hệ thống</h5>
        <p class="text-white-50 mb-0">
          Phim và Booking sẽ sớm được hoàn thiện.
        </p>

        <hr class="border-light opacity-25"/>

        <div class="row g-3">
          <div class="col-md-4">
            <div class="cardx p-3">
              <div class="text-white-50">Combo</div>
              <div class="fs-4 fw-bold"></div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="cardx p-3">
              <div class="text-white-50">Phim</div>
              <div class="fs-4 fw-bold">Coming</div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="cardx p-3">
              <div class="text-white-50">Booking</div>
              <div class="fs-4 fw-bold">Coming</div>
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>

</div>
</body>
</html>
