<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<title>用户登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/style.css">
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
 	width:400px;
 	height:280px;
	box-sizing: border-box;
 	left:calc(50% - 200px);
 	top:calc(50% - 140px);
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
<jsp:include page="top.jsp"><jsp:param name="menu" value="login" /></jsp:include>
<div id="picnews2"></div>
<div class="middlefull">
	 <div class="regTable">
	 	 <form name="info" id="info" style="width:100%;height:100%" action="LoginRegSystem.action" method="post">
		 <table class="regTable" style="">
			<tr>
				<td class="theme" colspan="2">登录贝壳交流论坛</td>
			</tr>
			<tr>
				<td align="right" width="20%"><span style="color:red">*</span> 用户名：</td>
				<td align="left" width="80%"><input type="text" name="user_name" id="user_nameTop" style="width:200px;" class="inputstyle"/></td>
			</tr>
			<tr>
				<td align="right" width="20%"><span style="color:red">*</span> 密　码：</td>
				<td align="left" width="80%"><input type="password" name="user_pass" id="user_passTop" style="width:200px;" class="inputstyle"/></td>
			</tr>
			<tr>
				<td align="right" width="20%"><span style="color:red">*</span> 验证码：</td>
				<td align="left" width="80%"> 
					<input type="text" id="randomTop" name="random" style="width:80px;" class="inputstyle"/>
					&nbsp;<img src="Random.jsp" width="90" style="cursor:pointer;vertical-align:text-bottom;" title="换一张" id="safecode" border="0" onClick="reloadcode()"/>
				</td>
			</tr>
			<tr>
				<td align="right" width="20%"></td>
				<td align="left" width="80%"> 
					<input type="button" style="width:80px;height:30px" id="loginInBtn" class="btnstyle2" value="登录"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="reset"  style="width:80px;height:30px" value="清空"  class="btnstyle2" />
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
</script>
</body>
</html>