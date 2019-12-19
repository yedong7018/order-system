<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>提示</title>
<link href="${basePath }/css/t1.css" rel="stylesheet">
</head>
<body>
<div align="center" style="margin-top: 50px;">
	<h2 style="color: #DC143C;">${msg }</h2>
	<button onclick="location.href='${basePath }/main.jsp'">回到主页</button>
</div>
</body>
</html>
