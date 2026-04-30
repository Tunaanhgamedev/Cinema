<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Ý kiến khách hàng | Admin</title>
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
                <h1 class="text-4xl font-extrabold tracking-tight text-white mb-2">Ý kiến khách hàng</h1>
                <p class="text-slate-400">Lắng nghe và phản hồi các đóng góp từ người xem phim.</p>
            </div>
            <div class="card-glass px-6 py-3 flex items-center gap-3 border-sky-500/20 bg-sky-500/5">
                <i class="fas fa-inbox text-sky-400"></i>
                <span class="text-sm font-bold text-sky-400 uppercase tracking-wider">Hộp thư: ${contactList.size()} tin nhắn</span>
            </div>
        </div>

        <div class="card-glass overflow-hidden">
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="text-slate-500 text-[10px] font-black uppercase tracking-[2px] border-b border-white/5 bg-white/5">
                            <th class="px-8 py-5">THỜI GIAN</th>
                            <th class="px-8 py-5">KHÁCH HÀNG</th>
                            <th class="px-8 py-5">NỘI DUNG</th>
                            <th class="px-8 py-5">TRẠNG THÁI</th>
                            <th class="px-8 py-5 text-right">HÀNH ĐỘNG</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-white/5">
                        <c:forEach var="c" items="${contactList}">
                            <tr class="hover:bg-white/5 transition-colors group">
                                <td class="px-8 py-5">
                                    <div class="text-white text-sm font-bold">${c.createdAt}</div>
                                </td>
                                <td class="px-8 py-5">
                                    <div class="font-bold text-white text-base mb-1">${c.fullName}</div>
                                    <div class="text-slate-500 text-[11px] font-medium tracking-wider uppercase">${c.email}</div>
                                    <div class="text-slate-600 text-[10px] mt-1">${c.phoneNumber}</div>
                                </td>
                                <td class="px-8 py-5 max-w-sm">
                                    <p class="text-slate-400 text-xs leading-relaxed line-clamp-2 italic">"${c.message}"</p>
                                </td>
                                <td class="px-8 py-5">
                                    <c:choose>
                                        <c:when test="${c.status == 'PROCESSED'}">
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-emerald-500/10 text-emerald-500 border border-emerald-500/20 text-[10px] font-black uppercase tracking-wider">
                                                <i class="fas fa-check-circle text-[8px]"></i> Đã xử lý
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-amber-500/10 text-amber-500 border border-amber-500/20 text-[10px] font-black uppercase tracking-wider">
                                                <i class="fas fa-clock text-[8px]"></i> Chờ phản hồi
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-8 py-5 text-right">
                                    <div class="flex justify-end gap-3">
                                        <form action="${pageContext.request.contextPath}/admin/contacts" method="POST" class="inline">
                                            <input type="hidden" name="action" value="status">
                                            <input type="hidden" name="contactId" value="${c.contactId}">
                                            <input type="hidden" name="status" value="PROCESSED">
                                            <button class="w-9 h-9 rounded-lg bg-emerald-500/10 text-emerald-500 flex items-center justify-center hover:bg-emerald-500 hover:text-white transition-all" 
                                                    title="Đánh dấu đã xử lý">
                                                <i class="fas fa-check text-xs"></i>
                                            </button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/admin/contacts" method="POST" class="inline" onsubmit="return confirm('Xóa phản hồi này?')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="contactId" value="${c.contactId}">
                                            <button class="w-9 h-9 rounded-lg bg-rose-500/10 text-rose-500 flex items-center justify-center hover:bg-rose-500 hover:text-white transition-all" 
                                                    title="Xóa">
                                                <i class="fas fa-trash-alt text-xs"></i>
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty contactList}">
                            <tr><td colspan="5" class="px-8 py-12 text-center text-slate-500 italic text-sm">Hộp thư đang trống.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
