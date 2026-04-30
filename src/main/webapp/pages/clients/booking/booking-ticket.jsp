<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Đặt vé & Chọn ghế | BOBIXI Cinema</title>
    
    <!-- Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    
    <style>
        body { font-family: 'Outfit', sans-serif; background-color: #020617; color: #f8fafc; overflow-x: hidden; }
        
        .premium-glass {
            background: rgba(15, 23, 42, 0.6);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 32px;
        }

        .step-badge {
            width: 40px; height: 40px; border-radius: 50%;
            display: flex; items-center; justify-content: center;
            font-weight: 900; background: rgba(99, 102, 241, 0.1);
            border: 2px solid #6366f1; color: #6366f1;
        }

        .input-premium {
            background: rgba(2, 6, 23, 0.6) !important;
            border: 1px solid rgba(255, 255, 255, 0.1) !important;
            border-radius: 16px !important;
            color: white !important;
            padding: 14px 20px !important;
            transition: all 0.3s;
        }
        .input-premium:focus { border-color: #6366f1 !important; box-shadow: 0 0 20px rgba(99, 102, 241, 0.2) !important; }

        /* Cinema Seat Styles */
        .screen-curve {
            width: 100%; height: 20px;
            background: linear-gradient(to bottom, #6366f1, transparent);
            border-radius: 50% / 100% 100% 0 0;
            filter: blur(5px);
            margin-bottom: 60px;
            position: relative;
        }
        .screen-curve::after {
            content: "MÀN HÌNH";
            position: absolute; top: 30px; left: 50%; transform: translateX(-50%);
            font-size: 10px; font-weight: 900; letter-spacing: 10px; color: #475569;
        }

        .seat-btn {
            width: 36px; height: 36px;
            border-radius: 10px;
            background: #1e293b;
            border: 1px solid rgba(255, 255, 255, 0.05);
            display: flex; align-items: center; justify-content: center;
            font-size: 10px; font-weight: 700; color: #94a3b8;
            cursor: pointer; transition: all 0.2s;
        }
        .seat-btn:hover:not(.booked):not(.other-selected) { 
            transform: scale(1.1); background: #334155; color: white;
            box-shadow: 0 0 15px rgba(99, 102, 241, 0.3);
        }
        .seat-btn.selected { background: #6366f1; color: white; box-shadow: 0 0 20px rgba(99, 102, 241, 0.5); border-color: #818cf8; }
        .seat-btn.booked { background: #0f172a; color: #334155; cursor: not-allowed; opacity: 0.5; border: none; }
        .seat-btn.other-selected { background: #fbbf24; color: #78350f; cursor: not-allowed; box-shadow: 0 0 15px rgba(251, 191, 36, 0.4); }

        .summary-card {
            background: linear-gradient(135deg, #4f46e5 0%, #312e81 100%);
            border-radius: 32px; padding: 32px; box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }
    </style>
</head>

<body>
    <jsp:include page="/common/header.jsp" />

    <div class="max-w-7xl mx-auto px-6 py-12">
        
        <!-- Header Info -->
        <div class="flex flex-col md:flex-row justify-between items-end mb-12 gap-8">
            <div>
                <h1 class="text-5xl font-black italic tracking-tighter uppercase mb-2">Phòng vé trực tuyến</h1>
                <p class="text-slate-500 font-medium uppercase tracking-widest text-xs">Bước 1: Suất chiếu & Ghế ngồi → Bước 2: Bắp nước → Bước 3: Thanh toán</p>
            </div>
            <c:if test="${not empty error}">
                <div class="bg-rose-500/10 border border-rose-500/20 px-6 py-3 rounded-2xl text-rose-500 font-bold text-sm animate-pulse">
                    <i class="fas fa-exclamation-circle mr-2"></i> ${error}
                </div>
            </c:if>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-12">
            
            <!-- Main Content Area -->
            <div class="lg:col-span-2 space-y-8">
                
                <!-- Step 1: Filter Area -->
                <div class="premium-glass p-8">
                    <div class="flex items-center gap-4 mb-8">
                        <div class="step-badge">1</div>
                        <h2 class="text-xl font-black uppercase tracking-tight">Chọn Phim & Suất chiếu</h2>
                    </div>
                    
                    <form id="filterForm" method="get" action="${pageContext.request.contextPath}/booking-seat" class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <div>
                            <label class="block text-[10px] font-black text-slate-500 uppercase tracking-widest mb-3">Phim đang chọn</label>
                            <select class="input-premium w-full outline-none" name="movieId" id="movieSelect" required>
                                <option value="">-- Chọn phim --</option>
                                <c:forEach var="m" items="${movies}">
                                    <option value="${m.movieId}" ${movieId == m.movieId ? 'selected' : ''}>${m.title}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <label class="block text-[10px] font-black text-slate-500 uppercase tracking-widest mb-3">Ngày xem</label>
                            <input class="input-premium w-full outline-none" type="date" name="showDate" id="showDateInput" value="${showDate}" required/>
                        </div>
                        <div>
                            <label class="block text-[10px] font-black text-slate-500 uppercase tracking-widest mb-3">Giờ chiếu</label>
                            <select class="input-premium w-full outline-none" name="showtimeId" id="showtimeSelect" required>
                                <option value="">-- Chọn suất chiếu --</option>
                                <c:forEach var="st" items="${showtimes}">
                                    <option value="${st.showtimeId}" ${showtimeId == st.showtimeId ? 'selected' : ''}>
                                        <fmt:formatDate value="${st.startTime}" pattern="HH:mm"/> - (Phòng ${st.roomName})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </form>
                </div>

                <!-- Step 2: Seat Area -->
                <div class="premium-glass p-8 overflow-hidden">
                    <div class="flex items-center gap-4 mb-12">
                        <div class="step-badge">2</div>
                        <h2 class="text-xl font-black uppercase tracking-tight">Chọn Chỗ ngồi</h2>
                    </div>

                    <div class="max-w-2xl mx-auto">
                        <div class="screen-curve"></div>
                        
                        <div class="flex flex-col items-center gap-4" id="seatGrid">
                            <c:if test="${empty showtimeId}">
                                <div class="text-center py-20 text-slate-600">
                                    <i class="fas fa-couch text-4xl mb-4 block"></i>
                                    <p class="font-bold">Vui lòng chọn Phim và Suất chiếu để thấy sơ đồ ghế</p>
                                </div>
                            </c:if>
                            
                            <c:forEach var="r" items="${rows}">
                                <div class="flex gap-3">
                                    <div class="w-6 text-[10px] font-black text-slate-700 flex items-center">${r}</div>
                                    <c:forEach var="i" begin="1" end="10">
                                        <c:set var="code" value="${r}${i}"/>
                                        <c:set var="sid" value="s_${code}"/>
                                        
                                        <div class="relative group">
                                            <input type="checkbox" id="${sid}" name="seats" value="${code}" 
                                                   class="hidden seat-check seat"
                                                   ${bookedMap[code] ? 'disabled' : ''}
                                                   ${selectedMap[code] ? 'checked' : ''} />
                                            <label for="${sid}" class="seat-btn ${bookedMap[code] ? 'booked' : ''} ${selectedMap[code] ? 'selected' : ''}">${i}</label>
                                        </div>
                                    </c:forEach>
                                    <div class="w-6 text-[10px] font-black text-slate-700 flex items-center justify-end">${r}</div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Legend -->
                        <div class="flex flex-wrap justify-center gap-8 mt-16 border-t border-white/5 pt-8">
                            <div class="flex items-center gap-3">
                                <div class="w-4 h-4 rounded-md bg-[#1e293b]"></div>
                                <span class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Trống</span>
                            </div>
                            <div class="flex items-center gap-3">
                                <div class="w-4 h-4 rounded-md bg-[#6366f1] shadow-[0_0_10px_rgba(99,102,241,0.5)]"></div>
                                <span class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Đang chọn</span>
                            </div>
                            <div class="flex items-center gap-3">
                                <div class="w-4 h-4 rounded-md bg-[#0f172a] opacity-50"></div>
                                <span class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Đã đặt</span>
                            </div>
                            <div class="flex items-center gap-3">
                                <div class="w-4 h-4 rounded-md bg-[#fbbf24]"></div>
                                <span class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Người khác chọn</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sidebar: Summary Area -->
            <div class="lg:col-span-1">
                <div class="summary-card sticky top-8">
                    <h2 class="text-2xl font-black uppercase tracking-tight mb-8 border-b border-white/10 pb-6 flex items-center justify-between">
                        Vé của bạn
                        <i class="fas fa-shopping-cart text-white/20 text-4xl"></i>
                    </h2>
                    
                    <form id="bookingForm" method="post" action="${pageContext.request.contextPath}/booking-seat" class="space-y-6">
                        <input type="hidden" name="movieId" value="${movieId}"/>
                        <input type="hidden" name="showDate" value="${showDate}"/>
                        <input type="hidden" name="showtimeId" value="${showtimeId}"/>
                        
                        <div>
                            <label class="block text-[10px] font-black text-indigo-200 uppercase tracking-widest mb-3">Phim</label>
                            <p id="summary-movie" class="text-xl font-black text-white italic">---</p>
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-[10px] font-black text-indigo-200 uppercase tracking-widest mb-3">Suất chiếu</label>
                                <p id="summary-time" class="text-lg font-bold text-white">---</p>
                            </div>
                            <div>
                                <label class="block text-[10px] font-black text-indigo-200 uppercase tracking-widest mb-3">Phòng</label>
                                <p id="summary-room" class="text-lg font-bold text-white">---</p>
                            </div>
                        </div>

                        <div class="hr bg-white/10 my-6"></div>

                        <div class="grid grid-cols-2 gap-6">
                            <div>
                                <label class="block text-[10px] font-black text-indigo-200 uppercase tracking-widest mb-3">Loại vé</label>
                                <select class="bg-white/10 border border-white/20 rounded-xl px-4 py-3 w-full outline-none font-bold text-sm" name="ticketType" required>
                                    <option value="ADULT">Người lớn</option>
                                    <option value="STUDENT">Học sinh/SV</option>
                                    <option value="CHILD">Trẻ em</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-[10px] font-black text-indigo-200 uppercase tracking-widest mb-3">Số lượng</label>
                                <input id="ticketQty" class="bg-white/10 border border-white/20 rounded-xl px-4 py-3 w-full outline-none font-bold text-sm text-center" 
                                       type="number" name="ticketQty" min="1" max="10" value="${empty ticketQty ? 2 : ticketQty}" required/>
                            </div>
                        </div>

                        <div class="bg-black/20 p-6 rounded-3xl mt-8">
                            <label class="block text-[10px] font-black text-indigo-300 uppercase tracking-widest mb-3">Ghế đã chọn</label>
                            <div id="summary-seats" class="flex flex-wrap gap-2 min-h-[40px]">
                                <span class="text-white/40 font-bold italic text-sm">Chưa chọn ghế...</span>
                            </div>
                            
                            <div class="flex justify-between items-end mt-8 border-t border-white/5 pt-6">
                                <span class="text-[10px] font-black text-indigo-300 uppercase">Tổng cộng: <span id="pickedCount">0</span>/<span id="maxCount">0</span> ghế</span>
                                <div class="text-right">
                                    <span class="block text-[10px] font-black text-amber-400 uppercase mb-1">Tạm tính</span>
                                    <span class="text-3xl font-black text-white italic">--- VND</span>
                                </div>
                            </div>
                        </div>

                        <button type="submit" id="submitBtn" class="w-full bg-amber-500 hover:bg-amber-400 text-amber-950 font-black uppercase tracking-widest py-6 rounded-2xl transition-all shadow-2xl disabled:opacity-50 disabled:cursor-not-allowed" 
                                ${empty showtimeId ? 'disabled' : ''}>
                            Chọn bắp nước <i class="fas fa-chevron-right ml-2"></i>
                        </button>
                        
                        <a href="${pageContext.request.contextPath}/home" class="block text-center text-indigo-300 text-[10px] font-black uppercase hover:text-white transition-all">
                            Quay lại trang chủ
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/common/footer.jsp" />

    <script>
        (function(){
            const movieSelect = document.getElementById('movieSelect');
            const dateInput = document.getElementById('showDateInput');
            const showtimeSelect = document.getElementById('showtimeSelect');
            const seatGrid = document.getElementById('seatGrid');
            const qtyEl = document.getElementById('ticketQty');
            const pickedCount = document.getElementById('pickedCount');
            const maxCount = document.getElementById('maxCount');
            const summarySeats = document.getElementById('summary-seats');
            const submitBtn = document.getElementById('submitBtn');

            let socket = null;

            // --- UI Sync ---
            function syncSummary() {
                const movie = movieSelect.options[movieSelect.selectedIndex]?.text || "---";
                const timeText = showtimeSelect.options[showtimeSelect.selectedIndex]?.text || "---";
                
                document.getElementById('summary-movie').textContent = movie;
                if(timeText !== "---") {
                    const parts = timeText.split(' - ');
                    document.getElementById('summary-time').textContent = parts[0];
                    document.getElementById('summary-room').textContent = parts[1]?.replace(/[()]/g, '') || "---";
                }
            }

            function updateSeatUI(){
                const checked = Array.from(document.querySelectorAll('input.seat:checked'));
                const max = parseInt(qtyEl.value) || 0;
                
                pickedCount.textContent = checked.length;
                maxCount.textContent = max;
                
                // Update summary seats
                summarySeats.innerHTML = checked.length ? '' : '<span class="text-white/40 font-bold italic text-sm">Chưa chọn ghế...</span>';
                checked.forEach(s => {
                    summarySeats.innerHTML += `<span class="px-3 py-1 bg-white/20 rounded-lg text-xs font-black text-white">${s.value}</span>`;
                });

                // Disable/Enable based on max
                document.querySelectorAll('input.seat:not(:checked)').forEach(s => {
                    s.disabled = checked.length >= max || s.dataset.booked === 'true' || s.dataset.otherSelected === 'true';
                    const label = document.querySelector(`label[for="${s.id}"]`);
                    if(s.disabled) label.style.opacity = '0.3';
                    else label.style.opacity = '1';
                });
            }

            // --- AJAX SHOWTIMES ---
            async function loadShowtimes(){
                const mId = movieSelect.value;
                const date = dateInput.value;
                if(!mId || !date) return;

                const res = await fetch(`${pageContext.request.contextPath}/booking-seat?ajax=showtimes&movieId=${mId}&showDate=${date}`);
                const data = await res.json();

                showtimeSelect.innerHTML = '<option value="">-- Chọn suất chiếu --</option>';
                data.forEach(st => {
                    showtimeSelect.innerHTML += `<option value="${st.id}">${st.time} (Phòng ${st.room})</option>`;
                });
                
                seatGrid.innerHTML = '<div class="text-center py-20 text-slate-600"><i class="fas fa-couch text-4xl mb-4 block"></i><p class="font-bold">Vui lòng chọn suất chiếu để thấy sơ đồ ghế</p></div>';
                submitBtn.disabled = true;
                syncSummary();
            }

            // --- AJAX SEATS ---
            async function loadSeats(){
                const stId = showtimeSelect.value;
                if(!stId) {
                    seatGrid.innerHTML = '';
                    submitBtn.disabled = true;
                    return;
                }

                const res = await fetch(`${pageContext.request.contextPath}/booking-seat?ajax=seats&showtimeId=${stId}`);
                const data = await res.json();

                renderSeats(data);
                initWebSocket(stId);
                submitBtn.disabled = false;
                document.querySelector('input[name="showtimeId"]').value = stId;
                syncSummary();
            }

            function renderSeats(data){
                let html = '<div class="screen-curve"></div><div class="flex flex-col items-center gap-4">';
                data.rows.forEach(r => {
                    html += `<div class="flex gap-3"><div class="w-6 text-[10px] font-black text-slate-700 flex items-center">${r}</div>`;
                    for(let i=1; i<=10; i++){
                        const code = r + i;
                        const isBooked = data.booked.includes(code);
                        const sid = 's_' + code;
                        
                        html += `<div class="relative group">`;
                        if(isBooked){
                            html += `<div class="seat-btn booked">${i}</div>`;
                        } else {
                            html += `
                                <input type="checkbox" id="${sid}" name="seats" value="${code}" class="hidden seat-check seat" data-booked="false">
                                <label for="${sid}" class="seat-btn">${i}</label>
                            `;
                        }
                        html += `</div>`;
                    }
                    html += `<div class="w-6 text-[10px] font-black text-slate-700 flex items-center justify-end">${r}</div></div>`;
                });
                html += '</div>';
                seatGrid.innerHTML = html;
                
                document.querySelectorAll('input.seat').forEach(s => {
                    s.addEventListener('change', () => {
                        const label = document.querySelector(`label[for="${s.id}"]`);
                        if(s.checked) label.classList.add('selected');
                        else label.classList.remove('selected');
                        updateSeatUI();
                        if(socket && socket.readyState === WebSocket.OPEN) {
                            socket.send(showtimeSelect.value + ':' + s.value + ':' + (s.checked ? 'select' : 'deselect'));
                        }
                    });
                });
                updateSeatUI();
            }

            // --- WEBSOCKET ---
            function initWebSocket(stId){
                if(socket) socket.close();
                const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
                const wsUrl = protocol + '//' + window.location.host + '${pageContext.request.contextPath}/ws/seat?showtimeId=' + stId;
                socket = new WebSocket(wsUrl);

                socket.onmessage = (event) => {
                    const [msgStId, seatCode, action] = event.data.split(':');
                    if (msgStId === stId) {
                        const seatInput = document.getElementById('s_' + seatCode);
                        const seatLabel = document.querySelector(`label[for="s_${seatCode}"]`);
                        if (seatInput && seatLabel) {
                            if (action === 'select') {
                                seatInput.disabled = true;
                                seatInput.dataset.otherSelected = 'true';
                                seatLabel.classList.add('other-selected');
                            } else {
                                if (!seatInput.checked) {
                                    seatInput.disabled = false;
                                    delete seatInput.dataset.otherSelected;
                                    seatLabel.classList.remove('other-selected');
                                    updateSeatUI();
                                }
                            }
                        }
                    }
                };
            }

            movieSelect.addEventListener('change', loadShowtimes);
            dateInput.addEventListener('change', loadShowtimes);
            showtimeSelect.addEventListener('change', loadSeats);
            qtyEl.addEventListener('input', updateSeatUI);

            // Initial load
            if(showtimeSelect.value) loadSeats();
            else if(movieSelect.value) syncSummary();
        })();
    </script>
</body>
</html>
