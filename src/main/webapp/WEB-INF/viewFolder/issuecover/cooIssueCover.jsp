<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>원산지확인서 발급 대상 조회</title>
    <style type="text/css">
    .input-btn-search-group .form-control {
	    height: 35px !important;
	}
	
	.input-btn-search-group button {
	    height: 35px !important;
	    min-width: 54px;
	    padding: 0 !important;
	    display: flex;
	    align-items: center;
	    justify-content: center;
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
			    	<span class="peity-bar"
			    	      data-peity="{ &quot;fill&quot;: [&quot;#fff&quot;], &quot;width&quot;: 27, &quot;height&quot;: 27 }">3,4,5,8,2</span>
			    </div>
			    <div class="d-flex flex-column align-items-start justify-content-center">
			        <label class="fs-xs mb-0">Bounce Rate</label>
			        <h5 class="fw-bold mb-0">37.56%</h5>
	 		   </div>
			</div>
			<div class="col-2 d-sm-flex align-items-center mb-3">
				<div class="p-2 me-2 me-xxl-3 bg-success-300 rounded">
	                <span class="peity-bar"
	                      data-peity="{ &quot;fill&quot;: [&quot;#fff&quot;], &quot;width&quot;: 27, &quot;height&quot;: 27 }">16,4,7,5,6</span>
                </div>
                <div class="d-flex flex-column align-items-start justify-content-center">
                    <label class="fs-xs mb-0">Clickthrough</label>
                    <h5 class="fw-bold mb-0">19.77%</h5>
                </div>
			</div>
			<div class="col-2 d-sm-flex align-items-center mb-3">
				<div class="p-2 me-2 me-xxl-3 bg-primary-300 rounded">
					<span class="peity-bar" 
					      data-peity="{ &quot;fill&quot;: [&quot;#fff&quot;], &quot;width&quot;: 27, &quot;height&quot;: 27 }">3,4,3,5,5</span>
				</div>
				<div class="d-flex flex-column align-items-start justify-content-center">
				    <label class="fs-xs mb-0">New Sessions</label>
				    <h5 class="fw-bold mb-0">12.17%</h5>
				</div>
			</div>		
			<div class="col-2 d-sm-flex align-items-center mb-3">
				<div class="p-2 me-2 me-xxl-3 bg-info-300 rounded">
					<span class="peity-bar" 
					      data-peity="{ &quot;fill&quot;: [&quot;#fff&quot;], &quot;width&quot;: 27, &quot;height&quot;: 27 }">5,3,1,7,9</span>
				</div>
				<div class="d-flex flex-column align-items-start justify-content-center">
				    <label class="fs-xs mb-0">Actual Sessions</label>
				    <h5 class="fw-bold mb-0">56.34%</h5>
				</div>
			</div>	
		</div>
    </div>
    <!-- 검색 조건 -->
    <div class="row">
    	<form:form id="SAMPLE001-form" class="s4-form" novalidate="novalidate" action="" method="post">
	    	<div id="panel-4" class="panel panel-icon">
	    		<div class="panel-container show">
					<div class="panel-content">
			            <div class="row">
                            <div class="col-3">
                                <div class="row mb-3">
                                	<div class="col-6">
	                                	<label class="form-label fw-700 mb-1" for="search_from">매출 From</label>
	                        			<input type="month" class="form-control" id="search_from" name="search_from">
                                    </div>
                                    <div class="col-6">
	                                    <label class="form-label fw-700 mb-1" for="search_to">매출 To</label>
		                      		  	<input type="month" class="form-control" id="search_to" name="search_to">
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
                            <div class="col-2">
                            	<label class="form-label fw-700 mb-1" for="search_status">발급구분</label>
		                        <select class="form-select" id="search_status" name="search_status">
		                            <option value="">ALL</option>
		                            <option value="ISSUED">발급</option>
		                            <option value="MODIFIED">수정</option>
		                            <option value="NOT_ISSUED">미발급</option>
		                        </select>
                            </div>
                            <div class="col-2">
						        <label class="form-label fw-700" for="search_customer">고객사</label>
						        <div class="input-group input-btn-search-group">
						            <input type="text" class="form-control" id="search_customer" name="search_customer" placeholder="">
						            <button type="button" class="btn btn-info shadow-0 waves-effect waves-themed" onclick="ISSUE_TARGET.fnCheckCustomer();">
						                <i class="sa sa-magnifier"></i>
						            </button>
						        </div>
						    </div>
                            <div class="col-2">
						        <label class="form-label fw-700" for="search_customer">플랜트</label>
						        <div class="input-group input-btn-search-group">
						            <input type="text" class="form-control" id="search_division" name="search_division" placeholder="">
						            <button type="button" class="btn btn-info shadow-0 waves-effect waves-themed" onclick="ISSUE_TARGET.fnCheckCustomer();">
						                <i class="sa sa-magnifier"></i>
						            </button>
						        </div>
						    </div>
                            <div class="col">
                               	<button type="button" onclick="javascript:SAMPLE001.retrieve_GridData();" class="btn btn-sm btn-search search-more waves-effect waves-themed">Search</button>
                               	<button type="button" onclick="javascript:toggleSearchMore(this,'ISSUE_TARGET_SEARCHMORE');" class="btn btn-xs btn-search-more waves-effect waves-themed">More</button>
                            </div>
                        </div>
                        <div class="row" id="ISSUE_TARGET_SEARCHMORE" style="display: none;">
							<div class="col-3">
						        <label class="form-label fw-700" for="search_customer">플랜트</label>
						        <div class="input-group input-btn-search-group">
						            <input type="text" class="form-control" id="search_division" name="search_division" placeholder="">
						            <button type="button" class="btn btn-info shadow-0 waves-effect waves-themed" onclick="ISSUE_TARGET.fnCheckCustomer();">
						                <i class="sa sa-magnifier"></i>
						            </button>
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
			<div class="ms-auto d-none d-sm-flex align-items-center ">
                <div class="d-flex align-items-center">
                    <div class="d-none d-md-inline-flex">
                        <span class="peity-donut 
                        			d-none" data-peity="{ &quot;fill&quot;: [&quot;var(--success-300)&quot;], &quot;height&quot;: 34, &quot;width&quot;: &quot;34&quot; }" style="display: none;">5, 3</span>
                    </div>
                    <div class="d-inline-flex flex-column justify-content-center ms-2">
                        <span class="fw-500 fs-xs d-block">
                            <small>조회된 데이터기준</small>
                        </span>
                        <span class="fw-500 fs-xl d-flex align-items-center text-success"> 50% <svg class="sa-icon sa-bold sa-icon-success ms-1">
                                <use href="img/sprite.svg#trending-up"></use>
                            </svg>
                        </span>
                    </div>
                </div>
                <div class="d-flex align-items-center border-faded border-dashed border-top-0 border-bottom-0 border-end-0 ms-3 ps-3">
                    <div class="d-none d-md-inline-flex">
                        <span class="peity-line
                        			 d-none" data-peity="{ &quot;fill&quot;: [&quot;var(--danger-500)&quot;], &quot;height&quot;: 34, &quot;width&quot;: &quot;34&quot; }" style="display: none;">1,9,3,5,10</span>
                    </div>
                    <div class="d-inline-flex flex-column justify-content-center ms-2">
                        <span class="fw-500 fs-xs d-block">
                            <small>Bounce Rate</small>
                        </span>
                        <span class="fw-500 fs-xl d-flex align-items-center text-danger"> 10% <svg class="sa-icon sa-bold ms-1 sa-icon-danger">
                                <use href="img/sprite.svg#trending-down"></use>
                            </svg>
                        </span>
                    </div>
                </div>
            </div>
    	</div>
    	<div class="col-5">
			<div class="frame-wrap">
			    <div class="demo" style="text-align: right;">
			    	<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="javascript:KpackageOBJ.dialog.open('previewPopup','가운데팝업','/sample-001-pop02',1000,700);;">
			            가운데 팝업창(드래그 가능)
			        </button>

			        <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="javascript:KpackageOBJ.sidepanel.open('aaaa','/sample-001-pop01', '1200px');">
			            우측 팝업창 호출하기 
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

        $("#search_from").val(currentMonth);
        $("#search_to").val(currentMonth);
    };
    
    this.setMonthRange = function(monthCount) {
        let fromValue = $("#search_from").val();

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

        $("#search_from").val(fromY + "-" + fromM);
        $("#search_to").val(toY + "-" + toM);
    };

    this.createAUIGrid = function() {
        const columnLayout = [
            { dataField: "division_name", headerText: "플랜트", width: 120 },
            { dataField: "yyyymm", headerText: "매출월", width: 100 },
            { dataField: "customer_name", headerText: "고객사", width: 130 },
            { dataField: "customer_code", headerText: "고객사", width: 130 },
            { dataField: "product_code", headerText: "품번", width: 150 },
            { dataField: "product_name", headerText: "품명", width: 150 },
            { dataField: "hs_code", headerText: "HS CODE", width: 100 },
            { dataField: "issue_status", headerText: "발급상태", width: 120 },
            { dataField: "remark", headerText: "수정발급 사유", width: 180 },
            { dataField: "coo_certify_no", headerText: "발급번호", width: 80 }
        ];

        const gridProps = {
            usePaging: true,
            pageRowCount: 50,
            showPageRowSelect: true,
            enableFilter: true,
            editable: false,
            selectionMode: "multipleRows",
            showRowNumColumn: false
        };

        ISSUE_TARGET.grid_ISSUE_TARGET_01 =
            KpackageOBJ.auiGrid.create("oAuiGrid_ISSUE_TARGET_01", columnLayout, gridProps, "check");

        AUIGrid.bind(ISSUE_TARGET.grid_ISSUE_TARGET_01, "cellClick", function(event) {
            console.log("cellClick", event);
        });

        AUIGrid.bind(ISSUE_TARGET.grid_ISSUE_TARGET_01, "cellDoubleClick", function(event) {
            console.log("cellDoubleClick", event);
        });
    };

    this.retrieve_GridData = function() {
        var params = {
            search_year: $("#search_year").val(),
            search_month: $("#search_month").val(),
            search_status: $("#search_status").val(),
            search_customer_code: $("#search_customer_code").val(),
            search_division_code: $("#search_division_code").val(),
            search_product_code: $("#search_product_code").val(),
            search_product_name: $("#search_product_name").val(),
            search_hs_code: $("#search_hs_code").val()
        };

        KpackageOBJ.auiGrid.retrieve(
            ISSUE_TARGET.grid_ISSUE_TARGET_01,
            "/sample/retrieveIssueTargetList",
            params
        );
    };
};

$(document).ready(function() {
    pageSetUp();
    ISSUE_TARGET.Initialize_viewObject();
});
</script>
</html>