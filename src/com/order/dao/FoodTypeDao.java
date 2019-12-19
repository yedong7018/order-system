package com.order.dao;

import java.sql.SQLException;
import java.util.List;

import com.order.model.FoodType;

import cn.hutool.db.Db;

public class FoodTypeDao {
	
	private Db db = Db.use();

	/**
	 * 查询所有分类
	 * @return 分类列表
	 */
	public List<FoodType> listAll() {
		String sql = "select * from foodtype order by name";
		try {
			return db.query(sql, FoodType.class);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 插入单个分类
	 * @param ft 分类对象
	 * @return 自增长主键
	 */
	public long insert(FoodType ft) {
		String sql = "insert into foodtype(name) values(?)";
		try {
			return db.executeForGeneratedKey(sql, ft.getName());
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 删除单个分类
	 * @param id 分类id
	 */
	public int delete(int id) {
		String sql = "delete from foodtype where id = ?";
		try {
			return db.execute(sql, id);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 更新单个分类
	 * @param ft 待更新分类
	 */
	public int update(FoodType ft) {
		String sql = "update foodtype set name=? where id=?";
		try {
			return db.execute(sql, ft.getName(), ft.getId());
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据名称模糊查询多个分类
	 * @param name 模糊查询的名称
	 * @return 分类列表
	 */
	public List<FoodType> listByName(String name) {
		String sql = "select * from foodtype where name like ?";
		try {
			return db.query(sql, FoodType.class, "%" + name + "%");
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

}
