<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	.form-control {
	    height: 45px;
	    padding-left: 25px;
	}
</style>
</head>
<body>
	<div class="content-wrapper">
	    <div class="main-content layout-trimmed profile-page position-relative sortable-inactive">
	        <!-- Profile Header Background -->
	        <div class="profile-page-header-underlay bg-info-gradient bg-info-500"></div>
	        <!-- Main Profile Content -->
	        <div class="container-xl position-relative">
	            <!-- Profile Header Section -->
	            <div class="profile-page-header rounded-3 body-bg shadow-3 mb-4">
	                <div class="d-flex flex-column flex-md-row align-items-center position-relative p-4">
	                    <!-- Profile Info -->
	                    <div class="profile-page-header-info ms-md-4 text-center text-md-start">
	                        <h1 class="fs-xxl fw-700 mb-2"><span id="sp_company_name">Company Name</span></h1>
	                        <p class="text-muted mb-2"><span id="sp_address_name">Address Eng</span></p>
	                        <div class="d-flex flex-wrap gap-2 justify-content-center justify-content-md-start">
	                            <span class="badge bg-primary-100 text-primary"><span id="sp_officer_name">sp_officer_name</span></span>
	                            <span class="badge bg-primary-100 text-primary"><span id="sp_officer_phone">sp_officer_phone</span></span>
	                            <span class="badge bg-primary-100 text-primary"><span id="sp_officer_email">sp_officer_email</span></span>
	                        </div>
	                    </div>
	                </div>
	                <!-- Tab pagenation -->
	                <div class="profile-page-nav border-top">
	                    <ul class="nav nav-tabs-clean" role="tablist">
	                        <li class="nav-item" role="presentation">
	                            <a class="nav-link active" href="#profile-about" data-bs-toggle="tab" aria-selected="false" role="tab" tabindex="-1"><i class="sa sa-map"></i>&nbsp; 회사정보 </a>
	                        </li>
	                        <li class="nav-item" role="presentation">
	                            <a class="nav-link" href="#profile-news" data-bs-toggle="tab" aria-selected="true" role="tab"><i class="sa sa-calculator"></i>&nbsp; Options </a>
	                        </li>
	                    </ul>
	                </div>
	            </div>
	            <!-- Content -->
	            <div class="tab-content">
	                <!-- Company Information Tab -->
	
	                <div class="tab-pane fade active show" id="profile-about" role="tabpanel">
	                    <div class="row">
	                        <div class="col-lg-12">
	                            <!-- About Me Section -->
	                            <div class="panel mb-12">
	                                <div class="panel-hdr d-flex justify-content-between align-items-center pe-3">
	                                    <h2></h2>
	                                    <button class="btn btn-outline-default btn-xs px-2 waves-effect waves-themed" data-bs-toggle="modal" data-bs-target="#addNewsModal"> Save </button>
	                                </div>
	                                <div class="panel-container">
	                                    <div class="panel-content">
	                                        <form:form id="SAMPLE000-form" novalidate="novalidate" class="s4-form" onsubmit="return false;" method="post">
												<div class="row">
                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label class="form-label" for="example-input-square">회사코드</label>
                                                            <input type="text" id="example-input-square" class="form-control rounded-pill" placeholder="Square borders">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label class="form-label" for="example-input-pill">회사코드(HR)</label>
                                                            <input type="text" id="example-input-pill" class="form-control rounded-pill" placeholder="Rounded pill">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label class="form-label" for="example-input-pill">대표자명</label>
                                                            <input type="text" id="example-input-pill" class="form-control rounded-pill" placeholder="Rounded pill">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label class="form-label" for="example-input-square">대표자 영문명</label>
                                                            <input type="text" id="example-input-square" class="form-control rounded-pill" placeholder="Square borders">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4">
                                                        <div class="mb-3">
                                                            <label class="form-label" for="example-input-square">회사명</label>
                                                            <input type="text" id="example-input-square" class="form-control rounded-pill" placeholder="Square borders">
                                                        </div>
                                                    </div>                                                    
                                                    <div class="col-lg-4">
                                                        <div class="mb-3">
                                                            <label class="form-label" for="example-input-pill">회사명(영문)</label>
                                                            <input type="text" id="example-input-pill" class="form-control rounded-pill" placeholder="Rounded pill">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4">
                                                        <div class="mb-3">
                                                            <label class="form-label" for="example-input-square">회사명(로컬)</label>
                                                            <input type="text" id="example-input-square" class="form-control rounded-pill" placeholder="Square borders">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label class="form-label" for="example-input-pill">주소</label>
                                                            <input type="text" id="example-input-pill" class="form-control rounded-pill" placeholder="Rounded pill">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label class="form-label" for="example-input-pill">영문주소</label>
                                                            <input type="text" id="example-input-pill" class="form-control rounded-pill" placeholder="Rounded pill">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label class="form-label" for="example-input-pill">회사전화번호</label>
                                                            <input type="text" id="example-input-pill" class="form-control rounded-pill" placeholder="Rounded pill">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label class="form-label" for="example-input-pill">회사팩스번호</label>
                                                            <input type="text" id="example-input-pill" class="form-control rounded-pill" placeholder="Rounded pill">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label class="form-label" for="example-input-pill">담당자 전화번호</label>
                                                            <input type="text" id="example-input-pill" class="form-control rounded-pill" placeholder="Rounded pill">
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label class="form-label" for="example-input-square">담당자 이메일</label>
                                                            <input type="text" id="example-input-square" class="form-control rounded-pill" placeholder="Square borders">
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label class="form-label" for="example-input-square">원산지인증수출자번호</label>
                                                            <input type="text" id="example-input-square" class="form-control rounded-pill" placeholder="Square borders">
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label class="form-label" for="example-input-square">수불부 자동생성</label>
                                                            <input type="text" id="example-input-square" class="form-control rounded-pill" placeholder="Square borders">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label class="form-label" for="example-input-square">재고회전기간</label>
                                                            <input type="text" id="example-input-square" class="form-control rounded-pill" placeholder="Square borders">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label class="form-label" for="example-input-square">세번변경 판정만 수행</label>
                                                            <input type="text" id="example-input-square" class="form-control rounded-pill" placeholder="Square borders">
                                                        </div>
                                                    </div>
                                                </div>
	                                        </form:form>
	
	                                    </div>
	                                </div>
	                            </div>
	                            <!-- Experience Section -->
	                        </div>
	                    </div>
	                </div>
	                <!-- Options Tab -->
	                <div class="tab-pane fade" id="profile-news" role="tabpanel">
	                    <div class="row">
	                        <div class="col-lg-12">
	                            <div class="panel mb-12">
	                                <div class="panel-hdr d-flex justify-content-between align-items-center pe-3">
	                                    <h2>Options</h2>
	                                    <button class="btn btn-outline-default btn-xs px-2 waves-effect waves-themed" data-bs-toggle="modal" data-bs-target="#addNewsModal"> Save </button>
	                                </div>
	                                <div class="panel-container">
	                                    <div class="panel-content">
	                                        <form:form id="SAMPLE000-form" novalidate="novalidate" class="s4-form" onsubmit="return false;" method="post">
												<div class="row">
                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                        	<h5 class="frame-heading">버퍼설정기준</h5>
                                                            <div class="frame-wrap demo-radio">
			                                                    <div class="form-check form-check-inline">
			                                                        <input type="radio" class="form-check-input" id="defaultInline1Radio" name="inlineDefaultRadiosExample">
			                                                        <label class="form-check-label" for="defaultInline1Radio">회사</label>
			                                                    </div>
			                                                    <div class="form-check form-check-inline">
			                                                        <input type="radio" class="form-check-input" id="defaultInline2Radio" name="inlineDefaultRadiosExample" checked="">
			                                                        <label class="form-check-label" for="defaultInline2Radio">영업조직</label>
			                                                    </div>
			                                                    <div class="form-check form-check-inline">
			                                                        <input type="radio" class="form-check-input" id="defaultInline2Radio" name="inlineDefaultRadiosExample" checked="">
			                                                        <label class="form-check-label" for="defaultInline2Radio">생산플랜트</label>
			                                                    </div>
			                                                    <div class="form-check form-check-inline">
			                                                        <input type="radio" class="form-check-input" id="defaultInline2Radio" name="inlineDefaultRadiosExample" checked="">
			                                                        <label class="form-check-label" for="defaultInline2Radio">제품군</label>
			                                                    </div>
			                                                    <div class="form-check form-check-inline">
			                                                        <input type="radio" class="form-check-input" id="defaultInline2Radio" name="inlineDefaultRadiosExample" checked="">
			                                                        <label class="form-check-label" for="defaultInline2Radio">FTA 협정</label>
			                                                    </div>
			                                                </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <h5 class="frame-heading">수취율 목표</h5>
                                                            <input type="text" id="example-input-pill" class="form-control rounded-pill" placeholder="Rounded pill">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <h5 class="frame-heading">수불부 참조 기간</h5>
                                                            <input type="text" id="example-input-pill" class="form-control rounded-pill" placeholder="Rounded pill">
                                                        </div>
                                                    </div>                                                      
                                                    <div class="col-lg-4">
                                                        <div class="mb-3">
                                                            <h5 class="frame-heading">확인서 등록 기준</h5>
                                                            <div class="frame-wrap demo-radio">
			                                                    <div class="form-check form-check-inline">
			                                                        <input type="radio" class="form-check-input" id="defaultInline1Radio" name="inlineDefaultRadiosExample">
			                                                        <label class="form-check-label" for="defaultInline1Radio">회사</label>
			                                                    </div>
			                                                    <div class="form-check form-check-inline">
			                                                        <input type="radio" class="form-check-input" id="defaultInline2Radio" name="inlineDefaultRadiosExample" checked="">
			                                                        <label class="form-check-label" for="defaultInline2Radio">플랜트</label>
			                                                    </div>
			                                                </div>
                                                        </div>
                                                    </div>
                                                  
                                                    <div class="col-lg-4">
                                                        <div class="mb-3">
                                                            <h5 class="frame-heading">원산지 판정 방법</h5>
                                                            <div class="frame-wrap demo-radio">
			                                                    <div class="form-check form-check-inline">
			                                                        <input type="radio" class="form-check-input" id="defaultInline1Radio" name="inlineDefaultRadiosExample">
			                                                        <label class="form-check-label" for="defaultInline1Radio">재고회전</label>
			                                                    </div>
			                                                    <div class="form-check form-check-inline">
			                                                        <input type="radio" class="form-check-input" id="defaultInline2Radio" name="inlineDefaultRadiosExample" checked="">
			                                                        <label class="form-check-label" for="defaultInline2Radio">재고회전비율</label>
			                                                    </div>
			                                                </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4">
                                                        <div class="mb-3">
                                                            <h5 class="frame-heading">서명권자 플랜트 여부</h5>
                                                            <div class="frame-wrap demo-radio">
			                                                    <div class="form-check form-check-inline">
			                                                        <input type="radio" class="form-check-input" id="defaultInline1Radio" name="inlineDefaultRadiosExample">
			                                                        <label class="form-check-label" for="defaultInline1Radio">Yes</label>
			                                                    </div>
			                                                    <div class="form-check form-check-inline">
			                                                        <input type="radio" class="form-check-input" id="defaultInline2Radio" name="inlineDefaultRadiosExample" checked="">
			                                                        <label class="form-check-label" for="defaultInline2Radio">No</label>
			                                                    </div>
			                                                </div>
                                                        </div>
                                                    </div>
                                                </div>
	                                        </form:form>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <!-- Contact Tab -->
	            </div>
	        </div>
	    </div>
	</div>
<script type="text/javascript">
	
	var SAMPLE000 = new function(){
		
		// Page Object Initialize
		this.initialize_Object = function() {
			
		}
		


		
		this.initialize_TuiGrid = function() {
			
			var colArrayInfo = [
				
				{"header" :"플랜트"              ,"name" :"DIVISION_NAME"           ,"width" : 80      ,"align" : "center"    ,"hidden" : false},
				{"header" :"근거서류번호"        ,"name" :"SUPT_DOC_NO"             ,"width" : 100      ,"align" : "center"    ,"hidden" : false},
				
		    ];
			
			var tools = [ 
			     {icon:"none",  title:"상세조회"        ,text:"상세조회"        ,func:"SAMPLE000.openDetailPage"}
			     ,{icon:"excel", title:"엑셀다운로드"    ,text:"엑셀다운로드"  ,func:"SAMPLE000.excel_SAMPLE000List"}

			  ];
			KpackageOBJ.tuiGrid.setButton("oTui_CsPurchase", tools); // Toobar 생성
			KpackageOBJ.tuiGrid.create("oTui_CsPurchase","/cusven/retrieve_SAMPLE000List", colArrayInfo, null, null, this.oTui_CsPurchase_onDblclick_Handler);
			
		}
		
		this.retrieve_gridData = function() {
			var param = KpackageOBJ.data.makePostData("SAMPLE000-form");
			KpackageOBJ.tuiGrid.retrieve("oTui_CsPurchase","", param);
		}
		
		/* Dbl Click Handler */
		this.oTui_CsPurchase_onDblclick_Handler = function(p_GridId, p_RowKey, p_ColName){
			SAMPLE000.openDetailPage(p_RowKey);
		}
		
		
		/** 상세페이지 호출 */
        this.openDetailPage = function(rowKey){
            var rowData = KpackageOBJ.tuiGrid.getRowValues("oTui_CsPurchase", rowKey);
            
            var getParams = "?DIALOG_ID="           + "dialog_SAMPLE00001"
                            + "&PGMID="             +  "SAMPLE00001"
                            + "&P_SUPT_DOC_NO="     +  rowData.SUPT_DOC_NO
                            + "&P_SUPT_DOC_CODE="   +  rowData.SUPT_DOC_CODE
                            + "&P_DIVISION_CODE="   +  rowData.DIVISION_CODE
                            + "&P_SUPT_DATE="       +  rowData.SUPT_DATE
                            + "&P_ATTRIBUTE01="     +  rowData.ATTRIBUTE01
                            + "&P_CODE_NM="         +  rowData.CODE_NM
                            + "&P_ITEM_CNT="        +  rowData.ITEM_CNT
                            + "&P_SUM_QY="          +  rowData.SUM_QY
                            + "&P_SUM_AMOUNT="      +  rowData.SUM_AMOUNT
                            ;
                            
            KpackageOBJ.dialog.open("dialog_SAMPLE00001", "고객사 구매확인서 상세", "/cv-00101" + getParams, 1145, 480);
            
        }
	}
	
	
	$(document).ready(function() {
		pageSetUp();				// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		//SAMPLE000.initialize_Object(); 		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		//SAMPLE000.initialize_TuiGrid();		 
		
		
	});
	
</script>
</body>
</html>