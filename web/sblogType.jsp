<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<title>论坛板块</title>
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
$(document).ready(function(){
	$("input[id^='viewSblogType_']").bind('click',function(){
		var sblog_type_id = $(this).attr("id").split("_")[1];
		window.location.href='page_listSblogs.action?sblog_type_id='+sblog_type_id;
	 });
});		 
	
</script>
<style type="text/css">
 body,td,div
 {
   font-size:14px;
 }
 .list_info li {
 	margin-top:10px;
 	width:100%;
 	height:170px!important;
 	line-height:170px!important;
 	box-shadow:0 2px 12px 0 rgb(0 0 0 / 10%);
 	box-sizing:border-box;
 	padding-top:20px;
 }
 .list_info .info_pic {
    float:left;
 	width:200px;
 	height:120px;
 	line-height:160px;
 	text-align:center;
 }
 .list_info .info_content {
    float:left;
 	width:670px;
 	height:170px;
 	line-height:30px;
 	overflow:auto;
 	color:#666;
 }
</style>
</head>
<body>
<jsp:include page="top.jsp">
	<jsp:param name="menu" value="sblog"/>
</jsp:include>
<div id="picnews2"></div>
<div id="middle">
	<form name="info" id="info" action="page_listSblogTypes.action" method="post" style="width:100%;height:100%">
	<input type="hidden" name="pageNo" id="pageNo" value="${pageNo}"/>
	<div id="list" style="width: 95%;">
		 <div class="nav">
		 	<div class="nav1">当前位置: 首页 > 论坛板块  </div>
		 	<div class="nav2">　　　
			  板块名称：
		      <input type="text" id="sblog_type_name" name="sblog_type_name" value="${paramsSblogType.sblog_type_name}" class="inputstyle" Style=""/>&nbsp;
			  <input type="button" value="搜索" onclick="serch();" class="btnstyle"/>
		 	</div>
		 </div>
		 <div class="list_info" style="width:100%;box-sizing:border-box;padding:10px">
			<ul>
			    <c:if test="${sblogTypes!=null && fn:length(sblogTypes)>0}">
				<c:forEach items="${sblogTypes}" var="sblogType" varStatus="status">
				<li>
					<div class="info_pic">
						<img src="images/sblogType.jpg" width="120" height="120" style="border-radius:8px;"/>
					</div>
					<div class="info_content">
						<div style="color:#000;font-size:18px;font-weight:bold;height:30px;line-height:30px">
							${sblogType.sblog_type_name}　　
							<span style="color:#666;font-size:14px;font-weight:normal">
								帖子数量：${sblogType.sblog_count}　
								活跃用户：${sblogType.user_count}+
							</span>
						</div>
						<div style="height:60px;line-height:30px">
								${sblogType.sblog_type_note}
						</div>
						<div style="height:50px;line-height:50px">
							<input type="button" value="进入板块"  id="viewSblogType_${sblogType.sblog_type_id}" class="btnstyle" style="width:100px;height:30px!important"/>
						</div>	
					</div>
				</li>
				</c:forEach>
				</c:if>
				<c:if test="${sblogTypes==null || fn:length(sblogTypes)==0}">
			    <li style="text-align:center">
			      <b>&lt;不存在论坛板块信息&gt;</b>
			    </li>
			    </c:if>
			</ul>
		 </div>
		 <jsp:include page="page.jsp"></jsp:include>
	</div>
		<!-- <div id="Picture"></div> -->
	</form>
</div>
<jsp:include page="bottom.jsp"></jsp:include>
<script language="javascript" type="text/javascript">
function serch()
{
   document.info.action="page_listSblogTypes.action";
   document.getElementById("pageNo").value=1;
   document.info.submit();
}

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
  document.info.action="page_listSblogTypes.action";
  document.info.submit();
}
function ChangePage(pagenum)
{	
	document.getElementById("pageNo").value=pagenum;
	document.info.action="page_listSblogTypes.action";
	document.info.submit();
}
</script>
</body>
</html>