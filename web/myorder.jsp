<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${basePath }/css/bootstrap.min.css" rel="stylesheet">
<script src="${basePath }/js/jquery-1.9.1.min.js"></script>
<script src="${basePath }/js/bootstrap.min.js"></script>
<title>我的订单</title>
</head>
<style>
body{
	background: rgba(0, 0, 0, 0);
}

.myorder-background {
	width: 100%;
	height: 90%;
	position: fixed;
	margin: auto;
	left: 0;
	right: 0;
	bottom: 0;
}

.myorder-content {
	min-width: 1306px;
	width: 85%;
	height: 100%;
	position: absolute;
	left: 7.5%;
	right: 7.5%;
	margin: auto;
}

.myorder-content * {
	font-weight: 200;
	top: 0;
	float: left;
}

.myorder-search {
	width: 15%;
	height: 100%;
	position: absolute;
	left: 0%;
	right: 85%;
	margin: auto;
	background-color: #ddd;
}

.search-text {
	line-height: 73.6px;
	height: 73.6px;
	font-size: 24px;
	width: 100%;
	text-align: center;
}

.myorder-search * {
	padding: 0;
	cursor: pointer;
	font-size: 20px;
	width: 100%;
	height: 45px;
	line-height: 45px;
	border: 0;
	text-align: center;
	outline: none;
}

.search-spanlabel {
	cursor: default;
	font-size: 16px;
}

input[type=date]::-webkit-inner-spin-button, input[type=date]::-webkit-clear-button
	{
	width: 0px;
	visibility: hidden;
	display: none;
}

.daterange_input {
	border: 0;
	background-color: rgba(150, 150, 150, 0);
	width: 80%;
	height: 100%;
	line-height: 45px;
	float: right;
	outline: 0;
}

.myorder-info {
	position: absolute;
	width: 85%;
	height: 94%;
	top: 6%;
	left: 15%;
	right: 0;
	margin: auto;
	background-color: #eee;
	overflow: auto;
}

.myorder-info::-webkit-scrollbar {
	width: 8px;
}

.myorder-info::-webkit-scrollbar-thumb {
	border-radius: 8px;
	background: rgba(0, 0, 0, 0.2);
}

.myorder-info::-webkit-scrollbar-track {
	background: rgba(0, 0, 0, 0);
}

.myorder-info .row div {
	font-size: 18px;
	text-align: center;
	line-height: 100px;
	padding: 0;
}

.myorder-info .row {
	width: 100%;
	margin: 20px 0 ;
}

.myorder-title {
	width: 85%;
	height: 6%;
	position: absolute;
	margin: 0;
	left: 15%;
	top: 0;
	right: 0;
	bottom: 94%;
	background-color: #eee;
}

.myorder-title .row div {
	text-align: center;
	line-height: 36.8px;
	padding: 0;
}

.info-date{
	line-height: 80px; 
	height: 100%; 
	/* border-right: 2px solid #000; */
}

.info-date-day{
	width: 100%; 
	height: 60px; 
	margin: 0; 
	font-size: 16px;
}

.info-date-time{
	width: 100%; 
	height: 40px; 
	margin: 0; 
	font-size: 16px;
	line-height: 20px;
}

.info-img{
	width: 86px; 
	height: auto; 
	border-radius: 7%; 
	margin: 7px 7px 7px 20px;
}

.info-foodname {
	text-align: center;
	line-height: 70px;
}

.info-orderid {
	font-size: 16px;
	text-align: center;
	line-height: 10px;
}

.myorder-state {
	margin-top: 36px;
}

.myorder-state span {
	width: 100%;
}

.spanbtn_div, .searchbtn_div {
	z-index: 1;
	width: 100%;
	height: 50px;
	position: relative;
	cursor: pointer;
	padding: auto;
	margin: 0;
	transition: 1s;
}

.spanbtn_div:hover, .searchbtn_div:hover {
	color: #fff;
	transition: .54s;
}

.bgsearch {
	margin-top: 20%;
	background-color:#bbb;
}

.spanbtn_div:before, .searchbtn_div:before {
	z-index: -1;
	content: "";
	width: 0%;
	height: 100%;
	position: absolute;
	top: 0;
	transition: .36s;
}

.spanbtn_div:before {
	right: 0;
}

.searchbtn_div:before {
	left: 0;
}

.spanbtn_div:hover:before, .searchbtn_div:hover:before, .bgdetail_click:before,
	.bgagain_click:before, .bgpay_click:before {
	width: 100%;
}

.bgdetail_click, .bgagain_click, .bgpay_click,{
	color: white;
}

.bgdetail:hover:before, .bgdetail_click:before {
	background-color: rgba(0, 137, 220, .7);
}

.bgagain:hover:before, .bgagain_click:before {
	background-color: rgba(102, 193, 140, .9);
}

.bgpay:hover:before, .bgpay_click:before {
	background-color: rgba(36, 168, 56, .9);
}

.bgsearch:hover:before {
	background-color: rgba(128, 128, 128, .9);
}

.spanbtn_div span {
	height: 100%;
	width: 100%;
	line-height: 50px;
}
</style>
<body>
	<div class="myorder-background">
		<div class="myorder-content">
			<div class="myorder-search">
				<label class="search-text">订单信息 </label> <span
					class="search-spanlabel glyphicon glyphicon-calendar"
					style="margin-top: 20%;">日期</span>
				<div>
					从<input class="daterange_input" type="date" />
				</div>
				<div>
					至<input class="daterange_input" type="date" />
				</div>
				<span class="search-spanlabel glyphicon glyphicon-check">状态</span>
				<div class="searchbtn_div bgdetail">
					<span class="glyphicon glyphicon-ok"> 已完成</span>
				</div>
				<div class="searchbtn_div bgpay">
					<span class="glyphicon glyphicon-qrcode"> 待支付</span>
				</div>
				<div class="searchbtn_div bgagain">
					<span class="glyphicon glyphicon-send"> 待送达</span>
				</div>
				<div class="searchbtn_div bgsearch">
					<span class="glyphicon glyphicon-search"> 进行筛选</span>
				</div>
			</div>
			<div class="myorder-title">
				<div class="row" style="width: 100%; margin: 0;">
					<div class="col-xs-1">日期</div>
					<div class="col-xs-5">订单简介</div>
					<div class="col-xs-6">
						<div class="col-xs-4">金额</div>
						<div class="col-xs-4">状态</div>
						<div class="col-xs-4">操作</div>
					</div>
				</div>
			</div>
			
			<div class="myorder-info">
				<c:forEach items="${orderList }" var="order">
				<div class="row">
					<div class="col-xs-1 info-date" >
						<label class="info-date-day">${order.time.year + 1900 }-${order.time.month + 1 }-${order.time.date }</label>
						<label class="info-date-time">${order.time.hours }:${order.time.minutes }</label>
					</div>
					<div class="col-xs-5">
						<c:forEach items="${order.orderItems }" var="orderItem" varStatus="vs">
						<c:if test="${vs.index == 0 }">
						<img class="info-img" src="http://47.100.204.138:9090/ima/${orderItem.food.image }"></c:if>
						</c:forEach>

						<div style="width: 340px;">
							<c:forEach items="${order.orderItems }" var="orderItem" varStatus="vs">
							<c:if test="${vs.index == 0 }">
							<label class="info-foodname">${orderItem.food.name }</label></c:if>
							<c:if test="${vs.index == 1 }">
							<label class="info-foodname">、${orderItem.food.name }</label></c:if>
							<c:if test="${vs.last }">
							<label class="info-foodname" style="margin-left: 5%;">共${vs.index + 1 }件</label></c:if>
							</c:forEach>
						</div>

						<label class="info-orderid">订单号：${order.id }</label>
					</div>
					<div class="col-xs-6">
						<div class="col-xs-4">￥${order.total }</div>
						<div class="col-xs-4 myorder-state" style="padding-left: 15px;">
							<!-- 三选一 -->
							<c:choose>
								<c:when test="${order.state == 1 }">
								<span class="glyphicon glyphicon-qrcode"> 待支付</span></c:when>
								<c:when test="${order.state == 2 }">
								<span class="glyphicon glyphicon-send"> 待送达</span></c:when>
								<c:when test="${order.state >= 3 }">
								<span class="glyphicon glyphicon-ok"> 已完成</span></c:when>
							</c:choose>
						</div>
						<div class="col-xs-4">
							<div class="spanbtn_div bgdetail">
								<span class="glyphicon glyphicon-list-alt orderbtn" onclick="toDetail('${order.id}')"> 查看详情</span>
							</div>
							
							<c:if test="${order.state == 1 }">
							<div class="spanbtn_div bgpay">
								<span class="glyphicon glyphicon-chevron-right orderbtn" onclick="toPay('${order.id}')"> 前往支付</span>
							</div>
							</c:if>
							
							<c:if test="${order.state == 2 }">
							<div class="spanbtn_div bgagain">
								<span class="glyphicon glyphicon-saved orderbtn"
									onclick="confirmOrder('${order.id}')"> 确认送达</span>
							</div>
							</c:if>
							
							<c:if test="${order.state >= 3 }">
							<div class="spanbtn_div bgagain">
								<span class="glyphicon glyphicon-shopping-cart orderbtn"
									onclick="orderAgain('${order.id}')"> 再来一单</span>
							</div>
							</c:if>
						</div>
					</div>
				</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
<script>
	// 查看详情
	function toDetail(oid) {
		location.href = "${basePath}/order?m=toDetail&oid=" + oid;
	};
	// 去支付
	function toPay(oid) {
		top.location.href = "${basePath}/order?m=toPay&oid=" + oid;
	};
	// 确认送达
	function confirmOrder(oid) {
		location.href = "${basePath}/order?m=confirmOrder&oid=" + oid + "&from=order";
	};
	// 再来一单
	function orderAgain(oid) {
		location.href = "${basePath}/order?m=orderAgain&oid=" + oid;
	};
	
	var dateR0 = $(".daterange_input").eq(0);
	var dateR1 = $(".daterange_input").eq(1);

	$(function() {
		$(parent.document.getElementById("iframeK")).hide();
		function GetDateStr(AddDayCount) {
			var dd = new Date();
			dd.setDate(dd.getDate() + AddDayCount);//获取AddDayCount天后的日期
			var y = dd.getFullYear();
			var m = (dd.getMonth() + 1) < 10 ? "0" + (dd.getMonth() + 1) : (dd
					.getMonth() + 1);//获取当前月份的日期，不足10补0
			var d = dd.getDate() < 10 ? "0" + dd.getDate() : dd.getDate();//获取当前几号，不足10补0
			return y + "-" + m + "-" + d;
		}

		//时间范围上限设置为当前时间 ,下限设置为三月前
		var nowdate = GetDateStr(0);
		var olddate = GetDateStr(-90);

		dateR0.val(olddate).attr("max", nowdate);
		dateR1.val(nowdate).attr("max", nowdate).attr("min", olddate);
	});

	dateR1.change(function() {
		dateR0.attr("max", dateR1.val());
	});
	dateR0.change(function() {
		dateR1.attr("min", dateR0.val());
	});

	$(".searchbtn_div.bgpay").click(function() {
		$(this).before().toggleClass("bgpay_click");
	});
	$(".searchbtn_div.bgdetail").click(function() {
		$(this).before().toggleClass("bgdetail_click");
	});
	$(".searchbtn_div.bgagain").click(function() {
		$(this).before().toggleClass("bgagain_click");
	});
</script>
</html>