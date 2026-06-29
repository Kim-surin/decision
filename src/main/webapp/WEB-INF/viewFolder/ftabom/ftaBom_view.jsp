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
								<li class="breadcrumb-item active" aria-current="page">FTA BOM 조회</li>
							</ol>
						</nav>
					</div>
				</div>
				<div class="row">
					<form:form id="FTABOM-form" class="s4-form" novalidate="novalidate" action="" method="post">
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
												<label class="form-label" for="example-input-border">제품</label>
											</div>
											<div class="col">
												<input type="text" id="product" class="form-control">
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
											<button type="button" onclick="javascript:FTABOMVIEW.retrieve_GridData();"
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
						<div id="oAuiGrid_FTABOM_MASTER" style="width:100%;height:480px; margin:0 auto;"></div>
					</div>
				</div>
				<div class="row">
					<div class="col-8">
						<div id="oAuiGrid_FTABOM_DETAIL" style="width:100%;height:480px; margin:0 auto;"></div>
					</div>
					<div class="col-4">
						<div id="oAuiGrid_FTABOM_DETAIL_CUSTOMER" style="width:100%;height:480px; margin:0 auto;"></div>
					</div>
				</div>
			</div>
			<script type="text/javascript">

				var FTABOMVIEW = new function () {
					this.grid_FTABOM_MST = null;
					this.grid_FTABOM_DTL = null;
					this.grid_FTABOM_DTL_CUSTOMER = null;

					this.Initialize_viewObject = function () {
						FTABOMVIEW.createAUIGrid();
						AUIGrid.setGridData(FTABOMVIEW.grid_FTABOM_MST, FTABOMVIEW.data);
						AUIGrid.setGridData(FTABOMVIEW.grid_FTABOM_DTL, FTABOMVIEW.data);
					}

					this.data = [];

					this.createAUIGrid = function () {
						const columnLayoutMst = [
							{dataField: "yyymm", headerText: "기준년월", width: 120},
							{dataField: "division_name", headerText: "플랜트", width: 120},
							{dataField: "product_code", headerText: "제품코드", width: 200},
							{dataField: "product_name", headerText: "제품명", width: 200},
							{dataField: "hs_code", headerText: "HS코드", width: 200}
						];

						const gridPropsMst = {
							//추가속성이 필요한 경우 작성 
							//editable : true,  // 그리드 수정 모드 

						};

						FTABOMVIEW.grid_FTABOM_MST = KpackageOBJ.auiGrid.create("oAuiGrid_FTABOM_MASTER", columnLayoutMst, gridPropsMst, "");

						const columnLayoutDtl = [
							{dataField: "yyymm", headerText: "기준년월", width: 120},
							{dataField: "division_name", headerText: "플랜트", width: 120},
							{dataField: "product_code", headerText: "제품코드", width: 200},
							{dataField: "product_name", headerText: "제품명", width: 200},
							{dataField: "hs_code", headerText: "HS코드", width: 200}
						];

						const gridPropsDtl = {
							//추가속성이 필요한 경우 작성 
							//editable : true,  // 그리드 수정 모드 

						};

						FTABOMVIEW.grid_FTABOM_DTL = KpackageOBJ.auiGrid.create("oAuiGrid_FTABOM_DETAIL", columnLayoutDtl, gridPropsDtl, "");

						const columnLayoutDtlCustomer = [
							{dataField: "customer_name", headerText: "구매업체", width: 120}
						];

						const gridPropsDtlCustomer = {
							//추가속성이 필요한 경우 작성 
							//editable : true,  // 그리드 수정 모드 

						};

						FTABOMVIEW.grid_FTABOM_DTL_CUSTOMER = KpackageOBJ.auiGrid.create("oAuiGrid_FTABOM_DETAIL_CUSTOMER", columnLayoutDtlCustomer, gridPropsDtlCustomer, "");
					}

					this.retrieve_GridData = function () {
						var params = {
							/* 날짜 파라메터 '-' 제거  */
							"from_date": KpackageOBJ.object.getFormValue("FTABOM-form", "from_date").replace(/-/gi, "")
							, "to_date": KpackageOBJ.object.getFormValue("FTABOM-form", "to_date").replace(/-/gi, "")
							, "product": KpackageOBJ.object.getFormValue("FTABOM-form", "product")
							, "division_code": KpackageOBJ.object.getFormValue("FTABOM-form", "division_code")
						}

						KpackageOBJ.auiGrid.retrieve(FTABOMVIEW.grid_FTABOM_MST, "/origin/compliance/ftaBom/ftaBomMasterList", params);
					}
				}


				$(document).ready(function () {
					pageSetUp();
					FTABOMVIEW.Initialize_viewObject();
				});

			</script>
		</body>

		</html>