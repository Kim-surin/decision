<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<style>
.aui-right-align,
.aui-right-align .aui-grid-renderer-base {
	width:100% !important;
	text-align:right !important;
}
.aui-center-align,
.aui-center-align .aui-grid-renderer-base {
	width:100% !important;
	text-align:center !important;
}
.aui-left-align,
.aui-left-align .aui-grid-renderer-base {
	width:100% !important;
	text-align:left !important;
}
.coomgt-file-row {
	display:flex;
	align-items:center;
	min-height:28px;
	margin-bottom:4px;
}
.coomgt-file-download {
	max-width:500px;
	overflow:hidden;
	text-overflow:ellipsis;
	white-space:nowrap;
	text-align:left;
}
.coomgt-file-delete {
	margin-left:8px;
	padding:2px 9px;
	font-size:12px;
	line-height:18px;
}
</style>
</head>
<body>
<div class="content-wrapper">
	<div class="row">
		<form:form id="coomgtDetail-form" class="s4-form" novalidate="novalidate" action="" method="post">
			<input type="hidden" id="coomgtDetail_companyCode" name="company_code" value="${sessionScope._sessionUser.company_code}">
			<input type="hidden" id="coomgtDetail_userId" name="user_id" value="${sessionScope._sessionUser.user_id}">
			<input type="hidden" id="coomgtDetail_vendorCode" name="vendorCode" value="${param.vendorCode}">
			<input type="hidden" id="coomgtDetail_divisionCode" name="divisionCode" value="${param.divisionCode}">
			<input type="hidden" id="coomgtDetail_beforeCooCertifyNo" name="cooCertifyNo" value="${param.cooCertifyNo}">
			<input type="hidden" id="coomgtDetail_submitStatus" name="submitStatus" value="${param.submitStatus}">
			<input type="hidden" id="coomgtDetail_inputType" name="inputType" value="${param.inputType}">
			<input type="hidden" id="coomgtDetail_cooCertifyType" name="cooCertifyType" value="${param.cooCertifyType}">
			<input type="hidden" id="coomgtDetail_warehousingNo" name="warehousingNo" value="${param.warehousingNo}">
			<input type="hidden" id="coomgtDetail_subconYn" name="subconYn" value="${param.subconYn}">
			<input type="hidden" id="coomgtDetail_subconDivision" name="subconDivision" value="${param.subconDivision}">
			<div class="col-12">
				<div id="coomgtDetail_panel" class="panel panel-icon">
					<div class="panel-container show">
						<div class="panel-content" style="padding:20px 32px;">
							<div style="display:flex; align-items:center; width:100%;">
								<div style="display:flex; align-items:center; width:50%;">
									<label class="form-label" for="coomgtDetail_cooCertifyNo" style="width:130px; margin:0;"><spring:message code="TXT.COO_CONFIRMATION_NO"/></label>
									<input class="form-control" id="coomgtDetail_cooCertifyNo" name="cooCertifyNoInput" type="text" readonly style="width:230px; background:#fff;">
									<button type="button" id="coomgtDetail_duplicateBtn" class="btn btn-sm btn-secondary" onclick="coomgtDetail.checkDuplicate();" style="display:none; margin-left:6px; white-space:nowrap;"><spring:message code="TXT.DUPLICATE_CHECK"/></button>
									<label id="coomgtDetail_autoArea" style="display:none; align-items:center; margin:0 0 0 8px; white-space:nowrap;">
										<input id="coomgtDetail_autoCreate" name="autoCreate" type="checkbox" style="margin-right:5px;"><spring:message code="TXT.AUTO_CREATE"/>
									</label>
								</div>
								<div style="display:flex; align-items:center; width:50%;">
									<label class="form-label" for="coomgtDetail_issueDate" style="width:125px; margin:0;"><spring:message code="TXT.PUBLICATION_DATE"/></label>
									<input class="form-control" id="coomgtDetail_issueDate" name="issueDate" type="date" readonly style="width:160px; background:#fff;">
								</div>
							</div>
							<br>
							<div style="display:flex; align-items:center; width:100%;">
								<div style="display:flex; align-items:center; width:50%;">
									<label class="form-label" for="coomgtDetail_confirmTypeName" style="width:130px; margin:0;"><spring:message code="TXT.CONFIRMATION_TYPE"/></label>
									<input class="form-control" id="coomgtDetail_confirmTypeName" type="text" readonly style="width:160px; background:#fff;">
								</div>
								<div id="coomgtDetail_coverPeriodArea" style="display:flex; align-items:center; width:50%;">
									<label class="form-label" style="width:125px; margin:0;"><spring:message code="TXT.COVER_CONFIRMATION_PERIOD"/></label>
									<div style="display:flex; align-items:center; gap:8px;">
										<input class="form-control" id="coomgtDetail_applyDate" name="applyDate" type="date" readonly style="width:160px; background:#fff;">
										<span>~</span>
										<input class="form-control" id="coomgtDetail_endDate" name="endDate" type="date" readonly style="width:160px; background:#fff;">
									</div>
								</div>
							</div>
							<div id="coomgtDetail_newFileArea" style="display:none; margin-top:20px;">
								<div style="display:flex; align-items:center;">
									<label class="form-label" style="width:130px; margin:0;"><spring:message code="TXT.ADDITIONAL_ATTACHMENT"/></label>
									<input id="coomgtDetail_FILEUP" name="FILEUP" type="file" multiple style="display:none;" onchange="coomgtDetail.changeFileName(this);">
									<button type="button" class="btn btn-sm btn-outline-primary" onclick="$('#coomgtDetail_FILEUP').click();" style="width:90px;"><spring:message code="TXT.SELECT_FILE"/></button>
									<input id="coomgtDetail_FILEUP_NAME" type="text" class="form-control" readonly placeholder="<spring:message code='TXT.NO_FILE_SELECTED'/>" style="width:300px; margin-left:8px; background:#fff;">
								</div>
							</div>
							<div style="margin-top:20px;">
								<div style="display:flex; align-items:flex-start;">
									<label class="form-label" style="width:130px; margin:0; padding-top:4px;"><spring:message code="TXT.EXISTING_ATTACHMENT"/></label>
									<div id="coomgtDetail_existingFileList" style="flex:1;"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form:form>
	</div>
	<div class="row">
		<div class="col-6">
			<div class="frame-wrap">
				<div class="demo" style="display:inline-flex; align-items:center; margin-left:10px;">
					<span style="font-size:13px; color:#666; margin-right:10px;"><spring:message code="TXT.TOTAL_COUNT"/></span>
					<span id="coomgtDetail_totalCount" style="font-size:16px; font-weight:700;">0</span>
					<span style="font-size:13px; color:#666; margin-left:3px;"><spring:message code="TXT.CASE"/></span>
				</div>
			</div>
		</div>
		<div class="col-6">
			<div class="frame-wrap">
				<div class="demo" style="display:flex; justify-content:flex-end; align-items:center; gap:3px;">
					<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="coomgtDetail.excelDownload();" style="width:110px; color:#fff; background-color:#526d82; border:1px solid #526d82;">ExcelDown</button>
					<button type="button" id="coomgtDetail_renewBtn" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="coomgtDetail.beginRenew();" style="display:none; width:110px; color:#fff; background-color:#526d82; border:1px solid #526d82;"><spring:message code="TXT.PERIOD_EXTENSION"/></button>
					<button type="button" id="coomgtDetail_renewSaveBtn" class="btn btn-sm btn-primary waves-effect waves-themed" onclick="coomgtDetail.saveRenew();" style="display:none; width:110px;"><spring:message code="TXT.SAVE_EXTENSION"/></button>
					<button type="button" id="coomgtDetail_cancelRenewBtn" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="coomgtDetail.cancelRenew();" style="display:none; width:110px;"><spring:message code="TXT.CANCEL"/></button>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-12">
			<div id="oAuiGrid_coomgtDetail_01" style="width:100%; height:480px; margin:0 auto;"></div>
		</div>
	</div>
</div>
<script>
var coomgtDetail = new function() {
	this.grid_coomgtDetail_01 = null;
	this.duplicateChecked = false;
	this.renewMode = false;
	this.originalData = {};
	this.Initialize_viewObject = function() {
		coomgtDetail.createAUIGrid();
		coomgtDetail.bindEvents();
	};
	this.bindEvents = function() {
		$("#coomgtDetail_cooCertifyNo").on("input", function() {
			coomgtDetail.duplicateChecked = false;
		});
		$("#coomgtDetail_autoCreate").on("change", function() {
			var checked = $(this).is(":checked");
			coomgtDetail.duplicateChecked = false;
			$("#coomgtDetail_cooCertifyNo").val("").prop("readonly", checked);
			$("#coomgtDetail_duplicateBtn").prop("disabled", checked);
		});
	};
	this.createAUIGrid = function() {
		const columnLayout = [
			{ dataField:"ITEM_CODE", headerText:"<spring:message code='TXT.ITEM_CODE2' javaScriptEscape='true'/>", width:120, filter:{showIcon:true}, style:"aui-center-align", cellMerge:true, editable:false },
			{ dataField:"ITEM_SPEC", headerText:"<spring:message code='TXT.MATERIAL_DETAILS' javaScriptEscape='true'/>", width:190, filter:{showIcon:true}, style:"aui-left-align", cellMerge:true, editable:false },
			{ dataField:"HS_CODE", headerText:"HS Code", width:100, filter:{showIcon:false}, style:"aui-center-align", cellMerge:true, editable:false },
			{ dataField:"FTA_NAME", headerText:"<spring:message code='TXT.FTA_NAME' javaScriptEscape='true'/>", width:140, filter:{showIcon:true}, style:"aui-center-align", editable:false },
			{ dataField:"COVER_DATE", headerText:"<spring:message code='TXT.COVER_PERIOD' javaScriptEscape='true'/>", width:190, filter:{showIcon:false}, style:"aui-center-align", editable:false },
			{ dataField:"COO_YN_NM", headerText:"<spring:message code='TXT.SATISFIED_YN' javaScriptEscape='true'/>", width:100, filter:{showIcon:true}, style:"aui-center-align", editable:false },
			{ dataField:"RULE_CODE", headerText:"<spring:message code='TXT.RULE_CRITERIA' javaScriptEscape='true'/>", width:180, filter:{showIcon:true}, style:"aui-center-align", editable:false },
			{ dataField:"RVC_RATE", headerText:"<spring:message code='TXT.RVC_RATE' javaScriptEscape='true'/>", width:110, filter:{showIcon:false}, style:"aui-center-align", editable:false },
			{ dataField:"COO_NATION_NM", headerText:"<spring:message code='TXT.ORIGIN' javaScriptEscape='true'/>", width:120, filter:{showIcon:true}, style:"aui-center-align", editable:false },
			{ dataField:"FTA_CODE", headerText:"FTA_CODE", visible:false },
			{ dataField:"COO_YN", headerText:"COO_YN", visible:false },
			{ dataField:"COO_NATION", headerText:"COO_NATION", visible:false },
			{ dataField:"APPLY_DATE", headerText:"APPLY_DATE", visible:false },
			{ dataField:"END_DATE", headerText:"END_DATE", visible:false },
			{ dataField:"WAREHOUSING_NO", headerText:"WAREHOUSING_NO", visible:false },
			{ dataField:"WAREHOUSING_SEQ", headerText:"WAREHOUSING_SEQ", visible:false },
			{ dataField:"ROW_ID", headerText:"ROW_ID", visible:false }
		];
		const gridProps = { editable:false, usePaging:true, pageRowCount:10, showPageRowSelect:true, enableFilter:true, enableCellMerge:true, rowIdField:"ROW_ID" };
		coomgtDetail.grid_coomgtDetail_01 = KpackageOBJ.auiGrid.create("oAuiGrid_coomgtDetail_01", columnLayout, gridProps, "");
	};
	this.retrieve_GridData = function() {
		var params = {
			COMPANY_CODE:$("#coomgtDetail_companyCode").val(),
			PARAM_DIVISION_CODE:$("#coomgtDetail_divisionCode").val(),
			PARAM_VENDOR_CODE:$("#coomgtDetail_vendorCode").val(),
			COO_CERTIFY_NO:$("#coomgtDetail_beforeCooCertifyNo").val(),
			COO_CERTIFY_TYPE:$("#coomgtDetail_cooCertifyType").val()
		};
		$.ajax({
			url:"/coomgt/retrieveCooConfirmationPopup",
			type:"POST",
			contentType:"application/json",
			dataType:"json",
			data:JSON.stringify(params),
			success:function(res) {
				if (typeof res === "string") res = JSON.parse(res);
				var gridData = res.value || [];
				AUIGrid.setGridData(coomgtDetail.grid_coomgtDetail_01, gridData);
				$("#coomgtDetail_totalCount").text(gridData.length);
				if (gridData.length > 0) {
					var firstRow = gridData[0];
					$("#coomgtDetail_cooCertifyNo").val(firstRow.COO_CERTIFY_NO || "");
					$("#coomgtDetail_issueDate").val(coomgtDetail.toDateInput(firstRow.ISSUE_DATE));
					$("#coomgtDetail_applyDate").val(coomgtDetail.toDateInput(firstRow.APPLY_DATE));
					$("#coomgtDetail_endDate").val(coomgtDetail.toDateInput(firstRow.END_DATE));
					if (firstRow.COO_CERTIFY_TYPE) $("#coomgtDetail_cooCertifyType").val(firstRow.COO_CERTIFY_TYPE);
					if (firstRow.INPUT_TYPE) $("#coomgtDetail_inputType").val(firstRow.INPUT_TYPE);
					coomgtDetail.originalData = {
						COO_CERTIFY_NO:firstRow.COO_CERTIFY_NO || "",
						ISSUE_DATE:coomgtDetail.toDateInput(firstRow.ISSUE_DATE),
						APPLY_DATE:coomgtDetail.toDateInput(firstRow.APPLY_DATE),
						END_DATE:coomgtDetail.toDateInput(firstRow.END_DATE)
					};
				}
				coomgtDetail.setMode();
				coomgtDetail.retrieveExistingFiles();
			},
			error:function(xhr) {
				console.log(xhr.responseText);
				alert("<spring:message code='MSG.DETAIL_RETRIEVE_ERROR' javaScriptEscape='true'/>");
			}
		});
	};
	this.setMode = function() {
		var type = $("#coomgtDetail_cooCertifyType").val();
		var inputType = $("#coomgtDetail_inputType").val();
		if (type == "C") {
			$("#coomgtDetail_confirmTypeName").val("<spring:message code='TXT.COMPREHENSIVE' javaScriptEscape='true'/>");
			$("#coomgtDetail_coverPeriodArea").show();
		} else {
			$("#coomgtDetail_confirmTypeName").val("<spring:message code='TXT.INDIVIDUAL' javaScriptEscape='true'/>");
			$("#coomgtDetail_coverPeriodArea").hide();
		}
		if (type == "C" && inputType == "I") $("#coomgtDetail_renewBtn").show();
		else $("#coomgtDetail_renewBtn").hide();
	};
	this.beginRenew = function() {
		if ($("#coomgtDetail_cooCertifyType").val() != "C" || $("#coomgtDetail_inputType").val() != "I") {
			alert("<spring:message code='MSG.ONLY_INTERNAL_COMPREHENSIVE_CAN_EXTEND' javaScriptEscape='true'/>");
			return;
		}
		coomgtDetail.renewMode = true;
		coomgtDetail.duplicateChecked = false;
		$("#coomgtDetail_cooCertifyNo").val("").prop("readonly", false);
		$("#coomgtDetail_issueDate").prop("readonly", false);
		$("#coomgtDetail_applyDate").prop("readonly", false);
		$("#coomgtDetail_endDate").prop("readonly", false);
		$("#coomgtDetail_duplicateBtn").show().prop("disabled", false);
		$("#coomgtDetail_autoArea").css("display", "flex");
		$("#coomgtDetail_newFileArea").show();
		$("#coomgtDetail_renewBtn").hide();
		$("#coomgtDetail_renewSaveBtn").show();
		$("#coomgtDetail_cancelRenewBtn").show();
	};
	this.cancelRenew = function() {
		coomgtDetail.renewMode = false;
		coomgtDetail.duplicateChecked = false;
		$("#coomgtDetail_cooCertifyNo").val(coomgtDetail.originalData.COO_CERTIFY_NO).prop("readonly", true);
		$("#coomgtDetail_issueDate").val(coomgtDetail.originalData.ISSUE_DATE).prop("readonly", true);
		$("#coomgtDetail_applyDate").val(coomgtDetail.originalData.APPLY_DATE).prop("readonly", true);
		$("#coomgtDetail_endDate").val(coomgtDetail.originalData.END_DATE).prop("readonly", true);
		$("#coomgtDetail_autoCreate").prop("checked", false);
		$("#coomgtDetail_duplicateBtn").hide();
		$("#coomgtDetail_autoArea").hide();
		$("#coomgtDetail_newFileArea").hide();
		$("#coomgtDetail_FILEUP").val("");
		$("#coomgtDetail_FILEUP_NAME").val("");
		$("#coomgtDetail_renewSaveBtn").hide();
		$("#coomgtDetail_cancelRenewBtn").hide();
		$("#coomgtDetail_renewBtn").show();
	};
	this.checkDuplicate = function() {
		var cooCertifyNo = $.trim($("#coomgtDetail_cooCertifyNo").val());
		if (!cooCertifyNo) {
			alert("<spring:message code='MSG.COO_CONFIRMATION_NO_REQUIRED' javaScriptEscape='true'/>");
			return;
		}
		$.ajax({
			url:"/coomgt/checkCooConfirmationListDuplicate",
			type:"POST",
			contentType:"application/json",
			dataType:"json",
			data:JSON.stringify({
				COMPANY_CODE:$("#coomgtDetail_companyCode").val(),
				PARAM_DIVISION_CODE:$("#coomgtDetail_divisionCode").val(),
				PARAM_VENDOR_CODE:$("#coomgtDetail_vendorCode").val(),
				COO_CERTIFY_NO:cooCertifyNo
			}),
			success:function(res) {
				if (typeof res === "string") res = JSON.parse(res);
				if (Number(res.value || 0) > 0) {
					coomgtDetail.duplicateChecked = false;
					alert("<spring:message code='MSG.COO_CONFIRMATION_NO_ALREADY_REGISTERED' javaScriptEscape='true'/>");
				} else {
					coomgtDetail.duplicateChecked = true;
					alert("<spring:message code='MSG.COO_CONFIRMATION_NO_AVAILABLE' javaScriptEscape='true'/>");
				}
			},
			error:function() {
				coomgtDetail.duplicateChecked = false;
				alert("<spring:message code='MSG.DUPLICATE_CHECK_ERROR' javaScriptEscape='true'/>");
			}
		});
	};
	this.saveRenew = function() {
		if (!coomgtDetail.renewMode) return;
		var autoCreate = $("#coomgtDetail_autoCreate").is(":checked");
		var cooCertifyNo = $.trim($("#coomgtDetail_cooCertifyNo").val());
		var issueDate = $("#coomgtDetail_issueDate").val();
		var applyDate = $("#coomgtDetail_applyDate").val();
		var endDate = $("#coomgtDetail_endDate").val();
		if (!autoCreate && !cooCertifyNo) {
			alert("<spring:message code='MSG.COO_CONFIRMATION_NO_REQUIRED' javaScriptEscape='true'/>");
			return;
		}
		if (!autoCreate && !coomgtDetail.duplicateChecked) {
			alert("<spring:message code='MSG.COO_CONFIRMATION_NO_DUPLICATE_CHECK_REQUIRED' javaScriptEscape='true'/>");
			return;
		}
		if (!issueDate || !applyDate || !endDate) {
			alert("<spring:message code='MSG.PUBLICATION_DATE_COVER_PERIOD_REQUIRED' javaScriptEscape='true'/>");
			return;
		}
		if (applyDate > endDate) {
			alert("<spring:message code='MSG.COVER_DATE_BEFORE' javaScriptEscape='true'/>");
			return;
		}
		var diffDays = Math.floor((new Date(endDate) - new Date(applyDate)) / 86400000);
		if (diffDays > 365) {
			alert("<spring:message code='MSG.COVER_DATE_OVER' javaScriptEscape='true'/>");
			return;
		}
		var gridData = AUIGrid.getGridData(coomgtDetail.grid_coomgtDetail_01);
		if (!gridData || gridData.length == 0) {
			alert("<spring:message code='MSG.NO_MATERIAL_TO_EXTEND' javaScriptEscape='true'/>");
			return;
		}
		var files = $("#coomgtDetail_FILEUP")[0].files;
		var param = {
			COMPANY_CODE:$("#coomgtDetail_companyCode").val(),
			PARAM_DIVISION_CODE:$("#coomgtDetail_divisionCode").val(),
			PARAM_VENDOR_CODE:$("#coomgtDetail_vendorCode").val(),
			BEFORE_COO_CERTIFY_NO:$("#coomgtDetail_beforeCooCertifyNo").val(),
			COO_CERTIFY_NO:cooCertifyNo,
			AUTO_COO_CERTIFY_NO:autoCreate ? "true" : "false",
			COO_CERTIFY_TYPE:"C",
			ISSUE_DATE:issueDate.replace(/-/g, ""),
			APPLY_DATE:applyDate.replace(/-/g, ""),
			END_DATE:endDate.replace(/-/g, ""),
			SUBMIT_STATUS:4,
			SUBMIT_TYPE:files.length > 0 ? "A" : "X",
			INPUT_TYPE:"I",
			DOCUMENT_TYPE:"D",
			APPLY_TYPE:"A",
			RENEW:"Y",
			USER_ID:$("#coomgtDetail_userId").val(),
			gridData:gridData
		};
		var formData = new FormData();
		formData.append(
			"data",
			new Blob(
				[JSON.stringify(param)],
				{type:"application/json"}
			)
		);
		for (var fileIndex = 0; fileIndex < files.length; fileIndex++) {
			formData.append("FILEUP", files[fileIndex]);
		}
		if (!confirm("<spring:message code='MSG.CONFIRM_PERIOD_EXTENSION' javaScriptEscape='true'/>")) return;
		$.ajax({
			url:"/coomgt/insertExtCooCertify",
			type:"POST",
			data:formData,
			processData:false,
			contentType:false,
			success:function(res) {
				if (typeof res === "string") res = JSON.parse(res);
				if (res.success) {
					alert("<spring:message code='MSG.PERIOD_EXTENSION_SUCCESS' javaScriptEscape='true'/>");
					if (typeof coomgt !== "undefined" && coomgt.retrieve_GridData) {
						coomgt.retrieve_GridData();
					}
					KpackageOBJ.dialog.close("previewPopup");
				} else {
					alert(res.message || "<spring:message code='MSG.PERIOD_EXTENSION_ERROR' javaScriptEscape='true'/>");
				}
			},
			error:function(xhr) {
				console.log(xhr.responseText);
				alert("<spring:message code='MSG.PERIOD_EXTENSION_ERROR' javaScriptEscape='true'/>");
			}
		});
	};
	this.retrieveExistingFiles = function() {
		$.ajax({
			url:"/coomgt/retrieveCooConfirmationListgetFileList",
			type:"POST",
			contentType:"application/json",
			dataType:"json",
			data:JSON.stringify({
				COMPANY_CODE:$("#coomgtDetail_companyCode").val(),
				PARAM_DIVISION_CODE:$("#coomgtDetail_divisionCode").val(),
				PARAM_VENDOR_CODE:$("#coomgtDetail_vendorCode").val(),
				COO_CERTIFY_NO:$("#coomgtDetail_beforeCooCertifyNo").val()
			}),
			success:function(res) {
				if (typeof res === "string") res = JSON.parse(res);
				var fileList = res.value || [];
				var $area = $("#coomgtDetail_existingFileList");
				$area.empty();
				if (fileList.length == 0) {
					$area.append(
						$("<span>")
							.css({fontSize:"13px", color:"#777"})
							.text("<spring:message code='MSG.NO_REGISTERED_ATTACHMENT' javaScriptEscape='true'/>")
					);
					return;
				}
				fileList.forEach(function(file) {
					var fileName = file.ORIGIN_FILE_NAME || file.FILE_NAME || "";
					var $row = $("<div>").addClass("coomgt-file-row");
					var $downloadButton = $("<button>")
						.attr("type", "button")
						.addClass("btn btn-link coomgt-file-download")
						.css({
							padding:"0",
							margin:"0",
							fontSize:"13px",
							textDecoration:"underline"
						})
						.attr("title", fileName)
						.text(fileName);
					$downloadButton.on("click", function() {
						coomgtDetail.downloadExistingFile(file.FILE_SEQ);
					});
					var $deleteButton = $("<button>")
						.attr("type", "button")
						.addClass("btn btn-sm btn-danger coomgt-file-delete")
						.text("<spring:message code='TXT.DELETE' javaScriptEscape='true'/>");
					$deleteButton.on("click", function() {
						coomgtDetail.deleteExistingFile(file.FILE_SEQ, fileName);
					});
					$row.append($downloadButton);
					$row.append($deleteButton);
					$area.append($row);
				});
			},
			error:function(xhr) {
				console.log(xhr.responseText);
				alert("<spring:message code='MSG.ATTACHMENT_LIST_RETRIEVE_ERROR' javaScriptEscape='true'/>");
			}
		});
	};
	this.downloadExistingFile = function(fileSeq) {
		var params = {
			COMPANY_CODE:$("#coomgtDetail_companyCode").val(),
			PARAM_DIVISION_CODE:$("#coomgtDetail_divisionCode").val(),
			PARAM_VENDOR_CODE:$("#coomgtDetail_vendorCode").val(),
			COO_CERTIFY_NO:$("#coomgtDetail_beforeCooCertifyNo").val(),
			FILE_SEQ:fileSeq
		};
		window.location.href = "/coomgt/extCooCertifyFileDownLoad?" + $.param(params);
	};
	this.deleteExistingFile = function(fileSeq, fileName) {
		if (!fileSeq) {
			alert("<spring:message code='MSG.NO_ATTACHMENT_INFO_TO_DELETE' javaScriptEscape='true'/>");
			return;
		}
		if (!confirm("'" + fileName + "' <spring:message code='MSG.CONFIRM_DELETE_FILE' javaScriptEscape='true'/>")) return;
		$.ajax({
			url:"/coomgt/deleteExtCooCertifyFile",
			type:"POST",
			contentType:"application/json",
			dataType:"json",
			data:JSON.stringify({
				COMPANY_CODE:$("#coomgtDetail_companyCode").val(),
				PARAM_DIVISION_CODE:$("#coomgtDetail_divisionCode").val(),
				PARAM_VENDOR_CODE:$("#coomgtDetail_vendorCode").val(),
				COO_CERTIFY_NO:$("#coomgtDetail_beforeCooCertifyNo").val(),
				FILE_SEQ:fileSeq
			}),
			success:function(res) {
				if (typeof res === "string") res = JSON.parse(res);
				if (res.success) {
					alert("<spring:message code='MSG.DELETE_SUCCESS' javaScriptEscape='true'/>");
					coomgtDetail.retrieveExistingFiles();
				} else {
					alert(res.message || "<spring:message code='MSG.ATTACHMENT_DELETE_ERROR' javaScriptEscape='true'/>");
				}
			},
			error:function(xhr) {
				console.log(xhr.responseText);
				alert("<spring:message code='MSG.ATTACHMENT_DELETE_ERROR' javaScriptEscape='true'/>");
			}
		});
	};
	this.changeFileName = function(obj) {
		if (!obj.files || obj.files.length == 0) {
			$("#coomgtDetail_FILEUP_NAME").val("");
			return;
		}
		var fileNames = [];
		for (var i = 0; i < obj.files.length; i++) {
			fileNames.push(obj.files[i].name);
		}
		$("#coomgtDetail_FILEUP_NAME").val(fileNames.join(", "));
	};
	this.excelDownload = function() {
		const exportProps = {
			fileName:"<spring:message code='TXT.COO_CONFIRMATION_DETAIL' javaScriptEscape='true'/>",
			sheetName:"<spring:message code='TXT.COO_CONFIRMATION_DETAIL' javaScriptEscape='true'/>",
			exportWithStyle:true,
			progressBar:true,
			showRowNumColumn:false
		};
		AUIGrid.exportToXlsx(
			coomgtDetail.grid_coomgtDetail_01,
			exportProps
		);
	};
	this.toDateInput = function(value) {
		if (!value) return "";
		var date = String(value).replace(/[^0-9]/g, "");
		if (date.length != 8) return value;
		return date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6, 8);
	};
};
$(document).ready(function() {
	pageSetUp();
	coomgtDetail.Initialize_viewObject();
	coomgtDetail.retrieve_GridData();
});
</script>
</body>
</html>
