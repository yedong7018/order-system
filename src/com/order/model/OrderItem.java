package com.order.model;

public class OrderItem {
	private Integer id; // 条目ID
	private String oid; // 订单id
	private Integer fid; // 菜品id
	private Integer count; // 菜品数量
	private Double subtotal; // 小计
	private Food food; // 所属菜品
	private Integer rating; // 用户对该菜品的评分

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getOid() {
		return oid;
	}

	public void setOid(String oid) {
		this.oid = oid;
	}

	public Food getFood() {
		return food;
	}

	public void setFood(Food food) {
		this.food = food;
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

	public Double getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(Double subtotal) {
		this.subtotal = subtotal;
	}

	public Integer getRating() {
		return rating;
	}

	public void setRating(Integer rating) {
		this.rating = rating;
	}

	@Override
	public String toString() {
		return "OrderItem [id=" + id + ", oid=" + oid + ", fid=" + fid + ", count=" + count + ", subtotal=" + subtotal
				+ ", food=" + food + ", rating=" + rating + "]";
	}

}
