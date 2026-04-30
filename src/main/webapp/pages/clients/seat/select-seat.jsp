<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Link Google Fonts & FontAwesome -->
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://cdn.tailwindcss.com"></script>

<style>
    body { font-family: 'Outfit', sans-serif; background-color: #0f172a; color: #f8fafc; }
    .cinema-screen {
        height: 60px;
        width: 100%;
        background: linear-gradient(to bottom, rgba(99, 102, 241, 0.4), transparent);
        border-top: 3px solid #6366f1;
        border-radius: 50% 50% 0 0 / 100% 100% 0 0;
        margin-bottom: 60px;
        filter: drop-shadow(0 -10px 15px rgba(99, 102, 241, 0.3));
    }
    .seat-container {
        display: inline-grid;
        grid-template-columns: repeat(auto-fit, minmax(36px, 1fr));
        gap: 12px;
        padding: 40px;
        background: rgba(30, 41, 59, 0.5);
        border-radius: 32px;
        border: 1px solid rgba(255, 255, 255, 0.05);
        backdrop-filter: blur(10px);
    }
    .seat-box {
        position: relative;
        width: 38px;
        height: 38px;
        cursor: pointer;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }
    .seat-box .seat-icon {
        width: 100%;
        height: 100%;
        background: #334155;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 10px;
        font-weight: 800;
        color: rgba(255, 255, 255, 0.2);
        border: 1px solid rgba(255, 255, 255, 0.05);
    }
    .seat-box:hover:not(.BOOKED) .seat-icon {
        background: #475569;
        transform: translateY(-4px);
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.3);
        color: white;
    }
    .seat-box.NORMAL .seat-icon { border-bottom: 3px solid #475569; }
    .seat-box.VIP .seat-icon { border-bottom: 3px solid #fbbf24; background: rgba(251, 191, 36, 0.1); color: #fbbf24; }
    .seat-box.BOOKED { cursor: not-allowed; opacity: 0.3; }
    .seat-box.BOOKED .seat-icon { background: #1e293b; color: transparent; border: none; }
    .seat-box.SELECTED .seat-icon { 
        background: #6366f1 !important; 
        color: white !important; 
        border-bottom: 3px solid #4f46e5 !important;
        box-shadow: 0 0 20px rgba(99, 102, 241, 0.4);
    }
    .legend-item { display: flex; align-items: center; gap: 10px; font-size: 12px; font-weight: 600; color: #94a3b8; }
    .legend-box { width: 16px; height: 16px; border-radius: 4px; }
</style>

<div class="max-w-6xl mx-auto py-12 px-4">
    <div class="text-center mb-16">
        <h2 class="text-5xl font-black text-white mb-4 tracking-tighter">Chọn vị trí ngồi</h2>
        <p class="text-slate-400">Vui lòng chọn chỗ ngồi bạn yêu thích để tận hưởng bộ phim.</p>
    </div>

    <div class="flex flex-col items-center">
        <!-- Screen -->
        <div class="w-full max-w-3xl">
            <div class="cinema-screen"></div>
            <p class="text-center text-[10px] font-black tracking-[0.3em] uppercase text-indigo-400 -mt-10 mb-20">MÀN HÌNH CHÍNH</p>
        </div>

        <!-- Legend -->
        <div class="flex flex-wrap justify-center gap-8 mb-16 px-8 py-4 bg-white/5 rounded-2xl border border-white/5">
            <div class="legend-item"><div class="legend-box bg-[#334155]"></div> Ghế thường</div>
            <div class="legend-item"><div class="legend-box bg-[#fbbf24]/20 border border-[#fbbf24]"></div> Ghế VIP</div>
            <div class="legend-item"><div class="legend-box bg-[#6366f1]"></div> Đang chọn</div>
            <div class="legend-item"><div class="legend-box bg-[#1e293b] opacity-30"></div> Đã bán</div>
        </div>

        <form action="${pageContext.request.contextPath}/booking" method="post" class="w-full">
            <input type="hidden" name="showtimeId" value="${showtimeId}" />
            
            <div class="flex justify-center mb-16">
                <div class="grid gap-x-3 gap-y-4" style="grid-template-columns: repeat(12, 1fr);">
                    <c:forEach var="s" items="${seats}">
                        <c:set var="isBooked" value="${bookedSeats.contains(s.seatId)}" />
                        
                        <div class="seat-box ${s.seatType} ${isBooked ? 'BOOKED' : ''}" 
                             id="seat-${s.seatId}"
                             onclick="toggleSeat(this, '${s.seatId}')">
                            <div class="seat-icon">
                                ${s.seatRow}${s.seatNumber}
                            </div>
                            <c:if test="${!isBooked}">
                                <input type="checkbox" name="seatIds" value="${s.seatId}" id="check-${s.seatId}" class="hidden">
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div class="flex justify-between items-center p-8 bg-slate-900 border border-white/5 rounded-3xl sticky bottom-8 shadow-2xl backdrop-blur-xl">
                <div>
                    <p class="text-slate-500 text-xs font-black uppercase tracking-widest mb-1">Ghế đã chọn</p>
                    <div id="selected-list" class="text-white font-bold text-xl flex gap-2">
                        <span class="text-slate-600 italic font-normal text-sm">Chưa chọn ghế</span>
                    </div>
                </div>
                <button type="submit" id="btn-submit" disabled 
                        class="bg-indigo-600 opacity-50 cursor-not-allowed hover:bg-indigo-500 text-white font-black py-4 px-12 rounded-2xl transition-all shadow-lg shadow-indigo-600/20 flex items-center gap-3">
                    Tiếp tục đặt vé <i class="fas fa-arrow-right"></i>
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    function toggleSeat(el, id) {
        if (el.classList.contains('BOOKED')) return;
        
        const checkbox = document.getElementById('check-' + id);
        checkbox.checked = !checkbox.checked;
        el.classList.toggle('SELECTED');
        
        updateSummary();
    }

    function updateSummary() {
        const selected = document.querySelectorAll('.seat-box.SELECTED');
        const listDiv = document.getElementById('selected-list');
        const btn = document.getElementById('btn-submit');
        
        if (selected.length > 0) {
            const names = Array.from(selected).map(el => el.innerText.trim());
            listDiv.innerHTML = names.join(', ');
            btn.disabled = false;
            btn.classList.remove('opacity-50', 'cursor-not-allowed');
        } else {
            listDiv.innerHTML = '<span class="text-slate-600 italic font-normal text-sm">Chưa chọn ghế</span>';
            btn.disabled = true;
            btn.classList.add('opacity-50', 'cursor-not-allowed');
        }
    }
</script>
