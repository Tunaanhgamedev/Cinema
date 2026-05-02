CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role ENUM('USER','ADMIN') DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_of_birth DATE NULL,
    gender ENUM('MALE','FEMALE','OTHER') NULL,
    address VARCHAR(255) NULL,
    subscribe_newsletter BOOLEAN DEFAULT FALSE,
    subscribe_sms BOOLEAN DEFAULT FALSE
);

CREATE TABLE cinemas (
    cinema_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(100)
);

CREATE TABLE rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    cinema_id INT NOT NULL,
    room_name VARCHAR(50),
    total_seats INT,
    FOREIGN KEY (cinema_id) REFERENCES cinemas(cinema_id)
);

CREATE TABLE seats (
    seat_id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT NOT NULL,
    seat_row CHAR(1),
    seat_number INT,
    seat_type ENUM('NORMAL','VIP', 'BOOKED', 'SELECTED', 'COUPLE') DEFAULT 'NORMAL',
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

CREATE TABLE movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    duration INT,
    release_date DATE,
    rating VARCHAR(10),
    poster VARCHAR(255),
    status ENUM('COMING_SOON', 'NOW_SHOWING', 'STOP_SHOWING') DEFAULT 'NOW_SHOWING'
);

CREATE TABLE showtimes (
    showtime_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT NOT NULL,
    room_id INT NOT NULL,
    start_time DATETIME,
    end_time DATETIME,
    price DECIMAL(10,2),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    showtime_id INT NOT NULL,
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_price DECIMAL(10,2),
    status ENUM('PENDING','PAID','CANCELLED') DEFAULT 'PENDING',
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (showtime_id) REFERENCES showtimes(showtime_id)
);

CREATE TABLE booking_seat (
    booking_id INT,
    seat_id INT,
    PRIMARY KEY (booking_id, seat_id),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (seat_id) REFERENCES seats(seat_id)
);

CREATE TABLE combos (
    combo_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    description TEXT NULL
);

CREATE TABLE booking_combo (
    booking_id INT,
    combo_id INT,
    quantity INT,
    PRIMARY KEY (booking_id, combo_id),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (combo_id) REFERENCES combos(combo_id)
);

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    method ENUM('CASH','MOMO','VNPAY'),
    payment_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('SUCCESS','FAILED') DEFAULT 'SUCCESS',
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

CREATE TABLE contact (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    phone_number VARCHAR(20),
    email VARCHAR(100),
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('NEW','REPLIED') DEFAULT 'NEW'
);

CREATE TABLE banners (
    banner_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150),
    image_url VARCHAR(255) NOT NULL,
    link_url VARCHAR(255),
    position ENUM('LEFT','RIGHT','HEADER','SLIDER') NOT NULL,
    status ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE movies 
ADD COLUMN genre VARCHAR(255) AFTER status,
ADD COLUMN trailer_url VARCHAR(500) AFTER genre,
ADD COLUMN director VARCHAR(255) AFTER trailer_url,
ADD COLUMN cast TEXT AFTER director;

ALTER TABLE combos 
ADD COLUMN image_url VARCHAR(500) AFTER description;
-- Đảm bảo cột price có định dạng tiền tệ chuẩn
ALTER TABLE showtimes MODIFY COLUMN price DECIMAL(10,2);

-- Thêm bảng quy định phụ phí theo loại ghế
CREATE TABLE seat_prices (
    seat_type ENUM('NORMAL','VIP', 'COUPLE') PRIMARY KEY,
    surcharge DECIMAL(10,2) DEFAULT 0 -- Ví dụ: NORMAL: 0, VIP: +20.000, COUPLE: +50.000
);
ALTER TABLE seats 
ADD COLUMN grid_row INT,    -- Tọa độ Y trên lưới UI
ADD COLUMN grid_col INT;    -- Tọa độ X trên lưới UI

ALTER TABLE booking_seat 
ADD COLUMN ticket_code VARCHAR(50) UNIQUE; -- VD: BXI-1A2B3C (Tạo ngẫu nhiên bằng UUID)

CREATE TABLE vouchers (
    voucher_id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(20) UNIQUE NOT NULL, -- Ví dụ: BOBIXI50
    discount_value DECIMAL(10,2),     -- Giảm 50.000đ
    discount_type ENUM('PERCENT', 'FIXED_AMOUNT'),
    min_order_value DECIMAL(10,2),    -- Đơn tối thiểu
    valid_from DATETIME,
    valid_to DATETIME,
    is_active BOOLEAN DEFAULT TRUE,
    user_id INT NULL,                 -- ID người dùng sở hữu (nếu là voucher cá nhân)
    is_used BOOLEAN DEFAULT FALSE,    -- Trạng thái đã sử dụng
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
ALTER TABLE payments 
ADD COLUMN transaction_id VARCHAR(100), -- Mã giao dịch từ VNPay/Momo trả về
ADD COLUMN payment_url TEXT;            -- Lưu lại URL thanh toán nếu khách chưa quét ngay

-- 1. Thêm cột màu sắc nếu chưa có
ALTER TABLE seat_prices ADD COLUMN color_hex VARCHAR(20) DEFAULT '#FFFFFF';

-- 2. Đổ dữ liệu mẫu (Surcharge: Phụ phí cộng thêm vào giá gốc)
INSERT INTO seat_prices (seat_type, surcharge, color_hex) VALUES 
('NORMAL', 0, '#94a3b8'),
('VIP', 20000, '#f59e0b'),
('COUPLE', 50000, '#f43f5e')
ON DUPLICATE KEY UPDATE surcharge = VALUES(surcharge), color_hex = VALUES(color_hex);

-- Thêm cột ngày chiếu riêng biệt
ALTER TABLE showtimes ADD COLUMN show_date DATE AFTER room_id;

-- Cập nhật dữ liệu từ start_time sang show_date
UPDATE showtimes SET show_date = DATE(start_time);

-- 3. Đặt NOT NULL cho cột này sau khi đã cập nhật dữ liệu
ALTER TABLE showtimes MODIFY COLUMN show_date DATE NOT NULL;

-- Đảm bảo index để truy vấn nhanh
-- Thêm cột discount_amount vào bookings
ALTER TABLE bookings ADD COLUMN discount_amount DECIMAL(10,2) DEFAULT 0 AFTER total_price;
ALTER TABLE bookings CHANGE COLUMN booking_time booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE users ADD COLUMN points INT DEFAULT 0;
ALTER TABLE users ADD COLUMN membership_level VARCHAR(20) DEFAULT 'BRONZE';

ALTER TABLE vouchers ADD COLUMN user_id INT NULL, ADD COLUMN is_used BOOLEAN DEFAULT FALSE;
ALTER TABLE vouchers ADD CONSTRAINT fk_voucher_user FOREIGN KEY (user_id) REFERENCES users(user_id);
