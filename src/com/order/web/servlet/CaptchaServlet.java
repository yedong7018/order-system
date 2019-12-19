package com.order.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.hutool.captcha.ICaptcha;
import cn.hutool.captcha.ShearCaptcha;

/**
 * 用于刷新验证码的servlet
 * @author hoby
 * @date 2019年6月16日
 */
@WebServlet("/captcha")
public class CaptchaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		 * 1. 创建验证码类
		 */
		ICaptcha captcha = new ShearCaptcha(300, 50, 4);
		/*
		 * 2. 得到验证码图片
		 */
		captcha.createCode();
		/*
		 * 3. 把图片上的文本保存到session域中
		 */
		request.getSession().setAttribute("captcha", captcha.getCode());
		/*
		 * 4. 把图片响应给客户端
		 */
		captcha.write(response.getOutputStream());
	}

}