package com.order.model;

import java.util.List;

public class User {
	public static final String TABLE_NAME = "user"; // 数据库表名
	private Integer id; // 用户id
	private String username; // 用户名
	private String password; // 密码
	private String phone; // 手机号
	private String email; // 邮箱
	private String code; // 找回密码验证码
	private List<Address> addrList; // 地址列表

	public User() {
	}

	public User(int id) {
		this.id = id;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public List<Address> getAddrList() {
		return addrList;
	}

	public void setAddrList(List<Address> addrList) {
		this.addrList = addrList;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", phone=" + phone + ", email="
				+ email + ", code=" + code + ", addrList=" + addrList + "]";
	}

}
