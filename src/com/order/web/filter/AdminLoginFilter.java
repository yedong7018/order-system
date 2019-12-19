package com.order.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.order.model.Admin;

@WebFilter(urlPatterns = { "/admin/*", "/addFood", "/foodSearch", "/updateFood" })
public class AdminLoginFilter implements Filter {

	public void init(FilterConfig fConfig) throws ServletException {

	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;

		Admin admin = (Admin) req.getSession().getAttribute("admin");
		if (admin == null) {
			resp.sendRedirect(req.getContextPath() + "/adminLogin.jsp");
		} else {
			chain.doFilter(request, response);
		}
	}

	public void destroy() {

	}
}
