<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<title>我的收藏</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/store.css">
<script language="javascript" type="text/javascript" src=""></script>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script language="javascript" type="text/javascript"> 
	
</script>
<style type="text/css">
 body,td,div
 {
   font-size:12px;
 }
</style>
</head>
<body>
<jsp:include page="top.jsp"><jsp:param name="menu" value="self" /></jsp:include>
<div id="picnews2"></div>
<div id="middle" style="padding:10px;">
	 <div id="product_menu">
	 	 <jsp:include page="leftMenu.jsp"><jsp:param name="leftMenu" value="collect" /></jsp:include>
	 </div>
	 <div id="product_info">
			<div style="margin-top:5px;overflow:auto;">
				 <form id="info" name="info" action="page_listMyCollects.action" method="post" style="width:100%;height:100%">
				 <input type="hidden" name="pageNo" id="pageNo" value="${paperUtil.pageNo}"/>    
				 <table class="ptable" style="margin-bottom:5px;">
				 	<tr>
						<td colspan="15" align="right">
							帖子标题：
      						<input type="text" id="sblog_title" name="sblog_title" style=""
      							value="${paramsCollect.sblog_title}" class="inputstyle"/>&nbsp;
      					    <input type="button" value="搜索" onclick="serch();" class="btnstyle"/>&nbsp;
						</td>
					</tr>
					<tr class="head_text">
					     <td width="*" align="center">帖子标题</td>
     					 <td width="180" align="center">收藏时间</td>
					     <td width="100" align="center">操作</td>
					</tr>
					  <c:if test="${collects!=null &&  fn:length(collects)>0}">
   					  <c:forEach items="${collects}" var="collect" varStatus="status">
					   <tr> 
					     <td width="" align="center">
					     	<a href="page_querySblog.action?sblog_id=${collect.sblog_id}">
					     	${collect.sblog_title}
					     	</a>
					     </td>
     					 <td width="" align="center">${fn:substring(collect.collect_date,0,19)}</td>  
					     <td width="" align="center" style="line-height:22px">&nbsp;
					     	<a id="delCollect_${collect.collect_id}" href="javascript:void(0)">取消收藏</a>
					     </td>
					   </tr> 
					   </c:forEach>
					   </c:if>
					   <c:if test="${collects==null || fn:length(collects)==0}">
					   <tr>
					     <td height="60" colspan="11" align="center"><b>&lt;不存在我的收藏记录信息&gt;</b></td>
					   </tr>
					   </c:if>
				 </table>
				 </form>
			</div>
			<div class="pages">
				<jsp:include page="page.jsp"></jsp:include>
			</div>
		</div>
</div>
<jsp:include page="bottom.jsp"></jsp:include>
<script language="javascript" type="text/javascript">
	function serch()
	{
	   document.info.action="page_listMyCollects.action";
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
	   document.info.action="page_listMyCollects.action";
	   document.info.submit();
	}
	function ChangePage(pagenum)
	{
		document.getElementById("pageNo").value=pagenum;
		document.info.action="page_listMyCollects.action";
		document.info.submit();
	}
	
	$(document).ready(function(){
		$("a[id^='delCollect']").bind('click',function(){
			var collect_id = $(this).attr("id").split("_")[1];
			var aQuery = {
				'ids':collect_id  
			}
			$.post('page_delCollects.action',aQuery,
				function(responseObj) {
						if(responseObj.success) {	
							 alert('取消成功！');
							 window.location.reload();
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