package com.order.model;

public class FoodType {
	private Integer id; // 分类id
	private String name; // 分类名称

	public FoodType() {

	}

	public FoodType(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "FoodType [id=" + id + ", name=" + name + "]";
	}

}
