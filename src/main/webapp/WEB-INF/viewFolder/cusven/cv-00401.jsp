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
		<form:form id="CV00401-detail-form" class="s4-form form-horizontal form-dialog" novalidate="novalidate">
			<input type="hidden" name="COMPANY_CODE" id="COMPANY_CODE" value="${reqParam.COMPANY_CODE}"/>
			<input type="hidden" name="DIVISION_CODE" id="DIVISION_CODE" value="${reqParam.DIVISION_CODE}"/>
			<input type="hidden" name="P_REGIST_RCEPT_NO" id="P_REGIST_RCEPT_NO" value="${reqParam.REGIST_RCEPT_NO}"/>
			<input type="hidden" name="SUBMIT_NO" id="SUBMIT_NO" value="${reqParam.SUBMIT_NO}"/>
			<input type="hidden" name="ISSUE_TYPE" id="ISSUE_TYPE" value="${reqParam.ISSUE_TYPE}"/>
			<input type="hidden" name="INPUT_FLAG" id="INPUT_FLAG" value="${reqParam.INPUT_FLAG}"/>
			<fieldset>
				<div class="dialog-form-group">
					<div class="col-md-12 table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 130px;" />
								<col style="width: 130px;" />
								<col style="width: " />
								<col style="width: 130px;" />
								<col style="width: " />
								<col style="width: 130px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th rowspan="2" style="vertical-align:middle; text-align:center;">양수자통보</th>
									<th>접수번호</th>
									<td>
										<input type="text" id ="REGIST_RCEPT_NO" name="REGIST_RCEPT_NO" class="form-control"/>
									</td>
									<th>양도일자</th>
									<td>
										<input type="text" id ="CHIT_FRMTRM_DATE" name="CHIT_FRMTRM_DATE" class="form-control" />
									</td>
									<th>제출구분</th>
									<td>
										<input type="text" id ="RECV_DOC_TYPE_NAME" name="RECV_DOC_TYPE_NAME" class="form-control" />
									</td>
								</tr>
								<tr>
									<th>양도수량</th>
									<td>
										<input type="text" id ="ACCMLT_ORDER_QY" name="ACCMLT_ORDER_QY" class="form-control" />
									</td>
									<th>환급종류</th>
									<td>
										<input type="text" id ="ISSUE_TYPE_NAME" name="ISSUE_TYPE_NAME" class="form-control" />
									</td>
									<th>공급가격</th>
									<td>
										<input type="text" id ="STTEMNT_PC_KRW" name="STTEMNT_PC_KRW" class="form-control" />
									</td>
								</tr>
								<tr>
									<th style="vertical-align:middle; text-align:center;">양도세액</th>
									<td colspan="6">
										<input type="text" id ="TOT_TAX" name="TOT_TAX" class="form-control" />
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
				<div id="div_oTui_CV00401_grid_01" name="div_oTui_CV00401_grid_01" class="tuigrid-resizable">
					<div id="oTui_CV00401_grid_01" data-minus-height="630"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>

	var CV00401 = new function(){
		
		this.DIALOG_ID = "CV004_Dtl";
		// Page Object Initialize
		this.initialize_Dialog_Object = function() {
			if('${reqParam.INPUT_FLAG}' == "U"){
				KpackageOBJ.object.readOnly("CV00401-detail-form", "REGIST_RCEPT_NO", true);
				KpackageOBJ.object.readOnly("CV00401-detail-form", "CHIT_FRMTRM_DATE", true);
				KpackageOBJ.object.readOnly("CV00401-detail-form", "CSTMS", true);
				KpackageOBJ.object.readOnly("CV00401-detail-form", "ISSUE_TYPE_NAME", true);
				KpackageOBJ.object.readOnly("CV00401-detail-form", "INTTAX", true);
				KpackageOBJ.object.readOnly("CV00401-detail-form", "LQTX_AMOUNT", true);
				KpackageOBJ.object.readOnly("CV00401-detail-form", "ACCMLT_ORDER_QY", true);
				KpackageOBJ.object.readOnly("CV00401-detail-form", "TRANTAX", true);
				KpackageOBJ.object.readOnly("CV00401-detail-form", "STTEMNT_PC_KRW", true);
				KpackageOBJ.object.readOnly("CV00401-detail-form", "AGSPT", true);
				KpackageOBJ.object.readOnly("CV00401-detail-form", "ECX_AMOUNT", true);
				KpackageOBJ.object.readOnly("CV00401-detail-form", "RECV_DOC_TYPE_NAME", true);
				KpackageOBJ.object.readOnly("CV00401-detail-form", "TOT_TAX", true);
			}
			
			CV00401.retrieve_Dialog_formData();
			
		};
		
		
		this.retrieve_Dialog_formData = function(){
			
			var param = {	"COMPANY_CODE":  KpackageOBJ.object.getFormValue("CV00401-detail-form", "COMPANY_CODE")
							,"DIVISION_CODE":KpackageOBJ.object.getFormValue("CV00401-detail-form", "DIVISION_CODE")
							,"REGIST_RCEPT_NO":KpackageOBJ.object.getFormValue("CV00401-detail-form", "P_REGIST_RCEPT_NO")
							,"SUBMIT_NO":KpackageOBJ.object.getFormValue("CV00401-detail-form", "SUBMIT_NO")
							,"ISSUE_TYPE":KpackageOBJ.object.getFormValue("CV00401-detail-form", "ISSUE_TYPE")
						};
			KpackageOBJ.ajax.doSubmit("/cusven/retrieveCV004GridDetail", param, CV00401.formData_Handler);	
		}
		
		this.formData_Handler = function(result) {
			if (result.success) { // 성공시			
				var data = result.value;
				KpackageOBJ.data.setFormData("CV00401-detail-form", data);
				

				KpackageOBJ.object.setFormValue("CV00401-detail-form", "CHIT_FRMTRM_DATE"		, KpackageOBJ.formatter.date(KpackageOBJ.object.getFormValue("CV00401-detail-form", "CHIT_FRMTRM_DATE")));
				KpackageOBJ.object.setFormValue("CV00401-detail-form", "CSTMS"				, KpackageOBJ.formatter.commas(KpackageOBJ.object.getFormValue("CV00401-detail-form", "CSTMS")));
// 				KpackageOBJ.object.setFormValue("CV00401-detail-form", "ISSUE_TYPE_NAME"			, KpackageOBJ.formatter.commas(KpackageOBJ.object.getFormValue("CV00401-detail-form", "ISSUE_TYPE_NAME")));
				KpackageOBJ.object.setFormValue("CV00401-detail-form", "INTTAX"				, KpackageOBJ.formatter.commas(KpackageOBJ.object.getFormValue("CV00401-detail-form", "INTTAX")));
				KpackageOBJ.object.setFormValue("CV00401-detail-form", "LQTX_AMOUNT"		, KpackageOBJ.formatter.commas(KpackageOBJ.object.getFormValue("CV00401-detail-form", "LQTX_AMOUNT")));
				KpackageOBJ.object.setFormValue("CV00401-detail-form", "ACCMLT_ORDER_QY"					, KpackageOBJ.formatter.commas(KpackageOBJ.object.getFormValue("CV00401-detail-form", "ACCMLT_ORDER_QY")));
				KpackageOBJ.object.setFormValue("CV00401-detail-form", "TRANTAX"			, KpackageOBJ.formatter.commas(KpackageOBJ.object.getFormValue("CV00401-detail-form", "TRANTAX")));
				KpackageOBJ.object.setFormValue("CV00401-detail-form", "STTEMNT_PC_KRW"			, KpackageOBJ.formatter.commas(KpackageOBJ.object.getFormValue("CV00401-detail-form", "STTEMNT_PC_KRW")));
				KpackageOBJ.object.setFormValue("CV00401-detail-form", "AGSPT"				, KpackageOBJ.formatter.commas(KpackageOBJ.object.getFormValue("CV00401-detail-form", "AGSPT")));
				KpackageOBJ.object.setFormValue("CV00401-detail-form", "ECX_AMOUNT"			, KpackageOBJ.formatter.commas(KpackageOBJ.object.getFormValue("CV00401-detail-form", "ECX_AMOUNT")));
				KpackageOBJ.object.setFormValue("CV00401-detail-form", "TOT_TAX"			, KpackageOBJ.formatter.commas(KpackageOBJ.object.getFormValue("CV00401-detail-form", "TOT_TAX")));
				
				KpackageOBJ.object.setFormValue("RB00201-detail-form", "ACCMLT_ORDER_QY",KpackageOBJ.formatter.commas(KpackageOBJ.object.getFormValue("RB00201-detail-form", "ACCMLT_ORDER_QY")));
				
				CV00401.initialize_TuiGrid();
				
			} else { // 실패시
				KpackageOBJ.object.alert(result.message);
			}
		};
		
		
		this.initialize_TuiGrid = function(){ 
			 
			 var colArrayInfo = [
				 
				 {"header" :'순번',		name:'SEQ',					width:30,			align:'center',		hidden:false},
				 {"header" :'수출신고번호',	name:'IMPDEC_NO',			width:110,			align:'center',		hidden:false},
				 {"header" :'란',		name:'LNE_NO',				width:30,			align:'center',		hidden:false},
				 {"header" :'행',		name:'POUCH_NO',			width:30,			align:'center',		hidden:false},
				 {"header" :'자재코드',	name:'ITEM_CODE',			width:150,			align:'left',		hidden:false},
				 {"header" :'자재명',		name:'ITEM_NM',				width:260,			align:'left',		hidden:false},
				 {"header" :'수량',		name:'QTY',					width:80,			align:'right',		hidden:false	,formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'단위',		name:'BASS_UNIT',			width:50,			align:'center',		hidden:false},
				 {"header" :'공급가격',	name:'STTEMNT_PC_KRW',		width:90,			align:'right',		hidden:false	,formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'총세액',		name:'CSTMS',				width:90,			align:'right',		hidden:false	,formatter:KpackageOBJ.tuiGrid.commas},
				 {"header" :'관련문서번호',	name:'BASIS_DOC_NO',		width:120,			align:'center',		hidden:false}
				 ]
			 
			 KpackageOBJ.tuiGrid.create("oTui_CV00401_grid_01", "/cusven/retrieveCV004GridDetailList", colArrayInfo, 'number', null);
			 KpackageOBJ.tuiGrid.setCaption("oTui_CV00401_grid_01","<spring:message code='양도 상세내역'/>");
			 
			 CV00401.retrieve_gridData();
		};
		
		this.retrieve_gridData = function() {
			
			var param = {	"COMPANY_CODE":  KpackageOBJ.object.getFormValue("CV00401-detail-form", "COMPANY_CODE")
					,"DIVISION_CODE":KpackageOBJ.object.getFormValue("CV00401-detail-form", "DIVISION_CODE")
					,"REGIST_RCEPT_NO":KpackageOBJ.object.getFormValue("CV00401-detail-form", "P_REGIST_RCEPT_NO")
					,"SUBMIT_NO":KpackageOBJ.object.getFormValue("CV00401-detail-form", "SUBMIT_NO")
					,"ISSUE_TYPE":KpackageOBJ.object.getFormValue("CV00401-detail-form", "ISSUE_TYPE")
				};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_CV00401_grid_01", "", param);
		};
	}
	
	$(document).ready(function() {
		CV00401.initialize_Dialog_Object();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
		
	});
	
	
	
</script>
</body>
</html>