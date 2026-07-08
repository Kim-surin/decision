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
							<h1 class="subheader-title mb-1">구매원장 조회</h1>
							<nav class="app-breadcrumb" aria-label="breadcrumb">
								<ol class="breadcrumb ms-0 text-muted mb-0">
									<li class="breadcrumb-item">FTA 거래정보</li>
									<li class="breadcrumb-item active" aria-current="page">구매원장 조회</li>
								</ol>
							</nav>
						</div>
					</div>
					<div class="row">
						<form:form id="poledger-form" class="s4-form" novalidate="novalidate" action="" method="post">
							<div id="panel-4" class="panel panel-icon">
								<div class="panel-container show">
									<div class="panel-content">
										<div class="row">
											<div class="col-4">
												<div class="mb-3">
													<label class="form-label" for="from_date">입고일자</label>
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
													<label class="form-label" for="example-select">확인서 수취여부</label>
													<select class="form-select" id="coo_certify_yn">
														<option value="">전체</option>
														<option value="Y">수취</option>
														<option value="N">미수취</option>
													</select>
												</div>
											</div>

											<div class="col">
												<button type="button"
													onclick="javascript:POLEDGERVIEW.retrieve_GridData();"
													class="btn btn-sm btn-search search-more waves-effect waves-themed">Search</button>
												<button type="button"
													onclick="javascript:toggleSearchMore(this,'POLEDGER_SEARCHMORE');"
													class="btn btn-xs btn-search-more waves-effect waves-themed">More</button>
											</div>
										</div>

										<!--숨겨진 영역-->
										<div class="row" id="POLEDGER_SEARCHMORE" style="display: none;">
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
													<label class="form-label" for="example-select">입고구분</label>
													<select class="form-select" id="warehousing_type">
														<c:forEach items="${warehousing_type}" var="item">
															<option value="${item.code}">${item.name}
															</option>
														</c:forEach>
													</select>
												</div>
											</div>
											<div class="col-3">
												<div class="mb-3">
													<label class="form-label" for="example-select">집중관리 협력사</label>
													<select class="form-select" id="mail_send_yn">
														<option value="">전체</option>
														<option value="Y">관리</option>
														<option value="N">미관리</option>
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
							<div id="oAuiGrid_poledger" style="width:100%;height:700px; margin:0 auto;"></div>
						</div>
					</div>
				</div>
				<script type="text/javascript">

					var POLEDGERVIEW = new function () {
						this.grid_poledger = null;

						this.Initialize_viewObject = function () {
							POLEDGERVIEW.createAUIGrid();
							AUIGrid.setGridData(POLEDGERVIEW.grid_poledger, POLEDGERVIEW.data);
						}

						this.data = [];

						this.createAUIGrid = function () {
							const columnLayout = [
								{dataField: "division_name", headerText: "플랜트", width: 120, filter: {showIcon: true}},
								{dataField: "warehousing_no", headerText: "입고번호", width: 140, filter: {showIcon: true}},
								{dataField: "order_no", headerText: "발주번호", width: 140},
								{dataField: "vendor_code", headerText: "협력사코드", width: 150, filter: {showIcon: true}},
								{dataField: "vendor_name", headerText: "협력사명", width: 150, filter: {showIcon: true}},
								{dataField: "item_code", headerText: "자재코드", width: 250,  filter: {showIcon: true}},
								{dataField: "item_name", headerText: "자재명", width: 250,  filter: {showIcon: true}},
								{
									dataField: "warehousing_amount", headerText: "입고금액", width: 150
									, dataType: "numeric", style: ""
									, editRenderer: {
										type: "InputEditRenderer",
										onlyNumeric: true, // 0~9만 입력가능
										textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
										autoThousandSeparator: true // 천단위 구분자 삽입 여부
									}
								},
								{dataField: "warehousing_type_name", headerText: "입고구분", width: 100},
								{
									dataField: "warehousing_qty", headerText: "수량"
									, editRenderer: {
										type: "InputEditRenderer",
										onlyNumeric: true, // 0~9만 입력가능
										textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
										autoThousandSeparator: true // 천단위 구분자 삽입 여부
									}
								},
								{
									dataField: "unit_price", headerText: "단가"
									, editRenderer: {
										type: "InputEditRenderer",
										onlyNumeric: true, // 0~9만 입력가능
										textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
										autoThousandSeparator: true // 천단위 구분자 삽입 여부
									}
								},
								{dataField: "coo_certify_yn", headerText: "확인서 수취 여부", style: "aui-grid-renderer-center"}
							];

							const gridProps = {
								usePaging: true,
								pageRowCount: 50,
								showPageRowSelect: true,
								enableFilter: true
							};


							POLEDGERVIEW.grid_poledger = KpackageOBJ.auiGrid.create("oAuiGrid_poledger", columnLayout, gridProps, "");
						}

						this.retrieve_GridData = function () {
							var params = {
								/* 날짜 파라메터 '-' 제거  */
								"from_date": KpackageOBJ.object.getFormValue("poledger-form", "from_date").replace(/-/gi, "")
								, "to_date": KpackageOBJ.object.getFormValue("poledger-form", "to_date").replace(/-/gi, "")
								, "item": KpackageOBJ.object.getFormValue("poledger-form", "item")
								, "coo_certify_yn": KpackageOBJ.object.getFormValue("poledger-form", "coo_certify_yn")
								, "division_code": KpackageOBJ.object.getFormValue("poledger-form", "division_code")
								, "warehousing_type": KpackageOBJ.object.getFormValue("poledger-form", "warehousing_type")
								, "mail_send_yn": KpackageOBJ.object.getFormValue("poledger-form", "mail_send_yn")
							}

							KpackageOBJ.auiGrid.retrieve(POLEDGERVIEW.grid_poledger, "/origin/compliance/poledger/poledgerList", params);
						}

					}


					$(document).ready(function () {
						pageSetUp(); // [TODO] 무슨 용도인지 확인	
						POLEDGERVIEW.Initialize_viewObject();

						// [TODO] 공통 페이지로 분리
						$("#searchKeyword").on("keydown", function (event) {
							if (event.key === "Enter" || event.keyCode === 13) {
								event.preventDefault();
								POLEDGERVIEW.retrieve_GridData();
							}
						});

					});

				</script>
			</body>

			</html>