<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String ua = request.getHeader("User-Agent");
	String jsDiv = "v2.0";
	if (ua.indexOf("Trident") > 0 || ua.indexOf("MSIE") > 0) {
		jsDiv = "ie";
	}
	 
%>
<!DOCTYPE html>
<html lang="ko" id="extr-page">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
		<meta name="_csrf" content="${_csrf.token}"/>
  		<meta name="_csrf_header" content="${_csrf.headerName}"/>
		<title> 아모레퍼시픽 관세환급 시스템 </title>
		<meta name="description" content="">
		<meta name="author" content="">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		
		<!-- Basic Styles -->
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/font-awesome.min.css">

		<!-- S4-Dummy System Styles : Caution! DO NOT change the order -->
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/s4-production-plugins.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/s4-production.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/s4-skins.min.css">

		<!-- S4-Dummy System RTL Support -->
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/s4-rtl.min.css"> 

		<link rel="shortcut icon" href="/rcs/img/favicon/favicon.png" type="image/x-icon">
		<link rel="icon" href="/rcs/img/favicon/favicon.png" type="image/x-icon">

		<!-- #GOOGLE FONT -->
		<!-- <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,300,400,700"> -->

		<link rel="apple-touch-icon" type="image/*" href="/rcs/img/splash/sptouch-icon-iphone.png">
		<link rel="apple-touch-icon" type="image/x-icon" sizes="76x76" href="/rcs/img/splash/touch-icon-ipad.png">
		<link rel="apple-touch-icon" type="image/x-icon" sizes="120x120" href="/rcs/img/splash/touch-icon-iphone-retina.png">
		<link rel="apple-touch-icon" type="image/x-icon" sizes="152x152" href="/rcs/img/splash/touch-icon-ipad-retina.png">
		
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		
		<link rel="apple-touch-startup-image" href="/rcs/img/splash/ipad-landscape.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)">
		<link rel="apple-touch-startup-image" href="/rcs/img/splash/ipad-portrait.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)">
		<link rel="apple-touch-startup-image" href="/rcs/img/splash/iphone.png" media="screen and (max-device-width: 320px)">


		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/login/style_01/main.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/login/style_01/util.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/login/style_01/animate/animate.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/login/style_01/css-hamburgers/hamburgers.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/login/style_01/select2/select2.min.css">

		
		<style class="cp-pen-styles">@import url(https://fonts.googleapis.com/css?family=Open+Sans);
			.btn { display: inline-block; *display: inline; *zoom: 1; padding: 4px 10px 4px; margin-bottom: 0; font-size: 13px; line-height: 18px; color: #333333; text-align: center;text-shadow: 0 1px 1px rgba(255, 255, 255, 0.75); vertical-align: middle; background-color: #f5f5f5; background-image: -moz-linear-gradient(top, #ffffff, #e6e6e6); background-image: -ms-linear-gradient(top, #ffffff, #e6e6e6); background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#ffffff), to(#e6e6e6)); background-image: -webkit-linear-gradient(top, #ffffff, #e6e6e6); background-image: -o-linear-gradient(top, #ffffff, #e6e6e6); background-image: linear-gradient(top, #ffffff, #e6e6e6); background-repeat: repeat-x; filter: progid:dximagetransform.microsoft.gradient(startColorstr=#ffffff, endColorstr=#e6e6e6, GradientType=0); border-color: #e6e6e6 #e6e6e6 #e6e6e6; border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25); border: 1px solid #e6e6e6; -webkit-border-radius: 4px; -moz-border-radius: 4px; border-radius: 4px; -webkit-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05); -moz-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05); box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05); cursor: pointer; *margin-left: .3em; }
			.btn:hover, .btn:active, .btn.active, .btn.disabled, .btn[disabled] { background-color: #e6e6e6; }
			.btn-large { padding: 9px 14px; font-size: 15px; line-height: normal; -webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px; }
			.btn:hover { color: #333333; text-decoration: none; background-color: #e6e6e6; background-position: 0 -15px; -webkit-transition: background-position 0.1s linear; -moz-transition: background-position 0.1s linear; -ms-transition: background-position 0.1s linear; -o-transition: background-position 0.1s linear; transition: background-position 0.1s linear; }
			.btn-primary, .btn-primary:hover { text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25); color: #ffffff; }
			.btn-primary.active { color: rgba(255, 255, 255, 0.75); }
			.btn-primary { background-color: #4a77d4; background-image: -moz-linear-gradient(top, #6eb6de, #4a77d4); background-image: -ms-linear-gradient(top, #6eb6de, #4a77d4); background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#6eb6de), to(#4a77d4)); background-image: -webkit-linear-gradient(top, #6eb6de, #4a77d4); background-image: -o-linear-gradient(top, #6eb6de, #4a77d4); background-image: linear-gradient(top, #6eb6de, #4a77d4); background-repeat: repeat-x; filter: progid:dximagetransform.microsoft.gradient(startColorstr=#6eb6de, endColorstr=#4a77d4, GradientType=0);  border: 1px solid #3762bc; text-shadow: 1px 1px 1px rgba(0,0,0,0.4); box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.5); }
			.btn-primary:hover, .btn-primary:active, .btn-primary.active, .btn-primary.disabled, .btn-primary[disabled] { filter: none; background-color: #4a77d4; }
			.btn-block { width: 100%; display:block; }
			
			* { -webkit-box-sizing:border-box; -moz-box-sizing:border-box; -ms-box-sizing:border-box; -o-box-sizing:border-box; box-sizing:border-box; }
			
			html { width: 100%; height:100%; overflow:hidden; }
			
			body { 
				width: 100%;
				height:100%;
				font-family: 'Open Sans', sans-serif;
				background: #092756;
				background: -moz-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%),-moz-linear-gradient(top,  rgba(57,173,219,.25) 0%, rgba(42,60,87,.4) 100%), -moz-linear-gradient(-45deg,  #670d10 0%, #092756 100%);
				background: -webkit-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%), -webkit-linear-gradient(top,  rgba(57,173,219,.25) 0%,rgba(42,60,87,.4) 100%), -webkit-linear-gradient(-45deg,  #670d10 0%,#092756 100%);
				background: -o-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%), -o-linear-gradient(top,  rgba(57,173,219,.25) 0%,rgba(42,60,87,.4) 100%), -o-linear-gradient(-45deg,  #670d10 0%,#092756 100%);
				background: -ms-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%), -ms-linear-gradient(top,  rgba(57,173,219,.25) 0%,rgba(42,60,87,.4) 100%), -ms-linear-gradient(-45deg,  #670d10 0%,#092756 100%);
				background: -webkit-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%), linear-gradient(to bottom,  rgba(57,173,219,.25) 0%,rgba(42,60,87,.4) 100%), linear-gradient(135deg,  #670d10 0%,#092756 100%);
				filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#3E1D6D', endColorstr='#092756',GradientType=1 );
			}
			.login { 
				position: absolute;
				top: 50%;
				left: 50%;
				margin: -150px 0 0 -150px;
				width:300px;
				height:300px;
			}
			.login h1 { color: #fff; text-shadow: 0 0 10px rgba(0,0,0,0.3); letter-spacing:1px; text-align:center; }
			
			input { 
				width: 100%; 
				margin-bottom: 10px; 
				background: rgba(0,0,0,0.3);
				border: none;
				outline: none;
				padding: 10px;
				font-size: 13px;
				color: #fff;
				text-shadow: 1px 1px 1px rgba(0,0,0,0.3);
				border: 1px solid rgba(0,0,0,0.3);
				border-radius: 4px;
				box-shadow: inset 0 -5px 45px rgba(100,100,100,0.2), 0 1px 1px rgba(255,255,255,0.2);
				-webkit-transition: box-shadow .5s ease;
				-moz-transition: box-shadow .5s ease;
				-o-transition: box-shadow .5s ease;
				-ms-transition: box-shadow .5s ease;
				transition: box-shadow .5s ease;
			}
			input:focus { box-shadow: inset 0 -5px 45px rgba(100,100,100,0.4), 0 1px 1px rgba(255,255,255,0.2);
							border-color: #3276B1 !important; 
			}

			div.ui-dialog-titlebar > span {
				font-size: 14px;
			}
		</style>
	</head>
	
	<!-- <body class="animated jackInTheBox" style="height: 100%;display: table;width: 100%"> -->
	<body class="animated fadeIn" style="height: 100%;display: table;width: 100%">
		<div class="login">
		    <div style="text-align: center;margin-bottom: 15px;">
		      <img src="/rcs/img/ap/login_logo_ap.png" style="text-align: center;"/>
		    </div>
			<!-- <h1 style="margin-bottom: 26px;">Member Login</h1> -->
		    <form:form id="loginPage_form" name="loginPage_form" class="login100-form validate-form" return="false">
		    	<input type="hidden" id="ENC_PASSWORD" name="ENC_PASSWORD"/>
		    	<input type="text" id="u" name="USERID" placeholder="Your Account" required="required" data-validate = "Valid account is required: yourAccount" autocomplete="false">
		    	<input type="password" id="PASSWORD" name="PASSWORD" placeholder="Password" required="required" autocomplete="false">
		        <button type="submit" class="btn btn-primary btn-block btn-large">Login</button>
		        <span style="float: right;"><a href="javascript:oLoginPage.openPasswordInitPopup();"> 비밀번호 초기화 및 변경 </a></span>
		        <span style="float: right;margin-right: 10px;"><a href="javascript:oLoginPage.openAccountLockPopup();"> 잠금해제</a> | </span>
		        <!-- onclick="javascript:oLoginPage.goLogin(); -->
		        <!--<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>-->
		    </form:form>
		</div>
		
		
		<div id="dialog_AccountLock" title="사용자계정 잠금 해제" style="display: none;overflow: hidden;">
			<form id="accountLock-Form" name="accountLock-Form" novalidate="novalidate" class="s4-form" method="post" onsubmit="return false;" autocomplete="off">
				<fieldset style="padding: 0px;">
					<section>
						<label class="label">사용자 ID를 입력 후 인증메일을 발송해주세요</label>
						<label class="input"> <i class="icon-append fa fa-lock"></i>
							<input type="text" id="S_USER_ID" name="S_USER_ID" >
							<b class="tooltip tooltip-top-right"><i class="fa fa-lock txt-color-teal"></i> Enter your user ID</b> </label>
							<button type="button" class="btn btn-primary" style="float: right;margin-top: 5px;" onclick="javascript:oLoginPage.unLockSendMail();">인증메일발송</button>
					</section>
					
					<section style="margin-top: 40px;">
						<label class="label">메일로 수신한 인증코드를 입력해주세요</label>
						<label class="input"> <i class="icon-append fa fa-lock"></i>
							<input type="text" id="LOCK_STR" name="LOCK_STR" disabled="true">
							<b class="tooltip tooltip-top-right"><i class="fa fa-lock txt-color-teal"></i> Enter unlock code</b> </label>
							<button id="BTN_LOCK_STR" type="button" class="btn btn-primary" style="float: right;margin-top: 5px;" onclick="javascript:oLoginPage.doUnlockProcess();" disabled="true">잠금해제</button>
					</section>
				</fieldset>
			</form>
		</div>
		
		<script src="/rcs/js/libs/jquery-2.1.1.min.js"></script>
		<script src="/rcs/js/libs/jquery-ui-1.10.3.min.js"></script>
		<script src="/rcs/js/login/style_01/tilt/tilt.jquery.min.js"></script>
		<script src="/rcs/js/security/encrypt.js"></script>
		<script src="/rcs/js/utils.common.js"></script>
		<script src="/rcs/js/package.common-<%=jsDiv %>.js"></script>
		
		<script type="text/javascript">
			try{
				if(MAINPAGE){
					alert("세션 로그인 정보가 없습니다. 로그인 페이지로 이동합니다.");
					$(location).attr("href", "/loginform");
				}
			}catch(x){}
			
			window.onload = function() {
				if($("#left-panel").length > 0 ){
					alert("세션 로그인 정보가 없습니다. 로그인 페이지로 이동합니다.");
					$(location).attr("href", "/loginform");
				}
				
				var agent = window.navigator.userAgent.toLowerCase();
				
				alert(ddd);
			};

			
			var oLoginPage = new function() {
				this.userDialog = "";
				
				$('#loginPage_form').submit(function(event) {
					event.preventDefault();
					var postData = {
							"USERID" : KpackageOBJ.object.getFormValue("loginPage_form", "USERID")
							,"ENC_PASSWORD" : encryptStr(KpackageOBJ.object.getFormValue("loginPage_form", "PASSWORD")).toString()
					}; 
					
					KpackageOBJ.ajax.doSubmit("/common/retrieveUserCheck", postData, oLoginPage.login, null, false); 
				});
		

				this.login = function(data) {
					if (data.value.LOGIN_CNT > 0) {
						KpackageOBJ.object.setFormValue("loginPage_form"
								, "ENC_PASSWORD"
								, encryptStr(KpackageOBJ.object.getFormValue("loginPage_form", "PASSWORD")).toString());
						
						loginPage_form.action = "/login";
						loginPage_form.submit();
					} else {
						try{
							KpackageOBJ.object.alert("<spring:message code='MSG.LOGIN_FAILED' text='MSG.LOGIN_FAILED'/>");	
						}catch(e){
							alert("<spring:message code='MSG.LOGIN_FAILED' text='MSG.LOGIN_FAILED'/>");
						}
						
						KpackageOBJ.object.setFormValue("loginPage_form", "PASSWORD", "");
					}
				};
				
				this.openPasswordInitPopup = function(){
					if (confirm("패스워드 변경 페이지로 이동하시겠습니까?") ) {
						window.open("https://piam.amorepacific.com/iam/profile/personal/password/");
					}
				}
				
				this.unLockSendMail = function(){
					var postData = KpackageOBJ.data.makePostData("accountLock-Form");
					if(oUtil.isNull(postData["S_USER_ID"])){
						alert("아이디를 입력해주세요");
						return;
					}
					KpackageOBJ.ajax.doSubmit("/common/accountLockCheck", postData, oLoginPage.unLockSendMail_CallbackHandler, null, false); 
				}
				
				this.unLockSendMail_CallbackHandler = function(result){
					alert(result.message);
					if(result.success){
						$("#LOCK_STR").attr("disabled", false);
						$("#BTN_LOCK_STR").attr("disabled", false);
					}
				}
				
				
				this.openAccountLockPopup = function(){
					var getParams = "?DIALOG_ID="           + "dialog_AccountLock";
		         
					if("" == oLoginPage.userDialog){
						oLoginPage.userDialog = $("#dialog_AccountLock").html();
					}
					$("#LOCK_STR").attr("disabled", true);
					$("#BTN_LOCK_STR").attr("disabled", true);
					KpackageOBJ.dialog.open("dialog_AccountLock", " 사용자계정 잠금해제", "", 450, 250, null, true, null, oLoginPage.userDialog);
				}
				
				this.doUnlockProcess = function(){
					var postData = KpackageOBJ.data.makePostData("accountLock-Form");
					if(oUtil.isNull(postData["S_USER_ID"])){
						alert("아이디를 입력해주세요");
						return;
					}
					
					if(oUtil.isNull(postData["LOCK_STR"])){
						alert("인증코드를 입력해주세요");
						return;
					}
					
					KpackageOBJ.ajax.doSubmit("/common/doUnlockProcess", postData, oLoginPage.doUnlockProcess_CallbackHandler, null, false); 
				}
				
				this.doUnlockProcess_CallbackHandler = function(result){
					alert(result.message);
					if(result.success){
						KpackageOBJ.dialog.close("dialog_AccountLock");  
					}
					
				}
				
			};
		</script>

	</body>
</html>