$(function() {
	$("#adminLoginForm").validate({
		rules : {
			admName : {
				required : true,
				minlength : 3,
				maxlength : 32,
			},
			admPassword : {
				required : true,
				minlength : 3,
				maxlength : 32,
			},
		},
		messages : {
			admName : {
				required : "必须填写账号",
				minlength : "密码至少为3个字符",
				maxlength : "密码至多为32个字符",
			},
			admPassword : {
				required : "必须填写密码",
				minlength : "密码至少为3个字符",
				maxlength : "密码至多为32个字符",
			},
		},
	});
	
	$("#updatePwdForm").validate({
		rules : {
			old_pwd : {
				required : true,
				minlength : 3,
				maxlength : 32,
			},
			new_pwd : {
				required : true,
				minlength : 3,
				maxlength : 32,
				not_eq_old_pwd : true,
			},
			confirm_pwd : {
				required : true,
				minlength : 3,
				equalTo : "#newpw",
			},
		},
		messages : {
			old_pwd : {
				required : "必须填写原密码",
				minlength : "密码至少为3个字符",
				maxlength : "密码至多为32个字符",
			},
			new_pwd : {
				required : "必须填写新密码",
				minlength : "密码至少为3个字符",
				maxlength : "密码至多为32个字符",
			},
			confirm_pwd : {
				required : "请再次输入密码",
				minlength : "确认密码不能少于3个字符",
				equalTo : "两次输入密码不一致",
			},
		},
		submitHandler : function(form) {
			$.ajax({
				url : "user",
				type : "post",
				dataType : "json",
				data : {
					method : "update_pwd",
					old_pwd : $("input[name='old_pwd']").val(),
					new_pwd : $("input[name='new_pwd']").val(),
				},
				success : function(data) {
					if(data) {
						showMsg("success", "修改密码成功");
					} else {
						showMsg("danger", "原密码错误");
					}
					$("input[name='old_pwd']").val('');
					$("input[name='new_pwd']").val('');
					$("input[name='confirm_pwd']").val('');
				},
			});
		},
	});

	$("#updateInfoForm").validate({
		rules : {
			username : {
				required : true,
				minlength : 3,
				maxlength : 32,
				remote : {
					url : "user",
					type : "post",
					dataType : "json",
					data : {
						method : "checkNotUsed",
						from : "userinfo",
						type : "username",
						info : function() {
							return $("input[name='username']").val();
						},
					},
					dataFilter : function(data, type) {
						return data;
					},
				},
			},
			phone : {
				required : true,
				phone : true,
				remote : {
					url : "user",
					type : "post",
					dataType : "json",
					data : {
						method : "checkNotUsed",
						from : "userinfo",
						type : "phone",
						info : function() {
							return $("input[name='phone']").val();
						},
					},
					dataFilter : function(data, type) {
						return data;
					},
				},
			},
			email : {
				required : true,
				email : true,
				remote : {
					url : "user",
					type : "post",
					dataType : "json",
					data : {
						method : "checkNotUsed",
						from : "userinfo",
						type : "email",
						info : function() {
							return $("input[name='email']").val();
						},
					},
					dataFilter : function(data, type) {
						return data;
					},
				},
			},
		},
		messages : {
			username : {
				required : "必须填写用户名",
				minlength : "用户名至少为3个字符",
				maxlength : "用户名至多为32个字符",
				remote : "用户名已被注册",
			},
			phone : {
				required : "必须填写手机号码",
				phone : "请输入正确的手机号码",
				remote : "手机号码已被注册",
			},
			email : {
				required : "必须填写邮箱地址",
				email : "请输入正确的邮箱地址",
				remote : "邮箱地址已被注册",
			},
		},
	});

	$("#resetPwdForm").validate({
		rules : {
			password : {
				required : true,
				minlength : 3,
				maxlength : 32,
			},
			confirm_password : {
				required : true,
				minlength : 3,
				equalTo : "#password"
			},
		},
		messages : {
			password : {
				required : "必须填写密码",
				minlength : "密码至少为3个字符",
				maxlength : "密码至多为32个字符",
			},
			confirm_password : {
				required : "请再次输入密码",
				minlength : "确认密码不能少于3个字符",
				equalTo : "两次输入密码不一致",
			},
		},
	});

	$("#findPwdForm").validate({
		rules : {
			info : {
				required : true,
				checkUsername : true,
				checkEmail : true,
				checkPhone : true,
			},
		},
		messages : {
			info : {
				required : "必须填写",
			},
		},
	});

	$("#loginForm").validate({
		rules : {
			username : {
				required : true,
				minlength : 3,
				maxlength : 32,
			},
			password : {
				required : true,
				minlength : 3,
				maxlength : 32,
			},
		},
		messages : {
			username : {
				required : "必须填写用户名",
				minlength : "用户名至少为3个字符",
				maxlength : "用户名至多为32个字符",
			},
			password : {
				required : "必须填写密码",
				minlength : "密码至少为3个字符",
				maxlength : "密码至多为32个字符",
			},
		},
	});
	
	$("#registForm").validate({
		rules : {
			username : {
				required : true,
				minlength : 3,
				maxlength : 32,
				remote : {
					url : "user",
					type : "post",
					dataType : "json",
					data : {
						method : "checkNotUsed",
						type : "username",
						info : function() {
							return $("input[name='username']").val();
						},
					},
					dataFilter : function(data, type) {
						return data;
					},
				},
			},
			password : {
				required : true,
				minlength : 3,
				maxlength : 32,
			},
			confirm_password : {
				required : true,
				equalTo : "#password",
			},
			email : {
				required : true,
				email : true,
				remote : {
					url : "user",
					type : "post",
					dataType : "json",
					data : {
						method : "checkNotUsed",
						type : "email",
						info : function() {
							return $("input[name='email']").val();
						},
					},
					dataFilter : function(data, type) {
						return data;
					},
				},
			},
			phone : {
				required : true,
				phone : true,
				digits : true,
				remote : {
					url : "user",
					type : "post",
					dataType : "json",
					data : {
						method : "checkNotUsed",
						type : "phone",
						info : function() {
							return $("input[name='phone']").val();
						},
					},
					dataFilter : function(data, type) {
						return data;
					},
				},
			},
			captcha : {
				required : true,
				captcha : true,
				minlength : 4,
				maxlength : 4,
				remote : {
					url : "user",
					type : "post",
					dataType : "json",
					data : {
						method : "checkCaptcha",
						captcha : function() {
							return $("input[name='captcha']").val();
						},
					},
					dataFilter : function(data, type) {
						return data;
					},
				}
			},
		},
		messages : {
			username : {
				required : "必须填写用户名",
				minlength : "用户名至少为3个字符",
				maxlength : "用户名至多为32个字符",
				remote : "用户名已被注册",
			},
			password : {
				required : "必须填写密码",
				minlength : "密码至少为3个字符",
				maxlength : "密码至多为32个字符",
			},
			confirm_password : {
				required : "请再次输入密码",
				equalTo : "两次输入密码不一致",
			},
			email : {
				required : "请输入邮箱地址",
				email : "请输入正确的email地址",
				remote : "邮箱地址已被注册",
			},
			phone : {
				required : "请输入手机号码",
				digits : "请输入正确的手机号码",
				remote : "手机号码已被注册",
			},
			captcha : {
				required : "请输入验证码",
				minlength : "请输入4位验证码",
				maxlength : "请输入4位验证码",
				remote : "验证码错误",
			},
		},
	});
	
	jQuery.validator.addMethod("phone", function(value, element) 
		{
			var length = value.length;
			var phone = /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/
			return this.optional(element) || (length == 11 && phone.test(value));
		}, "手机号码格式错误");

	jQuery.validator.addMethod("email", function(value, element) 
		{
			var zz = /^([0-9A-Za-z\-_\.]+)@([0-9a-z]+\.[a-z]{2,3}(\.[a-z]{2})?)$/g;
			return this.optional(element) || zz.test(value);
		}, "邮箱地址格式错误");

	jQuery.validator.addMethod("not_eq_old_pwd", function(value, element) 
		{
			var select = $("#oldpw").val();
			if (select == value) {
				return false;
			} else {
				return true;
			}
		}, "请输入与原密码不一样的新密码");

	jQuery.validator.addMethod("checkUsername", function(value, element) 
		{
			var select = $("#type").val();
			if (select == "username") {
				var zz = /^.{3,36}$/;
				return this.optional(element) || zz.test(value);
			} else {
				return true;
			}
		}, "请输入正确的用户名");

	jQuery.validator.addMethod("checkEmail", function(value, element) 
		{
			var select = $("#type").val();
			if (select == "email") {
				var zz = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
				return this.optional(element) || zz.test(value);
			} else {
				return true;
			}
		}, "请输入正确的邮箱地址");

	jQuery.validator.addMethod("checkPhone", function(value, element) 
		{
			var select = $("#type").val();
			if (select == "phone") {
				var zz = /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/;
				return this.optional(element) || zz.test(value);
			} else {
				return true;
			}
		}, "请输入正确的11位手机号码");

	jQuery.validator.addMethod("captcha", function(value, element) 
		{
			var zz = /^[a-z0-9]{4}$/;
			return this.optional(element) || zz.test(value);
		}, "请输入4位有效验证码");
	
	jQuery.validator.addMethod("test", function() 
		{
			var foodname = $("#foodname").val();
			var foodtype =  $("#foodtype").val();
			var firstprice = $("#firstprice").val();
			var secondprice = $("#secondprice").val();
			var firstsale =  $("#firstsale").val();
			var secondsale = $("#secondsale").val();
			
			if (foodname==""&&foodtype=="请选择"
					&&firstprice==""&&secondprice==""
					&&firstsale==""&&secondsale=="") {
				return false;
			} else {
				return true;
			}
		}, "请至少输入一项");
})