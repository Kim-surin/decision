<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head></head>
<body>
	<div class="content-wrapper">
		<form:form id="IFITEM001-form" class="s4-form" novalidate="novalidate" action="" method="post" onsubmit="return false;">
			<input type="hidden" id="save_type" name="save_type" value="I">
			<div id="panel-4" class="panel panel-icon">
				<div class="panel-container show">
					<div class="panel-content">
						<h6 class="mb-3">기본정보</h6>
						<div class="row">
							<div class="mb-3 col-3">
								<label class="form-label" for="if_code">인터페이스 코드 <span class="text-danger">*</span></label>
								<input type="text" id="if_code" name="if_code" value="${if_code}" class="form-control" maxlength="6">
							</div>
							<div class="mb-3 col-3">
								<label class="form-label" for="if_name">인터페이스 명 <span class="text-danger">*</span></label>
								<input type="text" id="if_name" name="if_name" class="form-control" maxlength="200">
							</div>
							<div class="mb-3 col-3">
								<label class="form-label" for="interface_type">인터페이스 유형 <span class="text-danger">*</span></label>
								<select id="interface_type" name="interface_type" class="form-select">
									<option value="I">Inbound</option>
									<option value="O">Outbound</option>
								</select>
							</div>
							<div class="mb-3 col-3">
								<label class="form-label" for="using_yn">사용 여부</label>
								<select id="using_yn" name="using_yn" class="form-select">
									<option value="Y">사용</option>
									<option value="N">미사용</option>
								</select>
							</div>
							<div class="mb-3 col-3">
								<label class="form-label" for="source_table">원천 테이블</label>
								<input type="text" id="source_table" name="source_table" class="form-control" maxlength="30">
							</div>
							<div class="mb-3 col-3">
								<label class="form-label" for="target_table">대상 테이블</label>
								<input type="text" id="target_table" name="target_table" class="form-control" maxlength="30">
							</div>
							<div class="mb-3 col-3">
								<label class="form-label" for="history_table">이력 테이블</label>
								<input type="text" id="history_table" name="history_table" class="form-control" maxlength="30">
							</div>
							<div class="mb-3 col-3">
								<label class="form-label" for="trans_program_name">이관 프로그램명</label>
								<input type="text" id="trans_program_name" name="trans_program_name" class="form-control" maxlength="100">
							</div>
							<div class="mb-3 col-3">
								<label class="form-label" for="vrify_program_name">검증 프로그램명</label>
								<input type="text" id="vrify_program_name" name="vrify_program_name" class="form-control" maxlength="50">
							</div>
							<div class="mb-3 col-3">
								<label class="form-label" for="source_program_name">소스 프로그램명</label>
								<input type="text" id="source_program_name" name="source_program_name" class="form-control" maxlength="50">
							</div>
							<div class="mb-3 col-2">
								<label class="form-label" for="return_column_name">결과 항목명</label>
								<input type="text" id="return_column_name" name="return_column_name" class="form-control" maxlength="30">
							</div>
							<div class="mb-3 col-2">
								<label class="form-label" for="return_column_value">Success 값</label>
								<input type="text" id="return_column_value" name="return_column_value" class="form-control" maxlength="10">
							</div>
							<div class="mb-3 col-2">
								<label class="form-label" for="return_msg_column_name">결과 메시지 항목</label>
								<input type="text" id="return_msg_column_name" name="return_msg_column_name" class="form-control" maxlength="30">
							</div>
							<div class="mb-3 col-12">
								<label class="form-label" for="remark">인터페이스 설명</label>
								<textarea id="remark" name="remark" class="form-control" rows="2" maxlength="2000"></textarea>
							</div>
						</div>
						<hr>
						<h6 class="mb-3">이관 및 엑셀 옵션</h6>
						<div class="row">
							<div class="mb-3 col-3">
								<label class="form-label" for="excel_upload_yn">엑셀 업로드 여부</label>
								<select id="excel_upload_yn" name="excel_upload_yn" class="form-select">
									<option value="N">아니오</option>
									<option value="Y">예</option>
								</select>
							</div>
							<div class="mb-3 col-3">
								<label class="form-label" for="trans_company_code_yn">이관 회사코드 여부</label>
								<select id="trans_company_code_yn" name="trans_company_code_yn" class="form-select">
									<option value="N">아니오</option>
									<option value="Y">예</option>
								</select>
							</div>
							<div class="mb-3 col-3">
								<label class="form-label" for="trans_division_code_yn">이관 사업부코드 여부</label>
								<select id="trans_division_code_yn" name="trans_division_code_yn" class="form-select">
									<option value="N">아니오</option>
									<option value="Y">예</option>
								</select>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form:form>
		<div class="row">
			<div class="col-7">
				<ul class="nav nav-tabs" role="tablist">
					<li class="nav-item">
						<button id="input_tab" class="nav-link active" type="button" onclick="IFITEM001.changeTab('I');">Input</button>
					</li>
					<li class="nav-item">
						<button id="output_tab" class="nav-link" type="button" onclick="IFITEM001.changeTab('O');">Output</button>
					</li>
				</ul>
			</div>
			<div class="col-5">
				<div class="frame-wrap">
					<div class="demo" style="text-align: right;">
						<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed"
								onclick="IFITEM001.addColumnRow();">행 추가</button>
						<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed"
								onclick="IFITEM001.removeColumnRow();">행 삭제</button>
						<button type="button" class="btn btn-sm btn-primary waves-effect waves-themed"
								onclick="IFITEM001.saveInterfaceItem();">저장</button>
					</div>
				</div>
			</div>
		</div>
		<div id="input_grid_wrap" class="row">
			<div class="col-12">
				<div id="oAuiGrid_IFITEM001_01" style="width:100%;height:300px; margin:0 auto;"></div>
			</div>
		</div>
		<div id="output_grid_wrap" class="row" style="display: none;">
			<div class="col-12">
				<div id="oAuiGrid_IFITEM001_02" style="width:100%;height:300px; margin:0 auto;"></div>
			</div>
		</div>
	</div>
</body>
<script>
	var IFITEM001 = new function() {

		// AUIGrid 생성 후 반환 ID
		this.grid_IFITEM001_01 = null;
		this.grid_IFITEM001_02 = null;
		this.activeTab = "I";
		this.ifCode = $("#if_code").val();

		// 시작점
		this.Initialize_viewObject = function() {
			IFITEM001.createAUIGrid();
			if (IFITEM001.ifCode) {
				IFITEM001.retrieveInterfaceItemDetail();
			} else {
				IFITEM001.setDefaults();
			}
		}

		// Input/Output Grid 공통 칼럼 레이아웃
		this.getColumnLayout = function() {
			return [
				{ dataField: "target_column",              headerText: "대상 컬럼",     width: 150 },
				{ dataField: "source_column",              headerText: "소스 컬럼",     width: 150 },
				{ dataField: "history_column",             headerText: "이력 컬럼",     width: 150 },
				{ dataField: "column_name",                headerText: "컬럼명",        width: 150 },
				{ dataField: "sample_data",                headerText: "샘플 데이터",   width: 130 },
				{ dataField: "column_type",                headerText: "컬럼 타입 코드", width: 110, dataType: "numeric" },
				{ dataField: "column_length",              headerText: "컬럼 길이",     width: 100, dataType: "numeric" },
				{ dataField: "column_dcmlpoint_length",    headerText: "소수점 길이",   width: 100, dataType: "numeric" },
				{ dataField: "column_format_form",         headerText: "컬럼 포맷",     width: 120 },
				{ dataField: "column_dflt_value",          headerText: "기본값",        width: 120 },
				{ dataField: "column_vrify_program_name", headerText: "검증 프로그램", width: 160 },
				{ dataField: "column_required_yn",        headerText: "필수 여부",     width: 90,
					renderer: { type: "DropDownListRenderer", list: ["Y", "N"] } },
				{ dataField: "pk_yn",                     headerText: "PK 여부",       width: 80,
					renderer: { type: "DropDownListRenderer", list: ["Y", "N"] } },
				{ dataField: "using_yn",                  headerText: "사용 여부",     width: 90,
					renderer: { type: "DropDownListRenderer", list: ["Y", "N"] } }
			];
		}

		// AUIGrid 를 생성합니다.
		this.createAUIGrid = function() {
			const gridProps = {
				editable: true,
				selectionMode: "multipleRows",
				softRemoveRowMode: false,
				usePaging: false
			};
			var columnLayout = IFITEM001.getColumnLayout();

			IFITEM001.grid_IFITEM001_01 = KpackageOBJ.auiGrid.create(
				"oAuiGrid_IFITEM001_01", columnLayout, gridProps, "check"
			);
			IFITEM001.grid_IFITEM001_02 = KpackageOBJ.auiGrid.create(
				"oAuiGrid_IFITEM001_02", columnLayout, gridProps, "check"
			);
		}

		this.setDefaults = function() {
			$("#interface_type").val("I");
			$("#using_yn").val("Y");
			$("#excel_upload_yn, #trans_company_code_yn, #trans_division_code_yn").val("N");
		}

		this.retrieveInterfaceItemDetail = function() {
			KpackageOBJ.ajax.doSubmit("/system/interface/itemMgmt/retrieveInterfaceItemDetail",
				{ if_code: IFITEM001.ifCode }, function(result) {
					if (!result.value || !result.value.item) {
						alert("인터페이스 항목을 찾을 수 없습니다.");
						return;
					}

					KpackageOBJ.data.setFormData("IFITEM001-form", result.value.item);
					$("#save_type").val("U");
					$("#if_code").prop("readonly", true);

					var inputList = [];
					var outputList = [];
					(result.value.columns || []).forEach(function(row) {
						if (row.column_trans_type === "O") {
							outputList.push(row);
						} else {
							inputList.push(row);
						}
					});

					AUIGrid.setGridData(IFITEM001.grid_IFITEM001_01, inputList);
					AUIGrid.setGridData(IFITEM001.grid_IFITEM001_02, outputList);
				});
		}

		this.changeTab = function(columnTransType) {
			IFITEM001.activeTab = columnTransType;
			$("#input_tab").toggleClass("active", columnTransType === "I");
			$("#output_tab").toggleClass("active", columnTransType === "O");
			$("#input_grid_wrap").toggle(columnTransType === "I");
			$("#output_grid_wrap").toggle(columnTransType === "O");

			window.setTimeout(function() {
				var gridId = columnTransType === "I"
					? IFITEM001.grid_IFITEM001_01 : IFITEM001.grid_IFITEM001_02;
				AUIGrid.resize(gridId);
			}, 50);
		}

		this.getActiveGrid = function() {
			return IFITEM001.activeTab === "I"
				? IFITEM001.grid_IFITEM001_01 : IFITEM001.grid_IFITEM001_02;
		}

		this.addColumnRow = function() {
			AUIGrid.addRow(IFITEM001.getActiveGrid(), {
				column_trans_type: IFITEM001.activeTab,
				column_type: 1,
				column_length: 0,
				column_dcmlpoint_length: 0,
				column_required_yn: "N",
				pk_yn: "N",
				using_yn: "Y"
			}, "last");
		}

		this.removeColumnRow = function() {
			var gridId = IFITEM001.getActiveGrid();
			var checkedArray = KpackageOBJ.auiGrid.getCheckedRowItems(gridId);
			if (!checkedArray || checkedArray.length < 1) {
				alert("선택된 데이터가 없습니다.");
				return;
			}

			checkedArray.sort(function(a, b) { return b.rowIndex - a.rowIndex; });
			for (var i = 0; i < checkedArray.length; i++) {
				AUIGrid.removeRow(gridId, checkedArray[i].rowIndex);
			}
		}

		this.saveInterfaceItem = function() {
			if (!IFITEM001.validateForm()) return;

			var params = KpackageOBJ.data.makePostData("IFITEM001-form");
			var inputList = AUIGrid.getGridData(IFITEM001.grid_IFITEM001_01);
			var outputList = AUIGrid.getGridData(IFITEM001.grid_IFITEM001_02);
			inputList.forEach(function(row) { row.column_trans_type = "I"; });
			outputList.forEach(function(row) { row.column_trans_type = "O"; });
			params.columns = inputList.concat(outputList);

			KpackageOBJ.ajax.doSubmit("/system/interface/itemMgmt/saveInterfaceItem", params, function(result) {
				alert(result.message);
				if (!result.success) return;

				IFITEM001.ifCode = result.value.if_code;
				$("#save_type").val("U");
				$("#if_code").prop("readonly", true);
				if (parent.IFITEM000) parent.IFITEM000.retrieve_GridData();
				IFITEM001.retrieveInterfaceItemDetail();
			});
		}

		this.validateForm = function() {
			if (!$.trim($("#if_code").val())) {
				alert("인터페이스 코드를 입력해 주세요.");
				$("#if_code").focus();
				return false;
			}
			if (!$.trim($("#if_name").val())) {
				alert("인터페이스 명을 입력해 주세요.");
				$("#if_name").focus();
				return false;
			}

			var rows = AUIGrid.getGridData(IFITEM001.grid_IFITEM001_01)
				.concat(AUIGrid.getGridData(IFITEM001.grid_IFITEM001_02));
			for (var i = 0; i < rows.length; i++) {
				if (!$.trim(rows[i].target_column || "") || !$.trim(rows[i].column_name || "")) {
					alert((i + 1) + "번째 상세행의 대상 컬럼과 컬럼명을 입력해 주세요.");
					return false;
				}
				if (rows[i].column_type == null || rows[i].column_length == null) {
					alert((i + 1) + "번째 상세행의 컬럼 타입과 길이를 입력해 주세요.");
					return false;
				}
			}
			return true;
		}
	};

	$(document).ready(function() {
		pageSetUp();
		IFITEM001.Initialize_viewObject();
	});
</script>
</html>
