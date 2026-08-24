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
                                    파일선택
                                    <input type="file" id="excel_FILEUP" name="FILEUP" accept=".xlsx" style="display:none;" onchange="ItemGroupExcelUploadPopup.changeFileName(this);">
                                </label>

                            </div>

                        </div>

                    </div>


                    <div class="row" style="margin-top:20px;">

                        <div class="col-12">

                            <div style="padding:14px; background:#f7f7f7; border:1px solid #ddd; font-size:13px; line-height:1.8;">

                                Excel 컬럼은 아래 순서로 작성하세요.<br>

                                A열 : 제품군코드<br>

                                B열 : 제품군명<br>

                                C열 : 제조공정순서<br><br>

                                이미 등록된 제품군코드가 포함되어 있으면 전체 업로드가 취소됩니다.

                            </div>

                        </div>

                    </div>


                    <div class="row" style="margin-top:20px;">

                        <div class="col-12" style="display:flex; justify-content:flex-end; gap:5px;">

                            <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="ItemGroupExcelUploadPopup.templateDownload();" style="width:110px; height:32px;">양식다운로드</button>

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

            alert("업로드할 Excel 파일을 선택하세요.");

            return;
        }

        var fileName =
            fileInput.files[0].name || "";

        if (!fileName.toLowerCase().endsWith(".xlsx")) {

            alert("xlsx 파일만 업로드할 수 있습니다.");

            return;
        }

        if (!confirm("제품군을 등록하시겠습니까?")) {
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
                        "제품군이 등록되었습니다."
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
                        "Excel Upload 중 오류가 발생했습니다."
                    );
                }
            },

            error:function(xhr) {

                console.log(xhr.responseText);

                alert(
                    "Excel Upload 중 오류가 발생했습니다."
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