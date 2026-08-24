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
	    	<form:form id="CootargetList-form" class="s4-form" novalidate="novalidate" action="" method="post">
	    		<input type="hidden" id="company_code" name="company_code" value="${sessionScope._sessionUser.company_code}"/>  
	    		
	    		
	    		<div id="panel-4" class="panel panel-icon">
				    <div class="panel-container show">
				        <div class="panel-content" style="padding: 0;">
				            <div class="row" style="margin: 0; min-height: 110px;">
				
				                <div class="col-3"
				                     style="
				                        padding: 16px 18px 18px;
				                        display: flex;
				                        flex-direction: column;
				                     ">
				                    <div style="
				                        font-size: 12px;
				                        font-weight: 600;
				                        color: #666;
				                        text-align: left;
				                        line-height: 1.4;
				                        margin-bottom: 14px;
				                        white-space: nowrap;
				                    ">
				                        총 구매처 수취율
				                    </div>
				
				                    <div style="
				                        font-size: 30px;
				                        font-weight: 700;
				                        color: #252525;
				                        text-align: center;
				                        line-height: 1.2;
				                    ">
				                        <span id="totalCooGetRate"></span>
				                    </div>
				                </div>
				
				                <div class="col-3"
				                     style="
				                        padding: 16px 18px 18px;
				                        display: flex;
				                        flex-direction: column;
				                     ">
				                    <div style="
				                        font-size: 12px;
				                        font-weight: 600;
				                        color: #666;
				                        text-align: left;
				                        line-height: 1.4;
				                        margin-bottom: 14px;
				                        white-space: nowrap;
				                    ">
				                        비역내 수취 비율
				                    </div>
				
				                    <div style="
				                        font-size: 30px;
				                        font-weight: 700;
				                        color: #252525;
				                        text-align: center;
				                        line-height: 1.2;
				                    ">
				                        <span id="nonOriginRate"></span>
				                    </div>
				                </div>
				
				                <div class="col-3"
				                     style="
				                        padding: 16px 18px 18px;
				                        display: flex;
				                        flex-direction: column;
				                     ">
				                    <div style="
				                        font-size: 12px;
				                        font-weight: 600;
				                        color: #666;
				                        text-align: left;
				                        line-height: 1.4;
				                        margin-bottom: 14px;
				                        white-space: nowrap;
				                    ">
				                        집중관리 대상 수취율
				                    </div>
				
				                    <div style="
				                        font-size: 30px;
				                        font-weight: 700;
				                        color: #252525;
				                        text-align: center;
				                        line-height: 1.2;
				                    ">
				                        <span id="importanceCooGetRate"></span>
				                    </div>
				                </div>
				
				                <div class="col-3"
				                     style="
				                        padding: 16px 18px 18px;
				                        display: flex;
				                        flex-direction: column;
				                     ">
				                    <div style="
				                        font-size: 12px;
				                        font-weight: 600;
				                        color: #666;
				                        text-align: left;
				                        line-height: 1.4;
				                        margin-bottom: 14px;
				                        white-space: nowrap;
				                    ">
				                        집중관리 대상 비역내 수취율
				                    </div>
				
				                    <div style="
				                        font-size: 30px;
				                        font-weight: 700;
				                        color: #252525;
				                        text-align: center;
				                        line-height: 1.2;
				                    ">
				                        <span id="importanceNonOriginRate"></span>
				                    </div>
				                </div>
				
				            </div>
				        </div>
				    </div>
				</div>
	    		
	    		
		    	<div id="panel-4" class="panel panel-icon">
		    		<div class="panel-container show">
						<div class="panel-content">
				            <div class="row">
	                             <div class="col-4" style="padding-right: 40px;">
								    <label class="form-label" for="search_from_date" style="display: block; margin-bottom: 7px;"><spring:message code="입고일자"/></label>
								
								    <div style="display: flex; align-items: center; gap: 16px;">
								        <input class="form-control" id="search_from_date" name="search_from_date" type="date" value="<%= java.time.LocalDate.now().minusMonths(1) %>" style="width: calc(50% - 8px);">
								        <input class="form-control" id="search_to_date" name="search_to_date" type="date" value="<%= java.time.LocalDate.now() %>" style="width: calc(50% - 8px);">
								    </div>
								</div>
	                            
	                            <div class="col-2" style="width: 250px;">
	                                <div class="mb-2">
		                                <div class="row">
		                                    <label class="form-label" for="example-input-border">고객사 </label>
		                                </div>
		                                <div class="row mb-2">
		                                	<div class="col-4" style="width: 180px;">
		                                		<select class="form-select" id="vendor" name="vendor">
		                                            <option value="id.ITEM_CODE"><spring:message code='bominfo.title.ITEM_CODE'/></option>
		                                            <option value="im.ITEM_NAME"><spring:message code='bominfo.title.ITEM_NAME'/></option>
		                                            <option value="v.VENDOR_CODE"><spring:message code='supplyInfo.title.SUPPLY_CODE'/></option>
		                                            <option value="v.VENDOR_NAME"><spring:message code='supplyInfo.title.SUPPLY_NAME'/></option>
		                                        </select>
		                                	</div>
	                                    
	                                	</div>
	                                </div>
	                            </div>
	                            <div class="col-lg-4" style="width: 250px;">
	                            	<div class="row">
	                            		<label class="form-label" for="example-input-border">플랜트 </label>
	                            	</div>
	                                <div class="row mb-2">
	                                	<div class="col-4" style="width: 180px;">
	                                		<select class="form-select" id="plant" name="plant">
	                                            <option value="id.ITEM_CODE"><spring:message code='bominfo.title.ITEM_CODE'/></option>
	                                            <option value="im.ITEM_NAME"><spring:message code='bominfo.title.ITEM_NAME'/></option>
	                                            <option value="v.VENDOR_CODE"><spring:message code='supplyInfo.title.SUPPLY_CODE'/></option>
	                                            <option value="v.VENDOR_NAME"><spring:message code='supplyInfo.title.SUPPLY_NAME'/></option>
	                                        </select>
	                                	</div>
	                                </div>
	                            </div>
	                            			
	                           
	                            
	                            <div class="col">
                                	<button type="button" onclick="javascript:CootargetList.retrieve_GridData();" class="btn btn-sm btn-search search-more waves-effect waves-themed">Search</button>
                                	<button type="button" onclick="javascript:toggleSearchMore(this,'CootargetList_SEARCHMORE');" class="btn btn-xs btn-search-more waves-effect waves-themed">More</button>
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
				    <div class="demo" style="text-align: left;">
				    	&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="CootargetList.thismonth();">
				            This Month
				        </button>
				        <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="CootargetList.threemonth();">
				            3 Month
				        </button>
				        <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="CootargetList.sixmonth();">
				            6 Month
				        </button>
				    </div>
				</div>
	    	</div>
	    	<div class="col-5">
				<div class="frame-wrap">
				    <div class="demo" style="text-align: right;">
				    	
				        <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="CootargetList.excelDownload();">
				            ExcelDownload
				        </button>
																													
				        <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="javascript:KpackageOBJ.dialog.open('previewPopup','수취율 정보','/cootarget_pop',1000,700);">
				            상세팝업
				        </button>
				    </div>
				</div>
	    	</div>
	    </div>

		<div class="row">
	   		<div class="col-12">
		        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		        <div id="oAuiGrid_CootargetList_01" style="width:100%;height:480px; margin:0 auto;"></div>
		    </div>
	    </div>	

	</div>
</body>
<script>
	var CootargetList = new function() {

		// AUIGrid 생성 후 반환 ID
		this.grid_CootargetList_01 = null;

		// 시작점
		this.Initialize_viewObject = function() {
			
			KpackageOBJ.selectbox.create("CootargetList-form", "plant", "/common/retrievePlantCombo", {"OPTION_ALL":"Y"}, "code", "name");
			KpackageOBJ.selectbox.create("CootargetList-form", "vendor", "/common/retrieveVendorCombo", {"OPTION_ALL":"Y"}, "code", "name");
			
			
			// AUIGrid 그리드를 생성합니다.
			CootargetList.createAUIGrid();
			AUIGrid.setGridData(CootargetList.grid_CootargetList_01, CootargetList.data);
			
			CootargetList.retrieve_GridData();
		}

		// AUIGrid 를 생성합니다.
		this.createAUIGrid = function() {
			// 그리드 칼럼 레이아웃 설정
			const columnLayout = [ 
				{ dataField : "division_code",		headerText : "플랜트",          width : 200,		filter: { showIcon: true } ,  style: "aui-center-align"},
				{ dataField : "vendor_code",		headerText : "구매처 코드",      width : 200,	    filter: { showIcon: true } , style: "aui-right-align"},
				{ dataField : "vendor_name", 		headerText : "구매처명",     	  width : "auto",	filter: { showIcon: true } ,  style: "aui-center-align" },
				{ dataField : "total_cnt", 			headerText : "총 품목 수 ",     width : 140,		filter: { showIcon: false } , style: "aui-right-align" },
				{ dataField : "coo_get_cnt", 		headerText : "수취 품목 수",     width : 140,		filter: { showIcon: false } , style: "aui-right-align"},
				{ dataField : "coo_get_rate", 		headerText : "수취율",     	  width : 140,		filter: { showIcon: false } , style: "aui-right-align", dataType: "numeric",
				    labelFunction: function(rowIndex, columnIndex, value) {
				        return value == null ? "" : value + "%";
				    }},
				{ dataField : "importance_mgt_yn", 		headerText : "집중관리 대상",     width : 140,		filter: { showIcon: false } , style: "aui-center-align" }
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

			// 실제로 #oAuiGrid_CootargetList_01 에 그리드 생성
			// 파라메터 : Grid Div ID, 컬럼레이아웃, 그리드속성, 그리드타입(없음 : null or "", 행번호 : number ,체크박스 : check ,라디오 : radio)
			CootargetList.grid_CootargetList_01 = KpackageOBJ.auiGrid.create("oAuiGrid_CootargetList_01", columnLayout, gridProps, "check");
			
			
		/* 	// 클릭 이벤트
			AUIGrid.bind(CootargetList.grid_CootargetList_01, "cellClick", function( event ) {
				console.log("rowIndex : " + event.rowIndex + ", columnIndex : " + event.columnIndex + " clicked");
			});
			
			// 더블클릭 이벤트 
			AUIGrid.bind(CootargetList.grid_CootargetList_01, "cellDoubleClick", function( event ) {
				console.log("rowIndex : " + event.rowIndex + ", columnIndex : " + event.columnIndex + " dbl clicked");
			}); */
			
		};
		
		this.retrieve_GridData = function(){
			   var params = {
				        COMPANY_CODE: $("#company_code").val(),
				        plant: $("#plant").val(),
				        vendor: $("#vendor").val(),
				        search_from_date: $("#search_from_date").val().replace(/-/g, ""),
				        search_to_date: $("#search_to_date").val().replace(/-/g, ""),
				    };

				KpackageOBJ.auiGrid.retrieve(CootargetList.grid_CootargetList_01, "/cootarget/retrieveCootargetList", params);
				$.ajax({
				    url: "/cootarget/retrieveCootargetDashboard",
				    type: "POST",
				    contentType: "application/json",
				    data: JSON.stringify(params),
				    success: function (res) {
				        const result = typeof res === "string" ? JSON.parse(res) : res;
				        const data = result.value[0];

				        $("#totalCooGetRate").text(data.total_coo_get_rate + "%");
				        $("#nonOriginRate").text(data.non_origin_rate + "%");
				        $("#importanceCooGetRate").text(data.importance_coo_get_rate + "%");
				        $("#importanceNonOriginRate").text(data.importance_non_origin_rate + "%");
				    }
				});
			 
		}
		
		
		this.thismonth = function(){
			$("#search_from_date").val("<%= java.time.LocalDate.now().withDayOfMonth(1) %>") ;
		}
		
		this.threemonth = function(){
			$("#search_from_date").val("<%= java.time.LocalDate.now().minusMonths(3) %>") ;
		}
		
		this.sixmonth = function(){
			$("#search_from_date").val("<%= java.time.LocalDate.now().minusMonths(6) %>") ;
		}
		
		this.excelDownload  = function(){
			const exportProps = {
			        fileName: "원산지확인서_수취현황",
			        sheetName: "수취현황",
			        exportWithStyle: true,
			        progressBar: true,
			        showRowNumColumn: false
			    };

			    AUIGrid.exportToXlsx(
			        CootargetList.grid_CootargetList_01,
			        exportProps
			    );
		}
		
		
	};
	
	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		CootargetList.Initialize_viewObject();
	});
</script>

</html>