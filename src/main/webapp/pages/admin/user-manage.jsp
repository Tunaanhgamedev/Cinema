<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Người dùng | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-style.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        accent: '#6366f1',
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-[#0f172a] text-slate-200">

<div class="admin-layout">
    <jsp:include page="/common/admin/sidebar.jsp" />

    <div class="main-content">
        <div class="flex justify-between items-center mb-12">
            <div>
                <h1 class="text-4xl font-extrabold tracking-tight text-white mb-2">Quản lý Người dùng</h1>
                <p class="text-slate-400">Xem và quản lý danh sách thành viên của hệ thống.</p>
            </div>
            <div class="flex gap-4">
                <div class="bg-white/5 border border-white/10 px-6 py-3 rounded-2xl flex items-center gap-3">
                    <i class="fas fa-users text-indigo-400"></i>
                    <div>
                        <div class="text-[10px] text-slate-500 font-bold uppercase tracking-widest">Tổng thành viên</div>
                        <div class="text-xl font-black text-white">${userList.size()}</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card-glass overflow-hidden">
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="text-slate-500 text-[10px] font-black uppercase tracking-[2px] border-b border-white/5 bg-white/5">
                            <th class="px-8 py-5">THÀNH VIÊN</th>
                            <th class="px-8 py-5">SỐ ĐIỆN THOẠI</th>
                            <th class="px-8 py-5">VAI TRÒ</th>
                            <th class="px-8 py-5">HẠNG THÀNH VIÊN</th>
                            <th class="px-8 py-5">ĐIỂM TÍCH LŨY</th>
                            <th class="px-8 py-5 text-right">HÀNH ĐỘNG</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-white/5">
                        <c:forEach var="u" items="${userList}">
                            <tr class="hover:bg-white/5 transition-colors group">
                                <td class="px-8 py-5">
                                    <div class="flex items-center gap-4">
                                        <div class="w-10 h-10 rounded-xl bg-indigo-600/20 flex items-center justify-center text-indigo-400 border border-indigo-500/20">
                                            <i class="fas fa-user"></i>
                                        </div>
                                        <div>
                                            <div class="font-bold text-white text-base mb-1">${u.fullName}</div>
                                            <div class="text-slate-500 text-xs">${u.email}</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-8 py-5 text-slate-300 font-medium">
                                    ${u.phoneNumber != null ? u.phoneNumber : '---'}
                                </td>
                                <td class="px-8 py-5">
                                    <c:choose>
                                        <c:when test="${u.role == 'ADMIN'}">
                                            <span class="px-3 py-1 bg-rose-500/10 text-rose-500 border border-rose-500/20 rounded-full text-[10px] font-black uppercase tracking-wider">
                                                Quản trị viên
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="px-3 py-1 bg-indigo-500/10 text-indigo-400 border border-indigo-500/20 rounded-full text-[10px] font-black uppercase tracking-wider">
                                                Người dùng
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-8 py-5">
                                    <c:set var="tierColor" value="text-slate-400 bg-slate-400/10 border-slate-400/20" />
                                    <c:if test="${u.membershipLevel == 'SILVER'}"><c:set var="tierColor" value="text-slate-300 bg-slate-300/10 border-slate-300/20" /></c:if>
                                    <c:if test="${u.membershipLevel == 'GOLD'}"><c:set var="tierColor" value="text-yellow-500 bg-yellow-500/10 border-yellow-500/20" /></c:if>
                                    <c:if test="${u.membershipLevel == 'PLATINUM'}"><c:set var="tierColor" value="text-indigo-400 bg-indigo-400/10 border-indigo-400/20" /></c:if>
                                    
                                    <span class="px-3 py-1 rounded-full text-[10px] font-black uppercase tracking-wider border ${tierColor}">
                                        ${u.membershipLevel}
                                    </span>
                                </td>
                                <td class="px-8 py-5">
                                    <div class="text-white font-bold">${u.loyaltyPoints} <span class="text-slate-500 text-[10px] font-black ml-1 uppercase">Points</span></div>
                                </td>
                                <td class="px-8 py-5 text-right">
                                    <div class="flex justify-end gap-3">
                                        <button class="w-9 h-9 rounded-lg bg-indigo-500/10 text-indigo-400 flex items-center justify-center hover:bg-indigo-500 hover:text-white transition-all" title="Xem chi tiết">
                                            <i class="fas fa-eye text-xs"></i>
                                        </button>
                                        <form action="${pageContext.request.contextPath}/admin/users" method="POST" class="inline" onsubmit="return confirm('Bạn có chắc muốn xóa người dùng này?')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="userId" value="${u.userId}">
                                            <button class="w-9 h-9 rounded-lg bg-rose-500/10 text-rose-500 flex items-center justify-center hover:bg-rose-500 hover:text-white transition-all" title="Xóa">
                                                <i class="fas fa-trash-alt text-xs"></i>
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
