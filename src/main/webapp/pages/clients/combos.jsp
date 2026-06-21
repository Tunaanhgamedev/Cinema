<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>THỰC ĐƠN COMBO | BOBIXI Cinema</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800;900&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        :root {
            --primary: #6366f1;
            --secondary: #a855f7;
            --dark: #0f172a;
            --glass: rgba(255, 255, 255, 0.03);
            --border: rgba(255, 255, 255, 0.1);
        }

        body {
            font-family: 'Outfit', sans-serif;
            background-color: #0b0f1a;
            color: #f8fafc;
        }

        .hero-section {
            height: 400px;
            background: linear-gradient(rgba(15, 23, 42, 0.7), rgba(15, 23, 42, 0.9)), 
                        url('https://images.unsplash.com/photo-1513106580091-1d82408b8cd6?q=80&w=2076&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .combo-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 30px;
            padding: 60px 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .combo-card {
            background: var(--glass);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border);
            border-radius: 40px;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            display: flex;
            flex-direction: column;
        }

        .combo-card:hover {
            transform: translateY(-12px);
            border-color: var(--primary);
            box-shadow: 0 25px 50px -12px rgba(99, 102, 241, 0.25);
        }

        .combo-img {
            height: 240px;
            overflow: hidden;
            position: relative;
        }

        .combo-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }

        .combo-card:hover .combo-img img {
            transform: scale(1.1);
        }

        .combo-tag {
            position: absolute;
            top: 20px;
            right: 20px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: #fff;
            padding: 6px 16px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 800;
            text-transform: uppercase;
            box-shadow: 0 10px 20px rgba(99, 102, 241, 0.3);
        }

        .combo-info {
            padding: 30px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .combo-info h3 {
            font-size: 24px;
            font-weight: 900;
            margin-bottom: 12px;
            color: #fff;
        }

        .combo-info p {
            color: #94a3b8;
            font-size: 15px;
            line-height: 1.6;
            margin-bottom: 24px;
        }

        .combo-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: auto;
        }

        .price {
            font-size: 24px;
            font-weight: 900;
            color: #fff;
        }

        .btn-order {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--border);
            color: #fff;
            padding: 12px 24px;
            border-radius: 16px;
            font-weight: 700;
            transition: all 0.3s;
            text-decoration: none;
        }

        .btn-order:hover {
            background: #fff;
            color: var(--dark);
        }

        .promo-banner {
            max-width: 1200px;
            margin: 40px auto;
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            border: 1px solid rgba(215, 177, 96, 0.3);
            border-radius: 40px;
            padding: 60px;
            display: flex;
            align-items: center;
            gap: 40px;
            position: relative;
            overflow: hidden;
        }

        .promo-banner::before {
            content: '';
            position: absolute;
            top: -100px;
            right: -100px;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, rgba(215, 177, 96, 0.1) 0%, transparent 70%);
        }

        .promo-text h2 {
            font-size: 40px;
            font-weight: 900;
            margin-bottom: 16px;
            background: linear-gradient(to right, #fff, #d7b160);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .promo-text p {
            color: #94a3b8;
            font-size: 18px;
            max-width: 600px;
        }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp" />

    <section class="hero-section">
        <div>
            <h1 class="text-6xl font-black italic uppercase tracking-tighter text-white mb-4">Popcorn & Drinks</h1>
            <p class="text-xl text-slate-400 font-medium">Combo hoàn hảo cho trải nghiệm điện ảnh tuyệt vời nhất</p>
        </div>
    </section>

    <div class="container mx-auto">
        <div class="combo-grid">
            <c:forEach var="c" items="${comboList}">
                <div class="combo-card">
                    <div class="combo-img">
                        <img src="${c.imageUrl != null && c.imageUrl != '' ? c.imageUrl : 'https://images.unsplash.com/photo-1572177191856-3cde6403ec1b?q=80&w=1000'}" alt="${c.name}">
                        <c:if test="${c.price < 100000}">
                            <span class="combo-tag">Giá rẻ</span>
                        </c:if>
                        <c:if test="${c.price >= 150000}">
                            <span class="combo-tag">Premium</span>
                        </c:if>
                    </div>
                    <div class="combo-info">
                        <h3>${c.name}</h3>
                        <p>${c.description}</p>
                        <div class="combo-footer">
                            <div class="price"><fmt:formatNumber value="${c.price}" type="currency" currencySymbol="" />đ</div>
                            <a href="${pageContext.request.contextPath}/booking-seat" class="btn-order">Đặt ngay</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="promo-banner">
            <div class="promo-text">
                <h2>Hội viên BOBIXI Loyalty</h2>
                <p>Đăng ký ngay hôm nay để được giảm giá tới 15% cho tất cả các loại bắp nước và tích điểm đổi quà không giới hạn.</p>
                <div class="mt-10 flex gap-4">
                    <a href="${pageContext.request.contextPath}/register" class="px-8 py-4 bg-white text-slate-900 rounded-2xl font-black uppercase tracking-widest hover:bg-amber-400 transition-colors">Đăng ký ngay</a>
                    <a href="${pageContext.request.contextPath}/contact" class="px-8 py-4 bg-white/5 border border-white/10 rounded-2xl font-black uppercase tracking-widest hover:bg-white/10 transition-colors">Tìm hiểu thêm</a>
                </div>
            </div>
            <div class="hidden lg:block">
                <i class="fas fa-crown text-[120px] text-amber-500/20"></i>
            </div>
        </div>
    </div>

    <jsp:include page="/common/footer.jsp" />
</body>
</html>
