<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>원산지확인서 검색</title>
</head>
<body>
<div class="container-fluid p-2">
    <!-- 1행 : 검색조건 영역 + 검색버튼 -->
    <div class="row g-2 align-items-stretch mb-2">
        <div class="col-md-11">
            <div class="card border shadow-sm h-100">
                <div class="card-body py-2 px-3">
                    <form:form id="COO_CERT_SEARCH_POPUP-form" method="post" action="" novalidate="novalidate">
                        <input type="hidden" id="customer_code" name="customer_code"/>

                        <div class="row g-2 align-items-center">

                            <div class="col-md-1">
                                <label for="division_code" class="form-label fw-semibold small mb-0">플랜트</label>
                            </div>
                            <div class="col-md-2">
                                <select id="division_code" name="division_code" class="form-select form-select-sm">
                                    <option value="">All</option>
                                </select>
                            </div>

                            <div class="col-md-1">
                                <label class="form-label fw-semibold small mb-0">발행일자</label>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-center gap-1">
                                    <input type="date" id="from_date" name="from_date" class="form-control form-control-sm">
                                    <span class="small text-secondary">~</span>
                                    <input type="date" id="to_date" name="to_date" class="form-control form-control-sm">
                                </div>
                            </div>

                            <div class="col-md-1">
                                <label for="customer_name" class="form-label fw-semibold small mb-0">고객명</label>
                            </div>
                            <div class="col-md-3">
                                <div class="input-group input-group-sm">
                                    <input type="text" id="customer_name" name="customer_name" class="form-control">
                                    <button type="button" class="btn btn-outline-secondary" onclick="COO_CERT_SEARCH_POPUP.openCustomerSearch();">
                                        <i class="sa sa-magnifier"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="col-md-1">
                                <label for="product_name" class="form-label fw-semibold small mb-0">재품명</label>
                            </div>
                            <div class="col-md-3">
                                <div class="input-group input-group-sm">
                                    <input type="text" id="product_name" name="product_name" class="form-control">
                                    <button type="button" class="btn btn-outline-secondary" onclick="COO_CERT_SEARCH_POPUP.openProductSearch();">
                                        <i class="sa sa-magnifier"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="col-md-1">
                                <label for="search_type" class="form-label fw-semibold small mb-0">검색조건</label>
                            </div>
                            <div class="col-md-3">
                                <div class="d-flex gap-1">
                                    <select id="search_type" name="search_type" class="form-select form-select-sm" style="max-width: 120px;">
                                        <option value="COO_CERTIFY_NO">증명번호</option>
                                        <option value="INVOICE_NO">인보이스번호</option>
                                        <option value="PRODUCT_CODE">품목코드</option>
                                    </select>
                                    <div class="input-group input-group-sm">
                                        <input type="text" id="search_keyword" name="search_keyword" class="form-control">
                                        <button type="button" class="btn btn-outline-secondary" onclick="COO_CERT_SEARCH_POPUP.retrieveGridData();">
                                            <i class="sa sa-magnifier"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-1">
                                <label for="issue_type" class="form-label fw-semibold small mb-0">발급유형</label>
                            </div>
                            <div class="col-md-2">
                                <select id="issue_type" name="issue_type" class="form-select form-select-sm">
                                    <option value="">All</option>
                                    <option value="N">일반</option>
                                    <option value="C">포괄</option>
                                </select>
                            </div>

                        </div>
                    </form:form>
                </div>
            </div>
        </div>

        <!-- 검색 버튼 -->
        <div class="col-md-1">
            <div class="card border shadow-sm h-100">
                <div class="card-body d-flex align-items-center justify-content-center p-2">
                    <button type="button"
                            class="btn btn-primary w-100 h-100"
                            onclick="COO_CERT_SEARCH_POPUP.retrieveGridData();">
                        검색
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- 2행 : 총건수 + 선택버튼 -->
    <div class="d-flex justify-content-between align-items-center mb-2">
        <div class="fw-semibold text-primary small">
            총건수 :
            <span id="cooCertifyPipup_total_count">0</span>
        </div>

        <button type="button"
                class="btn btn-sm btn-outline-primary px-4"
                onclick="COO_CERT_SEARCH_POPUP.selectRow();">
            선택
        </button>
    </div>

    <!-- 3행 : 그리드 -->
    <div class="card border shadow-sm">
        <div class="card-body p-1">
            <div id="oAuiGrid_COO_CERT_SEARCH_POPUP_01" style="width: 100%; height: 420px;"></div>
        </div>
    </div>
</div>

<script>
var COO_CERT_SEARCH_POPUP = new function() {

    this.grid_COO_CERT_SEARCH_POPUP_01 = null;

    this.Initialize_viewObject = function() {
        this.setDefaultDateRange();
        this.createAUIGrid();
    };

    this.setDefaultSelectBox = function() {
        KpackageOBJ.selectbox.create("COO_CERT_SEARCH_POPUP-form", "division_code", "/common/retrievePlantCombo", {"OPTION_ALL":"Y"}, "code", "name");
        
        var arrayItem = [
			{value:"COO_CERTIFY_NO", name:"<spring:message code='증명번호'/>"}
			,{value:"INVOICE_NO", name:"<spring:message code='인보이스번호'/>"}
			,{value:"PRODUCT_CODE", name:"<spring:message code='품목코드'/>"}
		
		];
		KpackageOBJ.selectbox.create("COO_CERT_SEARCH_POPUP-form", "search_type", "", null, "value", "name", arrayItem);
    };

    this.setDefaultDateRange = function() {
        var today = new Date();

        var toY = today.getFullYear();
        var toM = String(today.getMonth() + 1).padStart(2, "0");
        var toD = String(today.getDate()).padStart(2, "0");

        var toDateStr = toY + "-" + toM + "-" + toD;

        var fromDate = new Date(today);
        fromDate.setMonth(fromDate.getMonth() - 3);

        var fromY = fromDate.getFullYear();
        var fromM = String(fromDate.getMonth() + 1).padStart(2, "0");
        var fromD = String(fromDate.getDate()).padStart(2, "0");

        var fromDateStr = fromY + "-" + fromM + "-" + fromD;

        KpackageOBJ.object.setFormValue("COO_CERT_SEARCH_POPUP-form", "from_date", fromDateStr);
        KpackageOBJ.object.setFormValue("COO_CERT_SEARCH_POPUP-form", "to_date", toDateStr);
    };

    this.createAUIGrid = function() {
        var columnLayout = [
            {
                dataField: "coo_certify_no",
                headerText: "원산지증명번호",
                width: 160,
                style: "aui-center",
                headerStyle: "aui-center"
            },
            {
                dataField: "division_name",
                headerText: "플랜트명",
                width: 120,
                style: "aui-center",
                headerStyle: "aui-center"
            },
            {
                dataField: "customer_name",
                headerText: "고객명",
                width: 140
            },
            {
                dataField: "issue_date",
                headerText: "발행일자",
                width: 100,
                style: "aui-center",
                headerStyle: "aui-center"
            },
            {
                dataField: "cover_date",
                headerText: "포괄기간",
                width: 180,
                style: "aui-center",
                headerStyle: "aui-center"
            },
            {
                dataField: "issue_type_name",
                headerText: "발급유형",
                width: 100,
                style: "aui-center",
                headerStyle: "aui-center"
            },
            {
                dataField: "origin_coo_certify_no",
                headerText: "기발급 확인서 번호",
                width: 160
            }
            
            ,{dataField: "export_flag", headerText: "export_flag", width: 160, visible:false }
            ,{dataField: "division_code", headerText: "division_code", width: 160, visible:false }
            ,{dataField: "apply_date", headerText: "apply_date", width: 160, visible:false }
            ,{dataField: "end_date", headerText: "end_date", width: 160, visible:false }
        ];

        var gridProps = {
            editable: false,
            selectionMode: "singleRow",
            showRowNumColumn: false,
            enableFilter: true,
            usePaging: false,
            fillColumnSizeMode: true
        };

        COO_CERT_SEARCH_POPUP.grid_COO_CERT_SEARCH_POPUP_01 =
            KpackageOBJ.auiGrid.create("oAuiGrid_COO_CERT_SEARCH_POPUP_01", columnLayout, gridProps, "check");

        // 체크박스 1건만 선택되도록 제어
        AUIGrid.bind(COO_CERT_SEARCH_POPUP.grid_COO_CERT_SEARCH_POPUP_01, "rowCheckClick", function(event) {
            if (!event) {
                return;
            }

            // 현재 클릭한 행만 체크 유지
            var rowIdField = event.item && event.item._$uid ? event.item._$uid : null;

            if (rowIdField) {
                AUIGrid.setCheckedRowsByIds(COO_CERT_SEARCH_POPUP.grid_COO_CERT_SEARCH_POPUP_01, [rowIdField]);
            }
        });

        // 행 더블클릭 시에도 체크 기반으로 선택 처리
        AUIGrid.bind(COO_CERT_SEARCH_POPUP.grid_COO_CERT_SEARCH_POPUP_01, "cellDoubleClick", function(event) {
            var item = event.item;
            if (!item) {
                return;
            }

            if (item._$uid) {
                AUIGrid.setCheckedRowsByIds(COO_CERT_SEARCH_POPUP.grid_COO_CERT_SEARCH_POPUP_01, [item._$uid]);
            }

            COO_AUDIT_DOC.returnCheckedRow(item);
        });
        
        AUIGrid.bind(COO_CERT_SEARCH_POPUP.grid_COO_CERT_SEARCH_POPUP_01, "ready", function (event) {
        	var list = AUIGrid.getGridData(COO_CERT_SEARCH_POPUP.grid_COO_CERT_SEARCH_POPUP_01) || [];
            $("#cooCertifyPipup_total_count").text(list.length.toLocaleString());
		});

        setTimeout(function() {
            $(window).trigger("resize");
        }, 200);
    };

    this.retrieveGridData = function() {
        var params = KpackageOBJ.data.makePostData("COO_CERT_SEARCH_POPUP-form");

        KpackageOBJ.auiGrid.retrieve(
            COO_CERT_SEARCH_POPUP.grid_COO_CERT_SEARCH_POPUP_01,
            "/inspection/retrieveCooCertSearchPopupList",
            params
        );
    };

    this.selectRow = function() {
        this.returnCheckedRow();
    };

    this.returnCheckedRow = function() {
        var checkedItems = AUIGrid.getCheckedRowItems(COO_CERT_SEARCH_POPUP.grid_COO_CERT_SEARCH_POPUP_01);

        if (!checkedItems || checkedItems.length === 0) {
            alert("선택된 데이터가 없습니다.");
            return;
        }

        var item = checkedItems[0].item ? checkedItems[0].item : checkedItems[0];
        COO_AUDIT_DOC.returnCheckedRow(item);
        //console.log("선택", item);
    };

    this.openCustomerSearch = function() {
        // TODO
    };

    this.openProductSearch = function() {
        // TODO
    };
};

$(document).ready(function() {
    COO_CERT_SEARCH_POPUP.Initialize_viewObject();
});
</script>
</body>
</html>