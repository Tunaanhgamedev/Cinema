<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="bg-slate-100 dark:bg-slate-900/50 border-t border-slate-200 dark:border-white/5 pt-20 pb-10 transition-colors duration-500">
    <div class="max-w-7xl mx-auto px-6">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12 mb-20">
            
            <!-- Column 1 -->
            <div class="space-y-6">
                <h3 class="text-xs font-black uppercase tracking-[0.3em] text-indigo-500">BOBIXI Việt Nam</h3>
                <ul class="space-y-4">
                    <li><a href="#" class="text-sm font-bold text-slate-600 dark:text-slate-400 hover:text-indigo-500 transition-colors">Giới Thiệu</a></li>
                    <li><a href="#" class="text-sm font-bold text-slate-600 dark:text-slate-400 hover:text-indigo-500 transition-colors">Tiện Ích Online</a></li>
                    <li><a href="#" class="text-sm font-bold text-slate-600 dark:text-slate-400 hover:text-indigo-500 transition-colors">Thẻ Quà Tặng</a></li>
                    <li><a href="#" class="text-sm font-bold text-slate-600 dark:text-slate-400 hover:text-indigo-500 transition-colors">Tuyển Dụng</a></li>
                </ul>
            </div>

            <!-- Column 2 -->
            <div class="space-y-6">
                <h3 class="text-xs font-black uppercase tracking-[0.3em] text-indigo-500">Điều khoản sử dụng</h3>
                <ul class="space-y-4">
                    <li><a href="${pageContext.request.contextPath}/pages/terms/terms.jsp" class="text-sm font-bold text-slate-600 dark:text-slate-400 hover:text-indigo-500 transition-colors">Điều Khoản Chung</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/terms/term-payment.jsp" class="text-sm font-bold text-slate-600 dark:text-slate-400 hover:text-indigo-500 transition-colors">Điều Khoản Giao Dịch</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/terms/payment-policy.jsp" class="text-sm font-bold text-slate-600 dark:text-slate-400 hover:text-indigo-500 transition-colors">Chính Sách Thanh Toán</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/terms/privacy-policy.jsp" class="text-sm font-bold text-slate-600 dark:text-slate-400 hover:text-indigo-500 transition-colors">Chính Sách Bảo Mật</a></li>
                </ul>
            </div>

            <!-- Column 3 -->
            <div class="space-y-6">
                <h3 class="text-xs font-black uppercase tracking-[0.3em] text-indigo-500">Kết nối với chúng tôi</h3>
                <div class="flex items-center gap-4">
                    <a href="#" class="w-10 h-10 rounded-xl bg-white dark:bg-white/5 flex items-center justify-center shadow-sm hover:scale-110 transition-transform">
                        <img src="${pageContext.request.contextPath}/assets/images/home/facebook.png" class="w-5 h-5">
                    </a>
                    <a href="#" class="w-10 h-10 rounded-xl bg-white dark:bg-white/5 flex items-center justify-center shadow-sm hover:scale-110 transition-transform">
                        <img src="${pageContext.request.contextPath}/assets/images/home/tiktok.png" class="w-5 h-5">
                    </a>
                    <a href="#" class="w-10 h-10 rounded-xl bg-white dark:bg-white/5 flex items-center justify-center shadow-sm hover:scale-110 transition-transform">
                        <img src="${pageContext.request.contextPath}/assets/images/home/instagram.png" class="w-5 h-5">
                    </a>
                    <a href="#" class="w-10 h-10 rounded-xl bg-white dark:bg-white/5 flex items-center justify-center shadow-sm hover:scale-110 transition-transform">
                        <img src="${pageContext.request.contextPath}/assets/images/home/zalo.png" class="w-5 h-5">
                    </a>
                </div>
            </div>

            <!-- Column 4 -->
            <div class="space-y-6">
                <h3 class="text-xs font-black uppercase tracking-[0.3em] text-indigo-500">Chăm sóc khách hàng</h3>
                <div class="space-y-3">
                    <p class="text-sm font-bold text-slate-700 dark:text-slate-300">Hotline: <span class="text-indigo-500">1900 1111</span></p>
                    <p class="text-xs font-medium text-slate-500">Giờ làm việc: 8:00 - 22:00 (Cả CN & Lễ)</p>
                    <p class="text-xs font-medium text-slate-500">Email: hoidap@bobixi.vn</p>
                </div>
            </div>
        </div>

        <!-- Divider -->
        <div class="h-px w-full bg-slate-200 dark:bg-white/5 mb-10"></div>

        <!-- Bottom Area -->
        <div class="flex flex-col lg:flex-row justify-between items-center gap-6">
            <div class="text-center lg:text-left space-y-2">
                <p class="text-xs font-black uppercase tracking-widest text-slate-800 dark:text-white">CÔNG TY TNHH DA BOBIXI VIỆT NAM</p>
                <p class="text-[10px] font-bold text-slate-500 uppercase tracking-wider">© 2025 BOBIXI Cinemas Việt Nam. All rights reserved.</p>
            </div>
            <div class="flex items-center gap-4">
                <div class="px-4 py-2 bg-slate-200 dark:bg-white/5 rounded-lg text-[10px] font-black text-slate-600 dark:text-slate-400 uppercase tracking-tighter">
                    Địa chỉ: Đà Nẵng, Việt Nam
                </div>
            </div>
        </div>
    </div>
</footer>

"