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
						<li class="breadcrumb-item">시스템관리</li>
						<li class="breadcrumb-item">인터페이스 관리</li>
						<li class="breadcrumb-item active" aria-current="page">인터페이스 항목관리</li>
					</ol>
				</nav>
			</div>
			<div class="row col-9"></div>
		</div>
		<div class="row">
			<form:form id="IFITEM000-form" class="s4-form" novalidate="novalidate" action="" method="post" onsubmit="return false;">
				<div id="panel-4" class="panel panel-icon">
					<div class="panel-container show">
						<div class="panel-content">
							<div class="row">
								<div class="col-2">
									<div class="mb-3">
										<label class="form-label" for="using_yn">사용 여부</label>
										<select id="using_yn" name="using_yn" class="form-select">
											<option value="">전체</option>
											<option value="Y" selected>사용</option>
											<option value="N">미사용</option>
										</select>
									</div>
								</div>
								<div class="col-lg-5">
									<div class="row">
										<label class="form-label" for="search_item">조회조건</label>
									</div>
									<div class="row mb-3">
										<div class="col-4">
											<select class="form-select" id="search_item" name="search_type"></select>
										</div>
										<div class="col">
											<input type="text" id="search_keyword" name="search_keyword" class="form-control"
													placeholder="키워드 입력" onkeydown="if(event.keyCode===13){IFITEM000.retrieve_GridData();}">
										</div>
									</div>
								</div>
								<div class="col"></div>
								<div class="col-1">
									<button type="button" onclick="javascript:IFITEM000.retrieve_GridData();"
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
						<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed"
								onclick="IFITEM000.openItemDetail('I');">항목 추가</button>
						<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed"
								onclick="IFITEM000.openItemDetail('U');">상세조회</button>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="oAuiGrid_IFITEM000_01" style="width:100%;height:630px; margin:0 auto;"></div>
			</div>
		</div>
	</div>
</body>
<script>
	var IFITEM000 = new function() {

		// AUIGrid 생성 후 반환 ID
		this.grid_IFITEM000_01 = null;

		// 시작점
		this.Initialize_viewObject = function() {
			/* Search Type Select Box Create */
			var arrayItem = [
				{value:"IF_CODE", name:"인터페이스 코드"}
				,{value:"IF_NAME", name:"인터페이스 명"}
			];
			KpackageOBJ.selectbox.create("IFITEM000-form", "search_item", "", null, "value", "name", arrayItem);

			// AUIGrid 그리드를 생성합니다.
			IFITEM000.createAUIGrid();
			IFITEM000.retrieve_GridData();
		}

		// AUIGrid 를 생성합니다.
		this.createAUIGrid = function() {
			// 그리드 칼럼 레이아웃 설정
			const columnLayout = [
				{ dataField: "if_code",             headerText: "인터페이스 코드", width: 140, filter: { showIcon: true } },
				{ dataField: "if_name",             headerText: "인터페이스 명",   width: 220, filter: { showIcon: true } },
				{ dataField: "interface_type_name", headerText: "인터페이스 유형", width: 130, filter: { showIcon: true } },
				{ dataField: "source_table",        headerText: "원천 테이블",     width: 160, filter: { showIcon: true } },
				{ dataField: "target_table",        headerText: "대상 테이블",     width: 160, filter: { showIcon: true } },
				{ dataField: "history_table",       headerText: "이력 테이블",     width: 160, filter: { showIcon: true } },
				{ dataField: "trans_program_name",  headerText: "이관 프로그램명", width: 200, filter: { showIcon: true } },
				{ dataField: "using_yn",            headerText: "사용 여부",       width: 90,  filter: { showIcon: true } }
			];

			// 그리드 속성 설정
			const gridProps = {
				fillColumnSizeMode: true,
				usePaging: true,
				pageRowCount: 50,
				showPageRowSelect: true,
				enableFilter: true
			};

			IFITEM000.grid_IFITEM000_01 = KpackageOBJ.auiGrid.create(
				"oAuiGrid_IFITEM000_01", columnLayout, gridProps, "check"
			);

			// 더블클릭 이벤트
			AUIGrid.bind(IFITEM000.grid_IFITEM000_01, "cellDoubleClick", function(event) {
				IFITEM000.openDetailPopup(event.item.if_code);
			});
		};

		this.retrieve_GridData = function() {
			var params = KpackageOBJ.data.makePostData("IFITEM000-form");
			KpackageOBJ.auiGrid.retrieve(IFITEM000.grid_IFITEM000_01,
				"/system/interface/itemMgmt/retrieveInterfaceItemList", params);
		}

		this.openItemDetail = function(saveType) {
			if (saveType === "I") {
				IFITEM000.openDetailPopup("");
				return;
			}

			var item = IFITEM000.getSingleCheckedItem();
			if (item) IFITEM000.openDetailPopup(item.if_code);
		}

		this.openDetailPopup = function(ifCode) {
			var getParam = "?dialog_id=" + "interfaceItemDetail_Popup"
					+ "&opener_pgm_id=" + "IFITEM000"
					+ "&if_code=" + encodeURIComponent(ifCode || "");
			KpackageOBJ.dialog.open("IFITEM00001_InterfaceItemDetailPopup", "인터페이스 항목 상세",
				"/system/interface/itemDetail" + getParam, 1250, 820);
		}

		this.getSingleCheckedItem = function() {
			var checkedArray = KpackageOBJ.auiGrid.getCheckedRowItems(IFITEM000.grid_IFITEM000_01);
			if (!checkedArray || checkedArray.length < 1) {
				alert("선택된 데이터가 없습니다.");
				return null;
			}
			if (checkedArray.length > 1) {
				alert("한개의 데이터만 선택할 수 있습니다.");
				return null;
			}
			return checkedArray[0].item ? checkedArray[0].item : checkedArray[0];
		}
	};

	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		IFITEM000.Initialize_viewObject();
	});
</script>
</html>
