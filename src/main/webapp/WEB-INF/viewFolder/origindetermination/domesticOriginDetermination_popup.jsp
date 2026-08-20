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
	.origin-detail-main table {
		width: 100%;
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
			<button type="button" class="btn btn-sm btn-outline-primary" onclick="javascript:DOMESTIC_ORIGIN_DETERMINATION_POPUP.bulkOriginDetermination();">일괄 원산지 판정</button>
			<button type="button" class="btn btn-sm btn-primary" onclick="javascript:DOMESTIC_ORIGIN_DETERMINATION_POPUP.individualOriginDetermination();">개별 원산지 판정</button>
			<button type="button" class="btn btn-system" data-bs-dismiss="modal" aria-label="Close">
				<svg class="sa-icon sa-icon-2x">
                      <use href="/rcs/ui5x/img/sprite.svg#x"></use>
                  </svg>
			</button>
		</div>
	</div>
	<div class="modal-body p-0">
		<div class="origin-detail-split">
			<div class="origin-detail-sidebar list-group" id="domesticOriginDetermination_popup_sidebar">
			</div>
			<div class="origin-detail-main">
				<h6 class="mb-3">판정 품목</h6>
				<table class="table table-bordered table-sm">
					<thead class="table-light">
						<tr>
							<th>품번</th>
							<th>품명</th>
							<th>HS CODE</th>
							<th>수량</th>
							<th>단위</th>
							<th>단가(원)</th>
							<th>금액(원)</th>
						</tr>
					</thead>
					<tbody id="domesticOriginDetermination_popup_detailBody">
						<tr>
							<td colspan="7" class="origin-detail-empty">좌측에서 조회할 항목을 선택하세요.</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
<script>
	var DOMESTIC_ORIGIN_DETERMINATION_POPUP = new function() {
		// 좌측에서 체크되어 넘어온 판정 대상 목록 (invoice_month, product_code, product_name, sales_no, sales_seq 등)
		this.datas = [];
		// sales_no + '_' + sales_seq 를 key 로 하는 상세정보 맵
		this.detailMap = {};
		this.selectedKey = null;

		this.buildKey = function(salesNo, salesSeq) {
			return salesNo + "_" + salesSeq;
		};

		// KpackageOBJ.ajax.doSubmit는 통신 실패 시 항상 네이티브 alert()를 호출하는데,
		// 이 팝업은 Bootstrap 모달(sidepanel.open) 위에서 열려 있어 네이티브 alert()가
		// 모달 트랜지션을 끊어 백드롭이 안 사라지는 문제로 이어짐.
		// 그래서 이 팝업 내부 통신은 자체 헬퍼로 처리하고, 에러는 KpackageOBJ.object.alert로만 표시
		this.postJson = function(url, data, successHandler, errorHandler) {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");

			$.ajax({
				url: url,
				type: "POST",
				cache: false,
				data: JSON.stringify(data),
				contentType: "application/json; charset=utf-8",
				dataType: "json",
				beforeSend: function(xhr) {
					if (token && header) {
						xhr.setRequestHeader(header, token);
					}
				},
				success: successHandler,
				error: function() {
					if (typeof errorHandler === "function") {
						errorHandler();
					}
				}
			});
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

		// 시작점
		this.Initialize_viewObject = function() {
			var rawDatas = '${datas}';

			try {
				this.datas = rawDatas ? JSON.parse(rawDatas) : [];
			} catch (e) {
				this.datas = [];
			}

			this.renderSidebar();
			this.retrieveDetailList();
		};

		// 좌측 사이드바 렌더링 (매출년월/품번/품명)
		this.renderSidebar = function() {
			var $sidebar = $('#domesticOriginDetermination_popup_sidebar');
			$sidebar.empty();

			if (this.datas.length === 0) {
				$sidebar.append('<div class="origin-detail-empty">선택된 항목이 없습니다.</div>');
				return;
			}

			var self = this;
			this.datas.forEach(function(row) {
				var key = self.buildKey(row.sales_no, row.sales_seq);
				var statusClass = self.getStatusBadgeClass(row.status);

				var $item = $(
					'<a href="javascript:void(0)" class="list-group-item list-group-item-action" data-key="' + key + '">' +
						'<span class="badge bg-secondary">' + (row.invoice_month || '') + '</span> ' +
						'<span class="badge ' + statusClass + '">' + (row.status_name || '') + '</span>' +
						'<span class="item-product-code">' + (row.product_code || '') + '</span>' +
						'<span class="item-product-name">' + (row.product_name || '') + '</span>' +
					'</a>'
				);

				$item.on('click', function() {
					self.selectItem(key);
				});

				$sidebar.append($item);
			});
		};

		// 초기 진입 시, 체크되어 넘어온 모든 항목의 상세정보를 한번에 조회
		this.retrieveDetailList = function() {
			var self = this;

			var request = {
				datas: this.datas.map(function(row) {
					return { sales_no: row.sales_no, sales_seq: row.sales_seq };
				})
			};

			this.postJson(
				'/origin/compliance/origindetermination/domesticOriginDeterminationDetailList',
				request,
				function(response) {
					var list = (response && response.value) ? response.value : [];

					self.detailMap = {};
					list.forEach(function(row) {
						var key = self.buildKey(row.sales_no, row.sales_seq);
						self.detailMap[key] = row;
					});

					if (self.datas.length > 0) {
						self.selectItem(self.buildKey(self.datas[0].sales_no, self.datas[0].sales_seq));
					}
				},
				function() {
					KpackageOBJ.object.alert('판정 품목 상세 조회 중 오류가 발생했습니다.');
				}
			);
		};

		// 좌측 항목 선택 시, 우측 상세 렌더링
		this.selectItem = function(key) {
			this.selectedKey = key;

			$('#domesticOriginDetermination_popup_sidebar .list-group-item').removeClass('active');
			$('#domesticOriginDetermination_popup_sidebar .list-group-item[data-key="' + key + '"]').addClass('active');

			this.renderDetail(this.detailMap[key]);
		};

		this.renderDetail = function(detail) {
			var $body = $('#domesticOriginDetermination_popup_detailBody');
			$body.empty();

			if (!detail) {
				$body.append('<tr><td colspan="7" class="origin-detail-empty">상세 정보가 없습니다.</td></tr>');
				return;
			}

			var $row = $(
				'<tr>' +
					'<td>' + (detail.product_code || '') + '</td>' +
					'<td>' + (detail.product_name || '') + '</td>' +
					'<td>' + (detail.hs_code || '') + '</td>' +
					'<td class="text-end">' + (detail.quantity || '') + '</td>' +
					'<td>' + (detail.unit || '') + '</td>' +
					'<td class="text-end">' + (detail.unit_price || '') + '</td>' +
					'<td class="text-end">' + (detail.amount || '') + '</td>' +
				'</tr>'
			);

			$body.append($row);
		};

		// 우측의 모든 품목을 대상으로 원산지 판정 진행
		// TODO: 판정 백엔드(원산지 판정 로직) 병합 시 실제 API 연동 필요
		this.bulkOriginDetermination = function() {
			if (this.datas.length === 0) {
				KpackageOBJ.object.alert("판정할 품목이 없습니다.");
				return;
			}

			KpackageOBJ.object.alert(this.datas.length + "건 일괄 원산지 판정을 진행합니다.");
		};

		// 좌측에서 선택한 품목 1건만 대상으로 원산지 판정 진행
		// TODO: 판정 백엔드(원산지 판정 로직) 병합 시 실제 API 연동 필요
		this.individualOriginDetermination = function() {
			if (!this.selectedKey) {
				KpackageOBJ.object.alert("판정할 품목을 선택하세요.");
				return;
			}

			var selectedRow = this.findSelectedRow();

			KpackageOBJ.object.alert("선택한 품목 1건 원산지 판정을 진행합니다.");

			// 판정을 진행한 건은 결과가 바뀌므로, 판정 실행 후 해당 건만 재조회해 우측 상세를 최신화
			if (selectedRow) {
				this.refetchDetail(selectedRow);
			}
		};

		// 좌측 목록(datas)에서 현재 선택된(selectedKey) 항목의 원본 row 를 찾음
		this.findSelectedRow = function() {
			var self = this;
			return this.datas.filter(function(row) {
				return self.buildKey(row.sales_no, row.sales_seq) === self.selectedKey;
			})[0];
		};

		// 판정 실행 후, 해당 건 1개의 상세 결과만 다시 조회해 우측 화면을 최신화
		this.refetchDetail = function(row) {
			var self = this;
			var key = this.buildKey(row.sales_no, row.sales_seq);

			var request = {
				datas: [{ sales_no: row.sales_no, sales_seq: row.sales_seq }]
			};

			this.postJson(
				'/origin/compliance/origindetermination/domesticOriginDeterminationDetailList',
				request,
				function(response) {
					var list = (response && response.value) ? response.value : [];

					list.forEach(function(r) {
						self.detailMap[self.buildKey(r.sales_no, r.sales_seq)] = r;
					});

					if (self.selectedKey === key) {
						self.renderDetail(self.detailMap[key]);
					}
				},
				function() {
					KpackageOBJ.object.alert('판정 결과 재조회 중 오류가 발생했습니다.');
				}
			);
		};
	};

	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DOMESTIC_ORIGIN_DETERMINATION_POPUP.Initialize_viewObject();
	});
</script>

</html>
