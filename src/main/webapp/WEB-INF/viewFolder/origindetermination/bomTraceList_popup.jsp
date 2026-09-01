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
			제품코드: ${product_code} &nbsp;|&nbsp; BOM 사업장: ${division_code} &nbsp;|&nbsp; 기준년월: ${yyyymm}
		</div>
		<div id="oAuiGrid_bomTraceList" style="width:100%;height:400px;"></div>
	</div>
</body>
<script>
	var BOM_TRACE_LIST_POPUP = new function() {
		this.grid_BomTrace = null;

		this.createAUIGrid = function() {
			var columnLayout = [
				{dataField: "item_code", headerText: "자재코드", width: 250, filter: {showIcon: true}},
				{dataField: "item_name", headerText: "자재명", width: 550, filter: {showIcon: true}},
				{dataField: "unit", headerText: "단위", width: 120},
				{dataField: "hs_code", headerText: "HS코드", width: 200, filter: {showIcon: true}},
				{dataField: "req_qty", headerText: "사용수량", width: 150}
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

		// 기존 FTA BOM 화면(/origin/compliance/ftaBom/ftaBom)이 쓰는 상세조회 API를 그대로 재사용한다
		this.retrieveBomTraceList = function() {
			var params = {
				product_code: '${product_code}',
				division_code: '${division_code}',
				yyyymm: '${yyyymm}'
			};

			KpackageOBJ.auiGrid.retrieve(this.grid_BomTrace, '/origin/compliance/ftaBom/ftaBomDetailList', params);
		};
	};

	$(document).ready(function() {
		BOM_TRACE_LIST_POPUP.createAUIGrid();
		BOM_TRACE_LIST_POPUP.bindModalShownResize();
		BOM_TRACE_LIST_POPUP.retrieveBomTraceList();
	});
</script>
</html>
