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
		<form:form id="RB00901-detail-form" class="s4-form form-horizontal form-dialog" novalidate="novalidate">
			<input type="hidden" name="COMPANY_CODE" id="COMPANY_CODE"/>
			<input type="hidden" name="INPUT_FLAG" id="INPUT_FLAG" value="${reqParam.INPUT_FLAG}"/>
			<input type="hidden" name="EXPDECL_MANAGE_NO" id="EXPDECL_MANAGE_NO" value="${reqParam.EXPDECL_MANAGE_NO}"/>
			<input type="hidden" name="INV_NO" id="INV_NO" value="${reqParam.INV_NO}"/>
			<fieldset>
				<div class="dialog-form-group">
					<div class="col-md-12 table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 110px;" />
								<col style="width: " />
								<col style="width: 110px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th>수출신고번호</th>
									<td colspan="3">
										<input type="text" id ="XPORT_STTEMNT_NO" name="XPORT_STTEMNT_NO" class="form-control"/>
									</td>
								</tr>
								<tr>
									<th>제조자</th>
									<td>
										<input type="text" id ="MANUFAC_NAME" name="MANUFAC_NAME" class="form-control" />
									</td>
									<th>구매자</th>
									<td>
										<input type="text" id ="EXPORTER_NAME" name="EXPORTER_NAME" class="form-control" />
									</td>
								</tr>
								<tr>
									<th>선적일자</th>
									<td>
										<input type="text" id ="ONBOARD_DATE" name="ONBOARD_DATE" class="form-control" />
									</td>
									<th>목적국</th>
									<td>
										<input type="text" id ="NATION_CODE" name="NATION_CODE" class="form-control" />
									</td>
								</tr>
								<tr>
									<th>인보이스 번호</th>
									<td>
										<input type="text" id ="INV_NO" name="INV_NO" class="form-control" />
									</td>
									<th>수출수량</th>
									<td>
										<input type="text" id ="ITEM_QTY" name="ITEM_QTY" class="form-control" />
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</fieldset>
		</form:form>
		
		<div class="row">
			<div class="col-xs-4 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_RB00901_grid_01" name="div_oTui_RB00901_grid_01" class="tuigrid-resizable">
					<div id="oTui_RB00901_grid_01" data-minus-height="570"></div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-8 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_RB00901_grid_02" name="div_oTui_RB00901_grid_02" class="tuigrid-resizable">
					<div id="oTui_RB00901_grid_02" data-minus-height="570"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>

	var RB00901 = new function(){
		
		this.DIALOG_ID = "RB009_Dtl";
		// Page Object Initialize
		this.initialize_Dialog_Object = function() {
			if('${reqParam.INPUT_FLAG}' == "U"){
				KpackageOBJ.object.readOnly("RB00901-detail-form", "XPORT_STTEMNT_NO", true);
				KpackageOBJ.object.readOnly("RB00901-detail-form", "MANUFAC_NAME", true);
				KpackageOBJ.object.readOnly("RB00901-detail-form", "EXPORTER_NAME", true);
				KpackageOBJ.object.readOnly("RB00901-detail-form", "ONBOARD_DATE", true);
				KpackageOBJ.object.readOnly("RB00901-detail-form", "NATION_CODE", true);
				KpackageOBJ.object.readOnly("RB00901-detail-form", "INV_NO", true);
				KpackageOBJ.object.readOnly("RB00901-detail-form", "ITEM_QTY", true);
			}
			
			RB00901.retrieve_Dialog_formData();
			RB00901.initialize_TuiGrid();
		};
		
		
		this.retrieve_Dialog_formData = function(){
			var params = { "EXPDECL_MANAGE_NO" : "${reqParam.EXPDECL_MANAGE_NO}"
					       ,"INV_NO" : "${reqParam.INV_NO}"
				
					}; 
			KpackageOBJ.ajax.doSubmit("/refundBasis/retrieveExpDetail", params, RB00901.formData_Handler);	
		}
		
		this.formData_Handler = function(result) {
			if (result.success) { // 성공시			
				var data = result.value;
				KpackageOBJ.data.setFormData("RB00901-detail-form", data);
				
				
				RB00901.formObjectSetFormatter();
			} else { // 실패시
				KpackageOBJ.object.alert(result.message);
			}
		};
		
		<%// Form Object에 대해서 Formatter을 적용합니다. %>
		this.formObjectSetFormatter = function(){
			KpackageOBJ.object.setFormValue("RB00901-detail-form", "ONBOARD_DATE", KpackageOBJ.formatter.date(KpackageOBJ.object.getFormValue("RB00901-detail-form", "ONBOARD_DATE")));
            KpackageOBJ.object.setFormValue("RB00901-detail-form", "ITEM_QTY", KpackageOBJ.formatter.commas(KpackageOBJ.object.getFormValue("RB00901-detail-form", "ITEM_QTY")));
		}
		
		
		this.initialize_TuiGrid = function(){ 
			
			 var colArrayInfo = [
					{name:"COMPANY_CODE"       ,title:"COMPANY_CODE"        ,width: 50,			align:'center',		hidden:true},
					{name:"DIVISION_CODE"      ,title:"DIVISION_CODE"       ,width: 50,			align:'center',		hidden:true},
					{name:"EXPDECL_MANAGE_NO"  ,title:"내부관리번호"        ,width:100,			align:'center',		hidden:true},
					{name:"LNE_NO"             ,title:"란"       			,width:50,			align:'center',		hidden:false},
					{name:"POUCH_NO"           ,title:"행"       			,width:50,			align:'center',		hidden:false},
					{name:"HS_CODE"            ,title:"HS CODE"             ,width:100,         align:'center',     hidden:false    ,formatter:KpackageOBJ.tuiGrid.hscode10},
					{name:"XPORT_SE"           ,title:"거래구분"       		,width:80,			align:'center',		hidden:false},
					{name:"INV_NO"             ,title:"Inv No."             ,width:100,         align:'center',     hidden:false},
					
					{name:"ITEM_CODE"          ,title:"제품코드"       		,width:180,			align:'left',		hidden:false},
					{name:"ITEM_NM"            ,title:"제품명"       		,width:270,			align:'left',		hidden:false},
					{name:"STTEMNT_PC_KRW"     ,title:"수출금액"       		,width:100,			align: "right"  ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas },
					{name:"ITEM_QTY"           ,title:"수출수량"       		,width:100,			align: "right"  ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas }
				 ];
			 KpackageOBJ.tuiGrid.create("oTui_RB00901_grid_01", "/refundBasis/retrieveExpDetail_Lne", colArrayInfo, 'number', null);
			 KpackageOBJ.tuiGrid.setCaption("oTui_RB00901_grid_01","<spring:message code='수출 내역'/>");
			 
			 
			 var param = {"EXPDECL_MANAGE_NO" : "${reqParam.EXPDECL_MANAGE_NO}"}; 
		
			KpackageOBJ.tuiGrid.retrieve("oTui_RB00901_grid_01", "/refundBasis/retrieveExpDetail_Lne", param);
		};
		
	}
	
	$(document).ready(function() {
		RB00901.initialize_Dialog_Object();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
		
	});
	
	
	
</script>
</body>
</html>