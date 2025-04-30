<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="content">
	<div class="widget-body">
		<form:form id="MM00401-detail-form" class="s4-form form-horizontal form-dialog" novalidate="novalidate">
			<input type="hidden" name="COMPANY_CODE" id="COMPANY_CODE"/>
			<input type="hidden" name="INPUT_FLAG" id="INPUT_FLAG" value="${reqParam.INPUT_FLAG}"/>
			<input type="hidden" id ="EFECT_BGNDE" name="EFECT_BGNDE"/>
			<input type="hidden" id ="EFECT_ENDDE" name="EFECT_ENDDE"/>
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
									<th>환급제한규정</th>
									<td>
										<select class="form-control searchSelect" id="DRWBAK_LMTT_REGLTN" name="DRWBAK_LMTT_REGLTN" class="form-control searchSelect" style="width:150px"></select>
									</td>
									<th>HS CODE</th>
									<td>
										<input type="text" id ="HS_CODE" name="HS_CODE" style="width:120px" class="inputText"/>
									</td>
								</tr>
								<tr>
									<th>효력시작일</th>
									<td>
										<input type="text" id="CAL_EFECT_BGNDE" name="CAL_EFECT_BGNDE" style="width:120px" class="inputText"/>
									</td>
									<th>효력종료일</th>
									<td>
										<input type="text" id="CAL_EFECT_ENDDE" name="CAL_EFECT_ENDDE" style="width:120px" class="inputText"/>
									</td>
								</tr>
								<tr>
									<th>비고</th>
									<td colspan="3">
										<textarea type="text" id ="RM" name="RM" rows="10" class="custom-scroll" style="width: 99%"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</fieldset>
		</form:form>
	</div>
</div>
<script>

	var MM00401 = new function(){
		
		this.DIALOG_ID = "drwbakLmtt_Dtl";
		// Page Object Initialize
		this.initialize_Dialog_Object = function() {
			KpackageOBJ.selectbox.create("MM00401-detail-form", "DRWBAK_LMTT_REGLTN", "/common/retrieveComCdList", {"CATEGORY_CD":"DL"}, "CODE", "NAME");

			KpackageOBJ.calendar.create("MM00401-detail-form", "CAL_EFECT_BGNDE");
			KpackageOBJ.calendar.create("MM00401-detail-form", "CAL_EFECT_ENDDE");
			
			if('${reqParam.INPUT_FLAG}' == "I"){
				KpackageOBJ.object.readOnly("MM00401-detail-form", "DRWBAK_LMTT_REGLTN", false);
				KpackageOBJ.object.readOnly("MM00401-detail-form", "HS_CODE", false);
				KpackageOBJ.object.readOnly("MM00401-detail-form", "CAL_EFECT_BGNDE", false);
			}else{
				KpackageOBJ.object.readOnly("MM00401-detail-form", "DRWBAK_LMTT_REGLTN", true);
				KpackageOBJ.object.readOnly("MM00401-detail-form", "HS_CODE", true);
				KpackageOBJ.object.readOnly("MM00401-detail-form", "CAL_EFECT_BGNDE", true);
				MM00401.retrieve_Dialog_formData();
			}
			
			
		};
		
		
		this.retrieve_Dialog_formData = function(){
			var params = { "DRWBAK_LMTT_REGLTN" : "${reqParam.DRWBAK_LMTT_REGLTN}"
						,"HS_CODE" : "${reqParam.HS_CODE}"
						,"EFECT_BGNDE" : "${reqParam.EFECT_BGNDE}"}; 
			KpackageOBJ.ajax.doSubmit("/master/retrieveDrwbakLmttDetail", params, MM00401.formData_Handler);	
		}
		
		this.formData_Handler = function(result) {
			if (result.success) { // 성공시			
				var data = result.value;
				KpackageOBJ.data.setFormData("MM00401-detail-form", data);
				
				KpackageOBJ.calendar.setValue("MM00401-detail-form","CAL_EFECT_BGNDE", data["EFECT_BGNDE"]);
				KpackageOBJ.calendar.setValue("MM00401-detail-form","CAL_EFECT_ENDDE", data["EFECT_ENDDE"]);
			} else { // 실패시
				KpackageOBJ.object.alert(result.message);
			}
		};
		
		this.dataSaveFunction = function(){
			var postData = KpackageOBJ.data.makePostData("MM00401-detail-form");
			KpackageOBJ.ajax.doSubmit("/master/updateDrwbakLmttDetail", postData, "MM00401.dataSaveFunction_CallbackHandler");
		};
		
		this.dataSaveFunction_CallbackHandler = function(result) {
			if (result.success) { // 성공시
				MM004.retrieve_gridData();
				alert("저장되었습니다.");
	            KpackageOBJ.dialog.close(MM00401.DIALOG_ID);
			} else { // 실패시
				alert("데이터를 저장할 수 없습니다.");
			}
		};
		
		this.dataDeleteFunction = function(){
			if(!confirm("삭제하시겠습니까?")){
				return;
			}
			var postData = KpackageOBJ.data.makePostData("MM00401-detail-form");
			KpackageOBJ.ajax.doSubmit("/master/deleteDrwbakLmttDetail", postData, "MM00401.dataDeleteFunction_CallbackHandler");
		};
		
		this.dataDeleteFunction_CallbackHandler = function(result) {
			if (result.success) { // 성공시
				MM004.retrieve_gridData();
				alert("삭제되었습니다.");
	            KpackageOBJ.dialog.close(MM00401.DIALOG_ID);
			} else { // 실패시
				alert("데이터를 삭제할 수 없습니다.");
			}
		};
	};
	
	$(document).ready(function() {
		MM00401.initialize_Dialog_Object();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		
		var tools = [{icon:"save", title:"Save" ,text:"저장"	,func:"MM00401.dataSaveFunction"}
					,{icon:"delete", title:"Delete" ,text:"삭제"	,func:"MM00401.dataDeleteFunction"}];
		KpackageOBJ.dialog.setButton(MM00401.DIALOG_ID, tools);
	});
	
	
	
</script>
</body>
</html>