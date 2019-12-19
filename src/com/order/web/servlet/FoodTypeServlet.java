package com.order.web.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.order.model.FoodType;
import com.order.service.FoodTypeService;

import cn.hutool.core.convert.Convert;

@WebServlet("/foodType")
public class FoodTypeServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

	private FoodTypeService service = new FoodTypeService();

	// 更新分类
	public void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Convert.toInt(request.getParameter("foodTypeId"));
		String newName = request.getParameter("newName");
		
		FoodType foodType = new FoodType();
		foodType.setId(id);
		foodType.setName(newName);
		
		service.update(foodType);
		response.getWriter().print(1);
	}

	// 删除分类
	public void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Convert.toInt(request.getParameter("foodTypeId"));
		service.delete(id);
		response.getWriter().print(1);
	}

	// 添加分类
	public void add(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("newName");
		
		FoodType foodType = new FoodType();
		foodType.setName(name);
		
		long id = service.add(foodType);
		response.getWriter().print(id);
	}

	// 查询所有分类
	public String findAll(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		request.setAttribute("ftList", service.findAll());
		/**
		 * 根据来源决定转发到哪
		 */
		String identity = request.getParameter("identity");
		if ("user".equals(identity)) {
			return "main_foodkind.jsp";
		} 
		if ("admin".equals(identity)) {
			return "admin/m_foodtype.jsp";
		} 
		return null;
	}

	// 搜索分类
	public String findByName(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String name = request.getParameter("name");
		List<FoodType> ftList;
		if (name == null || name.isEmpty()) {
			ftList = service.findAll();
		} else {
			ftList = service.findByName(name);
		}
		request.setAttribute("ftList", ftList);
		return "admin/m_foodtype.jsp";
	}
}
