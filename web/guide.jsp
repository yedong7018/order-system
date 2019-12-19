<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link href="${basePath }/css/bootstrap.min.css" rel="stylesheet">
<script src="${basePath }/js/jquery-1.9.1.min.js"></script>
<script src="${basePath }/js/bootstrap.min.js"></script>
<style>
body {
	background : rgba(0,0,0,0);
}
header {
	position: fixed;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	font-weight: 200;
	outline:none;
}
header div {
	height: 55px;
	padding-left: 0px !important;
	padding-right: 0px !important;
}
header input {
	width: 100%;
	height: 100%;
	line-height: 55px;
	margin: 0;
	padding: 0 0 0 5px;
	font-family: "Microsoft YaHei", Helvetica, Arial, sans-serif;
	font-size: 18px;
	border:none;
	transition: all .5s;
	background : #d8e6ee;
	outline:none;
}
header input:focus , header input:hover{
	padding-left:15px;
	box-shadow: 0 10px 13px -5px rgba(0, 137, 220,.04), 0 10px 10px -5px rgba(0, 137, 220,.04);
	transition: .2s;
}

.nav_inPage{
	color: white;
	background : rgba(92, 184, 92, 0);
	box-shadow: none;
	text-decoration: none;
	cursor: default;
	disable:disable;
}
.nav_inPage:hover,.nav_inPage:hover,.nav_inPage:focus{
	box-shadow: none;
}
header a {
	height: 100%;
	background : rgba(0, 137, 220, .9);
	display: inline-block;
	color: white;
	text-decoration: none;
	text-align: center;
	font-size: 18px;
	font-weight: 200;
	width: 100%;
	line-height: 55px;
	transition: .5s;
}
header a:active, header a:focus, header a:hover  {
	color: black;
	background : rgba(0, 137, 220, .5);
	box-shadow: 0 10px 13px -5px rgba(0, 137, 220,.1), 0 10px 10px -5px rgba(0, 137, 220,.04);
	text-decoration: none;
	transition: .2s;
}
.extre{
	width:10%; 
	background: rgba(0, 137, 220, .9);
}

</style>
<body>
	<header id="header1">
			<div class="conter-fluid" >
				<div class="row" style="margin:0px;width:100%;display:flex;">
					<div class="extre">
					</div>
					<div style="width:80%;min-width:1000px;">
						<div class="col-xs-2">
							<a href="${basePath }/main.jsp" target="_parent" id="nav_main">主页</a>
						</div>
							
						<c:choose>
						<c:when test="${not empty sessionScope.user }">
						<div class="col-xs-3">
							<input id="searchinfo" type="text" placeholder="搜索菜品" onkeypress="if(event.keyCode==13) searchByName();"/>
						</div>
						<div class="col-xs-1">
							<a onclick="searchByName()" href="#" id="search" target="frameInfo">搜索</a>
						</div>
					
						<div class="col-xs-6">
							<div class="col-xs-3">
								<a href="${basePath }/order?m=myOrder" onclick="blurBtn(this)" target="frameInfo" id="nav_order">我的订单</a>
							</div>
							<div class="col-xs-3">
								<a href="${basePath }/user?m=myCollection" onclick="blurBtn(this)" target="frameInfo" id="nav_mycollection">我的收藏</a>
							</div>
							<div class="col-xs-3">
								<a href="${basePath }/userinfo.jsp" onclick="touserinfo(this)" target="frameInfo" id="nav_userinfo">用户中心</a>
							</div>
							<div class="col-xs-3">
								<a href="${basePath }/user?m=quit" target="_parent">退出登录</a>
							</div>
						</div>
						</c:when>
							
						<c:otherwise>
						<div class="col-xs-6">
							<input id="searchinfo" type="text" placeholder="搜索菜品或菜品分类" onkeypress="if(event.keyCode==13) searchByName();"/>
						</div>
						<div class="col-xs-1">
							<a  onclick="searchByName()" href="#" target="frameInfo" id="search">搜索</a>
						</div>
						<div class="col-xs-3">
							<div class="col-xs-6">
								<a href="${basePath }/regist.jsp" target="_parent" id="nav_order">注册</a>
							</div>
							<div class="col-xs-6">
								<a href="${basePath }/login.jsp" target="_parent" id="nav_mycollection" >登录</a>
							</div>
						</div>
						</c:otherwise>
						</c:choose>
					</div>
					<div class="extre">
					</div>
				</div>
			</div>
	</header> 
</body>
<script>
function searchByName() {
	var a = document.getElementById("search");
	var name = $("#searchinfo").val();
	a.href="${basePath}/food?m=findByName&name="+name + "&identity=user";
	a.click();
	a.blur();
	$(parent.document.getElementById("iframeK")).show();
};

function touserinfo(e) {
	$(parent.document.getElementById("iframeK")).hide();
	$(e).blur();
}; 
function blurBtn(e) {
	$(e).blur();
}
</script>
</html>