package com.order.model;

import java.util.Date;
import java.util.List;

public class Order {
	private String id; // 订单id
	private Integer uid; // 用户id
	private Date time; // 下单时间
	private String sendTime; // 送达时间
	private Integer state; // 订单状态（0已取消；1未付款；2待送达；3已完成；4已评价）
	private Double total; // 合计
	private Integer payMethod; // 支付方式（1微信；2支付宝；3到付）
	private String remark; // 备注
	private String name; // 收货人姓名
	private String phone; // 收获人手机号
	private String address; // 收货人详细地址
	private List<OrderItem> orderItems; // 所有订单条目
	private User user; // 所属用户

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Integer getUid() {
		return uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getSendTime() {
		return sendTime;
	}

	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Double getTotal() {
		return total;
	}

	public void setTotal(Double total) {
		this.total = total;
	}

	public Integer getPayMethod() {
		return payMethod;
	}

	public void setPayMethod(Integer payMethod) {
		this.payMethod = payMethod;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public List<OrderItem> getOrderItems() {
		return orderItems;
	}

	public void setOrderItems(List<OrderItem> orderItems) {
		this.orderItems = orderItems;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Order [id=" + id + ", uid=" + uid + ", time=" + time + ", sendTime=" + sendTime + ", state=" + state
				+ ", total=" + total + ", payMethod=" + payMethod + ", remark=" + remark + ", name=" + name + ", phone="
				+ phone + ", address=" + address + ", orderItems=" + orderItems + ", user=" + user + "]";
	}

}
