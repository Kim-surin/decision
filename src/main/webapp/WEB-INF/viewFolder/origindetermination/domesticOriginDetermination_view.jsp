<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
			<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
			<html>

			<head>
				<style>
				        .origin-determination-fail {
							background-color: #ffe6e6 !important; /* 연한 빨간색 배경 */
							color: #d9534f !important;            /* 붉은색 글자 */
							font-weight: bold;
				        }
						.origin-determination-non {
							background-color: #fffde7 !important; /* 은은하고 밝은 노란색 배경 */
							color: #b78103 !important;            /* 어두운 황토/겨자빛 노란색 글자 */
							font-weight: bold;
						}
						/* 검색조건 위 통계(총 건수/판정완료/판정실패/미판정) - 그리드 상태 배지와 동일한 색상 사용 */
						.origin-stat-box {
							min-width: 90px;
						}
						.origin-stat-label {
							font-size: 12px;
							color: #6c757d;
							margin-bottom: 2px;
						}
						.origin-stat-value {
							font-size: 22px;
							font-weight: bold;
							margin-bottom: 0;
						}
						.origin-stat-done {
							color: #1e7e34;
						}
						.origin-stat-fail-label, .origin-stat-fail {
							color: #d9534f;
						}
						.origin-stat-non-label, .origin-stat-non {
							color: #b78103;
						}
				    </style>
			</head>

			<body>
				<div class="content-wrapper">
					<div class="row">
						<div class="content-wrapper col-3">
							<h1 class="subheader-title mb-1">원산지 판정(내수)</h1>
							<nav class="app-breadcrumb" aria-label="breadcrumb">
								<ol class="breadcrumb ms-0 text-muted mb-0">
									<li class="breadcrumb-item">FTA 원산지판정</li>
									<li class="breadcrumb-item active" aria-current="page">원산지 판정(내수)</li>
								</ol>
							</nav>
						</div>
						<div class="row col-9">
							<div class="col-2 d-flex flex-column justify-content-center origin-stat-box">
								<label class="origin-stat-label mb-0">총 건수</label>
								<h4 class="origin-stat-value mb-0" id="DOMESTIC_ORIGIN_DETERMINATION_stat_total">0</h4>
							</div>
							<div class="col-2 d-flex flex-column justify-content-center origin-stat-box">
								<label class="origin-stat-label mb-0">판정완료</label>
								<h4 class="origin-stat-value origin-stat-done mb-0" id="DOMESTIC_ORIGIN_DETERMINATION_stat_done">0</h4>
							</div>
							<div class="col-2 d-flex flex-column justify-content-center origin-stat-box">
								<label class="origin-stat-label origin-stat-fail-label mb-0">판정실패</label>
								<h4 class="origin-stat-value origin-stat-fail mb-0" id="DOMESTIC_ORIGIN_DETERMINATION_stat_fail">0</h4>
							</div>
							<div class="col-2 d-flex flex-column justify-content-center origin-stat-box">
								<label class="origin-stat-label origin-stat-non-label mb-0">미판정</label>
								<h4 class="origin-stat-value origin-stat-non mb-0" id="DOMESTIC_ORIGIN_DETERMINATION_stat_non">0</h4>
							</div>
						</div>
					</div>
					<div class="row">
						<form:form id="DOMESTIC_ORIGIN_DETERMINATION-form" class="s4-form" novalidate="novalidate" action="" method="post">
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
													onclick="javascript:DOMESTIC_ORIGIN_DETERMINATIONVIEW.retrieve_GridData();"
													class="btn btn-sm btn-search search-more waves-effect waves-themed">Search</button>
												<button type="button"
													onclick="javascript:toggleSearchMore(this,'DOMESTIC_ORIGIN_DETERMINATION_SEARCHMORE');"
													class="btn btn-xs btn-search-more waves-effect waves-themed">More</button>
											</div>
										</div>
										
										<!--숨겨진 영역-->
										<div class="row" id="DOMESTIC_ORIGIN_DETERMINATION_SEARCHMORE" style="display: none;">
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
									        <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="javascript:DOMESTIC_ORIGIN_DETERMINATIONVIEW.individual_domestic_origin_determination()">
									            원산지 판정
									        </button>
									    </div>
									</div>
						    	</div>
						    </div>
							
							
					<div class="row">
						<div class="col-12">
							<div id="oAuiGrid_DOMESTIC_ORIGIN_DETERMINATION" style="width:100%;height:700px; margin:0 auto;"></div>
						</div>
					</div>
				</div>
				<script type="text/javascript">

					var DOMESTIC_ORIGIN_DETERMINATIONVIEW = new function () {
						this.grid_DOMESTIC_ORIGIN_DETERMINATION = null;
						// 원산지판정 팝업으로 넘길 수 있는 최대 체크 건수
						this.MAX_CHECK_COUNT = 50;
						
						this.STATUS_NAME_STYLE = {
							'0' : 'origin-determination-non',
							'1' : 'origin-determination-non',
							'5' : 'origin-determination-fail'	
						}

						this.Initialize_viewObject = function () {
							DOMESTIC_ORIGIN_DETERMINATIONVIEW.createAUIGrid();
							AUIGrid.setGridData(DOMESTIC_ORIGIN_DETERMINATIONVIEW.grid_DOMESTIC_ORIGIN_DETERMINATION, DOMESTIC_ORIGIN_DETERMINATIONVIEW.data);
						}

						this.createAUIGrid = function () {
							const columnLayout = [
								{dataField: "sales_no", headerText: "매출번호", width: 130, visible: false},
								{dataField: "sales_seq", headerText: "매출순번", width: 100, visible: false},
								{dataField: "division_code", headerText: "플랜트코드", width: 120, visible: false},
								{dataField: "customer_code", headerText: "고객사코드", width: 120, visible: false},
								{dataField: "invoice_month", headerText: "매출년월", width: 100, filter: {showIcon: true}},
								{dataField: "division_name", headerText: "플랜트", width: 200, filter: {showIcon: true}},
								{dataField: "customer_name", headerText: "고객사", width: 200, filter: {showIcon: true}},
								{dataField: "product_code", headerText: "품번", width: 250, filter: {showIcon: true}},
								{dataField: "product_name", headerText: "품명", width: 250, filter: {showIcon: true}},
								{dataField: "hs_code", headerText: "HS CODE", width: 130, filter: {showIcon: true}},
								{dataField: "product_assets_type_name", headerText: "자산구분", width: 130, filter: {showIcon: true}},
								{dataField: "coo_certify_no", headerText: "원산지확인서 발급번호", width: 200, filter: {showIcon: true}},
								{dataField: "status", headerText: "판정상태", width: 130, visible: false},
								{dataField: "status_name", headerText: "판정상태", width: 130, filter: {showIcon: true}, 
									styleFunction: function(rowIndex, columnIndex, value, headerText, item, dataField){
										if(Object.hasOwn(DOMESTIC_ORIGIN_DETERMINATIONVIEW.STATUS_NAME_STYLE, item.status)){
											return DOMESTIC_ORIGIN_DETERMINATIONVIEW.STATUS_NAME_STYLE[item.status];
										}
										
									}}
							];

							const gridProps = {
								showRowCheckColumn: true,     	// 최좌측에 행 선택 체크박스 컬럼 생성
								rowNumColumnWidth: 50,			// 행번호 너비
								usePaging: true,
								pageRowCount: 20,
								showPageRowSelect: true,
								enableFilter: true
							};


							//DOMESTIC_ORIGIN_DETERMINATIONVIEW.grid_DOMESTIC_ORIGIN_DETERMINATION = KpackageOBJ.auiGrid.create("oAuiGrid_DOMESTIC_ORIGIN_DETERMINATION", columnLayout, gridProps, "");
							const DOMESTIC_ORIGIN_DETERMINATION_GRID = DOMESTIC_ORIGIN_DETERMINATIONVIEW.grid_DOMESTIC_ORIGIN_DETERMINATION = AUIGrid.create("#oAuiGrid_DOMESTIC_ORIGIN_DETERMINATION", columnLayout, gridProps);
						
						
							// 셀클릭 이벤트 바인딩
							AUIGrid.bind(DOMESTIC_ORIGIN_DETERMINATION_GRID, "cellClick", function (event) {
								// 원산지확인서 발급번호 셀 클릭
								if (event.dataField === "coo_certify_no" && event.value) {
									var param = "?coo_certify_no=" + encodeURIComponent(event.item.coo_certify_no) + "&customer_code=" + encodeURIComponent(event.item.customer_code);
									
									KpackageOBJ.sidepanel.open('cooIssueDetailPopup', '/issuecover/cooIssueCoverDetail' + param, '1300px', true);
									return;
								}

								const rowIndex = event.rowIndex;

								// 이미 체크 선택되었는지 검사
								if (AUIGrid.isCheckedRowById(event.pid, rowIndex)) {
									// 엑스트라 체크박스 체크해제 추가
									AUIGrid.addUncheckedRowsByIds(event.pid, rowIndex);
								} else {
									// 체크 가능 건수(최대 50건) 초과 여부 확인
									if (AUIGrid.getCheckedRowItems(event.pid).length >= DOMESTIC_ORIGIN_DETERMINATIONVIEW.MAX_CHECK_COUNT) {
										KpackageOBJ.object.alert("한 번에 최대 " + DOMESTIC_ORIGIN_DETERMINATIONVIEW.MAX_CHECK_COUNT + "건까지 선택할 수 있습니다.");
										return;
									}

									// 엑스트라 체크박스 체크 추가
									AUIGrid.addCheckedRowsByIds(event.pid, rowIndex);
								}
							});
						}

						// preservePage가 true면 재조회 전 보고 있던 페이지 번호를 기억해뒀다가 새 목록에도 그대로
						// 이동시킨다. 검색 버튼처럼 조건이 바뀌는 조회는 기본값(false)대로 1페이지로 돌아간다
						this.retrieve_GridData = function (preservePage) {
							var pageToRestore = preservePage
								? AUIGrid.getProperty(DOMESTIC_ORIGIN_DETERMINATIONVIEW.grid_DOMESTIC_ORIGIN_DETERMINATION, "currentPage")
								: null;

							var params = {
								/* 날짜 파라메터 '-' 제거  */
								"from_date": KpackageOBJ.object.getFormValue("DOMESTIC_ORIGIN_DETERMINATION-form", "from_date").replace(/-/gi, "")
								, "to_date": KpackageOBJ.object.getFormValue("DOMESTIC_ORIGIN_DETERMINATION-form", "to_date").replace(/-/gi, "")
								, "division_code": KpackageOBJ.object.getFormValue("DOMESTIC_ORIGIN_DETERMINATION-form", "division_code")
								, "customer": KpackageOBJ.object.getFormValue("DOMESTIC_ORIGIN_DETERMINATION-form", "customer")
								, "product": KpackageOBJ.object.getFormValue("DOMESTIC_ORIGIN_DETERMINATION-form", "product")
								, "status": KpackageOBJ.object.getFormValue("DOMESTIC_ORIGIN_DETERMINATION-form", "status")
							}

							KpackageOBJ.ajax.doSubmit(
								"/origin/compliance/origindetermination/domesticOriginDeterminationList",
								params,
								function (result) {
									var list = (result && Array.isArray(result.value)) ? result.value : [];

									AUIGrid.setGridData(DOMESTIC_ORIGIN_DETERMINATIONVIEW.grid_DOMESTIC_ORIGIN_DETERMINATION, list);
									DOMESTIC_ORIGIN_DETERMINATIONVIEW.updateStats(list);

									if (pageToRestore > 1) {
										AUIGrid.movePageTo(DOMESTIC_ORIGIN_DETERMINATIONVIEW.grid_DOMESTIC_ORIGIN_DETERMINATION, pageToRestore);
									}
								},
								null,
								false
							);
						}

						// 조회된 목록으로 총 건수/판정완료(4)/판정실패(5)/미판정(0) 건수를 집계해 표시.
						// status는 서버에서 문자열로 내려온다
						this.updateStats = function (list) {
							var doneCount = 0;
							var failCount = 0;

							list.forEach(function (row) {
								if (row.status === '4') {
									doneCount++;
								} else if (row.status === '5') {
									failCount++;
								} 
							});

							$('#DOMESTIC_ORIGIN_DETERMINATION_stat_total').text(list.length);
							$('#DOMESTIC_ORIGIN_DETERMINATION_stat_done').text(doneCount);
							$('#DOMESTIC_ORIGIN_DETERMINATION_stat_fail').text(failCount);
							$('#DOMESTIC_ORIGIN_DETERMINATION_stat_non').text(list.length - (doneCount + failCount));
						}
						
						this.individual_domestic_origin_determination = function () {
							var checkItems = AUIGrid.getCheckedRowItems(DOMESTIC_ORIGIN_DETERMINATIONVIEW.grid_DOMESTIC_ORIGIN_DETERMINATION);

							if (checkItems.length === 0) {
								alert("선택된 항목이 없습니다.");
								return;
							}

							// 전체선택 체크박스 등으로 체크 가능 건수(최대 50건)를 초과한 경우 방어
							if (checkItems.length > DOMESTIC_ORIGIN_DETERMINATIONVIEW.MAX_CHECK_COUNT) {
								KpackageOBJ.object.alert("한 번에 최대 " + DOMESTIC_ORIGIN_DETERMINATIONVIEW.MAX_CHECK_COUNT + "건까지 선택할 수 있습니다.");
								return;
							}

							var datas = checkItems.map(function(row) {
							        return row.item;
							    });
							
							var request = {
								datas: JSON.stringify(datas),
								mode: 'domestic'
							}

							// 팝업이 닫히는 시점(onClose)에 리스트를 다시 조회한다. 보고 있던 페이지 번호도 유지한다
							KpackageOBJ.sidepanel.open('aaaa', '/origin/compliance/origindetermination/originDeterminationDetail_popup', '1700px', false, request,
								function() {
									DOMESTIC_ORIGIN_DETERMINATIONVIEW.retrieve_GridData(true);
								});
						}

					}


					$(document).ready(function () {
						DOMESTIC_ORIGIN_DETERMINATIONVIEW.Initialize_viewObject();
					});

				</script>
			</body>

			</html>