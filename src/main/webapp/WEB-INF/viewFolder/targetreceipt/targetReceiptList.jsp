<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>


</head>
<body>
	<div class="content-wrapper">
	    <div class="row">
	    	<form:form id="TargetReceiptList-form" class="s4-form" novalidate="novalidate" action="" method="post">
	    		<input type="hidden" id="company_code" name="company_code" value="${sessionScope._sessionUser.company_code}"/>  
		    	<div id="panel-4" class="panel panel-icon">
		    		<div class="panel-container show">
						<div class="panel-content">
				            <div class="row">
	                            
	                            <div class="col-2" style="width: 125px;">
	                                <div class="mb-2">
	                                    <label class="form-label" for="example-select"><spring:message code='plantinfo.title.plant'/> </label>
	                                    <select class="form-select searchSelect" id="plant" name="plant" style="width:110px; height:35px !important;"></select>
	                                </div>
	                            </div>
	                            <div class="col-lg-4" style="width: 600px;">
	                            	<div class="row">
	                            		<label class="form-label" for="example-input-border"><spring:message code='TXT.SEARCH_TEXT03'/> </label>
	                            	</div>
	                                <div class="row mb-2">
	                                	<div class="col-4" style="width: 150px;">
	                                		<select class="form-select" id="search_type" name="search_type">
	                                            <option value="id.ITEM_CODE"><spring:message code='bominfo.title.ITEM_CODE'/></option>
	                                            <option value="im.ITEM_NAME"><spring:message code='bominfo.title.ITEM_NAME'/></option>
	                                            <option value="v.VENDOR_CODE"><spring:message code='supplyInfo.title.SUPPLY_CODE'/></option>
	                                            <option value="v.VENDOR_NAME"><spring:message code='supplyInfo.title.SUPPLY_NAME'/></option>
	                                        </select>
	                                	</div>
	                                	<div class="col">
	                                		<input type="text" id="search_key_word" name="search_key_word" class="form-control" placeholder="Border colors">
	                                	</div>
	                                    
	                                </div>
	                            </div>
	                            			
	                            <div class="col-2">
	                                <div class="row mb-3">
	                                    <div class="col-12">
		                                    <label class="form-label" for="search_to_date"><spring:message code='targetReceipList.title.coverdate'/></label>
	                                        <input class="form-control" id="search_to_date" name="search_to_date" type="date" value="<%= java.time.LocalDate.now() %>">
    	                               </div>
	                                </div>
	                            </div>
	                            
	                            <div class="col-2" style="width: 125px;">
	                                <div class="mb-2">
	                                    <label class="form-label" for="cover_yn"><spring:message code='targetReceipList.title.recpyn'/> </label>
	                                    <select class="form-select" id="cover_yn" name="cover_yn">
                                            <option value="">ALL</option>
                                            <option>Y</option>
                                            <option>N</option>
                                        </select>
	                                </div>
	                            </div>
	                            
	                            <div class="col">
                                	<button type="button" onclick="javascript:TargetReceiptList.retrieve_GridData();" class="btn btn-sm btn-search search-more waves-effect waves-themed">Search</button>
                                	<button type="button" onclick="javascript:toggleSearchMore(this,'TargetReceiptList_SEARCHMORE');" class="btn btn-xs btn-search-more waves-effect waves-themed">More</button>
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
					&nbsp;&nbsp; <spring:message code='targetReceipList.title.recinfo'/> :  <span id="receiptRate"></span>%(<spring:message code='targetReceipList.title.recp'/> <span id="receiptCount"></span> <spring:message code='targetReceipList.title.cnt'/> / <spring:message code='targetReceipList.title.target'/>  <span id="totalCount"></span> <spring:message code='targetReceipList.title.cnt'/>) 
	            </div>
	    	</div>
	    </div>

		<div class="row">
	   		<div class="col-12">
		        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		        <div id="oAuiGrid_TargetReceiptList_01" style="width:100%;height:480px; margin:0 auto;"></div>
		    </div>
	    </div>	

	</div>
</body>
<script>
	var TargetReceiptList = new function() {

		// AUIGrid 생성 후 반환 ID
		this.grid_TargetReceiptList_01 = null;

		// 시작점
		this.Initialize_viewObject = function() {
			
			KpackageOBJ.selectbox.create("TargetReceiptList-form", "plant", "/common/retrievePlantCombo", {"OPTION_ALL":"Y"}, "code", "name");
			
			// AUIGrid 그리드를 생성합니다.
			TargetReceiptList.createAUIGrid();
			AUIGrid.setGridData(TargetReceiptList.grid_TargetReceiptList_01, TargetReceiptList.data);
		}

		// AUIGrid 를 생성합니다.
		this.createAUIGrid = function() {
			// 그리드 칼럼 레이아웃 설정
			const columnLayout = [ 
				{ dataField : "DIVISION_NAME",		headerText : "<spring:message code='TXT.DIVISION_NAME'/>",          width : 200,		filter: { showIcon: true }  },
		//		{ dataField : "DIVISION_CODE",		headerText : "플랜트 코드",        width : 140,	filter: { showIcon: false }  },
				{ dataField : "COMPANY_CODE", 		headerText : "<spring:message code='targetReceipList.grid.vendorname'/>",     	width : 200,		filter: { showIcon: true }  },
		//		{ dataField : "COMPANY_CODE", 		headerText : "협력사 코드",     width : 140,		filter: { showIcon: false }  },
				{ dataField : "ITEM_CODE", 			headerText : "<spring:message code='bominfo.title.ITEM_CODE'/>",     width : "auto",		filter: { showIcon: false }  },
				{ dataField : "ITEM_NAME", 			headerText : "<spring:message code='bominfo.title.ITEM_NAME'/>",     width : 240,			filter: { showIcon: false }  },
				{ dataField : "HS_CODE", 			headerText : "HS_CODE",     width : 140,		filter: { showIcon: false }  },
				{ dataField : "CNT", 				headerText : "<spring:message code='targetReceipList.title.recpyn'/>",     width : 140,			filter: { showIcon: false }  }
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

			// 실제로 #oAuiGrid_TargetReceiptList_01 에 그리드 생성
			// 파라메터 : Grid Div ID, 컬럼레이아웃, 그리드속성, 그리드타입(없음 : null or "", 행번호 : number ,체크박스 : check ,라디오 : radio)
			TargetReceiptList.grid_TargetReceiptList_01 = KpackageOBJ.auiGrid.create("oAuiGrid_TargetReceiptList_01", columnLayout, gridProps, "");
			
			
		/* 	// 클릭 이벤트
			AUIGrid.bind(TargetReceiptList.grid_TargetReceiptList_01, "cellClick", function( event ) {
				console.log("rowIndex : " + event.rowIndex + ", columnIndex : " + event.columnIndex + " clicked");
			});
			
			// 더블클릭 이벤트 
			AUIGrid.bind(TargetReceiptList.grid_TargetReceiptList_01, "cellDoubleClick", function( event ) {
				console.log("rowIndex : " + event.rowIndex + ", columnIndex : " + event.columnIndex + " dbl clicked");
			}); */
			
		};
		
		this.retrieve_GridData = function(){
			   var params = {
				        COMPANY_CODE: $("#company_code").val(),
				        SEARCH_DIVISION_CODE: $("#plant").val(),
				        search_type: $("#search_type").val(),
				        search_key_word: $("#search_key_word").val(),
				        SCH_APPLY_DATE: $("#search_to_date").val().replace(/-/g, ""),
				        cover_yn: $("#cover_yn").val()
				    };

			KpackageOBJ.auiGrid.retrieve(TargetReceiptList.grid_TargetReceiptList_01, "/targetreceipt/retrieveTargetReceiptList", params);
			
			 KpackageOBJ.ajax.doSubmit(
				        "/targetreceipt/retrieveTargetReceiptList",
				        params,
				        function(arg) {
				        	var data = arg.value;
				            if (data && data.length > 0) {
				                $("#totalCount").text(data[0].TOTAL_COUNT);
				                $("#receiptCount").text(data[0].RECEIPT_COUNT);
				                $("#receiptRate").text(data[0].RECEIPT_RATE);
				            } else {
				                $("#totalCount").text("0");
				                $("#receiptCount").text("0");
				                $("#receiptRate").text("0");
				            }
				        }
				    );
			 
			 
		}
		

	    this.drawGridData = function(data) {

	        AUIGrid.setGridData(
	            TargetReceiptList.grid_TargetReceiptList_01,
	            data || []
	        );

	        if (data && data.length > 0) {
	            $("#totalCount").text(data[0].TOTAL_COUNT || 0);
	            $("#receiptCount").text(data[0].RECEIPT_COUNT || 0);
	            $("#receiptRate").text(data[0].RECEIPT_RATE || 0);
	        } else {
	            $("#totalCount").text("0");
	            $("#receiptCount").text("0");
	            $("#receiptRate").text("0");
	        }
	    };
	};
	
	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		TargetReceiptList.Initialize_viewObject();
	});
</script>

</html>