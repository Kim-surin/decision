<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head></head>
<body>
	<div class="content-wrapper">
		<form:form id="SCHEDULE001-form" class="s4-form" novalidate="novalidate" action="" method="post" onsubmit="return false;">
			<input type="hidden" id="save_type" name="save_type" value="I">
			<div id="panel-4" class="panel panel-icon">
				<div class="panel-container show">
					<div class="panel-content">
						<h6 class="mb-3">기본정보</h6>
						<div class="row">
							<div class="mb-3 col-4">
								<label class="form-label" for="schedule_code">스케줄 코드 <span class="text-danger">*</span></label>
								<input type="text" id="schedule_code" name="schedule_code" value="${schedule_code}" class="form-control" maxlength="30">
							</div>
							<div class="mb-3 col-4">
								<label class="form-label" for="schedule_name">스케줄 명 <span class="text-danger">*</span></label>
								<input type="text" id="schedule_name" name="schedule_name" class="form-control" maxlength="100">
							</div>
							<div class="mb-3 col-4">
								<label class="form-label" for="system_batch_yn">시스템 실행 여부</label>
								<select id="system_batch_yn" name="system_batch_yn" class="form-select">
									<option value="N">아니오</option><option value="Y">예</option>
								</select>
							</div>
							<div class="mb-3 col-4">
								<label class="form-label" for="execution_program">프로그램 명</label>
								<input type="text" id="execution_program" name="execution_program" class="form-control" maxlength="100">
							</div>
							<div class="mb-3 col-4">
								<label class="form-label" for="apply_from_date">적용 시작일 <span class="text-danger">*</span></label>
								<input type="text" id="apply_from_date" name="apply_from_date" class="form-control" maxlength="8" placeholder="YYYYMMDD">
							</div>
							<div class="mb-3 col-4">
								<label class="form-label" for="apply_to_date">적용 종료일</label>
								<input type="text" id="apply_to_date" name="apply_to_date" class="form-control" maxlength="8" placeholder="YYYYMMDD">
							</div>
							<div class="mb-3 col-12">
								<label class="form-label" for="schedule_desc">스케줄 설명 <span class="text-danger">*</span></label>
								<textarea id="schedule_desc" name="schedule_desc" class="form-control" rows="3" maxlength="400"></textarea>
							</div>
						</div>
						<hr>
						<h6 class="mb-3">실행 주기 정보</h6>
						<div class="row">
							<div class="mb-3 col-2"><label class="form-label" for="exec_daily_period">실행 기준일</label><input type="number" id="exec_daily_period" name="exec_daily_period" class="form-control"></div>
							<div class="mb-3 col-2"><label class="form-label" for="month">월 단위</label><input type="text" id="month" name="month" class="form-control" maxlength="50" placeholder="*"></div>
							<div class="mb-3 col-2"><label class="form-label" for="week">주 단위</label><input type="text" id="week" name="week" class="form-control" maxlength="50" placeholder="*"></div>
							<div class="mb-3 col-2"><label class="form-label" for="day">일 단위</label><input type="text" id="day" name="day" class="form-control" maxlength="50" placeholder="*"></div>
							<div class="mb-3 col-2"><label class="form-label" for="hour">시간 단위</label><input type="text" id="hour" name="hour" class="form-control" maxlength="50"></div>
							<div class="mb-3 col-2"><label class="form-label" for="minutes">분 단위</label><input type="text" id="minutes" name="minutes" class="form-control" maxlength="50"></div>
						</div>
						<input type="hidden" id="batch_yyyymm" name="batch_yyyymm">
						<input type="hidden" id="batch_yyyymm_yn" name="batch_yyyymm_yn" value="N">
						<input type="hidden" id="exec_type" name="exec_type">
						<input type="hidden" id="exec_manual_start_yyyymm" name="exec_manual_start_yyyymm">
						<input type="hidden" id="exec_manual_end_yyyymm" name="exec_manual_end_yyyymm">
						<input type="hidden" id="exec_monthly_period" name="exec_monthly_period">
					</div>
				</div>
			</div>
		</form:form>
		<div class="row">
			<div class="col-7"><h6 class="mb-3">배치 수행계획</h6></div>
			<div class="col-5">
				<div class="frame-wrap">
					<div class="demo" style="text-align: right;">
						<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="SCHEDULE001.addMappingRow();">행 추가</button>
						<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="SCHEDULE001.removeMappingRow();">행 삭제</button>
						<button type="button" class="btn btn-sm btn-primary waves-effect waves-themed" onclick="SCHEDULE001.saveSchedule();">저장</button>
					</div>
				</div>
			</div>
		</div>
		<div class="row"><div class="col-12">
			<div id="oAuiGrid_SCHEDULE001_01" style="width:100%;height:280px; margin:0 auto;"></div>
		</div></div>
	</div>
</body>
<script>
	var SCHEDULE001 = new function() {
		this.grid_SCHEDULE001_01 = null;
		this.scheduleCode = $("#schedule_code").val();
		this.interfaceItemList = [];
		this.parentInterfaceItemList = [];

		this.Initialize_viewObject = function() {
			SCHEDULE001.retrieveInterfaceItemCombo();
		}

		this.retrieveInterfaceItemCombo = function() {
			KpackageOBJ.ajax.doSubmit("/system/interface/scheduleMgmt/retrieveInterfaceItemCombo", {}, function(result) {
				SCHEDULE001.interfaceItemList = result.value || [];
				SCHEDULE001.parentInterfaceItemList = [{ code: "", name: "선택 안함" }]
					.concat(SCHEDULE001.interfaceItemList);
				SCHEDULE001.createAUIGrid();
				if (SCHEDULE001.scheduleCode) SCHEDULE001.retrieveScheduleDetail();
				else { $("#system_batch_yn").val("N"); $("#batch_yyyymm_yn").val("N"); }
			});
		}

		this.createAUIGrid = function() {
			const columnLayout = [
				{ dataField: "schedule_seq",    headerText: "순서",               width: 70,  editable: false },
				{ dataField: "if_code",         headerText: "인터페이스 코드",    width: 200,
					renderer: { type: "DropDownListRenderer", list: SCHEDULE001.interfaceItemList,
						keyField: "code", valueField: "name" } },
				{ dataField: "if_parent_code",  headerText: "상위 인터페이스 코드", width: 220,
					renderer: { type: "DropDownListRenderer", list: SCHEDULE001.parentInterfaceItemList,
						keyField: "code", valueField: "name" } },
				{ dataField: "procedure_id",     headerText: "프로시저명",         width: 240 },
				{ dataField: "required_yn",      headerText: "필수 여부",          width: 100, renderer: { type: "DropDownListRenderer", list: ["Y", "N"] } },
				{ dataField: "auto_batch_yn",    headerText: "자동 배치 여부",     width: 120, renderer: { type: "DropDownListRenderer", list: ["Y", "N"] } }
			];
			const gridProps = {
				    editable: true,
				    selectionMode: "multipleRows",
				    fillColumnSizeMode: true,
				    softRemoveRowMode: false
				};
			SCHEDULE001.grid_SCHEDULE001_01 = KpackageOBJ.auiGrid.create(
				"oAuiGrid_SCHEDULE001_01", columnLayout, gridProps, "check");
		}

		this.retrieveScheduleDetail = function() {
			KpackageOBJ.ajax.doSubmit("/system/interface/scheduleMgmt/retrieveScheduleDetail",
				{ schedule_code: SCHEDULE001.scheduleCode }, function(result) {
					if (!result.value || !result.value.schedule) { alert("스케줄 정보를 찾을 수 없습니다."); return; }
					KpackageOBJ.data.setFormData("SCHEDULE001-form", result.value.schedule);
					// DB의 기존 값이 NULL인 경우 hidden/select 기본값이 빈 값으로 변경되지 않도록 보정한다.
					if (!$("#system_batch_yn").val()) $("#system_batch_yn").val("N");
					if (!$("#batch_yyyymm_yn").val()) $("#batch_yyyymm_yn").val("N");
					AUIGrid.setGridData(SCHEDULE001.grid_SCHEDULE001_01, result.value.mappings || []);
					$("#save_type").val("U");
					$("#schedule_code").prop("readonly", true);
				});
		}

		this.addMappingRow = function() {
			AUIGrid.addRow(SCHEDULE001.grid_SCHEDULE001_01, { required_yn: "N", auto_batch_yn: "Y" }, "last");
		}
		this.removeMappingRow = function() {
			var checkedArray = KpackageOBJ.auiGrid.getCheckedRowItems(SCHEDULE001.grid_SCHEDULE001_01);
			if (!checkedArray || checkedArray.length < 1) { alert("선택된 데이터가 없습니다."); return; }

			// removeCheckedRows() 사용 시 삭제 행이 변경 데이터에 남는 버전이 있어
			// 실제 rowIndex를 역순으로 제거하여 getGridData()에서 완전히 제외한다.
			checkedArray.sort(function(a, b) { return b.rowIndex - a.rowIndex; });
			for (var i = 0; i < checkedArray.length; i++) {
				AUIGrid.removeRow(SCHEDULE001.grid_SCHEDULE001_01, checkedArray[i].rowIndex);
			}
		}

		this.saveSchedule = function() {
			if (!SCHEDULE001.validateForm()) return;
			var params = KpackageOBJ.data.makePostData("SCHEDULE001-form");
			params.system_batch_yn = params.system_batch_yn || "N";
			params.batch_yyyymm_yn = params.batch_yyyymm_yn || "N";
			// 현재 Grid에 남아 있는 행만 전송한다. 삭제된 행은 서버에서 재등록되지 않는다.
			params.mappings = AUIGrid.getGridData(SCHEDULE001.grid_SCHEDULE001_01).filter(function(row) {
				return row && row._$isRemoved !== true && row._$isDeleted !== true;
			});
			KpackageOBJ.ajax.doSubmit("/system/interface/scheduleMgmt/saveSchedule", params, function(result) {
				alert(result.message);
				if (!result.success) return;
				SCHEDULE001.scheduleCode = result.value.schedule_code;
				$("#save_type").val("U");
				$("#schedule_code").prop("readonly", true);
				if (parent.SCHEDULE000) parent.SCHEDULE000.retrieve_GridData();
				// 저장 후 DB 데이터를 다시 조회하여 삭제 및 순서 반영 결과를 확인한다.
				SCHEDULE001.retrieveScheduleDetail();
			});
		}

		this.validateForm = function() {
			if (!$.trim($("#schedule_code").val())) { alert("스케줄 코드를 입력해 주세요."); $("#schedule_code").focus(); return false; }
			if (!$.trim($("#schedule_name").val())) { alert("스케줄 명을 입력해 주세요."); $("#schedule_name").focus(); return false; }
			if (!/^\d{8}$/.test($.trim($("#apply_from_date").val()))) { alert("적용 시작일을 YYYYMMDD 형식으로 입력해 주세요."); return false; }
			if (!$.trim($("#schedule_desc").val())) { alert("스케줄 설명을 입력해 주세요."); $("#schedule_desc").focus(); return false; }
			var rows = AUIGrid.getGridData(SCHEDULE001.grid_SCHEDULE001_01);
			for (var i = 0; i < rows.length; i++) {
				if (!$.trim(rows[i].if_code || "")) { alert((i + 1) + "번째 인터페이스 코드를 입력해 주세요."); return false; }
			}
			return true;
		}
	};

	$(document).ready(function() {
		pageSetUp();
		SCHEDULE001.Initialize_viewObject();
	});
</script>
</html>
