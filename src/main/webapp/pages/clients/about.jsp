<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/common/header.jsp" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>VỀ CHÚNG TÔI | BOBIXI Cinema</title>
</head>
<body class="bg-[#0a0f1a] text-slate-200">

    <!-- Hero Section -->
    <div class="relative h-[50vh] flex items-center justify-center overflow-hidden">
        <div class="absolute inset-0 bg-[url('https://images.unsplash.com/photo-1517604401157-538a9663ec02?q=80&w=2070&auto=format&fit=crop')] bg-cover bg-center opacity-40"></div>
        <div class="absolute inset-0 bg-gradient-to-b from-slate-900/50 via-[#0a0f1a]/80 to-[#0a0f1a]"></div>
        
        <div class="relative z-10 text-center px-4">
            <h1 class="text-5xl md:text-7xl font-black text-white mb-4 tracking-tighter">VỀ CHÚNG TÔI</h1>
            <p class="text-xl text-primary font-bold uppercase tracking-[0.3em]">Hành trình điện ảnh tuyệt vời</p>
        </div>
    </div>

    <!-- Main Content -->
    <div class="max-w-7xl mx-auto px-4 py-20 space-y-32">
        
        <!-- Introduction -->
        <section class="grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
            <div class="space-y-6">
                <h2 class="text-4xl font-black text-white leading-tight">BOBIXI Cinemas Vietnam</h2>
                <p class="text-xl text-slate-400 font-medium leading-relaxed">
                    BOBIXI là biểu tượng của sự đổi mới trong ngành điện ảnh Việt Nam, 
                    mang đến trải nghiệm đẳng cấp thế giới cho hàng triệu khán giả mỗi năm.
                </p>
                <div class="space-y-4 text-slate-500 leading-relaxed">
                    <p>Kể từ khi khai trương rạp đầu tiên vào năm 2025, BOBIXI đã không ngừng khẳng định vị thế. Chúng tôi tự hào là đối tác chiến lược của các hãng phim lớn, mang những bom tấn đỉnh cao nhất đến gần hơn với khán giả Việt.</p>
                </div>
                <div class="flex gap-8 pt-4">
                    <div>
                        <p class="text-3xl font-black text-white">100+</p>
                        <p class="text-xs text-primary font-bold uppercase tracking-widest">Cụm rạp</p>
                    </div>
                    <div>
                        <p class="text-3xl font-black text-white">600+</p>
                        <p class="text-xs text-primary font-bold uppercase tracking-widest">Phòng chiếu</p>
                    </div>
                    <div>
                        <p class="text-3xl font-black text-white">50M+</p>
                        <p class="text-xs text-primary font-bold uppercase tracking-widest">Khách hàng</p>
                    </div>
                </div>
            </div>
            <div class="relative">
                <div class="absolute -inset-4 bg-primary/20 blur-2xl rounded-full"></div>
                <img src="${pageContext.request.contextPath}/assets/images/about/bobixi-cinema.jpg" 
                     onerror="this.src='https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?q=80&w=2070&auto=format&fit=crop'"
                     class="relative rounded-[3rem] shadow-2xl border border-white/10 w-full object-cover h-[500px]">
            </div>
        </section>

        <!-- Mission & Vision - Bento Style -->
        <section class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="p-10 rounded-[3rem] bg-white/5 border border-white/5 hover:bg-white/10 transition-all group">
                <div class="w-16 h-16 rounded-2xl bg-primary/20 text-primary flex items-center justify-center text-2xl mb-6 group-hover:scale-110 transition-transform">
                    <i class="fas fa-bullseye"></i>
                </div>
                <h3 class="text-2xl font-black text-white mb-4">Sứ mệnh</h3>
                <p class="text-slate-500 leading-relaxed">Mang đến những trải nghiệm điện ảnh tuyệt vời nhất, góp phần làm phong phú đời sống tinh thần của cộng đồng.</p>
            </div>
            <div class="p-10 rounded-[3rem] bg-white/5 border border-white/5 hover:bg-white/10 transition-all group">
                <div class="w-16 h-16 rounded-2xl bg-blue-500/20 text-blue-400 flex items-center justify-center text-2xl mb-6 group-hover:scale-110 transition-transform">
                    <i class="fas fa-eye"></i>
                </div>
                <h3 class="text-2xl font-black text-white mb-4">Tầm nhìn</h3>
                <p class="text-slate-500 leading-relaxed">Trở thành hệ thống rạp số 1 Việt Nam, tiên phong ứng dụng công nghệ hiện đại và tiêu chuẩn dịch vụ quốc tế.</p>
            </div>
            <div class="p-10 rounded-[3rem] bg-white/5 border border-white/5 hover:bg-white/10 transition-all group">
                <div class="w-16 h-16 rounded-2xl bg-emerald-500/20 text-emerald-400 flex items-center justify-center text-2xl mb-6 group-hover:scale-110 transition-transform">
                    <i class="fas fa-heart"></i>
                </div>
                <h3 class="text-2xl font-black text-white mb-4">Giá trị</h3>
                <p class="text-slate-500 leading-relaxed">Đam mê điện ảnh, tận tâm phục vụ, không ngừng đổi mới và luôn đặt khách hàng làm trung tâm.</p>
            </div>
        </section>

        <!-- Team Section - NEW UI -->
        <section>
            <div class="text-center mb-16">
                <p class="text-primary font-black tracking-widest text-xs uppercase mb-2">ĐỘI NGŨ THÀNH VIÊN</p>
                <h2 class="text-4xl font-black text-white">Những người tạo nên sự khác biệt</h2>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-3 gap-12">
                <!-- Member 1 -->
                <div class="group">
                    <div class="relative rounded-[3rem] overflow-hidden mb-6 aspect-[4/5]">
                        <img src="${pageContext.request.contextPath}/assets/images/team/ceo.jpg" 
                             onerror="this.src='https://images.unsplash.com/photo-1560250097-0b93528c311a?q=80&w=1974&auto=format&fit=crop'"
                             class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-700">
                        <div class="absolute inset-0 bg-gradient-to-t from-primary/80 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500 flex items-end p-10">
                            <div class="flex gap-4 text-white text-xl">
                                <a href="#"><i class="fab fa-linkedin"></i></a>
                                <a href="#"><i class="fab fa-twitter"></i></a>
                            </div>
                        </div>
                    </div>
                    <h4 class="text-2xl font-black text-white">Nguyễn Văn An</h4>
                    <p class="text-primary font-bold text-sm uppercase tracking-widest mt-1">Tổng Giám Đốc</p>
                    <p class="text-slate-500 mt-4 text-sm leading-relaxed">Hơn 20 năm kinh nghiệm dẫn dắt các tập đoàn giải trí hàng đầu.</p>
                </div>

                <!-- Member 2 -->
                <div class="group">
                    <div class="relative rounded-[3rem] overflow-hidden mb-6 aspect-[4/5]">
                        <img src="${pageContext.request.contextPath}/assets/images/team/coo.jpg" 
                             onerror="this.src='https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=2070&auto=format&fit=crop'"
                             class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-700">
                        <div class="absolute inset-0 bg-gradient-to-t from-primary/80 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500 flex items-end p-10">
                            <div class="flex gap-4 text-white text-xl">
                                <a href="#"><i class="fab fa-linkedin"></i></a>
                                <a href="#"><i class="fab fa-twitter"></i></a>
                            </div>
                        </div>
                    </div>
                    <h4 class="text-2xl font-black text-white">Nguyễn Tuấn Anh</h4>
                    <p class="text-primary font-bold text-sm uppercase tracking-widest mt-1">Giám Đốc Vận Hành</p>
                    <p class="text-slate-500 mt-4 text-sm leading-relaxed">Chuyên gia tối ưu hóa trải nghiệm khách hàng và hệ thống rạp.</p>
                </div>

                <!-- Member 3 -->
                <div class="group">
                    <div class="relative rounded-[3rem] overflow-hidden mb-6 aspect-[4/5]">
                        <img src="${pageContext.request.contextPath}/assets/images/team/cto.jpg" 
                             onerror="this.src='https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?q=80&w=1974&auto=format&fit=crop'"
                             class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-700">
                        <div class="absolute inset-0 bg-gradient-to-t from-primary/80 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500 flex items-end p-10">
                            <div class="flex gap-4 text-white text-xl">
                                <a href="#"><i class="fab fa-linkedin"></i></a>
                                <a href="#"><i class="fab fa-twitter"></i></a>
                            </div>
                        </div>
                    </div>
                    <h4 class="text-2xl font-black text-white">Lê Văn C</h4>
                    <p class="text-primary font-bold text-sm uppercase tracking-widest mt-1">Giám Đốc Công Nghệ</p>
                    <p class="text-slate-500 mt-4 text-sm leading-relaxed">Tiên phong đưa công nghệ IMAX và 4DX vào rạp chiếu Việt.</p>
                </div>
            </div>
        </section>

        <!-- Timeline -->
        <section class="bg-white/5 rounded-[4rem] p-12 md:p-20 border border-white/5">
            <h2 class="text-4xl font-black text-white text-center mb-16">Hành trình phát triển</h2>
            <div class="space-y-12">
                <div class="flex flex-col md:flex-row gap-8 items-start">
                    <div class="text-5xl font-black text-primary md:w-40 shrink-0">2025</div>
                    <div class="pt-2">
                        <h4 class="text-2xl font-bold text-white mb-2">Khởi đầu rực rỡ</h4>
                        <p class="text-slate-500">Khai trương cụm rạp đầu tiên tại Đà Nẵng, đặt nền móng cho cuộc cách mạng rạp chiếu.</p>
                    </div>
                </div>
                <div class="flex flex-col md:flex-row gap-8 items-start">
                    <div class="text-5xl font-black text-white/20 md:w-40 shrink-0">NOW</div>
                    <div class="pt-2">
                        <h4 class="text-2xl font-bold text-white mb-2">Dẫn đầu thị trường</h4>
                        <p class="text-slate-500">Với 100+ cụm rạp, BOBIXI tự hào là điểm đến giải trí số 1 của giới trẻ Việt Nam.</p>
                    </div>
                </div>
            </div>
        </section>

    </div>

    <!-- CTA -->
    <div class="py-32 text-center bg-gradient-to-t from-primary/10 to-transparent">
        <h2 class="text-4xl font-black text-white mb-8">Bạn muốn gia nhập đội ngũ của chúng tôi?</h2>
        <a href="${pageContext.request.contextPath}/contact" class="px-12 py-5 bg-primary rounded-full text-white font-black text-lg hover:scale-105 transition-all shadow-xl shadow-primary/20">LIÊN HỆ NGAY</a>
    </div>

    <jsp:include page="/common/footer.jsp" />

</body>
</html>