<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<style>
.aui-right-align, .aui-right-align .aui-grid-renderer-base { width:100% !important; text-align:right !important; }
.aui-center-align, .aui-center-align .aui-grid-renderer-base { width:100% !important; text-align:center !important; }
.aui-left-align, .aui-left-align .aui-grid-renderer-base { width:100% !important; text-align:left !important; }
</style>
</head>
<body>
<div class="content-wrapper">
	<div class="row">
		<form:form id="ForeignItem-form" class="s4-form" novalidate="novalidate" action="" method="post">
			<input type="hidden" id="company_code" name="company_code" value="${sessionScope._sessionUser.company_code}">
			<div id="panel-4" class="panel panel-icon">
				<div class="panel-container show">
					<div class="panel-content">
						<div class="row">
							<div class="col-lg-4" style="width:600px;">
								<div class="row">
									<label class="form-label" for="search_key_word"><spring:message code='TXT.SEARCH_TYPE'/></label>
								</div>
								<div class="row mb-2">
									<div class="col-4" style="width:150px;">
										<select class="form-select" id="search_type" name="search_type">
											<option value="itemCd"><spring:message code="TXT.ITEM_CODE2"/></option>
											<option value="itemNm"><spring:message code="TXT.MATERIAL_NAME_GRID"/></option>
											<option value="vendorCd"><spring:message code="TXT.VENDOR_PARTNER_CODE"/></option>
											<option value="vendorNm"><spring:message code="TXT.VENDOR_NAME_GRID"/></option>
											<option value="cooCertifyNo"><spring:message code="TXT.COO_CONFIRMATION_NO"/></option>
										</select>
									</div>
									<div class="col">
										<input type="text" id="search_key_word" name="search_key_word" class="form-control" placeholder="<spring:message code='MSG.ENTER_SEARCH_KEYWORD'/>">
									</div>
								</div>
							</div>
							<div class="col-2">
								<div class="row mb-3">
									<div class="col-12">
										<label class="form-label" for="search_to_date"><spring:message code="TXT.COVER_DATE"/></label>
										<input class="form-control" id="search_to_date" name="search_to_date" type="date" value="<%= java.time.LocalDate.now() %>">
									</div>
								</div>
							</div>
							<div class="col-2" style="width:125px;">
								<div class="mb-2">
									<label class="form-label" for="cover_yn"><spring:message code="TXT.SATISFIED_YN"/></label>
									<select class="form-select" id="cover_yn" name="cover_yn">
										<option value="">ALL</option>
										<option value="Y">Y</option>
										<option value="N">N</option>
									</select>
								</div>
							</div>
							<div class="col">
								<button type="button" onclick="ForeignItem.retrieve_GridData();" class="btn btn-sm btn-search search-more waves-effect waves-themed">Search</button>
								<button type="button" onclick="toggleSearchMore(this,'ForeignItem_SEARCHMORE');" class="btn btn-xs btn-search-more waves-effect waves-themed">More</button>
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
				<div class="demo" style="display:flex; justify-content:flex-end; align-items:center; margin-bottom:5px;">
					<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="ForeignItem.excelDownload();" style="width:110px; color:#fff; background-color:#526d82; border:1px solid #526d82;">ExcelDown</button>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-12">
			<div id="oAuiGrid_ForeignItem_01" style="width:100%; height:480px; margin:0 auto;"></div>
		</div>
	</div>
</div>
</body>
<script>
var ForeignItem = new function() {
	this.grid_ForeignItem_01 = null;

	this.Initialize_viewObject = function() {
		ForeignItem.createAUIGrid();
		ForeignItem.retrieve_GridData();
	};

	this.createAUIGrid = function() {
		const columnLayout = [
			{ dataField:"VENDOR_CODE", headerText:"<spring:message code='TXT.VENDOR_PARTNER_CODE' javaScriptEscape='true'/>", width:80, filter:{showIcon:false}, style:"aui-center-align", cellMerge:true, editable:false },
			{ dataField:"VENDOR_NAME", headerText:"<spring:message code='TXT.VENDOR_NAME_GRID' javaScriptEscape='true'/>", width:140, filter:{showIcon:false}, style:"aui-left-align", cellMerge:true, editable:false },
			{ dataField:"ITEM_CODE", headerText:"<spring:message code='TXT.ITEM_CODE2' javaScriptEscape='true'/>", width:140, filter:{showIcon:false}, style:"aui-center-align", cellMerge:true, editable:false },
			{ dataField:"ITEM_NAME", headerText:"<spring:message code='TXT.MATERIAL_NAME_GRID' javaScriptEscape='true'/>", width:140, filter:{showIcon:false}, style:"aui-left-align", cellMerge:true, editable:false },
			{ dataField:"HS_CODE", headerText:"HSCODE", width:80, filter:{showIcon:false}, style:"aui-center-align", cellMerge:true, editable:false },
			{ dataField:"COO_CERTIFY_NO", headerText:"<spring:message code='TXT.COO_CONFIRMATION_NO' javaScriptEscape='true'/>", width:180, filter:{showIcon:false}, style:"aui-center-align", cellMerge:true, editable:false },
			{ dataField:"COO_PERIOD", headerText:"<spring:message code='TXT.COVER_PERIOD' javaScriptEscape='true'/>", width:190, filter:{showIcon:false}, style:"aui-center-align", editable:false },
			{ dataField:"FTA_NAME", headerText:"<spring:message code='TXT.FTA_NAME' javaScriptEscape='true'/>", width:140, filter:{showIcon:false}, style:"aui-center-align", editable:false },
			{ dataField:"RULE_CODE", headerText:"<spring:message code='TXT.RULE_CRITERIA' javaScriptEscape='true'/>", width:140, filter:{showIcon:false}, style:"aui-center-align", editable:false },
			{ dataField:"COO_YN", headerText:"<spring:message code='TXT.ORIGIN' javaScriptEscape='true'/> <spring:message code='TXT.SATISFIED_YN' javaScriptEscape='true'/>", width:140, filter:{showIcon:false}, style:"aui-center-align", editable:false },
			{ dataField:"APPLY_DATE", headerText:"APPLY_DATE", visible:false },
			{ dataField:"END_DATE", headerText:"END_DATE", visible:false },
			{ dataField:"D_HS_CODE", headerText:"D_HS_CODE", visible:false }
		];

		const gridProps = {
			editable:false,
			usePaging:true,
			pageRowCount:20,
			showPageRowSelect:true,
			enableFilter:true,
			enableCellMerge:true
		};

		ForeignItem.grid_ForeignItem_01 = KpackageOBJ.auiGrid.create("oAuiGrid_ForeignItem_01", columnLayout, gridProps, "");
	};

	this.retrieve_GridData = function() {
		var params = {
			COMPANY_CODE:$("#company_code").val(),
			search_type:$("#search_type").val(),
			search_key_word:$("#search_key_word").val(),
			SCH_APPLY_DATE:$("#search_to_date").val().replace(/-/g, ""),
			cover_yn:$("#cover_yn").val()
		};

		KpackageOBJ.auiGrid.retrieve(
			ForeignItem.grid_ForeignItem_01,
			"/foreignitem/retrieveForeignItem",
			params
		);
	};

	this.excelDownload = function() {
		const exportProps = {
			fileName:"<spring:message code='TXT.COO_CONFIRMATION_MATERIAL_DETAILS' javaScriptEscape='true'/>".replace(/ /g, "_"),
			sheetName:"<spring:message code='TXT.COO_CONFIRMATION_MATERIAL_DETAILS' javaScriptEscape='true'/>",
			exportWithStyle:true,
			progressBar:true,
			showRowNumColumn:false
		};

		AUIGrid.exportToXlsx(
			ForeignItem.grid_ForeignItem_01,
			exportProps
		);
	};
};

$(document).ready(function() {
	pageSetUp();
	ForeignItem.Initialize_viewObject();
});
</script>
</html>