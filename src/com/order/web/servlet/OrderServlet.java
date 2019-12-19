package com.order.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.order.exception.OrderException;
import com.order.model.Cart;
import com.order.model.CartItem;
import com.order.model.Evaluation;
import com.order.model.Order;
import com.order.model.OrderItem;
import com.order.model.User;
import com.order.service.CartService;
import com.order.service.OrderService;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONArray;
import cn.itcast.commons.CommonUtils;

@WebServlet("/order")
public class OrderServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

	private OrderService orderService = new OrderService();
	private CartService cartService = new CartService();

	public String checkout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 转发到下单页面
		return "WEB-INF/checkout.jsp";
	}

	// 生成订单
	public String add(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		// 获取session中的购物车
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		/*
		 * 设置订单的一些基本信息
		 */
		// 封装表单
		Order order = CommonUtils.toBean(request.getParameterMap(), Order.class);
		order.setId(StrUtil.subPre(IdUtil.fastSimpleUUID(), 15)); // 设置随机15位订单ID
		order.setUid(cart.getId()); // 设置用户id
		order.setTime(DateUtil.date()); // 设置下单时间
		order.setState(1); // 设置状态为1（未付款）
		order.setTotal(cart.getTotal()); // 设置总计
		order.setOrderItems(toOrderItems(cart, order.getId())); // 根据购物车设置条目列表
		
		orderService.add(order); // 调用业务层完成添加订单
		cart.clear(); // 清空购物车
		cartService.clear(cart.getId()); // 清空数据库的购物车条目
		
		int payMethod = order.getPayMethod();
		if (payMethod == 1) {
			request.setAttribute("order", order); // 设置order到request域
			return "pay?m=alipay"; // 转发到支付宝支付页面
		}
		if (payMethod == 2) {
			request.setAttribute("msg", "微信支付待开发中...");
			return "msg.jsp";
		}
		if (payMethod == 3) { // 货到付款
			orderService.pay(order.getId()); // 直接算完成支付
			request.setAttribute("msg", "下单成功");
			return "msg.jsp";
		}
		request.setAttribute("msg", "请选择正确的支付方式");
		return "msg.jsp";
	}

	/**
	 * 将购物车条目转化为订单条目
	 * @param oid
	 * @param cart
	 * @return
	 */
	private List<OrderItem> toOrderItems(Cart cart, String oid) {
		Collection<CartItem> cartItems = cart.getCartItems();
		List<OrderItem> orderItems = new ArrayList<OrderItem>();
		for (CartItem ci : cartItems) {
			OrderItem oi = new OrderItem();
			oi.setOid(oid);
			oi.setFid(ci.getFid()); // 设置所属菜品
			oi.setCount(ci.getCount()); // 设置菜品数量
			oi.setSubtotal(ci.getSubtotal()); // 设置小计
			orderItems.add(oi);
		}
		return orderItems;
	}

	// 我的订单
	public String myOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");
		List<Order> orderList = orderService.listUserOrder(user.getId());
		
		request.setAttribute("orderList", orderList);
		return "myorder.jsp";
	}

	// 订单详情
	public String toDetail(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String oid = request.getParameter("oid");
		Order order = orderService.load(oid);
		request.setAttribute("order", order);
		return "WEB-INF/orderdetail.jsp";
	}

	// 去支付
	public String toPay(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String oid = request.getParameter("oid");
		Order order = orderService.load(oid);
		request.setAttribute("order", order);
		return "pay?m=alipay";
	}

	// 确认送达
	public String confirmOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String oid = request.getParameter("oid");
		try {
			orderService.confirmOrder(oid);
		} catch (OrderException e) {
			request.setAttribute("msg", e.getMessage());
			return "msg.jsp";
		}

		// 根据来源决定转发到哪里
		String from = request.getParameter("from");
		if ("order".equals(from)) { // 我的订单页面
			return myOrder(request, response);
		}
		if ("detail".equals(from)) { // 订单详情页面
			request.setAttribute("order", orderService.load(oid));
			return "WEB-INF/orderdetail.jsp";
		}
		return null;
	}

	// 再来一单
	public String orderAgain(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String oid = request.getParameter("oid");
		Order order = orderService.load(oid);
		/*
		 * 将订单中的条目添加到购物车
		 */
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		cart.clear(); // 会清空所有购物车原有条目
		cart.add(toCartItems(order));
		request.setAttribute("order", order);
		return "WEB-INF/checkout.jsp";
	}

	/**
	 * 将订单条目转化为购物车条目
	 * @param order
	 * @return
	 */
	private List<CartItem> toCartItems(Order order) {
		List<CartItem> cartItems = new ArrayList<>();
		List<OrderItem> orderItems = order.getOrderItems();
		for (OrderItem orderItem : orderItems) {
			CartItem cartItem = new CartItem();
			cartItem.setFid(orderItem.getFid());
			cartItem.setUid(order.getUid());
			cartItem.setFood(orderItem.getFood());
			cartItem.setCount(orderItem.getCount());
			cartItems.add(cartItem);
		}
		return cartItems;
	}

	// 评价订单
	public void evaluateOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String oid = request.getParameter("oid");
		// json数组，所有评价信息
		JSONArray comments = new JSONArray(request.getParameter("comments"));
		// 将json数组转成List
		List<Evaluation> eList = comments.toList(Evaluation.class);
		
		orderService.evaluateOrder(oid, eList);
		response.getWriter().print(1);
	}
}