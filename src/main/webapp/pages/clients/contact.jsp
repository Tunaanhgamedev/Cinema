<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>LIÊN HỆ | BOBIXI Cinema</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800;900&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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

        .contact-page { padding-bottom: 80px; }

        .page-header {
            height: 450px;
            background: linear-gradient(rgba(15, 23, 42, 0.7), rgba(15, 23, 42, 0.9)), 
                        url('https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?q=80&w=2070&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            position: relative;
            margin-bottom: -100px;
        }

        .header-content h1 {
            font-size: 64px;
            font-weight: 900;
            letter-spacing: -2px;
            text-transform: uppercase;
            background: linear-gradient(to right, #fff, #94a3b8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
        }

        .header-content p { font-size: 20px; color: #94a3b8; font-weight: 400; }

        .contact-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            position: relative;
            z-index: 10;
        }

        .quick-contact {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
            margin-bottom: 60px;
        }

        .contact-card {
            background: var(--glass);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border);
            padding: 40px;
            border-radius: 32px;
            text-align: center;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .contact-card:hover {
            transform: translateY(-10px);
            border-color: var(--primary);
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
        }

        .card-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 24px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            color: #fff;
            box-shadow: 0 10px 20px rgba(99, 102, 241, 0.3);
        }

        .contact-card h3 { font-size: 18px; font-weight: 800; color: #94a3b8; text-transform: uppercase; letter-spacing: 2px; margin-bottom: 12px; }
        .highlight { font-size: 24px; font-weight: 900; color: #fff; margin-bottom: 8px; }
        .highlight a { color: #fff; text-decoration: none; transition: color 0.3s; }
        .highlight a:hover { color: var(--primary); }
        .sub-text { color: #64748b; font-size: 14px; font-weight: 500; }

        .contact-form-section {
            display: grid;
            grid-template-columns: 1.5fr 1fr;
            gap: 40px;
            margin-bottom: 80px;
        }

        .form-wrapper {
            background: var(--glass);
            backdrop-filter: blur(20px);
            padding: 60px;
            border-radius: 40px;
            border: 1px solid var(--border);
        }

        .form-wrapper h2 { font-size: 40px; font-weight: 900; margin-bottom: 16px; letter-spacing: -1px; }
        .form-description { color: #94a3b8; font-size: 16px; margin-bottom: 40px; }

        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; }
        .form-group { margin-bottom: 24px; }
        .form-group label { display: block; margin-bottom: 10px; font-weight: 600; color: #cbd5e1; font-size: 14px; }
        
        .form-control {
            background: rgba(15, 23, 42, 0.5);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 16px 20px;
            color: #fff;
            width: 100%;
            transition: all 0.3s;
        }

        .form-control:focus {
            background: rgba(15, 23, 42, 0.8);
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
            outline: none;
        }

        .btn-submit {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: #fff;
            border: none;
            border-radius: 20px;
            padding: 18px 40px;
            font-size: 16px;
            font-weight: 900;
            text-transform: uppercase;
            letter-spacing: 1px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            width: 100%;
        }

        .btn-submit:hover {
            transform: scale(1.02);
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.4);
        }

        .faq-quick-links {
            background: #1e293b;
            padding: 40px;
            border-radius: 40px;
            border: 1px solid var(--border);
        }

        .faq-item {
            display: flex;
            align-items: center;
            gap: 16px;
            padding: 20px;
            background: rgba(255,255,255,0.02);
            border-radius: 20px;
            margin-bottom: 12px;
            text-decoration: none;
            color: #cbd5e1;
            transition: all 0.3s;
            border: 1px solid transparent;
        }

        .faq-item:hover {
            background: rgba(99, 102, 241, 0.05);
            border-color: rgba(99, 102, 241, 0.2);
            color: #fff;
            transform: translateX(10px);
        }

        .faq-item i { color: var(--primary); font-size: 20px; }

        .map-section {
            background: var(--glass);
            padding: 60px;
            border-radius: 40px;
            border: 1px solid var(--border);
        }

        .map-container {
            border-radius: 24px;
            overflow: hidden;
            border: 1px solid var(--border);
            margin-top: 30px;
        }

        .map-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 40px;
            margin-top: 40px;
        }

        .info-item { display: flex; gap: 20px; align-items: flex-start; }
        .info-item i { font-size: 24px; color: var(--primary); margin-top: 4px; }
        .info-item strong { display: block; font-size: 18px; color: #fff; margin-bottom: 4px; }
        .info-item p { color: #94a3b8; line-height: 1.6; }

        .social-links { display: flex; gap: 12px; justify-content: center; }
        .social-btn {
            width: 44px; height: 44px; border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            color: #fff; text-decoration: none; font-size: 20px;
            background: rgba(255,255,255,0.05); transition: all 0.3s;
        }
        .social-btn:hover { background: var(--primary); transform: scale(1.1); }

        @media (max-width: 992px) {
            .contact-form-section { grid-template-columns: 1fr; }
            .form-row { grid-template-columns: 1fr; }
            .header-content h1 { font-size: 40px; }
        }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp" />

    <div class="contact-page">
        <div class="page-header">
            <div class="header-content">
                <h1>Liên hệ với chúng tôi</h1>
                <p>Mọi góp ý của bạn là động lực để BOBIXI hoàn thiện hơn mỗi ngày</p>
            </div>
        </div>

        <div class="contact-container">
            <!-- Quick Contact Info -->
            <div class="quick-contact">
                <div class="contact-card">
                    <div class="card-icon"><i class="fa-solid fa-phone-volume"></i></div>
                    <h3>Hotline 24/7</h3>
                    <p class="highlight">1900 1234</p>
                    <p class="sub-text">Hỗ trợ khách hàng toàn quốc</p>
                </div>

                <div class="contact-card">
                    <div class="card-icon"><i class="fa-regular fa-envelope"></i></div>
                    <h3>Gửi Email</h3>
                    <p class="highlight"><a href="mailto:contact@bobixi.vn">contact@bobixi.vn</a></p>
                    <p class="sub-text">Phản hồi trong vòng 2 giờ</p>
                </div>

                <div class="contact-card">
                    <div class="card-icon"><i class="fa-solid fa-share-nodes"></i></div>
                    <h3>Kết nối ngay</h3>
                    <div class="social-links mt-3">
                        <a href="#" class="social-btn"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social-btn"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="social-btn"><i class="fab fa-tiktok"></i></a>
                        <a href="#" class="social-btn"><i class="fab fa-youtube"></i></a>
                    </div>
                    <p class="sub-text mt-3">Theo dõi tin tức mới nhất</p>
                </div>
            </div>

            <!-- Form & FAQ -->
            <div class="contact-form-section">
                <div class="form-wrapper">
                    <h2>Gửi thông điệp</h2>
                    <p class="form-description">Chúng tôi sẽ rất hạnh phúc nếu nhận được phản hồi từ bạn.</p>

                    <form action="${pageContext.request.contextPath}/contact/send" method="post">
                        <div class="form-row">
                            <div class="form-group">
                                <label>Họ và tên</label>
                                <input type="text" name="fullName" class="form-control" placeholder="Họ tên của bạn" required>
                            </div>
                            <div class="form-group">
                                <label>Địa chỉ Email</label>
                                <input type="email" name="email" class="form-control" placeholder="email@example.com" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Số điện thoại</label>
                                <input type="tel" name="phone" class="form-control" placeholder="09xx xxx xxx" required>
                            </div>
                            <div class="form-group">
                                <label>Chủ đề liên hệ</label>
                                <select name="subject" class="form-control" required>
                                    <option value="">-- Chọn chủ đề --</option>
                                    <option value="booking">Đặt vé & Thanh toán</option>
                                    <option value="member">Thành viên & Điểm thưởng</option>
                                    <option value="feedback">Góp ý dịch vụ</option>
                                    <option value="other">Vấn đề khác</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Nội dung chi tiết</label>
                            <textarea name="message" class="form-control" rows="5" placeholder="Bạn muốn nói gì với chúng tôi?" required></textarea>
                        </div>

                        <button type="submit" class="btn-submit">
                            Gửi yêu cầu ngay <i class="fa-solid fa-paper-plane"></i>
                        </button>
                    </form>
                </div>

                <div class="faq-quick-links">
                    <h3 class="text-xl font-bold mb-6 text-white uppercase italic tracking-wider">Hỗ trợ nhanh</h3>
                    <div class="faq-list">
                        <a href="#" class="faq-item">
                            <i class="fas fa-ticket-alt"></i>
                            <div>
                                <div class="font-bold text-white">Cách đặt vé online?</div>
                                <div class="text-xs opacity-60">Xem hướng dẫn từng bước</div>
                            </div>
                        </a>
                        <a href="#" class="faq-item">
                            <i class="fas fa-credit-card"></i>
                            <div>
                                <div class="font-bold text-white">Thanh toán VNPay/Momo?</div>
                                <div class="text-xs opacity-60">Các lỗi thường gặp</div>
                            </div>
                        </a>
                        <a href="#" class="faq-item">
                            <i class="fas fa-gift"></i>
                            <div>
                                <div class="font-bold text-white">Hạng thành viên?</div>
                                <div class="text-xs opacity-60">Quyền lợi các cấp bậc</div>
                            </div>
                        </a>
                        <a href="#" class="faq-item">
                            <i class="fas fa-undo"></i>
                            <div>
                                <div class="font-bold text-white">Chính sách hoàn vé?</div>
                                <div class="text-xs opacity-60">Điều kiện và thời gian</div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Map Section -->
            <div class="map-section">
                <h2 class="italic uppercase font-black">Tìm chúng tôi tại Đà Nẵng</h2>
                <div class="map-container">
                    <iframe 
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m12!1m3!1d3833.8966831411516!2d108.14836931535787!3d16.07588888887641!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314218d6bc080499%3A0x6b3f93c6628b0304!2zQsOhY2ggS2hvYSAtIMSQ4bqhaSBo4buNYyDEkMOgIE7hurVuZw!5e0!3m2!1svi!2s!4v1714650000000!5m2!1svi!2s" 
                        width="100%" height="450" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                </div>
                <div class="map-info">
                    <div class="info-item">
                        <i class="fa-solid fa-location-dot"></i>
                        <div>
                            <strong>Trụ sở chính</strong>
                            <p>Số 54 Nguyễn Lương Bằng, Hòa Khánh Bắc, Liên Chiểu, Đà Nẵng</p>
                        </div>
                    </div>
                    <div class="info-item">
                        <i class="fa-solid fa-clock"></i>
                        <div>
                            <strong>Thời gian làm việc</strong>
                            <p>Thứ 2 - Chủ Nhật: 08:00 - 22:00 (Kể cả ngày lễ)</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/common/footer.jsp" />
</body>
</html>
