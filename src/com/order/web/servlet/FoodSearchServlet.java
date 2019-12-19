package com.order.web.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.order.model.Food;
import com.order.service.FoodService;
import com.order.service.FoodTypeService;

@WebServlet("/foodSearch")
public class FoodSearchServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	private FoodService foodService = new FoodService();
	private FoodTypeService ftService = new FoodTypeService();
	private List<Food> foodList = new ArrayList<Food>();

	public String search(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {

		String foodName = request.getParameter("foodname");
		String foodTypeId = request.getParameter("foodtype");
		String firstPrice = request.getParameter("firstprice");
		String secondPrice = request.getParameter("secondprice");
		String firstSale = request.getParameter("firstsale");
		String secondSale = request.getParameter("secondsale");
		
		String sql = foodService.createFindSql(foodName, foodTypeId, firstPrice, secondPrice, firstSale, secondSale);
		foodList = (ArrayList<Food>) foodService.find(sql);
		
		request.setAttribute("foodList", foodList);
		request.setAttribute("ftList", ftService.findAll());
		return "admin/m_food.jsp";
	}
}
