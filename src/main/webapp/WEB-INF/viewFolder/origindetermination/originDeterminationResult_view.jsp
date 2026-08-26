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
						<form:form id="DOMESTIC_ORIGIN_DETERMINATION_RESULT-form" class="s4-form" novalidate="novalidate" action="" method="post">
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
													onclick="javascript:DOMESTIC_ORIGIN_DETERMINATION_RESULTVIEW.retrieve_GridData();"
													class="btn btn-sm btn-search search-more waves-effect waves-themed">Search</button>
												<button type="button"
													onclick="javascript:toggleSearchMore(this,'DOMESTIC_ORIGIN_DETERMINATION_RESULT_SEARCHMORE');"
													class="btn btn-xs btn-search-more waves-effect waves-themed">More</button>
											</div>
										</div>
										
										<!--숨겨진 영역-->
										<div class="row" id="DOMESTIC_ORIGIN_DETERMINATION_RESULT_SEARCHMORE" style="display: none;">
											<div class="col-4">
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
									        <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="javascript:KpackageOBJ.sidepanel.open('aaaa','/DOMESTIC_ORIGIN_DETERMINATION_RESULT_pop01', '1200px');">
									            원산지 판정
									        </button>
									    </div>
									</div>
						    	</div>
						    </div>
							
							
					<div class="row">
						<div class="col-12">
							<div id="oAuiGrid_DOMESTIC_ORIGIN_DETERMINATION_RESULT" style="width:100%;height:700px; margin:0 auto;"></div>
						</div>
					</div>
				</div>
				<script type="text/javascript">

					var DOMESTIC_ORIGIN_DETERMINATION_RESULTVIEW = new function () {
						this.grid_DOMESTIC_ORIGIN_DETERMINATION_RESULT = null;

						this.Initialize_viewObject = function () {
							DOMESTIC_ORIGIN_DETERMINATION_RESULTVIEW.createAUIGrid();
							AUIGrid.setGridData(DOMESTIC_ORIGIN_DETERMINATION_RESULTVIEW.grid_DOMESTIC_ORIGIN_DETERMINATION_RESULT, DOMESTIC_ORIGIN_DETERMINATION_RESULTVIEW.data);
						}

						this.data = [];

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


							//DOMESTIC_ORIGIN_DETERMINATION_RESULTVIEW.grid_DOMESTIC_ORIGIN_DETERMINATION_RESULT = KpackageOBJ.auiGrid.create("oAuiGrid_DOMESTIC_ORIGIN_DETERMINATION_RESULT", columnLayout, gridProps, "");
							const DOMESTIC_ORIGIN_DETERMINATION_GRID = DOMESTIC_ORIGIN_DETERMINATION_RESULTVIEW.grid_DOMESTIC_ORIGIN_DETERMINATION_RESULT = AUIGrid.create("#oAuiGrid_DOMESTIC_ORIGIN_DETERMINATION_RESULT", columnLayout, gridProps);			
						
							// 셀클릭 이벤트 바인딩
							AUIGrid.bind(DOMESTIC_ORIGIN_DETERMINATION_GRID, "cellClick", function (event) {
								DOMESTIC_ORIGIN_DETERMINATION_RESULTVIEW.retrive_DetailData(event.item);
							});
						}
						
						this.retrieve_GridData = function () {
							var params = {
							/* 날짜 파라메터 '-' 제거  */
							"from_date": KpackageOBJ.object.getFormValue("DOMESTIC_ORIGIN_DETERMINATION_RESULT-form", "from_date").replace(/-/gi, "")
							, "to_date": KpackageOBJ.object.getFormValue("DOMESTIC_ORIGIN_DETERMINATION_RESULT-form", "to_date").replace(/-/gi, "")
							, "division_code": KpackageOBJ.object.getFormValue("DOMESTIC_ORIGIN_DETERMINATION_RESULT-form", "division_code")
							, "customer": KpackageOBJ.object.getFormValue("DOMESTIC_ORIGIN_DETERMINATION_RESULT-form", "customer")
							, "export_flag": KpackageOBJ.object.getFormValue("DOMESTIC_ORIGIN_DETERMINATION_RESULT-form", "export_flag")
						}

						KpackageOBJ.auiGrid.retrieve(DOMESTIC_ORIGIN_DETERMINATION_RESULTVIEW.grid_DOMESTIC_ORIGIN_DETERMINATION_RESULT, "/origin/compliance/origindetermination/originDeterminationResultList", params);
					}
					
					// 이 화면은 내수(EXPORT_FLAG='D')/수출(EXPORT_FLAG='E') 데이터가 함께 조회되므로,
					// 클릭한 행의 판매구분에 맞춰 팝업이 내수/수출 판정 API를 호출하도록 mode를 함께 넘긴다
					this.retrive_DetailData = function (data) {
						var request = {
							datas: JSON.stringify([data]),
							mode: data.export_flag === 'E' ? 'export' : 'domestic'
						}

						KpackageOBJ.sidepanel.open('aaaa', '/origin/compliance/origindetermination/originDeterminationDetail_popup', '1700px', request);
					}

				}


					$(document).ready(function () {
						DOMESTIC_ORIGIN_DETERMINATION_RESULTVIEW.Initialize_viewObject();
					});

				</script>
			</body>

			</html>