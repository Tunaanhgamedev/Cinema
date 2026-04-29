<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/common/header.jsp" />
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>CHÚNG TÔI | BOBIXI Cinema</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="about-page">
    <!-- Hero Section -->
    <div class="about-hero">
        <div class="hero-overlay">
            <h1>Về chúng tôi</h1>
            <p>Hệ thống rạp chiếu phim Việt Nam</p>
        </div>
    </div>
    
    <div class="about-container">
        <!-- Introduction -->
        <section class="about-intro">
            <div class="intro-content">
                <h2>BOBIXI Cinemas Vietnam</h2>
                <p class="lead-text">
                    BOBIXI là hệ thống rạp chiếu phim ở Việt Nam, 
                    mang đến trải nghiệm điện ảnh đẳng cấp thế giới cho hàng triệu khán giả mỗi năm.
                </p>
                <p>
                    Kể từ khi khai trương rạp đầu tiên vào năm 2025, BOBIXI đã không ngừng phát triển và khẳng định 
                    vị thế trong ngành công nghiệp điện ảnh Việt Nam. Chúng tôi tự hào là đối tác chiến lược 
                    của các hãng phim lớn trên thế giới, mang đến những bom tấn điện ảnh đỉnh cao nhất.
                </p>
            </div>
            <div class="intro-image">
                <img src="${pageContext.request.contextPath}/assets/images/about/bobixi-cinema.jpg" 
                     alt="BOBIXI Cinema" />
            </div>
        </section>
        
        <!-- Mission & Vision -->
        <section class="mission-vision">
            <div class="mv-card mission">
                <div class="mv-icon">
                    <i class="icon-target"></i>
                </div>
                <h3>Sứ mệnh</h3>
                <p>
                    Mang đến những trải nghiệm điện ảnh tuyệt vời nhất, góp phần làm phong phú đời sống 
                    tinh thần của cộng đồng và thúc đẩy sự phát triển của nền điện ảnh Việt Nam.
                </p>
            </div>
            
            <div class="mv-card vision">
                <div class="mv-icon">
                    <i class="icon-eye"></i>
                </div>
                <h3>Tầm nhìn</h3>
                <p>
                    Trở thành hệ thống rạp chiếu phim số 1 tại Việt Nam, tiên phong trong việc ứng dụng 
                    công nghệ hiện đại và mang đến những tiêu chuẩn dịch vụ quốc tế.
                </p>
            </div>
            
            <div class="mv-card values">
                <div class="mv-icon">
                    <i class="icon-heart"></i>
                </div>
                <h3>Giá trị cốt lõi</h3>
                <p>
                    Đam mê điện ảnh, tận tâm phục vụ, không ngừng đổi mới và luôn đặt khách hàng 
                    làm trung tâm trong mọi hoạt động.
                </p>
            </div>
        </section>
        
        <!-- Statistics -->
        <section class="statistics">
            <h2>BOBIXI trong con số</h2>
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number">100+</div>
                    <div class="stat-label">Cụm rạp</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">600+</div>
                    <div class="stat-label">Phòng chiếu</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">50M+</div>
                    <div class="stat-label">Lượt khách/năm</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">3000+</div>
                    <div class="stat-label">Nhân viên</div>
                </div>
            </div>
        </section>
        
        <!-- Timeline -->
        <section class="timeline">
            <h2>Hành trình phát triển</h2>
            <div class="timeline-container">
                <div class="timeline-item">
                    <div class="timeline-year">2025</div>
                    <div class="timeline-content">
                        <h4>Khởi đầu</h4>
                        <p>Khai trương cụm rạp đầu tiên tại Đà Nẵng</p>
                    </div>
                </div>
                
                <div class="timeline-item">
                    <div class="timeline-year">2025</div>
                    <div class="timeline-content">
                        <h4>Mở rộng</h4>
                        <p>Đạt mốc 20 cụm rạp trên toàn quốc</p>
                    </div>
                </div>
                
                <div class="timeline-item">
                    <div class="timeline-year">2025</div>
                    <div class="timeline-content">
                        <h4>Công nghệ tiên tiến</h4>
                        <p>Ra mắt rạp IMAX tại Việt Nam</p>
                    </div>
                </div>
                
                <div class="timeline-item">
                    <div class="timeline-year">2025</div>
                    <div class="timeline-content">
                        <h4>Dẫn đầu thị trường</h4>
                        <p>Trở thành hệ thống rạp số 1 Việt Nam</p>
                    </div>
                </div>
                
                <div class="timeline-item">
                    <div class="timeline-year">2025</div>
                    <div class="timeline-content">
                        <h4>Chuyển đổi số</h4>
                        <p>Ra mắt nền tảng đặt vé trực tuyến toàn diện</p>
                    </div>
                </div>
                
                <div class="timeline-item">
                    <div class="timeline-year">2025</div>
                    <div class="timeline-content">
                        <h4>Hiện tại</h4>
                        <p>100+ cụm rạp, tiếp tục mở rộng và phát triển</p>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Technology -->
        <section class="technology">
            <h2>Công nghệ tiên tiến</h2>
            <div class="tech-grid">
                <div class="tech-card">
                    <img src="${pageContext.request.contextPath}/assets/images/about/imax.jpg" 
                         alt="IMAX" />
                    <h4>IMAX</h4>
                    <p>Màn hình khổng lồ với chất lượng hình ảnh và âm thanh vượt trội</p>
                </div>
                
                <div class="tech-card">
                    <img src="${pageContext.request.contextPath}/assets/images/about/4dx.jpg" 
                         alt="4DX" />
                    <h4>4DX</h4>
                    <p>Trải nghiệm xem phim 4 chiều với hiệu ứng đặc biệt</p>
                </div>
                
                <div class="tech-card">
                    <img src="${pageContext.request.contextPath}/assets/images/about/screenx.jpg" 
                         alt="ScreenX" />
                    <h4>ScreenX</h4>
                    <p>Công nghệ màn hình 270 độ mang đến trải nghiệm toàn cảnh</p>
                </div>
                
                <div class="tech-card">
                    <img src="${pageContext.request.contextPath}/assets/images/about/dolby.jpg" 
                         alt="Dolby Atmos" />
                    <h4>Dolby Atmos</h4>
                    <p>Hệ thống âm thanh vòm hiện đại nhất</p>
                </div>
            </div>
        </section>
        
        <!-- Team -->
        <section class="team">
            <h2>Đội ngũ lãnh đạo</h2>
            <div class="team-grid">
                <div class="team-member">
                    <div class="member-photo">
                        <img src="${pageContext.request.contextPath}/assets/images/team/ceo.jpg" 
                             alt="CEO" />
                    </div>
                    <h4>Nguyễn Văn An</h4>
                    <p class="member-role">Tổng Giám Đốc</p>
                    <p class="member-bio">
                        Hơn 0 năm kinh nghiệm trong ngành giải trí và điện ảnh
                    </p>
                </div>
                
                <div class="team-member">
                    <div class="member-photo">
                        <img src="${pageContext.request.contextPath}/assets/images/team/coo.jpg" 
                             alt="COO" />
                    </div>
                    <h4>Nguyễn Tuấn Anh</h4>
                    <p class="member-role">Giám Đốc Vận Hành</p>
                    <p class="member-bio">
                        Chuyên gia về quản lý và vận hành hệ thống rạp chiếu phim
                    </p>
                </div>
                
                <div class="team-member">
                    <div class="member-photo">
                        <img src="${pageContext.request.contextPath}/assets/images/team/cto.jpg" 
                             alt="CTO" />
                    </div>
                    <h4>Lê Văn C</h4>
                    <p class="member-role">Giám Đốc Công Nghệ</p>
                    <p class="member-bio">
                        Tiên phong trong việc ứng dụng công nghệ mới vào ngành điện ảnh
                    </p>
                </div>
            </div>
        </section>
        
        <!-- CTA -->
        <section class="cta-section">
            <h2>Tham gia cùng chúng tôi</h2>
            <p>Khám phá thế giới điện ảnh tuyệt vời tại CGV</p>
            <div class="cta-buttons">
                <a href="${pageContext.request.contextPath}/cinemas" class="btn-primary">
                    Tìm rạp gần bạn
                </a>
                <a href="${pageContext.request.contextPath}/careers" class="btn-secondary">
                    Cơ hội nghề nghiệp
                </a>
            </div>
        </section>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />

<style>
    .about-page {
        background: #f5f5f5;
    }
    
    .about-hero {
        height: 500px;
        background: url('${pageContext.request.contextPath}/resources/images/about/hero-bg.jpg') center/cover;
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .hero-overlay {
        background: rgba(0,0,0,0.6);
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        color: #fff;
        text-align: center;
    }
    
    .hero-overlay h1 {
        font-size: 56px;
        margin-bottom: 20px;
    }
    
    .hero-overlay p {
        font-size: 24px;
    }
    
    .about-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 80px 20px;
    }
    
    section {
        margin-bottom: 100px;
    }
    
    section h2 {
        font-size: 42px;
        text-align: center;
        margin-bottom: 50px;
        color: #333;
    }
    
    .about-intro {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 60px;
        align-items: center;
        background: #fff;
        padding: 60px;
        border-radius: 20px;
    }
    
    .lead-text {
        font-size: 22px;
        font-weight: 500;
        line-height: 1.6;
        color: #e71a0f;
        margin-bottom: 25px;
    }
    
    .intro-content p {
        font-size: 18px;
        line-height: 1.8;
        color: #666;
        margin-bottom: 20px;
    }
    
    .intro-image img {
        width: 100%;
        border-radius: 15px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.15);
    }
    
    .mission-vision {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 30px;
    }
    
    .mv-card {
        background: #fff;
        padding: 50px 40px;
        border-radius: 20px;
        text-align: center;
        box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        transition: all 0.3s;
    }
    
    .mv-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 15px 40px rgba(0,0,0,0.15);
    }
    
    .mv-icon {
        width: 100px;
        height: 100px;
        margin: 0 auto 30px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 48px;
        color: #fff;
    }
    
    .mv-card h3 {
        font-size: 28px;
        margin-bottom: 20px;
        color: #333;
    }
    
    .mv-card p {
        font-size: 16px;
        line-height: 1.8;
        color: #666;
    }
    
    .statistics {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        padding: 80px 60px;
        border-radius: 20px;
        color: #fff;
    }
    
    .statistics h2 {
        color: #fff;
    }
    
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 40px;
    }
    
    .stat-item {
        text-align: center;
    }
    
    .stat-number {
        font-size: 56px;
        font-weight: bold;
        margin-bottom: 10px;
    }
    
    .stat-label {
        font-size: 18px;
        opacity: 0.9;
    }
    
    .timeline-container {
        position: relative;
        padding: 40px 0;
    }
    
    .timeline-container::before {
        content: '';
        /* position: absolute;
        left: 50%;
        top: 0;
        bottom: 0;
        width: 4px;
        background: #e71a0f;
        transform: translateX(-50%); */
    }
    
    .timeline-item {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 60px;
        margin-bottom: 60px;
        position: relative;
    }
    
    .timeline-item:nth-child(even) .timeline-year {
        order: 2;
    }
    
    .timeline-item:nth-child(even) .timeline-content {
        text-align: right;
    }
    
    .timeline-year {
        font-size: 48px;
        font-weight: bold;
        color: #e71a0f;
        display: flex;
        align-items: center;
        justify-content: flex-end;
    }
    
    .timeline-content {
        background: #fff;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.08);
    }
    
    .timeline-content h4 {
        font-size: 24px;
        margin-bottom: 10px;
        color: #333;
    }
    
    .tech-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 30px;
    }
    
    .tech-card {
        background: #fff;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        transition: all 0.3s;
    }
    
    .tech-card:hover {
        transform: translateY(-10px);
    }
    
    .tech-card img {
        width: 100%;
        height: 200px;
        object-fit: cover;
    }
    
    .tech-card h4 {
        font-size: 20px;
        padding: 20px;
        color: #333;
    }
    
    .tech-card p {
        padding: 0 20px 20px;
        color: #666;
    }
    
    .team-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 40px;
    }
    
    .team-member {
        background: #fff;
        padding: 40px;
        border-radius: 20px;
        text-align: center;
        box-shadow: 0 5px 20px rgba(0,0,0,0.08);
    }
    
    .member-photo {
        width: 150px;
        height: 150px;
        margin: 0 auto 25px;
        border-radius: 50%;
        overflow: hidden;
        border: 5px solid #e71a0f;
    }
    
    .member-photo img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    .member-role {
        color: #e71a0f;
        font-weight: bold;
        margin: 10px 0;
    }
    
    .cta-section {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        padding: 80px;
        border-radius: 20px;
        text-align: center;
        color: #fff;
    }
    
    .cta-section h2 {
        color: #fff;
        margin-bottom: 20px;
    }
    
    .cta-section p {
        font-size: 20px;
        margin-bottom: 40px;
    }
    
    .cta-buttons {
        display: flex;
        gap: 20px;
        justify-content: center;
    }
    
    .btn-primary,
    .btn-secondary {
        padding: 18px 45px;
        border-radius: 30px;
        text-decoration: none;
        font-weight: bold;
        font-size: 18px;
        transition: all 0.3s;
    }
    
    .btn-primary {
        background: #e71a0f;
        color: #fff;
    }
    
    .btn-secondary {
        background: #fff;
        color: #333;
    }
    
    @media (max-width: 1024px) {
        .about-intro,
        .stats-grid,
        .tech-grid,
        .team-grid,
        .awards-list {
            grid-template-columns: 1fr;
        }
        
        .mission-vision {
            grid-template-columns: 1fr;
        }
        
        .partner-logos {
            grid-template-columns: repeat(3, 1fr);
        }
    }
</style>
</body>
</html>