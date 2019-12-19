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
	width: 85%;
	height: 75%;
	margin: auto;
    position: absolute;
    left: 15%;
    right: 0;
    top: 25%;
    bottom: 0;
    z-index: -1;
}
.div-search {
	padding: 0;
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
	line-height: 60px !important;
	padding: 0 !important;
}
a {
	font-size: 22px;
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
			<div class="col-xs-8 col-xs-offset-1">
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
					<div class="col-xs-4 pull-right div-search">
						<div class="input-group input-group-lg">
							<input id="search-name" type="text" class="form-control" placeholder="输入要查找的名称" 
							onkeypress="if(event.keyCode==13) search();"/> 
							<span class="input-group-btn">
								<input type="button" class="btn btn-info" value="查找" onclick="search()"/>
							</span>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xs-8 col-xs-offset-1" style="margin-top: 20px;">
				<table id="foodtype-table" class="table table-bordered">
					<thead>
						<tr>
							<th class="table-title" style="width: 20%;">ID</th>
							<th class="table-title" style="width: 40%;">名称</th>
							<th class="table-title" style="width: 20%;">修改</th>
							<th class="table-title" style="width: 20%;">删除</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${ftList }" var="ft">
						<tr id="tr1">
							<td>${ft.id }</td>
							<td>${ft.name }</td>
							<td><a class="a-mod" href="#modal-edit" data-toggle="modal"><span class="glyphicon glyphicon-edit"></span></a></td>
							<td><a class="a-del" style="cursor: pointer;"><span class="glyphicon glyphicon-trash"></span></a></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div class="modal fade" id="modal-edit" tabindex="-1" role="dialog" aria-labelledby="modal-label-edit" aria-hidden="true"
				data-backdrop="static" data-keyboard="false">
				    <div class="modal-dialog" style="position: absolute; top: 30%; left: 0; bottom: 0; right: 0;">
				        <div class="modal-content">
				            <div class="modal-header">
				                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				                <h4 class="modal-title" id="modal-label-edit">修改</h4>
				            </div>
				            <div class="modal-body">
				            	ID：<input type="text" class="form-control" name="edit-id" disabled/>
				            	分类名称：<input type="text" class="form-control" name="edit-name"/>
							</div>
				            <div class="modal-footer">
				                <button id="close-edit-modal-btn" type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				                <button type="button" class="btn btn-primary" onclick="edit_finish()">提交更改</button>
				            </div>
				        </div>
				    </div>
				</div>
				
				<div class="modal fade" id="modal-add" tabindex="-1" role="dialog" aria-labelledby="modal-label-add" aria-hidden="true"
				data-backdrop="static" data-keyboard="false">
				    <div class="modal-dialog" style="position: absolute; top: 30%; left: 0; bottom: 0; right: 0;">
				        <div class="modal-content" style="z-index: 1000;">
				            <div class="modal-header">
				                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				                <h4 class="modal-title" id="modal-label-add">添加</h4>
				            </div>
				            <div class="modal-body">
				            	分类名称：<input name="add-name" type="text" class="form-control" name="add-name"/>
							</div>
				            <div class="modal-footer">
				                <button id="close-add-modal-btn" type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				                <button type="button" class="btn btn-primary" onclick="add_finish()">确定添加</button>
				            </div>
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
// 修改事件
$(".a-mod").click(function() {
	mod($(this));
	iframe_left.hide();
});
// 删除事件
$(".a-del").click(function() {
	del($(this));
});
$(".btn-add").click(function() {
	iframe_left.hide();
});
$(".btn-default").click(function() {
	iframe_left.fadeIn(300);
});
$(".close").click(function() {
	iframe_left.fadeIn(300);
});
var edit_id = $("input[name='edit-id']");
var edit_name = $("input[name='edit-name']");
var old_name;
var showAlertDiv = $("#showAlertDiv");
var add_name = $("input[name='add-name']");
// 点击确定添加
function add_finish() {
	$.get("foodType?m=add&newName=" + add_name.val(), function(data) {
		data = eval("("+data+")");
		if(data > 0) {
			// 表格增加一行
			var tr = $("#tr1").clone();
			tr.find("td").eq(0).text(data);
			tr.find("a").eq(0).click(function() {
				mod($(this));
			});
			tr.find("td").eq(1).text(add_name.val());
			tr.find("a").eq(1).click(function() {
				del($(this));
			});
			$("#foodtype-table").append(tr);
			showMsg("success", "添加成功");	
		} else {
			showMsg("danger", "添加失败");
		}
	});
	$("#close-add-modal-btn").click();
};
// 点击确定修改
function edit_finish() {
	if(edit_name.val() != old_name.text()) {
		$.get("foodType?m=update&foodTypeId="+edit_id.val()+"&newName="+edit_name.val(), function(data) {
			data = eval("("+data+")");
			if(data == 1) {
				old_name.text(edit_name.val());
				showMsg("success", "修改成功");	
			} else {
				showMsg("danger", "修改失败");
			}
		});
		$("#close-edit-modal-btn").click();
	}
};
function mod(j) {
	var tid = j.parent().prev().prev().text();
	old_name = j.parent().prev();
	var tname = old_name.text();
	edit_id.val(tid);
	edit_name.val(tname);
};
function del(j) {
	var tid = j.parent().prev().prev().prev().text();
	if(confirm("确定要删除吗？")) {
		$.get("foodType?m=delete&foodTypeId="+tid, function(data) {
			data = eval("("+data+")"); //转成Json对象
			if(data == 1) {
				var row = j.parent().parent()[0].rowIndex;
				$("#foodtype-table")[0].deleteRow(row);
				showMsg("success", "删除成功");			
			} else {
				showMsg("danger", "删除失败");
			}
		}); 
	}
};
// 点击查找
function search() {
	var name = $("#search-name").val();
	name = $.trim(name);
	location.href = "foodType?m=findByName&name=" + name;
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