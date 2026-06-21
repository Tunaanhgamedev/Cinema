package com.cinema.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cinema.model.Contact;
import com.cinema.utils.DBConnection;

public class ContactDAO {

	public List<Contact> getAllContacts() {
		List<Contact> list = new ArrayList<>();
		String sql = "SELECT * FROM contacts ORDER BY createdAt DESC";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				Contact c = new Contact();
				c.setContactId(rs.getInt("contactId"));
				c.setFullName(rs.getString("fullName"));
				c.setPhoneNumber(rs.getString("phoneNumber"));
				c.setEmail(rs.getString("email"));
				c.setMessage(rs.getString("message"));
				c.setCreatedAt(rs.getString("createdAt"));
				c.setStatus(rs.getString("status"));
				list.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean deleteContact(int id) {
		String sql = "DELETE FROM contacts WHERE contactId = ?";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, id);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean updateStatus(int id, String status) {
		String sql = "UPDATE contacts SET status = ? WHERE contactId = ?";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, status);
			ps.setInt(2, id);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
