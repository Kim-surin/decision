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
		<form:form id="RB013-search-form" class="s4-form" novalidate="novalidate" action="/refundBasis-013" method="post">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;" />
								<col style="width: 20%;" />
								<col style="width: 80px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='기준년도' /></th>
									<td>
										<input type="text" id="CAL_SEARCH_YYYY"  name="CAL_SEARCH_YYYY" style="width:60px" class="inputText" searchfnc="RB013.retrieve_gridData"/>
									</td>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="RB013.retrieve_gridData"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:RB013.retrieve_gridData();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_RB013_grid_01" name="div_oTui_RB013_grid_01" class="tuigrid-resizable">
					<div id="oTui_RB013_grid_01" data-minus-height="240"></div>
					<div id="oTui_RB013_grid_01_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>

	var RB013 = new function(){
		
		// Page Object Initialize
		this.initialize_Object = function() {
			
			var searchYYYY = KpackageOBJ.date.getCurrYear();
			
			KpackageOBJ.object.setFormValue("RB013-search-form","CAL_SEARCH_YYYY", searchYYYY);	
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"ITEM_CODE", name:"<spring:message code='자재코드'/>"}];
			
			KpackageOBJ.selectbox.create("RB013-search-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			            ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("RB013-search-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
		}
		
		this.initialize_TuiGrid = function(){
			 
			 var colArrayInfo = [
				 {"header" :'회사코드'			,name:'COMPANY_CODE'	,width:80,		align:'center'		,hidden:false},
				 {"header" :'년도'			,name:'YEAR'			,width:60,		align:'center'		,hidden:false},
				 {"header" :'효력시작일'		,name:'EFECT_BGNDE'		,width:100,		align:'center'		,hidden:false	,formatter:KpackageOBJ.tuiGrid.dateFormatter},
				 {"header" :'효력종료일'		,name:'EFECT_ENDDE'		,width:100,		align:'center'		,hidden:false	,formatter:KpackageOBJ.tuiGrid.dateFormatter},
				 {"header" :'자재번호'			,name:'ITEM_CODE'		,width:180,		align:'left'		,hidden:false},
				 {"header" :'관세율(수입)'		,name:'INCME_TARRATE'	,width:100,		align:'right'		,hidden:false},
				 {"header" :'HS CODE'		,name:'HS_CODE'			,width:100,		align:'center'		,hidden:false	,formatter:KpackageOBJ.tuiGrid.hscode10},
				 {"header" :'자재내역'			,name:'ITEM_NM'			,width:200,		align:'left'		,hidden:false},
				 {"header" :'수량'			,name:'QY'				,width:100,		align:'right'		,hidden:false	,formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'기본단위'			,name:'BASS_UNIT'		,width:60,		align:'center'		,hidden:false},
				 {"header" :'구매비율(수입)'	,name:'PURCHS_RATE'		,width:100,		align:'right'		,hidden:false}
			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_RB013_grid_01", "/refundBasis/retrieveRB013Grid", colArrayInfo, 'number', null);

		}
		 
		this.retrieve_gridData = function() {
			
			var param = { "CAL_SEARCH_YYYY" : KpackageOBJ.object.getFormValue("RB013-search-form", "CAL_SEARCH_YYYY")
					 	 ,"SEARCH_TYPE" 	: KpackageOBJ.object.getFormValue("RB013-search-form", "SEARCH_TYPE")
					 	 ,"SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("RB013-search-form", "SEARCH_KEY_WORD")
			         	 ,"SEARCH_OPTION" 	: KpackageOBJ.object.getFormValue("RB013-search-form", "SEARCH_OPTION")
						};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_RB013_grid_01", "/refundBasis/retrieveRB013Grid", param);
		}
		
	} 
	
	$(document).ready(function() {
		
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		RB013.initialize_Object(); 		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		RB013.initialize_TuiGrid();		 
	});

</script>
</body>
</html>