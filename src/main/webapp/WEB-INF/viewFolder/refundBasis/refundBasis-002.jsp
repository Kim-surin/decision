<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    /**********************************************************************************************
    * PGM ID : RB002
    * PGM DESC : 수입신고
    * Remark : 수입면장정보를 조회할 수 있다.
    *
    **********************************************************************************************/
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form:form id="RB002-search-form" class="s4-form" novalidate="novalidate" action="/refundBasis-002" method="post">
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
								<col style="width: 30px;" />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='수입일자' /></th>
									<td>
										<input type="text" id="CAL_SEARCH_FROM_DATE"  name="CAL_SEARCH_FROM_DATE" style="width:120px" class="inputText" searchfnc="RB002.retrieve_gridData"/>
										<span class="fromTo-Dash">~</span>
										<input type="text" id="CAL_SEARCH_TO_DATE"  name="CAL_SEARCH_TO_DATE" style="width:120px" class="inputText" searchfnc="RB002.retrieve_gridData"/>
									</td>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="RB002.retrieve_gridData"/>
									</td>
									<td class="no-pd">
                                       <div class="input-group-btn">
                                            <button class="btn-default btn-primary btn-custom-search" name="switchFilterBtn" style="padding: 8px 0px;" type="button" onclick="javascript:KpackageOBJ.object.switchFilter(this,'DB007');">
                                                <i class="fa fa-arrow-down"></i>
                                            </button>
                                        </div>
                                    </td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:RB002.retrieve_gridData();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
			<div id="DB007-HIDDEN-FILTER" class="row-extends row switchFilter" >
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <colgroup>
                                <col style="width: 120px;" />
                                <col style="width: 25%;" />
                                <col style="width: 120px;" />
                                <col style="width: 25%;" />
                                <col style="width: 100px;" />
                                <col style="width: " />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th><spring:message code='수입거래구분' /></th>
                                    <td>
                                        <select class="form-control searchSelect" id="INCME_DELNG_SE" name="INCME_DELNG_SE" style="width:99%"/>
                                    </td>
                                    <th><spring:message code='수입종류' /></th>
                                    <td>
                                        <select class="form-control searchSelect" id="INCME_TYPE" name="INCME_TYPE" style="width:99%"/>
                                    </td>
                                    <th><spring:message code='L/C No.' /></th>
                                    <td>
                                    	<input type="text" id="LC_NO"  name="LC_NO" style="width:99%" class="inputText" maxlength="20" searchfnc="RB002.retrieve_gridData"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th><spring:message code='B/L No.' /></th>
                                    <td>
                                        <input type="text" id="BL_NO"  name="BL_NO" style="width:99%" class="inputText" maxlength="40" searchfnc="RB002.retrieve_gridData"/>
                                    </td>
                                    <th><spring:message code='HS CODE' /></th>
                                    <td colspan="3">
                                        <input type="text" id="HS_CODE"  name="HS_CODE" style="width:99%" class="inputText" maxlength="10" searchfnc="RB002.retrieve_gridData"/>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>              
                </div>
            </div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_RB002_grid_01" name="div_oTui_RB002_grid_01" class="tuigrid-resizable">
					<div id="oTui_RB002_grid_01" data-minus-height="240"></div>
					<div id="oTui_RB002_grid_01_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>

	var RB002 = new function(){
		
		// Page Object Initialize
		this.initialize_Object = function() {
			
			var fromDay = KpackageOBJ.date.getCurrMonth() + "01";
			var toDay = KpackageOBJ.date.getCurrDay();
			
			KpackageOBJ.calendar.create("RB002-search-form", "CAL_SEARCH_FROM_DATE");
			KpackageOBJ.calendar.setValue("RB002-search-form","CAL_SEARCH_FROM_DATE", fromDay);
			
			KpackageOBJ.calendar.create("RB002-search-form", "CAL_SEARCH_TO_DATE");
			KpackageOBJ.calendar.setValue("RB002-search-form","CAL_SEARCH_TO_DATE", toDay);
	
			/*Search Type Select Box Create */
			arrayItem = [{value:"IMPDEC_MANAGE_NO", name:"<spring:message code='수입신고번호'/>"}
						,{value:"ITEM_CODE", name:"<spring:message code='자재코드'/>"}
						,{value:"ITEM_NM", name:"<spring:message code='자재명'/>"}];
			
			KpackageOBJ.selectbox.create("RB002-search-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			            ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("RB002-search-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
			
			
			KpackageOBJ.selectbox.create("RB002-search-form", "INCME_DELNG_SE",  "/common/retrieveComCdList", {"CATEGORY_CD":"IMPT","OPTION_ALL":"Y"}, "CODE", "NAME");    
			
			
			KpackageOBJ.selectbox.create("RB002-search-form", "INCME_TYPE",  "/common/retrieveComCdList", {"CATEGORY_CD":"IMPD","OPTION_ALL":"Y"}, "CODE", "NAME");    
			
		}
		
		this.initialize_TuiGrid = function(){ 
			 
			 var colArrayInfo = [
				 {"header" :'수입신고번호',			name:'IMPDEC_NO',				width:150,			align:'center',		resizable: true, hidden:false },
				 {"header" :'수리일자',				name:'ACPT_DATE',				width:100,			align:'center',		formatter:KpackageOBJ.tuiGrid.dateFormatter,	resizable: true, hidden:false},
				 {"header" :'수입수량',					name:'QY',					width:100,			align:'right',		resizable: true, hidden:false,	formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'사용량',				name:'DLIVY_QY',				width:100,			align:'right',		resizable: true, hidden:false,	formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'잔량',					name:'REMNDR_QY',				width:100,			align:'right',		resizable: true, hidden:false,	formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'총 세액',             name:'TOT_TAXAMT',              width:100,          align:'right',      resizable: true, hidden:false,   formatter:KpackageOBJ.tuiGrid.commas},
                 {"header" :'사용세액',      name:'USE_TAX',             			width:100,          align:'right',      resizable: true, hidden:false,   formatter:KpackageOBJ.tuiGrid.commas},
                 {"header" :'잔량 세액',            name:'REMNDR_TAX',              width:100,          align:'right',      resizable: true, hidden:false,   formatter:KpackageOBJ.tuiGrid.commas},
                 {"header" :'신고금액',             name:'CVODV_USD',               width:100,          align:'right',      formatter:KpackageOBJ.tuiGrid.commas,   resizable: true, hidden:false},
                 {"header" :'신고금액',             name:'CVODV_KRW',               width:100,          align:'right',      formatter:KpackageOBJ.tuiGrid.commas,   resizable: true, hidden:false},
				 {"header" :'사용유무',				name:'USE_YN',					width:100,			align:'center',		resizable: true, hidden:false},
				 {"header" :'환급일자',				name:'LAST_USE_YYYYMMDD',		width:100,			align:'center',		resizable: true, hidden:false ,	formatter:KpackageOBJ.tuiGrid.dateFormatter},
				 {"header" :'IMPDEC_MANAGE_NO',		name:'IMPDEC_MANAGE_NO',		width:100,			align:'center',		hidden:true}
			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_RB002_grid_01", "/refundBasis/retrieveRB002Grid", colArrayInfo, 'number', null, RB002.onDblClick_oTui_RB002_grid_01);
			 
		}
		
		this.onDblClick_oTui_RB002_grid_01 = function(gridId, rowkey, colName){
			var rowData = KpackageOBJ.tuiGrid.getSelectedRowlValue(gridId, rowkey);
			var param = {	"COMPANY_CODE":rowData.COMPANY_CODE
							,"IMPDEC_NO":rowData.IMPDEC_NO
							,"IMPDEC_MANAGE_NO":rowData.IMPDEC_MANAGE_NO
							,"INPUT_FLAG":"U"	
						}
			var params = makeStringParameter(param, true);
			KpackageOBJ.dialog.open("RB002_Dtl", "수입신고 상세", "/refundBasis-00201?"+params, 1220, KpackageOBJ.prototype.pop_M_Height+30);
		};
		 
		this.retrieve_gridData = function() {
			
			var param = KpackageOBJ.data.makePostData("RB002-search-form");  
			KpackageOBJ.tuiGrid.retrieve("oTui_RB002_grid_01", "/refundBasis/retrieveRB002Grid", param);
		};
		
	} 
	
	$(document).ready(function() {
		
		pageSetUp();				// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		RB002.initialize_Object(); 		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		RB002.initialize_TuiGrid();		 
	});

</script>
</body>
</html>