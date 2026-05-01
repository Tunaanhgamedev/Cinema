<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8" id="movieGrid">
    <c:forEach var="m" items="${movies}">
        <div class="group bg-white rounded-[2rem] overflow-hidden shadow-sm border border-slate-100 hover:shadow-2xl transition-all duration-500 transform hover:-translate-y-2 animate-in fade-in zoom-in duration-500">
            <div class="relative aspect-[2/3] overflow-hidden">
                <img src="${pageContext.request.contextPath}/assets/images/movies/${m.poster}" 
                     alt="${m.title}" 
                     class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
                     onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie1.jpg'">
                
                <div class="absolute inset-0 bg-gradient-to-t from-slate-900/90 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex flex-col justify-end p-6">
                    <p class="text-white text-sm font-medium mb-2"><i class="fas fa-clock mr-2 text-yellow-400"></i>${m.duration} phút</p>
                    <p class="text-slate-300 text-xs line-clamp-2">${m.description}</p>
                </div>
            </div>

            <div class="p-6">
                <div class="flex justify-between items-start mb-2">
                    <h3 class="text-xl font-bold text-slate-800 line-clamp-1 group-hover:text-red-600 transition-colors">${m.title}</h3>
                </div>
                
                <div class="flex items-center gap-3 mb-6">
                    <span class="flex items-center gap-1 text-yellow-500 font-bold bg-yellow-50 px-2 py-1 rounded-lg text-sm">
                        <i class="fas fa-star"></i> ${m.rating}
                    </span>
                    <span class="text-slate-400 text-sm font-medium">| ${m.genre}</span>
                </div>

                <div class="flex gap-2">
                    <a href="${pageContext.request.contextPath}/movie/detail?id=${m.movieId}" 
                       class="flex-1 text-center py-3 bg-slate-100 hover:bg-slate-200 text-slate-700 font-bold rounded-xl transition-colors text-sm">
                       Chi tiết
                    </a>
                    <a href="${pageContext.request.contextPath}/booking-seat?movieId=${m.movieId}" 
                       class="flex-1 text-center py-3 bg-red-500 hover:bg-red-600 text-white font-bold rounded-xl shadow-lg shadow-red-100 transition-all text-sm">
                       Đặt vé
                    </a>
                </div>
            </div>
        </div>
    </c:forEach>
    <c:if test="${empty movies}">
        <div class="col-span-full bg-white rounded-3xl p-20 text-center border border-slate-100 shadow-sm">
            <div class="bg-slate-50 w-24 h-24 rounded-full flex items-center justify-center mx-auto mb-6 text-slate-300">
               <i class="fas fa-search text-4xl"></i>
            </div>
            <h2 class="text-2xl font-bold text-slate-800 mb-2">Không tìm thấy phim</h2>
            <p class="text-slate-500 mb-4 text-sm">Rất tiếc, chúng tôi không tìm thấy bộ phim nào phù hợp với yêu cầu của bạn.</p>
        </div>
    </c:if>
</div>
