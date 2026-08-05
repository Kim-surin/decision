<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head></head>
<body>
	<div class="content-wrapper">
		<div class="row">
			<div class="content-wrapper col-3">
				<h1 class="subheader-title mb-1">자재관리</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item">기초정보관리</li>
						<li class="breadcrumb-item active" aria-current="page">자재관리</li>
					</ol>
				</nav>
			</div>
			<div class="row col-9">
	    </div>
	    <div class="row">
	    	<form:form id="BASIS002-form" class="s4-form" novalidate="novalidate" action="" method="post" onsubmit="return false;">
		    	<div id="panel-4" class="panel panel-icon">
		    		<div class="panel-container show">
						<div class="panel-content">
				            <div class="row">
	                            <div class="col-2">
	                                <div class="mb-3">
	                                    <label class="form-label" for="example-select">플랜트</label>
	                                    <select class="form-select" id="search_division_code" name="search_division_code"></select>
	                                </div>
	                            </div>
	                            <div class="col-lg-5">
	                            	<div class="row">
	                            		<label class="form-label" for="example-input-border">조회조건</label>
	                            	</div>
	                                <div class="row mb-3">
	                                	<div class="col-3">
	                                		<select class="form-select" id="search_item" name="search_item"></select>
	                                	</div>
	                                	<div class="col">
	                                		<input type="text" id="serch_keyword" name="serch_keyword" class="form-control" placeholder="키워드 입력">
	                                	</div>
	                                </div>
	                            </div>
	                            <div class="col-4 d-flex align-items-center">
								    <div class="form-check mt-3">
								        <input class="form-check-input" type="checkbox" id="hs_code_missing_yn" name="hs_code_missing_yn" value="Y">
								        <label class="form-check-label" for="hs_code_missing_yn">
								            HS code 누락만 조회
								        </label>
								    </div>
								</div>
	                            <div class="col">
                                	<button type="button" onclick="javascript:BASIS002.retrieve_GridData();" class="btn btn-sm btn-search search-more waves-effect waves-themed mt-2">Search</button>
                                </div>
	                        </div>
					    </div>		    		
		    		</div>
				</div>
			</form:form>
	    </div>
	    <div class="row">
	    	<div class="col-7">
				<div class="ms-auto d-none d-sm-flex align-items-center">
				    <div class="d-flex align-items-center">
				        <div class="d-none d-md-inline-flex">
				            <span id="hsCodeDonut" class="peity-donut">1,3</span>
				        </div>
				        <div class="d-inline-flex flex-column justify-content-center ms-2">
				            <span class="fw-500 fs-xs d-block">
				                <small>HS 코드누락 비율</small>
				            </span>
				            <span id="hsCodeRateText" class="fw-500 fs-xl d-flex align-items-center text-success">
				                50%
				                <svg class="sa-icon sa-bold sa-icon-success ms-1">
				                    <use href="img/sprite.svg#trending-up"></use>
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
				            상세조회
				        </button>
				    </div>
				</div>
	    	</div>
	    </div>

		<div class="row">
	   		<div class="col-12">
		        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		        <div id="oAuiGrid_BASIS002_01" style="width:100%;height:630px; margin:0 auto;"></div>
		    </div>
	    </div>	

	</div>
</body>
<script>
	var BASIS002 = new function() {

		// AUIGrid 생성 후 반환 ID
		this.grid_BASIS002_01 = null;

		// 시작점
		this.Initialize_viewObject = function() {
			KpackageOBJ.selectbox.create("BASIS002-form", "search_division_code", "/common/retrievePlantCombo", {"OPTION_ALL":"Y"}, "code", "name");

			/*Search Type Select Box Create */
			var arrayItem = [
				{value:"ITEM_CODE", name:"<spring:message code='자재코드'/>"}
				,{value:"ITEM_NAME", name:"<spring:message code='자재명'/>"}
				,{value:"HS_CODE", name:"<spring:message code='HS 코드'/>"}
			
			];
			KpackageOBJ.selectbox.create("BASIS002-form", "search_item", "", null, "value", "name", arrayItem);
			
			
			/*우측 상단 차트 생성 */
			KpackageOBJ.perityChart.create("span.peity-donut", "donut");
			// AUIGrid 그리드를 생성합니다.
			BASIS002.createAUIGrid();
		}
		
		

		// AUIGrid 를 생성합니다.
		this.createAUIGrid = function() {
			// 그리드 칼럼 레이아웃 설정
			const columnLayout = [
			    { dataField: "item_code",         headerText: "품목코드",  	width: 120, filter: { showIcon: true } },
			    { dataField: "name_spec",         headerText: "자제내역",		width: 220, filter: { showIcon: true } },
			    { dataField: "division_code",     headerText: "사업부코드", 	width: 110, filter: { showIcon: true } },
			    { dataField: "division_name",     headerText: "사업부명",   	width: 150, visible: false, filter: { showIcon: true } },
			    { dataField: "hs_code",           headerText: "HS코드",   	width: 120, filter: { showIcon: true } },
			    { dataField: "process_gubun",     headerText: "공정구분",     width: 100, visible: false, filter: { showIcon: true } },
			    { dataField: "assets_type",       headerText: "자산구분",     width: 120, filter: { showIcon: true } },
			    { dataField: "unit",              headerText: "단위",        width: 80,  filter: { showIcon: true } },
			    { dataField: "weight",            headerText: "중량",        width: 100, style: "aui-right", filter: { showIcon: true } },
			    { dataField: "product_name",      headerText: "제품군",     	width: 150, filter: { showIcon: true } },
			    { dataField: "importance_mgt_yn", headerText: "주요자제관리", 	width: 110, visible: false, filter: { showIcon: true } },
			    { dataField: "mail_send_yn",      headerText: "메일발송",     width: 100, visible: false,	filter: { showIcon: true } },			    
			    {
			        dataField: "fta_hs_btn",
			        headerText: "협정별",
			        width: 150,
			        editable: false,
			        renderer: {
			            type: "ButtonRenderer",
			            labelText: "협정별HSCODE",
			            onClick: function(event) {
			                BASIS002.fnOpenFtaHsCodePopup(event.item.item_code);
			            }
			        }
			    },
			    {
			        dataField: "nation_hs_btn",
			        headerText: "국가별",
			        width: 150,
			        editable: false,
			        renderer: {
			            type: "ButtonRenderer",
			            labelText: "국가별HSCODE",
			            onClick: function(event) {
			                BASIS002.fnOpenNationHsCodePopup(event.item.item_code);
			            }
			        }
			    }
			];

			// 그리드 속성 설정
			const gridProps = {
				//추가속성이 필요한 경우 작성 
				//editable : true, // 그리드 수정 모드 
				fillColumnSizeMode: true,// 가로 스크롤 없이 현재 그리드 영역에 채우기 모드
				usePaging: true,   // 페이징 사용
				pageRowCount: 50,  // 페이지 행 개수 select UI 출력 여부 (기본값 : false)
				showPageRowSelect: true,	// 페이지 카운트 표시 여부				
				
				enableFilter: true	// 필터 사용여부
			};

			// 실제로 #oAuiGrid_BASIS002_01 에 그리드 생성
			// 파라메터 : Grid Div ID, 컬럼레이아웃, 그리드속성, 그리드타입(없음 : null or "", 행번호 : number ,체크박스 : check ,라디오 : radio)
			BASIS002.grid_BASIS002_01 = KpackageOBJ.auiGrid.create("oAuiGrid_BASIS002_01", columnLayout, gridProps, "check");
			
			
			// 클릭 이벤트
			AUIGrid.bind(BASIS002.grid_BASIS002_01, "cellClick", function( event ) {
				console.log("rowIndex : " + event.rowIndex + ", columnIndex : " + event.columnIndex + " clicked");
			});
			
			// 더블클릭 이벤트 
			AUIGrid.bind(BASIS002.grid_BASIS002_01, "cellDoubleClick", function( event ) {
				console.log("rowIndex : " + event.rowIndex + ", columnIndex : " + event.columnIndex + " dbl clicked");
			});
		};
		
		this.retrieve_GridData = function(){
			var params = KpackageOBJ.data.makePostData("BASIS002-form");
			params["hs_code_missing_yn"] = $("#hs_code_missing_yn").is(":checked") ? "YY" : "NN";
			
			KpackageOBJ.auiGrid.retrieve(BASIS002.grid_BASIS002_01, "/basis/retrieveItemList", params);
			
			/*HS CODE 누락 비율 chart UPDATE*/
			
			/*
			KpackageOBJ.ajax.doSubmit("/basis/retrieveUserinfoList", params, (result) => {
				var data = result.value;
			});
			*/
			
		}
		
		
		
		/**
		* HS CODE 누락 비율 UPDATE
		retrieveMissingHsCodeCount xml 만들어놨음 
		
		*/
		this.updateHsCodeDonut = function(normalCnt, missingCnt) {
		    const total = normalCnt + missingCnt;
		    const rate = total > 0 ? Math.round((missingCnt / total) * 100) : 0;

		    $("#hsCodeDonut").text(normalCnt + "," + missingCnt);
		    $("#hsCodeDonut").peity("donut", {
		        fill: ["var(--success-300)", "var(--danger-300)"],
		        height: 34,
		        width: 34
		    });

		    $("#hsCodeRateText").html(
		        rate + '% <svg class="sa-icon sa-bold sa-icon-success ms-1"><use href="img/sprite.svg#trending-up"></use></svg>'
		    );
		}
	};
	
	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		BASIS002.Initialize_viewObject();
	});
</script>

</html>