<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<script src="${basePath }/js/jquery-1.9.1.min.js"></script>
<style>
body {
	background-color: rgba(0,0,0,0);
}

* {
	margin: 0;
}

#box::-webkit-scrollbar {
	display: none;
}

ul {
	list-style-type: none;
	padding-left: 0;
}

.kind li {
	border: 0;
	margin: 10px 0px;
	color: black;
	text-align: center;
	width: 90%;
	height: 45px;
	line-height: 45px;
	cursor: pointer;
	outline: none;
	-webkit-transition: all 1s;
	border-radius: 0 5px 20px 2px;
}

.odd_kind {
	background-color: rgba(230, 230, 230, .5);
	box-shadow: 9px 7px 20px -6px rgba(230, 230, 230, .3);
}

.even_kind {
	background-color: rgba(180, 180, 180, .5);
	box-shadow: 9px 7px 20px -6px rgba(180, 180, 180, .3);
}

.kind li:hover {
	border-radius: 0;
	width: 100%;
	background-color: rgba(0, 137, 230, .8);
	box-shadow: 0 15px 30px 0 rgba(0, 137, 230, 0.15) inset, 0 2px 7px 0
		rgba(0, 137, 230, 0.2);
	-webkit-transition: all .1s;
}

.kind li:active, .kind li:visited, .kind-selected {
	border-radius: 0;
	background-color: rgba(30, 137, 224, 0.7);
	width: 100%;
	box-shadow: 0 5px 8px 0 rgba(0, 137, 230, .1) inset, 0 1px 4px 0
		rgba(0, 137, 230, .1)
}

li a:link,
li a:focus,
li a:active,
li a:hover,
li a:visited {
	color: black;
	text-decoration: none;
}

.kind li:hover a , .kind-selected a{
	color:white!important;
}
</style>
</head>
<body id="box">
	<ul class="kind">
		<li class="kind-selected">
			<a target="frameInfo" href="${basePath }/food?m=findByType&typeId=0">全部分类</a>
		</li>
		<c:forEach items="${ftList }" var="ft">
			<li>
				<a target="frameInfo" href="${basePath }/food?m=findByType&typeId=${ft.id}">${ft.name }</a>
			</li>
		</c:forEach>
	</ul>
</body>
<script>
	$(document).ready(function() {
		$("li:odd").addClass("odd_kind");
		$("li:even").addClass("even_kind");
	});
	$("li").click(function() {
		$(this).addClass("kind-selected");
		$(this).siblings(".kind-selected").removeClass("kind-selected");
		$(this).find("a")[0].click();
	});
</script>
</html>