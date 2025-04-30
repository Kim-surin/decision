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
		<title>File Not Found Error Page</title>
		<meta name="description" content="">
		<meta name="author" content="">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		
		
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		
		<!-- #CSS Links -->
		<!-- Basic Styles -->
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/font-awesome.min.css">

		<!-- SmartAdmin Styles : Caution! DO NOT change the order -->
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/s4-production-plugins.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/s4-production.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/rcs/css/s4-skins.min.css">

		<!-- #FAVICONS -->
		<link rel="shortcut icon" href="/rcs/img/favicon/favicon.ico" type="image/x-icon">
		<link rel="icon" href="/rcs/img/favicon/favicon.ico" type="image/x-icon">

		<!-- #GOOGLE FONT -->
		<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,300,400,700">

		<link rel="apple-touch-icon" href="/rcs/img/splash/sptouch-icon-iphone.png">
		<link rel="apple-touch-icon" sizes="76x76" href="/rcs/img/splash/touch-icon-ipad.png">
		<link rel="apple-touch-icon" sizes="120x120" href="/rcs/img/splash/touch-icon-iphone-retina.png">
		<link rel="apple-touch-icon" sizes="152x152" href="/rcs/img/splash/touch-icon-ipad-retina.png">
		
		
		<!-- Startup image for web apps -->
		<link rel="apple-touch-startup-image" href="/rcs/img/splash/ipad-landscape.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)">
		<link rel="apple-touch-startup-image" href="/rcs/img/splash/ipad-portrait.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)">
		<link rel="apple-touch-startup-image" href="/rcs/img/splash/iphone.png" media="screen and (max-device-width: 320px)">
		
		<!-- Custom Css  -->
		<link rel="stylesheet" href="/rcs/css/customize_style.css">
		
<style>
	.error-text-2 {
		text-align: center;
		font-size: 700%;
		font-weight: bold;
		font-weight: 100;
		color: #333;
		line-height: 1;
		letter-spacing: -.05em;
		background-image: -webkit-linear-gradient(92deg,#333,#ed1c24);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
	}
	.particle {
		position: absolute;
		top: 50%;
		left: 50%;
		width: 1rem;
		height: 1rem;
		border-radius: 100%;
		background-color: #ed1c24;
		background-image: -webkit-linear-gradient(rgba(0,0,0,0),rgba(0,0,0,.3) 75%,rgba(0,0,0,0));
		box-shadow: inset 0 0 1px 1px rgba(0,0,0,.25);
	}
	.particle--a {
		-webkit-animation: particle-a 1.4s infinite linear;
		-moz-animation: particle-a 1.4s infinite linear;
		-o-animation: particle-a 1.4s infinite linear;
		animation: particle-a 1.4s infinite linear;
	}
	.particle--b {
		-webkit-animation: particle-b 1.3s infinite linear;
		-moz-animation: particle-b 1.3s infinite linear;
		-o-animation: particle-b 1.3s infinite linear;
		animation: particle-b 1.3s infinite linear;
		background-color: #00A300;
	}
	.particle--c {
		-webkit-animation: particle-c 1.5s infinite linear;
		-moz-animation: particle-c 1.5s infinite linear;
		-o-animation: particle-c 1.5s infinite linear;
		animation: particle-c 1.5s infinite linear;
		background-color: #57889C;
	}@-webkit-keyframes particle-a {
	0% {
	-webkit-transform: translate3D(-3rem,-3rem,0);
	z-index: 1;
	-webkit-animation-timing-function: ease-in-out;
	} 25% {
	width: 1.5rem;
	height: 1.5rem;
	}

	50% {
	-webkit-transform: translate3D(4rem, 3rem, 0);
	opacity: 1;
	z-index: 1;
	-webkit-animation-timing-function: ease-in-out;
	}

	55% {
	z-index: -1;
	}

	75% {
	width: .75rem;
	height: .75rem;
	opacity: .5;
	}

	100% {
	-webkit-transform: translate3D(-3rem,-3rem,0);
	z-index: -1;
	}
	}

	@-moz-keyframes particle-a {
	0% {
	-moz-transform: translate3D(-3rem,-3rem,0);
	z-index: 1;
	-moz-animation-timing-function: ease-in-out;
	}

	25% {
	width: 1.5rem;
	height: 1.5rem;
	}

	50% {
	-moz-transform: translate3D(4rem, 3rem, 0);
	opacity: 1;
	z-index: 1;
	-moz-animation-timing-function: ease-in-out;
	}

	55% {
	z-index: -1;
	}

	75% {
	width: .75rem;
	height: .75rem;
	opacity: .5;
	}

	100% {
	-moz-transform: translate3D(-3rem,-3rem,0);
	z-index: -1;
	}
	}

	@-o-keyframes particle-a {
	0% {
	-o-transform: translate3D(-3rem,-3rem,0);
	z-index: 1;
	-o-animation-timing-function: ease-in-out;
	}

	25% {
	width: 1.5rem;
	height: 1.5rem;
	}

	50% {
	-o-transform: translate3D(4rem, 3rem, 0);
	opacity: 1;
	z-index: 1;
	-o-animation-timing-function: ease-in-out;
	}

	55% {
	z-index: -1;
	}

	75% {
	width: .75rem;
	height: .75rem;
	opacity: .5;
	}

	100% {
	-o-transform: translate3D(-3rem,-3rem,0);
	z-index: -1;
	}
	}

	@keyframes particle-a {
	0% {
	transform: translate3D(-3rem,-3rem,0);
	z-index: 1;
	animation-timing-function: ease-in-out;
	}

	25% {
	width: 1.5rem;
	height: 1.5rem;
	}

	50% {
	transform: translate3D(4rem, 3rem, 0);
	opacity: 1;
	z-index: 1;
	animation-timing-function: ease-in-out;
	}

	55% {
	z-index: -1;
	}

	75% {
	width: .75rem;
	height: .75rem;
	opacity: .5;
	}

	100% {
	transform: translate3D(-3rem,-3rem,0);
	z-index: -1;
	}
	}

	@-webkit-keyframes particle-b {
	0% {
	-webkit-transform: translate3D(3rem,-3rem,0);
	z-index: 1;
	-webkit-animation-timing-function: ease-in-out;
	}

	25% {
	width: 1.5rem;
	height: 1.5rem;
	}

	50% {
	-webkit-transform: translate3D(-3rem, 3.5rem, 0);
	opacity: 1;
	z-index: 1;
	-webkit-animation-timing-function: ease-in-out;
	}

	55% {
	z-index: -1;
	}

	75% {
	width: .5rem;
	height: .5rem;
	opacity: .5;
	}

	100% {
	-webkit-transform: translate3D(3rem,-3rem,0);
	z-index: -1;
	}
	}

	@-moz-keyframes particle-b {
	0% {
	-moz-transform: translate3D(3rem,-3rem,0);
	z-index: 1;
	-moz-animation-timing-function: ease-in-out;
	}

	25% {
	width: 1.5rem;
	height: 1.5rem;
	}

	50% {
	-moz-transform: translate3D(-3rem, 3.5rem, 0);
	opacity: 1;
	z-index: 1;
	-moz-animation-timing-function: ease-in-out;
	}

	55% {
	z-index: -1;
	}

	75% {
	width: .5rem;
	height: .5rem;
	opacity: .5;
	}

	100% {
	-moz-transform: translate3D(3rem,-3rem,0);
	z-index: -1;
	}
	}

	@-o-keyframes particle-b {
	0% {
	-o-transform: translate3D(3rem,-3rem,0);
	z-index: 1;
	-o-animation-timing-function: ease-in-out;
	}

	25% {
	width: 1.5rem;
	height: 1.5rem;
	}

	50% {
	-o-transform: translate3D(-3rem, 3.5rem, 0);
	opacity: 1;
	z-index: 1;
	-o-animation-timing-function: ease-in-out;
	}

	55% {
	z-index: -1;
	}

	75% {
	width: .5rem;
	height: .5rem;
	opacity: .5;
	}

	100% {
	-o-transform: translate3D(3rem,-3rem,0);
	z-index: -1;
	}
	}

	@keyframes particle-b {
	0% {
	transform: translate3D(3rem,-3rem,0);
	z-index: 1;
	animation-timing-function: ease-in-out;
	}

	25% {
	width: 1.5rem;
	height: 1.5rem;
	}

	50% {
	transform: translate3D(-3rem, 3.5rem, 0);
	opacity: 1;
	z-index: 1;
	animation-timing-function: ease-in-out;
	}

	55% {
	z-index: -1;
	}

	75% {
	width: .5rem;
	height: .5rem;
	opacity: .5;
	}

	100% {
	transform: translate3D(3rem,-3rem,0);
	z-index: -1;
	}
	}

	@-webkit-keyframes particle-c {
	0% {
	-webkit-transform: translate3D(-1rem,-3rem,0);
	z-index: 1;
	-webkit-animation-timing-function: ease-in-out;
	}

	25% {
	width: 1.3rem;
	height: 1.3rem;
	}

	50% {
	-webkit-transform: translate3D(2rem, 2.5rem, 0);
	opacity: 1;
	z-index: 1;
	-webkit-animation-timing-function: ease-in-out;
	}

	55% {
	z-index: -1;
	}

	75% {
	width: .5rem;
	height: .5rem;
	opacity: .5;
	}

	100% {
	-webkit-transform: translate3D(-1rem,-3rem,0);
	z-index: -1;
	}
	}

	@-moz-keyframes particle-c {
	0% {
	-moz-transform: translate3D(-1rem,-3rem,0);
	z-index: 1;
	-moz-animation-timing-function: ease-in-out;
	}

	25% {
	width: 1.3rem;
	height: 1.3rem;
	}

	50% {
	-moz-transform: translate3D(2rem, 2.5rem, 0);
	opacity: 1;
	z-index: 1;
	-moz-animation-timing-function: ease-in-out;
	}

	55% {
	z-index: -1;
	}

	75% {
	width: .5rem;
	height: .5rem;
	opacity: .5;
	}

	100% {
	-moz-transform: translate3D(-1rem,-3rem,0);
	z-index: -1;
	}
	}

	@-o-keyframes particle-c {
	0% {
	-o-transform: translate3D(-1rem,-3rem,0);
	z-index: 1;
	-o-animation-timing-function: ease-in-out;
	}

	25% {
	width: 1.3rem;
	height: 1.3rem;
	}

	50% {
	-o-transform: translate3D(2rem, 2.5rem, 0);
	opacity: 1;
	z-index: 1;
	-o-animation-timing-function: ease-in-out;
	}

	55% {
	z-index: -1;
	}

	75% {
	width: .5rem;
	height: .5rem;
	opacity: .5;
	}

	100% {
	-o-transform: translate3D(-1rem,-3rem,0);
	z-index: -1;
	}
	}

	@keyframes particle-c {
	0% {
	transform: translate3D(-1rem,-3rem,0);
	z-index: 1;
	animation-timing-function: ease-in-out;
	}

	25% {
	width: 1.3rem;
	height: 1.3rem;
	}

	50% {
	transform: translate3D(2rem, 2.5rem, 0);
	opacity: 1;
	z-index: 1;
	animation-timing-function: ease-in-out;
	}

	55% {
	z-index: -1;
	}

	75% {
	width: .5rem;
	height: .5rem;
	opacity: .5;
	}

	100% {
	transform: translate3D(-1rem,-3rem,0);
	z-index: -1;
	}
	}
</style>

<!--[if IE 9]>
<style>
.error-text {
	color: #333 !important;
}
.particle {
	display:none;
}
</style>
<![endif]-->

</head>
<!-- row -->
<body class="smart-style-0 menu-on-top">
<div class="row">

	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

		<div class="row" style="margin-top: 150px">
			<div class="col-sm-12">
				<div class="text-center error-box">
					<h1 class="error-text-2 bounceInDown animated"> Error 404 <span class="particle particle--c"></span><span class="particle particle--a"></span><span class="particle particle--b"></span></h1>
					<h2 class="font-xl"><strong><i class="fa fa-fw fa-warning fa-lg text-warning"></i> Page <u>Not</u> Found</strong></h2>
					<br />
					<p class="lead" style="    font-family: Dotum, Gulim, Arial !important">
						죄송합니다. 요청하신 페이지를 찾을 수 없습니다. 관리자에게 문의해주세요.
					</p>
					<ul class="error-search text-left font-md">
			            <li><a href="/#dashBoard"><small>메인화면으로 돌아가기<i class="fa fa-arrow-right"></i></small></a></li>
			            <li><a href="javascript:history.back()"><small>Go back</small></a></li>
			        </ul>
				</div>

			</div>

		</div>

	</div>

	<!-- end row -->

	<script type="text/javascript">


	var pagefunction = function() {
		
	};

	</script>
</div>
</body>
</html>
