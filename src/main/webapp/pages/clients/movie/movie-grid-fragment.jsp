<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>

<c:choose>
  <c:when test="${not empty movies}">
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8 animate-in fade-in duration-500">
      <c:forEach var="m" items="${movies}">
        <div class="group bg-slate-900/50 hover:bg-slate-800/80 border border-white/5 hover:border-indigo-500/30 rounded-[2rem] overflow-hidden shadow-2xl transition-all duration-500 transform hover:-translate-y-2">
          <div class="relative aspect-[2/3] overflow-hidden">
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
            
            <span class="absolute top-4 right-4 px-3 py-1 bg-red-600/80 text-white rounded-full text-[10px] font-black tracking-wider uppercase border border-red-500/30 backdrop-blur-sm">
               ${m.status == 'NOW_SHOWING' ? 'Đang chiếu' : 'Sắp chiếu'}
            </span>

            <div class="absolute inset-0 bg-gradient-to-t from-slate-950 via-slate-950/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex flex-col justify-end p-6">
               <p class="text-white text-sm font-medium mb-2"><i class="fas fa-clock mr-2 text-yellow-400"></i>${m.duration} phút</p>
               <p class="text-slate-400 text-xs line-clamp-2">${m.description}</p>
            </div>
          </div>

          <div class="p-6">
            <h3 class="text-xl font-black text-white line-clamp-1 group-hover:text-indigo-400 transition-colors">${m.title}</h3>
            
            <div class="flex items-center gap-3 mt-3 mb-6">
              <span class="flex items-center gap-1 text-yellow-500 font-bold bg-yellow-500/10 px-2.5 py-1 rounded-lg text-sm border border-yellow-500/20">
                  <i class="fas fa-star text-xs"></i> ${m.rating}
              </span>
              <span class="text-slate-400 text-sm font-medium">| ${m.genre}</span>
            </div>

            <div class="flex gap-2">
              <a href="${pageContext.request.contextPath}/movie?id=${m.movieId}" 
                 class="flex-1 text-center py-3 bg-white/5 hover:bg-white/10 text-white font-bold rounded-xl border border-white/10 transition-colors text-sm">
                 Chi tiết
              </a>
              <a href="${pageContext.request.contextPath}/booking-seat?movieId=${m.movieId}" 
                 class="flex-1 text-center py-3 bg-red-600 hover:bg-red-500 text-white font-black rounded-xl shadow-lg shadow-red-900/20 transition-all text-sm uppercase tracking-wider">
                 Đặt vé
              </a>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </c:when>
  <c:otherwise>
    <div class="bg-slate-900/30 rounded-[2.5rem] border border-white/5 p-20 text-center shadow-2xl animate-in fade-in duration-500">
      <div class="bg-slate-800/50 w-24 h-24 rounded-full flex items-center justify-center mx-auto mb-6 text-slate-500 border border-white/5">
         <i class="fas fa-search text-4xl"></i>
      </div>
      <h2 class="text-2xl font-bold text-white mb-2">Không tìm thấy phim</h2>
      <p class="text-slate-500">Rất tiếc, chúng tôi không tìm thấy bộ phim nào phù hợp với yêu cầu của bạn.</p>
    </div>
  </c:otherwise>
</c:choose>
