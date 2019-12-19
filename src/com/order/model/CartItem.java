package com.order.model;

import java.math.BigDecimal;

public class CartItem {
	private Integer uid; // 用户id
	private Integer fid; // 菜品id
	private Integer count; // 菜品数量
	private Food food; // 所属菜品

	public Integer getUid() {
		return uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	public Integer getFid() {
		return fid;
	}

	public void setFid(Integer fid) {
		this.fid = fid;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	// 计算小计
	public Double getSubtotal() {
		/*
		 * 处理二进制运算误差问题
		 */
		BigDecimal b1 = new BigDecimal(food.getPrice() + "");
		BigDecimal b2 = new BigDecimal(count + "");
		return b1.multiply(b2).doubleValue();
	}

	public Food getFood() {
		return food;
	}

	public void setFood(Food food) {
		this.food = food;
	}

	@Override
	public String toString() {
		return "CartItem [uid=" + uid + ", fid=" + fid + ", count=" + count + ", food=" + food + "]";
	}

}
