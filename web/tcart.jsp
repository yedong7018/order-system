<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<script src="${basePath }/js/jquery-1.9.1.min.js"></script>
<link href="${basePath }/css/cart.css" rel="stylesheet">
</head>
<body>
	<div class="shop-cart">
		<div class="shop-cartbasket" id="scb" style="top: 0px;">
			<div class="shop-grouphead">
				<p class="shop-cartname">购物车</p>
				<button type="button" name="btn_clearmycart" onclick="clearcf(this)" class="btn_clearmycart">清空</button>
			</div>
			<!-- for each 传入foodID 、单价进入隐藏label -->
			<div id="show_cartfood">
			<c:forEach items="${sessionScope.cart.cartItems }" var="c">
			<div class="shop-cartfood" id="${c.food.id }">
					<input type="hidden" value="${c.food.price }">
					<div class="row btn_group3" id="${c.food.id }">
						<label class="labelname">${c.food.name }</label> 
						<input type="button"
							onclick="reducefoodamount(this)"
							style="border-radius: 15px 0 0 15px;" value="-"></input> 
						<input id ="cfamount"
							type="number"	onblur="blurfoodamount(this)"
											onfocus="focusfoodamount(this)"
											onkeypress="enterNum(this)"
							style="background-color: rgba(30, 137, 224, 0.7); border-radius:20px;color:#fff;" value="${c.count }"></input>
						<input type="button" onclick="addfoodamount(this)"
							style="border-radius: 0 15px 15px 0;" value="+"></input> 
						<label
							class="labelprice"> ￥
							<font size=3px>${c.subtotal }</font>
						</label>
					</div>
				</div>
			</c:forEach>
			</div>
			<div id="hide_cartfood" style="display: none;">
				<div class="shop-cartfood" id="foodId">
					<input type="hidden" value="id">
					<div class="row btn_group3" id="foodId">
						<label class="labelname">食品名字</label> 
						<input type="button"
							onclick="reducefoodamount(this)"
							style="border-radius: 15px 0 0 15px;" value="-"></input> 
						<input id ="cfamount"
							type="number"	onblur="blurfoodamount(this)"
											onfocus="focusfoodamount(this)"
											onkeypress="enterNum(this)"
							style="background-color: rgba(30, 137, 224, 0.7); border-radius:20px;color:#fff;" value="1"></input>
						<input type="button" onclick="addfoodamount(this)"
							style="border-radius: 0 15px 15px 0;" value="+"></input> 
						<label
							class="labelprice"> ￥<font size=3px></font>
						</label>
					</div>
				</div>
			</div>
			<div id="show_cartfood_background">
			</div>
		</div>
		<div class="shop-cartfooter" id="scf">
			<img src="pic/cart_canhe.png" />
			<p class="shop-cartfooter-text">
				<font size=5px>￥
					<c:if test="${empty sessionScope.cart }">0.00</c:if>
					<c:if test="${not empty sessionScope.cart }">${sessionScope.cart.total }</c:if>
				</font>
			</p>
		</div>
		<div>
			<button type="button" id="btn_checkout" class="shop-cartfooter-checkout">结算</button>
		</div>
	</div>
</body>
<script>
var show_cartfood = $("#show_cartfood")
$(function(){
	initcart();
});
var initcart = function(){
	var allcartfood = show_cartfood.children(".shop-cartfood");
	var price = 0;
	
	for(var i = 0;i<allcartfood.length;i++){
		price += parseFloat($(allcartfood[i]).find(".labelprice").children().html());
	}
	a = 45 * (allcartfood.length+1);
	var aheight = "+" + a +"px";
	var atop = "-" + a +"px";
	
	$(".shop-cartbasket").animate({
		height:aheight,
		top:atop},300);
	
	$(".shop-cartfooter-text font").html("￥"+price.toFixed(2));
};
var newallprice = function(){
	var allcartfood = $("#show_cartfood").children(".shop-cartfood");
	var price = 0;

	for(var i = 0;i<allcartfood.length;i++){
		price += parseFloat($(allcartfood[i]).find(".labelprice").children().html());
	}
	$(".shop-cartfooter-text font").html("￥"+price.toFixed(2));
}

var newprice = function(e) {
	var changeprice_jq = e.next().next().children();

	var price = parseFloat(e.parent().prev().val());
	var newchangeprice = price * parseInt(e.val())
	changeprice_jq.html(newchangeprice.toFixed(2));
	newallprice();
}

function clearcf(e){
	var cartfood = $(e).parent().next().find(".shop-cartfood")
 	var cartnum = cartfood.length;
	for(var i=0; i<cartnum; i++){
		changeamount(cartfood.eq(i).attr("id"),0,0);
		
	}
	$(".shop-cartbasket").animate({
		height:'45px',
		top:'-45px'},300);
};

$("#btn_checkout").click(function(){
	var total = parseFloat($(".shop-cartfooter-text font").text());
	if(total != 0) {
		$(parent.document.getElementById("iframeK")).hide();
		location.href = "${basePath}/order?m=checkout";
	}
});
</script>
</html>