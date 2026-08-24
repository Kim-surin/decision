<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>


</head>
<body>
	<div class="content-wrapper">
		<div class="row">
			<div class="content-wrapper col-3">
				<h1 class="subheader-title mb-1">회사관리</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item" aria-current="page">기초정보관리</li>
						<li class="breadcrumb-item active" aria-current="page">회사관리</li>
					</ol>
				</nav>
			</div>
			<div class="row col-9"></div>
	    </div>
	    <div class="row">
	    	<div class="col-3">
		    	<div id="panel-4" class="panel panel-icon">
		    		<div class="panel-container show">
						<div class="panel-content">
				            <div class="row">
	                            <div id="oAuiGrid_BASIS000_01" style="width:90%;height:100%; margin:0 auto;"></div>
	                        </div>
					    </div>		    		
		    		</div>
				</div>
	    	</div>
	    	<!-- 회사정보  -->
	    	<div id="oCompanyLayer" class="col-9  d-none">
	    		<div class="row">
	    			<div class="col-6">
	    				<h3 id="oCompanyMgmt_title" class="subheader-title" style="font-size: 1.3rem;margin-bottom: 0px;" >
	    					Company Name ( Code )
	    				</h3>
	    			</div>
	    			<div class="frame-wrap col-6">
					    <div class="demo" style="text-align: right;">
					        <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="javascript:BASIS000.updateCompanyDivisionFormData('COMPANY');">변경사항 저장</button>
					    </div>
					</div>
	    		</div>
	    		
		    	<form:form id="BASIS000-comp-form" class="s4-form" novalidate="novalidate" action="" method="post">
			    	<div id="panel-4" class="panel panel-icon">
			    		<div class="panel-container show">
							<div class="panel-content">
								<div class="row">
								    <div class="mb-2 col-3 d-none">
								        <label class="form-label" for="company_code">회사 코드 <span class="text-danger">*</span></label>
								        <input type="text" id="company_code" name="company_code" class="form-control" maxlength="20" required>
								    </div>
								
								    <div class="mb-2 col-3 d-none">
								        <label class="form-label" for="company_name">회사명 <span class="text-danger">*</span></label>
								        <input type="text" id="company_name" name="company_name" class="form-control" maxlength="200" required>
								    </div>
								
								    <div class="mb-2 col-3 d-none">
								        <label class="form-label" for="company_name_eng">영문 회사명</label>
								        <input type="text" id="company_name_eng" name="company_name_eng" class="form-control" maxlength="200">
								    </div>
								
								    <div class="mb-2 col-3 d-none">
								        <label class="form-label" for="company_name_loc">현지어 회사명</label>
								        <input type="text" id="company_name_loc" name="company_name_loc" class="form-control" maxlength="200">
								    </div>
								
								    <div class="mb-2 col-3">
								        <label class="form-label" for="officer_name">담당자명(대표자명)</label>
								        <input type="text" id="officer_name" name="officer_name" class="form-control" maxlength="50">
								    </div>
								
								    <div class="mb-2 col-3">
								        <label class="form-label" for="officer_name_eng">담당자 영문명(영문 대표자명)</label>
								        <input type="text" id="officer_name_eng" name="officer_name_eng" class="form-control" maxlength="50">
								    </div>
								
								    <div class="mb-2 col-3">
								        <label class="form-label" for="officer_phone_no">담당자 전화번호</label>
								        <input type="text" id="officer_phone_no" name="officer_phone_no" class="form-control" maxlength="20">
								    </div>
								
								    <div class="mb-2 col-3">
								        <label class="form-label" for="officer_email">담당자 이메일</label>
								        <input type="email" id="officer_email" name="officer_email" class="form-control" maxlength="50">
								    </div>
								
								    <div class="mb-2 col-3">
								        <label class="form-label" for="business_no">사업자등록번호</label>
								        <input type="text" id="business_no" name="business_no" class="form-control" maxlength="15">
								    </div>
								    								
								    <div class="mb-2 col-3">
								        <label class="form-label" for="com_phone_no">회사 전화번호</label>
								        <input type="text" id="com_phone_no" name="com_phone_no" class="form-control" maxlength="20">
								    </div>
								
								    <div class="mb-2 col-3">
								        <label class="form-label" for="com_fax_no">회사 팩스번호</label>
								        <input type="text" id="com_fax_no" name="com_fax_no" class="form-control" maxlength="20">
								    </div>
								
								    <div class="mb-2 col-3"></div>
								    
								    <div class="mb-2 col-2">
								        <label class="form-label" for="zip_code">우편번호</label>
								        <input type="text" id="zip_code" name="zip_code" class="form-control" maxlength="7">
								    </div>					
								    			
								    <div class="mb-2 col-10">
								        <label class="form-label" for="address">주소</label>
								        <input type="text" id="address" name="address" class="form-control" maxlength="200">
								    </div>
								
								    <div class="mb-2 col-12">
								        <label class="form-label" for="address_eng">영문 주소</label>
								        <input type="text" id="address_eng" name="address_eng" class="form-control" maxlength="500">
								    </div>
								
								    <div class="mb-2 col-3">
								        <label class="form-label" for="company_use_yn">회사 사용 여부</label>
								        <select id="company_use_yn" name="company_use_yn" class="form-select">
								            <option value="">선택</option>
								            <option value="Y">사용</option>
								            <option value="N">사용 안함</option>
								        </select>
								    </div>
								
								    <div class="mb-2 col-3">
								        <label class="form-label" for="ctc_decision_only_yn">세번변경 판정만 수행 여부</label>
								        <select id="ctc_decision_only_yn" name="ctc_decision_only_yn" class="form-select">
								            <option value="">선택</option>
								            <option value="Y">예</option>
								            <option value="N" selected>아니오</option>
								        </select>
								    </div>
								</div>
								
								<div class="row  mt-3">
									<hr class="col-5" style="border-bottom: 1px dashed rgba(0, 0, 0, 0.7);">
									<h5 class="col-2 text-center"> 회사 옵션 설정 </h5>
									<hr class="col-5" style="border-bottom: 1px dashed rgba(0, 0, 0, 0.7);">
	                                <div class="col-auto ">
	                                    <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
	                                        <a class="nav-link d-flex align-items-center active" id="v-pills-home-tab" data-bs-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true" tabindex="-1">
	                                            <i class="sa sa-home me-2"></i>
	                                            <span class="hidden-sm-down ms-1"> 인증수출자 번호</span>
	                                        </a>
	                                        <a class="nav-link d-flex align-items-center" id="v-pills-profile-tab" onclick="javascript:KpackageOBJ.auiGrid.resize(BASIS000.grid_BASIS000_02);" data-bs-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="false" tabindex="-1">
	                                            <i class="sa sa-user me-2"></i>
	                                            <span class="hidden-sm-down ms-1"> 회사 버퍼 설정</span>
	                                        </a>
	                                        <a class="nav-link d-flex align-items-center" id="v-pills-messages-tab" data-bs-toggle="pill" href="#v-pills-messages" role="tab" aria-controls="v-pills-messages" aria-selected="false" tabindex="-1">
	                                            <i class="sa sa-envelope me-2"></i>
	                                            <span class="hidden-sm-down ms-1"> 수불부 설정</span>
	                                        </a>
	                                        <a class="nav-link d-flex align-items-center " id="v-pills-settings-tab" data-bs-toggle="pill" href="#v-pills-settings" role="tab" aria-controls="v-pills-settings" aria-selected="false">
	                                            <i class="sa sa-settings me-2"></i>
	                                            <span class="hidden-sm-down ms-1"> 확인서 등록 기준</span>
	                                        </a>
	                                    </div>
	                                </div>
	                                <div class="col">
	                                    <div class="tab-content" id="v-pills-tabContent">
	                                        <div class="tab-pane fade active show" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
	                                            <h4>
	                                                인증수출자 번호란
	                                            </h4>
	                                            <ul class="notification">
	                                                <li>
	                                                    <span class="d-flex flex-column flex-1">
															<span class="name">관세당국으로부터 인증수출자 자격을 부여받은 기업에 발급되는 고유번호로, FTA 원산지​신고서 작성 및 인증수출자 자격 확인에 사용됩니다.</span>
														</span>
	                                                </li>
	                                                <li>
	                                                	<div class="row">
	                                                		
	                                                		<div class="mb-2 col-3">
														        <label class="form-label" for="co_certified_exporter_yn">원산지 인증수출자 여부 <span class="text-danger">*</span></label>
														        <select id="co_certified_exporter_yn" name="co_certified_exporter_yn" class="form-select" required>
														            <option value="N">아니오</option>
														            <option value="Y">예</option>
														        </select>
														    </div>
														    <div class="mb-2 col-3">
														        <label class="form-label" for="certification_type">원산지 인증수출자 인증타입</label>
														        <select id="certification_type" name="certification_type" class="form-select">
														            <option value="">선택</option>
														            <option value="C">사업장별 인증</option>
														            <option value="I">품목별 인증</option>
														        </select>
														    </div>
															<div class="mb-2 col-3">
																<label class="form-label" for="certification_no">원산지 인증수출자 번호</label>
														        <input type="text" id="certification_no" name="certification_no" class="form-control" maxlength="50">
														    </div>
														    <div class="col-3" style="margin-top: 24px;">
														    	<div class="demo" style="text-align: left;">
															        <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="javascript:BASIS000.updateCertificationInfo();">인증수출자 정보 저장</button>
															    </div>
														    </div>
	                                                	</div>
	                                                </li>
	                                            </ul>
	                                        </div>
	                                        <div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
	                                            <h4>
	                                                회사버퍼 설정 기준
	                                            </h4>
	                                            <div class="d-flex flex-row rounded-top mb-2 align-items-center">
												    <span class="me-2">
												        <select id="bf_company_option" name="bf_company_option" class="form-select">
												            <option value="COM" selected>회사</option>
												            <option value="DIV">플랜트</option>
												            <option value="FTA">협정</option>
												        </select>
												    </span>
												
												    <div class="info-card-text flex-grow-1">
												        회사, 플렌트, 협정별 판정시 사용되는 버퍼를 설정할 수 있습니다.
												    </div>
												
												    <div class="ms-auto text-end">												        
												    	<button type="button" onclick="javascript:BASIS000.updateCompanyBuffer()" class="btn btn-sm btn-secondary waves-effect waves-themed">
												            버퍼 저장
												        </button>
												    </div>
												</div>
	                                            <div class="row">
	                                            	<div class="col-12">
												        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
												        <div id="oAuiGrid_BASIS000_02" style="width:100%;height:270px; margin:0 auto;"></div>
												    </div>
	                                            </div>
	                                            
	                                        </div>
	
	                                        <div class="tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
	                                            <h4>
	                                                수불부 설정
	                                            </h4>
	                                            <ul class="notification">
	                                                <li>
	                                                    <span class="d-flex flex-column flex-1">
															<span class="name">수불부를 인터페이스 하는 경우 수불부 사용여부 값을 Y로 설정합니다. </span>
															<span class="name">수불부를 인터페이스 하지 않는 경우 수불부 사용여부 값을 N로 설정합니다. 기초 수불부 참조 기간을 입력해야합니다.</span>
														</span>
	                                                </li>
	                                                <li>
	                                                	<div class="row">
	                                                		<div class="mb-2 col-3">
														        <label class="form-label" for="material_use_yn">수불부 사용 여부</label>
														        <select id="material_use_yn" name="material_use_yn" class="form-select">
														            <option value="Y">사용</option>
														            <option value="N">사용 안함</option>
														        </select>
														    </div>
															<div class="mb-2 col-3">
																<label class="form-label" for="basic_aging_period">기초 수불부 참조 기간</label>
														        <input type="text" id="basic_aging_period" name="basic_aging_period" class="form-control" maxlength="2">
														    </div>
														    <div class="col-3">
														    	<div class="demo" style="text-align: left;margin-top: 24px;">
															        <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="javascript:BASIS000.updateCompanyMaOption();">수불부 정보 저장</button>
															    </div>
														    </div>
	                                                	</div>
	                                                </li>
	                                            </ul>
	                                        </div>
	
	                                        <div class="tab-pane fade" id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">
	                                            <h4>확인서 등록 기준</h4>
	                                            <ul class="notification">
	                                                <li>
	                                                    <span class="d-flex flex-column flex-1">
															<span class="name">회사 : 수취한 확인서가 모든플렌트에 적용됩니다.</span>
															<span class="name">플랜트 : 수취한 확인서가 플렌트 별로 적용됩니다.</span>
														</span>
	                                                </li>
	                                                <li>
	                                                	<div class="row">
	                                                		<div class="mb-2 col-3">
														        <label class="form-label" for="material_use_yn">확인서 등록 기준</label>
														        <select id="ru_company_option" name="ru_company_option" class="form-select">
														            <option value="A">회사별 적용</option>
														            <option value="M">플렌트별 적용</option>
														        </select>
														    </div>
														    <div class="col-3">
														    	<div class="demo" style="text-align: left;margin-top: 24px;">
															        <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="javascript:BASIS000.updateCompanyRuOption();">확인서 등록기준 저장</button>
															    </div>
														    </div>
														</div>
													</li>
												</ul>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
						    </div>		    		
			    		</div>
					</div>
				</form:form>	    	
	    	</div>
	    	<!-- 플랜트 정보  -->
	    	<div id="oDivisionLayer" class="col-9">
	    		<div class="row">
	    			<div class="col-6">
	    				<h3 id="oDvisionMgmt_title" class="subheader-title" style="font-size: 1.3rem;margin-bottom: 0px;" >Division Name ( Code )</h3>
	    			</div>
	    			<div class="frame-wrap col-6">
					    <div class="demo" style="text-align: right;">
					        <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="javascript:BASIS000.updateCompanyDivisionFormData('DIVISION');">변경사항 저장</button>
					    </div>
					</div>
	    		</div>
	    		
		    	<form:form id="BASIS000-div-form" class="s4-form" novalidate="novalidate" action="" method="post">
			    	<div id="panel-4" class="panel panel-icon">
			    		<div class="panel-container show">
							<div class="panel-content">
								<div class="row">
								    <div class="mb-2 col-3 d-none">
								        <label class="form-label" for="company_code">회사 코드 <span class="text-danger">*</span></label>
								        <input type="text" id="company_code" name="company_code" class="form-control" maxlength="20" required>
								    </div>
								    
								    <div class="mb-2 col-3 d-none">
								        <label class="form-label" for="division_code">플렌트 코드 <span class="text-danger">*</span></label>
								        <input type="text" id="division_code" name="division_code" class="form-control" maxlength="20" required>
								    </div>
								
								    <div class="mb-2 col-4">
								        <label class="form-label" for="division_name">플렌트명 <span class="text-danger">*</span></label>
								        <input type="text" id="division_name" name="division_name" class="form-control" maxlength="200" required>
								    </div>
								
								    <div class="mb-2 col-4">
								        <label class="form-label" for="division_name_eng">영문 플렌트명</label>
								        <input type="text" id="division_name_eng" name="division_name_eng" class="form-control" maxlength="200">
								    </div>
								
								    <div class="mb-2 col-4">
								        <label class="form-label" for="business_no">사업자등록번호</label>
								        <input type="text" id="business_no" name="business_no" class="form-control" maxlength="15">
								    </div>
								    								
								    <div class="mb-2 col-4">
								        <label class="form-label" for="com_phone_no">회사 전화번호</label>
								        <input type="text" id="division_phone_no" name="division_phone_no" class="form-control" maxlength="20">
								    </div>
								
								    <div class="mb-2 col-4">
								        <label class="form-label" for="com_fax_no">회사 팩스번호</label>
								        <input type="text" id="division_fax_no" name="division_fax_no" class="form-control" maxlength="20">
								    </div>
								    
								    <div class="mb-2 col-4">
								        <label class="form-label" for="ctc_decision_only_yn">플렌트 유형</label>
								        <select id="division_type" name="division_type" class="form-select">
								            <option value="A">공용</option>
								            <option value="P">생산</option>
								            <option value="S">영업</option>
								        </select>
								    </div>
								    
								    <div class="mb-2 col-1">
								        <label class="form-label" for="zip_code">우편번호</label>
								        <input type="text" id="zip_code" name="zip_code" class="form-control" maxlength="7">
								    </div>					
								    			
								    <div class="mb-2 col-5">
								        <label class="form-label" for="address">주소</label>
								        <input type="text" id="address" name="address" class="form-control" maxlength="200">
								    </div>
								
								    <div class="mb-2 col-6">
								        <label class="form-label" for="address_eng">영문 주소</label>
								        <input type="text" id="address_eng" name="address_eng" class="form-control" maxlength="500">
								    </div>
								
								    <div class="mb-2 col-3">
								        <label class="form-label" for="company_use_yn">플랜트 사용 여부</label>
								        <select id="status" name="status" class="form-select">
								            <option value="Y">사용</option>
								            <option value="N">사용 안함</option>
								        </select>
								    </div>
								</div>
						    </div>		    		
			    		</div>
					</div>
				</form:form>	    	
	    	</div>
	    </div>
	</div>
</body>
<script>
	var BASIS000 = new function() {

		// AUIGrid 생성 후 반환 ID
		this.grid_BASIS000_01 = null;
		this.grid_BASIS000_02 = null;

		// 시작점
		this.Initialize_viewObject = function() {
			
			BASIS000.createAUIGrid_01(); // AUIGrid 그리드를 생성합니다.
			BASIS000.retrieve_GridData_grid_BASIS000_01();
			
			BASIS000.createAUIGrid_02(); // AUIGrid 그리드를 생성합니다.

		}

		// AUIGrid 를 생성합니다.
		this.createAUIGrid_01 = function() {
			// 그리드 칼럼 레이아웃 설정
			const columnLayout = [ 
				{ dataField : "company_code",	headerText : "코드",        width : 120},
				{ dataField : "company_name",	headerText : "이름",        width : 140}
				
			];

			// 그리드 속성 설정
			const gridProps = {
				//추가속성이 필요한 경우 작성 
				//editable : true, // 그리드 수정 모드 
				selectionMode: "singleRow", // singleRow 선택모드
				displayTreeOpen: true, // 최초 보여질 때 모두 열린 상태로 출력 여부
				usePaging: false,   // 페이징 사용
				pageRowCount: 20,  // 페이지 행 개수 select UI 출력 여부 (기본값 : false)
				showPageRowSelect: false	// 페이지 카운트 표시 여부	
				
			};

			// 실제로 #oAuiGrid_BASIS000_01 에 그리드 생성
			// 파라메터 : Grid Div ID, 컬럼레이아웃, 그리드속성, 그리드타입(없음 : null or "", 행번호 : number ,체크박스 : check ,라디오 : radio)
			BASIS000.grid_BASIS000_01 = KpackageOBJ.auiGrid.create("oAuiGrid_BASIS000_01", columnLayout, gridProps, "");
			
			
			// 클릭 이벤트
			AUIGrid.bind(BASIS000.grid_BASIS000_01, "cellClick", function( event ) {
				
				console.log("rowIndex : " + event.rowIndex + ", columnIndex : " + event.columnIndex + " clicked");
			});
			
			// 더블클릭 이벤트 
			AUIGrid.bind(BASIS000.grid_BASIS000_01, "cellDoubleClick", function( event ) {
				var dblClick_Depth = event.item._$depth;
				var data = event.item;
				if(1 == dblClick_Depth){
					$("#oCompanyLayer").removeClass('d-none');
					$("#oDivisionLayer").addClass('d-none');
					
					$("#oCompanyMgmt_title").html(data["company_name"] + " ("+ data["company_code"] +")");
					BASIS000.retrieveCompanyDivisionFormData("COMPANY");
				}else{
					$("#oCompanyLayer").addClass('d-none');
					$("#oDivisionLayer").removeClass('d-none');
					
					
					$("#oDvisionMgmt_title").html("플렌트 : " + data["company_name"] + " ("+ data["company_code"] +")");
					BASIS000.retrieveCompanyDivisionFormData("DIVISION");
				}
				
				console.log("rowIndex : " + event.rowIndex + ", columnIndex : " + event.columnIndex + " dbl clicked");
			});
			
			/* 데이터의 로드가 완료되면 발생 이벤트 */
			AUIGrid.bind(BASIS000.grid_BASIS000_01, "ready", function (event) {
				AUIGrid.setSelectionByIndex(event.pid, 0, 0); // 첫번째 셀 선택되도록 지정
				var data = KpackageOBJ.auiGrid.getSelectRowData(BASIS000.grid_BASIS000_01);
				$("#oCompanyLayer").removeClass('d-none');
				$("#oDivisionLayer").addClass('d-none');
				$("#oCompanyMgmt_title").html(data["company_name"] + " ("+ data["company_code"] +")");
				
				BASIS000.retrieveCompanyDivisionFormData("COMPANY");
			});
		};
		
	
		this.retrieveCompanyDivisionFormData = function(pSearchDivCode){
		
			if (pSearchDivCode == null && String(pSearchDivCode).trim() === '') {
				return false;
			}
			var data = KpackageOBJ.auiGrid.getSelectRowData(BASIS000.grid_BASIS000_01);
			var params = {
					"search_type" : pSearchDivCode
					,"p_param_code" : data["company_code"]	// depth가 2일때는 
			};
			
			KpackageOBJ.ajax.doSubmit("/basis/retrieveCompanyDivisionFormData", params, BASIS000.retrieveCompanyDivisionFormData_Handler);   
			
		}
		
		this.retrieveCompanyDivisionFormData_Handler = function(result){
			var data = result.value;
			var targetFormId = "BASIS000-comp-form";
			if("COMPANY" == data["search_type"]){
				targetFormId = "BASIS000-comp-form";
			}else{
				targetFormId = "BASIS000-div-form";
			}
			KpackageOBJ.data.setFormData(targetFormId, data);
			
			//회사버퍼설정 데이터 로드 
			BASIS000.retrieveBufferDatalist();
		}
		
		this.updateCompanyDivisionFormData = function(pSearchDivCode){
			
			if (pSearchDivCode == null && String(pSearchDivCode).trim() === '') {
				return false;
			}
			var params = null;
			
			if("COMPANY" == pSearchDivCode){
				params = KpackageOBJ.data.makePostData("BASIS000-comp-form");	
			}else{
				params = KpackageOBJ.data.makePostData("BASIS000-div-form");
			}
			
			params["search_type"] = pSearchDivCode;

			
			KpackageOBJ.ajax.doSubmit("/basis/updateCompanyDivisionFormData", params, BASIS000.commonActionResult_CallbackHandler);   
			
		}
		
		this.commonActionResult_CallbackHandler = function(result){
			var data = result.value;
			alert(result.message);
		}
		
		this.retrieveBufferDatalist = function(){
			const bfCompanyOption = KpackageOBJ.object.getFormValue("BASIS000-comp-form", "bf_company_option");
			
			if (bfCompanyOption) {
			    switch (bfCompanyOption) {
			        case "COM":
			            console.log("회사 기준 처리");
			            break;
			        case "DIV":
			            console.log("사업부/플랜트 기준 처리");
			            break;
			        case "FTA":
			            console.log("협정 기준 처리");
			            break;
			        default:
			            console.log("정의되지 않은 값:", bfCompanyOption);
			            break;
			    }
			    var parmas = {
			    		"p_bf_company_option" : bfCompanyOption
			    };
			    KpackageOBJ.auiGrid.retrieve(BASIS000.grid_BASIS000_02, "/basis/retrieveBufferDatalist", parmas);
			}
		}
		
		
		this.createAUIGrid_02 = function() {
			// 그리드 칼럼 레이아웃 설정
			const columnLayout = [ 
				{ dataField : "target_code",		headerText : "TARGET_CODE",		width : 120, visible : false},
				{ dataField : "target_name",		headerText : "버퍼 대상",			width : 120,		filter: { showIcon: true } , editable:false },
				{ dataField : "rvc_rate",			headerText : "부가가치율 버퍼(%)",  width : 140},
				{ dataField : "de_minimis_rate",	headerText : "미소기준 버퍼(%)",	width : 140}
				
			];

			// 그리드 속성 설정
			const gridProps = {
				//추가속성이 필요한 경우 작성 
				editable : true, // 그리드 수정 모드 
				usePaging: false,   // 페이징 사용
				pageRowCount: 20,  // 페이지 행 개수 select UI 출력 여부 (기본값 : false)
				showPageRowSelect: false,	// 페이지 카운트 표시 여부
				fillColumnSizeMode : true // 가로 스크롤 없이 가득차게
			};

			// 실제로 #oAuiGrid_BASIS000_01 에 그리드 생성
			// 파라메터 : Grid Div ID, 컬럼레이아웃, 그리드속성, 그리드타입(없음 : null or "", 행번호 : number ,체크박스 : check ,라디오 : radio)
			BASIS000.grid_BASIS000_02 = KpackageOBJ.auiGrid.create("oAuiGrid_BASIS000_02", columnLayout, gridProps, "");
			
			
			// 클릭 이벤트
			AUIGrid.bind(BASIS000.grid_BASIS000_02, "cellClick", function( event ) {
				console.log("rowIndex : " + event.rowIndex + ", columnIndex : " + event.columnIndex + " clicked");
			});
			
			// 더블클릭 이벤트 
			AUIGrid.bind(BASIS000.grid_BASIS000_02, "cellDoubleClick", function( event ) {
				console.log("rowIndex : " + event.rowIndex + ", columnIndex : " + event.columnIndex + " dbl clicked");
			});
		};
		
		this.retrieve_GridData_grid_BASIS000_01 = function(){
			KpackageOBJ.auiGrid.retrieve(BASIS000.grid_BASIS000_01, "/basis/retrieveCompanyDivisionList");
		}
		
		/*인증수출자 정보 저장*/
		this.updateCertificationInfo = function(){
			var params = KpackageOBJ.data.makePostData("BASIS000-comp-form");
			
			KpackageOBJ.ajax.doSubmit("/basis/updateCertificationInfo", params, BASIS000.commonActionResult_CallbackHandler);
			
		}
		
		/*회사버퍼 정보 저장*/
		this.updateCompanyBuffer = function(){
			
			var bufferOptionType = KpackageOBJ.object.getFormValue("BASIS000-comp-form", "bf_company_option");
			var bufferSettingValue = KpackageOBJ.auiGrid.getGridDataWithState(BASIS000.grid_BASIS000_02);
			
			var params = {
					"bf_company_option" : bufferOptionType
					,"buffer_setting_value" : bufferSettingValue  // Option Value Grid Data List
			};
			
			KpackageOBJ.ajax.doSubmit("/basis/updateCompanyBuffer", params, BASIS000.commonActionResult_CallbackHandler);
			
		}
		
		/*수불부 설정 정보 저장*/
		this.updateCompanyMaOption = function(){
			
			var materialUseYn = KpackageOBJ.object.getFormValue("BASIS000-comp-form", "material_use_yn");
			var params = {
					"material_use_yn" : materialUseYn
					,"option_value" : KpackageOBJ.object.getFormValue("BASIS000-comp-form", "basic_aging_period")
					,"option_code" : "MA"
			};
			
			KpackageOBJ.ajax.doSubmit("/basis/updateCompanyMaOption", params, BASIS000.commonActionResult_CallbackHandler);
			
		}
		
		/*확인서 등록 기준 정보 저장*/
		this.updateCompanyRuOption = function(){
			
			var ruCompanyOption = KpackageOBJ.object.getFormValue("BASIS000-comp-form", "ru_company_option");
			var params = {
					"option_value" : ruCompanyOption
					,"option_code" : "RU"
			};
			
			KpackageOBJ.ajax.doSubmit("/basis/updateCompanyRuOption", params, BASIS000.commonActionResult_CallbackHandler);
			
		}
		
		
		/**
 		 * event bind 
		 * 회사버퍼 설정 select box 값 변경 
		 */
		$("#bf_company_option").on("change", function () {
			
			BASIS000.retrieveBufferDatalist();
			
		});
		
		
	};
	
	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		BASIS000.Initialize_viewObject();
	});
</script>

</html>