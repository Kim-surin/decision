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
	<section id="widget-grid-RB016" class="">
		<form:form id="RB016-search-form" class="s4-form" novalidate="novalidate" action="/refundBasis-009" method="post">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;" />
								<col style="width: 25%;" />
								<col style="width: 80px;" />
								<col style="width: 25%;" />
								<col style="width: 100px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='조회구분' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
									</td>
									<th><spring:message code='거래처' /></th>
									<td>
										<input type="text" id="VENDOR_NAME" name="VENDOR_NAME" class="inputText" searchfnc="RB016.retrieve_gridData"/>
									</td>
									<th><spring:message code='사업자번호' /></th>
									<td>
										<input type="text" id="BIZRNO" name="BIZRNO" class="inputText" searchfnc="RB016.retrieve_gridData"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:RB016.retrieve_gridData();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_RB016_grid_01" name="div_oTui_RB016_grid_01" class="tuigrid-resizable">
					<div id="oTui_RB016_grid_01" data-minus-height="260"></div>
					<div id="oTui_RB016_grid_01_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>

	var RB016 = new function(){
		
		// Page Object Initialize
		this.initialize_Object = function() {
			
			/*Search Type Select Box Create */
			var arrayItem = [{value:"", name:"전체"}
			            ,{value:"VV", name:"공급업체"}
						,{value:"CC", name:"고객사"}];
			
			KpackageOBJ.selectbox.create("RB016-search-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
		}
		
		this.initialize_TuiGrid = function(){
			 
			 var colArrayInfo = [
				 
				{"header" :'거래처 구분'		,name:'DATA_TYPE',		width:100,		align:'center',		hidden:false},
				{"header" :'거래처 코드'		,name:'VC_CODE',		width:100,		align:'center',		hidden:false},
				{"header" :'거래처 명'			,name:'VC_NAME',		width:100,		align:'center',		hidden:false},
				{"header" :'거래처 영문 명'		,name:'VC_ENG_NAME',		width:100,		align:'center',		hidden:false},
				{"header" :'사업자 등록번호'	,name:'BUSINESS_NO',		width:100,		align:'center',		hidden:false},
				{"header" :'소속 국가'			,name:'VC_NATION',		width:100,		align:'center',		hidden:false},
				{"header" :'대표 명'			,name:'OFFICER_NAME',		width:100,		align:'center',		hidden:false},
				{"header" :'대표 영문명'		,name:'OFFICER_NAME_ENG',		width:100,		align:'center',		hidden:false},
				{"header" :'주소'				,name:'ADDRESS',		width:100,		align:'center',		hidden:false},
				{"header" :'영문 주소'			,name:'ADDRESS_ENG',		width:100,		align:'center',		hidden:false},
				{"header" :'FAX'			,name:'FAX_NO',		width:100,		align:'center',		hidden:true},
				{"header" :'TEL'			,name:'TEL_NO',		width:100,		align:'center',		hidden:true},
				{"header" :'통관고유부호'		,name:'CUSTOM_UNQ_CODE',		width:100,		align:'center',		hidden:true},
				{"header" :'삭제여부'			,name:'DELETE_YN',		width:100,		align:'center',		hidden:false}
			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_RB016_grid_01", "/refundbasis/retrieveRefundBasis-016", colArrayInfo, "number", null, null);
			 
			 
			 var tools = [
							{icon:"excel", title:"ExcelDown" ,text:"ExcelDown"	,func:"RB016.excelDown"}
						];
			KpackageOBJ.tuiGrid.setButton("oTui_RB016_grid_01", tools); // Toobar 생성 */

		}
		 
		this.retrieve_gridData = function() {
			var param = KpackageOBJ.data.makePostData("RB016-search-form");  
			
			KpackageOBJ.tuiGrid.retrieve("oTui_RB016_grid_01", "/refundbasis/retrieveRefundBasis-016", param);
		};
		
	} 
	
	$(document).ready(function() {
		
		pageSetUp();				// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		RB016.initialize_Object(); 		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		RB016.initialize_TuiGrid();		 
	});

</script>
</body>
</html>