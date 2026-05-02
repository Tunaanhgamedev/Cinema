package com.cinema.utils;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {
	private static final Properties props = new Properties();
	private static HikariDataSource ds;

	static {
		try {
			Properties localProps = new Properties();
			try (InputStream is = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
				if (is != null) {
					localProps.load(is);
					System.out.println("✅ Đã nạp file db.properties thành công.");
				} else {
					throw new RuntimeException("CRITICAL: Không tìm thấy file db.properties trong classpath!");
				}
			}

			String host = localProps.getProperty("db.host");
			String port = localProps.getProperty("db.port");
			String dbName = localProps.getProperty("db.name");
			String user = localProps.getProperty("db.user");
			String pass = localProps.getProperty("db.pass");

			if (host == null || dbName == null) {
				throw new RuntimeException("CRITICAL: Thiếu thông tin cấu hình db.host hoặc db.name trong db.properties!");
			}

			// URL Cloud yêu cầu SSL
			String url = "jdbc:mysql://" + host + ":" + port + "/" + dbName 
					+ "?useSSL=true&requireSSL=true&ssl-mode=REQUIRED&allowPublicKeyRetrieval=true&serverTimezone=UTC";

			System.out.println("📡 Đang khởi tạo kết nối tới: " + host + ":" + port + "/" + dbName);

			HikariConfig config = new HikariConfig();
			config.setJdbcUrl(url);
			config.setUsername(user);
			config.setPassword(pass);
			config.setDriverClassName("com.mysql.cj.jdbc.Driver");

			// Tối ưu hóa hiệu năng
			config.addDataSourceProperty("cachePrepStmts", "true");
			config.addDataSourceProperty("prepStmtCacheSize", "250");
			config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
			config.addDataSourceProperty("useServerPrepStmts", "true");
			
			// Cấu hình Pool
			config.setMaximumPoolSize(10);
			config.setMinimumIdle(2);
			config.setConnectionTimeout(30000);

			ds = new HikariDataSource(config);
			System.out.println("✨ Connection Pool đã được khởi tạo thành công.");
		} catch (Exception e) {
			System.err.println("❌ Khởi tạo Connection Pool THẤT BẠI!");
			e.printStackTrace();
			// Lưu vết lỗi để getConnection() có thể báo cáo
		}
	}

	public static Connection getConnection() throws SQLException {
		if (ds == null) {
			throw new SQLException("DataSource chưa được khởi tạo!");
		}
		return ds.getConnection();
	}

	// Đóng Pool khi ứng dụng tắt (tùy chọn)
	public static void closePool() {
		if (ds != null) {
			ds.close();
		}
	}
}
