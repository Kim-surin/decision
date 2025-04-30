<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style type="text/css">
    
    .form-control {
	    height: 30px;
	    padding-left: 11px;
	    margin-bottom: 10px;
	}
    
    </style>
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form:form id="MM001-form" novalidate="novalidate">
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<div class="jarviswidget" id="wid-id-x" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-sortable="false" role="widget">
				<div role="content" class="s4-form-body">
					<div class="widget-body">
						<fieldset>
							<legend>
								회사코드 : <span id="mm001_company_code"></span>
							</legend>
							<div class="form-group">
								<div class="row">
									<div class="col-sm-12 col-md-3">
										<label class="control-label">회사명</label>
										<input type="text" id="COMPANY_NM" name="COMPANY_NM" class="form-control"/>
									</div>

									<div class="col-sm-12 col-md-3">
										<label class="control-label">대표자 명</label>
										<input type="text" id="" name="RPRSNTV_NM" class="form-control"/>
									</div>
									<div class="col-sm-12 col-md-3">
										<label class="control-label">통관고유부호</label>
										<input type="text" id="ECTMRK" name="ECTMRK" class="form-control"/>
									</div>
									
									<div class="col-sm-12 col-md-3">
										<label class="control-label">제출번호식별자</label>
										<input type="text" id="PRESENTN_NO" name="PRESENTN_NO" class="form-control"/>
									</div>
								</div>
							</div>
						</fieldset>
						<fieldset>
							<div class="form-group">
								<div class="row">
									<div class="col-sm-12 col-md-3">
										<label class="control-label">우편번호</label>
										<input type="text" id="ZIP" name="ZIP" class="form-control"/>
									</div>
									<div class="col-sm-12 col-md-3">
										<label class="control-label">국가</label>
										<select id="NATION_CODE" name="NATION_CODE" class="form-control" style="padding:0px;"/>
									</div>
									
									<div class="col-sm-12 col-md-6">
										<label class="control-label">회사주소</label>
										<input type="text" id="ADRES" name="ADRES" class="form-control"/>
									</div>
									
								</div>
							</div>
						</fieldset>
						
						<fieldset>
							<div class="form-group">
								<div class="row">
									<div class="col-sm-12 col-md-3">
										<label class="control-label">사업자등록번호</label>
										<input type="text" id="BIZRNO" name="BIZRNO" class="form-control"/>
									</div>

									<div class="col-sm-12 col-md-3">
										<label class="control-label">담당자 연락처</label>
										<input type="text" id="TELNO_1" name="TELNO_1" class="form-control"/>
									</div>

									<div class="col-sm-12 col-md-3">
										<label class="control-label">담당자 팩스번호</label>
										<input type="text" id="FXNUM" name="FXNUM" class="form-control"/>
									</div>
									
									<div class="col-sm-12 col-md-3">
										<label class="control-label">담당자 Email</label>
										<input type="text" id="EMAIL_ADRES" name="EMAIL_ADRES" class="form-control"/>
									</div>
								</div>
							</div>
						</fieldset>
						
						<fieldset style="display: none;">
							<div class="form-group">
								<div class="row">
									<div class="col-sm-12 col-md-3">
										<label class="control-label">계좌번호</label>
										<input type="text" id="ACNUTNO" name="ACNUTNO" class="form-control"/>
									</div>

									<div class="col-sm-12 col-md-3">
										<label class="control-label">은행코드</label>
										<input type="text" id="BANK_CODE" name="BANK_CODE" class="form-control"/>
									</div>

									<div class="col-sm-12 col-md-3">
										<label class="control-label">은행명</label>
										<input type="text" id="BANK_NM" name="BANK_NM" class="form-control"/>
									</div>
									
									<div class="col-sm-12 col-md-3">
										<label class="control-label">지점명</label>
										<input type="text" id="BHF_NM" name="BHF_NM" class="form-control"/>
									</div>
								</div>
							</div>
						</fieldset>
						
						<fieldset>
							<div class="form-group">
								<div class="row">
									<div class="col-sm-12 col-md-3">
										<label class="control-label">환급구분코드</label>
										<select id="DRWBAK_SE_CODE" name="DRWBAK_SE_CODE" class="form-control" style="padding:0px;"/>
									</div>

									<div class="col-sm-12 col-md-3">
										<label class="control-label">소요량산정방법</label>
										<select id="REQREQY_CALC_MTH" name="REQREQY_CALC_MTH" class="form-control" style="padding:0px;"/>
									</div>
									
								</div>
							</div>
						</fieldset>
						<fieldset>
							<legend>
								세관 정보</span>
							</legend>
							<div class="form-group">
								<div class="row">
									<div class="col-sm-12 col-md-3">
										<label class="control-label">세관코드</label>
										<select id="CSMHSE_CODE" name="CSMHSE_CODE" class="form-control" style="padding:0px;"/>
									</div>
									
									<div class="col-sm-12 col-md-3">
										<label class="control-label">유니패스ID</label>
										<input type="text" id="UNIPASS_ID" name="UNIPASS_ID" class="form-control"/>
									</div>
									
									<div class="col-sm-12 col-md-3">
										<label class="control-label">유니패스 문서함 코드</label>
										<input type="text" id="UNIPASS_DOC_BOX_CODE" name="UNIPASS_DOC_BOX_CODE" class="form-control"/>
									</div>
								</div>
							</div>
						</fieldset>
						
						<div class="form-actions">
							<div class="row">
								<div class="col-md-12">
									<div style="width: 125px; float: right;">
										<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:MM001.dataSaveFunction();">
											<i class="fa fa-save"></i> 수정내용 저장
										</button>
									</div>
								</div>
							</div>
						</div>

					</div>
					<!-- end widget content -->

				</div>
				<!-- end widget div -->

			</div>
			<!-- end widget -->
		</div>
	</form:form>
	</section>
</div>
<script>

	var MM001 = new function(){
		// Page Object Initialize
		this.initialize_viewObject = function() {
			KpackageOBJ.selectbox.create("MM001-form", "NATION_CODE", "/common/retrieveComCdList", {"CATEGORY_CD":"NA","OPTION_ALL":"Y"}, "CODE", "NAME");
			KpackageOBJ.selectbox.create("MM001-form", "CSMHSE_CODE", "/common/retrieveComCdList", {"CATEGORY_CD":"CT","OPTION_ALL":"Y"}, "CODE", "NAME");
			KpackageOBJ.selectbox.create("MM001-form", "DRWBAK_SE_CODE", "/common/retrieveComCdList", {"CATEGORY_CD":"DS","OPTION_ALL":"Y"}, "CODE", "NAME");
			KpackageOBJ.selectbox.create("MM001-form", "RTROACT_PD", "/common/retrieveComCdList", {"CATEGORY_CD":"RP","OPTION_ALL":"Y"}, "CODE", "NAME");
			KpackageOBJ.selectbox.create("MM001-form", "REQREQY_CALC_MTH", "/common/retrieveComCdList", {"CATEGORY_CD":"RCM","OPTION_ALL":"Y"}, "CODE", "NAME");
			KpackageOBJ.selectbox.create("MM001-form", "PRIC_RQEST_TYPE", "/common/retrieveComCdList", {"CATEGORY_CD":"PR","OPTION_ALL":"Y"}, "CODE", "NAME");
			

			var arrayItem = [{value:"Y", name:"<spring:message code='common.title.useYn.Yes'/>"}
					        ,{value:"N", name:"<spring:message code='common.title.useYn.No'/>"}];
			KpackageOBJ.selectbox.create("MM001-form", "ITEM_GROUP_AT", "", null, "value", "name", arrayItem);
			
			
			MM001.retrieve_formData();
		}
		
		this.retrieve_formData = function(){
			var params = { }; 
			KpackageOBJ.ajax.doSubmit("/master/retrieveCompanyInfo", params, MM001.formData_Handler);	
		}
		
		this.formData_Handler = function(result) {
			if (result.success) { // 성공시			
				var data = result.value;
				KpackageOBJ.data.setFormData("MM001-form", data);
				$("#mm001_company_code").append(data.COMPANY_CODE);
			} else { // 실패시
				KpackageOBJ.object.alert(result.message);
			}
		};
		
		this.dataSaveFunction = function() {
			var postData = KpackageOBJ.data.makePostData("MM001-form");
			KpackageOBJ.ajax.doSubmit("/master/updateCompanyInfo", postData, "MM001.dataSaveFunction_CallbackHandler");
		};
		
		this.dataSaveFunction_CallbackHandler = function(result) {
			if (result.success) { // 성공시
				MM001.retrieve_formData();
				alert("<spring:message code='common.msg.saveok'/>");            
// 	            KpackageOBJ.dialog.close("plantDetail_Dialog");
			} else { // 실패시
				alert("<spring:message code='common.msg.savefail'/>");
				}
		};
		
	};
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		MM001.initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
		
	});
	
	
	
	
</script>
</body>
</html>