<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
			<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
			<html>
			<head>
				<script src="/rcs/js/chartjs_v451/chart.js"></script>
				<script src="/rcs/js/package.chartjs.utils.js"></script>
				<style>
				        .origin-determination-fail {
							background-color: #ffe6e6 !important; /* 연한 빨간색 배경 */
							color: #d9534f !important;            /* 붉은색 글자 */
							font-weight: bold;
				        }
				        .origin-stat-row {
				        	display: flex;
				        	gap: 16px;
				        	margin-bottom: 16px;
				        }
				        .origin-stat-card {
				        	flex: 1 1 0;
				        	display: flex;
				        	align-items: center;
				        	gap: 12px;
				        	border: 1px dashed #ced4da;
				        	border-radius: 8px;
				        	padding: 12px 16px;
				        	cursor: pointer;
				        }
				        .origin-stat-card:hover {
				        	border-color: #adb5bd;
				        	background-color: #f8f9fa;
				        }
				        .origin-stat-card.active {
				        	border: 1px solid #4a6cf7;
				        	background-color: #eef3ff;
				        }
				        .origin-stat-donut {
				        	position: relative;
				        	width: 56px;
				        	height: 56px;
				        	flex: 0 0 56px;
				        }
				        .origin-stat-label {
				        	font-size: 12px;
				        	color: #6c757d;
				        }
				        .origin-stat-value {
				        	font-size: 20px;
				        	font-weight: 700;
				        }
				    </style>
			</head>

			<body>
				<div class="content-wrapper">
					<div class="row">
						<div class="content-wrapper col-3">
							<h1 class="subheader-title mb-1">원산지 판정 결과 조회</h1>
							<nav class="app-breadcrumb" aria-label="breadcrumb">
								<ol class="breadcrumb ms-0 text-muted mb-0">
									<li class="breadcrumb-item">FTA 원산지판정</li>
									<li class="breadcrumb-item active" aria-current="page">원산지 판정 결과 조회</li>
								</ol>
							</nav>
						</div>
					</div>

					<div class="row">
						<div class="col-12">
							<div class="origin-stat-row">
								<div class="origin-stat-card" id="originStatCard1" onclick="javascript:ORIGIN_DETERMINATION_RESULTVIEW.filterByStat(1);">
									<div class="origin-stat-donut"><canvas id="originStatChart1"></canvas></div>
									<div>
										<div class="origin-stat-label">역내산 비율</div>
										<div class="origin-stat-value" id="originStatValue1">-</div>
									</div>
								</div>
								<div class="origin-stat-card" id="originStatCard2" onclick="javascript:ORIGIN_DETERMINATION_RESULTVIEW.filterByStat(2);">
									<div class="origin-stat-donut"><canvas id="originStatChart2"></canvas></div>
									<div>
										<div class="origin-stat-label">비역내산 비율</div>
										<div class="origin-stat-value" id="originStatValue2">-</div>
									</div>
								</div>
								<div class="origin-stat-card" id="originStatCard3" onclick="javascript:ORIGIN_DETERMINATION_RESULTVIEW.filterByStat(3);">
									<div class="origin-stat-donut"><canvas id="originStatChart3"></canvas></div>
									<div>
										<div class="origin-stat-label">판정 실패 비율</div>
										<div class="origin-stat-value" id="originStatValue3">-</div>
									</div>
								</div>
								<div class="origin-stat-card" id="originStatCard4" onclick="javascript:ORIGIN_DETERMINATION_RESULTVIEW.filterByStat(4);">
									<div class="origin-stat-donut"><canvas id="originStatChart4"></canvas></div>
									<div>
										<div class="origin-stat-label">내수 비율</div>
										<div class="origin-stat-value" id="originStatValue4">-</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<form:form id="ORIGIN_DETERMINATION_RESULT-form" class="s4-form" novalidate="novalidate" action="" method="post">
							<div id="panel-4" class="panel panel-icon">
								<div class="panel-container show">
									<div class="panel-content">
										<div class="row">
											<div class="col-4">
												<div class="mb-3">
													<label class="form-label" for="from_date">매출일자</label>
													<div class="d-flex gap-2">
														<input class="form-control" id="from_date" name="from_date"
															type="date" value="${from_date}">
														<input class="form-control" id="to_date" name="to_date"
															type="date" value="${to_date}">
													</div>

												</div>
											</div>
											<div class="col-4">
												<div class="mb-3">
													<div class="row">
														<label class="form-label" for="example-input-border">고객사</label>
													</div>
													<div class="col">
														<input type="text" id="customer" class="form-control">
													</div>
												</div>
											</div>

											<div class="col-3">
												<div class="mb-3">
													<div class="row">
														<label class="form-label" for="example-input-border">품번</label>
													</div>
													<div class="col">
														<input type="text" id="product" class="form-control">
													</div>
												</div>
											</div>

											<div class="col">
												<button type="button"
													onclick="javascript:ORIGIN_DETERMINATION_RESULTVIEW.retrieve_GridData();"
													class="btn btn-sm btn-search search-more waves-effect waves-themed">Search</button>
												<button type="button"
													onclick="javascript:toggleSearchMore(this,'ORIGIN_DETERMINATION_RESULT_SEARCHMORE');"
													class="btn btn-xs btn-search-more waves-effect waves-themed">More</button>
											</div>
										</div>
										
										<!--숨겨진 영역-->
										<div class="row" id="ORIGIN_DETERMINATION_RESULT_SEARCHMORE" style="display: none;">
											<div class="col-4">
												<div class="mb-3">
													<label class="form-label" for="example-select">플랜트</label>
													<select class="form-select" id="division_code">
														<option value="">전체</option>
														<c:forEach items="${division}" var="item">
															<option value="${item.division_code}">${item.division_name}
															</option>
														</c:forEach>
													</select>
												</div>
											</div>
											<div class="col-4">
												<div class="mb-3">
													<label class="form-label" for="example-select">판정상태</label>
													<select class="form-select" id="status">
														<option value="">전체</option>
														<option value="0">미판정</option>
														<option value="4">판정완료</option>
														<option value="5">판정에러</option>
													</select>
												</div>
											</div>
											<div class="col-3">
												<div class="mb-3">
													<label class="form-label" for="example-select">판매구분</label>
													<select class="form-select" id="export_flag">
														<option value="">전체</option>
														<option value="D">내수</option>
														<option value="E">수출</option>
													</select>
												</div>
											</div>
										</div>
																				
									</div>
								</div>
							</div>
						</form:form>
					</div>

					<div class="row">
						<div class="col-12">
							<div class="frame-wrap">
								<div class="demo" style="text-align: right;">
									<button type="button" class="btn btn-sm btn-primary waves-effect waves-themed"
										onclick="javascript:ORIGIN_DETERMINATION_RESULTVIEW.executeMonthlyOriginDetermination();">
										월판정
									</button>
									<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed"
										onclick="javascript:ORIGIN_DETERMINATION_RESULTVIEW.excelDownload();">
										엑셀 다운로드
									</button>
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-12">
							<div id="oAuigrid_ORIGIN_DETERMINATION_RESULT" style="width:100%;height:700px; margin:0 auto;"></div>
						</div>
					</div>
				</div>
				<script type="text/javascript">

					var ORIGIN_DETERMINATION_RESULTVIEW = new function () {
						this.grid_ORIGIN_DETERMINATION_RESULT = null;

						this.Initialize_viewObject = function () {
							ORIGIN_DETERMINATION_RESULTVIEW.createAUIGrid();
							AUIGrid.setGridData(ORIGIN_DETERMINATION_RESULTVIEW.grid_ORIGIN_DETERMINATION_RESULT, ORIGIN_DETERMINATION_RESULTVIEW.data);
							ORIGIN_DETERMINATION_RESULTVIEW.updateStatsCharts([]);
						}

						this.data = [];
						// 마지막 검색 결과 전체(필터링 전) - 통계 카드 클릭 시 이걸 기준으로 그리드만 다시 필터링한다
						this.currentList = [];
						// 현재 선택된 통계 카드 번호(1~4). 없으면 null
						this.activeStatFilter = null;

						// 통계 카드 번호별 필터 조건. updateStatsCharts의 집계 기준과 반드시 맞춰야 한다
						this.STAT_FILTERS = {
							1: function (row) { return row.origin_status === 'Y'; },
							2: function (row) { return row.origin_status !== 'Y'; },
							3: function (row) { return String(row.status) === '5'; },
							4: function (row) { return row.export_flag === 'D'; }
						};

						this.createAUIGrid = function () {
							const columnLayout = [
								{dataField: "invoice_date", headerText: "매출일", width: 120, filter: {showIcon: true}},
								{dataField: "division_name", headerText: "플랜트", width: 120, filter: {showIcon: true}},
								{dataField: "export_flag", headerText: "판매구분", width: 130, visible: false},
								{dataField: "export_flag_name", headerText: "판매구분", width: 120, filter: {showIcon: true}},
								{dataField: "customer_name", headerText: "고객사", width: 140, filter: {showIcon: true}},
								{dataField: "product_code", headerText: "품번", width: 250, filter: {showIcon: true}},
								{dataField: "product_name", headerText: "품명", width: 250, filter: {showIcon: true}},
								{dataField: "hs_code", headerText: "HS CODE", width: 130, filter: {showIcon: true}},
								{dataField: "fta_name", headerText: "협정", width: 130, filter: {showIcon: true}},
								{dataField: "origin_status", headerText: "원산지 지위", width: 100, filter: {showIcon: true}},
								{dataField: "status", headerText: "판정상태", width: 130, visible: false},
								{dataField: "status_name", headerText: "판정상태", width: 130, filter: {showIcon: true}, 
									styleFunction: function(rowIndex, columnIndex, value, headerText, item, dataField){
										if(item.status === 5){
											return "origin-determination-fail";
										}													
									}}
							];

							const gridProps = {
								rowNumColumnWidth: 50,			// 행번호 너비
								usePaging: true,
								pageRowCount: 20,
								showPageRowSelect: true,
								enableFilter: true
							};


							//ORIGIN_DETERMINATION_RESULTVIEW.grid_ORIGIN_DETERMINATION_RESULT = KpackageOBJ.auiGrid.create("oAuigrid_ORIGIN_DETERMINATION_RESULT", columnLayout, gridProps, "");
							const ORIGIN_DETERMINATION_GRID = ORIGIN_DETERMINATION_RESULTVIEW.grid_ORIGIN_DETERMINATION_RESULT = AUIGrid.create("#oAuigrid_ORIGIN_DETERMINATION_RESULT", columnLayout, gridProps);			
						
							// 셀클릭 이벤트 바인딩. 체크박스 컬럼(columnIndex < 0) 클릭은 선택만 토글하고,
							// 그 외 데이터 셀 클릭은 기존처럼 바로 해당 행의 상세 팝업을 연다.
							AUIGrid.bind(ORIGIN_DETERMINATION_GRID, "cellClick", function (event) {
								if (event.columnIndex < 0) {
									return;
								}
								ORIGIN_DETERMINATION_RESULTVIEW.retrive_DetailData(event.item);
							});
						}
						
						this.excelDownload = function () {
						const exportProps = {
							fileName: "원산지 판정 결과 조회",
							sheetName: "원산지 판정 결과 조회",
							exportWithStyle: true,
							progressBar: true,
							showRowNumColumn: false
						};

						AUIGrid.exportToXlsx(
							ORIGIN_DETERMINATION_RESULTVIEW.grid_ORIGIN_DETERMINATION_RESULT,
							exportProps
						);
					}

					this.retrieve_GridData = function () {
							var params = {
							/* 날짜 파라메터 '-' 제거  */
							"from_date": KpackageOBJ.object.getFormValue("ORIGIN_DETERMINATION_RESULT-form", "from_date").replace(/-/gi, "")
							, "to_date": KpackageOBJ.object.getFormValue("ORIGIN_DETERMINATION_RESULT-form", "to_date").replace(/-/gi, "")
							, "customer": KpackageOBJ.object.getFormValue("ORIGIN_DETERMINATION_RESULT-form", "customer")
							, "product": KpackageOBJ.object.getFormValue("ORIGIN_DETERMINATION_RESULT-form", "product")
							, "division_code": KpackageOBJ.object.getFormValue("ORIGIN_DETERMINATION_RESULT-form", "division_code")
							, "status": KpackageOBJ.object.getFormValue("ORIGIN_DETERMINATION_RESULT-form", "status")
							, "export_flag": KpackageOBJ.object.getFormValue("ORIGIN_DETERMINATION_RESULT-form", "export_flag")
						}

						// KpackageOBJ.auiGrid.retrieve 대신 직접 호출한다: 상단 통계 도넛차트도 같은 응답으로
						// 갱신해야 해서 결과 목록(list)에 접근할 콜백이 필요하다
						KpackageOBJ.ajax.doSubmit("/origin/compliance/origindetermination/originDeterminationResultList", params, function (response) {
							var list = (response && Array.isArray(response.value)) ? response.value : [];

							ORIGIN_DETERMINATION_RESULTVIEW.currentList = list;
							ORIGIN_DETERMINATION_RESULTVIEW.activeStatFilter = null;
							$(".origin-stat-card").removeClass("active");

							AUIGrid.setGridData(ORIGIN_DETERMINATION_RESULTVIEW.grid_ORIGIN_DETERMINATION_RESULT, list);
							ORIGIN_DETERMINATION_RESULTVIEW.updateStatsCharts(list);
						});
					}

					// 통계 카드 클릭: 그 카드가 이미 선택돼 있으면 필터를 풀고 전체를, 아니면 해당 조건에
					// 맞는 행만 그리드에 다시 채운다. 통계 수치는 검색 결과 전체 기준으로 그대로 둔다
					this.filterByStat = function (index) {
						var $card = $("#originStatCard" + index);

						if (ORIGIN_DETERMINATION_RESULTVIEW.activeStatFilter === index) {
							ORIGIN_DETERMINATION_RESULTVIEW.activeStatFilter = null;
							$(".origin-stat-card").removeClass("active");
							AUIGrid.setGridData(ORIGIN_DETERMINATION_RESULTVIEW.grid_ORIGIN_DETERMINATION_RESULT, ORIGIN_DETERMINATION_RESULTVIEW.currentList);
							return;
						}

						var filtered = ORIGIN_DETERMINATION_RESULTVIEW.currentList.filter(ORIGIN_DETERMINATION_RESULTVIEW.STAT_FILTERS[index]);

						ORIGIN_DETERMINATION_RESULTVIEW.activeStatFilter = index;
						$(".origin-stat-card").removeClass("active");
						$card.addClass("active");
						AUIGrid.setGridData(ORIGIN_DETERMINATION_RESULTVIEW.grid_ORIGIN_DETERMINATION_RESULT, filtered);
					};

					// 상단 통계 도넛차트 4개 갱신: 1)역내산 2)비역내산 3)판정 실패 4)내수 비율
					this.updateStatsCharts = function (list) {
						list = list || [];
						var total = list.length;
						var originCount = list.filter(ORIGIN_DETERMINATION_RESULTVIEW.STAT_FILTERS[1]).length;
						var failCount = list.filter(ORIGIN_DETERMINATION_RESULTVIEW.STAT_FILTERS[3]).length;
						var domesticCount = list.filter(ORIGIN_DETERMINATION_RESULTVIEW.STAT_FILTERS[4]).length;

						ORIGIN_DETERMINATION_RESULTVIEW.applyStat(1, originCount, total, "#22c55e");
						ORIGIN_DETERMINATION_RESULTVIEW.applyStat(2, total - originCount, total, "#f97316");
						ORIGIN_DETERMINATION_RESULTVIEW.applyStat(3, failCount, total, "#ef4444");
						ORIGIN_DETERMINATION_RESULTVIEW.applyStat(4, domesticCount, total, "#3b82f6");
					};

					this.applyStat = function (index, count, total, color) {
						var ratio = total > 0 ? Math.round((count / total) * 1000) / 10 : 0;

						ORIGIN_DETERMINATION_RESULTVIEW.renderRatioChart("originStatChart" + index, ratio, color);
						$("#originStatValue" + index).text(ratio + "%");
					};

					this.renderRatioChart = function (canvasId, ratio, color) {
						var data = {
							labels: ["대상", "그 외"],
							datasets: [{
								data: [ratio, Math.max(0, 100 - ratio)],
								backgroundColor: [color, "#e5e7eb"],
								borderWidth: 0
							}]
						};

						ChartUtil.createDoughnut(canvasId, data, {
							cutout: "72%",
							plugins: {
								legend: { display: false },
								tooltip: { enabled: false }
							}
						});
					};

					// 검색 조건의 매출일자(from_date~to_date) 범위가 걸치는 매출년월 전체를 대상으로
					// 월 판정(내수+수출 통합)을 진행한다. 대상 회사는 세션값이 서버에서 자동 주입된다.
					this.executeMonthlyOriginDetermination = function () {
						var fromDate = KpackageOBJ.object.getFormValue("ORIGIN_DETERMINATION_RESULT-form", "from_date").replace(/-/gi, "");
						var toDate = KpackageOBJ.object.getFormValue("ORIGIN_DETERMINATION_RESULT-form", "to_date").replace(/-/gi, "");

						if (!fromDate || !toDate) {
							KpackageOBJ.object.alert("매출일자(From/To)를 입력하세요.");
							return;
						}

						if (!confirm("매출일자 " + fromDate + " ~ " + toDate + " 범위의 매출년월을 대상으로 월 판정을 진행하시겠습니까?")) {
							return;
						}

						var params = {
							"from_date": fromDate,
							"to_date": toDate
						};

						KpackageOBJ.ajax.doSubmit("/origin/compliance/origindetermination/executeMonthlyOriginDetermination", params, ORIGIN_DETERMINATION_RESULTVIEW.executeMonthlyOriginDetermination_CallBack);
					}

					this.executeMonthlyOriginDetermination_CallBack = function (res) {
						if (!res || !res.success) {
							KpackageOBJ.object.alert("월 판정 실행 중 오류가 발생했습니다.");
							return;
						}

						var value = res.value || {};
						var failedCount = value.failedTargets ? value.failedTargets.length : 0;
						var message = (value.groupCount || 0) + "건 월 판정을 진행했습니다.";

						if (failedCount > 0) {
							message += " (실패 " + failedCount + "건)";
						}

						KpackageOBJ.object.alert(message);
						ORIGIN_DETERMINATION_RESULTVIEW.retrieve_GridData();
					}

					// 이 화면은 내수(EXPORT_FLAG='D')/수출(EXPORT_FLAG='E') 데이터가 함께 조회되므로,
					// 클릭한 행의 판매구분에 맞춰 팝업이 내수/수출 판정 API를 호출하도록 mode를 함께 넘긴다
					this.retrive_DetailData = function (data) {
						var request = {
							datas: JSON.stringify([data]),
							mode: data.export_flag === 'E' ? 'export' : 'domestic'
						}

						KpackageOBJ.sidepanel.open('aaaa', '/origin/compliance/origindetermination/originDeterminationDetail_popup', '1700px', false, request);
					}

				}


					$(document).ready(function () {
						ORIGIN_DETERMINATION_RESULTVIEW.Initialize_viewObject();
					});

				</script>
			</body>

			</html>