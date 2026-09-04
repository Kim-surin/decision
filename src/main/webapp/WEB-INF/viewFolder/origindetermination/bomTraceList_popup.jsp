<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="/rcs/js/chartjs_v451/chart.js"></script>
<script src="/rcs/js/package.chartjs.utils.js"></script>
<style>
	/* 역내전환전략 팝업 상단(.conversion-strategy-header-*)과 동일한 구조/글자크기 */
	.bom-trace-header {
		display: flex;
		gap: 24px;
		border: 1px dashed #ced4da;
		border-radius: 4px;
		padding: 12px 16px;
		margin-bottom: 8px;
	}
	.bom-trace-header-left {
		flex: 0 0 500px;
	}
	.bom-trace-header-right {
		flex: 1 1 auto;
		min-width: 0;
		display: flex;
		gap: 24px;
	}
	.bom-trace-header-row {
		display: flex;
		font-size: 13px;
		padding: 3px 0;
	}
	.bom-trace-header-label {
		width: 110px;
		flex: 0 0 110px;
		color: #6c757d;
	}
	.bom-trace-header-value {
		font-weight: 600;
	}
	.bom-trace-donut-card {
		flex: 1 1 0;
		display: flex;
		align-items: center;
		gap: 12px;
	}
	.bom-trace-donut {
		position: relative;
		width: 56px;
		height: 56px;
		flex: 0 0 56px;
	}
	.bom-trace-donut-label {
		font-size: 12px;
		color: #6c757d;
	}
	.bom-trace-donut-value {
		font-size: 20px;
		font-weight: 700;
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
		<div class="bom-trace-header">
			<div class="bom-trace-header-left">
				<div class="bom-trace-header-row"><span class="bom-trace-header-label">대상 협정</span><span class="bom-trace-header-value" id="bomTraceStat_ftaName">-</span></div>
				<div class="bom-trace-header-row"><span class="bom-trace-header-label">역내산 재료비</span><span class="bom-trace-header-value" id="bomTraceStat_inarea">0</span></div>
				<div class="bom-trace-header-row"><span class="bom-trace-header-label">비역내산 재료비</span><span class="bom-trace-header-value" id="bomTraceStat_outarea">0</span></div>
				<div class="bom-trace-header-row"><span class="bom-trace-header-label">총 재료비</span><span class="bom-trace-header-value" id="bomTraceStat_total">0</span></div>
			</div>
			<div class="bom-trace-header-right">
				<div class="bom-trace-donut-card">
					<div class="bom-trace-donut"><canvas id="bomTraceChart_inarea"></canvas></div>
					<div>
						<div class="bom-trace-donut-label">역내산 재료비 비율</div>
						<div class="bom-trace-donut-value" id="bomTraceStat_inareaRatio">-</div>
					</div>
				</div>
				<div class="bom-trace-donut-card">
					<div class="bom-trace-donut"><canvas id="bomTraceChart_outarea"></canvas></div>
					<div>
						<div class="bom-trace-donut-label">비역내산 재료비 비율</div>
						<div class="bom-trace-donut-value" id="bomTraceStat_outareaRatio">-</div>
					</div>
				</div>
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
		// 그 안에서 그리드를 생성하므로, 생성 시점엔 모달이 아직 안 보인 상태라 AUIGrid가 실제 너비를 못 잡고 좁게 축소되어 그려진다
		// show() 이후 (shown.bs.modal) 시점에 다시 resize해준다
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

		// 조회된 원재료 목록으로 역내산/비역내/총 재료비(각각 inarea_amount/outarea_amount/input_amount 합산)와
		// 역내산/비역내산 재료비 비율 도넛차트를 표시
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

			var inareaRatio = totalSum > 0 ? Math.round((inareaSum / totalSum) * 1000) / 10 : 0;
			var outareaRatio = totalSum > 0 ? Math.round((outareaSum / totalSum) * 1000) / 10 : 0;

			BOM_TRACE_LIST_POPUP.renderRatioChart('bomTraceChart_inarea', inareaRatio, '#22c55e');
			$('#bomTraceStat_inareaRatio').text(inareaRatio + '%');

			BOM_TRACE_LIST_POPUP.renderRatioChart('bomTraceChart_outarea', outareaRatio, '#f97316');
			$('#bomTraceStat_outareaRatio').text(outareaRatio + '%');
		};

		// 원산지 판정 결과 조회 화면의 통계 도넛차트(originStatChart)와 동일한 스타일(링 형태, 범례/툴팁 없음)
		this.renderRatioChart = function(canvasId, ratio, color) {
			var data = {
				labels: ['대상', '그 외'],
				datasets: [{
					data: [ratio, Math.max(0, 100 - ratio)],
					backgroundColor: [color, '#e5e7eb'],
					borderWidth: 0
				}]
			};

			ChartUtil.createDoughnut(canvasId, data, {
				cutout: '72%',
				plugins: {
					legend: { display: false },
					tooltip: { enabled: false }
				}
			});
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
