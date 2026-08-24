<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
<style>
.aui-right-align,
.aui-right-align .aui-grid-renderer-base {
    width: 100% !important;
    text-align: right !important;
}

.aui-center-align,
.aui-center-align .aui-grid-renderer-base {
    width: 100% !important;
    text-align: center !important;
}

.aui-left-align,
.aui-left-align .aui-grid-renderer-base {
    width: 100% !important;
    text-align: left !important;
}
</style>
</head>

<body>
    <div class="content-wrapper">

        <div class="row">
            <form:form id="coomgt-form" class="s4-form" novalidate="novalidate" action="" method="post">

                <input type="hidden" id="coomgt_companyCode" name="company_code" value="${sessionScope._sessionUser.company_code}"/>

                <!-- 검색 영역 -->
                <div id="coomgt_searchPanel" class="panel panel-icon">
                    <div class="panel-container show">
                        <div class="panel-content" style="padding:20px 32px;">

                            <!-- 기본 검색 조건 -->
                            <div style="display:grid; grid-template-columns:200px 420px 316px 100px; column-gap:36px; align-items:end;">

                                <!-- 자재코드 다중 입력 팝업 -->
                                <div class="modal fade" id="coomgt_itemCodeModal" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" style="max-width:520px;">
                                        <div class="modal-content" style="height:450px;">

                                            <div class="modal-header">
                                                <h5 class="modal-title">자재코드 입력</h5>
                                                <button type="button" class="btn-close" onclick="coomgt.closeItemCodePopup();"></button>
                                            </div>

                                            <div class="modal-body">
                                                <label class="form-label" for="coomgt_itemCodeInput">자재코드</label>
                                                <textarea style="height:220px;" class="form-control" id="coomgt_itemCodeInput" rows="8" placeholder="쉼표 또는 줄바꿈으로 구분해 입력하세요.&#10;예시:&#10;A001,A002,A003&#10;또는&#10;A001&#10;A002&#10;A003"></textarea>

                                                <div style="margin-top:8px; font-size:12px; color:#777;">
                                                    쉼표, 공백, 줄바꿈으로 여러 자재코드를 구분할 수 있습니다.
                                                </div>
                                            </div>

                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" onclick="coomgt.clearItemCodes();" style="width:80px;">초기화</button>
                                                <button type="button" class="btn btn-primary" onclick="coomgt.applyItemCodes();" style="width:80px;">적용</button>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <!-- 자재정보 -->
                                <div style="width:200px;">
                                    <label class="form-label" for="coomgt_itemCodeDisplay" style="display:block; margin-bottom:8px;">자재정보</label>

                                    <div style="position:relative;">
                                        <input class="form-control" id="coomgt_itemCodeDisplay" name="itemCodeDisplay" type="text" placeholder="자재 선택" readonly onclick="coomgt.openItemCodePopup();" style="width:100%; height:38px; padding-right:44px; background-color:#fff; cursor:pointer;">

                                        <button type="button" onclick="coomgt.openItemCodePopup();" aria-label="자재 검색" style="position:absolute; top:0; right:0; width:42px; height:38px; display:flex; align-items:center; justify-content:center; padding:0; color:#66717d; background-color:transparent; border:0; border-left:1px solid #d7dce1; border-radius:0 4px 4px 0; cursor:pointer;">
                                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                                                <circle cx="11" cy="11" r="6.5" stroke="currentColor" stroke-width="2"></circle>
                                                <path d="M16 16L21 21" stroke="currentColor" stroke-width="2" stroke-linecap="round"></path>
                                            </svg>
                                        </button>
                                    </div>

                                    <input id="coomgt_itemCodes" name="itemCodes" type="hidden">
                                </div>

                                <!-- 검색조건 -->
                                <div>
                                    <label class="form-label" for="coomgt_searchType" style="display:block; margin-bottom:8px;"><spring:message code='TXT.SEARCH_TEXT03'/></label>

                                    <div style="display:flex; align-items:center; gap:10px;">
                                        <select class="form-select" id="coomgt_searchType" name="search_type" style="width:120px;">
                                            <option value="VENDOR">협력사</option>
                                            <option value="CCNO">원산지확인서번호</option>
                                        </select>

                                        <input type="text" id="coomgt_searchKeyWord" name="search_key_word" class="form-control" placeholder="검색어 입력" style="width:290px;">
                                    </div>
                                </div>

                                <!-- 유효일자 -->
                                <div>
                                    <label class="form-label" for="coomgt_searchFromDate" style="display:block; margin-bottom:8px;">유효일자</label>

                                    <div style="display:flex; align-items:center; gap:8px;">
                                        <input class="form-control" id="coomgt_searchFromDate" name="search_from_date" type="date" value="<%= java.time.LocalDate.now().minusMonths(1) %>" style="width:145px;">
                                        <span style="display:inline-block; min-width:10px; text-align:center;">~</span>
                                        <input class="form-control" id="coomgt_searchToDate" name="search_to_date" type="date" value="<%= java.time.LocalDate.now() %>" style="width:145px;">
                                    </div>
                                </div>

                                <!-- 검색 버튼 -->
                                <div style="display:flex; flex-direction:column; gap:5px;">
                                    <button type="button" class="btn btn-sm btn-search waves-effect waves-themed" onclick="coomgt.retrieve_GridData();" style="width:200px; height:39px; padding:0 12px;">Search</button>
                                    <button type="button" class="btn btn-xs btn-search-more waves-effect waves-themed" onclick="toggleSearchMore(this, 'coomgt_SEARCHMORE');" style="width:200px; height:30px; padding:0 10px;">More</button>
                                </div>

                            </div>

                            <!-- More 검색 조건 -->
                            <div id="coomgt_SEARCHMORE" style="display:none; margin-top:20px; padding-top:20px; border-top:1px solid #e5e5e5;">
                                <div style="display:grid; grid-template-columns:200px 200px 200px 200px; column-gap:36px; align-items:end;">

                                    <!-- 플랜트 -->
                                    <div>
                                        <label class="form-label" for="coomgt_plant" style="display:block; margin-bottom:8px;">플랜트</label>
                                        <select class="form-select" id="coomgt_plant" name="plant"></select>
                                    </div>

                                    <!-- 확인서 타입 -->
                                    <div>
                                        <label class="form-label" for="coomgt_confirmType" style="display:block; margin-bottom:8px;">확인서타입</label>
                                        <select class="form-select" id="coomgt_confirmType" name="confirm_type" style="width:200px;">
                                            <option value="">All</option>
                                            <option value="N">개별</option>
                                            <option value="C">포괄</option>
                                        </select>
                                    </div>

                                    <!-- 상태 -->
                                    <div>
                                        <label class="form-label" for="coomgt_submitStatus" style="display:block; margin-bottom:8px;">상태</label>
                                        <select class="form-select" id="coomgt_submitStatus" name="submit_status" style="width:200px;">
                                            <option value="">All</option>
                                            <option value="4">작성완료</option>
                                            <option value="0">작성중</option>
                                            <option value="3">재작성요청</option>
                                        </select>
                                    </div>

                                    <!-- 충족여부 -->
                                    <!-- <div>
                                        <label class="form-label" for="coomgt_cooYn" style="display:block; margin-bottom:8px;">충족여부</label>

                                        <div style="height:38px; display:flex; align-items:center;">
                                            <input type="checkbox" id="coomgt_cooYn" name="coo_yn" value="N" style="margin-right:6px;">
                                            <label for="coomgt_cooYn" style="margin:0;">불충족 조회</label>
                                        </div>
                                    </div> -->

                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </form:form>
        </div>

        <!-- Grid 상단 영역 -->
        <div class="row">

            <div class="col-7">
                <div class="frame-wrap">
                    <div class="demo" style="display:inline-flex; align-items:center; margin-left:10px;">
                        <span style="font-size:13px; color:#666; margin-right:10px;">총 건수</span>
                        <span id="coomgt_totalCount" style="font-size:16px; font-weight:700; color:#333;">0</span>
                        <span style="font-size:13px; color:#666; margin-left:3px;">건</span>
                    </div>
                </div>
            </div>

            <div class="col-5">
                <div class="frame-wrap">
                    <div class="demo" style="display:flex; justify-content:flex-end; align-items:center; gap:3px;">
                       <!--  <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="coomgt.excelDownload();" style="width:110px;">ExcelDown</button> -->
                        <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="coomgt.openDetail();" style="width:110px; color:#fff; background-color:#526d82; border:1px solid #526d82;">상세조회</button>
                    </div>
                </div>
            </div>

        </div>

        <!-- Grid -->
        <div class="row">
            <div class="col-12">
                <div id="oAuiGrid_coomgt_01" style="width:100%; height:480px; margin:0 auto;"></div>
            </div>
        </div>

    </div>
</body>

<script>
var coomgt = new function() {

    this.grid_coomgt_01 = null;

    this.Initialize_viewObject = function() {

        KpackageOBJ.selectbox.create(
            "coomgt-form",
            "coomgt_plant",
            "/common/retrievePlantCombo",
            {"OPTION_ALL":"Y"},
            "code",
            "name"
        );

        coomgt.createAUIGrid();
        coomgt.retrieve_GridData();
    };

    this.createAUIGrid = function() {

        const columnLayout = [
            { dataField:"VENDOR_NAME", headerText:"협력사명", width:160, filter:{showIcon:true}, style:"aui-left-align" },
            { dataField:"VENDOR_CODE", headerText:"협력사코드", width:110, filter:{showIcon:true}, style:"aui-center-align" },
            { dataField:"ISSUE_DATE", headerText:"발행일자", width:110, filter:{showIcon:true}, style:"aui-center-align" },
            { dataField:"COO_CERTIFY_NO", headerText:"원산지확인서번호", width:180, filter:{showIcon:true}, style:"aui-center-align" },
            { dataField:"SUBMIT_STATUS_NAME", headerText:"상태", width:100, filter:{showIcon:true}, style:"aui-center-align" },
            { dataField:"INPUT_TYPE_NAME", headerText:"입력구분", width:100, filter:{showIcon:true}, style:"aui-center-align" },
            { dataField:"CNT", headerText:"아이템수", width:90, filter:{showIcon:false}, style:"aui-right-align" },
            { dataField:"COO_CERTIFY_TYPE_NAME", headerText:"타입", width:100, filter:{showIcon:true}, style:"aui-center-align" },
            { dataField:"ORIGIN_FILE_NAME", headerText:"원산지확인서 다운로드", width:180, filter:{showIcon:false}, style:"aui-center-align", editable:false, labelFunction:function(rowIndex, columnIndex, value, headerText, item){ return Number(item.FILE_CNT || 0) > 0 ? "다운로드" : ""; } },
            { dataField:"FILE_CNT", headerText:"확인서 파일 수", width:110, filter:{showIcon:false}, style:"aui-right-align" }
        ];

        const gridProps = {
            usePaging:true,
            pageRowCount:20,
            showPageRowSelect:true,
            enableFilter:true,
            editable:false
        };

        coomgt.grid_coomgt_01 = KpackageOBJ.auiGrid.create(
            "oAuiGrid_coomgt_01",
            columnLayout,
            gridProps,
            "check"
        );
        
        AUIGrid.bind(coomgt.grid_coomgt_01, "cellDoubleClick", function(event) {
        	if (event.dataField != "ORIGIN_FILE_NAME") return;
        	if (!event.item || !event.item.FILE_SEQ) {
        		alert("등록된 원산지확인서 파일이 없습니다.");
        		return;
        	}
        	coomgt.downloadCooFile(event.item);
        });
    };
    
    this.downloadCooFile = function(item) {
    	var params = {
    		COMPANY_CODE:item.COMPANY_CODE,
    		PARAM_DIVISION_CODE:item.DIVISION_CODE,
    		PARAM_VENDOR_CODE:item.VENDOR_CODE,
    		COO_CERTIFY_NO:item.COO_CERTIFY_NO,
    		FILE_SEQ:item.FILE_SEQ
    	};

    	var url = "/coomgt/extCooCertifyFileDownLoad?" + $.param(params);

    	var a = document.createElement("a");
    	a.href = url;
    	a.style.display = "none";
    	document.body.appendChild(a);
    	a.click();
    	document.body.removeChild(a);
    };

    this.retrieve_GridData = function() {

        var params = {
            COMPANY_CODE:$("#coomgt_companyCode").val(),
            plant:$("#coomgt_plant").val(),
            search_from_date:$("#coomgt_searchFromDate").val().replace(/-/g, ""),
            search_to_date:$("#coomgt_searchToDate").val().replace(/-/g, ""),
            confirm_type:$("#coomgt_confirmType").val(),
            submit_status:$("#coomgt_submitStatus").val(),
            itemCodes:$("#coomgt_itemCodes").val(),
            coo_yn:$("#coomgt_cooYn").is(":checked") ? "N" : "",
            search_type:$("#coomgt_searchType").val(),
            search_key_word:$("#coomgt_searchKeyWord").val()
        };

        $.ajax({
            url:"/coomgt/retrieveCooConfirmationList",
            type:"POST",
            contentType:"application/json",
            dataType:"json",
            data:JSON.stringify(params),

            success:function(res) {

                var gridData = [];

                if (res && res.success && res.value) {
                    gridData = res.value;
                }

                AUIGrid.setGridData(
                    coomgt.grid_coomgt_01,
                    gridData
                );

                $("#coomgt_totalCount").text(gridData.length);
            },

            error:function(xhr, status, error) {

                console.log("수취확인서 내역 조회 오류");
                console.log(xhr.responseText);

                AUIGrid.setGridData(
                    coomgt.grid_coomgt_01,
                    []
                );

                $("#coomgt_totalCount").text(0);
            }
        });
    };

    this.openItemCodePopup = function() {

        var itemCodes = $("#coomgt_itemCodes").val();

        $("#coomgt_itemCodeInput").val(itemCodes);
        $("#coomgt_itemCodeModal").modal("show");
    };

    this.closeItemCodePopup = function() {
        $("#coomgt_itemCodeModal").modal("hide");
    };

    this.applyItemCodes = function() {

        var input = $("#coomgt_itemCodeInput").val() || "";

        var codes = input.split(/[\s,]+/)
            .map(function(code) {
                return code.trim();
            })
            .filter(function(code) {
                return code !== "";
            });

        codes = [...new Set(codes)];

        var itemCodes = codes.join(",");

        $("#coomgt_itemCodes").val(itemCodes);

        if (codes.length === 0) {
            $("#coomgt_itemCodeDisplay").val("");
        } else if (codes.length === 1) {
            $("#coomgt_itemCodeDisplay").val(codes[0]);
        } else {
            $("#coomgt_itemCodeDisplay").val(codes[0] + " 외 " + (codes.length - 1) + "건");
        }

        coomgt.closeItemCodePopup();
    };

    this.clearItemCodes = function() {
        $("#coomgt_itemCodeInput").val("");
        $("#coomgt_itemCodes").val("");
        $("#coomgt_itemCodeDisplay").val("");
    };

    this.setItemCodes = function(itemCodes) {
        $("#coomgt_itemCodes").val(itemCodes);
        $("#coomgt_itemCodeDisplay").val(itemCodes);
    };

    this.excelDownload = function() {

        const exportProps = {
            fileName:"수취확인서내역",
            sheetName:"수취확인서내역",
            exportWithStyle:true,
            progressBar:true,
            showRowNumColumn:false
        };

        AUIGrid.exportToXlsx(
            coomgt.grid_coomgt_01,
            exportProps
        );
    };


    this.openDetail = function() {
    	var checkedRows = AUIGrid.getCheckedRowItems(coomgt.grid_coomgt_01);

    	if (!checkedRows || checkedRows.length != 1) {
    		alert("상세조회할 확인서를 1건 선택해주세요.");
    		return;
    	}

    	var item = checkedRows[0].item;

    	if (!item.COO_CERTIFY_NO) {
    		alert("등록된 원산지확인서가 아닙니다.");
    		return;
    	}

    	var popupUrl = "/coomgt/CooConfirmationDetail"
    		+ "?cooCertifyNo=" + encodeURIComponent(item.COO_CERTIFY_NO || "")
    		+ "&vendorCode=" + encodeURIComponent(item.VENDOR_CODE || "")
    		+ "&divisionCode=" + encodeURIComponent(item.DIVISION_CODE || "")
    		+ "&submitStatus=" + encodeURIComponent(item.SUBMIT_STATUS || "")
    		+ "&inputType=" + encodeURIComponent(item.INPUT_TYPE || "")
    		+ "&cooCertifyType=" + encodeURIComponent(item.COO_CERTIFY_TYPE || "")
    		+ "&warehousingNo=" + encodeURIComponent(item.WAREHOUSING_NO || "")
    		+ "&subconYn=" + encodeURIComponent(item.SUBCON_YN || "")
    		+ "&subconDivision=" + encodeURIComponent(item.SUBCON_DIVISION || "");

    	KpackageOBJ.dialog.open("previewPopup", "수취 확인서 상세", popupUrl, 1200, 850);
    };
    
};

$(document).ready(function() {
    pageSetUp();
    coomgt.Initialize_viewObject();
});
</script>

</html>