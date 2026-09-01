<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	.origin-detail-split {
		display: flex;
		/* 팝업(sidepanel) 자체가 거의 풀 높이라 고정값(620px) 대신 뷰포트 기준으로 채움.
		   140px는 이 팝업의 modal-header + 바깥 sidepanel modal-body의 여백을 대략 뺀 값 */
		height: calc(100vh - 140px);
	}
	.origin-detail-sidebar {
		width: 300px;
		flex: 0 0 300px;
		border-right: 1px solid #dee2e6;
		overflow-y: auto;
	}
	.origin-detail-sidebar .list-group-item {
		cursor: pointer;
		border-left: 0;
		border-right: 0;
		border-radius: 0;
	}
	.origin-detail-sidebar .list-group-item.active {
		background-color: #eef3ff;
		border-color: #dee2e6;
		color: #212529;
		font-weight: bold;
		border-left: 3px solid #4a6cf7;
	}
	.origin-detail-sidebar .badge {
		margin-bottom: 4px;
	}
	.origin-detail-sidebar .badge.status-fail {
		background-color: #ffe6e6 !important;
		color: #d9534f !important;
	}
	.origin-detail-sidebar .badge.status-non {
		background-color: #fffde7 !important;
		color: #b78103 !important;
	}
	.origin-detail-sidebar .badge.status-done {
		background-color: #e6f4ea !important;
		color: #1e7e34 !important;
	}
	.origin-detail-sidebar .item-product-code {
		display: block;
		font-weight: 600;
	}
	.origin-detail-sidebar .item-product-name {
		display: block;
		font-size: 12px;
		color: #6c757d;
	}
	.origin-detail-main {
		flex: 1 1 auto;
		padding: 16px 20px;
		overflow-y: auto;
	}
	.origin-detail-empty {
		color: #6c757d;
		text-align: center;
		padding: 40px 0;
	}
</style>
</head>
<body>
	<div class="modal-header">
		<h5 class="modal-title h4">원산지 판정 상세</h5>
		<div class="ms-auto d-flex align-items-center gap-2">
			<button type="button" class="btn btn-sm btn-primary" onclick="javascript:ORIGIN_DETERMINATION_DETAIL_POPUP.bulkOriginDetermination();">일괄 원산지 판정</button>
			<button type="button" class="btn btn-system" data-bs-dismiss="modal" aria-label="Close">
				<svg class="sa-icon sa-icon-2x">
                      <use href="/rcs/ui5x/img/sprite.svg#x"></use>
                  </svg>
			</button>
		</div>
	</div>
	<div class="modal-body p-0">
		<div class="origin-detail-split">
			<div class="origin-detail-sidebar list-group" id="originDetermination_popup_sidebar">
			</div>
			<div class="origin-detail-main">
				<div class="d-flex justify-content-between align-items-center mb-3">
					<h6 class="mb-0">판정 품목</h6>
					<button type="button" id="originDetermination_popup_individualBtn" class="btn btn-sm btn-primary" onclick="javascript:ORIGIN_DETERMINATION_DETAIL_POPUP.individualOriginDetermination();">개별 원산지 판정</button>
				</div>
				<div id="oAuiGrid_originDetermination_popup_detail" style="width:100%;height:180px;"></div>

				<div id="originDetermination_popup_resultSection">
					<h6 class="mt-4 mb-3">판정결과</h6>
					<div id="oAuiGrid_originDetermination_popup_result" style="width:100%;height:280px;"></div>

					<h6 class="mt-4 mb-3">판정 상세내용</h6>
					<div id="oAuiGrid_originDetermination_popup_resultDetail" style="width:100%;height:180px;"></div>
				</div>

				<div id="originDetermination_popup_failSection">
					<h6 class="mt-4 mb-3">판정 실패 사유</h6>
					<div id="oAuiGrid_originDetermination_popup_failReason" style="width:100%;height:280px;"></div>

					<h6 class="mt-4 mb-3">판정 실패 상세내용</h6>
					<div id="oAuiGrid_originDetermination_popup_failDetail" style="width:100%;height:180px;"></div>
					<!-- TXT_HSCODE_INCLUDE_MISSING/MSG_FAILED_DECISION_QTY_AMOUNT 사유일 때는 위 대신 이 원재료
					     목록을 보여준다(selectFailReasonRow 참고) -->
					<div id="oAuiGrid_originDetermination_popup_failMaterial" style="width:100%;height:180px;"></div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	var ORIGIN_DETERMINATION_DETAIL_POPUP = new function() {
		// 팝업을 연 화면에서 체크되어 넘어온 원본 목록. 내수는 이미 라인(SALES_NO+SALES_SEQ) 단위라
		// 좌측 목록에도 그대로 쓰지만, 수출은 송장(SALES_NO) 단위라 좌측 목록/상세 렌더링에는
		// this.lineItems(라인 단위로 펼친 목록)를 쓰고, this.datas는 일괄/개별 판정 실행(executeOriginDetermination)
		// 대상 식별에만 쓴다.
		this.datas = [];
		// lineItems를 (품번, 품명) 기준으로 묶은 좌측 사이드바 표시 단위 목록 - retrieveDetailList 응답으로 채워짐.
		// 동일 품번/품명이 여러 라인(SALES_SEQ)에 걸쳐 있어도 좌측엔 하나만 노출하고, 그 그룹에 속한
		// 라인들을 우측 "판정 품목" 표에 모두 나열한다.
		this.lineItems = [];
		this.groupedItems = [];
		// sales_no + '_' + sales_seq 를 key 로 하는 라인별 상세정보 맵
		this.detailMap = {};
		// 좌측에서 선택된 그룹(품번/품명)의 key
		this.selectedGroupKey = null;
		// 우측 "판정 품목" 표에서 선택된 라인(SALES_NO+SALES_SEQ) 단위 key - 판정결과 조회/개별 원산지 판정 대상
		this.selectedLineKey = null;
		// 현재 선택된 판정 품목의 판정 상세내용(기준별) 전체 목록 - fta_code로 필터링해서 사용
		this.currentDetailList = [];
		// 현재 선택된 판정 품목의 판정 실패 상세내용(협정 내 룰 전체) 목록 - fta_code로 필터링해서 사용
		this.currentFailDetailList = [];
		// 현재 선택된 판정 품목의 원재료(FCR_DTL) 전체 목록 - HS코드 누락/금액 0 사유일 때 fta_code로
		// 필터링해서 판정 실패 상세내용 자리에 대신 보여준다
		this.currentFailMaterialList = [];
		// 판정 실패 상세내용 대신 원재료 목록을 보여줘야 하는 실패 사유(ERROR_CODE)
		this.MATERIAL_DETAIL_ERROR_CODES = ["TXT_HSCODE_INCLUDE_MISSING", "MSG_FAILED_DECISION_QTY_AMOUNT"];
		// 팝업을 연 화면(내수/수출) - 값이 없으면(구버전 호출부 등) 내수로 취급.
		// 내수는 "개별/일괄 원산지 판정" 버튼이 둘 다 있고 executeDomesticOriginDetermination을,
		// 수출은 "일괄 원산지 판정" 버튼만 있고 executeExportOriginDetermination을 호출한다.
		this.mode = 'domestic';

		// 판정 품목 -> 판정결과 -> 판정 상세내용으로 이어지는 마스터-디테일 그리드 3개
		this.grid_Detail = null;
		this.grid_Result = null;
		this.grid_ResultDetail = null;
		this.grid_FailReason = null;
		this.grid_FailDetail = null;
		this.grid_FailMaterial = null;

		this.buildKey = function(salesNo, salesSeq) {
			return salesNo + "_" + salesSeq;
		};

		this.buildGroupKey = function(productCode, productName) {
			return productCode + "_" + productName;
		};

		// this.lineItems를 (품번, 품명) 기준으로 묶어 this.groupedItems를 구성.
		// 그룹의 판정상태 배지는 그 그룹에 속한 첫 번째 라인의 값을 대표로 사용한다
		// (같은 품번이 여러 라인에 걸쳐 있어도 보통 같은 송장/그룹에 속해 판정상태를 공유함)
		this.buildGroupedItems = function() {
			var self = this;
			var groupMap = {};
			var order = [];

			this.lineItems.forEach(function(row) {
				var groupKey = self.buildGroupKey(row.product_code, row.product_name);

				if (!groupMap[groupKey]) {
					groupMap[groupKey] = {
						key: groupKey,
						product_code: row.product_code,
						product_name: row.product_name,
						invoice_month: row.invoice_month,
						status: row.status,
						status_name: row.status_name,
						lines: []
					};
					order.push(groupKey);
				}

				groupMap[groupKey].lines.push(row);
			});

			this.groupedItems = order.map(function(groupKey) {
				return groupMap[groupKey];
			});
		};

		// 좌측 목록(groupedItems)에서 key에 해당하는 그룹을 찾음
		this.findGroupByKey = function(key) {
			return this.groupedItems.filter(function(group) {
				return group.key === key;
			})[0];
		};

		// 판정상태(status)에 따른 배지 색상 클래스
		this.getStatusBadgeClass = function(status) {
			switch (String(status)) {
				case "5": // 판정실패
					return "status-fail";
				case "0": // 미판정
				case "1":
					return "status-non";
				case "4": // 판정완료
					return "status-done";
				default:
					return "bg-secondary";
			}
		};

		this.createAUIGrid = function() {
			var self = this;

			var columnLayoutDetail = [
				{dataField: "sales_no", headerText: "SALES_NO", width: 0, visible: false},
				{dataField: "sales_seq", headerText: "SALES_SEQ", width: 0, visible: false},
				{dataField: "product_code", headerText: "품번", width: 200},
				{dataField: "product_name", headerText: "품명", width: 250},
				{dataField: "hs_code", headerText: "HS CODE", width: 150},
				{dataField: "quantity", headerText: "수량", width: 100, dataType: "numeric", style: ""},
				{dataField: "unit", headerText: "단위", width: 100},
				{dataField: "unit_price", headerText: "단가(원)", width: 200, dataType: "numeric", style: "", formatString: "#,##0"},
				{dataField: "amount", headerText: "금액(원)", width: 200, dataType: "numeric", style: "", formatString: "#,##0"}
			];
			var gridPropsDetail = {};
			this.grid_Detail = KpackageOBJ.auiGrid.create("oAuiGrid_originDetermination_popup_detail", columnLayoutDetail, gridPropsDetail, "");

			AUIGrid.bind(this.grid_Detail, "cellClick", function(event) {
				self.selectDetailLine(self.buildKey(event.item.sales_no, event.item.sales_seq));
			});

			var columnLayoutResult = [
				{dataField: "fta_code", headerText: "FTA_CODE", width: 0, visible: false},
				{dataField: "product_code", headerText: "PRODUCT_CODE", width: 0, visible: false},
				{dataField: "bom_division_code", headerText: "BOM_DIVISION_CODE", width: 0, visible: false},
				{dataField: "bom_yyyymm", headerText: "BOM_YYYYMM", width: 0, visible: false},
				{dataField: "hs_code", headerText: "HS CODE", width: 110},
				{dataField: "fta_name", headerText: "협정명", width: 150, filter: {showIcon: true}},
				{dataField: "amount", headerText: "단가", width: 120, dataType: "numeric", style: "", formatString: "#,##0"},
				{dataField: "inkoterms_type", headerText: "단가기준", width: 100},
				{dataField: "rule_contents", headerText: "결정기준", width: 130, filter: {showIcon: true}},
				{dataField: "company_coo_yn", headerText: "충족여부", width: 100},
				{dataField: "rvc_rate", headerText: "판정 부가가치 비율", width: 130, dataType: "numeric", style: "",  				
					labelFunction: function(rowIndex, columnIndex, value, dataField, gridObject) {
				        if (value === null || value === undefined || value === "") return "";
				        return Number(value).toFixed(0) + "%"; 
				    }},
				{dataField: "de_minimis_rate", headerText: "미소기준 적용 비율", width: 130, dataType: "numeric", style: "",
					labelFunction: function(rowIndex, columnIndex, value, dataField, gridObject) {
					    if (value === null || value === undefined || value === "") return "";
					    return Number(value).toFixed(0) + "%"; 
					}},
				// BOM 추적 아이콘 클릭은 아래 grid_Result의 cellClick 바인딩(dataField === "bom_trace")에서
				// 처리한다 - IconRenderer의 onClick은 클릭된 행(item)을 넘겨주지 않아 어느 협정의 BOM인지
				// 알 수 없다
				{dataField: "bom_trace", headerText: "BOM 추적", width: 100, style: "grid-center-text",
					renderer: {
						type: 'IconRenderer',
						iconWidth: 16, // icon 가로 사이즈, 지정하지 않으면 24로 기본값 적용됨
						iconHeight: 16,
						iconFunction: function (rowIndex, columnIndex, value, item) {
						 	return "/rcs/auigrid/images/icon-search.png";
						},
					}
				},
				// 역내전환전략은 충족여부(company_coo_yn)가 'N'(미충족)일 때만 아이콘을 보여준다 -
				// 이미 충족된 건은 전환전략이 필요 없기 때문
				{dataField: "conversion_strategy", headerText: "역내전환전략", width: 100, style: "grid-center-text",
					renderer: {
					    type: 'IconRenderer',
					    iconWidth: 16, // icon 가로 사이즈, 지정하지 않으면 24로 기본값 적용됨
					    iconHeight: 16,
					    iconFunction: function (rowIndex, columnIndex, value, item) {
					    	return item.company_coo_yn === 'N' ? "/rcs/auigrid/images/icon-search.png" : null;
					    },
					    onClick: (e) => {
					    	ORIGIN_DETERMINATION_DETAIL_POPUP.getConversionStrategy();
					    },
					}
				}
			];
			var gridPropsResult = {enableFilter: true };
			this.grid_Result = KpackageOBJ.auiGrid.create("oAuiGrid_originDetermination_popup_result", columnLayoutResult, gridPropsResult, "");

			AUIGrid.bind(this.grid_Result, "cellClick", function(event) {
				if (event.dataField === "bom_trace") {
					self.getBomTraceList(event.item);
					return;
				}
				self.selectResultRow(event.item.fta_code);
			});

			var columnLayoutResultDetail = [
				{dataField: "rule_code", headerText: "결정기준", width: 120, filter: {showIcon: true}},
				{dataField: "de_minimis_amount", headerText: "미소기준 적용금액", width: 100, dataType: "numeric", style: ""},
				{dataField: "company_coo_yn", headerText: "충족여부", width: 100},
				{dataField: "amount", headerText: "단가", width: 120, dataType: "numeric", style: "", formatString: "#,##0"},
				{dataField: "outarea_amount", headerText: "미상 재료비(원)", width: 120, dataType: "numeric", style: "", formatString: "#,##0"},
				{dataField: "rvc_rate", headerText: "부가가치 비율", width: 130, dataType: "numeric", style: "",
					labelFunction: function(rowIndex, columnIndex, value, dataField, gridObject) {
					    if (value === null || value === undefined || value === "") return "";
					    return Number(value).toFixed(0) + "%"; 
					}},
				{dataField: "rule_description", headerText: "결정기준 해설", width: 500}
			];
			var gridPropsResultDetail = { enableFilter: true };
			this.grid_ResultDetail = KpackageOBJ.auiGrid.create("oAuiGrid_originDetermination_popup_resultDetail", columnLayoutResultDetail, gridPropsResultDetail, "");

			// 판정 실패 사유: FCR_RESULT 중 STATUS='E'(오류)인 협정별 사유 목록(협정+사유 단위로 중복 제거됨)
			var columnLayoutFailReason = [
				{dataField: "fta_code", headerText: "FTA_CODE", width: 0, visible: false},
				{dataField: "fta_name", headerText: "협정명", width: 150, filter: {showIcon: true}},
				{dataField: "error_code", headerText: "오류코드", width: 180, filter: {showIcon: true}},
				{dataField: "error_msg", headerText: "실패 사유", width: 400}
			];
			var gridPropsFailReason = { enableFilter: true };
			this.grid_FailReason = KpackageOBJ.auiGrid.create("oAuiGrid_originDetermination_popup_failReason", columnLayoutFailReason, gridPropsFailReason, "");

			AUIGrid.bind(this.grid_FailReason, "cellClick", function(event) {
				self.selectFailReasonRow(event.item);
			});

			// 판정 실패 상세내용: 실패 사유 그리드에서 협정(FTA_CODE) 행을 클릭하면, 그 협정에 걸린
			// 룰 전체(오류 여부 무관)의 처리결과를 보여준다 - 어떤 룰은 통과하고 어떤 룰만 실패했는지 함께 확인 가능.
			// 단 실패 사유가 MATERIAL_DETAIL_ERROR_CODES에 해당하면 이 그리드 대신 원재료 목록을 보여준다
			// (selectFailReasonRow 참고)
			var columnLayoutFailDetail = [
				{dataField: "rule_seq", headerText: "룰순번", width: 90},
				{dataField: "rule_code", headerText: "결정기준", width: 150, filter: {showIcon: true}},
				{dataField: "status", headerText: "처리상태", width: 100,
					labelFunction: function(rowIndex, columnIndex, value) {
						return value === "E" ? "오류" : (value === "N" ? "정상" : (value || ""));
					}},
				{dataField: "error_code", headerText: "오류코드", width: 180, filter: {showIcon: true}},
				{dataField: "error_msg", headerText: "실패 사유", width: 300},
				{dataField: "rule_description", headerText: "결정기준 해설", width: 400}
			];
			var gridPropsFailDetail = { enableFilter: true };
			this.grid_FailDetail = KpackageOBJ.auiGrid.create("oAuiGrid_originDetermination_popup_failDetail", columnLayoutFailDetail, gridPropsFailDetail, "");

			// 원재료(FCR_DTL) 목록: HS코드 누락(TXT_HSCODE_INCLUDE_MISSING)/금액 0(MSG_FAILED_DECISION_QTY_AMOUNT)
			// 사유일 때 어떤 원재료가 원인인지 바로 확인할 수 있도록 보여준다
			var columnLayoutFailMaterial = [
				{dataField: "item_code", headerText: "품목코드", width: 150},
				{dataField: "item_name", headerText: "품명", width: 200},
				{dataField: "hs_code", headerText: "HS CODE", width: 110},
				{dataField: "requirement_qty", headerText: "소요량", width: 100, dataType: "numeric", style: ""},
				{dataField: "input_amount", headerText: "투입금액", width: 130, dataType: "numeric", style: "", formatString: "#,##0"},
				{dataField: "inarea_qty", headerText: "역내수량", width: 100, dataType: "numeric", style: ""},
				{dataField: "inarea_amount", headerText: "역내금액", width: 130, dataType: "numeric", style: "", formatString: "#,##0"},
				{dataField: "outarea_qty", headerText: "역외수량", width: 100, dataType: "numeric", style: ""},
				{dataField: "outarea_amount", headerText: "역외금액", width: 130, dataType: "numeric", style: "", formatString: "#,##0"}
			];
			var gridPropsFailMaterial = { enableFilter: true };
			this.grid_FailMaterial = KpackageOBJ.auiGrid.create("oAuiGrid_originDetermination_popup_failMaterial", columnLayoutFailMaterial, gridPropsFailMaterial, "");
			$('#oAuiGrid_originDetermination_popup_failMaterial').hide();

			// 판정 품목 조회가 끝나 selectDetailLine이 상태에 맞게 다시 켤 때까지, 두 섹션 모두 기본적으로
			// 숨겨둔다(비동기 조회 응답이 오기 전 빈 그리드가 잠깐 노출되는 걸 방지)
			$('#originDetermination_popup_resultSection').hide();
			$('#originDetermination_popup_failSection').hide();
		};

		// 시작점
		this.Initialize_viewObject = function() {
			var rawDatas = '${datas}';
			var rawMode = '${mode}';

			try {
				this.datas = rawDatas ? JSON.parse(rawDatas) : [];
			} catch (e) {
				this.datas = [];
			}

			this.mode = rawMode || 'domestic';
			this.applyModeVisibility();
			this.disableModalFadeTransition();
			this.createAUIGrid();
			this.bindModalShownResize();

			this.retrieveDetailList();
		};

		// 이 팝업이 열리는 modal-dialog-end 는 슬라이드인 트랜지션(.modal.fade .modal-dialog-end 의
		// transform)이 걸려 있어 열릴 때마다 화면이 접혔다 펴지는 것처럼 보인다. 부트스트랩은 show()
		// 호출 시점에 대상 엘리먼트의 fade 클래스 유무를 그때그때 확인하므로(Modal.prototype._isAnimated),
		// KpackageOBJ.sidepanel.open이 modalObject.show()를 호출하기 전인 지금(스크립트가 콘텐츠 주입과
		// 함께 동기 실행되는 시점) fade 클래스를 미리 떼어내면 트랜지션 없이 즉시 나타난다.
		this.disableModalFadeTransition = function() {
			$('.origin-detail-split').closest('.modal').removeClass('fade');
		};

		// AUIGrid는 생성 시점에 부모 Div가 화면에 보이는 상태여야 실제 크기를 계산한다(보이지 않으면
		// 기본 크기로 축소됨 - package.common-v2.3.js auiGrid.resize 주석 참고). 이 팝업은
		// KpackageOBJ.sidepanel.open이 부트스트랩 모달을 아직 show() 하기 전에 콘텐츠를 주입하고
		// 그 안에서 그리드를 생성하므로(createAUIGrid), 생성 시점엔 모달이 아직 안 보인 상태다.
		// disableModalFadeTransition으로 트랜지션을 없앴으므로 shown.bs.modal은 show() 호출과 거의
		// 동시에(대기 없이) 발생한다 - 그 시점에 그리드 크기를 다시 계산한다.
		this.bindModalShownResize = function() {
			var self = this;
			var $modal = $('.origin-detail-split').closest('.modal');

			if ($modal.hasClass('show')) {
				self.resizeGridsToFitModal();
				return;
			}

			$modal.one('shown.bs.modal', function() {
				self.resizeGridsToFitModal();
			});
		};

		this.resizeGridsToFitModal = function() {
			AUIGrid.resize(this.grid_Detail);
			AUIGrid.resize(this.grid_Result);
			AUIGrid.resize(this.grid_ResultDetail);
			AUIGrid.resize(this.grid_FailReason);
			AUIGrid.resize(this.grid_FailDetail);
		};

		 // 개별 원산지 판정 임시 숨김 처리
		this.applyModeVisibility = function() {
			$('#originDetermination_popup_individualBtn').hide();
		};

		// 좌측 사이드바 렌더링 (매출년월/품번/품명) - this.groupedItems(품번+품명 단위) 기준.
		// 동일 품번/품명은 여러 라인에 걸쳐 있어도 하나만 노출한다
		this.renderSidebar = function() {
			var $sidebar = $('#originDetermination_popup_sidebar');
			$sidebar.empty();

			if (this.groupedItems.length === 0) {
				$sidebar.append('<div class="origin-detail-empty">선택된 항목이 없습니다.</div>');
				return;
			}

			var self = this;
			this.groupedItems.forEach(function(group) {
				var statusClass = self.getStatusBadgeClass(group.status);

				var $item = $(
					'<a href="javascript:void(0)" class="list-group-item list-group-item-action" data-key="' + group.key + '">' +
						(group.invoice_month ? '<span class="badge bg-secondary">' + group.invoice_month + '</span> ' : '') +
						'<span class="badge ' + statusClass + '">' + (group.status_name || '') + '</span>' +
						'<span class="item-product-code">' + (group.product_code || '') + '</span>' +
						'<span class="item-product-name">' + (group.product_name || '') + '</span>' +
					'</a>'
				);

				$item.on('click', function() {
					self.selectItem(group.key);
				});

				$sidebar.append($item);
			});
		};

		// 체크되어 넘어온 항목(this.datas)의 상세정보를 한번에 조회하고, 그 응답으로 좌측 목록
		// (this.lineItems)까지 새로 구성한다. 일괄/개별 판정 실행 뒤 최신화할 때도 이 함수를 그대로
		// 다시 호출한다(선택 중이던 라인이 남아있으면 그 라인을, 없으면 첫 라인을 다시 선택).
		this.retrieveDetailList = function() {
			var self = this;

			var request = {
				datas: this.datas.map(function(row) {
					return { sales_no: row.sales_no, sales_seq: row.sales_seq, division_code: row.division_code };
				})
			};

			KpackageOBJ.ajax.doSubmit(
				'/origin/compliance/origindetermination/originDeterminationDetailList',
				request,
				function(response) {
					var list = (response && response.value) ? response.value : [];
					var previousGroupKey = self.selectedGroupKey;

					self.buildDetailMapAndLineItems(list);
					self.buildGroupedItems();
					self.renderSidebar();

					var keyToSelect = (previousGroupKey && self.findGroupByKey(previousGroupKey)) ? previousGroupKey : null;
					if (!keyToSelect && self.groupedItems.length > 0) {
						keyToSelect = self.groupedItems[0].key;
					}

					if (keyToSelect) {
						self.selectItem(keyToSelect);
					}
				}
			);
		};

		// detailMap: buildKey(sales_no, sales_seq) -> 그 라인의 상세 1건.
		// lineItems: 좌측 사이드바/선택 기준이 되는 라인 목록. 내수는 this.datas 자체가 이미 라인
		// 단위라 그대로 쓰고, 수출은 this.datas가 송장(SALES_NO) 단위라 방금 받은 라인 목록으로
		// 새로 구성한다 - 품번/품명은 그 라인 상세에서, 판정상태는 그 라인이 속한 송장의 원본
		// this.datas 항목에서 가져온다(판정상태는 송장 단위라 같은 송장의 모든 라인이 공유).
		this.buildDetailMapAndLineItems = function(list) {
			var self = this;

			this.detailMap = {};
			list.forEach(function(row) {
				self.detailMap[self.buildKey(row.sales_no, row.sales_seq)] = row;
			});

			if (this.mode === 'domestic') {
				this.lineItems = this.datas;
				return;
			}

			var invoiceBySalesNo = {};
			this.datas.forEach(function(d) {
				invoiceBySalesNo[d.sales_no] = d;
			});

			this.lineItems = list.map(function(row) {
				var invoice = invoiceBySalesNo[row.sales_no] || {};
				return {
					sales_no: row.sales_no,
					sales_seq: row.sales_seq,
					division_code: invoice.division_code,
					product_code: row.product_code,
					product_name: row.product_name,
					status: invoice.status,
					status_name: invoice.status_name
				};
			});
		};

		// 좌측 그룹(품번/품명) 선택 시, 그 그룹에 속한 라인 전체를 우측 "판정 품목"에 나열하고,
		// 그 중 하나(이전에 선택돼 있던 라인 우선, 없으면 판정완료 라인, 그마저 없으면 첫 라인)를
		// 자동으로 선택해 판정결과를 보여준다
		this.selectItem = function(key) {
			this.selectedGroupKey = key;

			$('#originDetermination_popup_sidebar .list-group-item').removeClass('active');
			$('#originDetermination_popup_sidebar .list-group-item[data-key="' + key + '"]').addClass('active');

			var self = this;
			var group = this.findGroupByKey(key);
			var lines = group ? group.lines : [];

			this.renderDetailList(lines);

			if (lines.length === 0) {
				this.selectedLineKey = null;
				this.hideResultSections();
				this.hideFailSections();
				return;
			}

			var lineKeyToSelect = null;
			if (this.selectedLineKey && lines.some(function(line) {
				return self.buildKey(line.sales_no, line.sales_seq) === self.selectedLineKey;
			})) {
				lineKeyToSelect = this.selectedLineKey;
			} else {
				var determinedLine = lines.filter(function(line) {
					return self.isDetermined(line.status);
				})[0];
				var targetLine = determinedLine || lines[0];
				lineKeyToSelect = this.buildKey(targetLine.sales_no, targetLine.sales_seq);
			}

			this.selectDetailLine(lineKeyToSelect);
		};

		// 우측 "판정 품목" 표에서 라인 1건을 선택 - 판정완료(status=4)면 판정결과/판정 상세내용을,
		// 판정실패(status=5)면 판정 실패 사유/판정 실패 상세내용을 보여줌. 그 외 상태는 둘 다 비움.
		// 개별 원산지 판정(도메스틱 전용) 대상도 이 선택된 라인을 기준으로 한다
		this.selectDetailLine = function(lineKey) {
			this.selectedLineKey = lineKey;

			var line = this.findRowByKey(lineKey);
			if (line && this.isDetermined(line.status)) {
				this.retrieveResultList(line);
				this.hideFailSections();
			} else if (line && this.isFailed(line.status)) {
				this.retrieveFailList(line);
				this.hideResultSections();
			} else {
				this.hideResultSections();
				this.hideFailSections();
			}
		};

		// 좌측 목록(lineItems)에서 key에 해당하는 라인을 찾음
		this.findRowByKey = function(key) {
			var self = this;
			return this.lineItems.filter(function(row) {
				return self.buildKey(row.sales_no, row.sales_seq) === key;
			})[0];
		};

		this.isDetermined = function(status) {
			return String(status) === "4";
		};

		this.isFailed = function(status) {
			return String(status) === "5";
		};

		this.hideResultSections = function() {
			this.currentDetailList = [];
			AUIGrid.setGridData(this.grid_Result, []);
			AUIGrid.setGridData(this.grid_ResultDetail, []);
			$('#originDetermination_popup_resultSection').hide();
		};

		this.hideFailSections = function() {
			this.currentFailDetailList = [];
			this.currentFailMaterialList = [];
			AUIGrid.setGridData(this.grid_FailReason, []);
			AUIGrid.setGridData(this.grid_FailDetail, []);
			AUIGrid.setGridData(this.grid_FailMaterial, []);
			$('#oAuiGrid_originDetermination_popup_failDetail').show();
			$('#oAuiGrid_originDetermination_popup_failMaterial').hide();
			$('#originDetermination_popup_failSection').hide();
		};

		// 좌측에서 선택한 그룹(품번/품명)에 속한 라인 전체를 판정 품목 그리드에 나열.
		// 행 클릭은 createAUIGrid에서 selectDetailLine으로 한 번만 바인딩해뒀다
		this.renderDetailList = function(lines) {
			var self = this;
			var data = (lines || []).map(function(line) {
				var detail = self.detailMap[self.buildKey(line.sales_no, line.sales_seq)] || {};
				return {
					sales_no: line.sales_no,
					sales_seq: line.sales_seq,
					product_code: detail.product_code,
					product_name: detail.product_name,
					hs_code: detail.hs_code,
					quantity: detail.quantity,
					unit: detail.unit,
					unit_price: detail.unit_price,
					amount: detail.amount
				};
			});

			AUIGrid.setGridData(this.grid_Detail, data);
		};

		// 판정완료 건의 판정결과(협정별)와 판정 상세내용(기준별)을 한 번에 조회.
		// 판정 상세내용은 협정(FTA_CODE)마다 별도 호출하지 않고, 여기서 받은 detailList 를
		// fta_code 로 매핑해 화면에서 바로 보여준다(selectResultRow 참고)
		this.retrieveResultList = function(row) {
			var self = this;
			var request = { sales_no: row.sales_no, sales_seq: row.sales_seq };

			KpackageOBJ.ajax.doSubmit(
				'/origin/compliance/origindetermination/originDeterminationDetailResultList',
				request,
				function(response) {
					var value = (response && response.value) ? response.value : {};
					self.currentDetailList = value.detailList || [];
					self.renderResultList(value.resultList || []);
				}
			);
		};

		// 판정결과 그리드 렌더링. 행 클릭은 createAUIGrid에서 selectResultRow로 한 번만 바인딩해뒀다
		this.renderResultList = function(list) {
			$('#originDetermination_popup_resultSection').show();
			// AUIGrid는 부모가 display:none인 상태로 생성/resize되면 크기를 제대로 못 잡는다(다른 주석 참고).
			// 숨겨져 있다가 지금 막 보이게 된 경우를 대비해 다시 계산해준다.
			AUIGrid.resize(this.grid_Result);
			AUIGrid.resize(this.grid_ResultDetail);
			AUIGrid.setGridData(this.grid_Result, list || []);
			AUIGrid.setGridData(this.grid_ResultDetail, []);
		};

		// 판정결과 그리드에서 협정(FTA_CODE) 행을 클릭하면, 별도 API 호출 없이
		// retrieveResultList에서 이미 받아둔 currentDetailList를 그 fta_code로 필터링해
		// 판정 상세내용 그리드에 보여준다
		this.selectResultRow = function(ftaCode) {
			var filtered = this.currentDetailList.filter(function(d) {
				return d.fta_code === ftaCode;
			});
			this.renderResultDetailList(filtered);
		};

		// 미소기준 적용금액/판매금액/미상 재료비/부가가치 비율/결정기준 해설은 API가 아직 제공하지 않아 빈 칸으로 남는다
		this.renderResultDetailList = function(list) {
			AUIGrid.setGridData(this.grid_ResultDetail, list || []);
		};

		// 판정실패(status=5) 건의 실패 사유(협정/룰별)와, 그 사유(FTA_CODE)별 상세내용(룰 전체 처리결과)/
		// 원재료 목록을 한 번에 조회. retrieveResultList와 동일한 패턴 - 상세내용/원재료 목록은 fta_code마다
		// 별도 호출하지 않고 여기서 받은 목록을 fta_code로 매핑해 화면에서 바로 보여준다(selectFailReasonRow 참고)
		this.retrieveFailList = function(row) {
			var self = this;
			var request = { sales_no: row.sales_no, sales_seq: row.sales_seq };

			KpackageOBJ.ajax.doSubmit(
				'/origin/compliance/origindetermination/originDeterminationFailList',
				request,
				function(response) {
					var value = (response && response.value) ? response.value : {};
					self.currentFailDetailList = value.detailList || [];
					self.currentFailMaterialList = value.materialList || [];
					self.renderFailReasonList(value.reasonList || []);
				}
			);
		};

		// 실패 사유 그리드 렌더링. 행 클릭은 createAUIGrid에서 selectFailReasonRow로 한 번만 바인딩해뒀다
		this.renderFailReasonList = function(list) {
			$('#originDetermination_popup_failSection').show();
			AUIGrid.resize(this.grid_FailReason);
			AUIGrid.resize(this.grid_FailDetail);
			AUIGrid.resize(this.grid_FailMaterial);
			AUIGrid.setGridData(this.grid_FailReason, list || []);
			AUIGrid.setGridData(this.grid_FailDetail, []);
			AUIGrid.setGridData(this.grid_FailMaterial, []);
			$('#oAuiGrid_originDetermination_popup_failDetail').show();
			$('#oAuiGrid_originDetermination_popup_failMaterial').hide();
		};

		// 실패 사유 그리드에서 행을 클릭하면, 별도 API 호출 없이 retrieveFailList에서 이미 받아둔 목록을
		// 그 fta_code로 필터링해 보여준다. error_code가 MATERIAL_DETAIL_ERROR_CODES(HS코드 누락/금액 0)에
		// 해당하면 판정 상세내용 대신 원재료 목록을 보여준다
		this.selectFailReasonRow = function(reasonRow) {
			var ftaCode = reasonRow.fta_code;

			if (this.MATERIAL_DETAIL_ERROR_CODES.indexOf(reasonRow.error_code) !== -1) {
				var materials = this.currentFailMaterialList.filter(function(d) {
					return d.fta_code === ftaCode;
				});
				this.renderFailMaterialList(materials);
				return;
			}

			var filtered = this.currentFailDetailList.filter(function(d) {
				return d.fta_code === ftaCode;
			});
			this.renderFailDetailList(filtered);
		};

		this.renderFailDetailList = function(list) {
			$('#oAuiGrid_originDetermination_popup_failDetail').show();
			$('#oAuiGrid_originDetermination_popup_failMaterial').hide();
			AUIGrid.setGridData(this.grid_FailDetail, list || []);
		};

		this.renderFailMaterialList = function(list) {
			$('#oAuiGrid_originDetermination_popup_failDetail').hide();
			$('#oAuiGrid_originDetermination_popup_failMaterial').show();
			AUIGrid.resize(this.grid_FailMaterial);
			AUIGrid.setGridData(this.grid_FailMaterial, list || []);
		};

		// 내수는 (invoice_month, customer_code, division_code, product_code) 라인 목록으로
		// executeDomesticOriginDetermination을, 수출은 (sales_no, division_code) 목록으로
		// executeExportOriginDetermination을 호출한다 - 응답 형태(groupCount/failedTargets)는
		// 동일해서 처리(handleExecuteResponse)는 공용으로 쓴다.
		// 주의: 판정상태(status) 배지는 좌측 목록(datas)이 팝업을 열 때 넘어온 값을 그대로 쓰고 있어,
		// 여기서는 갱신하지 않는다 - 최신 판정상태를 보려면 팝업을 닫고 다시 열어야 한다.
		this.executeOriginDetermination = function(rows) {
			var self = this;
			var url;
			var request;

			if (this.mode === 'export') {
				url = '/origin/compliance/origindetermination/executeExportOriginDetermination';
				request = {
					datas: rows.map(function(row) {
						return { sales_no: row.sales_no, division_code: row.division_code };
					})
				};
			} else {
				url = '/origin/compliance/origindetermination/executeDomesticOriginDetermination';
				request = {
					datas: rows.map(function(row) {
						return {
							invoice_month: row.invoice_month,
							customer_code: row.customer_code,
							division_code: row.division_code,
							product_code: row.product_code
						};
					})
				};
			}

			KpackageOBJ.ajax.doSubmit(
				url,
				request,
				function(response) {
					self.handleExecuteResponse(response);
				}
			);
		};

		// executeOriginDetermination 응답(내수/수출 공용) 처리: 결과 메시지 표시 후 좌측 목록/상세
		// 전체를 다시 조회해 최신화한다(선택 중이던 라인이 남아있으면 그 라인을 그대로 유지).
		this.handleExecuteResponse = function(response) {
			var value = (response && response.value) ? response.value : {};
			var failedCount = value.failedTargets ? value.failedTargets.length : 0;
			var message = (value.groupCount || 0) + "건 원산지 판정을 진행했습니다.";

			if (failedCount > 0) {
				message += " (실패 " + failedCount + "건)";
			}

			KpackageOBJ.object.alert(message);

			this.retrieveDetailList();
		};

		// 우측의 모든 품목을 대상으로 원산지 판정 진행
		this.bulkOriginDetermination = function() {
			if (this.datas.length === 0) {
				KpackageOBJ.object.alert("판정할 품목이 없습니다.");
				return;
			}

			this.executeOriginDetermination(this.datas);
		};

		// 우측 "판정 품목"에서 선택한 라인 1건만 대상으로 원산지 판정 진행
		this.individualOriginDetermination = function() {
			if (!this.selectedLineKey) {
				KpackageOBJ.object.alert("판정할 품목을 선택하세요.");
				return;
			}

			var selectedRow = this.findSelectedRow();
			if (!selectedRow) {
				return;
			}

			this.executeOriginDetermination([selectedRow]);
		};

		// 좌측 목록(lineItems)에서 현재 선택된(selectedLineKey) 라인을 찾음
		this.findSelectedRow = function() {
			return this.findRowByKey(this.selectedLineKey);
		};
		
		// BOM 추적: 이 협정 판정에 실제로 쓰인 BOM(제품코드 + BOM_DIVISION_CODE + BOM_YYYYMM - CREATE_FCR가
		// SALES_DTL에 남겨둔, 실제 채택된 실적/타 사업장 BOM 기준)을 팝업으로 보여준다.
		// 조회 자체는 기존 FTA BOM 화면이 쓰는 API(/origin/compliance/ftaBom/ftaBomDetailList)를 그대로 재사용한다
		this.getBomTraceList = function (row) {
			if (!row.bom_division_code || !row.bom_yyyymm) {
				KpackageOBJ.object.alert("조회된 BOM이 없습니다.");
				return;
			}

			var getParam = "?product_code=" + encodeURIComponent(row.product_code)
				+ "&division_code=" + encodeURIComponent(row.bom_division_code)
				+ "&yyyymm=" + encodeURIComponent(row.bom_yyyymm);
			KpackageOBJ.sidepanel.open('bomTraceListPopup', '/origin/compliance/origindetermination/bomTraceList_popup' + getParam, '1000px', true);
		};
		
		this.getConversionStrategy = function () {
				
		};
	};

	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		ORIGIN_DETERMINATION_DETAIL_POPUP.Initialize_viewObject();
	});
</script>

</html>
