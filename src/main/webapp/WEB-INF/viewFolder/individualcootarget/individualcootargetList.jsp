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
            <form:form id="individualCootargetList-form" class="s4-form" novalidate="novalidate" action="" method="post">

                <input type="hidden" id="individual_company_code" name="company_code" value="${sessionScope._sessionUser.company_code}"/>

                <!-- 대시보드 -->
                <div id="individual_dashboard_panel" class="panel panel-icon">
                    <div class="panel-container show">
                        <div class="panel-content" style="padding:0;">
                            <div class="row" style="margin:0; min-height:110px;">

                                <div class="col-3" style="padding:16px 18px 18px; display:flex; flex-direction:column;">
                                    <div style="font-size:15px; font-weight:600; color:#777; text-align:left; line-height:1.4; margin-bottom:14px; white-space:nowrap;">미등록 자재</div>
                                    <div style="font-size:45px; font-weight:700; color:#6c4cff; text-align:center; line-height:1.2;">
                                        <span id="individual_unregisteredItemCount"></span>
                                    </div>
                                </div>

                                <div class="col-3" style="padding:16px 18px 18px; display:flex; flex-direction:column;">
                                    <div style="font-size:15px; font-weight:600; color:#777; text-align:left; line-height:1.4; margin-bottom:14px; white-space:nowrap;">제출완료 자재</div>
                                    <div style="font-size:45px; font-weight:700; color:#252525; text-align:center; line-height:1.2;">
                                        <span id="individual_submittedItemCount"></span>
                                    </div>
                                </div>

                                <div class="col-3" style="padding:16px 18px 18px; display:flex; flex-direction:column;">
                                    <div style="font-size:15px; font-weight:600; color:#777; text-align:left; line-height:1.4; margin-bottom:14px; white-space:nowrap;">30일 내 만료 자재</div>
                                    <div style="font-size:45px; font-weight:700; color:#252525; text-align:center; line-height:1.2;">
                                        <span id="individual_expiringWithin30DaysItemCount"></span>
                                    </div>
                                </div>

                                <div class="col-3" style="padding:16px 18px 18px; display:flex; flex-direction:column;">
                                    <div style="font-size:15px; font-weight:600; color:#777; text-align:left; line-height:1.4; margin-bottom:14px; white-space:nowrap;">Total 자재내역</div>
                                    <div style="font-size:45px; font-weight:700; color:#6c4cff; text-align:center; line-height:1.2;">
                                        <span id="individual_totalItemCount"></span>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <!-- 검색 영역 -->
                <div id="individual_search_panel" class="panel panel-icon">
                    <div class="panel-container show">
                        <div class="panel-content" style="padding:20px 32px;">

                            <!-- 기본 검색 조건 -->
                            <div style="display:grid; grid-template-columns:420px 340px 1fr; column-gap:36px; align-items:end;">

                                <!-- 검색 -->
                                <div>
                                    <label class="form-label" for="individual_search_type" style="display:block; margin-bottom:8px;"><spring:message code='TXT.SEARCH_TEXT03'/></label>
                                    <div style="display:flex; align-items:center; gap:10px;">
                                        <select class="form-select" id="individual_search_type" name="search_type" style="width:120px;">
                                            <option value="ITEM">자재</option>
										    <option value="ORDER_NO">발주번호</option>
										    <option value="VENDOR">협력사</option>
                                        </select>
                                        <input type="text" id="individual_search_key_word" name="search_key_word" class="form-control" placeholder="Border colors" style="width:290px;">
                                    </div>
                                </div>

                                <!-- 입고일자 -->
                                <div>
                                    <label class="form-label" for="individual_search_from_date" style="display:block; margin-bottom:8px;">입고일자</label>
                                    <div style="display:flex; align-items:center; gap:8px;">
                                        <input class="form-control" id="individual_search_from_date" name="search_from_date" type="date" value="<%= java.time.LocalDate.now().minusMonths(1) %>" style="width:145px;">
                                        <span style="display:inline-block; min-width:10px; text-align:center;">~</span>
                                        <input class="form-control" id="individual_search_to_date" name="search_to_date" type="date" value="<%= java.time.LocalDate.now() %>" style="width:145px;">
                                    </div>
                                </div>

                                <!-- 버튼 -->
                                <div style="display:flex; flex-direction:column; gap:5px; justify-self:end;">
                                    <button type="button" class="btn btn-sm btn-search waves-effect waves-themed" onclick="individualCootargetList.retrieve_GridData();" style="width:200px; height:39px; padding:0 12px;">Search</button>
                                    <button type="button" class="btn btn-xs btn-search-more waves-effect waves-themed" onclick="toggleSearchMore(this, 'individualCootargetList_SEARCHMORE');" style="width:200px; height:30px; padding:0 10px;">More</button>
                                </div>

                            </div>

                            <!-- More 검색 조건 -->
                            <div id="individualCootargetList_SEARCHMORE" style="display:none; margin-top:20px; padding-top:20px; border-top:1px solid #e5e5e5;">
                                <div style="display:grid; grid-template-columns:420px 340px 100px; column-gap:36px; align-items:end;">

                                    <!-- 플랜트 -->
                                    <div>
                                        <label class="form-label" for="individual_plant" style="display:block; margin-bottom:8px;">플랜트</label>
                                        <select class="form-select" id="individual_plant" name="plant"></select>
                                    </div>

                                    <!-- 내수여부 -->
                                    <div>
                                        <label class="form-label" for="individual_warehousing_type" style="display:block; margin-bottom:8px;">내수/수입</label>
										<select class="form-select" id="individual_warehousing_type" name="warehousing_type" style="width:200px;">
										    <option value="">All</option>
										    <option value="DOM">내수</option>
										    <option value="IMP">수입</option>
										</select>
                                    </div>
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
                        <span id="individual_totalCount" style="font-size:16px; font-weight:700; color:#333;">0</span>
                        <span style="font-size:13px; color:#666; margin-left:3px;">건</span>
                    </div>
                </div>
            </div>

            <div class="col-5">
                <div class="frame-wrap">
                    <div class="demo" style="display:flex; justify-content:flex-end; align-items:center; gap:3px;">
                        <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="individualCootargetList.openWritePopup();" style="width:110px; color:#fff; background-color:#526d82; border:1px solid #526d82;">증명서 작성</button>
                    </div>
                </div>
            </div>

        </div>


        <!-- Grid -->
        <div class="row">
            <div class="col-12">
                <div id="oAuiGrid_individualCootargetList_01" style="width:100%; height:480px; margin:0 auto;"></div>
            </div>
        </div>

    </div>
</body>

<script>
var individualCootargetList = new function() {

    // AUIGrid 생성 후 반환 ID
    this.grid_individualCootargetList_01 = null;


    // 시작점
    this.Initialize_viewObject = function() {

	    KpackageOBJ.selectbox.create(
	        "individualCootargetList-form",
	        "individual_plant",
	        "/common/retrievePlantCombo",
	        {"OPTION_ALL":"Y"},
	        "code",
	        "name"
	    );
	
	    individualCootargetList.createAUIGrid();
	    individualCootargetList.retrieve_GridData();
	};


    // AUIGrid 생성
    this.createAUIGrid = function() {

        const columnLayout = [
        	{dataField:"COO_CERTIFY_NO", headerText:"COO_CERTIFY_NO", visible:false},
        	{dataField:"DIVISION_NAME", headerText:"플랜트", width:140, filter:{showIcon:false}, style:"aui-center-align"},
        	{dataField:"VENDOR_NAME", headerText:"협력사명", width:200, filter:{showIcon:true}, style:"aui-center-align"},
        	{dataField:"ITEM_CODE", headerText:"자재코드", width:200, filter:{showIcon:true}, style:"aui-center-align"},
        	{dataField:"ITEM_NAME", headerText:"자재명", width:"auto", filter:{showIcon:true}, style:"aui-left-align"},
        	{dataField:"HS_CODE", headerText:"HSCode", width:140, filter:{showIcon:false}, style:"aui-center-align"},
        	{dataField:"ORDER_NO", headerText:"발주번호", width:140, filter:{showIcon:false}, style:"aui-center-align"},
        	{dataField:"ORDER_SEQ", headerText:"발주순번", width:100, filter:{showIcon:false}, style:"aui-center-align"},
        	{dataField:"SUBMIT_STATUS", headerText:"상태", width:100, filter:{showIcon:false}, style:"aui-center-align"},

        	{dataField:"VENDOR_CODE", headerText:"VENDOR_CODE", visible:false},
        	{dataField:"WAREHOUSING_NO", headerText:"WAREHOUSING_NO", visible:false},
        	{dataField:"PARAM_DIVISION_CODE", headerText:"PARAM_DIVISION_CODE", visible:false}
        ];

        const gridProps = {
            usePaging:true,
            pageRowCount:20,
            showPageRowSelect:true,
            enableFilter:true
        };

        individualCootargetList.grid_individualCootargetList_01 = KpackageOBJ.auiGrid.create(
            "oAuiGrid_individualCootargetList_01",
            columnLayout,
            gridProps,
            "check"
        );
    };


    // 조회
    this.retrieve_GridData = function() {

    var params = {
        COMPANY_CODE:$("#individual_company_code").val(),
        plant:$("#individual_plant").val(),
        search_from_date:$("#individual_search_from_date").val().replace(/-/g, ""),
        search_to_date:$("#individual_search_to_date").val().replace(/-/g, ""),
        warehousing_type:$("#individual_warehousing_type").val(),
        search_type:$("#individual_search_type").val(),
        search_key_word:$("#individual_search_key_word").val()
    };

    /* 리스트 조회 */
    $.ajax({
        url:"/individual/retrieveIndividualCootargetList",
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
                individualCootargetList.grid_individualCootargetList_01,
                gridData
            );

            $("#individual_totalCount").text(gridData.length);
        },

        error:function(xhr, status, error) {

            console.log("리스트 조회 오류");
            console.log(xhr.responseText);

            AUIGrid.setGridData(
                individualCootargetList.grid_individualCootargetList_01,
                []
            );

            $("#individual_totalCount").text(0);
        }
    });


    /* 대시보드 조회 */
    $.ajax({
        url:"/individual/retrieveIndividualCootargetDashboard",
        type:"POST",
        contentType:"application/json",
        dataType:"json",
        data:JSON.stringify(params),

        success:function(res) {

            if (!res || !res.success || !res.value || res.value.length === 0) {
                $("#individual_unregisteredItemCount").text(0);
                $("#individual_submittedItemCount").text(0);
                $("#individual_expiringWithin30DaysItemCount").text(0);
                $("#individual_totalItemCount").text(0);
                return;
            }

            var data = res.value[0];

            $("#individual_unregisteredItemCount").text(data.unregisteredItemCount);
            $("#individual_submittedItemCount").text(data.submittedItemCount);
            $("#individual_expiringWithin30DaysItemCount").text(data.expiringWithin30DaysItemCount);
            $("#individual_totalItemCount").text(data.totalItemCount);
        },

        error:function(xhr, status, error) {
            console.log("대시보드 조회 오류");
            console.log(xhr.responseText);
        }
    });
};


    // Excel Download
    this.excelDownload = function() {

        const exportProps = {
            fileName:"원산지증명서등록",
            sheetName:"원산지증명서등록",
            exportWithStyle:true,
            progressBar:true,
            showRowNumColumn:false
        };

        AUIGrid.exportToXlsx(
            individualCootargetList.grid_individualCootargetList_01,
            exportProps
        );
    };


    // 증명서 작성 팝업
    this.openWritePopup = function() {

        var checkedRows = AUIGrid.getCheckedRowItems(
            individualCootargetList.grid_individualCootargetList_01
        );

        if (!checkedRows || checkedRows.length === 0) {
            alert("하나 이상의 자재를 선택해주세요.");
            return;
        }

        var orderNo = checkedRows[0].item.ORDER_NO;
        var orderSeq = checkedRows[0].item.ORDER_SEQ;
        var vendorCode = checkedRows[0].item.VENDOR_CODE;
        var divisionCode = checkedRows[0].item.PARAM_DIVISION_CODE;
        var cooCertifyNo = checkedRows[0].item.COO_CERTIFY_NO || "";

        if (!orderNo || !orderSeq) {
            alert("선택한 자재의 발주정보가 없습니다.");
            return;
        }

        var invalid = checkedRows.some(function(row) {

            if (!row.item) {
                return true;
            }

            return row.item.ORDER_NO != orderNo
	            || row.item.ORDER_SEQ != orderSeq
	            || row.item.VENDOR_CODE != vendorCode
	            || row.item.PARAM_DIVISION_CODE != divisionCode
	            || (row.item.COO_CERTIFY_NO || "") != cooCertifyNo;
        });

        if (invalid) {
        	alert("동일한 발주번호, 발주순번, 협력사, 플랜트 및 동일한 증명서 상태의 자재만 선택해주세요.");
            return;
        }

        var popupUrl =
            "/individualcootarget_pop"
            + "?orderNo=" + encodeURIComponent(orderNo)
            + "&orderSeq=" + encodeURIComponent(orderSeq)
            + "&vendorCode=" + encodeURIComponent(vendorCode)
            + "&divisionCode=" + encodeURIComponent(divisionCode)
            + "&cooCertifyNo=" + encodeURIComponent(cooCertifyNo);

        KpackageOBJ.dialog.open(
            "previewPopup",
            "증명서 작성",
            popupUrl,
            1200,
            800
        );
    };
};


$(document).ready(function() {
    pageSetUp();
    individualCootargetList.Initialize_viewObject();
});
</script>

</html>