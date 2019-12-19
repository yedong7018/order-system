package com.order.service;

import java.util.List;

import com.order.dao.FoodDao;
import com.order.model.Food;

public class FoodService {
	private FoodDao foodDao = new FoodDao();

	public void add(Food f) {
		foodDao.insert(f);
	}

	public void delete(int id) {
		foodDao.delete(id);
	}
	
	public void update(Food f) {
		foodDao.update(f);
	}

	public List<Food> find(String sql) {
		return foodDao.find(sql);
	}

	public String createFindSql(String foodName, String foodTypeId, String firstPrice, String secondPrice,
			String firstSale, String secondSale) {
		return foodDao.createFindSql(foodName, foodTypeId, firstPrice, secondPrice, firstSale, secondSale);
	}
	
	public List<Food> findAll() {
		return foodDao.listAll();
	}
	
	public Food findById(int id) {
		return foodDao.getById(id);
	}

	public List<Food> findByType(int ftid) {
		return foodDao.listByType(ftid);
	}

	public List<Food> findByName(String name) {
		return foodDao.listByName(name);
	}
	
}
