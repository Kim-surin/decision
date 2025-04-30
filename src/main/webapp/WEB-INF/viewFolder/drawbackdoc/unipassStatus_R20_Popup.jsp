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
	<div class ="row" style="margin-top:10px;">
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<ul id="grid_Tab" class="nav nav-tabs bordered">
				<li class="active" id="notification"  style="display : none">
					<a href="#grid_01" data-toggle="tab" aria-expanded="true"><i class="fa fa-fw fa-lg fa-gear"></i>접수통보</a>
				</li>
				<li class=""  id="error" style="display : none">
					<a href="#grid_02" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>오류통보</a>
				</li>
				<li class=""  id="complement" style="display : none">
					<a href="#grid_03" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>보완통보</a>
				</li>
				<li class=""  id="request" style="display : none">
					<a href="#grid_04" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>자료제출요구통보</a>
				</li>
				<li class=""  id="complete" style="display : none">
					<a href="#grid_05" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>완료통보</a>
				</li>
				<li class=""  id="payment" style="display : none">
					<a href="#grid_06" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>지급통보</a>
				</li>
			</ul>
		</div>
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<div class="tab-content">
				<div class="tab-pane fade active in" id="grid_01">
					<!-- 접수통보 -->
					<form:form id="UNIPASS_STATUS_R54-form" class="s4-form form-horizontal form-dialog" novalidate="novalidate">
						<input type="hidden" name="COMPANY_CODE" id="COMPANY_CODE" value="${reqParam.COMPANY_CODE}" />
						<input type="hidden" name="DIVISION_CODE" id="DIVISION_CODE" value="${reqParam.DIVISION_CODE}" />
						<input type="hidden" name="SUBMIT_NO" id="SUBMIT_NO" value="${reqParam.SUBMIT_NO}" />
						<fieldset>
							<div class="dialog-form-group">
								<div class="col-md-12 table-responsive">
									<table class="table table-bordered">
										<colgroup>
											<col style="width: 120px;" />
											<col style="width: 120px;" />
											<col style="width: 200px;" />
											<col style="width: 120px;" />
											<col style="width:;" />
											<col style="width: 120px;" />
											<col style="width:;" />
										</colgroup>
										<tbody>
											<tr>
												<th rowspan="2" style="vertical-align: middle; text-align: center;">접수 정보</th>
												<th>내부관리번호</th>
												<td><input type="text" id="PRESENTN_NO" name="PRESENTN_NO" class="form-control-plaintext" value="${reqParam.PRESENTN_NO}" readonly /></td>
												<th>접수통보 수신일시</th>
												<td><input type="text" id="COMPLETE_DATE" name="COMPLETE_DATE" class="form-control-plaintext" readonly /></td>
												<th>통보세관</th>
												<td><input type="text" id="CATEGORY_NM" name="CATEGORY_NM" class="form-control-plaintext" readonly /></td>
											</tr>
											<tr>
												<th>제출번호</th>
												<td><input type="text" id="SUBMIT_NO" name="SUBMIT_NO" class="form-control-plaintext" value="${reqParam.SUBMIT_NO}" readonly /></td>
												<th>접수번호</th>
												<td><input type="text" id="REGIST_RCEPT_NO" name="REGIST_RCEPT_NO" class="form-control-plaintext"  value="${reqParam.REGIST_RCEPT_NO}" readonly /></td>
												<th>접수일시</th>
												<td><input type="text" id="REGIST_RCEP_DATE" name="REGIST_RCEP_DATE" class="form-control-plaintext" readonly /></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</fieldset>
					</form:form>
					<form:form id="UNIPASS_STATUS_R54-form" class="s4-form form-horizontal form-dialog" novalidate="novalidate">
						<fieldset>
							<div class="dialog-form-group">
								<div class="col-md-12 table-responsive">
									<table class="table table-bordered">
										<colgroup>
											<col style="width: 120px;" />
											<col style="width: 120px;" />
											<col style="width: 200px;" />
											<col style="width: 120px;" />
											<col style="width:;" />
											<col style="width: 120px;" />
											<col style="width:;" />
										</colgroup>
										<tbody>
											<tr>
												<th rowspan="2" style="vertical-align: middle; text-align: center;">접수 상세내역</th>
												<th>PL구분</th>
												<td><input type="text" id="PL_TYPE" name="PL_TYPE" class="form-control-plaintext" readonly /></td>
												<th>문서구분</th>
												<td><input type="text" id="STTEMNT_DOC_STLE" name="STTEMNT_DOC_STLE" class="form-control-plaintext" readonly /></td>
												<th>세관 담당자</th>
												<td><input type="text" id="CSMHSE_PRSN" name="CSMHSE_PRSN" class="form-control-plaintext" readonly /></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</fieldset>
					</form:form>
				</div> <!-- grid_01 end -->
				
				
				<div class="tab-pane fade" id="grid_02">
					<!-- 오류통보 -->
					<form:form id="UNIPASS_STATUS_R20-master-form" class="s4-form form-horizontal form-dialog" novalidate="novalidate">
						<input type="hidden" name="COMPANY_CODE" id="COMPANY_CODE" value="${reqParam.COMPANY_CODE}" />
						<input type="hidden" name="DIVISION_CODE" id="DIVISION_CODE" value="${reqParam.DIVISION_CODE}" />
						<input type="hidden" name="SUBMIT_NO" id="SUBMIT_NO" value="${reqParam.SUBMIT_NO}" />
						<fieldset>
							<div class="dialog-form-group">
								<div class="col-md-12 table-responsive">
									<table class="table table-bordered">
										<colgroup>
											<col style="width: 120px;" />
											<col style="width: 120px;" />
											<col style="width: 200px;" />
											<col style="width: 120px;" />
											<col style="width:;" />
											<col style="width: 120px;" />
											<col style="width:;" />
										</colgroup>
										<tbody>
											<tr>
												<th rowspan="2" style="vertical-align: middle; text-align: center;">수신 정보</th>
												<th>내부관리번호</th>
												<td><input type="text" id="PRESENTN_NO" name="PRESENTN_NO" class="form-control-plaintext" value="${reqParam.PRESENTN_NO}" readonly /></td>
												<th>오류통보 수신일시</th>
												<td><input type="text" id="RECV_DATE" name="RECV_DATE" class="form-control-plaintext" readonly /></td>
												<th>통보세관</th>
												<td><input type="text" id="CATEGORY_NM" name="CATEGORY_NM" class="form-control-plaintext" readonly /></td>
											</tr>
											<tr>
												<th>제출번호</th>
												<td><input type="text" id="SUBMIT_NO" name="SUBMIT_NO" class="form-control-plaintext" value="${reqParam.SUBMIT_NO}" readonly /></td>
												<th>접수번호</th>
												<td><input type="text" id="REGIST_RCEPT_NO" name="REGIST_RCEPT_NO" class="form-control-plaintext"  value="${reqParam.REGIST_RCEPT_NO}" readonly /></td>
												<th>신청문서 수신일시</th>
												<td><input type="text" id="SUBMIT_DATE" name="SUBMIT_DATE" class="form-control-plaintext" readonly /></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</fieldset>
					</form:form>
					<div class="row">
						<div class="col-xs-4 col-sm-12 col-md-12 col-lg-12">
							<div id="div_oTui_UNIPASS_STATUS_R20_grid_01" name="div_oTui_UNIPASS_STATUS_R20_grid_01" class="tuigrid-resizable">
								<div id="oTui_UNIPASS_STATUS_R20_grid_01" data-minus-height="630"></div>
							</div>
						</div>
					</div>			
				</div> <!-- grid_02 end -->
				
				
				<div class="tab-pane fade" id="grid_03">
					<!-- 보완통보 -->
					<form:form id="UNIPASS_STATUS_R58-form" class="s4-form form-horizontal form-dialog" novalidate="novalidate">
						<fieldset>
							<div class="dialog-form-group">
								<div class="col-md-12 table-responsive">
									<table class="table table-bordered">
										<colgroup>
											<col style="width: 120px;" />
											<col style="width: 120px;" />
											<col style="width: 200px;" />
											<col style="width: 120px;" />
											<col style="width:;" />
											<col style="width: 120px;" />
											<col style="width:;" />
										</colgroup>
										<tbody>
											<tr>
												<th rowspan="2" style="vertical-align: middle; text-align: center;">접수 정보</th>
												<th>내부관리번호</th>
												<td><input type="text" id="PRESENTN_NO" name="PRESENTN_NO" class="form-control-plaintext" value="${reqParam.PRESENTN_NO}" readonly /></td>
												<th>보완통보 수신일시</th>
												<td><input type="text" id="COMPLETE_DATE" name="COMPLETE_DATE" class="form-control-plaintext" readonly /></td>
												<th>통보세관</th>
												<td><input type="text" id="CSMHSE_NAME" name="CSMHSE_NAME" class="form-control-plaintext" readonly /></td>
											</tr>
											<tr>
												<th>제출번호</th>
												<td><input type="text" id="SUBMIT_NO" name="SUBMIT_NO" class="form-control-plaintext" value="${reqParam.SUBMIT_NO}" readonly /></td>
												<th>제출기한</th>
												<td><input type="text" id="SUBMIT_DUE_DATE" name="SUBMIT_DUE_DATE" class="form-control-plaintext" readonly /></td>
												<th>과 코드</th>
												<td><input type="text" id="CSMHSE_KWA_CODE" name="CSMHSE_KWA_CODE" class="form-control-plaintext" readonly /></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</fieldset>
					</form:form>
					<form:form id="UNIPASS_STATUS_R58-form" class="s4-form form-horizontal form-dialog" novalidate="novalidate">
						<fieldset>
							<div class="dialog-form-group">
								<div class="col-md-12 table-responsive">
									<table class="table table-bordered">
										<colgroup>
											<col style="width: 120px;" />
											<col style="width: 120px;" />
											<col style="width: 200px;" />
											<col style="width: 120px;" />
											<col style="width:;" />
											<col style="width: 120px;" />
											<col style="width:;" />
										</colgroup>
										<tbody>
											<tr>
												<th rowspan="4" style="vertical-align: middle; text-align: center;">접수 상세내역</th>
												<th>문서구분</th>
												<td><input type="text" id="STTEMNT_DOC_STLE" name="STTEMNT_DOC_STLE" class="form-control-plaintext" readonly /></td>
												<th>수신처상호</th>
												<td><input type="text" id="RECV_CMPNY_NAME" name="RECV_CMPNY_NAME" class="form-control-plaintext" readonly /></td>
												<th>수신처성명</th>
												<td><input type="text" id="RECV_NAME" name="RECV_NAME" class="form-control-plaintext" readonly /></td>
											</tr>
											<tr>
												<th>담당과장명</th>
												<td><input type="text" id="CSMHSE_KWAJANG_NAME" name="CSMHSE_KWAJANG_NAME" class="form-control-plaintext" readonly /></td>
												<th>담당자명</th>
												<td><input type="text" id="CSMHSE_PRSN" name="CSMHSE_PRSN" class="form-control-plaintext" readonly /></td>
												<th>담당자전화번호</th>
												<td><input type="text" id="CSMHSE_PRSN_TEL" name="CSMHSE_PRSN_TEL" class="form-control-plaintext" readonly /></td>
											</tr>
											<tr>
												<th>보완요구내역</th>
												<td colspan="6"><input type="text" id="SPLMT_TEXT" name="SPLMT_TEXT" class="form-control-plaintext" readonly /></td>
											</tr>
											<tr>
												<th>비고</th>
												<td colspan="6"><input type="text" id="REMARK" name="REMARK" class="form-control-plaintext" readonly /></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</fieldset>
					</form:form>
				</div> <!-- grid_03 end -->
				
				
				<div class="tab-pane fade" id="grid_04">
					<!-- 자료제출요구통보 -->
					<form:form id="UNIPASS_STATUS_R57-form" class="s4-form form-horizontal form-dialog" novalidate="novalidate">
						<fieldset>
							<div class="dialog-form-group">
								<div class="col-md-12 table-responsive">
									<table class="table table-bordered">
										<colgroup>
											<col style="width: 120px;" />
											<col style="width: 120px;" />
											<col style="width: 200px;" />
											<col style="width: 120px;" />
											<col style="width:;" />
											<col style="width: 120px;" />
											<col style="width:;" />
										</colgroup>
										<tbody>
											<tr>
												<th rowspan="2" style="vertical-align: middle; text-align: center;">접수 정보</th>
												<th>내부관리번호</th>
												<td><input type="text" id="PRESENTN_NO" name="PRESENTN_NO" class="form-control-plaintext" value="${reqParam.PRESENTN_NO}" readonly /></td>
												<th>요구통보 수신일자</th>
												<td><input type="text" id="COMPLETE_DATE" name="COMPLETE_DATE" class="form-control-plaintext" readonly /></td>
												<th>통보세관</th>
												<td><input type="text" id="CSMHSE_NAME" name="CSMHSE_NAME" class="form-control-plaintext" readonly /></td>
											</tr>
											<tr>
												<th>제출번호</th>
												<td><input type="text" id="SUBMIT_NO" name="SUBMIT_NO" class="form-control-plaintext" value="${reqParam.SUBMIT_NO}" readonly /></td>
												<th>제출기한</th>
												<td colspan="4"><input type="text" id="SUBMIT_DUE_DATE" name="SUBMIT_DUE_DATE" class="form-control-plaintext" readonly /></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</fieldset>
					</form:form>
					<form:form id="UNIPASS_STATUS_R57-form" class="s4-form form-horizontal form-dialog" novalidate="novalidate">
						<fieldset>
							<div class="dialog-form-group">
								<div class="col-md-12 table-responsive">
									<table class="table table-bordered">
										<colgroup>
											<col style="width: 120px;" />
											<col style="width: 120px;" />
											<col style="width: 200px;" />
											<col style="width: 120px;" />
											<col style="width:;" />
											<col style="width: 120px;" />
											<col style="width:;" />
										</colgroup>
										<tbody>
											<tr>
												<th rowspan="3" style="vertical-align: middle; text-align: center;">접수 상세내역</th>
												<th>문서구분</th>
												<td><input type="text" id="STTEMNT_DOC_STLE" name="STTEMNT_DOC_STLE" class="form-control-plaintext" readonly /></td>
												<th>수신처상호</th>
												<td><input type="text" id="RECV_CMPNY_NAME" name="RECV_CMPNY_NAME " class="form-control-plaintext" readonly /></td>
												<th>수신처성명</th>
												<td><input type="text" id="RECV_NAME" name="RECV_NAME" class="form-control-plaintext" readonly /></td>
											</tr>
											<tr>
												<th>담당과장명</th>
												<td><input type="text" id="CSMHSE_KWAJANG_NAME" name="CSMHSE_KWAJANG_NAME" class="form-control-plaintext" readonly /></td>
												<th>담당자명</th>
												<td><input type="text" id="CSMHSE_PRSN" name="CSMHSE_PRSN" class="form-control-plaintext" readonly /></td>
												<th>담당자 전화번호</th>
												<td><input type="text" id="CSMHSE_PRSN_TEL" name="CSMHSE_PRSN_TEL" class="form-control-plaintext" readonly /></td>
											</tr>
											<tr>
												<th>과명</th>
												<td><input type="text" id="CSMHSE_KWA_NAME" name="CSMHSE_KWA_NAME" class="form-control-plaintext" readonly /></td>
												<th>자료제출요구사유</th>
												<td colspan="4"><input type="text" id="REQ_RESN" name="REQ_RESN" class="form-control-plaintext" readonly /></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</fieldset>
					</form:form>
				</div> <!-- grid_04 end -->
				
				<div class="tab-pane fade" id="grid_05">
					<!-- 완료통보 -->
					<form:form id="UNIPASS_STATUS_5DF-form" class="s4-form form-horizontal form-dialog" novalidate="novalidate">
						<fieldset>
							<div class="dialog-form-group">
								<div class="col-md-12 table-responsive">
									<table class="table table-bordered">
										<colgroup>
											<col style="width: 120px;" />
											<col style="width: 120px;" />
											<col style="width: 200px;" />
											<col style="width: 120px;" />
											<col style="width:;" />
											<col style="width: 120px;" />
											<col style="width:;" />
										</colgroup>
										<tbody>
											<tr>
												<th rowspan="2" style="vertical-align: middle; text-align: center;">접수 정보</th>
												<th>내부관리번호</th>
												<td><input type="text" id="PRESENTN_NO" name="PRESENTN_NO" class="form-control-plaintext" value="${reqParam.PRESENTN_NO}" readonly /></td>
												<th>완료통보 수신일자</th>
												<td><input type="text" id="COMPLETE_DATE" name="COMPLETE_DATE" class="form-control-plaintext" readonly /></td>
												<th>통보세관</th>
												<td><input type="text" id="CSMHSE_NAME" name="CSMHSE_NAME" class="form-control-plaintext" readonly /></td>
											</tr>
											<tr>
												<th>제출번호</th>
												<td><input type="text" id="SUBMIT_NO" name="SUBMIT_NO" class="form-control-plaintext" value="${reqParam.SUBMIT_NO}" readonly /></td>
												<th>심사완료일자</th>
												<td><input type="text" id="INSPECTIONENDDATE" name="INSPECTIONENDDATE" class="form-control-plaintext" readonly /></td>
												<th>처리담당자</th>
												<td><input type="text" id="CSMHSE_PRSN" name="CSMHSE_PRSN" class="form-control-plaintext" readonly /></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</fieldset>
					</form:form>		
					<form:form id="UNIPASS_STATUS_5DF-form" class="s4-form form-horizontal form-dialog" novalidate="novalidate">
						<fieldset>
							<div class="dialog-form-group">
								<div class="col-md-12 table-responsive">
									<table class="table table-bordered">
										<colgroup>
											<col style="width: 120px;" />
											<col style="width: 120px;" />
											<col style="width: ;" />
											<col style="width: ;" />
											<col style="width: ;" />
											<col style="width: ;" />
										</colgroup>
										<tbody>
											<tr>
												<th style="vertical-align: middle; text-align: center;">접수 상세내역</th>										
												<th>문서구분</th>
												<td colspan="4"><input type="text" id="STTEMNT_DOC_STLE" name="STTEMNT_DOC_STLE" class="form-control-plaintext" readonly /></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</fieldset>
					</form:form>		
				</div> <!-- grid_05 end -->
				
				
				<div class="tab-pane fade" id="grid_06">
					<!-- 지급통보 -->
					<form:form id="UNIPASS_STATUS_381-form" class="s4-form form-horizontal form-dialog" novalidate="novalidate">
						<input type="hidden" name="COMPANY_CODE" id="COMPANY_CODE" value="${reqParam.COMPANY_CODE}" />
						<input type="hidden" name="DIVISION_CODE" id="DIVISION_CODE" value="${reqParam.DIVISION_CODE}" />
						<input type="hidden" name="SUBMIT_NO" id="SUBMIT_NO" value="${reqParam.SUBMIT_NO}" />
						<fieldset>
							<div class="dialog-form-group">
								<div class="col-md-12 table-responsive">
									<table class="table table-bordered">
										<colgroup>
											<col style="width: 120px;" />
											<col style="width: 120px;" />
											<col style="width: 200px;" />
											<col style="width: 120px;" />
											<col style="width:;" />
											<col style="width: 120px;" />
											<col style="width:;" />
										</colgroup>
										<tbody>
											<tr>
												<th rowspan="2" style="vertical-align: middle; text-align: center;">접수 정보</th>
												<th>내부관리번호</th>
												<td><input type="text" id="PRESENTN_NO" name="PRESENTN_NO" class="form-control-plaintext" value="${reqParam.PRESENTN_NO}" readonly /></td>
												<th>지급통보일시</th>
												<td colspan="4"><input type="text" id="RECV_DATE" name="RECV_DATE" class="form-control-plaintext" readonly /></td>
												
											</tr>
											<tr>
												<th>제출번호</th>
												<td><input type="text" id="SUBMIT_NO" name="SUBMIT_NO" class="form-control-plaintext" value="${reqParam.SUBMIT_NO}" readonly /></td>
												<th>접수번호</th>
												<td><input type="text" id="REGIST_RCEPT_NO" name="REGIST_RCEPT_NO" class="form-control-plaintext"  value="${reqParam.REGIST_RCEPT_NO}" readonly /></td>
												<th>결정일자</th>
												<td><input type="text" id="AUTHEN_DATE" name="AUTHEN_DATE" class="form-control-plaintext" readonly /></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</fieldset>
					</form:form>
					<form:form id="UNIPASS_STATUS_381-form" class="s4-form form-horizontal form-dialog" novalidate="novalidate">
						<fieldset>
							<div class="dialog-form-group">
								<div class="col-md-12 table-responsive">
									<table class="table table-bordered">
										<colgroup>
											<col style="width: 120px;" />
											<col style="width: 120px;" />
											<col style="width: 200px;" />
											<col style="width: 120px;" />
											<col style="width:;" />
											<col style="width: 120px;" />
											<col style="width:;" />
										</colgroup>
										<tbody>
											<tr>
												<th rowspan="2" style="vertical-align: middle; text-align: center;">접수 상세내역</th>
												<th>문서구분</th>
												<td><input type="text" id="STTEMNT_DOC_STLE" name="STTEMNT_DOC_STLE" class="form-control-plaintext" readonly /></td>
												<th>신청인</th>
												<td><input type="text" id="SUBMITTER" name="SUBMITTER" class="form-control-plaintext" readonly /></td>
												<th>지급은행</th>
												<td><input type="text" id="PAY_BANK_NAME" name="PAY_BANK_NAME" class="form-control-plaintext" readonly /></td>
											</tr>
											<tr>
												<th>결정일자</th>
												<td><input type="text" id="AUTHEN_DATE" name="AUTHEN_DATE" class="form-control-plaintext" readonly /></td>
												<th>지급계좌</th>
												<td><input type="text" id="ACNUTNO" name="ACNUTNO" class="form-control-plaintext" readonly /></td>
												<th>지급금액</th>
												<td><input type="text" id="PAY_AMOUNT" name="PAY_AMOUNT" class="form-control-plaintext" readonly /></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</fieldset>
					</form:form>
				</div> <!-- grid_06 end -->
				
			</div>
		</div>
		
	</div>
	
</div>
<script>
    var UNIPASS_STATUS = new function() {
        // Page Object Initialize
        this.initialize_Dialog_Object = function() {

            UNIPASS_STATUS.get_unipass_status_count();
                        
            $("#grid_Tab.nav.nav-tabs li").click(function(){
				//Search And ResizingGrid
				setTimeout(UNIPASS_STATUS.reSizingGrid, 300);
			});

        };
        
        /* 통보 별 counting 조회 */
        this.get_unipass_status_count = function(){
        	var param = {
                    "COMPANY_CODE" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "COMPANY_CODE"),
                    "DIVISION_CODE" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "DIVISION_CODE"),
                    "SUBMIT_NO" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "SUBMIT_NO"),
                    "REGIST_RCEPT_NO" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "REGIST_RCEPT_NO"),
                };
        	
        	KpackageOBJ.ajax.doSubmit("/drawback/get_unipass_status_count", param, UNIPASS_STATUS.uniapss_status_count_Handler);
		}
        
        /* count 조회 handler */
        this.uniapss_status_count_Handler = function(result) {
            const success = result.success;
            const datas = result.value;
            
            if(success && datas.length > 0){
				var isActive = false;
				
				for(var idx = 0; idx < datas.length; idx++){
					const data = datas[idx];
					
					const cnt = data.CNT;
					const key = data.KEY;
					
					if(cnt > 0){
						$("#" +key+ "").show();
						
						const func = "unipass_status_" + key;
						if(UNIPASS_STATUS[func]){
							UNIPASS_STATUS[func]();
						}
						
						if(isActive == false){
							$("#" +key+ "> a").trigger('click');
							isActive = true;
						} 
					}
				}
			}
        }
        
        
        /* 접수 통보 조회*/
        this.unipass_status_notification = function(result) {
        	// 접수 통보 조회
        	var param = {
                    "COMPANY_CODE" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "COMPANY_CODE"),
                    "DIVISION_CODE" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "DIVISION_CODE"),
                    "SUBMIT_NO" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "SUBMIT_NO"),
                    "REGIST_RCEPT_NO" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "REGIST_RCEPT_NO"),
                };
                
        	KpackageOBJ.ajax.doSubmit("/drawback/retrieve_unipass_status_notification", param, UNIPASS_STATUS.unipass_status_notification_handler);
        }
        
        this.unipass_status_notification_handler = function(result) {
			if(result){
				KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R54-form", "COMPLETE_DATE", result.COMPLETE_DATE);
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R54-form", "CATEGORY_NM", result.CATEGORY_NM);
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R54-form", "REGIST_RCEP_DATE", result.REGIST_RCEP_DATE);
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R54-form", "PL_TYPE", result.PL_TYPE);
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R54-form", "STTEMNT_DOC_STLE", result.STTEMNT_DOC_STLE);
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R54-form", "CSMHSE_PRSN", result.CSMHSE_PRSN);
			} 	    	
        }
        
        /* 오류 통보 조회*/
        this.unipass_status_error = function(result) {
        	// 오류 통보 master 조회
        	var param = {
                    "COMPANY_CODE" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "COMPANY_CODE"),
                    "DIVISION_CODE" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "DIVISION_CODE"),
                    "SUBMIT_NO" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "SUBMIT_NO")
                };

            KpackageOBJ.ajax.doSubmit("/drawback/retrieve_unipass_status_error_master", param, UNIPASS_STATUS.unipass_status_error_handler);
            
            // 오류 통보 detail 화면 구성
            var colArrayInfo = [ 
				{ header : '문서구분',		name : 'SUBMIT_STTEMNT_DOC_STLE',	width : 110, 	align : 'center',	hidden : false}
				, { header : '오류내역',    	name : 'ERROR_MESSAGE',    			width : 700,    align : 'left',    	hidden : false}
				, { header : '오류발생일시', 	name : 'CREATE_DATE',    			width : 150,    align : 'center',	hidden : false} 
			];

			KpackageOBJ.tuiGrid.create("oTui_UNIPASS_STATUS_R20_grid_01", "/drawback/retrieve_unipass_status_error_details", colArrayInfo, 'number', null);
			KpackageOBJ.tuiGrid.setCaption("oTui_UNIPASS_STATUS_R20_grid_01", "<spring:message code='오류 상세내역'/>");
        }
        
        this.unipass_status_error_handler = function(result) {
			// 오류 통보 master 정보 존재 시
        	 if (result && result.SUBMIT_NO) {
                 KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R20-master-form", "SUBMIT_NO", result.SUBMIT_NO);
                 KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R20-master-form", "SUBMIT_DATE", result.SUBMIT_DATE);
                 KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R20-master-form", "CATEGORY_NM", result.CATEGORY_NM);
                 KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R20-master-form", "RECV_DATE", result.RECV_DATE);

                 // 오류 통보 detail 조회
                 var param = {
                         "COMPANY_CODE" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "COMPANY_CODE"),
                         "DIVISION_CODE" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "DIVISION_CODE"),
                         "SUBMIT_NO" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "SUBMIT_NO")
                     };

                KpackageOBJ.tuiGrid.retrieve("oTui_UNIPASS_STATUS_R20_grid_01", "", param);
             }
		}
        
        /* 보완통보 조회*/
        this.unipass_status_complement = function(result) {
        	// 보완통보 조회
        	var param = {
                    "COMPANY_CODE" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "COMPANY_CODE"),
                    "DIVISION_CODE" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "DIVISION_CODE"),
                    "REGIST_RCEPT_NO" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "REGIST_RCEPT_NO"),
                };
                
        	KpackageOBJ.ajax.doSubmit("/drawback/retrieve_unipass_status_complement", param, UNIPASS_STATUS.unipass_status_complement_handler);
        }
        
        this.unipass_status_complement_handler = function(result) {
			if(result){
				KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R58-form", "STTEMNT_DOC_STLE", result.STTEMNT_DOC_STLE);		
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R58-form", "CSMHSE_KWA_CODE", result.CSMHSE_KWA_CODE);		
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R58-form", "CSMHSE_KWAJANG_NAME", result.CSMHSE_KWAJANG_NAME);		
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R58-form", "CSMHSE_PRSN", result.CSMHSE_PRSN);		
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R58-form", "CSMHSE_PRSN_TEL", result.CSMHSE_PRSN_TEL);		
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R58-form", "RECV_NAME", result.RECV_NAME);		
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R58-form", "RECV_CMPNY_NAME", result.RECV_CMPNY_NAME);		
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R58-form", "COMPLETE_DATE", result.COMPLETE_DATE);		
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R58-form", "SUBMIT_DUE_DATE", result.SUBMIT_DUE_DATE);		
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R58-form", "SPLMT_TEXT", result.SPLMT_TEXT);		
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R58-form", "REMARK", result.REMARK);		
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R58-form", "CSMHSE_NAME", result.CSMHSE_NAME);		
			} 	
        }
        
        /* 자료제출요구 통보 조회*/
        this.unipass_status_request = function(result) {
        	// 자료제출요구 통보 조회
        	var param = {
                    "COMPANY_CODE" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "COMPANY_CODE"),
                    "DIVISION_CODE" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "DIVISION_CODE"),
                    "REGIST_RCEPT_NO" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "REGIST_RCEPT_NO"),
                };
                
        	KpackageOBJ.ajax.doSubmit("/drawback/retrieve_unipass_status_request", param, UNIPASS_STATUS.unipass_status_request_handler);
        }
        
        this.unipass_status_request_handler = function(result) {
			if(result){
				KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R57-form", "COMPLETE_DATE", result.COMPLETE_DATE);
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R57-form", "CSMHSE_NAME", result.CSMHSE_NAME);
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R57-form", "SUBMIT_DUE_DATE", result.SUBMIT_DUE_DATE);
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R57-form", "STTEMNT_DOC_STLE", result.STTEMNT_DOC_STLE);
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R57-form", "RECV_CMPNY_NAME", result.RECV_CMPNY_NAME);
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R57-form", "RECV_NAME", result.RECV_NAME);
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R57-form", "CSMHSE_KWAJANG_NAME", result.CSMHSE_KWAJANG_NAME);    	
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R57-form", "CSMHSE_PRSN", result.CSMHSE_PRSN);    	
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R57-form", "CSMHSE_PRSN_TEL", result.CSMHSE_PRSN_TEL);    	
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R57-form", "CSMHSE_KWA_NAME ", result.CSMHSE_KWA_NAME );    	
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_R57-form", "REQ_RESN", result.REQ_RESN);    		
			}	
        }
        
        /* 완료 통보 조회*/
        this.unipass_status_complete = function(result) {
        	// 지급 통보 master 조회
        	var param = {
                    "COMPANY_CODE" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "COMPANY_CODE"),
                    "DIVISION_CODE" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "DIVISION_CODE"),
                    "SUBMIT_NO" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "SUBMIT_NO"),
                    "REGIST_RCEPT_NO" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "REGIST_RCEPT_NO")
                };

            KpackageOBJ.ajax.doSubmit("/drawback/retrieve_unipass_status_complete", param, UNIPASS_STATUS.unipass_status_complete_handler);
        }
        
        this.unipass_status_complete_handler = function(result) {
			if(result){
				KpackageOBJ.object.setFormValue("UNIPASS_STATUS_5DF-form", "STTEMNT_DOC_STLE", result.STTEMNT_DOC_STLE); 		
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_5DF-form", "COMPLETE_DATE", result.COMPLETE_DATE); 		
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_5DF-form", "CSMHSE_PRSN", result.CSMHSE_PRSN); 		
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_5DF-form", "INSPECTIONENDDATE", result.INSPECTIONENDDATE); 		
	        	KpackageOBJ.object.setFormValue("UNIPASS_STATUS_5DF-form", "CSMHSE_NAME", result.CSMHSE_NAME); 		
			}
        }
        
        
        /* 지급 통보 조회*/
        this.unipass_status_payment = function(result) {
        	// 지급 통보 master 조회
        	var param = {
                    "COMPANY_CODE" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "COMPANY_CODE"),
                    "DIVISION_CODE" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "DIVISION_CODE"),
                    "REGIST_RCEPT_NO" : KpackageOBJ.object.getFormValue("UNIPASS_STATUS_R20-master-form", "REGIST_RCEPT_NO")
                };

            KpackageOBJ.ajax.doSubmit("/drawback/retrieve_unipass_status_payment", param, UNIPASS_STATUS.unipass_status_payment_handler);
        }
        
        this.unipass_status_payment_handler = function(result) {
			// 지급 통보 master 정보 존재 시
        	 if (result) {
                 KpackageOBJ.object.setFormValue("UNIPASS_STATUS_381-form", "STTEMNT_DOC_STLE", result.STTEMNT_DOC_STLE);
                 KpackageOBJ.object.setFormValue("UNIPASS_STATUS_381-form", "SUBMITTER", result.SUBMITTER);
                 KpackageOBJ.object.setFormValue("UNIPASS_STATUS_381-form", "PAY_BANK_NAME", result.PAY_BANK_NAME);
                 KpackageOBJ.object.setFormValue("UNIPASS_STATUS_381-form", "AUTHEN_DATE", result.AUTHEN_DATE);
                 KpackageOBJ.object.setFormValue("UNIPASS_STATUS_381-form", "ACNUTNO", result.ACNUTNO);
                 KpackageOBJ.object.setFormValue("UNIPASS_STATUS_381-form", "PAY_AMOUNT", result.PAY_AMOUNT);
                 KpackageOBJ.object.setFormValue("UNIPASS_STATUS_381-form", "RECV_DATE", result.RECV_DATE);
                 KpackageOBJ.object.setFormValue("UNIPASS_STATUS_381-form", "AUTHEN_DATE", result.AUTHEN_DATE);
             }
		}
        
        /* 리사이징 */
        this.reSizingGrid = function(){
            //오류통보 그리드 사이즈 재설정
            KpackageOBJ.tuiGrid.reSizingGrid("oTui_UNIPASS_STATUS_R20_grid_01");
        }
    }

    $(document).ready(function() {
        UNIPASS_STATUS.initialize_Dialog_Object();

    });
</script>
</body>
</html>