<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>원산지확인서 발급 대상 조회</title>
<style>
    .issue-badge {
        display: inline-block;
        min-width: 58px;
        padding: 0px 12px;
        border-radius: 7px;
        font-size: 12px;
        font-weight: 700;
        text-align: center;
        line-height: 1.5rem !important;
    }

    .issue-badge-issued {
        background-color: #d1f7dd;
        color: #198754;
        border: 1px solid #a8ebbe;
    }

    .issue-badge-modified {
        background-color: #ffe1e3;
        color: #dc3545;
        border: 1px solid #f5b5bc;
    }

    .issue-badge-not-issued {
        background-color: #fff3cd;
        color: #dc3545;
        border: 1px solid #ffe08a;
    }

    .issue-badge-default {
        background-color: #e9ecef;
        color: #495057;
        border: 1px solid #ced4da;
    }

    .issue-link-badge {
        display: inline-block;
        padding: 0px 12px;
        border-radius: 7px;
        font-size: 12px;
        font-weight: 700;
        color: #0d6efd;
        background-color: #e7f1ff;
        border: 1px solid #b6d4fe;
        text-decoration: none;
        cursor: pointer;
        line-height: 1.5rem !important;
    }

    .issue-link-badge:hover {
        background-color: #dbeafe;
        color: #0a58ca;
        text-decoration: underline;
    }

    .aui-center {
        text-align: center !important;
    }
</style>
</head>
<body>
<div class="content-wrapper">
    <div class="row">
		<div class="content-wrapper col-3">
            <h1 class="subheader-title mb-1">확인서 발급</h1>
            <nav class="app-breadcrumb" aria-label="breadcrumb">
                <ol class="breadcrumb ms-0 text-muted mb-0">
                    <li class="breadcrumb-item">Home</li>
                    <li class="breadcrumb-item">FTA C/O 발급</li>
                    <li class="breadcrumb-item active" aria-current="page">확인서 발급</li>
				</ol>
			</nav>
		</div>
		<div class="row col-9">
			<div class="col-2 d-sm-flex align-items-center mb-3">
			</div>
			<div class="col-2 d-sm-flex align-items-center mb-3">
			</div>
			<div class="col-2 d-sm-flex align-items-center mb-3">
				<div class="p-2 me-2 me-xl-3 me-xxl-3 bg-warning-300 rounded">
			    	<i class="sa sa-layers" style="color: #FFF;font-size: 1.55rem;"> </i>
			    </div>
			    <div class="d-flex flex-column align-items-start justify-content-center">
			        <label class="fs-xs mb-0">Total Count</label>
			        <h5 id="totalCount" class="fw-bold mb-0">--</h5>
	 		   </div>
			</div>
			<div class="col-2 d-sm-flex align-items-center mb-3">
				<div class="p-2 me-2 me-xxl-3 bg-success-300 rounded">
	                <i class="sa sa-layers" style="color: #FFF;font-size: 1.55rem;"> </i>
                </div>
                <div class="d-flex flex-column align-items-start justify-content-center">
                    <label class="fs-xs mb-0">발급</label>
                    <h5 id="issued" class="fw-bold mb-0">--</h5>
                </div>
			</div>
			<div class="col-2 d-sm-flex align-items-center mb-3">
				<div class="p-2 me-2 me-xxl-3 bg-primary-300 rounded">
					<i class="sa sa-layers" style="color: #FFF;font-size: 1.55rem;"> </i>
				</div>
				<div class="d-flex flex-column align-items-start justify-content-center">
				    <label class="fs-xs mb-0">수정 발급</label>
				    <h5 id="modified" class="fw-bold mb-0">--</h5>
				</div>
			</div>		
			<div class="col-2 d-sm-flex align-items-center mb-3">
				<div class="p-2 me-2 me-xxl-3 bg-info-300 rounded">
					<i class="sa sa-layers" style="color: #FFF;font-size: 1.55rem;"> </i>
				</div>
				<div class="d-flex flex-column align-items-start justify-content-center">
				    <label class="fs-xs mb-0">미발급</label>
				    <h5 id="not_issued" class="fw-bold mb-0">--</h5>
				</div>
			</div>	
		</div>
    </div>
    <!-- 검색 조건 -->
    <div class="row">
    	<form:form id="ISSUE_TARGET-form" class="s4-form" novalidate="novalidate" action="" method="post">
	    	<div id="panel-4" class="panel panel-icon">
	    		<div class="panel-container show">
					<div class="panel-content">
			            <div class="row">
                            <div class="col-3">
                                <div class="row mb-3">
                                	<div class="col-6">
	                                	<label class="form-label fw-700 mb-1" for="from_yyyymm">매출 From</label>
	                        			<input type="month" class="form-control" id="from_yyyymm" name="from_yyyymm">
                                    </div>
                                    <div class="col-6">
	                                    <label class="form-label fw-700 mb-1" for="to_yyyymm">매출 To</label>
		                      		  	<input type="month" class="form-control" id="to_yyyymm" name="to_yyyymm">
   	                               </div>
                                </div>
                            </div>
                            <div class="col-2">
                                <div class="mb-3">
                                    <!-- <label class="form-label" for="example-select"> </label> -->
                                    <!-- 기간 버튼 -->
				                    <div class="btn-group w-100" role="group" style="margin-top: 5px;">
			                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="ISSUE_TARGET.setMonthRange(0);">1 Month</button>
			                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="ISSUE_TARGET.setMonthRange(3);">3 Month</button>
			                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="ISSUE_TARGET.setMonthRange(6);">6 Month</button>
			                        </div>
                                </div>
                            </div>
                            
                            <div class="col-3">
						        <label class="form-label fw-700" for="search_customer">고객사</label>
						        <div class="input-group input-btn-search-group">
						            <input type="text" class="form-control" id="search_customer" name="search_customer" value="1138122221" placeholder="">
						            <button type="button" class="btn btn-info shadow-0 waves-effect waves-themed" onclick="ISSUE_TARGET.fnOpenCompop('customer_code');">
						                <i class="sa sa-magnifier"></i>
						            </button>
						        </div>
						    </div>
                            <div class="col-3">
						        <label class="form-label fw-700" for="search_customer">플랜트</label>
						        <div class="input-group input-btn-search-group">
						            <input type="text" class="form-control" id="search_division" name="search_division" value="FRT101" placeholder="">
						            <button type="button" class="btn btn-info shadow-0 waves-effect waves-themed" onclick="ISSUE_TARGET.fnOpenCompop('division_code');">
						                <i class="sa sa-magnifier"></i>
						            </button>
						        </div>
						    </div>
                            <div class="col">
                               	<button type="button" onclick="javascript:ISSUE_TARGET.retrieve_GridData();" class="btn btn-sm btn-search search-more waves-effect waves-themed">Search</button>
                               	<button type="button" onclick="javascript:toggleSearchMore(this,'ISSUE_TARGET_SEARCHMORE');" class="btn btn-xs btn-search-more waves-effect waves-themed">More</button>
                            </div>
                        </div>
                        <div class="row" id="ISSUE_TARGET_SEARCHMORE" style="display: none;">
                        	<div class="col-2">
                            	<label class="form-label fw-700 mb-1" for="search_status">발급구분</label>
		                        <select class="form-select" id="search_status" name="search_status">
		                            <option value="">ALL</option>
		                            <option value="ISSUED">발급</option>
		                            <option value="MODIFIED">수정</option>
		                            <option value="NOT_ISSUED">미발급</option>
		                        </select>
                            </div>
							<div class="col-5">
                            	<div class="row">
                            		<label class="form-label" for="example-input-border">키워드 검색</label>
                            	</div>
                                <div class="row mb-3">
                                	<div class="col-3">
                                		<select class="form-select" id="search_type" name="search_type">
                                            <option value="ITEM_CODE">품번</option>
                                            <option value="CUSTOMER_MODEL">고객사 품번</option>
                                            <option value="COO_CERTIFY_NO">원산지확인서번호</option>
                                        </select>
                                	</div>
                                	<div class="col">
                                		<input type="text" id="search_keyword" name="search_keyword" class="form-control" placeholder="Search keyword" value="11588322">
                                	</div>
                                    
                                </div>
                            </div>
                                             
						</div>
				    </div>		    		
	    		</div>
			</div>
		</form:form>
    </div>
    <div class="row">
    	<div class="col-7">
    	</div>
    	<div class="col-5">
			<div class="frame-wrap">
			    <div class="demo" style="text-align: right;">
			    	<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="javascript:ISSUE_TARGET.openCooIssueDialog();">
			            확인서 발급
			        </button>
			    </div>
			</div>
    	</div>
    </div>

    <!-- 그리드 -->
    <div class="row">
        <div class="col-12">
            <div id="oAuiGrid_ISSUE_TARGET_01" style="width:100%; height:520px; margin:0 auto;"></div>
        </div>
    </div>
	<div id="issueStatusPopover" class="issue-status-popover" style="display:none;"></div>
</div>
</body>

<script>
var ISSUE_TARGET = new function() {

    this.grid_ISSUE_TARGET_01 = null;

    this.Initialize_viewObject = function() {
    	/*우측 상단 차트 생성 */
		KpackageOBJ.perityChart.create("span.peity-bar", "bar");
		this.setDefaultMonth();
        ISSUE_TARGET.createAUIGrid();
    };
    
    
    this.setDefaultMonth = function() {
        const today = new Date();
        const yyyy = today.getFullYear();
        const mm = String(today.getMonth() + 1).padStart(2, "0");
        const currentMonth = yyyy + "-" + mm;

        KpackageOBJ.object.setFormValue("ISSUE_TARGET-form", "from_yyyymm", currentMonth);
        KpackageOBJ.object.setFormValue("ISSUE_TARGET-form", "to_yyyymm", currentMonth);
    };
    
    this.setMonthRange = function(monthCount) {
    	let fromValue = KpackageOBJ.object.getFormValue("ISSUE_TARGET-form", "from_yyyymm");

        // from 값이 없으면 현재월 기준
        let baseDate;
        if (fromValue) {
            const arr = fromValue.split("-");
            baseDate = new Date(Number(arr[0]), Number(arr[1]) - 1, 1);
        } else {
            const today = new Date();
            baseDate = new Date(today.getFullYear(), today.getMonth(), 1);
        }

        // to 는 기준월(from 값)
        const toDate = new Date(baseDate.getFullYear(), baseDate.getMonth(), 1);
        const fromDate = new Date(baseDate.getFullYear(), baseDate.getMonth(), 1);

        if (monthCount > 0) {
            fromDate.setMonth(fromDate.getMonth() - (monthCount - 1));
        }

        const fromY = fromDate.getFullYear();
        const fromM = String(fromDate.getMonth() + 1).padStart(2, "0");

        const toY = toDate.getFullYear();
        const toM = String(toDate.getMonth() + 1).padStart(2, "0");

        KpackageOBJ.object.setFormValue("ISSUE_TARGET-form", "from_yyyymm", fromY + "-" + fromM);
        KpackageOBJ.object.setFormValue("ISSUE_TARGET-form", "to_yyyymm", toY + "-" + toM);
    };

    
    this.showIssueStatusPopover = function(pageX, pageY, reason) {
        const $popover = $("#issueStatusPopover");

        $popover.html(
            '<div class="issue-status-popover-title">수정발급 사유</div>' +
            '<div>- ' + reason + '</div>'
        );

        $popover.css({
            display: "block",
            left: (pageX + 10) + "px",
            top: (pageY + 10) + "px"
        });
    };

    this.hideIssueStatusPopover = function() {
        $("#issueStatusPopover").hide();
    };
    
    
    this.createAUIGrid = function() {
        const columnLayout = [
            {
                dataField: "division_name",
                headerText: "플랜트",
                width: 120,
                style: "aui-center"
            },
            {
                dataField: "yyyymm",
                headerText: "매출월",
                width: 100,
                style: "aui-center",
                labelFunction: function(rowIndex, columnIndex, value) {
                    if (!value) return "";
                    if (String(value).length === 6) {
                        return value.substring(0, 4) + "-" + value.substring(4, 6);
                    }
                    return value;
                }
            },
            {
                dataField: "customer_name",
                headerText: "고객사",
                width: 130
            },
            {
                dataField: "product_code",
                headerText: "품번",
                width: 150,
                style: "aui-center"
            },
            {
                dataField: "product_name",
                headerText: "품명",
                width: 150
            },
            {
                dataField: "hs_code",
                headerText: "HS CODE",
                width: 100,
                style: "aui-center"
            },
            {
                dataField: "issue_status_name",
                headerText: "발급상태",
                width: 120,
                renderer: {
                    type: "TemplateRenderer"
                },
                labelFunction: function(rowIndex, columnIndex, value, headerText, item) {
                    let cls = "badge bg-secondary";
                    if (item.issue_status === "ISSUED") cls = "badge bg-success";
                    else if (item.issue_status === "MODIFIED") cls = "badge bg-danger";
                    else if (item.issue_status === "NOT_ISSUED") cls = "badge bg-warning";

                    return '<span class="' + cls + '">' + (value || '') + '</span>';
                },
                style: "aui-center"
            },
            {
                dataField: "coo_certify_no",
                headerText: "발급번호",
                width: 140,
                renderer: {
                    type: "TemplateRenderer"
                },
                labelFunction: function(rowIndex, columnIndex, value) {
                    if (!value) return "";
                    return '<span class="issue-link-badge">' + value + '</span>';
                },
                style: "aui-center"
            },
            { dataField: "modify_issue_reason", headerText: "수정발급 사유", visible: false, width: 180 },
            { dataField: "customer_code", headerText: "고객사코드", visible: false, width: 130 },
            { dataField: "issue_status", headerText: "발급상태", visible: false, width: 120 },
            { dataField: "invoice_date", headerText: "sales_no", visible: false, width: 120 },
            { dataField: "sales_no", headerText: "sales_no", visible: false, width: 120 },
            { dataField: "sales_seq", headerText: "sales_seq", visible: false, width: 120 }
        ];

        const gridProps = {
            usePaging: false,
            //pageRowCount: 50,
            //showPageRowSelect: true,
            enableFilter: true,
            editable: false,
            selectionMode: "multipleRows",
            showRowNumColumn: false,
            fillColumnSizeMode: true
        };

        ISSUE_TARGET.grid_ISSUE_TARGET_01 =
            KpackageOBJ.auiGrid.create("oAuiGrid_ISSUE_TARGET_01", columnLayout, gridProps, "check");

        AUIGrid.bind(ISSUE_TARGET.grid_ISSUE_TARGET_01, "cellClick", function(event) {

            // 발급번호 클릭 -> 상세 팝업
            if (event.dataField === "coo_certify_no" && event.value) {
                ISSUE_TARGET.hideIssueStatusPopover();
                var getParam = "?coo_certify_no=" + encodeURIComponent(event.item.coo_certify_no) + "&customer_code=" + encodeURIComponent(event.item.customer_code);
                KpackageOBJ.sidepanel.open('cooIssueDetailPopup','/issuecover/cooIssueCoverDetail' + getParam, '1300px', true);
                return;
            }
        });
        
        /* 데이터 로드가 완료되면 */
        AUIGrid.bind(ISSUE_TARGET.grid_ISSUE_TARGET_01, "ready", function (event) {
        	var gridDataList = KpackageOBJ.auiGrid.getGridData(ISSUE_TARGET.grid_ISSUE_TARGET_01);
        	ISSUE_TARGET.setTopSummary(gridDataList);
        	
        });
        
        
    };
    
    /*
    * 확인서 발급
    */
    this.openCooIssueDialog = function(){
    	
    	var selectedItems = AUIGrid.getCheckedRowItems(ISSUE_TARGET.grid_ISSUE_TARGET_01);
    	var rowItems = [];
    	if (selectedItems) {
            for (var i = 0; i < selectedItems.length; i++) {
                if (selectedItems[i].item) {
                    rowItems.push(selectedItems[i].item);
                }
            }
        }

        if (rowItems.length === 0) {
            alert("발급할 대상을 선택해주세요.");
            return;
        }
        
        var baseCustomerCode = rowItems[0].customer_code;

        for (var i = 0; i < rowItems.length; i++) {
            if (rowItems[i].customer_code !== baseCustomerCode) {
                alert("같은 고객사끼리만 선택할 수 있습니다.");
                return;
            }
            
            if (rowItems[i].issue_status !== "NOT_ISSUED") {
                alert("미발급 상태의 데이터만 선택할 수 있습니다.");
                return;
            }
        }
        
        var getParam = "?dialog_id="           + "cooIssueForm"
           + "&opener_pgm_id="    +  "ISSUE_TARGET" 
           + "&opener_target_grid_id=" + "grid_ISSUE_TARGET_01"
           + "&customer_code="    +  baseCustomerCode;
    	
        KpackageOBJ.sidepanel.open('cooIssueCoverForm','/issuecover/cooIssueCoverForm' + getParam, '1300px', true);
    }
    
    this.retrieve_GridData = function() {
        var fromYyyymm    = KpackageOBJ.object.getFormValue("ISSUE_TARGET-form", "from_yyyymm");
        var toYyyymm      = KpackageOBJ.object.getFormValue("ISSUE_TARGET-form", "to_yyyymm");
        var customerCode  = KpackageOBJ.object.getFormValue("ISSUE_TARGET-form", "search_customer");
        var divisionCode  = KpackageOBJ.object.getFormValue("ISSUE_TARGET-form", "search_division");
        var searchStatus  = KpackageOBJ.object.getFormValue("ISSUE_TARGET-form", "search_status");
        var searchType    = KpackageOBJ.object.getFormValue("ISSUE_TARGET-form", "search_type");
        var searchKeyword = KpackageOBJ.object.getFormValue("ISSUE_TARGET-form", "search_keyword");

        // 필수값 체크
        if (!fromYyyymm) {
            alert("매출 From은 필수입니다.");
            $("#from_yyyymm").focus();
            return;
        }

        if (!toYyyymm) {
            alert("매출 To는 필수입니다.");
            $("#to_yyyymm").focus();
            return;
        }

        if (!customerCode) {
            alert("고객사는 필수입니다.");
            $("#search_customer").focus();
            return;
        }

        if (!divisionCode) {
            alert("플랜트는 필수입니다.");
            $("#search_division").focus();
            return;
        }

        if (fromYyyymm > toYyyymm) {
            alert("매출 From은 매출 To보다 클 수 없습니다.");
            $("#from_yyyymm").focus();
            return;
        }

        if (searchKeyword && !searchType) {
            alert("키워드 검색 유형을 선택해주세요.");
            $("#search_type").focus();
            return;
        }

        var params = {
            from_yyyymm: fromYyyymm,
            to_yyyymm: toYyyymm,
            customer_code: customerCode,
            division_code: divisionCode,
            issue_status: searchStatus,
            search_type: searchType,
            search_keyword: searchKeyword
        };

        KpackageOBJ.auiGrid.retrieve(ISSUE_TARGET.grid_ISSUE_TARGET_01,"/issuecover/retrieveCooIssueCoverList",params);
    };
    
    this.setTopSummary = function(list) {
        var totalCount = 0;
        var issuedCount = 0;
        var modifiedCount = 0;
        var notIssuedCount = 0;

        if (list && list.length > 0) {
            totalCount = list.length;

            for (var i = 0; i < list.length; i++) {
                var row = list[i];

                if (row.issue_status === "ISSUED") {
                    issuedCount++;
                } else if (row.issue_status === "MODIFIED") {
                    modifiedCount++;
                } else if (row.issue_status === "NOT_ISSUED") {
                    notIssuedCount++;
                }
            }
        }

        $("#totalCount").text(ISSUE_TARGET.numberWithComma(totalCount));
        $("#issued").text(ISSUE_TARGET.numberWithComma(issuedCount));
        $("#modified").text(ISSUE_TARGET.numberWithComma(modifiedCount));
        $("#not_issued").text(ISSUE_TARGET.numberWithComma(notIssuedCount));
    };
    
    /* 천단위 콤마 */
    this.numberWithComma = function(value) {
        if (value == null || value === "") {
            return "0";
        }
        return String(value).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    };
    
    
    this.fnOpenCompop = function(colGubn, bAutoSearch = false ) {
	    let callbackFunctionName = "";
	    let searchText = "";
	    let popGubn = "";
	    let data = {};
	    
	    switch (colGubn) {
	    	case "division_code":
				popGubn = "DIVISION";
	    	    callbackFunctionName = "setComDivisionPopupData";
	    	    data = {
	    	    	"searchText": KpackageOBJ.object.getFormValue("ISSUE_TARGET-form", "search_division")
		        };
	            break;    
	    	case "customer_code":
				popGubn = "CUSTOMER";
	    	    callbackFunctionName = "setComCustomerPopupData";
	    	    data = {
	    	    	"searchText": KpackageOBJ.object.getFormValue("ISSUE_TARGET-form", "search_customer")
		        };
	            break;    
	    	 default:
	    		 return;
	    }
	    
	    
	    KpackageOBJ.dialog.openCommonPop(popGubn, {
	        callbackObject: "ISSUE_TARGET",
	        callbackFunctionName: callbackFunctionName,
	        bAutoSearch: bAutoSearch,
	        data: data
	    });
	};
	
	//사업장코드 팝업 세팅
    this.setComDivisionPopupData = function(selectedData) {
		KpackageOBJ.object.setFormValue("ISSUE_TARGET-form", "search_division", selectedData["code"]);  
	};
    
    this.setComCustomerPopupData = function(selectedData) {
    	KpackageOBJ.object.setFormValue("ISSUE_TARGET-form", "search_customer", selectedData["code"]);  
	};
};

$(document).ready(function() {
    pageSetUp();
    ISSUE_TARGET.Initialize_viewObject();
});
$(document).on("click", function(e) {
    if (!$(e.target).closest("#issueStatusPopover").length) {
        ISSUE_TARGET.hideIssueStatusPopover();
    }
});
</script>
</html>