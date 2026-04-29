package com.cinema.dao;

import java.math.BigDecimal;
import java.util.List;

import com.cinema.model.Combo;

public interface ComboDAO {
	List<Combo> findAll();

	Combo findById(int comboId);

	boolean insertCombo(String name, String description, BigDecimal price);

	boolean updateCombo(int comboId, String name, String description, BigDecimal price);

	boolean deleteCombo(int comboId);
}
