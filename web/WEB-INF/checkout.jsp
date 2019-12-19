<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link href="${basePath }/css/bootstrap.min.css" rel="stylesheet">
<script src="${basePath }/js/jquery-1.9.1.min.js"></script>
<script src="${basePath }/js/bootstrap.min.js"></script>
<link href="${basePath }/css/checkout.css?aaaa=aaaa" rel="stylesheet">
<title>订单结算</title>
</head>
<body>
	<div class="checkout-content">
		<div class="checkout-payinfo">
			<div class="payinfopart" style="margin-top:0;">
				<div class="editaddr-background">
					<div class="editaddr">
						<div class="editaddr-title">
							编辑地址
						</div>
						
						<input type="hidden" name="addressId" value="">
						<div style="width: 50%;">
							<div class="input-group" style="margin:10px 0 0 0;">
								<div class="input-group-addon">
									<span class="glyphicon glyphicon-user">&emsp;联系人&emsp;</span> 
								</div>
								<input type="text" class="form-control input-text" placeholder="请输入收货人姓名" value="硕大的"></input>
							</div>
						</div>
						<div style="width: 50%;">
							<div class="input-group" style="margin:10px 0 0 0;">
								<div class="input-group-addon">
									<span class="glyphicon glyphicon-phone">&emsp;联系电话</span> 
								</div>
								<input type="number" class="form-control input-text" placeholder="请输入收货人手机号" value=""></input>
							</div>
						</div>
						<div style="width: 97%;">
							<div class="input-group" style="margin:10px 0 0 0;">
								<div class="input-group-addon">
									<span class="glyphicon glyphicon-map-marker">&emsp;配送地址</span> 
								</div>
								<input type="text" class="form-control input-text" placeholder="请输入具体地址" value=""></input>
							</div>
						</div>
							
						<div class="editaddr-btn">
							<button class="editaddr-cancel">取消</button>
							<button class="editaddr-submit" onclick="AddOrUpdateAddr()">确定</button>
						</div>
					</div>
				</div>
				
				<label class="title">配送信息</label>
				<label class="addr-top add-addr" onclick="editaddr(this)" style="display:block;">添加地址</label>
				<label class="addr-top choose-addr" >请选择地址</label>
				
				<c:forEach items="${sessionScope.user.addrList }" var="address" varStatus="vs">
				<div class="addr" id="${address.id }" onmouseenter="addrhover(this)" onmouseleave="addrnohover(this)">
					<div class="addr-span">
						<span class="glyphicon glyphicon-map-marker"></span>
					</div>
					<div class="addr-else">
						<label class="addr-name"><span class="glyphicon glyphicon-user">${address.name }</span></label>
						<label class="addr-phone"><span class="glyphicon glyphicon-phone">${address.phone }</span></label>
						<label class="addr-addr">${address.addr }</label>
					</div>
					<div class="addr-btn">
						<label class="btnedit" onclick="editaddr(this)"><span class="glyphicon glyphicon-pencil">修改</span></label>
						<label class="btnchange" onclick="changeaddr(this)"><span class="glyphicon glyphicon-refresh">切换</span></label>
					</div>
				</div>
				</c:forEach>
			</div>
			<div class="payinfopart">
				<div class="input-group myinputgroup" style="margin-left:0%">
					<div class="input-group-addon" >
						<span class="glyphicon glyphicon-time"></span> 
					</div>
					<select id="arrivetime" class="form-control input-text" name="sendTime">
					</select>
				</div>
				<div class="input-group myinputgroup" style="width:65%">
					<div class="input-group-addon">
						<span class="glyphicon glyphicon-pencil"></span> 
					</div>
					<input type="text" class="form-control input-text" placeholder="可填写备注" value="" style="border:1px dashed #ccc;" name="remark"></input>
				</div>
			</div>
			<div class="payinfopart">
				<label class="title">支付方式</label>
				<input type="hidden" value="1" name="payMethod"></input>
				<div id="payguide">
					<div class="paymethod alipay selectalipay" style="margin-left:0;" onclick="paybyit(this)">
						<div class="imgpay">
							<img src="${basePath }/pic/ali.png"></img> 
						</div>
						<label class="labelpay">支付宝支付</label>
					</div>
					<div class="paymethod wxpay" onclick="paybyit(this)">
						<div class="imgpay" >
							<img src="${basePath }/pic/wx.png"></img> 
						</div>
						<label class="labelpay">微信支付</label>
					</div>	
					<div class="paymethod wopay" onclick="paybyit(this)">
						<div class="imgpay">
							<img src="${basePath }/pic/wo.png"></img> 
						</div>
						<label class="labelpay">货到付款</label>
					</div>
				</div>
			</div>
			<div class="payinfopart">
				<div class="paybtn alipaybtn" onclick="confirmOrder()">
					确认下单
				</div>
			</div>
			<div class="payinfopart"></div>
		</div>
		<div class="checkout-cart">
			<div class="checkout-cart-head">
				<label class="checkout-cart-head-text">订单详情 </label>
			</div>
			<div class="checkout-cart-label">
				<label style="margin-left: 10%;">商品</label>
				<label style="margin-left: 40%;">数量</label>
				<label style="margin-left: 17%;">小计</label>
			</div>
			
			<!--cartfood for each  -->
			<c:forEach items="${sessionScope.cart.cartItems }" var="item">
			<div class="checkout-cart-food" id="${item.food.id}">
				<label class="labelname">${item.food.name}</label>
				<input type="hidden" value="${item.food.price}"></input>
				<div class="btn_group3" id="${item.food.id}">
					<input type="button" onclick="reducefoodamount(this)"
						style="border-radius: 15px 0 0 15px;" value="-"></input> 
					<input
						class="cfamount" type="number" onblur="blurfoodamount(this)"
						onfocus="focusfoodamount(this)" onkeyup="pressEnter(this)"
						onkeypress="if(event.keyCode<48 || event.keyCode>57) event.returnValue=false"
						value="${item.count }"></input> 
					<input type="button"
						onclick="addfoodamount(this)"
						style="border-radius: 0 15px 15px 0;" value="+"></input>
				</div>
				<label class="labelprice">￥${item.subtotal }</label>
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
</body>
<script>
	// 确认下单
	function confirmOrder() {
		var $label = $(".selected").find("label");
		var name = $label.eq(0).children().html();
		var phone = $label.eq(1).children().html();
		var addr = $label.eq(2).html();
		var sendTime = $("select[name='sendTime']").val();
		var remark = $("input[name='remark']").val();
		var payMethod = $("input[name='payMethod']").val();
		top.location.href = "order?m=add&name="+name+"&phone="+phone+"&address="+addr+"&sendTime="+sendTime+"&remark="+remark+"&payMethod="+payMethod;
	};
	
	//显示、隐藏地址中的按钮
	function addrhover(e){
		$(e).find(".addr-btn").fadeIn(100);
	}
	
	function addrnohover(e){
		$(e).find(".addr-btn").hide();
	}

	//选择地址
	var btnaddaddr = $(".addr-top.add-addr");
	var btnedit = $(".btnedit");
	var btnchange = $(".btnchange");
	var chooseaddr = $(".addr-top.choose-addr");
	
	function changeaddr(e) {
		e2 = $(e).parent().parent();
		setTimeout(function(){
			e2.addClass("selected selected_div").attr("onclick","selecting(this)");
		},50);
		e2.siblings("div").addClass("selected selected_div").attr("onclick","selecting(this)");
		btnchange.hide();
		btnaddaddr.hide();
		chooseaddr.fadeIn();
	}
	function selecting(e) {
		if($(e).hasClass("addr")){
			e2 = $(e);
		}else{
			e2 = $(e).parent().parent();
		}
		e2.attr("onclick","").removeClass("selected_div");
		e2.siblings("div").removeClass("selected selected_div").attr("onclick","");
		btnchange.show();
		chooseaddr.hide();
		btnaddaddr.fadeIn();	
	}
	//修改地址
	var $editinput = $(".editaddr").find("input");
	var $eid = $editinput.eq(0);
	var $ename = $editinput.eq(1);
	var $ephone = $editinput.eq(2);
	var $eaddr = $editinput.eq(3);
	
	function editaddr(e){
		if($(e).hasClass("btnedit")){
			$e = $(e).parent().parent();
			var $label = $e.find("label");
			var id = $e.attr("id");
			var name = $label.eq(0).children().html();
			var phone = $label.eq(1).children().html();
			var addr = $label.eq(2).html();
			
			$eid.val(id);
			$ename.val(name);
			$ephone.val(phone);
			$eaddr.val(addr);
		}else{
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
	
	function AddOrUpdateAddr() {
		var id = $eid.val();
		var name = $ename.val();
		var phone = $ephone.val();
		var addr = $eaddr.val();
		$.post("address", {method:"addOrUpdate", id:id, name:name, phone:phone, addr:addr}, function(data){
			// data大于0表示添加地址成功，并且data表示新增地址的ID
			if(data > 0) { // 添加地址成功
				// 克隆一个地址
				var newAddr = $(".addr").eq(0).clone();
				// 给新克隆的地址赋值
				var $label = newAddr.find("label");
				newAddr.attr("id", data);
				$label.eq(0).children().html(name);
				$label.eq(1).children().html(phone);
				$label.eq(2).html(addr);
				// 找到之前选择的地址
				var selectedAddr = $(".selected");
				// 隐藏
				selectedAddr.hide().removeClass("selected");
				// 将克隆地址插入到原先选中的地址的位置
				newAddr.appendTo(selectedAddr.parent()).addClass("selected");
				btnaddaddr = $(".addr-top.add-addr");
				btnedit = $(".btnedit");
				btnchange = $(".btnchange");
				chooseaddr = $(".addr-top.choose-addr");
			} else if(data == true) { // 更新成功
				var $label = $(".addr[id=" + id + "]").find("label");
				$label.eq(0).children().html(name);
				$label.eq(1).children().html(phone);
				$label.eq(2).html(addr);
			}
		});
		$(".editaddr-background").hide();
	};
	
	//购物车事件
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
			totalamount += parseFloat($(allfoodamount.eq(i)).val());
		}
		$("#totalamount").html(totalamount+"件");
	}
	
	var newprice = function(e) {
		var changeprice_jq = e.parent().next();
		var price = parseFloat(e.parent().prev().val());
		
		var newchangeprice = price * parseInt(e.val())
		changeprice_jq.html("￥"+newchangeprice);
		newallprice();
	}
	
	function animate_up(){
		$(".cartbottom").animate({
			top:'-=54px'},200);
	}
	
	var cartamount = $(".checkout-cart").find("div [class='checkout-cart-food']").length;
	var removecf = function(foodid){
		cartamount --;
		animate_up();
		
		var cf = "[class='checkout-cart-food'][id="+foodid+"]";//购物车
		$(cf).remove();
	}
	
	var	changeamount = function(foodid,oldnum,num){
		var cf = "[class='checkout-cart-food'][id="+foodid+"]";	//购物车
		var $cf = $(".checkout-cart").find(cf);					//该di购物车jq对象
		var $cfa = $cf.find(".cfamount");						//数量jq对象
		var price = $cf.find("input[type=hidden]").val();		//单价

		$cfa.val(num);//更新数量
		newprice($cfa);//更新价格
		
		if(oldnum > 0 && num == 0){
			removecf(foodid);
			// 删除条目
			$.post("cart", {method : "deleteItem", foodId : foodid});
		} else {
			// 更新条目
			$.post("cart", {method : "updateItem", foodId : foodid, count:num});
		}
	}
	
	var oldnum2;
	function focusfoodamount(e){
		oldnum2 = $(e).val();
	}
	
	function blurfoodamount(e){
		$(e).attr("style","");
		num = parseInt($(e).val());
		if(num == "" || num == NaN){
			num = 0;
		}
		e.value = num;
		if(num>=0 && (oldnum2 != num)){
			var foodid = $(e).parent().attr("id");
			changeamount(foodid,oldnum2,num);
		}
	}
	
	function pressEnter(e){
		var lKeyCode = (navigator.appname=="Netscape")?event.which:window.event.keyCode; 
		if(lKeyCode == 13){
			$(e).blur();
		}
	}
	
	function addfoodamount(e){
		var oldnum = $(e).prev().val();
		var foodid = $(e).parent().attr("id");
		var num = parseInt(oldnum)+1;
		changeamount(foodid,oldnum,num);
	}
	
	function reducefoodamount(e){
		var oldnum = $(e).next().val();
		if(oldnum != 0){
			var foodid = $(e).parent().attr("id");
			var num = parseInt(oldnum)-1;
			changeamount(foodid,oldnum,num);
		}
	}
	
	$(function() {
		var b = 120 + $(".corner").width()*0.5;
		b = "bottom:-" + b + "px";
		$(".middle").attr("style", b).show();

		newallprice();
		creatoption();
		$(".addr").eq(0).addClass("selected");
	});
	
	//选择送达时间
	var arrivetime = $("#arrivetime");
	var options = $("#arrivetime").children();
	function creatoption(){
		var date = new Date();
		hours = date.getHours();
		min = date.getMinutes();
		
		var hourS = "0";
		var minS = "0";
		
		var h = 0;
		if(min < 14 || min == 59){
			h = 1;
			m2 = 45;
		}else if(min < 29){
			m2 = 60;
		}else if(min < 44){
			m2 = 15;
		}else {
			m2 = 30;
		}

		
		if(min <= 29){
			min += 30;
			hourS = hours;
			minS = min;
		}else{
			min -= 30;
			hours ++;

			if(min == 0){
				minS = "00";
			}else if(min < 10){
				minS = "0" + min;
			}else{
				minS = min;
			}
		}
		if(hours == 24){
			hourS = "00";
		}else if(hours < 10){
			hourS = "0"+ hours;
		}else{
			hourS = hours;
		}
		
		c0 = "<option selected='selected' value='尽快送达'>尽快送达</option>";
		c1 = "<option>"+ hourS+":"+minS+"</option>";
		
		$(c0).appendTo(arrivetime);
		$(c1).appendTo(arrivetime);
		
		for(var i = 2; i<17; i++){
			//生成时间
			if(m2 == 60){
				hours ++;
				//超过24无法选择
				if(hours >= 24){
					break;
				}
				m2 = 0;
				minS = "00";
			}else{
				minS = m2;
			}
			
			//优化时间格式
			if(hours == 24){
				hourS = "00";
			}else if(hours < 10){
				hourS = "0"+ hours;
			}else{
				hourS = hours;
			}
			var sendTime = hourS+":"+minS;
			//插入时间
			c = "<option value='" + sendTime + "'>"+ sendTime + "</option>";
			$(c).appendTo(arrivetime);
			
			m2 += 15;
		}
	}
	
	
	//选择支付
	var payguide = $("#payguide");
	var hiddenpay = payguide.prev();
	var wxpay = payguide.find(".wxpay");
	var alipay = payguide.find(".alipay");
	var wopay = payguide.find(".wopay");
	var paybtn = $(".paybtn");
	function paybyit(e){
		var oldpaymethod = hiddenpay.val();

		if (oldpaymethod == 2){
			wxpay.removeClass("selectwxpay");
			paybtn.removeClass("wxpaybtn");
		}else if(oldpaymethod == 1){
			alipay.removeClass("selectalipay");
			paybtn.removeClass("alipaybtn");
		}else{
			wopay.removeClass("selectwopay");
			paybtn.removeClass("wopaybtn");
		}
		
		if($(e).hasClass("wxpay")){
			paymethod = 2;
			$(e).addClass("selectwxpay");
			paybtn.addClass("wxpaybtn");
		}else if($(e).hasClass("alipay")){
			paymethod = 1;
			$(e).addClass("selectalipay");
			paybtn.addClass("alipaybtn");
		}else{
			paymethod = 3;
			$(e).addClass("selectwopay");
			paybtn.addClass("wopaybtn");
		}
		
		hiddenpay.val(paymethod);
	};
	
</script>
</html>