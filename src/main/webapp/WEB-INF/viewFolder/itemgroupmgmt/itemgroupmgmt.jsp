<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<div class="content-wrapper">
    <div class="row">
        <form:form id="ItemGroupMgmt-form" class="s4-form" novalidate="novalidate" action="" method="post">
            <input type="hidden" id="company_code" name="company_code" value="${sessionScope._sessionUser.company_code}"/>
            <!-- 제품군 다중 입력 팝업 -->
            <div class="modal fade" id="productCodeModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" style="max-width:520px;">
                    <div class="modal-content" style="height:450px;">
                        <div class="modal-header">
                            <h5 class="modal-title"><spring:message code="TXT.PRODUCT_GROUP_INPUT"/></h5>
                            <button type="button" class="btn-close" onclick="ItemGroupMgmt.closeProductCodePopup();"></button>
                        </div>
                        <div class="modal-body">
                            <label class="form-label" for="productCodeInput"><spring:message code="TXT.PRODUCT_LINE"/></label>
                            <textarea class="form-control" id="productCodeInput" rows="8" style="height:220px;" placeholder="<spring:message code='MSG.SEPARATE_THEM'/>&#10;<spring:message code='TXT.EXAMPLE'/>:&#10;P001,P002,P003&#10;<spring:message code='TXT.OR'/>&#10;P001&#10;P002&#10;P003"></textarea>
                            <div style="margin-top:8px; font-size:12px; color:#777;">
                                <spring:message code="MSG.SEPARATE_PRODUCT_GROUPS"/>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" onclick="ItemGroupMgmt.clearProductCodes();" style="width:80px;"><spring:message code="TXT.INITIALIZATION"/></button>
                            <button type="button" class="btn btn-primary" onclick="ItemGroupMgmt.applyProductCodes();" style="width:80px;"><spring:message code="TXT.APPLICATION"/></button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 조회조건 -->
            <div id="panel-4" class="panel panel-icon">
                <div class="panel-container show">
                    <div class="panel-content" style="padding:20px 32px;">
                        <div style="display:flex; justify-content:space-between; align-items:flex-end; width:100%;">
                            <div>
                                <label class="form-label" for="productCodeDisplay" style="display:block; margin-bottom:8px;"><spring:message code="TXT.PRODUCT_LINE"/></label>
                                <div style="position:relative; width:220px;">
                                    <input class="form-control" id="productCodeDisplay" name="productCodeDisplay" type="text" placeholder="<spring:message code='TXT.PRODUCT_GROUP_SELECTION'/>" readonly onclick="ItemGroupMgmt.openProductCodePopup();" style="width:100%; height:38px; padding-right:44px; background-color:#fff; cursor:pointer;">
                                    <button type="button" onclick="ItemGroupMgmt.openProductCodePopup();" aria-label="<spring:message code='TXT.PRODUCT_GROUP_SEARCH'/>" style="position:absolute; top:0; right:0; width:42px; height:38px; display:flex; align-items:center; justify-content:center; padding:0; color:#66717d; background-color:transparent; border:0; border-left:1px solid #d7dce1; border-radius:0 4px 4px 0; cursor:pointer;">
                                        <svg width="17" height="17" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                                            <circle cx="11" cy="11" r="6.5" stroke="currentColor" stroke-width="2"></circle>
                                            <path d="M16 16L21 21" stroke="currentColor" stroke-width="2" stroke-linecap="round"></path>
                                        </svg>
                                    </button>
                                </div>
                                <input id="productCodes" name="productCodes" type="hidden">
                            </div>
                            <div>
                                <button type="button" class="btn btn-sm btn-search waves-effect waves-themed" onclick="ItemGroupMgmt.retrieve_GridData();" style="width:140px; height:44px; padding:0 12px; font-size:15px; font-weight:600;">Search</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form:form>
    </div>
    <!-- 제품군 타이틀 / 툴바 -->
    <div class="row">
        <div class="col-2">
            <div class="ms-auto d-none d-sm-flex align-items-center">
                &nbsp;&nbsp; <spring:message code="TXT.PRODUCT_LINE"/> (<spring:message code="TXT.TOTAL_COUNT"/> : <span id="groupTotalCount" style="font-weight:700; margin:0 3px;">0</span>)
            </div>
        </div>
        <div class="col-10">
            <div class="frame-wrap">
                <div class="demo" style="display:flex; justify-content:flex-end; align-items:center; gap:3px;">
                    <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="ItemGroupMgmt.excelUpload();" style="width:110px; height:32px;">ExcelUpload</button>
                    <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="ItemGroupMgmt.openItemGroupInsertPopup();" style="width:110px; height:32px;"><spring:message code="TXT.ADD"/></button>
                    <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="ItemGroupMgmt.deleteItemGroup();" style="width:110px; height:32px;"><spring:message code="TXT.DELETE"/></button>
                </div>
            </div>
        </div>
    </div>
    <!-- 제품군 그리드 -->
    <div class="row">
        <div class="col-12">
            <div id="oAuiGrid_ItemGroupMgmt_01" style="width:100%; height:240px; margin:0 auto;"></div>
        </div>
    </div>
    <!-- 품목 타이틀 -->
    <div class="row" style="margin-top:15px;">
        <div class="col-12">
            <div class="ms-auto d-none d-sm-flex align-items-center">
                &nbsp;&nbsp; <spring:message code="TXT.ITEM_LIST"/> (<spring:message code="TXT.TOTAL_COUNT"/> : <span id="itemTotalCount" style="font-weight:700; margin:0 3px;">0</span>)
            </div>
        </div>
    </div>
    <!-- 품목 그리드 -->
    <div class="row">
        <div class="col-12">
            <div id="oAuiGrid_ItemGroupMgmt_02" style="width:100%; height:240px; margin:0 auto;"></div>
        </div>
    </div>
</div>
<script>
var ItemGroupMgmt = new function() {
    this.grid_ItemGroupMgmt_01 = null;
    this.grid_ItemGroupMgmt_02 = null;
    this.Initialize_viewObject = function() {
        ItemGroupMgmt.createAUIGrid();
        ItemGroupMgmt.createAUIGrid2();
        AUIGrid.setGridData(ItemGroupMgmt.grid_ItemGroupMgmt_01, []);
        AUIGrid.setGridData(ItemGroupMgmt.grid_ItemGroupMgmt_02, []);
        ItemGroupMgmt.updateTotalCount();
        ItemGroupMgmt.retrieve_GridData();
    };
    /* 제품군 그리드 */
    this.createAUIGrid = function() {
        const columnLayout = [
            { dataField:"PRODUCT_CODE", headerText:"<spring:message code='TXT.PRODUCT_GROUP_CODE' javaScriptEscape='true'/>", width:140, filter:{showIcon:false} },
            { dataField:"PRODUCT_NAME", headerText:"<spring:message code='TXT.PRODUCT_GROUP_NAME' javaScriptEscape='true'/>", width:200, filter:{showIcon:false} },
            { dataField:"FLOWCHART_COMMENT", headerText:"<spring:message code='TXT.MANUFACTURING_PROCESS_ORDER' javaScriptEscape='true'/>", width:"auto", filter:{showIcon:false} },
            { dataField:"FILE_NAME", headerText:"<spring:message code='TXT.ATTACHMENT_FILE' javaScriptEscape='true'/>", width:240, filter:{showIcon:false} },
            { dataField:"CREATE_DATE", headerText:"<spring:message code='TXT.CREATE_DATE' javaScriptEscape='true'/>", width:140, filter:{showIcon:false} }
        ];
        const gridProps = {
            usePaging:true,
            pageRowCount:20,
            showPageRowSelect:true,
            enableFilter:true,
            selectionMode:"singleRow"
        };
        ItemGroupMgmt.grid_ItemGroupMgmt_01 = KpackageOBJ.auiGrid.create(
            "oAuiGrid_ItemGroupMgmt_01",
            columnLayout,
            gridProps,
            "check"
        );
        /* 제품군 클릭 -> 품목 조회 */
        AUIGrid.bind(ItemGroupMgmt.grid_ItemGroupMgmt_01, "cellClick", function(event) {
            if (!event || !event.item || !event.item.PRODUCT_CODE) {
                return;
            }
            ItemGroupMgmt.retrieveItemList(event.item.PRODUCT_CODE);
        });
        /* 제품군 더블클릭 -> 제품군 수정 팝업 */
        AUIGrid.bind(ItemGroupMgmt.grid_ItemGroupMgmt_01, "cellDoubleClick", function(event) {
            if (!event || !event.item || !event.item.PRODUCT_CODE) {
                return;
            }
            ItemGroupMgmt.openItemGroupUpdatePopup(event.item.PRODUCT_CODE);
        });
    };
    /* 품목 그리드 */
    this.createAUIGrid2 = function() {
        const columnLayout = [
            { dataField:"ROW_NO", headerText:"No", width:50, filter:{showIcon:false} },
            { dataField:"ITEM_CODE", headerText:"<spring:message code='TXT.PRODUCT_CODE' javaScriptEscape='true'/>", width:240, filter:{showIcon:false} },
            { dataField:"ITEM_NAME", headerText:"<spring:message code='TXT.MATERIAL_NAME' javaScriptEscape='true'/>", width:"auto", filter:{showIcon:false} },
            { dataField:"HS_CODE", headerText:"HsCode", width:240, filter:{showIcon:false} }
        ];
        const gridProps = {
            usePaging:true,
            pageRowCount:20,
            showPageRowSelect:true,
            enableFilter:true,
            selectionMode:"singleRow"
        };
        ItemGroupMgmt.grid_ItemGroupMgmt_02 = KpackageOBJ.auiGrid.create(
            "oAuiGrid_ItemGroupMgmt_02",
            columnLayout,
            gridProps,
            ""
        );
        /* 품목 더블클릭 -> 제품 상세정보 팝업 */
        AUIGrid.bind(ItemGroupMgmt.grid_ItemGroupMgmt_02, "cellDoubleClick", function(event) {
            if (!event || !event.item || !event.item.ITEM_CODE) {
                return;
            }
            ItemGroupMgmt.openItemDetailPopup(event.item.ITEM_CODE);
        });
    };
    /* 제품군 목록 조회 */
    this.retrieve_GridData = function() {
        var params = {
            COMPANY_CODE:$("#company_code").val(),
            productCodes:$("#productCodes").val()
        };
        KpackageOBJ.ajax.doSubmit(
            "/itemgroupmgmt/retrieveItemGroupMgmt",
            params,
            function(arg) {
                var data = arg.value || [];
                AUIGrid.setGridData(ItemGroupMgmt.grid_ItemGroupMgmt_01, data);
                AUIGrid.setGridData(ItemGroupMgmt.grid_ItemGroupMgmt_02, []);
                ItemGroupMgmt.updateTotalCount();
            }
        );
    };
    /* 선택 제품군 품목 조회 */
    this.retrieveItemList = function(productCode) {
        if (!productCode) {
            AUIGrid.setGridData(ItemGroupMgmt.grid_ItemGroupMgmt_02, []);
            ItemGroupMgmt.updateTotalCount();
            return;
        }
        var params = {
            COMPANY_CODE:$("#company_code").val(),
            PRODUCT_CODE:productCode
        };
        KpackageOBJ.ajax.doSubmit(
            "/itemgroupmgmt/retrieveItemGroupItemList",
            params,
            function(arg) {
                var data = arg.value || [];
                for (var i = 0; i < data.length; i++) {
                    data[i].ROW_NO = i + 1;
                }
                AUIGrid.setGridData(ItemGroupMgmt.grid_ItemGroupMgmt_02, data);
                ItemGroupMgmt.updateTotalCount();
            }
        );
    };
    /* 추가 -> 제품군 관리 신규 팝업 */
    this.openItemGroupInsertPopup = function() {
        KpackageOBJ.dialog.open(
            "itemGroupPopup",
            "<spring:message code='TXT.PRODUCT_GROUP_MANAGEMENT' javaScriptEscape='true'/>",
            "/itemgroupmgmt/itemGroupPopup?flag=insert",
            800,
            470
        );
    };
    /* 제품군 수정 팝업 */
    this.openItemGroupUpdatePopup = function(productCode) {
        if (!productCode) {
            alert("<spring:message code='MSG.PRODUCT_GROUP_CODE_NOT_FOUND' javaScriptEscape='true'/>");
            return;
        }
        KpackageOBJ.dialog.open(
            "itemGroupPopup",
            "<spring:message code='TXT.PRODUCT_GROUP_MANAGEMENT' javaScriptEscape='true'/>",
            "/itemgroupmgmt/itemGroupPopup?flag=update&PRODUCT_CODE=" + encodeURIComponent(productCode),
            800,
            470
        );
    };
    /* 저장 버튼 -> 선택 제품군 수정 팝업 */
    this.openSelectedItemGroupPopup = function() {
        var selectedItems = AUIGrid.getSelectedItems(ItemGroupMgmt.grid_ItemGroupMgmt_01);
        if (!selectedItems || selectedItems.length === 0) {
            alert("<spring:message code='MSG.SELECT_PRODUCT_GROUP' javaScriptEscape='true'/>");
            return;
        }
        var row = selectedItems[0].item;
        if (!row || !row.PRODUCT_CODE) {
            alert("<spring:message code='MSG.SELECT_PRODUCT_GROUP' javaScriptEscape='true'/>");
            return;
        }
        ItemGroupMgmt.openItemGroupUpdatePopup(row.PRODUCT_CODE);
    };
    /* 체크된 제품군 다중 삭제 */
    this.deleteItemGroup = function() {
        var checkedRows = AUIGrid.getCheckedRowItems(ItemGroupMgmt.grid_ItemGroupMgmt_01);
        if (!checkedRows || checkedRows.length === 0) {
            alert("<spring:message code='MSG.CHECK_PRODUCT_GROUP_TO_DELETE' javaScriptEscape='true'/>");
            return;
        }
        var deleteRows = [];
        for (var i = 0; i < checkedRows.length; i++) {
            if (!checkedRows[i].item || !checkedRows[i].item.PRODUCT_CODE) {
                continue;
            }
            deleteRows.push({
                PRODUCT_CODE:checkedRows[i].item.PRODUCT_CODE
            });
        }
        if (deleteRows.length === 0) {
            alert("<spring:message code='MSG.NO_PRODUCT_GROUP_TO_DELETE' javaScriptEscape='true'/>");
            return;
        }
        if (!confirm("<spring:message code='MSG.CONFIRM_DELETE_CHECKED_PRODUCT_GROUP' javaScriptEscape='true'/>".replace("{0}", deleteRows.length))) {
            return;
        }
        var params = {
            COMPANY_CODE:$("#company_code").val(),
            deleteRows:deleteRows
        };
        KpackageOBJ.ajax.doSubmit(
            "/itemgroupmgmt/deleteItemGroupList",
            params,
            function(arg) {
                if (arg && arg.success) {
                    alert("<spring:message code='MSG.DELETE_SUCCESS' javaScriptEscape='true'/>");
                    AUIGrid.setGridData(ItemGroupMgmt.grid_ItemGroupMgmt_02, []);
                    ItemGroupMgmt.retrieve_GridData();
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
    /* 품목 상세정보 팝업 */
    this.openItemDetailPopup = function(itemCode) {
        if (!itemCode) {
            return;
        }
        KpackageOBJ.dialog.open(
            "itemDetailPopup",
            "<spring:message code='TXT.PRODUCT' javaScriptEscape='true'/> <spring:message code='TXT.DETAIL' javaScriptEscape='true'/> <spring:message code='TXT.INFO' javaScriptEscape='true'/>",
            "/itemgroupmgmt/itemDetailPopup?ITEM_CODE=" + encodeURIComponent(itemCode),
            900,
            650
        );
    };
    /* 양식 다운로드 */
    this.templateDownload = function() {
        window.location.href = "/itemgroupmgmt/templateDownload";
    };
    /* Excel Upload */
    this.excelUpload = function() {
        KpackageOBJ.dialog.open(
            "itemGroupExcelUploadPopup",
            "Excel Upload",
            "/itemgroupmgmt/excelUploadPopup",
            1000,
            800
        );
    };
    /* 총 건수 */
    this.updateTotalCount = function() {
        var groupCount = 0;
        var itemCount = 0;
        if (ItemGroupMgmt.grid_ItemGroupMgmt_01) {
            groupCount = AUIGrid.getRowCount(ItemGroupMgmt.grid_ItemGroupMgmt_01);
        }
        if (ItemGroupMgmt.grid_ItemGroupMgmt_02) {
            itemCount = AUIGrid.getRowCount(ItemGroupMgmt.grid_ItemGroupMgmt_02);
        }
        $("#groupTotalCount").text(groupCount);
        $("#itemTotalCount").text(itemCount);
    };
    /* 팝업 저장 후 부모 새로고침 */
    this.reload = function() {
        ItemGroupMgmt.retrieve_GridData();
    };
    /* 제품군 다중입력 팝업 */
    this.openProductCodePopup = function() {
        $("#productCodeInput").val($("#productCodes").val());
        $("#productCodeModal").modal("show");
    };
    this.closeProductCodePopup = function() {
        $("#productCodeModal").modal("hide");
    };
    this.applyProductCodes = function() {
        var input = $("#productCodeInput").val() || "";
        var codes = input.split(/[\s,]+/)
            .map(function(code) { return code.trim(); })
            .filter(function(code) { return code !== ""; });
        codes = [...new Set(codes)];
        var productCodes = codes.join(",");
        $("#productCodes").val(productCodes);
        if (codes.length === 0) {
            $("#productCodeDisplay").val("");
        } else if (codes.length === 1) {
            $("#productCodeDisplay").val(codes[0]);
        } else {
            $("#productCodeDisplay").val(
                codes[0] + " <spring:message code='TXT.ADDITION' javaScriptEscape='true'/> " + (codes.length - 1) + "<spring:message code='TXT.CASE' javaScriptEscape='true'/>"
            );
        }
        ItemGroupMgmt.closeProductCodePopup();
    };
    this.clearProductCodes = function() {
        $("#productCodeInput").val("");
        $("#productCodes").val("");
        $("#productCodeDisplay").val("");
    };
    this.setProductCodes = function(productCodes) {
        $("#productCodes").val(productCodes);
        $("#productCodeDisplay").val(productCodes);
    };
};
$(document).ready(function() {
    pageSetUp();
    ItemGroupMgmt.Initialize_viewObject();
});
</script>
</body>
</html>
