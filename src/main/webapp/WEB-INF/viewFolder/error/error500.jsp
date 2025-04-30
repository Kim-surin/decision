<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% response.setStatus(200); %>

<!DOCTYPE html>
<html>	
	<head>
		<meta charset="utf-8">
		<title>Occur Error Page</title>
		<meta name="description" content="">
		<meta name="author" content="">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		
		
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<!-- 
		#CSS Links
		Basic Styles
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/font-awesome.min.css">

		SmartAdmin Styles : Caution! DO NOT change the order
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/s4-production-plugins.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/s4-production.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/s4-skins.min.css">

		#FAVICONS
		<link rel="shortcut icon" href="/rcs/img/favicon/favicon.ico" type="image/x-icon">
		<link rel="icon" href="/rcs/img/favicon/favicon.ico" type="image/x-icon">

		#GOOGLE FONT
		<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,300,400,700">

		<link rel="apple-touch-icon" href="/rcs/img/splash/sptouch-icon-iphone.png">
		<link rel="apple-touch-icon" sizes="76x76" href="/rcs/img/splash/touch-icon-ipad.png">
		<link rel="apple-touch-icon" sizes="120x120" href="/rcs/img/splash/touch-icon-iphone-retina.png">
		<link rel="apple-touch-icon" sizes="152x152" href="/rcs/img/splash/touch-icon-ipad-retina.png">
		
		
		Startup image for web apps
		<link rel="apple-touch-startup-image" href="/rcs/img/splash/ipad-landscape.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)">
		<link rel="apple-touch-startup-image" href="/rcs/img/splash/ipad-portrait.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)">
		<link rel="apple-touch-startup-image" href="/rcs/img/splash/iphone.png" media="screen and (max-device-width: 320px)">
		 -->
		<!-- Custom Css  -->
		<link rel="stylesheet" type="text/css" href="/rcs/css/customize_style.css">
<!--[if IE 9]>
	<style>
		.error-text {
			color: #333 !important;
		}
	</style>
<![endif]-->
</head>
<body class="smart-style-0 menu-on-top">
	<!-- row -->
	<div class="row" style="margin-top: 150px;">
	
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	
			<div class="row">
				<div class="col-sm-12">
					<div class="text-center error-box">
						<h1 class="error-text tada animated"><i class="fa fa-times-circle text-danger error-icon-shadow"></i> Error</h1>
						<h2 class="font-xl"><strong>요청하신 내용을 처리 할 수 없습니다.</strong></h2>
						<br />
						<p class="lead semi-bold">
							<strong>시스템이 사용이 불가능한 상태이거나 잘못된 요청일 수 있습니다.</strong><br><br>
						</p>
						<ul class="error-search text-left font-md">
				            <li><a href="/#dashBoard"><small>메인화면으로 돌아가기<i class="fa fa-arrow-right"></i></small></a></li>
				            <li><a href="javascript:history.back()"><small>Go back</small></a></li>
				        </ul>
					</div>
	
				</div>
	
			</div>
	
		</div>
		
	</div>
	<!-- end row -->

	<script type="text/javascript"></script>

	</body>
	</html>