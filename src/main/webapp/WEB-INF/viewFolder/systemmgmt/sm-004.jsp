<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form:form id="SM004-form" class="s4-form" novalidate="novalidate">
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='iteminfo.title.STD_DATE' /></th>
									<td>
										<input type="text" id="CAL_FROM_DATE"  name="CAL_FROM_DATE" style="width:120px" class="inputText"/>
										<i class="fromTo fa fa-minus" style="margin-left: 9px;"/>
										<input type="text" id="CAL_TO_DATE"  name="CAL_TO_DATE" style="width:120px" class="inputText"/>
										<input type="hidden" id="FROM_DATE" name="FROM_DATE" style="width:80px"/> <input type="hidden" id="TO_DATE" name="TO_DATE" style="width:80px"/>
									</td>
									<th><spring:message code='TXT.INF_PGM' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_SCHEDULE_CODE" name="SEARCH_SCHEDULE_CODE" style="width: 110px" required="" onchange="javascript:changeHandler_SCHEDULE_CODE();">
											<option value="" selected="">전체</option>
											<option value="DAILY_BATCH">Daily</option>
											<option value="MONTHLY_BATCH">Monthly</option></select> <select class="form-control searchSelect" id="SEARCH_IF_CODE" name="SEARCH_IF_CODE" style="width:110px" required></select>										
									</td>
								</tr>
								<tr>
									<th><spring:message code='TXT.STATUS' /></th>
									<td colspan="3">
										<select id="TRANS_STATUS" name="TRANS_STATUS" class="form-control searchSelect" style="width: 80px;">
											<option value="" selected="selected">전체</option>
											<option value="2">Failure</option>
											<option value="1">Succeed</option>
											<option value="0">Working</option>
										</select>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
					
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-2" type="button" onclick="javascript:SM004.retrieve_IntgHistory;">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		<div class="row">
			<article class="col-xs-12 col-sm-4 col-md-4 col-lg-4" style="padding-right: 0px;">
				<div id="DAY_LAY" class="alert alert-block  link dataTransfer_wating" >
					<h4 class="alert-heading" style="color: white; font-size: 13px;">Daily Batch Status</h4>
					<div class="row">
						<article class="col-xs-12 col-sm-4 col-md-4 col-lg-4" style="padding-right: 0px;">
							<div id="DAILY_STATUS_WAITING" name="TRANSFER_STATUS"><span style="letter-spacing: -1px;font-size: 38px;font-weight: bold;margin-left: 15px; color: black;font-family: sans-serif;">W</span><span style="letter-spacing: -1px;font-size: 23px; color: black;font-weight: bold;">aiting</span></div>
							<div id="DAILY_STATUS_RUNNING" name="TRANSFER_STATUS" style="display:none"><span style="letter-spacing: -1px;font-size: 38px;font-weight: bold;margin-left: 15px; color: black;font-family: sans-serif;">R</span><span style="letter-spacing: -1px;font-size: 23px; color: black;font-weight: bold;">unning</span></div>
						</article>
						<article class="col-xs-12 col-sm-8 col-md-8 col-lg-8" style="text-align: left;padding-left: 60px;">
							<br><span style="color: white; font-weight: bold;">인터페이스 수행 스케줄</span>
							<br><span style="color: white; font-weight: bold;" id="DAILY_TIME">매일 01시 40분</span>
						</article>
					</div>
				</div>
				<div id="div_oTui_Intg_Daily" name="div_oTui_Intg_Daily" class="tuigrid-resizable">
					<div id="oTui_Intg_Daily" data-minus-height="380"></div>
					<div id="oTui_Intg_Daily_paging"></div>
				</div>
			</article>
			<article class="col-xs-12 col-sm-4 col-md-4 col-lg-4" style="padding-right: 0px;">
				<div id="MONTH_LAY" class="alert  alert-block link dataTransfer_wating">
					<h4 class="alert-heading" style="color: white; font-size: 13px;">Monthly Batch Status</h4>
					<div class="row">
						<article class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
							<div id="MONTHLY_STATUS_WAITING" name="TRANSFER_STATUS"><span style="letter-spacing: -1px;font-size: 38px;font-weight: bold;margin-left: 15px; color: black;font-family: sans-serif;">W</span><span style="letter-spacing: -1px;font-size: 23px; color: black;font-weight: bold;">aiting</span></div>
							<div id="MONTHLY_STATUS_RUNNING" name="TRANSFER_STATUS" style="display:none"><span style="letter-spacing: -1px;font-size: 38px;font-weight: bold;margin-left: 15px; color: black;font-family: sans-serif;">R</span><span style="letter-spacing: -1px;font-size: 23px; color: black;font-weight: bold;">unning</span></div>
						</article>
						<article class="col-xs-12 col-sm-8 col-md-8 col-lg-8" style="text-align: left;padding-left: 60px;">
							<br><span style="color: white; font-weight: bold;">인터페이스 수행 스케줄</span>
							<br><span style="color: white; font-weight: bold;" id="MONTHLY_TIME">20일 02시 40분</span>
						</article>
					</div>
				</div>
				<div id="div_oTui_Intg_Monthly" name="div_oTui_Intg_Daily" class="tuigrid-resizable">
					<div id=oTui_Intg_Monthly data-minus-height="380"></div>
					<div id="oTui_Intg_Monthly_paging"></div>
				</div>
			</article>
			<article class="col-xs-12 col-sm-4 col-md-4 col-lg-4" style="padding-right: 13px;">
				<div id="MANUAL_LAY" class="alert alert-block  dataTransfer_wating">
					<h4 class="alert-heading" style="color: white; font-size: 13px;">Manually Batch Status</h4>
					<div class="row">
						<article class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
							<div id="MANUALLY_STATUS_WAITING" name="TRANSFER_STATUS"><span style="letter-spacing: -1px;font-size: 38px;font-weight: bold;margin-left: 15px; color: black;font-family: sans-serif;">W</span><span style="letter-spacing: -1px;font-size: 23px; color: black;font-weight: bold;">aiting</span></div>
							<div id="MANUALLY_STATUS_RUNNING" name="TRANSFER_STATUS" style="display:none"><span style="letter-spacing: -1px;font-size: 38px;font-weight: bold;margin-left: 15px; color: black;font-family: sans-serif;">R</span><span style="letter-spacing: -1px;font-size: 23px; color: black;font-weight: bold;">unning</span></div>
						</article>
						<article class="col-xs-12 col-sm-8 col-md-8 col-lg-8" style="text-align:right">
							<a href="javascript:openUserExecute();" class="btn btn-sm btn-default" style="padding:10px 35px;margin-top: 10px;"><strong>수동실행설정</strong></a>
						</article>
					</div>
				</div>
				<div id="div_oTui_Intg_Menual" name="div_oTui_Intg_Daily" class="tuigrid-resizable">
					<div id=oTui_Intg_Menual data-minus-height="380"></div>
					<div id="oTui_Intg_Menual_paging"></div>
				</div>
			</article>
		</div>
		</section><!-- section id="widget-grid"  End -->

</div>

<script>


	var SM004 = new function(){
	
		this.GLOBAL_RUNNING_FLAG = false;
		
		this.Initialize_viewObject = function() {
			SM004.retrieve_Interface_RunStatus();	//화면로드시 한번만 실행
			SM004.renderTuiGrid();
			
			
			/* Calendar Type Object Create  */
			KpackageOBJ.calendar.create("SM004-form", "CAL_FROM_DATE");
			KpackageOBJ.calendar.setValue("SM004-form","CAL_FROM_DATE", (KpackageOBJ.date.getCurrMonth("").replace(/-/gi, ""))+"01");
			
			KpackageOBJ.calendar.create("SM004-form", "CAL_TO_DATE");
			KpackageOBJ.calendar.setValue("SM004-form","CAL_TO_DATE", KpackageOBJ.date.getCurrDay().replace(/-/gi, ""));
			
		}
		
		this.renderTuiGrid = function() {
			 
			var colInfoArray = [
				 {"header" :"통합interface id"    ,name:"INTG_INTERFACE_TRANS_ID"    ,width:100   ,align:"center"    ,hidden:true},
				 {"header" :"인터페이스코드"      ,name:"IF_CODE"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"총건수"    ,name:"TOTAL_ROWS"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"이관일자"    ,name:"TRANS_DATE"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"생성일자"    ,name:"CREATE_DATE"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"수정일자"    ,name:"UPDATE_DATE"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"수정자"    ,name:"UPDATE_BY"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"스케쥴코드"    ,name:"SCHEDULE_CODE"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"인터페이스 파라메터"    ,name:"IF_PARAM"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"처리상태"    ,name:"STATUS"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"배치 프로세스 처리결과"    ,name:"BATCH_STATUS"    ,width:100   ,align:"center"    ,hidden:false},
				 {"header" :"에러여부"    ,name:"ERROR_YN"    ,width:100   ,align:"center"    ,hidden:false}
  			];
			
			KpackageOBJ.tuiGrid.create("oTui_Intg_Daily","/sys/retrieveDataTransHistory", colInfoArray, null, null, SM004.dbl_Handler);
			KpackageOBJ.tuiGrid.create("oTui_Intg_Monthly","", colInfoArray, null, null, SM004.dbl_Handler);
			KpackageOBJ.tuiGrid.create("oTui_Intg_Menual","", colInfoArray, null, null, SM004.dbl_Handler);
		}
		
		this.dbl_Handler = function(gridId, rowkey, colName){
			
			
		}
		
		this.retrieve_IntgHistory = function(result){
			
		}
		
		
		this.retrieve_Interface_RunStatus = function(){
			
			var params = {"DUMMY" : ""};
			KpackageOBJ.ajax.doSubmit("/sys/retrieveDataTransSchdule", params,SM004.retrieveDataTransSchdulea_CallbackHandler);  
		}
		
		this.retrieveDataTransSchdulea_CallbackHandler = function(result){
			var data = result.value;
			
			if (result.success) {
				SM004.GLOBAL_RUNNING_FLAG = false;
				$("div[name='TRANSFER_STATUS']").hide();
				$("#DAY_LAY").removeClass("dataTransfer_wating").removeClass("dataTransfer_running");
				$("#MONTH_LAY").removeClass("dataTransfer_wating").removeClass("dataTransfer_running");
				$("#MANUAL_LAY").removeClass("dataTransfer_wating").removeClass("dataTransfer_running");
				
				for(var inx=0; inx < data.length; inx++){
					var trsnStat = data[inx]["TRANSFER_STATUS"];
					
					if(!SM004.GLOBAL_RUNNING_FLAG){
						if("0" == trsnStat){
							SM004.GLOBAL_RUNNING_FLAG = true; // 데이터전송 중인 내역이 있으면 True 설정
						}
					}
					if("DAILY_BATCH" == data[inx]["SCHEDULE_CODE"]){
						if("0" == trsnStat){
							$("#DAILY_STATUS_RUNNING").show();
							$("#DAY_LAY").addClass("dataTransfer_running");
						}else{
							$("#DAILY_STATUS_WAITING").show();
							$("#DAY_LAY").addClass("dataTransfer_wating");
						}
						$("#DAILY_TIME").html("매일 "+ data[inx]["HOUR"]+"시 "+ data[inx]["MINUTES"] + "분");
						
					}else if("MONTHLY_BATCH" == data[inx]["SCHEDULE_CODE"]){
						if("0" == trsnStat){
							$("#MONTHLY_STATUS_RUNNING").show();
							$("#MONTH_LAY").addClass("dataTransfer_running");
						}else{
							$("#MONTHLY_STATUS_WAITING").show();
							$("#MONTH_LAY").addClass("dataTransfer_wating");
						}
						$("#MONTHLY_TIME").html("매월 "+ data[inx]["DAY"]+"일 "+ data[inx]["HOUR"]+"시 "+ data[inx]["MINUTES"] + "분");
					}else if("NON_SCHEDULE" == data[inx]["SCHEDULE_CODE"]){
						if("0" == trsnStat){
							$("#MANUALLY_STATUS_RUNNING").show();
							$("#MANUAL_LAY").addClass("dataTransfer_running");
						}else{
							$("#MANUALLY_STATUS_WAITING").show();
							$("#MANUAL_LAY").addClass("dataTransfer_wating");
							
						}
					}

				}	
			}
			
		}
	
	}
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		SM004.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});
</script>
</body>
</html>