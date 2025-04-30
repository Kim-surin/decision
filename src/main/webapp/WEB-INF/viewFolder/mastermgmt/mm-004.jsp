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
		<form:form id="MM004-form" class="s4-form" novalidate="novalidate">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<input type="hidden" id="SEARCH_YYYYMMDD" name="SEARCH_YYYYMMDD"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 100px;" />
								<col style="width: " />
								<col style="width: 100px;" />
								<col style="width: " />
								<col style="width: 100px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th>기준일자</th>
									<td>
										<input type="text" id="CAL_SEARCH_YYYYMMDD" name="CAL_SEARCH_YYYYMMDD" style="width:120px" class="inputText" searchfnc="MM004.retrieve_gridData"/>
									</td>
									<th>HS CODE</th>
									<td>
										<input type="text" id="SEARCH_HS_CODE" name="SEARCH_HS_CODE" class="inputText" searchfnc="MM004.retrieve_gridData">
									</td>
									<th>환급제한규정</th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_DRWBAK_LMTT_REGLTN" name="SEARCH_DRWBAK_LMTT_REGLTN" style="width:110px"></select>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:MM004.retrieve_gridData();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			</div>
		</form:form>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_Drwbak_Lmtt_List" name="div_oTui_Drwbak_Lmtt_List" class="tuigrid-resizable">
					<div id="oTui_Drwbak_Lmtt_List" data-minus-height="270"></div>
					<div id="oTui_Drwbak_Lmtt_List_paging"></div>
				</div>
			</div>
		</div>
	</section>
</div>
<script>
	var MM004 = new function() {
		// Page Object Initialize
		this.initialize_viewObject = function() {
			
			/* Calendar Type Object Create  */
			KpackageOBJ.calendar.create("MM004-form", "CAL_SEARCH_YYYYMMDD");
			KpackageOBJ.calendar.setValue("MM004-form","CAL_SEARCH_YYYYMMDD", "${sessionScope._sessionUser.WORK_DATE}".replace(/-/gi, ""));
			
			KpackageOBJ.object.setFormValue("MM004-form", "SEARCH_YYYYMMDD", "${sessionScope._sessionUser.WORK_DATE}".replace(/-/gi, ""));
			
			KpackageOBJ.selectbox.create("MM004-form", "SEARCH_DRWBAK_LMTT_REGLTN", "/common/retrieveComCdList", {"CATEGORY_CD":"DL","OPTION_ALL":"Y"}, "CODE", "NAME");
		};
		
		this.initialize_TuiGrid = function(){
			var colArrayInfo = [
				 	{ header : "회사 코드"    , name: "COMPANY_CODE"         , width: 100, align: "center", hidden:true  },
				 	{ header : "환급제한규정" , name: "DRWBAK_LMTT_REGLTN"   , width: 100, align: "center", hidden:true  },
				 	{ header : "환급제한규정" , name: "DRWBAK_LMTT_REGLTN_NM", width: 100, align: "center", hidden:false },
				 	{ header : "HS CODE"      , name: "HS_CODE"              , width: 100, align: "center", hidden:false  , formatter: KpackageOBJ.tuiGrid.hscode6},
				 	{ header : "효력 시작일"  , name: "EFECT_BGNDE"          , width: 100, align: "center", hidden:false  , formatter: KpackageOBJ.tuiGrid.dateFormatter},
				 	{ header : "효력 종료일"  , name: "EFECT_ENDDE"          , width: 100, align: "center", hidden:false  , formatter: KpackageOBJ.tuiGrid.dateFormatter},
				 	{ header : "비고"         , name: "RM"                   , width: 400, align: "left"  , hidden:false }
	
			    ];
			 
			KpackageOBJ.tuiGrid.create("oTui_Drwbak_Lmtt_List", "/master/retrieveDrwbakLmttList", colArrayInfo, "number", null, MM004.onDblClick_oTui_Drwbak_Lmtt_List);
		       	
			var tools = [{icon:"insert", title:"Add" ,text:"추가"	,func:"MM004.openPopup_Drwbak_Lmtt"}];
	    	KpackageOBJ.tuiGrid.setButton("oTui_Drwbak_Lmtt_List", tools); // Toobar 생성
	    	
		};
		 
		this.onClick_oTui_Drwbak_Lmtt_List = function(gridId, rowkey, colName){
		};
		 
		this.onDblClick_oTui_Drwbak_Lmtt_List = function(gridId, rowkey, colName){
			var rowData = KpackageOBJ.tuiGrid.getSelectedRowlValue(gridId, rowkey);
			var param = {"COMPANY_CODE":rowData.COMPANY_CODE
						,"DRWBAK_LMTT_REGLTN":rowData.DRWBAK_LMTT_REGLTN
						,"HS_CODE":rowData.HS_CODE
						,"EFECT_BGNDE":rowData.EFECT_BGNDE
						,"INPUT_FLAG":"U"}
			var params = makeStringParameter(param, true);
			KpackageOBJ.dialog.open("drwbakLmtt_Dtl", "환급제한규정 상세", "/mm-00401?"+params, 800, 330);
		};
		 
		this.retrieve_gridData = function(){
			var param = {"SEARCH_DRWBAK_LMTT_REGLTN":KpackageOBJ.object.getFormValue("MM004-form", "SEARCH_DRWBAK_LMTT_REGLTN")
						,"SEARCH_HS_CODE":KpackageOBJ.object.getFormValue("MM004-form", "SEARCH_HS_CODE")
						,"SEARCH_YYYYMMDD":KpackageOBJ.object.getFormValue("MM004-form", "SEARCH_YYYYMMDD")};
			KpackageOBJ.tuiGrid.retrieve("oTui_Drwbak_Lmtt_List", "", param);
		};
		
		this.openPopup_Drwbak_Lmtt = function(){
			var param = {"INPUT_FLAG":"I"}
			var params = makeStringParameter(param, true);
			KpackageOBJ.dialog.open("drwbakLmtt_Dtl", "환급제한규정 상세", "/mm-00401?"+params, 800, 330);
		};
	};

	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		MM004.initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
		MM004.initialize_TuiGrid();
		
	});


</script>
</body>
</html>