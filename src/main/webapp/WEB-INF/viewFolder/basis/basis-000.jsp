<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	    	<div class="col-9">
	    		<div class="row">
	    			<div class="col-6">
	    				Company Name ( Code )
	    			</div>
	    			<div class="frame-wrap col-6">
					    <div class="demo" style="text-align: right;">
					        <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="javascript:;">변경사항 저장</button>
					    </div>
					</div>
	    		</div>
	    		
		    	<form:form id="BASIS000-form" class="s4-form" novalidate="novalidate" action="" method="post">
			    	<div id="panel-4" class="panel panel-icon">
			    		<div class="panel-container show">
							<div class="panel-content">
								<div class="row">
								    <div class="mb-3 col-3 d-none">
								        <label class="form-label" for="company_code">회사 코드 <span class="text-danger">*</span></label>
								        <input type="text" id="company_code" name="company_code" class="form-control" maxlength="20" required>
								    </div>
								
								    <div class="mb-3 col-3 d-none">
								        <label class="form-label" for="company_name">회사명 <span class="text-danger">*</span></label>
								        <input type="text" id="company_name" name="company_name" class="form-control" maxlength="200" required>
								    </div>
								
								    <div class="mb-3 col-3 d-none">
								        <label class="form-label" for="company_name_eng">영문 회사명</label>
								        <input type="text" id="company_name_eng" name="company_name_eng" class="form-control" maxlength="200">
								    </div>
								
								    <div class="mb-3 col-3 d-none">
								        <label class="form-label" for="company_name_loc">현지어 회사명</label>
								        <input type="text" id="company_name_loc" name="company_name_loc" class="form-control" maxlength="200">
								    </div>
								

								
								    <div class="mb-3 col-3">
								        <label class="form-label" for="officer_name">담당자명(대표자명)</label>
								        <input type="text" id="officer_name" name="officer_name" class="form-control" maxlength="50">
								    </div>
								
								    <div class="mb-3 col-3">
								        <label class="form-label" for="officer_name_eng">담당자 영문명(영문 대표자명)</label>
								        <input type="text" id="officer_name_eng" name="officer_name_eng" class="form-control" maxlength="50">
								    </div>
								
								    <div class="mb-3 col-3">
								        <label class="form-label" for="officer_phone_no">담당자 전화번호</label>
								        <input type="text" id="officer_phone_no" name="officer_phone_no" class="form-control" maxlength="20">
								    </div>
								
								    <div class="mb-3 col-3">
								        <label class="form-label" for="officer_email">담당자 이메일</label>
								        <input type="email" id="officer_email" name="officer_email" class="form-control" maxlength="50">
								    </div>
								
								    <div class="mb-3 col-3">
								        <label class="form-label" for="business_no">사업자등록번호</label>
								        <input type="text" id="business_no" name="business_no" class="form-control" maxlength="15">
								    </div>
								    								
								    <div class="mb-3 col-3">
								        <label class="form-label" for="com_phone_no">회사 전화번호</label>
								        <input type="text" id="com_phone_no" name="com_phone_no" class="form-control" maxlength="20">
								    </div>
								
								    <div class="mb-3 col-3">
								        <label class="form-label" for="com_fax_no">회사 팩스번호</label>
								        <input type="text" id="com_fax_no" name="com_fax_no" class="form-control" maxlength="20">
								    </div>
								
								    <div class="mb-3 col-3"></div>
								    
								    <div class="mb-3 col-1">
								        <label class="form-label" for="zip_code">우편번호</label>
								        <input type="text" id="zip_code" name="zip_code" class="form-control" maxlength="7">
								    </div>					
								    			
								    <div class="mb-3 col-5">
								        <label class="form-label" for="address">주소</label>
								        <input type="text" id="address" name="address" class="form-control" maxlength="200">
								    </div>
								
								    <div class="mb-3 col-6">
								        <label class="form-label" for="address_eng">영문 주소</label>
								        <input type="text" id="address_eng" name="address_eng" class="form-control" maxlength="500">
								    </div>
								
								
								   
								
								    <div class="mb-3 col-3">
								        <label class="form-label" for="com_de_minimis_rate">미소기준 감산 비율 <span class="text-danger">*</span></label>
								        <input type="number" id="com_de_minimis_rate" name="com_de_minimis_rate" class="form-control" step="0.01" required>
								    </div>
								
								    <div class="mb-3 col-3">
								        <label class="form-label" for="com_rvc_rate">부가가치 가산 비율 <span class="text-danger">*</span></label>
								        <input type="number" id="com_rvc_rate" name="com_rvc_rate" class="form-control" step="0.01" required>
								    </div>
								
								    <div class="mb-3 col-3">
								        <label class="form-label" for="inventory_valuation_method">재고평가방법</label>
								        <input type="text" id="inventory_valuation_method" name="inventory_valuation_method" class="form-control" maxlength="1">
								    </div>
								
								    <div class="mb-3 col-3">
								        <label class="form-label" for="co_certified_exporter_yn">원산지 인증수출자 여부 <span class="text-danger">*</span></label>
								        <select id="co_certified_exporter_yn" name="co_certified_exporter_yn" class="form-select" required>
								            <option value="">선택</option>
								            <option value="Y">예</option>
								            <option value="N">아니오</option>
								        </select>
								    </div>
								
								    <div class="mb-3 col-3">
								        <label class="form-label" for="certification_no">원산지 인증수출자 인증번호</label>
								        <input type="text" id="certification_no" name="certification_no" class="form-control" maxlength="50">
								    </div>
								
								    <div class="mb-3 col-3">
								        <label class="form-label" for="default_language">사용 언어</label>
								        <input type="text" id="default_language" name="default_language" class="form-control" maxlength="3">
								    </div>
								
								    <div class="mb-3 col-3">
								        <label class="form-label" for="certification_type">원산지 인증수출자 인증타입</label>
								        <select id="certification_type" name="certification_type" class="form-select">
								            <option value="">선택</option>
								            <option value="C">사업장별 인증</option>
								            <option value="I">품목별 인증</option>
								        </select>
								    </div>
								
								    <div class="mb-3 col-3">
								        <label class="form-label" for="material_use_yn">수불부 사용 여부</label>
								        <select id="material_use_yn" name="material_use_yn" class="form-select">
								            <option value="">선택</option>
								            <option value="Y">사용</option>
								            <option value="N">사용 안함</option>
								        </select>
								    </div>
								
								    <div class="mb-3 col-3">
								        <label class="form-label" for="company_use_yn">회사 사용 여부</label>
								        <select id="company_use_yn" name="company_use_yn" class="form-select">
								            <option value="">선택</option>
								            <option value="Y">사용</option>
								            <option value="N">사용 안함</option>
								        </select>
								    </div>
								
								    <div class="mb-3 col-3">
								        <label class="form-label" for="basic_aging_period">기초 재고회전 기간</label>
								        <input type="number" id="basic_aging_period" name="basic_aging_period" class="form-control" value="0">
								    </div>
								
								    <div class="mb-3 col-3">
								        <label class="form-label" for="ctc_decision_only_yn">세번변경 판정만 수행 여부</label>
								        <select id="ctc_decision_only_yn" name="ctc_decision_only_yn" class="form-select">
								            <option value="">선택</option>
								            <option value="Y">예</option>
								            <option value="N" selected>아니오</option>
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

		// 시작점
		this.Initialize_viewObject = function() {
			
			/*우측 상단 차트 생성 */
			//KpackageOBJ.perityChart.create("span.peity-bar", "bar");
			//KpackageOBJ.perityChart.create("span.peity-donut", "donut");
			//KpackageOBJ.perityChart.create("span.peity-line", "line");
			// AUIGrid 그리드를 생성합니다.
			BASIS000.createAUIGrid();
			//AUIGrid.setGridData(BASIS000.grid_BASIS000_01, BASIS000.data);
		}

		// AUIGrid 를 생성합니다.
		this.createAUIGrid = function() {
			// 그리드 칼럼 레이아웃 설정
			const columnLayout = [ 
				{ dataField : "company_code",	headerText : "회사코드",          width : 120,		filter: { showIcon: true }  },
				{ dataField : "company_name",	headerText : "회사명",        width : 140,		filter: { showIcon: true }  }
				
			];

			// 그리드 속성 설정
			const gridProps = {
				//추가속성이 필요한 경우 작성 
				//editable : true, // 그리드 수정 모드 
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
				console.log("rowIndex : " + event.rowIndex + ", columnIndex : " + event.columnIndex + " dbl clicked");
			});
		};
		
		this.retrieve_GridData = function(){
			var params = { 
				/* 날짜 파라메터 '-' 제거  */
  				"search_from_date" : KpackageOBJ.object.getFormValue("BASIS000-form", "search_from_date").replace(/-/gi, "")
				,"search_to_date" : KpackageOBJ.object.getFormValue("BASIS000-form", "search_to_date").replace(/-/gi, "")
			}

			KpackageOBJ.auiGrid.retrieve(BASIS000.grid_BASIS000_01, "/sample/retrieveTestSalesMaster", params);
		}
	};
	
	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		BASIS000.Initialize_viewObject();
	});
</script>

</html>