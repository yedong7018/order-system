package com.order.dao;

import java.sql.SQLException;

import com.order.model.User;

import cn.hutool.db.Db;
import cn.hutool.db.Entity;
import cn.hutool.db.handler.BeanHandler;

public class UserDao {

	private Db db = Db.use();
	
	/**
	 * 新增用户
	 * @param user 用户对象
	 */
	public int insert(User user) {
		try {
			return db.insert(Entity.create(User.TABLE_NAME)
					.set("username", user.getUsername())
					.set("password", user.getPassword())
					.set("phone", user.getPhone())
					.set("email", user.getEmail()));
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 更新用户
	 * @param user 待更新用户对象
	 */
	public int update(User user) {
		try {
			return db.update(Entity.create()
					.set("username", user.getUsername())
					.set("password", user.getPassword())
					.set("phone", user.getPhone())
					.set("email", user.getEmail())
					.set("code", user.getCode()),
					Entity.create(User.TABLE_NAME).set("id", user.getId())
			);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 根据id更新单个字段
	 * @param id 用户id
	 * @param field 字段
	 * @param value 值
	 * @return
	 */
	public int updateField(int id, String field, Object value) {
		try {
			return db.update(
					Entity.create().set(field, value), 
					Entity.create(User.TABLE_NAME).set("id", id));
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public int updateUsername(int id, String username) {
		return updateField(id, "username", username);
	}

	public int updatePassword(int id, String password) {
		return updateField(id, "password", password);
	}

	public int updatePhone(int id, String phone) {
		return updateField(id, "phone", phone);
	}

	public int updateEmail(int id, String email) {
		return updateField(id, "email", email);
	}

	public int updateCode(int id, String code) {
		return updateField(id, "code", code);
	}

	/**
	 * 根据单个字段查询单个用户
	 * @param field 字段
	 * @param value 值
	 * @return
	 */
	public User getByField(String field, Object value) {
		try {
			return db.find(
					Entity.create(User.TABLE_NAME).set(field, value), 
					new BeanHandler<User>(User.class));
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public User getById(int id) {
		return getByField("id", id);
	}

	public User getByUsername(String username) {
		return getByField("username", username);
	}

	public User getByPhone(String phone) {
		return getByField("phone", phone);
	}

	public User getByEmail(String email) {
		return getByField("email", email);
	}

	public User getByCode(String code) {
		return getByField("code", code);
	}

}
