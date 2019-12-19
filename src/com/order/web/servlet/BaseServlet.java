package com.order.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.hutool.core.util.ReflectUtil;
import cn.hutool.core.util.StrUtil;

/**
 * 用来作为其它Servlet的父类
 */
public abstract class BaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		/**
		 * 1. 获取method或m参数，它是用户想调用的方法
		 */
		String methodName = request.getParameter("method");
		if (StrUtil.isBlank(methodName)) {
			methodName = request.getParameter("m");
		}
		/**
		 * 2. 通过invoke()来调用这个方法
		 */
		String result = ReflectUtil.invoke(this, methodName, request, response);
		if (StrUtil.isBlank(result)) { // 返回值为void或""
			return;
		}
		String way = StrUtil.subBefore(result, ":", true);
		String path = StrUtil.subAfter(result, ":", true);
		if (way.equals(result)) { // 没有冒号
			request.getRequestDispatcher(result).forward(request, response);
		} else if (way.equals("f")) { // 转发
			request.getRequestDispatcher(path).forward(request, response);
		} else if (way.equals("r")) { // 重定向
			response.sendRedirect(request.getContextPath() + path);
		}
	}
}
