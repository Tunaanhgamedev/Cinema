<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi" class="dark">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Đặt vé & Chọn ghế | BOBIXI Cinema</title>
    
    <!-- Fonts & Frameworks -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        dark: '#020617',
                        card: '#0f172a',
                        primary: '#6366f1',
                        accent: '#fbbf24',
                    }
                }
            }
        }
    </script>
    
    <style>
        body { 
            font-family: 'Outfit', sans-serif; 
            background-color: #020617; 
            color: #f8fafc; 
            background-image: 
                radial-gradient(circle at 0% 0%, rgba(99, 102, 241, 0.05) 0%, transparent 30%),
                radial-gradient(circle at 100% 100%, rgba(251, 191, 36, 0.05) 0%, transparent 30%);
            min-height: 100vh;
        }
        
        .glass-panel {
            background: rgba(15, 23, 42, 0.7);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 24px;
            box-shadow: 0 10px 40px -10px rgba(0, 0, 0, 0.5);
        }

        .ticket-stub {
            background: linear-gradient(135deg, #4f46e5 0%, #312e81 100%);
            border-radius: 32px;
            position: relative;
        }
        /* Notch effects for ticket look */
        .ticket-stub::before, .ticket-stub::after {
            content: '';
            position: absolute; left: -15px; top: 70%;
            width: 30px; height: 30px; background: #020617; border-radius: 50%;
        }
        .ticket-stub::after { left: auto; right: -15px; }

        .glow-text {
            background: linear-gradient(to right, #818cf8, #ffffff, #818cf8);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            text-shadow: 0 0 30px rgba(99, 102, 241, 0.3);
        }

        .seat-btn {
            width: 36px; height: 34px;
            border-radius: 8px;
            background: #1e293b;
            border: 1px solid rgba(255, 255, 255, 0.05);
            display: flex; align-items: center; justify-content: center;
            font-size: 10px; font-weight: 800; color: #64748b;
            cursor: pointer; transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .seat-btn:hover:not(.booked):not(.other-selected) { 
            transform: scale(1.15) translateY(-2px); 
            background: #334155; color: white;
            box-shadow: 0 5px 15px rgba(99, 102, 241, 0.4);
            border-color: #6366f1;
        }
        .seat-btn.selected { 
            background: #6366f1; color: white; 
            box-shadow: 0 0 20px rgba(99, 102, 241, 0.6); 
            border-color: #818cf8; 
            transform: scale(1.1);
        }
        .seat-btn.booked { background: #020617; color: #1e293b; cursor: not-allowed; opacity: 0.4; border: none; }
        .seat-btn.other-selected { background: #fbbf24; color: #78350f; cursor: not-allowed; }

        .screen-light {
            width: 100%; height: 4px;
            background: linear-gradient(to right, transparent, #6366f1, transparent);
            box-shadow: 0 0 40px 5px rgba(99, 102, 241, 0.8);
            border-radius: 50%; margin-bottom: 50px;
        }

        .input-glow:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.15);
        }

        ::-webkit-calendar-picker-indicator {
            filter: invert(1);
            cursor: pointer;
        }
    </style>
</head>

<body class="overflow-x-hidden">
    <!-- Header wrapper to ensure it doesn't break background -->
    <div class="relative z-50">
        <jsp:include page="/common/header.jsp" />
    </div>

    <main class="max-w-7xl mx-auto px-4 sm:px-6 py-8 sm:py-16 relative z-10">
        
        <!-- Animated Background Decor -->
        <div class="absolute -top-24 -left-24 w-96 h-96 bg-indigo-600/10 rounded-full blur-[120px] pointer-events-none"></div>
        <div class="absolute top-1/2 -right-24 w-96 h-96 bg-amber-600/5 rounded-full blur-[120px] pointer-events-none"></div>

        <!-- Section Title -->
        <div class="text-center mb-16">
            <h1 class="text-4xl sm:text-7xl font-black italic tracking-tighter glow-text uppercase mb-4 leading-tight">
                Phòng vé trực tuyến
            </h1>
            <div class="flex flex-wrap justify-center items-center gap-4 text-xs font-bold uppercase tracking-[0.2em] text-slate-500">
                <span>Chọn Phim</span>
                <i class="fas fa-chevron-right text-[8px] text-slate-700"></i>
                <span class="text-indigo-400">Chọn Ghế</span>
                <i class="fas fa-chevron-right text-[8px] text-slate-700"></i>
                <span>Bắp Nước</span>
                <i class="fas fa-chevron-right text-[8px] text-slate-700"></i>
                <span>Thanh Toán</span>
            </div>
        </div>

        <div class="flex flex-col lg:flex-row gap-10">
            
            <!-- Left Side: Interactive Forms -->
            <div class="flex-1 space-y-8">
                
                <!-- STEP 1: Selection -->
                <div class="glass-panel p-6 sm:p-10">
                    <div class="flex items-center gap-5 mb-10">
                        <div class="w-12 h-12 rounded-2xl bg-indigo-500/10 border border-indigo-500/30 flex items-center justify-center text-indigo-400 text-xl font-black shadow-[0_0_20px_rgba(99,102,241,0.2)]">1</div>
                        <div>
                            <h2 class="text-xl font-black uppercase tracking-tight text-white">Chọn Phim & Suất chiếu</h2>
                            <p class="text-slate-500 text-xs font-semibold">Vui lòng chọn thông tin để hiển thị sơ đồ ghế</p>
                        </div>
                    </div>
                    
                    <form id="filterForm" method="get" action="${pageContext.request.contextPath}/booking-seat" class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <div class="space-y-3">
                            <label class="text-[10px] font-black text-slate-500 uppercase tracking-widest flex items-center gap-2">
                                <i class="fas fa-film text-indigo-500"></i> Phim đang chọn
                            </label>
                            <div class="relative">
                                <select class="w-full bg-slate-950/50 border border-slate-800 rounded-2xl px-5 py-4 text-white outline-none input-glow appearance-none transition-all cursor-pointer font-bold text-sm" name="movieId" id="movieSelect" required>
                                    <option value="">-- Chọn phim --</option>
                                    <c:forEach var="m" items="${movies}">
                                        <option value="${m.movieId}" ${movieId == m.movieId ? 'selected' : ''}>${m.title}</option>
                                    </c:forEach>
                                </select>
                                <i class="fas fa-chevron-down absolute right-5 top-1/2 -translate-y-1/2 text-slate-600 pointer-events-none"></i>
                            </div>
                        </div>

                        <div class="space-y-3">
                            <label class="text-[10px] font-black text-slate-500 uppercase tracking-widest flex items-center gap-2">
                                <i class="fas fa-calendar-alt text-indigo-500"></i> Ngày xem
                            </label>
                            <input class="w-full bg-slate-950/50 border border-slate-800 rounded-2xl px-5 py-4 text-white outline-none input-glow transition-all font-bold text-sm" 
                                   type="date" name="showDate" id="showDateInput" value="${showDate}" required/>
                        </div>

                        <div class="space-y-3">
                            <label class="text-[10px] font-black text-slate-500 uppercase tracking-widest flex items-center gap-2">
                                <i class="fas fa-clock text-indigo-500"></i> Suất chiếu
                            </label>
                            <div class="relative">
                                <select class="w-full bg-slate-950/50 border border-slate-800 rounded-2xl px-5 py-4 text-white outline-none input-glow appearance-none transition-all cursor-pointer font-bold text-sm" name="showtimeId" id="showtimeSelect" required>
                                    <option value="">-- Chọn suất chiếu --</option>
                                    <c:forEach var="st" items="${showtimes}">
                                        <option value="${st.showtimeId}" ${showtimeId == st.showtimeId ? 'selected' : ''}>
                                            <fmt:formatDate value="${st.startTime}" pattern="HH:mm"/> - (Phòng ${st.roomName})
                                        </option>
                                    </c:forEach>
                                </select>
                                <i class="fas fa-chevron-down absolute right-5 top-1/2 -translate-y-1/2 text-slate-600 pointer-events-none"></i>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- STEP 2: Seat Map -->
                <div class="glass-panel p-6 sm:p-10 overflow-hidden relative">
                    <div class="flex items-center gap-5 mb-16">
                        <div class="w-12 h-12 rounded-2xl bg-indigo-500/10 border border-indigo-500/30 flex items-center justify-center text-indigo-400 text-xl font-black">2</div>
                        <div>
                            <h2 class="text-xl font-black uppercase tracking-tight text-white">Chọn Chỗ ngồi</h2>
                            <p class="text-slate-500 text-xs font-semibold">Chạm vào ghế để chọn hoặc bỏ chọn</p>
                        </div>
                    </div>

                    <div class="flex flex-col items-center">
                        <!-- Cinema Screen -->
                        <div class="w-full max-w-xl px-10 mb-20 text-center">
                            <div class="screen-light"></div>
                            <span class="text-[9px] font-black text-slate-700 tracking-[1.5em] uppercase">Màn hình trung tâm</span>
                        </div>
                        
                        <div class="flex flex-col items-center gap-4 w-full" id="seatGrid">
                            <c:if test="${empty showtimeId}">
                                <div class="text-center py-24 text-slate-600">
                                    <div class="relative inline-block mb-6">
                                        <i class="fas fa-couch text-6xl opacity-10"></i>
                                        <i class="fas fa-search absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-2xl text-indigo-500"></i>
                                    </div>
                                    <p class="font-bold text-sm tracking-wide uppercase">Vui lòng chọn phim & suất chiếu để thấy sơ đồ ghế</p>
                                </div>
                            </c:if>
                            
                            <!-- Rows from Server -->
                            <c:forEach var="r" items="${rows}">
                                <div class="flex gap-2 sm:gap-4 items-center">
                                    <div class="w-6 text-[10px] font-black text-slate-700">${r}</div>
                                    <div class="flex gap-2">
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
                                            <!-- Aisle after column 2 and 8 -->
                                            <c:if test="${i == 2 || i == 8}">
                                                <div class="w-2 sm:w-4"></div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                    <div class="w-6 text-[10px] font-black text-slate-700 text-right">${r}</div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Legend -->
                        <div class="flex flex-wrap justify-center gap-8 mt-20 border-t border-white/5 pt-10 w-full">
                            <div class="flex items-center gap-3">
                                <div class="w-4 h-4 rounded-md bg-[#1e293b]"></div>
                                <span class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Trống</span>
                            </div>
                            <div class="flex items-center gap-3">
                                <div class="w-4 h-4 rounded-md bg-indigo-500 shadow-[0_0_15px_rgba(99,102,241,0.6)]"></div>
                                <span class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Đang chọn</span>
                            </div>
                            <div class="flex items-center gap-3">
                                <div class="w-4 h-4 rounded-md bg-slate-950 opacity-40"></div>
                                <span class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Đã đặt</span>
                            </div>
                            <div class="flex items-center gap-3">
                                <div class="w-4 h-4 rounded-md bg-amber-500"></div>
                                <span class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Người khác</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Side: Ticket Stub -->
            <div class="lg:w-[400px]">
                <div class="ticket-stub p-8 shadow-[0_30px_60px_-15px_rgba(0,0,0,0.6)] sticky top-24">
                    <div class="flex items-center justify-between mb-8 border-b border-white/10 pb-6">
                        <h2 class="text-2xl font-black uppercase tracking-tight text-white italic">Vé Của Bạn</h2>
                        <i class="fas fa-ticket-alt text-white/20 text-4xl -rotate-12"></i>
                    </div>
                    
                    <form id="bookingForm" method="post" action="${pageContext.request.contextPath}/booking-seat" class="space-y-8">
                        <input type="hidden" name="movieId" value="${movieId}"/>
                        <input type="hidden" name="showDate" value="${showDate}"/>
                        <input type="hidden" name="showtimeId" value="${showtimeId}"/>
                        
                        <div class="space-y-1">
                            <label class="text-[10px] font-black text-indigo-200/60 uppercase tracking-widest">Phim</label>
                            <p id="summary-movie" class="text-xl font-black text-white italic leading-tight">---</p>
                        </div>

                        <div class="grid grid-cols-2 gap-6">
                            <div class="space-y-1">
                                <label class="text-[10px] font-black text-indigo-200/60 uppercase tracking-widest">Suất chiếu</label>
                                <p id="summary-time" class="text-lg font-bold text-white">---</p>
                            </div>
                            <div class="space-y-1">
                                <label class="text-[10px] font-black text-indigo-200/60 uppercase tracking-widest">Phòng</label>
                                <p id="summary-room" class="text-lg font-bold text-white">---</p>
                            </div>
                        </div>

                        <!-- Dashed Divider for Ticket Look -->
                        <div class="border-t-2 border-dashed border-white/10 my-8"></div>

                        <div class="grid grid-cols-2 gap-4">
                            <div class="space-y-2">
                                <label class="text-[10px] font-black text-indigo-200/60 uppercase tracking-widest">Loại vé</label>
                                <select class="bg-black/20 border border-white/10 rounded-xl px-4 py-3 w-full outline-none font-bold text-sm text-white focus:bg-black/40 transition-all" name="ticketType" required>
                                    <option value="ADULT">Người lớn</option>
                                    <option value="STUDENT">Học sinh/SV</option>
                                    <option value="CHILD">Trẻ em</option>
                                </select>
                            </div>
                            <div class="space-y-2">
                                <label class="text-[10px] font-black text-indigo-200/60 uppercase tracking-widest">Số lượng</label>
                                <input id="ticketQty" class="bg-black/20 border border-white/10 rounded-xl px-4 py-3 w-full outline-none font-bold text-sm text-center text-white focus:bg-black/40 transition-all" 
                                       type="number" name="ticketQty" min="1" max="10" value="${empty ticketQty ? 2 : ticketQty}" required/>
                            </div>
                        </div>

                        <div class="bg-black/20 p-6 rounded-3xl mt-8 space-y-4">
                            <div class="flex justify-between items-start">
                                <label class="text-[10px] font-black text-indigo-300 uppercase tracking-widest">Ghế đã chọn</label>
                                <span class="text-[10px] font-black text-amber-400"><span id="pickedCount">0</span>/<span id="maxCount">0</span> GHẾ</span>
                            </div>
                            <div id="summary-seats" class="flex flex-wrap gap-2 min-h-[40px]">

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
