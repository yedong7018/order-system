package com.order.web.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.order.exception.UserException;
import com.order.model.Cart;
import com.order.model.CartItem;
import com.order.model.Food;
import com.order.model.User;
import com.order.service.AddressService;
import com.order.service.CartService;
import com.order.service.UserService;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.convert.Convert;
import cn.itcast.commons.CommonUtils;

@WebServlet("/user")
public class UserServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();
	private CartService cartService = new CartService();
	private AddressService addrService = new AddressService();

	// 注册
	public String regist(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 封装表单
		User form = CommonUtils.toBean(request.getParameterMap(), User.class);
		// 调用业务层完成注册
		userService.regist(form);
		// 重定向到登录页面
		return "r:/login.jsp";
	}

	// 登录
	public String login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 封装表单
		User form = CommonUtils.toBean(request.getParameterMap(), User.class);
		try {
			User user = userService.login(form);
			request.getSession().setAttribute("user", user);
			/*
			 * 加载用户的购物车
			 */
			Cart cart = new Cart(user.getId());
			List<CartItem> cartItems = cartService.getCartItems(user.getId());
			cart.add(cartItems);
			request.getSession().setAttribute("cart", cart);

			user.setAddrList(addrService.listUserAddr(user.getId())); // 加载用户地址列表
			System.out.println(user);
			return "r:/main.jsp"; // 重定向到主页
		} catch (UserException e) { // 登录失败
			request.setAttribute("form", form);
			request.setAttribute("msg", e.getMessage());
			request.setAttribute("error", "error");
			return "login.jsp";
		}
	}

	// 退出
	public String quit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getSession().invalidate();
		return "r:/main.jsp";
	}

	// 找回密码
	public String find_pwd(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String type = request.getParameter("type"); // 找回密码的方式
		String info = request.getParameter("info"); // 找回密码的信息
		User user = userService.load(type, info);
		if (user != null) {
			userService.findPwd(user);
			request.setAttribute("msg", "找回密码邮件已发送至" + user.getEmail());
			return "msg.jsp";
		} else {
			// 数据回显
			request.setAttribute("msg", "账号不存在");
			request.setAttribute(type, "selected='selected'");
			request.setAttribute("info", info);
			request.setAttribute("error", "error");
			return "find_pwd.jsp";
		}
	}

	// 去重置密码页面
	public String to_reset_pwd(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String code = request.getParameter("code");
		User user = userService.load("code", code);
		if (user != null) {
			request.setAttribute("user", user);
			return "WEB-INF/reset_pwd.jsp";
		} else {
			request.setAttribute("msg", "链接无效");
			return "msg.jsp";
		}
	}

	// 重置密码
	public String reset_pwd(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String code = request.getParameter("code");
		User user = userService.load("code", code);
		if (user != null) {
			user.setPassword(request.getParameter("password"));
			userService.resetPwd(user);
			request.setAttribute("msg", "重置密码成功");
		} else {
			request.setAttribute("msg", "重置密码失败");
		}
		return "msg.jsp";
	}

	// 更新密码
	public void update_pwd(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");
		String oldPwd = request.getParameter("old_pwd"); // 旧密码
		String newPwd = request.getParameter("new_pwd"); // 新密码
		if (oldPwd.equals(user.getPassword())) { // 原密码正确
			userService.updatePwd(user.getId(), newPwd);
			user.setPassword(newPwd);
			response.getWriter().print(true);
		} else { // 原密码错误
			response.getWriter().print(false);
		}
	}

	// 更新资料
	public String update_info(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 原用户
		User user = (User) request.getSession().getAttribute("user");
		// 从页面传过来的表单
		User form = CommonUtils.toBean(request.getParameterMap(), User.class);
		// copy表单值到原用户
		BeanUtil.copyProperties(form, user, "id", "password", "code");

		userService.updateInfo(user);
		return "userinfo.jsp";
	}

	// 检查信息是否被注册
	public void checkNotUsed(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String from = request.getParameter("from"); // 页面来源
		String type = request.getParameter("type"); // 要检查的类型
		String info = request.getParameter("info"); // 要检查的信息

		User result = userService.load(type, info); // 检查的结果
		User user = (User) request.getSession().getAttribute("user"); // 原有的信息

		if (result == null) { // 结果为空，说明没被注册
			response.getWriter().print(true);
			return;
		}
		// 来源是userinfo页面
		if ("userinfo".equals(from) && user.getId().equals(result.getId())) { // 结果和原有相同
			response.getWriter().print(true);
			return;
		}
		// 其余情况都是false
		response.getWriter().print(false);
	}

	// 检查验证码是否正确
	public void checkCaptcha(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String answer = (String) request.getSession().getAttribute("captcha"); // 答案
		String captcha = request.getParameter("captcha"); // 用户写的验证码
		if (captcha.equalsIgnoreCase(answer)) {
			response.getWriter().print(true);
		} else {
			response.getWriter().print(false);
		}
	}

	// 收藏菜品
	public void collect(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");
		int fid = Convert.toInt(request.getParameter("fid"));
		userService.collect(user.getId(), fid);
		response.getWriter().print(1);
	}

	// 取消收藏菜品
	public void discollect(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");
		int fid = Convert.toInt(request.getParameter("fid"));
		userService.discollect(user.getId(), fid);
		response.getWriter().print(1);
	}

	// 是否收藏某菜品
	public void isCollected(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) { // 没登录，不查询
			return;
		}
		int fid = Convert.toInt(request.getParameter("fid"));
		if (userService.isCollected(user.getId(), fid)) {
			response.getWriter().print(1);
		} else {
			response.getWriter().print(0);
		}
	}

	// 我的收藏
	public String myCollection(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		User user = (User) request.getSession().getAttribute("user");
		List<Food> foodList = userService.listCollection(user.getId());
		request.setAttribute("foodList", foodList);
		return "main_foodinfo.jsp";
	}

}