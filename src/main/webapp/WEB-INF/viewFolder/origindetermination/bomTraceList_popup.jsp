<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
		cursor: pointer;
		border-radius: 8px;
		padding: 4px 8px;
	}
	.bom-trace-donut-card:hover {
		background-color: #f8f9fa;
	}
	.bom-trace-donut-card.active {
		background-color: #eef3ff;
		box-shadow: inset 0 0 0 1px #4a6cf7;
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
				<div class="bom-trace-header-row"><span class="bom-trace-header-label"><spring:message code='TXT.TARGET_FTA'/></span><span class="bom-trace-header-value" id="bomTraceStat_ftaName">-</span></div> <!--대상 협정-->
				<div class="bom-trace-header-row"><span class="bom-trace-header-label"><spring:message code='TXT.INAREA_MATERIAL_COST'/></span><span class="bom-trace-header-value" id="bomTraceStat_inarea">0</span></div> <!--역내산 재료비-->
				<div class="bom-trace-header-row"><span class="bom-trace-header-label"><spring:message code='TXT.NON_INAREA_MATERIAL_COST'/></span><span class="bom-trace-header-value" id="bomTraceStat_outarea">0</span></div> <!--비역내산 재료비-->
				<div class="bom-trace-header-row"><span class="bom-trace-header-label"><spring:message code='TXT.TOTAL_MATERIAL_COST'/></span><span class="bom-trace-header-value" id="bomTraceStat_total">0</span></div> <!--총 재료비-->
			</div>
			<div class="bom-trace-header-right">
				<div class="bom-trace-donut-card" id="bomTraceDonutCard_inarea" onclick="javascript:BOM_TRACE_LIST_POPUP.filterByArea('inarea');">
					<div class="bom-trace-donut"><canvas id="bomTraceChart_inarea"></canvas></div>
					<div>
						<div class="bom-trace-donut-label"><spring:message code='TXT.INAREA_MATERIAL_COST_RATE'/></div> <!--역내산 재료비 비율-->
						<div class="bom-trace-donut-value" id="bomTraceStat_inareaRatio">-</div>
					</div>
				</div>
				<div class="bom-trace-donut-card" id="bomTraceDonutCard_outarea" onclick="javascript:BOM_TRACE_LIST_POPUP.filterByArea('outarea');">
					<div class="bom-trace-donut"><canvas id="bomTraceChart_outarea"></canvas></div>
					<div>
						<div class="bom-trace-donut-label"><spring:message code='TXT.NON_INAREA_MATERIAL_COST_RATE'/></div> <!--비역내산 재료비 비율-->
						<div class="bom-trace-donut-value" id="bomTraceStat_outareaRatio">-</div>
					</div>
				</div>
			</div>
		</div>
		<div id="oAuiGrid_bomTraceList" style="width:100%;height:600px;"></div>
	</div>
</body>
<script>
	var BOM_TRACE_LIST_POPUP = new function() {
		this.grid_BomTrace = null;
		// 마지막 조회 결과 전체(필터링 전) - 도넛차트 클릭 시 이걸 기준으로 그리드만 다시 필터링한다
		this.currentList = [];
		// 현재 선택된 영역('inarea'/'outarea'). 없으면 null
		this.activeAreaFilter = null;

		// updateStats의 합산 기준과 동일한 조건이어야 한다
		this.AREA_FILTERS = {
			inarea: function (row) { return (Number(row.inarea_amount) || 0) > 0; },
			outarea: function (row) { return (Number(row.outarea_amount) || 0) > 0; }
		};

		// 이 협정(fta_code) 판정 계산에 실제로 쓰인 최종 원재료(FCR_DTL) 목록
		this.createAUIGrid = function() {
			var columnLayout = [
				{dataField: "fta_code", headerText: "FTA_CODE", width: 0, visible: false},
				{dataField: "item_code", headerText: "<spring:message code='TXT.ITEM_CODE'/>", width: 220, filter: {showIcon: true}}, //품목코드
				{dataField: "item_name", headerText: "<spring:message code='TXT.ITEM_DESC'/>", width: 320, filter: {showIcon: true}}, //품명
				{dataField: "hs_code", headerText: "<spring:message code='TXT.HS_CODE'/>", width: 130, filter: {showIcon: true}}, //HS CODE
				{dataField: "requirement_qty", headerText: "<spring:message code='TXT.REQ_QUANTITY'/>", width: 110, dataType: "numeric"}, //소요량
				{dataField: "input_amount", headerText: "<spring:message code='TXT.INPUT_AMOUNT'/>", width: 140, dataType: "numeric", formatString: "#,##0"}, //투입금액
				{dataField: "inarea_qty", headerText: "<spring:message code='TXT.INAREA_QTY'/>", width: 110, dataType: "numeric"}, //역내수량
				{dataField: "inarea_amount", headerText: "<spring:message code='TXT.INAREA_AMOUNT'/>", width: 140, dataType: "numeric", formatString: "#,##0"}, //역내금액
				{dataField: "outarea_qty", headerText: "<spring:message code='TXT.OUTAREA_QTY'/>", width: 110, dataType: "numeric"}, //역외수량
				{dataField: "outarea_amount", headerText: "<spring:message code='TXT.OUTAREA_AMOUNT'/>", width: 140, dataType: "numeric", formatString: "#,##0"} //역외금액
			];
			var gridProps = { enableFilter: true };
			this.grid_BomTrace = KpackageOBJ.auiGrid.create("oAuiGrid_bomTraceList", columnLayout, gridProps, "");
		};

		// 모달이 아직 show()되기 전에 그리드가 생성돼 너비를 못 잡고 좁게 그려진다.
		// show() 이후(shown.bs.modal) 시점에 다시 resize해준다.
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

					BOM_TRACE_LIST_POPUP.currentList = list;
					BOM_TRACE_LIST_POPUP.activeAreaFilter = null;
					$('.bom-trace-donut-card').removeClass('active');

					AUIGrid.setGridData(BOM_TRACE_LIST_POPUP.grid_BomTrace, list);
					BOM_TRACE_LIST_POPUP.updateStats(list);
				}
			);
		};

		// 도넛차트 클릭: 이미 선택된 영역이면 필터를 풀고 전체를, 아니면 그 영역(역내산/비역내산)
		// 재료비가 있는 행만 그리드에 다시 채운다. 통계 수치는 조회 결과 전체 기준으로 그대로 둔다
		this.filterByArea = function (area) {
			var $card = $('#bomTraceDonutCard_' + area);

			if (BOM_TRACE_LIST_POPUP.activeAreaFilter === area) {
				BOM_TRACE_LIST_POPUP.activeAreaFilter = null;
				$('.bom-trace-donut-card').removeClass('active');
				AUIGrid.setGridData(BOM_TRACE_LIST_POPUP.grid_BomTrace, BOM_TRACE_LIST_POPUP.currentList);
				return;
			}

			var filtered = BOM_TRACE_LIST_POPUP.currentList.filter(BOM_TRACE_LIST_POPUP.AREA_FILTERS[area]);

			BOM_TRACE_LIST_POPUP.activeAreaFilter = area;
			$('.bom-trace-donut-card').removeClass('active');
			$card.addClass('active');
			AUIGrid.setGridData(BOM_TRACE_LIST_POPUP.grid_BomTrace, filtered);
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
