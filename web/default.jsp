<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<title>首页</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script language="javascript" type="text/javascript"> 
$(function(){
	var index=1;
	function changeImg(){
		index ++;
		index = index > 4 ? 1 : index;
		return "images/hdtp/"+index+".jpg";
	}
	setInterval(function(){
		$("#img1").hide();
		$("#img1").attr("src",changeImg());
		$("#img1").fadeIn(); 
	},3000);
});
</script>
<style type="text/css">
 body,td,div
 {
   font-size:14px;
 }
 #infoField,#loginField{
 	line-height:35px;
 }
 .titleBg{
 	width:100%;
	height:40px;
	line-height:30px;
	margin:auto;
	box-sizing:border-box;
 	background-color: #F4F4F4;
    color: #000;
    padding: 5px;
    padding-left:35px;
    font-size: 18px;
    background-image:url('images/tag1.png');
	background-repeat:no-repeat;
	background-position:10px center;
	background-size:20px 20px;
 }
</style>
</head>
<body>
<jsp:include page="top.jsp"><jsp:param name="menu" value="home" /></jsp:include>
<div id="picnews">
	<img id="img1" src="images/hdtp/1.jpg" style="width:100%;height:100%"/>
</div>
<div id="middle">	
	<div id="middle_left">
		<div id="info">
			<div class="info_con">
				<div class="titleBg">
					精华区
				</div>
				<ul>
				 <c:forEach items="${sblogs}" var="sblog" varStatus="status">
				  <li>
					<div>
						<div class="info_text">
							<a href="page_querySblog.action?sblog_id=${sblog.sblog_id}" target="_blank" title="${sblog.sblog_title}">
								${fn:length(sblog.sblog_title)>25?fn:substring(sblog.sblog_title,0,24).concat('...'):sblog.sblog_title}
							</a>
						</div>
						<div class="info_time">${fn:substring(sblog.sblog_date,0,10)}</div>
					</div>
				  </li>
				  </c:forEach>
				</ul>
			</div>
		</div>
	</div>
	
	<div id="middle_right">
		<div id="info">
			<div class="info_con">
				<div class="titleBg">
					热帖区
				</div>
				<ul>
					<c:forEach items="${sblogs2}" var="sblog" varStatus="status">
						<li>
							<div>
								<div class="info_text">
									<a href="page_querySblog.action?sblog_id=${sblog.sblog_id}" target="_blank"
									   title="${sblog.sblog_title}">
										${fn:length(sblog.sblog_title)>25?fn:substring(sblog.sblog_title,0,24).concat('...'):sblog.sblog_title}
									</a>
								</div>
								<div class="info_time">${fn:substring(sblog.sblog_date,0,10)}</div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</div>
<div id="middle" style="margin-top:10px">
	<div id="middle_left">
		<div id="info">
			<div class="info_con">
				<div class="titleBg">
					新帖区
				</div>
				<ul>
				 <c:forEach items="${sblogs3}" var="sblog" varStatus="status">
				  <li>
					<div>
						<div class="info_text">
							<a href="page_querySblog.action?sblog_id=${sblog.sblog_id}" target="_blank" title="${sblog.sblog_title}">
								${fn:length(sblog.sblog_title)>25?fn:substring(sblog.sblog_title,0,24).concat('...'):sblog.sblog_title}
							</a>
						</div>
						<div class="info_time">${fn:substring(sblog.sblog_date,0,10)}</div>
					</div>
				  </li>
				  </c:forEach>
				</ul>
			</div>
		</div>
	</div>

	<div id="middle_right">
		<div id="info">
			<div class="info_con">
				<div class="titleBg">
					关注区
				</div>
				<ul>
					<c:forEach items="${sblogs4}" var="sblog" varStatus="status">
						<li>
							<div>
								<div class="info_text">
									<a href="page_querySblog.action?sblog_id=${sblog.sblog_id}" target="_blank"
									   title="${sblog.sblog_title}">
										${fn:length(sblog.sblog_title)>25?fn:substring(sblog.sblog_title,0,24).concat('...'):sblog.sblog_title}
									</a>
								</div>
								<div class="info_time">${fn:substring(sblog.sblog_date,0,10)}</div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</div>
<jsp:include page="bottom.jsp"></jsp:include>
</body>
</html>