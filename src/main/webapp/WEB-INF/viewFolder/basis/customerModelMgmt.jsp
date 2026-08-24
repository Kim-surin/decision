<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head></head>
<body>
    <form:form id="BASIS003-form" class="s4-form" novalidate="novalidate" action="" method="post" onsubmit="return false;">
	    <input type="hidden" id="dummy" name="dummy"/>
    </form:form>
	<div class="content-wrapper">
		<div class="row">
			<div class="content-wrapper col-3">
				<h1 class="subheader-title mb-1">고객사 자재관리</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item" aria-current="page">기초정보관리</li>
						<li class="breadcrumb-item active" aria-current="page">고객사 자재관리</li>
					</ol>
				</nav>
			</div>
			<div class="row col-9"></div>
	    </div>	
		<div class="row">
	    	<div class="col-7">
				<div class="frame-wrap">
				    <div class="demo" style="text-align: left;">
				    	<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="javascript:BASIS003.fnExcelDown();">
				            엑셀다운로드
				        </button>
				    </div>
				</div>	    	
	    	</div>
	    	<div class="col-5">
				<div class="frame-wrap">
				    <div class="demo" style="text-align: right;">
				        <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="javascript:BASIS003.fnAddRow();">
				            추가
				        </button>
				        <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="javascript:BASIS003.fnSave();">
				            저장
				        </button>
				        <button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="javascript:BASIS003.fnDeleteRow();">
				            삭제
				        </button>
				    </div>
				</div>
	    	</div>
	    </div>
	    <div class="row">
	  		<div class="col-12">
	    	    <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		        <div id="oAuiGrid_BASIS003_01" style="width:100%;height:630px; margin:0 auto;"></div>
		    </div>
		</div>	
	</div>
</body>
<script>
	var BASIS003 = new function() {

		// AUIGrid 생성 후 반환 ID
		this.grid_BASIS003_01 = null;

		// 시작점
		this.Initialize_viewObject = function() {
			
			BASIS003.createAUIGrid(); // AUIGrid 그리드를 생성합니다.
			BASIS003.retrieve_GridData_grid_BASIS003_01();
		}

		// AUIGrid 를 생성합니다.
		this.createAUIGrid = function() {
			// 그리드 칼럼 레이아웃 설정
			const columnLayout = [
				{
				    dataField: "division_code"
				  , headerText: "사업장코드"
				  , width: 120
				  , filter: {showIcon: true}
				  , renderer: {
		                type: 'IconRenderer',
		                iconWidth: 16, // icon 가로 사이즈, 지정하지 않으면 24로 기본값 적용됨
		                iconHeight: 16,
		                iconPosition: 'aisleRight', // 아이콘 위치
		                iconFunction: function (rowIndex, columnIndex, value, item) {
		                	return "/rcs/auigrid/images/icon-search.png";
		                },
		                onClick: (e) => {
		                	BASIS003.fnOpenCompop("division_code");
		                },
		            },
				},
	            
	            {   dataField: "division_name",headerText: "플랜트 명",width: 320,editable: false,style: "aui-left",
	                filter: {
	                    showIcon: true
	                }
	            },
	            {   dataField: "item_code", headerText: "자재코드", width: 180, style: "aui-center", editable: true
	                , filter: {
	                    showIcon: true,
	                    iconWidth: 18
	                }
	                , renderer: {
		                type: 'IconRenderer',
		                iconWidth: 16, // icon 가로 사이즈, 지정하지 않으면 24로 기본값 적용됨
		                iconHeight: 16,
		                iconPosition: 'aisleRight', // 아이콘 위치
		                iconFunction: function (rowIndex, columnIndex, value, item) {
		                	return "/rcs/auigrid/images/icon-search.png";
		                },
		                onClick: (e) => {
		                	BASIS003.fnOpenCompop("item_code");
		                },
		            },
				},
	            {   dataField: "item_name",headerText: "자재명",width: 320,editable: false,style: "aui-left",
	                filter: {
	                    showIcon: true
	                }
	            },
	            {	dataField: "customer_code",headerText: "고객사코드",width: 150,editable: true,style: "aui-center",
	                filter: {
	                    showIcon: true
	                }
	                , renderer: {
		                type: 'IconRenderer',
		                iconWidth: 16, // icon 가로 사이즈, 지정하지 않으면 24로 기본값 적용됨
		                iconHeight: 16,
		                iconPosition: 'aisleRight', // 아이콘 위치
		                iconFunction: function (rowIndex, columnIndex, value, item) {
		                	return "/rcs/auigrid/images/icon-search.png";
		                },
		                onClick: (e) => {
		                	BASIS003.fnOpenCompop("customer_code");
		                },
		            },
				},
	            {	dataField: "customer_name",headerText: "고객사명",width: 150,editable: false,style: "aui-center"},
	            {   dataField: "hs_code",headerText: "HS CODE",width: 120,editable: false,style: "aui-center"},
	            {   headerText: "고객사 정보",
	                children: [
	                    {   dataField: "customer_hs_code"   ,headerText: "HS CODE"	,width: 110    ,editable: true    ,style: "aui-center"},
	                    {   dataField: "customer_item_code" ,headerText: "자재코드"  	,width: 130    ,editable: true    ,style: "aui-center"},
	                    {   dataField: "customer_item_name" ,headerText: "자재명"    	,width: 130    ,editable: true    ,style: "aui-left"},
	                    {   dataField: "customer_standard"  ,headerText: "규격"   	,width: 160    ,editable: true    ,style: "aui-left"}
	                ]
	            },

	            /* 숨김 관리 컬럼 */
	            { dataField: "remark", headerText: "비고", visible: false },
	            { dataField: "create_date", headerText: "생성일", visible: false },
	            { dataField: "create_by", headerText: "생성자", visible: false },
	            { dataField: "update_date", headerText: "수정일", visible: false },
	            { dataField: "update_by", headerText: "수정자", visible: false }
	        ];

			// 그리드 속성 설정
			const gridProps = {
				//추가속성이 필요한 경우 작성 
				editable : true, // 그리드 수정 모드 
				selectionMode: "singleRow", // singleRow 선택모드
				displayTreeOpen: true, // 최초 보여질 때 모두 열린 상태로 출력 여부
				usePaging: false,   // 페이징 사용
				pageRowCount: 20,  // 페이지 행 개수 select UI 출력 여부 (기본값 : false)
				showPageRowSelect: false,	// 페이지 카운트 표시 여부	
				fillColumnSizeMode : true // 가로 스크롤 없이 가득차게
				
			};

			// 실제로 #oAuiGrid_BASIS003_01 에 그리드 생성
			// 파라메터 : Grid Div ID, 컬럼레이아웃, 그리드속성, 그리드타입(없음 : null or "", 행번호 : number ,체크박스 : check ,라디오 : radio)
			BASIS003.grid_BASIS003_01 = KpackageOBJ.auiGrid.create("oAuiGrid_BASIS003_01", columnLayout, gridProps, "");
			
			
			// 클릭 이벤트
			AUIGrid.bind(BASIS003.grid_BASIS003_01, "cellClick", function( event ) {
			});
			
			// 더블클릭 이벤트 
			AUIGrid.bind(BASIS003.grid_BASIS003_01, "cellDoubleClick", function( event ) {
				
			});
			
			/* 데이터의 로드가 완료되면 발생 이벤트 */
			AUIGrid.bind(BASIS003.grid_BASIS003_01, "ready", function (event) { /* 본문 */});
		};
		
		
		this.retrieve_GridData_grid_BASIS003_01 = function(){
			
			var params = KpackageOBJ.data.makePostData("BASIS003-form");
			KpackageOBJ.auiGrid.retrieve(BASIS003.grid_BASIS003_01, "/basis/retrieveCustomerModelList", params);
			
		}
		
		
		this.fnAddRow = function() {
	        const row = {
	            row_id: "ROW_" + new Date().getTime(),
	            company_code: $("#schCompanyCode").val() || "",
	            division_code: "",
	            item_code: "",
	            item_name: "",
	            customer_code: "",
	            customer_name: "",
	            hs_code: "",
	            customer_hs_code: "",
	            customer_item_code: "",
	            customer_item_name: "",
	            customer_standard: "",
	            remark: ""
	        };

	        AUIGrid.addRow(BASIS003.grid_BASIS003_01, row, "last");
	    }
		
		
	    this.fnDeleteRow = function() {
	        const selectedItems = AUIGrid.getSelectedItems(BASIS003.grid_BASIS003_01);

	        if (!selectedItems || selectedItems.length === 0) {
	            alert("삭제할 행을 선택하세요.");
	            return;
	        }

	        const rowIndexes = [];
	        for (let i = 0; i < selectedItems.length; i++) {
	            rowIndexes.push(selectedItems[i].rowIndex);
	        }

	        KpackageOBJ.auiGrid.removeRow(BASIS003.grid_BASIS003_01, rowIndexes);
	        
	    }
	    
	    this.fnSave = function() {
	        const addedRows = AUIGrid.getAddedRowItems(BASIS003.grid_BASIS003_01);
	        const editedRows = AUIGrid.getEditedRowItems(BASIS003.grid_BASIS003_01);
	        const removedRows = AUIGrid.getRemovedItems(BASIS003.grid_BASIS003_01);

	        const payload = {
	            addList: addedRows,
	            updateList: editedRows,
	            deleteList: removedRows
	        };

	        // 간단 validation
	        const checkRows = [...addedRows, ...editedRows];
	        for (let i = 0; i < checkRows.length; i++) {
	            const row = checkRows[i];
	            if (!row.item_code) {
	                alert("자재코드는 필수입니다.");
	                return;
	            }
	            if (!row.customer_code) {
	                alert("고객사코드는 필수입니다.");
	                return;
	            }
	        }
	        
	     	// 저장 확인
	        if (!confirm("저장하시겠습니까?")) {
	            return;
	        }

	        KpackageOBJ.ajax.doSubmit("/basis/saveCustomerModelList", payload, function(saveResult) {
	            alert(saveResult.message);
	            if(saveResult.success){
	            	//재조회
	            	BASIS003.retrieve_GridData_grid_BASIS003_01();
	            }
	        });
	        
	    }
	    
	    
	    this.fnExcelDown = function() {
	        AUIGrid.exportToXlsx(BASIS003.grid_BASIS003_01, {
	            fileName: "품목고객사매핑.xlsx",
	            progressBar: true
	        });
	    }
	    
	    
	    //곧통팝업 오픈
		this.fnOpenCompop = function(colGubn, bAutoSearch = false ) {
			const selRowIndex = KpackageOBJ.auiGrid.getSelectedIndex(BASIS003.grid_BASIS003_01)[0];
		    let callbackFunctionName = "";
		    let searchText = "";
		    let popGubn = "";
		    let data = {};
		    
		    switch (colGubn) {
		    	case "item_code":
		    		popGubn = "ITEM";
		    	    callbackFunctionName = "setComItemPopupData";
		    	    data ={
		    	    	"searchText": nullToString(KpackageOBJ.auiGrid.getCellValue(BASIS003.grid_BASIS003_01, selRowIndex, colGubn))
			        };
		            break;
		    	case "division_code":
					popGubn = "DIVISION";
		    	    callbackFunctionName = "setComDivisionPopupData";
		    	    data = {
		    	    	"searchText": nullToString(KpackageOBJ.auiGrid.getCellValue(BASIS003.grid_BASIS003_01, selRowIndex, colGubn))
			        };
		            break;    
		    	case "customer_code":
					popGubn = "CUSTOMER";
		    	    callbackFunctionName = "setComCustomerPopupData";
		    	    data = {
		    	    	"searchText": nullToString(KpackageOBJ.auiGrid.getCellValue(BASIS003.grid_BASIS003_01, selRowIndex, colGubn))
			        };
		            break;    
		    	 default:
		    		 return;
		    }
			
			
		    KpackageOBJ.dialog.openCommonPop(popGubn, {
		        callbackObject: "BASIS003",
		        callbackFunctionName: callbackFunctionName,
		        rowIndex: selRowIndex,
		        bAutoSearch: bAutoSearch,
		        data: data
		    });
		};
		
		//사업장코드 팝업 세팅
	    this.setComDivisionPopupData = function(selectedData) {
			KpackageOBJ.auiGrid.setCellValue(BASIS003.grid_BASIS003_01, selectedData["rowIndex"], "division_code", selectedData["code"]);
			KpackageOBJ.auiGrid.setCellValue(BASIS003.grid_BASIS003_01, selectedData["rowIndex"], "division_name", selectedData["code_name"]);

	    };
	    
	    this.setComItemPopupData = function(selectedData) {
			KpackageOBJ.auiGrid.setCellValue(BASIS003.grid_BASIS003_01, selectedData["rowIndex"], "item_code", selectedData["code"]);
			KpackageOBJ.auiGrid.setCellValue(BASIS003.grid_BASIS003_01, selectedData["rowIndex"], "item_name", selectedData["code_name"]);
			KpackageOBJ.auiGrid.setCellValue(BASIS003.grid_BASIS003_01, selectedData["rowIndex"], "hs_code", selectedData["hs_code"]);

	    };
	    
	    this.setComCustomerPopupData = function(selectedData) {
			KpackageOBJ.auiGrid.setCellValue(BASIS003.grid_BASIS003_01, selectedData["rowIndex"], "customer_code", selectedData["code"]);
			KpackageOBJ.auiGrid.setCellValue(BASIS003.grid_BASIS003_01, selectedData["rowIndex"], "customer_name", selectedData["code_name"]);

	    };
	    
	    
	};
	
	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		BASIS003.Initialize_viewObject();
	});
</script>

</html>