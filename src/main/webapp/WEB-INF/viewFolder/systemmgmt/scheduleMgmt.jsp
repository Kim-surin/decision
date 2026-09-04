<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head></head>
<body>
	<div class="content-wrapper">
		<div class="row">
			<div class="content-wrapper col-3">
				<h1 class="subheader-title mb-1">스케줄 관리</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item">인터페이스 관리</li>
						<li class="breadcrumb-item active" aria-current="page">스케줄 관리</li>
					</ol>
				</nav>
			</div>
			<div class="row col-9"></div>
		</div>

		<div class="row">
			<div class="col-7"></div>
			<div class="col-5">
				<div class="frame-wrap"><div class="demo" style="text-align: right;">
					<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="SCHEDULE000.restoreScheduleStatus();">상태복원</button>
					<button type="button" class="btn btn-sm btn-primary waves-effect waves-themed" onclick="SCHEDULE000.saveSchedule();">저장</button>
				</div></div>
			</div>
		</div>
		<div class="row"><div class="col-12"><div id="oAuiGrid_SCHEDULE000_01" style="width:100%;height:200px; margin:0 auto;"></div></div></div>

		<div class="row mt-3">
			<div class="col-6">
				<div class="row">
					<div class="col-7"><h6 class="mb-2">스케줄 상세정보</h6></div>
					<div class="col-5"><div class="frame-wrap"><div class="demo" style="text-align: right;">
						<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="SCHEDULE000.initializeDetail();">초기화</button>
					</div></div></div>
				</div>
				<form:form id="SCHEDULE000-detail-form" class="s4-form" novalidate="novalidate" action="" method="post" onsubmit="return false;">
					<input type="hidden" id="save_type" name="save_type" value="I">
					<input type="hidden" id="batch_yyyymm" name="batch_yyyymm">
					<input type="hidden" id="batch_yyyymm_yn" name="batch_yyyymm_yn" value="N">
					<table class="table table-bordered table-sm mb-0">
						<colgroup><col style="width:25%;"><col style="width:75%;"></colgroup>
						<tbody>
							<tr><th class="align-middle">스케줄 코드 <span class="text-danger">*</span></th><td><input type="text" id="schedule_code" name="schedule_code" class="form-control" maxlength="30"></td></tr>
							<tr><th class="align-middle">스케줄 명 <span class="text-danger">*</span></th><td><input type="text" id="schedule_name" name="schedule_name" class="form-control" maxlength="100"></td></tr>
							<tr><th class="align-middle">적용 기간 <span class="text-danger">*</span></th><td><div class="row"><div class="col"><input type="text" id="apply_from_date" name="apply_from_date" class="form-control" maxlength="8" placeholder="YYYYMMDD"></div><div class="col-auto align-self-center">~</div><div class="col"><input type="text" id="apply_to_date" name="apply_to_date" class="form-control" maxlength="8" placeholder="YYYYMMDD"></div></div></td></tr>
							<tr><th class="align-middle">시스템 실행 여부</th><td><select id="system_batch_yn" name="system_batch_yn" class="form-select"><option value="Y">Yes</option><option value="N">No</option></select></td></tr>
							<tr><th class="align-middle">실행 프로그램</th><td><input type="text" id="execution_program" name="execution_program" class="form-control" maxlength="100"></td></tr>
							<tr><th class="align-middle">스케줄 설명 <span class="text-danger">*</span></th><td><textarea id="schedule_desc" name="schedule_desc" class="form-control" rows="2" maxlength="400"></textarea></td></tr>
							<tr><th class="align-middle">실행 기준 (일)</th><td><input type="number" id="exec_daily_period" name="exec_daily_period" class="form-control"></td></tr>
							<tr><th class="align-middle">실행 기준 (월)</th><td>
								<div class="row mb-1"><div class="col-auto"><input type="radio" id="exec_type_1" name="exec_type" value="1"><label class="ms-1" for="exec_type_1">월 (개월)</label></div><div class="col-3"><input type="number" id="exec_monthly_period" name="exec_monthly_period" class="form-control"></div></div>
								<div class="row"><div class="col-auto"><input type="radio" id="exec_type_2" name="exec_type" value="2"><label class="ms-1" for="exec_type_2">기간 (시작월 ~ 종료월)</label></div><div class="col"><input type="text" id="exec_manual_start_yyyymm" name="exec_manual_start_yyyymm" class="form-control" maxlength="6" placeholder="YYYYMM"></div><div class="col-auto align-self-center">~</div><div class="col"><input type="text" id="exec_manual_end_yyyymm" name="exec_manual_end_yyyymm" class="form-control" maxlength="6" placeholder="YYYYMM"></div></div>
							</td></tr>
							<tr><th class="align-middle">실행 주기 (월)</th><td><input type="text" id="month" name="month" class="form-control" maxlength="50" placeholder="*"></td></tr>
							<tr><th class="align-middle">실행 주기 (주)</th><td><input type="text" id="week" name="week" class="form-control" maxlength="50" placeholder="*"></td></tr>
							<tr><th class="align-middle">실행 주기 (일)</th><td><input type="text" id="day" name="day" class="form-control" maxlength="50" placeholder="*"></td></tr>
							<tr><th class="align-middle">실행 주기 (시간)</th><td><input type="text" id="hour" name="hour" class="form-control" maxlength="50"></td></tr>
							<tr><th class="align-middle">실행 주기 (분)</th><td><input type="text" id="minutes" name="minutes" class="form-control" maxlength="50"></td></tr>
						</tbody>
					</table>
				</form:form>
			</div>

			<div class="col-6">
				<div class="row">
					<div class="col-7"><h6 class="mb-2">배치 수행계획</h6></div>
					<div class="col-5"><div class="frame-wrap"><div class="demo" style="text-align: right;">
						<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="SCHEDULE000.addMappingRow();">행 추가</button>
						<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="SCHEDULE000.removeMappingRow();">행 삭제</button>
					</div></div></div>
				</div>
				<div id="oAuiGrid_SCHEDULE000_02" style="width:100%;height:550px; margin:0 auto;"></div>
			</div>
		</div>
	</div>
</body>
<script>
	var SCHEDULE000 = new function() {
		this.grid_SCHEDULE000_01 = null;
		this.grid_SCHEDULE000_02 = null;
		this.interfaceItemList = [];
		this.parentInterfaceItemList = [];

		this.Initialize_viewObject = function() {
			var arrayItem = [
				{value:"SCHEDULE_CODE", name:"스케줄 코드"}
				,{value:"SCHEDULE_NAME", name:"스케줄 명"}
			];
			KpackageOBJ.selectbox.create("SCHEDULE000-search-form", "search_item", "", null, "value", "name", arrayItem);
			SCHEDULE000.createScheduleGrid();
			SCHEDULE000.retrieveInterfaceItemCombo();
			SCHEDULE000.initializeDetail();
			SCHEDULE000.retrieve_GridData();
		}

		this.createScheduleGrid = function() {
			const columnLayout = [
				{ dataField: "schedule_code", headerText: "스케줄 코드", width: 150, filter: { showIcon: true } },
				{ dataField: "schedule_name", headerText: "스케줄 명", width: 180, filter: { showIcon: true } },
				{ dataField: "apply_from_date", headerText: "적용 시작일자", width: 110 },
				{ dataField: "apply_to_date", headerText: "적용 종료일자", width: 110 },
				{ dataField: "month", headerText: "월", width: 90 },
				{ dataField: "day", headerText: "일", width: 90 },
				{ dataField: "hour", headerText: "시간", width: 90 },
				{ dataField: "minutes", headerText: "분", width: 90 },
				{ dataField: "system_batch_yn", headerText: "실행여부", width: 100 },
				{ dataField: "status_name", headerText: "상태", width: 100 }
			];
			const gridProps = { fillColumnSizeMode: true, selectionMode: "singleRow", usePaging: false, enableFilter: true };
			SCHEDULE000.grid_SCHEDULE000_01 = KpackageOBJ.auiGrid.create("oAuiGrid_SCHEDULE000_01", columnLayout, gridProps, "check");
			AUIGrid.bind(SCHEDULE000.grid_SCHEDULE000_01, "cellClick", function(event) {
				SCHEDULE000.retrieveScheduleDetail(event.item.schedule_code);
			});
		}

		this.retrieveInterfaceItemCombo = function() {
			KpackageOBJ.ajax.doSubmit("/system/interface/scheduleMgmt/retrieveInterfaceItemCombo", {}, function(result) {
				SCHEDULE000.interfaceItemList = result.value || [];
				SCHEDULE000.parentInterfaceItemList = [{ code: "", name: "선택 안함" }].concat(SCHEDULE000.interfaceItemList);
				SCHEDULE000.createMappingGrid();
			});
		}

		this.createMappingGrid = function() {
			const columnLayout = [
				{ dataField: "schedule_seq", headerText: "순서", width: 60, editable: false },
				{ dataField: "if_code", headerText: "인터페이스 명", width: 160, renderer: { type: "DropDownListRenderer", list: SCHEDULE000.interfaceItemList, keyField: "code", valueField: "name" } },
				{ dataField: "if_parent_code", headerText: "상위 인터페이스 명", width: 180, renderer: { type: "DropDownListRenderer", list: SCHEDULE000.parentInterfaceItemList, keyField: "code", valueField: "name" } },
				{ dataField: "procedure_id", headerText: "인터페이스 방법", width: 180 },
				{ dataField: "required_yn", headerText: "필수 여부", width: 90, renderer: { type: "DropDownListRenderer", list: ["Y", "N"] } },
				{ dataField: "auto_batch_yn", headerText: "배치 실행 여부", width: 110, renderer: { type: "DropDownListRenderer", list: ["Y", "N"] } }
			];
			const gridProps = { editable: true, selectionMode: "multipleRows", softRemoveRowMode: false };
			SCHEDULE000.grid_SCHEDULE000_02 = KpackageOBJ.auiGrid.create("oAuiGrid_SCHEDULE000_02", columnLayout, gridProps, "check");
		}

		this.retrieve_GridData = function() {
			var params = KpackageOBJ.data.makePostData("SCHEDULE000-search-form");
			KpackageOBJ.auiGrid.retrieve(SCHEDULE000.grid_SCHEDULE000_01, "/system/interface/scheduleMgmt/retrieveScheduleList", params);
		}

		this.retrieveScheduleDetail = function(scheduleCode) {
			KpackageOBJ.ajax.doSubmit("/system/interface/scheduleMgmt/retrieveScheduleDetail", { schedule_code: scheduleCode }, function(result) {
				if (!result.value || !result.value.schedule) { alert("스케줄 정보를 찾을 수 없습니다."); return; }
				SCHEDULE000.clearDetailForm();
				KpackageOBJ.data.setFormData("SCHEDULE000-detail-form", result.value.schedule);
				if (!$("#system_batch_yn").val()) $("#system_batch_yn").val("N");
				if (!$("#batch_yyyymm_yn").val()) $("#batch_yyyymm_yn").val("N");
				AUIGrid.setGridData(SCHEDULE000.grid_SCHEDULE000_02, result.value.mappings || []);
				$("#save_type").val("U");
				$("#schedule_code").prop("readonly", true);
			});
		}

		this.initializeDetail = function() {
			SCHEDULE000.clearDetailForm();
			$("#save_type").val("I");
			$("#system_batch_yn").val("N");
			$("#batch_yyyymm_yn").val("N");
			$("#month, #week, #day").val("*");
			$("#schedule_code").prop("readonly", false).focus();
			if (SCHEDULE000.grid_SCHEDULE000_02) AUIGrid.setGridData(SCHEDULE000.grid_SCHEDULE000_02, []);
		}

		this.clearDetailForm = function() {
			var form = document.getElementById("SCHEDULE000-detail-form");
			if (form) form.reset();
		}

		this.addMappingRow = function() {
			AUIGrid.addRow(SCHEDULE000.grid_SCHEDULE000_02, { required_yn: "N", auto_batch_yn: "Y" }, "last");
		}

		this.removeMappingRow = function() {
			var checkedArray = KpackageOBJ.auiGrid.getCheckedRowItems(SCHEDULE000.grid_SCHEDULE000_02);
			if (!checkedArray || checkedArray.length < 1) { alert("선택된 데이터가 없습니다."); return; }
			checkedArray.sort(function(a, b) { return b.rowIndex - a.rowIndex; });
			for (var i = 0; i < checkedArray.length; i++) AUIGrid.removeRow(SCHEDULE000.grid_SCHEDULE000_02, checkedArray[i].rowIndex);
		}

		this.saveSchedule = function() {
			if (!SCHEDULE000.validateForm()) return;
			var params = KpackageOBJ.data.makePostData("SCHEDULE000-detail-form");
			params.system_batch_yn = params.system_batch_yn || "N";
			params.batch_yyyymm_yn = params.batch_yyyymm_yn || "N";
			params.mappings = AUIGrid.getGridData(SCHEDULE000.grid_SCHEDULE000_02);
			KpackageOBJ.ajax.doSubmit("/system/interface/scheduleMgmt/saveSchedule", params, function(result) {
				alert(result.message);
				if (!result.success) return;
				$("#save_type").val("U");
				$("#schedule_code").prop("readonly", true);
				SCHEDULE000.retrieve_GridData();
				SCHEDULE000.retrieveScheduleDetail(result.value.schedule_code);
			});
		}

		this.restoreScheduleStatus = function() {
			var item = SCHEDULE000.getSingleCheckedItem();
			if (!item || !confirm("선택한 스케줄 상태를 대기로 복원하시겠습니까?")) return;
			KpackageOBJ.ajax.doSubmit("/system/interface/scheduleMgmt/restoreScheduleStatus", { schedule_code: item.schedule_code }, function(result) {
				alert(result.message);
				if (result.success) SCHEDULE000.retrieve_GridData();
			});
		}

		this.getSingleCheckedItem = function() {
			var checkedArray = KpackageOBJ.auiGrid.getCheckedRowItems(SCHEDULE000.grid_SCHEDULE000_01);
			if (!checkedArray || checkedArray.length < 1) { alert("선택된 데이터가 없습니다."); return null; }
			if (checkedArray.length > 1) { alert("한개의 데이터만 선택할 수 있습니다."); return null; }
			return checkedArray[0].item ? checkedArray[0].item : checkedArray[0];
		}

		this.validateForm = function() {
			if (!$.trim($("#schedule_code").val())) { alert("스케줄 코드를 입력해 주세요."); $("#schedule_code").focus(); return false; }
			if (!$.trim($("#schedule_name").val())) { alert("스케줄 명을 입력해 주세요."); $("#schedule_name").focus(); return false; }
			if (!/^\d{8}$/.test($.trim($("#apply_from_date").val()))) { alert("적용 시작일을 YYYYMMDD 형식으로 입력해 주세요."); $("#apply_from_date").focus(); return false; }
			if ($.trim($("#apply_to_date").val()) && !/^\d{8}$/.test($.trim($("#apply_to_date").val()))) { alert("적용 종료일을 YYYYMMDD 형식으로 입력해 주세요."); $("#apply_to_date").focus(); return false; }
			if (!$.trim($("#schedule_desc").val())) { alert("스케줄 설명을 입력해 주세요."); $("#schedule_desc").focus(); return false; }
			var rows = AUIGrid.getGridData(SCHEDULE000.grid_SCHEDULE000_02);
			for (var i = 0; i < rows.length; i++) {
				if (!$.trim(rows[i].if_code || "")) { alert((i + 1) + "번째 인터페이스를 선택해 주세요."); return false; }
			}
			return true;
		}
	};

	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		SCHEDULE000.Initialize_viewObject();
	});
</script>
</html>
