<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>

<head>
</head>

<body>

<div class="content-wrapper">

    <form id="ItemDetailPopup-form" enctype="multipart/form-data">

        <input type="hidden" id="company_code" name="COMPANY_CODE" value="${sessionScope._sessionUser.company_code}">
        <input type="hidden" id="ITEM_CODE" name="ITEM_CODE" value="${param.ITEM_CODE}">
        <input type="hidden" id="delList" name="delList" value="">


        <!-- 저장 버튼 -->
        <div class="row">

            <div class="col-12">

                <div style="display:flex; justify-content:flex-end; align-items:center; margin-bottom:10px;">

                    <button type="button" class="btn btn-sm btn-primary waves-effect waves-themed" onclick="ItemDetailPopup.save();" style="width:90px; height:32px;">저장</button>

                </div>

            </div>

        </div>


        <!-- 제품 기본정보 -->
        <div id="panel-4" class="panel panel-icon">

            <div class="panel-container show">

                <div class="panel-content">

                    <div class="row" style="margin-bottom:15px;">

                        <div class="col-2">
                            <label class="form-label" for="ITEM_CODE_DISPLAY">제품 코드</label>
                        </div>

                        <div class="col-4">
                            <input type="text" class="form-control" id="ITEM_CODE_DISPLAY" readonly style="width:100%;">
                        </div>

                        <div class="col-2">
                            <label class="form-label" for="ITEM_NAME">제품명</label>
                        </div>

                        <div class="col-4">
                            <input type="text" class="form-control" id="ITEM_NAME" readonly style="width:100%;">
                        </div>

                    </div>


                    <div class="row" style="margin-bottom:15px;">

                        <div class="col-2">
                            <label class="form-label" for="CURRENT_PRODUCT_LINE_CODE">등록된 제품군 코드</label>
                        </div>

                        <div class="col-4">
                            <input type="text" class="form-control" id="CURRENT_PRODUCT_LINE_CODE" readonly style="width:100%;">
                        </div>

                        <div class="col-2">
                            <label class="form-label" for="CURRENT_PRODUCT_LINE_NAME">등록된 제품군명</label>
                        </div>

                        <div class="col-4">
                            <input type="text" class="form-control" id="CURRENT_PRODUCT_LINE_NAME" readonly style="width:100%;">
                        </div>

                    </div>


                    <div class="row">

                        <div class="col-2">
                            <label class="form-label" for="SELECTED_PRODUCT_LINE_CODE">수정할 제품군 코드</label>
                        </div>

                        <div class="col-4">
                            <select class="form-select" id="SELECTED_PRODUCT_LINE_CODE" name="SELECTED_PRODUCT_LINE_CODE" onchange="ItemDetailPopup.changeProductLine();" style="width:100%;"></select>
                        </div>

                        <div class="col-2">
                            <label class="form-label" for="SELECTED_PRODUCT_LINE_NAME">수정할 제품군명</label>
                        </div>

                        <div class="col-4">
                            <input type="text" class="form-control" id="SELECTED_PRODUCT_LINE_NAME" readonly style="width:100%;">
                        </div>

                    </div>

                </div>

            </div>

        </div>


        <!-- 제품 이미지 -->
        <div class="panel panel-icon">

            <div class="panel-container show">

                <div class="panel-content">

                    <div style="font-size:15px; font-weight:700; margin-bottom:15px;">제품 이미지</div>


                    <div class="row">

                        <div class="col-2">
                            <label class="form-label" for="ITEM_IMG">제품 이미지</label>
                        </div>

                        <div class="col-10">

                            <input type="file" class="form-control" id="ITEM_IMG" name="ITEM_IMG" multiple accept="image/gif,image/jpeg,image/png" style="width:100%;">

                            <div id="itemImageList" style="display:flex; flex-wrap:wrap; gap:12px; margin-top:12px;"></div>

                        </div>

                    </div>

                </div>

            </div>

        </div>


        <!-- 제품군 관리정보 -->
        <div class="panel panel-icon">

            <div class="panel-container show">

                <div class="panel-content">

                    <div style="font-size:15px; font-weight:700; margin-bottom:15px;">제품군 관리</div>


                    <div class="row" style="margin-bottom:15px;">

                        <div class="col-2">
                            <label class="form-label" for="GROUP_PRODUCT_CODE">제품군 코드</label>
                        </div>

                        <div class="col-10">
                            <input type="text" class="form-control" id="GROUP_PRODUCT_CODE" readonly style="width:300px;">
                        </div>

                    </div>


                    <div class="row" style="margin-bottom:15px;">

                        <div class="col-2">
                            <label class="form-label" for="GROUP_PRODUCT_NAME">제품군명</label>
                        </div>

                        <div class="col-10">
                            <input type="text" class="form-control" id="GROUP_PRODUCT_NAME" readonly style="width:300px;">
                        </div>

                    </div>


                    <div class="row" style="margin-bottom:15px;">

                        <div class="col-2">
                            <label class="form-label" for="FLOWCHART_COMMENT">제조공정 순서</label>
                        </div>

                        <div class="col-10">
                            <textarea class="form-control" id="FLOWCHART_COMMENT" readonly style="width:100%; height:80px;"></textarea>
                        </div>

                    </div>


                    <div class="row">

                        <div class="col-2">
                            <label class="form-label">제조공정도 첨부파일</label>
                        </div>

                        <div class="col-10">
                            <div id="flowchartFileList"></div>
                        </div>

                    </div>

                </div>

            </div>

        </div>

    </form>

</div>


<script>

var ItemDetailPopup = new function() {

    this.productLineMap = {};


    this.Initialize_viewObject = function() {

        ItemDetailPopup.retrieveProductLineCombo(function() {

            ItemDetailPopup.retrieveDetail();

        });

        ItemDetailPopup.retrieveItemFileList();
    };


    /* 제품군 콤보 */
    this.retrieveProductLineCombo = function(callback) {

        var params = {
            COMPANY_CODE:$("#company_code").val()
        };

        KpackageOBJ.ajax.doSubmit(
            "/itemgroupmgmt/retrieveItemGroupCombo",
            params,
            function(arg) {

                var data = arg.value || [];

                ItemDetailPopup.productLineMap = {};

                $("#SELECTED_PRODUCT_LINE_CODE").empty();

                $("#SELECTED_PRODUCT_LINE_CODE").append(
                    $("<option>").val("").text("")
                );


                for (var i = 0; i < data.length; i++) {

                    var row = data[i];

                    ItemDetailPopup.productLineMap[row.CODE] = row.NAME;

                    $("#SELECTED_PRODUCT_LINE_CODE").append(
                        $("<option>").val(row.CODE).text(row.CODE)
                    );
                }


                if (callback) {
                    callback();
                }
            }
        );
    };


    /* 품목 상세 조회 */
    this.retrieveDetail = function() {

        var params = {
            COMPANY_CODE:$("#company_code").val(),
            ITEM_CODE:$("#ITEM_CODE").val()
        };

        KpackageOBJ.ajax.doSubmit(
            "/itemgroupmgmt/retrieveItemDetail",
            params,
            function(arg) {

                var data = arg.value || {};

                $("#ITEM_CODE_DISPLAY").val(data.ITEM_CODE || "");
                $("#ITEM_NAME").val(data.ITEM_NAME || "");

                $("#CURRENT_PRODUCT_LINE_CODE").val(data.PRODUCT_LINE_CODE || "");
                $("#CURRENT_PRODUCT_LINE_NAME").val(data.PRODUCT_LINE_NAME || "");

                $("#SELECTED_PRODUCT_LINE_CODE").val(data.PRODUCT_LINE_CODE || "");
                $("#SELECTED_PRODUCT_LINE_NAME").val(data.PRODUCT_LINE_NAME || "");

                $("#GROUP_PRODUCT_CODE").val(data.PRODUCT_LINE_CODE || "");
                $("#GROUP_PRODUCT_NAME").val(data.PRODUCT_LINE_NAME || "");
                $("#FLOWCHART_COMMENT").val(data.FLOWCHART_COMMENT || "");


                if (data.PRODUCT_LINE_CODE) {

                    ItemDetailPopup.retrieveFlowchartFileList(data.PRODUCT_LINE_CODE);

                } else {

                    $("#flowchartFileList").empty();
                }
            }
        );
    };


    /* 수정할 제품군 변경 */
    this.changeProductLine = function() {

        var productCode = $("#SELECTED_PRODUCT_LINE_CODE").val();

        $("#SELECTED_PRODUCT_LINE_NAME").val(
            ItemDetailPopup.productLineMap[productCode] || ""
        );
    };


    /* 제품 이미지 조회 */
    this.retrieveItemFileList = function() {

        var params = {
            COMPANY_CODE:$("#company_code").val(),
            ITEM_CODE:$("#ITEM_CODE").val()
        };

        KpackageOBJ.ajax.doSubmit(
            "/itemgroupmgmt/retrieveItemFileList",
            params,
            function(arg) {

                var data = arg.value || [];

                $("#itemImageList").empty();


                for (var i = 0; i < data.length; i++) {

                    var file = data[i];

                    var wrapper = $("<div>").css({
                        display:"inline-block",
                        border:"1px solid #ddd",
                        padding:"8px",
                        position:"relative"
                    });


                    if (file.FILE_URL) {

                        var img = $("<img>")
                            .attr("src", file.FILE_URL)
                            .css({
                                width:"180px",
                                maxHeight:"180px",
                                objectFit:"contain",
                                display:"block"
                            });

                        wrapper.append(img);

                    } else {

                        wrapper.append(
                            $("<div>")
                                .text(file.ORIGIN_FILE_NAME || file.FILE_NAME || "")
                                .css({
                                    width:"180px",
                                    minHeight:"40px",
                                    wordBreak:"break-all"
                                })
                        );
                    }


                    var deleteBtn = $("<button>")
                        .attr("type", "button")
                        .addClass("btn btn-xs btn-danger waves-effect waves-themed")
                        .text("삭제")
                        .css({
                            width:"50px",
                            height:"26px",
                            marginTop:"8px"
                        });


                    deleteBtn.data("fileSeq", file.FILE_SEQ);


                    deleteBtn.on("click", function() {

                        ItemDetailPopup.markDeleteItemFile(
                            $(this).data("fileSeq"),
                            this
                        );
                    });


                    wrapper.append(deleteBtn);

                    $("#itemImageList").append(wrapper);
                }
            }
        );
    };


    /* 제품 이미지 삭제대상 지정 */
    this.markDeleteItemFile = function(fileSeq, obj) {

        var delList = $("#delList").val();

        if (delList !== "") {
            delList += ",";
        }

        delList += fileSeq;

        $("#delList").val(delList);

        $(obj).parent().remove();
    };


    /* 현재 제품군의 제조공정 첨부파일 조회 */
    this.retrieveFlowchartFileList = function(productCode) {

        var params = {
            COMPANY_CODE:$("#company_code").val(),
            PRODUCT_CODE:productCode
        };

        KpackageOBJ.ajax.doSubmit(
            "/itemgroupmgmt/retrieveItemGroupFileList",
            params,
            function(arg) {

                var data = arg.value || [];

                $("#flowchartFileList").empty();


                for (var i = 0; i < data.length; i++) {

                    var file = data[i];

                    var html = "";

                    html += "<div style='margin-bottom:5px;'>";

                    html += "<a href='javascript:ItemDetailPopup.downloadFlowchartFile(";
                    html += "\"" + productCode + "\",";
                    html += file.FILE_SEQ;
                    html += ");'>";

                    html += file.ORIGIN_FILE_NAME;

                    html += "</a>";

                    html += "</div>";

                    $("#flowchartFileList").append(html);
                }
            }
        );
    };


    /* 제조공정 첨부파일 다운로드 */
    this.downloadFlowchartFile = function(productCode, fileSeq) {

        var params = {
            COMPANY_CODE:$("#company_code").val(),
            PRODUCT_CODE:productCode,
            FILE_SEQ:fileSeq
        };

        window.location.href = "/itemgroupmgmt/itemGroupFileDownload?" + $.param(params);
    };


    /* 저장 */
    this.save = function() {

        var selectedProductLineCode = $("#SELECTED_PRODUCT_LINE_CODE").val();

        if (!selectedProductLineCode) {

            alert("수정할 제품군 코드를 선택하세요.");

            $("#SELECTED_PRODUCT_LINE_CODE").focus();

            return;
        }


        var formData = new FormData(
            document.getElementById("ItemDetailPopup-form")
        );


        $.ajax({
            url:"/itemgroupmgmt/saveItemDetail",
            type:"POST",
            data:formData,
            processData:false,
            contentType:false,

            success:function(result) {

                if (result && result.success) {

                    alert("저장되었습니다.");

                    $("#delList").val("");
                    $("#ITEM_IMG").val("");

                    ItemDetailPopup.retrieveDetail();
                    ItemDetailPopup.retrieveItemFileList();


                    if (window.parent.ItemGroupMgmt) {
                        window.parent.ItemGroupMgmt.reload();
                    }

                } else {

                    alert(
                        result && result.message
                            ? result.message
                            : "저장 중 오류가 발생했습니다."
                    );
                }
            },

            error:function() {

                alert("저장 중 오류가 발생했습니다.");
            }
        });
    };

};


$(document).ready(function() {

    pageSetUp();

    ItemDetailPopup.Initialize_viewObject();

});

</script>

</body>

</html>