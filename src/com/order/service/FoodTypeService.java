package com.order.service;

import java.util.List;

import com.order.dao.FoodTypeDao;
import com.order.model.FoodType;

public class FoodTypeService {
	private FoodTypeDao ftDao = new FoodTypeDao();

	public List<FoodType> findAll() {
		return ftDao.listAll();
	}

	public long add(FoodType ft) {
		return ftDao.insert(ft);
	}

	public void delete(int id) {
		ftDao.delete(id);
	}

	public void update(FoodType ft) {
		ftDao.update(ft);
	}

	public List<FoodType> findByName(String name) {
		return ftDao.listByName(name);
	}

}
