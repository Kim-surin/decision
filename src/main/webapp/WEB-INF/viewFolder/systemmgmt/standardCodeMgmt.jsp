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
				<h1 class="subheader-title mb-1">표준코드관리</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item">시스템관리</li>
						<li class="breadcrumb-item active" aria-current="page">표준코드관리</li>
					</ol>
				</nav>
			</div>
			<div class="row col-9"></div>
		</div>

		<div class="row">
			<form:form id="STDCODE000-search-form" class="s4-form" novalidate="novalidate" action="" method="post" onsubmit="return false;">
				<div id="panel-4" class="panel panel-icon">
					<div class="panel-container show">
						<div class="panel-content">
							<div class="row">
								<div class="col-lg-5">
									<div class="row"><label class="form-label" for="search_item">조회조건</label></div>
									<div class="row mb-3">
										<div class="col-4"><select class="form-select" id="search_item" name="search_type"></select></div>
										<div class="col"><input type="text" id="search_keyword" name="search_keyword" class="form-control" placeholder="키워드 입력" onkeydown="if(event.keyCode===13){STDCODE000.retrieveCategoryList();}"></div>
									</div>
								</div>
								<div class="col"></div>
								<div class="col-1"><button type="button" onclick="javascript:STDCODE000.retrieveCategoryList();" class="btn btn-sm btn-search search-no-more waves-effect waves-themed mt-2">Search</button></div>
							</div>
						</div>
					</div>
				</div>
			</form:form>
		</div>

		<div class="row">
			<div class="col-3">
				<h6 class="mb-2">카테고리 목록</h6>
				<div id="oAuiGrid_STDCODE000_01" style="width:100%;height:650px; margin:0 auto;"></div>
			</div>
			<div class="col-9">
				<div class="row">
					<div class="col-7"><h6 class="mb-2">카테고리 상세정보</h6></div>
					<div class="col-5">
						<div class="frame-wrap"><div class="demo" style="text-align:right;">
							<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="STDCODE000.initializeDetail();">초기화</button>
							<button type="button" class="btn btn-sm btn-primary waves-effect waves-themed" onclick="STDCODE000.saveStandardCode();">저장</button>
							<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="STDCODE000.deleteStandardCode();">삭제</button>
						</div></div>
					</div>
				</div>

				<form:form id="STDCODE000-detail-form" class="s4-form" novalidate="novalidate" action="" method="post" onsubmit="return false;">
					<input type="hidden" id="save_type" name="save_type" value="I">
					<table class="table table-bordered table-sm mb-2">
						<colgroup><col style="width:15%;"><col style="width:35%;"><col style="width:15%;"><col style="width:35%;"></colgroup>
						<tbody>
							<tr>
								<th class="align-middle">카테고리 <span class="text-danger">*</span></th>
								<td><input type="text" id="category" name="category" class="form-control" maxlength="5"></td>
								<th class="align-middle">코드 길이 <span class="text-danger">*</span></th>
								<td><input type="number" id="code_length" name="code_length" class="form-control" min="1" max="50"></td>
							</tr>
							<tr>
								<th class="align-middle">카테고리 명 <span class="text-danger">*</span></th>
								<td><input type="text" id="category_name" name="category_name" class="form-control" maxlength="50"></td>
								<th class="align-middle">수정 가능 여부</th>
								<td><select id="update_yn" name="update_yn" class="form-select"><option value="Y">Yes</option><option value="N">No</option></select></td>
							</tr>
							<tr>
								<th class="align-middle">카테고리 영문명</th>
								<td><input type="text" id="category_name_eng" name="category_name_eng" class="form-control" maxlength="50"></td>
								<th class="align-middle">카테고리 로컬명</th>
								<td><input type="text" id="category_name_loc" name="category_name_loc" class="form-control" maxlength="50"></td>
							</tr>
						</tbody>
					</table>
				</form:form>

				<div class="row">
					<div class="col-7"><h6 class="mb-2">ㆍ 코드목록</h6></div>
					<div class="col-5">
						<div class="frame-wrap"><div class="demo" style="text-align:right;">
							<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="STDCODE000.addCodeRow();">행 추가</button>
							<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="STDCODE000.removeCodeRow();">행 삭제</button>
						</div></div>
					</div>
				</div>
				<div id="oAuiGrid_STDCODE000_02" style="width:100%;height:480px; margin:0 auto;"></div>
			</div>
		</div>
	</div>
</body>
<script>
	var STDCODE000 = new function() {
		this.grid_STDCODE000_01 = null;
		this.grid_STDCODE000_02 = null;
		this.category = "";

		this.Initialize_viewObject = function() {
			var searchItems = [
				{value:"CATEGORY", name:"카테고리"}
				,{value:"CATEGORY_NAME", name:"카테고리 명"}
			];
			KpackageOBJ.selectbox.create("STDCODE000-search-form", "search_item", "", null, "value", "name", searchItems);
			STDCODE000.createAUIGrid();
			STDCODE000.initializeDetail();
			STDCODE000.retrieveCategoryList();
		}

		this.createAUIGrid = function() {
			const categoryLayout = [
				{ dataField:"category", headerText:"카테고리", width:120, filter:{showIcon:true} },
				{ dataField:"category_name", headerText:"카테고리 명", width:180, filter:{showIcon:true} }
			];
			const categoryProps = { fillColumnSizeMode:true, selectionMode:"singleRow", usePaging:false, enableFilter:true };
			STDCODE000.grid_STDCODE000_01 = KpackageOBJ.auiGrid.create("oAuiGrid_STDCODE000_01", categoryLayout, categoryProps, "number");
			AUIGrid.bind(STDCODE000.grid_STDCODE000_01, "cellClick", function(event) {
				STDCODE000.retrieveCategoryDetail(event.item.category);
			});

			const codeLayout = [
				{ dataField:"code", headerText:"코드", width:100 },
				{ dataField:"code_name", headerText:"코드명", width:170 },
				{ dataField:"code_name_eng", headerText:"코드 영문명", width:170 },
				{ dataField:"code_name_loc", headerText:"코드 로컬명", width:170 },
				{ dataField:"sort_no", headerText:"정렬순서", width:90, dataType:"numeric" },
				{ dataField:"using_yn", headerText:"사용여부", width:90, renderer:{type:"DropDownListRenderer", list:["Y", "N"]} },
				{ dataField:"txt_value1", headerText:"텍스트값1", width:140 },
				{ dataField:"txt_value2", headerText:"텍스트값2", width:140 },
				{ dataField:"txt_value3", headerText:"텍스트값3", width:140 },
				{ dataField:"txt_value4", headerText:"텍스트값4", width:140 },
				{ dataField:"txt_value5", headerText:"텍스트값5", width:140 },
				{ dataField:"num_value1", headerText:"숫자값1", width:120, dataType:"numeric" },
				{ dataField:"num_value2", headerText:"숫자값2", width:120, dataType:"numeric" },
				{ dataField:"num_value3", headerText:"숫자값3", width:120, dataType:"numeric" },
				{ dataField:"num_value4", headerText:"숫자값4", width:120, dataType:"numeric" },
				{ dataField:"num_value5", headerText:"숫자값5", width:120, dataType:"numeric" }
			];
			const codeProps = { editable:true, selectionMode:"multipleRows", softRemoveRowMode:false, usePaging:false };
			STDCODE000.grid_STDCODE000_02 = KpackageOBJ.auiGrid.create("oAuiGrid_STDCODE000_02", codeLayout, codeProps, "check");
		}

		this.retrieveCategoryList = function() {
			var params = KpackageOBJ.data.makePostData("STDCODE000-search-form");
			KpackageOBJ.auiGrid.retrieve(STDCODE000.grid_STDCODE000_01, "/system/code/standardCodeMgmt/retrieveCategoryList", params);
		}

		this.retrieveCategoryDetail = function(category) {
			STDCODE000.category = category || "";
			KpackageOBJ.ajax.doSubmit("/system/code/standardCodeMgmt/retrieveCategoryDetail", {category:STDCODE000.category}, function(result) {
				if (!result.value || !result.value.category) {
					alert("카테고리 정보를 찾을 수 없습니다.");
					return;
				}
				STDCODE000.clearDetailForm();
				KpackageOBJ.data.setFormData("STDCODE000-detail-form", result.value.category);
				AUIGrid.setGridData(STDCODE000.grid_STDCODE000_02, result.value.codes || []);
				$("#save_type").val("U");
				$("#category").prop("readonly", true);
			});
		}

		this.initializeDetail = function() {
			STDCODE000.category = "";
			STDCODE000.clearDetailForm();
			$("#save_type").val("I");
			$("#update_yn").val("Y");
			$("#category").prop("readonly", false).focus();
			if (STDCODE000.grid_STDCODE000_02) AUIGrid.setGridData(STDCODE000.grid_STDCODE000_02, []);
		}

		this.clearDetailForm = function() {
			var form = document.getElementById("STDCODE000-detail-form");
			if (form) form.reset();
		}

		this.addCodeRow = function() {
			var rows = AUIGrid.getGridData(STDCODE000.grid_STDCODE000_02);
			AUIGrid.addRow(STDCODE000.grid_STDCODE000_02, {sort_no:rows.length + 1, using_yn:"Y"}, "last");
		}

		this.removeCodeRow = function() {
			var checkedArray = KpackageOBJ.auiGrid.getCheckedRowItems(STDCODE000.grid_STDCODE000_02);
			if (!checkedArray || checkedArray.length < 1) {
				alert("선택된 데이터가 없습니다.");
				return;
			}
			checkedArray.sort(function(a, b) { return b.rowIndex - a.rowIndex; });
			for (var i = 0; i < checkedArray.length; i++) AUIGrid.removeRow(STDCODE000.grid_STDCODE000_02, checkedArray[i].rowIndex);
		}

		this.saveStandardCode = function() {
			if (!STDCODE000.validateForm()) return;
			var params = KpackageOBJ.data.makePostData("STDCODE000-detail-form");
			params.codes = AUIGrid.getGridData(STDCODE000.grid_STDCODE000_02);
			KpackageOBJ.ajax.doSubmit("/system/code/standardCodeMgmt/saveStandardCode", params, function(result) {
				alert(result.message);
				if (!result.success) return;
				STDCODE000.category = result.value.category;
				STDCODE000.retrieveCategoryList();
				STDCODE000.retrieveCategoryDetail(STDCODE000.category);
			});
		}

		this.deleteStandardCode = function() {
			if ($("#save_type").val() !== "U" || !STDCODE000.category) {
				alert("삭제할 카테고리를 선택해 주세요.");
				return;
			}
			if (!confirm("선택한 카테고리와 하위 코드를 모두 삭제하시겠습니까?")) return;
			KpackageOBJ.ajax.doSubmit("/system/code/standardCodeMgmt/deleteStandardCode", {category:STDCODE000.category}, function(result) {
				alert(result.message);
				if (!result.success) return;
				STDCODE000.initializeDetail();
				STDCODE000.retrieveCategoryList();
			});
		}

		this.validateForm = function() {
			var category = $.trim($("#category").val());
			var codeLength = Number($("#code_length").val());
			if (!category) { alert("카테고리를 입력해 주세요."); $("#category").focus(); return false; }
			if (!$.trim($("#category_name").val())) { alert("카테고리 명을 입력해 주세요."); $("#category_name").focus(); return false; }
			if (!Number.isInteger(codeLength) || codeLength < 1 || codeLength > 50) { alert("코드 길이는 1에서 50 사이로 입력해 주세요."); $("#code_length").focus(); return false; }
			var rows = AUIGrid.getGridData(STDCODE000.grid_STDCODE000_02);
			var codeMap = Object.create(null);
			for (var i = 0; i < rows.length; i++) {
				var code = $.trim(rows[i].code || "");
				if (!code) { alert((i + 1) + "번째 코드값을 입력해 주세요."); return false; }
				if (code.length > codeLength) { alert((i + 1) + "번째 코드가 설정된 코드 길이를 초과합니다."); return false; }
				if (!$.trim(rows[i].code_name || "")) { alert((i + 1) + "번째 코드명을 입력해 주세요."); return false; }
				if (codeMap[code]) { alert("중복된 코드가 있습니다. (" + code + ")"); return false; }
				codeMap[code] = true;
			}
			return true;
		}
	};

	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		STDCODE000.Initialize_viewObject();
	});
</script>
</html>
