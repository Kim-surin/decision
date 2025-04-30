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
	<form:form id="SM00101-detail-form" class="s4-form form-horizontal form-dialog" onsubmit="return false;" method="post">
		<input type="hidden" id="INTERFACE_SCHEDULE_ID" name="INTERFACE_SCHEDULE_ID"/>
		<fieldset>
			<legend style="margin-bottom: -20px;">배치 기본정보</legend>
			
			<div class="dialog-form-group">
				<div class="col-md-12 table-responsive">
					<table class="table table-bordered"  style="margin-bottom: 15px;">
						<colgroup>
						    <col style="width: 10%; min-width: 70px;;"/>
						    <col/>
						    <col style="width: 10%; min-width: 70px;;"/>
						    <col/>
						</colgroup>
						<tbody>
							<tr>
								<th>스케줄 코드</td>
								<td colspan="3"><input type="text" id="SCHEDULE_CODE" name="SCHEDULE_CODE" class="form-control"  placeholder="SCHEDULE_CODE" ></td>
							</tr>
							<tr>
								<th>스케줄 명</td>
								<td><input type="text" id="SCHEDULE_NAME" name="SCHEDULE_NAME" class="form-control"  placeholder="SCHEDULE_NAME" ></td>
								<th>프로그램 명</td>
								<td><input type="text" id="EXECUTION_PROGRAM" name="EXECUTION_PROGRAM" class="form-control"  placeholder="EXECUTION_PROGRAM" ></td>
							</tr>
							<tr>
								<th>적용기간</td>
								<td>
									<div style="float: left;">
										<input type="text" id="CAL_APPLY_FROM_DATE" name="CAL_APPLY_FROM_DATE" class="form-control" style="width: 100px;float: left;">
										<input type="hidden" id="APPLY_FROM_DATE" name="APPLY_FROM_DATE" class="form-control" style="width: 100px;float: left;">
									</div>
									<i class="fa fa-minus pt8" style="float: left;margin: 0 10px;"></i>
									<div style="float: left;">
										<input type="text" id="CAL_APPLY_TO_DATE" name="CAL_APPLY_TO_DATE" class="form-control" style="width: 100px;float: left;">
										<input type="hidden" id="APPLY_TO_DATE" name="APPLY_TO_DATE" class="form-control" style="width: 100px;float: left;">
									</div>
								</td>
								<th>실행여부</td>
								<td><select id="SYSTEM_BATCH_YN" name="SYSTEM_BATCH_YN" class="form-control" style="width:110px">
										<option value="Y">Yes</option>
										<option value="N">No</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>스케줄 설명</td>
								<td colspan="3"><textarea id="SCHEDULE_DESC" name="SCHEDULE_DESC" class="form-control" placeholder="Textarea" rows="4"></textarea></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<legend style="margin-bottom: 5px;">실행 주기 정보</legend>
			<div class="dialog-form-group">
				<div class="alert alert-info no-margin fade in">
					<button class="close" data-dismiss="alert" style="top:-7px">
						×
					</button>
					<i class="fa-fw fa fa-info"></i>
					각항목에 <code>*(별표)</code>를 입력할 경우 매월,매일,매시간 등의 반복을 의미합니다. 예시) 1,2,3(1월,2월,3월 실행),  * (매월)
				</div>
				<div class="col-md-12 table-responsive">
					<table class="table table-bordered" style="    margin-bottom: 15px;">
						<thead>
							<tr>
								<th>배치 실행 월</th>
								<th>배치 실행 일</th>
								<th>배치 실행 시간</th>
								<th>배치실행 분</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="text" id="MONTH"   name="MONTH"   class="form-control" style="text-align: center;" placeholder="" ></td>
								<td><input type="text" id="DAY"     name="DAY"     class="form-control" style="text-align: center;" placeholder="" ></td>
								<td><input type="text" id="HOUR"    name="HOUR"    class="form-control" style="text-align: center;" placeholder="" ></td>
								<td><input type="text" id="MINUTES" name="MINUTES" class="form-control" style="text-align: center;" placeholder="" ></td>
							</tr>
							<tr name="SM00101_DAILY_BATCH">
								<th colspan="4">적용기간</th>
							</tr>
							<tr name="SM00101_MONTHLY_BATCH">
								<th colspan="2"><label class="radio" style="padding-left: 25px;padding-top: 0px"><input type="radio" name="EXEC_TYPE" value="1"><i style="border-color: #3276B1;"></i>적용기간</label></th>
								<th colspan="2"><label class="radio" style="padding-left: 25px;padding-top: 0px"><input type="radio" name="EXEC_TYPE" value="2"><i style="border-color: #3276B1;"></i>적용기간 From - To</label></th>
							</tr>
							<tr name="SM00101_DAILY_BATCH">
								<td colspan="4"><span style="float: left;margin-top: 5px;margin-right: 5px;">수행일로부터</span> <input type="text" id="EXEC_DAILY_PERIOD" name="EXEC_DAILY_PERIOD" class="form-control" style="width: 30px;float: left;" maxlength="2"><span style="float: left;margin-top: 5px;">일 전 마감데이터를 인터페이스 합니다.</span></td>
							</tr>
							<tr name="SM00101_MONTHLY_BATCH">
								<td colspan="2"><span style="float: left;margin-top: 5px;margin-right: 5px;">수행일로부터</span> <input type="text" id="EXEC_MONTHLY_PERIOD" name="EXEC_MONTHLY_PERIOD" class="form-control" style="width: 30px;float: left;" maxlength="2"><span style="float: left;margin-top: 5px;">개월 전 마감데이터를 인터페이스 합니다.</span></td>
								<td colspan="2">
									<input type="text" id="EXEC_MANUAL_START_YYYYMM" name="EXEC_MANUAL_START_YYYYMM" class="form-control" style="width: 100px;float: left;"><i class="fa fa-minus pt8" style="float: left;margin: 0 10px;"></i>
									<input type="text" id="EXEC_MANUAL_END_YYYYMM" name="EXEC_MANUAL_END_YYYYMM" class="form-control" style="width: 100px;float: left;"> <span style="float: left;margin-top: 5px;">기간의 마감 데이터를 인터페이스 합니다.</span>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<legend  style="margin-bottom: 5px;">배치수행작업 목록</legend>
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div id="oTui_dialog_schdulerDtl_grid" data-minus-height="200" data-fixed-height="250"></div>
					<div id="oTui_dialog_schdulerDtl_grid_paging"></div>
				</div>
			</div>
		
		</fieldset>
	</form:form>
							
</div> 
<script type="text/javascript">

	
	var SM00101 = new function(){
		
		this.DIALOG_ID = "interfaceSch_Dtl";
		// Page Object Initialize
		this.initialize_Dialog_Object = function() {
			KpackageOBJ.calendar.create("SM00101-detail-form","CAL_APPLY_FROM_DATE");
			KpackageOBJ.calendar.create("SM00101-detail-form","CAL_APPLY_TO_DATE");
			
			SM00101.retrieve_Dialog_formData();
		}

		
		this.initialize_Dialog_TuiGrid = function(){
			var colArrayInfo = [
				{"header" :"실행순서"             ,name:"SCHEDULE_SEQ"  ,width:100   ,align:"center"    ,hidden:false},
				{"header" :"인터페이스명"         ,name:"IF_NAME"                    ,align:"left"      ,hidden:false},
				{"header" :"인터페이스 코드"      ,name:"IF_CODE"       ,width:100   ,align:"center"    ,hidden:false},
				{"header" :"상위인터페이스 코드"  ,name:"IF_PARENT_CODE",width:100   ,align:"center"    ,hidden:false},
				{"header" :"인터페이스 방법"      ,name:"IF_METHOD"     ,width:150   ,align:"center"    ,hidden:false},
				{"header" :"프로시저 명"          ,name:"PROCEDURE_ID"  ,width:250   ,align:"center"    ,hidden:false},
				{"header" :"필수 여부"            ,name:"REQUIRED_YN"   ,width:100   ,align:"center"    ,hidden:false},
				{"header" :"사용여부"             ,name:"USING_YN"      ,width:100   ,align:"center"    ,hidden:false}
				
	    	];
	 
			KpackageOBJ.tuiGrid.create("oTui_dialog_schdulerDtl_grid","/sys/retrieveInterfaceSchMapping", colArrayInfo, null, null, null);
		}
		
		
		this.retrieve_Dialog_formData = function(){
			var params = { "INTERFACE_SCHEDULE_ID" : "${reqParam.INTERFACE_SCHEDULE_ID}"}; 
			KpackageOBJ.ajax.doSubmit("/sys/retrieveInterfaceDetailSch", params, SM00101.formData_Handler);	
		}
		
		this.formData_Handler = function(result){
			if (result.success) { // 성공시			
				var data = result.value[0];
				KpackageOBJ.data.setFormData("SM00101-detail-form", data);
				

				
				KpackageOBJ.calendar.setValue("SM00101-detail-form","CAL_APPLY_FROM_DATE", data["APPLY_FROM_DATE"]);		
				KpackageOBJ.calendar.setValue("SM00101-detail-form","CAL_APPLY_TO_DATE", data["APPLY_TO_DATE"]);
				
				if(data["SCHEDULE_CODE"] == "DAILY_BATCH"){
					$("tr[name='SM00101_DAILY_BATCH']").show();
					$("tr[name='SM00101_MONTHLY_BATCH']").hide();
				
				}else{
					$("tr[name='SM00101_DAILY_BATCH']").hide();
					$("tr[name='SM00101_MONTHLY_BATCH']").show();
				}
				
				/* 하단 그리드 조회 */
				SM00101.retrieve_Dialog_gridData( data["SCHEDULE_CODE"]);
			} else { // 실패시
				$("tr[name='SM00101_DAILY_BATCH']").show();
				$("tr[name='SM00101_MONTHLY_BATCH']").hide();
				KpackageOBJ.object.alert(result.message);
			}
		}
	
		
		
		
		this.retrieve_Dialog_gridData = function(p_Schedule_code){
			if(p_Schedule_code == null || p_Schedule_code == undefined){
				return false;
			}
			KpackageOBJ.tuiGrid.retrieve("oTui_dialog_schdulerDtl_grid", "", {"SCHEDULE_CODE" : p_Schedule_code});
			
			
		}
		
		
		
		
		
		/* Dbl Click Handler */
		this.dbl_Dialog_Handler = function(p_GridId, p_RowKey, p_ColName){
		}
		
		this.update_Dialog_schdulerDtl = function(){
			alert(1);
		}		
	}
	
	$(document).ready(function() {
		SM00101.initialize_Dialog_Object(); 		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		SM00101.initialize_Dialog_TuiGrid();		 
		
		var tools = [{icon:"save", title:"Add" ,text:"저장"	,func:"SM00101.update_Dialog_schdulerDtl"}];
		KpackageOBJ.dialog.setButton(SM00101.DIALOG_ID, tools);
	});

	</script>
</body>
</html>