package com.order.model;

public class Food {
	private Integer id; // 菜品id
	private Integer ftid; // 分类id
	private String name; // 名称
	private String image; // 图片
	private Double price; // 价格
	private String info; // 说明
	private Integer sold; // 月售
	private Double avgRating; // 平均评分

	public Food() {

	}

	public Food(int id) {
		this.id = id;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getFtid() {
		return ftid;
	}

	public void setFtid(Integer ftid) {
		this.ftid = ftid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public Integer getSold() {
		return sold;
	}

	public void setSold(Integer sold) {
		this.sold = sold;
	}

	public Double getAvgRating() {
		return this.avgRating;
	}

	public void setAvgRating(Double avgRating) {
		this.avgRating = avgRating;
	}

	@Override
	public String toString() {
		return "Food [id=" + id + ", ftid=" + ftid + ", name=" + name + ", image=" + image + ", price=" + price
				+ ", info=" + info + ", sold=" + sold + ", avgRating=" + avgRating + "]";
	}

}
