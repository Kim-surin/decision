<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>


</head>
<body>
	<div class="modal-body" style="text-align: right;">
		<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="CootargetPopup.excelDownload();" style="bottom:8px;">
			ExcelDownload
		</button>
		
	</div>
	<div class="row">
	   		<div class="col-12">
		        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		        <div id="oAuiGrid_CootargetPopup_01" style="width:100%;height:480px; margin:0 auto;"></div>
		    </div>
	    </div>
</body>
<script>
	var CootargetPopup = new function() {
		
		this.grid_CootargetPopup_01 = null;
		
		// 시작점
		this.Initialize_viewObject = function() {
			CootargetPopup.createAUIGrid();
			AUIGrid.setGridData(CootargetPopup.grid_CootargetPopup_01, CootargetPopup.data);
		}


		// AUIGrid 를 생성합니다.
		this.createAUIGrid = function() {
			// 그리드 칼럼 레이아웃 설정
			const columnLayout = [ 
				{ dataField : "division_code",		headerText : "플랜트",          width : 120,		filter: { showIcon: true } ,  style: "aui-center-align"},
				{ dataField : "vendor_code",		headerText : "구매처 코드",      width : 120,	    filter: { showIcon: true } , style: "aui-right-align"},
				{ dataField : "vendor_name", 		headerText : "구매처명",     	  width : 120,		filter: { showIcon: false } ,  style: "aui-center-align" },
				{ dataField : "item_code", 			headerText : "품번",     		  width : 120,		filter: { showIcon: true } , style: "aui-right-align" },
				{ dataField : "item_name", 			headerText : "품명",     		  width : 120,		filter: { showIcon: false } , style: "aui-right-align"},
				{ dataField : "coo_get_yn", 		headerText : "수취여부",     	  width : 120,		filter: { showIcon: false } , style: "aui-center-align"},
				{ dataField : "yyyymmdd", 			headerText : "수취한 포괄기간",   width : "auto",		filter: { showIcon: false } , style: "aui-center-align"}
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
			CootargetPopup.grid_CootargetPopup_01 = KpackageOBJ.auiGrid.create("oAuiGrid_CootargetPopup_01", columnLayout, gridProps, "");
			
		};
		
		this.retrieve_GridData = function(){
			
			 // 부모 화면 찾기
		    const parentWindow =
		        window.parent && window.parent.CootargetList
		            ? window.parent
		            : window.opener;

		    // 부모 그리드의 체크된 행
		    const checkedRows = parentWindow.AUIGrid.getCheckedRowItemsAll(
		        parentWindow.CootargetList.grid_CootargetList_01
		    );

		    // Total, Sub Total 제외
		    const conditionList = checkedRows
		        .filter(function(row) {
		            return row.vendor_code && row.division_code;
		        })
		        .map(function(row) {
		            return {
		                vendor_code: row.vendor_code,
		                division_code: row.division_code
		            };
		        });

		    if (conditionList.length === 0) {
		        alert("상세 행을 하나 이상 선택해주세요.");
		        return;
		    }

		    const parent$ = parentWindow.jQuery || parentWindow.$;
			
			var params = {
			        COMPANY_CODE: $("#company_code").val(),
			        START_DATE: $("#search_from_date").val().replace(/-/g, ""),
			        END_DATE: $("#search_to_date").val().replace(/-/g, ""),
			        conditionListJson: JSON.stringify(conditionList)
			    };

			KpackageOBJ.auiGrid.retrieve(CootargetPopup.grid_CootargetPopup_01, "/cootarget/retrieveCootargetPopup", params);
		}
		
		this.excelDownload  = function(){
			const exportProps = {
			        fileName: "수취율정보_상세팝업",
			        sheetName: "수취율정보",
			        exportWithStyle: true,
			        progressBar: true,
			        showRowNumColumn: false
			    };

			    AUIGrid.exportToXlsx(
			    	CootargetPopup.grid_CootargetPopup_01,
			        exportProps
			    );
		}
	};
	
	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		CootargetPopup.Initialize_viewObject();
		CootargetPopup.retrieve_GridData();
	});
</script>

</html>