package com.order.web.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.order.model.Cart;
import com.order.model.CartItem;
import com.order.model.Food;
import com.order.service.CartService;
import com.order.service.FoodService;

import cn.hutool.core.convert.Convert;

@WebServlet("/cart")
public class CartServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	private CartService cartService = new CartService();
	private FoodService foodService = new FoodService();

	// 添加条目
	public void addItem(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException, SQLException {
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		if (cart == null) { // 未登录
			response.getWriter().print(-1);
			return;
		}
		int foodId = Convert.toInt(request.getParameter("foodId"));
		int count = Convert.toInt(request.getParameter("count"));
		Food food = foodService.findById(foodId);
		
		CartItem cartItem = new CartItem();
		cartItem.setUid(cart.getId());
		cartItem.setFid(foodId);
		cartItem.setCount(count);
		cartItem.setFood(food);
		cart.add(cartItem);
		cartService.addCartItem(cartItem);
		response.getWriter().print(1);
	}

	// 删除条目
	public void deleteItem(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		if (cart == null) {
			response.getWriter().print(-1);
			return;
		}
		int fid = Convert.toInt(request.getParameter("foodId"));
		CartItem ci = cart.get(fid);
		cart.delete(fid);
		cartService.deleteCartItem(ci.getUid(), fid);
		response.getWriter().print(1);
	}
	
	// 更新条目
	public void updateItem(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException, SQLException {
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		if (cart == null) {
			response.getWriter().print(-1);
			return;
		}
		int foodId = Convert.toInt(request.getParameter("foodId"));
		int count = Convert.toInt(request.getParameter("count"));
		cart.update(foodId, count);
		cartService.updateCartItem(cart.get(foodId));
		response.getWriter().print(1);
	}

	// 清空购物车
	public void clear(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		if (cart == null) {
			response.getWriter().print(-1);
			return;
		}
		cart.clear();
		cartService.clear(cart.getId());
		response.getWriter().print(1);
	}
	
}
