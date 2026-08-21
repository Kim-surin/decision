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
		/* 셀 내용 길이에 따라 컬럼 너비가 항목마다 달라지지 않도록 고정.
		   실제 너비는 각 표의 thead th에 지정한 width(%) 값을 따름 */
		table-layout: fixed;
	}
	.origin-detail-main th,
	.origin-detail-main td {
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	.origin-detail-empty {
		color: #6c757d;
		text-align: center;
		padding: 40px 0;
	}
	.origin-result-row {
		cursor: pointer;
	}
	.origin-result-detail-row > td {
		padding: 0;
	}
	.origin-result-detail-inline {
		padding: 20px 24px;
		background-color: #f8f9fa;
		border-top: 2px solid #4a6cf7;
	}
	.origin-result-detail-inline table {
		background-color: #fff;
		table-layout: auto;
	}
	.origin-result-detail-inline table th,
	.origin-result-detail-inline table td {
		white-space: normal;
		overflow: visible;
		text-overflow: clip;
		padding: 10px 12px;
		vertical-align: middle;
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
					<button type="button" class="btn btn-sm btn-primary" onclick="javascript:ORIGIN_DETERMINATION_DETAIL_POPUP.individualOriginDetermination();">개별 원산지 판정</button>
				</div>
				<table class="table table-bordered table-sm">
					<thead class="table-light">
						<tr>
							<th style="width:15%">품번</th>
							<th style="width:25%">품명</th>
							<th style="width:12%">HS CODE</th>
							<th style="width:10%">수량</th>
							<th style="width:8%">단위</th>
							<th style="width:15%">단가(원)</th>
							<th style="width:15%">금액(원)</th>
						</tr>
					</thead>
					<tbody id="originDetermination_popup_detailBody">
						<tr>
							<td colspan="7" class="origin-detail-empty">좌측에서 조회할 항목을 선택하세요.</td>
						</tr>
					</tbody>
				</table>

				<div id="originDetermination_popup_resultSection" style="display:none;">
					<h6 class="mt-4 mb-3">판정결과</h6>
					<table class="table table-bordered table-sm">
						<thead class="table-light">
							<tr>
								<th style="width:9%">HS CODE</th>
								<th style="width:11%">협정명</th>
								<th style="width:8%">단가</th>
								<th style="width:8%">단가기준</th>
								<th style="width:10%">결정기준</th>
								<th style="width:8%">충족여부</th>
								<th style="width:12%">판정 부가가치 비율</th>
								<th style="width:12%">미소기준 적용 비율</th>
								<th style="width:11%">BOM 추적</th>
								<th style="width:11%">역내전환전략</th>
							</tr>
						</thead>
						<tbody id="originDetermination_popup_resultBody">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	var ORIGIN_DETERMINATION_DETAIL_POPUP = new function() {
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
			var $sidebar = $('#originDetermination_popup_sidebar');
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
				'/origin/compliance/origindetermination/originDeterminationDetailList',
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

			$('#originDetermination_popup_sidebar .list-group-item').removeClass('active');
			$('#originDetermination_popup_sidebar .list-group-item[data-key="' + key + '"]').addClass('active');

			this.renderDetail(this.detailMap[key]);

			// 판정완료(status=4) 건만 판정결과/판정 상세내용 섹션을 보여줌
			var row = this.findRowByKey(key);
			if (row && this.isDetermined(row.status)) {
				this.retrieveResultList(row);
			} else {
				this.hideResultSections();
			}
		};

		// 좌측 목록(datas)에서 key에 해당하는 원본 row 를 찾음
		this.findRowByKey = function(key) {
			var self = this;
			return this.datas.filter(function(row) {
				return self.buildKey(row.sales_no, row.sales_seq) === key;
			})[0];
		};

		this.isDetermined = function(status) {
			return String(status) === "4";
		};

		this.hideResultSections = function() {
			$('#originDetermination_popup_resultSection').hide();
		};

		this.renderDetail = function(detail) {
			var $body = $('#originDetermination_popup_detailBody');
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

		// 판정완료 건의 판정결과(협정별) 조회
		this.retrieveResultList = function(row) {
			var self = this;
			var request = { sales_no: row.sales_no, sales_seq: row.sales_seq };

			this.postJson(
				'/origin/compliance/origindetermination/originDeterminationResultList',
				request,
				function(response) {
					var list = (response && response.value) ? response.value : [];
					self.renderResultList(list, row);
				},
				function() {
					KpackageOBJ.object.alert('판정결과 조회 중 오류가 발생했습니다.');
				}
			);
		};

		// 판정결과 렌더링 (협정 행 클릭 시 그 행 바로 아래에 판정 상세내용을 펼침)
		this.renderResultList = function(list, row) {
			var self = this;
			var $body = $('#originDetermination_popup_resultBody');
			$body.empty();
			$('#originDetermination_popup_resultSection').show();

			if (list.length === 0) {
				$body.append('<tr><td colspan="10" class="origin-detail-empty">판정결과가 없습니다.</td></tr>');
				return;
			}

			list.forEach(function(r) {
				// 단가기준/BOM 추적/역내전환전략은 현재 제공되는 값이 없어 빈 칸으로 출력
				var $tr = $(
					'<tr class="origin-result-row">' +
						'<td>' + (r.hs_code || '') + '</td>' +
						'<td>' + (r.fta_name || '') + '</td>' +
						'<td class="text-end">' + (r.amount || '') + '</td>' +
						'<td></td>' +
						'<td>' + (r.rule_contents || '') + '</td>' +
						'<td>' + (r.company_coo_yn || '') + '</td>' +
						'<td class="text-end">' + (r.rvc_rate || '') + '</td>' +
						'<td class="text-end">' + (r.de_minimis_rate || '') + '</td>' +
						'<td></td>' +
						'<td></td>' +
					'</tr>'
				);

				$tr.on('click', function() {
					self.toggleResultDetailRow($tr, row, r.fta_code);
				});

				$body.append($tr);
			});
		};

		// 판정결과 행 클릭 시 그 행 바로 아래에 판정 상세내용 행을 펼치거나(없으면 추가), 이미 펼쳐진
		// 같은 행을 다시 클릭하면 접는다(토글). 다른 행을 클릭하면 기존에 펼쳐진 행은 접고 새로 펼친다.
		this.toggleResultDetailRow = function($tr, row, ftaCode) {
			var self = this;
			var alreadyExpanded = $tr.hasClass('table-active');

			$('#originDetermination_popup_resultBody tr.origin-result-row').removeClass('table-active');
			$('#originDetermination_popup_resultBody tr.origin-result-detail-row').remove();

			if (alreadyExpanded) {
				return;
			}

			$tr.addClass('table-active');

			var $detailRow = $(
				'<tr class="origin-result-detail-row">' +
					'<td colspan="10">' +
						'<div class="origin-result-detail-inline">' +
							'<h6 class="mb-2">판정 상세내용</h6>' +
							'<table class="table table-bordered table-sm mb-0">' +
								'<thead class="table-light">' +
									'<tr>' +
										'<th style="width:12%">결정기준</th>' +
										'<th style="width:14%">미소기준 적용금액</th>' +
										'<th style="width:10%">충족여부</th>' +
										'<th style="width:12%">판매금액</th>' +
										'<th style="width:14%">미상 재료비(원)</th>' +
										'<th style="width:12%">부가가치 비율</th>' +
										'<th style="width:26%">결정기준 해설</th>' +
									'</tr>' +
								'</thead>' +
								'<tbody>' +
									'<tr><td colspan="7" class="origin-detail-empty">조회 중...</td></tr>' +
								'</tbody>' +
							'</table>' +
						'</div>' +
					'</td>' +
				'</tr>'
			);
			$tr.after($detailRow);

			self.retrieveResultDetailList(row, ftaCode, $detailRow.find('tbody'));
		};

		// 협정(FTA_CODE) 선택 시, 그 협정의 기준별 판정 상세내용을 조회해 $targetBody(그 행 바로 아래에
		// 펼쳐진 인라인 표의 tbody)에 렌더링한다.
		this.retrieveResultDetailList = function(row, ftaCode, $targetBody) {
			var request = { sales_no: row.sales_no, sales_seq: row.sales_seq, fta_code: ftaCode };

			this.postJson(
				'/origin/compliance/origindetermination/originDeterminationResultDetailList',
				request,
				function(response) {
					var list = (response && response.value) ? response.value : [];
					ORIGIN_DETERMINATION_DETAIL_POPUP.renderResultDetailList(list, $targetBody);
				},
				function() {
					KpackageOBJ.object.alert('판정 상세내용 조회 중 오류가 발생했습니다.');
				}
			);
		};

		this.renderResultDetailList = function(list, $body) {
			$body.empty();

			if (list.length === 0) {
				$body.append('<tr><td colspan="7" class="origin-detail-empty">판정 상세내용이 없습니다.</td></tr>');
				return;
			}

			// 미소기준 적용금액/판매금액/미상 재료비/부가가치 비율/결정기준 해설은
			// 현재 제공되는 값이 없어 빈 칸으로 출력
			list.forEach(function(r) {
				$body.append(
					'<tr>' +
						'<td>' + (r.rule_code || '') + '</td>' +
						'<td></td>' +
						'<td>' + (r.company_coo_yn || '') + '</td>' +
						'<td></td>' +
						'<td></td>' +
						'<td></td>' +
						'<td></td>' +
					'</tr>'
				);
			});
		};

		// (invoice_month, customer_code, division_code, product_code) 라인 목록으로 원산지 판정을 실행하고,
		// 완료 후 처리 대상 row들의 판정 품목 상세를 재조회해 우측 화면을 최신화
		// 주의: 판정상태(status) 배지는 좌측 목록(datas)이 팝업을 열 때 넘어온 값을 그대로 쓰고 있어,
		// 여기서는 갱신하지 않는다 - 최신 판정상태를 보려면 팝업을 닫고 다시 열어야 한다.
		this.executeOriginDetermination = function(rows) {
			var self = this;

			var request = {
				datas: rows.map(function(row) {
					return {
						invoice_month: row.invoice_month,
						customer_code: row.customer_code,
						division_code: row.division_code,
						product_code: row.product_code
					};
				})
			};

			this.postJson(
				'/origin/compliance/origindetermination/executeDomesticOriginDetermination',
				request,
				function(response) {
					var value = (response && response.value) ? response.value : {};
					var failedCount = value.failedTargets ? value.failedTargets.length : 0;
					var message = (value.groupCount || 0) + "건 원산지 판정을 진행했습니다.";

					if (failedCount > 0) {
						message += " (실패 " + failedCount + "건)";
					}

					KpackageOBJ.object.alert(message);

					rows.forEach(function(row) {
						self.refetchDetail(row);
					});
				},
				function() {
					KpackageOBJ.object.alert('원산지 판정 실행 중 오류가 발생했습니다.');
				}
			);
		};

		// 우측의 모든 품목을 대상으로 원산지 판정 진행
		this.bulkOriginDetermination = function() {
			if (this.datas.length === 0) {
				KpackageOBJ.object.alert("판정할 품목이 없습니다.");
				return;
			}

			this.executeOriginDetermination(this.datas);
		};

		// 좌측에서 선택한 품목 1건만 대상으로 원산지 판정 진행
		this.individualOriginDetermination = function() {
			if (!this.selectedKey) {
				KpackageOBJ.object.alert("판정할 품목을 선택하세요.");
				return;
			}

			var selectedRow = this.findSelectedRow();
			if (!selectedRow) {
				return;
			}

			this.executeOriginDetermination([selectedRow]);
		};

		// 좌측 목록(datas)에서 현재 선택된(selectedKey) 항목의 원본 row 를 찾음
		this.findSelectedRow = function() {
			return this.findRowByKey(this.selectedKey);
		};

		// 판정 실행 후, 해당 건 1개의 상세 결과만 다시 조회해 우측 화면을 최신화
		this.refetchDetail = function(row) {
			var self = this;
			var key = this.buildKey(row.sales_no, row.sales_seq);

			var request = {
				datas: [{ sales_no: row.sales_no, sales_seq: row.sales_seq }]
			};

			this.postJson(
				'/origin/compliance/origindetermination/originDeterminationDetailList',
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
		ORIGIN_DETERMINATION_DETAIL_POPUP.Initialize_viewObject();
	});
</script>

</html>
