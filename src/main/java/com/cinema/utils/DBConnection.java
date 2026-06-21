package com.cinema.utils;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBConnection {
	private static final Properties props = new Properties();

	static {
		try (InputStream is = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
			if (is != null) {
				props.load(is);
			} else {
				System.err.println("Không tìm thấy file db.properties!");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static Connection getConnection() {
		try {
			String host = props.getProperty("db.host", "localhost");
			String port = props.getProperty("db.port", "3306");
			String dbName = props.getProperty("db.name", "cinema_db");
			String user = props.getProperty("db.user", "root");
			String pass = props.getProperty("db.pass", "");

			// URL Cloud yêu cầu SSL
			String url = "jdbc:mysql://" + host + ":" + port + "/" + dbName 
					+ "?useSSL=true&requireSSL=true&ssl-mode=REQUIRED";

			Class.forName("com.mysql.cj.jdbc.Driver");
			return DriverManager.getConnection(url, user, pass);
		} catch (Exception e) {
			System.err.println("Kết nối Database thất bại: " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
}
