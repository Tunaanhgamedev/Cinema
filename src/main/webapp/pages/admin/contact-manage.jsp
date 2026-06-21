<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hòm thư Liên hệ | Admin Cinema</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-[#0f172a] text-slate-200">

<jsp:include page="/common/admin-sidebar.jsp">
    <jsp:param name="activeTab" value="contacts" />
</jsp:include>

<div class="main-content min-h-screen">
    <!-- Header Section -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-6 mb-10">
        <div>
            <h1 class="text-3xl font-black text-white tracking-tight">Hòm thư Góp ý</h1>
            <p class="text-slate-400 mt-1">Lắng nghe ý kiến và hỗ trợ khách hàng BOBIXI Cinema.</p>
        </div>
        <div class="flex items-center gap-3">
            <span class="px-4 py-2 bg-indigo-500/10 text-indigo-400 rounded-xl text-xs font-black uppercase tracking-widest border border-indigo-500/20">
                0 Tin nhắn mới
            </span>
        </div>
    </div>

    <!-- Inbox Layout -->
    <div class="glass-effect rounded-[2.5rem] border border-slate-800 shadow-2xl overflow-hidden flex flex-col md:flex-row min-h-[600px]">
        <!-- Sidebar: Inbox Filter -->
        <div class="w-full md:w-72 border-r border-slate-800 p-6 space-y-2 bg-slate-900/30">
            <button class="w-full text-left px-4 py-3 rounded-xl bg-indigo-600 text-white font-bold flex items-center gap-3 transition-all">
                <i class="fas fa-inbox"></i>
                <span>Hộp thư đến</span>
            </button>
            <button class="w-full text-left px-4 py-3 rounded-xl text-slate-400 hover:bg-slate-800 hover:text-white font-bold flex items-center gap-3 transition-all">
                <i class="fas fa-star"></i>
                <span>Quan trọng</span>
            </button>
            <button class="w-full text-left px-4 py-3 rounded-xl text-slate-400 hover:bg-slate-800 hover:text-white font-bold flex items-center gap-3 transition-all">
                <i class="fas fa-paper-plane"></i>
                <span>Đã trả lời</span>
            </button>
            <button class="w-full text-left px-4 py-3 rounded-xl text-slate-400 hover:bg-slate-800 hover:text-white font-bold flex items-center gap-3 transition-all">
                <i class="fas fa-trash"></i>
                <span>Thùng rác</span>
            </button>
        </div>

        <!-- Main: Message List / Content -->
        <div class="flex-1 flex flex-col items-center justify-center p-12 text-center bg-slate-900/10 relative">
            <div class="absolute inset-0 opacity-5 pointer-events-none flex items-center justify-center">
                <i class="fas fa-envelope-open-text text-[20rem]"></i>
            </div>
            
            <div class="relative z-10 max-w-md">
                <div class="w-24 h-24 bg-slate-800 rounded-full flex items-center justify-center text-slate-600 text-4xl mx-auto mb-8 border border-slate-700">
                    <i class="fas fa-comments"></i>
                </div>
                <h3 class="text-2xl font-black text-white mb-4">Mọi thứ đều yên tĩnh...</h3>
                <p class="text-slate-500 leading-relaxed font-medium">
                    Tính năng quản lý phản hồi đang được hoàn thiện. 
                    Chúng tôi đang kết nối hệ thống hòm thư để bạn có thể phản hồi khách hàng ngay tại đây.
                </p>
                <div class="mt-10 flex gap-4 justify-center">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" 
                       class="px-8 py-4 bg-slate-800 hover:bg-slate-700 text-white font-black rounded-2xl transition-all uppercase tracking-widest text-[11px] border border-slate-700">
                        Về Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
