<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<div class="content-wrapper">
    <form id="ItemGroupPopup-form" enctype="multipart/form-data">
        <input type="hidden" id="flag" name="flag" value="${param.flag}">
        <input type="hidden" id="company_code" name="COMPANY_CODE" value="${sessionScope._sessionUser.company_code}">
        <input type="hidden" id="delList" name="delList" value="">
        <div class="row">
            <div class="col-12">
                <div style="display:flex; justify-content:flex-end; align-items:center; gap:5px; margin-bottom:10px;">
                    <button type="button" class="btn btn-sm btn-primary waves-effect waves-themed" onclick="window.ItemGroupPopup.save();" style="width:90px; height:32px;"><spring:message code="TXT.SAVE"/></button>
                </div>
            </div>
        </div>
        <div id="panel-4" class="panel panel-icon">
            <div class="panel-container show">
                <div class="panel-content">
                    <div class="row">
                        <div class="col-12">
                            <div style="font-size:15px; font-weight:700; margin-bottom:15px;">
                                <spring:message code="TXT.PRODUCT_GROUP_MANAGEMENT"/>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin-bottom:15px;">
                        <div class="col-3">
                            <label class="form-label" for="PRODUCT_CODE">
                                <spring:message code="TXT.PRODUCT_GROUP_CODE"/>
                            </label>
                        </div>
                        <div class="col-9">
                            <input type="text" class="form-control" id="PRODUCT_CODE" name="PRODUCT_CODE" value="${param.PRODUCT_CODE}" maxlength="100" style="width:300px;">
                        </div>
                    </div>
                    <div class="row" style="margin-bottom:15px;">
                        <div class="col-3">
                            <label class="form-label" for="PRODUCT_NAME">
                                <spring:message code="TXT.PRODUCT_GROUP_NAME"/>
                            </label>
                        </div>
                        <div class="col-9">
                            <input type="text" class="form-control" id="PRODUCT_NAME" name="PRODUCT_NAME" maxlength="250" style="width:300px;">
                        </div>
                    </div>
                    <div class="row" style="margin-bottom:15px;">
                        <div class="col-3">
                            <label class="form-label" for="FLOWCHART_COMMENT">
                                <spring:message code="TXT.MANUFACTURING_PROCESS_ORDER"/>
                            </label>
                        </div>
                        <div class="col-9">
                            <textarea class="form-control" id="FLOWCHART_COMMENT" name="FLOWCHART_COMMENT" maxlength="500" style="width:100%; height:80px;"></textarea>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-3">
                            <label class="form-label" for="FILEUP">
                                <spring:message code="TXT.FLOWCHART_ATTACHMENT"/>
                            </label>
                        </div>
                        <div class="col-9">
                            <input id="FILEUP" name="FILEUP" type="file" multiple class="form-control" style="width:100%;">
                            <div id="itemGroupFileList" style="margin-top:10px;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<script>
window.ItemGroupPopup = new function() {
    this.Initialize_viewObject = function() {
        var flag = $("#flag").val();
        if (flag === "update") {
            $("#PRODUCT_CODE").prop("readonly", true);
            window.ItemGroupPopup.retrieveDetail();
            window.ItemGroupPopup.retrieveFileList();
        } else {
            $("#deleteBtn").hide();
        }
    };
    this.retrieveDetail = function() {
        var params = {
            COMPANY_CODE:$("#company_code").val(),
            PRODUCT_CODE:$("#PRODUCT_CODE").val()
        };
        KpackageOBJ.ajax.doSubmit(
            "/itemgroupmgmt/retrieveItemGroupDetail",
            params,
            function(arg) {
                var data = arg.value || {};
                $("#PRODUCT_CODE").val(data.PRODUCT_CODE || "");
                $("#PRODUCT_NAME").val(data.PRODUCT_NAME || "");
                $("#FLOWCHART_COMMENT").val(data.FLOWCHART_COMMENT || "");
            }
        );
    };
    this.retrieveFileList = function() {
        var params = {
            COMPANY_CODE:$("#company_code").val(),
            PRODUCT_CODE:$("#PRODUCT_CODE").val()
        };
        KpackageOBJ.ajax.doSubmit(
            "/itemgroupmgmt/retrieveItemGroupFileList",
            params,
            function(arg) {
                var data = arg.value || [];
                $("#itemGroupFileList").empty();
                for (var i = 0; i < data.length; i++) {
                    var file = data[i];
                    var html = "";
                    html += "<div style='display:flex; align-items:center; gap:8px; margin-bottom:5px;'>";
                    html += "<a href='javascript:window.ItemGroupPopup.downloadFile(" + file.FILE_SEQ + ");'>";
                    html += file.ORIGIN_FILE_NAME;
                    html += "</a>";
                    html += "<button type='button' class='btn btn-xs btn-danger waves-effect waves-themed' onclick='window.ItemGroupPopup.markDeleteFile(" + file.FILE_SEQ + ", this);' style='width:50px; height:26px;'><spring:message code='TXT.DELETE' javaScriptEscape='true'/></button>";
                    html += "</div>";
                    $("#itemGroupFileList").append(html);
                }
            }
        );
    };
    this.save = function() {
        var productCode = $.trim($("#PRODUCT_CODE").val());
        var productName = $.trim($("#PRODUCT_NAME").val());
        var flowchartComment = $.trim($("#FLOWCHART_COMMENT").val());
        if (productCode === "") {
            alert("<spring:message code='MSG.PRODUCT_GROUP_CODE_REQUIRED' javaScriptEscape='true'/>");
            $("#PRODUCT_CODE").focus();
            return;
        }
        if (productName === "") {
            alert("<spring:message code='MSG.PRODUCT_GROUP_NAME_REQUIRED' javaScriptEscape='true'/>");
            $("#PRODUCT_NAME").focus();
            return;
        }
        if (flowchartComment === "") {
            alert("<spring:message code='MSG.MANUFACTURING_PROCESS_ORDER_REQUIRED' javaScriptEscape='true'/>");
            $("#FLOWCHART_COMMENT").focus();
            return;
        }
        var formData = new FormData(
            document.getElementById("ItemGroupPopup-form")
        );
        $.ajax({
            url:"/itemgroupmgmt/saveItemGroup",
            type:"POST",
            data:formData,
            processData:false,
            contentType:false,
            success:function(result) {
                if (result && result.success) {
                    alert("<spring:message code='MSG.SAVEOK' javaScriptEscape='true'/>");
                    $("#flag").val("update");
                    $("#PRODUCT_CODE").prop("readonly", true);
                    $("#deleteBtn").show();
                    $("#delList").val("");
                    $("#FILEUP").val("");
                    window.ItemGroupPopup.retrieveDetail();
                    window.ItemGroupPopup.retrieveFileList();
                    if (window.parent && window.parent.ItemGroupMgmt) {
                        window.parent.ItemGroupMgmt.reload();
                    }
                } else {
                    alert(
                        result && result.message
                            ? result.message
                            : "<spring:message code='MSG.SAVEFAIL' javaScriptEscape='true'/>"
                    );
                }
            },
            error:function(xhr) {
                console.log(xhr);
                alert("<spring:message code='MSG.SAVEFAIL' javaScriptEscape='true'/>");
            }
        });
    };
    this.remove = function() {
        var productCode = $("#PRODUCT_CODE").val();
        if (!productCode) {
            alert("<spring:message code='MSG.NO_PRODUCT_GROUP_TO_DELETE' javaScriptEscape='true'/>");
            return;
        }
        if (!confirm("<spring:message code='MSG.CONFIRM_DELETE_PRODUCT_GROUP' javaScriptEscape='true'/>")) {
            return;
        }
        var params = {
            COMPANY_CODE:$("#company_code").val(),
            PRODUCT_CODE:productCode
        };
        KpackageOBJ.ajax.doSubmit(
            "/itemgroupmgmt/deleteItemGroup",
            params,
            function(arg) {
                if (arg && arg.success) {
                    alert("<spring:message code='MSG.DELETE_SUCCESS' javaScriptEscape='true'/>");
                    if (window.parent && window.parent.ItemGroupMgmt) {
                        window.parent.ItemGroupMgmt.reload();
                    }
                    KpackageOBJ.dialog.close("itemGroupPopup");
                } else {
                    alert(
                        arg && arg.message
                            ? arg.message
                            : "<spring:message code='MSG.DELETE_ERROR' javaScriptEscape='true'/>"
                    );
                }
            }
        );
    };
    this.markDeleteFile = function(fileSeq, obj) {
        var delList = $("#delList").val();
        if (delList !== "") {
            delList += ",";
        }
        delList += fileSeq;
        $("#delList").val(delList);
        $(obj).parent().remove();
    };
    this.downloadFile = function(fileSeq) {
        var params = {
            COMPANY_CODE:$("#company_code").val(),
            PRODUCT_CODE:$("#PRODUCT_CODE").val(),
            FILE_SEQ:fileSeq
        };
        window.location.href =
            "/itemgroupmgmt/itemGroupFileDownload?"
            + $.param(params);
    };
};
$(document).ready(function() {
    pageSetUp();
    window.ItemGroupPopup.Initialize_viewObject();
});
</script>
</body>
</html>
