$(document).ready(function(){
	var postStr = {
		'user_name':'',
		'user_pass':'',
		'random':''
	};
	var selfCenterBtn = $("#selfCenterBtn");
	var loginOutBtn = $("#loginOutBtn");
	var loginOutTop = $("#loginOutTop");
	var loginInBtn = $("#loginInBtn");
	var regBtn = $("#regBtn");
	var infoField = $("#infoField");
	var loginField = $("#loginField");
	var user_name = $("#user_nameTop");
	var user_pass = $("#user_passTop");
	var random = $("#randomTop");
	
	$("#loginOutBtn,#loginOutTop").bind('click',function(){
		$.post('LoginOutSystem.action',null,
			function(responseObj) {
					if(responseObj.success) {	
						 window.location.href="page_index.action";
					}else  if(responseObj.err.msg){
						 alert('error：'+responseObj.err.msg);
					}else{
						 alert('error！');
					}	
		 },'json');
	});
	
	loginInBtn.bind('click',function(){
		if(user_name.val()==''||user_pass.val()==''||random.val()==''){
			//alert("用户名和密码、验证码不能为空！")
			return;
		}
		postStr['user_name'] = user_name.val();
		postStr['user_pass'] = user_pass.val();
		postStr['random'] = random.val();
		
		$.post('LoginInSystem.action',postStr,
			function(responseObj) {
					if(responseObj.success) {	
						 window.location.href="page_index.action";
					}else  if(responseObj.err.msg){
						 alert('error：'+responseObj.err.msg);
					}else{
						 alert('error！');
					}	
		 },'json');
	});
	
	regBtn.bind('click',function(){
		 window.location.href="reg.jsp";
	});
	
	selfCenterBtn.bind('click',function(){
		 window.location.href="myInfo.jsp";
	});

	$("#sblog_titleTop").keydown(function (e) {
		var curKey = e.which;
		if (curKey == 13) {
			$("#infoTop").submit();
		}
	});
});