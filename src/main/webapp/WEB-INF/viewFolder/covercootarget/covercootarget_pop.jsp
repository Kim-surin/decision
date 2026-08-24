<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                                <label class="form-label" for="cooCertifyNo" style="width:125px; margin:0;">원산지증명번호</label>
                                <input class="form-control" id="cooCertifyNo" name="cooCertifyNo" type="text" style="width:200px;">
                                <button type="button" id="duplicateBtn" class="btn btn-sm btn-secondary" onclick="CoverCootargetPopup.checkDuplicate();" style="margin-left:6px; white-space:nowrap;">중복확인</button>
                                <label style="display:flex; align-items:center; margin:0 0 0 8px; white-space:nowrap;">
                                    <input id="autoCreate" name="autoCreate" type="checkbox" style="margin-right:6px;">
                                    자동생성
                                </label>
                            </div>

                            <div style="display:flex; align-items:center; width:50%;">
                                <label class="form-label" for="issueDate" style="width:125px; margin:0;">발행일자</label>
                                <input class="form-control" id="issueDate" type="date" value="<%= java.time.LocalDate.now() %>" style="width:140px;">
                            </div>
                        </div>

                        <br>

                        <div style="display:flex; align-items:center; width:100%;">
                            <div style="display:flex; align-items:center; width:50%;">
                                <label class="form-label" style="width:125px; margin:0;">증명서타입</label>
                                <label style="display:flex; align-items:center; margin:0 0 0 8px; white-space:nowrap;">포괄</label>
                            </div>

                            <div style="display:flex; align-items:center; width:50%;">
                                <label class="form-label" style="width:125px; margin:0;">포괄확인기간</label>
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
                                <label class="form-label" style="width:125px; margin:0;">충족여부 일괄변경</label>
                                <div class="col-4" style="width:100px;">
                                    <select class="form-select" id="bulkCooYn" name="bulkCooYn">
                                        <option value="Y">충족</option>
                                        <option value="N">불충족</option>
                                    </select>
                                </div>
                                <button type="button" id="bulkApplyBtn" class="btn btn-sm btn-secondary" onclick="CoverCootargetPopup.applyBulkCooYn();" style="margin-left:6px; white-space:nowrap;">적용</button>
                            </div>
                        </div>

                        <br>

                        <div style="display:flex; align-items:center; width:100%;">
						    <div style="display:flex; align-items:center; width:50%;">
						        <label class="form-label" style="width:120px; margin:0;">파일첨부</label>
						        <div style="display:flex; align-items:center; gap:8px;">
						            <input id="FILEUP" name="FILEUP" type="file" multiple style="display:none;" onchange="CoverCootargetPopup.changeFileName(this);">
						            <button type="button" id="fileSelectBtn" class="btn btn-sm btn-outline-primary" onclick="$('#FILEUP').click();" style="height:32px; min-width:90px;">파일 선택</button>
						            <input id="FILEUP_NAME" type="text" class="form-control" placeholder="선택된 파일 없음" readonly style="width:280px; height:32px; background:#fff;">
						        </div>
						    </div>
						</div>
						
						<div id="existingFileArea" style="display:none; margin-top:10px;">
						    <div style="display:flex; align-items:flex-start;">
						        <label class="form-label" style="width:120px; margin:0;">기등록 첨부파일</label>
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
                    <span style="font-size:13px; color:#666; margin-right:10px;">총 건수</span>
                    <span id="popupTotalCount" style="font-size:16px; font-weight:700; color:#333;">0</span>
                    <span style="font-size:13px; color:#666; margin-left:3px;">건</span>
                </div>
            </div>
        </div>

        <div class="col-5">
            <div class="frame-wrap">
                <div class="demo" style="display:flex; justify-content:flex-end; align-items:center; gap:3px;">
				    <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="CoverCootargetPopup.excelDownload();" style="width:110px; color:#fff; background-color:#526d82; border:1px solid #526d82;">ExcelDown</button>
				    <input type="file" id="excelUploadFile" accept=".xlsx,.xls" style="display:none;" onchange="CoverCootargetPopup.excelUpload(this);">
				    <button type="button" id="excelUploadBtn" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="$('#excelUploadFile').click();" style="width:110px; color:#fff; background-color:#526d82; border:1px solid #526d82;">ExcelUpload</button>
				    <button type="button" id="saveBtn" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="CoverCootargetPopup.save();" style="width:110px; color:#fff; background-color:#526d82; border:1px solid #526d82;">확인서 등록</button>
				    <button type="button" id="omissionBtn" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="CoverCootargetPopup.retrieveOmissionData();" style="display:none; width:110px; color:#fff; background-color:#526d82; border:1px solid #526d82;">누락협정등록</button>
				    <button type="button" id="renewBtn" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="CoverCootargetPopup.renew();" style="display:none; width:110px; color:#fff; background-color:#526d82; border:1px solid #526d82;">갱신</button>
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
            {dataField:"ITEM_CODE", headerText:"자재코드", width:100, filter:{showIcon:true}, style:"aui-center-align", cellMerge:true, editable:false},
            {dataField:"ITEM_SPEC", headerText:"자재내역", width:100, filter:{showIcon:true}, style:"aui-right-align", cellMerge:true, editable:false},
            {dataField:"HS_CODE", headerText:"HsCode", width:100, filter:{showIcon:false}, style:"aui-center-align", cellMerge:true, editable:false},
            {dataField:"FTA_NAME", headerText:"FTA명", width:100, filter:{showIcon:true}, style:"aui-center-align", editable:false},
            {dataField:"FTA_CODE", headerText:"FTA_CODE", visible:false},
            {dataField:"COVER_DATE", headerText:"포괄기간", width:100, filter:{showIcon:false}, style:"aui-center-align", editable:false},
            {
                dataField:"COO_YN_NM",
                headerText:"충족여부",
                width:100,
                style:"aui-center-align",
                editRenderer:{
                    type:"DropDownListRenderer",
                    showEditorBtnOver:true,
                    list:["충족", "불충족"]
                }
            },
            {
                dataField:"RULE_CODE",
                headerText:"결정기준",
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
            {dataField:"RVC_RATE", headerText:"부가가치비율", width:80, style:"aui-center-align"},
            {
                dataField:"COO_NATION_NM",
                headerText:"원산지",
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
                headerText:"역외유형",
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
                    if (event.value == "충족") {
                        AUIGrid.updateRow(
                            CoverCootargetPopup.grid_CoverCootargetPopup_01,
                            {
                                COO_YN:"Y",
                                COO_NATION:"KR",
                                COO_NATION_NM:"대한민국"
                            },
                            event.rowIndex
                        );
                    } else {
                        AUIGrid.updateRow(
                            CoverCootargetPopup.grid_CoverCootargetPopup_01,
                            {
                                COO_YN:"N",
                                COO_NATION:"ZZ",
                                COO_NATION_NM:"비역내"
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

        if (!confirm("'" + fileName + "' 파일을 삭제하시겠습니까?")) {
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

                    alert("첨부파일이 삭제되었습니다.");

                    CoverCootargetPopup.retrieveExistingFiles();

                } else {

                    alert(
                        res.message ||
                        "첨부파일 삭제 중 오류가 발생했습니다."
                    );
                }
            },
            error:function() {
                alert("첨부파일 삭제 중 오류가 발생했습니다.");
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
                        .text("삭제")
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
            alert("기존 적용종료일이 없습니다.");
            return;
        }

        var oldCooCertifyNo = $("#cooCertifyNoParam").val();

        if (!oldCooCertifyNo) {
            alert("갱신할 기존 증명서가 없습니다.");
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
                alert("증명서 등록대상 조회 중 오류가 발생했습니다.");
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
            fileName:"확인서등록_팝업",
            sheetName:"확인서등록",
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
            alert("원산지증명번호를 입력해주세요.");
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
                    alert("이미 등록된 원산지증명번호입니다.");
                } else {
                    alert("사용 가능한 원산지증명번호입니다.");
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
                        COO_YN_NM:"충족",
                        COO_NATION:"KR",
                        COO_NATION_NM:"대한민국"
                    },
                    index
                );

            } else {

                AUIGrid.updateRow(
                    CoverCootargetPopup.grid_CoverCootargetPopup_01,
                    {
                        COO_YN:"N",
                        COO_YN_NM:"불충족",
                        COO_NATION:"ZZ",
                        COO_NATION_NM:"비역내"
                    },
                    index
                );
            }
        });
    };


    this.save = function() {

        var isRegistered = $("#cooCertifyNoParam").val() != "";

        if (isRegistered) {
            alert("이미 등록된 확인서입니다.");
            return;
        }

        var gridData = AUIGrid.getGridData(
            CoverCootargetPopup.grid_CoverCootargetPopup_01
        );

        if (!gridData || gridData.length == 0) {
            alert("등록할 데이터가 없습니다.");
            return;
        }

        var autoCreate = $("#autoCreate").is(":checked");
        var cooCertifyNo = $.trim($("#cooCertifyNo").val());

        var issueDate = $("#issueDate").val();
        var applyDate = $("#applyDate").val();
        var endDate = $("#endDate").val();

        if (!autoCreate && !cooCertifyNo) {
            alert("원산지증명번호를 입력해주세요.");
            return;
        }

        if (!issueDate) {
            alert("증명일자를 입력해주세요.");
            return;
        }

        if (!applyDate) {
            alert("적용시작일을 입력해주세요.");
            return;
        }

        if (!endDate) {
            alert("적용종료일을 입력해주세요.");
            return;
        }

        var applyDateObj = new Date(applyDate + "T00:00:00");
        var endDateObj = new Date(endDate + "T00:00:00");

        if (applyDateObj > endDateObj) {
            alert("적용시작일은 적용종료일보다 늦을 수 없습니다.");
            return;
        }

        var diffDays = Math.floor(
            (endDateObj.getTime() - applyDateObj.getTime()) /
            (1000 * 60 * 60 * 24)
        );

        if (diffDays > 365) {
            alert("포괄 적용기간은 365일을 초과할 수 없습니다.");
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
                    alert("정상적으로 등록되었습니다.");
                    coverCootargetList.retrieve_GridData();
                    KpackageOBJ.dialog.close("previewPopup");
                } else {
                    alert(res.message || "등록 중 오류가 발생했습니다.");
                }
            },
            error:function() {
                alert("등록 중 오류가 발생했습니다.");
            }
        });
    };
    
	
    this.retrieveOmissionData = function() {

        if (CoverCootargetPopup.mode !== "REGISTERED") {
            return;
        }

        var omissionData = CoverCootargetPopup.omissionData || [];

        if (omissionData.length == 0) {
            alert("추가할 누락협정이 없습니다.");
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
                alert("엑셀 데이터가 없습니다.");
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

                if (row["자재코드"]) {
                    lastItemCode = row["자재코드"];
                }

                if (row["자재내역"]) {
                    lastItemSpec = row["자재내역"];
                }

                if (row["HsCode"]) {
                    lastHsCode = row["HsCode"];
                }

                var org = orgGridData.find(function(r) {
                    return r.FTA_NAME == row["FTA명"];
                });

                var nation = CoverCootargetPopup.nationCodeData.find(function(r) {
                    return r.CODE_NAME == row["원산지"];
                });

                return {
                    ITEM_CODE:lastItemCode,
                    ITEM_SPEC:lastItemSpec,
                    HS_CODE:lastHsCode,

                    FTA_NAME:row["FTA명"] || "",
                    FTA_CODE:org ? org.FTA_CODE : "",

                    COVER_DATE:row["포괄기간"] || "",

                    COO_YN_NM:row["충족여부"] || "",
                    COO_YN:row["충족여부"] == "충족" ? "Y" : "N",

                    RULE_CODE:row["결정기준"] || "",
                    RVC_RATE:row["부가가치비율"] || "",

                    COO_NATION_NM:row["원산지"] || "",
                    COO_NATION:nation ? nation.CODE : "",

                    NO_CODE:row["역외유형"] || ""
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