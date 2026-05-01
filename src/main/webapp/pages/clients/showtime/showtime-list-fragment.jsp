<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:choose>
    <c:when test="${not empty movieShowtimes}">
        <c:forEach var="entry" items="${movieShowtimes}">
            <c:set var="m" value="${entry.key}"/>
            <c:set var="sts" value="${entry.value}"/>
            
            <div class="group bg-white rounded-[2rem] border border-slate-100 p-6 hover:shadow-xl transition-all duration-500 flex flex-col md:flex-row gap-8 animate-in fade-in slide-in-from-bottom-4 duration-500">
                <!-- Poster -->
                <div class="w-full md:w-48 flex-shrink-0 aspect-[2/3] rounded-2xl overflow-hidden shadow-lg shadow-slate-200/50">
                    <img src="${pageContext.request.contextPath}/assets/images/movies/${m.poster}" 
                         alt="${m.title}" 
                         class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
                         onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie1.jpg'">
                </div>

                <!-- Details -->
                <div class="flex-1 flex flex-col justify-center">
                    <div class="mb-6">
                        <div class="flex items-center gap-3 mb-3">
                            <span class="bg-red-50 text-red-500 text-[10px] font-black px-3 py-1 rounded-full uppercase tracking-widest">
                                ${m.genre}
                            </span>
                            <span class="text-slate-400 text-sm font-bold">
                                <i class="far fa-clock mr-1"></i> ${m.duration} phút
                            </span>
                        </div>
                        <h3 class="text-2xl md:text-3xl font-black text-slate-800 mb-2 group-hover:text-red-600 transition-colors uppercase italic tracking-tighter">
                            ${m.title}
                        </h3>
                        <div class="flex items-center gap-2 text-yellow-500 font-bold text-sm">
                            <i class="fas fa-star"></i> ${m.rating > 0 ? m.rating : '8.5'}
                            <span class="text-slate-300 ml-2">|</span>
                            <span class="text-slate-500 font-medium">BOBIXI Đà Nẵng</span>
                        </div>
                    </div>

                    <div class="flex flex-wrap gap-3">
                        <c:forEach var="s" items="${sts}">
                            <a href="${pageContext.request.contextPath}/booking-seat?showtimeId=${s.showtimeId}" 
                               class="flex flex-col items-center bg-slate-50 hover:bg-red-500 border border-slate-100 hover:border-red-500 px-6 py-3 rounded-2xl transition-all group/btn shadow-sm hover:shadow-lg hover:shadow-red-200">
                                <span class="text-lg font-black text-slate-800 group-hover/btn:text-white leading-none">
                                    <fmt:formatDate value="${s.startTime}" pattern="HH:mm" />
                                </span>
                                <span class="text-[9px] font-black uppercase tracking-widest text-slate-400 group-hover/btn:text-white/80 mt-1">
                                    ${s.roomName}
                                </span>
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="py-20 text-center bg-slate-50 rounded-[2rem] border border-dashed border-slate-200 animate-in fade-in duration-500">
            <div class="w-20 h-20 bg-white rounded-full flex items-center justify-center mx-auto mb-6 text-slate-200 shadow-sm">
                <i class="fas fa-film text-3xl"></i>
            </div>
            <h2 class="text-xl font-black text-slate-400 uppercase tracking-widest">Không có suất chiếu nào</h2>
            <p class="text-slate-400 text-sm mt-2 font-medium">Vui lòng chọn ngày khác hoặc quay lại sau nhé!</p>
        </div>
    </c:otherwise>
</c:choose>
