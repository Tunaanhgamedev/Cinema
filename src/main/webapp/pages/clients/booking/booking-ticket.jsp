<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Đặt vé & Chọn ghế | BOBIXI Cinema</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    
    <script>
        tailwind.config = {
            darkMode: 'media',
            theme: {
                extend: {
                    colors: {
                        dark: '#020617',
                        card: {
                            light: '#ffffff',
                            dark: '#0f172a'
                        }
                    },
                    fontFamily: {
                        sans: ['Outfit', 'sans-serif'],
                    }
                }
            }
        }
    </script>
    
    <style>
        body { 
            font-family: 'Outfit', sans-serif; 
            transition: background-color 0.5s ease, color 0.5s ease;
        }
        
        .adaptive-glass {
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(16px);
            border: 1px solid rgba(0, 0, 0, 0.05);
        }
        .dark .adaptive-glass {
            background: rgba(15, 23, 42, 0.7);
            border: 1px solid rgba(255, 255, 255, 0.08);
        }

        .ticket-stub {
            background: linear-gradient(135deg, #4f46e5 0%, #312e81 100%);
            border-radius: 40px;
            position: relative;
            box-shadow: 0 25px 50px -12px rgba(79, 70, 229, 0.4);
        }
        /* Notch effects for ticket look */
        .ticket-stub::before, .ticket-stub::after {
            content: '';
            position: absolute; left: -20px; top: 75%;
            width: 40px; height: 40px; 
            background: rgb(248 250 252); /* bg-slate-50 */
            border-radius: 50%;
            transition: background-color 0.5s ease;
        }
        .dark .ticket-stub::before, .dark .ticket-stub::after {
            background: #020617; /* dark bg */
        }
        .ticket-stub::after { left: auto; right: -20px; }

        .glow-text {
            background: linear-gradient(to right, #6366f1, #8b5cf6, #6366f1);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .seat-btn {
            width: 36px; height: 34px;
            border-radius: 10px;
            background: #e2e8f0; /* slate-200 */
            border: 1px solid rgba(0, 0, 0, 0.05);
            display: flex; align-items: center; justify-content: center;
            font-size: 10px; font-weight: 800; color: #64748b;
            cursor: pointer; transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .dark .seat-btn {
            background: #1e293b;
            border: 1px solid rgba(255, 255, 255, 0.05);
            color: #475569;
        }
        
        .seat-btn:hover:not(.booked):not(.other-selected) { 
            transform: translateY(-4px) scale(1.1); 
            background: #6366f1; color: white;
            box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.4);
            border-color: #818cf8;
        }
        .seat-btn.selected { 
            background: #6366f1; color: white; 
            box-shadow: 0 0 20px rgba(99, 102, 241, 0.6); 
            border-color: #818cf8;
        }
        .seat-btn.booked { 
            background: #cbd5e1; color: #94a3b8; cursor: not-allowed; opacity: 0.5; border: none; 
        }
        .dark .seat-btn.booked {
            background: #020617; color: #1e293b; opacity: 0.3;
        }
        .seat-btn.other-selected { background: #fbbf24; color: #78350f; cursor: not-allowed; }

        .screen-curve {
            width: 100%; height: 6px;
            background: #6366f1;
            box-shadow: 0 0 40px 5px rgba(99, 102, 241, 0.5);
            border-radius: 100%; margin-bottom: 60px;
        }

        ::-webkit-calendar-picker-indicator {
            cursor: pointer;
            transition: filter 0.5s;
        }
        .dark ::-webkit-calendar-picker-indicator {
            filter: invert(1);
        }
    </style>
</head>

<body class="bg-slate-50 dark:bg-dark text-slate-900 dark:text-slate-100 min-h-screen overflow-x-hidden">
    <jsp:include page="/common/header.jsp" />

    <main class="max-w-7xl mx-auto px-6 py-12 sm:py-20 relative">
        
        <!-- Decoration -->
        <div class="absolute top-0 left-0 w-full h-full pointer-events-none overflow-hidden">
            <div class="absolute -top-24 -left-24 w-96 h-96 bg-indigo-500/10 rounded-full blur-[100px]"></div>
            <div class="absolute top-1/2 -right-24 w-96 h-96 bg-purple-500/5 rounded-full blur-[100px]"></div>
        </div>

        <!-- Title Area -->
        <div class="text-center mb-20">
            <h1 class="text-5xl sm:text-7xl font-black italic tracking-tighter uppercase mb-6 leading-tight">
                <span class="glow-text">Phòng vé</span> BOBIXI
            </h1>
            <div class="flex flex-wrap justify-center items-center gap-4 text-[10px] font-black uppercase tracking-[0.3em] text-slate-400">
                <span class="text-indigo-600 dark:text-indigo-400">01 Chọn Ghế</span>
                <span class="w-10 h-px bg-slate-200 dark:bg-white/10"></span>
                <span>02 Bắp Nước</span>
                <span class="w-10 h-px bg-slate-200 dark:bg-white/10"></span>
                <span>03 Thanh Toán</span>
            </div>
        </div>

        <div class="flex flex-col lg:flex-row gap-12 relative z-10">
            
            <!-- Left Side -->
            <div class="flex-1 space-y-10">
                
                <!-- STEP 1: Selection -->
                <div class="adaptive-glass p-8 sm:p-12 rounded-[2.5rem] shadow-xl shadow-slate-200/50 dark:shadow-none">
                    <div class="flex items-center gap-6 mb-12">
                        <div class="w-14 h-14 rounded-2xl bg-indigo-600 text-white flex items-center justify-center text-xl font-black shadow-lg shadow-indigo-500/30 italic">1</div>
                        <div>
                            <h2 class="text-2xl font-black uppercase tracking-tight italic">Suất chiếu</h2>
                            <p class="text-slate-500 text-xs font-bold uppercase tracking-widest">Vui lòng chọn thông tin xem phim</p>
                        </div>
                    </div>
                    
                    <form id="filterForm" method="get" action="${pageContext.request.contextPath}/booking-seat" class="grid grid-cols-1 md:grid-cols-3 gap-8">
                        <div class="space-y-4">
                            <label class="text-[10px] font-black text-slate-400 uppercase tracking-widest">🎬 Phim</label>
                            <div class="relative">
                                <select class="w-full bg-white dark:bg-slate-950/50 border border-slate-200 dark:border-slate-800 rounded-2xl px-6 py-4 outline-none focus:border-indigo-500 transition-all cursor-pointer font-bold text-sm appearance-none" name="movieId" id="movieSelect" required>
                                    <option value="">-- Chọn phim --</option>
                                    <c:forEach var="m" items="${movies}">
                                        <option value="${m.id}" ${movieId == m.id ? 'selected' : ''}>${m.title}</option>
                                    </c:forEach>
                                </select>
                                <i class="fas fa-chevron-down absolute right-6 top-1/2 -translate-y-1/2 text-slate-400 pointer-events-none"></i>
                            </div>
                        </div>

                        <div class="space-y-4">
                            <label class="text-[10px] font-black text-slate-400 uppercase tracking-widest">📅 Ngày</label>
                            <input class="w-full bg-white dark:bg-slate-950/50 border border-slate-200 dark:border-slate-800 rounded-2xl px-6 py-4 outline-none focus:border-indigo-500 transition-all font-bold text-sm" 
                                   type="date" name="showDate" id="showDateInput" value="${showDate}" required/>
                        </div>

                        <div class="space-y-4">
                            <label class="text-[10px] font-black text-slate-400 uppercase tracking-widest">⏰ Suất</label>
                            <div class="relative">
                                <select class="w-full bg-white dark:bg-slate-950/50 border border-slate-200 dark:border-slate-800 rounded-2xl px-6 py-4 outline-none focus:border-indigo-500 transition-all cursor-pointer font-bold text-sm appearance-none" name="showtimeId" id="showtimeSelect" required>
                                    <option value="">-- Chọn suất --</option>
                                    <c:forEach var="st" items="${showtimes}">
                                        <option value="${st.showtimeId}" ${showtimeId == st.showtimeId ? 'selected' : ''}>
                                            <fmt:formatDate value="${st.startTime}" pattern="HH:mm"/> (P.${st.roomName})
                                        </option>
                                    </c:forEach>
                                </select>
                                <i class="fas fa-chevron-down absolute right-6 top-1/2 -translate-y-1/2 text-slate-400 pointer-events-none"></i>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- STEP 2: Seat Map -->
                <div class="adaptive-glass p-8 sm:p-12 rounded-[2.5rem] shadow-xl shadow-slate-200/50 dark:shadow-none text-center">
                    <div class="flex items-center justify-center gap-6 mb-16">
                        <div class="w-14 h-14 rounded-2xl bg-indigo-600 text-white flex items-center justify-center text-xl font-black shadow-lg shadow-indigo-500/30 italic">2</div>
                        <div class="text-left">
                            <h2 class="text-2xl font-black uppercase tracking-tight italic">Chỗ ngồi</h2>
                            <p class="text-slate-500 text-xs font-bold uppercase tracking-widest">Màn hình phía trên</p>
                        </div>
                    </div>

                    <div class="flex flex-col items-center">
                        <div class="w-full max-w-xl mb-16">
                            <div class="screen-curve"></div>
                            <span class="text-[9px] font-black text-slate-400 tracking-[1.5em] uppercase">Màn hình trung tâm</span>
                        </div>
                        
                        <div class="flex flex-col items-center gap-5 w-full" id="seatGrid">
                            <c:if test="${empty showtimeId}">
                                <div class="py-20 opacity-30">
                                    <i class="fas fa-couch text-7xl mb-4"></i>
                                    <p class="font-black text-xs uppercase tracking-widest">Chọn suất chiếu để hiển thị ghế</p>
                                </div>
                            </c:if>
                            
                            <c:forEach var="r" items="${rows}">
                                <div class="flex gap-4 items-center">
                                    <div class="w-6 text-[10px] font-black text-slate-300 dark:text-slate-700">${r}</div>
                                    <div class="flex gap-2 sm:gap-3">
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
                                            <c:if test="${i == 2 || i == 8}"><div class="w-4"></div></c:if>
                                        </c:forEach>
                                    </div>
                                    <div class="w-6 text-[10px] font-black text-slate-300 dark:text-slate-700 text-right">${r}</div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Legend -->
                        <div class="flex flex-wrap justify-center gap-10 mt-20 border-t border-slate-100 dark:border-white/5 pt-12 w-full">
                            <div class="flex items-center gap-3">
                                <div class="w-5 h-5 rounded-lg bg-slate-200 dark:bg-slate-800"></div>
                                <span class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Trống</span>
                            </div>
                            <div class="flex items-center gap-3">
                                <div class="w-5 h-5 rounded-lg bg-indigo-600 shadow-lg shadow-indigo-500/40"></div>
                                <span class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Chọn</span>
                            </div>
                            <div class="flex items-center gap-3">
                                <div class="w-5 h-5 rounded-lg bg-slate-400 dark:bg-black opacity-30"></div>
                                <span class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Đã bán</span>
                            </div>
                            <div class="flex items-center gap-3">
                                <div class="w-5 h-5 rounded-lg bg-amber-500"></div>
                                <span class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Giữ chỗ</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Side -->
            <div class="lg:w-[450px]">
                <div class="ticket-stub p-10 sticky top-24">
                    <div class="flex items-center justify-between mb-10 border-b border-white/10 pb-8">
                        <div>
                            <h2 class="text-3xl font-black uppercase tracking-tight text-white italic">Vé Của Bạn</h2>
                            <p class="text-indigo-200/50 text-[10px] font-bold uppercase tracking-widest mt-1">Thông tin đặt chỗ</p>
                        </div>
                        <i class="fas fa-ticket-alt text-white/10 text-6xl -rotate-12"></i>
                    </div>
                    
                    <form id="bookingForm" method="post" action="${pageContext.request.contextPath}/booking-seat" class="space-y-10 text-white">
                        <input type="hidden" name="movieId" value="${movieId}"/>
                        <input type="hidden" name="showtimeId" value="${showtimeId}"/>
                        
                        <div class="space-y-2">
                            <label class="text-[10px] font-black text-indigo-200/40 uppercase tracking-widest">Phim</label>
                            <p id="summary-movie" class="text-2xl font-black italic leading-tight">---</p>
                        </div>

                        <div class="grid grid-cols-2 gap-8">
                            <div class="space-y-2">
                                <label class="text-[10px] font-black text-indigo-200/40 uppercase tracking-widest">Giờ Chiếu</label>
                                <p id="summary-time" class="text-xl font-black italic">---</p>
                            </div>
                            <div class="space-y-2">
                                <label class="text-[10px] font-black text-indigo-200/40 uppercase tracking-widest">Phòng</label>
                                <p id="summary-room" class="text-xl font-black italic">---</p>
                            </div>
                        </div>

                        <div class="border-t-2 border-dashed border-white/10 my-10"></div>

                        <div class="grid grid-cols-2 gap-6">
                            <div class="space-y-3">
                                <label class="text-[10px] font-black text-indigo-200/40 uppercase tracking-widest">Loại Vé</label>
                                <select class="bg-white/10 border border-white/10 rounded-2xl px-5 py-4 w-full outline-none font-black text-xs uppercase tracking-widest focus:bg-white/20 transition-all" name="ticketType" required>
                                    <option value="ADULT" class="bg-indigo-900">Người lớn</option>
                                    <option value="STUDENT" class="bg-indigo-900">Sinh viên</option>
                                    <option value="CHILD" class="bg-indigo-900">Trẻ em</option>
                                </select>
                            </div>
                            <div class="space-y-3">
                                <label class="text-[10px] font-black text-indigo-200/40 uppercase tracking-widest">Số lượng</label>
                                <input id="ticketQty" class="bg-white/10 border border-white/10 rounded-2xl px-5 py-4 w-full outline-none font-black text-sm text-center focus:bg-white/20 transition-all" 
                                       type="number" name="ticketQty" min="1" max="10" value="${empty ticketQty ? 2 : ticketQty}" required/>
                            </div>
                        </div>

                        <div class="bg-white/5 p-8 rounded-[2rem] space-y-6">
                            <div class="flex justify-between items-center">
                                <label class="text-[10px] font-black text-indigo-200 uppercase tracking-widest">Ghế đã chọn</label>
                                <span class="px-3 py-1 bg-amber-500 text-black text-[9px] font-black rounded-full shadow-lg shadow-amber-500/20"><span id="pickedCount">0</span>/<span id="maxCount">0</span> GHẾ</span>
                            </div>
                            <div id="summary-seats" class="flex flex-wrap gap-2 min-h-[40px]">
                                <span class="text-white/20 font-bold italic text-sm">Vui lòng chọn ghế...</span>
                            </div>
                        </div>

                        <button type="submit" id="submitBtn" class="w-full bg-amber-500 hover:bg-amber-400 text-black font-black uppercase tracking-widest py-6 rounded-2xl shadow-2xl shadow-amber-500/30 hover:scale-[1.02] active:scale-95 transition-all disabled:opacity-30 disabled:cursor-not-allowed" disabled>
                            <i class="fas fa-popcorn mr-2"></i> Tiếp tục chọn Combo
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </main>

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

            function syncSummary() {
                const movie = movieSelect.options[movieSelect.selectedIndex]?.text || "---";
                const timeText = showtimeSelect.options[showtimeSelect.selectedIndex]?.text || "---";
                document.getElementById('summary-movie').textContent = movie;
                if(timeText !== "---") {
                    const parts = timeText.split(' (P.');
                    document.getElementById('summary-time').textContent = parts[0];
                    document.getElementById('summary-room').textContent = 'PHÒNG ' + parts[1]?.replace(/[)]/g, '') || "---";
                }
            }

            function updateSeatUI(){
                const checked = Array.from(document.querySelectorAll('input.seat:checked'));
                const max = parseInt(qtyEl.value) || 0;
                pickedCount.textContent = checked.length;
                maxCount.textContent = max;
                
                summarySeats.innerHTML = checked.length ? '' : '<span class="text-white/20 font-bold italic text-sm">Vui lòng chọn ghế...</span>';
                checked.forEach(s => {
                    summarySeats.innerHTML += `<span class="px-3 py-1 bg-white/20 border border-white/10 rounded-lg text-xs font-black text-white italic tracking-tighter">${s.value}</span>`;
                });

                document.querySelectorAll('input.seat:not(:checked)').forEach(s => {
                    s.disabled = checked.length >= max || s.dataset.booked === 'true' || s.dataset.otherSelected === 'true';
                    const label = document.querySelector(`label[for="${s.id}"]`);
                    if(s.disabled) label.style.opacity = '0.2';
                    else label.style.opacity = '1';
                });
                
                submitBtn.disabled = checked.length === 0;
            }

            async function loadShowtimes(){
                const mId = movieSelect.value;
                const date = dateInput.value;
                if(!mId || !date) return;
                const res = await fetch(`${pageContext.request.contextPath}/booking-seat?ajax=showtimes&movieId=${mId}&showDate=${date}`);
                const data = await res.json();
                showtimeSelect.innerHTML = '<option value="">-- Chọn suất --</option>';
                data.forEach(st => {
                    showtimeSelect.innerHTML += `<option value="${st.id}">${st.time} (P.${st.room})</option>`;
                });
                seatGrid.innerHTML = '<div class="py-20 opacity-30"><i class="fas fa-couch text-7xl mb-4 block mx-auto"></i><p class="font-black text-xs tracking-widest uppercase">Chọn suất để thấy sơ đồ</p></div>';
                syncSummary();
            }

            async function loadSeats(){
                const stId = showtimeSelect.value;
                if(!stId) return;
                const res = await fetch(`${pageContext.request.contextPath}/booking-seat?ajax=seats&showtimeId=${stId}`);
                const data = await res.json();
                renderSeats(data);
                initWebSocket(stId);
                syncSummary();
            }

            function renderSeats(data){
                let html = '<div class="w-full max-w-xl mb-16"><div class="screen-curve"></div><span class="text-[9px] font-black text-slate-400 tracking-[1.5em] uppercase">Màn hình trung tâm</span></div>';
                html += '<div class="flex flex-col items-center gap-5 w-full">';
                data.rows.forEach(r => {
                    html += `<div class="flex gap-4 items-center"><div class="w-6 text-[10px] font-black text-slate-300 dark:text-slate-700">${r}</div><div class="flex gap-2 sm:gap-3">`;
                    for(let i=1; i<=10; i++){
                        const code = r + i;
                        const isBooked = data.booked.includes(code);
                        const sid = 's_' + code;
                        html += `<div class="relative group">`;
                        if(isBooked) html += `<div class="seat-btn booked">${i}</div>`;
                        else html += `<input type="checkbox" id="${sid}" name="seats" value="${code}" class="hidden seat-check seat" data-booked="false"><label for="${sid}" class="seat-btn">${i}</label>`;
                        html += `</div>`;
                        if(i == 2 || i == 8) html += `<div class="w-4"></div>`;
                    }
                    html += `</div><div class="w-6 text-[10px] font-black text-slate-300 dark:text-slate-700 text-right">${r}</div></div>`;
                });
                html += '</div>';
                seatGrid.innerHTML = html;
                document.querySelectorAll('input.seat').forEach(s => {
                    s.addEventListener('change', () => {
                        const label = document.querySelector(`label[for="${s.id}"]`);
                        if(s.checked) label.classList.add('selected');
                        else label.classList.remove('selected');
                        updateSeatUI();
                        if(socket && socket.readyState === WebSocket.OPEN) socket.send(showtimeSelect.value + ':' + s.value + ':' + (s.checked ? 'select' : 'deselect'));
                    });
                });
                updateSeatUI();
            }

            function initWebSocket(stId){
                if(socket) socket.close();
                const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
                socket = new WebSocket(protocol + '//' + window.location.host + '${pageContext.request.contextPath}/ws/seat?showtimeId=' + stId);
                socket.onmessage = (e) => {
                    const [msgStId, seatCode, action] = e.data.split(':');
                    if (msgStId === stId) {
                        const s = document.getElementById('s_' + seatCode);
                        const l = document.querySelector(`label[for="s_${seatCode}"]`);
                        if (s && l) {
                            if (action === 'select') { s.disabled = true; s.dataset.otherSelected = 'true'; l.classList.add('other-selected'); }
                            else if (!s.checked) { s.disabled = false; delete s.dataset.otherSelected; l.classList.remove('other-selected'); updateSeatUI(); }
                        }
                    }
                };
            }

            movieSelect.addEventListener('change', loadShowtimes);
            dateInput.addEventListener('change', loadShowtimes);
            showtimeSelect.addEventListener('change', loadSeats);
            qtyEl.addEventListener('input', updateSeatUI);
            if(showtimeSelect.value) loadSeats();
        })();
    </script>
</body>
</html>
