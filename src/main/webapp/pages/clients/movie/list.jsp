<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>PHIM | BOBIXI Cinema</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    
    <script>
        tailwind.config = {
            darkMode: 'media', // Tự động theo hệ thống hoặc trình duyệt
            theme: {
                extend: {
                    colors: {
                        dark: '#020617',
                        card: {
                            light: '#ffffff',
                            dark: '#0f172a'
                        }
                    },
                    fontFamily: {
                        sans: ['Outfit', 'sans-serif'],
                    }
                }
            }
        }
    </script>
    
    <style>
        body { 
            font-family: 'Outfit', sans-serif; 
            transition: background-color 0.5s ease, color 0.5s ease;
        }
        .glow-text {
            background: linear-gradient(to right, #6366f1, #a855f7);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }
        .movie-card {
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .movie-card:hover {
            transform: translateY(-12px);
        }
    </style>
</head>

<body class="bg-slate-50 dark:bg-dark text-slate-900 dark:text-slate-100 min-h-screen">
    <jsp:include page="/common/header.jsp"/>

    <main class="max-w-7xl mx-auto px-6 py-16">
        
        <!-- Header Section -->
        <div class="flex flex-col md:flex-row justify-between items-end mb-20 gap-8">
            <div class="space-y-4">
                <div class="flex items-center gap-3">
                    <span class="w-12 h-1 bg-indigo-600 rounded-full"></span>
                    <h2 class="text-xs font-black uppercase tracking-[0.4em] text-indigo-600 dark:text-indigo-400">Khám phá điện ảnh</h2>
                </div>
                <h1 class="text-6xl font-black tracking-tighter uppercase">
                    Phim <span class="glow-text italic">Đang Chiếu</span>
                </h1>
            </div>
            <div class="flex gap-4">
                <button class="px-8 py-4 bg-indigo-600 text-white rounded-2xl text-xs font-black uppercase tracking-widest shadow-2xl shadow-indigo-500/30 hover:scale-105 transition-transform">Đang chiếu</button>
                <button class="px-8 py-4 bg-white dark:bg-white/5 border border-slate-200 dark:border-white/10 text-slate-600 dark:text-slate-400 rounded-2xl text-xs font-black uppercase tracking-widest hover:bg-slate-50 dark:hover:bg-white/10 transition-all">Sắp ra mắt</button>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty movies}">
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-10">
                    <c:forEach items="${movies}" var="m">
                        <div class="movie-card group bg-white dark:bg-slate-900/40 rounded-[2.5rem] overflow-hidden border border-slate-200 dark:border-white/5 shadow-xl shadow-slate-200/50 dark:shadow-none hover:border-indigo-500/50 transition-all">
                            
                            <!-- Poster -->
                            <div class="relative aspect-[2/3] overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/movie/${m.poster}"
                                     alt="${m.title}"
                                     class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
                                     onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie.jpg'">
                                
                                <!-- Hover Overlay -->
                                <div class="absolute inset-0 bg-indigo-900/60 opacity-0 group-hover:opacity-100 backdrop-blur-sm transition-opacity duration-500 flex items-center justify-center p-8">
                                    <a href="${pageContext.request.contextPath}/movie/detail?id=${m.id}" 
                                       class="w-full py-4 bg-white text-indigo-600 rounded-2xl text-center text-xs font-black uppercase tracking-widest shadow-2xl hover:bg-indigo-50 transition-all transform translate-y-4 group-hover:translate-y-0 duration-500">
                                       Chi tiết phim
                                    </a>
                                </div>

                                <!-- Rating -->
                                <div class="absolute top-6 right-6 px-3 py-2 bg-black/60 backdrop-blur-md rounded-xl border border-white/10 flex items-center gap-2">
                                    <i class="fas fa-star text-amber-400 text-[10px]"></i>
                                    <span class="text-[10px] font-black text-white">8.5</span>
                                </div>
                            </div>

                            <!-- Info -->
                            <div class="p-8 space-y-5">
                                <div class="space-y-2">
                                    <div class="flex items-center gap-2">
                                        <span class="px-2 py-0.5 bg-rose-500/10 text-rose-500 text-[8px] font-black uppercase rounded border border-rose-500/20">C18</span>
                                        <span class="text-[10px] font-bold text-slate-400 uppercase tracking-widest">${m.genre}</span>
                                    </div>
                                    <h3 class="text-xl font-black leading-tight line-clamp-2 group-hover:text-indigo-600 dark:group-hover:text-indigo-400 transition-colors">${m.title}</h3>
                                </div>
                                
                                <div class="flex items-center gap-4 text-slate-400 text-[10px] font-bold uppercase tracking-wider">
                                    <span class="flex items-center gap-1.5"><i class="far fa-clock text-indigo-500"></i> ${m.duration} PHÚT</span>
                                </div>

                                <div class="pt-4 border-t border-slate-100 dark:border-white/5">
                                    <a href="${pageContext.request.contextPath}/booking-seat?movieId=${m.id}" 
                                       class="flex items-center justify-center gap-2 w-full py-4 bg-slate-900 dark:bg-indigo-600 text-white rounded-2xl text-xs font-black uppercase tracking-widest hover:bg-indigo-700 shadow-xl shadow-indigo-500/20 transition-all">
                                       <i class="fas fa-ticket-alt"></i> Đặt vé ngay
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>

            <c:otherwise>
                <div class="py-40 text-center space-y-8">
                    <div class="w-32 h-32 bg-indigo-500/10 rounded-full flex items-center justify-center mx-auto border border-indigo-500/20 animate-pulse">
                        <i class="fas fa-film text-4xl text-indigo-500"></i>
                    </div>
                    <div class="max-w-md mx-auto space-y-3">
                        <h3 class="text-3xl font-black uppercase italic">Phim đang cập nhật</h3>
                        <p class="text-slate-500 font-bold text-sm">Hệ thống đang chuẩn bị những siêu phẩm mới nhất dành riêng cho bạn. Vui lòng quay lại sau!</p>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

    </main>

    <jsp:include page="/common/footer.jsp"/>
</body>
</html>
