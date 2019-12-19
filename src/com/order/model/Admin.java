package com.order.model;

public class Admin {
	private String admName; // 管理员账号
	private String admPassword; // 密码

	public String getAdmName() {
		return admName;
	}

	public void setAdmName(String admName) {
		this.admName = admName;
	}

	public String getAdmPassword() {
		return admPassword;
	}

	public void setAdmPassword(String admPassword) {
		this.admPassword = admPassword;
	}

	@Override
	public String toString() {
		return "Admin [admName=" + admName + ", admPassword=" + admPassword + "]";
	}

}
