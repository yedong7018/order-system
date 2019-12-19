<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>登录</title>
<link href="${basePath }/css/t1.css" rel="stylesheet">
<script src="${basePath }/js/jquery-1.9.1.min.js"></script>
<script src="${basePath }/js/jquery.validate.min.js"></script>
<script src="${basePath }/js/common.js"></script>
</head>
<body>
	<form method="post" id="loginForm" action="${basePath }/user">
		<input type="hidden" name="method" value="login"/>
		<div class="divlogin">
			<h2 class="h2login">公司内部订餐系统</h2>
			
			<div class="divinput">
				<input type="text" id="username" name="username" placeholder="请输入用户名" value="${form.username }">
				<label for="username" class="error" style="display:none;"></label>
			</div>

			<div class="divinput">
				<input type="password" id="password" name="password" placeholder="请输入密码" value="${form.password }">
				<label for="password" class="${error }">${msg }</label>
			</div>
			<div style="margin-top:25px;">
				<button type="submit" name="btn_login">登录</button>
				<button type="button" name="btn_regist" onclick="location.href='regist.jsp'">注册</button>
				<button type="button" name="btn_forget" onclick="location.href='find_pwd.jsp'">找回密码</button>
			</div>
		</div>
	</form>
</body>
</html>
