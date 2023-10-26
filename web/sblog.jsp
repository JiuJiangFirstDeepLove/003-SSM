q<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<title>帖子信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/info.css">
<script language="javascript" type="text/javascript" src=""></script>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
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
	var listH = $("#list").height();
	var pageTop = (middleHeight - 30) - (listH - 55) - 55;
	$("#middle").height(middleHeight);
	$("#list").height(middleHeight - 30);
	$("#page").css("margin-top", pageTop);
	
});
	
</script>
<style type="text/css">
 body,td,div
 {
   font-size:14px;
 }
</style>
</head>
<body>
<jsp:include page="top.jsp">
	<jsp:param name="menu" value="sblog"/>
</jsp:include>
<div id="picnews2"></div>
<div id="middle" sty;e="padding:10px;">
	<form name="info" id="info" action="page_listSblogs.action" method="post">
	<input type="hidden" name="pageNo" id="pageNo" value="${paperUtil.pageNo}"/>
	<div id="list">
		 <div class="nav">
		    <div class="nav1" style="width:200px!important;">当前位置: 主页 > 帖子信息 </div>
		 	<div class="nav2" style="width:730px!important;">　　　
		 	  标题：
			  <input type="text" style="width:120px" id="sblog_title" name="sblog_title" value="${paramsSblog.sblog_title}" class="inputstyle"/>&nbsp;
			  板块：
			  <select id="sblog_type_id" name="sblog_type_id" style="width:100px;height:22px" class="inputstyle">
				<option value="0">请选择</option>
				<c:forEach items="${sblogTypes}" var="sblogType">
				<option value="${sblogType.sblog_type_id}" ${sblogType.sblog_type_id==paramsSblog.sblog_type_id?'selected':''}>${sblogType.sblog_type_name}</option>
				</c:forEach>
			  </select>&nbsp;
			   帖主：
			   <input type="text" style="width:80px" id="user_name" name="user_name" value="${paramsSblog.user_name}" class="inputstyle"/>&nbsp;
				排序：
				<select id="top_flag" name="top_flag" style="width:80px;height:22px" class="inputstyle">
					<option value="0" ${paramsSblog.top_flag==0?'selected':''}>发布时间</option>
					<option value="1" ${paramsSblog.top_flag==1?'selected':''}>按点击量</option>
				</select>&nbsp;
			   <input type="button" value="搜索" onclick="serch();" class="btnstyle"/>
		 	</div>
		 </div>
		 <div class="list_info">
			<ul>
				<c:forEach items="${sblogs}" var="sblog" varStatus="status">
				<li>
					<div class="info_text" style="width: 700px">
					<img src="images/ico-1.gif" />&nbsp;&nbsp;
						<c:if test="${sblog.sblog_kind==2}"><img src="images/jing.png"/></c:if>
						<a href="page_querySblog.action?sblog_id=${sblog.sblog_id}"  title="${sblog.sblog_title}">
						${fn:length(sblog.sblog_title)>25?fn:substring(sblog.sblog_title,0,24):sblog.sblog_title}..
					</a>　
					</div>
					<div class="info_time">${sblog.sblog_date}</div>
				</li>
				</c:forEach>
			</ul>
		 </div>
		 <jsp:include page="page.jsp"></jsp:include>
	</div>
	</form>
</div>
<jsp:include page="bottom.jsp"></jsp:include>
<script language="javascript" type="text/javascript">
function GoPage()
{
  var pagenum=document.getElementById("goPage").value;
  var patten=/^\d+$/;
  if(!patten.exec(pagenum))
  {
    alert("页码必须为大于0的数字");
    return false;
  }
  document.getElementById("pageNo").value=pagenum;
  document.info.submit();
}
function ChangePage(pagenum)
{
	 document.getElementById("pageNo").value=pagenum;
	 document.info.submit();
}	 
function serch()
{
   var num = /^\d+(\.\d+)?$/;
   document.info.action="page_listSblogs.action";
   document.getElementById("pageNo").value=1;
   document.info.submit();
}
</script>
</body>
</html>