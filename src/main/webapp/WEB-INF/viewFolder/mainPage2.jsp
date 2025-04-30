<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String ua = request.getHeader("User-Agent");
	String jsDiv = "v2.2";
	if (ua.indexOf("Trident") > 0 || ua.indexOf("MSIE") > 0) {
		jsDiv = "ie";
	}
	 
%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="Robots" content="noindex,nofollow"> 
		<meta charset="utf-8">
		<title>System Name</title>
		<meta name="description" content="">
		<meta name="author" content="">
		<meta name="_csrf" content="${_csrf.token}"/>
  		<meta name="_csrf_header" content="${_csrf.headerName}"/>
		
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		
		<!-- Basic Styles -->
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/dashboard/css/app.bundle.css">
        <link rel="stylesheet" type="text/css" media="screen" href="/rcs/dashboard/css/vendors.bundle.css">

		
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/font-awesome.min.css">

		<!-- s4 Styles : Caution! DO NOT change the order -->
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/s4-production-plugins.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/s4-production.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/s4-skins.min.css">


		<!-- S4 RTL Support -->
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/s4-rtl.min.css"> 

		<!-- #FAVICONS -->
		<link rel="shortcut icon" href="/rcs/img/favicon/favicon.png" type="image/x-icon">
		<link rel="icon" href="/rcs/img/favicon/favicon.png" type="image/x-icon">


		<!-- #APP SCREEN / ICONS -->
		<!-- Specifying a Webpage Icon for Web Clip 
			 Ref: https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html -->
		<link rel="apple-touch-icon" href="/rcs/img/splash/sptouch-icon-iphone.png">
		<link rel="apple-touch-icon" sizes="76x76" href="/rcs/img/splash/touch-icon-ipad.png">
		<link rel="apple-touch-icon" sizes="120x120" href="/rcs/img/splash/touch-icon-iphone-retina.png">
		<link rel="apple-touch-icon" sizes="152x152" href="/rcs/img/splash/touch-icon-ipad-retina.png">
		
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		
		<link rel="apple-touch-startup-image" href="img/splash/ipad-landscape.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)">
		<link rel="apple-touch-startup-image" href="img/splash/ipad-portrait.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)">
		<link rel="apple-touch-startup-image" href="img/splash/iphone.png" media="screen and (max-device-width: 320px)">


		<!-- TOAST UI Styles -->
		<!-- <link rel="stylesheet" type="text/css" href="/rcs/css/tui-grid.css"> -->
		<link rel="stylesheet" type="text/css" href="/rcs/js/tui4x/css/toast/grid/tui-grid-4.17.2.css">
		<link rel="stylesheet" type="text/css" href="/rcs/css/tui-pagination.css">
		<link rel="stylesheet" type="text/css" href="/rcs/css/tui-date-picker.css">
		
		
		<!-- MonthPicker Styles -->
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/js/plugin/monthPicker/MonthPicker.css">

		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/customize_style-v2.0.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/customize_style_Button.css">
		
		<style>
			.gotop {position:fixed; _position:absolute; left:98%; top:92%; width:38px; height:38px; background-color:#777; z-index:3;
				    /* firefox's individual border radius properties */
				    -moz-border-radius:19px;
				    /* webkit's individual border radius properties */
				    -webkit-border-radius:19px;
				    border-radius:19px;
				}
			@media ( max-width :768px) {
				.gotop {position:fixed; _position:absolute; left:90%; top:92%; width:38px; height:38px; background-color:#777; z-index:3;
				    /* firefox's individual border radius properties */
				    -moz-border-radius:19px;
				    /* webkit's individual border radius properties */
				    -webkit-border-radius:19px;
				    border-radius:19px;
				}
			}
			.gotop div {z-index:4; display:block; position:relative; width:38px; height:38px; background:url("/rcs/img/top_arrow.png") no-repeat 7px 10px;}
		</style>
		
	</head>

	<body class="smart-style-0">

		<header id="header">
			<div id="gotop" class="gotop" style="display: block; background-color: rgb(153, 153, 153); height: 38px;"><div></div></div>
			<div id="logo-group">
				<span id="logo"> <img src="/rcs/img/ap/login_logo_ap.png"  alt="AP DRWB"></span>
				<span id="logo"> </span>
			</div>
			<div id="dialog-pwd-chg" title="비밀번호 변경" style="display: none;">
				<form id="MAINPAGE-USER-FORM" name="MAINPAGE-USER-FORM" novalidate="novalidate" class="s4-form" method="post" onsubmit="return false;" autocomplete="off">
					<div class="row">
						<fieldset style="padding: 25px 0px 0px;">
							<section style="padding-left: 10px; padding-right: 10px;">
								<label class="label">현재 패스워드(Current Password)</label>
								<label class="input"> <i class="icon-append fa fa-lock"></i>
									<input type="password" id="CURRENT_PWD" name="CURRENT_PWD" >
									<b class="tooltip tooltip-top-right"><i class="fa fa-lock txt-color-teal"></i> Enter your password</b> </label>
							</section>
							<section style="padding-left: 10px; padding-right: 10px;">
								<label class="label">새 패스워드(New Password)</label>
								<label class="input"> <i class="icon-append fa fa-lock"></i>
									<input type="password" id="NEW_PWD" name="NEW_PWD" >
									<b class="tooltip tooltip-top-right"><i class="fa fa-lock txt-color-teal"></i> Enter your new password</b> </label>
									
									<div class="note"><strong></strong>
									<c:if test="${sessionScope._sessionUser.AUTHOR_GROUP_CODE eq 'KDP'}">
									(Your password must be at least 8 characters and not exceed 15 characters with a mix of capital and lower-case letters, numbers and symbols.)</div>
									</c:if>
									<c:if test="${sessionScope._sessionUser.AUTHOR_GROUP_CODE ne 'KDP'}">
									영문 대/소문자, 숫자 및 특수문자 조합 비밀번호 8자리이상 15자리 이하로 작성
									</c:if>
							</section>
							<section style="padding-left: 10px; padding-right: 10px;">
								<label class="label">새 패스워드 확인(New Password Confrim)</label>
								<label class="input"> <i class="icon-append fa fa-lock"></i>
									<input type="password" id="NEW_PWD_CONNFIRM" name="NEW_PWD_CONNFIRM" >
									<b class="tooltip tooltip-top-right"><i class="fa fa-lock txt-color-teal"></i> Confirm new password</b> </label>
							</section>
							<footer>
								<button type="button" class="btn btn-primary" onclick="javascript:MAINPAGE.updateUserPwd();">Save</button>
							</footer>
						</fieldset>
					</div>
				</form>
			</div>
			<div class="project-context hidden-xs"></div>
			<!-- 우측 상단 기능 버튼 -->
			<div class="pull-right">
				<!-- 로그아웃 -->
				<div id="logout" class="btn-header transparent pull-right">
					<span> <a href="/logout" title="Sign Out" data-action="userLogout" data-logout-msg="로그아웃 하시려면 Yes 버튼을 눌러 안전하게 로그아웃 하실 수 있습니다."><i class="fa fa-sign-out" style="margin-top: 4px"></i></a> </span>
				</div>
				<!-- 메뉴 숨기기 -->
				<div id="hide-menu" class="btn-header pull-right">
					<span> <a href="javascript:void(0);" data-action="toggleMenu" title="Collapse Menu"><i class="fa fa-reorder" style="margin-top: 4px"></i></a> </span>
				</div>
				<!-- 위젯 초기화 -->
				<!-- 
				<div class="btn-header transparent pull-right hidden-mobile hidden-md hidden-sm" >
					<span id="refresh" >
						<a href="javascript:void(0);" data-action="resetWidgets" data-title="refresh" rel="tooltip" data-placement="bottom" data-original-title="<i class='text-warning fa fa-warning'></i> Warning! This will reset all your widget settings." data-html="true" data-reset-msg="Would you like to RESET all your saved widgets and clear LocalStorage?">
							<i class="fa fa-refresh" style="margin-top: 4px"></i>
						</a>
					</span>
				</div>
				 -->
				<!-- 전체화면 -->
				<div id="fullscreen" class="btn-header transparent pull-right">
					<span> <a href="javascript:void(0);" data-action="launchFullscreen" title="Full Screen"><i class="fa fa-arrows-alt" style="margin-top: 4px;"></i></a> </span>
				</div>

			</div>

		</header>

		<aside id="left-panel" class="bg-brand-gradient">

			<div class="login-info">
				<span> 
					<a href="javascript:void(0);" id="show-shortcut" data-action="toggleShortcut">
						<span><c:out value="${sessionScope._sessionUser.USER_NAME}" />(<c:out value="${sessionScope._sessionUser.USER_ID}" />)</span> 
						<!-- <i class="fa fa-angle-down"></i> -->
					</a> 
					<span class="minifyme" data-action="minifyMenu"> <i class="fa fa-arrow-circle-left hit" style="margin-top: 0px;"></i> </span>	
				</span>
			</div>
			<nav>
				<ul>
					<li class="">
						<a href="/dashBoard" title="Dashboard"><i class="fa fa-lg fa-fw fa-home"></i> <span class="menu-item-parent">Dashboard</span></a>
					</li>
					<c:forEach items="${sideMenuList}" var="item" varStatus="status">
					<li class="top-menu-invisible">
						<a href="#"><i class="fa fa-lg fa-fw <c:out value="${item.MENU_SE }"/>"></i> <span class="menu-item-parent"><c:out value="${item.MENU_NAME }"/></span></a>
						<c:set var="SUB_MENU" value="${item.SUB_MENU }"/>
						<c:if test="${fn:length(SUB_MENU) gt 0}">
						<ul>
						<c:forEach items="${SUB_MENU}" var="subItem">
							<li class="">
								<a href='<c:out value="${subItem.LINK_URL }"/>'> <span class="menu-item-parent"><c:out value="${subItem.MENU_NAME }"/></span></a>
							</li>
						</c:forEach>
						</c:if>
						</ul>
					</li>
					</c:forEach>
					
					
				</ul>
			</nav>
		</aside>
		
		<!-- #MAIN PANEL -->
		<div id="main" role="main">

			<!-- RIBBON -->
			<div id="ribbon">

				<span class="ribbon-button-alignment"> 
					<span id="refresh" class="btn btn-ribbon" data-action="resetWidgets" data-title="refresh" rel="tooltip" data-placement="bottom" data-original-title="<i class='text-warning fa fa-warning'></i> Warning! This will reset all your widget settings." data-html="true" data-reset-msg="Would you like to RESET all your saved widgets and clear LocalStorage?"><i class="fa fa-refresh"></i></span> 
				</span>

				<!-- breadcrumb -->
				<ol class="breadcrumb">
					<!-- This is auto generated -->
				</ol>
				<!-- end breadcrumb -->

			</div>
			<!-- END RIBBON -->

			<!-- #MAIN CONTENT -->
			<div id="content"></div>
			
			<!-- END #MAIN CONTENT -->

		</div>

		<!-- #PAGE FOOTER -->
		<div class="page-footer">
			<div class="row">
				<div class="col-xs-12 col-sm-6"></div>

				<div class="col-xs-6 col-sm-6 text-right hidden-xs">
					<div class="txt-color-white inline-block">
						<span class="txt-color-white" style="font-size: 11px;">Create By <span class="hidden-xs"> KPMG </span> © 2018</span>
						<!-- end btn-group-->
					</div>
					<!-- end div-->
				</div>
				<!-- end col -->
			</div>
			<!-- end row -->
		</div>
		
		
		
		<!-- END FOOTER -->


		<!--================================================== -->

		<!-- PACE LOADER - turn this on if you want ajax loading to show (caution: uses lots of memory on iDevices)
		<script data-pace-options='{ "restartOnRequestAfter": true }' src="/rcs/js/plugin/pace/pace.min.js"></script>-->


		<!-- #PLUGINS -->
		<!-- Link to Google CDN's jQuery + jQueryUI; fall back to local -->
		<script src="/rcs/js/libs/jquery-2.1.1.min.js"></script>
		<script>
			if (!window.jQuery) {
				document.write('<script src="/rcs/js/libs/jquery-2.1.1.min.js"><\/script>');
			}
		</script>

		<script src="/rcs/js/libs/jquery-ui-1.10.3.min.js"></script>
		<script src="/rcs/js/libs/jquery.form.js"></script>
 
		<script>
			if (!window.jQuery.ui) {
				document.write('<script src="/rcs/js/libs/jquery-ui-1.10.3.min.js"><\/script>');
			}
		</script>
		
		
		<!-- TOAST UI JS -->
		<script src="/rcs/js/underscore/underscore.js"></script>
		<script src="/rcs/js/backbone/backbone.js"></script>
		<script src="/rcs/js/jquery.mockjax.min.js"></script>
		<script src="/rcs/js/tui-code-snippet/tui-code-snippet.js"></script>
		<script src="/rcs/js/tui-pagination/tui-pagination.js"></script>
		<script src="/rcs/js/tui-date-picker/tui-date-picker.js"></script>
		<!-- <script src="/rcs/js/tui-grid/tui-grid.js"></script> -->
		
		<script src="/rcs/js/tui4x/js/plug-in/toast/grid/xlsx.full.min.js"></script><!-- Excel plugin -->
		<script src="/rcs/js/tui4x/js/plug-in/toast/grid/tui-grid-4.21.2.js"></script>

		<script src="/rcs/js/app.config.js"></script>
		<script src="/rcs/js/plugin/jquery-touch/jquery.ui.touch-punch.min.js"></script> 
		<script src="/rcs/js/bootstrap/bootstrap-s4-custom-v1.0.js"></script>
		<script src="/rcs/js/notification/SmartNotification.min.js"></script>
		<script src="/rcs/js/smartwidgets/jarvis.widget.min.js"></script>
		<script src="/rcs/js/plugin/easy-pie-chart/jquery.easy-pie-chart.min.js"></script>
		<script src="/rcs/js/plugin/sparkline/jquery.sparkline.min.js"></script>
		<script src="/rcs/js/plugin/jquery-validate/jquery.validate.min.js"></script>
		<script src="/rcs/js/plugin/masked-input/jquery.maskedinput.min.js"></script>
		<script src="/rcs/js/plugin/select2/select2.min.js"></script>
		<script src="/rcs/js/plugin/bootstrap-slider/bootstrap-slider.min.js"></script>
		<script src="/rcs/js/plugin/msie-fix/jquery.mb.browser.min.js"></script>
		<script src="/rcs/js/plugin/fastclick/fastclick.min.js"></script>

		<!--[if IE 8]>
			<h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>
		<![endif]-->

		<script src="/rcs/js/app.min.js"></script>
		<script src="/rcs/js/speech/voicecommand.min.js"></script>
		<script src="/rcs/js/smart-chat-ui/smart.chat.ui.min.js"></script>
		<script src="/rcs/js/smart-chat-ui/smart.chat.manager.min.js"></script>
		

		<script src="/rcs/js/jquery.paging.s4.customize.js"></script>		
		
		<!-- inputMask -->
		<script type="text/javascript" src="/rcs/js/plugin/inputmask/inputmask.js"></script>
		<script type="text/javascript" src="/rcs/js/plugin/inputmask/inputmask.date.extensions.js"></script>
		<script type="text/javascript" src="/rcs/js/plugin/inputmask/jquery.inputmask.js"></script>
		
    	<!-- bootStrap Confirm -->
    	<script src="/rcs/js/plugin/bootbox.min.js"></script>
    	
		<!-- Custom Common JS -->
		<script src="/rcs/js/plugin/monthPicker/MonthPicker.js"></script>
		
		<script src="/rcs/js/security/encrypt.js"></script>
		<script src="/rcs/js/utils.common.js"></script>
		<script src="/rcs/js/package.common-<%=jsDiv %>.js"></script>
		
		<script type="text/javascript">
		/* Toast Grid resize Event Code */
			$(window).bind('resize', function() {
				
				$(".tuigrid-resizable").children().each(function(){ 
					try{
						var tgt;
						if(KpackageOBJ.prototype.regexp_notPaging.test($(this).attr("id"))){
							tgt = KpackageOBJ.tuiGrid.getGrid($(this).attr("id"));
							if(tgt != null && $(this).data("fixedHeight") == undefined){
								tgt.setBodyHeight($(window).height()-$(this).data("minusHeight") || $(window).height() - KpackageOBJ.prototype.minusHeight);
							}else if(tgt != null && $(this).data("fixedHeight") != undefined){
								tgt.setBodyHeight($(this).data("fixedHeight"));	
							}
							
						}
					}catch(e){
						
					}
					
				});
				$("#left-panel").css("height", $("#main").height()+40);
			}).trigger('resize');

		
		</script>
		<script type="text/javascript">
		var userDialog = "";
		var MAINPAGE = new function(){
	
			this.updateUserPwd = function(){
				var param = KpackageOBJ.data.makePostData("MAINPAGE-USER-FORM");
 				var tmp_NEW_PWD_CONNFIRM = param.NEW_PWD_CONNFIRM;
				var tmp_NEW_PWD = param.NEW_PWD;
				var tmp_CURRENT_PWD = param.CURRENT_PWD;
				//영문 대/소문자, 숫자 및 특수문자 조합 비밀번호 8자리이상 15자리
				var regex = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/gm;
					
				if(oUtil.isNull(tmp_CURRENT_PWD)){
					KpackageOBJ.object.alert("현재 패스워드를 입력해주세요");
					return;
				}
				if(oUtil.isNull(tmp_NEW_PWD)){
					KpackageOBJ.object.alert("새로운 패스워드를 입력해주세요");
					return;
				}
				if(!regex.test(tmp_NEW_PWD)){
					KpackageOBJ.object.alert("패스워드 작성 규칙을 확인해주세요");
					return;
				}
				if(oUtil.isNull(tmp_NEW_PWD_CONNFIRM)){
					KpackageOBJ.object.alert("새 패스워드 확인을 입력해주세요 ");
					return;
				}
				
				if(tmp_NEW_PWD_CONNFIRM != tmp_NEW_PWD){
					KpackageOBJ.object.alert("새 패스워드와 새 패스워드 확인이 일치하지 않습니다.");
					return;
				}
				
				param["NEW_PWD_CONNFIRM"] = encryptStr(param["NEW_PWD_CONNFIRM"]).toString();
				param["CURRENT_PWD"] = encryptStr(param["tmp_CURRENT_PWD"]).toString();
				KpackageOBJ.ajax.doSubmit("/common/updateUserPwd", param, MAINPAGE.updateUserPwd_Callback); 
			}
			
			this.updateUserPwd_Callback = function(result){
				
				if(result.success){
					KpackageOBJ.dialog.close("dialog-pwd-chg");
					alert("사용자 정보가 수정되었습니다. 다시 로그인해주세요");
					location.href = "/logout";					
				}else{
					alert(result.message);
				}
				
				
			}
		}
		/* csrf 보완 코드 */
		$.ajaxSetup({
		    headers: {
		        "${_csrf.headerName}": "${_csrf.token}"
		    }
		});
		</script>

	</body>



 
<script>
$(function(){
    /*스크롤 탑*/
    $("div.gotop").fadeOut("slow");
     
    $(window).scroll(function(){
        setTimeout(scroll_top, 300);//화살표가 반응하여 생기는 시간
    });

    $(".gotop").hover(function(){
        //$(this).css("background-color","#307ad5");
    }, function(){
        $(this).css("background-color","#999");
        scroll_top()
    })
    $("#gotop").click(function(){
        $("html, body").animate({ scrollTop: 0 }, 600);//화살표 클릭시 화면 스크롤 속도
            return false;
    });
})
 
	/*스크롤 탑*/
	function scroll_top(){
	    if($(window).scrollTop()<=1) {
	        $("#gotop").fadeOut("slow");
	    }
	    else {
	        $("#gotop").fadeIn("slow");
	    }
	}
	
$(document).ready(function() {
	if("Y" == "${sessionScope._sessionUser.PWD_3MONTH_YN}" || "Y" == "${sessionScope._sessionUser.PWD_INIT_YN}"){
		alert("패스워드가 초기화 되었거나 패스워드 변경이후 3개월이 초과되었습니다. 변경 후 사용하실 수 있습니다.");
		
		if (confirm("패스워드 변경 페이지로 이동하시겠습니까?") ) {
			window.open("https://piam.amorepacific.com/iam/profile/personal/password/");
		}
		
	}else{
		if(7 >= "${sessionScope._sessionUser.PWD_CHG_REQ_CNT}"){
			alert("패스워드 만료까지 ${sessionScope._sessionUser.PWD_CHG_REQ_CNT}일 남았습니다. 패스워드를 변경해 주세요");
		}
		
	}
});
</script>

</html>