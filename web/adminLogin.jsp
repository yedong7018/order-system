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
	<form method="post" id="adminLoginForm" action="${basePath }/adminLogin">
		<div class="divlogin">
			<input type="hidden" name="method" value="login">
			<h2 class="h2login">公司内部订餐系统后台</h2>
			
			<div class="divinput">
				<input type="text" name="admName" placeholder="请输入用户名" value="${form.admName }">
			</div>

			<div class="divinput">
				<input type="password" name="admPassword" placeholder="请输入密码" value="${form.admPassword }">
				<label for="password" class="${error }">${msg }</label>
			</div>

			<button type="submit" name="btn_login">登录</button>
		</div>
	</form>
</body>
</html>
