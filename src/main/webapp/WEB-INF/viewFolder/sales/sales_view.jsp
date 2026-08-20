<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
			<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
			<html>

			<head>
			</head>

			<body>
				<div class="content-wrapper">
					<div class="row">
						<div class="content-wrapper col-3">
							<h1 class="subheader-title mb-1">매출내역 조회</h1>
							<nav class="app-breadcrumb" aria-label="breadcrumb">
								<ol class="breadcrumb ms-0 text-muted mb-0">
									<li class="breadcrumb-item">FTA 거래정보</li>
									<li class="breadcrumb-item active" aria-current="page">매출내역 조회</li>
								</ol>
							</nav>
						</div>
					</div>
					<div class="row">
						<form:form id="SALES-form" class="s4-form" novalidate="novalidate" action="" method="post">
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
														<label class="form-label" for="example-input-border">제품</label>
													</div>
													<div class="col">
														<input type="text" id="product" class="form-control">
													</div>
												</div>
											</div>

											<div class="col-3">
												<div class="mb-3">
													<div class="row">
														<label class="form-label" for="example-input-border">고객사</label>
													</div>
													<div class="col">
														<input type="text" id="customer" class="form-control">
													</div>
												</div>
											</div>

											<div class="col">
												<button type="button"
													onclick="javascript:SALESVIEW.retrieve_GridData();"
													class="btn btn-sm btn-search search-more waves-effect waves-themed">Search</button>
												<button type="button"
													onclick="javascript:toggleSearchMore(this,'SALES_SEARCHMORE');"
													class="btn btn-xs btn-search-more waves-effect waves-themed">More</button>
											</div>
										</div>

										<!--숨겨진 영역-->
										<div class="row" id="SALES_SEARCHMORE" style="display: none;">
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
							<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
							<div id="oAuiGrid_SALES" style="width:100%;height:700px; margin:0 auto;"></div>
						</div>
					</div>
				</div>
				<script type="text/javascript">

					var SALESVIEW = new function () {
						this.grid_SALES = null;

						this.Initialize_viewObject = function () {
							SALESVIEW.createAUIGrid();
							AUIGrid.setGridData(SALESVIEW.grid_SALES, SALESVIEW.data);
						}

						this.data = [];

						this.createAUIGrid = function () {
							const columnLayout = [
								{dataField: "invoice_no", headerText: "인보이스번호", width: 120},
								{dataField: "division_name", headerText: "플랜트", width: 120, filter: {showIcon: true}},
								{dataField: "product_code", headerText: "제품코드", width: 200, filter: {showIcon: true}},
								{dataField: "product_name", headerText: "제품명", width: 250, filter: {showIcon: true}},
								{dataField: "customer_code", headerText: "고객사코드", width: 200, filter: {showIcon: true}},
								{dataField: "customer_name", headerText: "고객사명", width: 200, filter: {showIcon: true}},
								{dataField: "customer_item_code", headerText: "고객사 품번", width: 200, filter: {showIcon: true}},
								{
									dataField: "unit_price", headerText: "단가", width: 100
									, dataType: "numeric", style: ""
									, editRenderer: {
										type: "InputEditRenderer",
										onlyNumeric: true, // 0~9만 입력가능
										textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
										autoThousandSeparator: true // 천단위 구분자 삽입 여부
									}
								},
								{
									dataField: "quantity", headerText: "수량", width: 100
									, dataType: "numeric", style: ""
									, editRenderer: {
										type: "InputEditRenderer",
										onlyNumeric: true, // 0~9만 입력가능
										textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
										autoThousandSeparator: true // 천단위 구분자 삽입 여부
									}
								},
								{
									dataField: "amount", headerText: "총 금액", width: 100
									, dataType: "numeric", style: ""
									, editRenderer: {
										type: "InputEditRenderer",
										onlyNumeric: true, // 0~9만 입력가능
										textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
										autoThousandSeparator: true // 천단위 구분자 삽입 여부
									}
								},
								{
									dataField: "invoice_date", headerText: "매출일", width: 100
									, dataType: "date", dateInputFormat: "yyyymmdd", formatString: "yyyy-mm-dd"
									, filter: {showIcon: true}
								},
								{dataField: "export_flag_name", headerText: "판매구분", filter: {showIcon: true}}
							];

							const gridProps = {
								usePaging: true,
								pageRowCount: 50,
								showPageRowSelect: true,
								enableFilter: true
							};

							SALESVIEW.grid_SALES = KpackageOBJ.auiGrid.create("oAuiGrid_SALES", columnLayout, gridProps, "");
						}

						this.retrieve_GridData = function () {
							var params = {
								/* 날짜 파라메터 '-' 제거  */
								"from_date": KpackageOBJ.object.getFormValue("SALES-form", "from_date").replace(/-/gi, "")
								, "to_date": KpackageOBJ.object.getFormValue("SALES-form", "to_date").replace(/-/gi, "")
								, "product": KpackageOBJ.object.getFormValue("SALES-form", "product")
								, "customer": KpackageOBJ.object.getFormValue("SALES-form", "customer")
								, "division_code": KpackageOBJ.object.getFormValue("SALES-form", "division_code")
								, "export_flag": KpackageOBJ.object.getFormValue("SALES-form", "export_flag")
							}

							KpackageOBJ.auiGrid.retrieve(SALESVIEW.grid_SALES, "/origin/compliance/sales/salesList", params);
						}
					}

					$(document).ready(function () {
						SALESVIEW.Initialize_viewObject();
					});

				</script>
			</body>

			</html>