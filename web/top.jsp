<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<div id="navMenu">
	<ul>
	  <li style="margin-right:65px;margin-left:30px"><img src="images/logo.png"></li>
	  <li class="${param.menu==null || param.menu=='home'?'hover':''}"><a href="page_index.action">首页</a></li>
	  <li class="${param.menu=='sblog'?'hover':''}"><a href="page_listSblogTypes.action">论坛板块</a></li>
	  <c:if test="${userFront!=null }">
	  <li class="${param.menu=='focus'?'hover':''}"><a href="page_listSblogsFocus.action">我的关注</a></li>
	  <li class="${param.menu=='sblogAdd'?'hover':''}"><a href="page_addSblogShow.action">+发帖</a></li>
      </c:if>
      <c:if test="${search_no==null || !search_no}">
	  <li class="searchTop">
		  <form name="infoTop" id="infoTop" action="page_listSblogs.action" method="post">
			  <input type="text" id="sblog_titleTop" name="sblog_title" value="" style="" placeHolder="输入关键字回车搜索"/>
		  </form>
	  </li>
      </c:if>
	  <c:if test="${userFront!=null }">
	  <li class="fright"><a id="loginOutTop" href="JavaScript:void(0)">退出</a></li>
	  <li class="fright ${param.menu=='self'?'hover':''}"><a href="page_myInfo.action">个人中心</a></li>
	  </c:if>
	  <c:if test="${userFront==null }">
	  <li class="fright ${param.menu=='reg'?'hover':''}"><a href="reg.jsp">注册</a></li>
	  <li class="fright ${param.menu=='login'?'hover':''}"><a href="login.jsp">登录</a></li>
	  </c:if>
	</ul>
</div>
<script type="text/javascript" src="js/login.js"></script>
<script language="javascript" type="text/javascript">
$(function(){
	var EHeight = document.documentElement.clientHeight;
	var BHeight = document.body.clientHeight;
	var Height1 = Math.max(EHeight,BHeight);
	var ESHeight = document.documentElement.scrollHeight;
	var Height2 = Math.min(BHeight,ESHeight);
	var bottomM = Math.max(Height1 - Height2,5);
	$("#bottom").css("margin-top", bottomM);
});
</script>