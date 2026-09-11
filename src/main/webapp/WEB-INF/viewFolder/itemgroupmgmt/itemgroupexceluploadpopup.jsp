<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<div class="content-wrapper">
    <form id="ItemGroupExcelUploadPopup-form" enctype="multipart/form-data">
        <input type="hidden" id="excel_company_code" name="COMPANY_CODE" value="${sessionScope._sessionUser.company_code}">
        <div id="panel-4" class="panel panel-icon">
            <div class="panel-container show">
                <div class="panel-content" style="padding:24px;">
                    <div class="row">
                        <div class="col-12">
                            <label class="form-label" style="display:block; margin-bottom:8px;">Excel File</label>
                            <div style="display:flex; align-items:center; gap:8px;">
                                <input type="text" id="excel_FILEUP_NAME" class="form-control" readonly style="flex:1;">
                                <label class="btn btn-sm btn-secondary waves-effect waves-themed" style="width:100px; height:34px; line-height:24px; margin:0;">
                                    <spring:message code="TXT.SELECT_FILE"/>
                                    <input type="file" id="excel_FILEUP" name="FILEUP" accept=".xlsx" style="display:none;" onchange="ItemGroupExcelUploadPopup.changeFileName(this);">
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin-top:20px;">
                        <div class="col-12">
                            <div style="padding:14px; background:#f7f7f7; border:1px solid #ddd; font-size:13px; line-height:1.8;">
                                <spring:message code="MSG.EXCEL_COLUMN_ORDER_GUIDE"/><br>
                                A<spring:message code="TXT.COLUMN"/> : <spring:message code="TXT.PRODUCT_GROUP_CODE"/><br>
                                B<spring:message code="TXT.COLUMN"/> : <spring:message code="TXT.PRODUCT_GROUP_NAME"/><br>
                                C<spring:message code="TXT.COLUMN"/> : <spring:message code="TXT.MANUFACTURING_PROCESS_ORDER"/><br><br>
                                <spring:message code="MSG.DUPLICATE_PRODUCT_GROUP_CANCEL_UPLOAD"/>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin-top:20px;">
                        <div class="col-12" style="display:flex; justify-content:flex-end; gap:5px;">
                            <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="ItemGroupExcelUploadPopup.templateDownload();" style="width:110px; height:32px;"><spring:message code="TXT.TEMPLATE_DOWNLOAD"/></button>
                            <button type="button" class="btn btn-sm btn-primary waves-effect waves-themed" onclick="ItemGroupExcelUploadPopup.upload();" style="width:110px; height:32px;">Upload</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<script>
window.ItemGroupExcelUploadPopup = new function() {
    this.changeFileName = function(obj) {
        if (!obj.files || obj.files.length === 0) {
            $("#excel_FILEUP_NAME").val("");
            return;
        }
        $("#excel_FILEUP_NAME").val(
            obj.files[0].name
        );
    };
    this.templateDownload = function() {
        window.location.href =
            "/itemgroupmgmt/templateDownload";
    };
    this.upload = function() {
        var fileInput =
            document.getElementById("excel_FILEUP");
        if (!fileInput.files ||
            fileInput.files.length === 0) {
            alert("<spring:message code='MSG.SELECT_EXCEL_FILE_TO_UPLOAD' javaScriptEscape='true'/>");
            return;
        }
        var fileName =
            fileInput.files[0].name || "";
        if (!fileName.toLowerCase().endsWith(".xlsx")) {
            alert("<spring:message code='MSG.XLSX_ONLY_UPLOAD' javaScriptEscape='true'/>");
            return;
        }
        if (!confirm("<spring:message code='MSG.CONFIRM_REGISTER_PRODUCT_GROUP' javaScriptEscape='true'/>")) {
            return;
        }
        var formData = new FormData();
        formData.append(
            "COMPANY_CODE",
            $("#excel_company_code").val()
        );
        formData.append(
            "FILEUP",
            fileInput.files[0]
        );
        $.ajax({
            url:"/itemgroupmgmt/excelUpload",
            type:"POST",
            data:formData,
            processData:false,
            contentType:false,
            success:function(res) {
                if (typeof res === "string") {
                    res = JSON.parse(res);
                }
                if (res.success) {
                    alert(
                        res.message ||
                        "<spring:message code='MSG.PRODUCT_GROUP_REGISTERED' javaScriptEscape='true'/>"
                    );
                    try {
                        if (parent.ItemGroupMgmt) {
                            parent.ItemGroupMgmt.reload();
                        }
                    } catch (e) {
                    }
                } else {
                    alert(
                        res.message ||
                        "<spring:message code='MSG.EXCEL_UPLOAD_ERROR' javaScriptEscape='true'/>"
                    );
                }
            },
            error:function(xhr) {
                console.log(xhr.responseText);
                alert(
                    "<spring:message code='MSG.EXCEL_UPLOAD_ERROR' javaScriptEscape='true'/>"
                );
            }
        });
    };
};
$(document).ready(function() {
    pageSetUp();
});
</script>
</body>
</html>
