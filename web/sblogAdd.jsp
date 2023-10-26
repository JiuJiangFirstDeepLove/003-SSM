<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<title>用户发帖</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/store.css">
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script charset="utf-8" src="admin/editor2/kindeditor-all-min.js"></script>
<script charset="utf-8" src="admin/editor2/lang/zh-CN.js"></script>
<script language="javascript" type="text/javascript"> 
	var user_id="${userFront.user_id}";
	if(user_id==null || user_id==''){
		alert("请先登录！");
		window.location.href="page_index.action";
	}
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
		var product_infoH = $("#product_info").height();
		$("#product_info").css("margin-top",(middleHeight - product_infoH)/2);
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
<jsp:include page="top.jsp"><jsp:param name="menu" value="sblogAdd" /></jsp:include>
<div id="picnews2"></div>
<div id="middle" style="padding:10px;">
	 <div id="product_info" style="width:100%;box-shadow:0 2px 12px 0 rgb(0 0 0 / 10%);">
			<div class="title">贝壳论坛  &gt;&gt;  发布帖子信息</div>
			<div style="margin-top:5px">
				<form id="info" name="info" action="page_saveSblog.action" method="post">
					<input type="hidden" name="user_id" id="user_id" value="${userFront.user_id }"/>
					<table class="ptable" style="margin-bottom:5px;">
						<tr>
							<td width="15%" align="right" style="padding-right:5px">帖子标题：</td>
							<td width="*">
								<input type="text" style="width:500px;" name="sblog_title" id="sblog_title"
									   value="${sblog.sblog_title}"/>
							</td>
						</tr>
						<tr>
							<td align="right" style="padding-right:5px">帖子内容：</td>
							<td class="KEEdit">
								<textarea style="width:580px;height:300px" name="sblog_content"
										  id="noticeContent">${sblog.sblog_content}</textarea>
							</td>
						</tr>
						<tr>
							<td align="right" style="padding-right:5px">论坛板块：</td>
							<td>
								<select id="sblog_type_id" name="sblog_type_id" style="width:200px">
									<option value="0">请选择</option>
									<c:forEach items="${sblogTypes}" var="sblogType">
									<option value="${sblogType.sblog_type_id}">${sblogType.sblog_type_name}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr class="">
							<td align="center" height="30" colspan="4">
								<input type="button" id="addBtn" Class="btnstyle" value="发 布"/>
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
		var user_flag = "${userFront.user_flag}";
		$("#addBtn").bind('click', function () {
			if (user_flag=="2"){
				alert('您的当前状态是：禁言！无法发布帖子，请联系管理员！');
				return;
			}
			editor.sync();
			if ($("#sblog_title").val() == '') {
				alert('帖子标题不能为空');
				return;
			}
			if ($("#noticeContent").val() == '') {
				alert('帖子内容不能为空');
				return;
			}
			var aQuery = $("#info").serialize();
			$.post('page_addSblog.action', aQuery,
					function (responseObj) {
						if (responseObj.success) {
							alert('发布成功！');
							window.location.href = "page_index.action";
						} else if (responseObj.err.msg) {
							alert('发布失败：' + responseObj.err.msg);
						} else {
							alert('发布失败：服务器异常！');
						}
					}, 'json');
		});
		
	});

	KindEditor.ready(function (K) {
		window.editor = K.create('#noticeContent', {
			width: '95%',
			items: [
				'fullscreen', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyfull',
				'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
				'italic', 'underline', 'anchor', 'link', 'unlink'
			],
			uploadJson: 'admin/editor2/jsp/upload_json.jsp',
			fileManagerJson: 'admin/editor2/jsp/file_manager_json.jsp',
			allowFileManager: true

		});
	});
</script>
</body>
</html>