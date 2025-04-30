<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form id="SM003-form" class="s4-form" novalidate="novalidate">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 100px;" />
								<col style="width: 25%;" />
								<col style="width: 80px;" />
								<col style="width:" />
							</colgroup>
							<tbody>
								<tr>
									<th>스케줄 구분</th>
									<td> 
										<select class="form-control searchSelect" id="SEARCH_SCHEDULE_CODE" name="SEARCH_SCHEDULE_CODE" style="width:130px"></select>
									</td>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:130px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="SM003.retrieve_Intg_History"/>
										
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:SM003.retrieve_Intg_History();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
				<div id="div_oTui_Intg_master" name="div_oTui_Intg_master" class="tuigrid-resizable">
					<div id="oTui_Intg_master" data-minus-height="270"></div>
					<div id="oTui_Intg_master_paging"></div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-12 col-md-8 col-lg-8">
				<div id="div_oTui_Intg_detail" name="div_oTui_Intg_detail" class="tuigrid-resizable">
					<div id="oTui_Intg_detail" data-minus-height="270"></div>
					<div id="oTui_Intg_detail_paging"></div>
				</div>
			</div>
		</div>
		
	
	</section>

</div>

<script>


	var SM003 = new function(){
	
		this.Initialize_viewObject = function() {
			
			
			var arrayItem = [{value:"DAILY_BATCH", name:"일마감 배치"}
							,{value:"MONTHLY_BATCH", name:"월마감 배치"}];

			KpackageOBJ.selectbox.create("SM003-form","SEARCH_SCHEDULE_CODE","", null,"value","name", arrayItem);
			
	
			/*Search Type Select Box Create */
			arrayItem = [{value:"SEARCH_TYPE_O1", name:"<spring:message code='인터페이스 코드'/>"}
						,{value:"SEARCH_TYPE_O2", name:"<spring:message code='인터페이스 명'/>"}];
			
			KpackageOBJ.selectbox.create("SM003-form","SEARCH_TYPE","", null,"value","name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			             ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						 ,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("SM003-form","SEARCH_OPTION","", null,"value","name", arrayItem);
			
			SM003.renderTuiGrid();
		}
		
		this.renderTuiGrid = function() {
			 
			 var colArrayInfo = [
				 {"header" :"통합interface id"    ,name:"INTG_INTERFACE_TRANS_ID"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"인터페이스코드"    ,name:"IF_CODE"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"회사 코드"    ,name:"COMPANY_CODE"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"사업부 코드"    ,name:"DIVISION_CODE"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"총건수"    ,name:"TOTAL_ROWS"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"이관일자"    ,name:"TRANS_DATE"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"이관상태"    ,name:"TRANS_STATUS"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"에러 메세지"    ,name:"ERROR_MESSAGE"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"생성일자"    ,name:"CREATE_DATE"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"생성자"    ,name:"CREATE_BY"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"수정일자"    ,name:"UPDATE_DATE"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"수정자"    ,name:"UPDATE_BY"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"스케쥴코드"    ,name:"SCHEDULE_CODE"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"인터페이스 파라메터"    ,name:"IF_PARAM"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"처리상태"    ,name:"STATUS"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"배치 프로세스 처리결과"    ,name:"BATCH_STATUS"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"에러여부"    ,name:"ERROR_YN"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"i/f 그룹 id (erp key)"    ,name:"GROUP_ID"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"org id (erp key)"    ,name:"ORG_ID"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"시작일자 (erp key)"    ,name:"START_TIME"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"interface_id"    ,name:"INTERFACE_ID"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"interface_type"    ,name:"INTERFACE_TYPE"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"정산 시작일"    ,name:"FROM_DATE"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"정산 종료일"    ,name:"TO_DATE"    ,width:100   ,align:"center"    ,hidden:false} 
			        
			    ];
			 
			 
			 KpackageOBJ.tuiGrid.create("oTui_Intg_master","/sys/retrieveInterfaceHistoryMaster", colArrayInfo, null, null, SM003.dbl_Handler);
			 KpackageOBJ.tuiGrid.setCaption("oTui_Intg_master","<spring:message code='인터페이스 이력 마스터'/>");
			 
			 var colInfoArray1 = [
				 {"header" :"인터페이스 마스터 아이디"   ,name:"INTG_INTERFACE_TRANS_ID"    ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"인터페이스 상세 아이디"     ,name:"INTG_INTERFACE_ID"          ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"에러 여부"                  ,name:"ERROR_YN"                   ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"에러 메세지"                ,name:"ERROR_MESSAGE"              ,width:80    ,align:"center"    ,hidden:false}
			 ];

			var params = {"DUMMY" :"" };
				retrieveURL ="";
				/* 그리드 생성 */
				KpackageOBJ.tuiGrid.create("oTui_Intg_detail","/sys/retrieveInterfaceItemDetail", colInfoArray1, null, null );
				KpackageOBJ.tuiGrid.setCaption("oTui_Intg_detail","<spring:message code='인터페이스 이력 상세'/>");
				
				
		}
		
		this.dbl_Handler = function(gridId, rowkey, colName){
			var rowData = KpackageOBJ.tuiGrid.getSelectedRowlValue(gridId, rowkey);
			var params = {"IF_CODE" : rowData.IF_CODE
					     ,"INTG_INTERFACE_TRANS_ID" : rowData.INTG_INTERFACE_TRANS_ID};
		
			KpackageOBJ.ajax.doSubmit("/sys/retrieveInterfaceHistoryLayout", params, SM003.retrieve_IntgDetail);   
			
			
		}
		
		this.retrieve_IntgDetail = function(result){
			var data = result.value;
			var col_info_array =  [
				 {"header" :"인터페이스 마스터 아이디"   ,name:"INTG_INTERFACE_TRANS_ID"    ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"인터페이스 상세 아이디"     ,name:"INTG_INTERFACE_ID"          ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"에러 여부"                  ,name:"ERROR_YN"                   ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"에러 메세지"                ,name:"ERROR_MESSAGE"              ,width:80    ,align:"center"    ,hidden:false}
			 ];
			for( var inx = 0; inx < data.length; inx++){
				col_info_array.push(JSON.parse(data[inx].COL_ARR));
			}
			KpackageOBJ.tuiGrid.setColumns( "oTui_Intg_detail" , col_info_array );
			
			var param = {"INTG_INTERFACE_TRANS_ID" : data[0].INTG_INTERFACE_TRANS_ID};
			KpackageOBJ.tuiGrid.retrieve("oTui_Intg_detail","/sys/retrieveInterfaceHistoryDetail", param);
			
		}
		
		this.retrieve_Intg_History = function(){
			
			var param = {"SEARCH_SCHEDULE_CODE" : KpackageOBJ.object.getFormValue("SM003-form","SEARCH_SCHEDULE_CODE")
						,"SEARCH_TYPE"          : KpackageOBJ.object.getFormValue("SM003-form","SEARCH_TYPE")
					 	,"SEARCH_KEY_WORD"      : KpackageOBJ.object.getFormValue("SM003-form","SEARCH_KEY_WORD")
			         	,"SEARCH_OPTION"        : KpackageOBJ.object.getFormValue("SM003-form","SEARCH_OPTION")
						};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_Intg_master","/sys/retrieveInterfaceHistoryMaster", param);
			
		}
	
	}
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		SM003.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});
</script>
</body>
</html>