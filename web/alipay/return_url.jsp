<%@ page import="com.alipay.api.internal.util.AlipaySignature"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.alipay.api.*"%>
<%@ page import="com.order.model.Order"%>
<%@ page import="com.order.model.*"%>
<%@ page import="com.order.service.*"%>

<html>
<head>
<title>支付宝页面跳转同步通知页面</title>
</head>
<body>
	<%
		//获取支付宝GET过来反馈信息
		Map<String, String> params = new HashMap<String, String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i] : valueStr + values[i] + ",";
			}
			params.put(name, valueStr);
		}

		//商户订单号
		String out_trade_no = request.getParameter("out_trade_no");

		//支付宝交易号
		String trade_no = request.getParameter("trade_no");

		//交易状态
		String trade_status = request.getParameter("trade_status");

		//计算得出通知验证结果
		boolean verify_result = AlipaySignature.rsaCheckV1(params,
				"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoiFIdcFfkEIndxo6ipRvEWvqD0gW0kC6b2L0PLKvWT+I9TqxWh0JcQh9wK7wD2N4BbHCSS/asaHIyX92wqs5TgLrlIO+TrCFlvM/hVQ1QpMUP/O8rcoNSmWOUzL78vIaphlkkXsl2RvRdXKmdAlXaYcynt+o/nDAos83WgxXNx4oqSqf2a8Va9QDbM42VtG7W+8JrwaCmd2Cmjugw/I0txOBYRF2h/WjLOQiVNCpYRPCLoKSrUAa4nA2UdKouTyoOItT1AYcwlLay+RXTi7SfUn1odkhTJb8riyw5Q1NXHFfsz4aWEUx0ie3KKUJEPX4/GkCoYy/61DlfOijY6qj4QIDAQAB",
				"UTF-8", "RSA2");

		OrderService orderService = new OrderService();
		orderService.pay(out_trade_no);
		//查询订单状态，如果为2代表支付成功
		int state = orderService.getState(out_trade_no);
		if (verify_result && state == 2) { //验证成功
			request.setAttribute("msg", "支付成功");
		} else { //验证失败
			request.setAttribute("msg", "支付失败");
		}
		request.getRequestDispatcher("/msg.jsp").forward(request, response);
	%>
</body>
</html>