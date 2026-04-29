package com.cinema.utils;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

	// Hash mật khẩu khi đăng ký
	public static String hash(String plainPassword) {
		if (plainPassword == null)
			plainPassword = "";
		return BCrypt.hashpw(plainPassword, BCrypt.gensalt(10));
	}

	// Kiểm tra mật khẩu khi đăng nhập
	public static boolean verify(String plainPassword, String hashedPassword) {
		if (plainPassword == null || hashedPassword == null)
			return false;
		return BCrypt.checkpw(plainPassword, hashedPassword);
	}
}
