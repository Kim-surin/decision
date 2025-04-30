<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
/******************************************************************************************************
	Program Name : INTERFACE TEST
	Program Code : SAMPLE-006
******************************************************************************************************/
%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<div id="content">
	<section id="widget-grid-SAMPLE006" class="">
		<form:form id="SAMPLE006-form" class="s4-form" novalidate="novalidate" onsubmit="return false;" action="/#/sm-006">
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;" />
								<col style="width: 200px;" />
								<col style="width: 130px;" />
							</colgroup>
							<tbody>
								<tr>
									<th>회사코드333</th>
									<td>
										<input type="text" id="COMPANY_CODE"  name="COMPANY_CODE" style="width:120px" class="inputText" maxlength="20" searchfnc="SAMPLE006.submitSearch"/>
									</td>
									<td rowspan="2">
										<div class="input-group-btn">
											<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:SAMPLE006.submitSearch();">
												<i class="fa fa-search"></i> Vendor
											</button>
										</div>
										
										<div class="input-group-btn">
											<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:SAMPLE006.submit_item();">
												<i class="fa fa-search"></i> Item
											</button>
										</div>
										
										<div class="input-group-btn">
											<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:SAMPLE006.submit_po();">
												<i class="fa fa-search"></i> PO  
											</button>
										</div>
										
										<div class="input-group-btn">
											<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:SAMPLE006.submit_salesLedger();">
												<i class="fa fa-search"></i> 매각
											</button>
										</div>
										
										
									</td>
								</tr>
								<tr>
									<th>FROM/TO DATE</th>
									<td>
										<input type="text" id="CAL_SEARCH_FROM_DATE"  name="CAL_SEARCH_FROM_DATE" style="width:120px" class="inputText" searchfnc="SAMPLE006.submitSearch"/>
										<input type="hidden" id="SEARCH_FROM_DATE"  name="SEARCH_FROM_DATE" />
										<span class="fromTo-Dash">~</span>
										<input type="text" id="CAL_SEARCH_TO_DATE"  name="CAL_SEARCH_TO_DATE" style="width:120px" class="inputText" searchfnc="SAMPLE006.submitSearch"/>
										<input type="hidden" id=SEARCH_TO_DATE  name="SEARCH_TO_DATE" />
									</td>
								</tr>
							</tbody>
						</table>		
					</div>
				</div>
			</div>
		</form:form>
	</section>
</div>

<div id="result" style="border: 1px #ddd solid;">

</div>

<script type="text/javascript">

	var SAMPLE006 = new function() {

		this.Initialize_viewObject = function() {
			var fromDay = KpackageOBJ.date.getCurrMonth() + "01";
			var toDay = KpackageOBJ.date.getCurrMonth() + KpackageOBJ.date.lastDay(KpackageOBJ.date.getCurrMonth());
			
			KpackageOBJ.calendar.create("SAMPLE006-form", "CAL_SEARCH_FROM_DATE");
			KpackageOBJ.calendar.setValue("SAMPLE006-form","CAL_SEARCH_FROM_DATE", fromDay);
			KpackageOBJ.object.setFormValue("SAMPLE006-form","SEARCH_FROM_DATE", fromDay);
			
			KpackageOBJ.calendar.create("SAMPLE006-form", "CAL_SEARCH_TO_DATE");
			KpackageOBJ.calendar.setValue("SAMPLE006-form","CAL_SEARCH_TO_DATE", toDay);
			KpackageOBJ.object.setFormValue("SAMPLE006-form","SEARCH_TO_DATE",toDay);
		}
		
		this.submitSearch = function(){
			var strCompanyCode =  KpackageOBJ.object.getFormValue("SAMPLE006-form", "COMPANY_CODE");
			
			if(oUtil.isNull(strCompanyCode)){
				KpackageOBJ.object.alert("회사코드를 입력해주세요.");
				return false;
			}
			
			
			var params = {
					"COMPANY_CODE" : KpackageOBJ.object.getFormValue("SAMPLE006-form", "COMPANY_CODE")
					, "SEARCH_FROM_DATE" : KpackageOBJ.object.getFormValue("SAMPLE006-form", "SEARCH_FROM_DATE")
					, "SEARCH_TO_DATE" : KpackageOBJ.object.getFormValue("SAMPLE006-form", "SEARCH_TO_DATE")
			};
			
			KpackageOBJ.ajax.doSubmit("/restful/test_vendor", params, SAMPLE006.sample06_callBack);   
		}
		
		this.submit_item = function(){
			var strCompanyCode =  KpackageOBJ.object.getFormValue("SAMPLE006-form", "COMPANY_CODE");
			
			if(oUtil.isNull(strCompanyCode)){
				KpackageOBJ.object.alert("회사코드를 입력해주세요.");
				return false;
			}
			
			
			var params = {
					"COMPANY_CODE" : KpackageOBJ.object.getFormValue("SAMPLE006-form", "COMPANY_CODE")
					, "SEARCH_FROM_DATE" : KpackageOBJ.object.getFormValue("SAMPLE006-form", "SEARCH_FROM_DATE")
					, "SEARCH_TO_DATE" : KpackageOBJ.object.getFormValue("SAMPLE006-form", "SEARCH_TO_DATE")
			};
			
			KpackageOBJ.ajax.doSubmit("/restful/test_item", params, SAMPLE006.sample06_callBack);   
		}
		
		this.submit_po = function(){
			var strCompanyCode =  KpackageOBJ.object.getFormValue("SAMPLE006-form", "COMPANY_CODE");
			
			if(oUtil.isNull(strCompanyCode)){
				KpackageOBJ.object.alert("회사코드를 입력해주세요.");
				return false;
			}
			
			
			var params = {
					"COMPANY_CODE" : KpackageOBJ.object.getFormValue("SAMPLE006-form", "COMPANY_CODE")
					, "SEARCH_FROM_DATE" : KpackageOBJ.object.getFormValue("SAMPLE006-form", "SEARCH_FROM_DATE")
					, "SEARCH_TO_DATE" : KpackageOBJ.object.getFormValue("SAMPLE006-form", "SEARCH_TO_DATE")
			};
			
			KpackageOBJ.ajax.doSubmit("/restful/test_po", params, SAMPLE006.sample06_callBack);   
		}
		
		
		this.sample06_callBack = function(result){
			
			$("#result").html(JSON.stringify(result));
			
		}
		
		
		this.submit_salesLedger = function(){
			var strCompanyCode =  KpackageOBJ.object.getFormValue("SAMPLE006-form", "COMPANY_CODE");
			
			if(oUtil.isNull(strCompanyCode)){
				KpackageOBJ.object.alert("회사코드를 입력해주세요.");
				return false;
			}
			
			
			var params = {
					"COMPANY_CODE" : KpackageOBJ.object.getFormValue("SAMPLE006-form", "COMPANY_CODE")
					, "SEARCH_FROM_DATE" : KpackageOBJ.object.getFormValue("SAMPLE006-form", "SEARCH_FROM_DATE")
					, "SEARCH_TO_DATE" : KpackageOBJ.object.getFormValue("SAMPLE006-form", "SEARCH_TO_DATE")
			};
			
			KpackageOBJ.ajax.doSubmit("/restful/test_salesLedger", params, SAMPLE006.sample06_callBack);   
		}
		
		
	}

	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		SAMPLE006.Initialize_viewObject();
	});

</script>
	
</body>
</html>