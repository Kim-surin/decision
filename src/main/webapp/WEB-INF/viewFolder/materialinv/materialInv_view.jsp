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
													<label class="form-label" for="from_date">기준년월</label>
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
														<label class="form-label" for="example-input-border">자재</label>
													</div>
													<div class="col">
														<input type="text" id="item" class="form-control">
													</div>
												</div>
											</div>

											<div class="col-3">
												<div class="mb-3">
													<label class="form-label" for="example-select">플랜트</label>
													<select class="form-select" id="division_code">
														<option value="">전체</option>
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
													class="btn btn-sm btn-search search-more waves-effect waves-themed">Search</button>
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
							<div id="oAuiGrid_MATERIALINV" style="width:100%;height:480px; margin:0 auto;"></div>
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
								{dataField: "yyyymm", headerText: "기준년월", width: 120, filter: {showIcon: true}},
								{dataField: "division_name", headerText: "플랜트", width: 120, filter: {showIcon: true}},
								{dataField: "item_code", headerText: "자재코드", width: 200, filter: {showIcon: true}},
								{dataField: "item_name", headerText: "자재명", width: 200, filter: {showIcon: true}},
								{dataField: "unit", headerText: "단위", width: 80},
								{dataField: "aging_period", headerText: "재고회전기간(월)", width: 100},
								{
									headerText: "기초재고", children: [
										{
											dataField: "initial_qty", headerText: "수량", width: 120
											, dataType: "numeric", style: ""
											, editRenderer: {
												type: "InputEditRenderer",
												onlyNumeric: true, // 0~9만 입력가능
												textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
												autoThousandSeparator: true // 천단위 구분자 삽입 여부
											}
										}, {dataField: "initial_amount", headerText: "금액", width: 120},
									]
								},
								{
									headerText: "입고", children: [{
										dataField: "warehousing_qty", headerText: "수량"
										, width: 120
										, editRenderer: {
											type: "InputEditRenderer",
											onlyNumeric: true, // 0~9만 입력가능
											textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
											autoThousandSeparator: true // 천단위 구분자 삽입 여부
										}
									},
									{
										dataField: "input_qty", headerText: "금액"
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
									headerText: "기타입고", children: [{
										dataField: "input_amount", headerText: "수량"
										, width: 120
										, editRenderer: {
											type: "InputEditRenderer",
											onlyNumeric: true, // 0~9만 입력가능
											textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
											autoThousandSeparator: true // 천단위 구분자 삽입 여부
										}
									},
									{
										dataField: "input_amount", headerText: "금액"
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
									headerText: "출고", children: [{
										dataField: "issue_qty", headerText: "수량"
										, width: 120
										, editRenderer: {
											type: "InputEditRenderer",
											onlyNumeric: true, // 0~9만 입력가능
											textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
											autoThousandSeparator: true // 천단위 구분자 삽입 여부
										}
									},
									{
										dataField: "issue_amount", headerText: "금액"
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
									headerText: "기타출고", children: [{
										dataField: "extra_issue_qty", headerText: "수량"
										, width: 120
										, editRenderer: {
											type: "InputEditRenderer",
											onlyNumeric: true, // 0~9만 입력가능
											textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
											autoThousandSeparator: true // 천단위 구분자 삽입 여부
										}
									},
									{
										dataField: "extra_issue_amount", headerText: "금액"
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
									headerText: "기말재고", children: [{
										dataField: "inventory_qty", headerText: "수량"
										, width: 120
										, editRenderer: {
											type: "InputEditRenderer",
											onlyNumeric: true, // 0~9만 입력가능
											textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
											autoThousandSeparator: true // 천단위 구분자 삽입 여부
										}
									},
									{
										dataField: "inventory_amount", headerText: "금액"
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
								"from_date": KpackageOBJ.object.getFormValue("MATERIALINV-form", "from_date").replace(/-/gi, "")
								, "to_date": KpackageOBJ.object.getFormValue("MATERIALINV-form", "to_date").replace(/-/gi, "")
								, "item": KpackageOBJ.object.getFormValue("MATERIALINV-form", "item")
								, "division_code": KpackageOBJ.object.getFormValue("MATERIALINV-form", "division_code")
							}

							KpackageOBJ.auiGrid.retrieve(MATERIALINVVIEW.grid_MATERIALINV, "/origin/compliance/materialinv/materialInvList", params);
						}

					}


					$(document).ready(function () {
						pageSetUp();
						MATERIALINVVIEW.Initialize_viewObject();
					});

				</script>
			</body>

			</html>