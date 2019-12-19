package com.order.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.order.model.CartItem;
import com.order.model.Food;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.db.Db;
import cn.hutool.db.Entity;

public class CartDao {
	
	private Db db = Db.use();
	
	/**
	 * 插入单个购物车条目
	 * @param item 条目对象
	 */
	public int insertCartItem(CartItem item) {
		String sql = "insert into cartitem(uid,fid,count,subtotal) values(?,?,?,?)";
		Object[] params = { item.getUid(), item.getFid(), item.getCount(), item.getSubtotal() };
		try {
			return db.execute(sql, params);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据用户id和菜品id更新单个购物车条目
	 * @param item 条目对象
	 */
	public int updateCartItem(CartItem item) {
		String sql = "update cartitem set count=?,subtotal=? where uid=? and fid=?";
		Object[] params = { item.getCount(), item.getSubtotal(), item.getUid(), item.getFid() };
		try {
			return db.execute(sql, params);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据用户id和菜品id删除单个购物车条目
	 * @param uid 用户id
	 * @param fid 菜品id
	 */
	public int deleteCartItem(int uid, int fid) {
		String sql = "delete from cartitem where uid=? and fid=?";
		try {
			return db.execute(sql, uid, fid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 根据用户id查询用户所有购物车条目
	 * @param uid 用户id
	 * @return 购物车条目列表
	 */
	public List<CartItem> listCartItemByUid(int uid) {
		String sql = "SELECT * FROM cartitem ci JOIN food f ON ci.fid = f.id WHERE uid = ?";
		List<CartItem> cartItems = new ArrayList<>();
		try {
			// 查询得到实体列表
			List<Entity> entities = db.query(sql, uid);
			// 遍历实体列表，对每个实体做多实体映射
			for (Entity entity : entities) { 
				// 映射得到CartItem
				CartItem ci = BeanUtil.toBean(entity, CartItem.class);
				// 映射得到Food
				Food food = BeanUtil.toBean(entity, Food.class);
				// 设置Food到CartItem
				ci.setFood(food);
				// 添加CartItem到条目列表
				cartItems.add(ci);
			}
			// 返回条目列表
			return cartItems;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据用户id删除用户所有购物车条目
	 * @param uid 用户id
	 */
	public int deleteAllByUid(int uid) {
		String sql = "delete from cartitem where uid = ?";
		try {
			return db.execute(sql, uid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 根据用户id查询用户购物车条目数
	 * @param uid 用户id
	 * @return 购物车条目数量
	 */
	public int countCartItemByUid(int uid) {
		try {
			return db.count(Entity.create("cartitem").set("uid", uid));
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

}
