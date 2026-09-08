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
				<h1 class="subheader-title mb-1">인터페이스 및 판정</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item">FTA 기준정보</li>
						<li class="breadcrumb-item active" aria-current="page">인터페이스 및 판정</li>
					</ol>
				</nav>
			</div>
			<div class="row col-9"></div>
		</div>

		<div class="row">
			<form id="IFDETM000-search-form" class="s4-form" enctype="multipart/form-data" onsubmit="return false;">
				<div id="panel-4" class="panel panel-icon">
					<div class="panel-container show">
						<div class="panel-content">
							<div class="row">
								<div class="col-2">
									<label class="form-label" for="schedule_code">스케줄명</label>
									<select id="schedule_code" name="schedule_code" class="form-select" onchange="javascript:IFDETM000.changeSchedule();"></select>
								</div>
								<div class="col-2">
									<label class="form-label" for="base_yyyymm">기준일자</label>
									<input type="text" id="base_yyyymm" name="base_yyyymm" class="form-control" maxlength="6" placeholder="YYYYMM">
								</div>
								<div class="col-2">
									<label class="form-label" for="division_code">플랜트명</label>
									<select id="division_code" name="division_code" class="form-select"></select>

								</div>
								<div class="col-2">
									<label class="form-label" for="if_code">인터페이스 ID</label>
									<select id="if_code" name="if_code" class="form-select"></select>
								</div>
								<div class="col-2">
									<label class="form-label" for="excel_file">업로드 파일</label>
									<input type="file" id="excel_file" name="excel_file" class="form-control" accept=".xlsx,.xls,.xlsm">
								</div>
								<div class="col"></div>
								<div class="col-1">
									<button type="button" onclick="javascript:IFDETM000.retrieveAll();"
											class="btn btn-sm btn-search search-no-more waves-effect waves-themed mt-2">Search</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
		
		<div class="row">
			<div class="col-7"></div>
			<div class="col-5">
				<div class="frame-wrap">
					<div class="demo" style="text-align: right;">
						<button type="button" onclick="javascript:IFDETM000.uploadExcel();" class="btn btn-sm btn-primary waves-effect waves-themed">엑셀 업로드</button>
						<button type="button" onclick="javascript:IFDETM000.executeDetermination();" class="btn btn-sm btn-primary waves-effect waves-themed">원산지 판정실행</button>
						<button type="button" onclick="javascript:IFDETM000.restoreScheduleStatus();" class="btn btn-sm btn-secondary waves-effect waves-themed">스케줄 상태 복원</button>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-12">
				<h6 class="mb-2">업로드 인터페이스 현황</h6>
				<div id="oAuiGrid_IFDETM000_01" style="width:100%;height:300px; margin:0 auto;"></div>
			</div>
		</div>

		<div class="row mt-3">
			<div class="col-12">
				<h6 class="mb-2">원산지 판정 수행결과</h6>
				<div id="oAuiGrid_IFDETM000_02" style="width:100%;height:340px; margin:0 auto;"></div>
			</div>
		</div>
	</div>
</body>
<script>
	var IFDETM000 = new function() {
		this.grid_IFDETM000_01 = null;
		this.grid_IFDETM000_02 = null;

		this.Initialize_viewObject = function() {
			IFDETM000.setDefaultBaseYyyymm();
			IFDETM000.createAUIGrid();
			IFDETM000.retrieveDivisionCombo();
			IFDETM000.retrieveScheduleCombo();
		}

		this.setDefaultBaseYyyymm = function() {
			var today = new Date();
			var value = today.getFullYear() + String(today.getMonth() + 1).padStart(2, "0");
			$("#base_yyyymm").val(value);
		}

		this.createAUIGrid = function() {
			const uploadLayout = [
				{ dataField:"if_code", headerText:"인터페이스 코드", width:130, filter:{showIcon:true} },
				{ dataField:"if_name", headerText:"인터페이스 항목", width:190, filter:{showIcon:true} },
				{ dataField:"total_rows", headerText:"총건수", width:100, dataType:"numeric", style:"aui-right" },
				{ dataField:"error_count", headerText:"에러 건수", width:100, dataType:"numeric", style:"aui-right" },
				{ dataField:"start_time", headerText:"시작시간", width:180 },
				{ dataField:"submit_yn", headerText:"제출여부", width:90 },
				{ dataField:"trans_date", headerText:"제출일자", width:180 },
				{ dataField:"error_message", headerText:"오류내용", width:300 }
			];
			const uploadProps = { fillColumnSizeMode:true, usePaging:false, enableFilter:true };
			IFDETM000.grid_IFDETM000_01 = KpackageOBJ.auiGrid.create("oAuiGrid_IFDETM000_01", uploadLayout, uploadProps, "number");

			const determinationLayout = [
				{ dataField:"if_code", headerText:"인터페이스 코드", width:130, filter:{showIcon:true} },
				{ dataField:"if_name", headerText:"인터페이스 항목", width:190, filter:{showIcon:true} },
				{ dataField:"total_rows", headerText:"수취결과", width:100, dataType:"numeric", style:"aui-right" },
				{ dataField:"start_time", headerText:"시작시간", width:180 },
				{ dataField:"trans_date", headerText:"종료시간", width:180 },
				{ dataField:"trans_status_name", headerText:"상태", width:100 },
				{ dataField:"if_param", headerText:"요청 파라메터", width:300 },
				{ dataField:"error_message", headerText:"에러내용", width:300 }
			];
			const determinationProps = { fillColumnSizeMode:true, usePaging:true, pageRowCount:50, showPageRowSelect:true, enableFilter:true };
			IFDETM000.grid_IFDETM000_02 = KpackageOBJ.auiGrid.create("oAuiGrid_IFDETM000_02", determinationLayout, determinationProps, "number");
		}

		this.retrieveScheduleCombo = function() {
			KpackageOBJ.ajax.doSubmit("/ftaInfo/interfaceDetermination/retrieveScheduleCombo", {}, function(result) {
				var list = result.value || [];
				KpackageOBJ.selectbox.create("IFDETM000-search-form", "schedule_code", "", null, "value", "name", list);
				IFDETM000.changeSchedule();
			});
		}
		
		this.retrieveDivisionCombo = function() {
			KpackageOBJ.ajax.doSubmit("/ftaInfo/interfaceDetermination/retrieveDivisionCombo", {}, function(result) {
				var list = result.value || [];
				//list.unshift({value:"", name:"전체"});
				KpackageOBJ.selectbox.create("IFDETM000-search-form", "division_code", "", null, "value", "name", list);
			});
		}

		this.changeSchedule = function() {
			var params = { schedule_code:$("#schedule_code").val() };
			KpackageOBJ.ajax.doSubmit("/ftaInfo/interfaceDetermination/retrieveInterfaceCombo", params, function(result) {
				var list = result.value || [];
				list.unshift({value:"", name:"전체"});
				KpackageOBJ.selectbox.create("IFDETM000-search-form", "if_code", "", null, "value", "name", list);
				IFDETM000.retrieveAll();
			});
		}

		this.uploadExcel = function() {
			var file = $("#excel_file")[0].files[0];
			if (!$("#schedule_code").val()) { alert("스케줄을 선택해 주세요."); return; }
			if (!/^\d{6}$/.test($.trim($("#base_yyyymm").val()))) { alert("기준일자를 YYYYMM 형식으로 입력해 주세요."); return; }
			if (!file) { alert("업로드할 엑셀 파일을 선택해 주세요."); return; }
			if (!confirm("선택한 엑셀 파일을 업로드하시겠습니까?")) return;

			var formData = new FormData(document.getElementById("IFDETM000-search-form"));
			$.ajax({
				url:"/ftaInfo/interfaceDetermination/uploadExcel",
				type:"POST",
				data:formData,
				processData:false,
				contentType:false,
				dataType:"json",
				success:function(result) {
					alert(result.success
						? "업로드가 완료되었습니다. 시트 " + result.value.sheet_count + "개, 데이터 " + result.value.total_rows + "건, 오류 " + result.value.error_count + "건"
						: result.message);
					if (result.success) IFDETM000.retrieveAll();
				},
				error:function(xhr) {
					alert("엑셀 업로드 중 오류가 발생했습니다.");
				}
			});
		}

		this.executeDetermination = function() {
			if (!$("#schedule_code").val()) { alert("스케줄을 선택해 주세요."); return; }
			if (!/^\d{6}$/.test($.trim($("#base_yyyymm").val()))) { alert("기준일자를 YYYYMM 형식으로 입력해 주세요."); return; }
			if (!confirm("업로드 데이터를 기준으로 원산지 판정을 실행하시겠습니까?")) return;
			var params = KpackageOBJ.data.makePostData("IFDETM000-search-form");
			params.division_code = $("#division_code").val();
			KpackageOBJ.ajax.doSubmit("/ftaInfo/interfaceDetermination/executeDetermination", params, function(result) {
				alert(result.message);
				if (result.success) IFDETM000.retrieveAll();
			});
		}

		this.restoreScheduleStatus = function() {
			if (!$("#schedule_code").val()) { alert("스케줄을 선택해 주세요."); return; }
			if (!confirm("선택한 스케줄 상태를 대기로 복원하시겠습니까?")) return;
			KpackageOBJ.ajax.doSubmit("/ftaInfo/interfaceDetermination/restoreScheduleStatus",
					{schedule_code:$("#schedule_code").val()}, function(result) {
				alert(result.message);
				if (result.success) IFDETM000.retrieveAll();
			});
		}

		this.retrieveAll = function() {
			var params = KpackageOBJ.data.makePostData("IFDETM000-search-form");
			KpackageOBJ.auiGrid.retrieve(IFDETM000.grid_IFDETM000_01, "/ftaInfo/interfaceDetermination/retrieveUploadList", params);
			KpackageOBJ.auiGrid.retrieve(IFDETM000.grid_IFDETM000_02, "/ftaInfo/interfaceDetermination/retrieveDeterminationList", params);
		}
	};

	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		IFDETM000.Initialize_viewObject();
	});
</script>
</html>
