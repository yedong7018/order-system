package com.order.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.order.model.Food;
import com.order.model.Order;
import com.order.model.OrderItem;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.db.Db;
import cn.hutool.db.Entity;
import cn.hutool.db.handler.BeanHandler;
import cn.hutool.db.handler.BeanListHandler;

public class OrderDao {
	
	private Db db = Db.use();

	/**
	 * 插入单个订单
	 * @param order 订单对象
	 */
	public int insert(Order order) {
		Entity record = Entity.create("orders")
				.set("id", order.getId())
				.set("uid", order.getUid())
				.set("time", order.getTime())
				.set("sendTime", order.getSendTime())
				.set("state", order.getState())
				.set("total", order.getTotal())
				.set("payMethod", order.getPayMethod())
				.set("remark", order.getRemark())
				.set("name", order.getName())
				.set("phone", order.getPhone())
				.set("address", order.getAddress());
		try {
			return db.insert(record);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 批处理插入多个订单条目，并批处理更新多个菜品的月售
	 * @param itemList 条目列表
	 */
	public void insertItems(List<OrderItem> itemList) {
		String orderSql = "insert into orderitem (oid,fid,count,subtotal) values (?,?,?,?)";
		String foodSql = "update food set sold = sold + ? where id = ?";
		Object[][] orderParams = new Object[itemList.size()][];
		Object[][] foodParams = new Object[itemList.size()][];
		for (int i = 0; i < orderParams.length; i++) {
			OrderItem orderItem = itemList.get(i);
			orderParams[i] = new Object[] { orderItem.getOid(), orderItem.getFid(),
					orderItem.getCount(), orderItem.getSubtotal() };
			foodParams[i] = new Object[] { orderItem.getCount(), orderItem.getFid() };
		}
		try {
			db.executeBatch(orderSql, orderParams); // 插入条目列表
			db.executeBatch(foodSql, foodParams); // 更新菜品月售
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 根据id查询订单的状态
	 * @param id 订单id
	 * @return 订单状态值
	 */
	public int getStateById(String id) {
		String sql = "select state from orders where id = ?";
		try {
			return db.queryNumber(sql, id).intValue();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据id更新订单状态
	 * @param id 订单id
	 * @param state 要更新的状态值
	 */
	public int updateStateById(String id, int state) {
		String sql = "update orders set state=? where id=?";
		try {
			return db.execute(sql, state, id);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据id删除单个订单
	 * @param id 订单id
	 */
	public int delete(String id) {
		String sql = "delete from orders where id = ?";
		try {
			return db.execute(sql, id);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 根据Map条件查询多个订单
	 * @param map 表字段 map对象
	 * @return 订单列表
	 */
	public List<Order> listByMap(Map<String, Object> map) {
		try {
			Entity where = Entity.create("orders");
			for (String key : map.keySet()) {
				where.set(key, map.get(key));
			}
			return db.find(where, Order.class);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据id查询单个订单
	 * @param id 订单id
	 * @return 单个订单
	 */
	public Order getById(String id) {
		String sql = "select * from orders where id = ?";
		try {
			Order order = db.query(sql, new BeanHandler<Order>(Order.class), id);
			loadItems(order); // 为订单加载条目列表
			return order;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 根据用户id查询用户所有订单
	 * @param uid 用户id
	 * @return 订单列表
	 */
	public List<Order> listByUid(int uid) {
		String sql = "select * from orders where uid = ? order by time desc"; // 按照下单时间降序排序
		try {
			List<Order> orderList = db.query(sql, new BeanListHandler<Order>(Order.class), uid);
			for (Order order : orderList) {
				loadItems(order); // 为每个订单加载条目列表
			}
			return orderList;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 为订单加载条目列表
	 * @param order 要加载条目的订单
	 * @throws SQLException
	 */
	private void loadItems(Order order) throws SQLException {
		List<OrderItem> orderItems = new ArrayList<>();
		String sql;
		if(order.getState() == 4) { // 如果订单已完成评价
			// 顺带查出对所有菜品的评价
			sql = "SELECT f.*, oi.*, e.rating "
					+ "FROM orderitem oi "
					+ "JOIN food f ON oi.fid = f.id "
					+ "LEFT JOIN evaluation e ON f.id = e.fid "
					+ "WHERE oi.oid = ?";
		} else {
			sql = "SELECT f.*, oi.* FROM orderitem oi JOIN food f ON oi.fid = f.id WHERE oi.oid = ?";
		}
		// 得到实体列表
		List<Entity> entities = db.query(sql, order.getId());
		// 遍历实体列表，完成多表映射
		for (Entity entity : entities) {
			OrderItem orderItem = BeanUtil.toBean(entity, OrderItem.class); // 映射得到条目
			Food food = BeanUtil.toBean(entity, Food.class); // 映射得到菜品
			orderItem.setFood(food); // 设置条目的菜品
			orderItems.add(orderItem); // 添加到条目列表
		}
		order.setOrderItems(orderItems);
	}
	
}
