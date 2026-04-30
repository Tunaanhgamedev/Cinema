<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="faq-page">
    <div class="page-header">
        <h1>Câu hỏi thường gặp</h1>
        <p>Tìm câu trả lời cho những thắc mắc của bạn</p>
    </div>
    
    <div class="faq-container">
        <!-- Search Box -->
        <div class="faq-search">
            <input type="text" 
                   id="faq-search-input" 
                   placeholder="Tìm kiếm câu hỏi..." 
                   onkeyup="searchFAQ()" />
            <i class="icon-search"></i>
        </div>
        
        <!-- FAQ Categories -->
        <div class="faq-categories">
            <button class="category-btn active" data-category="all" onclick="filterCategory('all')">
                Tất cả
            </button>
            <button class="category-btn" data-category="booking" onclick="filterCategory('booking')">
                Đặt vé
            </button>
            <button class="category-btn" data-category="payment" onclick="filterCategory('payment')">
                Thanh toán
            </button>
            <button class="category-btn" data-category="membership" onclick="filterCategory('membership')">
                Thành viên
            </button>
            <button class="category-btn" data-category="cinema" onclick="filterCategory('cinema')">
                Rạp chiếu
            </button>
            <button class="category-btn" data-category="promotion" onclick="filterCategory('promotion')">
                Khuyến mãi
            </button>
            <button class="category-btn" data-category="other" onclick="filterCategory('other')">
                Khác
            </button>
        </div>
        
        <!-- FAQ List -->
        <div class="faq-list">
            <!-- Booking Questions -->
            <div class="faq-category-section" id="booking">
                <h2>Đặt vé</h2>
                
                <div class="faq-item" data-category="booking">
                    <div class="faq-question" onclick="toggleFAQ(this)">
                        <h3>Làm sao để đặt vé online?</h3>
                        <i class="icon-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>Để đặt vé online tại BOBIXI, bạn thực hiện theo các bước sau:</p>
                        <ol>
                            <li>Truy cập website hoặc tải app CGV</li>
                            <li>Chọn phim bạn muốn xem</li>
                            <li>Chọn rạp, ngày và suất chiếu</li>
                            <li>Chọn ghế ngồi</li>
                            <li>Thanh toán trực tuyến</li>
                            <li>Nhận mã QR và xuất trình tại rạp</li>
                        </ol>
                        <p>Bạn cũng có thể đăng ký tài khoản để lưu lịch sử đặt vé và tích điểm thành viên.</p>
                    </div>
                </div>
                
                <div class="faq-item" data-category="booking">
                    <div class="faq-question" onclick="toggleFAQ(this)">
                        <h3>Tôi có thể đặt vé trước bao lâu?</h3>
                        <i class="icon-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>Bạn có thể đặt vé trước tối đa 7 ngày kể từ ngày hiện tại. Lịch chiếu sẽ được cập nhật hàng ngày.</p>
                    </div>
                </div>
                
                <div class="faq-item" data-category="booking">
                    <div class="faq-question" onclick="toggleFAQ(this)">
                        <h3>Tôi có thể đặt bao nhiêu vé trong một lần?</h3>
                        <i class="icon-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>Mỗi lần đặt vé, bạn có thể đặt tối đa 8 vé cho cùng một suất chiếu.</p>
                    </div>
                </div>
            </div>
            
            <!-- Payment Questions -->
            <div class="faq-category-section" id="payment">
                <h2>Thanh toán</h2>
                
                <div class="faq-item" data-category="payment">
                    <div class="faq-question" onclick="toggleFAQ(this)">
                        <h3>BOBIXI chấp nhận những phương thức thanh toán nào?</h3>
                        <i class="icon-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>BOBIXI chấp nhận các phương thức thanh toán sau:</p>
                        <ul>
                            <li>Thẻ ATM nội địa (qua VNPay)</li>
                            <li>Ví điện tử MoMo</li>
                            <li>Thanh toán tại quầy vé</li>
                        </ul>
                    </div>
                </div>
                
                <div class="faq-item" data-category="payment">
                    <div class="faq-question" onclick="toggleFAQ(this)">
                        <h3>Có được hoàn tiền khi hủy vé không?</h3>
                        <i class="icon-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>Vé đã thanh toán thành công có thể được hủy và hoàn tiền với các điều kiện sau:</p>
                        <ul>
                            <li>Hủy trước giờ chiếu ít nhất 24 giờ: Hoàn 100% giá vé</li>
                            <li>Hủy trước giờ chiếu từ 12-24 giờ: Hoàn 50% giá vé</li>
                            <li>Hủy trước giờ chiếu dưới 12 giờ: Không hoàn tiền</li>
                        </ul>
                        <p>Phí hoàn vé: 10,000 VNĐ/vé</p>
                    </div>
                </div>
            </div>
            
            <!-- Membership Questions -->
            <div class="faq-category-section" id="membership">
                <h2>Thành viên</h2>
                
                <div class="faq-item" data-category="membership">
                    <div class="faq-question" onclick="toggleFAQ(this)">
                        <h3>Làm sao để trở thành thành viên BOBIXI?</h3>
                        <i class="icon-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>Để trở thành thành viên BOBIXI, bạn chỉ cần:</p>
                        <ol>
                            <li>Truy cập website hoặc app CGV</li>
                            <li>Click vào "Đăng ký"</li>
                            <li>Điền đầy đủ thông tin cá nhân</li>
                            <li>Xác nhận email đăng ký</li>
                        </ol>
                        <p>Việc đăng ký hoàn toàn miễn phí!</p>
                    </div>
                </div>
                
                <div class="faq-item" data-category="membership">
                    <div class="faq-question" onclick="toggleFAQ(this)">
                        <h3>Quyền lợi của thành viên BOBIXI là gì?</h3>
                        <i class="icon-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>Thành viên BOBIXI sẽ nhận được:</p>
                        <ul>
                            <li>Tích điểm từ mỗi giao dịch (1 điểm = 1,000 VNĐ)</li>
                            <li>Ưu đãi đặc biệt vào ngày sinh nhật</li>
                            <li>Giảm giá vé vào các ngày đặc biệt</li>
                            <li>Ưu tiên đặt vé sớm cho phim hot</li>
                        </ul>
                    </div>
                </div>
                
                <div class="faq-item" data-category="membership">
                    <div class="faq-question" onclick="toggleFAQ(this)">
                        <h3>Điểm tích lũy có thời hạn sử dụng không?</h3>
                        <i class="icon-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>Điểm tích lũy của bạn sẽ có hiệu lực trong vòng 12 tháng kể từ ngày tích điểm. Sau thời gian này, điểm sẽ tự động hết hạn.</p>
                    </div>
                </div>
            </div>
            
            <!-- Cinema Questions -->
            <div class="faq-category-section" id="cinema">
                <h2>Rạp chiếu</h2>
                
                <div class="faq-item" data-category="cinema">
                    <div class="faq-question" onclick="toggleFAQ(this)">
                        <h3>Tôi có thể mang đồ ăn từ bên ngoài vào rạp không?</h3>
                        <i class="icon-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>Theo quy định của rạp, khách hàng không được mang thức ăn và đồ uống từ bên ngoài vào phòng chiếu. Tại BOBIXI có quầy bắp nước với nhiều lựa chọn hấp dẫn phục vụ quý khách.</p>
                    </div>
                </div>
                
                <div class="faq-item" data-category="cinema">
                    <div class="faq-question" onclick="toggleFAQ(this)">
                        <h3>Trẻ em có cần mua vé không?</h3>
                        <i class="icon-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>Trẻ em dưới 13 tuổi phải có người lớn đi cùng khi xem phim có độ tuổi từ 13+. Trẻ em từ 2 tuổi trở lên phải mua vé xem phim.</p>
                    </div>
                </div>
            </div>
            
            <!-- Promotion Questions -->
            <div class="faq-category-section" id="promotion">
                <h2>Khuyến mãi</h2>
                
                <div class="faq-item" data-category="promotion">
                    <div class="faq-question" onclick="toggleFAQ(this)">
                        <h3>Làm sao để sử dụng mã giảm giá?</h3>
                        <i class="icon-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>Để sử dụng mã giảm giá:</p>
                        <ol>
                            <li>Thêm vé vào giỏ hàng</li>
                            <li>Tại bước thanh toán, nhập mã giảm giá vào ô "Mã khuyến mãi"</li>
                            <li>Click "Áp dụng"</li>
                            <li>Giá vé sẽ được điều chỉnh theo mức giảm giá</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Contact Support -->
        <div class="faq-support">
            <h3>Không tìm thấy câu trả lời?</h3>
            <p>Liên hệ với chúng tôi để được hỗ trợ trực tiếp</p>
            <div class="support-options">
                <a href="${pageContext.request.contextPath}/contact" class="support-btn">
                    <i class="icon-email"></i>
                    <span>Gửi câu hỏi</span>
                </a>
                <a href="tel:19006017" class="support-btn">
                    <i class="icon-phone"></i>
                    <span>Gọi 1900 1111</span>
                </a>
                <a href="#" target="_blank" class="support-btn">
                    <i class="icon-messenger"></i>
                    <span>Chat Facebook</span>
                </a>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    function toggleFAQ(element) {
        var faqItem = $j(element).parent();
        var answer = faqItem.find('.faq-answer');
        var icon = faqItem.find('.icon-chevron-down');
        
        // Close all other FAQs
        $j('.faq-item').not(faqItem).removeClass('active');
        $j('.faq-answer').not(answer).slideUp();
        $j('.icon-chevron-down').not(icon).removeClass('rotate');
        
        // Toggle current FAQ
        faqItem.toggleClass('active');
        answer.slideToggle();
        icon.toggleClass('rotate');
    }
    
    function filterCategory(category) {
        // Update active button
        $j('.category-btn').removeClass('active');
        $j('.category-btn[data-category="' + category + '"]').addClass('active');
        
        // Filter FAQs
        if (category === 'all') {
            $j('.faq-item').show();
            $j('.faq-category-section').show();
        } else {
            $j('.faq-item').hide();
            $j('.faq-item[data-category="' + category + '"]').show();
            
            // Show/hide sections
            $j('.faq-category-section').each(function() {
                if ($j(this).find('.faq-item:visible').length > 0) {
                    $j(this).show();
                } else {
                    $j(this).hide();
                }
            });
        }
    }
    
    function searchFAQ() {
        var searchTerm = $j('#faq-search-input').val().toLowerCase();
        
        $j('.faq-item').each(function() {
            var question = $j(this).find('.faq-question h3').text().toLowerCase();
            var answer = $j(this).find('.faq-answer').text().toLowerCase();
            
            if (question.includes(searchTerm) || answer.includes(searchTerm)) {
                $j(this).show();
            } else {
                $j(this).hide();
            }
        });
        
        // Show/hide sections based on visible items
        $j('.faq-category-section').each(function() {
            if ($j(this).find('.faq-item:visible').length > 0) {
                $j(this).show();
            } else {
                $j(this).hide();
            }
        });
    }
</script>

<style>
    .faq-page {
        background: #f5f5f5;
        min-height: 100vh;
    }
    
    .page-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        padding: 80px 20px;
        text-align: center;
        color: #fff;
    }
    
    .page-header h1 {
        font-size: 48px;
        margin-bottom: 15px;
    }
    
    .page-header p {
        font-size: 20px;
        opacity: 0.9;
    }
    
    .faq-container {
        max-width: 900px;
        margin: -50px auto 0;
        padding: 0 20px 80px;
    }
    
    .faq-search {
        background: #fff;
        padding: 15px 20px;
        border-radius: 30px;
        display: flex;
        align-items: center;
        gap: 15px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.15);
        margin-bottom: 40px;
    }
    
    .faq-search input {
        flex: 1;
        border: none;
        font-size: 16px;
        outline: none;
    }
    
    .faq-search i {
        color: #e71a0f;
        font-size: 24px;
    }
    
    .faq-categories {
        display: flex;
        gap: 10px;
        margin-bottom: 40px;
        overflow-x: auto;
        padding-bottom: 10px;
    }
    
    .category-btn {
        padding: 12px 25px;
        background: #fff;
        border: 2px solid #ddd;
        border-radius: 25px;
        cursor: pointer;
        transition: all 0.3s;
        white-space: nowrap;
        font-weight: 500;
    }
    
    .category-btn.active {
        background: #e71a0f;
        color: #fff;
        border-color: #e71a0f;
    }
    
    .faq-category-section {
        margin-bottom: 50px;
    }
    
    .faq-category-section h2 {
        font-size: 32px;
        margin-bottom: 25px;
        color: #333;
    }
    
    .faq-item {
        background: #fff;
        border-radius: 10px;
        margin-bottom: 15px;
        overflow: hidden;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        transition: all 0.3s;
    }
    
    .faq-item:hover {
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    
    .faq-item.active {
        box-shadow: 0 5px 20px rgba(231, 26, 15, 0.15);
    }
    
    .faq-question {
        padding: 25px 30px;
        cursor: pointer;
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 20px;
    }
    
    .faq-question h3 {
        font-size: 18px;
        color: #333;
        margin: 0;
    }
    
    .faq-question i {
        font-size: 24px;
        color: #e71a0f;
        transition: transform 0.3s;
    }
    
    .faq-question i.rotate {
        transform: rotate(180deg);
    }
    
    .faq-answer {
        padding: 0 30px 25px;
        display: none;
        color: #666;
        line-height: 1.8;
    }
    
    .faq-answer p {
        margin-bottom: 15px;
    }
    
    .faq-answer ul,
    .faq-answer ol {
        margin: 15px 0;
        padding-left: 30px;
    }
    
    .faq-answer li {
        margin-bottom: 10px;
    }
    
    .faq-support {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        padding: 60px;
        border-radius: 20px;
        text-align: center;
        color: #fff;
        margin-top: 60px;
    }
    
    .faq-support h3 {
        font-size: 32px;
        margin-bottom: 15px;
    }
    
    .faq-support p {
        font-size: 18px;
        margin-bottom: 30px;
        opacity: 0.9;
    }
    
    .support-options {
        display: flex;
        gap: 20px;
        justify-content: center;
        flex-wrap: wrap;
    }
    
    .support-btn {
        padding: 15px 30px;
        background: #fff;
        color: #333;
        text-decoration: none;
        border-radius: 30px;
        display: flex;
        align-items: center;
        gap: 10px;
        font-weight: bold;
        transition: all 0.3s;
    }
    
    .support-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 25px rgba(0,0,0,0.2);
    }
    
    .support-btn i {
        font-size: 20px;
    }
    
    @media (max-width: 768px) {
        .faq-categories {
            flex-wrap: wrap;
        }
        
        .support-options {
            flex-direction: column;
        }
        
        .support-btn {
            justify-content: center;
        }
    }
</style>
