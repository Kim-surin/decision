<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form:form id="SM001-search-form" novalidate="novalidate" class="s4-form" onsubmit="return false;" method="post">
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;">
								<col style="width: 15%;">
								<col style="width: 80px;">
								<col style="width:">
							</colgroup>
							<tbody>
								<tr>
									<th>사용유무</th>
									<td> 
										<select class="form-control searchSelect" id="SEARCH_SYSTEM_BATCH_YN" name="SEARCH_SYSTEM_BATCH_YN" style="width:110px"></select>
									</td>
									<th>조회조건</th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="SM001.retrieve_gridData"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:SM001.retrieve_gridData();">
							<i class="fa fa-search"></i> Search
						</button>
					</div>
				</div>
			</div>
			<div>
				<input type="hidden" name="_csrf" value="63062d27-85c7-46d3-bc64-05fc8b500248">
			</div>
		</form:form>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_InterfaceSchdule_Grid" name="div_oTui_InterfaceSchdule_Grid" class="tuigrid-resizable">
					
					<div id="oTui_InterfaceSchdule_Grid" data-minus-height="240"></div>
					<div id="oTui_InterfaceSchdule_Grid_paging"></div>
				</div>
			</div>
		</div>
		
	</section>
</div> 
<script type="text/javascript">
	
	var SM001 = new function(){
		
		// Page Object Initialize
		this.initialize_Object = function() {
			
			var arrayItem = [{value:"", name:"ALL"}
							,{value:"Y", name:"Yes"}
	        				,{value:"N", name:"No"}];
			
			KpackageOBJ.selectbox.create("SM001-search-form", "SEARCH_SYSTEM_BATCH_YN", "", null, "value", "name", arrayItem);
			
			arrayItem = [{value:"SEARCH_TYPE_O1", name:"스케줄 코드"}
						,{value:"SEARCH_TYPE_O2", name:"스케줄 명"}];

			KpackageOBJ.selectbox.create("SM001-search-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			arrayItem = [{value:"CC", name:"Contains"}
            			,{value:"EQ", name:"Equal To"}
			 			,{value:"SW", name:"Starts With Is"}];

			KpackageOBJ.selectbox.create("SM001-search-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
		}
		


		
		this.initialize_TuiGrid = function() {
			
			var colArrayInfo = [
					{"header" :"고유id"                      ,name:"INTERFACE_SCHEDULE_ID"       ,width:100      ,align:"center"    ,hidden:false},
					{"header" :"스케줄 코드"                 ,name:"SCHEDULE_CODE"               ,width:100          ,align:"center"    ,hidden:false},
					{"header" :"회사코드"                    ,name:"COMPANY_CODE"                ,width:100        ,align:"center"    ,hidden:false},
					{"header" :"스케줄 명"                   ,name:"SCHEDULE_NAME"               ,width:100        ,align:"center"    ,hidden:false},
					{"header" :"스케줄 설명"                 ,name:"SCHEDULE_DESC"               ,width:100         ,align:"center"    ,hidden:false},
					{"header" :"실행프로그램"                ,name:"EXECUTION_PROGRAM"           ,width:100           ,align:"center"    ,hidden:false},
					{"header" :"적용시작일자"                ,name:"APPLY_FROM_DATE"             ,width:100      ,align:"center"    ,formatter: KpackageOBJ.tuiGrid.dateFormatter    ,hidden:false},
					{"header" :"적용종료일자"                ,name:"APPLY_TO_DATE"               ,width:100      ,align:"center"    ,formatter: KpackageOBJ.tuiGrid.dateFormatter   ,hidden:false},
					{"header" :"월"                          ,name:"MONTH"                       ,width:100      ,align:"center"    ,hidden:false},
					{"header" :"주"                          ,name:"WEEK"                        ,width:100      ,align:"center"    ,hidden:false},
					{"header" :"일"                          ,name:"DAY"                         ,width:100      ,align:"center"    ,hidden:false},
					{"header" :"시간"                        ,name:"HOUR"                        ,width:100       ,align:"center"    ,hidden:false},
					{"header" :"분"                          ,name:"MINUTES"                     ,width:100      ,align:"center"    ,hidden:false},
					{"header" :"상태"                        ,name:"STATUS"                      ,width:100       ,align:"center"    ,hidden:false},
					{"header" :"시스템 실행배치 여부"        ,name:"SYSTEM_BATCH_YN"             ,width:100              ,align:"center"    ,hidden:false},
					{"header" :"최종실행일자"                ,name:"LAST_EXECUTION_DATE"         ,width:100           ,align:"center"    ,hidden:false},
					{"header" :"최종실행결과 메시지"         ,name:"EXTCUTION_MESSAGE"           ,width:100              ,align:"center"    ,hidden:false},
					{"header" :"배치적용 기준년월"           ,name:"BATCH_YYYYMM"                ,width:100             ,align:"center"    ,hidden:false},
					{"header" :"배치적용 기준년월 반영여부"  ,name:"BATCH_YYYYMM_YN"             ,width:100                 ,align:"center"    ,hidden:false},
					{"header" :"월배치 실행 기준 유형"       ,name:"EXEC_TYPE"                   ,width:100              ,align:"center"    ,hidden:false},
					{"header" :"일배치 실행 기준 기간"       ,name:"EXEC_DAILY_PERIOD"           ,width:100              ,align:"center"    ,hidden:false},
					{"header" :"월배치 실행 기준 기간"       ,name:"EXEC_MONTHLY_PERIOD"         ,width:100              ,align:"center"    ,hidden:false},
					{"header" :"월배치 실행 시작 기준일"     ,name:"EXEC_MANUAL_START_YYYYMM"    ,width:100               ,align:"center"    ,hidden:false},
					{"header" :"월배치 실행 종료 기준일"     ,name:"EXEC_MANUAL_END_YYYYMM"      ,width:100               ,align:"center"    ,hidden:false},
					{"header" :"생성일자"                    ,name:"CREATE_DATE"                 ,width:100         ,align:"center"    ,hidden:false},
					{"header" :"생성자"                      ,name:"CREATE_BY"                   ,width:100        ,align:"center"    ,hidden:false},
					{"header" :"수정일자"                    ,name:"UPDATE_DATE"                 ,width:100         ,align:"center"    ,hidden:false},
					{"header" :"수정자"                      ,name:"UPDATE_BY"                   ,width:100        ,align:"center"    ,hidden:false}
		    ];
		 
			KpackageOBJ.tuiGrid.create("oTui_InterfaceSchdule_Grid","/sys/retrieveInterfaceSch", colArrayInfo, null, null, this.dbl_Handler);
			
		}
		
		this.retrieve_gridData = function() {
			var param = KpackageOBJ.data.makePostData("SM001-search-form");
			KpackageOBJ.tuiGrid.retrieve("oTui_InterfaceSchdule_Grid", "", param);
		}
		
		/* Dbl Click Handler */
		this.dbl_Handler = function(p_GridId, p_RowKey, p_ColName){
			
			var width_size = $(window).width() - 100;
			var height_size = $(window).height() - 100;
			
			var rowData = KpackageOBJ.tuiGrid.getRowValues(p_GridId, p_RowKey);
			var params = makeStringParameter(rowData, true);
			KpackageOBJ.dialog.open("interfaceSch_Dtl", "Interface Schedule Detail", "/sm-00101?" + params, KpackageOBJ.prototype.pop_M_Width, KpackageOBJ.prototype.pop_M_Height);
		}
	}
	
	$(document).ready(function() {
		pageSetUp();				// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		SM001.initialize_Object(); 		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		SM001.initialize_TuiGrid();		 
		
		
	});
	
</script>
</body>
</html>