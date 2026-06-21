<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
    @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap');
    body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #0f172a; }
    .nav-link-active { background: linear-gradient(135deg, #6366f1 0%, #a855f7 100%); box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.4); }
    .glass-effect { background: rgba(255, 255, 255, 0.03); backdrop-filter: blur(10px); border: 1px solid rgba(255, 255, 255, 0.05); }
    .sidebar-gradient { background: linear-gradient(180deg, #1e293b 0%, #0f172a 100%); }
</style>

<div class="fixed inset-y-0 left-0 w-72 sidebar-gradient border-r border-slate-800 z-50 transition-all duration-300 transform">
    <div class="flex flex-col h-full">
        <!-- Brand Header -->
        <div class="p-8 flex items-center gap-3">
            <div class="w-10 h-10 bg-indigo-600 rounded-xl flex items-center justify-center shadow-lg shadow-indigo-500/20">
                <i class="fas fa-film text-white text-xl"></i>
            </div>
            <div>
                <h1 class="text-white font-extrabold text-xl tracking-tight">BOBIXI</h1>
                <p class="text-slate-500 text-[10px] font-bold uppercase tracking-widest">Admin Control</p>
            </div>
        </div>

        <!-- Navigation -->
        <nav class="flex-1 px-4 py-4 space-y-2 overflow-y-auto">
            <p class="px-4 text-[11px] font-bold text-slate-500 uppercase tracking-widest mb-4">Main Menu</p>
            
            <a href="${pageContext.request.contextPath}/admin" 
               class="flex items-center gap-3 px-4 py-3.5 rounded-xl transition-all duration-200 group ${param.activeTab == 'dashboard' ? 'nav-link-active text-white' : 'text-slate-400 hover:bg-slate-800/50 hover:text-white'}">
                <i class="fas fa-chart-line text-lg w-6 ${param.activeTab == 'dashboard' ? 'text-white' : 'group-hover:text-indigo-400'}"></i>
                <span class="font-semibold text-sm">Dashboard</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/movies" 
               class="flex items-center gap-3 px-4 py-3.5 rounded-xl transition-all duration-200 group ${param.activeTab == 'movies' ? 'nav-link-active text-white' : 'text-slate-400 hover:bg-slate-800/50 hover:text-white'}">
                <i class="fas fa-film text-lg w-6 ${param.activeTab == 'movies' ? 'text-white' : 'group-hover:text-indigo-400'}"></i>
                <span class="font-semibold text-sm">Quản lý Phim</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/showtimes" 
               class="flex items-center gap-3 px-4 py-3.5 rounded-xl transition-all duration-200 group ${param.activeTab == 'showtimes' ? 'nav-link-active text-white' : 'text-slate-400 hover:bg-slate-800/50 hover:text-white'}">
                <i class="fas fa-calendar-alt text-lg w-6 ${param.activeTab == 'showtimes' ? 'text-white' : 'group-hover:text-indigo-400'}"></i>
                <span class="font-semibold text-sm">Lịch chiếu</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/bookings" 
               class="flex items-center gap-3 px-4 py-3.5 rounded-xl transition-all duration-200 group ${param.activeTab == 'bookings' ? 'nav-link-active text-white' : 'text-slate-400 hover:bg-slate-800/50 hover:text-white'}">
                <i class="fas fa-ticket-alt text-lg w-6 ${param.activeTab == 'bookings' ? 'text-white' : 'group-hover:text-indigo-400'}"></i>
                <span class="font-semibold text-sm">Đơn hàng</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/combos" 
               class="flex items-center gap-3 px-4 py-3.5 rounded-xl transition-all duration-200 group ${param.activeTab == 'combos' ? 'nav-link-active text-white' : 'text-slate-400 hover:bg-slate-800/50 hover:text-white'}">
                <i class="fas fa-hamburger text-lg w-6 ${param.activeTab == 'combos' ? 'text-white' : 'group-hover:text-indigo-400'}"></i>
                <span class="font-semibold text-sm">Quản lý Combo</span>
            </a>

            <div class="pt-8">
                <p class="px-4 text-[11px] font-bold text-slate-500 uppercase tracking-widest mb-4">System</p>
                
                <a href="${pageContext.request.contextPath}/home" 
                   class="flex items-center gap-3 px-4 py-3.5 rounded-xl text-slate-400 hover:bg-slate-800/50 hover:text-white transition-all duration-200 group">
                    <i class="fas fa-external-link-alt text-lg w-6 group-hover:text-emerald-400"></i>
                    <span class="font-semibold text-sm">Về Web Client</span>
                </a>

                <a href="${pageContext.request.contextPath}/admin/logout" 
                   class="flex items-center gap-3 px-4 py-3.5 rounded-xl text-rose-400 hover:bg-rose-500/10 hover:text-rose-300 transition-all duration-200 group">
                    <i class="fas fa-sign-out-alt text-lg w-6"></i>
                    <span class="font-semibold text-sm">Đăng xuất</span>
                </a>
            </div>
        </nav>

        <!-- User Profile Minimal -->
        <div class="p-6">
            <div class="flex items-center gap-3 p-4 rounded-2xl glass-effect">
                <div class="w-10 h-10 rounded-full bg-slate-700 border-2 border-slate-600 flex items-center justify-center text-white font-bold">
                    AD
                </div>
                <div class="overflow-hidden">
                    <p class="text-white text-sm font-bold truncate">Administrator</p>
                    <p class="text-slate-500 text-[11px] truncate">admin@bobixi.vn</p>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .main-content { margin-left: 288px; padding: 40px; }
</style>
