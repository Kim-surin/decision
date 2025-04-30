<%@ page language="java" isErrorPage="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% response.setStatus(200); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Error</title>


	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
	<script type="text/javascript">
	
	$(document).ready(function() {
		$("#btn_showhide_error").on("click", function() {
			if ( $("#dv_error_message_area").is(":visible") ) {
				$("#dv_error_message_area").hide();
				$("#btn_showhide_error").val("상세보기");
			}
			else {
				$("#dv_error_message_area").show();
				$("#btn_showhide_error").val("감추기");
			}
		});
		
		centerIt( $("#dv_main_contents") );
	});
	
	var centerIt = function (el /* (jQuery element) Element to center */) {
	    if (!el) {
	    	return;
	    }
	    var moveIt = function () {
	        var winWidth = $(window).width();
	        var winHeight = $(window).height();
	        el.css("position","absolute").css("left", ((winWidth / 2) - (el.width() / 2)) + "px").css("top", ((winHeight / 2) - (el.height() / 2)) + "px");
	    }; 
	    $(window).resize(moveIt);
	    moveIt();
	};
	
	</script>
</head>
<body>
	<div id="dv_main_contents"
		style="width: 450px; height: 290px; border: 0px solid red;">

		<h3>시스템 오류가 발생하였습니다.</h3>

		<h4>
			원인 : <span style="color: red;">${exception.cause}</span>
		</h4>

		<input type="button" id="btn_showhide_error" value="상세보기" /><br />
		<br />



		<div id="dv_error_contents" style="width: 450px; height: 150px;">
			<div id="dv_error_message_area" style="display: none;">
				<textarea id="ta_error_message_area"
					style="width: 99%; height: 150px;">${exception.message}</textarea>
			</div>

			<div id="dv_error_trace_area" style="display: none;">
				<textarea id="ta_error_trace_area"
					style="width: 90%; height: 150px;">
					<jsp:scriptlet>exception.printStackTrace(new java.io.PrintWriter(out));</jsp:scriptlet>
	    </textarea>
			</div>
		</div>

	</div>
</body>
</html>