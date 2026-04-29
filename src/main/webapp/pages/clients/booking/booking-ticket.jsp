<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="/common/header.jsp" />

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>Đặt vé & Chọn ghế | BOBIXI</title>

  <!-- Nếu bạn có bootstrap thì giữ -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/booking-ticket.css"/>
  <style>
    :root{ --bg:#0b0f19; --card:#111827; --line:#253047; --txt:#e5e7eb; --muted:#9ca3af; --brand:#e71a0f; }
    body{ background:var(--bg); color:var(--txt); }
    .wrap{ max-width:1100px; margin:24px auto; padding:0 14px; }
    .card{ background:linear-gradient(180deg, rgba(255,255,255,.06), rgba(255,255,255,.03)); border:1px solid var(--line); border-radius:18px; padding:18px; box-shadow:0 10px 30px rgba(0,0,0,.25); }
    .title{ font-weight:900; letter-spacing:.2px; }
    .muted{ color:var(--muted); }
    .row{ display:flex; gap:14px; flex-wrap:wrap; }
    .col{ flex:1; min-width:240px; }
    label{ font-weight:800; margin-bottom:6px; display:block; }
    .input, .select{ width:100%; padding:12px 12px; border-radius:14px; border:1px solid var(--line); background:#0f1627; color:var(--txt); outline:none; }
    .btn{ border:none; border-radius:999px; padding:12px 16px; font-weight:900; cursor:pointer; }
    .btn-outline{ background:transparent; color:var(--txt); border:1px solid var(--line); }
    .btn-brand{ background:var(--brand); color:#fff; }
    .btn:disabled{ opacity:.5; cursor:not-allowed; }
    .hr{ height:1px; background:var(--line); margin:18px 0; }

    /* Seats */
    .screen{ text-align:center; padding:10px; border-radius:12px; background:rgba(255,255,255,.08); border:1px dashed rgba(255,255,255,.25); font-weight:900; margin:12px 0 14px; }
    .seat-grid{ display:grid; grid-template-columns:repeat(10, 1fr); gap:10px; }
    .seat-item{ display:flex; justify-content:center; }
    .seat-check{ display:none; }
    .seat-label{
      width:100%; padding:10px 0; text-align:center;
      border-radius:12px; border:1px solid var(--line);
      background:#0f1627; font-weight:900; user-select:none;
      transition:transform .12s, filter .12s, background .12s;
    }
    .seat-label:hover{ transform:translateY(-1px); filter:brightness(1.08); }
    .seat-label.booked{ background:#2b2b2b; color:#888; text-decoration:line-through; cursor:not-allowed; }
    .seat-label.selected{ background:rgba(231,26,15,.18); border-color:rgba(231,26,15,.55); }
    .seat-check:checked + .seat-label{ background:rgba(231,26,15,.18); border-color:rgba(231,26,15,.55); }
    .legend{ display:flex; gap:12px; flex-wrap:wrap; margin-top:12px; }
    .badge{ display:inline-flex; gap:8px; align-items:center; padding:8px 12px; border-radius:999px; border:1px solid var(--line); background:rgba(255,255,255,.04); font-weight:800; }
    .dot{ width:10px; height:10px; border-radius:999px; display:inline-block; }
    .dot.free{ background:#0f1627; border:1px solid rgba(255,255,255,.25); }
    .dot.sel{ background:rgba(231,26,15,.65); }
    .dot.bok{ background:#444; }

    .alert{ padding:12px 14px; border-radius:14px; border:1px solid rgba(231,26,15,.5); background:rgba(231,26,15,.12); font-weight:800; }
    .top-actions{ display:flex; gap:10px; flex-wrap:wrap; align-items:center; justify-content:space-between; }
    .counter{ font-weight:900; }
  </style>
</head>

<body>
<div class="wrap">

  <div class="top-actions">
    <div>
      <div class="title" style="font-size:22px;">Đặt vé & Chọn ghế</div>
      <div class="muted">Bước 1 chọn suất chiếu → Bước 2 chọn ghế → Tiếp tục chọn combo</div>
    </div>
    <c:if test="${not empty error}">
      <div class="alert">${error}</div>
    </c:if>
  </div>

  <!-- FORM GET: tải showtimes + tải ghế -->
  <div class="card" style="margin-top:14px;">
    <form id="filterForm" method="get" action="${pageContext.request.contextPath}/booking-seat">
      <div class="title" style="font-size:18px; margin-bottom:10px;">1) Chọn suất chiếu</div>

      <div class="row">
        <div class="col">
          <label>Phim</label>
          <select class="select" name="movieId" required>
            <option value="">-- Chọn phim --</option>
            <c:forEach var="m" items="${movies}">
              <option value="${m.movieId}" <c:if test="${movieId == m.movieId}">selected</c:if>>
                ${m.title}
              </option>
            </c:forEach>
          </select>
        </div>

        <div class="col">
          <label>Rạp</label>
          <input class="input" value="BOBIXI" readonly />
          <input type="hidden" name="cinemaId" value="1"/>
        </div>

        <div class="col">
          <label>Ngày chiếu</label>
          <!-- type=date BẮT BUỘC yyyy-MM-dd -->
          <input class="input" type="date" name="showDate" value="${showDate}" required/>
          <div class="muted" style="margin-top:6px;"></div>
        </div>

        <div class="col">
          <label>Suất chiếu</label>

          <c:choose>
            <c:when test="${empty showtimes}">
              <select class="select" name="showtimeId" disabled>
                <option>Chọn phim + ngày rồi bấm “Tải suất chiếu / tải ghế”</option>
              </select>
              <div class="muted" style="margin-top:6px;">Chưa có dữ liệu suất chiếu.</div>
            </c:when>
            <c:otherwise>
              <select class="select" name="showtimeId" required>
                <option value="">-- Chọn suất chiếu --</option>
                <c:forEach var="st" items="${showtimes}">
                  <option value="${st.showtimeId}" <c:if test="${showtimeId == st.showtimeId}">selected</c:if>>
                    <fmt:formatDate value="${st.startTime}" pattern="HH:mm"/> -
                    <fmt:formatDate value="${st.endTime}" pattern="HH:mm"/>
                    (Phòng: ${st.roomName})
                  </option>
                </c:forEach>
              </select>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

      <div style="margin-top:14px; display:flex; gap:10px; flex-wrap:wrap;">
        <button type="submit" class="btn btn-outline">Tải suất chiếu / tải ghế</button>
      </div>
    </form>
  </div>

  <div class="hr"></div>

  <!-- FORM POST: tạo booking PENDING + giữ ghế + redirect qua combo -->
  <div class="card">
    <form id="bookingForm" method="post" action="${pageContext.request.contextPath}/booking/combo">
      <input type="hidden" name="movieId" value="${movieId}"/>
      <input type="hidden" name="showDate" value="${showDate}"/>
      <input type="hidden" name="cinemaId" value="1"/>
      <input type="hidden" name="showtimeId" value="${showtimeId}"/>

      <div class="row">
        <div class="col">
          <label>Loại vé</label>
          <select class="select" name="ticketType" required>
            <option value="ADULT">Người lớn</option>
            <option value="STUDENT">Học sinh/SV</option>
            <option value="CHILD">Trẻ em</option>
          </select>
        </div>

        <div class="col">
          <label>Số vé</label>
          <input id="ticketQty" class="input" type="number" name="ticketQty" min="1" max="10"
                 value="${empty ticketQty ? 2 : ticketQty}" required/>
          <div class="muted" style="margin-top:6px;">Chọn đúng số ghế = số vé.</div>
        </div>

        <div class="col">
          <label>Suất chiếu đang chọn</label>
          <input class="input" value="${showtimeId}" readonly/>
          <div class="muted" style="margin-top:6px;">Muốn đổi suất chiếu: đổi ở form trên rồi bấm tải.</div>
        </div>
      </div>

      <div class="hr"></div>

      <div class="title" style="font-size:18px; margin-bottom:10px;">2) Chọn ghế</div>

      <c:if test="${empty showtimeId}">
        <div class="alert">Bạn chưa chọn suất chiếu. Hãy chọn ở bước 1 và bấm “Tải suất chiếu / tải ghế”.</div>
      </c:if>

      <div class="screen">MÀN HÌNH</div>

      <div class="seat-grid" id="seatGrid">
        <c:forEach var="r" items="${rows}">
          <c:forEach var="i" begin="1" end="10">
            <c:set var="code" value="${r}${i}"/>
            <c:set var="sid" value="s_${code}"/>

            <c:choose>
              <c:when test="${bookedMap[code]}">
                <div class="seat-item">
                  <span class="seat-label booked">${code}</span>
                </div>
              </c:when>
              <c:otherwise>
                <div class="seat-item">
                  <input class="seat-check seat" type="checkbox" id="${sid}" name="seats" value="${code}"
                         <c:if test="${selectedMap[code]}">checked</c:if>
                         <c:if test="${empty showtimeId}">disabled</c:if>
                  />
                  <label class="seat-label <c:if test='${selectedMap[code]}'>selected</c:if>" for="${sid}">${code}</label>
                </div>
              </c:otherwise>
            </c:choose>

          </c:forEach>
        </c:forEach>
      </div>

      <div class="legend">
        <span class="badge"><span class="dot free"></span>Trống</span>
        <span class="badge"><span class="dot sel"></span>Đang chọn</span>
        <span class="badge"><span class="dot bok"></span>Đã đặt/đang giữ</span>
        <span class="badge counter">Đã chọn: <span id="pickedCount">0</span>/<span id="maxCount">0</span></span>
      </div>

      <div style="margin-top:16px; display:flex; gap:10px; flex-wrap:wrap;">
        <button type="submit" class="btn btn-brand" <c:if test="${empty showtimeId}">disabled</c:if>>
          Tiếp tục chọn combo →
        </button>
        <a class="btn btn-outline" href="${pageContext.request.contextPath}/home" style="text-decoration:none; display:inline-flex; align-items:center;">
          Về trang chủ
        </a>
      </div>
    </form>
  </div>

</div>

<script>
  // ✅ Không auto-submit khi đổi ngày => tránh “reset trang”
  // ✅ Khóa chọn ghế theo ticketQty
  (function(){
    const qtyEl = document.getElementById('ticketQty');
    const seats = Array.from(document.querySelectorAll('input.seat'));
    const pickedCount = document.getElementById('pickedCount');
    const maxCount = document.getElementById('maxCount');

    function getMax(){
      const n = parseInt(qtyEl?.value || "0", 10);
      return isNaN(n) ? 0 : n;
    }

    function update(){
      const max = getMax();
      const picked = seats.filter(s => s.checked).length;
      maxCount.textContent = max;
      pickedCount.textContent = picked;

      // disable các ghế còn lại khi đã đủ
      seats.forEach(s => {
        if (!s.checked) s.disabled = (picked >= max) || s.disabled && s.hasAttribute('disabled');
      });

      // nhưng nếu showtimeId rỗng thì disabled tất
      const showtimeId = "${showtimeId}";
      if (!showtimeId) seats.forEach(s => s.disabled = true);
    }

    // khi đổi số vé -> bỏ chọn ghế nếu vượt quá
    qtyEl?.addEventListener('input', function(){
      const max = getMax();
      let checked = seats.filter(s => s.checked);
      while (checked.length > max){
        checked[checked.length - 1].checked = false;
        checked = seats.filter(s => s.checked);
      }
      update();
    });

    seats.forEach(s => s.addEventListener('change', update));
    update();
  })();
</script>

</body>
</html>

<jsp:include page="/common/footer.jsp" />
