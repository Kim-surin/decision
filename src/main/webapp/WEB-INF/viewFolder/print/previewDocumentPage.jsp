<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
</head>
<body>
<div id="content">
	<section id="dialog-widget-grid" class="">
		<form id="oPrintForm" class="smart-form" novalidate="novalidate">
			<div class="row-extends row">
				<div style="height: 680px; width:1000px;">
                    <iframe name="previewFrame" id="previewFrame" width="99%" style="margin-left: 5px;"></iframe>
                </div>
			</div>
		</form>
		<form id="reportFrame_Form" name="reportFrame_Form" method="post">
		    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <input type="hidden" name="_csrf_header" value="${_csrf.headerName}"/>
			<input type="hidden" id="REPORT_FILE_TYPE" 	name="REPORT_FILE_TYPE" 	value="pdf"/>
	        <input type="hidden" id="REPORT_TYPE" 		name="REPORT_TYPE" 			value="pdf"/>   
	        <input type="hidden" id="KEY_PARAM1"        name="KEY_PARAM1"			value="${reqParam.KEY_PARAM1 }"/>
	        <input type="hidden" id="KEY_PARAM2"        name="KEY_PARAM2"			value="${reqParam.KEY_PARAM2 }"/>
	        <input type="hidden" id="KEY_PARAM3"        name="KEY_PARAM3"			value="${reqParam.KEY_PARAM3 }"/>
	        <input type="hidden" id="KEY_PARAM4"        name="KEY_PARAM4"			value="${reqParam.KEY_PARAM4 }"/>
	        <input type="hidden" id="KEY_PARAM5"        name="KEY_PARAM5"			value="${reqParam.KEY_PARAM5 }"/>
	        <input type="hidden" id="P_FORM_ID"			name="P_FORM_ID" 			value="${reqParam.FORM_ID }"/>
	        <input type="hidden" id="P_FORM_YYYYMMDD"	name="P_FORM_YYYYMMDD"		value="${reqParam.FORM_YYYYMMDD }"/>
	        <input type="hidden" id="P_DIRECT_DOWNLOAD"	name="P_DIRECT_DOWNLOAD"	value="${reqParam.P_DIRECT_DOWNLOAD }"/>
		</form>		
	</section><!-- section id="widget-grid"  End -->
</div> <!-- Contents Div End -->

<script>
	
	
	var oPreviewDocumentPage = new function(){

		// Page Object Initialize
		this.Initialize_viewObject = function() {
			
			oPreviewDocumentPage.previewPrint();
		}
		
		
		this.previewPrint = function() {
			var height_size = $(window).height();
			
			$("#previewFrame").css("height", height_size+"px");
			$("#reportFrame_Form").prop("target", "previewFrame");
			$('#reportFrame_Form').prop('action','/thirdParty_ReportApplication');
			$('#reportFrame_Form').submit();
			
		}
	}
	
	$(document).ready(function() {
		pageSetUp();										// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		oPreviewDocumentPage.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
	});
	

</script>

</body>
</html>								