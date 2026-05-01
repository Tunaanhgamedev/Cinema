<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="vi" class="dark">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1" />
                <title>Đặt vé & Chọn ghế | BOBIXI Cinema</title>

                <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800;900&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                <script src="https://cdn.tailwindcss.com"></script>

                <script>
                    tailwind.config = {
                        darkMode: 'class',
                        theme: {
                            extend: {
                                colors: {
                                    dark: '#020617',
                                    card: '#0f172a'
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
                        background-color: #020617;
                        color: #f8fafc;
                    }

                    /* Force old header to be dark on this page */
                    .bobixi-header,
                    .header-top {
                        background: #020617 !important;
                        border-bottom: 1px solid rgba(255, 255, 255, 0.05) !important;
                    }

                    .main-menu a,
                    .user-menu a,
                    .account-name {
                        color: #94a3b8 !important;
                    }

                    .main-menu a:hover {
                        color: #6366f1 !important;
                    }

                    .glass-card {
                        background: rgba(15, 23, 42, 0.6);
                        backdrop-filter: blur(20px);
                        border: 1px solid rgba(255, 255, 255, 0.05);
                        border-radius: 40px;
                    }

                    .ticket-premium {
                        background: linear-gradient(135deg, #4f46e5 0%, #312e81 100%);
                        border-radius: 40px;
                        position: relative;
                        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
                    }

                    .ticket-premium::before,
                    .ticket-premium::after {
                        content: '';
                        position: absolute;
                        left: -20px;
                        top: 75%;
                        width: 40px;
                        height: 40px;
                        background: #020617;
                        border-radius: 50%;
                    }

                    .ticket-premium::after {
                        left: auto;
                        right: -20px;
                    }

                    .seat-btn {
                        width: 36px;
                        height: 34px;
                        border-radius: 10px;
                        background: #1e293b;
                        border: 1px solid rgba(255, 255, 255, 0.05);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 10px;
                        font-weight: 800;
                        color: #475569;
                        cursor: pointer;
                        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                    }

                    .seat-btn:hover:not(.booked):not(.other-selected) {
                        transform: translateY(-4px) scale(1.1);
                        background: #6366f1;
                        color: white;
                        box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.4);
                    }

                    .seat-btn.selected {
                        background: #6366f1;
                        color: white;
                        box-shadow: 0 0 20px rgba(99, 102, 241, 0.6);
                        border-color: #818cf8;
                    }

                    .seat-btn.booked {
                        background: #020617;
                        color: #1e293b;
                        opacity: 0.3;
                        cursor: not-allowed;
                        border: none;
                    }

                    .seat-btn.other-selected {
                        background: #fbbf24;
                        color: #78350f;
                        cursor: not-allowed;
                    }

                    .screen-line {
                        width: 100%;
                        height: 4px;
                        background: linear-gradient(to right, transparent, #6366f1, transparent);
                        box-shadow: 0 0 40px 5px rgba(99, 102, 241, 0.4);
                        border-radius: 100%;
                        margin-bottom: 60px;
                    }
                </style>
            </head>

            <body class="bg-dark text-slate-100 min-h-screen">
                <jsp:include page="/common/header.jsp" />

                <main class="max-w-7xl mx-auto px-6 py-12 sm:py-20">

                    <!-- Page Header -->
                    <div class="text-center mb-20 space-y-4">
                        <h1 class="text-5xl sm:text-6xl font-black italic tracking-tighter uppercase leading-tight">
                            Hệ thống <span class="text-indigo-500">Đặt Vé</span>
                        </h1>
                        <div
                            class="flex justify-center items-center gap-4 text-[10px] font-black uppercase tracking-[0.3em] text-slate-600">
                            <span class="text-indigo-500">01 Chọn Ghế</span>
                            <span class="w-10 h-px bg-white/10"></span>
                            <span>02 Bắp Nước</span>
                            <span class="w-10 h-px bg-white/10"></span>
                            <span>03 Thanh Toán</span>
                        </div>
                    </div>

                    <div class="flex flex-col lg:flex-row gap-12 relative">

                        <!-- SELECTION & SEATS -->
                        <div class="flex-1 space-y-10">

                            <!-- SELECT BOXES -->
                            <div class="glass-card p-8 sm:p-12 shadow-2xl">
                                <div class="flex items-center gap-6 mb-12">
                                    <div
                                        class="w-14 h-14 rounded-2xl bg-indigo-600 text-white flex items-center justify-center text-xl font-black italic shadow-lg shadow-indigo-500/30">
                                        1</div>
                                    <div>
                                        <h2 class="text-2xl font-black uppercase tracking-tight italic">Thông tin chiếu
                                        </h2>
                                        <p class="text-slate-500 text-xs font-bold uppercase tracking-widest">Chọn phim
                                            và suất chiếu</p>
                                    </div>
                                </div>

                                <form id="filterForm" method="get"
                                    action="${pageContext.request.contextPath}/booking-seat"
                                    class="grid grid-cols-1 md:grid-cols-3 gap-8">
                                    <div class="space-y-4">
                                        <label
                                            class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Phim</label>
                                        <select
                                            class="w-full bg-slate-950/50 border border-white/5 rounded-2xl px-6 py-4 outline-none focus:border-indigo-500 transition-all font-bold text-sm appearance-none cursor-pointer"
                                            name="movieId" id="movieSelect" required>
                                            <option value="">-- Chọn phim --</option>
                                            <c:if test="${not empty selectedMovie}">
                                                <option value="${selectedMovie.movieId}" selected
                                                    data-poster="${pageContext.request.contextPath}/${selectedMovie.poster}"
                                                    data-genre="${selectedMovie.genre}"
                                                    data-duration="${selectedMovie.duration}">
                                                    ${selectedMovie.title}
                                                </option>
                                            </c:if>
                                            <c:forEach var="m" items="${movies}">
                                                <%-- Tránh lặp lại phim nếu nó đã là selectedMovie --%>
                                                    <c:if test="${selectedMovie.movieId != m.movieId}">
                                                        <option value="${m.movieId}" ${movieId==m.movieId ? 'selected'
                                                            : '' }
                                                            data-poster="${pageContext.request.contextPath}/${m.poster}"
                                                            data-genre="${m.genre}" data-duration="${m.duration}">
                                                            ${m.title}
                                                        </option>
                                                    </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="space-y-4">
                                        <label
                                            class="flex items-center gap-3 text-indigo-300/80 font-black text-[10px] uppercase tracking-[0.2em] ml-2">
                                            <i class="fas fa-calendar-alt"></i>
                                            Ngày chiếu
                                        </label>
                                        <select
                                            class="w-full bg-slate-950/50 border border-white/5 rounded-2xl px-6 py-4 outline-none focus:border-indigo-500 transition-all font-bold text-sm appearance-none cursor-pointer"
                                            name="showDate" id="showDateInput" required>
                                            <option value="">-- Chọn ngày --</option>
                                            <c:forEach var="d" items="${availableDates}">
                                                <option value="${d}" ${showDate==d ? 'selected' : '' }>${d}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="space-y-4">
                                        <label
                                            class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Suất
                                            chiếu</label>
                                        <select
                                            class="w-full bg-slate-950/50 border border-white/5 rounded-2xl px-6 py-4 outline-none focus:border-indigo-500 transition-all font-bold text-sm"
                                            name="showtimeId" id="showtimeSelect" required>
                                            <option value="">-- Chọn suất --</option>
                                            <c:forEach var="st" items="${showtimes}">
                                                <option value="${st.showtimeId}" ${showtimeId==st.showtimeId
                                                    ? 'selected' : '' }>
                                                    ${st.roomName} |
                                                    <fmt:formatDate value="${st.startTime}" pattern="HH:mm" />
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </form>
                            </div>

                            <!-- SEAT MAP -->
                            <div class="glass-card p-8 sm:p-12 shadow-2xl text-center">
                                <div class="flex items-center justify-center gap-6 mb-16">
                                    <div
                                        class="w-14 h-14 rounded-2xl bg-indigo-600 text-white flex items-center justify-center text-xl font-black italic shadow-lg shadow-indigo-500/30">
                                        2</div>
                                    <div class="text-left">
                                        <h2 class="text-2xl font-black uppercase tracking-tight italic">Chọn ghế ngồi
                                        </h2>
                                        <p class="text-slate-500 text-xs font-bold uppercase tracking-widest">Màn hình
                                            phía trên</p>
                                    </div>
                                </div>

                                <div class="flex flex-col items-center overflow-x-auto pb-6">
                                    <div class="w-full max-w-xl mb-16">
                                        <div class="screen-line"></div>
                                        <span
                                            class="text-[9px] font-black text-slate-600 tracking-[1.5em] uppercase">Màn
                                            hình trung tâm</span>
                                    </div>

                                    <div class="flex flex-col items-center gap-5 min-w-[500px]" id="seatGrid">
                                        <c:if test="${empty showtimeId}">
                                            <div class="py-20 opacity-20">
                                                <i class="fas fa-couch text-7xl mb-4"></i>
                                                <p class="font-black text-xs uppercase tracking-widest">Chọn suất chiếu
                                                    để hiển thị ghế</p>
                                            </div>
                                        </c:if>

                                        <c:forEach var="r" items="${rows}">
                                            <div class="flex gap-4 items-center">
                                                <div class="w-6 text-[10px] font-black text-slate-700">${r}</div>
                                                <div class="flex gap-3">
                                                    <c:forEach var="i" begin="1" end="10">
                                                        <c:set var="code" value="${r}${i}" />
                                                        <div class="relative">
                                                            <input type="checkbox" id="s_${code}" name="seats"
                                                                value="${code}" class="hidden seat-check seat"
                                                                ${bookedMap[code] ? 'disabled' : '' }
                                                                ${selectedMap[code] ? 'checked' : '' } />
                                                            <label for="s_${code}"
                                                                class="seat-btn ${bookedMap[code] ? 'booked' : ''} ${selectedMap[code] ? 'selected' : ''}">${i}</label>
                                                        </div>
                                                        <c:if test="${i == 2 || i == 8}">
                                                            <div class="w-4"></div>
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                                <div class="w-6 text-[10px] font-black text-slate-700 text-right">${r}
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>

                                    <!-- Legend -->
                                    <div
                                        class="flex flex-wrap justify-center gap-10 mt-20 border-t border-white/5 pt-12 w-full">
                                        <div class="flex items-center gap-3">
                                            <div class="w-5 h-5 rounded-lg bg-slate-800"></div>
                                            <span
                                                class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Trống</span>
                                        </div>
                                        <div class="flex items-center gap-3">
                                            <div class="w-5 h-5 rounded-lg bg-indigo-600"></div>
                                            <span
                                                class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Chọn</span>
                                        </div>
                                        <div class="flex items-center gap-3">
                                            <div class="w-5 h-5 rounded-lg bg-black opacity-30"></div>
                                            <span
                                                class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Đã
                                                bán</span>
                                        </div>
                                        <div class="flex items-center gap-3">
                                            <div class="w-5 h-5 rounded-lg bg-amber-500"></div>
                                            <span
                                                class="text-[10px] font-black text-slate-500 uppercase tracking-widest">Giữ
                                                chỗ</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- SIDEBAR -->
                        <div class="lg:w-[420px]">
                            <div class="ticket-premium p-10 sticky top-24">
                                <div class="flex items-center justify-between mb-10 border-b border-white/10 pb-8">
                                    <div>
                                        <h2 class="text-3xl font-black uppercase tracking-tight text-white italic">Vé
                                            Của Bạn</h2>
                                        <p
                                            class="text-indigo-200/50 text-[10px] font-bold uppercase tracking-widest mt-1">
                                            Thông tin thanh toán</p>
                                    </div>
                                    <i class="fas fa-ticket-alt text-white/10 text-6xl -rotate-12"></i>
                                </div>

                                <form id="bookingForm" method="post"
                                    action="${pageContext.request.contextPath}/booking-seat"
                                    class="space-y-8 text-white">
                                    <input type="hidden" name="movieId" value="${movieId}" />
                                    <input type="hidden" name="showtimeId" value="${showtimeId}" />

                                    <!-- Movie Info Section -->
                                    <div class="flex gap-6 items-start">
                                        <div
                                            class="w-24 h-36 rounded-2xl overflow-hidden shadow-2xl border border-white/10 flex-shrink-0 bg-slate-900">
                                            <img id="summary-poster"
                                                src="${not empty selectedMovie ? selectedMovie.poster : ''}"
                                                class="w-full h-full object-cover ${empty selectedMovie.poster ? 'hidden' : ''}"
                                                alt="Poster">
                                            <div id="poster-placeholder"
                                                class="w-full h-full flex items-center justify-center ${not empty selectedMovie.poster ? 'hidden' : ''}">
                                                <i class="fas fa-film text-white/10 text-2xl"></i>
                                            </div>
                                        </div>
                                        <div class="space-y-3 pt-2">
                                            <div class="flex flex-wrap gap-2">
                                                <span id="summary-genre"
                                                    class="px-2 py-0.5 bg-indigo-500/20 text-indigo-300 text-[8px] font-black uppercase tracking-tighter rounded border border-indigo-500/30">
                                                    ${not empty selectedMovie ? selectedMovie.genre : '---'}
                                                </span>
                                                <span id="summary-duration"
                                                    class="px-2 py-0.5 bg-white/5 text-white/50 text-[8px] font-black uppercase tracking-tighter rounded border border-white/10">
                                                    <i class="far fa-clock mr-1"></i> ${not empty selectedMovie ?
                                                    selectedMovie.duration : '--'} Phút
                                                </span>
                                            </div>
                                            <label
                                                class="text-[10px] font-black text-indigo-200/40 uppercase tracking-widest block">Tên
                                                Phim</label>
                                            <p id="summary-movie"
                                                class="text-xl font-black italic leading-tight uppercase tracking-tight">
                                                ${not empty selectedMovie ? selectedMovie.title : '---'}
                                            </p>
                                        </div>
                                    </div>

                                    <div class="grid grid-cols-3 gap-4">
                                        <div class="space-y-2">
                                            <label
                                                class="text-[10px] font-black text-indigo-200/40 uppercase tracking-widest">Ngày
                                                Chiếu</label>
                                            <p id="summary-date" class="text-sm font-black italic">---</p>
                                        </div>
                                        <div class="space-y-2">
                                            <label
                                                class="text-[10px] font-black text-indigo-200/40 uppercase tracking-widest">Giờ
                                                Chiếu</label>
                                            <p id="summary-time" class="text-sm font-black italic">---</p>
                                        </div>
                                        <div class="space-y-2">
                                            <label
                                                class="text-[10px] font-black text-indigo-200/40 uppercase tracking-widest">Phòng</label>
                                            <p id="summary-room" class="text-sm font-black italic">---</p>
                                        </div>
                                    </div>

                                    <div class="border-t-2 border-dashed border-white/10 my-8"></div>

                                    <div class="grid grid-cols-2 gap-6">
                                        <div class="space-y-3">
                                            <label
                                                class="text-[10px] font-black text-indigo-200/40 uppercase tracking-widest">Loại
                                                Vé</label>
                                            <select
                                                class="bg-white/10 border border-white/10 rounded-2xl px-5 py-4 w-full outline-none font-black text-xs uppercase focus:bg-white/20 transition-all"
                                                name="ticketType" required>
                                                <option value="ADULT" class="bg-slate-900">Người lớn</option>
                                                <option value="STUDENT" class="bg-slate-900">Sinh viên</option>
                                                <option value="CHILD" class="bg-slate-900">Trẻ em</option>
                                            </select>
                                        </div>
                                        <div class="space-y-3">
                                            <label
                                                class="text-[10px] font-black text-indigo-200/40 uppercase tracking-widest">Số
                                                lượng</label>
                                            <input id="ticketQty"
                                                class="bg-white/10 border border-white/10 rounded-2xl px-5 py-4 w-full outline-none font-black text-sm text-center focus:bg-white/20 transition-all"
                                                type="number" name="ticketQty" min="1" max="10"
                                                value="${empty ticketQty ? 2 : ticketQty}" required />
                                        </div>
                                    </div>

                                    <div class="bg-white/5 p-8 rounded-[2rem] space-y-6">
                                        <div class="flex justify-between items-center">
                                            <label
                                                class="text-[10px] font-black text-indigo-200 uppercase tracking-widest">Ghế
                                                Đã Chọn</label>
                                            <span
                                                class="px-3 py-1 bg-amber-500 text-black text-[9px] font-black rounded-full"><span
                                                    id="pickedCount">0</span>/<span id="maxCount">0</span> GHẾ</span>
                                        </div>
                                        <div id="summary-seats" class="flex flex-wrap gap-2 min-h-[40px]">
                                            <span class="text-white/20 font-bold italic text-sm">Chưa chọn ghế...</span>
                                        </div>
                                    </div>

                                    <button type="button" id="nextToCombo"
                                        class="w-full bg-amber-500 hover:bg-amber-400 text-black font-black uppercase tracking-widest py-6 rounded-2xl shadow-2xl shadow-amber-500/30 hover:scale-[1.02] active:scale-95 transition-all disabled:opacity-30 disabled:cursor-not-allowed mb-10"
                                        disabled>
                                        <i class="fas fa-arrow-right mr-2"></i> Tiếp tục chọn Combo
                                    </button>

                                    <!-- SECTION 2: BẮP NƯỚC (COMBO) -->
                                    <div id="comboSection" class="hidden space-y-12 animate-fade-in">
                                        <div class="flex items-center justify-center gap-6">
                                            <div
                                                class="w-14 h-14 rounded-2xl bg-amber-500 text-black flex items-center justify-center text-xl font-black italic shadow-lg shadow-amber-500/30">
                                                2</div>
                                            <div class="text-left">
                                                <h2 class="text-2xl font-black uppercase tracking-tight italic">Combo
                                                    Bắp Nước</h2>
                                                <p class="text-slate-500 text-xs font-bold uppercase tracking-widest">
                                                    Thêm hương vị cho buổi xem phim</p>
                                            </div>
                                        </div>

                                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                                            <c:forEach var="c" items="${allCombos}">
                                                <div
                                                    class="glass-card p-6 flex gap-6 hover:border-amber-500/50 transition-all group">
                                                    <div
                                                        class="w-24 h-24 rounded-2xl overflow-hidden bg-slate-900 flex-shrink-0">
                                                        <img src="${pageContext.request.contextPath}/${c.imageUrl}"
                                                            class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
                                                            alt="${c.name}">
                                                    </div>
                                                    <div class="flex-grow text-left flex flex-col justify-between">
                                                        <div>
                                                            <h3 class="font-black italic uppercase text-sm mb-1">
                                                                ${c.name}</h3>
                                                            <p
                                                                class="text-slate-500 text-[10px] leading-relaxed line-clamp-2">
                                                                ${c.description}</p>
                                                        </div>
                                                        <div class="flex items-center justify-between mt-4">
                                                            <span class="text-amber-500 font-black italic text-sm">
                                                                <fmt:formatNumber value="${c.price}" type="currency"
                                                                    currencySymbol="đ" />
                                                            </span>
                                                            <div
                                                                class="flex items-center gap-3 bg-white/5 rounded-xl p-1 border border-white/5">
                                                                <button type="button"
                                                                    class="w-7 h-7 rounded-lg bg-white/5 hover:bg-white/10 flex items-center justify-center text-xs minus-combo"
                                                                    data-id="${c.comboId}">-</button>
                                                                <input type="number" name="combo_${c.comboId}" value="0"
                                                                    min="0"
                                                                    data-price="${c.price}"
                                                                    class="w-8 bg-transparent text-center font-black text-xs outline-none combo-qty"
                                                                    readonly />
                                                                <button type="button"
                                                                    class="w-7 h-7 rounded-lg bg-amber-500 text-black hover:bg-amber-400 flex items-center justify-center text-xs plus-combo"
                                                                    data-id="${c.comboId}">+</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <div class="border-t-2 border-dashed border-white/10 my-8"></div>
                                        
                                        <!-- Tổng Tiền -->
                                        <div class="flex items-center justify-between bg-indigo-900/40 p-6 rounded-2xl border border-indigo-500/30">
                                            <div>
                                                <h3 class="text-sm font-black text-indigo-200 uppercase tracking-widest">Tổng Thanh Toán</h3>
                                                <p class="text-[10px] text-indigo-300/60 mt-1">Đã bao gồm thuế và phụ phí ghế</p>
                                            </div>
                                            <div class="text-right">
                                                <span id="totalPriceUI" class="text-3xl font-black text-white italic tracking-tight">0đ</span>
                                            </div>
                                        </div>

                                        <button type="submit" id="submitBtn"
                                            class="w-full bg-indigo-600 hover:bg-indigo-500 text-white font-black uppercase tracking-widest py-6 rounded-2xl shadow-2xl shadow-indigo-500/30 hover:scale-[1.02] active:scale-95 transition-all">
                                            <i class="fas fa-check-circle mr-2"></i> Xác nhận & Thanh toán
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>

                <jsp:include page="/common/footer.jsp" />

                <script>
                        // Dữ liệu bảng giá ghế động từ Backend
                        window.seatPrices = {
                            <c:forEach var="sp" items="${seatPrices}">
                            '${sp.seatType}': ${sp.surcharge},
                            </c:forEach>
                        };

                        (function () {
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
                                const opt = movieSelect.options[movieSelect.selectedIndex];
                                const movie = opt?.text || "---";
                                const poster = opt?.dataset.poster;
                                const genre = opt?.dataset.genre;
                                const duration = opt?.dataset.duration;

                                const timeText = showtimeSelect.options[showtimeSelect.selectedIndex]?.text || "---";
                                const basePriceStr = showtimeSelect.options[showtimeSelect.selectedIndex]?.dataset.price || "0";
                                const basePrice = parseFloat(basePriceStr);

                                // Update Movie Info
                                document.getElementById('summary-movie').textContent = movie.replace(' (Phim đang chọn)', '');

                                const img = document.getElementById('summary-poster');
                                const placeholder = document.getElementById('poster-placeholder');
                                if (poster) {
                                    img.src = poster;
                                    img.classList.remove('hidden');
                                    placeholder.classList.add('hidden');
                                } else {
                                    img.classList.add('hidden');
                                    placeholder.classList.remove('hidden');
                                }

                                document.getElementById('summary-genre').textContent = genre || '---';
                                document.getElementById('summary-duration').innerHTML = `<i class="far fa-clock mr-1"></i> ${duration || '--'} Phút`;

                                // Update Time and Room
                                document.getElementById('summary-date').textContent = dateInput.value || '---';

                                if (timeText && timeText.includes('|')) {
                                    const parts = timeText.split('|');
                                    document.getElementById('summary-room').textContent = parts[0].trim();
                                    document.getElementById('summary-time').textContent = parts[1].trim();
                                } else {
                                    document.getElementById('summary-room').textContent = "---";
                                    document.getElementById('summary-time').textContent = "---";
                                }
                            }

                            function updateSeatUI() {
                                const checked = Array.from(document.querySelectorAll('input.seat:checked'));
                                const max = parseInt(qtyEl.value) || 0;
                                pickedCount.textContent = checked.length;
                                maxCount.textContent = max;

                                summarySeats.innerHTML = checked.length ? '' : '<span class="text-white/20 font-bold italic text-sm">Chưa chọn ghế...</span>';
                                
                                let totalSeatsPrice = 0;
                                const basePrice = parseFloat(showtimeSelect.options[showtimeSelect.selectedIndex]?.dataset.price || "0");

                                checked.forEach(s => {
                                    // Hiển thị danh sách ghế đã chọn
                                    let typeLabel = '';
                                    const sType = s.dataset.type;
                                    if(sType === 'VIP') typeLabel = '👑 ';
                                    else if(sType === 'COUPLE') typeLabel = '💕 ';
                                    
                                    summarySeats.innerHTML += `<span class="px-3 py-1 bg-white/20 border border-white/10 rounded-lg text-xs font-black text-white italic tracking-tighter">${typeLabel}${s.value}</span>`;
                                    
                                    // Cộng dồn tiền ghế (Giá gốc + phụ phí)
                                    let surcharge = window.seatPrices && window.seatPrices[sType] ? window.seatPrices[sType] : 0;
                                    totalSeatsPrice += (basePrice + surcharge);
                                });

                                document.querySelectorAll('input.seat:not(:checked)').forEach(s => {
                                    const label = document.querySelector(`label[for="${s.id}"]`);
                                    const isOtherSelected = s.dataset.otherSelected === 'true';
                                    const isBooked = s.dataset.booked === 'true';

                                    s.disabled = (checked.length >= max && !s.checked) || isBooked || isOtherSelected;
                                });

                                const nextBtn = document.getElementById('nextToCombo');
                                if (nextBtn) nextBtn.disabled = checked.length === 0 || checked.length > max;

                                // Tính tiền Combo
                                let totalComboPrice = 0;
                                document.querySelectorAll('.combo-qty').forEach(input => {
                                    const qty = parseInt(input.value) || 0;
                                    const price = parseFloat(input.dataset.price || "0");
                                    totalComboPrice += (qty * price);
                                });

                                // Cập nhật UI Tổng tiền
                                const grandTotal = totalSeatsPrice + totalComboPrice;
                                document.getElementById('totalPriceUI').textContent = grandTotal.toLocaleString('vi-VN') + 'đ';
                            }

                            // Handle Step Navigation and Combos
                            document.addEventListener('click', (e) => {
                                if (e.target.id === 'nextToCombo') {
                                    const comboSection = document.getElementById('comboSection');
                                    comboSection.classList.remove('hidden');
                                    e.target.classList.add('hidden');
                                    comboSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
                                }

                                // Handle Combo +/-
                                if (e.target.classList.contains('plus-combo')) {
                                    const input = e.target.parentElement.querySelector('.combo-qty');
                                    input.value = parseInt(input.value) + 1;
                                    updateSeatUI();
                                }
                                if (e.target.classList.contains('minus-combo')) {
                                    const input = e.target.parentElement.querySelector('.combo-qty');
                                    const val = parseInt(input.value);
                                    if (val > 0) {
                                        input.value = val - 1;
                                        updateSeatUI();
                                    }
                                }
                            });

                            // Event Listeners
                            movieSelect.addEventListener('change', async () => {
                                await loadDates();
                                syncSummary();
                            });

                            dateInput.addEventListener('change', async () => {
                                await loadShowtimes();
                                syncSummary();
                            });

                            showtimeSelect.addEventListener('change', async () => {
                                await loadSeats();
                                syncSummary();
                            });

                            qtyEl.addEventListener('input', updateSeatUI);

                            // Functions
                            async function loadDates() {
                                const mId = movieSelect.value;
                                if (!mId) {
                                    dateInput.innerHTML = '<option value="">-- Chọn ngày --</option>';
                                    showtimeSelect.innerHTML = '<option value="">-- Chọn suất --</option>';
                                    return;
                                }

                                dateInput.innerHTML = '<option value="">⏳ Đang tải ngày...</option>';
                                dateInput.disabled = true;

                                try {
                                    const res = await fetch(`${pageContext.request.contextPath}/booking-seat?ajax=dates&movieId=${mId}`);
                                    const data = await res.json();

                                    dateInput.innerHTML = '<option value="">-- Chọn ngày --</option>';
                                    if (data && data.length > 0) {
                                        data.forEach(d => {
                                            dateInput.innerHTML += `<option value="${d}">${d}</option>`;
                                        });
                                        dateInput.disabled = false;
                                        // Auto load showtimes for first date
                                        dateInput.selectedIndex = 1;
                                        await loadShowtimes();
                                    } else {
                                        dateInput.innerHTML = '<option value="">🚫 Hết lịch chiếu</option>';
                                        dateInput.disabled = true;
                                    }
                                } catch (err) {
                                    console.error("Lỗi tải ngày:", err);
                                    dateInput.innerHTML = '<option value="">❌ Lỗi dữ liệu</option>';
                                }

                                // Reset showtimes
                                showtimeSelect.innerHTML = '<option value="">-- Chọn suất --</option>';
                                showtimeSelect.disabled = true;
                            }

                            // Tự động nạp dữ liệu khi trang tải xong (nếu đã có phim chọn sẵn)
                            window.addEventListener('DOMContentLoaded', () => {
                                if (movieSelect.value) {
                                    loadDates();
                                }
                            });

                            async function loadShowtimes() {
                                const mId = movieSelect.value;
                                const date = dateInput.value;
                                if (!mId || !date) return;

                                showtimeSelect.innerHTML = '<option value="">⏳ Đang tải suất chiếu...</option>';
                                showtimeSelect.disabled = true;

                                try {
                                    const res = await fetch(`${pageContext.request.contextPath}/booking-seat?ajax=showtimes&movieId=${mId}&showDate=${date}`);
                                    const data = await res.json();

                                    showtimeSelect.innerHTML = '<option value="">-- Chọn suất --</option>';
                                    if (data && data.length > 0) {
                                        data.forEach(st => {
                                            showtimeSelect.innerHTML += `<option value="${st.id}">${st.room} | ${st.time}</option>`;
                                        });
                                        showtimeSelect.disabled = false;
                                    } else {
                                        showtimeSelect.innerHTML = '<option value="">🚫 Hết suất chiếu ngày này</option>';
                                        showtimeSelect.disabled = true;
                                    }
                                } catch (err) {
                                    console.error("Lỗi tải suất chiếu:", err);
                                    showtimeSelect.innerHTML = '<option value="">❌ Lỗi tải dữ liệu</option>';
                                }

                                seatGrid.innerHTML = '<div class="py-20 opacity-20"><i class="fas fa-couch text-7xl mb-4 block mx-auto"></i><p class="font-black text-xs tracking-widest uppercase">Chọn suất để thấy sơ đồ</p></div>';
                                syncSummary();
                            }

                            async function loadSeats() {
                                const stId = showtimeSelect.value;
                                if (!stId) return;

                                seatGrid.innerHTML = '<div class="py-20"><i class="fas fa-spinner fa-spin text-4xl text-indigo-500 mb-4 block mx-auto"></i><p class="text-xs font-bold animate-pulse text-indigo-300">Đang tải sơ đồ ghế...</p></div>';

                                try {
                                    const res = await fetch(`${pageContext.request.contextPath}/booking-seat?ajax=seats&showtimeId=${stId}`);
                                    const data = await res.json();
                                    renderSeats(data);
                                    initWebSocket(stId);
                                } catch (err) {
                                    console.error("Lỗi tải ghế:", err);
                                    seatGrid.innerHTML = '<p class="text-red-500 font-bold">Lỗi khi nạp sơ đồ ghế.</p>';
                                }
                                syncSummary();
                            }

                            function renderSeats(data) {
                                let html = '<div class="w-full max-w-xl mb-16"><div class="screen-line"></div><span class="text-[9px] font-black text-slate-600 tracking-[1.5em] uppercase">Màn hình trung tâm</span></div>';
                                html += '<div class="flex flex-col items-center gap-5 min-w-[500px]">';
                                
                                if (!data.seats || data.seats.length === 0) {
                                    html += '<p class="text-white/40 italic text-sm">Chưa có sơ đồ ghế cho phòng này.</p></div>';
                                    seatGrid.innerHTML = html;
                                    return;
                                }

                                // Gom nhóm ghế theo Row (A, B, C...)
                                const rowMap = {};
                                data.seats.forEach(s => {
                                    const rowChar = s.code.charAt(0);
                                    if (!rowMap[rowChar]) rowMap[rowChar] = [];
                                    rowMap[rowChar].push(s);
                                });

                                // Render từng hàng
                                Object.keys(rowMap).sort().forEach(r => {
                                    html += `<div class="flex gap-4 items-center"><div class="w-6 text-[10px] font-black text-slate-700">${r}</div><div class="flex gap-3">`;
                                    
                                    const seatsInRow = rowMap[r];
                                    // Sắp xếp ghế theo số
                                    seatsInRow.sort((a,b) => parseInt(a.code.substring(1)) - parseInt(b.code.substring(1)));

                                    seatsInRow.forEach((s, index) => {
                                        const isBooked = data.booked.includes(s.code);
                                        const sid = 's_' + s.code;
                                        
                                        // CSS tùy chỉnh theo loại ghế
                                        let extraClass = '';
                                        if (s.type === 'VIP') {
                                            extraClass = 'border-amber-500/50 text-amber-500 hover:bg-amber-500 hover:text-black';
                                        } else if (s.type === 'COUPLE') {
                                            extraClass = 'border-pink-500/50 text-pink-500 hover:bg-pink-500 hover:text-white w-20'; // Couple thì to hơn
                                        }

                                        html += `<div class="relative">`;
                                        if (isBooked) {
                                            html += `<div class="seat-btn booked" data-type="${s.type}">${s.code.substring(1)}</div>`;
                                        } else {
                                            html += `<input type="checkbox" id="${sid}" name="seats" value="${s.code}" class="hidden seat-check seat" data-booked="false" data-type="${s.type}">
                                                     <label for="${sid}" class="seat-btn ${extraClass}">${s.code.substring(1)}</label>`;
                                        }
                                        html += `</div>`;
                                        
                                        // Khoảng trống (Aisle) mặc định giữa 2 bên nếu mảng > 4 ghế (tạm thời chia 2-6-2 nếu tổng là 10)
                                        // Nếu muốn dùng gridRow/Col thì sẽ set CSS grid sau, hiện tại dùng flex wrap gap
                                        if (seatsInRow.length === 10 && (index === 1 || index === 7)) {
                                            html += `<div class="w-4"></div>`;
                                        }
                                    });
                                    html += `</div><div class="w-6 text-[10px] font-black text-slate-700 text-right">${r}</div></div>`;
                                });
                                html += '</div>';
                                seatGrid.innerHTML = html;

                                document.querySelectorAll('input.seat').forEach(s => {
                                    s.addEventListener('change', () => {
                                        const label = document.querySelector(`label[for="${s.id}"]`);
                                        if (s.checked) label.classList.add('selected');
                                        else label.classList.remove('selected');
                                        updateSeatUI();
                                        if (socket && socket.readyState === WebSocket.OPEN) socket.send(showtimeSelect.value + ':' + s.value + ':' + (s.checked ? 'select' : 'deselect'));
                                    });
                                });
                                updateSeatUI();
                            }

                            function initWebSocket(stId) {
                                if (socket) socket.close();
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

                            // Initial Sync & Load
                            syncSummary();
                            if (showtimeSelect.value) {
                                loadSeats();
                            } else if (dateInput.value) {
                                loadShowtimes();
                            } else if (movieSelect.value) {
                                loadDates();
                            }
                        })();
                </script>
            </body>

            </html>