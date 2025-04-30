<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>    
<!DOCTYPE html>
<html>
<head></head>
<body>
<div id="content">
	
	<section id="widget-grid-SM008">
		
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-8">
				<div class="col-sm-12 text-right"  style="margin-bottom: 10px;">
					<button id="retrieveGrid" name="retrieveGrid" class="btn btn btn-primary" onclick="SM008.retrieve_List();">새로고침</button>
				</div>
				<div id="div_oTui_SM008_01" name="div_oTui_SM008_01" class="tuigrid-resizable">
					<div id="oTui_SM008_01" data-minus-height="310" ></div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
				<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-SM008-0" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
						<h2>인터페이스 속성</h2>
					</header>

					<!-- widget div-->
					<div role="content">
	
						<!-- widget edit box -->
						<div class="jarviswidget-editbox">
							<!-- This area used as dropdown edit box -->
	
						</div>
						<!-- end widget edit box -->
	
						<!-- widget content -->
						<div class="widget-body">
							
							<div class="widget-body-toolbar">
								<div class="row">
									<div class="col-sm-12 text-right">
										<button id="BTN_RECOVER_IF" name="BTN_RECOVER_IF" class="btn btn btn-primary" onclick="SM008.recoverInterfaceStatus();" style="display: none;">인터페이스 상태 복원</button>
										<!-- <button id="BTN_AUTHOR_NEW"  name="BTN_AUTHOR_NEW"  class="btn btn btn-primary">신규등록</button> -->
										<button id="BTN_IF_SAVE" name="BTN_IF_SAVE" class="btn btn btn-primary" onclick="SM008.saveInterfaceMaster();">저장</button>
										<!-- <button id="BTN_AUTHOR_DEL"  name="BTN_AUTHOR_DEL"  class="btn btn btn-primary">삭제</button> -->
									</div>
								</div>
							</div>
							<form:form id="SM008-form" class="s4-form" novalidate="novalidate" onsubmit="return false;">
							
							<table class="table table-bordered">  
			            		<thead></thead>
			            		<tbody>
									<tr>
						                <th>인터페이스 코드</td>
						                <td style="width:250px"><input type="text" id="IF_CODE" name="IF_CODE" class="inputText ov_readonly" style="width: 100%; background-color:#e6e6e6;" readonly="readonly"></td>
			              			</tr>
			              			<tr>
						                <th>인터페이스 명</td>
						                <td style="width:250px"><input type="text" id="IF_NAME" name="IF_NAME" class="inputText" style="width: 100%"></td>
			              			</tr>
			              			<tr>
						                <th>소스테이블</td>
						                <td style="width:250px"><input type="text" id="SOURCE_TABLE" name="SOURCE_TABLE" class="inputText" style="width: 100%"></td>
			              			</tr>
			              			<tr>
						                <th>인터페이스타입</td>
						                <td style="width:250px">
						                	<select class="form-control searchSelect" id="IF_TYPE" name="IF_TYPE" style="width:110px">
												<option value="OP">On-premise</option>	          									
												<option value="OD">On-demand</option>
											</select>	
						                </td>
			              			</tr>
			              			<tr>
						                <th>결과코드컬럼</td>
						                <td style="width:250px"><input type="text" id="RETURN_COLUMN_NAME" name="RETURN_COLUMN_NAME" class="inputText" style="width: 100%"></td>
			              			</tr>
			              			<tr>
						                <th>결과메세지컬럼</td>
						                <td style="width:250px"><input type="text" id="RETURN_MSG_COLUMN_NAME" name="RETURN_MSG_COLUMN_NAME" class="inputText" style="width: 100%"></td>
			              			</tr>
									<tr>
						                <th>사용여부</td>
						                <td>
						                	<select class="form-control searchSelect" id="USING_YN" name="USING_YN" style="width:110px">
												<option value="N">No</option>	          									
												<option value="Y">Yes</option>
											</select>
						                </td>
			              			</tr>
			              			<tr>
						                <th>비고</td>
						                <td style="width:250px">
						                	<textarea name="REMARK" id="REMARK" style="width: 100%;" rows="5"></textarea>
						                </td>
			              			</tr>

			            		</tbody>
			          		</table>
			          		
							</form:form>
						</div>
						<!-- end widget content -->
	
					</div>
					<!-- end widget div -->

				</div>
				<!-- end widget -->
				<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-SM008-0" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
						<h2 id="H2_INTERFACE_NAME">인터페이스 수동실행</h2>
					</header>
					<!-- widget div-->
					<div role="content">
						<!-- widget edit box -->
						<div class="jarviswidget-editbox">
							<!-- This area used as dropdown edit box -->
						</div>
						<!-- end widget edit box -->
						<!-- widget content -->
						<div class="widget-body">
							
							<div class="widget-body-toolbar">
								<div class="row">
									<div class="col-sm-12 text-right">
										<button id="BTN_IF_RUN" name="BTN_IF_RUN" class="btn btn btn-primary" onclick="SM008.runInterfaceItem();">인터페이스 수동실행</button>
									</div>
								</div>
							</div>
							<form:form id="SM008-if-form" class="s4-form" novalidate="novalidate" onsubmit="return false;">
								<input type="hidden" id="IF_CODE" name="IF_CODE"/>
								<table class="table table-bordered">  
				            		<thead></thead>
				            		<tbody>
				            			<tr>
							                <th>인터페이스 상태</td>
							                <td style="width:250px">
							                	<input type="text" id="STATUS_NAME" name="STATUS_NAME" class="inputText ov_readonly" style="width: 100%; background-color:#e6e6e6;" readonly="readonly">
							                	<input type="hidden" id="STATUS" name="STATUS"/>
							                </td>
				              			</tr>
				              			
				              			<tr name="CTRM" style="display: none;">
				              				<th>실행월</th>
				              				<td>
				              					<input type="text" id="CAL_F_CTRM_SEARCH_DATE"  name="CAL_F_CTRM_SEARCH_DATE" class="inputText has-month-picker"/>
				              				</td>
				              			</tr>
				              			<tr name="CTRM" style="display: none;">
				              				<th>종료월</th>
				              				<td>
				              					<input type="text" id="CAL_T_CTRM_SEARCH_DATE"  name="CAL_T_CTRM_SEARCH_DATE" class="inputText has-month-picker"/>
				              				</td>
				              			</tr>
				              			
				              			<tr name="DRWB" style="display: none;">
				              				<th>시작월</th>
				              				<td>
				              					<input type="text" id="CAL_F_SEARCH_DATE"  name="CAL_F_SEARCH_DATE" class="inputText has-month-picker"/>
				              				</td>
				              			</tr>
				              			
				              			<tr name="DRWB" style="display: none;">
				              				<th>종료월</th>
				              				<td>
				              					<input type="text" id="CAL_T_SEARCH_DATE"  name="CAL_T_SEARCH_DATE" class="inputText has-month-picker"/>
				              				</td>
				              			</tr>
										<tr name="IF">
							                <th>시작일자</td>
							                <td style="width:250px">
							                	<input type="text" id="CAL_START_YYYYMMDD" name="CAL_START_YYYYMMDD" class="inputText"/>
							                	<input type="hidden" id="START_YYYYMMDD" name="START_YYYYMMDD"/>
							                </td>
				              			</tr>
				              			<tr name="IF">
							                <th>종료일자</td>
							                <td style="width:250px">
							                	<input type="text" id="CAL_END_YYYYMMDD" name="CAL_END_YYYYMMDD" class="inputText"/>
							                	<input type="hidden" id=END_YYYYMMDD" name="END_YYYYMMDD"/>
							                </td>
				              			</tr>
				            		</tbody>
				          		</table>
							</form:form>
						</div>
					</div>
				</div>				
			</div>
		</div>
		
	</section>
	
</div>

<!-- end widget grid -->

<script type="text/javascript">

/*
 * BOOTSTRAP DUALLIST BOX
 */


	var oDualList;
	var SM008 = new function() {
		this.initialize_viewObject = function(){
			
			var fromDay = KpackageOBJ.date.getCurrMonth() + "01";
			var toDay = KpackageOBJ.date.getCurrMonth() + KpackageOBJ.date.lastDay(KpackageOBJ.date.getCurrMonth());
			
			KpackageOBJ.calendar.create("SM008-if-form", "CAL_START_YYYYMMDD");
			KpackageOBJ.calendar.setValue("SM008-if-form","CAL_START_YYYYMMDD", fromDay);
			KpackageOBJ.object.setFormValue("SM008-if-form","START_YYYYMMDD", fromDay);
			
			KpackageOBJ.calendar.create("SM008-if-form", "CAL_END_YYYYMMDD");
			KpackageOBJ.calendar.setValue("SM008-if-form","CAL_END_YYYYMMDD", toDay);
			KpackageOBJ.object.setFormValue("SM008-if-form","END_YYYYMMDD",toDay)
			
			
			KpackageOBJ.monthPicker.create("SM008-if-form", "CAL_F_SEARCH_DATE");
			KpackageOBJ.monthPicker.setValue("SM008-if-form","CAL_F_SEARCH_DATE", fromDay);	
			KpackageOBJ.monthPicker.create("SM008-if-form", "CAL_T_SEARCH_DATE");
			KpackageOBJ.monthPicker.setValue("SM008-if-form","CAL_T_SEARCH_DATE", fromDay);
			
			KpackageOBJ.monthPicker.create("SM008-if-form", "CAL_F_CTRM_SEARCH_DATE");
			KpackageOBJ.monthPicker.setValue("SM008-if-form","CAL_F_CTRM_SEARCH_DATE", fromDay);
			
			KpackageOBJ.monthPicker.create("SM008-if-form", "CAL_T_CTRM_SEARCH_DATE");
			KpackageOBJ.monthPicker.setValue("SM008-if-form","CAL_T_CTRM_SEARCH_DATE", fromDay);
			
			
			
			
		}
		
		this.initialize_TuiGrid = function(){
			var colArrayInfo = [

					{"header" :"회사코드",	    "name" :"COMPANY_CODE",            "width" : 100   ,"align" :"center"    ,"hidden" : true},
					{"header" :"상태코드",	    "name" :"STATUS",            "width" : 100   ,"align" :"center"    ,"hidden" : true},
					{"header" :"상태",	        "name" :"STATUS_NAME",            "width" : 120   ,"align" :"center"    ,"hidden" : false, formatter : SM008.transStatus_CustomFormatter},
					{"header" :"인터페이스 코드", "name" :"IF_CODE",                 "width" : 100   ,"align" :"center"    ,"hidden" : false},
					{"header" :"인터페이스 명",   "name" :"IF_NAME",                 "width" : 180   ,"align" :"center"    ,"hidden" : false},
					{"header" :"소스테이블",     "name" :"SOURCE_TABLE",            "width" : 180   ,"align" :"center"    ,"hidden" : false},
					{"header" :"인터페이스타입",  "name" :"IF_TYPE",                  "width" : 100   ,"align" :"center"    ,"hidden" : false},
					{"header" :"결과코드컬럼",    "name" :"RETURN_COLUMN_NAME",      "width" : 100   ,"align" :"center"    ,"hidden" : false},
					{"header" :"결과메세지컬럼",  "name" :"RETURN_MSG_COLUMN_NAME",   "width" : 100   ,"align" :"center"    ,"hidden" : false},
					{"header" :"비고",          "name" :"REMARK",                "width" : 100   ,"align" :"center"    ,"hidden" : false},
					{"header" :"사용여부",       "name" :"USING_YN",               "width" : 80   ,"align" :"center"    ,"hidden" : false},
					{"header" :"생성일자",       "name" :"CREATE_DATE",            "width" : 100   ,"align" :"center"    ,"hidden" : false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
					{"header" :"생성자",         "name" :"CREATE_BY",             "width" : 100   ,"align" :"center"    ,"hidden" : false},
					{"header" :"수정일자",       "name" :"UPDATE_DATE",            "width" : 100   ,"align" :"center"    ,"hidden" : false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
					{"header" :"수정자",         "name" :"UPDATE_BY",             "width" : 100   ,"align" :"center"    ,"hidden" : false}

			    ];
			 
			KpackageOBJ.tuiGrid.create("oTui_SM008_01","/sys/retrieve_interfaceMaster", colArrayInfo, "", null, SM008.onDblClick_oTui_Grid);
	    	
		};
		
		this.onDblClick_oTui_Grid = function(gridId, rowkey, colName){
			var rowData = KpackageOBJ.tuiGrid.getSelectedRowlValue(gridId, rowkey);
			
			if("N" == rowData["STATUS"]){
				$("#BTN_RECOVER_IF").hide();
			}else{
				$("#BTN_RECOVER_IF").show();
			}
				
			KpackageOBJ.object.setFormValue("SM008-form","IF_CODE",                 rowData["IF_CODE"]);
			KpackageOBJ.object.setFormValue("SM008-form","IF_NAME",                 rowData["IF_NAME"]);
			KpackageOBJ.object.setFormValue("SM008-form","SOURCE_TABLE",            rowData["SOURCE_TABLE"]);
			KpackageOBJ.object.setFormValue("SM008-form","IF_TYPE",                 rowData["IF_TYPE"]);
			KpackageOBJ.object.setFormValue("SM008-form","RETURN_COLUMN_NAME",      rowData["RETURN_COLUMN_NAME"]);
			KpackageOBJ.object.setFormValue("SM008-form","RETURN_MSG_COLUMN_NAME",  rowData["RETURN_MSG_COLUMN_NAME"]);
			KpackageOBJ.object.setFormValue("SM008-form","REMARK",                  rowData["REMARK"]);
			KpackageOBJ.object.setFormValue("SM008-form","USING_YN",                rowData["USING_YN"]);
			
			/** 수동실행 필드 시작 */
			
			KpackageOBJ.object.setFormValue("SM008-if-form","IF_CODE",                rowData["IF_CODE"]);
			KpackageOBJ.object.setFormValue("SM008-if-form","STATUS",                 rowData["STATUS"]);
			KpackageOBJ.object.setFormValue("SM008-if-form","STATUS_NAME",            rowData["STATUS_NAME"]);
			
			if("RFC099" === rowData["IF_CODE"]){
				$("tr[name='IF']").hide();
				$("tr[name='CTRM']").hide();
				$("tr[name='DRWB']").show();	
			}else if("RFC098" === rowData["IF_CODE"] || "RFC097" === rowData["IF_CODE"]){
				$("tr[name='IF']").hide();
				$("tr[name='DRWB']").hide();;	
			    $("tr[name='CTRM']").show()
			}else{
				$("tr[name='DRWB']").hide();
				$("tr[name='CTRM']").hide();
				$("tr[name='IF']").show();	
			}
			
			
			
			
			
			$("#H2_INTERFACE_NAME").html("인터페이스 수동실행 - " + rowData["IF_NAME"]);
		};
		
		this.retrieve_List = function(){
			var param = KpackageOBJ.data.makePostData("SM008-form");
			KpackageOBJ.tuiGrid.retrieve("oTui_SM008_01", "", param);
		}
		
		this.saveInterfaceMaster = function(){
			if(KpackageOBJ.object.getFormValue("SM008-form","IF_CODE") == ""){
				KpackageOBJ.object.alert("저장 할 데이터가 없습니다.");
				return false;
			}
			
			var params = {
					"IF_CODE"                  : KpackageOBJ.object.getFormValue("SM008-form","IF_CODE")
					,"IF_NAME"                 : KpackageOBJ.object.getFormValue("SM008-form","IF_NAME")
					,"SOURCE_TABLE"            : KpackageOBJ.object.getFormValue("SM008-form","SOURCE_TABLE")
					,"IF_TYPE"                 : KpackageOBJ.object.getFormValue("SM008-form","IF_TYPE")
					,"RETURN_COLUMN_NAME"      : KpackageOBJ.object.getFormValue("SM008-form","RETURN_COLUMN_NAME")
					,"RETURN_MSG_COLUMN_NAME"  : KpackageOBJ.object.getFormValue("SM008-form","RETURN_MSG_COLUMN_NAME")
					,"REMARK"                  : KpackageOBJ.object.getFormValue("SM008-form","REMARK")
					,"USING_YN"                : KpackageOBJ.object.getFormValue("SM008-form","USING_YN")
			};
			
			KpackageOBJ.ajax.doSubmit("/sys/update_interfaceMaster", params, SM008.updateComAuthorGroupCallback);	
		}
		
		this.updateComAuthorGroupCallback = function(result){
			SM008.retrieve_List();
			KpackageOBJ.object.alert(result.message);
		}
		
		this.recoverInterfaceStatus= function(){
			if(KpackageOBJ.object.getFormValue("SM008-form","IF_CODE") == ""){
				KpackageOBJ.object.alert("인터페이스 코드를 선택해주세요.");
				return false;
			}
			
			if(confirm("인터페이스 상태를 복원하시겠습니까?")){
				var params = { "IF_CODE"                  : KpackageOBJ.object.getFormValue("SM008-form","IF_CODE") }; 
				KpackageOBJ.ajax.doSubmit("/sys/update_interfaceMasterStatus", params, SM008.recoverInterfaceStatusCallback);	
			}else{
				KpackageOBJ.object.alert("작업이 취소되었습니다.");
			}
				
		}
		
		this.recoverInterfaceStatusCallback = function(result){
			SM008.retrieve_List();
			KpackageOBJ.object.alert(result.message);
		}
		
		this.runInterfaceItem = function(){
			if(KpackageOBJ.object.getFormValue("SM008-if-form","IF_CODE") == ""){
				KpackageOBJ.object.alert("인터페이스 코드를 선택해주세요.");
				return false;
			}
			
			if(KpackageOBJ.object.getFormValue("SM008-if-form","STATUS") == "Y"){
				KpackageOBJ.object.alert("인터페이스가 이미 실행중입니다.");
				return false;
			}
			
			if(confirm("수동으로 인터페이스를 수행합니다. 계속하시겠습니까?")){
			
				var params = {
						"IF_CODE"                  : KpackageOBJ.object.getFormValue("SM008-if-form","IF_CODE")
						,"START_YYYYMMDD"          : KpackageOBJ.object.getFormValue("SM008-if-form","START_YYYYMMDD")
						,"END_YYYYMMDD"            : KpackageOBJ.object.getFormValue("SM008-if-form","END_YYYYMMDD")
						,"STATUS"                  : KpackageOBJ.object.getFormValue("SM008-if-form","STATUS")
						
						,"CAL_F_SEARCH_DATE" 		: KpackageOBJ.object.getFormValue("SM008-if-form", "CAL_F_SEARCH_DATE")
					    ,"CAL_T_SEARCH_DATE" 		: KpackageOBJ.object.getFormValue("SM008-if-form", "CAL_T_SEARCH_DATE")
					    
					    ,"CAL_F_CTRM_SEARCH_DATE" 	: KpackageOBJ.object.getFormValue("SM008-if-form", "CAL_F_CTRM_SEARCH_DATE").replace(/-/gi, "")
					    ,"CAL_T_CTRM_SEARCH_DATE" 	: KpackageOBJ.object.getFormValue("SM008-if-form", "CAL_T_CTRM_SEARCH_DATE").replace(/-/gi, "")
					      
					    
				};
				
				KpackageOBJ.ajax.doSubmit("/sys/runInterfaceItem", params, SM008.runInterfaceItemCallback);	
			}
		}
		
		this.transStatus_CustomFormatter = function(value){
			var btnClass = "btn-primary";
			var btnStyle = "padding: 2px 28px; font-color:#ffffff;";		
			var rowData = value.row;
			if("Y" == rowData["STATUS"]){
				btnClass = "btn-default";
				btnStyle = "border-color: #ffb100; background-color: #ffb100; font-weight:bold;";
			}
			
			return "<span class='"+btnClass+" btn-border tuiGrid-toolbar-freeColor-button' style='"+btnStyle+"'"  
			+ " href=\"javascript:void(0);\" title=\"상세내용 확인하려면 클릭하세요\">" + rowData["STATUS_NAME"] + '</span>';	
		}
		
		this.runInterfaceItemCallback = function(result){
			if(result.success){
				KpackageOBJ.object.alert("인터페이스 수행을 요청하였습니다.");
				SM008.retrieve_List();	
			}else{
				KpackageOBJ.object.alert(result.message);
				SM008.retrieve_List();
			}
			
		}
	}

	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		SM008.initialize_viewObject();	// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		SM008.initialize_TuiGrid();		// Toast Grid Render
		SM008.retrieve_List();
	});

</script>
	
</body>
</html>