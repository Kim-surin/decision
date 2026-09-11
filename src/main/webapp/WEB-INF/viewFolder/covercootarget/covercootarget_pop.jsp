<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<div class="content-wrapper">
    <div class="row">
        <form:form id="coverCootargetPop-form" class="s4-form" novalidate="novalidate" action="" method="post">
            <input type="hidden" id="company_code" name="company_code" value="${sessionScope._sessionUser.company_code}">
            <input type="hidden" id="hsCodes" name="hsCodes" value="${param.hsCodes}">
            <input type="hidden" id="vendorCode" name="vendorCode" value="${param.vendorCode}">
            <input type="hidden" id="divisionCode" name="divisionCode" value="${param.divisionCode}">
            <input type="hidden" id="popupItemCodes" name="itemCodes" value="${param.itemCodes}">
            <input type="hidden" id="cooCertifyNoParam" value="${param.cooCertifyNo}">
            <input type="hidden" id="userId" value="${sessionScope._sessionUser.user_id}">
            <div id="panel-4" class="panel panel-icon">
                <div class="panel-container show">
                    <div class="panel-content" style="padding:20px 32px;">
                        <div style="display:flex; align-items:center; width:100%;">
                            <div style="display:flex; align-items:center; width:50%;">
                                <label class="form-label" for="cooCertifyNo" style="width:125px; margin:0;"><spring:message code="TXT.COO_CERT_NO"/></label>
                                <input class="form-control" id="cooCertifyNo" name="cooCertifyNo" type="text" style="width:200px;">
                                <button type="button" id="duplicateBtn" class="btn btn-sm btn-secondary" onclick="CoverCootargetPopup.checkDuplicate();" style="margin-left:6px; white-space:nowrap;"><spring:message code="TXT.DUPLICATE_CHECK"/></button>
                                <label style="display:flex; align-items:center; margin:0 0 0 8px; white-space:nowrap;">
                                    <input id="autoCreate" name="autoCreate" type="checkbox" style="margin-right:6px;">
                                    <spring:message code="TXT.AUTO_CREATE"/>
                                </label>
                            </div>
                            <div style="display:flex; align-items:center; width:50%;">
                                <label class="form-label" for="issueDate" style="width:125px; margin:0;"><spring:message code="TXT.PUBLICATION_DATE"/></label>
                                <input class="form-control" id="issueDate" type="date" value="<%= java.time.LocalDate.now() %>" style="width:140px;">
                            </div>
                        </div>
                        <br>
                        <div style="display:flex; align-items:center; width:100%;">
                            <div style="display:flex; align-items:center; width:50%;">
                                <label class="form-label" style="width:125px; margin:0;"><spring:message code="TXT.CERTIFICATE_TYPE"/></label>
                                <label style="display:flex; align-items:center; margin:0 0 0 8px; white-space:nowrap;"><spring:message code="TXT.COMPREHENSIVE"/></label>
                            </div>
                            <div style="display:flex; align-items:center; width:50%;">
                                <label class="form-label" style="width:125px; margin:0;"><spring:message code="TXT.COVER_CONFIRMATION_PERIOD"/></label>
                                <div style="display:flex; align-items:center; gap:10px;">
                                    <input class="form-control" id="applyDate" type="date" value="<%= java.time.LocalDate.now().withDayOfMonth(1) %>" style="width:140px;">
                                    <span style="display:inline-block; min-width:6px; text-align:center;">~</span>
                                    <input class="form-control" id="endDate" type="date" value="<%= java.time.LocalDate.now().withDayOfMonth(1).plusYears(1).minusDays(1) %>" style="width:140px;">
                                </div>
                            </div>
                        </div>
                        <br>
                        <div style="display:flex; align-items:center; width:100%;">
                            <div style="display:flex; align-items:center; width:50%;">
                                <label class="form-label" style="width:125px; margin:0;"><spring:message code="TXT.BULK_SATISFACTION_CHANGE"/></label>
                                <div class="col-4" style="width:100px;">
                                    <select class="form-select" id="bulkCooYn" name="bulkCooYn">
                                        <option value="Y"><spring:message code="TXT.SATISFIED"/></option>
                                        <option value="N"><spring:message code="TXT.NOT_SATISFIED"/></option>
                                    </select>
                                </div>
                                <button type="button" id="bulkApplyBtn" class="btn btn-sm btn-secondary" onclick="CoverCootargetPopup.applyBulkCooYn();" style="margin-left:6px; white-space:nowrap;"><spring:message code="TXT.APPLICATION"/></button>
                            </div>
                        </div>
                        <br>
                        <div style="display:flex; align-items:center; width:100%;">
						    <div style="display:flex; align-items:center; width:50%;">
						        <label class="form-label" style="width:120px; margin:0;"><spring:message code="TXT.FILE_ATTACHMENT"/></label>
						        <div style="display:flex; align-items:center; gap:8px;">
						            <input id="FILEUP" name="FILEUP" type="file" multiple style="display:none;" onchange="CoverCootargetPopup.changeFileName(this);">
						            <button type="button" id="fileSelectBtn" class="btn btn-sm btn-outline-primary" onclick="$('#FILEUP').click();" style="height:32px; min-width:90px;"><spring:message code="TXT.SELECT_FILE"/></button>
						            <input id="FILEUP_NAME" type="text" class="form-control" placeholder="<spring:message code='TXT.NO_FILE_SELECTED'/>" readonly style="width:280px; height:32px; background:#fff;">
						        </div>
						    </div>
						</div>
						<div id="existingFileArea" style="display:none; margin-top:10px;">
						    <div style="display:flex; align-items:flex-start;">
						        <label class="form-label" style="width:120px; margin:0;"><spring:message code="TXT.EXISTING_ATTACHMENT"/></label>
						        <div id="existingFileList"></div>
						    </div>
						</div>
                    </div>
                </div>
            </div>
        </form:form>
    </div>
    <div class="row">
        <div class="col-7">
            <div class="frame-wrap">
                <div class="demo" style="display:inline-flex; align-items:center; margin-left:10px;">
                    <span style="font-size:13px; color:#666; margin-right:10px;"><spring:message code="TXT.TOTAL_COUNT"/></span>
                    <span id="popupTotalCount" style="font-size:16px; font-weight:700; color:#333;">0</span>
                    <span style="font-size:13px; color:#666; margin-left:3px;"><spring:message code="TXT.CASE"/></span>
                </div>
            </div>
        </div>
        <div class="col-5">
            <div class="frame-wrap">
                <div class="demo" style="display:flex; justify-content:flex-end; align-items:center; gap:3px;">
				    <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="CoverCootargetPopup.excelDownload();" style="width:110px; color:#fff; background-color:#526d82; border:1px solid #526d82;">ExcelDown</button>
				    <input type="file" id="excelUploadFile" accept=".xlsx,.xls" style="display:none;" onchange="CoverCootargetPopup.excelUpload(this);">
				    <button type="button" id="excelUploadBtn" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="$('#excelUploadFile').click();" style="width:110px; color:#fff; background-color:#526d82; border:1px solid #526d82;">ExcelUpload</button>
				    <button type="button" id="saveBtn" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="CoverCootargetPopup.save();" style="width:110px; color:#fff; background-color:#526d82; border:1px solid #526d82;"><spring:message code="TXT.REGISTRATION_CERTIFICATE"/></button>
				    <button type="button" id="omissionBtn" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="CoverCootargetPopup.retrieveOmissionData();" style="display:none; width:110px; color:#fff; background-color:#526d82; border:1px solid #526d82;"><spring:message code="TXT.REGISTER_MISSING_AGREEMENT"/></button>
				    <button type="button" id="renewBtn" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="CoverCootargetPopup.renew();" style="display:none; width:110px; color:#fff; background-color:#526d82; border:1px solid #526d82;"><spring:message code="TXT.RENEW"/></button>
				</div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <div id="oAuiGrid_coverCootargetPopup_01" style="width:100%; height:480px; margin:0 auto;"></div>
        </div>
    </div>
</div>
</body>
<script>
var CoverCootargetPopup = new function() {
	this.ruleData = [];
	this.noCodeData = [];
	this.nationCodeData = [];
	this.omissionData = [];
	this.mode = "NEW";
	this.grid_CoverCootargetPopup_01 = null;
    this.Initialize_viewObject = function() {
        CoverCootargetPopup.createAUIGrid();
    };
    this.createAUIGrid = function() {
        const columnLayout = [
            {dataField:"ITEM_CODE", headerText:"<spring:message code='TXT.ITEM_CODE2' javaScriptEscape='true'/>", width:100, filter:{showIcon:true}, style:"aui-center-align", cellMerge:true, editable:false},
            {dataField:"ITEM_SPEC", headerText:"<spring:message code='TXT.MATERIAL_DETAILS' javaScriptEscape='true'/>", width:100, filter:{showIcon:true}, style:"aui-right-align", cellMerge:true, editable:false},
            {dataField:"HS_CODE", headerText:"HsCode", width:100, filter:{showIcon:false}, style:"aui-center-align", cellMerge:true, editable:false},
            {dataField:"FTA_NAME", headerText:"<spring:message code='TXT.FTA_NAME' javaScriptEscape='true'/>", width:100, filter:{showIcon:true}, style:"aui-center-align", editable:false},
            {dataField:"FTA_CODE", headerText:"FTA_CODE", visible:false},
            {dataField:"COVER_DATE", headerText:"<spring:message code='TXT.COVER_PERIOD' javaScriptEscape='true'/>", width:100, filter:{showIcon:false}, style:"aui-center-align", editable:false},
            {
                dataField:"COO_YN_NM",
                headerText:"<spring:message code='TXT.SATISFIED_YN' javaScriptEscape='true'/>",
                width:100,
                style:"aui-center-align",
                editRenderer:{
                    type:"DropDownListRenderer",
                    showEditorBtnOver:true,
                    list:["<spring:message code='TXT.SATISFIED' javaScriptEscape='true'/>", "<spring:message code='TXT.NOT_SATISFIED' javaScriptEscape='true'/>"]
                }
            },
            {
                dataField:"RULE_CODE",
                headerText:"<spring:message code='TXT.RULE_CRITERIA' javaScriptEscape='true'/>",
                width:120,
                style:"aui-center-align",
                editRenderer:{
                    type:"DropDownListRenderer",
                    showEditorBtnOver:true,
                    listFunction:function(rowIndex, columnIndex, item, dataField) {
                        return CoverCootargetPopup.ruleData
                            .filter(function(r) {
                                return r.FTA_CODE == item.FTA_CODE && r.HS_CODE == item.HS_CODE;
                            })
                            .map(function(r) {
                                return r.COMP_RULE;
                            });
                    }
                }
            },
            {dataField:"RVC_RATE", headerText:"<spring:message code='TXT.RVC_RATE' javaScriptEscape='true'/>", width:80, style:"aui-center-align"},
            {
                dataField:"COO_NATION_NM",
                headerText:"<spring:message code='TXT.ORIGIN' javaScriptEscape='true'/>",
                width:120,
                style:"aui-center-align",
                editRenderer:{
                    type:"DropDownListRenderer",
                    showEditorBtnOver:true,
                    listFunction:function() {
                        return CoverCootargetPopup.nationCodeData.map(function(r) {
                            return r.CODE_NAME;
                        });
                    }
                }
            },
            {
                dataField:"NO_CODE",
                headerText:"<spring:message code='TXT.OUT_OF_AREA_TYPE' javaScriptEscape='true'/>",
                width:"auto",
                style:"aui-center-align",
                editRenderer:{
                    type:"DropDownListRenderer",
                    showEditorBtnOver:true,
                    listFunction:function(rowIndex, columnIndex, item, dataField) {
                        return CoverCootargetPopup.noCodeData.map(function(r) {
                            return r.CODE_NAME;
                        });
                    }
                }
            }
        ];
        const gridProps = {
            editable:true,
            usePaging:true,
            pageRowCount:20,
            showPageRowSelect:true,
            enableFilter:true,
            enableCellMerge:true
        };
        CoverCootargetPopup.grid_CoverCootargetPopup_01 = KpackageOBJ.auiGrid.create(
            "oAuiGrid_coverCootargetPopup_01",
            columnLayout,
            gridProps,
            ""
        );
        AUIGrid.bind(
            CoverCootargetPopup.grid_CoverCootargetPopup_01,
            "cellEditEnd",
            function(event) {
                if (event.dataField == "RULE_CODE") {
                    var rule = CoverCootargetPopup.ruleData.find(function(r) {
                        return r.FTA_CODE == event.item.FTA_CODE
                            && r.HS_CODE == event.item.HS_CODE
                            && r.COMP_RULE == event.value;
                    });
                    if (rule) {
                        AUIGrid.updateRow(
                            CoverCootargetPopup.grid_CoverCootargetPopup_01,
                            {RVC_RATE:rule.RVC_RATE},
                            event.rowIndex
                        );
                    }
                }
                if (event.dataField == "COO_YN_NM") {
                    if (event.value == "<spring:message code='TXT.SATISFIED' javaScriptEscape='true'/>") {
                        AUIGrid.updateRow(
                            CoverCootargetPopup.grid_CoverCootargetPopup_01,
                            {
                                COO_YN:"Y",
                                COO_NATION:"KR",
                                COO_NATION_NM:"<spring:message code='TXT.SOUTH_KOREA' javaScriptEscape='true'/>"
                            },
                            event.rowIndex
                        );
                    } else {
                        AUIGrid.updateRow(
                            CoverCootargetPopup.grid_CoverCootargetPopup_01,
                            {
                                COO_YN:"N",
                                COO_NATION:"ZZ",
                                COO_NATION_NM:"<spring:message code='TXT.NON_ORIGINATING' javaScriptEscape='true'/>"
                            },
                            event.rowIndex
                        );
                    }
                }
                if (event.dataField == "COO_NATION_NM") {
                    var nation = CoverCootargetPopup.nationCodeData.find(function(r) {
                        return r.CODE_NAME == event.value;
                    });
                    if (nation) {
                        AUIGrid.updateRow(
                            CoverCootargetPopup.grid_CoverCootargetPopup_01,
                            {COO_NATION:nation.CODE},
                            event.rowIndex
                        );
                    }
                }
            }
        );
    };
    this.deleteExistingFile = function(fileSeq, fileName) {
        if (!confirm("<spring:message code='MSG.CONFIRM_DELETE' javaScriptEscape='true'/>" + "\n" + fileName)) {
            return;
        }
        var params = {
            COMPANY_CODE:$("#company_code").val(),
            PARAM_DIVISION_CODE:$("#divisionCode").val(),
            PARAM_VENDOR_CODE:$("#vendorCode").val(),
            COO_CERTIFY_NO:$("#cooCertifyNoParam").val(),
            FILE_SEQ:fileSeq
        };
        $.ajax({
            url:"/cover/deleteExtCooCertifyFile",
            type:"POST",
            contentType:"application/json",
            dataType:"json",
            data:JSON.stringify(params),
            success:function(res) {
                if (typeof res === "string") {
                    res = JSON.parse(res);
                }
                if (res.success) {
                    alert("<spring:message code='MSG.DELETE_SUCCESS' javaScriptEscape='true'/>");
                    CoverCootargetPopup.retrieveExistingFiles();
                } else {
                    alert(
                        res.message ||
                        "<spring:message code='MSG.ATTACHMENT_DELETE_ERROR' javaScriptEscape='true'/>"
                    );
                }
            },
            error:function() {
                alert("<spring:message code='MSG.ATTACHMENT_DELETE_ERROR' javaScriptEscape='true'/>");
            }
        });
    };
    this.retrieveExistingFiles = function() {
        var params = {
            COMPANY_CODE:$("#company_code").val(),
            PARAM_DIVISION_CODE:$("#divisionCode").val(),
            PARAM_VENDOR_CODE:$("#vendorCode").val(),
            COO_CERTIFY_NO:$("#cooCertifyNoParam").val()
        };
        $.ajax({
            url:"/cover/selectExtCooCertifyFileList",
            type:"POST",
            contentType:"application/json",
            dataType:"json",
            data:JSON.stringify(params),
            success:function(res) {
                if (typeof res === "string") {
                    res = JSON.parse(res);
                }
                var fileList = res.value || [];
                var $fileList = $("#existingFileList");
                $fileList.empty();
                if (fileList.length == 0) {
                    $("#existingFileArea").hide();
                    return;
                }
                fileList.forEach(function(file) {
                    var fileName =
                        file.ORIGIN_FILE_NAME ||
                        file.FILE_NAME ||
                        "";
                    var $row = $("<div>")
                        .css({
                            display:"flex",
                            alignItems:"center",
                            gap:"8px",
                            marginBottom:"5px"
                        });
                    var $downloadButton = $("<button>")
                        .attr("type", "button")
                        .addClass("btn btn-link")
                        .css({
                            padding:"0",
                            margin:"0",
                            fontSize:"13px",
                            color:"#0d6efd",
                            textDecoration:"underline",
                            cursor:"pointer"
                        })
                        .text(fileName)
                        .on("click", function() {
                            CoverCootargetPopup.downloadExistingFile(file.FILE_SEQ);
                        });
                    var $deleteButton = $("<button>")
                        .attr("type", "button")
                        .addClass("btn btn-sm btn-outline-danger")
                        .css({
                            padding:"2px 7px",
                            fontSize:"11px"
                        })
                        .text("<spring:message code='TXT.DELETE' javaScriptEscape='true'/>")
                        .on("click", function() {
                            CoverCootargetPopup.deleteExistingFile(
                                file.FILE_SEQ,
                                fileName
                            );
                        });
                    $row.append($downloadButton);
                    $row.append($deleteButton);
                    $fileList.append($row);
                });
                $("#existingFileArea").show();
            },
            error:function() {
                $("#existingFileArea").hide();
                $("#existingFileList").empty();
            }
        });
    };
    this.renew = function() {
        if (CoverCootargetPopup.mode !== "REGISTERED") {
            return;
        }
        var oldEndDate = $("#endDate").val();
        if (!oldEndDate) {
            alert("<spring:message code='MSG.NO_EXISTING_END_DATE' javaScriptEscape='true'/>");
            return;
        }
        var oldCooCertifyNo = $("#cooCertifyNoParam").val();
        if (!oldCooCertifyNo) {
            alert("<spring:message code='MSG.NO_CERTIFICATE_TO_RENEW' javaScriptEscape='true'/>");
            return;
        }
        var endDateObj = new Date(oldEndDate + "T00:00:00");
        endDateObj.setDate(endDateObj.getDate() + 1);
        var renewStartDate = CoverCootargetPopup.formatDate(endDateObj);
        var renewEndDateObj = new Date(renewStartDate + "T00:00:00");
        renewEndDateObj.setFullYear(renewEndDateObj.getFullYear() + 1);
        var renewEndDate = CoverCootargetPopup.formatDate(renewEndDateObj);
        $("#cooCertifyNoParam").val("");
        $("#cooCertifyNo").val("");
        $("#issueDate").val(renewStartDate);
        $("#applyDate").val(renewStartDate);
        $("#endDate").val(renewEndDate);
        $("#autoCreate").prop("checked", false);
        $("#FILEUP").val("");
        $("#FILEUP_NAME").val("");
        CoverCootargetPopup.setMode("RENEW");
        CoverCootargetPopup.retrieveRuleData();
    };
    this.formatDate = function(date) {
        var year = date.getFullYear();
        var month = String(date.getMonth() + 1).padStart(2, "0");
        var day = String(date.getDate()).padStart(2, "0");
        return year + "-" + month + "-" + day;
    };
    this.retrieve_GridData = function() {
        var params = {
            COMPANY_CODE:$("#company_code").val(),
            itemCodes:$("#popupItemCodes").val(),
            vendorCode:$("#vendorCode").val(),
            divisionCode:$("#divisionCode").val(),
            COO_CERTIFY_NO:$("#cooCertifyNoParam").val()
        };
        $.ajax({
            url:"/cover/retrieveCoverCootargetPopup",
            type:"POST",
            contentType:"application/json",
            dataType:"json",
            data:JSON.stringify(params),
            success:function(res) {
                if (typeof res === "string") {
                    res = JSON.parse(res);
                }
                var gridData = res.value || [];
                AUIGrid.setGridData(
                    CoverCootargetPopup.grid_CoverCootargetPopup_01,
                    gridData
                );
                $("#popupTotalCount").text(gridData.length);
                var isRegistered = $("#cooCertifyNoParam").val() != "";
                if (isRegistered) {
                    CoverCootargetPopup.setMode("REGISTERED");
                    if (gridData.length > 0) {
                        var firstRow = gridData[0];
                        $("#cooCertifyNo").val(firstRow.COO_CERTIFY_NO);
                        $("#issueDate").val(firstRow.ISSUE_DATE);
                        $("#applyDate").val(firstRow.APPLY_DATE);
                        $("#endDate").val(firstRow.END_DATE);
                        CoverCootargetPopup.retrieveExistingFiles();
                        CoverCootargetPopup.checkOmissionData(gridData);
                    }
                } else {
                    CoverCootargetPopup.setMode("NEW");
                    CoverCootargetPopup.retrieveRuleData();
                }
                CoverCootargetPopup.retrieveNoCodeData();
                CoverCootargetPopup.retrieveNationCodeData();
            },
            error:function() {
                alert("<spring:message code='MSG.CERTIFICATE_TARGET_RETRIEVE_ERROR' javaScriptEscape='true'/>");
            }
        });
    };
    this.checkOmissionData = function(gridData) {
        $("#omissionBtn").hide();
        CoverCootargetPopup.omissionData = [];
        if (!$("#cooCertifyNoParam").val()) {
            return;
        }
        if (!gridData || gridData.length == 0) {
            return;
        }
        var applyDate = $("#applyDate").val();
        if (!applyDate) {
            return;
        }
        var itemCodes = [];
        gridData.forEach(function(row) {
            if (
                row.ITEM_CODE &&
                itemCodes.indexOf(String(row.ITEM_CODE)) === -1
            ) {
                itemCodes.push(String(row.ITEM_CODE));
            }
        });
        if (itemCodes.length == 0) {
            return;
        }
        var params = {
            COMPANY_CODE:$("#company_code").val(),
            PARAM_DIVISION_CODE:$("#divisionCode").val(),
            PARAM_VENDOR_CODE:$("#vendorCode").val(),
            APPLY_DATE:applyDate.replace(/-/g, ""),
            itemCodes:itemCodes.join(","),
            OMISSION_CHECK:"Y"
        };
        $.ajax({
            url:"/cover/retrieveCoverCootargetOmission",
            type:"POST",
            contentType:"application/json",
            dataType:"json",
            data:JSON.stringify(params),
            success:function(res) {
                if (typeof res === "string") {
                    res = JSON.parse(res);
                }
                if (!res.success) {
                    return;
                }
                CoverCootargetPopup.omissionData = res.value || [];
                if (
               	    CoverCootargetPopup.mode === "REGISTERED" &&
               	    CoverCootargetPopup.omissionData.length > 0
               	) {
               	    $("#omissionBtn").show();
               	} else {
               	    $("#omissionBtn").hide();
               	}
            },
            error:function() {
                $("#omissionBtn").hide();
            }
        });
    };
    this.setMode = function(mode) {
        CoverCootargetPopup.mode = mode;
        var isRegistered = mode === "REGISTERED";
        var isWriteMode = mode === "NEW" || mode === "OMISSION" || mode === "RENEW";
        $("#cooCertifyNo").prop("readonly", isRegistered);
        $("#issueDate").prop("disabled", isRegistered);
        $("#applyDate").prop("disabled", isRegistered);
        $("#endDate").prop("disabled", isRegistered);
        $("#autoCreate").prop("disabled", isRegistered);
        $("#duplicateBtn").prop("disabled", isRegistered);
        $("#bulkCooYn").prop("disabled", isRegistered);
        $("#FILEUP").prop("disabled", isRegistered);
        $("#excelUploadFile").prop("disabled", isRegistered);
        if (isWriteMode) {
            $("#duplicateBtn").show();
            $("#bulkApplyBtn").show();
            $("#fileSelectBtn").show();
            $("#excelUploadBtn").show();
            $("#saveBtn").show();
        } else {
            $("#duplicateBtn").hide();
            $("#bulkApplyBtn").hide();
            $("#fileSelectBtn").hide();
            $("#excelUploadBtn").hide();
            $("#saveBtn").hide();
        }
        if (mode === "REGISTERED") {
            $("#renewBtn").show();
            $("#omissionBtn").hide();
        } else {
            $("#renewBtn").hide();
            $("#omissionBtn").hide();
        }
        if (mode === "OMISSION" || mode === "RENEW") {
            $("#existingFileArea").hide();
            $("#existingFileList").empty();
        }
        AUIGrid.setProp(
            CoverCootargetPopup.grid_CoverCootargetPopup_01,
            "editable",
            isWriteMode
        );
    };
    this.downloadExistingFile = function(fileSeq) {
        var params = {
            COMPANY_CODE:$("#company_code").val(),
            PARAM_DIVISION_CODE:$("#divisionCode").val(),
            PARAM_VENDOR_CODE:$("#vendorCode").val(),
            COO_CERTIFY_NO:$("#cooCertifyNoParam").val(),
            FILE_SEQ:fileSeq
        };
        window.location.href = "/cover/extCooCertifyFileDownLoad?" + $.param(params);
    };
    this.retrieveRuleData = function() {
        $.ajax({
            url:"/cover/retrieveCoverCootargetRule",
            type:"POST",
            contentType:"application/json",
            dataType:"json",
            data:JSON.stringify({
                hsCodes:$("#hsCodes").val()
            }),
            success:function(res) {
                if (typeof res === "string") {
                    res = JSON.parse(res);
                }
                CoverCootargetPopup.ruleData = res.value || [];
                var gridData = AUIGrid.getGridData(
                    CoverCootargetPopup.grid_CoverCootargetPopup_01
                );
                gridData.forEach(function(item, index) {
                    var rule = CoverCootargetPopup.ruleData.find(function(r) {
                        return r.FTA_CODE == item.FTA_CODE
                            && r.HS_CODE == item.HS_CODE;
                    });
                    if (rule) {
                        AUIGrid.updateRow(
                            CoverCootargetPopup.grid_CoverCootargetPopup_01,
                            {
                                RULE_CODE:rule.COMP_RULE,
                                RVC_RATE:rule.RVC_RATE
                            },
                            index
                        );
                    }
                });
                AUIGrid.refresh(
                    CoverCootargetPopup.grid_CoverCootargetPopup_01
                );
            }
        });
    };
    this.retrieveNoCodeData = function() {
        $.ajax({
            url:"/cover/retrieveCoverCootargetNoCode",
            type:"POST",
            contentType:"application/json",
            dataType:"json",
            data:JSON.stringify({
                COMPANY_CODE:$("#company_code").val()
            }),
            success:function(res) {
                if (typeof res === "string") {
                    res = JSON.parse(res);
                }
                CoverCootargetPopup.noCodeData = res.value || [];
                AUIGrid.refresh(
                    CoverCootargetPopup.grid_CoverCootargetPopup_01
                );
            }
        });
    };
    this.retrieveNationCodeData = function() {
        $.ajax({
            url:"/cover/retrieveCoverCootargetNationCode",
            type:"POST",
            contentType:"application/json",
            dataType:"json",
            data:JSON.stringify({
                COMPANY_CODE:$("#company_code").val()
            }),
            success:function(res) {
                if (typeof res === "string") {
                    res = JSON.parse(res);
                }
                CoverCootargetPopup.nationCodeData = res.value || [];
                AUIGrid.refresh(
                    CoverCootargetPopup.grid_CoverCootargetPopup_01
                );
            }
        });
    };
    this.excelDownload = function() {
        const exportProps = {
            fileName:"<spring:message code='TXT.REGISTRATION_CERTIFICATE' javaScriptEscape='true'/>" + "_Popup",
            sheetName:"<spring:message code='TXT.REGISTRATION_CERTIFICATE' javaScriptEscape='true'/>",
            exportWithStyle:true,
            progressBar:true,
            showRowNumColumn:false
        };
        AUIGrid.exportToXlsx(
            CoverCootargetPopup.grid_CoverCootargetPopup_01,
            exportProps
        );
    };
    this.checkDuplicate = function() {
        var cooCertifyNo = $("#cooCertifyNo").val();
        if (!cooCertifyNo) {
            alert("<spring:message code='MSG.COO_CERTIFY_NO_REQUIRED' javaScriptEscape='true'/>");
            return;
        }
        $.ajax({
            url:"/cover/checkCoverCootargetDuplicate",
            type:"POST",
            contentType:"application/json",
            dataType:"json",
            data:JSON.stringify({
                COMPANY_CODE:$("#company_code").val(),
                PARAM_DIVISION_CODE:$("#divisionCode").val(),
                PARAM_VENDOR_CODE:$("#vendorCode").val(),
                COO_CERTIFY_NO:cooCertifyNo
            }),
            success:function(res) {
                if (typeof res === "string") {
                    res = JSON.parse(res);
                }
                var duplicate = res.value;
                if (duplicate > 0) {
                    alert("<spring:message code='MSG.COO_CERTIFY_NO_ALREADY_REGISTERED' javaScriptEscape='true'/>");
                } else {
                    alert("<spring:message code='MSG.COO_CERTIFY_NO_AVAILABLE' javaScriptEscape='true'/>");
                }
            }
        });
    };
    this.applyBulkCooYn = function() {
        var cooYn = $("#bulkCooYn").val();
        var gridData = AUIGrid.getGridData(
            CoverCootargetPopup.grid_CoverCootargetPopup_01
        );
        gridData.forEach(function(item, index) {
            if (cooYn == "Y") {
                AUIGrid.updateRow(
                    CoverCootargetPopup.grid_CoverCootargetPopup_01,
                    {
                        COO_YN:"Y",
                        COO_YN_NM:"<spring:message code='TXT.SATISFIED' javaScriptEscape='true'/>",
                        COO_NATION:"KR",
                        COO_NATION_NM:"<spring:message code='TXT.SOUTH_KOREA' javaScriptEscape='true'/>"
                    },
                    index
                );
            } else {
                AUIGrid.updateRow(
                    CoverCootargetPopup.grid_CoverCootargetPopup_01,
                    {
                        COO_YN:"N",
                        COO_YN_NM:"<spring:message code='TXT.NOT_SATISFIED' javaScriptEscape='true'/>",
                        COO_NATION:"ZZ",
                        COO_NATION_NM:"<spring:message code='TXT.NON_ORIGINATING' javaScriptEscape='true'/>"
                    },
                    index
                );
            }
        });
    };
    this.save = function() {
        var isRegistered = $("#cooCertifyNoParam").val() != "";
        if (isRegistered) {
            alert("<spring:message code='MSG.CERTIFICATE_ALREADY_REGISTERED' javaScriptEscape='true'/>");
            return;
        }
        var gridData = AUIGrid.getGridData(
            CoverCootargetPopup.grid_CoverCootargetPopup_01
        );
        if (!gridData || gridData.length == 0) {
            alert("<spring:message code='MSG.NO_DATA_TO_SAVE' javaScriptEscape='true'/>");
            return;
        }
        var autoCreate = $("#autoCreate").is(":checked");
        var cooCertifyNo = $.trim($("#cooCertifyNo").val());
        var issueDate = $("#issueDate").val();
        var applyDate = $("#applyDate").val();
        var endDate = $("#endDate").val();
        if (!autoCreate && !cooCertifyNo) {
            alert("<spring:message code='MSG.COO_CERTIFY_NO_REQUIRED' javaScriptEscape='true'/>");
            return;
        }
        if (!issueDate) {
            alert("<spring:message code='MSG.CERTIFICATE_DATE_REQUIRED' javaScriptEscape='true'/>");
            return;
        }
        if (!applyDate) {
            alert("<spring:message code='MSG.APPLY_START_DATE_REQUIRED' javaScriptEscape='true'/>");
            return;
        }
        if (!endDate) {
            alert("<spring:message code='MSG.APPLY_END_DATE_REQUIRED' javaScriptEscape='true'/>");
            return;
        }
        var applyDateObj = new Date(applyDate + "T00:00:00");
        var endDateObj = new Date(endDate + "T00:00:00");
        if (applyDateObj > endDateObj) {
            alert("<spring:message code='MSG.COVER_DATE_BEFORE' javaScriptEscape='true'/>");
            return;
        }
        var diffDays = Math.floor(
            (endDateObj.getTime() - applyDateObj.getTime()) /
            (1000 * 60 * 60 * 24)
        );
        if (diffDays > 365) {
            alert("<spring:message code='MSG.COVER_DATE_OVER' javaScriptEscape='true'/>");
            return;
        }
        var files = $("#FILEUP")[0].files;
        var param = {
            COMPANY_CODE:$("#company_code").val(),
            PARAM_DIVISION_CODE:$("#divisionCode").val(),
            PARAM_VENDOR_CODE:$("#vendorCode").val(),
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
            USER_ID:$("#userId").val(),
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
        for (var i = 0; i < files.length; i++) {
            formData.append("FILEUP", files[i]);
        }
        $.ajax({
            url:"/cover/insertExtCooCertify",
            type:"POST",
            data:formData,
            processData:false,
            contentType:false,
            success:function(res) {
                if (typeof res === "string") {
                    res = JSON.parse(res);
                }
                if (res.success) {
                    alert("<spring:message code='MSG.SAVEOK' javaScriptEscape='true'/>");
                    coverCootargetList.retrieve_GridData();
                    KpackageOBJ.dialog.close("previewPopup");
                } else {
                    alert(res.message || "<spring:message code='MSG.SAVEFAIL' javaScriptEscape='true'/>");
                }
            },
            error:function() {
                alert("<spring:message code='MSG.SAVEFAIL' javaScriptEscape='true'/>");
            }
        });
    };
    this.retrieveOmissionData = function() {
        if (CoverCootargetPopup.mode !== "REGISTERED") {
            return;
        }
        var omissionData = CoverCootargetPopup.omissionData || [];
        if (omissionData.length == 0) {
            alert("<spring:message code='MSG.NO_MISSING_AGREEMENT_TO_ADD' javaScriptEscape='true'/>");
            $("#omissionBtn").hide();
            return;
        }
        AUIGrid.setGridData(
            CoverCootargetPopup.grid_CoverCootargetPopup_01,
            omissionData
        );
        $("#popupTotalCount").text(omissionData.length);
        $("#cooCertifyNoParam").val("");
        $("#cooCertifyNo").val("");
        $("#FILEUP").val("");
        $("#FILEUP_NAME").val("");
        CoverCootargetPopup.setMode("OMISSION");
        CoverCootargetPopup.retrieveRuleData();
    };
    this.changeFileName = function(obj) {
        if (!obj.files || obj.files.length == 0) {
            $("#FILEUP_NAME").val("");
            return;
        }
        var fileNames = [];
        for (var i = 0; i < obj.files.length; i++) {
            fileNames.push(obj.files[i].name);
        }
        $("#FILEUP_NAME").val(fileNames.join(", "));
    };
    this.excelUpload = function(obj) {
        var file = obj.files[0];
        if (!file) {
            return;
        }
        var reader = new FileReader();
        reader.onload = function(e) {
            var data = new Uint8Array(e.target.result);
            var workbook = XLSX.read(
                data,
                {
                    type:"array"
                }
            );
            var sheet = workbook.Sheets[
                workbook.SheetNames[0]
            ];
            var excelData = XLSX.utils.sheet_to_json(
                sheet,
                {
                    defval:""
                }
            );
            if (!excelData || excelData.length == 0) {
                alert("<spring:message code='MSG.NO_EXCEL_DATA' javaScriptEscape='true'/>");
                obj.value = "";
                return;
            }
            var orgGridData = AUIGrid.getGridData(
                CoverCootargetPopup.grid_CoverCootargetPopup_01
            );
            var lastItemCode = "";
            var lastItemSpec = "";
            var lastHsCode = "";
            var gridData = excelData.map(function(row) {
                if (row["<spring:message code='TXT.ITEM_CODE2' javaScriptEscape='true'/>"]) {
                    lastItemCode = row["<spring:message code='TXT.ITEM_CODE2' javaScriptEscape='true'/>"];
                }
                if (row["<spring:message code='TXT.MATERIAL_DETAILS' javaScriptEscape='true'/>"]) {
                    lastItemSpec = row["<spring:message code='TXT.MATERIAL_DETAILS' javaScriptEscape='true'/>"];
                }
                if (row["HsCode"]) {
                    lastHsCode = row["HsCode"];
                }
                var org = orgGridData.find(function(r) {
                    return r.FTA_NAME == row["<spring:message code='TXT.FTA_NAME' javaScriptEscape='true'/>"];
                });
                var nation = CoverCootargetPopup.nationCodeData.find(function(r) {
                    return r.CODE_NAME == row["<spring:message code='TXT.ORIGIN' javaScriptEscape='true'/>"];
                });
                return {
                    ITEM_CODE:lastItemCode,
                    ITEM_SPEC:lastItemSpec,
                    HS_CODE:lastHsCode,
                    FTA_NAME:row["<spring:message code='TXT.FTA_NAME' javaScriptEscape='true'/>"] || "",
                    FTA_CODE:org ? org.FTA_CODE : "",
                    COVER_DATE:row["<spring:message code='TXT.COVER_PERIOD' javaScriptEscape='true'/>"] || "",
                    COO_YN_NM:row["<spring:message code='TXT.SATISFIED_YN' javaScriptEscape='true'/>"] || "",
                    COO_YN:row["<spring:message code='TXT.SATISFIED_YN' javaScriptEscape='true'/>"] == "<spring:message code='TXT.SATISFIED' javaScriptEscape='true'/>" ? "Y" : "N",
                    RULE_CODE:row["<spring:message code='TXT.RULE_CRITERIA' javaScriptEscape='true'/>"] || "",
                    RVC_RATE:row["<spring:message code='TXT.RVC_RATE' javaScriptEscape='true'/>"] || "",
                    COO_NATION_NM:row["<spring:message code='TXT.ORIGIN' javaScriptEscape='true'/>"] || "",
                    COO_NATION:nation ? nation.CODE : "",
                    NO_CODE:row["<spring:message code='TXT.OUT_OF_AREA_TYPE' javaScriptEscape='true'/>"] || ""
                };
            });
            AUIGrid.setGridData(
                CoverCootargetPopup.grid_CoverCootargetPopup_01,
                gridData
            );
            $("#popupTotalCount").text(gridData.length);
            obj.value = "";
        };
        reader.readAsArrayBuffer(file);
    };
};
$(document).ready(function() {
    pageSetUp();
    CoverCootargetPopup.Initialize_viewObject();
    CoverCootargetPopup.retrieve_GridData();
});
</script>
</html>
