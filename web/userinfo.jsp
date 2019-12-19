<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>用户信息</title>
<link href="${basePath }/css/bootstrap.min.css" rel="stylesheet">
<script src="${basePath }/js/jquery-1.9.1.min.js"></script>
<script src="${basePath }/js/bootstrap.min.js"></script>
<link href="${basePath }/css/t2.css" rel="stylesheet">
<script src="${basePath }/js/jquery.leoTextAnimate.js"></script>
<script src="${basePath }/js/jquery.validate.min.js"></script>
<script src="${basePath }/js/common.js?time=616"></script>
<style>
body {
	background: linear-gradient(45deg, rgba(240, 240, 240, 0.3),
		rgba(200, 200, 200, 0.2));
}
#showAlertDiv {
	position: absolute;
	width: 50%;
	height: 50px;
	top: 10%;
	left: 30%;
	z-index: 100;
	text-align: center;
	font-size: 20px;
	line-height: 18px;
}
</style>
</head>
<body>
	<div id="showAlertDiv" role="alert"></div>
	<div class="div_background">
		<div class="userinfo-content">
			<div class="div_menu">
				<ul class="nav">
					<li id='<c:if test="${empty a }">selected</c:if>'
						style="margin-top: 120px">资料编辑</li>
					<li id="${a }"
						onclick="location.href='${basePath }/address?m=findAll'">地址管理</li>
					<li>统计信息</li>
					<li>修改密码</li>
				</ul>
			</div>

			<div class="content">
				<div class="list">
					<form class="div_input" method="post" id="updateInfoForm"
						action="${basePath }/user">
						<input type="hidden" name="method" value="update_info" />
						<div class="divinput">
							<label>用户名称</label> <input type="text" name="username"
								placeholder="请输入用户名" value="${sessionScope.user.username }">
						</div>
						<div class="divinput">
							<label>手机号码</label> <input type="text" name="phone"
								placeholder="请输入手机号" value="${sessionScope.user.phone }">
						</div>
						<div class="divinput">
							<label>邮箱地址</label> <input type="text" name="email"
								placeholder="请输入邮箱地址" value="${sessionScope.user.email }">
							<label for="email" class="${error }">${msg }</label>
						</div>
						<div class="divinput">
							<button type="submit">确认修改</button>
						</div>
					</form>
				</div>

				<div class="list">
					<div class="div_input" style="bottom:auto;width:100%;">
						<div class="editaddr-background">
							<div class="editaddr">
								<div class="editaddr-title">
									编辑地址
								</div>
								<form action="${basePath }/address" method="post">
								<input type="hidden" name="method" value="addOrUpdate">
								<input type="hidden" name="id" value="0">
								<div style="width: 97%; padding-right:47%;">
									<div class="input-group" style="margin:10px 0 0 0;">
										<div class="input-group-addon">
											<span class="glyphicon glyphicon-user">&emsp;联系人&emsp;</span> 
										</div>
										<input type="text" class="form-control input-text" placeholder="请输入收货人姓名" name="name"></input>
									</div>
								</div>
								<div style="width: 97%; padding-right:47%;">
									<div class="input-group" style="margin:10px 0 0 0;">
										<div class="input-group-addon">
											<span class="glyphicon glyphicon-phone">&emsp;联系电话</span> 
										</div>
										<input type="number" class="form-control input-text" placeholder="请输入收货人手机号" name="phone"></input>
									</div>
								</div>
								<div style="width: 97%;">
									<div class="input-group" style="margin:10px 0 0 0;">
										<div class="input-group-addon">
											<span class="glyphicon glyphicon-map-marker">&emsp;配送地址</span> 
										</div>
										<input type="text" class="form-control input-text" placeholder="请输入具体地址" name="addr"></input>
									</div>
								</div>
									
								<div class="editaddr-btn">
									<button type="button" class="editaddr-cancel">取消</button>
									<button type="submit" class="editaddr-submit">确定</button>
								</div>
								<input type="hidden" name="from" value="userinfo">
								</form>
							</div>
						</div>			
						<div id="show" style="margin-top:20px;">
							<c:forEach items="${sessionScope.user.addrList }" var="address">
							<div class="addr" id="${address.id }">
								<div class="addr-else">
									<label class="addr-name">
										<span class="glyphicon glyphicon-user">${address.name }</span>
									</label>
									<label class="addr-addr">
										<span class="glyphicon glyphicon-map-marker">${address.addr }</span>
									</label>
									<label class="addr-phone">
										<span class="glyphicon glyphicon-phone">${address.phone }</span>
									</label>
								</div>
								<div class="addr-btn">
									<label class="btnremove" onclick="delAddr(this)"><span class="glyphicon glyphicon-remove">删除</span></label>
									<label class="btnedit" onclick="editaddr(this)"><span class="glyphicon glyphicon-pencil">修改</span></label> 
								</div>
							</div>
							</c:forEach>
							
							
							<div class="addr add-addr" onclick="editaddr(this)" id="0">
								<span class="glyphicon glyphicon-plus"> 新增地址</span>
							</div>
						</div>	
					</div>
				</div>

				<div class="list">
					<div class="div_input">
						<div class="totalinfo">
							<label class="l2">下单次数</label>
							<div class="number">233</div>
						</div>
						<div class="totalinfo">
							<label class="l2">下单金额</label>
							<div class="number">233.33</div>
						</div>
						<div class="totalinfo">
							<label class="l2">最爱菜品</label>
						</div>
					</div>
				</div>

				<div class="list">
					<form class="div_input" method="post" id="updatePwdForm"
						action="${basePath }/user">
						<input type="hidden" name="method" value="update_pwd" />
						<div class="divinput">
							<label>原密码</label> <input type="password" name="old_pwd"
								id="oldpw" placeholder="请输入原密码">
						</div>
						<div class="divinput">
							<label>新密码</label> <input type="password" name="new_pwd"
								id="newpw" placeholder="请输入新密码">
						</div>
						<div class="divinput">
							<label>确认密码</label> <input type="password" name="confirm_pwd"
								placeholder="请再次输入密码">
						</div>
						<div class="divinput">
							<button type="submit" name="btn_udpw">确认修改</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	//修改地址
	var $editinput = $(".editaddr").find("input");
	var $eid = $editinput.eq(1);
	var $ename = $editinput.eq(2);
	var $ephone = $editinput.eq(3);
	var $eaddr = $editinput.eq(4);
	
	function editaddr(e){
		if($(e).hasClass("btnedit")) {
			$e = $(e).parent().parent();
			var $label = $e.find("label");
			var id = $e.attr("id");
			var name = $label.eq(0).children().text();
			var addr = $label.eq(1).children().text();
			var phone = $label.eq(2).children().text();
			
			$eid.val(id);
			$ename.val(name);
			$ephone.val(phone);
			$eaddr.val(addr);
		} else{
			$eid.val(0);
			$ename.val("");
			$ephone.val("");
			$eaddr.val("");
		}
		$(".editaddr-background").show();
	}
	
	$(".editaddr-cancel").click(function(){
		$(".editaddr-background").hide();
	});

	function delAddr(btn_del) {
		var id = $(btn_del).parent().parent().attr("id");
		if (confirm("确认删除吗？")) { // 弹出确认框
			$.post("address", {
				method : "delete",
				id : id
			}, function(data) {
				if (data == 1) {
					$(btn_del).parent().parent().remove();
					showMsg("success", "删除成功");
				} else {
					showMsg("danger", "删除失败");
				}
			});
		}
	};

	$(function() {
		var a = "${a}";
		if (a == "selected") {
			$("li:eq(7)").attr('id', 'selected').siblings('li').attr('id', '');
			$(".list:eq(1)").show();
			$(".list:eq(1)").siblings('.list').hide();
		} else {
			$(".list:eq(0)").show();
			$(".list:eq(0)").siblings('.list').hide();
		}
	});

	$(function() {
		// 切换
		$(".nav li").click(function() {
			var divShow = $(".content").children('.list');
			if ($(this).attr('id') != "selected") {
				if ($(this).text() == "统计信息") {
					$('.number:first').leoTextAnimate({
						delay : 200,
						autorun : true,
						fixed : [ ',', ':', '.' ],
						start : '0'
					});
					$('.number:last').leoTextAnimate({
						delay : 700,
						autorun : true,
						fixed : [ ',', ':', '.' ],
						start : '0'
					});
				}
				if ($(this).text() != "地址管理") {
					var index = $(this).index();
					$(this).attr('id', 'selected').siblings('li').attr(
							'id', '');
					$(divShow[index]).show();
					$(divShow[index]).siblings('.list').hide();
				}
			}
		});
	});
	
	//显示、隐藏地址中的按钮
	$(".addr").hover(
		function(){
			$(this).find(".addr-btn").fadeIn();
		},
		function(){
			$(this).find(".addr-btn").hide();
		});

	var t1 = 0;
	var showAlertDiv = $("#showAlertDiv");
	function showMsg(style, msg) {
		showAlertDiv.attr("class", "alert alert-" + style).text(msg).show();
		t1++;
		var t2 = t1;
		setTimeout(function() {
			if (t2 == t1) {
				showAlertDiv.hide();
			}
		}, 4000);
	};
</script>
</html>