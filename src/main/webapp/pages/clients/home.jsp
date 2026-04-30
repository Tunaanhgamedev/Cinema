<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>BOBIXI Cinema | Đặt vé xem phim nhanh & đẹp</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>

    <script>
        tailwind.config = {
            darkMode: 'media',
            theme: {
                extend: {
                    colors: {
                        dark: '#020617',
                    },
                    fontFamily: {
                        sans: ['Outfit', 'sans-serif'],
                    }
                }
            }
        }
    </script>
    
    <style>
        body { font-family: 'Outfit', sans-serif; transition: background-color 0.5s ease; }
        .hero-gradient {
            background: radial-gradient(circle at 0% 0%, rgba(99, 102, 241, 0.15) 0%, transparent 50%),
                        radial-gradient(circle at 100% 100%, rgba(168, 85, 247, 0.1) 0%, transparent 50%);
        }
        .reveal { opacity: 0; transform: translateY(30px); transition: all 0.8s ease-out; }
        .reveal.active { opacity: 1; transform: translateY(0); }
    </style>
</head>

<body class="bg-slate-50 dark:bg-dark text-slate-900 dark:text-slate-100 min-h-screen overflow-x-hidden">

    <jsp:include page="/common/header.jsp" />

    <!-- HERO SECTION -->
    <section class="relative min-h-[90vh] flex items-center pt-20 hero-gradient">
        <div class="max-w-7xl mx-auto px-6 w-full grid grid-cols-1 lg:grid-cols-2 gap-20 items-center">
            
            <div class="space-y-10 reveal active">
                <div class="inline-flex items-center gap-3 px-4 py-2 bg-indigo-600/10 border border-indigo-500/20 rounded-full">
                    <span class="relative flex h-2 w-2">
                        <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-indigo-400 opacity-75"></span>
                        <span class="relative inline-flex rounded-full h-2 w-2 bg-indigo-500"></span>
                    </span>
                    <span class="text-[10px] font-black uppercase tracking-[0.2em] text-indigo-600 dark:text-indigo-400">Hệ thống rạp chiếu phim BOBIXI</span>
                </div>

                <h1 class="text-6xl sm:text-8xl font-black tracking-tighter leading-[0.9] uppercase italic">
                    Điện ảnh <br/>
                    <span class="text-indigo-600 dark:text-transparent dark:bg-clip-text dark:bg-gradient-to-r dark:from-indigo-400 dark:to-purple-400">Đẳng Cấp</span>
                </h1>

                <p class="text-lg text-slate-500 dark:text-slate-400 max-w-lg font-medium leading-relaxed">
                    Trải nghiệm công nghệ chiếu phim IMAX & 4K hiện đại nhất. Đặt vé nhanh chóng, thanh toán an toàn chỉ trong 30 giây.
                </p>

                <div class="flex flex-wrap gap-6">
                    <a href="#nowshowing" class="px-10 py-5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-2xl text-xs font-black uppercase tracking-widest shadow-2xl shadow-indigo-500/30 transition-all hover:scale-105 active:scale-95">
                        Mua vé ngay
                    </a>
                    <a href="${pageContext.request.contextPath}/movie" class="px-10 py-5 bg-white dark:bg-white/5 border border-slate-200 dark:border-white/10 text-slate-600 dark:text-slate-400 rounded-2xl text-xs font-black uppercase tracking-widest hover:bg-slate-50 dark:hover:bg-white/10 transition-all flex items-center gap-3">
                        <i class="fas fa-play text-indigo-500"></i> Khám phá phim
                    </a>
                </div>

                <div class="flex gap-12 pt-8 border-t border-slate-200 dark:border-white/5">
                    <div class="space-y-1">
                        <p class="text-3xl font-black italic">50+</p>
                        <p class="text-[9px] font-bold text-slate-400 uppercase tracking-widest">Suất chiếu/Ngày</p>
                    </div>
                    <div class="space-y-1">
                        <p class="text-3xl font-black italic">12+</p>
                        <p class="text-[9px] font-bold text-slate-400 uppercase tracking-widest">Cụm rạp toàn quốc</p>
                    </div>
                    <div class="space-y-1">
                        <p class="text-3xl font-black italic">4K</p>
                        <p class="text-[9px] font-bold text-slate-400 uppercase tracking-widest">Độ phân giải</p>
                    </div>
                </div>
            </div>

            <div class="relative hidden lg:block reveal active">
                <div class="relative z-10 w-full aspect-[4/5] rounded-[3rem] overflow-hidden shadow-2xl border-4 border-white/10 group">
                    <img src="${pageContext.request.contextPath}/assets/images/movies/avg.jpg" 
                         class="w-full h-full object-cover transition-transform duration-[2s] group-hover:scale-110" 
                         alt="Featured">
                    <div class="absolute inset-0 bg-gradient-to-t from-indigo-950 via-transparent to-transparent p-12 flex flex-col justify-end">
                        <h3 class="text-3xl font-black text-white italic tracking-tighter uppercase mb-2">Marvel Cinematic Universe</h3>
                        <p class="text-indigo-200/60 text-xs font-bold uppercase tracking-widest">Siêu phẩm đang được mong đợi nhất</p>
                    </div>
                </div>
                <!-- Floating Elements -->
                <div class="absolute -bottom-10 -left-10 w-40 h-40 bg-white dark:bg-slate-900 rounded-3xl p-6 shadow-2xl border border-slate-100 dark:border-white/5 animate-bounce-slow">
                    <i class="fas fa-star text-amber-400 text-3xl mb-4"></i>
                    <p class="text-[10px] font-black uppercase text-slate-400 tracking-widest">Rating 9.8</p>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="/common/banner.jsp" />

    <!-- NOW SHOWING SECTION -->
    <section class="max-w-7xl mx-auto px-6 py-32" id="nowshowing">
        <div class="flex flex-col md:flex-row justify-between items-end mb-20 gap-8 reveal">
            <div class="space-y-4">
                <div class="flex items-center gap-3">
                    <span class="w-12 h-1 bg-indigo-600 rounded-full"></span>
                    <h2 class="text-xs font-black uppercase tracking-[0.4em] text-indigo-600 dark:text-indigo-400">Danh sách phim</h2>
                </div>
                <h2 class="text-5xl font-black tracking-tighter uppercase">PHIM ĐANG <span class="text-indigo-600 dark:text-transparent dark:bg-clip-text dark:bg-gradient-to-r dark:from-indigo-400 dark:to-purple-400 italic">CHIẾU</span></h2>
            </div>
            <a href="${pageContext.request.contextPath}/movie" class="text-sm font-black uppercase tracking-widest text-indigo-600 dark:text-indigo-400 hover:translate-x-4 transition-all group">
                Tất cả phim <i class="fas fa-arrow-right ml-2 transition-transform"></i>
            </a>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-10">
            <c:forEach var="m" items="${nowShowingMovies}">
                <div class="reveal group bg-white dark:bg-slate-900/40 rounded-[2.5rem] overflow-hidden border border-slate-200 dark:border-white/5 shadow-xl shadow-slate-200/50 dark:shadow-none hover:border-indigo-500/50 transition-all duration-500">
                    <div class="relative aspect-[2/3] overflow-hidden">
                        <img src="${pageContext.request.contextPath}/assets/images/movie/${m.poster}" alt="${m.title}" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110">
                        <div class="absolute inset-0 bg-indigo-900/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center p-8 backdrop-blur-sm">
                             <a href="${pageContext.request.contextPath}/movie/detail?id=${m.id}" 
                               class="w-full py-4 bg-white text-indigo-600 rounded-2xl text-center text-xs font-black uppercase tracking-widest shadow-2xl hover:bg-indigo-50 transition-all transform translate-y-4 group-hover:translate-y-0">
                               Chi tiết phim
                            </a>
                        </div>
                        <c:if test="${m.rating >= 9}">
                            <div class="absolute top-6 left-6 px-4 py-1.5 bg-rose-600 text-white text-[9px] font-black uppercase tracking-widest rounded-full shadow-lg">HOT</div>
                        </c:if>
                    </div>
                    <div class="p-8 space-y-4">
                        <h3 class="text-xl font-black leading-tight group-hover:text-indigo-600 dark:group-hover:text-indigo-400 transition-colors">${m.title}</h3>
                        <div class="flex items-center gap-4 text-slate-400 text-[10px] font-bold uppercase tracking-wider">
                            <span class="flex items-center gap-1.5"><i class="far fa-clock text-indigo-500"></i> ${m.duration} PHÚT</span>
                            <span class="flex items-center gap-1.5"><i class="fas fa-star text-amber-400"></i> ${m.rating}/10</span>
                        </div>
                        <div class="pt-4 border-t border-slate-100 dark:border-white/5">
                            <a href="${pageContext.request.contextPath}/booking-seat?movieId=${m.id}" class="w-full py-4 flex items-center justify-center gap-2 bg-slate-900 dark:bg-indigo-600 text-white rounded-2xl text-xs font-black uppercase tracking-widest hover:bg-indigo-700 shadow-xl shadow-indigo-500/20 transition-all">
                                Mua vé ngay
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>

    <jsp:include page="/common/footer.jsp" />

    <script>
        // Scroll Reveal
        function reveal() {
            const reveals = document.querySelectorAll(".reveal");
            reveals.forEach(el => {
                const windowHeight = window.innerHeight;
                const elementTop = el.getBoundingClientRect().top;
                const elementVisible = 150;
                if (elementTop < windowHeight - elementVisible) el.classList.add("active");
            });
        }
        window.addEventListener("scroll", reveal);
        reveal();
    </script>
</body>
</html>
