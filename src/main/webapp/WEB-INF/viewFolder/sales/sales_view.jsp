<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
			<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
													<label class="form-label" for="from_date"><spring:message code='TXT.INVOICE_DATE'/></label> <!--매출일자-->
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
														<label class="form-label" for="example-input-border"><spring:message code='TXT.PRODUCT'/></label> <!--제품-->
													</div>
													<div class="col">
														<input type="text" id="product" class="form-control">
													</div>
												</div>
											</div>

											<div class="col-3">
												<div class="mb-3">
													<div class="row">
														<label class="form-label" for="example-input-border"><spring:message code='TXT.CLIENT_COMPANY'/></label> <!--고객사-->
													</div>
													<div class="col">
														<input type="text" id="customer" class="form-control">
													</div>
												</div>
											</div>

											<div class="col">
												<button type="button"
													onclick="javascript:SALESVIEW.retrieve_GridData();"
													class="btn btn-sm btn-search search-more waves-effect waves-themed"><spring:message code='TXT.SEARCH'/></button> <!--조회-->
												<button type="button"
													onclick="javascript:toggleSearchMore(this,'SALES_SEARCHMORE');"
													class="btn btn-xs btn-search-more waves-effect waves-themed"><spring:message code='TXT.MORE'/></button> <!--더보기-->
											</div>
										</div>

										<!--숨겨진 영역-->
										<div class="row" id="SALES_SEARCHMORE" style="display: none;">
											<div class="col-4">
												<div class="mb-3">
													<label class="form-label" for="example-select"><spring:message code='TXT.PLANT'/></label> <!--플랜트-->
													<select class="form-select" id="search_division_code">
														<option value=""><spring:message code='TXT.ALL'/></option> <!--전체-->
														<c:forEach items="${division}" var="item">
															<option value="${item.division_code}">${item.division_name}
															</option>
														</c:forEach>
													</select>
												</div>
											</div>
											<div class="col-4">
												<div class="mb-3">
													<label class="form-label" for="example-select"><spring:message code='TXT.SALES_TYPE'/></label> <!--판매구분-->
													<select class="form-select" id="export_flag">
														<option value=""><spring:message code='TXT.ALL'/></option> <!--전체-->
														<option value="D"><spring:message code='TXT.DOMESTIC'/></option> <!--내수-->
														<option value="E"><spring:message code='TXT.EXPORT'/></option> <!--수출-->
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
								{dataField: "invoice_no", headerText: "<spring:message code='TXT.INVOICE_NO'/>", width: 120}, //인보이스번호
								{dataField: "division_name", headerText: "<spring:message code='TXT.PLANT'/>", width: 120, filter: {showIcon: true}}, //플랜트
								{dataField: "product_code", headerText: "<spring:message code='TXT.PRODUCT_CODE'/>", width: 200, filter: {showIcon: true}}, //제품코드
								{dataField: "product_name", headerText: "<spring:message code='TXT.MATERIAL_NAME'/>", width: 250, filter: {showIcon: true}}, //제품명
								{dataField: "customer_code", headerText: "<spring:message code='TXT.CUSTOMER_CODE'/>", width: 200, filter: {showIcon: true}}, //고객사코드
								{dataField: "customer_name", headerText: "<spring:message code='TXT.CUSTOMER_NAME'/>", width: 200, filter: {showIcon: true}}, //고객사명
								{dataField: "customer_item_code", headerText: "<spring:message code='TXT.CUSTOMER_ITEM_NO'/>", width: 200, filter: {showIcon: true}}, //고객사 품번
								{
									dataField: "unit_price", headerText: "<spring:message code='TXT.UNIT_PRICE'/>", width: 100 //단가
									, dataType: "numeric", style: ""
									, editRenderer: {
										type: "InputEditRenderer",
										onlyNumeric: true, // 0~9만 입력가능
										textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
										autoThousandSeparator: true // 천단위 구분자 삽입 여부
									}
								},
								{
									dataField: "quantity", headerText: "<spring:message code='TXT.QTY'/>", width: 100 //수량
									, dataType: "numeric", style: ""
									, editRenderer: {
										type: "InputEditRenderer",
										onlyNumeric: true, // 0~9만 입력가능
										textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
										autoThousandSeparator: true // 천단위 구분자 삽입 여부
									}
								},
								{
									dataField: "amount", headerText: "<spring:message code='TXT.TOTAL_AMOUNT'/>", width: 100 //총 금액
									, dataType: "numeric", style: ""
									, editRenderer: {
										type: "InputEditRenderer",
										onlyNumeric: true, // 0~9만 입력가능
										textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
										autoThousandSeparator: true // 천단위 구분자 삽입 여부
									}
								},
								{
									dataField: "invoice_date", headerText: "<spring:message code='TXT.INVOICE_DATE'/>", width: 100 //매출일
									, dataType: "date", dateInputFormat: "yyyymmdd", formatString: "yyyy-mm-dd"
									, filter: {showIcon: true}
								},
								{dataField: "export_flag_name", headerText: "<spring:message code='TXT.SALES_TYPE'/>", filter: {showIcon: true}} //판매구분
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
								, "search_division_code": KpackageOBJ.object.getFormValue("SALES-form", "search_division_code")
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