<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	/* 원산지 판정(내수) 화면 상단 통계(.origin-stat-*)와 동일한 스타일 */
	.bom-trace-stat-box {
		min-width: 90px;
	}
	.bom-trace-stat-label {
		font-size: 12px;
		color: #6c757d;
		margin-bottom: 2px;
	}
	.bom-trace-stat-value {
		font-size: 22px;
		font-weight: bold;
		margin-bottom: 0;
	}
</style>
</head>
<body>
	<div class="modal-header">
		<h5 class="modal-title h4">BOM 추적</h5>
		<div class="ms-auto d-flex align-items-center gap-2">
			<button type="button" class="btn btn-system" data-bs-dismiss="modal" aria-label="Close">
				<svg class="sa-icon sa-icon-2x">
                      <use href="/rcs/ui5x/img/sprite.svg#x"></use>
                  </svg>
			</button>
		</div>
	</div>
	<div class="modal-body">
		<div class="row mb-3">
			<div class="col-3 d-flex flex-column justify-content-center bom-trace-stat-box">
				<label class="bom-trace-stat-label mb-0">대상 협정</label>
				<h4 class="bom-trace-stat-value mb-0" id="bomTraceStat_ftaName">-</h4>
			</div>
			<div class="col-3 d-flex flex-column justify-content-center bom-trace-stat-box">
				<label class="bom-trace-stat-label mb-0">역내산 재료비</label>
				<h4 class="bom-trace-stat-value mb-0" id="bomTraceStat_inarea">0</h4>
			</div>
			<div class="col-3 d-flex flex-column justify-content-center bom-trace-stat-box">
				<label class="bom-trace-stat-label mb-0">비역내 재료비</label>
				<h4 class="bom-trace-stat-value mb-0" id="bomTraceStat_outarea">0</h4>
			</div>
			<div class="col-3 d-flex flex-column justify-content-center bom-trace-stat-box">
				<label class="bom-trace-stat-label mb-0">총 재료비</label>
				<h4 class="bom-trace-stat-value mb-0" id="bomTraceStat_total">0</h4>
			</div>
		</div>
		<div id="oAuiGrid_bomTraceList" style="width:100%;height:400px;"></div>
	</div>
</body>
<script>
	var BOM_TRACE_LIST_POPUP = new function() {
		this.grid_BomTrace = null;

		// 이 협정(fta_code) 판정 계산에 실제로 쓰인 최종 원재료(FCR_DTL) 목록
		this.createAUIGrid = function() {
			var columnLayout = [
				{dataField: "fta_code", headerText: "FTA_CODE", width: 0, visible: false},
				{dataField: "item_code", headerText: "품목코드", width: 220, filter: {showIcon: true}},
				{dataField: "item_name", headerText: "품명", width: 320, filter: {showIcon: true}},
				{dataField: "hs_code", headerText: "HS CODE", width: 130, filter: {showIcon: true}},
				{dataField: "requirement_qty", headerText: "소요량", width: 110, dataType: "numeric"},
				{dataField: "input_amount", headerText: "투입금액", width: 140, dataType: "numeric", formatString: "#,##0"},
				{dataField: "inarea_qty", headerText: "역내수량", width: 110, dataType: "numeric"},
				{dataField: "inarea_amount", headerText: "역내금액", width: 140, dataType: "numeric", formatString: "#,##0"},
				{dataField: "outarea_qty", headerText: "역외수량", width: 110, dataType: "numeric"},
				{dataField: "outarea_amount", headerText: "역외금액", width: 140, dataType: "numeric", formatString: "#,##0"}
			];
			var gridProps = { enableFilter: true };
			this.grid_BomTrace = KpackageOBJ.auiGrid.create("oAuiGrid_bomTraceList", columnLayout, gridProps, "");
		};

		// 이 팝업은 KpackageOBJ.sidepanel.open이 부트스트랩 모달을 아직 show() 하기 전에 콘텐츠를 주입하고
		// 그 안에서 그리드를 생성하므로, 생성 시점엔 모달이 아직 안 보인 상태라 AUIGrid가 실제 너비를 못 잡고
		// 좁게 축소되어 그려진다(originDeterminationDetail_popup.jsp의 동일 이슈 참고). show() 이후
		// (shown.bs.modal) 시점에 다시 resize해준다
		this.bindModalShownResize = function() {
			var self = this;
			var $modal = $('#oAuiGrid_bomTraceList').closest('.modal');

			if ($modal.hasClass('show')) {
				AUIGrid.resize(self.grid_BomTrace);
				return;
			}

			$modal.one('shown.bs.modal', function() {
				AUIGrid.resize(self.grid_BomTrace);
			});
		};

		// 대상 협정 이름은 조회 없이 팝업을 열 때 넘어온 값으로 바로 표시(fta_name이 비어있으면 fta_code로 대체)
		this.renderTargetFta = function() {
			var ftaName = '${fta_name}';
			var ftaCode = '${fta_code}';
			$('#bomTraceStat_ftaName').text(ftaName || ftaCode || '-');
		};

		// KpackageOBJ.auiGrid.retrieve는 그리드에 데이터만 채워주고 응답 목록을 돌려주지 않아, 통계(역내/비역내/
		// 총 재료비 합산)도 같이 계산해야 하는 여기서는 KpackageOBJ.ajax.doSubmit을 직접 써서 응답을 받는다
		this.retrieveBomTraceList = function() {
			var params = {
				sales_no: '${sales_no}',
				sales_seq: '${sales_seq}',
				fta_code: '${fta_code}'
			};

			KpackageOBJ.ajax.doSubmit(
				'/origin/compliance/origindetermination/originDeterminationMaterialList',
				params,
				function(response) {
					var list = (response && Array.isArray(response.value)) ? response.value : [];
					AUIGrid.setGridData(BOM_TRACE_LIST_POPUP.grid_BomTrace, list);
					BOM_TRACE_LIST_POPUP.updateStats(list);
				}
			);
		};

		// 조회된 원재료 목록으로 역내산/비역내/총 재료비(각각 inarea_amount/outarea_amount/input_amount 합산)를 표시
		this.updateStats = function(list) {
			var inareaSum = 0;
			var outareaSum = 0;
			var totalSum = 0;

			(list || []).forEach(function(row) {
				inareaSum += Number(row.inarea_amount) || 0;
				outareaSum += Number(row.outarea_amount) || 0;
				totalSum += Number(row.input_amount) || 0;
			});

			$('#bomTraceStat_inarea').text(KpackageOBJ.formatter.commas(Math.round(inareaSum)));
			$('#bomTraceStat_outarea').text(KpackageOBJ.formatter.commas(Math.round(outareaSum)));
			$('#bomTraceStat_total').text(KpackageOBJ.formatter.commas(Math.round(totalSum)));
		};
	};

	$(document).ready(function() {
		BOM_TRACE_LIST_POPUP.createAUIGrid();
		BOM_TRACE_LIST_POPUP.bindModalShownResize();
		BOM_TRACE_LIST_POPUP.renderTargetFta();
		BOM_TRACE_LIST_POPUP.retrieveBomTraceList();
	});
</script>
</html>
