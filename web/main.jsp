<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
</head>
<style>
html {
	overflow-y: hidden;
}
body {
	background: linear-gradient(45deg,rgba(200,200,200,0.3), rgba(220, 220, 220, 0.2));
	background-size:400% 400%;
}
.div_nav {
	width: 100%;
	height: 10%;
	z-index: 1;
	position: fixed;
	top:0;
	left:0;
}
.div_kind {
	min-width:80px;
	width: 10%;
	height: 70%;
	margin: auto;
    position: fixed;
    left: 0;
    right: 95%;
    top: 0%;
    bottom: 0;
}
.div_food {
	background-color:rgba(0,0,0,0);
	width: 100%;
	height: 100%;
	margin: auto;
    position: fixed;
    left: 0%;
    right: 0;
    top: 0%;
    bottom: 0;
    z-index:-1;
}
iframe {
	width: 100%;
    height: 100%;
    border: 0;
}
</style>
<title>主页</title>
<body>
	<div class="div_nav">
		<iframe src="${basePath }/guide.jsp" name="frameNav" id="iframeN"></iframe>
	</div>
	<div class="div_kind">
		<iframe src="${basePath }/foodType?m=findAll&identity=user" name="frameKind" id="iframeK"></iframe>
	</div>
	<div class="div_food">
		<iframe src="${basePath }/food?m=findAll&identity=user" name="frameInfo" id="iframeF"></iframe>
	</div>
</body>
<script>
function adjustIfHt() {
    var ht = $(window).height(); //获取浏览器窗口的整体高度；
    var topHeader = 60; //获取头部高度，定义一个变量名为topHeader
    // $(".sidebar").height(ht);
    $("#iframeN").height(ht-topHeader);
 }
</script>
</html>