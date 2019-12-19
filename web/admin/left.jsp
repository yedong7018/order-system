<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link href="${basePath }/css/bootstrap.min.css" rel="stylesheet">
<script src="${basePath }/js/jquery-1.9.1.min.js"></script>
<script src="${basePath }/js/bootstrap.min.js"></script>
</head>
<style>
body {
	background-color: rgba(0,0,0,0);
}

ul {
	list-style-type: none;
	padding-left: 0;
	margin-top: 45px;
}

li {
	box-shadow: 9px 7px 10px -6px rgba(0, 0, 0, 0.25);
	border: 0;
	margin: 25px 0px;
	text-align: center;
	width: 90%;
	height: 55px;
	line-height: 55px;
	font-size: 16px;
	cursor: pointer;
	outline: none;
	-webkit-transition: all 1s;
	border-radius: 0 5px 20px 2px;
}

.odd-title {
	background-color: rgba(255, 133, 71, 0.6);
}

.even-title {
	background-color: rgba(255, 205, 64, 0.6);
}

li:hover {
	border-radius: 0;
	width: 100%;
	border-color: rgba(255, 205, 64, 0.5);
	background-color: rgba(30, 137, 224, 0.7);
	box-shadow: 0 15px 30px 0 rgba(255, 255, 255, .15) inset, 0 2px 7px 0
		rgba(0, 0, 0, .2);
	-webkit-transition: all .1s;
}

li:active,
li:visited,
.title-selected {
	border-radius: 0;
	background-color: rgba(30, 137, 224, 0.7);
	width: 100%;
	box-shadow: 0 5px 8px 0 rgba(0, 0, 0, .1) inset, 0 1px 4px 0
		rgba(0, 0, 0, .1);
}

a:link,
a:focus,
a:active,
a:hover,
a:visited {
	color: black;
	text-decoration: none;
}
</style>
<body>
	<ul>
		<li><a href="${basePath }/foodType?m=findAll&identity=admin" target="iframe-body">分类管理</a></li>
		<li><a href="${basePath }/food?m=findAll&identity=admin" target="iframe-body">菜品管理</a></li>
		<li><a href="#" target="iframe-body">订单管理</a></li>
	</ul>
</body>
<script>
$(function() {
	$("li:odd").addClass("odd-title");
	$("li:even").addClass("even-title");
	$("li").click(function() {
		$(this).addClass("title-selected");
		$(this).siblings(".title-selected").removeClass("title-selected");
		$(this).find("a")[0].click();
	});
});
</script>
<html>
