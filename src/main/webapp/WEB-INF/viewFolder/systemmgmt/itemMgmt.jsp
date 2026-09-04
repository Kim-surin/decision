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
				<h1 class="subheader-title mb-1">인터페이스 항목관리</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item">인터페이스 관리</li>
						<li class="breadcrumb-item active" aria-current="page">인터페이스 항목관리</li>
					</ol>
				</nav>
			</div>
			<div class="row col-9"></div>
		</div>

		<div class="row">
			<div class="col-3"><h6 class="mb-2">인터페이스 목록</h6><div id="oAuiGrid_IFITEM000_01" style="width:100%;height:730px; margin:0 auto;"></div></div>
			<div class="col-9">
				<div class="row">
					<div class="col-7"><h6 class="mb-2">인터페이스 상세정보</h6></div>
					<div class="col-5"><div class="frame-wrap"><div class="demo" style="text-align:right;">
						<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="IFITEM000.initializeDetail();">초기화</button>
						<button type="button" class="btn btn-sm btn-primary waves-effect waves-themed" onclick="IFITEM000.saveInterfaceItem();">저장</button>
					</div></div></div>
				</div>

				<form:form id="IFITEM000-detail-form" class="s4-form" novalidate="novalidate" action="" method="post" onsubmit="return false;">
					<input type="hidden" id="save_type" name="save_type" value="I">
					<input type="hidden" id="vrify_program_name" name="vrify_program_name">
					<input type="hidden" id="source_program_name" name="source_program_name">
					<input type="hidden" id="return_column_name" name="return_column_name">
					<input type="hidden" id="return_column_value" name="return_column_value">
					<input type="hidden" id="return_msg_column_name" name="return_msg_column_name">
					<input type="hidden" id="excel_upload_yn" name="excel_upload_yn" value="N">
					<input type="hidden" id="trans_company_code_yn" name="trans_company_code_yn" value="N">
					<input type="hidden" id="trans_division_code_yn" name="trans_division_code_yn" value="N">
					<table class="table table-bordered table-sm mb-2">
						<colgroup><col style="width:14%;"><col style="width:20%;"><col style="width:14%;"><col style="width:20%;"><col style="width:14%;"><col style="width:18%;"></colgroup>
						<tbody>
							<tr><th class="align-middle">인터페이스 코드 <span class="text-danger">*</span></th><td><input type="text" id="if_code" name="if_code" class="form-control" maxlength="6"></td><th class="align-middle">인터페이스 명 <span class="text-danger">*</span></th><td><input type="text" id="if_name" name="if_name" class="form-control" maxlength="200"></td><th class="align-middle">인터페이스 유형</th><td><select id="interface_type" name="interface_type" class="form-select"><option value="I">Inbound</option><option value="O">Outbound</option></select></td></tr>
							<tr><th class="align-middle">사용 여부</th><td><select id="using_yn" name="using_yn" class="form-select"><option value="Y">Yes</option><option value="N">No</option></select></td><th class="align-middle">원천 테이블</th><td><input type="text" id="source_table" name="source_table" class="form-control" maxlength="30"></td><th class="align-middle">대상 테이블</th><td><input type="text" id="target_table" name="target_table" class="form-control" maxlength="30"></td></tr>
							<tr><th class="align-middle">이력 테이블</th><td><input type="text" id="history_table" name="history_table" class="form-control" maxlength="30"></td><th class="align-middle">이관 프로그램 명</th><td colspan="3"><input type="text" id="trans_program_name" name="trans_program_name" class="form-control" maxlength="100"></td></tr>
							<tr><th class="align-middle">인터페이스 설명</th><td colspan="5"><textarea id="remark" name="remark" class="form-control" rows="2" maxlength="2000"></textarea></td></tr>
						</tbody>
					</table>
				</form:form>

				<div class="row"><div class="col-7"><h6 class="mb-1">ㆍ INPUT Data</h6></div><div class="col-5"><div class="frame-wrap"><div class="demo" style="text-align:right;"><button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="IFITEM000.addColumnRow('I');">행 추가</button><button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="IFITEM000.removeColumnRow('I');">행 삭제</button></div></div></div></div>
				<div id="oAuiGrid_IFITEM000_02" style="width:100%;height:220px; margin:0 auto;"></div>
				<div class="row mt-2"><div class="col-7"><h6 class="mb-1">ㆍ OUTPUT Data</h6></div><div class="col-5"><div class="frame-wrap"><div class="demo" style="text-align:right;"><button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="IFITEM000.addColumnRow('O');">행 추가</button><button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="IFITEM000.removeColumnRow('O');">행 삭제</button></div></div></div></div>
				<div id="oAuiGrid_IFITEM000_03" style="width:100%;height:300px; margin:0 auto;"></div>
			</div>
		</div>
	</div>
</body>
<script>
	var IFITEM000 = new function() {
		this.grid_IFITEM000_01 = null;
		this.grid_IFITEM000_02 = null;
		this.grid_IFITEM000_03 = null;
		this.ifCode = "";

		this.Initialize_viewObject = function() {
			var arrayItem = [{value:"IF_CODE", name:"인터페이스 코드"}, {value:"IF_NAME", name:"인터페이스 명"}];
			KpackageOBJ.selectbox.create("IFITEM000-search-form", "search_item", "", null, "value", "name", arrayItem);
			IFITEM000.createAUIGrid();
			IFITEM000.initializeDetail();
			IFITEM000.retrieve_GridData();
		}

		this.getColumnLayout = function() {
			return [
				{ dataField:"column_name", headerText:"컬럼명", width:150 },
				{ dataField:"source_column", headerText:"ERP 컬럼 명", width:150 },
				{ dataField:"target_column", headerText:"FTA 컬럼 명", width:150 },
				{ dataField:"history_column", headerText:"이력 컬럼명", width:140 },
				{ dataField:"sample_data", headerText:"샘플 데이터", width:130 },
				{ dataField:"column_type", headerText:"컬럼 타입", width:100, dataType:"numeric" },
				{ dataField:"column_length", headerText:"컬럼 길이", width:100, dataType:"numeric" },
				{ dataField:"column_dcmlpoint_length", headerText:"소수점 길이", width:100, dataType:"numeric" },
				{ dataField:"column_dflt_value", headerText:"컬럼 디폴트 값", width:130 },
				{ dataField:"column_required_yn", headerText:"컬럼 필수 여부", width:110, renderer:{type:"DropDownListRenderer", list:["Y", "N"]} },
				{ dataField:"pk_yn", headerText:"PK 여부", width:90, renderer:{type:"DropDownListRenderer", list:["Y", "N"]} },
				{ dataField:"column_format_form", headerText:"컬럼 포맷", width:120 },
				{ dataField:"column_vrify_program_name", headerText:"검증 프로그램", width:160 },
				{ dataField:"using_yn", headerText:"사용 여부", width:90, renderer:{type:"DropDownListRenderer", list:["Y", "N"]} }
			];
		}

		this.createAUIGrid = function() {
			const listLayout = [
				{ dataField:"if_code", headerText:"인터페이스 코드", width:130, filter:{showIcon:true} },
				{ dataField:"if_name", headerText:"인터페이스 명", width:180, filter:{showIcon:true} }
			];
			const listProps = { fillColumnSizeMode:true, selectionMode:"singleRow", usePaging:false, enableFilter:true };
			IFITEM000.grid_IFITEM000_01 = KpackageOBJ.auiGrid.create("oAuiGrid_IFITEM000_01", listLayout, listProps, "number");
			AUIGrid.bind(IFITEM000.grid_IFITEM000_01, "cellClick", function(event) { IFITEM000.retrieveInterfaceItemDetail(event.item.if_code); });

			const detailProps = { editable:true, selectionMode:"multipleRows", softRemoveRowMode:false, usePaging:false };
			IFITEM000.grid_IFITEM000_02 = KpackageOBJ.auiGrid.create("oAuiGrid_IFITEM000_02", IFITEM000.getColumnLayout(), detailProps, "check");
			IFITEM000.grid_IFITEM000_03 = KpackageOBJ.auiGrid.create("oAuiGrid_IFITEM000_03", IFITEM000.getColumnLayout(), detailProps, "check");
		}

		this.retrieve_GridData = function() {
			var params = KpackageOBJ.data.makePostData("IFITEM000-search-form");
			KpackageOBJ.auiGrid.retrieve(IFITEM000.grid_IFITEM000_01, "/system/interface/itemMgmt/retrieveInterfaceItemList", params);
		}

		this.retrieveInterfaceItemDetail = function(ifCode) {
			IFITEM000.ifCode = ifCode || "";
			KpackageOBJ.ajax.doSubmit("/system/interface/itemMgmt/retrieveInterfaceItemDetail", {if_code:IFITEM000.ifCode}, function(result) {
				if (!result.value || !result.value.item) { alert("인터페이스 항목을 찾을 수 없습니다."); return; }
				IFITEM000.clearDetailForm();
				KpackageOBJ.data.setFormData("IFITEM000-detail-form", result.value.item);
				$("#save_type").val("U");
				$("#if_code").prop("readonly", true);
				var inputList = [], outputList = [];
				(result.value.columns || []).forEach(function(row) {
					if (row.column_trans_type === "O") outputList.push(row); else inputList.push(row);
				});
				AUIGrid.setGridData(IFITEM000.grid_IFITEM000_02, inputList);
				AUIGrid.setGridData(IFITEM000.grid_IFITEM000_03, outputList);
			});
		}

		this.initializeDetail = function() {
			IFITEM000.ifCode = "";
			IFITEM000.clearDetailForm();
			$("#save_type").val("I");
			$("#interface_type").val("I");
			$("#using_yn").val("Y");
			$("#excel_upload_yn, #trans_company_code_yn, #trans_division_code_yn").val("N");
			$("#if_code").prop("readonly", false).focus();
			if (IFITEM000.grid_IFITEM000_02) AUIGrid.setGridData(IFITEM000.grid_IFITEM000_02, []);
			if (IFITEM000.grid_IFITEM000_03) AUIGrid.setGridData(IFITEM000.grid_IFITEM000_03, []);
		}

		this.clearDetailForm = function() {
			var form = document.getElementById("IFITEM000-detail-form");
			if (form) form.reset();
		}

		this.getDetailGrid = function(columnTransType) { return columnTransType === "O" ? IFITEM000.grid_IFITEM000_03 : IFITEM000.grid_IFITEM000_02; }

		this.addColumnRow = function(columnTransType) {
			AUIGrid.addRow(IFITEM000.getDetailGrid(columnTransType), {column_trans_type:columnTransType, column_type:1, column_length:0, column_dcmlpoint_length:0, column_required_yn:"N", pk_yn:"N", using_yn:"Y"}, "last");
		}

		this.removeColumnRow = function(columnTransType) {
			var gridId = IFITEM000.getDetailGrid(columnTransType);
			var checkedArray = KpackageOBJ.auiGrid.getCheckedRowItems(gridId);
			if (!checkedArray || checkedArray.length < 1) { alert("선택된 데이터가 없습니다."); return; }
			checkedArray.sort(function(a, b) { return b.rowIndex - a.rowIndex; });
			for (var i = 0; i < checkedArray.length; i++) AUIGrid.removeRow(gridId, checkedArray[i].rowIndex);
		}

		this.saveInterfaceItem = function() {
			if (!IFITEM000.validateForm()) return;
			var params = KpackageOBJ.data.makePostData("IFITEM000-detail-form");
			var inputList = AUIGrid.getGridData(IFITEM000.grid_IFITEM000_02);
			var outputList = AUIGrid.getGridData(IFITEM000.grid_IFITEM000_03);
			inputList.forEach(function(row) { row.column_trans_type = "I"; });
			outputList.forEach(function(row) { row.column_trans_type = "O"; });
			params.columns = inputList.concat(outputList);
			KpackageOBJ.ajax.doSubmit("/system/interface/itemMgmt/saveInterfaceItem", params, function(result) {
				alert(result.message);
				if (!result.success) return;
				IFITEM000.ifCode = result.value.if_code;
				$("#save_type").val("U");
				$("#if_code").prop("readonly", true);
				IFITEM000.retrieve_GridData();
				IFITEM000.retrieveInterfaceItemDetail(IFITEM000.ifCode);
			});
		}

		this.validateForm = function() {
			if (!$.trim($("#if_code").val())) { alert("인터페이스 코드를 입력해 주세요."); $("#if_code").focus(); return false; }
			if (!$.trim($("#if_name").val())) { alert("인터페이스 명을 입력해 주세요."); $("#if_name").focus(); return false; }
			var rows = AUIGrid.getGridData(IFITEM000.grid_IFITEM000_02).concat(AUIGrid.getGridData(IFITEM000.grid_IFITEM000_03));
			for (var i = 0; i < rows.length; i++) {
				if (!$.trim(rows[i].target_column || "") || !$.trim(rows[i].column_name || "")) { alert((i + 1) + "번째 상세행의 대상 컬럼과 컬럼명을 입력해 주세요."); return false; }
				if (rows[i].column_type == null || rows[i].column_length == null) { alert((i + 1) + "번째 상세행의 컬럼 타입과 길이를 입력해 주세요."); return false; }
			}
			return true;
		}
	};

	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		IFITEM000.Initialize_viewObject();
	});
</script>
</html>
