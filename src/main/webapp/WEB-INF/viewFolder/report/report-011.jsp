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
		<form:form id="R011-form" class="s4-form" novalidate="novalidate" action="/report-011" method="post">
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
										<th><spring:message code='수리일자' /></th>
										<td>
											<input type="text" id="CAL_SEARCH_FROM_DATE"  name="CAL_SEARCH_FROM_DATE" style="width:120px" class="inputText" searchfnc="R011.retrieve_R011List"/>
											<input type="hidden" id="SEARCH_FROM_DATE"  name="SEARCH_FROM_DATE" style="width:120px" class="inputText"/>
											<span class="fromTo-Dash">~</span>
											<input type="text" id="CAL_SEARCH_TO_DATE"  name="CAL_SEARCH_TO_DATE" style="width:120px" class="inputText" searchfnc="R011.retrieve_R011List"/>
											<input type="hidden" id="SEARCH_TO_DATE"  name="SEARCH_TO_DATE" style="width:120px" class="inputText"/>
										</td>	
										
										<th><spring:message code='수입신고번호' /></th>
										<td>
											<select class="form-control searchSelect" id="SEARCH_TYPE_NO" name="SEARCH_TYPE_NO" style="width:110px"></select>
											<select class="form-control searchSelect" id="SEARCH_OPTION_NO" name=SEARCH_OPTION_NO style="width:110px"></select>
											<input type="text" id="SEARCH_KEY_WORD_NO" name="SEARCH_KEY_WORD_NO" class="inputText" searchfnc="R011.retrieve_R011List"/>
										</td>
										<td rowspan=2>
											<div class="input-group-btn">
												<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:R011.retrieve_R011List();">
													<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
												</button>
											</div>
										</td>
									</tr>
									<tr>
										<th><spring:message code='자재코드/거래품명' /></th>
										<td colspan=3>
											<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
											<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
											<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="R011.retrieve_R011List"/>
										</td>
	                                
									</tr>
								</tbody>
							</table>
					</div>
				</div>
			</div>
			<br>
			<div class ="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<ul id="grid_Tab" class="nav nav-tabs bordered">
						<li class="active" id="tab01" >
							<a href="#grid_01" data-toggle="tab" aria-expanded="true"><i class="fa fa-fw fa-lg fa-gear"></i>HS_CODE</a>
						</li>
						<li class=""  id="tab02">
							<a href="#grid_02" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>거래품명</a>
						</li>
						<li class="" id="tab03">
							<a href="#grid_03" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>단가차이</a>
						</li>
					</ul>
					<div id="Grid_TabContent" class="tab-content" style="background: #FFF;display: inline-block;width: 100%;height:270px;">
						<div class="tab-pane fade active in" id="grid_01">
							<div class="widget-body col-xs-9 col-sm-9 col-md-9 col-lg-9" style="position: relative; margin-left:10px">
								<div id="div_oTui_R011_List_01" name="div_oTui_R011_List_01"  >
									<div id="oTui_R011_List_01" ></div>
									<div id="oTui_R011_List_01_paging"></div>
								</div>
							</div>
							<div class="widget-body col-xs-2 col-sm-2 col-md-2 col-lg-2" style="position: relative; float:right; margin-right:10px">
								<div id="div_oTui_R011_ItemList_01" name="div_oTui_R011_ItemList_01"  >
									<div id="oTui_R011_ItemList_01" ></div>
								</div>
							</div>
						</div>
						<div class="tab-pane fade" id="grid_02">
							<div class="widget-body col-xs-9 col-sm-9 col-md-9 col-lg-9" style="position: relative; margin-left:10px">
								<div id="div_oTui_R011_List_02" name="div_oTui_R011_List_02"  >
									<div id="oTui_R011_List_02" ></div>
									<div id="oTui_R011_List_02_paging"></div>
								</div>
							</div>
							<div class="widget-body col-xs-2 col-sm-2 col-md-2 col-lg-2" style="position: relative; float:right; margin-right:10px">
								<div id="div_oTui_R011_ItemList_02" name="div_oTui_R011_ItemList_02" >
									<div id="oTui_R011_ItemList_02"></div>
								</div>
							</div>
						</div>
						<div class="tab-pane fade" id="grid_03">
							<div class="widget-body col-xs-12 col-sm-12 col-md-12 col-lg-12" style="position: relative;">
								<div class="frame-wrap" style="margin-top:5px;padding: 5px;">
									<label class="control-label" style="margin-left:20px">단가차이 : </label>
									<div class="custom-control custom-radio custom-control-inline" style="margin-left:20px">
		                               	<input type="radio" class="custom-control-input" id="PRICE_DIFF_RANGE1" name="PRICE_DIFF_RANGE"  value="1.5" onclick="javascript:R011.retrieve_diffPriceList();"checked="checked">
		                                <label class="custom-control-label" for="PRICE_DIFF_RANGE1">1.5배</label>
		                            </div>
									<div class="custom-control custom-radio custom-control-inline" style="margin-left:20px">
		                                <input type="radio" class="custom-control-input" id="PRICE_DIFF_RANGE2" name="PRICE_DIFF_RANGE" value="2" onclick="javascript:R011.retrieve_diffPriceList();">
		                                <label class="custom-control-label" for="PRICE_DIFF_RANGE2">2배</label>
		                             </div>
									 <div class="custom-control custom-radio custom-control-inline" style="margin-left:20px">
		                                <input type="radio" class="custom-control-input" id="PRICE_DIFF_RANGE3" name="PRICE_DIFF_RANGE" value="5"onclick="javascript:R011.retrieve_diffPriceList();">
		                                <label class="custom-control-label" for="PRICE_DIFF_RANGE3">5배</label>
		                             </div>
									 <div class="custom-control custom-radio custom-control-inline" style="margin-left:20px">
		                                <input type="radio" class="custom-control-input" id="PRICE_DIFF_RANGE4" name="PRICE_DIFF_RANGE" value="10" onclick="javascript:R011.retrieve_diffPriceList();">
		                                <label class="custom-control-label" for="PRICE_DIFF_RANGE4">10배</label>
		                             </div>
		                    	</div>
							</div>
							<div class="widget-body col-xs-9 col-sm-9 col-md-9 col-lg-9" style="position: relative; margin-left:10px">
								<div id="div_oTui_R011_List_03" name="div_oTui_R011_List_03"  >
									<div id="oTui_R011_List_03"></div>
									<div id="oTui_R011_List_03_paging"></div>
								</div>
							</div>
							<div class="widget-body col-xs-2 col-sm-2 col-md-2 col-lg-2" style="position: relative; float:right; margin-right:10px">
								<div id="div_oTui_R011_ItemList_03" name="div_oTui_R011_ItemList_03"  >
									<div id="oTui_R011_ItemList_03" ></div>
								</div>
							</div>
						</div>
					
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div>
						<!-- widget content -->
						<div class="widget-body" style="position: relative;">
							<div id="div_oTui_R011_List" name="div_oTui_R011_List" >
								<div id="oTui_R011_List"   ></div>
								<div id="oTui_R011_List_paging"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form:form>
	</section>

</div>

<script>
	
	var R011 = new function(){
		var fromDay = "";  //최소시작일자
		var toDay = "";    //최대종료일자 
 		
		this.Initialize_viewObject = function() {
	
			/*Search Type Select Box Create */
			
			arrayItem = [{value:"ITEM_CODE", name:"<spring:message code='자재코드'/>"}
						,{value:"ITEM_NAME", name:"<spring:message code='거래품명'/>"}
						];
			
			KpackageOBJ.selectbox.create("R011-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			arrayItem = [{value:"IMPDEC_NO", name:"<spring:message code='신고번호'/>"}
						];
			
			KpackageOBJ.selectbox.create("R011-form", "SEARCH_TYPE_NO", "", null, "value", "name", arrayItem);
			
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			            ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("R011-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			KpackageOBJ.selectbox.create("R011-form", "SEARCH_OPTION_NO", "", null, "value", "name", arrayItem);

			/* Create Calender*/
			toDay = KpackageOBJ.date.getCurrDay();
			fromDay = KpackageOBJ.date.makeDateToString( KpackageOBJ.date.add_months(toDay,-12));

			KpackageOBJ.calendar.create("R011-form", "CAL_SEARCH_FROM_DATE");
			KpackageOBJ.calendar.setValue("R011-form","CAL_SEARCH_FROM_DATE", fromDay);
			KpackageOBJ.object.setFormValue("R011-form","SEARCH_FROM_DATE", fromDay);
			
			KpackageOBJ.calendar.create("R011-form", "CAL_SEARCH_TO_DATE");
			KpackageOBJ.calendar.setValue("R011-form","CAL_SEARCH_TO_DATE", toDay);
			KpackageOBJ.object.setFormValue("R011-form","SEARCH_TO_DATE",toDay);
			
			/* Create Grid*/
			R011.renderTuiGrid();
			

			/* Create Tab Event*/
			$("#grid_Tab.nav.nav-tabs li").click(function(){
				//Search And ResizingGrid
				if(this.id == "tab01"){
					R011.retrieve_diffHsCodeList(); 
					//setTimeout(R011.reSizingGrid, 300);
					
				}else if(this.id == "tab02"){
					R011.retrieve_diffItemNmList();
					//setTimeout(R011.reSizingGrid, 300);
				}else if(this.id == "tab03"){
					R011.retrieve_diffPriceList(); 
					//setTimeout(R011.reSizingGrid, 300);
				}
			});
		}
		
		this.renderTuiGrid = function() {
			 
			 /* 오류추정영역*/	 
			 var colArrayInfo = [
				 	{ header : "구분"				, name: "GUBUN"				, width : 60 , align: "center"   , resizable: true, hidden:false},
			        { header : "수입신고번호"			, name: "IMPDEC_MANAGE_NO"	, width : 150, align: "left"     , resizable: true, hidden:false},
			        { header : "수리일자"			, name: "ACPT_DATE"			, width : 120, align: "center"   , resizable: true, hidden:false},
			        { header : "HS_CODE"			, name: "HS_CODE"			, width : 120, align: "center"   , resizable: true, hidden:false},
			        { header : "자재코드"			, name: "ITEM_CODE"			, width : 100, align: "center"   , resizable: true, hidden:false},
			        { header : "품명"				, name: "ITEM_NAME"			, width : 200, align: "left"     , resizable: true, hidden:false},
			        { header : "단가"				, name: "ITEM_PRICE"		, width : 120, align: "right"    , resizable: true, hidden:false, formatter: KpackageOBJ.tuiGrid.commas},
			        { header : "수량(단위)"			, name: "ITEM_QTY"			, width : 120, align: "right"    , resizable: true, hidden:false},
			        { header : "금액"				, name: "ITEM_AMOUNT"		, width : 150, align: "right"    , resizable: true, hidden:false, formatter: KpackageOBJ.tuiGrid.commas}
			    ];
		
			 KpackageOBJ.tuiGrid.create("oTui_R011_List"	, "/report/retrieve_R011List"		, colArrayInfo, "number", null);
			 KpackageOBJ.tuiGrid.setBodyHeight("oTui_R011_List", "480");
			 KpackageOBJ.tuiGrid.create("oTui_R011_List_01" , "/report/retrieve_diffHsCodeList" , colArrayInfo, "number", null, R011.oTui_R011_List_onDblclick_Handler);
			 KpackageOBJ.tuiGrid.create("oTui_R011_List_02" , "/report/retrieve_diffItemNmList" , colArrayInfo, "number", null, R011.oTui_R011_List_onDblclick_Handler);
			 KpackageOBJ.tuiGrid.create("oTui_R011_List_03" , "/report/retrieve_diffPriceList"  , colArrayInfo, "number", null, R011.oTui_R011_List_onDblclick_Handler);
		
			 
			 /*자재코드 영역*/
			 var colArrayInfo2 = [
				 	{ header : "자재코드"			, name: "ITEM_CODE"			, width : 200, align: "center"   , resizable: true, hidden:false}
			    ];
		
			 KpackageOBJ.tuiGrid.create("oTui_R011_ItemList_01" , "/report/retrieve_diffHsCodeItemList" , colArrayInfo2, "", null, R011.oTui_R011_List_onDblclick_Handler);
			 KpackageOBJ.tuiGrid.create("oTui_R011_ItemList_02" , "/report/retrieve_diffItemNmItemList" , colArrayInfo2, "", null, R011.oTui_R011_List_onDblclick_Handler);
			 KpackageOBJ.tuiGrid.create("oTui_R011_ItemList_03" , "/report/retrieve_diffPriceItemList" , colArrayInfo2, "", null, R011.oTui_R011_List_onDblclick_Handler);

			 
		}
		
		//Double Click Event
		this.oTui_R011_List_onDblclick_Handler = function(p_GridId, p_RowKey, p_ColName){
         	var param = {					
		         			  "SEARCH_FROM_DATE" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_FROM_DATE")
				 		 	, "SEARCH_TO_DATE" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_TO_DATE")
				         	, "SEARCH_OPTION" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_OPTION")
				         	, "SEARCH_TYPE_NO" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_TYPE_NO")
					        , "SEARCH_OPTION_NO" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_OPTION_NO")
         				};
			
			if(p_ColName =="ITEM_CODE"){
				param["SEARCH_TYPE"] = p_ColName;
				param["SEARCH_KEY_WORD"] = KpackageOBJ.tuiGrid.getCellValue(p_GridId,p_RowKey,p_ColName);
				param["SEARCH_KEY_WORD_NO"] = "";
				R011.retrieve_R011List(param);
			}else if(p_ColName == "ITEM_NAME"){
				param["SEARCH_TYPE"] = p_ColName;
				param["SEARCH_KEY_WORD"] = KpackageOBJ.tuiGrid.getCellValue(p_GridId,p_RowKey,p_ColName);
				param["SEARCH_KEY_WORD_NO"] = "";
				R011.retrieve_R011List(param);
			}else if(p_ColName == "IMPDEC_MANAGE_NO"){
				param["SEARCH_KEY_WORD"] = "";
				param["SEARCH_KEY_WORD_NO"] = KpackageOBJ.tuiGrid.getCellValue(p_GridId,p_RowKey,p_ColName);
				R011.retrieve_R011List(param);
			}
		}
		
		//Bottom Search
		this.retrieve_R011List = function(dbParam) {
			var searchFromDate = KpackageOBJ.object.getFormValue("R011-form","SEARCH_FROM_DATE");
			var searchToDate = KpackageOBJ.object.getFormValue("R011-form","SEARCH_TO_DATE");
			var tabId = $("#grid_Tab li[class='active']").attr("id");
			//validation Check
			/* 
			if(KpackageOBJ.date.getDiffDay(searchFromDate, searchToDate) > 366 )
			{
				alert("최대 조회가능기간은 1년입니다.");
				return false;
			} */
			
			//param Setting
			var param = { "SEARCH_FROM_DATE" : searchFromDate
					 	, "SEARCH_TO_DATE" : searchToDate
			         	, "SEARCH_TYPE" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_TYPE")
			         	, "SEARCH_OPTION" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_OPTION")
			         	, "SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_KEY_WORD")
			         	, "SEARCH_TYPE_NO" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_TYPE_NO")
			         	, "SEARCH_OPTION_NO" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_OPTION_NO")
			         	, "SEARCH_KEY_WORD_NO" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_KEY_WORD_NO")
			         	};
			
			if(!oUtil.isNull(dbParam)){
				//Double Click Parameter Change
				param = dbParam;   
			}else{
				//Tab Search
				if(tabId =="tab01"){
					R011.retrieve_diffHsCodeList();
				}else if(tabId == "tab02"){
					R011.retrieve_diffItemNmList();
				}else if(tabId == "tab03"){
					R011.retrieve_diffPriceList();
				}
			}
			
			param["ACTIVE_TAB"] = tabId;
			KpackageOBJ.tuiGrid.retrieve("oTui_R011_List", "/report/retrieve_R011List", param);
		}
		

		this.retrieve_diffHsCodeList = function() {
			var param = {
					  "SEARCH_FROM_DATE" :  KpackageOBJ.object.getFormValue("R011-form","SEARCH_FROM_DATE")
				 	, "SEARCH_TO_DATE" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_TO_DATE")
					, "SEARCH_TYPE" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_TYPE")
		         	, "SEARCH_OPTION" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_OPTION")
		         	, "SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_KEY_WORD")
		         	, "SEARCH_TYPE_NO" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_TYPE_NO")
		         	, "SEARCH_OPTION_NO" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_OPTION_NO")
		         	, "SEARCH_KEY_WORD_NO" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_KEY_WORD_NO")
		         	};
			
			KpackageOBJ.tuiGrid.retrieveWithCallBack("oTui_R011_List_01", "/report/retrieve_diffHsCodeList", param, "", "R011.retrieve_diffHsCodeListCallBack");
		}
		
		this.retrieve_diffHsCodeListCallBack = function(result) {
			var itemList = KpackageOBJ.tuiGrid.getColValues("oTui_R011_List_01","ITEM_CODE");
			var uItemList = [...new Set(itemList)];
			
			R011.setItemList("oTui_R011_ItemList_01", uItemList);
			setTimeout(R011.reSizingGrid, 300);
		}
		
		
		this.retrieve_diffItemNmList = function() {
			
			var param = {
					
					  "SEARCH_FROM_DATE" :  KpackageOBJ.object.getFormValue("R011-form","SEARCH_FROM_DATE")
				 	, "SEARCH_TO_DATE" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_TO_DATE")
					, "SEARCH_TYPE" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_TYPE")
		         	, "SEARCH_OPTION" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_OPTION")
		         	, "SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_KEY_WORD")
		         	, "SEARCH_TYPE_NO" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_TYPE_NO")
		         	, "SEARCH_OPTION_NO" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_OPTION_NO")
		         	, "SEARCH_KEY_WORD_NO" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_KEY_WORD_NO")
		         	};
			
			KpackageOBJ.tuiGrid.retrieveWithCallBack("oTui_R011_List_02", "/report/retrieve_diffItemNmList", param, "", "R011.retrieve_diffItemNmListCallBack");
		}
		
		this.retrieve_diffItemNmListCallBack = function(result) {
			var itemList = KpackageOBJ.tuiGrid.getColValues("oTui_R011_List_02","ITEM_CODE");
			var uItemList = [...new Set(itemList)];
			
			R011.setItemList("oTui_R011_ItemList_02", uItemList);
			setTimeout(R011.reSizingGrid, 300);
		}

		this.retrieve_diffPriceList = function() {
			var param = {					
					  "SEARCH_FROM_DATE" :  KpackageOBJ.object.getFormValue("R011-form","SEARCH_FROM_DATE")
		 	        , "SEARCH_TO_DATE" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_TO_DATE")
					, "SEARCH_TYPE" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_TYPE")
		         	, "SEARCH_OPTION" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_OPTION")
		         	, "SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_KEY_WORD")
		         	, "SEARCH_TYPE_NO" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_TYPE_NO")
		         	, "SEARCH_OPTION_NO" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_OPTION_NO")
		         	, "SEARCH_KEY_WORD_NO" : KpackageOBJ.object.getFormValue("R011-form","SEARCH_KEY_WORD_NO")
		         	, "PRICE_DIFF_RANGE" :  KpackageOBJ.object.getFormRadioValue("R011-form","PRICE_DIFF_RANGE") 
		         	};

			KpackageOBJ.tuiGrid.retrieveWithCallBack("oTui_R011_List_03", "/report/retrieve_diffPriceList", param, "", "R011.retrieve_diffPriceListCallBack");
		}

		this.retrieve_diffPriceListCallBack = function(result) {
			var itemList = KpackageOBJ.tuiGrid.getColValues("oTui_R011_List_03","ITEM_CODE");
			var uItemList = [...new Set(itemList)];
			
			R011.setItemList("oTui_R011_ItemList_03", uItemList);
			setTimeout(R011.reSizingGrid, 300);
		}
		
		
		this.reSizingGrid = function(){
			var tabId = $("#grid_Tab li[class='active']").attr("id");
			var gridNo = tabId.replaceAll("tab","");
			var gridHeight = gridNo == "03" ? "150" : "180"; 		
			
			KpackageOBJ.tuiGrid.reSizingGrid("oTui_R011_List_"+gridNo);
			KpackageOBJ.tuiGrid.reSizingGrid("oTui_R011_ItemList_"+gridNo);
			KpackageOBJ.tuiGrid.setBodyHeight("oTui_R011_List_"+gridNo, gridHeight);
			KpackageOBJ.tuiGrid.setBodyHeight("oTui_R011_ItemList_"+gridNo, gridHeight);
			
		}
	
		
		this.setItemList = function(gridId , data){
			var itemArray =[];
			for(var i = 0; i < data.length; i++){
				itemArray.push({"ITEM_CODE":+data[i]})
			}
			KpackageOBJ.tuiGrid.setData(gridId, itemArray);
		}
		
		
	}
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		R011.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
		R011.retrieve_diffHsCodeList(); 
	});
</script>
</body>
</html>