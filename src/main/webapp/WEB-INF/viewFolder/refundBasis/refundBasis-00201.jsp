<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="content">
	<div class="widget-body">
		<form:form id="RB00201-detail-form" class="s4-form form-horizontal form-dialog" novalidate="novalidate">
			<input type="hidden" name="COMPANY_CODE" id="COMPANY_CODE"/>
			<input type="hidden" name="INPUT_FLAG" id="INPUT_FLAG" value="${reqParam.INPUT_FLAG}"/>
			<fieldset>
				<div class="dialog-form-group">
					<div class="col-md-12 table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 110px;" />
								<col style="width: " />
								<col style="width: 110px;" />
								<col style="width: " />
								<col style="width: 110px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th>수입신고번호</th>
									<td colspan="3">
										<input type="text" id ="IMPDEC_NO" name="IMPDEC_NO" class="form-control"/>
									</td>
								</tr>
								<tr>
									<th>L/C No.</th>
									<td>
										<input type="text" id ="LC_NO" name="LC_NO" class="form-control" />
									</td>
									<th>B/L No.</th>
									<td>
										<input type="text" id ="BL_NO" name="BL_NO" class="form-control" />
									</td>
									<th><spring:message code='수입거래구분' /></th>
                                    <td>
                                        <select class="form-control searchSelect" id="INCME_DELNG_SE" name="INCME_DELNG_SE" style="width:99%"/>
                                    </td>
								</tr>
								<tr>
									<th>신고금액</th>
									<td>
										<input type="text" id ="CVODV_KRW" name="CVODV_KRW" class="form-control" />
									</td>
									<th>수입수량</th>
									<td>
										<input type="text" id ="QY" name="QY" class="form-control" />
									</td>
									 <th><spring:message code='수입종류' /></th>
                                    <td>
                                        <select class="form-control searchSelect" id="INCME_TYPE" name="INCME_TYPE"/>
                                    </td>
								</tr>
								<tr>
									<th>총 관세금액</th>
									<td>
										<input type="text" id ="CSTMS" name="CSTMS" class="form-control" />
									</td>
									<th>총 세액</th>
									<td>
										<input type="text" id ="TOT_TAXAMT" name="TOT_TAXAMT" class="form-control" />
									</td>
									<th><spring:message code='수입국' /></th>
                                    <td>
                                        <select class="form-control searchSelect" id="XPORT_NATION_CODE" name="XPORT_NATION_CODE" style="width:99%"/>
                                    </td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</fieldset>
		</form:form>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-xs-4 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_RB00201_grid_01" name="div_oTui_RB00201_grid_01" class="tuigrid-resizable">
					<div id="oTui_RB00201_grid_01" data-fixed-height="170"></div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-8 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_RB00201_grid_02" name="div_oTui_RB00201_grid_02" class="tuigrid-resizable">
					<div id="oTui_RB00201_grid_02" data-minus-height="600"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>

	var RB00201 = new function(){
		
		this.DIALOG_ID = "RB002_Dtl";
		// Page Object Initialize
		this.initialize_Dialog_Object = function() {
			if('${reqParam.INPUT_FLAG}' == "U"){
				KpackageOBJ.object.readOnly("RB00201-detail-form", "IMPDEC_NO", true);
				KpackageOBJ.object.readOnly("RB00201-detail-form", "LC_NO", true);
				KpackageOBJ.object.readOnly("RB00201-detail-form", "BL_NO", true);
				KpackageOBJ.object.readOnly("RB00201-detail-form", "AMOUNT_CRNCY_KRW", true);
				KpackageOBJ.object.readOnly("RB00201-detail-form", "QY", true);
				KpackageOBJ.object.readOnly("RB00201-detail-form", "CVODV_KRW", true);
				KpackageOBJ.object.readOnly("RB00201-detail-form", "CSTMS", true);
				KpackageOBJ.object.readOnly("RB00201-detail-form", "TOT_TAXAMT", true);
				
				
				KpackageOBJ.selectbox.create("RB00201-detail-form", "INCME_DELNG_SE",  "/common/retrieveComCdList", {"CATEGORY_CD":"IMPT","OPTION_ALL":"Y"}, "CODE", "NAME");
				KpackageOBJ.object.readOnly("RB00201-detail-form", "INCME_DELNG_SE", true);
				KpackageOBJ.selectbox.create("RB00201-detail-form", "INCME_TYPE",  "/common/retrieveComCdList", {"CATEGORY_CD":"IMPD","OPTION_ALL":"Y"}, "CODE", "NAME");
				KpackageOBJ.object.readOnly("RB00201-detail-form", "INCME_TYPE", true);
				KpackageOBJ.selectbox.create("RB00201-detail-form", "XPORT_NATION_CODE",  "/common/retrieveComCdList", {"CATEGORY_CD":"NA","OPTION_ALL":"Y"}, "CODE", "NAME");
				KpackageOBJ.object.readOnly("RB00201-detail-form", "XPORT_NATION_CODE", true);
				
			}
			
			RB00201.retrieve_Dialog_formData();
			
		};
		
		
		this.retrieve_Dialog_formData = function(){
			var params = { "IMPDEC_NO" : "${reqParam.IMPDEC_NO}", "IMPDEC_MANAGE_NO" : "${reqParam.IMPDEC_MANAGE_NO}"}; 
			KpackageOBJ.ajax.doSubmit("/refundBasis/retrieveImpDetail", params, RB00201.formData_Handler);	
		}
		
		this.formData_Handler = function(result) {
			if (result.success) { // 성공시			
				var data = result.value;
				KpackageOBJ.data.setFormData("RB00201-detail-form", data);
				
				RB00201.initialize_TuiGrid();
				var params = { "IMPDEC_NO" : "${reqParam.IMPDEC_NO}", "IMPDEC_MANAGE_NO" : "${reqParam.IMPDEC_MANAGE_NO}"}; 
				KpackageOBJ.tuiGrid.retrieve("oTui_RB00201_grid_01", "/refundBasis/retrieveImpDetail_LneList", params);

				KpackageOBJ.object.setFormValue("RB00201-detail-form", "QY",KpackageOBJ.formatter.commas(KpackageOBJ.object.getFormValue("RB00201-detail-form", "QY")));
				KpackageOBJ.object.setFormValue("RB00201-detail-form", "CVODV_KRW",KpackageOBJ.formatter.commas(KpackageOBJ.object.getFormValue("RB00201-detail-form", "CVODV_KRW")));
				KpackageOBJ.object.setFormValue("RB00201-detail-form", "CSTMS",KpackageOBJ.formatter.commas(KpackageOBJ.object.getFormValue("RB00201-detail-form", "CSTMS")));
				KpackageOBJ.object.setFormValue("RB00201-detail-form", "TOT_TAXAMT",KpackageOBJ.formatter.commas(KpackageOBJ.object.getFormValue("RB00201-detail-form", "TOT_TAXAMT")));
				
			} else { // 실패시
				KpackageOBJ.object.alert(result.message);
			}
		};
		
		
		this.initialize_TuiGrid = function(){ 
			 
			 var colArrayInfo = [
				 {"header" :'란',					name:'LNE_NO',				width:50,			align:'center',		hidden:false},
				 {"header" :'HS CODE',				name:'HS_CODE',				width:100,			align:'center',		hidden:false	,formatter:KpackageOBJ.tuiGrid.hscode10},
				 {"header" :'수입신고금액',			name:'CVODV_KRW',			width:100,			align:'right',		hidden:false	,formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'수입수량',				name:'QY',					width:100,			align:'right',		hidden:false	,formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'환급 사용량',			name:'DLIVY_QY',			width:100,			align:'right',		hidden:false	,formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'잔량수량',				name:'REMNDR_QY',			width:100,			align:'right',		hidden:false	,formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'총세액',				name:'TOT_TAX',				width:120,			align:'right',		hidden:false	,formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'환급 사용금액',		name:'USE_TAX',				width:120,			align:'right',		hidden:false	,formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'잔량세액',				name:'REMNDR_TAX',			width:120,			align:'right',		hidden:false	,formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'환급일자',				name:'LAST_USE_YYYYMMDD',	width:100,			align:'center',		hidden:false	,formatter:KpackageOBJ.tuiGrid.dateFormatter},
				 {"header" :'단축고시 해당유무',	name:'LMTT_REGLTN',			width:100,			align:'center',		hidden:false}
				 ]
			 
			 KpackageOBJ.tuiGrid.create("oTui_RB00201_grid_01", "/refundBasis/retrieveImpDetail", colArrayInfo, "number"   , null, RB00201.onDblClick_oTui_Grid);
			 KpackageOBJ.tuiGrid.setCaption("oTui_RB00201_grid_01","<spring:message code='수입 란 내역'/>");
			 
			 var colArrayInfo2 = [
				 {"header" :'란',				name:'LNE_NO',		width:50,			align:'center',		hidden:false},
				 {"header" :'행',				name:'POUCH_NO',	width:50,			align:'center',		hidden:false},
				 {"header" :'자재코드',			name:'ITEM_CODE',	width:150,			align:'left',		hidden:false},
				 {"header" :'자재명',			name:'ITEM_NM',		width:200,			align:'left',		hidden:false},
				 {"header" :'수입수량',			name:'QY',			width:100,			align:'right',		hidden:false	,formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'환급 사용량',		name:'DLIVY_QY',	width:100,			align:'right',		hidden:false	,formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'잔량수량',			name:'REMNDR_QY',	width:100,			align:'right',		hidden:false	,formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'신고금액',			name:'CVODV_KRW',		width:100,			align:'right',		hidden:false	,formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'총 세액',			name:'TOT_TAX',		width:100,			align:'right',		hidden:false	,formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'환급 사용금액',	name:'USE_TAX',		width:100,			align:'right',		hidden:false	,formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'잔량세액',			name:'REMNDR_TAX',	width:100,			align:'right',		hidden:false	,formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'단위',				name:'BASS_UNIT',	width:50,			align:'center',		hidden:false}
			 ];
			 KpackageOBJ.tuiGrid.create("oTui_RB00201_grid_02", "/refundBasis/retrieveImpDetail", colArrayInfo2, "number", null);
			 KpackageOBJ.tuiGrid.setCaption("oTui_RB00201_grid_02","<spring:message code='수입신고 행별 상세내역'/>");
		};
		
		
		this.onDblClick_oTui_Grid = function(p_GridId, p_RowKey, p_ColName){
			var rowData = KpackageOBJ.tuiGrid.getSelectedRowlValue(p_GridId, p_RowKey);
			var params = { "IMPDEC_NO" : rowData.IMPDEC_NO, "IMPDEC_MANAGE_NO" : rowData.IMPDEC_MANAGE_NO, "LNE_NO" : rowData.LNE_NO}; 
			KpackageOBJ.tuiGrid.retrieve("oTui_RB00201_grid_02", "/refundBasis/retrieveImpDetail_PouchList", params);
		};
		
	}
	

	
	$(document).ready(function() {
		RB00201.initialize_Dialog_Object();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
		
	});
	
	
	
</script>
</body>
</html>