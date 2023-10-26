<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<title>用户注册</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/style.css">
<script language="javascript" type="text/javascript" src=""></script>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script language="javascript" type="text/javascript"> 
	 
	
</script>
<style type="text/css">
 html,body{
 	height:100%;
 }
 body,td,div
 {
   font-size:14px;
 }
 .middlefull{
	position: relative;
	width:100%;
	height:calc(100% - 213px);
	background-color:blue;
	box-sizing: border-box;
	padding:20px;
	background-image:url('images/loginbg.jpg');
 	background-size:100% 100%;
	overflow:hidden;
 }
 .regTable{
 	position:absolute;
 	width:800px;
 	height:450px;
	box-sizing: border-box;
 	left:calc(50% - 400px);
 	top:calc(50% - 225px);
	padding:10px;
 	background-color:white;
 	border-radius:20px;
 	box-shadow:0 2px 12px 0 rgb(0 0 0 / 10%);
 }
 .regTable .theme{
 	font-size:18px;
 	font-weight:bold;
 }
 .regTable td{
 	height:40px;
 }
 .regTable input{
 	height:30px;
 	border:1px solid #E7EAED;
 }
 .regTable input:focus{
    outline-width: 0px;
 }
 .btnstyle2 {
	COLOR: white;
 	border:1px solid #6A9DE3;
 	border-width:0px;
 	background-color:#6782ef;
 	border-radius:5px;
 	cursor:pointer;
    font-size:14px;
 }
</style>
</head>
<body>
<jsp:include page="top.jsp"><jsp:param name="menu" value="reg" /></jsp:include>
<div id="picnews2"></div>
<div class="middlefull">
	 <div class="regTable">
	 	 <form name="info" id="info" style="width:100%;height:100%" action="LoginRegSystem.action" method="post">
		 <table class="regTable">
			<tr>
				<td class="theme" colspan="4">新用户注册</td>
			</tr>
			<tr>
				<td align="right" width="15%"><span style="color:red">*</span> 用&nbsp;&nbsp;户&nbsp;&nbsp;名：</td>
				<td align="left" width="35%"><input type="text" name="user_name" id="user_name" style="width:200px;" class="inputstyle"/></td>
				<td align="right" width="15%"><span style="color:red">*</span> 密　码：</td>
				<td align="left" width="35%"><input type="password" name="user_pass" id="user_pass" style="width:200px;" class="inputstyle"/></td>
			</tr>
			<tr>
				<td align="right"><span style="color:red">*</span> 确认密码：</td>
				<td align="left"><input type="password" name="user_rpass" id="user_rpass" style="width:200px;" class="inputstyle"/></td>
				<td align="right"><span style="color:red">*</span> 姓　名：</td>
				<td align="left"><input type="text" name="real_name" id="real_name" style="width:200px;" class="inputstyle"/></td>
			</tr>
			<tr>
				<td align="right"><span style="color:red">*</span> 性　　别：</td>
				<td align="left"> 
				    <input type="radio" name="user_sex" checked="checked" value="1" />
					男
					<input type="radio" name="user_sex" value="2" />
					女
				</td>
				<td align="right">邮　箱：</td>
				<td align="left"><input type="text" name="user_mail" id="user_mail" style="width:200px;" class="inputstyle"/></td>
			</tr>
			<tr>
				<td align="right">联系电话：</td>
				<td align="left"><input type="text" name="user_phone" id="user_phone" style="width:200px;" class="inputstyle"/></td>
				<td align="right"><span style="color:red">*</span> 验证码：</td>
				<td align="left"> 
					<input type="text" id="random" name="random" style="width:80px;" class="inputstyle"/>
					&nbsp;<img src="Random.jsp" width="90"  style="cursor:pointer;vertical-align:text-bottom;" title="换一张" id="safecode" border="0" onClick="reloadcode()"/>
				</td>
			</tr>
			<tr>
				<td colspan="4" align="center"> 
					<input type="button" id="addBtn" class="btnstyle2" value=" 提 交 "/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="reset"  class="btnstyle2" value=" 清 空 "/>
				</td>
			</tr>
	 	 </table>
	 	 </form>
	</div>
</div>
<jsp:include page="bottom.jsp"></jsp:include>
<script language="javascript" type="text/javascript">
//实现验证码点击刷新
function reloadcode(){
	var verify=document.getElementById('safecode');
	verify.setAttribute('src','Random.jsp?'+Math.random());
}
$(document).ready(function(){
	var addBtn = $("#addBtn");
	var user_name = $("#user_name");
	var user_pass = $("#user_pass");
	var user_rpass = $("#user_rpass");
	var real_name = $("#real_name");
	var user_mail = $("#user_mail");
	var user_phone = $("#user_phone");
	var random = $("#random");
	
	var name=/^[a-z][a-z0-9_]{3,15}$/;
    var pass=/^[a-zA-Z0-9]{3,15}$/;
    var num= /^\d+$/;
    var email=/^[\w]+[@]\w+[.][\w]+$/;
    var IdCard=/^\d{15}(\d{2}[A-Za-z0-9])?$/;
    var Phone=/^\d{11}$/;
	addBtn.bind("click",function(){
		
		if(user_name.val()==''||user_pass.val()==''){
			alert("用户名或密码不能为空");
			return;
		}
		if(user_pass.val()!=user_rpass.val()){
			alert("两次输入密码不一致");
			return;
		}
		if(real_name.val()==''){
			alert("姓名不能为空");
			return;
		}
		if(user_mail.val()!='' && !email.exec(user_mail.val())){
			alert("邮箱格式不正确");
			return;
		}
		if(user_phone.val()!='' && !Phone.exec(user_phone.val())){
			alert("联系电话必须为11位数字");
			return;
		}
		if(random.val()==''){
			alert("验证码不能为空");
			return;
		}
		var aQuery = $("#info").serialize();  
		$.post('LoginRegSystem.action',aQuery,
			function(responseObj) {
					if(responseObj.success) {	
						 alert('注册成功！');
						 window.location.href="page_index.action";
					}else  if(responseObj.err.msg){
						 alert('失败：'+responseObj.err.msg);
					}else{
						 alert('失败：服务器异常！');
					}	
		 },'json');
	});
});
</script>
</body>
</html>