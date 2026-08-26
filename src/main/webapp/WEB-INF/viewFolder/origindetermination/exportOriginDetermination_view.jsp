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
				    </style>
			</head>

			<body>
				<div class="content-wrapper">
					<div class="row">
						<div class="content-wrapper col-3">
							<h1 class="subheader-title mb-1">원산지 판정(수출)</h1>
							<nav class="app-breadcrumb" aria-label="breadcrumb">
								<ol class="breadcrumb ms-0 text-muted mb-0">
									<li class="breadcrumb-item">FTA 원산지판정</li>
									<li class="breadcrumb-item active" aria-current="page">원산지 판정(수출)</li>
								</ol>
							</nav>
						</div>
					</div>
					<div class="row">
						<form:form id="EXPORT_ORIGIN_DETERMINATION-form" class="s4-form" novalidate="novalidate" action="" method="post">
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

											<div class="col">
												<button type="button"
													onclick="javascript:EXPORT_ORIGIN_DETERMINATIONVIEW.retrieve_GridData();"
													class="btn btn-sm btn-search search-more waves-effect waves-themed">Search</button>
												<button type="button"
													onclick="javascript:toggleSearchMore(this,'EXPORT_ORIGIN_DETERMINATION_SEARCHMORE');"
													class="btn btn-xs btn-search-more waves-effect waves-themed">More</button>
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
											<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="javascript:EXPORT_ORIGIN_DETERMINATIONVIEW.individual_export_origin_determination()">
									            원산지 판정
									        </button>
									    </div>
									</div>
						    	</div>
						    </div>
							
							
					<div class="row">
						<div class="col-12">
							<div id="oAuiGrid_EXPORT_ORIGIN_DETERMINATION" style="width:100%;height:700px; margin:0 auto;"></div>
						</div>
					</div>
				</div>
				<script type="text/javascript">

					var EXPORT_ORIGIN_DETERMINATIONVIEW = new function () {
						this.grid_EXPORT_ORIGIN_DETERMINATION = null;
						// 원산지판정 팝업으로 넘길 수 있는 최대 체크 건수
						this.MAX_CHECK_COUNT = 50;

						this.Initialize_viewObject = function () {
							EXPORT_ORIGIN_DETERMINATIONVIEW.createAUIGrid();
							AUIGrid.setGridData(EXPORT_ORIGIN_DETERMINATIONVIEW.grid_EXPORT_ORIGIN_DETERMINATION, EXPORT_ORIGIN_DETERMINATIONVIEW.data);
						}

						this.data = [];

						this.createAUIGrid = function () {
							const columnLayout = [
								{dataField: "sales_no", headerText: "매출번호", width: 130, visible: false},
								{dataField: "sales_seq", headerText: "매출순번", width: 100, visible: false},
								{dataField: "division_code", headerText: "플랜트코드", width: 120, visible: false},
								{dataField: "customer_code", headerText: "고객사코드", width: 120, visible: false},
								{dataField: "invoice_date", headerText: "매출일", width: 120, filter: {showIcon: true}},
								{dataField: "division_name", headerText: "플랜트", width: 200, filter: {showIcon: true}},
								{dataField: "customer_name", headerText: "고객사", width: 200, filter: {showIcon: true}},
								{dataField: "invoice_no", headerText: "Invoice No", width: 250, filter: {showIcon: true}},
								{dataField: "export_nation", headerText: "수출국", width: 130, filter: {showIcon: true}},
								{dataField: "fta_cnt", headerText: "판정대상 협정", width: 200, filter: {showIcon: true}},
								{dataField: "status", headerText: "판정상태", width: 130, visible: false},
								{dataField: "status_name", headerText: "판정상태", width: 130, filter: {showIcon: true}, 
									styleFunction: function(rowIndex, columnIndex, value, headerText, item, dataField){
										if(item.status === 5){
											return "origin-determination-fail";
										}
										
										if(item.status === 0){
											return "origin-determination-non";
										}
										
									}}
							];

							const gridProps = {
								showRowCheckColumn: true,     	// 최좌측에 행 선택 체크박스 컬럼 생성
								showRowAllCheckBox: true,     	// 헤더에 전체 선택 체크박스 표시
								rowNumColumnWidth: 40,			// 행번호 너비
								usePaging: true,
								pageRowCount: 20,
								showPageRowSelect: true,
								enableFilter: true
							};


							//EXPORT_ORIGIN_DETERMINATIONVIEW.grid_EXPORT_ORIGIN_DETERMINATION = KpackageOBJ.auiGrid.create("oAuiGrid_EXPORT_ORIGIN_DETERMINATION", columnLayout, gridProps, "");
							const EXPORT_ORIGIN_DETERMINATION_GRID = EXPORT_ORIGIN_DETERMINATIONVIEW.grid_EXPORT_ORIGIN_DETERMINATION = AUIGrid.create("#oAuiGrid_EXPORT_ORIGIN_DETERMINATION", columnLayout, gridProps);
						
						
							// 셀클릭 이벤트 바인딩
							AUIGrid.bind(EXPORT_ORIGIN_DETERMINATION_GRID, "cellClick", function (event) {
								const rowIndex = event.rowIndex;

								// 이미 체크 선택되었는지 검사
								if (AUIGrid.isCheckedRowById(event.pid, rowIndex)) {
									// 엑스트라 체크박스 체크해제 추가
									AUIGrid.addUncheckedRowsByIds(event.pid, rowIndex);
								} else {
									// 엑스트라 체크박스 체크 추가
									AUIGrid.addCheckedRowsByIds(event.pid, rowIndex);
								}
							});
						}

						this.retrieve_GridData = function () {
							var params = {
								/* 날짜 파라메터 '-' 제거  */
								"from_date": KpackageOBJ.object.getFormValue("EXPORT_ORIGIN_DETERMINATION-form", "from_date").replace(/-/gi, "")
								, "to_date": KpackageOBJ.object.getFormValue("EXPORT_ORIGIN_DETERMINATION-form", "to_date").replace(/-/gi, "")
								, "division_code": KpackageOBJ.object.getFormValue("EXPORT_ORIGIN_DETERMINATION-form", "division_code")
								, "customer": KpackageOBJ.object.getFormValue("EXPORT_ORIGIN_DETERMINATION-form", "customer")
							}

							KpackageOBJ.auiGrid.retrieve(EXPORT_ORIGIN_DETERMINATIONVIEW.grid_EXPORT_ORIGIN_DETERMINATION, "/origin/compliance/origindetermination/exportOriginDeterminationList", params);
						}
						
						this.individual_export_origin_determination = function () {
							var checkItems = AUIGrid.getCheckedRowItems(EXPORT_ORIGIN_DETERMINATIONVIEW.grid_EXPORT_ORIGIN_DETERMINATION);
	
							if (checkItems.length === 0) {
								alert("선택된 항목이 없습니다.");
								return;
							}
	
							// 전체선택 체크박스 등으로 체크 가능 건수(최대 50건)를 초과한 경우 방어
							if (checkItems.length > EXPORT_ORIGIN_DETERMINATIONVIEW.MAX_CHECK_COUNT) {
								KpackageOBJ.object.alert("한 번에 최대 " + EXPORT_ORIGIN_DETERMINATIONVIEW.MAX_CHECK_COUNT + "건까지 선택할 수 있습니다.");
								return;
							}
	
							var datas = checkItems.map(function(row) {
							        return row.item;
							    });
							
							var request = {
								datas: JSON.stringify(datas),
								mode: 'export'
							}

							KpackageOBJ.sidepanel.open('aaaa', '/origin/compliance/origindetermination/originDeterminationDetail_popup', '1700px', request);
						}

					}


					$(document).ready(function () {
						EXPORT_ORIGIN_DETERMINATIONVIEW.Initialize_viewObject();
					});

				</script>
			</body>

			</html>