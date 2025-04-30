<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  
    
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form:form id="MM006-form" class="s4-form" novalidate="novalidate">
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 100px;" />
								<col style="width: 350px" />
								<col style="width: 100px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='TXT.ITEM_CODE'/></th>
									<td>
										<input type="text" id="SEARCH_ITEM_CODE" name="SEARCH_ITEM_CODE" style="width:300px" class="inputText" searchfnc="MM006.retrieve_gridData"/>
									</td>
									<th><spring:message code='TXT.ITEM_NAME'/></th>
									<td>
										<input type="text" id="SEARCH_ITEM_NAME" name="SEARCH_ITEM_NAME" style="width:300px" class="inputText" searchfnc="MM006.retrieve_gridData">
									</td>
								</tr>
								<tr>
									<th><spring:message code='TXT.ASSETS_TYPE'/></th>
									<td>
										<input type="text" id="SEARCH_ASSETS_TYPE" name="SEARCH_ASSETS_TYPE" style="width:300px" class="inputText" searchfnc="MM006.retrieve_gridData"/>
									</td>
									<th><spring:message code='TXT.HS_CODE'/></th>
									<td>
										<input type="text" id="SEARCH_HS_CODE" name="SEARCH_HS_CODE" style="width:300px" class="inputText" searchfnc="MM006.retrieve_gridData">
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:MM006.retrieve_gridData();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			</div>
		</form:form>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_List" name="div_oTui_List" class="tuigrid-resizable">
					<div id="oTui_List" data-minus-height="270"></div>
					<div id="oTui_List_paging"></div>
				</div>
			</div>
		</div>
	</section>
</div>
<script>
	var MM006 = new function() {
		
		// Page Object Initialize
		this.initialize_viewObject = function() {
	
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			             ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						 ,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("MM006-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
			MM006.initialize_TuiGrid();
			
		};
		
		this.initialize_TuiGrid = function(){
			var colArrayInfo = [
				 	{ header : "회사코드"       , name: "COMPANY_CODE"      , width: 100, align: "center", hidden:false  },
				 	{ header : "회사명"        , name: "COMPANY_NAME"      , width: 150, align: "center", hidden:false  },
				 	{ header : "자재코드"       , name: "ITEM_CODE"        	, width: 120, align: "center", hidden:false },
				 	{ header : "자재명"  		, name: "ITEM_NAME"			, width: 300, align: "left", hidden:false },
				 	{ header : "자재명(영문)"    , name: "ITEM_NAME_ENG"     , width: 300, align: "left", hidden:false },
				 	{ header : "제품군"         , name: "PRODUCT_CODE"      , width: 100, align: "center", hidden:false },
				 	{ header : "제품스펙"       , name: "SPEC"           	, width: 150, align: "center", hidden:false },
				 	{ header : "자재유형"       , name: "ASSETS_TYPE"        , width:  80, align: "center", hidden:false  },
				 	{ header : "HS_CODE"      , name: "HS_CODE"            , width: 120, align: "center", hidden:false },
				 	{ header : "단위"  			, name: "UNIT"               , width: 80, align: "center", hidden:false },
				 	{ header : "중량"      		, name: "WEIGHT"             , width: 100, align: "right", hidden:false },
				 	{ header : "생성일"         , name: "CREATE_DATE"        , width: 120, align: "center", hidden:false }
			    ];
			 
			KpackageOBJ.tuiGrid.create("oTui_List", "/master/retrieveItemList", colArrayInfo, "number",null,null);
		};
	
		 
		this.retrieve_gridData = function(){
			var param = {
						"SEARCH_ITEM_CODE":KpackageOBJ.object.getFormValue("MM006-form", "SEARCH_ITEM_CODE")
						,"SEARCH_ITEM_NAME":KpackageOBJ.object.getFormValue("MM006-form", "SEARCH_ITEM_NAME")
						,"SEARCH_ASSETS_TYPE":KpackageOBJ.object.getFormValue("MM006-form", "SEARCH_ASSETS_TYPE")
						,"SEARCH_HS_CODE":KpackageOBJ.object.getFormValue("MM006-form", "SEARCH_HS_CODE")
						};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_List", "/master/retrieveItemList", param);
		};
	};
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		MM006.initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});

</script>
</body>
</html>