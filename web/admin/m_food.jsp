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
	background-color: rgba(0, 0, 0, 0);
	width: 90%;
	height: 80%;
	margin: auto;
    position: absolute;
    left: 10%;
    right: 0;
    top: 20%;
    bottom: 0;
    z-index: -1;
}
.table-title {
	text-align: center;
	height: 60px;
	line-height: 60px !important;
	padding: 0 !important;
	font-size: 20px;
}
td {
	font-size: 18px;
	text-align: center;
	height: 60px;
	padding: 0 !important;
	vertical-align: middle !important;
}
a {
	font-size: 24px;
}
.div-search {
	padding: 0;
}
body {
	margin-top: 2.5%;
}
#showAlertDiv {
	position: fixed;
    width: 35%;
    height: 50px;
    top: 15%;
    left: 38%;
    z-index: 10000;
    text-align: center;
    font-size: 20px;
    line-height: 18px;
}
.file-input {
	 opacity:0;
     filter:alpha(opacity=0);
     height: 95px;
     width: 100px;
     position: absolute;
     top: 0;
     left: 0;
     z-index: 9;
}
table input,
.div-textarea {
	width: 100%; 
	height: 100%; 
	background-color: rgba(0,0,0,0);
	border: 0;
	outline: none;
	text-align: center;
}
select {
	height: auto;
	background-color: rgba(0,0,0,0);
	border: 0;
	outline: none;
	text-align: center;
}
table textarea {
	width: 100%; 
	height: 100%; 
	border: 0; 
	background-color: rgba(0,0,0,0); 
	outline:none;
	padding: 0;
	resize: none;
}
.label-add {
	height: 34px; 
	line-height: 34px;
	float: left;
	width: 75px;
}
::-webkit-scrollbar {
	width: 6px;
    background-color: rgba(0,0,0,0);
}
::-webkit-scrollbar-track {
	background-color: rgba(0,0,0,0);
}
::-webkit-scrollbar-thumb {
	background-color: #333;
}
</style>
<body>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="col-xs-10 col-xs-offset-1">
				<div class="row-fluid">
					<div class="col-xs-1" style="padding: 0;">
						<div class="input-group input-group-lg">
							<span class="input-group-btn"> 
								<input type="button" data-target="#modal-add" data-toggle="modal"
								class="btn btn-primary btn-add" value="添加" style="border-radius: 6px;"/>
							</span>
						</div>
					</div>
					<div id="showAlertDiv" role="alert"></div>
					<div class="col-xs-1 pull-right div-search">
						<div class="input-group input-group-lg">
							<span class="input-group-btn">
								<input type="button" data-target="#modal-search" data-toggle="modal" 
								class="btn btn-info btn-search" value="查找" style="float: right; border-radius: 6px;"/>
							</span>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xs-10 col-xs-offset-1" style="margin-top: 20px;">
				<table id="food-table" class="table table-bordered">
					<thead>
						<tr>
							<th class="table-title" style="width: 8%;">ID</th>
							<th class="table-title" style="width: 10%;">图片</th>
							<th class="table-title" style="width: 18%;">名称</th>
							<th class="table-title" style="width: 12%;">分类</th>
							<th class="table-title" style="width: 25%;">说明</th>
							<th class="table-title" style="width: 8%;">单价</th>
							<th class="table-title" style="width: 8%;">上传</th>
							<th class="table-title" style="width: 8%;">删除</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${foodList }" var="food">
						<form action="${basePath }/updateFood" method="post" enctype="multipart/form-data">
						<input type="hidden" name="id" value="${food.id }"/>
						<tr>
							<td class="content">${food.id }</td>
							<td>
								<div style="position: relative;">
									<input class="file-input" type="file" accept="image/jpg,image/png,image/jpeg,image/bmp,image/webp" name="image" onchange="changepic(this)" 
									style="width: 100%; height: 100%; cursor: pointer; font-size: 0;" title=""/>
									<img id="show" src="http://47.100.204.138:9090/ima/${food.image }" style="height: 150px;"/>
								</div>
							</td>
							<td><input name="name" value="${food.name }"/></td>
							<td>
								<select name="type_id">
								<c:forEach items="${ftList }" var="ft">
									<option <c:if test="${food.ftid eq ft.id }">selected="selected"</c:if> value="${ft.id }">${ft.name}</option>
								</c:forEach>
								</select>
							</td>
							<td><div class="div-textarea" style="height: 150px;"><textarea name="info">${food.info }</textarea></div></td>
							<td><input name="price" value="${food.price }"/></td>
							<td>
								<a target="iframe-body" class="a-mod" style="cursor: pointer;"><span class="glyphicon glyphicon-cloud-upload"></span></a>
								<input type="hidden" onclick="updateFood(this.form)"/>
							</td>
							<td>
								<a class="a-del" style="cursor: pointer;"><span class="glyphicon glyphicon-trash"></span></a>
								<input type="hidden" onclick="deleteFood(this.form, this)"/>
							</td>
						</tr>
						</form>
						</c:forEach>
					</tbody>
				</table>
				
				<div class="modal fade" id="modal-add" tabindex="-1" role="dialog" aria-labelledby="modal-label-add" aria-hidden="true"
				data-backdrop="static" data-keyboard="false">
				    <div class="modal-dialog" style="position: absolute; top: 15%; left: 0; bottom: 0; right: 0;">
				        <div class="modal-content" style="z-index: 1000;">
				            <div class="modal-header">
				                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				                <h4 class="modal-title" id="modal-label-add">添加菜品</h4>
				            </div>
				            <div class="modal-body">
				            	<form id="addFoodForm" method="post" action="${basePath }/addFood" enctype="multipart/form-data">
				            	  <div class="row">
								  <div class="col-xs-4">
								    <label class="label-add" for="name">菜名</label>
								    <input class="form-control" name="name" placeholder="请输入菜名" required style="float: left; width: 100%;"/>
								  </div>
								  <div class="col-xs-4">
								    <label class="label-add" for="price">价格</label>
								    <input type="number" class="form-control" name="price" placeholder="请输入价格" required min="0.00" step="0.01"
								    style="float: left; width: 100%;"/>
								  </div>
								  <div class="col-xs-4">
								    <label class="label-add" for="foodtype">分类</label>
								    <select name="foodtype" required style="width: 100%; height: 34px; line-height: 34px;">
								    	<option value="" selected="selected">请选择分类</option>
										<c:forEach items="${ftList }" var="ft">
											<option value="${ft.id }">${ft.name}</option>
										</c:forEach>
									</select>
								  </div>
								  </div>
								  <div class="row">
									  <div class="col-xs-8">
									  	<label class="label-add" for="info">说明</label>
								    	<textarea rows="7" class="form-control" name="info" placeholder="请输入说明" required></textarea>
									  </div>
									  <div class="col-xs-4">
									  	<div style="position: relative;">
										    <label class="label-add" for="image">图片</label>
											<input class="file-input" type="file" accept="image/jpg,image/png,image/jpeg,image/bmp,image/webp" 
											name="image" onchange="changepic(this)" title="请选择一张图片"
											style="width: 100%; height: 100%; cursor: pointer; font-size: 0;"/>
											<img id="show" src="pic/add.jpg" style="height: 150px;"/>
										</div>
									  </div>
								  </div>
							</div>
				            <div class="modal-footer">
				                <button id="close-add-modal-btn" type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				                <button type="button" class="btn btn-primary" onclick="addSubmitClick(this.form)">确定添加</button>
				            </div>
				            </form>
				        </div>
				    </div>
				</div>
				
				<div class="modal fade" id="modal-search" tabindex="-1" role="dialog" aria-labelledby="modal-label-search" aria-hidden="true"
				data-backdrop="static" data-keyboard="false">
				    <div class="modal-dialog" style="position: absolute; top: 15%; left: 0; bottom: 0; right: 0;">
				        <div class="modal-content" style="z-index: 1000;">
				            <div class="modal-header">
				                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				                <h4 class="modal-title" id="modal-label-search">查找菜品</h4>
				            </div>
				            <div class="modal-body">
				            	<form id="searchFoodForm" method="post" action="${basePath }/foodSearch">
				            	<input type="hidden" name="method" value="search"/>
				            	  <div class="row">
								  	<div class="col-xs-7">
								    	<label class="label-add" for="foodname">菜名</label>
								    	<input class="form-control" name="foodname" placeholder="请输入菜名" style="float: left; width: 70%;"/>
								  	</div>
								  	<div class="col-xs-5">
									    <label class="label-add" for="foodtype">分类</label>
									    <select name="foodtype" style="width: 50%; height: 34px; line-height: 34px;">
									    	<option value="" selected="selected">请选择分类</option>
											<c:forEach items="${ftList }" var="ft">
												<option value="${ft.id }">${ft.name}</option>
											</c:forEach>
										</select>
								  	</div>
								  	<div class="col-xs-12">
									    <label class="label-add" for="price">价格区间</label>
									    <input type="number" class="form-control" name="firstprice" min="0.00" step="0.01"
									    style="float: left; width: 18%;"/>
									    <label style="float: left; width: 20px; text-align: center;">~</label>
									    <input type="number" class="form-control" name="secondprice" min="0.00" step="0.01"
									    style="float: left; width: 18%;"/>
								  	</div>
								  	<div class="col-xs-12">
									  	<label class="label-add" for="price">销量区间</label>
									    <input type="number" class="form-control" name="firstsale" min="0.00" step="0.01"
									    style="float: left; width: 18%;"/>
									    <label style="float: left; width: 20px; text-align: center;">~</label>
									    <input type="number" class="form-control" name="secondsale" min="0.00" step="0.01"
									    style="float: left; width: 18%;"/>
									 </div>
								  </div>
							</div>
				            <div class="modal-footer">
				                <button id="close-search-modal-btn" type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				                <button type="submit" class="btn btn-primary" onclick="SearchSubmitClick(this.form)">搜索</button>
				            </div>
				            </form>
				        </div>
				    </div>
				</div>
				
			</div>
		</div>
	</div>
</body>
<script>
window.onload = function() {
	$(parent.document.getElementById("iframe-top")).show();
};
//鼠标下滚时隐藏导航栏
window.onscroll = function(){
	var scrollTop = document.body.scrollTop || document.documentElement.scrollTop;
	if(scrollTop >= 40){
		$(parent.document.getElementById("iframe-top")).hide();
	}else{
		$(parent.document.getElementById("iframe-top")).show();
	}
};
var iframe_left = $(parent.document.getElementById("iframe-left"));
$(".btn-add").click(function() {
	iframe_left.animate({
		right:"100%"
	},300);
});
$(".btn-search").click(function() {
	iframe_left.animate({
		right:"100%"
	},300);
});
$(".btn-default").click(function() {
	iframe_left.animate({
		right:"0%"
	},300);
});
$(".close").click(function() {
	iframe_left.animate({
		right:"0%"
	},300);
});
function addSubmitClick(form) {
	$("#close-add-modal-btn")[0].click();
	setTimeout(function() {
		form.submit();
	}, 300);
};
function SearchSubmitClick(form) {
	$("#close-search-modal-btn")[0].click();
	setTimeout(function() {
		form.submit();
	}, 300);
};
// 点击上传
$(".a-mod").click(function() {
	$(this).next()[0].click();
});
// 点击删除
$(".a-del").click(function() {
	$(this).next()[0].click();
});
// 更新菜品
function updateFood(form) {
	form.submit();
};
// 删除菜品
function deleteFood(form, btn) {
	if(confirm("确定要删除吗？")) {
		$.get("food?m=delete&id="+form.id.value, function(data){
			data = eval("(" + data + ")");
			if(data == 1){
				var row = $(btn).parent().parent()[0].rowIndex;
				$("#food-table")[0].deleteRow(row);
				showMsg("success", "删除成功");
			} else {
				showMsg("danger", "删除失败");	
			}
		});
	}
};
function change(div) {
	$(div).find("input")[0].onchange();
};
// 预览图片
function changepic(file) {
	var reader = new FileReader();
	reader.readAsDataURL(file.files[0]);
	reader.onload = function(e) {
	    $(file).next().attr("src", this.result);
	};
};
var showAlertDiv = $("#showAlertDiv");
var iframe_left = $(parent.document.getElementById("iframe-left"));
// 查找
function search() {
	var name = $("#search-name").val();
	name = $.trim(name);
	location.href = "food?m=findByName&name=" + name + "&identity=admin";
};
// 显示提示框
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
</script>
<html>