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
				<h1 class="subheader-title mb-1">SAMPLE PAGE 001</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item active" aria-current="page">SAMPLE-001</li>
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
	    <div class="row">
	    	<form:form id="SAMPLE001-form" class="s4-form" novalidate="novalidate" action="" method="post">
		    	<div id="panel-4" class="panel panel-icon">
		    		<div class="panel-container show">
						<div class="panel-content">
				            <div class="row">
	                            <div class="col-4">
	                                <div class="row mb-3">
	                                	<div class="col-6">
		                                	<label class="form-label" for="search_from_date">매출일 From</label>
		                                    <input class="form-control" id="search_from_date" name="search_from_date" type="date" value="2024-01-01">
	                                    </div>
	                                    <div class="col-6">
		                                    <label class="form-label" for="search_to_date">매출일 To</label>
	                                        <input class="form-control" id="search_to_date" name="search_to_date" type="date" value="2024-01-31">
    	                               </div>
	                                </div>
	                            </div>
	                            <div class="col-2">
	                                <div class="mb-3">
	                                    <label class="form-label" for="example-select">Input Select</label>
	                                    <select class="form-select" id="example-select">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                        </select>
	                                </div>
	                            </div>
	                            <div class="col-lg-5">
	                            	<div class="row">
	                            		<label class="form-label" for="example-input-border">Border color</label>
	                            	</div>
	                                <div class="row mb-3">
	                                	<div class="col-3">
	                                		<select class="form-select" id="example-select">
	                                            <option>1</option>
	                                            <option>2</option>
	                                            <option>3</option>
	                                            <option>4</option>
	                                            <option>5</option>
	                                        </select>
	                                	</div>
	                                	<div class="col">
	                                		<input type="text" id="example-input-border" class="form-control" placeholder="Border colors">
	                                	</div>
	                                    
	                                </div>
	                            </div>
	                            <div class="col">
                                	<button type="button" onclick="javascript:SAMPLE001.retrieve_GridData();" class="btn btn-sm btn-search search-more waves-effect waves-themed">Search</button>
                                	<button type="button" onclick="javascript:toggleSearchMore(this,'SAMPLE001_SEARCHMORE');" class="btn btn-xs btn-search-more waves-effect waves-themed">More</button>
                                </div>
	                        </div>
	                        <div class="row" id="SAMPLE001_SEARCHMORE" style="display: none;">
	                        	<div class="col-2">
	                                <div class="mb-3">
	                                    <label class="form-label" for="example-select">Input Select</label>
	                                    <select class="form-select" id="example-select">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                        </select>
	                                </div>
	                            </div>
	                            <div class="col-2">
	                                <div class="mb-3">
	                                    <label class="form-label" for="example-select">Input Select</label>
	                                    <select class="form-select" id="example-select">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                        </select>
	                                </div>
	                            </div>
	                            <div class="col-2">
	                                <div class="mb-3">
	                                    <label class="form-label" for="example-select">Input Select</label>
	                                    <select class="form-select" id="example-select">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                        </select>
	                                </div>
	                            </div>
	                            <div class="col-2">
	                                <div class="mb-3">
	                                    <label class="form-label" for="example-select">Input Select</label>
	                                    <select class="form-select" id="example-select">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                        </select>
	                                </div>
	                            </div>
	                            <div class="col-2">
	                                <div class="mb-3">
	                                    <label class="form-label" for="example-select">Input Select</label>
	                                    <select class="form-select" id="example-select">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                        </select>
	                                </div>
	                            </div>
	                            <div class="col-2">
	                                <div class="mb-3">
	                                    <label class="form-label" for="example-select">Input Select</label>
	                                    <select class="form-select" id="example-select">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
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

		<div class="row">
	   		<div class="col-12">
		        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		        <div id="oAuiGrid_SAMPLE001_01" style="width:100%;height:480px; margin:0 auto;"></div>
		    </div>
	    </div>	

	</div>
</body>
<script>
	var SAMPLE001 = new function() {

		// AUIGrid 생성 후 반환 ID
		this.grid_SAMPLE001_01 = null;

		// 시작점
		this.Initialize_viewObject = function() {
			
			/*우측 상단 차트 생성 */
			KpackageOBJ.perityChart.create("span.peity-bar", "bar");
			KpackageOBJ.perityChart.create("span.peity-donut", "donut");
			KpackageOBJ.perityChart.create("span.peity-line", "line");
			// AUIGrid 그리드를 생성합니다.
			SAMPLE001.createAUIGrid();
			AUIGrid.setGridData(SAMPLE001.grid_SAMPLE001_01, SAMPLE001.data);
		}

		// AUIGrid 를 생성합니다.
		this.createAUIGrid = function() {
			// 그리드 칼럼 레이아웃 설정
			const columnLayout = [ 
				{ dataField : "sales_no",		headerText : "매출번호",          width : 120,		filter: { showIcon: true }  },
				{ dataField : "division_code",	headerText : "플랜트 코드",        width : 140,		filter: { showIcon: true }  },
				{ dataField : "company_code", 	headerText : "회사코드",     width : 140,		filter: { showIcon: true }  },
				{ dataField : "customer_code", 	headerText : "고객사 코드",     width : 140,		filter: { showIcon: true }  },
				{ dataField : "invoice_date",    headerText : "매출일자"
					,    dataType : "date",    dateInputFormat : "yyyymmdd", 	formatString : "yyyy-mm-dd" 
				,		filter: { showIcon: true }  }
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

			// 실제로 #oAuiGrid_SAMPLE001_01 에 그리드 생성
			// 파라메터 : Grid Div ID, 컬럼레이아웃, 그리드속성, 그리드타입(없음 : null or "", 행번호 : number ,체크박스 : check ,라디오 : radio)
			SAMPLE001.grid_SAMPLE001_01 = KpackageOBJ.auiGrid.create("oAuiGrid_SAMPLE001_01", columnLayout, gridProps, "");
			
			
			// 클릭 이벤트
			AUIGrid.bind(SAMPLE001.grid_SAMPLE001_01, "cellClick", function( event ) {
				console.log("rowIndex : " + event.rowIndex + ", columnIndex : " + event.columnIndex + " clicked");
			});
			
			// 더블클릭 이벤트 
			AUIGrid.bind(SAMPLE001.grid_SAMPLE001_01, "cellDoubleClick", function( event ) {
				console.log("rowIndex : " + event.rowIndex + ", columnIndex : " + event.columnIndex + " dbl clicked");
			});
		};
		
		this.retrieve_GridData = function(){
			var params = { 
				/* 날짜 파라메터 '-' 제거  */
  				"search_from_date" : KpackageOBJ.object.getFormValue("SAMPLE001-form", "search_from_date").replace(/-/gi, "")
				,"search_to_date" : KpackageOBJ.object.getFormValue("SAMPLE001-form", "search_to_date").replace(/-/gi, "")
			}

			KpackageOBJ.auiGrid.retrieve(SAMPLE001.grid_SAMPLE001_01, "/sample/retrieveTestSalesMaster", params);
		}
	};
	
	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		SAMPLE001.Initialize_viewObject();
	});
</script>

</html>