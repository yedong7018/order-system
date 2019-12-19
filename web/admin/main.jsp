<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
</head>
<style>
body {
	width: max-content;
	height: -webkit-fill-available;
	background: linear-gradient(-45deg, #23A6D5, #2df5AB, #23Aff5, #ffD5AB);
	background-size: 400% 400%;
	animation: Gradient 15s ease infinite;
	overflow-y : hidden;
}
.div_top {
	width: 100%;
	height: 20%;
	z-index: 1;
	position: fixed;
	left: 0;
	top:0;
}
.div_left {
	width: 15%;
	height: 80%;   
	margin: auto;
    position: fixed;
    right: 85%;
    top: 20%;
    bottom: 0;
}
.div_body {
	width: 100%;
	height: 100%;
	margin: auto;
    position: fixed;
    left: 0%;
    right: 0;
    top: 0%;
    bottom: 0;
    z-index: -1;
}
iframe {
	position:absolute;
	width: 100%;
    height: 100%;
    border: 0;
    margin:0;
    padding:0;
}
</style>
<body>
	<div class="div_top">
		<iframe src="${basePath }/admin/top.jsp" name="iframe-top" id="iframe-top"></iframe>
	</div>
	<div class="div_left">
		<iframe src="${basePath }/admin/left.jsp" name="iframe-left" id="iframe-left"></iframe>
	</div>
	<div class="div_body">
		<iframe src="${basePath }/admin/body.jsp" name="iframe-body" id="iframe-body"></iframe>
	</div>
</body>
<script>
	
</script>
<html>