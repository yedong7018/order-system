package com.order.model;

import java.math.BigDecimal;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class Cart {
	// 用户id
	private Integer id; 
	// 购物车内部的Map，其中key为菜品id，value为购物车条目对象
	private Map<Integer, CartItem> map = new LinkedHashMap<Integer, CartItem>(); 

	public Cart() {
	}

	public Cart(int id) {
		this.id = id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return id;
	}
	
	/**
	 * 获取单个条目
	 * @param fid 菜品id
	 * @return 单个条目
	 */
	public CartItem get(int fid) {
		return map.get(fid);
	}

	/**
	 * 添加单个条目
	 * @param cartItem
	 */
	public void add(CartItem cartItem) {
		map.put(cartItem.getFid(), cartItem);
	}
	
	/**
	 * 添加多个条目
	 * @param cartItem
	 */
	public void add(List<CartItem> cartItemList) {
		for (CartItem cartItem : cartItemList) {
			add(cartItem);
		}
	}
	
	/**
	 * 更新单个条目
	 * @param fid
	 * @param count
	 */
	public void update(int fid, int count) {
		CartItem ci = map.get(fid);
		ci.setCount(count);
	}

	/**
	 * 清空所有条目
	 */
	public void clear() {
		map.clear();
	}

	/**
	 * 删除指定条目
	 * @param fid 菜品id
	 */
	public void delete(int fid) {
		map.remove(fid);
	}

	/**
	 * 查看购物车
	 * @return 条目集合
	 */
	public Collection<CartItem> getCartItems() {
		return map.values();
	}

	/**
	 * 计算合计
	 * @return 处理了二进制精度问题的合计
	 */
	public double getTotal() {
		// 合计 = 所有条目的小计之和
		BigDecimal total = new BigDecimal(0 + "");
		for (CartItem cartItem : map.values()) {
			BigDecimal subtotal = new BigDecimal(cartItem.getSubtotal() + "");
			total = total.add(subtotal);
		}
		return total.doubleValue();
	}

	@Override
	public String toString() {
		return "Cart [id=" + id + ", map=" + map + "]";
	}

}
