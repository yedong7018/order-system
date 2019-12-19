<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>忘记密码</title>
<link href="${basePath }/css/t1.css" rel="stylesheet">
<script src="${basePath }/js/jquery-1.9.1.min.js"></script>
<script src="${basePath }/js/jquery.validate.min.js"></script>
<script src="${basePath }/js/common.js"></script>
</head>
<body>
	<form method="post" id="findPwdForm" action="${basePath }/user">
		<input type="hidden" name="method" value="find_pwd"/>
		<div class="divlogin">
			<div class="divfnpw">
				<select id="type" name="type">
  					<option ${username } value="username">用户名</option>
 					<option ${phone } value="phone">手机号</option>
  					<option ${email } value="email">邮箱地址</option>
				</select>
				<input type="text" name="info" placeholder="根据该信息找回密码" value="${info }">
				<label for="info" class="${error }">${msg }</label>
			</div>
			<button type="submit" name="btn_fnpw">找回密码</button>
			<h2 class="h2reg">找回密码链接稍后会发送到该邮箱中</h2>
		</div>
	</form>
</body>
</html>
