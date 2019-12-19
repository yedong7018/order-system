<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<%@ include file="/tcart.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link href="${basePath }/css/bootstrap.min.css" rel="stylesheet">
<script src="${basePath }/js/jquery-1.9.1.min.js"></script>
<script src="${basePath }/js/bootstrap.min.js"></script>
<link href="${basePath }/css/main_foodinfo.css" rel="stylesheet">
</head>
<body>
	<div class="foodinfo_background">
		<c:forEach items="${foodList }" var="food">
			<div class="foodinfo" id="${food.id }">
				<input type="hidden" id="mffavor" value=""> <input
					type="hidden" id="mfintro" value="${food.info }">
				<div class="row">
					<div class="col-xs-3">
						<img id="mfimg" class="img"
							src="http://47.100.204.138:9090/ima/${food.image }" />
					</div>
					<div class="col-xs-9 foodrightinfo">
						<div class="row">
							<label><strong id="mfname">${food.name }</strong></label>
						</div>
						<div class="row">
							<label id="mfgrade">评分： <span class="starFive"> <span
									class="spanc" style="width: ${food.avgRating / 5.0 * 100 }%;">★★★★★</span> <span>★★★★★</span>
							</span> (<span class="food-rating">${food.avgRating }</span>)
							</label>
						</div>
						<div class="row">
							<label id="mfsold" style="margin-top: -2%; margin-bottom: 3%">销量：${food.sold }</label>
						</div>
						<div class="row">
							<label><strong id="mfprice" style="color: red">￥${food.price }</strong></label>
							<div class="btn_group1" id="${food.id }">
								<input type="button"
									style="border-radius: 15px 0 0 15px; margin-left: 35%;"
									onclick="reducefoodamount(this)" value="-"></input> <input
									id="mfamount" onfocus="focusfoodamount(this)"
									onblur="blurfoodamount(this)" onkeypress="enterNum(this)"
									type="number" value="0"></input> <input type="button"
									style="border-radius: 0 15px 15px 0;"
									onclick="addfoodamount(this)" value="+"></input>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>

		<div class="detailbackground">
			<div class="fooddetail">
				<div class="conter-fluid" id="deid">
					<div class="row">
						<div class="col-xs-6">
							<img id="deimg" src="" />
						</div>
						<div class="col-xs-6">
							<div class="row" style="height: 50px; margin-top: 8%">
								<label><strong id="dename">名称</strong></label>
							</div>
							<div class="row" style="height: 30px; width: 100%;">
								<label id="degrade">评级 <span class="starFive"> <span
										class="spanc" style="width: 94%;">★★★★★</span> <span>★★★★★</span>
								</span> (<span>4.7</span>)
								</label> <span class="glyphicon glyphicon-heart noco_heart favour"></span>
							</div>
							<div class="row" style="height: 30px;">
								<label id="desold">销量</label>
							</div>
							<div class="row" style="height: 150px;">
								<div id="deintro"
									style="word-wrap: break-word; margin: 10px; padding-right: 8%;">详情</div>
							</div>
							<div class="row" style="height: 50px;">
								<label><strong id="deprice" style="color: red;">￥</strong></label>
								<div class="btn_group2" id="000">
									<input type="button" style="border-radius: 15px 0 0 15px;"
										onclick="reducefoodamount(this)" value="-"></input> <input
										id="deamount" onfocus="focusfoodamount(this)"
										onblur="blurfoodamount(this)" onkeypress="enterNum(this)"
										type="number" value="0"></input> <input type="button"
										style="border-radius: 0 15px 15px 0;"
										onclick="addfoodamount(this)" value="+"></input>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div style="display:none">
		<div id="hidecircle" class="dot">
			<div class="dot-after">
			</div>
		</div>
	</div>
</body>
<script>
	//鼠标下滚时隐藏导航栏
	window.onscroll = function() {
		var scrollTop = document.body.scrollTop
				|| document.documentElement.scrollTop;
		if (scrollTop >= 28) {
			$(parent.document.getElementById("iframeN")).hide();
		} else {
			$(parent.document.getElementById("iframeN")).show();
		}
	};
	//页面初始加载以及换页直接执行
	$(function() {
		// 让评分只显示一位小数
		var ratingArr = $(".food-rating");
		for(var i = 0; i < ratingArr.length; i++) {
			var rating = parseFloat(ratingArr.eq(i).text()).toFixed(1);
			ratingArr.eq(i).text(rating);
		}
		
		$(parent.document.getElementById("iframeN")).show();
		$(parent.document.getElementById("iframeK")).show();

		var allfoodinfo;
		var addfoodtocartinfo_jq;
		var de = $("div .fooddetail").children();
		//展示详情
		//从页面接受ID、食品名称，评价，销量，价格、购买数量、收藏信息、文字描述
		$(".foodinfo label,.foodinfo img").click(function(e) {
			if (e.target.nodeName.toLowerCase() == "img") {
				allfoodinfo = $(this).parent().parent();
			} else {
				allfoodinfo = $(this).parent().parent().parent();
			}
			de.attr("id", allfoodinfo.parent().attr("id"));//赋值id
			var fid = de.attr("id");
			$.get("user?m=isCollected&fid=" + fid, function(data) {
				if (data == 1) {
					de.find(".favour").addClass(
							"iloveit");
				} else if (data == 0) {
					de.find(".favour")
							.removeClass(
									"iloveit");
				} else {
					de.find(".favour").hide();
				}
			});
			de.find(".btn_group2").attr("id",
					allfoodinfo.parent().attr("id"));//赋值id
			de.find("#deimg").attr("src",
					allfoodinfo.find("#mfimg").attr("src"));
			de.find("#dename").html(
					allfoodinfo.find("#mfname").html());
			de.find("#degrade").html(
					allfoodinfo.find("#mfgrade").html());
			de.find("#desold").html(
					allfoodinfo.find("#mfsold").html());
			de.find("#deprice").html(
					allfoodinfo.find("#mfprice").html());
			de.find("#deamount").val(
					allfoodinfo.find("#mfamount").val());
			de.find("#deintro")
					.html(
							allfoodinfo.parent().find(
									"#mfintro").val());
			//如果已经加入购物车
			if (allfoodinfo.find("#mfamount").val() != 0) {
				de
						.find("#deamount")
						.attr("style",
								"background-color: rgba(30, 137, 224, 0.7);");
			}
			//显示菜品详情
			$(parent.document.getElementById("iframeN")).hide();
			$(".div_kind", parent.document).hide();
			$(".detailbackground").show();
		});
		//收藏按钮切换
		$(".fooddetail span").click(function() {
			var fid = de.attr("id");
			$(this).toggleClass("iloveit");
			if ($(this).hasClass("iloveit")) {
				//收藏
				$.get("user?m=collect&fid=" + fid);
			} else {
				//取消收藏
				$.get("user?m=discollect&fid=" + fid);
			}
		});
		//关闭详情
		//从详情页面发送收藏信息、购买数量
		var closedetail = function() {
			if (de.find("span").hasClass("iloveit")) { //收藏
				allfoodinfo.parent().find("#mffavor").val("1");
			} else { //取消收藏
				allfoodinfo.parent().find("#mffavor").val("0");
			}
			var scrollTop = document.body.scrollTop
					|| document.documentElement.scrollTop;
			if (scrollTop < 40) {
				$(parent.document.getElementById("iframeN")).show();
			}
			$(".div_kind", parent.document).show();
			$(".detailbackground").hide();
		};
		//阻止冒泡
		$('.fooddetail').click(function(e) {
			e.stopPropagation();
		})

		//关闭详情
		//从详情页面发送收藏信息、购买数量
		$(".glyphicon-remove").click(function() {
			closedetail();
		});
		$(".detailbackground").click(function() {
			closedetail();
		});

		//检查购物车中菜品的数量
		var a = $(".btn_group3 input[type=number]");
		var allmf = $(".foodinfo");
		var cfid = 0;
		var cfnum = 999;
		var styled = "background-color: rgba(30, 137, 224, 0.7); border-radius:20px;color:#fff;";
		for (var i = 0; i < a.length - 1; i++) {
			b = a.eq(i);
			b.attr("style", styled);
			cfid = b.parent().attr("id");
			cfnum = b.val();
			var cf;
			for (var j = 0; j < allmf.length; j++) {
				cf = allmf.eq(j).filter("[id=" + cfid + "]");

				if (cf.length) {
					cf.find("#mfamount").val(cfnum).attr("style", styled);
					break;
				}
			}
		}
	});

	//购物车隐藏时，点击购物车脚部，显示购物车
	var animate_show = function() {
		var height = '-' + $(".shop-cartbasket").height() + 'px';
		$(".shop-cartbasket").animate({
			top : height
		}, 300);
	}

	//购物车显示时，点击购物车脚部，隐藏购物车
	var animate_hide = function() {
		$(".shop-cartbasket").animate({
			top : '0px'
		}, 300);
	}

	var cartamount = $("#show_cartfood .shop-cartfood").length;
	var animate_up = function(newTr) {
		var showflag;
		if ($(".shop-cartbasket").css('top') == '0px') {
			showflag = 1;
		} else {
			showflag = 0;
		}
		if (cartamount > 12) {
			showflag += 10;
		}
		var aheight = '+=0px';
		var atop = '-=0px';
		switch (showflag) {
		case 0: {//未隐藏 	未满载
			aheight = '+=45px';
			atop = '-=45px';
			break;
		}
		case 1: {//隐藏	未满载
			aheight = '+=45px';
			atop = '-' + (parseInt($(".shop-cartbasket").height()) + 45) + 'px';
			break;
		}
		case 10: {//未隐藏	满载
			newTr[0].scrollIntoView();
			break;
		}
		case 11: {//隐藏	满载
			atop = '-585px';
			newTr[0].scrollIntoView();
			break;
		}
		}

		$(".shop-cartbasket").animate({
			height : aheight,
			top : atop
		}, 200);
	}

	var animate_down = function() {
		var showflag;
		if ($(".shop-cartbasket").css('top') == '0px') {
			showflag = 1;
		} else {
			showflag = 0;
		}
		if (cartamount >= 12) {
			showflag += 10;
		}
		var aheight = '+=0px';
		var atop = '-=0px';
		switch (showflag) {
			case 0: {//未隐藏 	未满载
				aheight = '-=45px';
				atop = '+=45px';
				break;
			}
			case 1: {//隐藏	未满载
				aheight = '-=45px';
				break;
			}
		}

		$(".shop-cartbasket").animate({
			height : aheight,
			top : atop
		}, 200);
	}
	
	//添加菜品的小点动画
	function addcircle(mfa_jq){
		var circle = $("#hidecircle").clone();
		var after = circle.find(".dot-after");
		
		if (window.innerWidth){
  	      winW = window.innerWidth;
  	      winH = window.innerHeight;
		}else if ((document.body) && (document.body.clientWidth)){
  			winW = document.body.clientWidth;
  			winH = document.body.clientHeight;
  		}
		circle.attr("style","bottom:"+(winH-mfa_jq.offset().top)+"px;right:0px;").appendTo("body");
		after.attr("style","bottom:0px;right:"+(winW-mfa_jq.offset().left-50)+"px;")
		
		animate_cy(circle);
		animate_cx(after);
		
		setTimeout(function(){
			circle.remove();
		},500)
	}

	var animate_cy = function(a) {
		a.animate({
			bottom : "+=50px"
		}, 150);
		a.animate({
			bottom : "30px",
		}, 350);
	}

	var animate_cx = function(a) {
		a.animate({
			right : "280px"
		}, 500);
	}
	
	//添加条目到购物车
	var addcf = function(foodid, mf_jq, num) {
		var hideTr = $("#hide_cartfood").children();
		var newTr = hideTr.clone();

		var mfrejq = mf_jq.parent().parent().parent();
		//id
		newTr.attr("id", foodid);
		newTr.find(".btn_group3").attr("id", foodid);
		//price
		newTr.find("input")[0].value = parseFloat(mfrejq.find("strong")[1].innerHTML
				.replace("￥", ""));
		//name
		newTr.find("label")[0].innerHTML = mfrejq.find("strong")[0].innerHTML;

		$("#show_cartfood").append(newTr);
		cartamount++;
		setTimeout(function(){
			animate_up(newTr);
		},500);
	}

	var removecf = function(foodid) {
		cartamount--;
		animate_down();

		var cfa = "[class='row btn_group3'][id=" + foodid + "]";//购物车
		$(cfa).parent().remove();
	}

	var changeamount = function(foodid, oldnum, num) {
		var mfa = "[class=btn_group1][id=" + foodid + "]";//主页
		var dfa = "[class=btn_group2][id=" + foodid + "]";//详情
		var mfa_jq = $(mfa).find("#mfamount");
		var dfa_jq = $(dfa).find("#deamount");
		var addfa_jq = -1;
		
		if (mfa_jq.length > 0) {
			mfa_jq.val(num);
			addfa_jq = mfa_jq;
		}
		if (dfa_jq.length > 0) {
			dfa_jq.val(num);
			addfa_jq = dfa_jq;
		}

		
		if (oldnum == 0 && num > 0) {
			if(addfa_jq != -1){
				addcircle(addfa_jq);
			}
			addcf(foodid, mfa_jq, num);
			mfa_jq.attr("style","background-color: rgba(30, 137, 224, 0.7); border-radius:20px;color:#fff;");

			// 传到后台
			$.post("cart", {
				method : "addItem",
				foodId : foodid,
				count : num
			}, function(data) {
				parseData(data);
			});
		} else if (oldnum > 0 && num == 0) {
			removecf(foodid);
			mfa_jq.attr("style", "");

			// 传到后台
			$.post("cart", {
				method : "deleteItem",
				foodId : foodid
			}, function(data) {
				parseData(data);
			});
		} else if (oldnum == 0 && num == 0) {
			cartamount = 0;
			var cfa = "[class='row btn_group3'][id=" + foodid + "]";//购物车
			$(cfa).parent().remove();
			mfa_jq.attr("style", "");

			// 传到后台
			$.post("cart", {
				method : "clear"
			}, function(data) {
				parseData(data);
			});
		} else {
			if(oldnum < num){
				if(addfa_jq != -1){
					addcircle(addfa_jq);
				}
			}
			
			$.post("cart", {
				method : "updateItem",
				foodId : foodid,
				count : num
			}, function(data) {
				parseData(data);
			});
		}
		
		if(oldnum < num && addfa_jq != -1){
			setTimeout(function(){
				var cfa = "[class='row btn_group3'][id=" + foodid + "]";//购物车
				var cfa_jq = $(cfa).find("#cfamount");
				cfa_jq.val(num);
				newprice(cfa_jq);
			},500);
		}else{
			var cfa = "[class='row btn_group3'][id=" + foodid + "]";//购物车
			var cfa_jq = $(cfa).find("#cfamount");
			cfa_jq.val(num);
			newprice(cfa_jq);
		}
	}

	function parseData(data) {
		if (data == -1) {
			top.location.href = "${basePath}/login.jsp";
		}
	};

	var oldnum2;
	function focusfoodamount(e) {
		oldnum2 = $(e).val();
	}

	function blurfoodamount(e) {
		num = parseInt($(e).val());
		if (num == "" || isNaN(num)) {
			num = 0;
		}
		e.value = num;
		if (num >= 0) {
			if (oldnum2 != num) {
				var foodid = $(e).parent().attr("id");
				changeamount(foodid, oldnum2, num);
			}
		}
	}

	function addfoodamount(e) {
		var oldnum = $(e).prev().val();
		var foodid = $(e).parent().attr("id");
		var num = parseInt(oldnum) + 1;
		changeamount(foodid, oldnum, num);
	}

	function reducefoodamount(e) {
		var oldnum = $(e).next().val();
		if (oldnum != 0) {
			var foodid = $(e).parent().attr("id");
			num = parseInt(oldnum) - 1;
			changeamount(foodid, oldnum, num);
		}
	}

	//点击购物车脚部事件
	$(".shop-cartfooter").click(function() {
		if ($(".shop-cartbasket").css('top') == '0px') {//如果购物车隐藏
			animate_show();
		} else {
			animate_hide();
		}
	});

	function enterNum(e) {
		var code = (navigator.appname == "Netscape") ? event.which
				: window.event.keyCode;
		if (code == 13) {
			$(e).blur();
		} else if (code<48 || code>57) {
			event.returnValue = false;
		}
	};
</script>
</html>