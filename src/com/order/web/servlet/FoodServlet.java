package com.order.web.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.order.service.FoodService;
import com.order.service.FoodTypeService;

import cn.hutool.core.convert.Convert;

@WebServlet("/food")
public class FoodServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	private FoodService foodService = new FoodService();
	private FoodTypeService ftService = new FoodTypeService();

	// 查询所有菜品
	public String findAll(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		request.setAttribute("foodList", foodService.findAll());
		/*
		 * 根据来源决定转发到哪
		 */
		String identity = request.getParameter("identity");
		if ("user".equals(identity)) {
			return "main_foodinfo.jsp";
		} 
		if ("admin".equals(identity)) {
			request.setAttribute("ftList", ftService.findAll());
			return "admin/m_food.jsp";
		}
		return null;
	}

	// 查询某个分类的菜品
	public String findByType(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		int ftid = Convert.toInt(request.getParameter("typeId"));
		request.setAttribute("foodList", foodService.findByType(ftid));
		return "main_foodinfo.jsp";
	}

	// 搜索菜品
	public String findByName(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		request.setAttribute("foodList", foodService.findByName(request.getParameter("name")));
		/**
		 * 根据来源决定转发到哪
		 */
		String identity = request.getParameter("identity");
		if ("user".equals(identity)) {
			return "main_foodinfo.jsp";
		} 
		if ("admin".equals(identity)) {
			return "admin/m_food.jsp";
		} 
		return null;
	}

	// 删除指定菜品
	public void delete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		int id = Convert.toInt(request.getParameter("id"));
		foodService.delete(id);
		response.getWriter().print(1);
	}
}
