<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
/**********************************************************************************************
* PGM ID : DB008
* PGM DESC : 기납증/분증 관리
* Remark : 
*
**********************************************************************************************/

	String serverName = request.getServerName();
	String portNumber = request.getServerPort()+"";
	String serverFullUrl = serverName;
	if(!"80".equalsIgnoreCase(portNumber) && !"443".equalsIgnoreCase(portNumber)){
		serverFullUrl = serverFullUrl + "" +  portNumber;
	}
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<OBJECT style="display: none;" classid="clsid:{4190A3E7-2648-4FD5-A120-03F99F7B321E}" align=center hspace=0 vspace=0 id="KPMGUnipassObj"></OBJECT>
	<div id="content">
		<section id="widget-grid-DB008" class="">
			<form:form id="DB008-form" class="s4-form" novalidate="novalidate" action="/db-002" method="post">
				<input type="hidden" id="headers" name="headers" />
				<input type="hidden" id="filename" name="filename" />
				<input type="hidden" id="sheetname" name="sheetname" />
				<div class="row-extends row">
					<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
						<div class="table-responsive">
							<table class="table table-bordered">
								<colgroup>
									<col style="width: 120px;" />
									<col style="width: 25%;" />
									<col style="width: 120px;" />
									<col style="width: 12%;" />
									<col style="width: 120px;" />
									<col style="width:" />
								</colgroup>
								<tbody>
									<tr>
										<th><spring:message code='기준년월' /></th>
										<td><input type="text" id="CAL_SEARCH_FROM_DATE" name="CAL_SEARCH_FROM_DATE" style="width: 120px" class="inputText" searchfnc="DB008.retrieve_DB008List" /> <input type="hidden" id="SEARCH_FROM_DATE" name="SEARCH_FROM_DATE" style="width: 120px" class="inputText" /> <span class="fromTo-Dash">~</span> <input type="text" id="CAL_SEARCH_TO_DATE" name="CAL_SEARCH_TO_DATE" style="width: 120px" class="inputText" searchfnc="DB008.retrieve_DB008List" /> <input type="hidden" id="SEARCH_TO_DATE" name="SEARCH_TO_DATE" style="width: 120px" class="inputText" /></td>
										<th><spring:message code='신청구분' /></th>
										<td><select class="form-control searchSelect" id="SEARCH_ISSUE_TYPE" name="SEARCH_ISSUE_TYPE" style="width: 80px"></select></td>
										<th><spring:message code='전송상태' /></th>
										<td><select class="form-control searchSelect" id="EXECUT_STATUS" name="EXECUT_STATUS" style="width: 110px"></select></td>
										<td class="no-pd">
											<div class="input-group-btn">
												<button class="btn-default btn-primary btn-custom-search" name="switchFilterBtn" style="padding: 8px 0px;" type="button" onclick="javascript:KpackageOBJ.object.switchFilter(this,'DB008');">
													<i class="fa fa-arrow-down"></i>
												</button>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
						<div class="input-group-btn">
							<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:DB008.retrieve_DB008List();">
								<i class="fa fa-search"></i>
								<spring:message code='TXT.ENG_SEARCH' />
							</button>
						</div>
					</div>

				</div>
				<div id="DB008-HIDDEN-FILTER" class="row-extends row switchFilter">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="table-responsive">
							<table class="table table-bordered">
								<colgroup>
									<col style="width: 100px;" />
									<col style="width: 20%;" />
									<col style="width: 120px;" />
									<col style="width: 20%;" />
									<col style="width: 120px;" />
									<col style="width:" />
								</colgroup>
								<tbody>
									<tr>
										<th><spring:message code='HS CODE' /></th>
										<td><input type="text" id="HS_CODE" name="HS_CODE" style="width: 99%" class="inputText" searchfnc="DB008.retrieve_DB008List" /></td>
										<th><spring:message code='관리번호(내부)' /></th>
										<td><input type="text" id="PRESENTN_NO" name="PRESENTN_NO" style="width: 99%" class="inputText" searchfnc="DB008.retrieve_DB008List" /></td>
										<th><spring:message code='common.title.searchCondition' /></th>
										<td><select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width: 100px"></select> <select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width: 100px"></select> <input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="DB008.retrieve_DB008List" /></td>
										
									</tr>
									<tr>
										<th><spring:message code='제출번호' /></th>
										<td><input type="text" id="REGIST_RCEPT_NO" name="REGIST_RCEPT_NO" style="width: 99%" class="inputText" searchfnc="DB008.retrieve_DB008List" /></td>
										<th><spring:message code='제품코드' /></th>
										<td><input type="text" id="ITEM_CODE" name="ITEM_CODE" style="width: 99%" class="inputText" searchfnc="DB008.retrieve_DB008List" /></td>
										<th><spring:message code='고객사코드' /></th>
										<td><input type="text" id="CUSTOMER_CODE" name="CUSTOMER_CODE" style="width: 99%" class="inputText" searchfnc="DB008.retrieve_DB008List" /></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			
			</form:form>
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div id="div_oTui_DB008_List" name="div_oTui_DB008_List" class="tuigrid-resizable">
						<div id="oTui_DB008_List" data-minus-height="280"></div>
						<div id="oTui_DB008_List_paging"></div>
					</div>
				</div>
			</div>


		</section>

	</div>

	<div id="UNPS_RESULT_LAYER" title="수신 결과" style="display: none; overflow: hidden;">
		<fieldset style="padding: 0px;">
			<section>
				<textarea id="UNPS_RESULT" rows="" cols="" style="height: 500px; width: 95%; margin-left: 18px; margin-top: 10px;" readonly="readonly"></textarea>
			</section>
		</fieldset>
	</div>
	<iframe name="previewFrame1" id="previewFrame1" width="0%" style="display: none;"></iframe>
	<iframe name="previewFrame2" id="previewFrame2" width="0%" style="display: none;"></iframe>
	<iframe name="previewFrame3" id="previewFrame3" width="0%" style="display: none;"></iframe>
	<iframe name="previewFrame4" id="previewFrame4" width="0%" style="display: none;"></iframe>
	<form id="dir_reportFrame_Form" name="dir_reportFrame_Form" method="post">
	    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
	    <input type="hidden" name="_csrf_header" value="${_csrf.headerName}"/>
		<input type="hidden" id="REPORT_FILE_TYPE" 	name="REPORT_FILE_TYPE" 	value="pdf"/>
		<input type="hidden" id="REPORT_TYPE" 	name="REPORT_TYPE" 			value="pdf"/>   
		<input type="hidden" id="KEY_PARAM1"     name="KEY_PARAM1"/>
		<input type="hidden" id="KEY_PARAM2"     name="KEY_PARAM2"/>
		<input type="hidden" id="KEY_PARAM3"     name="KEY_PARAM3"/>
		<input type="hidden" id="KEY_PARAM4"     name="KEY_PARAM4"/>
		<input type="hidden" id="KEY_PARAM5"     name="KEY_PARAM5"/>
		<input type="hidden" id="P_FORM_ID"		name="P_FORM_ID"/>
		<input type="hidden" id="P_FILE_NAME"	name="P_FILE_NAME"/>
		<input type="hidden" id="P_FORM_YYYYMMDD"	name="P_FORM_YYYYMMDD"/>
		<input type="hidden" id="P_DIRECT_DOWNLOAD"	name="P_DIRECT_DOWNLOAD"	value="Y"/>
	</form>	
	<script>
	
        var DB008 = new function() {

        	
            this.Initialize_viewObject = function() {

                /** 월달력 생성 */
                var fromMonth = KpackageOBJ.date.getCurrMonth();
                var fromDay = fromMonth + "01";

                var lastDay = KpackageOBJ.date.getCurrMonth() + KpackageOBJ.date.lastDay(KpackageOBJ.date.getCurrMonth());

                KpackageOBJ.calendar.create("DB008-form", "CAL_SEARCH_FROM_DATE");
                KpackageOBJ.calendar.setValue("DB008-form", "CAL_SEARCH_FROM_DATE", fromDay);
                KpackageOBJ.object.setFormValue("DB008-form", "SEARCH_FROM_DATE", fromDay);

                KpackageOBJ.calendar.create("DB008-form", "CAL_SEARCH_TO_DATE");
                KpackageOBJ.calendar.setValue("DB008-form", "CAL_SEARCH_TO_DATE", lastDay);
                KpackageOBJ.object.setFormValue("DB008-form", "SEARCH_TO_DATE", lastDay);

                // 			KpackageOBJ.monthPicker.create("DB008-form", "SEARCH_PRIC_RQEST_DATE");
                // 			KpackageOBJ.monthPicker.setValue("DB008-form","SEARCH_PRIC_RQEST_DATE", KpackageOBJ.date.getCurrMonth());

                KpackageOBJ.selectbox.create("DB008-form", "EXECUT_STATUS",  "/common/retrieveComCdList", {"CATEGORY_CD":"EXECUT_STATUS","OPTION_ALL":"Y"}, "CODE", "NAME");  

                /*Search Type Select Box Create */
                var arrayItem = [ {
                    value : "ITEM_CODE",
                    name : "<spring:message code='제품코드'/>"
                }, {
                    value : "ITEM_NAME",
                    name : "<spring:message code='제품명'/>"
                } ];

                KpackageOBJ.selectbox.create("DB008-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);

                /*Search Type Select Box Create */
                arrayItem = [ {
                    value : "CC",
                    name : "<spring:message code='common.txt.contains'/>"
                }, {
                    value : "EQ",
                    name : "<spring:message code='common.txt.equalTo'/>"
                }, {
                    value : "SW",
                    name : "<spring:message code='common.txt.startsWithIs'/>"
                } ];

                KpackageOBJ.selectbox.create("DB008-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);

                /*Search Type Select Box Create */
                arrayItem = [ {
                    value : "04",
                    name : "분증"
                }, {
                    value : "02",
                    name : "기납증"
                } ];

                KpackageOBJ.selectbox.create("DB008-form", "SEARCH_ISSUE_TYPE", "", null, "value", "name", arrayItem);

            }

            this.renderTuiGrid = function() {

                var colArrayInfo = [
     					{ header : "전송상태",    name : "VALID_CODE",    width : 120,    align : "center",    hidden : false,    formatter : DB008.transStatus_CustomFormatter},
         				{ header : "제출번호",    name : "PRESENTN_NO",    width : 190,    align : "center",    hidden : false}, 
         				{ header : "발급구분",    name : "ISSUE_TYPE_NAME",    width : 70,    align : "center",    hidden : false},
         				{ header : "고객사명",    name : "CSTMR_NM_1",    width : 150,    align : "left",    hidden : false},
         				{ header : "대표명",    name : "RPRSNTV_NM_1",    width : 100,    align : "left",    hidden : false},
         				{ header : "HS Code",    name : "HS_CODE",    width : 100,    align : "center",    hidden : false,    formatter : KpackageOBJ.tuiGrid.hscode10},
         				{ header : "대표품번",    name : "ITEM_CODE",    width : 110,    align : "center",    hidden : false}, 
         				{ header : "대표품명",    name : "ITEM_NM",    width : 300,    align : "left",    hidden : false}, 
         				{ header : "단위",    name : "BASS_UNIT",    width : 50,    align : "center",    hidden : false}, 
         				{ header : "품목수",    name : "DOC_ITEM_CNT",    width : 90,    align : "right",    hidden : false,    formatter : KpackageOBJ.tuiGrid.commas},
         				{ header : "판매금액",    name : "STTEMNT_PC_KRW",    width : 120,    align : "right",    hidden : false,    formatter : KpackageOBJ.tuiGrid.commas},
         				{ header : "양도세액",    name : "DRWBAK_AMOUNT",    width : 120,    align : "right",    hidden : false,    formatter : KpackageOBJ.tuiGrid.commas},
         				{ header : "제출여부",    name : "EXECUT_AT_NAME",    width : 100,    align : "center",    hidden : true}, 
       				 	{ header : "EXECUT_AT",    name : "EXECUT_AT",    width : 100,    align : "center",    hidden : true}, 
       				 	{ header : "COMPANY_CODE",    name : "COMPANY_CODE",    width : 100,    align : "center",    hidden : true},
       				 	{ header : "DIVISION_CODE",    name : "DIVISION_CODE",    width : 100,    align : "center",    hidden : true},
       				 	{ header : "BASE_SOURCE_YYYYMM",    name : "BASE_SOURCE_YYYYMM",    width : 100,    align : "center",    hidden : true},
       				 	{ header : "CUSTOMER_CODE",    name : "CUSTOMER_CODE",    width : 100,    align : "center",    hidden : true}, 
       				 	{ header : "ISSUE_TYPE",    name : "ISSUE_TYPE",    width : 100,    align : "center",    hidden : true}, 
       				 	{ header : "SUBMIT_NO",    name : "SUBMIT_NO",    width : 100,    align : "center",    hidden : true},
       				 	{ header : "EXECUT_STATUS",    name : "EXECUT_STATUS",    width : 100,    align : "center",    hidden : true},
     				 	{ header : "유니패스 상태값",    name : "UNIPASS_STATUS",    width : 100,    align : "center",    hidden : true},
     				 	{ header : "유니패스ID",    name : "UNIPASS_ID",    width : 120,    align : "center",    hidden : true},
     				 	{ header : "문서함코드",    name : "UNIPASS_DOC_BOX_CODE",    width : 120,    align : "center",    hidden : true},
     				 	{ header : "문서형태코드",    name : "STTEMNT_DOC_STLE",    width : 120,    align : "center",    hidden : true}
                				 ];

				var tools = [ {icon : "none",header : "전송",text : "전송",func : "DB008.drwbak_Send"}
				    		, {icon : "none",header : "수신",text : "수신",func : "DB008.receiveUnipass"}
							, {icon : "none",header : "상태조회",text : "상태조회",func : "DB008.unipassStatusPopup"}
							, {icon : "none",header : "증빙서류일괄다운로드",text : "상태조회",func : "DB008.openDirectDownload"}
							, {icon : "none",header : "양식출력",text : "양식출력",func : "DB008.openPrintReport"}
							, {icon : "none",header : "소요량 계산서",text : "소요량 계산서",func : "DB008.openPrintReport_InputCalc"}
							, {icon : "none",header : "자재명세서(BOM)",text : "자재명세서(BOM)",func : "DB008.openPrintReport_Bom"}
							, {icon : "none",header : "조견표",text : "조견표",func : "DB008.openPrintReport_QuickRef"}
							, {icon : "none",header : "매출정보조회",text : "매출정보조회",func : "DB008.openSalesData"}
							
							];
                KpackageOBJ.tuiGrid.setButton("oTui_DB008_List", tools); // Toobar 생성

                KpackageOBJ.tuiGrid.create("oTui_DB008_List", "/drawback/retrieve_DB008List", colArrayInfo, 'checkbox', DB008.oTui_DB008_List_onClick_Handler, DB008.oTui_DB008_List_onDblclick_Handler);

            }
            
            this.openDirectDownload = function(){
    			
            	var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB008_List");
                if(rowData.length == 0){
                    alert("선택된 데이터가 없습니다.");
                    return;
                }
                if(rowData.length > 1){
                    alert("1개의 데이터만 선택할 수 있습니다.");
                    return;
                }
                

                /* 기납증 신청서 */
                KpackageOBJ.object.setFormValue("dir_reportFrame_Form","P_FORM_YYYYMMDD", "20241211");
                KpackageOBJ.object.setFormValue("dir_reportFrame_Form","KEY_PARAM1", rowData[0].COMPANY_CODE);
                KpackageOBJ.object.setFormValue("dir_reportFrame_Form","KEY_PARAM2", rowData[0].DIVISION_CODE);
                KpackageOBJ.object.setFormValue("dir_reportFrame_Form","KEY_PARAM3", rowData[0].PRESENTN_NO);
                KpackageOBJ.object.setFormValue("dir_reportFrame_Form","KEY_PARAM4", rowData[0].PRESENTN_NO);
                KpackageOBJ.object.setFormValue("dir_reportFrame_Form","KEY_PARAM5", rowData[0].PRESENTN_NO);
                KpackageOBJ.object.setFormValue("dir_reportFrame_Form","P_FORM_ID", "prt01100");
                KpackageOBJ.object.setFormValue("dir_reportFrame_Form","P_FILE_NAME", "requestForm_"+rowData[0].SUBMIT_NO);
    				            
    			$("#dir_reportFrame_Form").prop("target", "previewFrame1");
    			$('#dir_reportFrame_Form').prop('action','/thirdParty_ReportApplication');
    			$('#dir_reportFrame_Form').submit();
    			
    			if("02" == rowData[0]["ISSUE_TYPE"]){
    				/* 자재명세서(BOM) */
        		    KpackageOBJ.object.setFormValue("dir_reportFrame_Form","P_FORM_ID", "prt00501");
                    KpackageOBJ.object.setFormValue("dir_reportFrame_Form","P_FILE_NAME", "BOM_"+rowData[0].SUBMIT_NO);
        				            
        			$("#dir_reportFrame_Form").prop("target", "previewFrame2");
        			$('#dir_reportFrame_Form').prop('action','/thirdParty_ReportApplication');
        			$('#dir_reportFrame_Form').submit();	
    			}
    			
    			
    			if("02" == rowData[0]["ISSUE_TYPE"]){
    				/* 소요량계산서 */
        		    KpackageOBJ.object.setFormValue("dir_reportFrame_Form","P_FORM_ID", "prt00601");
                    KpackageOBJ.object.setFormValue("dir_reportFrame_Form","P_FILE_NAME", "requirement_statements_"+rowData[0].SUBMIT_NO);
        				            
        			$("#dir_reportFrame_Form").prop("target", "previewFrame3");
        			$('#dir_reportFrame_Form').prop('action','/thirdParty_ReportApplication');
        			$('#dir_reportFrame_Form').submit();	
    			}
    			
    			
    			
    			/* 조견표 */
    			var targetDocument = "prt01200" // 분증
   	            if("02" == rowData[0]["ISSUE_TYPE"]){
   	            	targetDocument = "prt01201" // 기납증
   	            }
    			
    			KpackageOBJ.object.setFormValue("dir_reportFrame_Form","P_FORM_ID", targetDocument);
                KpackageOBJ.object.setFormValue("dir_reportFrame_Form","P_FILE_NAME", "QuickRef_"+rowData[0].SUBMIT_NO);
    				            
    			$("#dir_reportFrame_Form").prop("target", "previewFrame4");
    			$('#dir_reportFrame_Form').prop('action','/thirdParty_ReportApplication');
    			$('#dir_reportFrame_Form').submit();
                
    		}
            
            this.openPrintReport = function(){
                var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB008_List");
                if(rowData.length == 0){
                    alert("선택된 데이터가 없습니다.");
                    return;
                }
                if(rowData.length > 1){
                    alert("1개의 데이터만 선택할 수 있습니다.");
                    return;
                }
     
                
                var getParams = "?DIALOG_ID="                  + "dialog_previewDocumentPage"
                                + "&PGMID="                    + "previewDocumentPage"
                                + "&FORM_YYYYMMDD="            + "20241211"
                                + "&KEY_PARAM1="               + rowData[0].COMPANY_CODE
                                + "&KEY_PARAM2="               + rowData[0].DIVISION_CODE
                                + "&KEY_PARAM3="               + rowData[0].PRESENTN_NO
                                + "&FORM_ID="                  + "prt01100"
                            ;
                KpackageOBJ.dialog.open("dialog_PreviewDocumentPage", "출력", "/viewPreviewDocumentPage" + getParams, 1000, 700);
            }
	        <% /* 자재명세서(BOM) */%>    
	        this.openPrintReport_Bom = function(){
	            var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB008_List");
	            if(rowData.length == 0){
	                alert("선택된 데이터가 없습니다.");
	                return;
	            }
	            if(rowData.length > 1){
	                alert("1개의 데이터만 선택할 수 있습니다.");
	                return;
	            }
	 
	            
	            var getParams = "?DIALOG_ID="                  + "dialog_previewDocumentPage"
	                            + "&PGMID="                    + "previewDocumentPage"
	                            + "&FORM_YYYYMMDD="            + "20241211"
	                            + "&KEY_PARAM1="               + rowData[0].COMPANY_CODE
	                            + "&KEY_PARAM2="               + rowData[0].DIVISION_CODE
	                            + "&KEY_PARAM3="               + rowData[0].PRESENTN_NO
	                            + "&FORM_ID="                  + "prt00501"
	                        ;
	            KpackageOBJ.dialog.open("dialog_PreviewDocumentPage", "출력", "/viewPreviewDocumentPage" + getParams, 1000, 700);
	        }
	        <% /* 조견표 */%>
	        this.openPrintReport_QuickRef = function(){
	            var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB008_List");
	            var targetDocument = "prt01200" // 분증
	            if(rowData.length == 0){
	                alert("선택된 데이터가 없습니다.");
	                return;
	            }
	            if(rowData.length > 1){
	                alert("1개의 데이터만 선택할 수 있습니다.");
	                return;
	            }
	            
	            if("02" == rowData[0]["ISSUE_TYPE"]){
	            	targetDocument = "prt01201" // 기납증
	            }
	 
	            
	            var getParams = "?DIALOG_ID="                  + "dialog_previewDocumentPage"
	                            + "&PGMID="                    + "previewDocumentPage"
	                            + "&FORM_YYYYMMDD="            + "20241211"
	                            + "&KEY_PARAM1="               + rowData[0].COMPANY_CODE
	                            + "&KEY_PARAM2="               + rowData[0].DIVISION_CODE
	                            + "&KEY_PARAM3="               + rowData[0].PRESENTN_NO
	                            + "&FORM_ID="                  + targetDocument
	                            ;
	            KpackageOBJ.dialog.open("dialog_PreviewDocumentPage", "출력", "/viewPreviewDocumentPage" + getParams, 1000, 700);
	        }
	        
	        <% /* 소요량 계산서 */%>
	        this.openPrintReport_InputCalc = function(){
	            var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB008_List");
	            var targetDocument = "prt00601" // 분증
	            if(rowData.length == 0){
	                alert("선택된 데이터가 없습니다.");
	                return;
	            }
	            if(rowData.length > 1){
	                alert("1개의 데이터만 선택할 수 있습니다.");
	                return;
	            }
	            
	            var getParams = "?DIALOG_ID="                  + "dialog_previewDocumentPage"
	                            + "&PGMID="                    + "previewDocumentPage"
	                            + "&FORM_YYYYMMDD="            + "20241211"
	                            + "&KEY_PARAM1="               + rowData[0].COMPANY_CODE
	                            + "&KEY_PARAM2="               + rowData[0].DIVISION_CODE
	                            + "&KEY_PARAM3="               + rowData[0].PRESENTN_NO
	                            + "&FORM_ID="                  + targetDocument
	                            ;
	            KpackageOBJ.dialog.open("dialog_PreviewDocumentPage", "출력", "/viewPreviewDocumentPage" + getParams, 1000, 700);
	        }
	        
			

            this.oTui_DB008_List_onClick_Handler = function(p_GridId, p_RowKey, p_ColName) {
            }

            this.oTui_DB008_List_onDblclick_Handler = function(p_GridId, p_RowKey, p_ColName) {
                DB008.openDetailPage(p_RowKey);
            }

            this.drwbak_Send = function() {
                
                var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB008_List");

                if (rowData.length == 0) {
                    alert("선택된 데이터가 없습니다.");
                    return;
                }

                for (var inx = 0; inx < rowData.length; inx++) {
                    if ("10" == rowData[inx]["UNIPASS_STATUS"]) {
                        alert("상태가 접수상태일 경우 재송신 할 수 없습니다.");
                        return;
                    }
                }

                KpackageOBJ.ajax.doSubmit("/drawbackDoc/createXml_init_part", rowData, DB008.SendUnipassDrwb_callback);
            }

            this.SendUnipassDrwb_callback = function(result) {
                var data = result.value;

                if (data.length > 0) {
                    KPMGUnipassObj.TransferDoc_Create(); //TransferDoc 객체 생성

                    for (var inx = 0; inx < data.length; inx++) {
                        KPMGUnipassObj.TransferDoc_InsertBuffer(data[inx]["rowKey"]);
                        KPMGUnipassObj.TransferDoc_SetUserID(data[inx]["UNIPASS_ID"]); //관세청유니패스에 등록되 아이디
                        KPMGUnipassObj.TransferDoc_SetCbtID(data[inx]["UNIPASS_DOC_BOX_CODE"]); //관세청유니패스에 등록되 문서함번호
                        KPMGUnipassObj.TransferDoc_SetDocCode(data[inx]["STTEMNT_DOC_STLE"]); //문서코드(FTA원산지증명서 코드)
                        KPMGUnipassObj.TransferDoc_SetConversationID(data[inx]["SUBMIT_NO"]); //Submit_No
                        KPMGUnipassObj.TransferDoc_SetReferenceID(data[inx]["STTEMNT_DOC_STLE"]); //XML 문서 코드
                        KPMGUnipassObj.TransferDoc_SetPayload("http://<%=serverFullUrl%>/rcs/unipass/send/" + data[inx]["PRESENTN_NO"] + ".xml", KpackageOBJ.prototype.unipass_local_dir + data[inx]["PRESENTN_NO"] + ".xml"); //XML 주소

                    }

                    KPMGUnipassObj.TransferDoc_Call(); //문서 전송

                    for (var inx = 0; inx < data.length; inx++) {

                        data[inx]["RTN_CODE"] = KPMGUnipassObj.TransferDoc_GetErrorCode(data[inx]["rowKey"]);
                        data[inx]["RTN_MESSAGE"] = KPMGUnipassObj.TransferDoc_GetErrorMessage(data[inx]["rowKey"]);

                    }

                    KpackageOBJ.ajax.doSubmit("/drawbackDoc/updateInitPartStatus", data, DB008.updateInitPartStatus_callback);

                } else {
                    alert("생성된 XML 데이터를 확인할 수 없습니다.");
                    return;
                }

            }

            this.updateInitPartStatus_callback = function(result) {
                if (result.success) {
                    alert(result.message);
                } else {
                    DB008.unipassSendResult(result.message);
                }

                DB008.retrieve_DB008List();

            }

            this.unipassSendResult = function(resultMsg) {

                $("#UNPS_RESULT").val(resultMsg);
                var targetDiv = $("#UNPS_RESULT_LAYER").html();
                KpackageOBJ.dialog.open("dialog_UNPS_RESULT", " 관세청 전송 결과", "", 650, 550, null, true, null, targetDiv);

            }

            this.transStatus_CustomFormatter = function(value){
    			var buttonText = "미접수";
    			var btnClass = "btn-primary";
    			var btnStyle = "padding: 2px 28px; font-color:#ffffff;";		
    			var rowData = value.row;
    			/* EXECUT_AT 속성 존재 */		
    			if(rowData.hasOwnProperty('EXECUT_AT')){
    				
    				/* EXECUT_AT 값 미존재 */
    				if(oUtil.isNull(rowData["EXECUT_AT"]) || "N" == rowData["EXECUT_AT"]){
    					btnClass = "btn-default";
    					btnStyle = "border-color: #ffb100; background-color: #ffb100; font-weight:bold;";
    					
    					return "<a class='btn "+btnClass+" btn-border tuiGrid-toolbar-freeColor-button' style='"+btnStyle+"'"  
    								+ " href=\"javascript:void(0);\" title=\"상세내용 확인하려면 클릭하세요\">" + buttonText + '</a>';											
    				}
    			}
    			
    			switch(rowData["EXECUT_STATUS"]){
    			case "00":
    				buttonText = "전송";
    				btnClass = "btn-info";
    				btnStyle += "background-color:#0080a3;";
    				break;
    			case "10":
    				buttonText = "접수";
    				btnClass = "btn-info";
    				btnStyle += "background-color:#0080a3;";
    				break;
    			case "20":
    				buttonText = "오류통보";
    				btnClass = "btn-danger ";
    				btnStyle += "background-color:#d40000;";
    				break;
    			case "30":
    				buttonText = "보완통보";
    				btnClass = "btn-danger ";
    				btnStyle += "background-color:#d40000;";	
    				break;
    			case "40":
    				buttonText = "자료제출요청통보";
    				btnClass = "btn-danger ";
    				btnStyle += "background-color:#d40000;";
    				break;
    			case "50":
    				buttonText = "완료통보";
    				btnClass = "btn-success";
    				btnStyle += "background-color:#49a900;";
    				break;
    			case "60":
    				buttonText = "지급통보";
    				btnClass = "btn-success";
    				btnStyle += "background-color:#49a900;";
    				break;
    			default:
    				btnClass = "btn-default";
    				btnStyle = "border-color: #ffb100; background-color: #ffb100; font-weight:bold;";
    				break;
    			}
    			
    			return "<a class='btn "+btnClass+" btn-border tuiGrid-toolbar-freeColor-button' style='"+btnStyle+"'"  
    			+ " href=\"javascript:DB008.transStatusDetail('"+rowData["PRESENTN_NO"]+"');\" title=\"상세내용 확인하려면 클릭하세요\">" + buttonText + '</a>';	
    		}

            this.transStatusDetail = function() {
            	KpackageOBJ.tuiGrid.uncheckAll("oTui_DB008_List");
    			KpackageOBJ.tuiGrid.check("oTui_DB008_List",KpackageOBJ.tuiGrid.getSelectedRowKey("oTui_DB008_List"));
    			DB008.unipassStatusPopup();
            }

            this.unipassStatusPopup = function() {
                var rowDatas = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB008_List");

                if (rowDatas.length == 0) {
                    alert("선택된 데이터가 없습니다.");
                    return;
                }

                if (rowDatas.length > 1) {
                    alert("1개의 데이터만 선택할 수 있습니다.");
                    return;
                }

                var rowData = rowDatas[0];
                if ("00" == rowData.EXECUT_STATUS) {
                    alert("미접수, 전송 단계에서는 상태를 조회할 수 없습니다.");
                    return;
                }

                var getParams = "?DIALOG_ID=" + "dialog_unipassStatusPopup" + "&PGMID=" + "unipassStatusPopup" + "&FORM_ID=" + "unipassStatusPopup" + "&EXECUT_STATUS=" + rowData.EXECUT_STATUS + "&SUBMIT_NO=" + rowData.SUBMIT_NO + "&PRESENTN_NO=" + rowData.PRESENTN_NO;
                
                if(!oUtil.isNull(rowData.REGIST_RCEPT_NO)){
					getParams += "&REGIST_RCEPT_NO=" + rowData.REGIST_RCEPT_NO;
				}

                KpackageOBJ.dialog.open("dialog_unipassStatusPopup", "유니패스 전송상태", "/drawbackDoc/unipassStatusPopup" + getParams, 1000, 700);
            }

            this.retrieve_DB008List = function() {

                var param = {
                    "SEARCH_FROM_DATE" : KpackageOBJ.object.getFormValue("DB008-form", "SEARCH_FROM_DATE"),
                    "SEARCH_TO_DATE" : KpackageOBJ.object.getFormValue("DB008-form", "SEARCH_TO_DATE"),
                    "HS_CODE" : KpackageOBJ.object.getFormValue("DB008-form", "HS_CODE"),
                    "REGIST_RCEPT_NO" : KpackageOBJ.object.getFormValue("DB008-form", "REGIST_RCEPT_NO"),
                    "ITEM_CODE" : KpackageOBJ.object.getFormValue("DB008-form", "ITEM_CODE"),
                    "CUSTOMER_CODE" : KpackageOBJ.object.getFormValue("DB008-form", "CUSTOMER_CODE"),
                    "PRESENTN_NO" : KpackageOBJ.object.getFormValue("DB008-form", "PRESENTN_NO"),
                    "SEARCH_TYPE" : KpackageOBJ.object.getFormValue("DB008-form", "SEARCH_TYPE"),
                    "SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("DB008-form", "SEARCH_KEY_WORD"),
                    "SEARCH_OPTION" : KpackageOBJ.object.getFormValue("DB008-form", "SEARCH_OPTION"),
                    "SEARCH_ISSUE_TYPE" : KpackageOBJ.object.getFormValue("DB008-form", "SEARCH_ISSUE_TYPE"),
                    "EXECUT_STATUS" : KpackageOBJ.object.getFormValue("DB008-form", "EXECUT_STATUS")
                };

                KpackageOBJ.tuiGrid.retrieve("oTui_DB008_List", "/drawback/retrieve_DB008List", param);

            }

            this.receiveUnipass = function() {

                var receiveFile = "https://<%=serverFullUrl%>/common/unipassReceiveData";
                var addparameter = "COMPANY_CODE=${sessionScope._sessionUser.COMPANY_CODE}&DIVISION_CODE=${sessionScope._sessionUser.DIVISION_CODE}";
                KPMGUnipassObj.ReceiveDoc_Create(); //ReceiveDoc 객체 생성
                KPMGUnipassObj.ReceiveDoc_SetUserID("${sessionScope._sessionUser.UNIPASS_ID}"); //관세청유니패스에 등록되 아이디
                KPMGUnipassObj.ReceiveDoc_SetCbtID("${sessionScope._sessionUser.UNIPASS_DOC_BOX_CODE}"); //관세청유니패스에 등록되 문서함번호
                KPMGUnipassObj.ReceiveDoc_UploadURL(receiveFile + "?" + addparameter); //결과 XML 업로드

                KPMGUnipassObj.ReceiveDoc_Call();//결과 수신

                var code = KPMGUnipassObj.ReceiveDoc_GetErrorCode();//에러 코드
                var message = KPMGUnipassObj.ReceiveDoc_GetErrorMessage();//에러 메시지

                alert("코드[" + code + "] : " + message);

                KPMGUnipassObj.ReceiveDoc_Delete(); //ReceiveDoc 객체 해제
                
                DB008.retrieve_DB008List();
            }

            this.openDetailPage = function(rowKey) {
                var rowData = KpackageOBJ.tuiGrid.getRowValues("oTui_DB008_List", rowKey);

                var getParams = "?DIALOG_ID=" + "dialog_DB00801" + "&PGMID=" + "DB00801" + "&PRESENTN_NO=" + rowData.PRESENTN_NO + "&DIVISION_CODE=" + rowData.DIVISION_CODE + "&ISSUE_TYPE=" + rowData.ISSUE_TYPE;
                if ("02" == rowData.ISSUE_TYPE) {
                    KpackageOBJ.dialog.open("dialog_DB00801", "기납증 상세조회", "/db-00801" + getParams, 1250, 750);
                } else {
                    KpackageOBJ.dialog.open("dialog_DB00801", "분증 상세조회", "/db-00802" + getParams, 1000, 700);
                }

            }
            
            this.openSalesData = function(){
                var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB008_List");
                if(rowData.length == 0){
                    alert("선택된 데이터가 없습니다.");
                    return;
                }
                if(rowData.length > 1){
                    alert("1개의 데이터만 선택할 수 있습니다.");
                    return;
                }
                
                
                if(rowData[0]["ISSUE_TYPE"] != "02"){
                	alert("기납증 데이터만 선택 할 수 있습니다.");
                    return;
                }
                
                
                
                var getParams = "?DIALOG_ID="                  + "dialog_DB00803"
                                + "&PGMID="                    + "DB00803"
                                + "&PRESENTN_NO="               + rowData[0].PRESENTN_NO
                            ;

                KpackageOBJ.dialog.open("dialog_DB00803", "매출정보 조회", "/drawback/initSalesDataPopup" + getParams, 1100, 550);
            }

        }

        $(document).ready(function() {
            pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
            DB008.Initialize_viewObject(); // 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
            DB008.renderTuiGrid();
        });
    </script>
</body>
</html>