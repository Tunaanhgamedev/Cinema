<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>

<c:choose>
    <c:when test="${not empty movieShowtimes}">
        <c:forEach var="entry" items="${movieShowtimes}">
            <c:set var="m" value="${entry.key}"/>
            <c:set var="sts" value="${entry.value}"/>
            
            <div class="group bg-slate-900/50 hover:bg-slate-800/80 border border-white/5 hover:border-indigo-500/30 rounded-[2.5rem] p-8 hover:shadow-2xl transition-all duration-500 flex flex-col md:flex-row gap-8 animate-in fade-in slide-in-from-bottom-4 duration-500">
                <!-- Poster -->
                <div class="w-full md:w-48 flex-shrink-0 aspect-[2/3] rounded-2xl overflow-hidden shadow-2xl relative border border-white/10">
                    <c:set var="posterUrl" value="${m.poster}" />
                    <c:choose>
                      <c:when test="${not empty posterUrl && posterUrl.startsWith('http')}">
                        <c:set var="finalPoster" value="${posterUrl}" />
                      </c:when>
                      <c:when test="${not empty posterUrl}">
                        <!-- Remove leading slash if any -->
                        <c:if test="${posterUrl.startsWith('/')}">
                          <c:set var="posterUrl" value="${posterUrl.substring(1)}" />
                        </c:if>
                        <c:choose>
                          <c:when test="${posterUrl.startsWith('assets/')}">
                            <c:set var="finalPoster" value="${pageContext.request.contextPath}/${posterUrl}" />
                          </c:when>
                          <c:otherwise>
                            <c:set var="finalPoster" value="${pageContext.request.contextPath}/assets/images/movies/${posterUrl}" />
                          </c:otherwise>
                        </c:choose>
                      </c:when>
                      <c:otherwise>
                        <c:set var="finalPoster" value="${pageContext.request.contextPath}/assets/images/movies/movie.jpg" />
                      </c:otherwise>
                    </c:choose>
                    <img src="${finalPoster}" 
                         alt="${m.title}" 
                         class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
                         onerror="this.src='https://placehold.co/300x450?text=No+Poster'">
                </div>

                <!-- Details -->
                <div class="flex-1 flex flex-col justify-center">
                    <div class="mb-6">
                        <div class="flex items-center gap-3 mb-3">
                            <span class="bg-red-500/10 text-red-400 text-[10px] font-black px-3.5 py-1.5 rounded-full uppercase tracking-widest border border-red-500/20">
                                ${m.genre}
                            </span>
                            <span class="text-slate-400 text-sm font-bold">
                                <i class="far fa-clock mr-1 text-red-500"></i> ${m.duration} phút
                            </span>
                        </div>
                        <h3 class="text-2xl md:text-3.5xl font-black text-white mb-2 group-hover:text-indigo-400 transition-colors uppercase italic tracking-tighter leading-tight">
                            ${m.title}
                        </h3>
                        <div class="flex items-center gap-2 text-yellow-500 font-bold text-sm">
                            <i class="fas fa-star"></i> ${m.rating > 0 ? m.rating : '8.5'}
                            <span class="text-slate-700 ml-2">|</span>
                            <span class="text-slate-400 font-medium">BOBIXI Đà Nẵng</span>
                        </div>
                    </div>

                    <div class="flex flex-wrap gap-3">
                        <c:forEach var="s" items="${sts}">
                            <a href="${pageContext.request.contextPath}/booking-seat?movieId=${m.movieId}&showDate=${selectedDate}&showtimeId=${s.showtimeId}" 
                               class="flex flex-col items-center bg-slate-950/60 hover:bg-red-600 border border-white/5 hover:border-red-500 px-6 py-3.5 rounded-2xl transition-all group/btn shadow-sm hover:shadow-xl hover:shadow-red-900/20 active:scale-95">
                                <span class="text-lg font-black text-white group-hover/btn:text-white leading-none">
                                    <fmt:formatDate value="${s.startTime}" pattern="HH:mm" />
                                </span>
                                <span class="text-[9px] font-black uppercase tracking-widest text-slate-500 group-hover/btn:text-red-100 mt-1">
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
        <div class="py-20 text-center bg-slate-900/30 rounded-[2.5rem] border border-dashed border-white/5 animate-in fade-in duration-500">
            <div class="w-20 h-20 bg-slate-800/50 rounded-full flex items-center justify-center mx-auto mb-6 text-slate-500 border border-white/5 shadow-inner">
                <i class="fas fa-film text-3xl"></i>
            </div>
            <h2 class="text-xl font-black text-slate-400 uppercase tracking-widest">Không có suất chiếu nào</h2>
            <p class="text-slate-500 text-sm mt-2 font-medium">Vui lòng chọn ngày khác hoặc quay lại sau nhé!</p>
        </div>
    </c:otherwise>
</c:choose>
