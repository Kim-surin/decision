<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
/******************************************************************************************************
	Program Name : 과다환급금 자진신고서 작성
	Program Code : DB00901
******************************************************************************************************/
%>
<!DOCTYPE html>
<html>
<head>

	
	
	
	
</head>
<body>
<div id="content">
	<section id="widget-grid-DB00901" class="">
		<form:form id="DB00901-form" class="s4-form" novalidate="novalidate" onsubmit="return false;">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<input type="hidden" id="SEARCH_REGIST_RCEPT_NO" name="SEARCH_REGIST_RCEPT_NO" value="${reqParam.SEARCH_REGIST_RCEPT_NO }"/>
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 10px;margin-top: 15px;">
					<div class="table-responsive of-hidden">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:150px;" />
								<col style="width: " />
								<col style="width:150px;" />
								<col style="width: ;" />
							</colgroup>
							<tbody>
								<tr>
									<th>접수일자</th>
									<td>
										<span id="TXT_RECEIP_YYYYMMDD"></span>
									</td>
									<th>처리기간</th>
									<td>
										<span id="PROCESS_TERM"> 15일</span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 10px;">
					<div class="table-responsive of-hidden">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:100px;" />
								<col style="width:" />
								<col style="width:" />
								<col style="width: ;" />
							</colgroup>
							<tbody>
								<tr>
									<th rowspan="2" style="vertical-align: middle;">신고인</th>
									<td>
										<section style="margin-bottom: 0px;">
											<label class="label">상호</label>
											<label class="input">
												<input type="text" id="RCEPT_COMPANY_NAME"  name="RCEPT_COMPANY_NAME" style="width:99%;" class="inputText" value="삼정회계법인 I.T.A"/>
											</label>
										</section>
									</td>
									<td>
										<section style="margin-bottom: 0px;">
											<label class="label">대표자</label>
											<label class="input">
												<input type="text" id="RCEPT_RPRSNTV_NM"  name="RCEPT_RPRSNTV_NM" style="width:99%;" class="inputText" value="홍길동"/>
											</label>
										</section>
									</td>
									<td>
										<section style="margin-bottom: 0px;">
											<label class="label">통관고유번호</label>
											<label class="input">
												<input type="text" id="ECTMRK"  name="ECTMRK" style="width:99%;" class="inputText" value="1234567"/>
											</label>
										</section>
									</td>
								</tr>
								<tr>
									<td>
										<section style="margin-bottom: 0px;">
											<label class="label">사업자등록번호</label>
											<label class="input">
												<input type="text" id="BIZRNO"  name="BIZRNO" style="width:99%;" class="inputText" value="1438500115"/>
											</label>
										</section>
									</td>
									<td colspan="2">
										<section style="margin-bottom: 0px;">
											<label class="label">주소</label>
											<label class="input">
												<input type="text" id="ADDRESS"  name="ADDRESS" style="width:99%;" class="inputText" value="서울특별시 중구 세종대로 110"/>
											</label>
										</section>
										
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 10px;">
					<h5 style="text-align: center;margin: 10px 0px 10px 0px; font-weight: bold;">과다환급과 관련된 환급신청 동의 내역</h5>
					<div class="table-responsive of-hidden">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:16%;;"/>
								<col style="width:12%;"/>
								<col style="width:12%;"/>
								<col style="width:15%;"/>
								<col style="width:14%;"/>
								<col style="width: ;" />
							</colgroup>
							<tbody>
								<tr>
									<th style="text-align: center">환급 신청번호</th>
									<th style="text-align: center">환급 결정일자</th>
									<th style="text-align: center">환급 결정액</th>
									<th style="text-align: center">정당 환급액</th>
									<th style="text-align: center">과다 환급액</th>
									<th style="text-align: center">비고</th>
								</tr>
								<tr>
									<td class="info" style="height:30px;text-align: center;padding: 8px 5px 0px 4px;"><span id="REGIST_RCEPT_NO"></span></td>
									<td class="info" style="height:30px;text-align: center;padding: 8px 5px 0px 4px;"><span id="DRWBAK_COMP_YYYYMMDD"></span></td>
									<td class="info" style="height:30px;text-align: right;padding: 8px 5px 0px 4px;"><span id="DRWBAK_AMOUNT"></span></td>
									<td style="height:30px;">
										<input type="text" id="PROPER_DRWBAK_AMOUNT"  name="PROPER_DRWBAK_AMOUNT" style="width: 99%;height: 99%;text-align: right;" class="inputText" />
									</td>
									<td class="info" style="height:30px;text-align: right;padding: 8px 5px 0px 4px;"><span id="BALANCE_AMOUNT"></span></td>
									<td style="height:30px;">
										<input type="text" id="OVER_DRWBAK_REMARK"  name="OVER_DRWBAK_REMARK" style="width:99%;height: 99%" class="inputText"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 10px;">
					<div class="table-responsive of-hidden">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:70%" />
								<col style="width: ;" />
							</colgroup>
							<tbody>
								<tr>
									<td>
										<section>
											<label class="label">과다환급 사유</label>
											<label class="textarea textarea-resizable"> 										
												<textarea id="OVER_DRWBAK_REASON" name="OVER_DRWBAK_REASON" rows="3" class="custom-scroll" style="width: 99%"></textarea> 
											</label>
										</section>
									</td>
									<td>
										<section>
											<label class="label">과다환급액 계산내역</label>
											<div class="note">
												<strong>Note:</strong> 환급신청건별로 작성하여 별도 첨부.
											</div>
											<label class="textarea textarea-resizable"> 										
												 
											</label>
										</section>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<label class="label">「수출용원재료에 대한 관세 등 환급에 관한 특례법 시행령」 제 31조 제1항 및 「수출용원재료에 대한 관세 등 환급사무처리에 관한 고시」 제25조에 따라 과다환급 받은 사실을 신고합니다.</label>
										<label class="label" style="text-align: right;" >
											<span id="TXT_RECEIP_YYYYMMDD_FOOT">YYYY-MM-DD</span>
											
										</label>
										<label class="label" style="text-align: right;" >
											신고인<span id="RCEPT_RPRSNTV_NM_FOOTER" style="margin-left: 45px;margin-right: 30px;">홍길동</span> (서명 또는 인)
										</label>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="btn-group" style="width:100%; text-align: right;">
				<a href="javascript:DB00901.createDocument();" id="btn-next" class="btn btn-primary btn-xs" style="float: right;" ><i class="fa fa-chevron-right"></i> Save</a>
			</div>  
		</form:form>
	</section>
</div>

<script type="text/javascript">


	var oTui_DB00901_01, oTui_DB00901_02
	var DB00901 = new function() {
		
		this.initialize_viewObject = function(){

		}
		
		this.initialize_TuiGrid = function(){};
		
		this.onDblClick_oTui_Grid = function(gridId, rowkey, colName){};
		
		<% // 해더정보 조회 %>
		this.retrieve_OverDrwbak_Information = function(){
			var params = { "SEARCH_PRESENTN_NO"   : KpackageOBJ.object.getFormValue("DB00901-form","SEARCH_PRESENTN_NO") };
			KpackageOBJ.ajax.doSubmit("/drawback/retrieve_00901Detail", params, DB00901.retrieve_Information_callback);	
		}

		this.retrieve_Information_callback = function(result){
			var data = result.value;
			if(data["RCEPT_DATE"] != null){
				$("#DB00901-form #TXT_RECEIP_YYYYMMDD").html(data["RCEPT_DATE"]);
				$("#DB00901-form #TXT_RECEIP_YYYYMMDD_FOOT").html(data["RCEPT_DATE"]);	
			}
			
			if(data["REGIST_RCEPT_NO"] != null){
				 $("#DB00901-form #REGIST_RCEPT_NO").html(data["REGIST_RCEPT_NO"]);
			}
			
		   
		    $("#DB00901-form #DRWBAK_COMP_YYYYMMDD").html(data["DRWBAK_COMP_YYYYMMDD"]);
		    $("#DB00901-form #DRWBAK_AMOUNT").html(KpackageOBJ.formatter.commas(data["DRWBAK_AMOUNT"]));
		    $("#DB00901-form #PROPER_DRWBAK_AMOUNT").val(data["PROPER_DRWBAK_AMOUNT"]);
		    $("#DB00901-form #OVER_DRWBAK_REMARK").val(data["OVER_DRWBAK_REMARK"]);
		    $("#DB00901-form #OVER_DRWBAK_REASON").val(data["OVER_DRWBAK_REASON"]);
		    $("#DB00901-form #RCEPT_COMPANY_NAME").val(data["RCEPT_COMPANY_NAME"]);
		    $("#DB00901-form #RCEPT_RPRSNTV_NM").val(data["RCEPT_RPRSNTV_NM"]);
		    $("#DB00901-form #RCEPT_RPRSNTV_NM_FOOTER").html(data["RCEPT_RPRSNTV_NM"]);
		    
		    $("#DB00901-form #ECTMRK").val(data["ECTMRK"]);
		    $("#DB00901-form #BIZRNO").val(data["BIZRNO"]);
		    $("#DB00901-form #ADDRESS").val(data["ADDRESS"]);
		    $("#DB00901-form #ATTECH_FILE").html(data["ATTECH_FILE"]);
		    $("#DB00901-form #ATTECH_KEY").html(data["ATTECH_KEY"]);
		    
		    if("" != KpackageOBJ.object.getFormValue("DB00901-form","PROPER_DRWBAK_AMOUNT")){
		    	var balance = Number(data["DRWBAK_AMOUNT"]) - Number(KpackageOBJ.object.getFormValue("DB00901-form","PROPER_DRWBAK_AMOUNT"));
		    	balance = balance.toFixed(2);
		    	$("#DB00901-form #BALANCE_AMOUNT").html(KpackageOBJ.formatter.commas(balance));
		    	
		    }else{
		    	$("#DB00901-form #BALANCE_AMOUNT").html("");
		    }
			
		}
		
		this.createDocument = function(){
			
			var params = KpackageOBJ.data.makePostData("DB00901-form");
			
			if("" == params.RCEPT_COMPANY_NAME){
				alert("상호는 필수입력 항목 입니다.");
				return;
			}
			if("" == params.RCEPT_RPRSNTV_NM){
				alert("대표자는 필수입력 항목 입니다.");
				return;
			}
			if("" == params.ECTMRK){
				alert("통관고유번호는 필수입력 항목 입니다.");
				return;
			}
			if("" == params.BIZRNO){
				alert("사업자등록번호는 필수입력 항목 입니다.");
				return;
			}
			if("" == params.ADDRESS){
				alert("주소는 필수입력 항목 입니다.");
				return;
			}
			if("" == params.PROPER_DRWBAK_AMOUNT){
				alert("정당 환급금액은 필수입력 항목 입니다.");
				return;
			}
			if("" == params.OVER_DRWBAK_REMARK){
				alert("비고 사항은 필수입력 항목 입니다.");
				return;
			}
			if("" == params.OVER_DRWBAK_REASON){
				alert("과다환급 사유는 필수입력 항목 입니다.");
				return;
			}
			
			
				   
			
			KpackageOBJ.ajax.doSubmit("/drawback/merge_OverDrwbak_Document", params, DB00901.createDocument_CallBacHandler);
		}
		
		this.createDocument_CallBacHandler = function(result){
			if("" != result.message){
				alert(result.message);	
			}
			DB00901.retrieve_OverDrwbak_Information();
			
		}
	}

	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		
		
	});

</script>
	
</body>
</html>