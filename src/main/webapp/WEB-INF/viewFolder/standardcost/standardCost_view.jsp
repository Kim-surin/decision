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
							<h1 class="subheader-title mb-1">자재별 표준단가 조회</h1>
							<nav class="app-breadcrumb" aria-label="breadcrumb">
								<ol class="breadcrumb ms-0 text-muted mb-0">
									<li class="breadcrumb-item">FTA 거래정보</li>
									<li class="breadcrumb-item active" aria-current="page">자재별 표준단가 조회</li>
								</ol>
							</nav>
						</div>
					</div>
					<div class="row">
						<form:form id="STANDARDCOST-form" class="s4-form" novalidate="novalidate" action=""
							method="post">
							<div id="panel-4" class="panel panel-icon">
								<div class="panel-container show">
									<div class="panel-content">
										<div class="row">
											<div class="col-4">
												<div class="mb-3">
													<label class="form-label" for="search_date">적용일자</label>
													<div class="d-flex gap-2">
														<input class="form-control" id="search_date" name="from_date"
															type="date" value="${from_date}">
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
															<option value="${item.division_code}">${item.division_name}
															</option>
														</c:forEach>
													</select>
												</div>
											</div>

											<div class="col">
												<button type="button"
													onclick="javascript:STANDARDCOSTVIEW.retrieve_GridData();"
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
							<div id="oAuiGrid_STANDARDCOST" style="width:100%;height:700px; margin:0 auto;"></div>
						</div>
					</div>
				</div>
				<script type="text/javascript">

					var STANDARDCOSTVIEW = new function () {
						this.grid_STANDARDCOST = null;

						this.Initialize_viewObject = function () {
							STANDARDCOSTVIEW.createAUIGrid();
							AUIGrid.setGridData(STANDARDCOSTVIEW.grid_STANDARDCOST, []);
						}

						this.createAUIGrid = function () {
							const columnLayout = [
								{dataField: "item_code", headerText: "자재코드", width: 250, filter: {showIcon: true}},
								{dataField: "item_name", headerText: "자재명", width: 250, filter: {showIcon: true}},
								{dataField: "division_name", headerText: "플랜트", width: 150, filter: {showIcon: true}},
								{
									dataField: "apply_date", headerText: "적용 시작일자", width: 250
									, dataType: "date", dateInputFormat: "yyyymmdd", formatString: "yyyy-mm-dd"
									, filter: {showIcon: true}
								},
								{
									dataField: "end_date", headerText: "적용 만료일자", width: 250
									, dataType: "date", dateInputFormat: "yyyymmdd", formatString: "yyyy-mm-dd"
									, filter: {showIcon: true}
								},
								{
									dataField: "standard_cost_amount", headerText: "표준단가", width: 300
									, dataType: "numeric", style: ""
									, editRenderer: {
										type: "InputEditRenderer",
										onlyNumeric: true, // 0~9만 입력가능
										textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
										autoThousandSeparator: true // 천단위 구분자 삽입 여부
									}
								}
							];

							const gridProps = {
								usePaging: true,
								pageRowCount: 50,
								showPageRowSelect: true,
								enableFilter: true
							};


							STANDARDCOSTVIEW.grid_STANDARDCOST = KpackageOBJ.auiGrid.create("oAuiGrid_STANDARDCOST", columnLayout, gridProps, "");
						}

						this.retrieve_GridData = function () {
							var params = {
								"search_date": KpackageOBJ.object.getFormValue("STANDARDCOST-form", "search_date").replace(/-/gi, "")
								, "item": KpackageOBJ.object.getFormValue("STANDARDCOST-form", "item")
								, "division_code": KpackageOBJ.object.getFormValue("STANDARDCOST-form", "division_code")
							}

							KpackageOBJ.auiGrid.retrieve(STANDARDCOSTVIEW.grid_STANDARDCOST, "/origin/compliance/standardCost/standardCostList", params);
						}

					}

					$(document).ready(function () {
						STANDARDCOSTVIEW.Initialize_viewObject();
					});

				</script>
			</body>

			</html>