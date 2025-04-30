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
	<section id="widget-grid-RB015" class="">
		<form:form id="RB015-search-form" class="s4-form" novalidate="novalidate" action="/refundBasis-009" method="post">
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
										<select class="form-control searchSelect" id="APPLY_YEAR" name="APPLY_YEAR" style="width:110px"></select>
									</td>
									<th><spring:message code='HS CODE' /></th>
									<td>
										<input type="text" id="FROM_HSCODE10" name="FROM_HSCODE10" class="inputText" maxlength="10" style="width: 35%"/>
										~ <input type="text" id="TO_HSCODE10" name="TO_HSCODE10" class="inputText" maxlength="10" style="width: 35%"/>
									</td>
									<th><spring:message code='품명' /></th>
									<td>
										<input type="text" id="HS_DESC" name="HS_DESC" class="inputText"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:RB015.retrieve_gridData();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_RB015_grid_01" name="div_oTui_RB015_grid_01" class="tuigrid-resizable">
					<div id="oTui_RB015_grid_01" data-minus-height="240"></div>
					<div id="oTui_RB015_grid_01_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>

	var RB015 = new function(){
		
		// Page Object Initialize
		this.initialize_Object = function() {
			
			KpackageOBJ.selectbox.create("RB015-search-form", "APPLY_YEAR", "/refundbasis/retrieve_RB015_YearCodeList", {"CATEGORY_CD":"ETC"}, "CODE", "NAME");
			
		}
		
		this.initialize_TuiGrid = function(){
			 
			 var colArrayInfo = [
				 {"header" :'연번',				name:'APPLY_YEAR',		    width:100,		align:'center',		hidden:false},
				 {"header" :'HS CODE',			name:'HS_CODE10',		    width:100,		align:'center',		hidden:false, formatter:KpackageOBJ.tuiGrid.hscode10},
				 {"header" :'품명',				name:'HS_DESC',				width:800,		align:'left',		hidden:false},
				 {"header" :'비고',				name:'REMARK',				width:100,		align:'left',		hidden:false},
				 {"header" :'기존 연번',			name:'APPLY_YEAR',		    width:100,		align:'center',		hidden:false},
				 {"header" :'전년도 HS CODE',		name:'HS_CODE10',		    width:100,		align:'center',		hidden:false, formatter:KpackageOBJ.tuiGrid.hscode10}
			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_RB015_grid_01", "/refundbasis/retrieveRefundBasis-015", colArrayInfo, null, null, RB015.onDblClick_oTui_RB015_grid_01);
			 
			 
			 var tools = [
							{icon:"excel", title:"ExcelDown" ,text:"ExcelDown"	,func:"RB015.excelDown"}
						];
			KpackageOBJ.tuiGrid.setButton("oTui_RB015_grid_01", tools); // Toobar 생성 */

		}
		 
		this.onDblClick_oTui_RB015_grid_01 = function(gridId, rowkey, colName){
			var rowData = KpackageOBJ.tuiGrid.getSelectedRowlValue(gridId, rowkey);
			var param = {	
							"INPUT_FLAG":"U"	
						}
			var params = makeStringParameter(param, true);
		};
		
		this.retrieve_gridData = function() {
			var param = KpackageOBJ.data.makePostData("RB015-search-form");  
			
			KpackageOBJ.tuiGrid.retrieve("oTui_RB015_grid_01", "/refundbasis/retrieveRefundBasis-015", param);
		};
		
	} 
	
	$(document).ready(function() {
		
		pageSetUp();				// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		RB015.initialize_Object(); 		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		RB015.initialize_TuiGrid();		 
	});

</script>
</body>
</html>