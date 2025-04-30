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
		<form:form id="MM003-form" class="s4-form" novalidate="novalidate">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;" />
								<col style="width: 50%;" />
								<col style="width: 80px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="MM003.retrieve_gridData"/>
									</td>
									<th><spring:message code='view.DELETE_YN' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_DELETE_DRCTR" name="SEARCH_DELETE_DRCTR" style="width:110px"></select>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:MM003.retrieve_gridData();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			</div>
		</form:form>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_Customer_List" name="div_oTui_Customer_List" class="tuigrid-resizable">
					<div id="oTui_Customer_List" data-minus-height="240"></div>
					<div id="oTui_Customer_List_paging"></div>
				</div>
			</div>
		</div>
	</section>
</div>
<script>
	var MM003 = new function() {
	
		// Page Object Initialize
		this.initialize_viewObject = function() {
			var arrayItem = [{value:"", name:"<spring:message code='common.title.all'/>"}
							,{value:"N", name:"<spring:message code='common.title.useYn.No'/>"}
					        ,{value:"X", name:"<spring:message code='common.title.useYn.Yes'/>"}];
	
			KpackageOBJ.selectbox.create("MM003-form", "SEARCH_DELETE_DRCTR", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"VENDOR_CODE", name:"<spring:message code='TXT.VENDOR_CODE'/>"}
						 ,{value:"VENDOR_NAME", name:"<spring:message code='TXT.VENDOR_NAME'/>"}];
			
			KpackageOBJ.selectbox.create("MM003-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			             ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						 ,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("MM003-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
		};
		
		this.initialize_TuiGrid = function(){
			var colArrayInfo = [
				 	{ header : "회사 코드"     , name: "COMPANY_CODE", width: 100, align: "center", hidden:true  },
				 	{ header : "협력사코드"    , name: "VENDOR_CODE" , width: 100, align: "center", hidden:false },
				 	{ header : "통관 고유부호" , name: "ECTMRK"      , width: 100, align: "center", hidden:false },
				 	{ header : "협력사명"      , name: "VENDOR_NAME"   , width: 100, align: "center", hidden:false },
				 	{ header : "대표자"        , name: "RPRSNTV_NM"  , width: 100, align: "left"  , hidden:false },
				 	{ header : "국가"          , name: "NATION_CODE" , width:  50, align: "center", hidden:true  },
				 	{ header : "국가"          , name: "NATION_NM"   , width: 100, align: "center", hidden:false },
				 	{ header : "사업자등록번호", name: "BIZRNO"      , width: 150, align: "center", hidden:false },
				 	{ header : "우편번호"      , name: "ZIP"         , width: 200, align: "center", hidden:false },
				 	{ header : "주소"          , name: "ADRES"       , width: 100, align: "center", hidden:false },
				 	{ header : "전화번호1"     , name: "TELNO_1"     , width: 100, align: "left"  , hidden:false },
				 	{ header : "전화번호2"     , name: "TELNO_2"     , width: 100, align: "center", hidden:false },
				 	{ header : "팩스번호"      , name: "FXNUM"       , width: 100, align: "center", hidden:false },
				 	{ header : "E-MAIL"        , name: "EMAIL_ADRES" , width: 100, align: "center", hidden:false },
				 	{ header : "제외"          , name: "EXCL_AT"     , width: 100, align: "left"  , hidden:true  },
				 	{ header : "삭제지시자"    , name: "DELETE_DRCTR", width:  30, align: "center", hidden:true  }
	
			    ];
			 
			KpackageOBJ.tuiGrid.create("oTui_Customer_List", "/master/retrieveVendorList", colArrayInfo, null, null, MM003.onDblClick_oTui_Vendor_List);
		       	
			/* var tools = [{icon:"insert", title:"Add" ,text:"추가"	,func:"openPopup_CreateVendor"}];
	    	KpackageOBJ.tuiGrid.setButton("oTui_Customer_List", tools); // Toobar 생성 */
	    	
		};
		 
		this.onClick_oTui_Customer_List = function(gridId, rowkey, colName){
		};
		 
		this.onDblClick_oTui_Vendor_List = function(gridId, rowkey, colName){
			var rowData = KpackageOBJ.tuiGrid.getSelectedRowlValue(gridId, rowkey);
			var param = {"COMPANY_CODE":rowData.COMPANY_CODE
						,"VENDOR_CODE":rowData.VENDOR_CODE
						,"INPUT_FLAG":"U"}
			var params = makeStringParameter(param, true);
			KpackageOBJ.dialog.open("vendor_Dtl", "Vendor Detail", "/mm-00301?"+params, KpackageOBJ.prototype.pop_M_Width, KpackageOBJ.prototype.pop_M_Height);
		};
		 
		this.retrieve_gridData = function(){
			var param = {"SEARCH_DELETE_DRCTR":KpackageOBJ.object.getFormValue("MM003-form", "SEARCH_DELETE_DRCTR")
						,"SEARCH_TYPE":KpackageOBJ.object.getFormValue("MM003-form", "SEARCH_TYPE")
						,"SEARCH_OPTION":KpackageOBJ.object.getFormValue("MM003-form", "SEARCH_OPTION")
						,"SEARCH_KEY_WORD":KpackageOBJ.object.getFormValue("MM003-form", "SEARCH_KEY_WORD")};
			KpackageOBJ.tuiGrid.retrieve("oTui_Customer_List", "", param);
		};
		
		this.openPopup_CreateVendor = function(){
			KpackageOBJ.dialog.open("vendor_Dtl", "Vendor Detail", "/mm-00301", KpackageOBJ.prototype.pop_M_Width, KpackageOBJ.prototype.pop_M_Height);
		};
	};

	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		MM003.initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
		MM003.initialize_TuiGrid();
		
	});


</script>
</body>
</html>