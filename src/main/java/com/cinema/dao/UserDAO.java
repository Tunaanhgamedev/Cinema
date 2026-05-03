package com.cinema.dao;

import java.sql.Date;
import com.cinema.model.User;

public interface UserDAO {
    boolean existsByEmail(String email);
    int insert(User u);
    User findByEmail(String email);
    void addPoints(int userId, int pointsToAdd);
    boolean subtractPoints(int userId, int pointsToSubtract);
    void updateProfile(int userId, String fullName, String phoneNumber, Date dateOfBirth, String gender, String address);
    void updatePassword(int userId, String hashedPassword);
    void updateSettings(int userId, boolean subscribeNewsletter, boolean subscribeSMS);
    int countTotalUsers();
}
