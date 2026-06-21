<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<jsp:include page="/common/header.jsp" />

<div class="bg-[#0a0f1a] min-h-screen text-slate-200 font-['Outfit']">
    <!-- Cinema Hero Header -->
    <div class="relative h-[550px] overflow-hidden group">
        <div class="absolute inset-0">
            <img src="https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?q=80&w=2070&auto=format&fit=crop" 
                 alt="${cinema.name}" 
                 class="w-full h-full object-cover brightness-[0.3] group-hover:scale-105 transition-transform duration-[2000ms]" />
            <div class="absolute inset-0 bg-gradient-to-t from-[#0a0f1a] via-[#0a0f1a]/60 to-transparent"></div>
        </div>
        
        <div class="relative h-full max-w-7xl mx-auto px-6 flex flex-col justify-end pb-24">
            <div class="flex flex-wrap gap-4 mb-8">
                <c:if test="${cinema.hasIMAX}"><span class="px-5 py-2 bg-blue-600/20 text-blue-400 border border-blue-500/30 rounded-2xl text-xs font-black tracking-[0.2em] uppercase shadow-[0_0_20px_rgba(37,99,235,0.2)]">IMAX TECHNOLOGY</span></c:if>
                <c:if test="${cinema.has4DX}"><span class="px-5 py-2 bg-red-600/20 text-red-400 border border-red-500/30 rounded-2xl text-xs font-black tracking-[0.2em] uppercase shadow-[0_0_20px_rgba(220,38,38,0.2)]">4DX EXPERIENCE</span></c:if>
                <span class="px-5 py-2 bg-white/5 text-white border border-white/10 rounded-2xl text-xs font-black tracking-[0.2em] uppercase">DOLBY ATMOS</span>
            </div>
            <h1 class="text-6xl md:text-8xl font-black text-white mb-6 tracking-tighter uppercase italic leading-[0.9]">
                <span class="text-primary">BOBIXI</span><br/>${cinema.name != null ? cinema.name : "PREMIUM CINEMA"}
            </h1>
            <div class="flex flex-wrap items-center gap-8 text-slate-400 font-bold uppercase tracking-widest text-sm">
                <p class="flex items-center gap-3">
                    <i class="fas fa-location-dot text-primary text-xl"></i> ${cinema.address != null ? cinema.address : "Địa chỉ đang cập nhật"}
                </p>
                <p class="flex items-center gap-3">
                    <i class="fas fa-star text-amber-500 text-xl"></i> 4.9 (2,500+ Reviews)
                </p>
            </div>
        </div>
    </div>

    <!-- Features Quick Bar -->
    <div class="max-w-7xl mx-auto px-6 -mt-16 relative z-10">
        <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
            <div class="glass-effect p-6 rounded-[2rem] border border-white/5 flex flex-col items-center text-center group hover:bg-primary/10 transition-all">
                <i class="fas fa-couch text-2xl text-primary mb-3 group-hover:scale-110 transition-transform"></i>
                <span class="text-[10px] font-black uppercase tracking-widest text-slate-500">Ghế ngồi</span>
                <p class="text-sm font-bold text-white">Da cao cấp</p>
            </div>
            <div class="glass-effect p-6 rounded-[2rem] border border-white/5 flex flex-col items-center text-center group hover:bg-primary/10 transition-all">
                <i class="fas fa-volume-high text-2xl text-primary mb-3 group-hover:scale-110 transition-transform"></i>
                <span class="text-[10px] font-black uppercase tracking-widest text-slate-500">Âm thanh</span>
                <p class="text-sm font-bold text-white">Dolby Atmos 7.1</p>
            </div>
            <div class="glass-effect p-6 rounded-[2rem] border border-white/5 flex flex-col items-center text-center group hover:bg-primary/10 transition-all">
                <i class="fas fa-burger text-2xl text-primary mb-3 group-hover:scale-110 transition-transform"></i>
                <span class="text-[10px] font-black uppercase tracking-widest text-slate-500">Dịch vụ</span>
                <p class="text-sm font-bold text-white">Quầy bắp nước VIP</p>
            </div>
            <div class="glass-effect p-6 rounded-[2rem] border border-white/5 flex flex-col items-center text-center group hover:bg-primary/10 transition-all">
                <i class="fas fa-square-p text-2xl text-primary mb-3 group-hover:scale-110 transition-transform"></i>
                <span class="text-[10px] font-black uppercase tracking-widest text-slate-500">Bãi đỗ xe</span>
                <p class="text-sm font-bold text-white">Rộng rãi & Miễn phí</p>
            </div>
        </div>
    </div>

    <!-- Sticky Internal Navigation -->
    <div class="sticky top-20 z-[40] bg-[#0a0f1a]/90 backdrop-blur-2xl border-b border-white/5 hidden md:block shadow-xl">
        <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-center gap-2">
            <a href="#overview" class="px-6 h-full flex items-center text-xs font-black tracking-[0.2em] text-slate-400 hover:text-white transition-all uppercase border-b-2 border-transparent hover:border-primary/50">TỔNG QUAN</a>
            <a href="#facilities" class="px-6 h-full flex items-center text-xs font-black tracking-[0.2em] text-slate-400 hover:text-white transition-all uppercase border-b-2 border-transparent hover:border-primary/50">TIỆN ÍCH</a>
            <a href="#pricing" class="px-6 h-full flex items-center text-xs font-black tracking-[0.2em] text-slate-400 hover:text-white transition-all uppercase border-b-2 border-transparent hover:border-primary/50">GIÁ VÉ</a>
            <a href="#location" class="px-6 h-full flex items-center text-xs font-black tracking-[0.2em] text-slate-400 hover:text-white transition-all uppercase border-b-2 border-transparent hover:border-primary/50">VỊ TRÍ</a>
        </div>
    </div>

    <div class="max-w-7xl mx-auto px-6 py-24 space-y-48">
        <!-- Introduction & Overview -->
        <section id="overview" class="scroll-mt-40 grid grid-cols-1 lg:grid-cols-3 gap-20">
            <div class="lg:col-span-2 space-y-10">
                <div class="space-y-6">
                    <h2 class="text-4xl md:text-5xl font-black text-white italic uppercase tracking-tighter leading-tight">Trải nghiệm điện ảnh đỉnh cao</h2>
                    <div class="h-1.5 w-24 bg-primary rounded-full shadow-[0_0_15px_rgba(229,9,20,0.5)]"></div>
                    <p class="text-xl text-slate-400 leading-relaxed font-medium">
                        ${cinema.description != null ? cinema.description : "Chào mừng bạn đến với hệ thống rạp chiếu phim hiện đại nhất. Chúng tôi cam kết mang lại những giây phút giải trí tuyệt vời với công nghệ màn hình sắc nét và hệ thống âm thanh vòm sống động đến từng chi tiết."}
                    </p>
                </div>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                    <div class="p-10 bg-white/5 rounded-[3rem] border border-white/5 group hover:bg-white/10 transition-all">
                        <h4 class="text-primary font-black text-xs tracking-widest uppercase mb-4">THÔNG TIN LIÊN HỆ</h4>
                        <div class="space-y-4">
                            <div class="flex items-center gap-4">
                                <div class="w-10 h-10 rounded-xl bg-white/5 flex items-center justify-center text-slate-400"><i class="fas fa-phone"></i></div>
                                <p class="text-lg font-bold text-white">${cinema.phone != null ? cinema.phone : "1900 6017"}</p>
                            </div>
                            <div class="flex items-center gap-4">
                                <div class="w-10 h-10 rounded-xl bg-white/5 flex items-center justify-center text-slate-400"><i class="fas fa-clock"></i></div>
                                <p class="text-lg font-bold text-white">${cinema.openingHours != null ? cinema.openingHours : "08:00 - 24:00"}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="space-y-8 flex flex-col justify-center">
                <div class="p-8 bg-gradient-to-br from-primary/10 to-transparent rounded-[3rem] border border-white/5">
                    <h4 class="text-white font-black text-sm uppercase tracking-widest mb-4 italic">Tiêu chuẩn quốc tế</h4>
                    <p class="text-slate-400 text-sm font-medium leading-relaxed">BOBIXI Premium tự hào là hệ thống rạp chiếu phim đạt chuẩn quốc tế đầu tiên tại khu vực, mang đến không gian giải trí đẳng cấp cho mọi lứa tuổi.</p>
                </div>
            </div>
        </section>
 
        <!-- Cinema Facilities Showcase -->
        <section id="facilities" class="scroll-mt-40 space-y-20">
            <div class="text-center space-y-4">
                <p class="text-primary font-black tracking-[0.4em] uppercase text-xs">ULTIMATE EXPERIENCE</p>
                <h2 class="text-5xl md:text-7xl font-black text-white italic tracking-tighter uppercase leading-none">Tiện ích<br/><span class="text-slate-600">vượt trội</span></h2>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-12 gap-10">
                <!-- Left: Facility Cards Grid -->
                <div class="lg:col-span-7 grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="group p-8 bg-white/5 rounded-[2.5rem] border border-white/5 hover:border-primary/30 transition-all hover:-translate-y-2 duration-500">
                        <div class="w-14 h-14 bg-primary/10 rounded-2xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
                            <i class="fas fa-couch text-2xl text-primary"></i>
                        </div>
                        <h4 class="text-xl font-bold text-white mb-3">Ghế ngồi Premium</h4>
                        <p class="text-slate-400 text-sm leading-relaxed">Hệ thống ghế da cao cấp, có khả năng điều chỉnh độ ngả lưng hoàn hảo, mang lại sự thoải mái tuyệt đối.</p>
                    </div>

                    <div class="group p-8 bg-white/5 rounded-[2.5rem] border border-white/5 hover:border-blue-500/30 transition-all hover:-translate-y-2 duration-500">
                        <div class="w-14 h-14 bg-blue-500/10 rounded-2xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
                            <i class="fas fa-volume-high text-2xl text-blue-500"></i>
                        </div>
                        <h4 class="text-xl font-bold text-white mb-3">Âm thanh Dolby Atmos</h4>
                        <p class="text-slate-400 text-sm leading-relaxed">Công nghệ âm thanh vòm 360 độ sống động, chân thực đến từng tiếng động nhỏ nhất.</p>
                    </div>

                    <div class="group p-8 bg-white/5 rounded-[2.5rem] border border-white/5 hover:border-yellow-500/30 transition-all hover:-translate-y-2 duration-500">
                        <div class="w-14 h-14 bg-yellow-500/10 rounded-2xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
                            <i class="fas fa-tv text-2xl text-yellow-500"></i>
                        </div>
                        <h4 class="text-xl font-bold text-white mb-3">Màn hình 4K HDR</h4>
                        <p class="text-slate-400 text-sm leading-relaxed">Độ phân giải cực cao cùng độ tương phản tuyệt vời, tái hiện màu sắc rực rỡ và sắc nét.</p>
                    </div>

                    <div class="group p-8 bg-white/5 rounded-[2.5rem] border border-white/5 hover:border-green-500/30 transition-all hover:-translate-y-2 duration-500">
                        <div class="w-14 h-14 bg-green-500/10 rounded-2xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
                            <i class="fas fa-burger text-2xl text-green-500"></i>
                        </div>
                        <h4 class="text-xl font-bold text-white mb-3">Dịch vụ F&B VIP</h4>
                        <p class="text-slate-400 text-sm leading-relaxed">Thực đơn bắp nước đa dạng, phục vụ tận chỗ cho khách hàng tại các phòng chiếu Premium.</p>
                    </div>
                </div>

                <!-- Right: Large Image / Feature Highlight -->
                <div class="lg:col-span-5 flex flex-col gap-6">
                    <div class="flex-1 relative rounded-[3rem] overflow-hidden border border-white/10 group">
                        <img src="https://images.unsplash.com/photo-1517604401157-538a9663ec02?q=80&w=2070&auto=format&fit=crop" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110 brightness-75">
                        <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent flex flex-col justify-end p-10">
                            <span class="text-primary font-black text-xs tracking-widest uppercase mb-2">Space Design</span>
                            <h3 class="text-3xl font-black text-white italic uppercase leading-none">Kiến trúc sang trọng</h3>
                        </div>
                    </div>
                    
                    <div class="p-8 bg-gradient-to-br from-primary/20 to-transparent rounded-[2.5rem] border border-primary/20">
                        <div class="flex items-center gap-6">
                            <div class="flex -space-x-4">
                                <div class="w-12 h-12 rounded-full border-2 border-[#0a0f1a] bg-slate-800 flex items-center justify-center font-bold text-xs">J</div>
                                <div class="w-12 h-12 rounded-full border-2 border-[#0a0f1a] bg-slate-700 flex items-center justify-center font-bold text-xs">M</div>
                                <div class="w-12 h-12 rounded-full border-2 border-[#0a0f1a] bg-primary flex items-center justify-center font-bold text-xs">+99</div>
                            </div>
                            <div>
                                <p class="text-white font-bold text-sm">Hàng ngàn khán giả đã trải nghiệm</p>
                                <p class="text-slate-500 text-xs font-medium italic">"Chất lượng rạp tốt nhất tôi từng đi!"</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Pricing Section - Professional Table -->
        <section id="pricing" class="scroll-mt-40 bg-white/5 rounded-[5rem] p-16 md:p-24 border border-white/5 relative overflow-hidden">
            <div class="absolute top-0 right-0 w-[500px] h-[500px] bg-primary/5 blur-[150px] -mr-64 -mt-64"></div>
            
            <div class="relative z-10 space-y-16">
                <div class="text-center space-y-4">
                    <p class="text-primary font-black tracking-[0.4em] uppercase text-xs">PRICING PLANS</p>
                    <h2 class="text-5xl md:text-7xl font-black text-white italic tracking-tighter uppercase leading-none">Bảng giá vé<br/><span class="text-slate-600">niêm yết</span></h2>
                </div>

                <div class="grid grid-cols-1 gap-12">
                    <c:forEach items="${cinema.pricingTables}" var="priceTable">
                        <div class="space-y-8">
                            <h3 class="text-2xl font-black text-white border-l-4 border-primary pl-6 italic uppercase tracking-widest">${priceTable.name}</h3>
                            <div class="overflow-hidden rounded-[3rem] border border-white/5 bg-white/5 backdrop-blur-sm shadow-2xl">
                                <table class="w-full text-left border-collapse">
                                    <thead>
                                        <tr class="bg-white/10">
                                            <th class="px-10 py-8 text-xs font-black text-slate-400 uppercase tracking-widest">Loại ghế</th>
                                            <th class="px-10 py-8 text-xs font-black text-slate-400 uppercase tracking-widest text-right">Giá vé (VNĐ)</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-white/5">
                                        <c:forEach items="${priceTable.rows}" var="row">
                                            <tr class="hover:bg-white/5 transition-colors group">
                                                <td class="px-10 py-8">
                                                    <span class="text-lg font-bold text-white group-hover:text-primary transition-colors">${row.seatType}</span>
                                                </td>
                                                <td class="px-10 py-8 text-right">
                                                    <span class="text-2xl font-black text-white italic">
                                                        <fmt:formatNumber value="${row.prices[0]}" type="number" />
                                                    </span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <div class="p-8 bg-primary/10 rounded-3xl border border-primary/20 text-center">
                    <p class="text-sm text-primary font-bold italic">Lưu ý: Giá vé có thể thay đổi vào các ngày Lễ, Tết và các suất chiếu đặc biệt.</p>
                </div>
            </div>
        </section>

        <!-- Location & Map Section -->
        <section id="location" class="scroll-mt-40 space-y-16">
            <div class="flex flex-col md:flex-row justify-between items-end gap-8">
                <div class="space-y-4">
                    <p class="text-primary font-black tracking-[0.3em] uppercase text-xs">FIND US</p>
                    <h2 class="text-5xl md:text-7xl font-black text-white italic tracking-tighter uppercase leading-[1.1]">Vị trí<br/><span class="text-slate-600">tại Đà Nẵng</span></h2>
                </div>
                <button onclick="openGoogleMaps()" class="px-10 py-5 bg-white text-black font-black rounded-full hover:bg-primary hover:text-white transition-all flex items-center gap-3 group shadow-2xl active:scale-95">
                    <i class="fas fa-map-location-dot text-xl group-hover:bounce"></i>
                    CHỈ ĐƯỜNG TRÊN GOOGLE MAPS
                </button>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-10">
                <div class="lg:col-span-2 rounded-[4rem] overflow-hidden border border-white/5 h-[600px] relative shadow-2xl group bg-slate-900">
                    <!-- Standard Embed Map (Stable, no API key needed) -->
                    <iframe 
                        width="100%" 
                        height="100%" 
                        frameborder="0" 
                        style="border:0; filter: grayscale(1) invert(0.9) contrast(1.2) opacity(0.8);" 
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3834.020224168016!2d108.1482113758368!3d16.064464139556813!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314219299401777d%3A0xe54d9c79e6079c6d!2zODIgTmd1eeG7hW4gTMawxqFuZyBC4bqbmcsIEhvw6AgS2jDoW5oIELhuq9jLCBMacOqbiBDaGnhu4N1LCDEkMOgIE7hurVuZyA1NTAwMDAsIFZpZXNuYW0!5e0!3m2!1sen!2s!4v1714850000000!5m2!1sen!2s" 
                        allowfullscreen="" 
                        loading="lazy" 
                        referrerpolicy="no-referrer-when-downgrade">
                    </iframe>
                    <div class="absolute inset-0 pointer-events-none border-[20px] border-[#0a0f1a] rounded-[4rem]"></div>
                </div>
                
                <div class="space-y-8">
                    <div class="p-10 bg-white/5 rounded-[3rem] border border-white/5 flex flex-col justify-between h-full">
                        <div class="space-y-8">
                            <div class="space-y-4">
                                <c:choose>
                                    <c:when test="${not empty cinema.busDirections}">
                                        <h4 class="text-white font-black text-sm uppercase tracking-widest italic">Phương tiện công cộng</h4>
                                        <p class="text-slate-400 font-medium leading-relaxed">${cinema.busDirections}</p>
                                    </c:when>
                                    <c:otherwise>
                                        <h4 class="text-white font-black text-sm uppercase tracking-widest italic">Phương tiện công cộng</h4>
                                        <p class="text-slate-400 font-medium leading-relaxed">Các tuyến xe buýt đi qua điểm dừng Nguyễn Lương Bằng.</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="space-y-4">
                                <c:choose>
                                    <c:when test="${not empty cinema.carDirections}">
                                        <h4 class="text-white font-black text-sm uppercase tracking-widest italic">Đậu xe & Lối vào</h4>
                                        <p class="text-slate-400 font-medium leading-relaxed">${cinema.carDirections}</p>
                                    </c:when>
                                    <c:otherwise>
                                        <h4 class="text-white font-black text-sm uppercase tracking-widest italic">Đậu xe & Lối vào</h4>
                                        <p class="text-slate-400 font-medium leading-relaxed">Khu vực đậu xe miễn phí dành cho khách hàng xem phim.</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="pt-10 border-t border-white/5">
                            <p class="text-5xl font-black text-white italic opacity-10">BOBIXI</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Final CTA -->
        <section class="py-20 text-center space-y-12 bg-gradient-to-b from-transparent to-primary/5 rounded-[5rem]">
            <h2 class="text-5xl md:text-7xl font-black text-white italic uppercase tracking-tighter leading-none">Bạn đã sẵn sàng để<br/><span class="text-primary italic">thưởng thức siêu phẩm?</span></h2>
            <p class="text-xl text-slate-400 font-medium">Đặt vé ngay hôm nay để nhận được vị trí ngồi tốt nhất và trải nghiệm dịch vụ đẳng cấp tại BOBIXI Cinema.</p>
            <div class="flex flex-wrap justify-center gap-6">
                <a href="${pageContext.request.contextPath}/movie" class="px-12 py-5 bg-primary rounded-full text-white font-black text-lg hover:scale-110 transition-all shadow-2xl shadow-primary/30 tracking-widest uppercase">ĐẶT VÉ NGAY</a>
                <a href="${pageContext.request.contextPath}/movie" class="px-12 py-5 bg-white/5 text-white border border-white/10 rounded-full font-black text-lg hover:bg-white/10 transition-all tracking-widest uppercase">XEM DANH SÁCH PHIM</a>
            </div>
        </section>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />

<style>
    .glass-effect {
        background: rgba(255, 255, 255, 0.03);
        backdrop-filter: blur(10px);
    }
    
    html {
        scroll-behavior: smooth;
    }
    
    .scrollbar-hide::-webkit-scrollbar {
        display: none;
    }

    /* Active Nav Styling */
    .sticky a:active {
        color: white;
        border-bottom-color: #e50914;
    }
</style>

<script>
    function openGoogleMaps() {
        const url = 'https://www.google.com/maps/dir//16.0644,108.1482';
        window.open(url, '_blank');
    }
</script>
