<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<table class="ptable_menu">
	<tr class="ptable_menu_text">
		<td><a href="myInfo.jsp" class="${param.leftMenu=='myInfo'?'active':''}">个人信息</a></td>
	</tr>
	<tr class="ptable_menu_text">
		<td><a href="myPwd.jsp" class="${param.leftMenu=='myPwd'?'active':''}">修改密码</a></td>
	</tr>
	<tr class="ptable_menu_text">
		<td><a href="page_listMySblogs.action" class="${param.leftMenu=='sblog'?'active':''}">我的帖子</a></td>
	</tr>
	<tr class="ptable_menu_text">
		<td><a href="page_listMyCollects.action" class="${param.leftMenu=='collect'?'active':''}">我的收藏</a></td>
	</tr>
</table>
<script language="javascript" type="text/javascript"> 
$(function(){
	$("#bottom").css("margin-top", 0);
	var EHeight = document.documentElement.clientHeight;
	var BHeight = document.body.clientHeight;
	var Height1 = Math.max(EHeight,BHeight);
	var middleHeightYG = Height1 - 208;
	var middleHeight = $("#middle").height();
	if(middleHeight < middleHeightYG){
		middleHeight = middleHeightYG - 1;
	}
	$("#middle").height(middleHeight);
	$("#product_menu").height(middleHeight - 30);
	$("#product_info").height(middleHeight - 30);
});
</script>