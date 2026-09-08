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
				<h1 class="subheader-title mb-1">인터페이스 수동 실행</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item">시스템관리</li>
						<li class="breadcrumb-item">인터페이스 관리</li>
						<li class="breadcrumb-item active" aria-current="page">수동 실행</li>
					</ol>
				</nav>
			</div>
			<div class="row col-9"></div>
		</div>

		<!-- 인터페이스 수동 실행 -->
		<div class="row">
			<form:form id="IFMANUAL000-form-01" class="s4-form" novalidate="novalidate" action="" method="post" onsubmit="return false;">
				<div id="panel-4" class="panel panel-icon">
					<div class="panel-container show">
						<div class="panel-content">
							<div class="row">
								<div class="col-3">
									<label class="form-label" for="schedule_code">배치 명</label>
									<select id="schedule_code" name="schedule_code" class="form-select" onchange="IFMANUAL000.retrieveInterfaceCombo();"></select>
								</div>
								<div class="col-3">
									<label class="form-label" for="if_code">인터페이스 명</label>
									<select id="if_code" name="if_code" class="form-select"></select>
								</div>
								<div class="col-4">
									<label class="form-label">기준일자</label>
									<div class="row">
										<div class="col"><input type="text" id="from_date" name="from_date" class="form-control" maxlength="8" placeholder="YYYYMMDD"></div>
										<div class="col"><input type="text" id="to_date" name="to_date" class="form-control" maxlength="8" placeholder="YYYYMMDD"></div>
									</div>
								</div>
								<div class="col"></div>
								<div class="col-1">
									<button type="button" onclick="javascript:IFMANUAL000.executeInterface();"
											class="btn btn-sm btn-primary waves-effect waves-themed mt-2">요청</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form:form>
		</div>

		<!-- 수행결과 조회 -->
		<div class="row">
			<form:form id="IFMANUAL000-form-02" class="s4-form" novalidate="novalidate" action="" method="post" onsubmit="return false;">
				<div id="panel-5" class="panel panel-icon">
					<div class="panel-container show">
						<div class="panel-content">
							<div class="row">
								<div class="col-3">
									<label class="form-label">기준 일자</label>
									<div class="row">
										<div class="col"><input type="text" id="search_from_date" name="search_from_date" class="form-control" maxlength="8" placeholder="YYYYMMDD"></div>
										<div class="col"><input type="text" id="search_to_date" name="search_to_date" class="form-control" maxlength="8" placeholder="YYYYMMDD"></div>
									</div>
								</div>
								<div class="col-5">
									<div class="row"><label class="form-label" for="search_type">조회조건</label></div>
									<div class="row mb-3">
										<div class="col-4"><select class="form-select" id="search_type" name="search_type"></select></div>
										<div class="col"><input type="text" id="search_keyword" name="search_keyword" class="form-control"
												onkeydown="if(event.keyCode===13){IFMANUAL000.retrieveResultList();}"></div>
									</div>
								</div>
								<div class="col"></div>
								<div class="col-1">
									<button type="button" onclick="javascript:IFMANUAL000.retrieveResultList();"
											class="btn btn-sm btn-search search-no-more waves-effect waves-themed mt-2">Search</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form:form>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="panel-tag">인터페이스 결과</div>
				<div id="oAuiGrid_IFMANUAL000_01" style="width:100%;height:260px; margin:0 auto;"></div>
			</div>
		</div>

		<div class="row mt-3">
			<form:form id="IFMANUAL000-form-03" class="s4-form" novalidate="novalidate" action="" method="post" onsubmit="return false;">
				<input type="hidden" id="intg_interface_trans_id" name="intg_interface_trans_id">
				<input type="hidden" id="detail_if_code" name="if_code">
				<div id="panel-6" class="panel panel-icon">
					<div class="panel-container show">
						<div class="panel-content">
							<div class="row">
								<div class="col-2">
									<label class="form-label" for="error_yn">오류 여부</label>
									<select id="error_yn" name="error_yn" class="form-select" onchange="IFMANUAL000.retrieveExecutionDetail();">
										<option value="">전체</option><option value="Y">오류</option><option value="N">정상</option>
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form:form>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="panel-tag">인터페이스 이력</div>
				<div id="oAuiGrid_IFMANUAL000_02" style="width:100%;height:400px; margin:0 auto;"></div>
			</div>
		</div>
	</div>
</body>
<script>
	var IFMANUAL000 = new function() {

		this.grid_IFMANUAL000_01 = null;
		this.grid_IFMANUAL000_02 = null;

		// 시작점
		this.Initialize_viewObject = function() {
			var searchItems = [
				{value:"IF_CODE", name:"인터페이스 코드"}
				,{value:"IF_NAME", name:"인터페이스 명"}
			];
			KpackageOBJ.selectbox.create("IFMANUAL000-form-02", "search_type", "", null, "value", "name", searchItems);
			IFMANUAL000.setDefaultDate();
			IFMANUAL000.createResultGrid();
			IFMANUAL000.createDetailGrid([]);
			IFMANUAL000.retrieveScheduleCombo();
			IFMANUAL000.retrieveResultList();
		}

		this.formatDate = function(date) {
			var month = String(date.getMonth() + 1).padStart(2, "0");
			var day = String(date.getDate()).padStart(2, "0");
			return date.getFullYear() + month + day;
		}

		this.setDefaultDate = function() {
			var toDate = new Date();
			var fromDate = new Date();
			fromDate.setDate(toDate.getDate() - 10);
			$("#from_date, #to_date").val(IFMANUAL000.formatDate(toDate));
			$("#search_from_date").val(IFMANUAL000.formatDate(fromDate));
			$("#search_to_date").val(IFMANUAL000.formatDate(toDate));
		}

		this.createResultGrid = function() {
			const columnLayout = [
				{ dataField: "if_code",           headerText: "인터페이스 코드", width: 140 },
				{ dataField: "if_name",           headerText: "인터페이스명",    width: 180 },
				{ dataField: "total_rows",        headerText: "수취건수",        width: 100, dataType: "numeric" },
				{ dataField: "start_time",        headerText: "시작시간",        width: 180 },
				{ dataField: "trans_date",        headerText: "종료시간",        width: 180 },
				{ dataField: "trans_status_name", headerText: "상태",            width: 100 },
				{ dataField: "if_param",          headerText: "요청파라메터",    width: 400 },
				{ dataField: "error_message",     headerText: "오류내용",        width: 350 }
			];
			const gridProps = { usePaging: true, pageRowCount: 50, showPageRowSelect: true, enableFilter: true };
			IFMANUAL000.grid_IFMANUAL000_01 = KpackageOBJ.auiGrid.create("oAuiGrid_IFMANUAL000_01", columnLayout, gridProps, "number");
			AUIGrid.bind(IFMANUAL000.grid_IFMANUAL000_01, "cellClick", function(event) {
				$("#intg_interface_trans_id").val(event.item.intg_interface_trans_id);
				$("#detail_if_code").val(event.item.if_code);
				IFMANUAL000.retrieveExecutionDetail();
			});
		}

		this.createDetailGrid = function(dynamicColumns) {
			if (IFMANUAL000.grid_IFMANUAL000_02) AUIGrid.destroy(IFMANUAL000.grid_IFMANUAL000_02);
			var columnLayout = [
				{ dataField: "current_row",   headerText: "ROW",        width: 80, dataType: "numeric" },
				{ dataField: "error_yn",      headerText: "오류 여부",  width: 90 },
				{ dataField: "error_message", headerText: "오류 메시지", width: 250 }
			];
			(dynamicColumns || []).forEach(function(column) {
				columnLayout.push({ dataField: column.data_field, headerText: column.header_text, width: 160, filter: { showIcon: true } });
			});
			const gridProps = { usePaging: true, pageRowCount: 100, showPageRowSelect: true, enableFilter: true };
			IFMANUAL000.grid_IFMANUAL000_02 = KpackageOBJ.auiGrid.create("oAuiGrid_IFMANUAL000_02", columnLayout, gridProps, "number");
		}

		this.retrieveScheduleCombo = function() {
			KpackageOBJ.ajax.doSubmit("/system/interface/manualExecution/retrieveScheduleCombo", {}, function(result) {
				KpackageOBJ.selectbox.create("IFMANUAL000-form-01", "schedule_code", "", null, "value", "name", result.value || []);
				IFMANUAL000.retrieveInterfaceCombo();
			});
		}

		this.retrieveInterfaceCombo = function() {
			var params = {schedule_code: $("#schedule_code").val()};
			KpackageOBJ.ajax.doSubmit("/system/interface/manualExecution/retrieveInterfaceCombo", params, function(result) {
				KpackageOBJ.selectbox.create("IFMANUAL000-form-01", "if_code", "", null, "value", "name", result.value || []);
			});
		}

		this.executeInterface = function() {
			if (!$("#schedule_code").val() || !$("#if_code").val()) {
				alert("배치 명과 인터페이스 명을 선택해 주세요.");
				return;
			}
			if (!confirm("선택한 인터페이스를 수동으로 실행하시겠습니까?")) return;
			var params = KpackageOBJ.data.makePostData("IFMANUAL000-form-01");
			KpackageOBJ.ajax.doSubmit("/system/interface/manualExecution/executeInterface", params, function(result) {
				if (result.success) {
					alert("실행을 요청했습니다.");
					IFMANUAL000.retrieveResultList();
				} else alert(result.message);
			});
		}

		this.retrieveResultList = function() {
			var params = KpackageOBJ.data.makePostData("IFMANUAL000-form-02");
			KpackageOBJ.auiGrid.retrieve(IFMANUAL000.grid_IFMANUAL000_01,
					"/system/interface/manualExecution/retrieveExecutionResultList", params);
		}

		this.retrieveExecutionDetail = function() {
			if (!$("#intg_interface_trans_id").val()) return;
			var params = KpackageOBJ.data.makePostData("IFMANUAL000-form-03");
			KpackageOBJ.ajax.doSubmit("/system/interface/manualExecution/retrieveExecutionDetail", params, function(result) {
				var value = result.value || {};
				IFMANUAL000.createDetailGrid(value.columns || []);
				AUIGrid.setGridData(IFMANUAL000.grid_IFMANUAL000_02, value.rows || []);
			});
		}
	};

	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		IFMANUAL000.Initialize_viewObject();
	});
</script>
</html>
