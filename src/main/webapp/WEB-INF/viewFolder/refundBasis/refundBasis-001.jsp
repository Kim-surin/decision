<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form id="search-form" class="s4-form" novalidate="novalidate">
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
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='common.title.useYn' /></th>
									<td>
										<select class="form-control searchSelect" id="DELETE_YN" name="DELETE_YN" style="width:110px"></select>
									</td>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText">
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:retrieve_gridData();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-7 col-md-7 col-lg-7">
				<table id="grid_Supply_List" name="grid_Supply_List" class="jqgrid-resizable"></table>
					<div id="p_grid_Supply_List"></div>
			</div>
			<div class="col-xs-12 col-sm-5 col-md-5 col-lg-5">
				<div class="ma-b5">
					<table id="grid_PoledgerBySupply" name="grid_PoledgerBySupply" class="jqgrid-resizable"></table>
					<div id="p_grid_PoledgerBySupply"></div>
				</div>
				<div style="margin-top: 11px;">
					<table id="grid_SupplyUser" name="grid_SupplyUser" class="jqgrid-resizable"></table>
					<div id="p_grid_SupplyUser"></div>
				</div>
			</div>
		</div>
		

	
	</section>

</div>
<script>
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		initialize_grid();				// 그리드를 생성합니다.
		Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
		
	});
	
	// Page Object Initialize
	function Initialize_viewObject() {
		var arrayItem = [{value:"", name:"<spring:message code='common.title.all'/>"}
						,{value:"Y", name:"<spring:message code='common.title.useYn.No'/>"}
				        ,{value:"N", name:"<spring:message code='common.title.useYn.Yes'/>"}];

		KpackageOBJ.selectbox.create("search-form", "DELETE_YN", "", null, "value", "name", arrayItem);
		KpackageOBJ.selectbox.create("search-form", "USING_YN", "", null, "value", "name", arrayItem);
		
		/*Search Type Select Box Create */
		arrayItem = [{value:"SEARCH_TYPE_O1", name:"<spring:message code='supplyInfo.title.SUPPLY_CODE'/>"}
					 ,{value:"SEARCH_TYPE_O2", name:"<spring:message code='supplyInfo.title.SUPPLY_NAME'/>"}];
		
		KpackageOBJ.selectbox.create("search-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
		
		/*Search Type Select Box Create */
		arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
		             ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
					 ,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
		
		KpackageOBJ.selectbox.create("search-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
		
	}
	
	// Grid initialize function
	function initialize_grid(){
		
       	var colInfoArray = [
					 {name:"COMPANY_CODE"			,header:"<spring:message code='supplyInfo.title.COMPANY_CODE'/>"       ,width:100    ,align:"center"    ,editable:false    ,hidden:true}
					,{name:"VENDOR_CODE"			,header:"<spring:message code='supplyInfo.title.SUPPLY_CODE'/>"        ,width:100    ,align:"left"      ,editable:false    ,hidden:false}
					,{name:"VENDOR_NAME"			,header:"<spring:message code='supplyInfo.title.SUPPLY_NAME'/>"        ,width:150    ,align:"left"      ,editable:false    ,hidden:false}
					,{name:"VENDOR_NAME_ENG"		,header:"<spring:message code='supplyInfo.title.SUPPLY_NAME_ENG'/>"    ,width:150    ,align:"left"      ,editable:false    ,hidden:true}
					,{name:"NATION_CODE"			,header:"<spring:message code='supplyInfo.title.NATION_CODE'/>"        ,width:80     ,align:"center"    ,editable:false    ,hidden:false	,formatter:grid_Formatter_Nation}
					,{name:"BUSINESS_NO"			,header:"<spring:message code='supplyInfo.title.BIZ_NO'/>"             ,width:100    ,align:"center"    ,editable:false    ,hidden:false}
					,{name:"OFFICER_NAME"			,header:"<spring:message code='supplyInfo.title.OFFICER_NAME'/>"       ,width:100    ,align:"center"    ,editable:false    ,hidden:false}
					,{name:"OFFICER_NAME_ENG"		,header:"<spring:message code='supplyInfo.title.OFFICER_NAME_ENG'/>"   ,width:130    ,align:"left"      ,editable:false    ,hidden:true}
					,{name:"ADDRESS"				,header:"<spring:message code='supplyInfo.title.ADDR'/>"               ,width:200    ,align:"left"      ,editable:false    ,hidden:false}
					,{name:"ADDRESS_ENG"			,header:"<spring:message code='supplyInfo.title.ADDR_ENG'/>"           ,width:300    ,align:"left"      ,editable:false    ,hidden:true}
					,{name:"TEL_NO"					,header:"<spring:message code='supplyInfo.title.OFFICER_TEL_NO'/>"     ,width:100    ,align:"center"    ,editable:false    ,hidden:false}
					,{name:"FAX_NO"					,header:"<spring:message code='supplyInfo.title.OFFICER_FAX_NO'/>"     ,width:100    ,align:"center"    ,editable:false    ,hidden:false}
					,{name:"EMAIL"					,header:"<spring:message code='supplyInfo.title.OFFICER_EMAIL'/>"      ,width:150    ,align:"left"      ,editable:false    ,hidden:false}
					,{name:"CERTIFICATION_YN"		,header:"<spring:message code='supplyInfo.title.CERTIFICATION_YN'/>"   ,width:100    ,align:"center"    ,editable:false    ,hidden:true}
					,{name:"CERTIFICATION_NO"		,header:"<spring:message code='supplyInfo.title.CERTIFICATION_NO'/>"   ,width:100    ,align:"center"    ,editable:false    ,hidden:true}
					,{name:"REMARK"					,header:"<spring:message code='supplyInfo.title.REMARK'/>"             ,width:100    ,align:"center"    ,editable:false    ,hidden:true}
					,{name:"IF_TRANSFER_ID"			,header:"<spring:message code='supplyInfo.title.IF_TRANSFER_ID'/>"     ,width:100    ,align:"center"    ,editable:false    ,hidden:true}
					,{name:"HMC_HUB_ID"				,header:"<spring:message code='supplyInfo.title.HMC_HUB_ID'/>"         ,width:100    ,align:"center"    ,editable:false    ,hidden:true}
					,{name:"MANAGEMENT_YN"			,header:"<spring:message code='supplyInfo.title.MANAGEMENT_YN'/>"      ,width:80     ,align:"center"    ,editable:false    ,hidden:false	,formatter:grid_Formatter_importYn}
					,{name:"MANAGEMENT_YN_HIDDEN"	,header:"<spring:message code='supplyInfo.title.MANAGEMENT_YN'/>"      ,width:80     ,align:"center"    ,editable:false    ,hidden:true}
					,{name:"DELETE_YN"				,header:"<spring:message code='common.title.useYn'/>"    		       ,width:60     ,align:"center"    ,editable:false    ,hidden:false}

       ];
       	var params = { "DUMMY" : "" };
       	var retrieveURL = "/determinBaseInfo/retrieveSupplyList";
       	/* 그리드 생성 */
    	KpackageOBJ.grid.create("grid_Supply_List", retrieveURL, params, colInfoArray, true, 450, "grid_onSelectRow", "grid_onDblClickRow", "grid_loadComplete_Callback");
		    	                    
    	var tools = [{icon:"excel", title:"Excel" ,text:""	,func:"grid_Supply_List_ExcelDown"}];
    	KpackageOBJ.grid.setButton("grid_Supply_List", tools); // Toobar 생성
            	
    	
	   	colInfoArray = [
					 {name:"ITEM_CODE"		    ,header:"<spring:message code='bominfo.title.MATERIAL_CODE'/>"     	,width:100    ,align:"left"      ,editable:false    ,hidden:false}   	                
					,{name:"HS_CODE"		    ,header:"<spring:message code='iteminfo.title.HS_CODE'/>"           ,width:70     ,align:"center"    ,editable:false    ,hidden:false}            
					,{name:"ITEM_NAME"		    ,header:"<spring:message code='TXT.ITEM_NAME'/>"                   	,width:220    ,align:"left"      ,editable:false    ,hidden:false}
					,{name:"WAREHOUSING_DATE"	,header:"<spring:message code='TXT.CURRENT_PO_DATE'/>"          	,width:100    ,align:"center"    ,editable:false    ,hidden:false}   	                
			];
		var params = { "DUMMY" : "" };
       	retrieveURL = "";
       	/* 그리드 생성 */
    	KpackageOBJ.grid.create("grid_PoledgerBySupply", retrieveURL, params, colInfoArray, true, 200, "grid_onSelectRow", "grid_onDblClickRow", "grid_loadComplete_Callback");
       	
       	
		colInfoArray = [
				 {name:"V_USER_INFO_ID"    ,header:"<spring:message  code='SUPPLY_INFO_DETAIL.TITLE.V_USER_INFO_ID'/>" 	 ,width:100    ,align:"center"    ,editable:false    ,hidden:false}
				,{name:"POSITION_NAME"     ,header:"<spring:message  code='SUPPLY_INFO_DETAIL.TITLE.POSITION_NAME'/>"    ,width:100    ,align:"center"    ,editable:false    ,hidden:false}
				,{name:"USER_ID"           ,header:"<spring:message  code='SUPPLY_INFO_DETAIL.TITLE.USER_ID'/>"          ,width:100    ,align:"center"    ,editable:false    ,hidden:false}
				,{name:"CELL_PHONE_NO"     ,header:"<spring:message  code='SUPPLY_INFO_DETAIL.TITLE.CELL_PHONE_NO'/>"    ,width:100    ,align:"center"    ,editable:false    ,hidden:false}
				,{name:"OFFICE_PHONE_NO"   ,header:"<spring:message  code='SUPPLY_INFO_DETAIL.TITLE.OFFICE_PHONE_NO'/>"  ,width:100    ,align:"center"    ,editable:false    ,hidden:false}
				,{name:"FAX_NO"            ,header:"<spring:message  code='SUPPLY_INFO_DETAIL.TITLE.FAX_NO'/>"           ,width:100    ,align:"center"    ,editable:false    ,hidden:false}
				,{name:"EMAIL"             ,header:"<spring:message  code='SUPPLY_INFO_DETAIL.TITLE.EMAIL'/>"            ,width:150    ,align:"left"    ,editable:false    ,hidden:false}
				,{name:"DELETE_YN"         ,header:"<spring:message  code='SUPPLY_INFO_DETAIL.TITLE.DELETE_YN'/>"        ,width:70     ,align:"center"    ,editable:false    ,hidden:false}
			];
		var params = { "DUMMY" : "" };
       	retrieveURL = "";
       	/* 그리드 생성 */
    	KpackageOBJ.grid.create("grid_SupplyUser", retrieveURL, params, colInfoArray, true, 150, "grid_onSelectRow", "grid_onDblClickRow", "grid_loadComplete_Callback");
       	
    	var tools = [{icon:"insert", title:"Add" ,text:""	,func:"openPopup_SupplierUser"}];
    	KpackageOBJ.grid.setButton("grid_SupplyUser", tools); // Toobar 생성
       	
       	/* Caption 설정 */
       	KpackageOBJ.grid.setCaption("grid_Supply_List","<spring:message code='supplyInfo.title.SUPPLY_LIST' />");
       	KpackageOBJ.grid.setCaption("grid_PoledgerBySupply","<spring:message code='supplyInfo.title.ITEM_LIST' />");
       	KpackageOBJ.grid.setCaption("grid_SupplyUser","<spring:message code='supplyInfo.title.SUPPLY_USER_LIST' />");
     	

    	$(window).on('resize.jqGrid', function () {
			$("#grid_Supply_List").jqGrid('setGridWidth', $("#gbox_grid_Supply_List").parent().width() );
			$("#grid_PoledgerBySupply").jqGrid('setGridWidth', $("#gbox_grid_PoledgerBySupply").parent().width() );
			$("#grid_SupplyUser").jqGrid('setGridWidth', $("#gbox_grid_SupplyUser").parent().width() );
			$("#grid_Supply_List").jqGrid('setGridHeight', $(window).height()+(KpackageOBJ.prototype.topDownPx)-180 );  
			$("#grid_PoledgerBySupply").jqGrid('setGridHeight', $(window).height()+(KpackageOBJ.prototype.topDownPx)-419 );
		});
	}
	
	function grid_Formatter_importYn(cellValue, options, rowObject) {
		var rtnObject = '';
		if(cellValue == "Y"){
			rtnObject = '<i id="importYn_'+options.rowId+'" class="fa fa-lg fa-star" style="color: #0c49fb; cursor: pointer;"></i>';	
		}else{
			rtnObject = '<i id="importYn_'+options.rowId+'" class="fa fa-lg fa-star-o" style="color: #0c49fb; cursor: pointer;"></i>';
		}
		return rtnObject;
	}
	
	function grid_Formatter_Nation(cellValue, options, rowObject) {
		var rtnObject = '<img class="flag flag-'+cellValue.toLowerCase()+'"> ' + rowObject.NATION_CODE;
		return rtnObject;
	}
	
	function retrieve_gridData() {
		var params = KpackageOBJ.data.makePostData("search-form");
		KpackageOBJ.grid.retrieve("grid_Supply_List", "/determinBaseInfo/retrieveSupplyList", params);
	}
	
	function grid_onSelectRow(rowIndex, strGridId){
		
		if("grid_Supply_List" == strGridId){
			
			// 중점관리 대상 변경
			var importId = 'importYn_' + rowIndex;
			$('#'+importId).click(function(){
				var supplyInfoData = KpackageOBJ.grid.getSelectedRow(strGridId, rowIndex);
				var msgConfirm = "";
				var importYN = "";
				
				if(supplyInfoData.MANAGEMENT_YN_HIDDEN == "N"){
					msgConfirm = "중점관리 대상으로 변경하시겠습니까?";
				}else{
					msgConfirm = "중점관리 대상에서 제외하시겠습니까?";
				}
				
				if(rowData.MANAGEMENT_YN_HIDDEN == "Y"){
					importYN = "N";
				}else{
					importYN = "Y";
				}
				
				if ( !confirm(msgConfirm) ) {
			        return;
			    }
			 	var params = { "DUMMY" : ""
					  		  ,"VENDOR_CODE" : rowData.VENDOR_CODE
					  		  ,"IMPORTANCE_MGT_YN" : importYN }; 
				KpackageOBJ.ajax.doSubmit("/determinBaseInfo/updateSupplyImportYn", params, "grid_supplyInportyn_update_CallbackHandler");	
			}); 
			
			var rowData = KpackageOBJ.grid.getSelectedRow(strGridId, rowIndex);
			var params = {
					"DUMMY" : ""
					,"VENDOR_CODE" :  rowData.VENDOR_CODE
			};
			KpackageOBJ.grid.retrieve("grid_PoledgerBySupply", "/determinBaseInfo/retrievePoListbyVendor", params);
			KpackageOBJ.grid.retrieve("grid_SupplyUser", "/determinBaseInfo/retrieveVendorUserListbyVendor", params);
		}
	}
	
	function grid_supplyInportyn_update_CallbackHandler(result){
		if (result.success) { // 성공시			
			retrieve_gridData();
			KpackageOBJ.object.alert("<spring:message code='common.msg.saveok'/>");
		} else { // 실패시
			KpackageOBJ.object.alert(result.message);
		}
	}
	
	function grid_onDblClickRow(rowIndex, strGridId){
		if("grid_SupplyUser" == strGridId){
			var rowData = KpackageOBJ.grid.getSelectedRow(strGridId, rowIndex);
			var params = makeStringParameter(rowData, true);
			KpackageOBJ.dialog.open("dialog_supplier_user", "<spring:message code='supplyInfo.title.SUPPLY_USER_LIST_DTL' />", "/determinBaseInfo/viewSupplyUserInfoDetail?" + params, 860, 510);	
		}
		
	}
	function openPopup_SupplierUser(){
		
		var vendor_code = KpackageOBJ.grid.getSelectedRow("grid_Supply_List", KpackageOBJ.grid.getRowIndex("grid_Supply_List"), "VENDOR_CODE");
		if(vendor_code !== undefined){
			KpackageOBJ.dialog.open("dialog_supplier_user", "<spring:message code='supplyInfo.title.SUPPLY_USER_LIST_DTL' />", "/determinBaseInfo/viewSupplyUserInfoDetail?VENDOR_CODE=" + vendor_code, 860, 510);	
		}else{
			KpackageOBJ.object.alert("<spring:message code='supplyInfo.title.SELECT_VENDOR' />");
		}
		
	}
	function grid_loadComplete_Callback(data, strGridId){

	}
	
	
	function grid_Supply_List_ExcelDown(){
		var columns = KpackageOBJ.grid.getGridColumns("grid_Supply_List");
		
		KpackageOBJ.object.setFormValue("search-form", "headers", columns);
		
		var prpt = prompt("<spring:message code='MSG.PLZ_INPUT_FILE_NAME'/>", "파일저장");
		if (prpt == null || prpt == "") {
	        KpackageOBJ.object.alert("<spring:message code='MSG.USER_WORK_CANCEL'/>");
	    } else {
	    	KpackageOBJ.object.setFormValue("search-form", "filename", prpt);
	        KpackageOBJ.object.setFormValue("search-form", "sheetname", prpt);
	        
	        var params = KpackageOBJ.data.makeGetData("search-form");
	        
			KpackageOBJ.ajax.doFileDownload("search-form","/determinBaseInfo/excelSupplyList",params);
	    }
	}
	
	
</script>
</body>
</html>