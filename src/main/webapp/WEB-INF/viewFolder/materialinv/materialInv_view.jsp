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
							<h1 class="subheader-title mb-1">원재료수불부 조회</h1>
							<nav class="app-breadcrumb" aria-label="breadcrumb">
								<ol class="breadcrumb ms-0 text-muted mb-0">
									<li class="breadcrumb-item">FTA 거래정보</li>
									<li class="breadcrumb-item active" aria-current="page">원재료수불부 조회</li>
								</ol>
							</nav>
						</div>
					</div>
					<div class="row">
						<form:form id="MATERIALINV-form" class="s4-form" novalidate="novalidate" action=""
							method="post">
							<div id="panel-4" class="panel panel-icon">
								<div class="panel-container show">
									<div class="panel-content">
										<div class="row">
											<div class="col-4">
												<div class="mb-3">
													<label class="form-label" for="from_yyyymm"><spring:message code='TXT.STD_DATE'/></label> <!--기준년월-->
													<div class="d-flex gap-2">
														<input class="form-control" id="from_yyyymm" name="from_yyyymm"
															type="month" value="${from_yyyymm}">
														<input class="form-control" id="to_yyyymm" name="to_yyyymm"
															type="month" value="${to_yyyymm}">
													</div>

												</div>
											</div>

											<div class="col-4">
												<div class="mb-3">
													<div class="row">
														<label class="form-label" for="example-input-border"><spring:message code='TXT.MATERIAL'/></label> <!--자재-->
													</div>
													<div class="col">
														<input type="text" id="item" class="form-control">
													</div>
												</div>
											</div>

											<div class="col-3">
												<div class="mb-3">
													<label class="form-label" for="example-select"><spring:message code='TXT.PLANT'/></label> <!--플랜트-->
													<select class="form-select" id="search_division_code">
														<option value=""><spring:message code='TXT.ALL'/></option> <!--전체-->
														<c:forEach items="${division}" var="item">
															<option value="${item.division_code}">
																${item.division_name}
															</option>
														</c:forEach>
													</select>
												</div>
											</div>

											<div class="col">
												<button type="button"
													onclick="javascript:MATERIALINVVIEW.retrieve_GridData();"
													class="btn btn-sm btn-search search-more waves-effect waves-themed"><spring:message code='TXT.SEARCH'/></button> <!--조회-->
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
							<div id="oAuiGrid_MATERIALINV" style="width:100%;height:700px; margin:0 auto;"></div>
						</div>
					</div>
				</div>
				<script type="text/javascript">

					var MATERIALINVVIEW = new function () {
						this.grid_MATERIALINV = null;

						this.Initialize_viewObject = function () {
							MATERIALINVVIEW.createAUIGrid();
							AUIGrid.setGridData(MATERIALINVVIEW.grid_MATERIALINV, []);
						}

						this.createAUIGrid = function () {
							const columnLayout = [
								{dataField: "yyyymm", headerText: "<spring:message code='TXT.STD_DATE'/>", width: 120, filter: {showIcon: true}}, //기준년월
								{dataField: "division_name", headerText: "<spring:message code='TXT.PLANT'/>", width: 120, filter: {showIcon: true}}, //플랜트
								{dataField: "item_code", headerText: "<spring:message code='TXT.RAW_MATERIAL_CODE'/>", width: 200, filter: {showIcon: true}}, //자재코드
								{dataField: "item_name", headerText: "<spring:message code='TXT.RAW_MATERIAL_NAME'/>", width: 200, filter: {showIcon: true}}, //자재명
								{dataField: "unit", headerText: "<spring:message code='TXT.UNIT'/>", width: 80}, //단위
								{dataField: "aging_period", headerText: "<spring:message code='TXT.INVENTORY_TURNOVER'/>", width: 100}, //재고회전기간(월)
								{
									headerText: "<spring:message code='TXT.BASIS_INVENTORY'/>", children: [ //기초재고
										{
											dataField: "initial_qty", headerText: "<spring:message code='TXT.QTY'/>", width: 120 //수량
											, dataType: "numeric", style: "", formatString: "#,##0.000"
											, editRenderer: {
												type: "InputEditRenderer",
												onlyNumeric: true, // 0~9만 입력가능
												textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
												autoThousandSeparator: true // 천단위 구분자 삽입 여부
											}
										}, {dataField: "initial_amount", headerText: "<spring:message code='TXT.AMOUNT'/>", width: 120}, //금액
									]
								},
								{
									headerText: "<spring:message code='TXT.WAREHOUSING'/>", children: [{ //입고
										dataField: "input_qty", headerText: "<spring:message code='TXT.QTY'/>" //수량
										, width: 120, dataType: "numeric", formatString: "#,##0.000"
										, editRenderer: {
											type: "InputEditRenderer",
											onlyNumeric: true, // 0~9만 입력가능
											textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
											autoThousandSeparator: true // 천단위 구분자 삽입 여부
										}
									},
									{
										dataField: "input_amount", headerText: "<spring:message code='TXT.AMOUNT'/>" //금액
										, width: 120
										, editRenderer: {
											type: "InputEditRenderer",
											onlyNumeric: true, // 0~9만 입력가능
											textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
											autoThousandSeparator: true // 천단위 구분자 삽입 여부
										}
									}]
								},
								{
									headerText: "<spring:message code='TXT.ETC_WAREHOUSING'/>", children: [{ //기타입고
										dataField: "extra_input_qty", headerText: "<spring:message code='TXT.QTY'/>" //수량
										, width: 120, dataType: "numeric", formatString: "#,##0.000"
										, editRenderer: {
											type: "InputEditRenderer",
											onlyNumeric: true, // 0~9만 입력가능
											textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
											autoThousandSeparator: true // 천단위 구분자 삽입 여부
										}
									},
									{
										dataField: "extra_input_amount", headerText: "<spring:message code='TXT.AMOUNT'/>" //금액
										, width: 120
										, editRenderer: {
											type: "InputEditRenderer",
											onlyNumeric: true, // 0~9만 입력가능
											textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
											autoThousandSeparator: true // 천단위 구분자 삽입 여부
										}
									}]
								},
								{
									headerText: "<spring:message code='TXT.DELIVERY'/>", children: [{ //출고
										dataField: "issue_qty", headerText: "<spring:message code='TXT.QTY'/>" //수량
										, width: 120, dataType: "numeric", formatString: "#,##0.000"
										, editRenderer: {
											type: "InputEditRenderer",
											onlyNumeric: true, // 0~9만 입력가능
											textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
											autoThousandSeparator: true // 천단위 구분자 삽입 여부
										}
									},
									{
										dataField: "issue_amount", headerText: "<spring:message code='TXT.AMOUNT'/>" //금액
										, width: 120
										, editRenderer: {
											type: "InputEditRenderer",
											onlyNumeric: true, // 0~9만 입력가능
											textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
											autoThousandSeparator: true // 천단위 구분자 삽입 여부
										}
									}]
								},
								{
									headerText: "<spring:message code='TXT.ETC_DELIVERY'/>", children: [{ //기타출고
										dataField: "extra_issue_qty", headerText: "<spring:message code='TXT.QTY'/>" //수량
										, width: 120, dataType: "numeric", formatString: "#,##0.000"
										, editRenderer: {
											type: "InputEditRenderer",
											onlyNumeric: true, // 0~9만 입력가능
											textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
											autoThousandSeparator: true // 천단위 구분자 삽입 여부
										}
									},
									{
										dataField: "extra_issue_amount", headerText: "<spring:message code='TXT.AMOUNT'/>" //금액
										, width: 120
										, editRenderer: {
											type: "InputEditRenderer",
											onlyNumeric: true, // 0~9만 입력가능
											textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
											autoThousandSeparator: true // 천단위 구분자 삽입 여부
										}
									}]
								},
								{
									headerText: "<spring:message code='TXT.ENDING_INVENTORY'/>", children: [{ //기말재고
										dataField: "inventory_qty", headerText: "<spring:message code='TXT.QTY'/>" //수량
										, width: 120, dataType: "numeric", formatString: "#,##0.000"
										, editRenderer: {
											type: "InputEditRenderer",
											onlyNumeric: true, // 0~9만 입력가능
											textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
											autoThousandSeparator: true // 천단위 구분자 삽입 여부
										}
									},
									{
										dataField: "inventory_amount", headerText: "<spring:message code='TXT.AMOUNT'/>" //금액
										, width: 120
										, editRenderer: {
											type: "InputEditRenderer",
											onlyNumeric: true, // 0~9만 입력가능
											textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
											autoThousandSeparator: true // 천단위 구분자 삽입 여부
										}
									}]
								}
							];

							const gridProps = {
								usePaging: true,
								pageRowCount: 50,
								showPageRowSelect: true,
								enableFilter: true,
								fixedColumnCount: 6
							};

							MATERIALINVVIEW.grid_MATERIALINV = KpackageOBJ.auiGrid.create("oAuiGrid_MATERIALINV", columnLayout, gridProps, "");

						}

						this.retrieve_GridData = function () {
							var params = {
								"from_yyyymm": KpackageOBJ.object.getFormValue("MATERIALINV-form", "from_yyyymm").replace(/-/gi, "")
								, "to_yyyymm": KpackageOBJ.object.getFormValue("MATERIALINV-form", "to_yyyymm").replace(/-/gi, "")
								, "item": KpackageOBJ.object.getFormValue("MATERIALINV-form", "item")
								, "search_division_code": KpackageOBJ.object.getFormValue("MATERIALINV-form", "search_division_code")
							}

							KpackageOBJ.auiGrid.retrieve(MATERIALINVVIEW.grid_MATERIALINV, "/origin/compliance/materialinv/materialInvList", params);
						}

					}

					$(document).ready(function () {
						MATERIALINVVIEW.Initialize_viewObject();
					});

				</script>
			</body>

			</html>