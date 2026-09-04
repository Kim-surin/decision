<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>확인서 발급</title>
    <style>
    .aui-row-checked {
        background-color: #eaf3ff !important;
    }
</style>
</head>
<body>
    <div class="modal-header py-2 px-3">
	    <h5 class="modal-title fs-5 fw-semibold mb-0">확인서 발급</h5>
	    <button type="button" class="btn btn-sm btn-system ms-auto p-1" data-bs-dismiss="modal" aria-label="Close">
	        <svg class="sa-icon" style="width: 1rem; height: 1rem;">
	            <use href="/rcs/ui5x/img/sprite.svg#x"></use>
	        </svg>
	    </button>
	</div>

    <div class="modal-body">
        <form:form id="COO_ISSUE_POPUP-form" method="post" action="" novalidate="novalidate">
            <input type="hidden" id="dialog_id" name="dialog_id" value="${dialog_id}"/>
            <input type="hidden" id="opener_pgm_id" name="opener_pgm_id" value="${opener_pgm_id}"/>
            <input type="hidden" id="opener_target_grid_id" name="opener_target_grid_id" value="${opener_target_grid_id}"/>
            <input type="hidden" id="customer_code" name="customer_code" value="${customer_code}"/>
            <!-- 원산지 확인서 기본값 설정 -->
            <input type="hidden" id="issue_type" name="issue_type" value="E"/> <!-- 원산지확인서는 E -->
            <input type="hidden" id="export_flag" name="export_flag" value="D"/>
            <input type="hidden" id="coo_type" name="coo_type" value="C"/>
            <input type="hidden" id="fta_category" name="fta_category" value="CA01"/>

            <div class="card border-0 shadow-sm" style="background-color: #f5f5f5;">
                <div class="card-body p-0">
                    <div class="row g-0 align-items-stretch">
                        <div class="col-md-5">
                            <div class="d-flex align-items-center h-100 px-4 py-4 border-end">
                                <div class="d-flex align-items-center justify-content-center rounded-circle border border-2 flex-shrink-0"
                                     style="width: 64px; height: 64px; color: #666; border-color: #666 !important;">
                                    <i class="sa sa-info fs-1"></i>
                                </div>

                                <div class="ms-3">
                                    <div class="fw-semibold mb-1" style="color: #8c73c9; font-size: 1.35rem; line-height: 1.2;">
                                        <span id="customer_name">customer_name</span>
                                    </div>
                                    <div class="text-secondary" style="font-size: 1rem; line-height: 1.3;">
                                        <span id="officer_name">officer_name</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-7">
                            <div class="px-4 py-4 h-100 d-flex flex-column justify-content-center">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <div class="d-flex align-items-center text-secondary" style="font-size: 1rem;">
                                            <i class="sa sa-phone me-2"></i>
                                            <span id="tel_no">tel_no</span>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="d-flex align-items-center" style="font-size: 1rem; color: #8c73c9;">
                                            <i class="sa sa-envelope me-2 text-secondary"></i>
                                            <span id="email">email</span>
                                        </div>
                                    </div>

                                    <div class="col-12">
                                        <div class="d-flex align-items-start text-secondary" style="font-size: 1rem;">
                                            <i class="sa sa-map-marker me-2 mt-1"></i>
                                            <span id="address">address</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card border-0 shadow-sm mb-3 mt-3">
                <div class="card-body p-3">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div>
                            <h6 class="fw-bold mb-0">발급 정보</h6>
                            <div class="text-secondary small">확인서 발급 기본정보</div>
                        </div>
                        <div class="d-flex gap-2">
			                <button type="button" class="btn btn-outline-primary btn-sm px-4" onclick="COO_ISSUE_POPUP.issueConfirm();">
			                    발급
			                </button>
			            </div>
                    </div>

                    <div class="row g-2 align-items-end">
                        <div class="col-4">
                            <div class="border rounded-3 p-2 bg-light-subtle h-100">
                                <label for="coo_certify_no" class="form-label fw-semibold small mb-1">원산지증명번호</label>
                                <div class="d-flex align-items-center gap-2">
                                    <div class="input-group input-group-sm">
                                        <input type="text" id="coo_certify_no" name="coo_certify_no" class="form-control">
                                        <button type="button" id="btn_check_duplicate" class="btn btn-outline-secondary" onclick="COO_ISSUE_POPUP.checkDuplicateCertifyNo();">
                                            중복확인
                                        </button>
                                    </div>

                                    <div class="form-check form-switch m-0 flex-shrink-0">
                                        <input class="form-check-input" type="checkbox" id="auto_create_yn" name="auto_create_yn" value="Y" checked>
                                        <label class="form-check-label small ms-1" for="auto_create_yn">자동생성</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-2">
                            <div class="border rounded-3 p-2 h-100">
                                <label for="signature_seq" class="form-label fw-semibold small mb-1">서명권자</label>
                                <select id="signature_seq" name="signature_seq" class="form-select form-select-sm"></select>
                            </div>
                        </div>

                        <div class="col-2">
                            <div class="border rounded-3 p-2 h-100">
                                <label for="issue_date" class="form-label fw-semibold small mb-1">발급일</label>
                                <input type="date" id="issue_date" name="issue_date" class="form-control form-control-sm">
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="border rounded-3 p-2 h-100">
                                <label class="form-label fw-semibold small mb-1">포괄기간</label>
                                <div class="d-flex align-items-center gap-1">
                                    <input type="date" id="cover_from_date" name="cover_from_date" class="form-control form-control-sm">
                                    <span class="text-secondary small">~</span>
                                    <input type="date" id="cover_to_date" name="cover_to_date" class="form-control form-control-sm">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form:form>

        <div class="row">
            <div class="col-12">
                <div id="oAuiGrid_COO_ISSUE_POPUP_01" style="width:100%; height:490px; margin:0 auto;"></div>
            </div>
        </div>
    </div>

	<script>
	    var COO_ISSUE_POPUP = new function() {
	
	        this.grid_COO_ISSUE_POPUP_01 = null;
	        //최초 1회 실행용
	        this.needAutoCheckAfterLoad = false;
	        
	        //중복체크용
	        this.isCertifyNoChecked = false;
	
	        this.Initialize_viewObject = function() {
	            this.bindEvent();
	            this.createAUIGrid();
	            this.setDefaultIssueDate();
	            this.setDefaultValue();
	            this.toggleCertifyNoInput();
	            this.syncCoverPeriodByIssueDate();
	        };
	
	        this.setDefaultIssueDate = function() {
	        	
	        	COO_ISSUE_POPUP.needAutoCheckAfterLoad = true;
	        	
	        	
	            var today = new Date();
	            var yyyy = today.getFullYear();
	            var mm = String(today.getMonth() + 1).padStart(2, "0");
	            var dd = String(today.getDate()).padStart(2, "0");
	
	            $("#issue_date").val(yyyy + "-" + mm + "-" + dd);
	        };
	
	        this.setDefaultValue = function() {
	
	            /* 부모창 체크된 아이템 ArrayList*/
	            var checkedArray = KpackageOBJ.auiGrid.getCheckedRowItems(ISSUE_TARGET.grid_ISSUE_TARGET_01);
	            if (!checkedArray || checkedArray.length === 0) {
	                $("#customer_name").text("N/A");
	                $("#officer_name").text("N/A");
	                $("#tel_no").text("N/A");
	                $("#email").text("N/A");
	                $("#address").text("N/A");
	                return;
	            }
	
	            /* 상단 고객사 정보 조회 */
	            var params = checkedArray[0]["item"];
	
	            let comboParam = {
	                "OPTION_ALL": "Y",
	                "invoice_date": params["invoice_date"]
	            };
	            KpackageOBJ.selectbox.create("COO_ISSUE_POPUP-form", "signature_seq", "/common/retrieveSignatureCombo", comboParam, "code", "name");
	
	            KpackageOBJ.ajax.doSubmit("/issuecover/retrieveCooIssueTargetCustomerInfo", params, (result) => {
	                var value = result.value || {};
	                var data = $.isArray(value) ? (value[0] || {}) : value;
	
	                $("#customer_name").text(data.customer_name || "N/A");
	                $("#officer_name").text(data.officer_name || "N/A");
	                $("#tel_no").text(data.tel_no || "N/A");
	                $("#email").text(data.email || "N/A");
	                $("#address").text(data.address || "N/A");
	            });
	
	            /* 확인서 발급 대상 조회 */
	            var salesList = [];
	
	            for (var i = 0; i < checkedArray.length; i++) {
	                var row = checkedArray[i].item ? checkedArray[i].item : checkedArray[i];
	
	                salesList.push({
	                    salesNo: row.sales_no,
	                    salesSeq: row.sales_seq
	                });
	            }
	
	            var params = {
	                salesList: salesList
	            };
	
	            KpackageOBJ.auiGrid.retrieve(
	                COO_ISSUE_POPUP.grid_COO_ISSUE_POPUP_01,
	                "/issuecover/retrieveCooIssueTargetList",
	                params
	            );
	        };
	
	        this.createAUIGrid = function() {
	            const columnLayout = [
	            	{
	                    dataField: "division_name",
	                    headerText: "플랜트",
	                    width: 100,
	                    style: "aui-center",
	                    headerStyle: "aui-center",
	                    cellMerge: true   // 셀 병합
	                },
	                {
	                    dataField: "fta_name",
	                    headerText: "FTA명",
	                    width: 120,
	                    style: "aui-center",
	                    headerStyle: "aui-center",
	                    cellMerge: true   // 셀 병합
	                },
	                {
	                    dataField: "product_code",
	                    headerText: "제품코드",
	                    width: 130,
	                    style: "aui-center",
	                    headerStyle: "aui-center",
	                    cellMerge: true   // 셀 병합
	                },
	                {
	                    dataField: "product_name",
	                    headerText: "제품명",
	                    width: 180,
	                    cellMerge: true   // 셀 병합
	                },
	                {
	                    dataField: "hs_code",
	                    headerText: "HS코드",
	                    width: 110,
	                    style: "aui-center",
	                    headerStyle: "aui-center",
	                    cellMerge: true   // 셀 병합
	                },
	                {
	                    dataField: "rule_contents",
	                    headerText: "판정내용",
	                    width: 120,
	                    style: "aui-center",
	                    headerStyle: "aui-center"
	                },
	                {
	                    dataField: "fta_coo_yn",
	                    headerText: "협정기준",
	                    width: 90,
	                    style: "aui-center",
	                    headerStyle: "aui-center"
	                },
	                {
	                    dataField: "company_coo_yn",
	                    headerText: "회사기준",
	                    width: 90,
	                    style: "aui-center",
	                    headerStyle: "aui-center"
	                },
	                {
	                    dataField: "coo_certify_no",
	                    headerText: "수정발급 번호",
	                    width: 140,
	                    style: "aui-center",
	                    headerStyle: "aui-center"
	                },
	                {
	                    dataField: "cover_date",
	                    headerText: "포괄기간",
	                    width: 130,
	                    style: "aui-center",
	                    headerStyle: "aui-center"
	                },

	                /* 숨김 컬럼 */
	                {
	                    dataField: "company_code",
	                    headerText: "회사코드",
	                    visible: false
	                },
	                {
	                    dataField: "fta_code",
	                    headerText: "FTA코드",
	                    visible: false
	                },
	                {
	                    dataField: "co_issue_flag",
	                    headerText: "발급여부",
	                    visible: false
	                },
	                {
	                    dataField: "division_code",
	                    headerText: "플랜트코드",
	                    visible: false
	                },
	                {
	                    dataField: "sales_no",
	                    headerText: "매출번호",
	                    visible: false
	                },
	                {
	                    dataField: "sales_seq",
	                    headerText: "매출순번",
	                    visible: false
	                },
	                {
	                    dataField: "coo_date",
	                    headerText: "원산지판정일",
	                    visible: false
	                },
	                {
	                    dataField: "new_certify_no",
	                    headerText: "신규발급번호",
	                    visible: false
	                }
	            ];
	
	            const gridProps = {
	                editable: false,
	                selectionMode: "multipleRows",
	                showRowNumColumn: true,
	                rowNumHeaderText: "",
	                enableFilter: true,
	                fillColumnSizeMode: true,
	                usePaging: false,
	                // 셀 병합 정책
	    			// "default"(기본값) : null 을 셀 병합에서 제외하여 병합을 실행하지 않습니다.
	    			// "withNull" : null 도 하나의 값으로 간주하여 다수의 null 을 병합된 하나의 공백으로 출력 시킵니다.
	    			// "valueWithNull" : null 이 상단의 값과 함께 병합되어 출력 시킵니다.
	    			cellMergePolicy: "withNull",
	    			// 셀머지된 경우, 행 선택자(selectionMode : singleRow, multipleRows) 로 지정했을 때 병합 셀도 행 선택자에 의해 선택되도록 할지 여부
	    			rowSelectionWithMerge: false,
	    			rowStyleFunction: function(rowIndex, item) {
	    	            var checkedRows = AUIGrid.getCheckedRowItems(COO_ISSUE_POPUP.grid_COO_ISSUE_POPUP_01);

	    	            if (!checkedRows || checkedRows.length === 0) {
	    	                return "";
	    	            }

	    	            for (var i = 0; i < checkedRows.length; i++) {
	    	                var rowItem = checkedRows[i].item ? checkedRows[i].item : checkedRows[i];

	    	                if (rowItem.sales_no === item.sales_no &&
	    	                    rowItem.sales_seq === item.sales_seq &&
	    	                    rowItem.fta_code === item.fta_code &&
	    	                    rowItem.rule_contents === item.rule_contents) {
	    	                    return "aui-row-checked";
	    	                }
	    	            }

	    	            return "";
	    	        }
	            };
	
	            COO_ISSUE_POPUP.grid_COO_ISSUE_POPUP_01 =
	                KpackageOBJ.auiGrid.create("oAuiGrid_COO_ISSUE_POPUP_01", columnLayout, gridProps, "check");
	
	            

	            AUIGrid.bind(COO_ISSUE_POPUP.grid_COO_ISSUE_POPUP_01, "rowCheckClick", function() {
	                AUIGrid.refresh(COO_ISSUE_POPUP.grid_COO_ISSUE_POPUP_01);
	            });

	            AUIGrid.bind(COO_ISSUE_POPUP.grid_COO_ISSUE_POPUP_01, "rowAllCheckClick", function() {
	                AUIGrid.refresh(COO_ISSUE_POPUP.grid_COO_ISSUE_POPUP_01);
	            });
	            
	            /* 데이터 로드가 완료되면 */
	            AUIGrid.bind(COO_ISSUE_POPUP.grid_COO_ISSUE_POPUP_01, "ready", function (event) {
	            	if (!COO_ISSUE_POPUP.needAutoCheckAfterLoad) {
	                    return;
	                }

	                COO_ISSUE_POPUP.needAutoCheckAfterLoad = false;
	                COO_ISSUE_POPUP.autoCheckPriorityRows();
	                AUIGrid.refresh(COO_ISSUE_POPUP.grid_COO_ISSUE_POPUP_01);
	            });
	            setTimeout(function() {
	                $(window).trigger("resize");
	            }, 300);
	            
	            
	        };
	
	        this.checkDuplicateCertifyNo = function() {
	            if ($("#auto_create_yn").is(":checked")) {
	                return;
	            }
	
	            var certifyNo = KpackageOBJ.object.getFormValue("COO_ISSUE_POPUP-form", "coo_certify_no"); 
	              
	            if (!certifyNo) {
	                alert("원산지확인서 번호를 입력하세요.");
	                $("#coo_certify_no").focus();
	                return;
	            }
	            
	            var checkedItems = AUIGrid.getCheckedRowItems(COO_ISSUE_POPUP.grid_COO_ISSUE_POPUP_01);
	            
	            var params = { coo_certify_no : certifyNo
	            		       ,division_code : checkedItems[0]["item"]["division_code"]
	            };
	            KpackageOBJ.ajax.doSubmit("/issuecover/checkDuplicateCertifyNo", params, (result) => {
	                if(result.success){
	                	alert("사용가능한 확인서 번호 입니다.");
	                	COO_ISSUE_POPUP.isCertifyNoChecked = true;
	                }else{
	                	alert("중복된 확인서 번호 입니다.");
	                	COO_ISSUE_POPUP.isCertifyNoChecked = false;
	                }
	                
	            });
	        };
	
	        this.issueConfirm = function() {
	        	
	        	var signatureSeq  = KpackageOBJ.object.getFormValue("COO_ISSUE_POPUP-form", "signature_seq");
	        	var issueDate     = KpackageOBJ.object.getFormValue("COO_ISSUE_POPUP-form", "issue_date");
	        	var coverFromDate = KpackageOBJ.object.getFormValue("COO_ISSUE_POPUP-form", "cover_from_date");
	        	var coverToDate   = KpackageOBJ.object.getFormValue("COO_ISSUE_POPUP-form", "cover_to_date");
	        	var cooCertifyNo  = KpackageOBJ.object.getFormValue("COO_ISSUE_POPUP-form", "coo_certify_no");

	        	var autoCreateYn  = $("#auto_create_yn").is(":checked");

	            // 1. 서명권자 선택 여부
	            if (!signatureSeq) {
	                alert("서명권자를 선택해주세요.");
	                $("#signature_seq").focus();
	                return;
	            }

	            // 2. 발급일 체크
	            if (!issueDate) {
	                alert("발급일을 입력해주세요.");
	                $("#issue_date").focus();
	                return;
	            }

	            // 3. 포괄기간 필수 체크
	            if (!coverFromDate) {
	                alert("포괄기간 시작일을 입력해주세요.");
	                $("#cover_from_date").focus();
	                return;
	            }

	            if (!coverToDate) {
	                alert("포괄기간 종료일을 입력해주세요.");
	                $("#cover_to_date").focus();
	                return;
	            }

	            // 4. 기간 역전 체크
	            if (coverFromDate > coverToDate) {
	                alert("포괄기간 종료일은 시작일보다 빠를 수 없습니다.");
	                $("#cover_to_date").focus();
	                return;
	            }

	            // 5. 포괄기간 1년 초과 체크
	            var fromDate = new Date(coverFromDate);
	            var toDate = new Date(coverToDate);

	            var diffTime = toDate.getTime() - fromDate.getTime();
	            var diffDay = Math.floor(diffTime / (1000 * 60 * 60 * 24));

	            if (diffDay > 365) {
	                alert("포괄기간은 1년을 초과할 수 없습니다.");
	                $("#cover_to_date").focus();
	                return;
	            }

	            // 6. 자동생성이 아닐 경우 번호 입력 및 중복확인 여부 체크
	            if (!autoCreateYn) {
	                if (!cooCertifyNo) {
	                    alert("원산지확인서 번호를 입력해주세요.");
	                    $("#coo_certify_no").focus();
	                    return;
	                }

	                if (!COO_ISSUE_POPUP.isCertifyNoChecked) {
	                    alert("원산지확인서 번호 중복확인을 해주세요.");
	                    $("#btn_check_duplicate").focus();
	                    return;
	                }
	            }
	        	
	        	
	            var checkedItems = AUIGrid.getCheckedRowItems(COO_ISSUE_POPUP.grid_COO_ISSUE_POPUP_01);

	            if (!checkedItems || checkedItems.length === 0) {
	                alert("발급할 대상을 선택해주세요.");
	                return;
	            }

	            var checkedRows = [];
	            for (var i = 0; i < checkedItems.length; i++) {
	                checkedRows.push(checkedItems[i].item ? checkedItems[i].item : checkedItems[i]);
	            }

	            /* 1. 중복 협정 체크 */
	            var ftaCountMap = {};
	            var duplicatedFtaNames = [];

	            for (var i = 0; i < checkedRows.length; i++) {
	                var ftaCode = checkedRows[i].fta_code || "";
	                var ftaName = checkedRows[i].fta_name || ftaCode;

	                if (!ftaCountMap[ftaCode]) {
	                    ftaCountMap[ftaCode] = {
	                        count: 0,
	                        name: ftaName
	                    };
	                }

	                ftaCountMap[ftaCode].count++;
	            }

	            for (var key in ftaCountMap) {
	                if (ftaCountMap[key].count > 1) {
	                    duplicatedFtaNames.push(ftaCountMap[key].name);
	                }
	            }

	            if (duplicatedFtaNames.length > 0) {
	                alert("중복된 협정은 선택할 수 없습니다.\n중복 협정: " + duplicatedFtaNames.join(", "));
	                return;
	            }

	            /* 2. 같은 협정에 Y가 있는데 N을 선택한 경우 체크 */
	            var allRows = AUIGrid.getGridData(COO_ISSUE_POPUP.grid_COO_ISSUE_POPUP_01);
	            var warningFtaNames = [];

	            for (var i = 0; i < checkedRows.length; i++) {
	                var selectedRow = checkedRows[i];
	                var selectedFtaCode = selectedRow.fta_code;
	                var selectedFtaName = selectedRow.fta_name || selectedFtaCode;
	                var selectedCompanyCooYn = selectedRow.company_coo_yn;

	                if (selectedCompanyCooYn === "N") {
	                    var hasY = false;

	                    for (var j = 0; j < allRows.length; j++) {
	                        var row = allRows[j];
	                        if (row.fta_code === selectedFtaCode && row.company_coo_yn === "Y") {
	                            hasY = true;
	                            break;
	                        }
	                    }

	                    if (hasY) {
	                        warningFtaNames.push(selectedFtaName);
	                    }
	                }
	            }

	            if (warningFtaNames.length > 0) {
	                var uniqueWarningNames = [];
	                for (var i = 0; i < warningFtaNames.length; i++) {
	                    if (uniqueWarningNames.indexOf(warningFtaNames[i]) === -1) {
	                        uniqueWarningNames.push(warningFtaNames[i]);
	                    }
	                }

	                alert("선택한 협정 중 회사기준이 'Y'인 데이터가 존재하는데 'N' 데이터를 선택한 항목이 있습니다.\n대상 협정: " + uniqueWarningNames.join(", "));
	                return;
	            }

	            /* 3. 최종 처리 대상 */
	            var issueTargetList = [];
	            for (var i = 0; i < checkedRows.length; i++) {
	                issueTargetList.push({
	                    company_code: checkedRows[i].company_code,
	                    division_code: checkedRows[i].division_code,
	                    sales_no: checkedRows[i].sales_no,
	                    sales_seq: checkedRows[i].sales_seq,
	                    fta_code: checkedRows[i].fta_code,
	                    product_code: checkedRows[i].product_code,
	                    company_coo_yn: checkedRows[i].company_coo_yn,
	                    rule_contents: checkedRows[i].rule_contents
	                });
	            }

	            var params = KpackageOBJ.data.makePostData("COO_ISSUE_POPUP-form");   
	            params["coo_issue_target"] = issueTargetList;
	            params["division_code"] = issueTargetList[0]["division_code"];
	        
	            KpackageOBJ.ajax.doSubmit("/issuecover/confirmIssue", params, (result) => {
	                var data = result.value || {};
	                
	             	// 발급이 성공적으로 수행된 후 
		            // 기존 발급 페이지는 닫힘
		            KpackageOBJ.sidepanel.close("cooIssueCoverForm");

	                if(result.success){
	                	setTimeout(function() {
	                		//확인서 상세 페이지 (추후 개발 예정) 팝업이 열림
	                		var getParam = "?coo_certify_no=" + encodeURIComponent(data)  // 새로운 확인서 번호 
                					+ "&customer_code=" +  KpackageOBJ.object.getFormValue("COO_MODIFY_POPUP-form", "customer_code");
                    		KpackageOBJ.sidepanel.open('cooIssueDetailPopup','/issuecover/cooIssueCoverDetail' + getParam, '1300px', true);
                    
                    		alert("원산지 확인서 발급이 완료되었습니다.");
                    		//부모창 재조회
                    		var opener_pgm_id = KpackageOBJ.object.getFormValue("COO_ISSUE_POPUP-form", "opener_pgm_id");
                    		var openerObj = window[opener_pgm_id];
							if (openerObj && typeof openerObj.retrieve_GridData === "function") {
							    openerObj.retrieve_GridData();
							}
	                	}, 200);
	                	
	                }
	            });
	             
	        };
	
	        this.closePopup = function() {
	            if (parent && parent.KpackageOBJ && parent.KpackageOBJ.dialog) {
	                parent.KpackageOBJ.dialog.close();
	            } else {
	                window.close();
	            }
	        };
	
	        /* 자동발급 */
	        this.toggleCertifyNoInput = function() {
	            var checked = $("#auto_create_yn").is(":checked");
	
	            $("#coo_certify_no").prop("readonly", checked);
	            $("#btn_check_duplicate").prop("disabled", checked);
	
	            if (checked) {
	                $("#coo_certify_no").val("");
	                $("#coo_certify_no").addClass("bg-body-secondary text-secondary");
	            } else {
	                $("#coo_certify_no").removeClass("bg-body-secondary text-secondary");
	            }
	        };
	
	        /* 발급일자 기준 포괄기간 */
	        this.syncCoverPeriodByIssueDate = function() {
	            var issueDate = $("#issue_date").val();
	
	            if (!issueDate) {
	                $("#cover_from_date").val("");
	                $("#cover_to_date").val("");
	                return;
	            }
	
	            var year = issueDate.substring(0, 4);
	
	            $("#cover_from_date").val(issueDate);
	            $("#cover_to_date").val(year + "-12-31");
	        };
	
	        this.bindEvent = function() {
	            $("#auto_create_yn").off("change").on("change", function() {
	                COO_ISSUE_POPUP.toggleCertifyNoInput();
	            });
	
	            $("#issue_date").off("change").on("change", function() {
	                COO_ISSUE_POPUP.syncCoverPeriodByIssueDate();
	            });
	            
	            $("#coo_certify_no").off("input").on("input", function() {
	                COO_ISSUE_POPUP.isCertifyNoChecked = false;
	            });
	        };
	        
	        
	        this.autoCheckPriorityRows = function() {
	            var gridData = AUIGrid.getGridData(COO_ISSUE_POPUP.grid_COO_ISSUE_POPUP_01);

	            if (!gridData || gridData.length === 0) {
	                return;
	            }

	            var groupedMap = {};
	            var checkedRowIds = [];

	            function getPriority(rule) {
	                if (rule === "CC") return 1;
	                if (rule === "CTH") return 2;
	                if (rule === "CTSH") return 3;
	                return 999;
	            }

	            for (var i = 0; i < gridData.length; i++) {
	                var row = gridData[i];
	                var ftaCode = row.fta_code || "";

	                if (!groupedMap[ftaCode]) {
	                    groupedMap[ftaCode] = [];
	                }

	                groupedMap[ftaCode].push(row);
	            }

	            for (var ftaCode in groupedMap) {
	                var rows = groupedMap[ftaCode];
	                var yRows = [];
	                var nRows = [];

	                for (var j = 0; j < rows.length; j++) {
	                    if (rows[j].company_coo_yn === "Y") {
	                        yRows.push(rows[j]);
	                    } else {
	                        nRows.push(rows[j]);
	                    }
	                }

	                var targetRows = yRows.length > 0 ? yRows : nRows;

	                targetRows.sort(function(a, b) {
	                    return getPriority(a.rule_contents) - getPriority(b.rule_contents);
	                });

	                var selectedRow = targetRows.length > 0 ? targetRows[0] : rows[0];

	                if (selectedRow && selectedRow._$uid) {
	                    checkedRowIds.push(selectedRow._$uid);
	                }
	            }

	            if (checkedRowIds.length === 0) {
	                return;
	            }
	            
	            
	            AUIGrid.setCheckedRowsByIds(COO_ISSUE_POPUP.grid_COO_ISSUE_POPUP_01, checkedRowIds);
	            /* 배경색 즉시 반영 */
	            setTimeout(function() {
	                AUIGrid.refresh(COO_ISSUE_POPUP.grid_COO_ISSUE_POPUP_01);
	            }, 50);
	        };
	        
	
	    };
	
	    $(document).ready(function() {
	        COO_ISSUE_POPUP.Initialize_viewObject();
	    });
	</script>
</body>
</html>