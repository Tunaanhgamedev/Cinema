package com.cinema.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.cinema.model.Banner;
import com.cinema.utils.DBConnection;

public class BannerDAO {

	public Banner getActiveBannerByPosition(String position) {
		Banner banner = null;
		String sql = "SELECT * FROM banners WHERE position=? AND status='ACTIVE' LIMIT 1";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, position);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				banner = new Banner();
				banner.setBannerId(rs.getInt("banner_id"));
				banner.setTitle(rs.getString("title"));
				banner.setImageUrl(rs.getString("image_url"));
				banner.setLinkUrl(rs.getString("link_url"));
				banner.setPosition(rs.getString("position"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return banner;
	}
}
