package com.order.dao;

import java.sql.SQLException;
import java.util.List;

import com.order.model.Food;

import cn.hutool.db.Db;
import cn.hutool.db.handler.BeanHandler;
import cn.hutool.db.handler.BeanListHandler;

public class FoodDao {
	
	private Db db = Db.use();

	public List<Food> find(String sql) {
		try {
			return db.query(sql, new BeanListHandler<Food>(Food.class));
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	public String createFindSql(String foodName, String foodTypeId, String firstPrice, String secondPrice,
			String firstSale, String secondSale) {
		StringBuilder sql = new StringBuilder("SELECT * FROM food WHERE 1 = 1");
		
		if (foodName != null && !foodName.equals("")) {
			sql.append(" AND name LIKE '%" + foodName + "%'");
		}
		if (foodTypeId != null && !foodTypeId.equals("")) {
			sql.append(" AND ftid =" + foodTypeId);
		}
		if (firstPrice != null && !firstPrice.equals("")) {
			sql.append(" AND price>=" + firstPrice);
		}
		if (secondPrice != null && !secondPrice.equals("")) {
			sql.append(" AND price<=" + secondPrice);
		}

		if (firstSale != null && !firstSale.equals("")) {
			sql.append(" AND sold>=" + firstSale);
		}
		if (secondSale != null && !secondSale.equals("")) {
			sql.append(" AND sold<=" + secondSale);
		}

		System.out.println("------------");
		System.out.println(sql);
		System.out.println("------------");

		return sql.toString();
	}

	/**
	 * 插入单个菜品
	 * @param f 菜品对象
	 */
	public int insert(Food f) {
		String sql = "INSERT INTO food(ftid,name,image,price,info) VALUES(?,?,?,?,?)";
		Object[] params = { f.getFtid(), f.getName(), f.getImage(), f.getPrice(), f.getInfo() };
		try {
			return db.execute(sql, params);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据id删除单个菜品
	 * @param id 菜品id
	 */
	public int delete(int id) {
		String sql = "DELETE FROM food WHERE id = ?";
		try {
			return db.execute(sql, id);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据id更新单个菜品
	 * @param f 菜品对象
	 */
	public int update(Food f) {
		StringBuilder sql = new StringBuilder("update food set ftid=?,name=?,price=?,info=?");
		Object[] params;
		if (f.getImage() == null) {
			params = new Object[] { f.getFtid(), f.getName(), f.getPrice(), f.getInfo(), f.getId() };
		} else {
			sql.append(",image=?");
			params = new Object[] { f.getFtid(), f.getName(), f.getPrice(), f.getInfo(), f.getImage(), f.getId() };
		}
		sql.append(" where id=?");
		try {
			return db.execute(sql.toString(), params);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 查询所有菜品
	 * @return 菜品列表
	 */
	public List<Food> listAll() {
		// 查出平均评分
		String sql = "SELECT f.*, IFNULL(AVG(rating), 0) avgRating "
				+ "FROM food f "
				+ "LEFT JOIN evaluation e ON f.id = e.fid "
				+ "GROUP BY f.id";
		try {
			return db.query(sql, new BeanListHandler<Food>(Food.class));
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据id查询单个菜品
	 * @param id 菜品id
	 * @return 单个菜品
	 */
	public Food getById(int id) {
		// 查出平均评分
		String sql = "SELECT f.*, IFNULL(AVG(rating), 0) avgRating "
				+ "FROM food f "
				+ "LEFT JOIN evaluation e ON f.id = e.fid "
				+ "WHERE f.id = ?";
		try {
			return db.query(sql, new BeanHandler<Food>(Food.class), id);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据分类id查询该分类下所有菜品
	 * @param ftid 分类id
	 * @return 菜品列表
	 */
	public List<Food> listByType(int ftid) {
		if (ftid == 0) {
			return listAll();
		} 
		// 查出平均评分
		String sql = "SELECT f.*, IFNULL(AVG(rating), 0) avgRating "
				+ "FROM food f "
				+ "LEFT JOIN evaluation e ON f.id = e.fid "
				+ "GROUP BY f.id HAVING f.ftid = ? "
				+ "order by id";
		try {
			return db.query(sql, new BeanListHandler<Food>(Food.class), ftid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据名称模糊查询多个菜品
	 * @param name 模糊查询的名称
	 * @return 菜品列表
	 */
	public List<Food> listByName(String name) {
		// 查出平均评分
		String sql = "SELECT f.*, IFNULL(AVG(rating), 0) avgRating "
				+ "FROM food f "
				+ "LEFT JOIN evaluation e ON f.id = e.fid "
				+ "GROUP BY f.id HAVING f.name LIKE ? "
				+ "order by id";
		try {
			return db.query(sql, new BeanListHandler<Food>(Food.class), "%" + name + "%");
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
