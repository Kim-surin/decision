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
						<li class="breadcrumb-item">시스템관리</li>
						<li class="breadcrumb-item">인터페이스 관리</li>
						<li class="breadcrumb-item active" aria-current="page">스케줄 관리</li>
					</ol>
				</nav>
			</div>
			<div class="row col-9"></div>
		</div>
		<div class="row">
			<form:form id="SCHEDULE000-form" class="s4-form" novalidate="novalidate" action="" method="post" onsubmit="return false;">
				<div id="panel-4" class="panel panel-icon">
					<div class="panel-container show">
						<div class="panel-content">
							<div class="row">
								<div class="col-lg-5">
									<div class="row"><label class="form-label" for="search_item">조회조건</label></div>
									<div class="row mb-3">
										<div class="col-4"><select class="form-select" id="search_item" name="search_type"></select></div>
										<div class="col">
											<input type="text" id="search_keyword" name="search_keyword" class="form-control" placeholder="키워드 입력"
													onkeydown="if(event.keyCode===13){SCHEDULE000.retrieve_GridData();}">
										</div>
									</div>
								</div>
								<div class="col"></div>
								<div class="col-1">
									<button type="button" onclick="javascript:SCHEDULE000.retrieve_GridData();"
											class="btn btn-sm btn-search search-no-more waves-effect waves-themed mt-2">Search</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form:form>
		</div>
		<div class="row">
			<div class="col-7"></div>
			<div class="col-5">
				<div class="frame-wrap">
					<div class="demo" style="text-align: right;">
						<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="SCHEDULE000.restoreScheduleStatus();">스케줄 상태 복원</button>
						<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="SCHEDULE000.openScheduleDetail('I');">스케줄 추가</button>
						<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="SCHEDULE000.openScheduleDetail('U');">상세조회</button>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="oAuiGrid_SCHEDULE000_01" style="width:100%;height:630px; margin:0 auto;"></div>
			</div>
		</div>
	</div>
</body>
<script>
	var SCHEDULE000 = new function() {

		// AUIGrid 생성 후 반환 ID
		this.grid_SCHEDULE000_01 = null;

		// 시작점
		this.Initialize_viewObject = function() {
			/* Search Type Select Box Create */
			var arrayItem = [
				{value:"SCHEDULE_CODE", name:"스케줄 코드"}
				,{value:"SCHEDULE_NAME", name:"스케줄 명"}
			];
			KpackageOBJ.selectbox.create("SCHEDULE000-form", "search_item", "", null, "value", "name", arrayItem);
			SCHEDULE000.createAUIGrid();
			SCHEDULE000.retrieve_GridData();
		}

		// AUIGrid 를 생성합니다.
		this.createAUIGrid = function() {
			// 그리드 칼럼 레이아웃 설정
			const columnLayout = [
				{ dataField: "schedule_code",   headerText: "스케줄 코드",     width: 150, filter: { showIcon: true } },
				{ dataField: "schedule_name",   headerText: "스케줄 명",       width: 200, filter: { showIcon: true } },
				{ dataField: "apply_from_date", headerText: "적용시작일자",     width: 110, filter: { showIcon: true } },
				{ dataField: "apply_to_date",   headerText: "적용종료일자",     width: 110, filter: { showIcon: true } },
				{ dataField: "month",           headerText: "주기(월)",        width: 90,  filter: { showIcon: true } },
				{ dataField: "day",             headerText: "주기(일)",        width: 90,  filter: { showIcon: true } },
				{ dataField: "hour",            headerText: "주기(시간)",      width: 100, filter: { showIcon: true } },
				{ dataField: "minutes",         headerText: "주기(분)",        width: 90,  filter: { showIcon: true } },
				{ dataField: "system_batch_yn", headerText: "시스템 실행여부", width: 120, filter: { showIcon: true } },
				{ dataField: "status_name",     headerText: "상태",            width: 90,  filter: { showIcon: true } }
			];

			// 그리드 속성 설정
			const gridProps = {
				fillColumnSizeMode: true,
				usePaging: true,
				pageRowCount: 50,
				showPageRowSelect: true,
				enableFilter: true
			};

			SCHEDULE000.grid_SCHEDULE000_01 = KpackageOBJ.auiGrid.create(
				"oAuiGrid_SCHEDULE000_01", columnLayout, gridProps, "check"
			);

			// 더블클릭 이벤트
			AUIGrid.bind(SCHEDULE000.grid_SCHEDULE000_01, "cellDoubleClick", function(event) {
				SCHEDULE000.openDetailPopup(event.item.schedule_code);
			});
		};

		this.retrieve_GridData = function() {
			var params = KpackageOBJ.data.makePostData("SCHEDULE000-form");
			KpackageOBJ.auiGrid.retrieve(SCHEDULE000.grid_SCHEDULE000_01,
				"/system/interface/scheduleMgmt/retrieveScheduleList", params);
		}

		this.openScheduleDetail = function(saveType) {
			if (saveType === "I") {
				SCHEDULE000.openDetailPopup("");
				return;
			}
			var item = SCHEDULE000.getSingleCheckedItem();
			if (item) SCHEDULE000.openDetailPopup(item.schedule_code);
		}

		this.openDetailPopup = function(scheduleCode) {
			var getParam = "?dialog_id=" + "scheduleDetail_Popup"
					+ "&opener_pgm_id=" + "SCHEDULE000"
					+ "&schedule_code=" + encodeURIComponent(scheduleCode || "");
			KpackageOBJ.dialog.open("SCHEDULE00001_ScheduleDetailPopup", "스케줄 상세정보",
				"/system/interface/scheduleDetail" + getParam, 1200, 760);
		}

		this.restoreScheduleStatus = function() {
			var item = SCHEDULE000.getSingleCheckedItem();
			if (!item || !confirm("선택한 스케줄 상태를 대기로 복원하시겠습니까?")) return;
			KpackageOBJ.ajax.doSubmit("/system/interface/scheduleMgmt/restoreScheduleStatus",
				{ schedule_code: item.schedule_code }, function(result) {
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
	};

	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		SCHEDULE000.Initialize_viewObject();
	});
</script>
</html>
