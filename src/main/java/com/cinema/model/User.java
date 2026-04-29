package com.cinema.model;

import java.sql.Date;
import java.sql.Timestamp;

public class User {
	private int userId;
	private String fullName;
	private String email;
	private String password;
	private String phoneNumber;
	private String role;
	private Timestamp createdAt;

	// ✅ NEW fields theo DB mới
	private Date dateOfBirth; // date_of_birth
	private String gender; // MALE/FEMALE/OTHER
	private String address; // address
	private boolean subscribeNewsletter; // subscribe_newsletter
	private boolean subscribeSMS; // subscribe_sms

	public User() {
	}

	/*
	 * public User(String fullName, String email, String password, String
	 * phoneNumber) { this.fullName = fullName; this.email = email; this.password =
	 * password; this.phoneNumber = phoneNumber; this.role = "USER"; }
	 */
	public User(String fullName, String email, String password, String phoneNumber, java.sql.Date dateOfBirth,
			String gender, String address, boolean subscribeNewsletter, boolean subscribeSMS) {
		this.fullName = fullName;
		this.email = email;
		this.password = password;
		this.phoneNumber = phoneNumber;
		this.dateOfBirth = dateOfBirth;
		this.gender = gender;
		this.address = address;
		this.subscribeNewsletter = subscribeNewsletter;
		this.subscribeSMS = subscribeSMS;
		this.role = "USER";
	}

	// ===== getters/setters cũ =====
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	// ===== ✅ getters/setters NEW =====
	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public boolean isSubscribeNewsletter() {
		return subscribeNewsletter;
	}

	public void setSubscribeNewsletter(boolean subscribeNewsletter) {
		this.subscribeNewsletter = subscribeNewsletter;
	}

	public boolean isSubscribeSMS() {
		return subscribeSMS;
	}

	public void setSubscribeSMS(boolean subscribeSMS) {
		this.subscribeSMS = subscribeSMS;
	}

	@Override
	public String toString() {
		return "User{" + "userId=" + userId + ", fullName='" + fullName + '\'' + ", email='" + email + '\''
				+ ", phoneNumber='" + phoneNumber + '\'' + ", role='" + role + '\'' + ", dateOfBirth=" + dateOfBirth
				+ ", gender='" + gender + '\'' + ", address='" + address + '\'' + ", subscribeNewsletter="
				+ subscribeNewsletter + ", subscribeSMS=" + subscribeSMS + ", createdAt=" + createdAt + '}';
	}

}
