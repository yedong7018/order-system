<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>重置密码</title>
<link href="${basePath }/css/t1.css" rel="stylesheet">
</head>
<body>
<form method="post" id="resetPwdForm" action="${basePath }/user">
	<input type="hidden" name="code" value="${user.code }"/>
	<input type="hidden" name="method" value="reset_pwd"/>
	<div class="divlogin">
		<h2 class="h2fnpw"><font color="red">${user.email }</font></h2>
		<h2 class="h2fnpw"><br/>重置上述邮箱地址的密码</h2>
		<div class="divinput">
			<input type="password" id="password" name="password" placeholder="新密码"></div>
		<div class="divinput">
			<input type="password" name="confirm_password" placeholder="确认密码"></div>
		<button type="submit" name="btn_reg">确认修改</button>
	</div>
</form>
</body>
</html>
