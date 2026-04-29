create database cinema_db;
use cinema_db;

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


