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
		<form:form id="RB008-form" class="s4-form" novalidate="novalidate">
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
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='기준월' /></th>
									<td>
										<input type="text" id="CAL_F_SEARCH_DATE"  name="CAL_F_SEARCH_DATE" class="inputText has-month-picker" searchfnc="RB008.retrieve_bomList"/>
										<span class="fromTo-Dash">~</span>
										<input type="text" id="CAL_T_SEARCH_DATE"  name="CAL_T_SEARCH_DATE" class="inputText has-month-picker" searchfnc="DB006.retrieve_DB006List"/>
									</td>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="RB008.retrieve_bomList"/>
										
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:RB008.retrieve_bomList();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
				<div id="div_oTui_Bom_List" name="div_oTui_Bom_List" class="tuigrid-resizable">
					<div id="oTui_Bom_List" data-minus-height="310"></div>
					<div id="oTui_Bom_List_paging"></div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
				<div id="div_oTui_Item_List" name="div_oTui_Item_List" class="tuigrid-resizable">
				<div id="oTui_Item_List" data-minus-height="510"></div>
				</div>
			</div>
		</div>
		
	
	</section>

</div>

<script>


	var RB008 = new function(){
	
		this.Initialize_viewObject = function() {
			
			KpackageOBJ.monthPicker.create("RB008-form", "CAL_F_SEARCH_DATE");
			KpackageOBJ.monthPicker.setValue("RB008-form","CAL_F_SEARCH_DATE", KpackageOBJ.date.getCurrMonth());
			
			KpackageOBJ.monthPicker.create("RB008-form", "CAL_T_SEARCH_DATE");
			KpackageOBJ.monthPicker.setValue("RB008-form","CAL_T_SEARCH_DATE", KpackageOBJ.date.getCurrMonth());
	
			/*Search Type Select Box Create */
			arrayItem = [
			             {value:"PRODUCT_CODE", name:"<spring:message code='제품코드'/>"}
			             ,{value:"ITEM_CODE", name:"<spring:message code='품목코드'/>"}
			              ];
			
			KpackageOBJ.selectbox.create("RB008-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			             ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						 ,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("RB008-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
			RB008.renderTuiGrid();
		}
		
		this.renderTuiGrid = function() {
			  
		    var colArrayInfo = [
			    	{ header :"회사 코드"			, name:"COMPANY_CODE"     	, width : 100,     align:"center" , hidden:true},
			    	{ header :"사업부 코드"			, name:"DIVISION_CODE"     	, width : 100,     align:"center" , hidden:true},
			    	{ header :"BOM 버전"			, name:"BOM_VERSION"     	, width : 100,     align:"center" , resizable: true, hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
			    	{ header :"제품코드"				, name:"PRODUCT_CODE"     	, width : 90,      align:"center" , resizable: true, hidden:false},
			    	{ header :"제품 명"				, name:"PRODUCT_NAME"     	, width : 300,     align:"left"   , resizable: true, hidden:false},			    	
			    	{ header :"HS CODE"			, name:"HS_CODE10"     		, width : 100,     align:"center" , resizable: true, hidden:false, "formatter" : KpackageOBJ.tuiGrid.hscode10 },
			    	{ header :"기본 단위"		, name:"UNIT"    			, width : 100,     align:"center" , resizable: true, hidden:false},
			    	{ header :"부산물 발생여부"		, name:"BYPRD_OCCRRNC_AT"   , width : 100,     align:"center" , resizable: true, hidden:false},
			    	{ header :"사용여부"				, name:"USE_YN"     		, width : 70,      align:"center" , resizable: true, hidden:false},
			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_Bom_List", "/refundbasis/retrieveBomList", colArrayInfo, 'number', null, RB008.dbl_Handler);
			 KpackageOBJ.tuiGrid.setCaption("oTui_Bom_List","<spring:message code='제품목록'/>");
			 
			 var colInfoArray1 = [
				 { header : "원자재코드"        	, name:"ITEM_CODE"         , width : 180,     align: "center" , resizable: true, hidden:false},
				 { header : "자재명"			, name:"ITEM_NAME"     		, width : 250,     align:"left"   , resizable: true, hidden:false},
				 { header : "자재유형" 		  	, name:"ASSETS_TYPE"        	 , width : 60,     align: "center" , resizable: true, hidden:false},
				 { header : "자재 HS CODE"    	, name:"HS_CODE10"         , width : 100,     align: "center" , resizable: true, hidden:false, "formatter" : KpackageOBJ.tuiGrid.hscode10},
				 { header : "투입수량"         	, name:"INPUT_QTY"         , width : 60,     align:  "right" , resizable: true, hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas},
				 { header : "기본단위"        	, name:"INPUT_BASS_UNIT"   , width : 60,     align: "center" , resizable: true, hidden:false}
			                     
				];
			var params = { "DUMMY" : "" };
				retrieveURL = "";
				/* 그리드 생성 */
				KpackageOBJ.tuiGrid.create("oTui_Item_List", "", colInfoArray1, 'number', null );
				KpackageOBJ.tuiGrid.setCaption("oTui_Item_List","<spring:message code='BOM LIST'/>");
				
			$(window).bind('resize', function() {
				var d = KpackageOBJ.tuiGrid.getGrid("oTui_Item_List");
				d.setBodyHeight($(window).height()-270);
			}).trigger('resize');
				
		}
		
		this.dbl_Handler = function(gridId, rowkey, colName){
			var rowData = KpackageOBJ.tuiGrid.getSelectedRowlValue(gridId, rowkey);
			KpackageOBJ.tuiGrid.retrieve("oTui_Item_List", "/refundbasis/selectItemList", rowData);
		}
		
		
		this.retrieve_bomList = function(){
			
			var param = { "STDR_MT" : KpackageOBJ.object.getFormValue("RB008-form", "CAL_F_SEARCH_DATE")
						, "EDDR_MT" : KpackageOBJ.object.getFormValue("RB008-form", "CAL_T_SEARCH_DATE")
						, "SEARCH_TYPE" : KpackageOBJ.object.getFormValue("RB008-form","SEARCH_TYPE")
					 	, "SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("RB008-form", "SEARCH_KEY_WORD")
			         	, "SEARCH_OPTION" : KpackageOBJ.object.getFormValue("RB008-form","SEARCH_OPTION")
						};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_Bom_List", "/refundbasis/retrieveBomList", param);
			
		}
	
	}
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		RB008.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});
</script>
</body>
</html>