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
				<h1 class="subheader-title mb-1">인터페이스 현황</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item">시스템관리</li>
						<li class="breadcrumb-item">인터페이스 관리</li>
						<li class="breadcrumb-item active" aria-current="page">인터페이스 현황</li>
					</ol>
				</nav>
			</div>
			<div class="row col-9"></div>
		</div>

		<div class="row">
			<div class="col-12">
				<ul class="nav nav-tabs" role="tablist">
					<li class="nav-item">
						<button id="status_tab_01" class="nav-link active" type="button"
								onclick="IFSTATUS000.changeTab(1);">이관 스케줄</button>
					</li>
					<li class="nav-item">
						<button id="status_tab_02" class="nav-link" type="button"
								onclick="IFSTATUS000.changeTab(2);">이관 완료 및 에러</button>
					</li>
					<li class="nav-item">
						<button id="status_tab_03" class="nav-link" type="button"
								onclick="IFSTATUS000.changeTab(3);">이관에러 및 에러 상세항목</button>
					</li>
				</ul>
			</div>
		</div>

		<!-- TAB 1. 이관 스케줄 -->
		<div id="status_tab_wrap_01">
			<div class="row">
				<form:form id="IFSTATUS000-form-01" class="s4-form" novalidate="novalidate" action="" method="post" onsubmit="return false;">
					<div id="panel-4" class="panel panel-icon">
						<div class="panel-container show">
							<div class="panel-content">
								<div class="row">
									<div class="col-lg-5">
										<div class="row"><label class="form-label" for="schedule_search_item">조회조건</label></div>
										<div class="row mb-3">
											<div class="col-4"><select class="form-select" id="schedule_search_item" name="search_type"></select></div>
											<div class="col">
												<input type="text" id="schedule_search_keyword" name="search_keyword" class="form-control"
														placeholder="키워드 입력" onkeydown="if(event.keyCode===13){IFSTATUS000.retrieveScheduleList();}">
											</div>
										</div>
									</div>
									<div class="col"></div>
									<div class="col-1">
										<button type="button" onclick="javascript:IFSTATUS000.retrieveScheduleList();"
												class="btn btn-sm btn-search search-no-more waves-effect waves-themed mt-2">Search</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form:form>
			</div>
			<div class="row"><div class="col-12"><div id="oAuiGrid_IFSTATUS000_01" style="width:100%;height:600px; margin:0 auto;"></div></div></div>
		</div>

		<!-- TAB 2. 이관 완료 및 에러 -->
		<div id="status_tab_wrap_02" style="display: none;">
			<div class="row">
				<form:form id="IFSTATUS000-form-02" class="s4-form" novalidate="novalidate" action="" method="post" onsubmit="return false;">
					<input type="hidden" id="selected_schedule_code" name="schedule_code">
					<div id="panel-5" class="panel panel-icon">
						<div class="panel-container show">
							<div class="panel-content">
								<div class="row">
									<div class="col-3"><label class="form-label">생성일자</label>
										<div class="row">
											<div class="col"><input type="text" id="from_date" name="from_date" class="form-control" maxlength="8" placeholder="YYYYMMDD"></div>
											<div class="col"><input type="text" id="to_date" name="to_date" class="form-control" maxlength="8" placeholder="YYYYMMDD"></div>
										</div>
									</div>
									<div class="col-2">
										<label class="form-label" for="trans_status">상태</label>
										<select id="trans_status" name="trans_status" class="form-select">
											<option value="">전체</option>
											<option value="0">진행중</option>
											<option value="1">성공</option>
											<option value="2">에러</option>
										</select>
									</div>
									<div class="col-4">
										<div class="row"><label class="form-label" for="transfer_search_item">검색조건</label></div>
										<div class="row mb-3">
										<div class="col-4"><select class="form-select" id="transfer_search_item" name="search_type"></select></div>
											<div class="col">
												<input type="text" id="transfer_search_keyword" name="search_keyword" class="form-control"
														onkeydown="if(event.keyCode===13){IFSTATUS000.retrieveTransferList();}">
											</div>
										</div>
									</div>
									<div class="col"></div>
									<div class="col-1">
										<button type="button" onclick="javascript:IFSTATUS000.retrieveTransferList();"
												class="btn btn-sm btn-search search-no-more waves-effect waves-themed mt-2">Search</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form:form>
			</div>
			<div class="row"><div class="col-12"><div id="oAuiGrid_IFSTATUS000_02" style="width:100%;height:600px; margin:0 auto;"></div></div></div>
		</div>

		<!-- TAB 3. 이관에러 및 에러 상세항목 -->
		<div id="status_tab_wrap_03" style="display: none;">
			<div class="row">
				<form:form id="IFSTATUS000-form-03" class="s4-form" novalidate="novalidate" action="" method="post" onsubmit="return false;">
					<input type="hidden" id="selected_trans_id" name="intg_interface_trans_id">
					<input type="hidden" id="selected_if_code" name="if_code">
					<div id="panel-6" class="panel panel-icon">
						<div class="panel-container show">
							<div class="panel-content">
								<div class="row">
									<div class="col-2">
										<div class="row"><label class="form-label" for="detail_error_yn">오류 여부</label></div>
										<div class="row mb-3">
											<select id="detail_error_yn" name="error_yn" class="form-select">
												<option value="">전체</option>
												<option value="Y">오류</option>
												<option value="N">정상</option>
											</select>
										</div>
									</div>
									<div class="col"></div>
									<div class="col-1">
										<button type="button" onclick="javascript:IFSTATUS000.retrieveTransferDetail();"
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
					<div class="frame-wrap">
						<div class="demo" style="text-align: right;">
							<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed"
									onclick="IFSTATUS000.downloadDetailExcel();">엑셀다운로드</button>
						</div>
					</div>
				</div>
			</div>			
			<div class="row"><div class="col-12"><div id="oAuiGrid_IFSTATUS000_03" style="width:100%;height:600px; margin:0 auto;"></div></div></div>
		</div>
	</div>
</body>
<script>
	var IFSTATUS000 = new function() {

		this.grid_IFSTATUS000_01 = null;
		this.grid_IFSTATUS000_02 = null;
		this.grid_IFSTATUS000_03 = null;
		this.activeTab = 1;

		// 시작점
		this.Initialize_viewObject = function() {
			var scheduleSearchItems = [
				{value:"SCHEDULE_CODE", name:"스케줄 코드"}
				,{value:"SCHEDULE_NAME", name:"스케줄 명"}
			];
			var transferSearchItems = [
				{value:"IF_CODE", name:"인터페이스 코드"}
				,{value:"IF_NAME", name:"인터페이스 명"}
				,{value:"INTERFACE_ID", name:"Interface ID"}
			];
			KpackageOBJ.selectbox.create("IFSTATUS000-form-01", "schedule_search_item", "", null, "value", "name", scheduleSearchItems);
			KpackageOBJ.selectbox.create("IFSTATUS000-form-02", "transfer_search_item", "", null, "value", "name", transferSearchItems);

			IFSTATUS000.setDefaultDate();
			IFSTATUS000.createScheduleGrid();
			IFSTATUS000.createTransferGrid();
			IFSTATUS000.createTransferDetailGrid([]);
			IFSTATUS000.retrieveScheduleList();
		}

		this.setDefaultDate = function() {
			var toDate = new Date();
			var fromDate = new Date();
			fromDate.setDate(toDate.getDate() - 10);
			$("#from_date").val(IFSTATUS000.formatDate(fromDate));
			$("#to_date").val(IFSTATUS000.formatDate(toDate));
		}

		this.formatDate = function(date) {
			var month = String(date.getMonth() + 1).padStart(2, "0");
			var day = String(date.getDate()).padStart(2, "0");
			return date.getFullYear() + month + day;
		}

		this.createScheduleGrid = function() {
			const columnLayout = [
				{ dataField: "schedule_code",      headerText: "스케줄 코드", width: 180, filter: { showIcon: true } },
				{ dataField: "schedule_name",      headerText: "스케줄 명",   width: 230, filter: { showIcon: true } },
				{ dataField: "apply_from_date",    headerText: "적용일자",    width: 130 },
				{ dataField: "apply_to_date",      headerText: "만료일자",    width: 130 },
				{ dataField: "last_execution_date",headerText: "최근실행일자", width: 180 },
				{ dataField: "status_name",        headerText: "상태",        width: 100 }
			];
			const gridProps = { fillColumnSizeMode: true, usePaging: true, pageRowCount: 50, showPageRowSelect: true, enableFilter: true };
			IFSTATUS000.grid_IFSTATUS000_01 = KpackageOBJ.auiGrid.create("oAuiGrid_IFSTATUS000_01", columnLayout, gridProps, "number");
			AUIGrid.bind(IFSTATUS000.grid_IFSTATUS000_01, "cellDoubleClick", function(event) {
				$("#selected_schedule_code").val(event.item.schedule_code);
				IFSTATUS000.changeTab(2);
				IFSTATUS000.retrieveTransferList();
			});
		}

		this.createTransferGrid = function() {
			const columnLayout = [
				{ dataField: "if_code",          headerText: "인터페이스 코드", width: 140, filter: { showIcon: true } },
				{ dataField: "if_name",          headerText: "인터페이스 항목", width: 200, filter: { showIcon: true } },
				{ dataField: "total_rows",       headerText: "총합",            width: 100, dataType: "numeric", style: "aui-right" },
				{ dataField: "start_time",       headerText: "시작일자",        width: 180 },
				{ dataField: "trans_date",       headerText: "종료일자",        width: 180 },
				{ dataField: "trans_status_name",headerText: "이관상태",        width: 100 },
				{ dataField: "batch_status_name",headerText: "배치상태",        width: 100 },
				{ dataField: "error_yn",         headerText: "오류여부",        width: 90 },
				{ dataField: "if_param",         headerText: "요청정보",        width: 300 },
				{ dataField: "error_message",    headerText: "오류 메시지",     width: 300 }
			];
			const gridProps = { usePaging: true, pageRowCount: 50, showPageRowSelect: true, enableFilter: true };
			IFSTATUS000.grid_IFSTATUS000_02 = KpackageOBJ.auiGrid.create("oAuiGrid_IFSTATUS000_02", columnLayout, gridProps, "number");
			AUIGrid.bind(IFSTATUS000.grid_IFSTATUS000_02, "cellDoubleClick", function(event) {
				$("#selected_trans_id").val(event.item.intg_interface_trans_id);
				$("#selected_if_code").val(event.item.if_code);
				IFSTATUS000.changeTab(3);
				IFSTATUS000.retrieveTransferDetail();
			});
		}

		this.createTransferDetailGrid = function(dynamicColumns) {
			if (IFSTATUS000.grid_IFSTATUS000_03) AUIGrid.destroy(IFSTATUS000.grid_IFSTATUS000_03);
			var columnLayout = [
				{ dataField: "current_row",   headerText: "ROW",       width: 80, dataType: "numeric" },
				{ dataField: "error_yn",      headerText: "오류 여부", width: 90 },
				{ dataField: "error_message", headerText: "오류 메시지",width: 250 }
			];
			(dynamicColumns || []).forEach(function(column) {
				columnLayout.push({ dataField: column.data_field, headerText: column.header_text, width: 160, filter: { showIcon: true } });
			});
			const gridProps = { usePaging: true, pageRowCount: 100, showPageRowSelect: true, enableFilter: true };
			IFSTATUS000.grid_IFSTATUS000_03 = KpackageOBJ.auiGrid.create("oAuiGrid_IFSTATUS000_03", columnLayout, gridProps, "number");
		}

		this.changeTab = function(tabNo) {
			IFSTATUS000.activeTab = tabNo;
			for (var i = 1; i <= 3; i++) {
				$("#status_tab_0" + i).toggleClass("active", i === tabNo);
				$("#status_tab_wrap_0" + i).toggle(i === tabNo);
			}
			window.setTimeout(function() {
				var gridId = tabNo === 1 ? IFSTATUS000.grid_IFSTATUS000_01
					: (tabNo === 2 ? IFSTATUS000.grid_IFSTATUS000_02 : IFSTATUS000.grid_IFSTATUS000_03);
				if (gridId) AUIGrid.resize(gridId);
			}, 50);
		}

		this.retrieveScheduleList = function() {
			var params = KpackageOBJ.data.makePostData("IFSTATUS000-form-01");
			KpackageOBJ.auiGrid.retrieve(IFSTATUS000.grid_IFSTATUS000_01,
				"/system/interface/statusMgmt/retrieveScheduleStatusList", params);
		}

		this.retrieveTransferList = function() {
			var params = KpackageOBJ.data.makePostData("IFSTATUS000-form-02");
			params.from_date = (params.from_date || "").replace(/-/g, "");
			params.to_date = (params.to_date || "").replace(/-/g, "");
			KpackageOBJ.auiGrid.retrieve(IFSTATUS000.grid_IFSTATUS000_02,
				"/system/interface/statusMgmt/retrieveTransferList", params);
		}

		this.retrieveTransferDetail = function() {
			if (!$("#selected_trans_id").val()) {
				alert("이관 완료 및 에러 탭에서 조회할 항목을 선택해 주세요.");
				return;
			}
			var params = KpackageOBJ.data.makePostData("IFSTATUS000-form-03");
			KpackageOBJ.ajax.doSubmit("/system/interface/statusMgmt/retrieveTransferDetail", params, function(result) {
				var value = result.value || {};
				IFSTATUS000.createTransferDetailGrid(value.columns || []);
				AUIGrid.setGridData(IFSTATUS000.grid_IFSTATUS000_03, value.rows || []);
			});
		}
		
		this.downloadDetailExcel = function() {
			if (!IFSTATUS000.grid_IFSTATUS000_03) {
				alert("엑셀로 다운로드할 Grid가 없습니다.");
				return;
			}

			var rows = AUIGrid.getGridData(IFSTATUS000.grid_IFSTATUS000_03);
			if (!rows || rows.length < 1) {
				alert("엑셀로 다운로드할 데이터가 없습니다.");
				return;
			}
			if (typeof AUIGrid.exportToXlsx !== "function") {
				alert("AUIGrid 엑셀 다운로드 모듈이 로드되지 않았습니다.");
				return;
			}

			var ifCode = $("#selected_if_code").val() || "INTERFACE";
			var transId = $("#selected_trans_id").val() || "DETAIL";
			var fileName = "인터페이스상세_" + ifCode + "_" + transId + "_"
					+ IFSTATUS000.formatDate(new Date());

			AUIGrid.exportToXlsx(IFSTATUS000.grid_IFSTATUS000_03, {
				fileName: fileName,
				exportWithStyle: true
			});
		}

	};

	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		IFSTATUS000.Initialize_viewObject();
	});
</script>
</html>
