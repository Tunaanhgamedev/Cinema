# BOBIXI Cinema - Premium Ticket Booking & Management Platform

[![Java Version](https://img.shields.io/badge/Java-17%2B-orange.svg)](https://www.oracle.com/java/)
[![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-10-blue.svg)](https://jakarta.ee/)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)]()
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

BOBIXI Cinema is a modern, enterprise-grade movie ticket booking and theater management system built on the **Jakarta EE 10** platform. Utilizing an MVC design pattern, it integrates real-time interactions via **WebSockets**, modern responsive frontends, and a smart generative AI virtual assistant (**BobiBot AI**).

---

## 🌟 Outstanding Business Features

### 🎬 Client-Facing Experience
*   **Dynamic Showtime Search & Filtering**: Customers can search for movies in real-time, filter by screening formats (2D, 3D, IMAX), languages (subbed, dubbed), and sort dynamically by rating or popularity.
*   **WebSocket Real-Time Seat Selection**: Prevents double-booking by locking and unlocking seats across all active clients in real-time using full-duplex WebSocket connections.
*   **Popcorn & Beverage Combo Booking**: Integrated F&B service allow users to order single/couple combos or limited-edition theme packs (e.g., My Melody & Kuromi).
*   **Promotional Voucher Engine**: Discount processing supporting fixed-amount or percentage discounts with minimum order value validation.
*   **Simulated Secure Checkout & E-Ticket**: Comprehensive billing/invoicing flow with simulated payments (Cash, MoMo, VNPay) and auto-generated ticket codes.
*   **Loyalty Points & Membership Levels**: User accounts accumulate loyalty points on checkout to upgrade membership tiers (Bronze, Silver, Gold, Platinum).
*   **BobiBot - Generative AI Assistant**: 
    *   Powered by Google Gemini 1.5 Flash.
    *   Context-aware conversations (remembers the last discussed movie/topic in session).
    *   Proactive marketing (recommends movies based on user mood/keywords, offers discount codes dynamically).
    *   BFF (Best Friend Forever) conversational style tailored for modern Vietnamese audiences.
    *   Local offline fallback model using keyword mapping if Gemini API is unreachable.

### 🛡️ Administrative Dashboard
*   **Operational Analytics**: High-level statistics on daily/monthly revenue, ticket sales, room utilization rates, and recent order history.
*   **Movie Catalog Management**: Full CRUD operations for movies, including poster uploads, trailers, and status configurations (Coming Soon, Now Showing, Stop Showing).
*   **Screening & Showtime Scheduler**: Drag-and-drop-style showtime manager preventing double-booking rooms or overlapping movie times.
*   **Seat Price Configuration**: Dynamically manage base ticket surcharges by seat classification (Normal, VIP, Couple).
*   **Promotion & Voucher Manager**: Issue, edit, and track usage statistics of promotion codes.
*   **Customer Inquiry Portal**: Manage and respond to inquiries, reviews, and ratings.

---

## 🏗️ Technical Architecture & Technology Stack

The platform is designed around clean MVC (Model-View-Controller) principles, separating concerns between representation, business logic, and database access:

```
[ Client Browser ] <--- WebSocket (Real-Time Seats) ---> [ SeatWebSocket ]
       |                                                         |
  HTTP Request / Response                                    Broadcasting
       |                                                         |
[ Front-Controller / Servlets ] <=========================> [ Concurrent Sets ]
       |
[ Service Layer & DAOs ] <--- HikariCP (Connection Pool) ---> [ MySQL Database ]
       |
[ Google Gemini API ] (Generative AI Integration)
```

### Backend Architecture
*   **Language**: Java 17
*   **Core Framework**: Jakarta Servlet 6.0, JSP 3.0, WebSocket 2.1
*   **Database Access**: Plain JDBC with DAO pattern (data access objects)
*   **Connection Pooling**: HikariCP 5.1.0 for high-performance connection reuse
*   **Security**: jBCrypt 0.4 for cryptographic hashing of user passwords
*   **Data Serialization**: Google Gson 2.10.1
*   **Mailer Service**: Jakarta Mail 2.1 / Angus Mail 2.0.2

### Frontend Architecture
*   **Templates**: JavaServer Pages (JSP) with JSTL 3.0 (Jakarta namespace)
*   **Styles & UI**: CSS3, Tailwind CSS integration (Admin layout), FontAwesome icons
*   **Client Logic**: Vanilla JS, Fetch API for asynchronous AJAX calls

---

## 💾 Database Schema

The database model consists of 8 primary tables organized to optimize transaction performance and ensure referential integrity:

| Table Name | Description | Key Relationships |
| :--- | :--- | :--- |
| `users` | Customer and administrator profiles, roles, and loyalty points. | |
| `cinemas` | Physical theater branch details. | Parent of `rooms` |
| `rooms` | Hall configurations inside theaters. | Child of `cinemas`, Parent of `seats` & `showtimes` |
| `seat_prices` | Base pricing configurations and surcharges by seat type. | Referenced by `seats` |
| `seats` | Individual physical seats inside halls (NORMAL, VIP, COUPLE). | Child of `rooms` |
| `movies` | Movie titles, descriptions, status, genres, and metadata. | Parent of `showtimes` & `reviews` |
| `showtimes` | Allocated movie screening sessions with times and prices. | Child of `movies` & `rooms` |
| `vouchers` | Promotional codes with discount values and expiration ranges. | Optional child of `users` |
| `bookings` | Customer ticket purchase transactions. | Child of `users` & `showtimes` |
| `booking_seat` | Many-to-many relationship mapping seats to bookings. | Child of `bookings` & `seats` |
| `combos` | Food and Beverage combos. | |
| `booking_combo` | Many-to-many relationship mapping ordered F&B combos to bookings. | Child of `bookings` & `combos` |
| `payments` | Records of transaction payments, channels, and statuses. | Child of `bookings` |
| `contact` | Customer support contact messages. | |
| `reviews` | Movie ratings and comments left by users. | Child of `movies` & `users` |
| `banners` | Marketing advertisements displayed on the portal. | |

---

## ⚙️ Installation & Configuration

### Prerequisites
*   **Java Development Kit (JDK)**: Version 17 or higher
*   **Apache Maven**: Version 3.8+
*   **Database**: MySQL Server 8.0+
*   **Servlet Container**: Apache Tomcat 10.1+ (Supporting Jakarta EE 10)

### 1. Database Setup
Execute the initialization script to prepare the schema and core configuration values:
```bash
mysql -u your_username -p defaultdb < sql/table.sql
```

### 2. Configuration Properties
Ensure the following files are properly configured inside the `src/main/resources/` directory:

#### `db.properties`
Configure your connection string, credentials, and SMTP settings for the mail client:
```properties
db.host=your-database-host
db.port=3306
db.name=defaultdb
db.user=your-username
db.pass=your-password

# Email Configuration (SMTP)
mail.user=your-system-email@gmail.com
mail.pass=your-app-password
```

#### `config.properties`
Provide your Google Gemini API Key to enable the BobiBot AI Assistant:
```properties
gemini.api.key=YOUR_GEMINI_API_KEY
```

---

## 🚀 Build & Deployment

To compile the application packaging it into a standard Web Application Archive (`.war`):

### 1. Clean and Compile
```bash
mvn clean compile
```

### 2. Package the Application
```bash
mvn package
```
This produces the artifact `target/Cinema.war`.

### 3. Deploy to Tomcat
1. Copy `target/Cinema.war` into the `webapps` directory of your Apache Tomcat 10.1+ installation.
2. Start Tomcat using:
   * **Windows**: `bin/startup.bat`
   * **Linux/macOS**: `bin/startup.sh`
3. Access the application at `http://localhost:8080/Cinema`.

---

## 📂 Project Structure

```
Cinema/
├── .github/                 # CI/CD Workflows
├── sql/
│   └── table.sql            # Master database schema script
├── src/
│   └── main/
│       ├── java/com/cinema/
│       │   ├── controller/  # Servlets handling requests (Admin/User)
│       │   ├── dao/         # Data Access Objects (JDBC logic)
│       │   ├── model/       # Entity POJOs mapping DB tables
│       │   ├── filter/      # Request filters (Authentication, Encoding)
│       │   ├── service/     # Business logic helpers
│       │   └── utils/       # Utility helper classes (Password hashing, DB connections)
│       ├── resources/
│       │   ├── db.properties
│       │   └── config.properties
│       └── webapp/
│           ├── assets/      # Static resources (CSS, JS, Images)
│           ├── common/      # Shared JSP components (Header, Footer, Sidebar)
│           └── pages/       # Screen views (User/Admin JSPs)
└── pom.xml                  # Maven project descriptor
```

---

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
