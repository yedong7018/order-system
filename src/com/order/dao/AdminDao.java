package com.order.dao;

import java.sql.SQLException;

import com.order.model.Admin;

import cn.hutool.db.Db;
import cn.hutool.db.handler.BeanHandler;

public class AdminDao {
	
	private Db db = Db.use();
	
	/**
	 * 根据名称查询单个管理员对象
	 * @param name 名称
	 * @return 管理员对象
	 */
	public Admin findByName(String name) {
		String sql = "select * from admin where admname = ?";
		try {
			return db.query(sql, new BeanHandler<Admin>(Admin.class), name);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
