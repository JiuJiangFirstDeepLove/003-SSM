<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<title>修改个人信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/store.css">
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script language="javascript" type="text/javascript"> 
	var user_id="${userFront.user_id}";
	if(user_id==null || user_id==''){
		alert("请先登录！");
		window.location.href="page_index.action";
	}
</script>
<style type="text/css">
 body,td,div
 {
   font-size:14px;
 }
</style>
</head>
<body>
<jsp:include page="top.jsp"><jsp:param name="menu" value="self" /></jsp:include>
<div id="picnews2"></div>
<div id="middle" style="padding:10px;">
	 <div id="product_menu">
	 	 <jsp:include page="leftMenu.jsp"><jsp:param name="leftMenu" value="myInfo" /></jsp:include>
	 </div>
	 <div id="product_info">
			<div>
				 <form id="info" name="info" action="page_saveUserFront.action" method="post">    
				 <input type="hidden" name="user_id" value="${userFront.user_id}"/>
				 <input type="hidden" name="user_fss" value="${userFront.user_fss}"/>
				 <input type="hidden" name="user_photo" id="user_photo" value='${userFront.user_photo}'/>
				 <table class="ptable" style="margin-bottom:5px;">
					<tr>
			          <td width="15%" align="right" style="padding-right:5px">用户名：</td>
			          <td width="35%">${userFront.user_name}</td>
					  <td align="left" colspan="2" rowspan="6">
					    <img id="userImg" src="images/head/${userFront.user_photo}" width="300" height="300" style="border:0px;"/>
				        &nbsp;<span id="op" style="display:none"><img src="images/loading004.gif"  height="80" /></span>
				      </td>
			        </tr> 
			         <tr>
			          <td width="15%" align="right" style="padding-right:5px"><font color="red">*</font> 姓名：</td>
			          <td width="35%">
			            <input type="text" id="real_name" name="real_name" value="${userFront.real_name}"/>
			          </td> 
			        </tr> 
			        <tr>  
			          <td align="right" style="padding-right:5px"><font color="red">*</font> 性别：</td>
			          <td>
			             <input type="radio" name="user_sex" id="sex1" value="1"/>男&nbsp;&nbsp;
			             <input type="radio" name="user_sex" id="sex2" value="2"/>女
			          </td>
			       </tr> 
			       <tr>
			          <td align="right" style="padding-right:5px">邮箱：</td>
			          <td>
			             <input type="text" id="user_mail" name="user_mail" value="${userFront.user_mail}"/>
			          </td>
			       </tr> 
			       <tr>    
			          <td align="right" style="padding-right:5px">电话：</td>
			          <td>
			             <input type="text" id="user_phone" name="user_phone" value="${userFront.user_phone}"/>
			          </td>
			        </tr>
			       <tr>
			          <td align="right" style="padding-right:5px">粉丝数：</td>
			          <td>
						  ${userFront.user_fss}
			          </td>
			        </tr>
			       <tr>
			          <td align="right" style="padding-right:5px">状态：</td>
			          <td>
						  ${userFront.user_flagDesc}
			          </td>
			          <td align="left" colspan="2">
				          <iframe name="uploadPage" src="uploadImg.jsp" width="100%" height="50" marginheight="0" marginwidth="0" scrolling="no" frameborder="0"></iframe>            
				       </td>
			        </tr>
			        <tr class="">
			          <td align="center" height="30" colspan="4">
			            <input type="button" id="saveBtn" Class="btnstyle" value="修 改"/>&nbsp;
			            <span style="color:red">${tip }</span>
			          </td>
			        </tr>
				 </table>
				 </form>
			</div>
		</div>
</div>
<jsp:include page="bottom.jsp"></jsp:include>
<script language="javascript" type="text/javascript">
	$(document).ready(function(){
		 var user_sex = "${userFront.user_sex}";
		 $("#sex"+user_sex).attr('checked','checked');
		 
		 var num=/^\d+$/;
		 var email=/^[\w]+[@]\w+[.][\w]+$/;
	     var IdCard=/^\d{15}(\d{2}[A-Za-z0-9])?$/;
	     var Phone=/^\d{11}$/;
	     
	     var real_name = $("#real_name");
	 	 var user_mail = $("#user_mail");
	 	 var user_phone = $("#user_phone");
		 $("#saveBtn").bind('click',function(){
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
			var aQuery = $("#info").serialize();  
			$.post('page_saveUserFront.action',aQuery,
				function(responseObj) {
						if(responseObj.success) {	
							 alert('修改成功！');
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