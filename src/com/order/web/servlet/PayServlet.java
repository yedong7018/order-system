package com.order.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.alipay.api.response.AlipayTradePagePayResponse;
import com.order.model.Order;
import com.order.util.PayUtil;

@WebServlet("/pay")
public class PayServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;
	private AlipayClient alipayClient = PayUtil.getAlipayClient();
	private AlipayTradePagePayRequest alipayRequest;
	private AlipayTradePagePayResponse alipayResponse;

	public String alipay(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		 * 设置订单的一些基本信息
		 */
		Order order = (Order) request.getAttribute("order");
		String out_trade_no = order.getId();
		String total_amount = order.getTotal() + "";
		String subject = "311公司订餐订单" + out_trade_no;
		String body = "您点了共" + order.getOrderItems().size() + "件菜品";
		alipayRequest = PayUtil.getAlipayTradePagePayRequest(out_trade_no, total_amount, subject, body);

		try {
			alipayResponse = alipayClient.pageExecute(alipayRequest);
			if (alipayResponse.isSuccess()) {
				response.getWriter().print(alipayResponse.getBody());
				return null;
			} else {
				request.setAttribute("msg", "跳转到支付页面失败");
				return "msg.jsp";
			}
		} catch (AlipayApiException e) {
			request.setAttribute("msg", "下单失败");
			return "msg.jsp";
		}
	}
}