<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
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
		<div id="conversionStrategy_cthSection" hidden>
			<div class="conversion-strategy-section-title">세번변경기준 충족을 위해 원산지확인서 수취가 필요한 대상은 아래와 같습니다.</div>
			<div id="oAuiGrid_conversionStrategy_cth" style="width:100%;height:220px;"></div>
		</div>
		<div id="conversionStrategy_valueSection" hidden>
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
			var vendorColumns = [
				{dataField: "item_code", headerText: "원재료 품번", width: 160, filter: {showIcon: true}},
				{dataField: "item_name", headerText: "품명", width: 220, filter: {showIcon: true}},
				{dataField: "hs_code", headerText: "HS CODE", width: 120, filter: {showIcon: true}},
				{dataField: "vendor_name", headerText: "구매처", width: 160, filter: {showIcon: true}},
				{dataField: "from_date", headerText: "수취 필요 포괄기간(시작)", width: 160, dataType: "date"},
				{dataField: "to_date", headerText: "수취 필요 포괄기간(종료)", width: 160, dataType: "date"}
			];
			var valueColumns = [
				{dataField: "rank", headerText: "재료비 비중 순위", width: 120, dataType: "numeric"}
			].concat(vendorColumns);

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
					CONVERSION_STRATEGY_POPUP.renderCthSection(value.cthTargetList || []);
					CONVERSION_STRATEGY_POPUP.renderValueSection(value.valueTargetList || []);
					CONVERSION_STRATEGY_POPUP.toggleEmptyMessage(value.cthTargetList, value.valueTargetList);
				}
			);
		};

		this.renderCthSection = function(list) {
			var wasHidden = $('#conversionStrategy_cthSection').prop('hidden');
			$('#conversionStrategy_cthSection').prop('hidden', list.length === 0);
			AUIGrid.setGridData(this.grid_Cth, list);
			// 목록이 비동기로 도착해 섹션이 이제 막 보이게 된 시점엔 그리드가 그 전까지 계속 hidden
			// 컨테이너 안에 있었던 상태라 너비를 못 잡고 있다 - 다시 보이자마자 resize로 잡아준다
			if (wasHidden && list.length > 0) {
				AUIGrid.resize(this.grid_Cth);
			}
		};

		this.renderValueSection = function(list) {
			var wasHidden = $('#conversionStrategy_valueSection').prop('hidden');
			$('#conversionStrategy_valueSection').prop('hidden', list.length === 0);
			list.forEach(function(row, index) {
				row.rank = index + 1;
			});
			AUIGrid.setGridData(this.grid_Value, list);
			if (wasHidden && list.length > 0) {
				AUIGrid.resize(this.grid_Value);
			}
		};

		this.toggleEmptyMessage = function(cthTargetList, valueTargetList) {
			var isEmpty = (!cthTargetList || cthTargetList.length === 0) && (!valueTargetList || valueTargetList.length === 0);
			$('#conversionStrategy_emptyMessage').prop('hidden', !isEmpty);
		};
	};

	$(document).ready(function() {
		CONVERSION_STRATEGY_POPUP.createAUIGrid();
		CONVERSION_STRATEGY_POPUP.bindModalShownResize();
		CONVERSION_STRATEGY_POPUP.retrieveConversionStrategyTargets();
	});
</script>
</html>
