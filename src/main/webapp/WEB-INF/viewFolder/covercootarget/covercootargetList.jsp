<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
	    	<form:form id="coverCootargetList-form" class="s4-form" novalidate="novalidate" action="" method="post">
	    		<input type="hidden" id="company_code" name="company_code" value="${sessionScope._sessionUser.company_code}"/>  
	    		
	    		
	    		<div id="panel-4" class="panel panel-icon">
				    <div class="panel-container show">
				        <div class="panel-content" style="padding: 0;">
				            <div class="row" style="margin: 0; min-height: 110px;">
				            
				                <div class="col-3" style="padding: 16px 18px 18px; display: flex; flex-direction: column;">
								    <div style="font-size: 15px; font-weight: 600; color: #777; text-align: left; line-height: 1.4; margin-bottom: 14px; white-space: nowrap;">미등록 자재</div>
								    <div style="font-size: 45px; font-weight: 700; color: #6c4cff; text-align: center; line-height: 1.2;">
								        <span id="unregisteredItemCount"></span>
								    </div>
								</div>
								
								<div class="col-3" style="padding: 16px 18px 18px; display: flex; flex-direction: column;">
								    <div style="font-size: 15px; font-weight: 600; color: #777; text-align: left; line-height: 1.4; margin-bottom: 14px; white-space: nowrap;">제출완료 자재</div>
								    <div style="font-size: 45px; font-weight: 700; color: #252525; text-align: center; line-height: 1.2;">
								        <span id="submittedItemCount"></span>
								    </div>
								</div>
								
								<div class="col-3" style="padding: 16px 18px 18px; display: flex; flex-direction: column;">
								    <div style="font-size: 15px; font-weight: 600; color: #777; text-align: left; line-height: 1.4; margin-bottom: 14px; white-space: nowrap;">30일 내 만료 자재</div>
								    <div style="font-size: 45px; font-weight: 700; color: #252525; text-align: center; line-height: 1.2;">
								        <span id="expiringWithin30DaysItemCount"></span>
								    </div>
								</div>
								
								<div class="col-3" style="padding: 16px 18px 18px; display: flex; flex-direction: column;">
								    <div style="font-size: 15px; font-weight: 600; color: #777; text-align: left; line-height: 1.4; margin-bottom: 14px; white-space: nowrap;">Total 자재내역</div>
								    <div style="font-size: 45px; font-weight: 700; color: #6c4cff; text-align: center; line-height: 1.2;">
								        <span id="totalItemCount"></span>
								    </div>
								</div>
				
				            </div>
				        </div>
				    </div>
				</div>
				
				<!-- 자재명 다중 입력 팝업 -->
				<div class="modal fade" id="itemCodeModal" tabindex="-1" aria-hidden="true">
				    <div class="modal-dialog modal-dialog-centered" style="max-width: 520px;">
				        <div class="modal-content" style="height: 450px;">
				
				            <div class="modal-header">
				                <h5 class="modal-title">자재코드 입력</h5>
				                <button type="button" class="btn-close" onclick="coverCootargetList.closeItemCodePopup();"></button>
				            </div>
				
				            <div class="modal-body">
				                <label class="form-label" for="itemCodeInput" >자재코드</label>
				                <textarea style="height:220px" class="form-control" id="itemCodeInput" rows="8" placeholder="쉼표 또는 줄바꿈으로 구분해 입력하세요.&#10;예시:&#10;A001,A002,A003&#10;또는&#10;A001&#10;A002&#10;A003"></textarea>
				
				                <div style="margin-top: 8px; font-size: 12px; color: #777;">
				                    쉼표, 공백, 줄바꿈으로 여러 자재코드를 구분할 수 있습니다.
				                </div>
				            </div>
				
				            <div class="modal-footer">
				                <button type="button" class="btn btn-secondary" onclick="coverCootargetList.clearItemCodes();" style="width: 80px;">초기화</button>
				                <button type="button" class="btn btn-primary" onclick="coverCootargetList.applyItemCodes();" style="width: 80px;">적용</button>
				            </div>
				
				        </div>
				    </div>
				</div>
	    		
		    	<div id="panel-4" class="panel panel-icon">
				    <div class="panel-container show">
				        <div class="panel-content" style="padding: 20px 32px;">
				
				            <!-- 기본 검색 조건 -->
				            <div style="display: grid; grid-template-columns: 240px 240px 420px 1fr; column-gap: 36px; align-items: end;">
				
								<!-- 자재코드 -->
								<div>
								    <label class="form-label" for="itemCodeDisplay" style="display: block; margin-bottom: 8px;">자재코드</label>
								
								    <div style="position: relative; width: 200px;">
								        <input class="form-control" id="itemCodeDisplay" name="itemCodeDisplay" type="text" placeholder="자재 선택" readonly onclick="coverCootargetList.openItemCodePopup();" style="width: 100%; height: 38px; padding-right: 44px; background-color: #fff; cursor: pointer;">
								
								        <button type="button" onclick="coverCootargetList.openItemCodePopup();" aria-label="자재 검색" style="position: absolute; top: 0; right: 0; width: 42px; height: 38px; display: flex; align-items: center; justify-content: center; padding: 0; color: #66717d; background-color: transparent; border: 0; border-left: 1px solid #d7dce1; border-radius: 0 4px 4px 0; cursor: pointer;">
								            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" aria-hidden="true">
								                <circle cx="11" cy="11" r="6.5" stroke="currentColor" stroke-width="2"></circle>
								                <path d="M16 16L21 21" stroke="currentColor" stroke-width="2" stroke-linecap="round"></path>
								            </svg>
								        </button>
								    </div>
								
								    <input id="itemCodes" name="itemCodes" type="hidden">
								</div>
				
				                <!-- 협력사명 -->
				                <div>
								    <label class="form-label" for="vendor" style="display: block; margin-bottom: 8px;">협력사명</label>
								    <input class="form-control" id="vendor" name="vendor" type="text" style="width: 200px;">
								</div>
				
				                <!-- 입고일자 -->
				                <div>
				                    <label class="form-label" for="search_from_date" style="display: block; margin-bottom: 8px;">입고일자</label>
				                    <div style="display: flex; align-items: center; gap: 10px;">
				                        <input class="form-control" id="search_from_date" name="search_from_date" type="date" value="<%= java.time.LocalDate.now().minusMonths(1) %>" style="width: 140px;">
				                        <span style="display: inline-block; min-width: 6px; text-align: center;">~</span>
				                        <input class="form-control" id="search_to_date" name="search_to_date" type="date" value="<%= java.time.LocalDate.now() %>" style="width: 140px;">
				                    </div>
				                </div>
				
				                <!-- 버튼 -->
				                <div style="display: flex; flex-direction: column; gap: 5px; width: auto;">
								    <button type="button" class="btn btn-sm btn-search waves-effect waves-themed" onclick="coverCootargetList.retrieve_GridData();" style="width: auto; height: 39px; padding: 0 12px;">Search</button>
								    <button type="button" class="btn btn-xs btn-search-more waves-effect waves-themed" onclick="toggleSearchMore(this, 'coverCootargetList_SEARCHMORE');" style="width: auto; height: 30px; padding: 0 10px;">More</button>
								</div>
				
				            </div>
				
				            <!-- More 검색 조건 -->
				            <div id="coverCootargetList_SEARCHMORE" style="display: none; margin-top: 20px; padding-top: 20px; border-top: 1px solid #e5e5e5;">
				                <div style="display: grid; grid-template-columns: 240px 240px 420px 1fr; column-gap: 36px; align-items: end;">
				
				                    <!-- 집중관리 여부 -->
									<div>
									    <label class="form-label" for="importanceYn" style="display: block; margin-bottom: 8px;">집중관리 여부</label>
									    <select class="form-select" id="importanceYn" name="importanceYn" style="width: 200px;">
									        <option value="">All</option>
									        <option value="Y">Y</option>
									        <option value="N">N</option>
									    </select>
									</div>
									
									<!-- 기등록확인서 포함 -->
									<div>
									    <label class="form-label" for="includeRegisteredYn" style="display: block; margin-bottom: 8px;">기등록확인서 포함</label>
									    <div style="display: flex; align-items: center; height: 38px;">
									        <input class="form-check-input" id="includeRegisteredYn" name="includeRegisteredYn" type="checkbox" value="Y" style="margin: 0;">
									        <label class="form-check-label" for="includeRegisteredYn" style="margin-left: 8px;">포함</label>
									    </div>
									</div>
									
									<!-- 포괄기간 만료일자 -->
									<div>
									    <label class="form-label" for="blanketExpiryDays" style="display: block; margin-bottom: 8px;">포괄기간 만료일자</label>
									    <select class="form-select" id="blanketExpiryDays" name="blanketExpiryDays" style="width: 200px;">
									        <option value="0">0일</option>
									        <option value="10">10일</option>
									        <option value="15">15일</option>
									        <option value="30">30일</option>
									        <option value="45">45일</option>
									    </select>
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
				<div class="frame-wrap">
				    <div class="demo" style="display: inline-flex; align-items: center; margin-left: 10px;">
					    <span style="font-size: 13px; color: #666; margin-right: 10px;">총 건수</span>
					    <span id="totalCount" style="font-size: 16px; font-weight: 700; color: #333;">0</span>
					    <span style="font-size: 13px; color: #666; margin-left: 3px;">건</span>
					</div>
				</div>
	    	</div>
	    	<div class="col-5">
			    <div class="frame-wrap">
			        <div class="demo" style="display: flex; justify-content: flex-end; align-items: center; gap: 3px;">
			            <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="coverCootargetList.openWritePopup();" style="width: 110px;color: #fff; background-color: #526d82; border: 1px solid #526d82;">확인서 작성</button>
			        </div>
			    </div>
			</div>
	    </div>

		<div class="row">
	   		<div class="col-12">
		        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		        <div id="oAuiGrid_coverCootargetList_01" style="width:100%;height:480px; margin:0 auto;"></div>
		    </div>
	    </div>	

	</div>
</body>
<script>
	var coverCootargetList = new function() {

		// AUIGrid 생성 후 반환 ID
		this.grid_coverCootargetList_01 = null;

		// 시작점
		this.Initialize_viewObject = function() {
			
			KpackageOBJ.selectbox.create("coverCootargetList-form", "plant", "/common/retrievePlantCombo", {"OPTION_ALL":"Y"}, "code", "name");
			KpackageOBJ.selectbox.create("coverCootargetList-form", "vendor", "/common/retrieveVendorCombo", {"OPTION_ALL":"Y"}, "code", "name");
			
			
			// AUIGrid 그리드를 생성합니다.
			coverCootargetList.createAUIGrid();
			AUIGrid.setGridData(coverCootargetList.grid_coverCootargetList_01, coverCootargetList.data);
			
			coverCootargetList.retrieve_GridData();
		}

		// AUIGrid 를 생성합니다.
		this.createAUIGrid = function() {
			// 그리드 칼럼 레이아웃 설정
			const columnLayout = [ 
				{ dataField : "VENDOR_NAME",		headerText : "협력사명",          width : 200,		filter: { showIcon: true } ,  style: "aui-center-align"},
				{ dataField : "ITEM_CODE",		headerText : "자재코드",      width : 200,	    filter: { showIcon: true } , style: "aui-right-align"},
				{ dataField : "ITEM_SPEC", 		headerText : "자재내역",     	  width : "auto",	filter: { showIcon: true } ,  style: "aui-center-align" },
				{ dataField : "HS_CODE", 			headerText : "HSCode ",     width : 140,		filter: { showIcon: false } , style: "aui-right-align" },
				{ dataField : "ISSUE_DATE", 		headerText : "발행일자",     width : 140,		filter: { showIcon: false } , style: "aui-right-align"},
				{ dataField : "APPLY_DATE", 		headerText : "포괄적용일",     width : 140,		filter: { showIcon: false } , style: "aui-right-align"},
				{ dataField : "END_DATE", 		headerText : "포괄만료일",     width : 140,		filter: { showIcon: false } , style: "aui-right-align"},
				{ dataField : "SUBMIT_STATUS", 	headerText : "상태",     width : 140,		filter: { showIcon: false } , style: "aui-center-align" }
			];

			// 그리드 속성 설정
			const gridProps = {
				//추가속성이 필요한 경우 작성 
				//editable : true, // 그리드 수정 모드 
				usePaging: true,   // 페이징 사용
				pageRowCount: 20,  // 페이지 행 개수 select UI 출력 여부 (기본값 : false)
				showPageRowSelect: true,	// 페이지 카운트 표시 여부				
				enableFilter: true	// 필터 사용여부
			};

			// 실제로 #oAuiGrid_covercootargetList_01 에 그리드 생성
			// 파라메터 : Grid Div ID, 컬럼레이아웃, 그리드속성, 그리드타입(없음 : null or "", 행번호 : number ,체크박스 : check ,라디오 : radio)
			coverCootargetList.grid_coverCootargetList_01 = KpackageOBJ.auiGrid.create("oAuiGrid_coverCootargetList_01", columnLayout, gridProps, "check");
			
			
		/* 	// 클릭 이벤트
			AUIGrid.bind(covercootargetList.grid_covercootargetList_01, "cellClick", function( event ) {
				console.log("rowIndex : " + event.rowIndex + ", columnIndex : " + event.columnIndex + " clicked");
			});
			
			// 더블클릭 이벤트 
			AUIGrid.bind(covercootargetList.grid_covercootargetList_01, "cellDoubleClick", function( event ) {
				console.log("rowIndex : " + event.rowIndex + ", columnIndex : " + event.columnIndex + " dbl clicked");
			}); */
			
		};
		

		this.retrieve_GridData = function(){

		    var params = {
		        COMPANY_CODE: $("#company_code").val(),
		        plant: $("#plant").val(),
		        vendor: $("#vendor").val(),
		        itemCodes: $("#itemCodes").val(),
		        search_from_date: $("#search_from_date").val().replace(/-/g, ""),
		        search_to_date: $("#search_to_date").val().replace(/-/g, ""),
		        importanceYn: $("#importanceYn").val(),
		        includeRegisteredYn: $("#includeRegisteredYn").is(":checked") ? "Y" : "N",
		        blanketExpiryDays: $("#blanketExpiryDays").val()
		    };

		    KpackageOBJ.auiGrid.retrieve(
		        coverCootargetList.grid_coverCootargetList_01,
		        "/cover/retrieveCoverCootargetList",
		        params
		    );

		    $.ajax({
		        url: "/cover/retrieveCoverCootargetDashboard",
		        type: "POST",
		        contentType: "application/json",
		        data: JSON.stringify(params),
		        success: function(res) {

		            const result = typeof res === "string" ? JSON.parse(res) : res;
		            const data = result.value[0];

		            $("#unregisteredItemCount").text(data.unregisteredItemCount);
		            $("#submittedItemCount").text(data.submittedItemCount);
		            $("#expiringWithin30DaysItemCount").text(data.expiringWithin30DaysItemCount);
		            $("#totalItemCount").text(data.totalItemCount);
		        }
		    });
		};
		
		
		this.openItemCodePopup = function(){
		    var itemCodes = $("#itemCodes").val();

		    // 기존에 저장된 값이 있으면 다시 팝업에 표시
		    $("#itemCodeInput").val(itemCodes);

		    $("#itemCodeModal").modal("show");
		}
		
		this.closeItemCodePopup = function(){
		    $("#itemCodeModal").modal("hide");
		}
		
		this.applyItemCodes = function(){
		    var input = $("#itemCodeInput").val() || "";

		    var codes = input.split(/[\s,]+/)
		        .map(function(code) {
		            return code.trim();
		        })
		        .filter(function(code) {
		            return code !== "";
		        });

		    codes = [...new Set(codes)];

		    var itemCodes = codes.join(",");

		    $("#itemCodes").val(itemCodes);

		    if (codes.length === 0) {
		        $("#itemCodeDisplay").val("");
		    } else if (codes.length === 1) {
		        $("#itemCodeDisplay").val(codes[0]);
		    } else {
		        $("#itemCodeDisplay").val(codes[0] + " 외 " + (codes.length - 1) + "건");
		    }

		    coverCootargetList.closeItemCodePopup();
		}

		this.clearItemCodes = function(){
		    $("#itemCodeInput").val("");
		    $("#itemCodes").val("");
		    $("#itemCodeDisplay").val("");
		}
		
		this.setItemCodes = function(itemCodes) {
		    $("#itemCodes").val(itemCodes);
		    $("#itemCodeDisplay").val(itemCodes);
		}
		
		this.excelDownload  = function(){
			const exportProps = {
			        fileName: "원산지확인서등록",
			        sheetName: "원산지확인서등록",
			        exportWithStyle: true,
			        progressBar: true,
			        showRowNumColumn: false
			    };

			    AUIGrid.exportToXlsx(
			        coverCootargetList.grid_coverCootargetList_01,
			        exportProps
			    );
		}
		
		this.openWritePopup = function() {
		    var checkedRows = AUIGrid.getCheckedRowItems(coverCootargetList.grid_coverCootargetList_01);

		    if (!checkedRows || checkedRows.length === 0) {
		        alert("하나 이상의 자재를 선택해주세요.");
		        return;
		    }

		    var hsCodeList = [];
		    var itemCodeList = [];

		    var vendorCode = checkedRows[0].item.VENDOR_CODE;
		    var divisionCode = checkedRows[0].item.DIVISION_CODE;

		    checkedRows.forEach(function(row) {
		        if (row.item) {
		            if (row.item.HS_CODE) {
		                hsCodeList.push(row.item.HS_CODE);
		            }

		            if (row.item.ITEM_CODE) {
		                itemCodeList.push(row.item.ITEM_CODE);
		            }
		        }
		    });

		    hsCodeList = [...new Set(hsCodeList)];
		    itemCodeList = [...new Set(itemCodeList)];

		    if (hsCodeList.length === 0) {
		        alert("선택한 자재에 HS CODE가 없습니다.");
		        return;
		    }

		    var hsCodes = hsCodeList.join(",");
		    var itemCodes = itemCodeList.join(",");
		    var cooCertifyNo = checkedRows[0].item.COO_CERTIFY_NO || "";
		    
		    
		    var popupUrl =
		        "/covercootarget_pop"
		        + "?hsCodes=" + encodeURIComponent(hsCodes)
		        + "&itemCodes=" + encodeURIComponent(itemCodes)
		        + "&vendorCode=" + encodeURIComponent(vendorCode)
		        + "&divisionCode=" + encodeURIComponent(divisionCode)
		        + "&cooCertifyNo=" + encodeURIComponent(cooCertifyNo);

		    KpackageOBJ.dialog.open(
		        "previewPopup",
		        "확인서 작성",
		        popupUrl,
		        1200,
		        1000
		    );
		}
	};
	
	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		coverCootargetList.Initialize_viewObject();
	});
</script>

</html>