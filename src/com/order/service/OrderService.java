package com.order.service;

import java.sql.SQLException;
import java.util.List;

import com.order.dao.EvaluationDao;
import com.order.dao.OrderDao;
import com.order.exception.OrderException;
import com.order.model.Evaluation;
import com.order.model.Order;

import cn.hutool.db.Session;

public class OrderService {
	private OrderDao orderDao = new OrderDao();
	private EvaluationDao evaluationDao = new EvaluationDao();
	
	/**
	 * 生成订单
	 * 需要处理事务
	 * @param order
	 */
	public void add(Order order) {
		Session session = Session.create();
		try {
			session.beginTransaction(); // 开启事务
			orderDao.insert(order); // 插入订单
			orderDao.insertItems(order.getOrderItems()); // 插入所有订单条目
			session.commit(); // 提交事务
		} catch (SQLException e) {
			session.quietRollback(); // 回滚事务
		}
	}
	
	/**
	 * 完成支付
	 * @param id
 	 */
	public void pay(String id) {
		// 获取订单的状态
		int state = orderDao.getStateById(id);
		if(state == 1) { // 如果状态为未付款
			orderDao.updateStateById(id, 2); // 更新状态
		}
		// 否则什么都不做
	}
	
	/**
	 * 根据id加载某个订单
	 * @param id
	 * @return
	 */
	public Order load(String id) {
		return orderDao.getById(id);
	}
	
	/**
	 * 获取订单状态
	 * @param id
	 * @return
	 */
	public int getState(String id) {
		return orderDao.getStateById(id);
	}

	/**
	 * 加载用户所有订单
	 * @param uid
	 * @return
	 */
	public List<Order> listUserOrder(int uid) {
		return orderDao.listByUid(uid);
	}
	
	/**
	 * 确认送达，修改状态为3（已完成）
	 * @param id
	 */
	public void confirmOrder(String id) throws OrderException {
		if (orderDao.getStateById(id) != 2) { // 如果订单状态不为2（待送达），抛出异常
			throw new OrderException("订单状态异常");
		}
		orderDao.updateStateById(id, 3);
	}

	/**
	 * 评价某个订单的所有菜品
	 * @param oid 订单id
	 * @param eList 评价列表
	 */
	public void evaluateOrder(String oid, List<Evaluation> eList) {
		evaluationDao.insert(eList); // 插入所有评价
		orderDao.updateStateById(oid, 4); // 修改订单状态为4（已评价）
	}
}
