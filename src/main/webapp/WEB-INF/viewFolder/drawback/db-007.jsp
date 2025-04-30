<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	/**********************************************************************************************
	* PGM ID : DB007
	* PGM DESC : 매출확정(내수)
	* Remark : 
	*
	**********************************************************************************************/

%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<style>
	.db007_rowColor{
	background-color:#0091DA;
	color:#fff;
	font-weight:bold;
	}
</style>
<body>
<div id="content">
	<section id="widget-grid-DB007" class="">
		<form:form id="DB007-form" class="s4-form" novalidate="novalidate" action="/db-002" method="post">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
					<div class="table-responsive">
						<table class="table table-bordered table-search-date">
							<colgroup>
								<col style="width: 100px;" />
								<col style="width: ;" />
								<col style="width: 5px;" />
							</colgroup>
							<tbody>
								<tr>
									<td><spring:message code='기준년월' /></td>
									<td>
										<input type="text" id="CAL_F_SEARCH_DATE"  name="CAL_F_SEARCH_DATE" class="inputText has-month-picker" searchfnc="DB007.retrieve_DB007List"/>
										<span class="fromTo-Dash">~</span>
										<input type="text" id="CAL_T_SEARCH_DATE"  name="CAL_T_SEARCH_DATE" class="inputText has-month-picker" searchfnc="DB007.retrieve_DB007List"/>
									</td>
									<td></td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-8 col-md-8 col-lg-8">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 120px;" />
								<col style="width: " />
								<col style="width: 30px;" />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="DB007.retrieve_DB007List"/>
									</td>
									<td class="no-pd">
                                       <div class="input-group-btn">
                                            <button class="btn-default btn-primary btn-custom-search" name="switchFilterBtn" style="padding: 7px 0px;" type="button" onclick="javascript:KpackageOBJ.object.switchFilter(this,'DB007');">
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
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:DB007.retrieve_DB007List();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
			
			<div id="DB007-HIDDEN-FILTER" class="row-extends row switchFilter" >
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <colgroup>
                                <col style="width: 120px;" />
                                <col style="width: 25%;" />
                                <col style="width: 120px;" />
                                <col style="width: 25%;" />
                                <col style="width: 100px;" />
                                <col style="width: " />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th><spring:message code='근거서류번호' /></th>
                                    <td>
                                        <input type="text" id="SUPT_DOC_NO"  name="SUPT_DOC_NO" style="width:99%" class="inputText" maxlength="30" searchfnc="DB007.retrieve_DB007List"/>
                                    </td>
                                    <th><spring:message code='발급구분' /></th>
                                    <td>
                                        <select class="form-control searchSelect" id="ISSUE_TYPE" name="ISSUE_TYPE" style="width:110px"/>
                                    </td>
                                    <th><spring:message code='발급상태' /></th>
                                    <td>
                                        <select class="form-control searchSelect" id="CONFIRM_YN" name="CONFIRM_YN" style="width:110px"></select>
                                    </td>
                                </tr>
                                <tr>
                                    
                                    <th><spring:message code='HS CODE' /></th>
                                    <td colspan="5">
                                        <input type="text" id="HS_CODE"  name="HS_CODE" style="width:110px" class="inputText" maxlength="10" searchfnc="DB007.retrieve_DB007List"/>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>              
                </div>
            </div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_DB007_List" name="div_oTui_DB007_List" class="tuigrid-resizable">
					<div id="oTui_DB007_List" data-minus-height="230"></div>
					<!-- <div id="oTui_DB007_List_paging"></div> -->
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>
	
	var DB007 = new function(){
		
		this.Initialize_viewObject = function() {
			
			/** 월달력 생성 */
			var fromDay = KpackageOBJ.date.getCurrMonth();
			
			KpackageOBJ.monthPicker.create("DB007-form", "CAL_F_SEARCH_DATE");
			KpackageOBJ.monthPicker.setValue("DB007-form","CAL_F_SEARCH_DATE", fromDay);	
			KpackageOBJ.monthPicker.create("DB007-form", "CAL_T_SEARCH_DATE");
			KpackageOBJ.monthPicker.setValue("DB007-form","CAL_T_SEARCH_DATE", fromDay);	
			
			/*Search Type Select Box Create */
			var arrayItem = [
				              {value:"ITEM_CODE", name:"<spring:message code='제품코드'/>"}
			                 , {value:"ITEM_NAME", name:"<spring:message code='제품명'/>"}
			                ];
			
			KpackageOBJ.selectbox.create("DB007-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			            ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("DB007-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
			
			arrayItem = [{value:"", name:"전체"}
			            ,{value:"02", name:"기납증"}
						,{value:"05", name:"분증"}];

			KpackageOBJ.selectbox.create("DB007-form", "ISSUE_TYPE", "", null, "value", "name", arrayItem);
			
			
			arrayItem = [{value:"", name:"전체"}
            ,{value:"N", name:"미사용"}
            ,{value:"U", name:"일부사용"}
            ,{value:"E", name:"모두사용"}
            ];

			 
			KpackageOBJ.selectbox.create("DB007-form", "CONFIRM_YN", "", null, "value", "name", arrayItem);
			
		}
		
		this.renderTuiGrid = function() {
			 var colArrayInfo = [
				 
				  { header : "회사코드"    		,name : "COMPANY_CODE"     	,width : 100,  align: "center" 	,hidden:true }
				 ,{ header : "플랜트"    		,name : "DIVISION_CODE"     ,width : 100,  align: "center" 	,hidden:true }
				 ,{ header : "내부관리번호"    	,name : "PRESENTN_NO"     ,width : 180,  align: "center" 	,hidden:false }
				 ,{ header : "매출번호"    		,name : "SALES_NO"     		,width : 100,  align: "center" 	,hidden:false , "formatter" : DB007.setConfirmYnColor }
				 ,{ header : "고객사 코드"    	,name : "CUSTOMER_CODE"     ,width : 100,  align: "center" 	,hidden:false }
				 ,{ header : "고객사 명"    		,name : "CUSTOMER_NAME"     ,width : 130,  align: "center" 	,hidden:false }
				 ,{ header : "매출일자"    		,name : "INVOICE_DATE"     	,width : 100,  align: "center" 	,hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter}
				 ,{ header : "제품코드(대표)"  	,name : "PRODUCT_CODE"     	,width : 100,  align: "center" 	,hidden:false }
				 ,{ header : "제품명(대표)"   	,name : "ITEM_NAME"     	,width : 250,  align: "left" 	,hidden:false }
				 ,{ header : "HS Code"    	,name : "HS_CODE"     		,width : 100,  align: "center" 	,hidden:false, "formatter" : KpackageOBJ.tuiGrid.hscode10}
				 ,{ header : "수량(대표)"    	,name : "QUANTITY"     		,width : 100,  align: "right" 	,hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas}
				 ,{ header : "금액(대표)"    	,name : "AMOUNT"     		,width : 100,  align: "right" 	,hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas}
				 ,{ header : "단가(대표)"    	,name : "UNIT_PRICE"     	,width : 100,  align: "right" 	,hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas}
				 ,{ header : "확정구분" 			,name : "CONFIRM_YN"      	,width : 60, align: "center" 	,hidden:false }
				 ,{ header : "확정일자"    		,name : "CONFIRM_DATE"     	,width : 100,  align: "center" 	,hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter}
				 

			    ];
			 
			 var tools = [ {icon:"excel", title:"엑셀다운로드" 	,text:"엑셀다운로드"	,func:"DB007.excel_DB007List"}
						  ,{icon:"save",  title:"확정" 			,text:"확정" 			,func:"DB007.makeCofirmData"}
						  ,{icon:"save",  title:"확정취소" 		,text:"확정취소" 		,func:"DB007.celcelCofirmData"}
				];
			 KpackageOBJ.tuiGrid.setButton("oTui_DB007_List", tools); // Toobar 생성

			 KpackageOBJ.tuiGrid.create("oTui_DB007_List", "/drawback/retrieve_DB007List", colArrayInfo, 'checkbox', DB007.oTui_DB007_List_onClick_Handler, DB007.oTui_DB007_List_onDblclick_Handler );
			 
		}
		
		this.oTui_DB007_List_onClick_Handler  = function(p_GridId, p_RowKey, p_ColName){}
		
		this.oTui_DB007_List_onDblclick_Handler = function(p_GridId, p_RowKey, p_ColName){
			
			DB007.openDetailPage(p_RowKey);
		}
		
		/**  조회버튼 클릭 */
		this.retrieve_DB007List = function() {
			
			var param = { "CAL_F_SEARCH_DATE" : KpackageOBJ.object.getFormValue("DB007-form", "CAL_F_SEARCH_DATE")
				        , "CAL_T_SEARCH_DATE" : KpackageOBJ.object.getFormValue("DB007-form", "CAL_T_SEARCH_DATE")
						, "SEARCH_TYPE" : KpackageOBJ.object.getFormValue("DB007-form","SEARCH_TYPE")
					 	, "SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("DB007-form", "SEARCH_KEY_WORD")
			         	, "SEARCH_OPTION" : KpackageOBJ.object.getFormValue("DB007-form","SEARCH_OPTION")
			         	, "ISSUE_TYPE" : KpackageOBJ.object.getFormValue("DB007-form","ISSUE_TYPE")
			         	, "CONFIRM_YN" : KpackageOBJ.object.getFormValue("DB007-form","CONFIRM_YN")
			         	, "HS_CODE" : KpackageOBJ.object.getFormValue("DB007-form","HS_CODE")
			         	, "SUPT_DOC_NO" : KpackageOBJ.object.getFormValue("DB007-form","SUPT_DOC_NO")
						};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_DB007_List", "", param);
			
		}
		
		
		/** 상세페이지 호출 */
		this.openDetailPage = function(rowKey){
			var rowData = KpackageOBJ.tuiGrid.getRowValues("oTui_DB007_List", rowKey);
			
			var getParams = "?DIALOG_ID="          + "dialog_DB00701"
					        + "&PGMID="            +  "DB00701"
					        + "&P_SUPT_MONTH="     +  rowData.SUPT_MONTH
					        + "&P_CUSTOMER_CODE="  +  rowData.CUSTOMER_CODE
					        + "&P_HS_CODE10="      +  rowData.HS_CODE10
					        + "&P_ITEM_CODE="      +  rowData.ITEM_CODE
					        + "&P_ISSUE_TYPE="    +  rowData.ISSUE_TYPE
					        + "&P_DIVISION_CODE="  +  rowData.DIVISION_CODE;
					        
					        
			KpackageOBJ.dialog.open("dialog_DB00701", "내수 상세 목록 조회", "/db-00701" + getParams, 1250, 480);
			
		}
		
		/** 확정데이터 생성*/
		this.makeCofirmData = function(){
			var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB007_List");
			
			var process_flag = true;
			var process_message = "";
			if(rowData.length < 1){
				process_message = "확정 대상을 선택해 주세요";
				process_flag = false;
			}
			if(process_flag){
				/* 미사용            N, 일부사용          U, 모두사용          E  */
				for(var inx = 0; inx < rowData.length; inx++){
					var row = rowData[inx];
					if("E" == row.USE_TYPE ){
						process_flag = false;
						process_message = "모두사용된 데이터는 확정할 수 없습니다.";
						break;
					}
				}
			}
			

			if(process_flag){
				//KpackageOBJ.ajax.doSubmit("/drawback/confirm_DB007_SelngList", rowData, DB007.makeCofirmData_callback);
				KpackageOBJ.ajax.doSubmit("/drawback/confirm_DB007_createCtrm", rowData, DB007.makeCofirmData_callback);
			}else{
				alert(process_message);
			}
			
		}
		
		this.makeCofirmData_callback = function(result){
			alert(result.message);
			DB007.retrieve_DB007List();
		}
		
		/** 확정데이터 취소*/
		this.celcelCofirmData = function(){
			//To Do. 신청이 들어가거나 완료되지 않은 건에 대해서 취소 해야하므로 체크로직 필요
			/* 미사용            N, 일부사용          U, 모두사용          E  */
			var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB007_List");
			
			var process_flag = true;
			var process_message = "";
			if(rowData.length < 1){
				process_message = "대상을 선택해 주세요";
				process_flag = false;
			}
			if(process_flag){
				/* 미사용            N, 일부사용          U, 모두사용          E  */
				for(var inx = 0; inx < rowData.length; inx++){
					var row = rowData[inx];
					if("N" == row.USE_TYPE ){
						process_flag = false;
						process_message = "사용되지 않은 대상은 확정취소 할 수 없습니다.";
						break;
					}
				}
			}
			

			if(process_flag){
				KpackageOBJ.ajax.doSubmit("/drawback/cancel_DB007_SelngList", rowData, DB007.makeCofirmData_callback);	
			}else{
				alert(process_message);
			}
			
			
		}
		
		this.makeCofirmData_callback = function(result){
			alert(result.message);
			DB007.retrieve_DB007List();
		}
		
		this.excel_DB007List = function(){
			
		}
		
		//확정구분 Formatter
		this.setConfirmYnColor = function(rowData){
			if (rowData.row.CONFIRM_YN == "Y") {
				KpackageOBJ.tuiGrid.getGrid("oTui_DB007_List").addCellClassName(rowData.row.rowKey,"CONFIRM_YN","db007_rowColor");
			} else {
				KpackageOBJ.tuiGrid.getGrid("oTui_DB007_List").removeCellClassName(rowData.row.rowKey,"CONFIRM_YN","db007_rowColor");
			}
			return rowData.value;
		};
	
	}
	
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB007.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		DB007.renderTuiGrid();
	});
	
	
</script>
</body>
</html>