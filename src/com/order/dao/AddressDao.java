package com.order.dao;

import java.sql.SQLException;
import java.util.List;

import com.order.model.Address;

import cn.hutool.db.Db;
import cn.hutool.db.handler.BeanHandler;

public class AddressDao {
	
	private Db db = Db.use();
	
	/**
	 * 插入单个地址
	 * @param address 新地址
	 * @return 自增长主键
	 */
	public long insert(Address a) {
		String sql = "insert into address(uid,name,phone,addr) values(?,?,?,?)";
		Object[] params = { a.getUid(), a.getName(), a.getPhone(), a.getAddr() };
		try {
			// 返回自增长主键
			return db.executeForGeneratedKey(sql, params); 
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据id更新单个地址
	 * @param id 地址id
	 * @param a 新地址
	 */
	public int update(int id, Address a) {
		String sql = "update address set name=?,phone=?,addr=? where id=?";
		Object[] params = { a.getName(), a.getPhone(), a.getAddr(), id };
		try {
			return db.execute(sql, params);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据id删除单个地址
	 * @param id 地址id
	 */
	public int delete(int id) {
		String sql = "delete from address where id = ?";
		try {
			return db.execute(sql, id);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据用户id查询用户所有地址
	 * @param uid 用户id
	 * @return 地址列表
	 */
	public List<Address> listByUid(int uid) {
		String sql = "select * from address where uid = ? order by id";
		try {
			return db.query(sql, Address.class, uid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据id查询单个地址
	 * @param id 地址id
	 * @return 单个地址
	 */
	public Address getById(int id) {
		String sql = "select * from address where id = ?";
		try {
			return db.query(sql, new BeanHandler<Address>(Address.class), id);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
}
