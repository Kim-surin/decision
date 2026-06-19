<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
		<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
		<html>

		<head>
		</head>

		<body>
			<div class="content-wrapper">
				<div class="row">
					<div class="content-wrapper col-3">
						<h1 class="subheader-title mb-1">SAMPLE PAGE 001</h1>
						<nav class="app-breadcrumb" aria-label="breadcrumb">
							<ol class="breadcrumb ms-0 text-muted mb-0">
								<li class="breadcrumb-item">FTA 거래정보</li>
								<li class="breadcrumb-item active" aria-current="page">원재료수불부 조회</li>
							</ol>
						</nav>
					</div>
				</div>
				<div class="row">
					<form:form id="MATERIALINV-form" class="s4-form" novalidate="novalidate" action="" method="post">
						<div id="panel-4" class="panel panel-icon">
							<div class="panel-container show">
								<div class="panel-content">
									<div class="row">
										<div class="col-4">
											<div class="row mb-3">
												<div class="col-6">
													<label class="form-label" for="from_date">기준년월</label>
													<div class="d-flex gap-2">
														<input class="form-control" id="from_date" name="from_date"
															type="date" value="2024-01-01">
														<input class="form-control" id="to_date" name="to_date"
															type="date" value="2027-01-31">
													</div>
												</div>
											</div>
										</div>

										<div class="col-lg-5">
											<div class="row">
												<label class="form-label" for="example-input-border">자재</label>
											</div>
											<div class="col">
												<input type="text" id="item" class="form-control">
											</div>
										</div>

										<div class="col-2">
											<div class="mb-3">
												<label class="form-label" for="example-select">플랜트</label>
												<select class="form-select" id="division_code">
													<option value="">전체</option>
												</select>
											</div>
										</div>

										<div class="col">
											<button type="button" onclick="javascript:MATERIALINVVIEW.retrieve_GridData();"
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
							{dataField: "yyyymm", headerText: "기준년월", width: 120},
							{dataField: "division_name", headerText: "플랜트", width: 120},
							{dataField: "item_code", headerText: "자재코드", width: 150},
							{dataField: "item_name", headerText: "자재명", width: 150},
							{dataField: "unit", headerText: "단위", width: 80},
							{dataField: "aging_period", headerText: "재고회전기간(월)", width: 80},
							{
								dataField: "initial_qty", headerText: "기초재고 수량", width: 100
								, dataType: "numeric", style: ""
								, editRenderer: {
									type: "InputEditRenderer",
									onlyNumeric: true, // 0~9만 입력가능
									textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
									autoThousandSeparator: true // 천단위 구분자 삽입 여부
								}
							},
							{dataField: "initial_amount", headerText: "기초재고 금액", width: 100},
							{
								dataField: "warehousing_qty", headerText: "입고 수량"
								, editRenderer: {
									type: "InputEditRenderer",
									onlyNumeric: true, // 0~9만 입력가능
									textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
									autoThousandSeparator: true // 천단위 구분자 삽입 여부
								}
							},
							{
								dataField: "input_qty", headerText: "입고 금액"
								, editRenderer: {
									type: "InputEditRenderer",
									onlyNumeric: true, // 0~9만 입력가능
									textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
									autoThousandSeparator: true // 천단위 구분자 삽입 여부
								}
							},
							{
								dataField: "input_amount", headerText: "기타입고 수량"
								, editRenderer: {
									type: "InputEditRenderer",
									onlyNumeric: true, // 0~9만 입력가능
									textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
									autoThousandSeparator: true // 천단위 구분자 삽입 여부
								}
							},
							{
								dataField: "input_amount", headerText: "기타입고 금액"
								, editRenderer: {
									type: "InputEditRenderer",
									onlyNumeric: true, // 0~9만 입력가능
									textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
									autoThousandSeparator: true // 천단위 구분자 삽입 여부
								}
							},
							{
								dataField: "issue_qty", headerText: "출고 수량"
								, editRenderer: {
									type: "InputEditRenderer",
									onlyNumeric: true, // 0~9만 입력가능
									textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
									autoThousandSeparator: true // 천단위 구분자 삽입 여부
								}
							},
							{
								dataField: "issue_amount", headerText: "출고 금액"
								, editRenderer: {
									type: "InputEditRenderer",
									onlyNumeric: true, // 0~9만 입력가능
									textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
									autoThousandSeparator: true // 천단위 구분자 삽입 여부
								}
							},
							{
								dataField: "extra_issue_qty", headerText: "기타출고 수량"
								, editRenderer: {
									type: "InputEditRenderer",
									onlyNumeric: true, // 0~9만 입력가능
									textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
									autoThousandSeparator: true // 천단위 구분자 삽입 여부
								}
							},
							{
								dataField: "extra_issue_amount", headerText: "기타출고 금액"
								, editRenderer: {
									type: "InputEditRenderer",
									onlyNumeric: true, // 0~9만 입력가능
									textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
									autoThousandSeparator: true // 천단위 구분자 삽입 여부
								}
							},
							{
								dataField: "inventory_qty", headerText: "기말재고 수량"
								, editRenderer: {
									type: "InputEditRenderer",
									onlyNumeric: true, // 0~9만 입력가능
									textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
									autoThousandSeparator: true // 천단위 구분자 삽입 여부
								}
							},
							{
								dataField: "inventory_amount", headerText: "기말재고 금액"
								, editRenderer: {
									type: "InputEditRenderer",
									onlyNumeric: true, // 0~9만 입력가능
									textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
									autoThousandSeparator: true // 천단위 구분자 삽입 여부
								}
							}
						];

						const gridProps = {
							//추가속성이 필요한 경우 작성 
							//editable : true,  // 그리드 수정 모드 

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