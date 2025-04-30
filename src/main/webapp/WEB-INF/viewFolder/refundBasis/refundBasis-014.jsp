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
	<section id="widget-grid" class="">
		<form:form id="RB014-search-form" class="s4-form" novalidate="novalidate" action="/refundBasis-009" method="post">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;" />
								<col style="width: 15%;" />
								<col style="width: 80px;" />
								<col style="width: 20%;" />
								<col style="width: 80px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='적용년도' /></th>
									<td>
										<input type="text" id="CAL_APPLY_DATE"  name="CAL_APPLY_DATE" style="width:120px" class="inputText" searchfnc="RB014.retrieve_gridData"/>
										<input type="hidden" id="APPLY_DATE" name="APPLY_DATE" style="width:110px">
									</td>
									<th><spring:message code='HS CODE' /></th>
									<td>
										<input type="text" id="HS_CODE10" name="HS_CODE10" class="inputText" maxlength="10" searchfnc="RB014.retrieve_gridData"/>
									</td>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="RB014.retrieve_gridData"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:RB014.retrieve_gridData();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_RB014_grid_01" name="div_oTui_RB014_grid_01" class="tuigrid-resizable">
					<div id="oTui_RB014_grid_01" data-minus-height="240"></div>
					<div id="oTui_RB014_grid_01_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>

	var RB014 = new function(){
		
		// Page Object Initialize
		this.initialize_Object = function() {
			
			var d = KpackageOBJ.date.getCurrMonth() + "01";
			
			KpackageOBJ.calendar.create("RB014-search-form", "CAL_APPLY_DATE");
			KpackageOBJ.calendar.setValue("RB014-search-form","CAL_APPLY_DATE", d);
			KpackageOBJ.object.setFormValue("RB014-search-form","APPLY_DATE", d);
			
			
			
			KpackageOBJ.selectbox.create("RB014-search-form", "APPLY_YEAR", "/refundbasis/retrieveYearCodeList", {"CATEGORY_CD":"ETC"}, "CODE", "NAME");
			
			
			var  arrayItem = [
								{value:"PRICE", name:"<spring:message code='세액'/>"}
								,{value:"HS_DESC", name:"<spring:message code='품명'/>"}
							];
			
			KpackageOBJ.selectbox.create("RB014-search-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			            ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("RB014-search-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
		}
		
		this.initialize_TuiGrid = function(){
			 
			 var colArrayInfo = [
				 {"header" :'적용시작일',			name:'START_DATE',		    width:100,		align:'center',		hidden:false	,formatter:KpackageOBJ.tuiGrid.dateFormatter},
				 {"header" :'적용종료일',			name:'END_DATE',		    width:100,		align:'center',		hidden:false	,formatter:KpackageOBJ.tuiGrid.dateFormatter},
				 {"header" :'HS CODE',				name:'HS_CODE10',		    width:100,		align:'center',		hidden:false, formatter:KpackageOBJ.tuiGrid.hscode10},
				 {"header" :'품명',					name:'HS_DESC',				width:1160,		align:'left',		hidden:false},
				 {"header" :'환급액',				name:'PRICE',				width:100,		align:'right',		hidden:false, formatter:KpackageOBJ.tuiGrid.commas}
			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_RB014_grid_01", "/refundbasis/retrieveRefundBasis-014", colArrayInfo, 'number', null, RB014.onDblClick_oTui_RB014_grid_01);
			 
			 
			 var tools = [
				 			{icon:"excel", title:"ExcelDown" ,text:"ExcelDown"	,func:"RB014.excelDown"}
						];
			KpackageOBJ.tuiGrid.setButton("oTui_RB014_grid_01", tools); // Toobar 생성 */

		}
		 
		this.onDblClick_oTui_RB014_grid_01 = function(gridId, rowkey, colName){
			var rowData = KpackageOBJ.tuiGrid.getSelectedRowlValue(gridId, rowkey);
			var param = {	
							"INPUT_FLAG":"U"	
						}
			var params = makeStringParameter(param, true);
		};
		
		this.retrieve_gridData = function() {
			var param = KpackageOBJ.data.makePostData("RB014-search-form");  
			
			KpackageOBJ.tuiGrid.retrieve("oTui_RB014_grid_01", "/refundbasis/retrieveRefundBasis-014", param);
		};
		
	} 
	
	$(document).ready(function() {
		
		pageSetUp();				// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		RB014.initialize_Object(); 		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		RB014.initialize_TuiGrid();		 
	});

</script>
</body>
</html>