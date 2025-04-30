<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	/**********************************************************************************************
	* PGM ID : DB011
	* PGM DESC : 제증명서 정정 취하 승인신청
	* Remark : 
	*
	**********************************************************************************************/

%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="content">
	<section id="widget-grid-DB011" class="">
		<form:form id="DB011-form" class="s4-form" novalidate="novalidate" action="/db-002" method="post">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 100px;" />
								<col style="width: 22%;" />
								<col style="width: 100px;" />
								<col style="width: 24%;" />
								<col style="width: 100px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code=' 증명일자' /></th>
									<td>
										<input type="text" id="CHIT_FRMTRM_MONTH_FROM"  name="CHIT_FRMTRM_MONTH_FROM" class="inputText has-month-picker"/>
										<span class="fromTo-Dash">~</span>
										<input type="text" id="CHIT_FRMTRM_MONTH_TO"  name="CHIT_FRMTRM_MONTH_TO" class="inputText has-month-picker"/>
									</td>
									<th><spring:message code='접수일자' /></th>
									<td>
										<input type="text" id="CAL_SEARCH_RCEPT_FROM_DATE"  name="CAL_SEARCH_RCEPT_FROM_DATE" style="width:120px" class="inputText" searchfnc="DB011.retrieve_DB011List"/>
										<input type="hidden" id="SEARCH_RCEPT_FROM_DATE"  name="SEARCH_RCEPT_FROM_DATE" />
										<span class="fromTo-Dash">~</span>
										<input type="text" id="CAL_SEARCH_RCEPT_TO_DATE"  name="CAL_SEARCH_RCEPT_TO_DATE" style="width:120px" class="inputText" searchfnc="DB011.retrieve_DB011List"/>
										<input type="hidden" id="SEARCH_RCEPT_TO_DATE"  name="SEARCH_RCEPT_TO_DATE" />
										
									</td>
									<th><spring:message code='통지일자' /></th>
									<td>
										<input type="text" id="CAL_SEARCH_NTICE_FROM_DATE"  name="CAL_SEARCH_NTICE_FROM_DATE" style="width:120px" class="inputText" searchfnc="DB011.retrieve_DB011List"/>
										<input type="hidden" id="SEARCH_NTICE_FROM_DATE"  name="SEARCH_NTICE_FROM_DATE" />
										<span class="fromTo-Dash">~</span>
										<input type="text" id="CAL_SEARCH_NTICE_TO_DATE"  name="CAL_SEARCH_NTICE_TO_DATE" style="width:120px" class="inputText" searchfnc="DB011.retrieve_DB011List"/>
										<input type="hidden" id="SEARCH_NTICE_TO_DATE"  name="SEARCH_NTICE_TO_DATE" />
										
									</td>
								</tr>
								<tr>
									<th><spring:message code='조회조건' /></th>
									<td colspan="3">
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="DB011.retrieve_DB011List"/>
									</td>
									<th><spring:message code='제증명구분' /></th>
									<td>
										<select id="ISSUE_TYPE"  name="ISSUE_TYPE" class="form-control searchSelect"  style="width:120px">
									</td>
								</tr>
								<tr>
									<th><spring:message code='상태' /></th>
									<td colspan="5">
										<select id="DOC_STATUS"  name="DOC_STATUS" class="form-control searchSelect"  style="width:120px">
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-3" type="button" onclick="javascript:DB011.retrieve_DB011List();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_DB011_List" name="div_oTui_DB011_List" class="tuigrid-resizable">
					<div id="oTui_DB011_List" data-minus-height="345"></div>
					<div id="oTui_DB011_List_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>
	
	var DB011 = new function(){
		
		
		
		this.Initialize_viewObject = function() {
			
			var fromDay = KpackageOBJ.date.getCurrMonth() + "01";
			var toDay = KpackageOBJ.date.getCurrMonth() + KpackageOBJ.date.lastDay(KpackageOBJ.date.getCurrMonth());
			
			
			
			KpackageOBJ.monthPicker.create("DB011-form", "CHIT_FRMTRM_MONTH_FROM");
			KpackageOBJ.monthPicker.setValue("DB011-form","CHIT_FRMTRM_MONTH_FROM", KpackageOBJ.date.getCurrMonth("").replace(/-/gi, ""));
			
			KpackageOBJ.monthPicker.create("DB011-form", "CHIT_FRMTRM_MONTH_TO");
			KpackageOBJ.monthPicker.setValue("DB011-form","CHIT_FRMTRM_MONTH_TO", KpackageOBJ.date.getCurrMonth("").replace(/-/gi, ""));
			
						
			KpackageOBJ.calendar.create("DB011-form", "CAL_SEARCH_RCEPT_FROM_DATE");
			//KpackageOBJ.calendar.setValue("DB011-form","CAL_SEARCH_RCEPT_FROM_DATE", fromDay);
			//KpackageOBJ.object.setFormValue("DB011-form","SEARCH_RCEPT_FROM_DATE", fromDay);
			
			KpackageOBJ.calendar.create("DB011-form", "CAL_SEARCH_RCEPT_TO_DATE");
			//KpackageOBJ.calendar.setValue("DB011-form","CAL_SEARCH_RCEPT_TO_DATE", toDay);
			//KpackageOBJ.object.setFormValue("DB011-form","SEARCH_RCEPT_TO_DATE",toDay);
			
			KpackageOBJ.calendar.create("DB011-form", "CAL_SEARCH_NTICE_FROM_DATE");
			//KpackageOBJ.calendar.setValue("DB011-form","CAL_SEARCH_NTICE_FROM_DATE", fromDay);
			//KpackageOBJ.object.setFormValue("DB011-form","SEARCH_NTICE_FROM_DATE", fromDay);
			
			KpackageOBJ.calendar.create("DB011-form", "CAL_SEARCH_NTICE_TO_DATE");
			//KpackageOBJ.calendar.setValue("DB011-form","CAL_SEARCH_NTICE_TO_DATE", toDay);
			//KpackageOBJ.object.setFormValue("DB011-form","SEARCH_NTICE_TO_DATE",toDay);
			
			var arrayItem1 = [{value:"", name:"전체"}
		    				,{value:"AA", name:"신고서 작성"}
		    				,{value:"BB", name:"신고서 미작성"}
		    				,{value:"CC", name:"신고 완료"}
		    				,{value:"DD", name:"신고 미완료"}];

			KpackageOBJ.selectbox.create("DB011-form", "DOC_STATUS", "", null, "value", "name", arrayItem1);
			
			var arrayItem2 = [{value:"", name:"전체"}
		    				,{value:"02", name:"기납증"}
		    				,{value:"04", name:"분증"}];

			KpackageOBJ.selectbox.create("DB011-form", "ISSUE_TYPE", "", null, "value", "name", arrayItem2);

			/*Search Type Select Box Create */
			arrayItem = [{value:"CUSTOMER_CODE", name:"<spring:message code='supplyInfo.title.SUPPLY_CODE'/>"}
						 ,{value:"CUSTOMER_NAME", name:"<spring:message code='supplyInfo.title.SUPPLY_NAME'/>"}
						 ,{value:"REGIST_RCEPT_NO", name:"증명번호"}];
			
			KpackageOBJ.selectbox.create("DB011-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			             ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						 ,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("DB011-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
			
			
		}
		
		this.renderTuiGrid = function() {
			 
			 var colArrayInfo = [
				 
					{ header : "증명번호"			,name : "REGIST_RCEPT_NO"		,width : 100, align: "center" ,hidden:false },
					{ header : "증명일자"			,name : "CHIT_FRMTRM_DATE"		,width : 100, align: "center" ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },				
					{ header : "제증명구분"		,name : "ISSUE_TYPE_NAME"		,width : 80, align: "center" ,hidden:false },
					{ header : "업체코드"			,name : "CUSTOMER_CODE"			,width : 80, align: "left" ,hidden:false },					
					{ header : "업체명"			,name : "CSTMR_NM_1"			,width : 200, align: "left" ,hidden:false },
					{ header : "신청서 작성여부"  ,name : "REGIST_YN"				,width : 100, align: "center" ,hidden:false },
					{ header : "접수여부"			,name : "RCEPT_YN"				,width : 100, align: "center" ,hidden:false },
					{ header : "통지여부"			,name : "NTICE_YN"				,width : 100, align: "center" ,hidden:false },
					{ header : "접수일자"			,name : "RCEPT_DATE"			,width : 100, align: "center" ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
					{ header : "통지일자"			,name : "NTICE_DATE"			,width : 100, align: "center" ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
					{ header : "제출번호"			,name : "MCRTF_PRESENTN_NO"		,width : 100, align: "center" ,hidden:true },
					{ header : "신청번호"			,name : "MCRTF_REGIST_RCEPT_NO"	,width : 100, align: "center" ,hidden:true },
					{ header : "회사코드"			,name : "COMPANY_CODE"			,width : 100, align: "center" ,hidden:true },
					{ header : "플랜트"			,name : "DIVISION_CODE"			,width : 100, align: "center" ,hidden:true },
					{ header : "기납증제출번호"	,name : "PRESENTN_NO"			,width : 100, align: "center" ,hidden:true },
					{ header : "제증명구분"		,name : "ISSUE_TYPE"			,width : 100, align: "center" ,hidden:true }
			    ];
			 
			 
			 var tools = [ {icon:"add",   title:"상세"					,text:"상세"				    ,func:"DB011.openDetail"}
						  , {icon:"add",   title:"작성"					,text:"작성"				    ,func:"DB011.openCreate"}
						  ,{icon:"none",  title:"출력"					,text:"출력"					,func:"DB011.openPrintReport"}
						  ,{icon:"excel", title:"엑셀다운로드"			,text:"엑셀다운로드"			,func:"DB011.excel_Download"}
						  ,{icon:"none",  title:"전송"					,text:"전송"					,func:"DB011.sendInterface"}
				];
			 KpackageOBJ.tuiGrid.setButton("oTui_DB011_List", tools); // Toobar 생성

			 KpackageOBJ.tuiGrid.create("oTui_DB011_List", "/drawback/retrieve_DB011List", colArrayInfo, 'checkbox', DB011.oTui_DB011_List_onClick_Handler, DB011.oTui_DB011_List_onDblclick_Handler );
			 
		}
		
		this.oTui_DB011_List_onClick_Handler  = function(p_GridId, p_RowKey, p_ColName){}
		
		this.oTui_DB011_List_onDblclick_Handler = function(p_GridId, p_RowKey, p_ColName){
			DB011.openDetailPage(p_RowKey);
		}
		
		/**  조회버튼 클릭 */
		this.retrieve_DB011List = function() {
			var param = KpackageOBJ.data.makePostData("DB011-form");  
			
			KpackageOBJ.tuiGrid.retrieve("oTui_DB011_List", "", param);
			
		}
		
		this.fileDownload_CustomFormatter = function(value){
			var rowData = value.row;
			return "<a class='btn btn-primary btn-border tuiGrid-toolbar-button' style='padding: 2px 19px;background-color: #566284;border-color: #566284;'"  
			+ " href=\"javascript:DB011.openFilePopup('"+ rowData.OVER_DRWBAK_PRESENTN_NO +"');\" title=\"클릭하여 첨부파일을 확인 할 수 있습니다.\">" + "파일관리" + '</a>';
			
		}
		
		this.openCalcDetail = function(){
			var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB011_List");
			if(rowData.length == 0){
				alert("선택된 데이터가 없습니다.");
				return;
			}
			var reqParams = "";
			var processErrorFlag = false;
			for(var inx = 0; inx < rowData.length; inx++){
				var rows = rowData[inx];
				
				if(rows.SEND_REQ_YN == "N" ){
					alert("과다환급자진신고 접수되지 않은 데이터가 포함되어 있습니다.");
					processErrorFlag = true;
					break;
				}else{
					reqParams += rows.OVER_DRWBAK_PRESENTN_NO + "^";
				}
			}
			
			if(!processErrorFlag){
				var getParams = "?DIALOG_ID="       		+ "dialog_DB01101"
						        + "&PGMID="         		+  "DB01101"
						        + "&SEARCH_PRESENTN_NO="    +  reqParams.substring(0, reqParams.length-1);
						        + "&PARENT_GRID_ID="		+ "oTui_DB011_List"
		        ;
				KpackageOBJ.dialog.open("dialog_DB01102", "과다환급금 가산금액 산출", "/db-00902" + getParams, 1050, 400);
			}
		}
		
		this.openDetail = function(){
			var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB011_List");
			if(rowData.length == 0){
				alert("선택된 데이터가 없습니다.");
				return;
			}
			if(rowData.length > 1){
				alert("1개의 데이터만 선택할 수 있습니다.");
				return;
			}
			var selectedRowKey = rowData[0].rowKey;
			DB011.openDetailPage(selectedRowKey);
		}
		
		/** 상세페이지 호출 */
		this.openDetailPage = function(rowKey){
			var formId = "";
			
			if(rowKey == null){
				rowKey = 0;
			}
			var rowData = KpackageOBJ.tuiGrid.getRowValues("oTui_DB011_List", rowKey);

			if(rowData.ISSUE_TYPE == "02"){
				formId = "prt01100";
			}else if(rowData.ISSUE_TYPE == "04"){
				formId = "prt00700";
			}else{
				return;
			}
			
			
			var getParams = "?DIALOG_ID="       		   + "dialog_previewDocumentPage"
					        + "&PGMID="         		   + "previewDocumentPage"
					        + "&FORM_YYYYMMDD="            + rowData.CHIT_FRMTRM_DATE /*to-do 취하 신청일자로 변경필요*/
					        + "&KEY_PARAM1="               + rowData.COMPANY_CODE
					        + "&KEY_PARAM2="               + rowData.DIVISION_CODE
					        + "&KEY_PARAM3="               + rowData.PRESENTN_NO
					        + "&FORM_ID="                  + formId
				        ;
			KpackageOBJ.dialog.open("dialog_PreviewDocumentPage", "출력", "/viewPreviewDocumentPage" + getParams, 1000, 700);
			
		}
		
		this.openCreate = function(){
			var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB011_List");
			if(rowData.length == 0){
				alert("선택된 데이터가 없습니다.");
				return;
			}
			if(rowData.length > 1){
				alert("1개의 데이터만 선택할 수 있습니다.");
				return;
			}
			var selectedRowKey = rowData[0].rowKey;
			DB011.openCreatePage(selectedRowKey);
		}
		
		/** 신청서 작성 페이지 호출 */
		this.openCreatePage = function(rowKey){
			if(rowKey == null){
				rowKey = 0;
			}
			var rowData = KpackageOBJ.tuiGrid.getRowValues("oTui_DB011_List", rowKey);
			
			if(oUtil.isNull(rowData.REGIST_RCEPT_NO)){
				alert("증명번호가 존재하지 않습니다.");
// 				return;
			}

			var getParams = "?DIALOG_ID="       		+ "dialog_DB01102"
					        + "&PGMID="         		+  "DB01102"
					        + "&SEARCH_PRESENTN_NO="     +  rowData.PRESENTN_NO
// 					        + "&SEARCH_REGIST_RCEPT_NO=" +  rowData.REGIST_RCEPT_NO
					        ;
			KpackageOBJ.dialog.open("dialog_DB01102", "제증명서 정정 취하 승인신청서 작성", "/db-01102" + getParams, 1000, 600);
			
		}
		
		/** 출력 **/
		
		this.openPrintReport = function(){
			var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB011_List");
			if(rowData.length == 0){
				alert("선택된 데이터가 없습니다.");
				return;
			}
			if(rowData.length > 1){
				alert("1개의 데이터만 선택할 수 있습니다.");
				return;
			}
			if("Y" != rowData[0].REGIST_YN){
				alert("신청서가 작성되어있지 않습니다.");
				return;
			}
			
			var getParams = "?DIALOG_ID="       		   + "dialog_previewDocumentPage"
					        + "&PGMID="         		   + "previewDocumentPage"
					        + "&FORM_YYYYMMDD="            + rowData[0].CHIT_FRMTRM_DATE /*to-do 취하 신청일자로 변경필요*/
					        + "&KEY_PARAM1="               + rowData[0].COMPANY_CODE
					        + "&KEY_PARAM2="               + rowData[0].DIVISION_CODE
					        + "&KEY_PARAM3="               + rowData[0].MCRTF_PRESENTN_NO
					        + "&FORM_ID="                  + "prt00300"
				        ;
			KpackageOBJ.dialog.open("dialog_PreviewDocumentPage", "출력", "/viewPreviewDocumentPage" + getParams, 1000, 700);
		}
		
	
		this.sendInterface = function(){
			alert("연계모듈을 찾을 수 없습니다.");
		}
		
		this.excel_Download = function(){
			
		}
	}
	
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB011.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		DB011.renderTuiGrid();
	});
	
	
</script>
</body>
</html>