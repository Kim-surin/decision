<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style>

    </style>
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form:form id="R013-form" class="s4-form" novalidate="novalidate" action="/report-011" method="post">
			<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="table-responsive">
							<table class="table table-bordered">
								<colgroup>
									<col style="width: 140px;" />
									<col style="width: 350px;" />
									<col style="width: 140px;" />
									<col style="width: " />
									<col style="width: 100px;" />
								</colgroup>
								<tbody>
									<tr>
										<th><spring:message code='수출일자' /></th>
										<td>
											<input type="text" id="SEARCH_YYYY"  name="SEARCH_YYYY" style="width:120px" class="inputText" searchfnc="R013.retrieve_R013List"/>
											<select class="form-control searchSelect" id="SEARCH_QUARTER" name="SEARCH_QUARTER" style="width:110px"></select>
										</td>	
										
										<th><spring:message code='제품코드' /></th>
										<td>
											<input type="text" id="SEARCH_KEY_WORD_PRODUCT_CODE" name="SEARCH_KEY_WORD_PRODUCT_CODE" class="inputText" searchfnc="R013.retrieve_R013List"/>
										</td>
										<td rowspan=2>
											<div class="input-group-btn">
												<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:R013.retrieve_R013List();">
													<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
												</button>
											</div>
										</td>
									</tr>
									<tr>
										<th><spring:message code='자재코드' /></th>
										<td>
											<input type="text" id="SEARCH_KEY_WORD_ITEM_CODE" name="SEARCH_KEY_WORD_ITEM_CODE" class="inputText" searchfnc="R013.retrieve_R013List"/>
										</td>
										<th><spring:message code='신규자재여부' /></th>
										<td>
											<select class="form-control searchSelect" id="SEARCH_NEWITEM_YN" name="SEARCH_NEWITEM_YN" style="width:110px"></select>
										</td>
	                            	</tr>
								</tbody>
							</table>
					</div>
				</div>
			</div>
			<div class ="row" style="margin-top:10px;">
				<div class="widget-body col-xs-12 col-sm-12 col-md-12 col-lg-12" style="position: relative;">
					<div id="div_oTui_R013_List" name="div_oTui_R013_List"  >
						<div id="oTui_R013_List" data-minus-height="750"></div>
						<div id="oTui_R013_List_paging"></div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div>
						<!-- widget content -->
						<div class="widget-body" style="position: relative;">
							<div id="div_oTui_R013_detailList" name="div_oTui_R013_detailList" >
								<div id="oTui_R013_detailList" data-minus-height="650"></div>
								<div id="oTui_R013_detailList_paging"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form:form>
	</section>

</div>

<script>
	
	var R013 = new function(){
		this.Initialize_viewObject = function() {
	
			/*Search Type Select Box Create */
			arrayItem = [{value:"1", name:"<spring:message code='1분기'/>"}
						,{value:"2", name:"<spring:message code='2분기'/>"}
						,{value:"3", name:"<spring:message code='3분기'/>"}
						,{value:"4", name:"<spring:message code='4분기'/>"}
						];
			
			KpackageOBJ.selectbox.create("R013-form", "SEARCH_QUARTER", "", null, "value", "name", arrayItem);
			
			
			arrayItem = [{value:"", name:"<spring:message code='전체'/>"}
					    ,{value:"Y", name:"<spring:message code='신규'/>"}
						,{value:"N", name:"<spring:message code='미신규'/>"}
						];

			KpackageOBJ.selectbox.create("R013-form", "SEARCH_NEWITEM_YN", "", null, "value", "name", arrayItem);

	
			/* Create Calender*/
			var toDay = KpackageOBJ.date.getCurrDay();
			KpackageOBJ.object.setFormValue("R013-form","SEARCH_YYYY",toDay.substring(0,4));
			KpackageOBJ.object.setFormValue("R013-form","SEARCH_QUARTER", Math.ceil( Number(toDay.substring(4,6)) / 3 ));
			KpackageOBJ.object.setFormValue("R013-form","SEARCH_NEWITEM_YN", "");
			
			
			
			/* Create Grid*/
			R013.renderTuiGrid();

			/* Create Tab Event*/
			$("#grid_Tab.nav.nav-tabs li").click(function(){
				R013.retrieve_R013List(this.id); 
			});
		}
		
		this.renderTuiGrid = function() {
	
			 /* 오류추정영역*/	 
			 var topColArrayInfo = [
				 	{ header : "회사코드"			, name: "COMPANY_CODE"		, width : 80 , align: "center"    , resizable: true, hidden:false},
			        { header : "플랜트"				, name: "DIVISION_CODE"		, width : 150, align: "center"    , resizable: true, hidden:false},
			        { header : "제품코드"			, name: "PRODUCT_CODE"		, width : 120, align: "center"    , resizable: true, hidden:false},
			        { header : "제품명" 			, name: "PRODUCT_NAME"		, width : 450, align: "left"      , resizable: true, hidden:false},
			        { header : "BOM일자"			, name: "BOM_VERSION"		, width : 120, align: "center"    , resizable: true, hidden:false},
			        { header : "신규자재여부"			, name: "NEW_CHANGE_FLAG"	, width : 100, align: "center"    , resizable: true, hidden:false},
			        { header : "삭제자재여부"			, name: "DELETE_CHANGE_FLAG", width : 100, align: "center"    , resizable: true, hidden:false},
			        { header : "소요량변경여부"		, name: "QTY_CHANGE_FLAG"	, width : 100, align: "center"    , resizable: true, hidden:false},
			        { header : "단위변경여부"			, name: "UNIT_CHANGE_FLAG"	, width : 100, align: "center"    , resizable: true, hidden:false}
			        
			 ];
		
			 KpackageOBJ.tuiGrid.create("oTui_R013_List" , "/report/retrieve_R013List" , topColArrayInfo, "number", null, R013.oTui_R013_List_onDblclick_Handler);

			 /* 오류추정영역*/	 
			 var colArrayInfo = [
			        { header : "신규자재여부"			, name: "NEW_CHANGE_FLAG"		, width : 100, align: "center"    , resizable: true, hidden:false},
			        { header : "삭제자재여부"			, name: "DELETE_CHANGE_FLAG"	, width : 100, align: "center"    , resizable: true, hidden:false},
			        { header : "소요량변경여부"		, name: "QTY_CHANGE_FLAG"		, width : 100, align: "center"    , resizable: true, hidden:false},
			        { header : "단위변경여부"			, name: "UNIT_CHANGE_FLAG"		, width : 100, align: "center"    , resizable: true, hidden:false},
					{ header : "제품코드"			, name: "PRODUCT_CODE"			, width : 120, align: "center"    , resizable: true, hidden:false},
			        { header : "현재구성품목"			, name: "CURR_ITEM_CODE"		, width : 120, align: "center"    , resizable: true, hidden:false},
			        { header : "현재구성풍목명"		, name: "CURR_ITEM_NAME"		, width : 200, align: "left"      , resizable: true, hidden:false},
			        { header : "현재소요량"			, name: "CURR_INPUT_QTY"		, width : 100, align: "right"     , resizable: true, hidden:false, formatter: KpackageOBJ.tuiGrid.commas},
			        { header : "현재단위"			, name: "CURR_INPUT_BASS_UNIT"	, width : 80 , align: "center"    , resizable: true, hidden:false},
			        { header : "현재BOM일자"			, name: "CURR_BOM_VERSION"		, width : 120, align: "center"    , resizable: true, hidden:false},
			        { header : "이전구성품목"			, name: "PAST_ITEM_CODE"		, width : 120, align: "center"    , resizable: true, hidden:false},
			        { header : "이전구성풍목명"		, name: "PAST_ITEM_NAME"		, width : 200, align: "left"      , resizable: true, hidden:false},
			        { header : "이전소요량"			, name: "PAST_INPUT_QTY"		, width : 100, align: "right"     , resizable: true, hidden:false, formatter: KpackageOBJ.tuiGrid.commas},
			        { header : "이전단위"			, name: "PAST_INPUT_BASS_UNIT"	, width : 80 , align: "center"    , resizable: true, hidden:false},
			        { header : "이전BOM일자"			, name: "PAST_BOM_VERSION"		, width : 120, align: "center"    , resizable: true, hidden:false}

			    ];
		
			 KpackageOBJ.tuiGrid.create("oTui_R013_detailList"	, "/report/retrieve_R013DetailList"		, colArrayInfo, "number", null);
		}
		
		//Double Click Event
		this.oTui_R013_List_onDblclick_Handler = function(p_GridId, p_RowKey, p_ColName){
			var param = KpackageOBJ.data.makePostData("R013-form");
         	param["COMPANY_CODE"] =  KpackageOBJ.tuiGrid.getCellValue(p_GridId,p_RowKey,"COMPANY_CODE");
         	param["DIVISION_CODE"] =  KpackageOBJ.tuiGrid.getCellValue(p_GridId,p_RowKey,"DIVISION_CODE");
         	param["GRID_PRODUCT_CODE"] =  KpackageOBJ.tuiGrid.getCellValue(p_GridId,p_RowKey,"PRODUCT_CODE");
         	param["GRID_BOM_VERSION"] =  KpackageOBJ.tuiGrid.getCellValue(p_GridId,p_RowKey,"BOM_VERSION");
			R013.retrieve_R013DetailList(param);
		}
		
		//Top Search
		this.retrieve_R013List = function() {
			var param = KpackageOBJ.data.makePostData("R013-form");

			KpackageOBJ.tuiGrid.clear("oTui_R013_detailList");
			KpackageOBJ.tuiGrid.retrieve("oTui_R013_List", "/report/retrieve_R013List", param);
		}
		
		//Bottom Search
		this.retrieve_R013DetailList = function(dbParam) {
			KpackageOBJ.tuiGrid.retrieve("oTui_R013_detailList", "/report/retrieve_R013DetailList", dbParam);
		}
		
	}
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		R013.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});
</script>
</body>
</html>