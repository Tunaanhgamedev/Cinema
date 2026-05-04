<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
if (session.getAttribute("authUser") == null) {
	response.sendRedirect(request.getContextPath() + "/login?returnUrl=/account");
	return;
}
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Tài khoản của tôi | BOBIXI Cinema</title>
    
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Google Fonts: Outfit -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Outfit', 'sans-serif'],
                    },
                    colors: {
                        primary: '#e71a0f',
                        'primary-dark': '#c4160d',
                        'dark-bg': '#0a0f1a',
                        'card-bg': 'rgba(17, 24, 39, 0.7)',
                    }
                }
            }
        }
    </script>
    
    <style>
        body { background-color: #0a0f1a; }
        .glass-effect {
            background: rgba(17, 24, 39, 0.7);
            backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.08);
        }
        .menu-item-active {
            background: linear-gradient(to right, #e71a0f, #ff4d4d);
            color: white !important;
            box-shadow: 0 10px 20px -5px rgba(231, 26, 15, 0.4);
        }
        .shimmer {
            background-size: 200% 100%;
            animation: shimmer 2s infinite linear;
        }
        @keyframes shimmer {
            0% { background-position: 200% 0; }
            100% { background-position: -200% 0; }
        }
        .content-section { display: none; }
        .content-section.active { display: block; animation: slideUp 0.4s ease-out; }
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body class="text-slate-200 font-sans antialiased">

    <!-- Background Decoration -->
    <div class="fixed top-0 left-0 w-full h-full -z-10 overflow-hidden">
        <div class="absolute top-[-10%] right-[-10%] w-[40%] h-[40%] rounded-full bg-primary/10 blur-[120px]"></div>
        <div class="absolute bottom-[-10%] left-[-10%] w-[40%] h-[40%] rounded-full bg-blue-600/10 blur-[120px]"></div>
    </div>

    <div class="max-w-7xl mx-auto px-4 py-12 md:py-20">
        <!-- Header -->
        <div class="mb-12">
            <h1 class="text-4xl md:text-5xl font-black tracking-tight bg-gradient-to-r from-white to-slate-500 bg-clip-text text-transparent">
                Tài khoản của tôi
            </h1>
            <p class="text-slate-400 mt-2">Quản lý thông tin, ưu đãi và lịch sử trải nghiệm điện ảnh.</p>
        </div>

        <div class="flex flex-col lg:flex-row gap-8">
            
            <!-- SIDEBAR -->
            <aside class="lg:w-80 shrink-0">
                <div class="glass-effect rounded-[2.5rem] p-8 sticky top-8">
                    <!-- Profile Brief -->
                    <div class="text-center mb-8">
                        <div class="relative inline-block group">
                            <div class="w-24 h-24 rounded-3xl bg-gradient-to-tr from-primary to-rose-400 p-[3px] shadow-2xl shadow-primary/20 transition-transform duration-500 group-hover:rotate-6">
                                <div class="w-full h-full rounded-[1.3rem] bg-slate-900 flex items-center justify-center text-4xl font-black text-white">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.authUser.fullName}">
                                            ${sessionScope.authUser.fullName.substring(0,1)}
                                        </c:when>
                                        <c:otherwise>
                                            ${sessionScope.authUser.email.substring(0,1)}
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="absolute -bottom-2 -right-2 w-8 h-8 rounded-xl bg-white text-slate-900 flex items-center justify-center shadow-lg border-2 border-slate-900">
                                <i class="fas fa-camera text-xs"></i>
                            </div>
                        </div>
                        
                        <h3 class="text-xl font-bold mt-6 text-white truncate px-2">
                            <c:out value="${sessionScope.authUser.fullName}" />
                        </h3>
                        <p class="text-slate-400 text-sm mt-1 truncate">
                            <c:out value="${sessionScope.authUser.email}" />
                        </p>
                        
                        <span class="inline-block mt-4 px-4 py-1.5 rounded-xl bg-white/5 border border-white/10 text-[10px] font-black uppercase tracking-widest text-primary">
                            <c:out value="${sessionScope.authUser.role}" /> Member
                        </span>
                    </div>

                    <!-- Navigation Menu -->
                    <nav class="space-y-2">
                        <a href="#overview" onclick="showSection('overview'); return false;" 
                           class="menu-btn flex items-center gap-4 px-6 py-4 rounded-2xl text-slate-400 hover:text-white hover:bg-white/5 transition-all group active-btn" data-section="overview">
                            <i class="fas fa-th-large w-5 group-hover:scale-110 transition-transform"></i>
                            <span class="font-semibold">Tổng quan</span>
                        </a>
                        <a href="#history" onclick="showSection('history'); return false;" 
                           class="menu-btn flex items-center gap-4 px-6 py-4 rounded-2xl text-slate-400 hover:text-white hover:bg-white/5 transition-all group" data-section="history">
                            <i class="fas fa-history w-5 group-hover:scale-110 transition-transform"></i>
                            <span class="font-semibold">Lịch sử đặt vé</span>
                        </a>
                        <a href="#vouchers" onclick="showSection('vouchers'); return false;" 
                           class="menu-btn flex items-center gap-4 px-6 py-4 rounded-2xl text-slate-400 hover:text-white hover:bg-white/5 transition-all group" data-section="vouchers">
                            <i class="fas fa-ticket-alt w-5 group-hover:scale-110 transition-transform"></i>
                            <span class="font-semibold">Kho Voucher</span>
                        </a>
                        <a href="#profile" onclick="showSection('profile'); return false;" 
                           class="menu-btn flex items-center gap-4 px-6 py-4 rounded-2xl text-slate-400 hover:text-white hover:bg-white/5 transition-all group" data-section="profile">
                            <i class="fas fa-user-edit w-5 group-hover:scale-110 transition-transform"></i>
                            <span class="font-semibold">Thông tin cá nhân</span>
                        </a>
                        <a href="#settings" onclick="showSection('settings'); return false;" 
                           class="menu-btn flex items-center gap-4 px-6 py-4 rounded-2xl text-slate-400 hover:text-white hover:bg-white/5 transition-all group" data-section="settings">
                            <i class="fas fa-bell w-5 group-hover:scale-110 transition-transform"></i>
                            <span class="font-semibold">Thông báo</span>
                        </a>
                        
                        <div class="pt-4 mt-4 border-t border-white/5">
                            <a href="${pageContext.request.contextPath}/logout" class="flex items-center gap-4 px-6 py-4 rounded-2xl text-rose-400 hover:bg-rose-500/10 transition-all group">
                                <i class="fas fa-sign-out-alt w-5"></i>
                                <span class="font-semibold">Đăng xuất</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/home" class="flex items-center gap-4 px-6 py-4 rounded-2xl text-slate-500 hover:text-white transition-all group">
                                <i class="fas fa-home w-5"></i>
                                <span class="font-semibold">Trang chủ</span>
                            </a>
                        </div>
                    </nav>
                </div>
            </aside>

            <!-- MAIN CONTENT AREA -->
            <main class="flex-1">
                <div class="glass-effect rounded-[2.5rem] p-8 md:p-12 min-h-[600px]">
                    
                    <!-- Feedback Messages -->
                    <c:if test="${not empty param.success || not empty param.error}">
                        <div class="mb-8">
                            <c:if test="${not empty param.success}">
                                <div class="p-4 rounded-2xl bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 flex items-center gap-3">
                                    <i class="fas fa-check-circle"></i>
                                    <span class="text-sm font-medium">Thao tác thành công!</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty param.error}">
                                <div class="p-4 rounded-2xl bg-rose-500/10 border border-rose-500/20 text-rose-400 flex items-center gap-3">
                                    <i class="fas fa-exclamation-circle"></i>
                                    <span class="text-sm font-medium">Đã có lỗi xảy ra. Vui lòng thử lại.</span>
                                </div>
                            </c:if>
                        </div>
                    </c:if>

                    <!-- OVERVIEW SECTION -->
                    <div id="overview-section" class="content-section active">
                        <h2 class="text-3xl font-bold mb-8 text-white">Tổng quan</h2>
                        
                        <!-- Premium Loyalty Card -->
                        <div class="relative group cursor-pointer mb-12">
                            <div class="absolute -inset-1 bg-gradient-to-r from-primary to-rose-500 rounded-[2rem] blur opacity-25 group-hover:opacity-50 transition duration-1000"></div>
                            <div class="relative h-64 w-full rounded-[2rem] overflow-hidden flex flex-col p-8 text-white ${sessionScope.authUser.membershipLevel == 'PLATINUM' ? 'bg-gradient-to-br from-slate-900 via-slate-800 to-indigo-900' : (sessionScope.authUser.membershipLevel == 'GOLD' ? 'bg-gradient-to-br from-amber-600 via-amber-400 to-yellow-600' : 'bg-gradient-to-br from-slate-800 to-slate-900')}">
                                <!-- Card Decorative Circles -->
                                <div class="absolute top-0 right-0 w-64 h-64 bg-white/5 rounded-full -translate-y-1/2 translate-x-1/2 blur-3xl"></div>
                                
                                <div class="flex justify-between items-start z-10">
                                    <div class="space-y-1">
                                        <p class="text-[10px] font-black tracking-[0.3em] uppercase opacity-60">BOBIXI LOYALTY</p>
                                        <p class="text-2xl font-black italic tracking-tighter">PREMIUM PASS</p>
                                    </div>
                                    <div class="px-4 py-1.5 rounded-full bg-white/10 backdrop-blur-md border border-white/20 text-[10px] font-black tracking-widest uppercase">
                                        ${not empty sessionScope.authUser.membershipLevel ? sessionScope.authUser.membershipLevel : 'BRONZE'}
                                    </div>
                                </div>

                                <div class="mt-auto z-10 flex justify-between items-end">
                                    <div>
                                        <p class="text-[10px] font-bold opacity-50 uppercase tracking-widest mb-1">Số dư điểm</p>
                                        <div class="flex items-baseline gap-2">
                                            <span class="text-5xl font-black leading-none tracking-tighter">
                                                <fmt:formatNumber value="${sessionScope.authUser.loyaltyPoints}" pattern="#,###" />
                                            </span>
                                            <span class="text-xs font-bold opacity-60 uppercase">PTS</span>
                                        </div>
                                    </div>
                                    <div class="text-right">
                                        <p class="text-sm font-bold uppercase tracking-widest opacity-80">${sessionScope.authUser.fullName}</p>
                                        <div class="mt-2 flex justify-end">
                                            <div class="w-12 h-8 rounded-lg bg-gradient-to-tr from-yellow-200 to-yellow-500 opacity-80 shadow-inner"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Info Bento Grid -->
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div class="p-6 rounded-3xl bg-white/5 border border-white/5 hover:bg-white/10 transition-all">
                                <p class="text-[10px] font-bold text-slate-500 uppercase tracking-widest mb-2">Số điện thoại</p>
                                <p class="text-lg font-bold text-white">${not empty sessionScope.authUser.phoneNumber ? sessionScope.authUser.phoneNumber : '—'}</p>
                            </div>
                            <div class="p-6 rounded-3xl bg-white/5 border border-white/5 hover:bg-white/10 transition-all">
                                <p class="text-[10px] font-bold text-slate-500 uppercase tracking-widest mb-2">Ngày sinh</p>
                                <p class="text-lg font-bold text-white">
                                    <fmt:formatDate value="${sessionScope.authUser.dateOfBirth}" pattern="dd/MM/yyyy" />
                                </p>
                            </div>
                            <div class="p-6 rounded-3xl bg-white/5 border border-white/5 hover:bg-white/10 transition-all col-span-1 md:col-span-2">
                                <p class="text-[10px] font-bold text-slate-500 uppercase tracking-widest mb-2">Địa chỉ</p>
                                <p class="text-lg font-bold text-white truncate">${not empty sessionScope.authUser.address ? sessionScope.authUser.address : '—'}</p>
                            </div>
                        </div>
                    </div>

                    <!-- BOOKING HISTORY SECTION -->
                    <div id="history-section" class="content-section">
                        <h2 class="text-3xl font-bold mb-8 text-white">Lịch sử đặt vé</h2>
                        <jsp:include page="/pages/clients/account/booking-history-fragment.jsp" />
                    </div>

                    <!-- VOUCHERS SECTION -->
                    <div id="vouchers-section" class="content-section">
                        <div class="flex justify-between items-end mb-8">
                            <h2 class="text-3xl font-bold text-white mb-0">Đổi quà ưu đãi</h2>
                            <div class="px-4 py-2 rounded-2xl bg-primary/10 border border-primary/20 text-primary font-bold text-sm">
                                Số dư: <fmt:formatNumber value="${sessionScope.authUser.loyaltyPoints}" pattern="#,###" /> PTS
                            </div>
                        </div>
                        
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
                            <!-- Voucher Card 1 -->
                            <div class="p-6 rounded-[2rem] bg-white/5 border border-white/10 text-center flex flex-col group">
                                <div class="w-16 h-16 rounded-full bg-primary/20 text-primary flex items-center justify-center mx-auto mb-4 text-2xl group-hover:scale-110 transition-transform">
                                    <i class="fas fa-ticket-alt"></i>
                                </div>
                                <h3 class="font-bold text-white mb-2">Voucher 20k</h3>
                                <p class="text-xs text-slate-500 mb-6 flex-1">Giảm ngay 20.000đ cho mọi đơn hàng.</p>
                                <div class="text-xl font-black text-white mb-6">500 <span class="text-[10px] font-bold text-slate-500">PTS</span></div>
                                <form action="${pageContext.request.contextPath}/account/redeem" method="post">
                                    <input type="hidden" name="rewardId" value="1">
                                    <button type="submit" class="w-full py-3 rounded-2xl bg-white text-slate-900 font-black text-sm hover:bg-primary hover:text-white transition-all disabled:opacity-30" ${sessionScope.authUser.loyaltyPoints < 500 ? 'disabled' : ''}>
                                        ĐỔI NGAY
                                    </button>
                                </form>
                            </div>
                            <!-- Voucher Card 2 -->
                            <div class="p-6 rounded-[2rem] bg-gradient-to-br from-amber-500/20 to-transparent border border-amber-500/20 text-center flex flex-col group">
                                <div class="w-16 h-16 rounded-full bg-amber-500/20 text-amber-500 flex items-center justify-center mx-auto mb-4 text-2xl group-hover:scale-110 transition-transform">
                                    <i class="fas fa-star"></i>
                                </div>
                                <h3 class="font-bold text-white mb-2">Voucher 50k</h3>
                                <p class="text-xs text-slate-500 mb-6 flex-1">Siêu ưu đãi giảm ngay 50.000đ.</p>
                                <div class="text-xl font-black text-white mb-6">1,000 <span class="text-[10px] font-bold text-slate-500">PTS</span></div>
                                <form action="${pageContext.request.contextPath}/account/redeem" method="post">
                                    <input type="hidden" name="rewardId" value="2">
                                    <button type="submit" class="w-full py-3 rounded-2xl bg-amber-500 text-slate-900 font-black text-sm hover:brightness-110 transition-all disabled:opacity-30" ${sessionScope.authUser.loyaltyPoints < 1000 ? 'disabled' : ''}>
                                        ĐỔI NGAY
                                    </button>
                                </form>
                            </div>
                            <!-- Voucher Card 3 -->
                            <div class="p-6 rounded-[2rem] bg-gradient-to-br from-indigo-500/20 to-transparent border border-indigo-500/20 text-center flex flex-col group">
                                <div class="w-16 h-16 rounded-full bg-indigo-500/20 text-indigo-400 flex items-center justify-center mx-auto mb-4 text-2xl group-hover:scale-110 transition-transform">
                                    <i class="fas fa-crown"></i>
                                </div>
                                <h3 class="font-bold text-white mb-2">Voucher 100k</h3>
                                <p class="text-xs text-slate-500 mb-6 flex-1">Đặc quyền Premium giảm hẳn 100.000đ.</p>
                                <div class="text-xl font-black text-white mb-6">2,000 <span class="text-[10px] font-bold text-slate-500">PTS</span></div>
                                <form action="${pageContext.request.contextPath}/account/redeem" method="post">
                                    <input type="hidden" name="rewardId" value="3">
                                    <button type="submit" class="w-full py-3 rounded-2xl bg-indigo-500 text-white font-black text-sm hover:brightness-110 transition-all disabled:opacity-30" ${sessionScope.authUser.loyaltyPoints < 2000 ? 'disabled' : ''}>
                                        ĐỔI NGAY
                                    </button>
                                </form>
                            </div>
                        </div>

                        <hr class="border-white/5 mb-12">

                        <h2 class="text-3xl font-bold text-white mb-8">Ví Voucher của tôi</h2>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <c:forEach var="v" items="${myVouchers}">
                                <div class="relative flex bg-white rounded-3xl overflow-hidden group cursor-pointer hover:shadow-2xl hover:shadow-primary/10 transition-all duration-500">
                                    <div class="w-1/3 bg-primary p-6 flex flex-col items-center justify-center text-white border-r-2 border-dashed border-slate-900/10">
                                        <div class="text-3xl font-black leading-none">
                                            <c:choose>
                                                <c:when test="${v.discountType == 'PERCENT'}">${v.discountValue.intValue()}%</c:when>
                                                <c:otherwise><fmt:formatNumber value="${v.discountValue}" pattern="#,###" />đ</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <span class="text-[10px] font-black uppercase tracking-widest mt-2 opacity-80">GIẢM GIÁ</span>
                                    </div>
                                    <div class="flex-1 p-6 text-slate-900 relative">
                                        <h4 class="font-bold text-lg mb-1">Voucher Đặc Quyền</h4>
                                        <div class="bg-slate-100 px-3 py-1.5 rounded-xl inline-flex items-center gap-2 mb-4" onclick="copyVoucher('${v.code}')">
                                            <span class="text-xs font-mono font-bold text-primary">${v.code}</span>
                                            <i class="fas fa-copy text-[10px] text-slate-400"></i>
                                        </div>
                                        <div class="text-[10px] font-bold text-slate-400 uppercase">Hạn dùng đến</div>
                                        <p class="text-xs font-bold text-slate-600"><fmt:formatDate value="${v.validTo}" pattern="dd/MM/yyyy" /></p>
                                        
                                        <!-- Punch hole decorations -->
                                        <div class="absolute -left-3 top-1/2 -translate-y-1/2 w-6 h-6 rounded-full bg-[#111827]"></div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- PROFILE SECTION -->
                    <div id="profile-section" class="content-section">
                        <h2 class="text-3xl font-bold mb-8 text-white">Thông tin cá nhân</h2>
                        <form action="${pageContext.request.contextPath}/account/update" method="post" class="space-y-6">
                            <div class="space-y-2">
                                <label class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Họ và tên *</label>
                                <input type="text" name="fullName" value="${sessionScope.authUser.fullName}" required 
                                       class="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white outline-none focus:border-primary transition-all" />
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div class="space-y-2">
                                    <label class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Email (Không thể thay đổi)</label>
                                    <input type="email" value="${sessionScope.authUser.email}" readonly 
                                           class="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-slate-500 outline-none cursor-not-allowed" />
                                </div>
                                <div class="space-y-2">
                                    <label class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Số điện thoại</label>
                                    <input type="tel" name="phoneNumber" value="${sessionScope.authUser.phoneNumber}" 
                                           class="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white outline-none focus:border-primary transition-all" />
                                </div>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div class="space-y-2">
                                    <label class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Ngày sinh</label>
                                    <input type="date" name="dateOfBirth" value="<fmt:formatDate value='${sessionScope.authUser.dateOfBirth}' pattern='yyyy-MM-dd'/>" 
                                           class="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white outline-none focus:border-primary transition-all" />
                                </div>
                                <div class="space-y-2">
                                    <label class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Giới tính</label>
                                    <select name="gender" class="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white outline-none focus:border-primary transition-all appearance-none">
                                        <option value="" class="bg-slate-900">-- Chọn --</option>
                                        <option value="MALE" ${sessionScope.authUser.gender == 'MALE' ? 'selected' : ''} class="bg-slate-900">Nam</option>
                                        <option value="FEMALE" ${sessionScope.authUser.gender == 'FEMALE' ? 'selected' : ''} class="bg-slate-900">Nữ</option>
                                        <option value="OTHER" ${sessionScope.authUser.gender == 'OTHER' ? 'selected' : ''} class="bg-slate-900">Khác</option>
                                    </select>
                                </div>
                            </div>

                            <div class="space-y-2">
                                <label class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Địa chỉ</label>
                                <textarea name="address" rows="3" class="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white outline-none focus:border-primary transition-all">${sessionScope.authUser.address}</textarea>
                            </div>

                            <div class="pt-6">
                                <button type="submit" class="px-10 py-4 bg-primary rounded-2xl text-white font-black text-sm hover:bg-primary-dark transition-all shadow-xl shadow-primary/20">
                                    LƯU THAY ĐỔI
                                </button>
                            </div>
                        </form>

                        <div class="mt-20 pt-12 border-t border-white/5">
                            <h3 class="text-2xl font-bold text-white mb-8">Bảo mật</h3>
                            <form action="${pageContext.request.contextPath}/account/change-password" method="post" class="space-y-6">
                                <div class="space-y-2">
                                    <label class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Mật khẩu hiện tại</label>
                                    <input type="password" name="currentPassword" required class="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white outline-none focus:border-primary transition-all" />
                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div class="space-y-2">
                                        <label class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Mật khẩu mới</label>
                                        <input type="password" name="newPassword" required class="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white outline-none focus:border-primary transition-all" />
                                    </div>
                                    <div class="space-y-2">
                                        <label class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Xác nhận mật khẩu mới</label>
                                        <input type="password" name="confirmPassword" required class="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white outline-none focus:border-primary transition-all" />
                                    </div>
                                </div>
                                <div class="pt-4">
                                    <button type="submit" class="px-10 py-4 bg-slate-100 rounded-2xl text-slate-900 font-black text-sm hover:bg-white transition-all shadow-xl shadow-white/5">
                                        ĐỔI MẬT KHẨU
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- SETTINGS SECTION -->
                    <div id="settings-section" class="content-section">
                        <h2 class="text-3xl font-bold mb-8 text-white">Nhận thông báo</h2>
                        <form action="${pageContext.request.contextPath}/account/settings" method="post" class="space-y-8">
                            <label class="flex items-center gap-4 group cursor-pointer">
                                <div class="relative w-12 h-6 bg-slate-800 rounded-full transition-colors border border-white/10">
                                    <input type="checkbox" name="subscribeNewsletter" class="peer hidden" ${sessionScope.authUser.subscribeNewsletter ? 'checked' : ''} />
                                    <div class="absolute left-1 top-1 w-4 h-4 bg-slate-400 rounded-full transition-all peer-checked:translate-x-6 peer-checked:bg-primary"></div>
                                </div>
                                <span class="text-slate-300 font-semibold group-hover:text-white transition-colors">Nhận email khuyến mãi / tin tức (Newsletter)</span>
                            </label>

                            <label class="flex items-center gap-4 group cursor-pointer">
                                <div class="relative w-12 h-6 bg-slate-800 rounded-full transition-colors border border-white/10">
                                    <input type="checkbox" name="subscribeSMS" class="peer hidden" ${sessionScope.authUser.subscribeSMS ? 'checked' : ''} />
                                    <div class="absolute left-1 top-1 w-4 h-4 bg-slate-400 rounded-full transition-all peer-checked:translate-x-6 peer-checked:bg-primary"></div>
                                </div>
                                <span class="text-slate-300 font-semibold group-hover:text-white transition-colors">Nhận SMS thông báo</span>
                            </label>

                            <div class="pt-8">
                                <button type="submit" class="px-10 py-4 bg-primary rounded-2xl text-white font-black text-sm hover:bg-primary-dark transition-all shadow-xl shadow-primary/20">
                                    LƯU CÀI ĐẶT
                                </button>
                            </div>
                        </form>
                    </div>

                </div>
            </main>
        </div>
    </div>

    <script>
        function showSection(sectionId) {
            // Update menu visual
            document.querySelectorAll('.menu-btn').forEach(btn => {
                btn.classList.remove('menu-item-active', 'text-white', 'bg-white/5');
                btn.classList.add('text-slate-400');
                if(btn.dataset.section === sectionId) {
                    btn.classList.add('menu-item-active');
                    btn.classList.remove('text-slate-400');
                }
            });

            // Update content display
            document.querySelectorAll('.content-section').forEach(section => {
                section.classList.remove('active');
            });
            const target = document.getElementById(sectionId + '-section');
            if (target) target.classList.add('active');

            // Save state
            history.pushState(null, null, '#' + sectionId);
        }

        function copyVoucher(code) {
            navigator.clipboard.writeText(code).then(() => {
                const notification = document.createElement('div');
                notification.className = 'fixed bottom-8 right-8 bg-emerald-500 text-white px-6 py-3 rounded-2xl font-bold shadow-2xl z-50 animate-bounce';
                notification.innerText = 'Đã sao chép mã voucher!';
                document.body.appendChild(notification);
                setTimeout(() => notification.remove(), 2000);
            });
        }

        // Initialize from URL hash
        window.onload = () => {
            const hash = window.location.hash ? window.location.hash.substring(1) : 'overview';
            showSection(hash);
        };
    </script>

</body>
</html>
