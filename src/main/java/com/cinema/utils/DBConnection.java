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
		try (InputStream is = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
			if (is != null) {
				props.load(is);
			} else {
				System.err.println("Không tìm thấy file db.properties!");
			}

			String host = props.getProperty("db.host", "localhost");
			String port = props.getProperty("db.port", "3306");
			String dbName = props.getProperty("db.name", "cinema_db");
			String user = props.getProperty("db.user", "root");
			String pass = props.getProperty("db.pass", "");

			// URL Cloud yêu cầu SSL
			String url = "jdbc:mysql://" + host + ":" + port + "/" + dbName 
					+ "?useSSL=true&requireSSL=true&ssl-mode=REQUIRED";

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
			config.setIdleTimeout(300000);
			config.setConnectionTimeout(30000);

			ds = new HikariDataSource(config);
		} catch (Exception e) {
			System.err.println("Khởi tạo Connection Pool thất bại!");
			e.printStackTrace();
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
