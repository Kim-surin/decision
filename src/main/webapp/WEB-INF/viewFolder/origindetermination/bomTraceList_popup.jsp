<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	.bom-trace-context {
		color: #6c757d;
		font-size: 13px;
		margin-bottom: 12px;
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
		<div class="bom-trace-context">
			SALES_NO: ${sales_no} &nbsp;|&nbsp; SALES_SEQ: ${sales_seq} &nbsp;|&nbsp; FTA_CODE: ${fta_code}
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

		this.retrieveBomTraceList = function() {
			var params = {
				sales_no: '${sales_no}',
				sales_seq: '${sales_seq}',
				fta_code: '${fta_code}'
			};

			KpackageOBJ.auiGrid.retrieve(this.grid_BomTrace, '/origin/compliance/origindetermination/originDeterminationMaterialList', params);
		};
	};

	$(document).ready(function() {
		BOM_TRACE_LIST_POPUP.createAUIGrid();
		BOM_TRACE_LIST_POPUP.bindModalShownResize();
		BOM_TRACE_LIST_POPUP.retrieveBomTraceList();
	});
</script>
</html>
