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
						<li class="breadcrumb-item">인터페이스 관리</li>
						<li class="breadcrumb-item active" aria-current="page">인터페이스 현황</li>
					</ol>
				</nav>
			</div>
			<div class="row col-9"></div>
		</div>

		<div class="row">
			<div class="col-4">
				<h6 class="mb-2">이관 스케줄</h6>
				<div id="oAuiGrid_IFSTATUS000_01" style="width:100%;height:300px; margin:0 auto;"></div>
			</div>
			<div class="col-8">
				<h6 class="mb-2">이관 완료 및 에러</h6>
				<form:form id="IFSTATUS000-form-02" class="s4-form" novalidate="novalidate" action="" method="post" onsubmit="return false;">
					<input type="hidden" id="selected_schedule_code" name="selected_schedule_code">
				</form:form>
				<div id="oAuiGrid_IFSTATUS000_02" style="width:100%;height:245px; margin:0 auto;"></div>
			</div>
		</div>

		<div class="row">
			<div class="col-7"></div>
			<div class="col-5">
				<div class="frame-wrap">
					<div class="demo" style="text-align: right;">
						<form:form id="IFSTATUS000-form-03" class="s4-form" novalidate="novalidate" action="" method="post" onsubmit="return false;">
							<input type="hidden" id="selected_trans_id" name="intg_interface_trans_id">
							<input type="hidden" id="selected_if_code" name="if_code">
							<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="IFSTATUS000.downloadDetailExcel();">엑셀다운로드</button>
						</form:form>
					</div>
				</div>
			</div>
		</div>
		<div class="row"><div class="col-12"><div id="oAuiGrid_IFSTATUS000_03" style="width:100%;height:420px; margin:0 auto;"></div></div></div>
	</div>
</body>
<script>
	var IFSTATUS000 = new function() {
		this.grid_IFSTATUS000_01 = null;
		this.grid_IFSTATUS000_02 = null;
		this.grid_IFSTATUS000_03 = null;

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
				{ dataField:"schedule_code", headerText:"스케줄 코드", width:160, filter:{showIcon:true} },
				{ dataField:"schedule_name", headerText:"스케줄 명", width:120, filter:{showIcon:true} },
				{ dataField:"last_execution_date", headerText:"최근실행일자", width:140 }
			];
			const gridProps = { fillColumnSizeMode:true, selectionMode:"singleRow", usePaging:false, enableFilter:true };
			IFSTATUS000.grid_IFSTATUS000_01 = KpackageOBJ.auiGrid.create("oAuiGrid_IFSTATUS000_01", columnLayout, gridProps, "number");
			AUIGrid.bind(IFSTATUS000.grid_IFSTATUS000_01, "cellClick", function(event) {
				$("#selected_schedule_code").val(event.item.schedule_code);
				$("#selected_trans_id, #selected_if_code").val("");
				AUIGrid.setGridData(IFSTATUS000.grid_IFSTATUS000_03, []);
				IFSTATUS000.retrieveTransferList();
			});
		}

		this.createTransferGrid = function() {
			const columnLayout = [
				{ dataField:"if_code", headerText:"인터페이스 코드", width:120, filter:{showIcon:true} },
				{ dataField:"if_name", headerText:"인터페이스 명", width:150, filter:{showIcon:true} },
				{ dataField:"total_rows", headerText:"이관 건수", width:90, dataType:"numeric", style:"aui-right" },
				{ dataField:"trans_status_name", headerText:"상태", width:80 },
				{ dataField:"start_time", headerText:"이관 시작", width:140 },
				{ dataField:"trans_date", headerText:"이관 종료", width:140 },
				{ dataField:"if_param", headerText:"요청파라메터", width:200 },
				{ dataField:"error_message", headerText:"오류 메시지", width:280 }
			];
			const gridProps = { selectionMode:"singleRow", usePaging:false, enableFilter:true };
			IFSTATUS000.grid_IFSTATUS000_02 = KpackageOBJ.auiGrid.create("oAuiGrid_IFSTATUS000_02", columnLayout, gridProps, "number");
			AUIGrid.bind(IFSTATUS000.grid_IFSTATUS000_02, "cellClick", function(event) {
				$("#selected_trans_id").val(event.item.intg_interface_trans_id);
				$("#selected_if_code").val(event.item.if_code);
				IFSTATUS000.retrieveTransferDetail();
			});
		}

		this.createTransferDetailGrid = function(dynamicColumns) {
			if (IFSTATUS000.grid_IFSTATUS000_03) AUIGrid.destroy(IFSTATUS000.grid_IFSTATUS000_03);
			var columnLayout = [];
			(dynamicColumns || []).forEach(function(column) {
				columnLayout.push({ dataField:column.data_field, headerText:column.header_text, width:160, filter:{showIcon:true} });
			});
			columnLayout.push({ dataField:"error_yn", headerText:"오류 여부", width:90 });
			columnLayout.push({ dataField:"error_message", headerText:"오류 메시지", width:250 });
			const gridProps = { usePaging:true, pageRowCount:100, showPageRowSelect:true, enableFilter:true };
			IFSTATUS000.grid_IFSTATUS000_03 = KpackageOBJ.auiGrid.create("oAuiGrid_IFSTATUS000_03", columnLayout, gridProps, "number");
		}

		this.retrieveScheduleList = function() {
			var params = KpackageOBJ.data.makePostData("IFSTATUS000-form-01");
			KpackageOBJ.auiGrid.retrieve(IFSTATUS000.grid_IFSTATUS000_01, "/system/interface/statusMgmt/retrieveScheduleStatusList", params);
		}

		this.retrieveTransferList = function() {
			var params = KpackageOBJ.data.makePostData("IFSTATUS000-form-02");
			params.from_date = (params.from_date || "").replace(/-/g, "");
			params.to_date = (params.to_date || "").replace(/-/g, "");
			KpackageOBJ.auiGrid.retrieve(IFSTATUS000.grid_IFSTATUS000_02, "/system/interface/statusMgmt/retrieveTransferList", params);
		}

		this.retrieveTransferDetail = function() {
			if (!$("#selected_trans_id").val()) { alert("조회할 이관 결과를 선택해 주세요."); return; }
			var params = KpackageOBJ.data.makePostData("IFSTATUS000-form-03");
			KpackageOBJ.ajax.doSubmit("/system/interface/statusMgmt/retrieveTransferDetail", params, function(result) {
				var value = result.value || {};
				IFSTATUS000.createTransferDetailGrid(value.columns || []);
				AUIGrid.setGridData(IFSTATUS000.grid_IFSTATUS000_03, value.rows || []);
			});
		}

		this.downloadDetailExcel = function() {
			if (!IFSTATUS000.grid_IFSTATUS000_03) { alert("엑셀로 다운로드할 Grid가 없습니다."); return; }
			var rows = AUIGrid.getGridData(IFSTATUS000.grid_IFSTATUS000_03);
			if (!rows || rows.length < 1) { alert("엑셀로 다운로드할 데이터가 없습니다."); return; }
			if (typeof AUIGrid.exportToXlsx !== "function") { alert("AUIGrid 엑셀 다운로드 모듈이 로드되지 않았습니다."); return; }
			var ifCode = $("#selected_if_code").val() || "INTERFACE";
			var transId = $("#selected_trans_id").val() || "DETAIL";
			AUIGrid.exportToXlsx(IFSTATUS000.grid_IFSTATUS000_03, {
				fileName:"인터페이스상세_" + ifCode + "_" + transId + "_" + IFSTATUS000.formatDate(new Date()),
				exportWithStyle:true
			});
		}
	};

	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		IFSTATUS000.Initialize_viewObject();
	});
</script>
</html>
