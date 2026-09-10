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
													<label class="form-label" for="from_date"><spring:message code='TXT.ARRIVAL_DATE'/></label> <!--입고일자-->
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
														<label class="form-label" for="example-input-border"><spring:message code='TXT.MATERIAL'/></label> <!--자재-->
													</div>
													<div class="col">
														<input type="text" id="item" class="form-control">
													</div>
												</div>
											</div>

											<div class="col-3">
												<div class="mb-3">
													<label class="form-label" for="example-select"><spring:message code='TXT.COVER_RECEIPT_YN'/></label> <!--확인서 수취여부-->
													<select class="form-select" id="coo_certify_yn">
														<option value=""><spring:message code='TXT.ALL'/></option> <!--전체-->
														<option value="Y"><spring:message code='TXT.RECEIPT'/></option> <!--수취-->
														<option value="N"><spring:message code='TXT.NOT_RECEIVED'/></option> <!--미수취-->
													</select>
												</div>
											</div>

											<div class="col">
												<button type="button"
													onclick="javascript:POLEDGERVIEW.retrieve_GridData();"
													class="btn btn-sm btn-search search-more waves-effect waves-themed"><spring:message code='TXT.SEARCH'/></button> <!--조회-->
												<button type="button"
													onclick="javascript:toggleSearchMore(this,'POLEDGER_SEARCHMORE');"
													class="btn btn-xs btn-search-more waves-effect waves-themed"><spring:message code='TXT.MORE'/></button> <!--더보기-->
											</div>
										</div>

										<!--숨겨진 영역-->
										<div class="row" id="POLEDGER_SEARCHMORE" style="display: none;">
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
													<label class="form-label" for="example-select"><spring:message code='TXT.WAREHOUSING_TYPE'/></label> <!--입고구분-->
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
													<label class="form-label" for="example-select"><spring:message code='TXT.INTENSIVE_VENDOR'/></label> <!--집중관리 협력사-->
													<select class="form-select" id="mail_send_yn">
														<option value=""><spring:message code='TXT.ALL'/></option> <!--전체-->
														<option value="Y"><spring:message code='TXT.MANAGED'/></option> <!--관리-->
														<option value="N"><spring:message code='TXT.NOT_MANAGED'/></option> <!--미관리-->
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
								{dataField: "division_name", headerText: "<spring:message code='TXT.PLANT'/>", width: 120, filter: {showIcon: true}}, //플랜트
								{dataField: "warehousing_no", headerText: "<spring:message code='TXT.WAREHOUSING_NO'/>", width: 140, filter: {showIcon: true}}, //입고번호
								{dataField: "order_no", headerText: "<spring:message code='TXT.ORDER_NO'/>", width: 140}, //발주번호
								{dataField: "vendor_code", headerText: "<spring:message code='TXT.VENDOR_CODE'/>", width: 150, filter: {showIcon: true}}, //협력사코드
								{dataField: "vendor_name", headerText: "<spring:message code='TXT.VENDOR_NAME_GRID'/>", width: 150, filter: {showIcon: true}}, //협력사명
								{dataField: "item_code", headerText: "<spring:message code='TXT.RAW_MATERIAL_CODE'/>", width: 250, filter: {showIcon: true}}, //자재코드
								{dataField: "item_name", headerText: "<spring:message code='TXT.RAW_MATERIAL_NAME'/>", width: 250, filter: {showIcon: true}}, //자재명
								{
									dataField: "warehousing_amount", headerText: "<spring:message code='TXT.WAREHOUSING_AMOUNT'/>", width: 150 //입고금액
									, dataType: "numeric", style: ""
									, editRenderer: {
										type: "InputEditRenderer",
										onlyNumeric: true, // 0~9만 입력가능
										textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
										autoThousandSeparator: true // 천단위 구분자 삽입 여부
									}
								},
								{dataField: "warehousing_type_name", headerText: "<spring:message code='TXT.WAREHOUSING_TYPE'/>", width: 100}, //입고구분
								{
									dataField: "warehousing_qty", headerText: "<spring:message code='TXT.QTY'/>" //수량
									, editRenderer: {
										type: "InputEditRenderer",
										onlyNumeric: true, // 0~9만 입력가능
										textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
										autoThousandSeparator: true // 천단위 구분자 삽입 여부
									}
								},
								{
									dataField: "unit_price", headerText: "<spring:message code='TXT.UNIT_PRICE'/>" //단가
									, editRenderer: {
										type: "InputEditRenderer",
										onlyNumeric: true, // 0~9만 입력가능
										textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
										autoThousandSeparator: true // 천단위 구분자 삽입 여부
									}
								},
								{dataField: "coo_certify_yn", headerText: "<spring:message code='TXT.COVER_RECEIPT_YN'/>", style: "aui-grid-renderer-center"} //확인서 수취 여부
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
								, "search_division_code": KpackageOBJ.object.getFormValue("poledger-form", "search_division_code")
								, "warehousing_type": KpackageOBJ.object.getFormValue("poledger-form", "warehousing_type")
								, "mail_send_yn": KpackageOBJ.object.getFormValue("poledger-form", "mail_send_yn")
							}

							KpackageOBJ.auiGrid.retrieve(POLEDGERVIEW.grid_poledger, "/origin/compliance/poledger/poledgerList", params);
						}

					}


					$(document).ready(function () {
						POLEDGERVIEW.Initialize_viewObject();
					});

				</script>
			</body>

			</html>