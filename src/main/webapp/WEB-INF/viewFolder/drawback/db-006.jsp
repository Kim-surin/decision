<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	/**********************************************************************************************
	* PGM ID : DB006
	* PGM Name : 수출확정
	* Desc : 수출확정을 통해 해당 수출건에 대한 환급신청서를 작성하는 프로그램 
	*
	**********************************************************************************************/

%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<style>
	.db006_rowColor{
	background-color:#0091DA;
	color:#fff;
	font-weight:bold;
	}
</style>
<body>
<div id="content">
	<section id="widget-grid-DB006" class="">
		<form:form id="DB006-form" class="s4-form" novalidate="novalidate" action="/db-002" method="post">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
					<div class="table-responsive" >
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
										<input type="text" id="CAL_F_SEARCH_DATE"  name="CAL_F_SEARCH_DATE" class="inputText has-month-picker" searchfnc="DB006.retrieve_DB006List"/>
										<span class="fromTo-Dash">~</span>
										<input type="text" id="CAL_T_SEARCH_DATE"  name="CAL_T_SEARCH_DATE" class="inputText has-month-picker" searchfnc="DB006.retrieve_DB006List"/>
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
                                       <input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="DB006.retrieve_DB006List"/>
									</td>
									<td class="no-pd">
									   <div class="input-group-btn">
					                        <button class="btn-default btn-primary btn-custom-search" style="padding: 7px 0px;" type="button" onclick="javascript:KpackageOBJ.object.switchFilter(this,'DB006');">
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
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:DB006.retrieve_DB006List();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			</div>
			<div id="DB006-HIDDEN-FILTER" class="row-extends row switchFilter" >
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <colgroup>
                                <col style="width: 120px;" />
                                <col style="width: 25%;" />
                                <col style="width: 120px;" />
                                <col style="width: 25%;" />
                                <col style="width: 120px;" />
                                <col style="width: " />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th><spring:message code='HS CODE' /></th>
                                    <td>
                                        <input type="text" id="HS_CODE"  name="HS_CODE" style="width:110px" class="inputText" maxlength="10" searchfnc="DB006.retrieve_DB006List"/>
                                    </td>
                                    <th><spring:message code='수출신고번호' /></th>
                                    <td>
                                        <input type="text" id="XPORT_STTEMNT_NO"  name="XPORT_STTEMNT_NO" style="width:99%" class="inputText" searchfnc="DB006.retrieve_DB006List"/>
                                        
                                    </td>
                                    <th><spring:message code='플렌트' /></th>
                                    <td>
                                        <select class="form-control searchSelect" id="DIVISION_CODE" name="DIVISION_CODE" style="width:110px"></select>
                                    </td>
                                </tr>
                                <tr>
                                    <th><spring:message code='제품코드' /></th>
                                    <td>
                                        <input type="text" id="ITEM_CODE"  name="ITEM_CODE" style="width:99%" class="inputText" searchfnc="DB006.retrieve_DB006List"/>
                                    </td>
                                    <th><spring:message code='제조자' /></th>
                                    <td>
                                        <input type="text" id="MANUFAC_NAME"  name="MANUFAC_NAME" style="width:99%" class="inputText" searchfnc="DB006.retrieve_DB006List"/>
                                    </td>
                                    <th><spring:message code='확정구분' /></th>
                                    <td>
                                        <select class="form-control searchSelect" id="CONFIRM_YN" name="CONFIRM_YN" style="width:110px"></select>
                                    </td>
                                </tr>
                                <tr>
                                    <th><spring:message code='수출거래구분' /></th>
                                    <td colspan="5">
                                        <select class="form-control searchSelect" id="XPORT_SE" name="XPORT_SE" style="width:110px"></select>
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
				<div id="div_oTui_DB006_List" name="div_oTui_DB006_List" class="tuigrid-resizable">
					<div id="oTui_DB006_List" data-minus-height="275" data-page-size="50"></div>
					<div id="oTui_DB006_List_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>

	var DB006 = new function(){
		
		
		
		this.Initialize_viewObject = function() {

			var fromDay = KpackageOBJ.date.getCurrMonth();
			
			KpackageOBJ.monthPicker.create("DB006-form", "CAL_F_SEARCH_DATE");
			KpackageOBJ.monthPicker.setValue("DB006-form","CAL_F_SEARCH_DATE", fromDay);	
			KpackageOBJ.monthPicker.create("DB006-form", "CAL_T_SEARCH_DATE");
			KpackageOBJ.monthPicker.setValue("DB006-form","CAL_T_SEARCH_DATE", fromDay);
			
			KpackageOBJ.selectbox.create("DB006-form", "DIVISION_CODE", "/common/retrievePlantCombo", {"OPTION_ALL":"Y"}, "CODE", "NAME");
			KpackageOBJ.selectbox.create("DB006-form", "XPORT_SE",  "/common/retrieveComCdList", {"CATEGORY_CD":"ETC","OPTION_ALL":"Y"}, "CODE", "NAME");  
			
			var arrayItem = [{value:"", name:"전체"}
		    				,{value:"Y", name:"확정"}
		    				,{value:"N", name:"미확정"}];

			KpackageOBJ.selectbox.create("DB006-form", "CONFIRM_YN", "", null, "value", "name", arrayItem);
			
			arrayItem = [
				             {value:"", name:"선택하세요"}
 			                 ,{value:"ITEM_CODE", name:"제품코드"}
                             ,{value:"ITEM_NAME", name:"제품명"}
                             ,{value:"INV_NO", name:"Invoice No"}
                         ];
		    KpackageOBJ.selectbox.create("DB006-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
            
            /*Search Type Select Box Create */
            arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
                        ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
                        ,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
            
            KpackageOBJ.selectbox.create("DB006-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);

			
			
		}
		
		this.renderTuiGrid = function() {
			 
			 var colArrayInfo = [

				 	{ header: "내부관리번호"  	,name : "PRESENTN_NO"        ,width : 180, align: "center" ,hidden:false },	
				 	{ header: "수출신고번호" 	,name : "XPORT_STTEMNT_NO"      ,width : 150, align: "center" ,hidden:false, "formatter" : DB006.setConfirmYnColor },
					{ header: "수출신고수리일"   ,name : "DSPTH_DATE"  			,width : 100, align: "center" ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
					{ header: "HS CODE"    		,name : "HS_CODE"            	,width : 100, align: "center" ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.hscode10 },					
					{ header: "제조자"    		,name : "MANUFAC_NAME"          ,width : 200, align: "left" ,hidden:false },
					{ header: "거래구분"    		,name : "XPORT_SE_NAME"            	,width : 130, align: "left" ,hidden:false },					
					{ header: "결제금액"    		,name : "STTEMNT_PC_FGCRY"     	,width : 100, align: "right" ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas },
					{ header: "결제통화"    		,name : "CRNCY"     			,width : 60, align: "center" ,hidden:false },
					{ header: "수출수량"    		,name : "SUM_ITEM_QTY"          ,width : 100, align: "right" ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas },
					{ header: "단위"    			,name : "SLE_UNIT"          	,width : 60, align: "center" ,hidden:false },
					{ header: "수출신고금액"    	,name : "SUM_STTEMNT_PC_KRW"    ,width : 100, align: "right" ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas},
					{ header: "Invoice No."    	,name : "INV_NO"      			,width : 100, align: "center" ,hidden:false },
					{ header: "확정구분" 		,name : "CONFIRM_YN"      		,width : 60, align: "center" ,hidden:false },
					{ header: "최초일자"  		,name : "CREATE_DATE"        	,width : 100, align: "center" ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
					{ header: "최종일자"  		,name : "UPDATE_DATE"        	,width : 100, align: "center" ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
					{ header: "확정일자"  		,name : "CONFIRM_DATE"        	,width : 100, align: "center" ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },

					{ header: "COMPANY_CODE"  	,name : "COMPANY_CODE"       ,width : 100, align: "center" ,hidden:true },
					{ header: "EXPDECL_MANAGE_NO",name : "EXPDECL_MANAGE_NO"  ,width : 100, align: "center" ,hidden:true },
					{ header: "거래구분"    		,name : "XPORT_SE"            	,width : 130, align: "left" ,hidden:true },
					{ header: "DIVISION_CODE"  	,name : "DIVISION_CODE"      ,width : 100, align: "center" ,hidden:true }
					
					
			        
			    ];
			 
			 
			 var tools = [ {icon:"save",  title:"확정" 			,text:"매출확정" 	,func:"DB006.makeCofirmData_Extn"} //2020-04-07 잔량기준 가능한 수량 만들기 
						  ,{icon:"save",  title:"확정취소" 		,text:"확정취소" 		,func:"DB006.cencelCofirmData"}
				];
			 KpackageOBJ.tuiGrid.setButton("oTui_DB006_List", tools); // Toobar 생성

			 KpackageOBJ.tuiGrid.create("oTui_DB006_List", "/drawback/retrieve_DB006List", colArrayInfo, 'checkbox', DB006.oTui_DB006_List_onClick_Handler, DB006.oTui_DB006_List_onDblclick_Handler );
			 
		}
		
		this.oTui_DB006_List_onClick_Handler  = function(p_GridId, p_RowKey, p_ColName){}
		
		this.oTui_DB006_List_onDblclick_Handler = function(p_GridId, p_RowKey, p_ColName){
			DB006.openDetailPage(p_RowKey);
		}
		
		/**  조회버튼 클릭 */
		this.retrieve_DB006List = function() {
			
			var param = { "CAL_F_SEARCH_DATE" : KpackageOBJ.object.getFormValue("DB006-form", "CAL_F_SEARCH_DATE")
					     ,"CAL_T_SEARCH_DATE" : KpackageOBJ.object.getFormValue("DB006-form", "CAL_T_SEARCH_DATE")
						 ,"HS_CODE" : KpackageOBJ.object.getFormValue("DB006-form", "HS_CODE")
				         ,"XPORT_STTEMNT_NO" : KpackageOBJ.object.getFormValue("DB006-form","XPORT_STTEMNT_NO")
				         ,"ITEM_CODE" : KpackageOBJ.object.getFormValue("DB006-form","ITEM_CODE")
				         ,"MANUFAC_NAME" : KpackageOBJ.object.getFormValue("DB006-form","MANUFAC_NAME")
				         ,"XPORT_SE" : KpackageOBJ.object.getFormValue("DB006-form","THNG_SE")
				         ,"DIVISION_CODE" : KpackageOBJ.object.getFormValue("DB006-form","DIVISION_CODE")
				         ,"CONFIRM_YN" : KpackageOBJ.object.getFormValue("DB006-form","CONFIRM_YN")
				         , "SEARCH_TYPE" : KpackageOBJ.object.getFormValue("DB006-form","SEARCH_TYPE")
                         , "SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("DB006-form", "SEARCH_KEY_WORD")
                         , "SEARCH_OPTION" : KpackageOBJ.object.getFormValue("DB006-form","SEARCH_OPTION")
                         , "ISSUE_TYPE" : KpackageOBJ.object.getFormValue("DB006-form","ISSUE_TYPE")
						};

			
			KpackageOBJ.tuiGrid.retrieve("oTui_DB006_List", "/drawback/retrieve_DB006List", param);
			
		}
		
		/** 상세페이지 호출 */
		this.openDetailPage = function(rowKey){
			var rowData = KpackageOBJ.tuiGrid.getRowValues("oTui_DB006_List", rowKey);
			
			var getParams = "?DIALOG_ID="       		+ "dialog_DB00601"
					        + "&PGMID="         		+  "DB00601"
					        + "&EXPDECL_MANAGE_NO="     +  rowData.EXPDECL_MANAGE_NO
					        + "&DIVISION_CODE="     	+  rowData.DIVISION_CODE
					        + "&XPORT_STTEMNT_NO="      +  rowData.XPORT_STTEMNT_NO
					        + "&HS_CODE="      			+  rowData.HS_CODE
					        + "&CONFIRM_YN="         	+  rowData.CONFIRM_YN;
					        
			KpackageOBJ.dialog.open("dialog_DB00601", "수출신고 조회 상세", "/db-00601" + getParams, 1250, 480);
			
		}
		
		this.makeCofirmData = function(){
			DB006.makeCofirmDataAction("NORMAL");
		}
		this.makeCofirmData_Extn = function(){
			//2020-04-07 잔량기준 가능한 수량 만들기 
			DB006.makeCofirmDataAction("EXTN");
		}
		
		this.makeCofirmData_Extn_FormTo = function(){
			//2020-04-07 잔량기준 가능한 수량 만들기 
			DB006.makeCofirmDataFromToAction("FROMTO");
		}
		
		this.makeCofirmDataFromToAction = function(arg){
			
			if(confirm("현재 검색조건에 해당하는 범위에 대해서 모두 환급신청서를 작성합니다. \n 실행하시겠습니까?")){
				var param = { "CAL_F_SEARCH_DATE" : KpackageOBJ.object.getFormValue("DB006-form", "CAL_F_SEARCH_DATE")
					     ,"CAL_T_SEARCH_DATE" : KpackageOBJ.object.getFormValue("DB006-form", "CAL_T_SEARCH_DATE")
						 ,"HS_CODE" : KpackageOBJ.object.getFormValue("DB006-form", "HS_CODE")
				         ,"XPORT_STTEMNT_NO" : KpackageOBJ.object.getFormValue("DB006-form","XPORT_STTEMNT_NO")
				         ,"ITEM_CODE" : KpackageOBJ.object.getFormValue("DB006-form","ITEM_CODE")
				         ,"MANUFAC_NAME" : KpackageOBJ.object.getFormValue("DB006-form","MANUFAC_NAME")
				         ,"XPORT_SE" : KpackageOBJ.object.getFormValue("DB006-form","THNG_SE")
				         ,"DIVISION_CODE" : KpackageOBJ.object.getFormValue("DB006-form","DIVISION_CODE")
				         ,"CONFIRM_YN" : KpackageOBJ.object.getFormValue("DB006-form","CONFIRM_YN")
				         , "SEARCH_TYPE" : KpackageOBJ.object.getFormValue("DB006-form","SEARCH_TYPE")
	                    , "SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("DB006-form", "SEARCH_KEY_WORD")
	                    , "SEARCH_OPTION" : KpackageOBJ.object.getFormValue("DB006-form","SEARCH_OPTION")
	                    , "ISSUE_TYPE" : KpackageOBJ.object.getFormValue("DB006-form","ISSUE_TYPE")
						};
				
				KpackageOBJ.ajax.doSubmit("/drawback/confirm_DB006_xportList_extn2", param, DB006.makeCofirmData_callback);
			}
			
			
		}
		
		/** 확정데이터 생성*/
		this.makeCofirmDataAction = function(workType){
			var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB006_List");
			
			var process_flag = true;
			var process_message = "";
			if(rowData.length < 1){
				process_message = "확정 대상을 선택해 주세요";
				process_flag = false;
			}
			if(process_flag){
				for(var inx = 0; inx < rowData.length; inx++){
					var row = rowData[inx];
					if("Y" == row.CONFIRM_YN ){
						process_flag = false;
						process_message = "확정되지 않은 데이터만 확정할 수 있습니다.";
						break;
					}
				}
			}

			if(process_flag){
				if("EXTN" == workType){
					//2020-04-07 잔량기준 가능한 수량 만들기 
					KpackageOBJ.ajax.doSubmit("/drawback/confirm_DB006_xportList_extn", rowData, DB006.makeCofirmData_callback);
				}else{
					KpackageOBJ.ajax.doSubmit("/drawback/confirm_DB006_xportList", rowData, DB006.makeCofirmData_callback);
				}
					
			}else{
				alert(process_message);
			}
			
		}
		
		
		
		this.makeCofirmData_callback = function(result){
			alert(result.message);
			DB006.retrieve_DB006List();
		}
		
		/** 확정데이터 취소*/
		this.cencelCofirmData = function(){
			//To Do. 신청이 들어가거나 완료되지 않은 건에 대해서 취소 해야하므로 체크로직 필요
			var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB006_List");
			var nonConfirmDataYn = false;
			for(var inx = 0; inx < rowData.length; inx++){
				var rows = rowData[inx];
				if("Y" != rows.CONFIRM_YN){
					nonConfirmDataYn = true;
					break;
				}
			}
			if(nonConfirmDataYn){
				KpackageOBJ.object.alert("확정된 데이터만 확정취소 할 수 있습니다.");
			}else{
				KpackageOBJ.ajax.doSubmit("/drawback/cencel_DB006_xportList", rowData, DB006.cencelCofirmData_callback);
			}
			
		}
		
		
		this.cencelCofirmData_callback = function(result){
			alert(result.message);
			DB006.retrieve_DB006List();
		}
		
		
		//확정구분 Formatter
		this.setConfirmYnColor = function(rowData){
			if (rowData.row["CONFIRM_YN"] == "Y") {
				KpackageOBJ.tuiGrid.getGrid("oTui_DB006_List").addCellClassName(rowData.rowKey,"CONFIRM_YN","db006_rowColor");
			} else {
				KpackageOBJ.tuiGrid.getGrid("oTui_DB006_List").removeCellClassName(rowData.rowKey,"CONFIRM_YN","db006_rowColor");
			}
			return rowData.value;
		};
		
		
	
	}
	
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB006.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		DB006.renderTuiGrid();
	});
	
	
</script>
</body>
</html>