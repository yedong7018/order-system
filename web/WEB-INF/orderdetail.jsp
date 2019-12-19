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
<style>
body {
	background: #f7f7f7;
	overflow-x:hidden;
}

/* .checkouthead {
	z-index: 1;
	width: 100%;
	height: 7%;
	margin: 0;
	position: absolute;
	left: 0;
	right: 0;
	bottom: 0;
	max-height: 120px;
	background: rgba(0, 130, 220, .6);
}

.checkouthead-content {
	width: 80%;
	height: 100%;
	margin: auto;
	position: absolute;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	max-height: 120px;
	min-width: 960px;
} */

.checkout-content {
	width: 80%;
	height: auto;
	margin: auto;
	position: absolute;
	left: 0;
	right: 0;
	top: 13%;
	bottom: 0;
	min-width: 1080px;
}

.checkout-cart-food {
	width: 100%;
	height: 54px;
	background: #eee;
	margin: 0;
}

.checkout-payinfo {
	z-index: 1;
	width: 65%;
	height: auto;
	margin: auto;
	position: absolute;
	left: 35%;
	right: 0;
	top: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0);
}

.checkouthead-text-id{
	float:right;
	margin:16px 0 0 10%;
	font-size:15px; 
	font-weight:200;
}

.checkout-cart {
	box-shadow: 0 2px 10px 0 rgba(0, 0, 0, 0.15);
	width: 34%;
	height: fit-content;
	margin: auto;
	position: absolute;
	left: 0;
	right: 65%;
	background: rgba(230, 230, 230, .8);
	min-width: 400px;
}

.checkout-cart-head {
	border-top: 1px dashed #999;
	width: 100%;
	margin: 0;
	height: 70px;
}

.top {
	top: -10%;;
}

.bottom {
	bottom: -10%;
}

.left {
	left: -3%;;
}

.right {
	right: -3%;
}

.corner {
	position: absolute;
	width: 6%;
	height: 0;
	padding-top: 6%;
	border-radius: 100%;
	background: #f7f7f7;
}

.checkout-cart-head-text {
	float:left;
	font-size: 26px;
	height: 100%;
	width: 30%;
	font-weight: 300;
	line-height: 70px;
	margin: 0 0 0 10%;
}

.checkout-cart-label {
	width: 100%;
	height: 40px;
	background: #eee;
	margin: 0;
}

.checkout-cart-label .row ,.checkout-cart-food .row, .comment .row{
	margin:0;
}

.checkout-cart-label label, .checkout-cart-food label, .comment label {
	width:100%;
	height:100%;
	text-align:center;
	font-size: 18px;
	font-weight: 300;
	margin:0;
}
.checkout-cart-food label, .comment label {
 	line-height:54px;
}
.checkout-cart-label label {
 	line-height:40px;
}

.checkout-cart-food:hover {
	background: rgba(255, 255, 255, 0.9);
}

.cartbottom{
    position: absolute;
    width: 100%;
    height: 120px;
}

.checkout-cart-bottom {
	box-shadow: 0 2px 10px 0 rgba(0, 0, 0, 0.15);
	z-index:-1;
	position:absolute;
	border-top: 1px dashed #999;
	border-bottom: 1px dashed #999;
	background:#eee;
	width: 100%;
	margin: 0;
	height: 120px;
}

.checkout-totalprcie {
	margin: 0 5% 0 0;
	font-size: 24px;
	font-weight: 200;
	width: auto;
	float: right;
	color: #ff3100;
}

.checkout-totalprcie strong {
	font-weight: 200;
	font-size: 32px;
}

.checkout-cart-bottom .labelprice2 {
	margin: 6% 5% 0 0;
	font-size: 24px;
	font-weight: 300;
	float: left;
}

.checkout-payinfo .payinfopart {
	width:100%;
	display:inline-table;
	margin: 0px 20px;
	padding-left:20px;
}

.title {   
    width:70%;
	margin: 10px 0px;
	font-size: 18px;
	font-weight: 400;
}

.myinputgroup{
    border-radius:10px;
	margin:2% 0% 2% 5%;
	width:30%;
    float:left;
    box-shadow: 1px 2px 4px 0px rgba(0, 0, 0, 0.1);
}
.addr{
	display:none;
	width:100%;
	height:75px;
	padding: 10px 0px;
	margin:5px 0px;
	border:2px solid #fff;
	background:#eee;
	float:left;
	border-radius:8px;
	box-shadow: 1px 2px 4px 0px rgba(0, 0, 0, 0.1);
}
.selected{
	display:block;
}

.addr label{
	font-weight:200;
}

.addr-span{
	margin:0;
	padding:0px 20px; 
	width:10%;
	height:100%;
	float:left;
	font-size:34px;
	line-height:55px;
	border-right:2px solid #fff;
}

.addr-else{
	margin:0;
	padding-left:10px;
	width:80%;
	height:100%;
	float:left;
}
.addr-btn{
	margin:0;
	width:10%;
	height:100%;
	float:left;
}
.addr-name{
	font-size:15px;
}

.addr-phone{
	padding-left:35px;
	font-size:15px; 
}

.addr-addr{
	width:100%;
	font-size:18px;
}

.btnspan{
    width: 10%;
}

.input-group>.input-group-addon{
	border:0;
}

.input-text{
	font-size: 18px;
	font-weight: 300;
    border:0;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	height: 45px;
	line-height: 45px;
	width:400px;
}

.labelpay{
	float:left;
	font-size: 18px;
	font-weight: 300;
	line-height: 70px;
    height: 100%;
    width:65%;
    text-align: center;
}
.imgpay{
	float: left;
	width: 35%;
    line-height: 70px;
}

.imgpay img{
	float:right;
	width:50px;
	line-height: 70px;
	margin-top:10%;
}
 
.paymethod{
	float:left;
	width:30%;
	height:70px;
	background:#fff; 
	border:2px solid #0000; 
	border-radius:10px;
    -webkit-transition: all .5s;
}

.wxpay{
	border:2px solid #24a838;
	color:#24a838;
	box-shadow: 0 2px 10px 0 rgba(36,168,56,.2);
}

.alipay{
	border:2px solid #0da0e6;
	color:#0da0e6;
	box-shadow: 0 2px 10px 0 rgba(13,160,230,.2);
}

.wopay{
	border:2px solid #000;
	color:#000;
	box-shadow: 0 2px 10px 0 rgba(0,0,0,0.2);
}

.againbtn {
	cursor:pointer;
    z-index:1;
	text-align:center;
	width:30%;
	height:50px; 
	line-height:50px;
	border-radius:10px;
	float:right;
	color:white;
	font-size:20px;
    position: relative;
    background: rgba( 255, 49, 0, 0.6);
    
}

.againbtn:before {
    border-radius:10px;
    transition: .36s;
    content: "";
    z-index:-1;
    position:absolute;
    height:50px;
    top:0;
    left:0;
    width:0;
    background: rgba(0,0,0,0); 
}

.againbtn:hover:before{
    width:100%;
}

.againbtn:hover:before{
    background:rgba(13,160,230,.9);
}

.comment-background{
   	z-index:100;
	top: 0%;
	left: 0%; 
	height: 100%; 
	width: 100%; 
	display: none;
	position: fixed;
	z-index: 99;
	background: rgba(0,0,0, 0.3);
	transition: all 0.5s;
}

.comment {
	margin: auto;
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
	height: 400px; 
	width: 400px;
	z-index: 100;
	border-radius:10px;
	background: #eee;
	box-shadow:9px 7px 40px -6px rgba(0, 0, 0, 0.25);
	-webkit-transition: box-shadow 0.3s;
	transition: all 0.5s;
}

.comment div{
	height:55px;
}

.comment-title {
	width:100%;  
	margin-bottom:15px;
	border-bottom:2px solid rgba(0,137,220,.8);
	padding:15px 5%;
	font-size:22px;
}

.comment-btn {
	width: 100%;
	padding:10px 5%;
	font-size:22px;
}

.comment-btn button{
	float:right; 
	border-radius:8px;
	border:0;padding:5px 30px;
	outline:none;
}

.comment-submit{
	margin-right:3%;
	background:rgba(0,137,220,.6);
}

.comment .col-xs-7 ,.comment .col-xs-5{
	padding:0;
}

.star {
	width: 100%;
	background:#ddd;
	padding:0% 5%;
}

.hover-star5, .hover-star4, .hover-star3, .hover-star2, .hover-star1 {
	font-size:25px;
	line-height:50px;
	color:#999;
	cursor:pointer;
}

.nohover{
	font-size:25px;
	line-height:50px;
	color:#999;
}

.star5{
	color:#eb6643;
}
.star4{
	color:#f18b1b;
}
.star3{
	color:#f3b518;
}
.star2{
	color:#333;
}

#showAlertDiv {
	position: fixed;
    width: 35%;
    height: 50px;
    top: 15%;
    left: 0;
    right: 0;
    margin: auto;
    z-index: 10000;
    text-align: center;
    font-size: 20px;
    line-height: 18px;
}

</style>
<title>订单详情</title>
</head>
<body>
	<div class="checkout-content">
		<div class="checkout-payinfo">
			<div class="payinfopart" style="margin-top:0;">
				<div style="width:100%; height:40px;">
					<c:set var="state" value="${order.state }" />
					<label class="title" style="width:30%;">配送信息</label>
					<label class="checkouthead-text-id" >订单状态：
					<c:choose>
						<c:when test="${state == 1 }">未支付</c:when>
						<c:when test="${state == 2 }">待送达</c:when>
						<c:when test="${state >= 3 }">已完成</c:when>
					</c:choose>
					</label>
					<label class="checkouthead-text-id">订单号：${order.id }</label>
				</div>
				
				
				<div class="addr selected">
					<div class="addr-span">
						<span class="glyphicon glyphicon-map-marker"></span>
					</div>
					<div class="addr-else">
						<label class="addr-name"><span class="glyphicon glyphicon-user">${order.name }</span></label>
						<label class="addr-phone"><span class="glyphicon glyphicon-phone">${order.phone }</span></label>
						<label class="addr-addr">${order.address }</label>
					</div>
				</div>
			</div>
			
			<div class="payinfopart">
				<div class="input-group myinputgroup" style="margin-left:0%;">
					<div class="input-group-addon" >
						<span class="glyphicon glyphicon-time"> 送达时间</span> 
					</div>
					<input type="text" class="form-control input-text" readonly = "readonly" value="${order.sendTime }"></input>
				</div>
				<div class="input-group myinputgroup" style="width:65%">
					<div class="input-group-addon">
						<span class="glyphicon glyphicon-pencil"> 备注</span> 
					</div>
					<input type="text" class="form-control input-text" readonly = "readonly" value="${order.remark }"></input>
				</div>
			</div>
			<div class="payinfopart">
				<label class="title">支付方式</label>
				<c:set var="payMethod" value="${order.payMethod }" />
				<div id="payguide">
					<c:if test="${payMethod == 1 }">
					<div class="paymethod alipay selectalipay">
						<div class="imgpay">
							<img src="pic/ali.png"></img> 
						</div>
						<label class="labelpay">支付宝支付</label>
					</div>
					</c:if>
					<c:if test="${payMethod == 2 }">
					<div class="paymethod wxpay">
						<div class="imgpay" >
							<img src="pic/wx.png"></img> 
						</div>
						<label class="labelpay">微信支付</label>
					</div>
					</c:if>
					<c:if test="${payMethod == 3 }">
					<div class="paymethod wopay">
						<div class="imgpay">
							<img src="pic/wo.png"></img> 
						</div>
						<label class="labelpay">货到付款</label>
					</div>
					</c:if>
				</div>
			</div>
			<div class="payinfopart">
				<div class="againbtn" onclick="orderAgain('${order.id}')">
					再来一单
				</div>
				<!-- if 是 已完成的订单 -->
				<c:if test="${state == 3 }">
				<div id="btn_comment" class="againbtn" onclick="comment(3)" style="margin-right:5%;background:rgba(13,160,230,0.6)">
					评价菜品
				</div></c:if>
				<!-- if 是已评价的订单 -->
				<c:if test="${state == 4 }">
				<div class="againbtn" onclick="comment(4)" style="margin-right:5%;background:rgba(13,160,230,0.6)">
					我的评价
				</div></c:if>
				<!-- if 是 等待送达状态的订单 -->
				<c:if test="${state == 2 }">
				<div class="againbtn" onclick="confirmOrder('${order.id}')" style="margin-right:5%;background:rgba(13,160,230,0.6)">
					确认送达
				</div></c:if>
			
				<div class="comment-background">
					<div class="comment">
						<div class="comment-title">
							评价菜品
						</div>
						
						<!-- for each start -->
						<c:forEach items="${order.orderItems }" var="orderItem">
						<div class="star" id="${orderItem.food.id }">
							<div class="row">
								<div class="col-xs-7">
									<label style="text-align:left">${orderItem.food.name }</label>  
								</div>
								<!-- 评分等级1~5 -->
								<c:if test = "${state == 3 }">
								<input type="hidden" value="-1">
								<div class="col-xs-5" style="padding-left:9px;" id="glyphicon-star-empty">
									<span class="glyphicon glyphicon-star-empty hover-star1"></span>
									<span class="glyphicon glyphicon-star-empty hover-star2"></span>
									<span class="glyphicon glyphicon-star-empty hover-star3"></span>
									<span class="glyphicon glyphicon-star-empty hover-star4"></span>
									<span class="glyphicon glyphicon-star-empty hover-star5"></span>
								</div>
								</c:if>
								<c:if test = "${state == 4 }">
								<input type="hidden" value="${orderItem.rating }">
								<div class="col-xs-5" style="padding-left:9px;" id="glyphicon-star-empty">
									<span class="glyphicon glyphicon-star-empty nohover"></span>
									<span class="glyphicon glyphicon-star-empty nohover"></span>
									<span class="glyphicon glyphicon-star-empty nohover"></span>
									<span class="glyphicon glyphicon-star-empty nohover"></span>
									<span class="glyphicon glyphicon-star-empty nohover"></span>
								</div>
								</c:if>
							</div>
						</div>
						</c:forEach>
						<!-- end -->
						
						<div class="comment-btn">
							<button type="button" class="comment-cancel">取消</button>
							<button type="button" class="comment-submit">确定</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="checkout-cart">
			<div class="checkout-cart-head">
				<label class="checkout-cart-head-text">订单详情 </label>
			</div>
			<div class="checkout-cart-label">
				<div class="row">
					<div class="col-xs-7">
						<label style="text-align:left">商品</label> 
					</div>
					<div class="col-xs-2">
						<label>数量</label> 
					</div>
					<div class="col-xs-3">
						<label>小计</label>
					</div>
				</div>
			</div>
			<!--cartfood for each  -->
			<c:forEach items="${order.orderItems }" var="orderItem">
			<div class="checkout-cart-food" id="${orderItem.id }">
				<div class="row">
					<div class="col-xs-7">
						<label style="text-align:left">${orderItem.food.name }</label>  
					</div>
					<div class="col-xs-2">
						<label class="cfamount">${orderItem.count }</label>
					</div>
					<div class="col-xs-3">
						<label class="labelprice" style="color:#ff3100;">￥${orderItem.subtotal }</label>
					</div>
				</div>
			</div>
			</c:forEach>
			<!--cartfood for each end -->
			<div class="cartbottom">
				<div class="checkout-cart-bottom">
					<label class="labelprice2" style="margin-left: 57.5%;">总计</label> 
					<label
						id="totalamount" class="labelprice2" style="float: right">--件</label> 
					<label
						class="checkout-totalprcie"> ￥<strong>--.--</strong>
					</label>
				</div>
				<div class="top left corner"></div>
				<div class="top right corner"></div>
				<div class="bottom left corner"></div>
				<div class="bottom right corner"></div>
			</div>
			<div class="top left corner"></div>
			<div class="top right corner"></div>
			<div class="bottom left corner"></div>
			<div class="bottom right corner"></div>
		</div>
	</div>
	<div id="showAlertDiv" role="alert"></div>
</body>
<script>
	var showAlertDiv = $("#showAlertDiv");
	
	//显示提示框
	var t1 = 0;
	function showMsg(style, msg) {
		showAlertDiv.attr("class", "alert alert-" + style).text(msg).show();
		t1++;
		var t2 = t1;
		setTimeout(function() {
			if(t2 == t1) { 
				showAlertDiv.fadeOut(100);
			}
		}, 4000);
	};

	$(".comment-submit").click(function(){
		var stars = $(".star");
		var oid = "${order.id}";
		var fid, rating;
		var flag = true;
		var comments = new Array(stars.length);
		for(var i = 0; i<stars.length; i++){
			var comment = {};
			fid = stars.eq(i).attr("id");
			rating = stars.eq(i).find("input").val();
			if(rating == -1){
				showMsg("danger","请评价所有菜品！");
				flag = false;
				break;
			} else {
				comment["oid"] = oid;
				comment["fid"] = fid;
				comment["rating"] = rating;
				comments[i] = comment;
			}
		}
		if(flag) {
			comments = JSON.stringify(comments);
			$.post("order", {method:"evaluateOrder", oid:oid, comments:comments}, function(data){
				if(data == 1) {
					com_bac.hide();
					showMsg("success", "评价成功！");
					$("#btn_comment").text("我的评价").attr("onclick", "comment(4)");
				} else {
					$(".comment-cancel")[0].click();
					showMsg("danger", "评价失败！");
				}
			});
		}
	});

	function orderAgain(oid) {
		location.href = "${basePath}/order?m=orderAgain&oid=" + oid;
	};
	
	function confirmOrder(oid) {
		location.href = "${basePath}/order?m=confirmOrder&oid=" + oid + "&from=detail";
	};
	
	$(function() {
		var b = 120 + $(".corner").width()*0.5;
		b = "bottom:-" + b + "px";
		$(".middle").attr("style", b).show();
		
		newallprice();
		initcomment();
	});
	
	var newallprice = function(){
		var allfoodprice = $(".checkout-cart").find(".labelprice");
		var price = 0;
		for(var i = 0;i<allfoodprice.length;i++){
			price += parseFloat($(allfoodprice.eq(i)).html().replace("￥",""));
		}
		$(".checkout-totalprcie").children().html(price.toFixed(2));
		
		var allfoodamount = $(".checkout-cart").find(".cfamount");
		var totalamount = 0;
		for(var i = 0;i<allfoodamount.length;i++){
			totalamount += parseInt($(allfoodamount.eq(i)).html());
		}
		$("#totalamount").html(totalamount+"件");
	};
	
	var initcomment = function(){
		$(".comment").height(145+55*$(".checkout-cart").find(".labelprice").length);
	};
	
	var com_bac = $(".comment-background");
	var com_bac_sub = com_bac.find(".comment-submit");
	var com_bac_can = com_bac.find(".comment-cancel");
	function comment(str){
		if(str == 4){
			com_bac_sub.hide();
			com_bac_can.text("关闭");
			var stars = $(".star");
			var rating = 0;
			var stqi;
			for(var i = 0; i<stars.length;i++){
				stqi = stars.eq(i);
				rating = stqi.find("input").val();
				
				eq = stqi.find("span").eq(0);
				hoverstar(eq,"star2","glyphicon-trash");
				if(rating == 1){
					clickstar(eq,"glyphicon-trash");
				}else if(rating == 2){
					clickstar(stqi.find("span").eq(1),"glyphicon-thumbs-down");
				}else if(rating == 3){
					clickstar(stqi.find("span").eq(2),"glyphicon-star");
				}else if(rating == 4){
					clickstar(stqi.find("span").eq(3),"glyphicon-heart-empty");
				}else{
					clickstar(stqi.find("span").eq(4),"glyphicon-heart");
				}
				nohoverstar(eq,"star2","glyphicon-trash");
			
			}
		}
		com_bac.show();
	}
	
	var clickstar = function(e,star){
		$(e).parent().attr("id",star);
		$(e).attr("id","clicked");
		$(e).siblings().attr("id","");
	};
	
	var hoverstar = function(e,level1,star){
		var nowstar = $(e).parent().attr("id");
		var starnum = $(e).parent().prev().val();
		if(nowstar != star){
			if(starnum == 5){
				$(e).removeClass("star5").siblings().removeClass("star5");
			}else if(starnum == 4){
				$(e).removeClass("star4").siblings().removeClass("star4");
			}else if(starnum == 3){
				$(e).removeClass("star3").siblings().removeClass("star3");
			}else if(starnum == 2){
				$(e).removeClass("star2").siblings().removeClass("star2");
			}else if(starnum == 1){
				$(e).removeClass("star2").siblings().removeClass("star2");
			}
			
			var level = level1 + " " + star;
			$(e).addClass(level).toggleClass(nowstar);
			$(e).prevAll().addClass(level1);
			$(e).siblings().toggleClass(star).toggleClass(nowstar);
		}
	};
	
	var nohoverstar = function(e,level1,star){
		var nowstar = $(e).parent().attr("id");
		var starnum = $(e).parent().prev().val();
		if(nowstar != star){
			level = level1 + " " + star;
			$(e).removeClass(level).toggleClass(nowstar);
			$(e).siblings("span").removeClass(level).toggleClass(nowstar);
		}
		
		if(starnum == 5){
			$(e).parent().find("#clicked").addClass("star5").prevAll().addClass("star5");
		}else if(starnum == 4){
			$(e).parent().find("#clicked").addClass("star4").prevAll().addClass("star4");
		}else if(starnum == 3){
			$(e).parent().find("#clicked").addClass("star3").prevAll().addClass("star3");
		}else if(starnum == 2){
			$(e).parent().find("#clicked").addClass("star2").prevAll().addClass("star2");
		}else if(starnum == 1){
			$(e).parent().find("#clicked").addClass("star2").prevAll().addClass("star2");
		}
	};
	
	$(".hover-star5").click(function(){
		clickstar(this,"glyphicon-heart");
		$(this).parent().prev().val(5);
	});
	$(".hover-star4").click(function(){
		clickstar(this,"glyphicon-heart-empty");
		$(this).parent().prev().val(4);
	});
	$(".hover-star3").click(function(){
		clickstar(this,"glyphicon-star");
		$(this).parent().prev().val(3);
	});
	$(".hover-star2").click(function(){
		clickstar(this,"glyphicon-thumbs-down");
		$(this).parent().prev().val(2);
	});
	$(".hover-star1").click(function(){
		clickstar(this,"glyphicon-trash");
		$(this).parent().prev().val(1);
	});
	
	$(".hover-star5").hover(
		function(){hoverstar(this,"star5","glyphicon-heart");},
		function(){nohoverstar(this,"star5","glyphicon-heart");}
	);
	$(".hover-star4").hover(
		function(){hoverstar(this,"star4","glyphicon-heart-empty");},
		function(){nohoverstar(this,"star4","glyphicon-heart-empty");}
	);
	$(".hover-star3").hover(
		function(){hoverstar(this,"star3","glyphicon-star");},
		function(){nohoverstar(this,"star3","glyphicon-star");}
	);
	$(".hover-star2").hover(
		function(){hoverstar(this,"star2","glyphicon-thumbs-down");},
		function(){nohoverstar(this,"star2","glyphicon-thumbs-down");}
	);
	$(".hover-star1").hover(
		function(){hoverstar(this,"star2","glyphicon-trash");},
		function(){nohoverstar(this,"star2","glyphicon-trash");}
	);
	
	$(".comment-cancel").click(function(){
		com_bac.hide();
		var stars = $(".star");
		for(var i = 0; i<stars.length; i++){
			stars.eq(i).find("input").val(-1);
		} 
		resetComment();
	});
	
	function resetComment() {
		var stars = com_bac.find(".star");
		
		for (var i = 0; i < stars.length; i++) {
			stars.eq(i).find("#clicked").attr("id", "");
			stars.eq(i).find(".col-xs-5").attr("id", "glyphicon-star-empty");
			var spans = stars.eq(i).find(".col-xs-5").find("span");
			
			for (var j = 0; j < 5; j++) {
				spans.eq(j).attr("class", "glyphicon glyphicon-star-empty hover-star" + (j + 1));
			}
		}
	}
</script>
</html>