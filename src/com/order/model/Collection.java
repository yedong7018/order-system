package com.order.model;

import java.util.Date;

public class Collection {
	private Integer uid; // 用户id
	private Integer fid; // 菜品id
	private Date addTime; // 收藏时间

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

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	@Override
	public String toString() {
		return "Collection [uid=" + uid + ", fid=" + fid + ", addTime=" + addTime + "]";
	}
	
}
