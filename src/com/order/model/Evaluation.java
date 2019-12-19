package com.order.model;

public class Evaluation {
	public static final String TABLE_NAME = "evaluation";
	private String oid; // 订单id
	private Integer fid; // 菜品id
	private Integer rating; // 评分

	public String getOid() {
		return oid;
	}

	public void setOid(String oid) {
		this.oid = oid;
	}

	public Integer getFid() {
		return fid;
	}

	public void setFid(Integer fid) {
		this.fid = fid;
	}

	public Integer getRating() {
		return rating;
	}

	public void setRating(Integer rating) {
		this.rating = rating;
	}

	@Override
	public String toString() {
		return "Evaluation [oid=" + oid + ", fid=" + fid + ", rating=" + rating + "]";
	}

}
