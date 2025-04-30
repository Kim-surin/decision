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
		<form:form id="MM00201-detail-form" class="s4-form form-horizontal form-dialog" novalidate="novalidate">
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
							</colgroup>
							<tbody>
								<tr>
									<th>고객사코드</th>
									<td>
										<input type="text" id ="CUSTOMER_CODE" name="CUSTOMER_CODE" class="form-control" placeholder="ex) ABCD"/>
									</td>
									<th>대표고객사코드</th>
									<td>
										<input type="text" id ="REPRSNT_CUSTOMER_CODE" name="REPRSNT_CUSTOMER_CODE" class="form-control" />
									</td>
								</tr>
								<tr>
									<th>고객사명</th>
									<td>
										<input type="text" id ="ATTRIBUTE01" name="ATTRIBUTE01" class="form-control" />
									</td>
									<th>대표자</th>
									<td>
										<input type="text" id ="RPRSNTV_NM" name="RPRSNTV_NM" class="form-control" />
									</td>
								</tr>
								<tr>
									<th>통관 고유부호</th>
									<td>
										<input type="text" id ="ECTMRK" name="ECTMRK" class="form-control" />
									</td>
									<th>국가</th>
									<td>
										<input type="text" id ="NATION_CODE" name="NATION_CODE" class="form-control" />
									</td>
								</tr>
								<tr>
									<th>사업자등록번호</th>
									<td>
										<input type="text" id ="BIZRNO" name="BIZRNO" class="form-control" />
									</td>
									<th>우편번호</th>
									<td>
										<input type="text" id ="ZIP" name="ZIP" class="form-control" />
									</td>
								</tr>
								<tr>
									<th>주소</th>
									<td colspan="3">
										<input type="text" id ="ADRES" name="ADRES" class="form-control" />
									</td>
								</tr>
								<tr>
									<th>전화번호1</th>
									<td>
										<input type="text" id ="TELNO_1" name="TELNO_1" class="form-control" />
									</td>
									<th>전화번호2</th>
									<td>
										<input type="text" id ="TELNO_2" name="TELNO_2" class="form-control" />
									</td>
								</tr>
								<tr>
									<th>팩스번호</th>
									<td>
										<input type="text" id ="FXNUM" name="FXNUM" class="form-control" />
									</td>
									<th>E-MAIL</th>
									<td>
										<input type="text" id ="EMAIL_ADRES" name="EMAIL_ADRES" class="form-control" />
									</td>
								</tr>
								<tr>
									<th>제외여부</th>
									<td>
										<input type="radio" id ="EXCL_AT" name="EXCL_AT" value="X" />Y
										<input type="radio" id ="EXCL_AT" name="EXCL_AT" value="" />N
									</td>
									<th>삭제여부</th>
									<td>
										<input type="radio" id ="DELETE_DRCTR" name="DELETE_DRCTR" value="X" />Y
										<input type="radio" id ="DELETE_DRCTR" name="DELETE_DRCTR" value="" />N
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

	var MM00201 = new function(){
		
		this.DIALOG_ID = "customer_Dtl";
		// Page Object Initialize
		this.initialize_Dialog_Object = function() {
			if('${reqParam.INPUT_FLAG}' == "U"){
				KpackageOBJ.object.readOnly("MM00201-detail-form", "CUSTOMER_CODE", true);
			}
			
			MM00201.retrieve_Dialog_formData();
		};
		
		
		this.retrieve_Dialog_formData = function(){
			var params = { "CUSTOMER_CODE" : "${reqParam.CUSTOMER_CODE}"}; 
			KpackageOBJ.ajax.doSubmit("/master/retrieveCustomerDetail", params, MM00201.formData_Handler);	
		}
		
		this.formData_Handler = function(result) {
			if (result.success) { // 성공시			
				var data = result.value;
				KpackageOBJ.data.setFormData("MM00201-detail-form", data);
			} else { // 실패시
				KpackageOBJ.object.alert(result.message);
			}
		};
		
		this.dataSaveFunction = function(){
			var postData = KpackageOBJ.data.makePostData("MM00201-detail-form");
			KpackageOBJ.ajax.doSubmit("/master/updateCustomerDetail", postData, "MM00201.dataSaveFunction_CallbackHandler");
		}
		
		this.dataSaveFunction_CallbackHandler = function(result) {
			if (result.success) { // 성공시
				MM002.retrieve_gridData();
				alert("저장되었습니다.");            
	            KpackageOBJ.dialog.close(MM00201.DIALOG_ID);
			} else { // 실패시
				alert("데이터를 저장할 수 없습니다.");
			}
		};
	};
	
	$(document).ready(function() {
		MM00201.initialize_Dialog_Object();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
		
		var tools = [{icon:"save", title:"Save" ,text:"저장"	,func:"MM00201.dataSaveFunction"}];
		KpackageOBJ.dialog.setButton(MM00201.DIALOG_ID, tools);
	});
	
	
	
</script>
</body>
</html>