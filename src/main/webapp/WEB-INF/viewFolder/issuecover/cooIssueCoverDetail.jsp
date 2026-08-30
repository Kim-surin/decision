<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>확인서 발급내역</title>
    <style>
    .aui-row-checked {
        background-color: #eaf3ff !important;
    }
</style>
</head>
<body>
    <div class="modal-header py-2 px-3">
	    <h5 class="modal-title fs-5 fw-semibold mb-0">확인서 발급내역</h5>
	    <button type="button" class="btn btn-sm btn-system ms-auto p-1" data-bs-dismiss="modal" aria-label="Close">
	        <svg class="sa-icon" style="width: 1rem; height: 1rem;">
	            <use href="/rcs/ui5x/img/sprite.svg#x"></use>
	        </svg>
	    </button>
	</div>
    <div class="modal-body">
        <form:form id="COO_ISSUE_DETAIL_POPUP-form" method="post" action="" novalidate="novalidate">
            <input type="hidden" id="dialog_id" name="dialog_id" value="${dialog_id}"/>
            <input type="hidden" id="opener_pgm_id" name="opener_pgm_id" value="${opener_pgm_id}"/>
            <input type="hidden" id="customer_code" name="customer_code" value="${customer_code}"/>
            <input type="hidden" id="coo_certify_no" name="coo_certify_no" value="${coo_certify_no}"/>
		    <div class="card-body p-0">
			    <div class="row g-3 mb-3">
				    <!-- 고객사 정보 박스 -->
				    <div class="col-md-8">
				        <div class="card border-0 shadow-sm h-100" style="background-color: #f5f5f5;">
				            <div class="card-body px-4 py-3">
				                <div class="row align-items-center g-3">
				
				                    <div class="col-md-4">
				                        <div class="d-flex align-items-center">
				                            <div class="d-flex align-items-center justify-content-center rounded-circle border border-2 flex-shrink-0"
				                                 style="width: 52px; height: 52px; color: #666; border-color: #666 !important;">
				                                <i class="sa sa-info fs-3"></i>
				                            </div>
				
				                            <div class="ms-3">
				                                <div class="fw-semibold mb-1" style="color: #8c73c9; font-size: 1.2rem; line-height: 1.2;">
				                                    <span id="customer_name">customer_name</span>
				                                </div>
				                                <div class="text-secondary" style="font-size: 0.95rem; line-height: 1.2;">
				                                    <span id="officer_name">officer_name</span>
				                                </div>
				                            </div>
				                        </div>
				                    </div>
				
				                    <div class="col-md-8">
				                        <div class="row g-2">
				                            <div class="col-md-6">
				                                <div class="d-flex align-items-center text-secondary" style="font-size: 0.95rem;">
				                                    <i class="sa sa-phone me-2"></i>
				                                    <span id="tel_no">tel_no</span>
				                                </div>
				                            </div>
				
				                            <div class="col-md-6">
				                                <div class="d-flex align-items-center" style="font-size: 0.95rem; color: #8c73c9;">
				                                    <i class="sa sa-envelope me-2 text-secondary"></i>
				                                    <span id="email">email</span>
				                                </div>
				                            </div>
				
				                            <div class="col-12">
				                                <div class="d-flex align-items-start text-secondary" style="font-size: 0.95rem; line-height: 1.35;">
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
				
				    <!-- 다운로드 박스 -->
					<div class="col-md-4">
					    <div class="card border-0 shadow-sm h-100">
					        <div class="card-body px-3 py-3">
					
					            <!-- 타이틀 + 압축 다운로드 -->
					            <div class="d-flex justify-content-between align-items-center mb-3">
					                <div class="fw-semibold text-secondary small">다운로드</div>
					
					                <button type="button"
					                        class="btn btn-sm btn-outline-info px-2 py-1 d-inline-flex align-items-center text-nowrap"
					                        style="min-width: 140px;"
					                        onclick="COO_ISSUE_DETAIL_POPUP.downloadAllZip();">
					                    <svg class="sa-icon me-1 flex-shrink-0" style="width: 0.8rem; height: 0.8rem;">
					                        <use href="/rcs/ui5x/img/sprite.svg#download"></use>
					                    </svg>
					                    <span class="small text-nowrap">압축파일다운로드</span>
					                </button>
					            </div>
					
					            <!-- 아이콘 4개 -->
					            <div class="d-flex justify-content-between align-items-start gap-2">
					
					                <button type="button"
					                        class="btn p-0 border-0 bg-transparent d-flex flex-column align-items-center"
					                        onclick="COO_ISSUE_DETAIL_POPUP.downloadConfirmPdf();">
					                    <svg class="sa-icon text-danger" style="width: 30px; height: 30px;">
					                        <use href="/rcs/ui5x/img/sprite.svg#file"></use>
					                    </svg>
					                    <span class="mt-1 small fw-semibold text-dark text-nowrap">확인서</span>
					                </button>
					
					                <button type="button"
					                        class="btn p-0 border-0 bg-transparent d-flex flex-column align-items-center"
					                        onclick="COO_ISSUE_DETAIL_POPUP.downloadExplanationPdf();">
					                    <svg class="sa-icon text-danger" style="width: 30px; height: 30px;">
					                        <use href="/rcs/ui5x/img/sprite.svg#file"></use>
					                    </svg>
					                    <span class="mt-1 small fw-semibold text-dark text-nowrap">소명서</span>
					                </button>
					
					                <button type="button"
					                        class="btn p-0 border-0 bg-transparent d-flex flex-column align-items-center"
					                        onclick="COO_ISSUE_DETAIL_POPUP.downloadLedgerPdf();">
					                    <svg class="sa-icon text-danger" style="width: 30px; height: 30px;">
					                        <use href="/rcs/ui5x/img/sprite.svg#file"></use>
					                    </svg>
					                    <span class="mt-1 small fw-semibold text-dark text-nowrap">작성대장</span>
					                </button>
					
					                <button type="button"
					                        class="btn p-0 border-0 bg-transparent d-flex flex-column align-items-center"
					                        onclick="COO_ISSUE_DETAIL_POPUP.downloadBomExcel();">
					                    <svg class="sa-icon text-success" style="width: 30px; height: 30px;">
					                        <use href="/rcs/ui5x/img/sprite.svg#file"></use>
					                    </svg>
					                    <span class="mt-1 small fw-semibold text-dark text-nowrap">BOM</span>
					                </button>
					
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
			                <button type="button"
							        class="btn btn-outline-primary btn-sm px-4"
							        onclick="COO_ISSUE_DETAIL_POPUP.openModifyIssuePopup();">
							    수정발급
							</button>
			            </div>
			        </div>
			
			        <div class="row g-3">
			            <div class="col-md-5">
			                <div class="border rounded-3 px-3 py-2 h-100">
			                    <div class="text-secondary small mb-1">원산지증명번호</div>
			                    <div class="fw-semibold text-dark" id="view_coo_certify_no">-</div>
			                </div>
			            </div>
			
			            <div class="col-md-3">
			                <div class="border rounded-3 px-3 py-2 h-100">
			                    <div class="text-secondary small mb-1">발급일</div>
			                    <div class="fw-semibold text-dark" id="view_issue_date">-</div>
			                </div>
			            </div>
			
			            <div class="col-md-4">
			                <div class="border rounded-3 px-3 py-2 h-100">
			                    <div class="text-secondary small mb-1">포괄기간</div>
			                    <div class="fw-semibold text-dark">
			                        <span id="view_cover_from_date">-</span>
			                        <span class="mx-1 text-secondary">~</span>
			                        <span id="view_cover_to_date">-</span>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>
			</div>
        </form:form>

        <div class="row">
            <div class="col-12">
                <div id="oAuiGrid_COO_ISSUE_DETAIL_POPUP_01" style="width:100%; height:490px; margin:0 auto;"></div>
            </div>
        </div>
    </div>

	<script>
	    var COO_ISSUE_DETAIL_POPUP = new function() {
	
	        this.grid_COO_ISSUE_DETAIL_POPUP_01 = null;
	
	        this.Initialize_viewObject = function() {
	            this.createAUIGrid();
	            this.setDefaultValue();
	        };
	
	
	        this.setDefaultValue = function() {
	            /* 부모창 체크된 아이템 ArrayList*/
	            var checkedArray = KpackageOBJ.auiGrid.getSelectedItems(ISSUE_TARGET.grid_ISSUE_TARGET_01);
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
	
	            KpackageOBJ.ajax.doSubmit("/issuecover/retrieveCooIssueTargetCustomerInfo", params, (result) => {
	                var value = result.value || {};
	                var data = $.isArray(value) ? (value[0] || {}) : value;
	
	                $("#customer_name").text(data.customer_name || "N/A");
	                $("#officer_name").text(data.officer_name || "N/A");
	                $("#tel_no").text(data.tel_no || "N/A");
	                $("#email").text(data.email || "N/A");
	                $("#address").text(data.address || "N/A");
	            });
	
	            /* 확인서 발급 데이터 목록 */
	            
	            var params = {
	            			coo_certify_no : KpackageOBJ.object.getFormValue("COO_ISSUE_DETAIL_POPUP-form", "coo_certify_no")
	            };
	
	            KpackageOBJ.auiGrid.retrieve(
	                COO_ISSUE_DETAIL_POPUP.grid_COO_ISSUE_DETAIL_POPUP_01,
	                "/issuecover/retrieveIssuedCoverList",
	                params
	            );
	        };
	
	        this.createAUIGrid = function() {
	            const columnLayout = [
	                {
	                    dataField: "product_code",
	                    headerText: "제품코드",
	                    width: 130,
	                    style: "aui-center",
	                    headerStyle: "aui-center",
	                    cellMerge: true
	                },
	                {
	                    dataField: "hs_code",
	                    headerText: "HS CODE",
	                    width: 110,
	                    style: "aui-center",
	                    headerStyle: "aui-center",
	                    cellMerge: true
	                },
	                
	                {
	                    dataField: "fta_name",
	                    headerText: "FTA명",
	                    width: 140,
	                    style: "aui-center",
	                    headerStyle: "aui-center"
	                },
	                {
	                    dataField: "rule_contents",
	                    headerText: "원산지결정기준",
	                    width: 140,
	                    style: "aui-center",
	                    headerStyle: "aui-center"
	                },
	                {
	                    dataField: "coo_yn_name",
	                    headerText: "원산지",
	                    width: 100,
	                    style: "aui-center",
	                    headerStyle: "aui-center",
	                    labelFunction: function(rowIndex, columnIndex, value) {
	                        return value || "";
	                    }
	                },
	                
	                {   dataField: "fta_code", headerText: "FTA CODE", width: 110, style: "aui-center", headerStyle: "aui-center", visible: false}
	            ];

	            const gridProps = {
	                editable: false,
	                selectionMode: "singleRow",
	                showRowNumColumn: true,
	                rowNumHeaderText: "",
	                enableFilter: true,
	                usePaging: false,
	                fillColumnSizeMode: true,
	                // 셀 병합 정책
	    			// "default"(기본값) : null 을 셀 병합에서 제외하여 병합을 실행하지 않습니다.
	    			// "withNull" : null 도 하나의 값으로 간주하여 다수의 null 을 병합된 하나의 공백으로 출력 시킵니다.
	    			// "valueWithNull" : null 이 상단의 값과 함께 병합되어 출력 시킵니다.
	    			cellMergePolicy: "withNull",
	    			// 셀머지된 경우, 행 선택자(selectionMode : singleRow, multipleRows) 로 지정했을 때 병합 셀도 행 선택자에 의해 선택되도록 할지 여부
	    			rowSelectionWithMerge: false
	            };

	            COO_ISSUE_DETAIL_POPUP.grid_COO_ISSUE_DETAIL_POPUP_01 =
	                KpackageOBJ.auiGrid.create(
	                    "oAuiGrid_COO_ISSUE_DETAIL_POPUP_01",
	                    columnLayout,
	                    gridProps,
	                    "number"
	                );

	            /* 데이터 로드가 완료되면 */
	            AUIGrid.bind(COO_ISSUE_DETAIL_POPUP.grid_COO_ISSUE_DETAIL_POPUP_01, "ready", function (event) {
	            	var gridDataList = KpackageOBJ.auiGrid.getGridData(COO_ISSUE_DETAIL_POPUP.grid_COO_ISSUE_DETAIL_POPUP_01);
	            	
	            	if(gridDataList.length > 0){
	            		var rowData = KpackageOBJ.auiGrid.getGridData(COO_ISSUE_DETAIL_POPUP.grid_COO_ISSUE_DETAIL_POPUP_01)[0];
		            	
		            	$("#view_coo_certify_no").text(rowData.coo_certify_no);
		            	$("#view_issue_date").text(rowData.issue_date);
		            	$("#view_cover_from_date").text(rowData.cover_from_date);
		            	$("#view_cover_to_date").text(rowData.cover_to_date);	
	            	}
	            });
	            
	            
	            setTimeout(function() {
	                $(window).trigger("resize");
	            }, 300);
	            
	        };
	        
	        /* 수정발급 버튼 클릭 */
	        this.openModifyIssuePopup = function() {
	            var originCooCertifyNo = KpackageOBJ.object.getFormValue("COO_ISSUE_DETAIL_POPUP-form", "coo_certify_no");

	            if (!originCooCertifyNo) {
	                alert("원산지증명번호가 없습니다.");
	                return;
	            }

	            if (!confirm("확인서 수정발급을 진행하시겠습니까?")) {
	                return;
	            }

	            var url = "/issuecover/cooIssueCoverModifyForm"
	                    + "?origin_coo_certify_no=" + encodeURIComponent(originCooCertifyNo);

	            KpackageOBJ.sidepanel.close("cooIssueDetailPopup");

	            setTimeout(function() {
	                KpackageOBJ.sidepanel.open("cooIssueCoverModifyForm", url, "1300px", true);
	            }, 200);
	        };
	
	    };
	
	    $(document).ready(function() {
	        COO_ISSUE_DETAIL_POPUP.Initialize_viewObject();
	    });
	</script>
</body>
</html>