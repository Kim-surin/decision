<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>Total Service v2.0</title>
		<meta name="description" content="Page Description">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, maximum-scale=5">
		<meta name="mobile-web-app-capable" content="yes">
		<!-- Remove Tap Highlight on Windows Phone IE -->
		<meta name="msapplication-tap-highlight" content="no">
		
		<meta name="_csrf" content="${_csrf.token}"/>
  		<meta name="_csrf_header" content="${_csrf.headerName}"/>
  				
		<!-- Vendor css -->
		<link rel="stylesheet" media="screen, print" href="/rcs/ui5x/css/bootstrap.css">
		<link rel="stylesheet" media="screen, print" href="/rcs/ui5x/css/waves.css">
		<!-- Base css -->
		<link rel="stylesheet" media="screen, print" href="/rcs/ui5x/css/smartapp.css">
		<link rel="stylesheet" media="screen, print" href="/rcs/ui5x/css/sa-icons.css">
		<!-- Page specific CSS -->
		
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/customize_style-v2.1.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/customize_style_Button.css">
		
		<!-- AUIGrid CSS -->
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/auigrid/AUIGrid_gts_style.css">
		
		
		<style>
			.primary-nav ul ul::before {
				content: "";
				position: absolute;
				border-left: 0px dashed var(--app-nav-border-color);
				display: block;
				top: 0;
				bottom: 0;
				left: 0.0rem;
				z-index: 1;
			}
			.app-content {
				padding : 10px 10px 5px 15px;
				display: initial;
			}
			.align-items-stretch div div.p-3 {
				padding: 0.6rem !important;
			}
			
			/* Common css */
			.p_rem-0.3{
				padding: 0.3rem !important;
			}
			
			/* Header Tab css*/
			.nav-tabs-clean .nav-item.active {
			    border-bottom: 1px solid var(--primary-500) !important;
			    color: var(--primary-500);
			    font-weight: 500;
			    border-width: 2px !important;
			}
			#mainPage_tab .nav-item .nav-link.active {
			    border-bottom: none !important;
			}
			
			
			.tui-grid-layer-state {
			    z-index: 9;
			}
			
			.tui-grid-border-line {
			    z-index: 9;
			}
			
		</style>
	</head>
	<body>
		<div class="app-wrap">
		    <header class="app-header" style="height: 40px;">
		        <div class="d-flex flex-grow-1 w-100 me-auto align-items-center">
		            <!-- logo -->
		            <div class="app-logo flex-shrink-0">
		                <img src="/rcs/img/kpmg_logo.svg#custom-logo.svg">
		            </div>
		            <!-- Collapse icon -->
		            <button class="collapse-icon me-3 d-none d-lg-inline-flex d-xl-inline-flex d-xxl-inline-flex" data-action="toggle" data-class="set-nav-minified" aria-label="Toggle Navigation Size">
		                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 5 8">
		                    <polygon fill="#878787" points="4.5,1 3.8,0.2 0,4 3.8,7.8 4.5,7 1.5,4" />
		                </svg>
		            </button>
		        </div>
		        <!-- Profile -->
		        <button type="button" data-bs-toggle="dropdown" title="drlantern@gotbootstrap.com" class="btn-system bg-transparent d-flex flex-shrink-0 align-items-center justify-content-center" aria-label="Open Profile Dropdown">
		            <img src="/rcs/ui5x/img/avatar-m.png" class="profile-image profile-image-md rounded-circle" alt="Sunny A.">
		        </button>
		        <!-- Profile dropdown START -->
		        <div class="dropdown-menu dropdown-menu-animated">
		            <div class="notification-header rounded-top mb-2">
		                <div class="d-flex flex-row align-items-center mt-1 mb-1 color-white">
		                    <div class="info-card-text">
		                        <div class="fs-lg text-truncate text-truncate-lg">사용자이름</div>
		                        <span class="text-truncate text-truncate-md opacity-80 fs-sm">권한종류</span>
		                    </div>
		                </div>
		            </div>
		            <div class="dropdown-divider m-0"></div>
		            <a href="#" class="dropdown-item d-flex justify-content-between align-items-center" data-action="app-fullscreen" aria-pressed="false">
		                <span data-i18n="drpdwn.fullscreen">Fullscreen</span>
		                <b class="text-muted fs-nano px-2 rounded font-monospace align-self-center border">F11</b>
		            </a>
		            <div class="dropdown-multilevel dropdown-multilevel-left">
		                <div class="dropdown-item d-flex justify-content-between align-items-center">
		                    <span data-i18n="drpdwn.language">Language</span>
		                    <i class="sa sa-chevron-right"></i>
		                </div>
		                <div class="dropdown-menu">
		                    <a href="#?lang=fr" class="dropdown-item" data-action="lang" data-lang="fr">Français</a>
		                    <a href="#?lang=en" class="dropdown-item selected" data-action="lang" data-lang="en">English (US)</a>
		                    <a href="#?lang=es" class="dropdown-item" data-action="lang" data-lang="es">Español</a>
		                    <a href="#?lang=ru" class="dropdown-item" data-action="lang" data-lang="ru">Русский язык</a>
		                    <a href="#?lang=jp" class="dropdown-item" data-action="lang" data-lang="jp">日本語</a>
		                    <a href="#?lang=ch" class="dropdown-item" data-action="lang" data-lang="ch">中文</a>
		                </div>
		            </div>
		            <div class="dropdown-divider m-0"></div>
		            <a class="dropdown-item py-3 fw-500 d-flex justify-content-between" href="/logout">
		                <span class="text-danger" data-i18n="drpdwn.page-logout">Logout</span>
		            </a>
		        </div>
		        <!-- Profile dropdown END -->
		    </header>
			<header class="app-header" style="height: 47px;margin-top: 40px;">
				<div class="profile-page-nav" style="margin-left: 288px;,overflow: hidden;">
				    <ul id="mainPage_tab" class="nav nav-tabs-clean" role="tablist" style="height: 45px;">
				    <!-- 
				        <li class="nav-item active" role="presentation">
				            <a class="nav-link " href="javascript:MAINPAGE.tabChange('cont_')" data-bs-toggle="tab" aria-selected="false" role="tab" tabindex="-1" style="float: left;">AboutAboutAboutAboutAbout </a>
				            <a class="nav-link " href="javascript:MAINPAGE.tabClose('cont_')" data-bs-toggle="tab" aria-selected="false" role="tab" tabindex="-1" style="padding: 0px;padding-right: 2px;">x</a>
				        </li>
				        <li class="nav-item" role="presentation">
				            <a class="nav-link " href="#profile-about" data-bs-toggle="tab" aria-selected="false" role="tab" tabindex="-1" style="float: left;">Aboud </a>
				            <a class="nav-link " href="#profile-news" data-bs-toggle="tab" aria-selected="false" role="tab" tabindex="-1" style="padding: 0px;padding-right: 2px;">x</a>
				        </li>
				         -->				        
				    </ul>
				</div>
		    </header>
		    <aside class="app-sidebar d-flex flex-column">
		        <div class="app-logo flex-shrink-0">
		            <svg class="custom-logo">
		                <use href="/rcs/ui5x/img/app-logo.svg#custom-logo"></use>
		            </svg>
		            <div class="logo-backdrop"></div>
		        </div>
		        <nav id="js-primary-nav" class="primary-nav flex-grow-1 custom-scroll">
		        	<%/* 메뉴구성 시작 */ %>
		            <ul id="js-nav-menu" class="nav-menu">
		            	<li class="nav-item active">
		            		 <a id="nav_dashBoard" href="#/dashBoard" title="Dashboard" >
		                        <svg class="sa-icon">
		                            <use href="/rcs/ui5x/img/sprite.svg#monitor"></use>
		                        </svg>
		                        <span class="nav-link-text" data-i18n="">Dashboard</span>
		                    </a>
		            	</li>
		            	<li class="nav-item ">
		            		 <a id="nav_sample-000" href="#/sample-000" title="sample-000" >
		                        <svg class="sa-icon">
		                            <use href="/rcs/ui5x/img/sprite.svg#monitor"></use>
		                        </svg>
		                        <span class="nav-link-text" data-i18n="">sample-000</span>
		                    </a>
		            	</li>
		            	<li class="nav-item">
		            		 <a id="nav_sample-001" href="#/sample-001" title="sample-001" >
		                        <svg class="sa-icon">
		                            <use href="/rcs/ui5x/img/sprite.svg#monitor"></use>
		                        </svg>
		                        <span class="nav-link-text" data-i18n="">sample-001</span>
		                    </a>
		            	</li>
		            	
		            	
		            	<c:forEach items="${sideMenuList}" var="item" varStatus="status">
		            	<li class="nav-item">
		            		<a id="nav_${item.id }" href="${item.link_url }" title="${item.text }" data-menu-id="${item.id }" data-menu-title="${item.text }">
		                        <svg class="sa-icon">
		                            <use href="/rcs/ui5x/img/sprite.svg#layers"></use>
		                        </svg>
		                        <span class="nav-link-text" data-i18n="">${item.text }</span>
		                    </a>
		                    <c:set var="SUB_MENU" value="${item.SUB_MENU }"/>
		                    <c:if test="${fn:length(SUB_MENU) gt 0}">
		                    <ul>
		                    	<c:forEach items="${SUB_MENU}" var="subItem">
		                    	<li class="">
		                    		<a id="nav_${subItem.id }" href="${subItem.link_url }" title="${subItem.text }"  data-menu-id="${subItem.id }" data-menu-title="${subItem.text }">
		                                <span class="nav-link-text" data-i18n="">${subItem.text }</span>
		                            </a>
		                            <!-- LV 3 -->
		                            <c:set var="S_SUB_MENU" value="${subItem.SUB_MENU }"/>
				                    <c:if test="${fn:length(S_SUB_MENU) gt 0}">
				                    <ul>
				                    	<c:forEach items="${S_SUB_MENU}" var="s_subItem">
				                    	<li class="">
				                    		<a id="nav_${s_subItem.id }" href="${s_subItem.link_url }" title="${s_subItem.text }" data-menu-id="${s_subItem.id }" data-menu-title="${s_subItem.text }">
				                                <span class="nav-link-text" data-i18n="">${s_subItem.text }</span>
				                            </a>
				                    	</li>
				                    	</c:forEach>
				                    </ul>
				                    </c:if>
		                    	</li>
		                    	</c:forEach>
		                    </ul>
		                    </c:if>
		            	</li>
		            	</c:forEach>
		            </ul>
		            <%/* 메뉴구성 종료 */ %>
		        </nav>
		        <div class="nav-footer">
		            
		        </div>
		    </aside>
		    
		    <main class="app-body">
		    	<!-- Contents Area Start -->
		        <div id="contents" class="app-content"></div>
		        <!-- Contents Area end -->
		        
		    </main>
		</div>
		
		<div id="backdropDiv_Area"></div>


	
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



		
		
        <!-- Core scripts -->
        <script src="/rcs/ui5x/scripts/smartApp.js"></script>
        <script src="/rcs/ui5x/scripts/smartNavigation.js"></script>
        <script src="/rcs/ui5x/scripts/smartFilter.js"></script>
        <script src="/rcs/ui5x/scripts/bootstrap.bundle.js"></script>
        <!-- Dependable scripts -->
        <script src="/rcs/ui5x/scripts/sortable.js"></script>
        <!-- Optional scripts -->
        <script src="/rcs/ui5x/scripts/smartSlimscroll.js"></script>
        <script src="/rcs/ui5x/scripts/waves.js"></script>
        <!-- Page Specific scripts -->
        <script src="/rcs/ui5x/scripts/sortable.js"></script>
        
        
        


		<!--[if IE 8]>
			<h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>
		<![endif]-->

		<script src="/rcs/js/jquery.paging.s4.customize.js"></script>		
		
		<!-- inputMask -->
		<script type="text/javascript" src="/rcs/js/plugin/inputmask/inputmask.js"></script>
		<script type="text/javascript" src="/rcs/js/plugin/inputmask/inputmask.date.extensions.js"></script>
		<script type="text/javascript" src="/rcs/js/plugin/inputmask/jquery.inputmask.js"></script>
		
    	<!-- bootStrap Confirm -->
    	<script src="/rcs/js/plugin/bootbox.min.js"></script>
    	
		<!-- Custom Common JS -->
		<script src="/rcs/js/plugin/monthPicker/MonthPicker.js"></script>
		
		<!-- 미니차트 -->
		<script src="/rcs/js/plugin/perityChart/perityChar-v3.3.0.js"></script>
	
		<script src="/rcs/js/security/encrypt.js"></script>
		<script src="/rcs/js/utils.common.js"></script>
		<script src="/rcs/js/package.common-v2.3.js"></script>
		
				
				    <!-- AUIGrid JS -->
		<!-- <script src="/rcs/js/plugin/auigrid/AUIGridLicense.js"></script>
		<script src="/rcs/js/plugin/auigrid/AUIGrid.js"></script> -->
		<script type="text/javascript" src="/rcs/auigrid/AUIGridLicense.js"></script>
		<script type="text/javascript" src="/rcs/auigrid/AUIGrid.js"></script>
		<script type="text/javascript" src="/rcs/auigrid/FileSaver.js"></script>
		
		
		
		

	</body>
	<script type="text/javascript">
	var MAINPAGE = new function(){

		
	};
	$(document).ready(function() {
	    checkURL();
	});
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
	/* csrf 보완 코드 */
	$.ajaxSetup({
	    headers: {
	        "${_csrf.headerName}": "${_csrf.token}"
	    }
	});
	
	
	
	</script>

</html>