<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%/****************************************************************************************************************
		Program Name : refundBasis-009
		Desc         : 수출신고
		
********************************************************************************************************************/%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form:form id="RB009-search-form" class="s4-form" novalidate="novalidate" action="/refundBasis-009" method="post">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;" />
								<col style="width: 35%;" />
								<col style="width: 80px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='수출일자' /></th>
									<td>
										<input type="text" id="CAL_SEARCH_FROM_DATE"  name="CAL_SEARCH_FROM_DATE" style="width:120px" class="inputText" searchfnc="RB009.retrieve_gridData"/>
										<span class="fromTo-Dash">~</span>
										<input type="text" id="CAL_SEARCH_TO_DATE"  name="CAL_SEARCH_TO_DATE" style="width:120px" class="inputText" searchfnc="RB009.retrieve_gridData"/>
									</td>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="RB009.retrieve_gridData"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:RB009.retrieve_gridData();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_RB009_grid_01" name="div_oTui_RB009_grid_01" class="tuigrid-resizable">
					<div id="oTui_RB009_grid_01" data-minus-height="250"></div>
					<div id="oTui_RB009_grid_01_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>

	var RB009 = new function(){
		
		// Page Object Initialize
		this.initialize_Object = function() {
			
			var fromDay = KpackageOBJ.date.getCurrMonth() + "01";
			var toDay = KpackageOBJ.date.getCurrDay();
			
			KpackageOBJ.calendar.create("RB009-search-form", "CAL_SEARCH_FROM_DATE");
			KpackageOBJ.calendar.setValue("RB009-search-form","CAL_SEARCH_FROM_DATE", fromDay);
			
			KpackageOBJ.calendar.create("RB009-search-form", "CAL_SEARCH_TO_DATE");
			KpackageOBJ.calendar.setValue("RB009-search-form","CAL_SEARCH_TO_DATE", toDay);
	
			/*Search Type Select Box Create */
			arrayItem = [{value:"XPORT_STTEMNT_NO", name:"<spring:message code='수출신고번호'/>"}
						,{value:"ITEM_CODE", name:"<spring:message code='제품코드'/>"}
						,{value:"ITEM_NAME", name:"<spring:message code='제품명'/>"}];
			
			KpackageOBJ.selectbox.create("RB009-search-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			            ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("RB009-search-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
		}
		
		this.initialize_TuiGrid = function(){
			 var colArrayInfo = [
				 {name:"COMPANY_CODE"          ,header:"회사 코드"                ,	   width:100,		align:'center',		hidden:true},
				 {name:"DIVISION_CODE"         ,header:"플랜트"                   ,	   width:80,		align:'center',		hidden:true},
				 {name:"XPORT_STTEMNT_NO"      ,header:"수출신고번호"             ,     width:150,      align:'center',     resizable: true, hidden:false},
				 {name:"EXPDECL_MANAGE_NO"     ,header:"수출신고 관리번호"        ,	   width:100,		align:'center',		hidden:true},
				 {name:"DSPTH_DATE"            ,header:"신고(통보)일자"           ,     width:100,      align:'center',     resizable: true, hidden:false,       formatter:KpackageOBJ.tuiGrid.dateFormatter},
				 {name:"ONBOARD_DATE"          ,header:"선적일자"                 ,     width:100,      align:'center',     resizable: true, hidden:false,       formatter:KpackageOBJ.tuiGrid.dateFormatter},
				 {name:"EXPORTER_NAME"         ,header:"수출자"                   ,     width:150,      align:'center',     resizable: true, hidden:false},
				 {name:"ITEM_CODE"             ,header:"제품코드"                 ,     width:180,      align:'left',       resizable: true, hidden:false},
                 {name:"ITEM_NM"               ,header:"재퓸명"                 ,     width:200,      align:'left',       resizable: true, hidden:false},
                 {name:"ITEM_QTY"              ,header:"수출수량"            ,     width:100,      align:'right',      resizable: true, hidden:false,       formatter:KpackageOBJ.tuiGrid.commas},
                 {name:"STTEMNT_PC_KRW"        ,header:"신고금액"            ,     width:100,      align:'right',      resizable: true, hidden:false,       formatter:KpackageOBJ.tuiGrid.commas},
                 {name:"STTEMNT_PC_FGCRY"      ,header:"결제금액"           ,     width:100,      align:'right',      resizable: true, hidden:false,       formatter:KpackageOBJ.tuiGrid.commas},
                 {name:"FRMLC_REPR"            ,header:"포장갯수"                 ,      width:100,      align:'right',      resizable: true, hidden:false,       formatter:KpackageOBJ.tuiGrid.commas},
                 {name:"DELY_CND"              ,header:"인도 조건"                ,      width:60,       align:'center',     resizable: true, hidden:false},
                 {name:"EHGT"                  ,header:"환율" ,     width:150,      align:'right',      resizable: true, hidden:false,       formatter:KpackageOBJ.tuiGrid.commas},
                 {name:"CRNCY"                 ,header:"미화통화"                 ,      width:60,       align:'center',     resizable: true, hidden:false},
                 {name:"NATION_CODE"           ,header:"국가 키"                  ,     width:60,       align:'center',     resizable: true, hidden:false},
                 {name:"XPORT_SE"              ,header:"수출거래구분"             ,        width:80,       align:'center',     resizable: true, hidden:false},
				 {name:"HS_CODE"               ,header:"HS CODE"                  ,		width:100,		align:'center',		resizable: true, hidden:false	,formatter:KpackageOBJ.tuiGrid.hscode10},
				 {name:"SLE_UNIT"              ,header:"판매 단위"                ,		width:60,		align:'center',		resizable: true, hidden:false},
				 {name:"INV_NO"                ,header:"invoice no"               ,		width:100,		align:'center',		resizable: true, hidden:false},
				 {name:"XPORT_TYPE"            ,header:"수출형태"                 ,		width:60,		align:'center',		resizable: true, hidden:false}

			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_RB009_grid_01", "/refundBasis/retrieveRB009Grid", colArrayInfo, 'number', null, RB009.onDblClick_oTui_RB009_grid_01);

		}
		 
		this.onDblClick_oTui_RB009_grid_01 = function(gridId, rowkey, colName){
			var rowData = KpackageOBJ.tuiGrid.getSelectedRowlValue(gridId, rowkey);
			var param = {	"COMPANY_CODE":rowData.COMPANY_CODE
							,"EXPDECL_MANAGE_NO":rowData.EXPDECL_MANAGE_NO
							,"INV_NO":rowData.INV_NO
							,"INPUT_FLAG":"U"	
						}
			var params = makeStringParameter(param, true);
			KpackageOBJ.dialog.open("RB009_Dtl", "수출신고 상세", "/refundBasis-00901?"+params, 1150, KpackageOBJ.prototype.pop_M_Height);
		};
		
		this.retrieve_gridData = function() {
			
			var param = { "CAL_SEARCH_FROM_DATE" : KpackageOBJ.object.getFormValue("RB009-search-form", "CAL_SEARCH_FROM_DATE")
					 	 ,"CAL_SEARCH_TO_DATE" : KpackageOBJ.object.getFormValue("RB009-search-form","CAL_SEARCH_TO_DATE")
					 	 ,"SEARCH_TYPE" : KpackageOBJ.object.getFormValue("RB009-search-form","SEARCH_TYPE")
					 	 ,"SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("RB009-search-form", "SEARCH_KEY_WORD")
			         	 ,"SEARCH_OPTION" : KpackageOBJ.object.getFormValue("RB009-search-form","SEARCH_OPTION")
						};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_RB009_grid_01", "/refundBasis/retrieveRB009Grid", param);
		};
		
	} 
	
	$(document).ready(function() {
		
		pageSetUp();				// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		RB009.initialize_Object(); 		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		RB009.initialize_TuiGrid();		 
	});

</script>
</body>
</html>