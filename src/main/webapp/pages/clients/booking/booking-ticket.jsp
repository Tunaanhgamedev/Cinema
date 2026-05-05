<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Đặt Vé - BOBIXI Cinema</title>
                <!-- Thêm các font và icon cần thiết -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;900&display=swap"
                    rel="stylesheet">
                <script src="https://cdn.tailwindcss.com"></script>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/booking-ticket.css">
                <style>
                    body {
                        font-family: 'Outfit', sans-serif;
                    }
                                /* THEMES */
                    .theme-imax { --accent: #f59e0b; --glow: rgba(245, 158, 11, 0.3); }
                    .theme-classic { --accent: #6366f1; --glow: rgba(99, 102, 241, 0.3); }
                    .theme-cosy { --accent: #ec4899; --glow: rgba(236, 153, 153, 0.3); }

                    .booking-card {
                        background: rgba(15, 23, 42, 0.85);
                        backdrop-filter: blur(25px);
                        border: 1px solid rgba(255, 255, 255, 0.08);
                        border-radius: 40px;
                        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.6);
                        transition: all 0.5s ease;
                    }

                    .screen-line {
                        height: 4px;
                        width: 100%;
                        background: linear-gradient(90deg, transparent, var(--accent), #fff, var(--accent), transparent);
                        box-shadow: 0 8px 30px var(--glow);
                        border-radius: 100%;
                        animation: screenPulse 3s infinite;
                    }

                    @keyframes screenPulse {
                        0%, 100% { opacity: 0.8; filter: blur(1px); }
                        50% { opacity: 1; filter: blur(2px); transform: scaleX(1.02); }
                    }

                    /* PREMIUM SEAT STYLES */
                    .seat-btn {
                        width: 36px;
                        height: 36px;
                        font-size: 11px;
                        font-weight: 800;
                        border-radius: 10px;
                        border: 1.5px solid rgba(255, 255, 255, 0.1);
                        background: rgba(255, 255, 255, 0.03);
                        color: rgba(255, 255, 255, 0.4);
                        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                        position: relative;
                        overflow: hidden;
                    }

                    .seat-btn::after {
                        content: '';
                        position: absolute;
                        top: 0; left: 0; right: 0; bottom: 0;
                        background: linear-gradient(180deg, rgba(255,255,255,0.1) 0%, transparent 100%);
                        pointer-events: none;
                    }

                    .seat-btn.vip {
                        border-color: rgba(245, 158, 11, 0.3);
                        background: rgba(245, 158, 11, 0.05);
                        color: #f59e0b;
                    }

                    .seat-btn.couple {
                        width: 84px; /* Ghế đôi rộng hơn */
                        border-color: rgba(236, 72, 153, 0.3);
                        background: rgba(236, 72, 153, 0.05);
                        color: #ec4899;
                    }

                    .seat-btn.selected {
                        background: var(--accent) !important;
                        color: white !important;
                        border: none !important;
                        box-shadow: 0 0 25px var(--glow);
                    }

                    .seat-btn.other-selected {
                        opacity: 0.15;
                        cursor: not-allowed;
                        filter: grayscale(1);
                    }
                    .screen-line {
                        height: 3px;
                        width: 100%;
                        background: linear-gradient(90deg, transparent, #6366f1, #a855f7, #6366f1, transparent);
                        box-shadow: 0 4px 20px rgba(99, 102, 241, 0.8);
                        border-radius: 100%;
                        filter: blur(1px);
                    }

                    .screen-glow {
                        position: absolute;
                        top: 0; left: 50%;
                        transform: translateX(-50%);
                        width: 80%;
                        height: 100px;
                        background: radial-gradient(ellipse at top, rgba(99, 102, 241, 0.15) 0%, transparent 70%);
                        pointer-events: none;
                    }

                    .seat-btn:hover:not(.other-selected):not(.booked) {
                        transform: translateY(-4px) scale(1.08);
                        border-color: #6366f1;
                        color: white;
                        background: rgba(99, 102, 241, 0.15);
                        box-shadow: 0 10px 20px -5px rgba(99, 102, 241, 0.4);
                    }

                    /* SEAT VIEW PREVIEW STYLES */
                    #seat-preview-container {
                        position: fixed;
                        pointer-events: none;
                        z-index: 1000;
                        width: 280px;
                        background: #1e293b;
                        border: 2px solid #6366f1;
                        border-radius: 16px;
                        overflow: hidden;
                        box-shadow: 0 20px 40px rgba(0,0,0,0.5);
                        opacity: 0;
                        transform: translateY(10px) scale(0.95);
                        transition: all 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                    }
                    #seat-preview-container.active {
                        opacity: 1;
                        transform: translateY(0) scale(1);
                    }
                    .preview-img { width: 100%; height: 150px; object-cover: cover; }
                    .preview-info { padding: 12px; background: #0f172a; border-top: 1px solid rgba(255,255,255,0.1); }
                    .preview-row { font-size: 10px; font-weight: 800; color: #6366f1; text-transform: uppercase; }
                    .preview-title { font-size: 14px; font-weight: 900; color: white; margin-top: 2px; }
                </style>
            </head>

            <body class="bg-[#0f172a] text-slate-200 overflow-x-hidden">
                <jsp:include page="/common/header.jsp" />

                <main class="min-h-screen pt-24 pb-20 px-4 max-w-7xl mx-auto flex flex-col lg:flex-row gap-8 relative">

                    <!-- LEFT: SELECTION -->
                    <div class="flex-1 space-y-8">
                        <section class="booking-card p-8">
                            <div class="flex items-center justify-between mb-10">
                                <div class="flex items-center gap-4">
                                    <div class="w-12 h-12 bg-indigo-600 rounded-2xl flex items-center justify-center">
                                        <i class="fas fa-couch text-white"></i>
                                    </div>
                                    <h2 class="text-2xl font-black text-white uppercase italic">Chọn ghế</h2>
                                </div>
                                <input type="number" id="ticketQty"
                                    class="bg-white/5 border border-white/10 rounded-xl px-4 py-2 w-20 text-center font-bold"
                                    value="${not empty param.ticketQty ? param.ticketQty : 1}" min="1" max="10">
                            </div>

                            <!-- BỘ LỌC TÌM KIẾM -->
                            <div
                                class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-10 bg-white/5 p-4 rounded-2xl border border-white/5 relative z-20">
                                <div>
                                    <label
                                        class="block text-[10px] font-black text-slate-500 uppercase tracking-widest mb-2">Phim</label>
                                    <select id="movieSelect"
                                        class="w-full bg-slate-800/80 border border-white/10 rounded-xl px-4 py-3 text-sm font-bold text-white focus:outline-none focus:border-indigo-500 appearance-none cursor-pointer">
                                        <c:forEach var="m" items="${movies}">
                                            <option value="${m.movieId}" data-poster="${m.poster}"
                                                data-genre="${m.genre}" data-duration="${m.duration}"
                                                ${m.movieId==param.movieId ? 'selected' : '' }>${m.title}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div>
                                    <label
                                        class="block text-[10px] font-black text-slate-500 uppercase tracking-widest mb-2">Ngày
                                        chiếu</label>
                                    <select id="dateInput"
                                        class="w-full bg-slate-800/80 border border-white/10 rounded-xl px-4 py-3 text-sm font-bold text-white focus:outline-none focus:border-indigo-500 appearance-none cursor-pointer">
                                        <option value="">-- Chọn phim trước --</option>
                                    </select>
                                </div>
                                <div>
                                    <label
                                        class="block text-[10px] font-black text-slate-500 uppercase tracking-widest mb-2">Suất
                                        chiếu</label>
                                    <select id="showtimeSelect"
                                        class="w-full bg-slate-800/80 border border-white/10 rounded-xl px-4 py-3 text-sm font-bold text-white focus:outline-none focus:border-indigo-500 appearance-none cursor-pointer">
                                        <option value="">-- Chọn ngày trước --</option>
                                    </select>
                                </div>
                            </div>

                            <div id="seatGrid" class="flex flex-col items-center py-10 min-h-[400px]">
                                <i class="fas fa-spinner fa-spin text-3xl text-indigo-500 mb-4"></i>
                                <p class="text-xs font-bold text-slate-500">Đang chuẩn bị...</p>
                            </div>

                            <!-- <div class="flex justify-center mt-8">
                                <button id="nextToCombo"
                                    class="bg-indigo-600 hover:bg-indigo-500 disabled:opacity-30 px-8 py-3 rounded-2xl font-black text-xs tracking-widest transition-all"
                                    disabled>
                                    TIẾP TỤC CHỌN COMBO
                                </button>
                            </div> -->
                        </section>

                        <section id="comboSection" class="hidden"></section>
                    </div>

                    <!-- RIGHT: SIDEBAR -->
                    <div class="w-full lg:w-80 space-y-6">
                        <div class="booking-card overflow-hidden">
                            <div class="h-40 relative">
                                <img id="summary-poster" class="w-full h-full object-cover hidden">
                                <div id="poster-placeholder"
                                    class="w-full h-full bg-slate-800 flex items-center justify-center"><i
                                        class="fas fa-film text-3xl opacity-20"></i></div>
                                <div class="absolute inset-0 bg-gradient-to-t from-[#1e293b] to-transparent"></div>
                                <div class="absolute bottom-4 left-6">
                                    <h3 id="summary-movie" class="text-lg font-black text-white uppercase italic">---
                                    </h3>
                                    <p class="text-[10px] text-white/50 uppercase"><span id="summary-genre">---</span> •
                                        <span id="summary-duration">--</span> Phút
                                    </p>
                                </div>
                            </div>
                            <div class="p-6 space-y-4">
                                <div class="grid grid-cols-2 gap-4 text-[10px]">
                                    <div>
                                        <p class="text-slate-500 uppercase font-black mb-1">Ngày</p>
                                        <p id="summary-date" class="text-white font-bold italic">---</p>
                                    </div>
                                    <div>
                                        <p class="text-slate-500 uppercase font-black mb-1">Suất</p>
                                        <p id="summary-time" class="text-white font-bold italic">---</p>
                                    </div>
                                    <div>
                                        <p class="text-slate-500 uppercase font-black mb-1">Phòng</p>
                                        <p id="summary-room" class="text-white font-bold italic">---</p>
                                    </div>
                                    <div>
                                        <p class="text-slate-500 uppercase font-black mb-1">Ghế</p>
                                        <p class="text-white font-black italic"><span id="pickedCount">0</span>/<span
                                                id="maxCount">0</span></p>
                                    </div>
                                </div>
                                <div id="summary-seats"
                                    class="flex flex-wrap gap-1 min-h-[40px] pt-2 border-t border-white/5"></div>
                                <div class="p-4 bg-white/5 rounded-2xl">
                                    <p class="text-[10px] text-slate-500 uppercase font-black mb-1">Tổng cộng</p>
                                    <p id="totalPriceUI" class="text-2xl font-black text-white italic">0đ</p>
                                </div>
                                <form action="${pageContext.request.contextPath}/booking-seat" method="POST"
                                    id="bookingForm">
                                    <input type="hidden" name="actionType" id="formActionType" value="combo">
                                    <div class="flex flex-col gap-3">
                                        <button type="submit" name="actionType" value="combo" id="btnCombo"
                                            class="w-full bg-indigo-600 py-3 rounded-xl font-black text-xs uppercase tracking-widest disabled:opacity-30 transition-all hover:bg-indigo-500 hover:shadow-[0_0_20px_rgba(79,70,229,0.5)]"
                                            disabled>
                                            CHỌN TIẾP: COMBO <i class="fas fa-arrow-right ml-2"></i>
                                        </button>
                                        <button type="submit" name="actionType" value="checkout" id="btnCheckout"
                                            class="w-full bg-slate-700 py-3 rounded-xl font-black text-xs uppercase tracking-widest disabled:opacity-30 transition-all hover:bg-slate-600 text-white/80"
                                            disabled>
                                            BỎ QUA COMBO, THANH TOÁN
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>

                <jsp:include page="/common/footer.jsp" />

                <!-- SEAT VIEW PREVIEW CONTAINER -->
                <div id="seat-preview-container">
                    <img src="" alt="Seat View" class="preview-img">
                    <div class="preview-info">
                        <div class="preview-row">Hàng ---</div>
                        <div class="preview-title">Tầm nhìn từ ghế</div>
                    </div>
                </div>

                <div id="seatPricesData" class="hidden">
                    <c:forEach var="sp" items="${seatPrices}">
                        <span data-type="${sp.seatType}" data-surcharge="${sp.surcharge}"></span>
                    </c:forEach>
                </div>
                
                <script>
                    const ctx = '${pageContext.request.contextPath}';
                    const urlParams = new URLSearchParams(window.location.search);
                    const uStId = urlParams.get('showtimeId');
                    const uDate = urlParams.get('showDate');

                    window.sPrices = {};
                    document.querySelectorAll('#seatPricesData span').forEach(el => {
                        window.sPrices[el.dataset.type] = parseFloat(el.dataset.surcharge);
                    });

                    (function () {
                        const mS = document.getElementById('movieSelect');
                        const dI = document.getElementById('dateInput');
                        const sS = document.getElementById('showtimeSelect');
                        const qI = document.getElementById('ticketQty');
                        let socket = null;

                        function sync() {
                            const opt = mS.options[mS.selectedIndex];
                            if (opt && opt.value) {
                                document.getElementById('summary-movie').textContent = opt.text;
                                const img = document.getElementById('summary-poster');
                                if (opt.dataset.poster) { img.src = opt.dataset.poster; img.classList.remove('hidden'); document.getElementById('poster-placeholder').classList.add('hidden'); }
                                document.getElementById('summary-genre').textContent = opt.dataset.genre || '---';
                                document.getElementById('summary-duration').textContent = opt.dataset.duration || '--';
                            }
                            document.getElementById('summary-date').textContent = dI.value || '---';
                            const sOpt = sS.options[sS.selectedIndex];
                            if (sOpt && sOpt.value) {
                                const p = sOpt.text.split('|');
                                document.getElementById('summary-room').textContent = p[0]?.trim() || '---';
                                document.getElementById('summary-time').textContent = p[1]?.trim() || '---';
                            }
                            update();
                        }

                        function update() {
                            const chk = document.querySelectorAll('input.seat:checked');
                            const max = parseInt(qI.value) || 1;
                            document.getElementById('pickedCount').textContent = chk.length;
                            document.getElementById('maxCount').textContent = max;

                            const area = document.getElementById('summary-seats');
                            area.innerHTML = '';
                            let tSeat = 0;
                            const base = parseFloat(sS.options[sS.selectedIndex]?.dataset.price || "0");

                            chk.forEach(s => {
                                const t = s.dataset.type;
                                area.innerHTML += '<span class="px-2 py-1 bg-white/10 rounded text-[9px] font-black italic">' + s.value + '</span>';
                                tSeat += (base + (window.sPrices[t] || 0));
                            });

                            document.querySelectorAll('input.seat:not(:checked)').forEach(s => {
                                s.disabled = (chk.length >= max) || (s.dataset.booked === 'true') || (s.dataset.otherSelected === 'true');
                            });

                            document.getElementById('btnCombo').disabled = (chk.length === 0);
                            document.getElementById('btnCheckout').disabled = (chk.length === 0);

                            document.getElementById('totalPriceUI').textContent = tSeat.toLocaleString('vi-VN') + 'đ';
                        }

                        async function loadD() {
                            if (!mS.value) return;
                            try {
                                const r = await fetch(ctx + '/booking-seat?ajax=dates&movieId=' + mS.value);
                                const data = await r.json();
                                dI.innerHTML = '<option value="">-- Ngày --</option>';
                                data.forEach(d => {
                                    dI.innerHTML += '<option value="' + d + '" ' + (d == uDate ? 'selected' : '') + '>' + d + '</option>';
                                });
                                if (dI.value) await loadT();
                            } catch (e) { console.error(e); }
                            sync();
                        }

                        async function loadT() {
                            if (!mS.value || !dI.value) return;
                            try {
                                const r = await fetch(ctx + '/booking-seat?ajax=showtimes&movieId=' + mS.value + '&showDate=' + dI.value);
                                const data = await r.json();
                                sS.innerHTML = '<option value="">-- Suất --</option>';
                                data.forEach(st => {
                                    sS.innerHTML += '<option value="' + st.id + '" data-price="' + st.price + '" ' + (st.id == uStId ? 'selected' : '') + '>' + st.room + ' | ' + st.time + '</option>';
                                });
                                if (sS.value) await loadS();
                            } catch (e) { console.error(e); }
                            sync();
                        }

                        async function loadS() {
                            if (!sS.value) return;
                            document.getElementById('seatGrid').innerHTML = '<i class="fas fa-spinner fa-spin text-2xl text-indigo-500 mb-2"></i>';
                            try {
                                const r = await fetch(ctx + '/booking-seat?ajax=seats&showtimeId=' + sS.value);
                                const data = await r.json();
                                render(data);
                                initWS(sS.value);
                            } catch (e) { console.error(e); }
                            sync();
                        }

                        function render(data) {
                            const grid = document.getElementById('seatGrid');
                            if (!data || !data.seats || data.seats.length === 0) {
                                grid.innerHTML = '<div class="p-20 text-center"><div class="text-slate-500 italic mb-4">Chưa có sơ đồ ghế cho phòng này.</div><div class="text-xs text-slate-600">Vui lòng liên hệ quản trị viên để cập nhật sơ đồ.</div></div>';
                                return;
                            }

                            const total = data.roomInfo?.total || 0;
                            const container = document.querySelector('.booking-card');
                            
                            // Apply Theme
                            container.classList.remove('theme-imax', 'theme-classic', 'theme-cosy');
                            if (total > 110) container.classList.add('theme-imax');
                            else if (total < 60) container.classList.add('theme-cosy');
                            else container.classList.add('theme-classic');

                            let h = '<div id="seat-container" class="flex flex-col gap-5 items-center w-full">';
                            h += '<div class="w-full max-w-lg mb-16 relative mx-auto"><div class="screen-glow"></div><div class="screen-line"></div><p class="text-[9px] text-center mt-4 font-black tracking-[1em] text-white/20 uppercase">Màn hình</p></div>';
                            
                            const rowMap = {};
                            data.seats.forEach(s => { 
                                const r = s.code.charAt(0); 
                                if (!rowMap[r]) rowMap[r] = []; 
                                rowMap[r].push(s); 
                            });

                            Object.keys(rowMap).sort().forEach(r => {
                                h += '<div class="flex gap-6 justify-center items-center group py-1"><div class="w-8 text-[11px] font-black text-slate-600 group-hover:text-white transition-all duration-300 transform group-hover:scale-150">' + r + '</div><div class="flex gap-3 items-center">';
                                rowMap[r].sort((a, b) => {
                                    const numA = parseInt(a.code.replace(/\D/g, '')) || 0;
                                    const numB = parseInt(b.code.replace(/\D/g, '')) || 0;
                                    return numA - numB;
                                }).forEach(s => {
                                    const bk = data.booked.includes(s.code);
                                    const sid = 's_' + s.code;
                                    let exClass = '';
                                    let seatLabel = s.code.substring(1);
                                    if(s.type === 'VIP') {
                                        exClass = 'vip';
                                        seatLabel = '<span class="text-[8px] absolute top-1 right-1 opacity-50">V</span>' + seatLabel;
                                    } else if(s.type === 'COUPLE') {
                                        exClass = 'couple';
                                        seatLabel = '<span class="text-[8px] absolute top-1 right-1 opacity-50">CC</span>' + seatLabel;
                                    }
                                    
                                    h += '<div class="relative">' + (bk ? '<div class="seat-btn opacity-25 bg-slate-800 flex items-center justify-center border-dashed border-white/10 text-slate-500 overflow-hidden"><span class="relative z-10">' + s.code.substring(1) + '</span><div class="absolute inset-0 bg-gradient-to-tr from-transparent via-white/5 to-transparent rotate-45"></div></div>' : '<input type="checkbox" id="' + sid + '" name="seats" value="' + s.code + '" class="hidden seat-check seat" data-type="' + s.type + '"><label for="' + sid + '" class="seat-btn ' + exClass + ' cursor-pointer flex items-center justify-center" data-seat="' + s.code + '">' + seatLabel + '</label>') + '</div>';
                                });
                                h += '</div><div class="w-8 text-[11px] font-black text-slate-600 group-hover:text-white transition-all duration-300 transform group-hover:scale-150 text-right">' + r + '</div></div>';
                            });
                            
                            h += `
                            <div class="grid grid-cols-2 md:grid-cols-5 gap-6 mt-16 pt-10 border-t border-white/5 w-full max-w-2xl mx-auto">
                                <div class="flex items-center gap-3">
                                    <div class="w-5 h-5 rounded-lg border border-white/10 bg-white/5"></div>
                                    <span class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Thường</span>
                                </div>
                                <div class="flex items-center gap-3">
                                    <div class="w-5 h-5 rounded-lg border border-amber-500/30 bg-amber-500/5 text-amber-500 flex items-center justify-center text-[8px] font-black">V</div>
                                    <span class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">VIP</span>
                                </div>
                                <div class="flex items-center gap-3">
                                    <div class="w-8 h-5 rounded-lg border border-pink-500/30 bg-pink-500/5 text-pink-500 flex items-center justify-center text-[8px] font-black">CC</div>
                                    <span class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Couple</span>
                                </div>
                                <div class="flex items-center gap-3">
                                    <div class="w-5 h-5 rounded-lg bg-indigo-500 shadow-[0_0_15px_rgba(99,102,241,0.5)]"></div>
                                    <span class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Đang chọn</span>
                                </div>
                                <div class="flex items-center gap-3 opacity-20">
                                    <div class="w-5 h-5 rounded-lg bg-slate-800"></div>
                                    <span class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Đã bán</span>
                                </div>
                            </div>
                            `;
                            grid.innerHTML = h + '</div>';
                            
                            // SEAT VIEW PREVIEW LOGIC
                            const preview = document.getElementById('seat-preview-container');
                            const previewImg = preview.querySelector('.preview-img');
                            const previewRow = preview.querySelector('.preview-row');
                            const previewTitle = preview.querySelector('.preview-title');

                            document.querySelectorAll('.seat-btn').forEach(btn => {
                                btn.addEventListener('mouseenter', (e) => {
                                    const code = btn.dataset.seat;
                                    if(!code) return;
                                    
                                    const row = code.charAt(0);
                                    let viewImg = 'middle.png';
                                    let viewName = 'Góc nhìn trung tâm';
                                    
                                    if(['A','B','C'].includes(row)) { viewImg = 'front.png'; viewName = 'Góc nhìn gần màn hình'; }
                                    else if(['G','H','I','J','K'].includes(row)) { viewImg = 'back.png'; viewName = 'Góc nhìn từ cuối rạp'; }
                                    
                                    previewImg.src = ctx + '/assets/images/previews/' + viewImg;
                                    previewRow.textContent = 'HÀNG ' + row + ' - GHẾ ' + code.substring(1);
                                    previewTitle.textContent = viewName;
                                    preview.classList.add('active');
                                });

                                btn.addEventListener('mousemove', (e) => {
                                    preview.style.left = (e.clientX + 20) + 'px';
                                    preview.style.top = (e.clientY - 180) + 'px';
                                });

                                btn.addEventListener('mouseleave', () => {
                                    preview.classList.remove('active');
                                });
                            });

                            document.querySelectorAll('input.seat').forEach(s => {
                                s.addEventListener('change', () => {
                                    const l = document.querySelector('label[for="' + s.id + '"]');
                                    if (s.checked) l.classList.add('selected'); else l.classList.remove('selected');
                                    update();
                                    if (socket?.readyState === 1) socket.send(sS.value + ':' + s.value + ':' + (s.checked ? 'select' : 'deselect'));
                                });
                            });
                            update();
                        }

                        function initWS(stId) {
                            if (socket) socket.close();
                            socket = new WebSocket((location.protocol == 'https:' ? 'wss:' : 'ws:') + '//' + location.host + ctx + '/ws/seat?showtimeId=' + stId);
                            socket.onmessage = (e) => {
                                const [id, code, act] = e.data.split(':');
                                if (id == stId) {
                                    const s = document.getElementById('s_' + code);
                                    const l = document.querySelector('label[for="s_' + code + '"]');
                                    if (s && l) {
                                        if (act == 'select') { s.disabled = true; s.dataset.otherSelected = 'true'; l.classList.add('other-selected'); }
                                        else if (!s.checked) { s.disabled = false; delete s.dataset.otherSelected; l.classList.remove('other-selected'); update(); }
                                    }
                                }
                            };
                        }

                        mS.addEventListener('change', loadD);
                        dI.addEventListener('change', loadT);
                        sS.addEventListener('change', loadS);
                        qI.addEventListener('input', update);

                        document.getElementById('btnCombo').addEventListener('click', () => { document.getElementById('formActionType').value = 'combo'; });
                        document.getElementById('btnCheckout').addEventListener('click', () => { document.getElementById('formActionType').value = 'checkout'; });

                        document.getElementById('bookingForm').addEventListener('submit', (e) => {
                            const chk = document.querySelectorAll('input.seat:checked');
                            if (chk.length === 0) { e.preventDefault(); return; }

                            let inputs = '<input type="hidden" name="showtimeId" value="' + sS.value + '">';
                            inputs += '<input type="hidden" name="movieId" value="' + mS.value + '">';
                            inputs += '<input type="hidden" name="showDate" value="' + dI.value + '">';
                            inputs += '<input type="hidden" name="ticketQty" value="' + qI.value + '">';

                            chk.forEach(s => { inputs += '<input type="hidden" name="seats" value="' + s.value + '">'; });
                            e.target.insertAdjacentHTML('beforeend', inputs);
                        });

                        window.addEventListener('DOMContentLoaded', () => {
                            sync();
                            if (mS.value) loadD();
                        });
                    })();
                </script>
            </body>

            </html>