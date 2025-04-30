<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
/******************************************************************************************************
	Program Name : 과다환급금 자진신고서 가산금 조회 팝업
	Program Code : DB00902
******************************************************************************************************/
%>
<!DOCTYPE html>
<html>
<head>

	
	
	
	
</head>
<body>
<div id="content">
	<section id="widget-grid-DB00902" class="">
		<form:form id="DB00902-form" class="s4-form" novalidate="novalidate" onsubmit="return false;">
			<input type="hidden" id="SEARCH_PRESENTN_NO" name="SEARCH_PRESENTN_NO" value="${reqParam.SEARCH_PRESENTN_NO }"/>
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 10px;margin-top: 15px;">
					<div id="div_oTui_DB00902_List" name="div_oTui_DB00902_List" class="tuigrid-resizable">
						<div id="oTui_DB00902_List" data-fixed-height="330"></div>
						<!-- <div id="oTui_DB00902_List_paging"></div> -->
					</div>
				</div>
			</div>
		</form:form>
	</section>
</div>

<script type="text/javascript">



	var DB00902 = new function() {
		
		this.initialize_viewObject = function(){}
		
		this.initialize_TuiGrid = function(){
			var colArrayInfo = [
				 
				
				{ header : "환급신청번호"	 	,name : "PRE_REGIST_RCEPT_NO"	,width : 120, align: "center" ,hidden:false },
				{ header : "환급결정액"  	 	,name : "PRE_DRWBAK_AMOUNT"		,width : 100, align: "right"  ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas },
				{ header : "정당환급액"  	 	,name : "PROPER_DRWBAK_AMOUNT"	,width : 100, align: "right"  ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas },
				{ header : "과다환급액"  	 	,name : "OVER_DRWBAK_AMOUNT"	,width : 100, align: "right"  ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas },
				{ header : "환급결정일자" 	,name : "DRWBAK_COMP_DATE"		,width : 100, align: "center" ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
				{ header : "신고일" 			,name : "RCEPT_DATE"			,width : 100, align: "center" ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
				{ header : "기간"  	 		,name : "BALANCE_DAYS"			,width : 100, align: "center" ,hidden:false},
				{ header : "적용이율"  	 	,name : "TAX_RATE"				,width : 100, align: "center" ,hidden:false},
				{ header : "과다환급액"  	 	,name : "TOT_TAX"				,width : 100, align: "right"  ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas }
				
		    ];
		 KpackageOBJ.tuiGrid.create("oTui_DB00902_List", "/drawback/retrieve_DB009002List", colArrayInfo, 'number', DB009.oTui_DB00902_List_onClick_Handler, DB009.oTui_DB00902_List_onDblclick_Handler );
		 
		};
		
		
		
		
		
		
	}

	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB00902.initialize_viewObject();	// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		DB00902.initialize_TuiGrid();		// Toast Grid Render
		
		if("" != KpackageOBJ.object.getFormValue("DB00902-form","SEARCH_PRESENTN_NO")){
			var param = KpackageOBJ.data.makePostData("DB00902-form");  
			KpackageOBJ.tuiGrid.retrieve("oTui_DB00902_List", "", param);
		}
		
		
	});

</script>
	
</body>
</html>