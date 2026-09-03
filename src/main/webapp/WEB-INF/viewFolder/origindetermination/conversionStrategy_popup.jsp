<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	.conversion-strategy-header {
		border: 1px dashed #ced4da;
		border-radius: 4px;
		padding: 12px 16px;
		margin-bottom: 8px;
	}
	.conversion-strategy-header-row {
		display: flex;
		font-size: 13px;
		padding: 3px 0;
	}
	.conversion-strategy-header-label {
		width: 90px;
		flex: 0 0 90px;
		color: #6c757d;
	}
	.conversion-strategy-header-value {
		font-weight: 600;
	}
	.conversion-strategy-section-title {
		font-size: 14px;
		font-weight: bold;
		margin: 16px 0 8px 0;
	}
	.conversion-strategy-empty {
		color: #6c757d;
		font-size: 13px;
		padding: 8px 0;
	}
</style>
</head>
<body>
	<div class="modal-header">
		<h5 class="modal-title h4">역내전환전략</h5>
		<div class="ms-auto d-flex align-items-center gap-2">
			<button type="button" class="btn btn-system" data-bs-dismiss="modal" aria-label="Close">
				<svg class="sa-icon sa-icon-2x">
                      <use href="/rcs/ui5x/img/sprite.svg#x"></use>
                  </svg>
			</button>
		</div>
	</div>
	<div class="modal-body">
		<div class="conversion-strategy-header">
			<div class="conversion-strategy-header-row"><span class="conversion-strategy-header-label">품번</span><span class="conversion-strategy-header-value" id="conversionStrategy_productCode">-</span></div>
			<div class="conversion-strategy-header-row"><span class="conversion-strategy-header-label">품명</span><span class="conversion-strategy-header-value" id="conversionStrategy_productName">-</span></div>
			<div class="conversion-strategy-header-row"><span class="conversion-strategy-header-label">협정명</span><span class="conversion-strategy-header-value" id="conversionStrategy_ftaName">-</span></div>
			<div class="conversion-strategy-header-row"><span class="conversion-strategy-header-label">HS CODE</span><span class="conversion-strategy-header-value" id="conversionStrategy_hsCode">-</span></div>
			<div class="conversion-strategy-header-row"><span class="conversion-strategy-header-label">PSR</span><span class="conversion-strategy-header-value" id="conversionStrategy_psr">-</span></div>
			<div class="conversion-strategy-header-row"><span class="conversion-strategy-header-label">판매가격</span><span class="conversion-strategy-header-value" id="conversionStrategy_amount">-</span></div>
		</div>
		<div id="conversionStrategy_cthSection">
			<div class="conversion-strategy-section-title">세번변경기준 충족을 위해 원산지확인서 수취가 필요한 대상은 아래와 같습니다.</div>
			<div id="oAuiGrid_conversionStrategy_cth" style="width:100%;height:220px;"></div>
		</div>
		<div id="conversionStrategy_valueSection">
			<div class="conversion-strategy-section-title">부가가치기준 충족을 위해 원산지확인서 수취가 필요한 대상은 아래와 같습니다.</div>
			<div id="oAuiGrid_conversionStrategy_value" style="width:100%;height:220px;"></div>
		</div>
		<div id="conversionStrategy_emptyMessage" class="conversion-strategy-empty" hidden>원산지확인서 수취로 전환 가능한 원재료가 없습니다.</div>
	</div>
</body>
<script>
	var CONVERSION_STRATEGY_POPUP = new function() {
		this.grid_Cth = null;
		this.grid_Value = null;

		this.createAUIGrid = function() {
			var CTHColumns = [
				{dataField: "item_code", headerText: "원재료 품번", width: 160, filter: {showIcon: true}},
				{dataField: "item_name", headerText: "품명", width: 220, filter: {showIcon: true}},
				{dataField: "hs_code", headerText: "HS CODE", width: 120, filter: {showIcon: true}},
				{dataField: "vendor_name", headerText: "구매처", width: 160, filter: {showIcon: true}},
				{dataField: "from_date", headerText: "수취 필요 포괄기간(시작)", width: 160, dataType: "date"},
				{dataField: "to_date", headerText: "수취 필요 포괄기간(종료)", width: 160, dataType: "date"}
			];
			
			var RVCColumns = [
				{dataField: "item_code", headerText: "원재료 품번", width: 160, filter: {showIcon: true}},
				{dataField: "item_name", headerText: "품명", width: 220, filter: {showIcon: true}},
				{dataField: "hs_code", headerText: "HS CODE", width: 120, filter: {showIcon: true}},
				{dataField: "vendor_name", headerText: "구매처", width: 160, filter: {showIcon: true}},
				{dataField: "from_date", headerText: "수취 필요 포괄기간(시작)", width: 160, dataType: "date"},
				{dataField: "to_date", headerText: "수취 필요 포괄기간(종료)", width: 160, dataType: "date"},
				{dataField: "rank", headerText: "재료비 비중 순위", width: 120, dataType: "numeric"}
			];

			var gridProps = { enableFilter: true };
			this.grid_Cth = KpackageOBJ.auiGrid.create("oAuiGrid_conversionStrategy_cth", vendorColumns, gridProps, "");
			this.grid_Value = KpackageOBJ.auiGrid.create("oAuiGrid_conversionStrategy_value", valueColumns, gridProps, "");
		};

		// bomTraceList_popup과 동일한 이유(모달 show() 이전에 그리드가 생성돼 좁게 그려지는 문제)로
		// shown.bs.modal 시점에 다시 resize한다
		this.bindModalShownResize = function() {
			var self = this;
			var $modal = $('#oAuiGrid_conversionStrategy_cth').closest('.modal');

			var resize = function() {
				AUIGrid.resize(self.grid_Cth);
				AUIGrid.resize(self.grid_Value);
			};

			if ($modal.hasClass('show')) {
				resize();
				return;
			}

			$modal.one('shown.bs.modal', resize);
		};

		// 대상 협정명은 조회 없이 팝업을 열 때 넘어온 값으로 바로 표시(bomTraceList_popup과 동일한 패턴)
		this.renderFtaName = function() {
			var ftaName = '${fta_name}';
			$('#conversionStrategy_ftaName').text(ftaName || '-');
		};

		this.retrieveConversionStrategyTargets = function() {
			var params = {
				sales_no: '${sales_no}',
				sales_seq: '${sales_seq}',
				fta_code: '${fta_code}'
			};

			KpackageOBJ.ajax.doSubmit(
				'/origin/compliance/origindetermination/conversionStrategyTargetList',
				params,
				function(response) {
					var value = (response && response.value) ? response.value : {};
					CONVERSION_STRATEGY_POPUP.renderHeader(value.header || {});
					CONVERSION_STRATEGY_POPUP.renderCthSection(value.cthTargetList || []);
					CONVERSION_STRATEGY_POPUP.renderValueSection(value.valueTargetList || []);
					CONVERSION_STRATEGY_POPUP.toggleEmptyMessage(value.cthTargetList, value.valueTargetList);
				}
			);
		};

		this.renderHeader = function(header) {
			$('#conversionStrategy_productCode').text(header.product_code || '-');
			$('#conversionStrategy_productName').text(header.product_name || '-');
			$('#conversionStrategy_hsCode').text(header.hs_code || '-');
			$('#conversionStrategy_psr').text(header.psr || '-');
			$('#conversionStrategy_amount').text(header.amount != null ? KpackageOBJ.formatter.commas(Math.round(header.amount)) + '원' : '-');
		};

		// 대상이 없어도 섹션(그리드) 자체는 항상 보여주고, 그리드가 빈 상태로 표시되게 한다
		this.renderCthSection = function(list) {
			AUIGrid.setGridData(this.grid_Cth, list);
		};

		this.renderValueSection = function(list) {
			list.forEach(function(row, index) {
				row.rank = index + 1;
			});
			AUIGrid.setGridData(this.grid_Value, list);
		};

		this.toggleEmptyMessage = function(cthTargetList, valueTargetList) {
			var isEmpty = (!cthTargetList || cthTargetList.length === 0) && (!valueTargetList || valueTargetList.length === 0);
			$('#conversionStrategy_emptyMessage').prop('hidden', !isEmpty);
		};
	};

	$(document).ready(function() {
		CONVERSION_STRATEGY_POPUP.createAUIGrid();
		CONVERSION_STRATEGY_POPUP.bindModalShownResize();
		CONVERSION_STRATEGY_POPUP.renderFtaName();
		CONVERSION_STRATEGY_POPUP.retrieveConversionStrategyTargets();
	});
</script>
</html>
