<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
</head>
<style>
body {
	background-color: rgba(255,255,255,.15);
	overflow-y: hidden;
}
.title {
	width: 100%;
	height: 100%;
	line-height: 140px;
	text-align: center;
	font-size: 36px;
	font-weight: bold;
}
.msg {
	position: absolute;
	top: 110px;
	right: 50px;
	font-size: 18px;
}
</style>
<body>
	<div class="title">订餐系统后台管理</div>
	<span class="msg">管理员：${sessionScope.admin.admName }
		<a href="${basePath }/adminLogin?m=quit" target="_top">退出</a>
	</span>
</body>
<script>
	
</script>
<html>