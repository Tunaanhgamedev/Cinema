package com.cinema.test;

import com.cinema.utils.DBConnection;
import java.sql.Connection;

public class TestDB {
    public static void main(String[] args) {
        try {
            System.out.println("Testing DB connection...");
            Connection conn = DBConnection.getConnection();
            if (conn != null) {
                System.out.println("✅ Connection SUCCESSFUL!");
                conn.close();
            }
        } catch (Exception e) {
            System.err.println("❌ Connection FAILED!");
            e.printStackTrace();
        }
    }
}
