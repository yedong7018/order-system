package com.order.util;

import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;

import cn.hutool.setting.dialect.Props;

public class PayUtil {
	public static AlipayClient getAlipayClient() {
		Props props = new Props("alipay.setting");
		String server_url = props.getStr("server_url");
		String app_id = props.getStr("app_id");
		String private_key = props.getStr("private_key");
		String public_key = props.getStr("public_key");
		return new DefaultAlipayClient(server_url, app_id, private_key, "json", "UTF-8", public_key, "RSA2");
	}

	public static AlipayTradePagePayRequest getAlipayTradePagePayRequest(String out_trade_no, String total_amount, String subject, String body) {
		Props props = new Props("alipay.setting");
		String returnUrl = props.getStr("return_url");
		String notifyUrl = props.getStr("notify_url");
		AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
		alipayRequest.setReturnUrl(returnUrl);
		alipayRequest.setNotifyUrl(notifyUrl);
		alipayRequest.setBizContent("{ "
				+ "\"out_trade_no\" : \"" + out_trade_no + "\"," 
				+ "\"total_amount\" : \"" + total_amount + "\"," 
				+ "\"subject\" : \"" + subject + "\"," 
				+ "\"body\" : \"" + body + "\"," 
				+ "\"product_code\" : \"FAST_INSTANT_TRADE_PAY\""
				+ "}");
		return alipayRequest;
	}
}
