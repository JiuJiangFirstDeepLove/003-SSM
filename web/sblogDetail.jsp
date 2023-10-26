<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>帖子详情</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/message.css">
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script charset="utf-8" src="admin/editor2/kindeditor-all-min.js"></script>
<script charset="utf-8" src="admin/editor2/lang/zh-CN.js"></script>
<script language="javascript" type="text/javascript">
 $(document).ready(function(){

	 var user_id = "${userFront.user_id}";
	 var user_flag = "${userFront.user_flag}";
	 var sblog_user_id = '${sblog.user_id}';
	 var num = /^\d+$/;

	 $("#addFocus").bind('click', function () {
		 if (user_id == '') {
			 alert('请先登录');
			 return;
		 }
		 if (user_id == sblog_user_id) {
			 alert('您不能关注自己');
			 return;
		 }
		 var aQuery = {
			 'user_id': user_id,
			 'sblog_user': '${sblog.user_id}'
		 };
		 $.post('page_addFocus.action', aQuery,
				 function (responseObj) {
					 if (responseObj.success) {
						 alert('关注成功！');
						 window.location.reload();
					 } else if (responseObj.err.msg) {
						 alert('失败：' + responseObj.err.msg);
					 } else {
						 alert('失败：服务器异常！');
					 }
				 }, 'json');
	 });

	 var focus_id = "${focus.focus_id}";
	 $("#cancelFocus").bind('click', function () {
		 if (user_id == '') {
			 alert('请先登录');
			 return;
		 }
		 var aQuery = {
			 'focus_id': focus_id
		 };
		 $.post('page_cancelFocus.action', aQuery,
				 function (responseObj) {
					 if (responseObj.success) {
						 alert('取消关注成功！');
						 window.location.reload();
					 } else if (responseObj.err.msg) {
						 alert('失败：' + responseObj.err.msg);
					 } else {
						 alert('失败：服务器异常！');
					 }
				 }, 'json');
	 });

	 $("#addCollect").bind('click', function () {
		 if (user_id == '') {
			 alert('请先登录');
			 return;
		 }
		 var aQuery = {
			 'user_id': user_id,
			 'sblog_id': '${sblog.sblog_id}'
		 };
		 $.post('page_addCollect.action', aQuery,
				 function (responseObj) {
					 if (responseObj.success) {
						 alert('收藏成功！');
					 } else if (responseObj.err.msg) {
						 alert('失败：' + responseObj.err.msg);
					 } else {
						 alert('失败：服务器异常！');
					 }
				 }, 'json');
	 });


	 $("#addPraise").bind('click', function () {
		 if (user_id == '') {
			 alert('请先登录');
			 return;
		 }
		 var aQuery = {
			 'user_id': user_id,
			 'sblog_id': '${sblog.sblog_id}'
		 };
		 $.post('page_addPraise.action', aQuery,
				 function (responseObj) {
					 if (responseObj.success) {
						 alert('点赞成功！');
						 $("#praiseCount").html(Number($("#praiseCount").html()) + 1);
					 } else if (responseObj.err.msg) {
						 alert('失败：' + responseObj.err.msg);
					 } else {
						 alert('失败：服务器异常！');
					 }
				 }, 'json');
	 });


	 $("#addBtn").bind("click", function () {
		 editor.sync();
		 if (user_id == '') {
			 alert('请先登录后在进行评论！')
			 return;
		 }
		 if (user_flag == "2") {
			 alert('您的当前状态是：禁言！无法发言，请联系管理员！');
			 return;
		 }
		 if ($("#noticeContent").val() == '') {
			 alert('评论内容不能为空！')
			 return;
		 }
		 var aQuery = $("#infoSblog").serialize();
		 $.post('page_addSblogReply.action', aQuery,
				 function (responseObj) {
					 if (responseObj.success) {
						 alert('感谢您的评论！');
						 window.location.reload();
					 } else if (responseObj.err.msg) {
						 alert('评论失败：' + responseObj.err.msg);
					 } else {
						 alert('评论失败：服务器异常！');
					 }
				 }, 'json');
	 });

	 $("#replyBtn").bind("click", function () {
		 if (user_id == '') {
			 alert('请先登录后在进行回复！')
			 return;
		 }
		 if (user_flag == "2") {
			 alert('您的当前状态是：禁言！无法发言，请联系管理员！');
			 return;
		 }
		 if ($("#noticeContent2").val() == '') {
			 alert('回复内容不能为空！')
			 return;
		 }
		 var aQuery = $("#infoSblogReply").serialize();
		 $.post('page_addSblogReply.action', aQuery,
				 function (responseObj) {
					 if (responseObj.success) {
						 alert('回复成功！');
						 window.location.reload();
					 } else if (responseObj.err.msg) {
						 alert('回复失败：' + responseObj.err.msg);
					 } else {
						 alert('回复失败：服务器异常！');
					 }
				 }, 'json');
	 });
	 $("#cancelReply").bind("click", function () {
		 $("#addSblogReply").hide();
		 $("#addSblog").fadeIn();
	 });

	 $("a[id^='delSblog_']").bind("click", function () {
		 var ids = $(this).attr("id").split("_")[1];
		 var aQuery = {'ids': ids};
		 $.post('page_delSblogs.action', aQuery,
				 function (responseObj) {
					 if (responseObj.success) {
						 alert('删除发言成功！');
						 window.location.reload();
					 } else if (responseObj.err.msg) {
						 alert('删除发言失败：' + responseObj.err.msg);
					 } else {
						 alert('删除发言失败：服务器异常！');
					 }
				 }, 'json');
	 });

	 $("a[id^='delSblogReply_']").bind("click", function () {
		 var ids = $(this).attr("id").split("_")[1];
		 var aQuery = {'ids': ids};
		 $.post('page_delSblogReplys.action', aQuery,
				 function (responseObj) {
					 if (responseObj.success) {
						 alert('删除回复成功！');
						 window.location.reload();
					 } else if (responseObj.err.msg) {
						 alert('删除回复失败：' + responseObj.err.msg);
					 } else {
						 alert('删除回复失败：服务器异常！');
					 }
				 }, 'json');
	 });
}); 
 function initForm(sblog_reply_id,sblog_user,sblog_content){
		$("#addSblog").hide();
		$("#addSblogReply").fadeIn();
		$("#sblog_reply2").val(sblog_reply_id);
		if (sblog_user){
			$("#sblog_user").val(sblog_user);
			$("#sblog_content").val(sblog_content);
		}else{
			$("#sblog_user").val("");
			$("#sblog_content").val("");
		}
	}
</script>
<style type="text/css">
 body,td,div
 {
   font-size:14px;
 }

 #product_info {
	 width: 1200px;
	 margin:0 auto;
	 overflow: hidden;
 }

 #product_info .productShow {
	 margin-top: 5px;
	 width: 1190px;
	 /* border: 1px solid #f0f0f0; */
	 overflow: hidden;
 }

 #product_info .productShow .titleTime {
	 width: 1170px;
	 margin-top: 10px;
	 margin-left: 10px;
	 height: 100px;
	 color: #000;
	 font-size: 22px;
	 box-shadow:0 2px 12px 0 rgb(0 0 0 / 10%);
	 overflow: hidden;
 }
 #product_info .productShow .title {
	 line-height: 50px;
	 width: 1000px;
	 margin-left: 10px;
	 color: #000;
	 font-size: 22px;
	 font-weight: bold;
	 text-align:center;
	 overflow: hidden;
 }
 #product_info .productShow .title .btn{
 	font-size:14px;
	font-weight: normals;
 	color: #9195A3;
 }
 #product_info .productShow .usertime {
	 width: 1000px;
	 height: 40px;
	 line-height: 40px;
	 margin-left: 10px;
	 text-align:center;
	 color: #9195A3;
	 font-size:16px;
 }
 #product_info .productShow .typehr {
	 height: 5px;
	 width: 1180px;
	 margin-left: 10px;
	 border-bottom: 1px solid whitesmoke;
	 overflow: hidden;
 }
 #product_info .productShow .sblogcontainer{
 	width:1170px;
 	min-height:100px;
 	max-height:none;
	margin-left: 10px;
 	margin-top: 10px;
 	margin-bottom: 10px;
    box-shadow:0 2px 12px 0 rgb(0 0 0 / 10%);
 	overflow:hidden;
 }
 #product_info .productShow .sbloguser {
	 width: 220px;
	 height: 400px;
	 margin-left:10px;
	 margin-top:10px;
	 box-sizing:border-box;
	 float:left;
	 padding-top:10px;
	 text-align:center;
	 border:1px solid whitesmoke;
	 position:relative;
	 overflow: hidden;
	 box-shadow:0 2px 12px 0 rgb(0 0 0 / 10%);
 }

 #product_info .productShow .sblogintro {
	 width: calc(100% - 300px);
	 min-height: 400px;
	 max-height:none;
	 box-sizing:border-box;
	 float:left;
	 padding:10px 10px 10px 0px;
	 margin-left:20px;
	 line-height: 30px;
	 font-size: 15px;
	 overflow: hidden;
 }
 .sbloguser .userpic{
	 width:200px;
	 height:200px;
	 margin:0 auto;
	 
 }
 .sbloguser .userpic img{
	 width:180px;
	 height:180px;
	 margin-top:10px;
	 border-radius: 50%;
 }
 .louzhubiaoshi {
    position: absolute;
    width: 36px;
    height: 36px;
    top: 0px;
    right: 0;
    background: url('images/louzhu_f37d453.png') no-repeat -44px 0;
}
 .sbloguser .userinfo {
	 width: 100%;
	 height: 120px;
	 line-height: 40px;
	 color: #000;
	 font-size:18px;
 }
 .sblogintro .usertime {
	 width: 100%;
	 height: 40px;
	 line-height: 40px;
	 color: #9195A3;
	 font-size:16px;
	 text-align:right;
 }
 .sbloguser .userbtn {
	 width: 100%;
	 height: 60px;
	 line-height: 60px;
	 text-align:center;
 }
 .replyContainer{
 	width:1170px;
 	min-height:100px;
 	max-height:none;
	margin-left: 10px;
 	margin-top: 10px;
 	margin-bottom: 10px;
    box-shadow:0 2px 12px 0 rgb(0 0 0 / 10%);
 	overflow:hidden;
 }
</style>
</head>
<body>
<jsp:include page="top.jsp"><jsp:param name="menu" value="sblog" /></jsp:include>
<div id="picnews2"></div>
<div id="middleBg">
	<!--  产品检索介绍 -->
	 <div id="product_info">
			<div class="productShow">
					<div class="titleTime">
						<div class="title">
							<c:if test="${sblog.sblog_kind==2}"><img src="images/jing.png"/></c:if> ${sblog.sblog_title}
						</div>
						<div class="usertime">
							论坛板块：${sblog.sblog_type_name}　　发表时间：${sblog.sblog_date}
							&nbsp;&nbsp;
							<img src="images/xcp-view.png" valign="middle" style="width:22px;height:22px"  title="浏览"/>
							<span class="btn">${sblog.sblog_click}</span>
							&nbsp;&nbsp;
							<a href="javascript:void(0)" id="addPraise" title="点赞">
								<img src="images/xcp-like.png" valign="middle" style="width:22px;height:22px；border:0px"/>
							</a>
							<span id="praiseCount" class="btn">${sblog.sblog_praise}</span>
							&nbsp;&nbsp;
							<a href="javascript:void(0)" id="addCollect" title="收藏">
								<img src="images/xcp-collect.png" valign="middle" style="width:22px;height:22px；border:0px"/>
							</a>
						</div>
					</div>
					<!-- <div class="typehr"></div> -->
					
					<div class="sblogcontainer">
						<div class="sbloguser">
							<div class="userpic">
								<img src="images/head/${sblog.user_photo}"/>
								<div class="louzhubiaoshi"></div>
							</div>
							<div class="userinfo">
								<strong>${sblog.user_name}</strong>
								<br/>性别：${sblog.user_sexDesc}
								<br/>粉丝数：${sblog.user_fss}
							</div>
							
							<div class="userbtn">
								<c:if test="${focus==null}">
									<input type="button" value="关 注" id="addFocus" class="btnstyle" style="width:90px;height:34px!important;border-radius:10px"/>
								</c:if>
								<c:if test="${focus!=null}">
									<input type="button" value="取消关注" id="cancelFocus" class="btnstyle"
										   style="width:90px;height:34px!important;;border-radius:10px"/>
								</c:if>
							</div>
						</div>
						
						<div class="sblogintro">
							${sblog.sblog_contentShow}
						</div>
					</div>
					
					<!-- <div class="typehr"></div> -->
					
					<div class="replyContainer">
					<div class="title">帖子相关评论</div>
					<!-- 发布评论开始 -->
					<div id="addSblog" style="width:99%;margin:0 auto;">
						<form name="infoSblog" id="infoSblog" action="page_addSblogReply.action" method="post">
							<input type="hidden" name="user_id" id="user_id" value="${userFront.user_id}"/>
							<input type="hidden" name="sblog_id" id="sblog_id" value="${sblog.sblog_id}"/>
							<input type="hidden" name="sblog_reply" id="sblog_reply" value="-1"/>
							<table class="reply_add">
								<tr>
									<td width="65px"><img style="width:55px;height:55px" class="circle" src="images/head/${userFront!=null?userFront.user_photo:'default.jpg'}"/></td>
									<td align="left">
										<textarea name="reply_content" id="noticeContent" style="width:90%;height:150px" class="inputstyle" placeholder="发表神妙评论"></textarea>
									</td>
								</tr>
								<tr>
									<td width="65px"></td>
									<td align="left" style="padding-left:5px;height:50px;line-height: 50px">
										<input type="button" id="addBtn" class="btnstyle" style="width:90px;height:34px!important;border-radius:10px;vertical-align:middle" value="发表评论"/>&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="reset" id="resetBtn" class="btnstyle" style="width:90px;height:34px!important;border-radius:10px;vertical-align:middle" value="清空"/>
									</td>
								</tr>
							</table>
						</form>
					</div>
					<a name="link"></a>
					<!-- 发布评论结束 -->
					
					<!-- 回复评论开始 -->
					<div id="addSblogReply" style="width:99%;margin:0 auto;display:none">
						<form name="infoSblogReply" id="infoSblogReply" action="page_addSblogReply.action" method="post">
							<input type="hidden" name="sblog_id" id="sblog_id" value="${sblog.sblog_id}"/>
							<input type="hidden" name="user_id" id="user_id" value="${userFront.user_id}"/>
							<input type="hidden" name="sblog_reply" id="sblog_reply2" value="0"/>
							<input type="hidden" name="sblog_user" id="sblog_user" value=""/>
							<input type="hidden" name="sblog_content" id="sblog_content" value=""/>
							<table class="reply_add">
								<tr>
									<td width="65px"><img style="width:55px;height:55px" class="circle" src="images/head/${userFront!=null?userFront.user_photo:'default.jpg'}"/>
									</td>
									<td align="left" colspan="2">
										<textarea name="reply_content" id="noticeContent2" style="width:90%;height:100px" class="inputstyle" placeholder="发表神妙回复"></textarea>
									</td>
								</tr>
								<tr>
									<td align="left" colspan="2" style="padding-left:65px;height: 50px;line-height: 50px">
										<input type="button" id="replyBtn" class="btnstyle" style="width:90px;height:34px!important;border-radius:10px;vertical-align:middle" value="发表回复"/>&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="button" id="cancelReply" class="btnstyle" style="width:90px;height:34px!important;border-radius:10px;vertical-align:middle" value="取消"/>
									</td>
								</tr>
							</table>
						</form>
					</div>
					<!-- 回复评论结束 -->
					
					<div class="typehr"></div>
					<div class="title">
						评论列表（${fn:length(sblog.replys)} 条）
					</div>
					<!-- 评论信息开始 -->
					<div id="lyxx" style="width:99%;max-height:600px;overflow-x:hidden;overflow-y:auto;">
					 <c:if test="${sblog.replys!=null && fn:length(sblog.replys)>0}">
				   	 <c:forEach items="${sblog.replys}" var="sblogReply" varStatus="status">
					 <div class="messages2" style="width:900px;margin-left:10px;margin-top:5px">
			 			<div class="messages_left" style="width:65px">
							<img style="width:55px;height:55px" class="circle" src="images/head/${sblogReply.user_photo}"/>
						</div>
						<div class="messages_right" style="width:820px;">
							<div class="nickName">
								${sblogReply.user_name}
							</div>
							<div class="message_content">
								${sblogReply.reply_contentShow}
							</div>
							<div class="time">
								<img src="images/xcp-time.png" valign="middle" style="width:16px;height:16px"/>
								${fn:substring(sblogReply.reply_date,0,19)}
								&nbsp;&nbsp;&nbsp;&nbsp;
								<img src="images/xcp-reply.png" valign="middle" style="width:18px;height:18px"/>
								<a href="#link" onclick="initForm('${sblogReply.sblog_reply_id}')">[回复]</a>
								<c:if test="${userFront!=null && userFront.user_id==sblogReply.user_id}">
									&nbsp;&nbsp;&nbsp;&nbsp;
									<img src="images/xcp-del.png" valign="middle" style="width:16px;height:16px"/>
									<a href="javascript:void(0)" id="delSblogReply_${sblogReply.sblog_reply_id}">[删除]</a>
								</c:if>
							</div>
							<c:if test="${sblogReply.replys != null && fn:length(sblogReply.replys) >0}">
					 		<c:forEach items="${sblogReply.replys}" var="sblogReply2">
							<div class="reply">
								<div class="messages_left" style="width:65px">
									<img style="width:55px;height:55px" class="circle" src="images/head/${sblogReply2.user_photo}"/>
								</div>
								<div class="messages_right" style="width:750px;">
									<div class="nickName">
											${sblogReply2.user_name}
									</div>
									<div class="message_content">
											${sblogReply2.reply_contentShow}
										    <c:if test="${sblogReply2.sblog_user!=null && sblogReply2.sblog_user!=''}"> // <span style="color:blue">@${sblogReply2.sblog_user}：</span>${sblogReply2.sblog_contentShow}</c:if>
									</div>
									<div class="time">
										<img src="images/xcp-time.png" valign="middle" style="width:16px;height:16px"/>
											${fn:substring(sblogReply2.reply_date,0,19)}
										&nbsp;&nbsp;&nbsp;&nbsp;
										<img src="images/xcp-reply.png" valign="middle" style="width:18px;height:18px"/>
										<a href="#link" onclick="initForm('${sblogReply2.sblog_reply}','${sblogReply2.user_name}','${sblogReply2.reply_content}')">[回复]</a>
										<c:if test="${userFront!=null && userFront.user_id==sblogReply2.user_id}">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<img src="images/xcp-del.png" valign="middle" style="width:16px;height:16px"/>
											<a href="javascript:void(0)" id="delSblogReply_${sblogReply2.sblog_reply_id}">[删除]</a>
										</c:if>
									</div>
								</div>
							</div>
							</c:forEach>
					 		</c:if>
						</div>
					 </div>
					 </c:forEach>
					 </c:if>
					</div>
					</div>
					 <!-- 评论信息结束 -->
			</div>

			 
			
	 </div>
	 <!--  产品检索 -->
	 
</div>
<jsp:include page="bottom.jsp"></jsp:include>
<script type="text/javascript">
KindEditor.ready(function(K) {
	window.editor = K.create('#noticeContent',{
		width : '90%',
		items:[
			'fullscreen','|','justifyleft', 'justifycenter', 'justifyright','justifyfull',
			'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
			'italic', 'underline','anchor', 'link', 'unlink'
		],
		uploadJson : 'admin/editor2/jsp/upload_json.jsp',
        fileManagerJson : 'admin/editor2/jsp/file_manager_json.jsp',
        allowFileManager : true

	});
	//editor.html("发表神妙评论");
});
</script>
</body>
</html>