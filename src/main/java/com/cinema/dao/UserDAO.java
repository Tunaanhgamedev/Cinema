package com.cinema.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Types;

import com.cinema.model.User;
import com.cinema.utils.DBConnection;

public class UserDAO {

	public boolean existsByEmail(String email) {
		String sql = "SELECT 1 FROM users WHERE email = ? LIMIT 1";
		try (Connection cn = DBConnection.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {

			ps.setString(1, email);

			try (ResultSet rs = ps.executeQuery()) {
				return rs.next();
			}

		} catch (Exception e) {
			throw new RuntimeException("existsByEmail failed", e);
		}
	}

	// ✅ Insert user đầy đủ các cột mới
	public int insert(User u) {
		String sql = """
				    INSERT INTO users(
				      full_name, email, password, phone_number, role,
				      date_of_birth, gender, address, subscribe_newsletter, subscribe_sms
				    )
				    VALUES(?,?,?,?,?,?,?,?,?,?)
				""";

		try (Connection cn = DBConnection.getConnection();
				PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

			ps.setString(1, u.getFullName());
			ps.setString(2, u.getEmail());
			ps.setString(3, u.getPassword()); // BCrypt hash
			ps.setString(4, u.getPhoneNumber());
			ps.setString(5, (u.getRole() == null || u.getRole().isEmpty()) ? "USER" : u.getRole());

			// date_of_birth (nullable)
			if (u.getDateOfBirth() != null)
				ps.setDate(6, u.getDateOfBirth());
			else
				ps.setNull(6, Types.DATE);

			// gender (nullable)
			if (u.getGender() != null && !u.getGender().isEmpty())
				ps.setString(7, u.getGender());
			else
				ps.setNull(7, Types.VARCHAR);

			// address (nullable)
			if (u.getAddress() != null && !u.getAddress().isEmpty())
				ps.setString(8, u.getAddress());
			else
				ps.setNull(8, Types.VARCHAR);

			// subscribe_newsletter / subscribe_sms (tinyint)
			ps.setInt(9, u.isSubscribeNewsletter() ? 1 : 0);
			ps.setInt(10, u.isSubscribeSMS() ? 1 : 0);

			int updated = ps.executeUpdate();
			if (updated != 1)
				return -1;

			try (ResultSet keys = ps.getGeneratedKeys()) {
				if (keys.next())
					return keys.getInt(1);
			}
			return -1;

		} catch (Exception e) {
			throw new RuntimeException("insert user failed", e);
		}
	}

	// (Tuỳ chọn) lấy user theo email để login sau này
	public User findByEmail(String email) {
		String sql = "SELECT * FROM users WHERE email = ? LIMIT 1";

		try (Connection cn = DBConnection.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {

			ps.setString(1, email);

			try (ResultSet rs = ps.executeQuery()) {
				if (!rs.next())
					return null;

				User u = new User();
				u.setUserId(rs.getInt("user_id"));
				u.setFullName(rs.getString("full_name"));
				u.setEmail(rs.getString("email"));
				u.setPassword(rs.getString("password"));
				u.setPhoneNumber(rs.getString("phone_number"));
				u.setRole(rs.getString("role"));
				u.setCreatedAt(rs.getTimestamp("created_at"));

				u.setDateOfBirth(rs.getDate("date_of_birth"));
				u.setGender(rs.getString("gender"));
				u.setAddress(rs.getString("address"));
				u.setSubscribeNewsletter(rs.getInt("subscribe_newsletter") == 1);
				u.setSubscribeSMS(rs.getInt("subscribe_sms") == 1);
				u.setLoyaltyPoints(rs.getInt("points"));
				u.setMembershipLevel(rs.getString("membership_level"));

				return u;
			}

		} catch (Exception e) {
			throw new RuntimeException("findByEmail failed", e);
		}
	}

	public void addPoints(int userId, int pointsToAdd) {
		String sql = """
				    UPDATE users 
				    SET points = points + ?,
				        membership_level = CASE 
				            WHEN points + ? >= 5000 THEN 'PLATINUM'
				            WHEN points + ? >= 2000 THEN 'GOLD'
				            WHEN points + ? >= 500 THEN 'SILVER'
				            ELSE 'BRONZE'
				        END
				    WHERE user_id = ?
				""";
		try (Connection cn = DBConnection.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
			ps.setInt(1, pointsToAdd);
			ps.setInt(2, pointsToAdd);
			ps.setInt(3, pointsToAdd);
			ps.setInt(4, pointsToAdd);
			ps.setInt(5, userId);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void updateProfile(int userId, String fullName, String phoneNumber, Date dateOfBirth, String gender,
			String address) {

		String sql = "UPDATE users SET full_name=?, phone_number=?, date_of_birth=?, gender=?, address=? WHERE user_id=?";
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, fullName);
			ps.setString(2, phoneNumber);

			if (dateOfBirth != null)
				ps.setDate(3, dateOfBirth);
			else
				ps.setNull(3, java.sql.Types.DATE);

			if (gender != null && !gender.isEmpty())
				ps.setString(4, gender);
			else
				ps.setNull(4, java.sql.Types.VARCHAR);

			ps.setString(5, address);
			ps.setInt(6, userId);

			ps.executeUpdate();

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public void updatePassword(int userId, String hashedPassword) {
		String sql = "UPDATE users SET password = ? WHERE user_id = ?";
		try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {

			ps.setString(1, hashedPassword);
			ps.setInt(2, userId);
			ps.executeUpdate();

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public void updateSettings(int userId, boolean subscribeNewsletter, boolean subscribeSMS) {
		String sql = "UPDATE users SET subscribe_newsletter=?, subscribe_sms=? WHERE user_id=?";
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setBoolean(1, subscribeNewsletter);
			ps.setBoolean(2, subscribeSMS);
			ps.setInt(3, userId);
			ps.executeUpdate();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

}
