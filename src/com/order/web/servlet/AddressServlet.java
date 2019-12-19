package com.order.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.order.model.Address;
import com.order.model.User;
import com.order.service.AddressService;

import cn.hutool.core.convert.Convert;
import cn.itcast.commons.CommonUtils;

@WebServlet("/address")
public class AddressServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	private AddressService addrService = new AddressService();

	public String findAll(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");
		user.setAddrList(addrService.listUserAddr(user.getId()));
		request.setAttribute("a", "selected");
		return "userinfo.jsp";
	}

	public String addOrUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");
		Address address = CommonUtils.toBean(request.getParameterMap(), Address.class);
		if (address.getId() == 0) { // 新增地址
			address.setUid(user.getId());
			long id = addrService.add(address);
			response.getWriter().print(id);
		} else { // 更新地址
			addrService.update(address.getId(), address);
			response.getWriter().print(true);
		}
		if ("userinfo".equals(request.getParameter("from"))) {
			return findAll(request, response);
		}
		return null;
	}

	public void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Convert.toInt(request.getParameter("id"));
		addrService.delete(id);
		
		User user = (User) request.getSession().getAttribute("user");
		user.getAddrList().remove(new Address(id));
		
		response.getWriter().print(1);
	}
}