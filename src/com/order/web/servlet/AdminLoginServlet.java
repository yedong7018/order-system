package com.order.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.order.dao.AdminDao;
import com.order.model.Admin;

import cn.itcast.commons.CommonUtils;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	private AdminDao adminDao = new AdminDao();
	
	// 登录
	public String login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 封装表单
		Admin form = CommonUtils.toBean(request.getParameterMap(), Admin.class);
		Admin admin = adminDao.findByName(form.getAdmName());
		if (admin != null && form.getAdmPassword().equals(admin.getAdmPassword())) { // 登录成功
			request.getSession().setAttribute("admin", admin);
			return "r:/admin/main.jsp";
		} else { // 登录失败
			request.setAttribute("form", form);
			request.setAttribute("msg", "账号或密码错误");
			request.setAttribute("error", "error");
			return "adminLogin.jsp";
		}
	}
	
	// 退出
	public String quit(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getSession().invalidate();
		return "r:/adminLogin.jsp";
	}
}
