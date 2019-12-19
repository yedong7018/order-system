<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>注册</title>
<link href="${basePath }/css/t1.css" rel="stylesheet">
<script src="${basePath }/js/jquery-1.9.1.min.js"></script>
<script src="${basePath }/js/jquery.validate.min.js"></script>
<script src="${basePath }/js/common.js"></script>
</head>
<body>
	<form method="post" id="registForm" action="${basePath }/user">
		<input type="hidden" name="method" value="regist"/>
		<div class="divreg">
			<h2 class="h2reg">注册帐号</h2>

			<div class="divinput">
				<input type="text" name="username" placeholder="用户名">
			</div>
			<div class="divinput">
				<input type="password" id="password" name="password" placeholder="密码" >
			</div>
			<div class="divinput">
				<input type="password" name="confirm_password" placeholder="确认密码" >
			</div>
			<div class="divinput">
				<input type="email" name="email" placeholder="邮箱地址" >
			</div>

			<div class="divinput">
				<input type="number" name="phone" placeholder="手机号码" >
			</div>

			<div class="divinput">
				<input type="text" name="captcha" placeholder="验证码">
			</div>

			<div class="divinput" style="margin-top: 25px; height:50px;">
				<img id="captcha" src="${basePath }/captcha" 
				onclick="refreshCode()" style="cursor: pointer;" />
			</div>

			<button type="submit" name="btn_reg">注册</button>
		</div>
	</form>
</body>
<script>
function refreshCode() {
	$("#captcha").attr("src", "${basePath}/captcha?time="+ new Date().getTime());
}
</script>
</html>
