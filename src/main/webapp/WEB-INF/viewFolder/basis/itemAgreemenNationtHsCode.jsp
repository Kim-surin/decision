<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <style>
    </style>
</head>
<body>
    <div class="container-fluid p-3">
        <div class="card border-0 shadow-sm">
            <div class="card-body">
                <form:form id="BASIS00202-form" novalidate="novalidate" action="" method="post">
                    <input type="hidden" id="dialog_id" name="dialog_id" value="${dialog_id}"/>
                    <input type="hidden" id="opener_pgm_id" name="opener_pgm_id" value="${opener_pgm_id}"/>
                    <input type="hidden" id="search_type" name="search_type" value="${search_type}"/>
                    <input type="hidden" id="hs_code" name="hs_code" value="${hs_code}"/>
                    <input type="hidden" id="item_code" name="item_code" value="${item_code}"/>

                    <h6 class="fw-bold mb-3">HS 코드 기본정보</h6>

                    <div class="table-responsive mb-4">
                        <table class="table table-bordered align-middle mb-0">
                            <colgroup>
                                <col style="width: 130px;">
                                <col style="width: 180px;">
                                <col style="width: 130px;">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th class="table-light">HS 코드</th>
                                    <td id="view_hs_code" class="fw-semibold text-primary"></td>
                                    <th class="table-light">HS 코드명</th>
                                    <td id="view_hs_code_name"></td>
                                </tr>
                                <tr>
                                    <th class="table-light">HS 코드 설명</th>
                                    <td colspan="3" id="view_hs_code_desc" class="text-secondary"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </form:form>

                <div class="card border">
                    <div class="card-header fw-bold">
                        HS 코드 목록
                    </div>
                    <div class="card-body">
                        <div id="oAuiGrid_BASIS00202_01"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
var BASIS00202 = new function() {
	
	this.grid_BASIS00202_01 = null;

    this.Initialize_viewObject = function() {
        var params = KpackageOBJ.data.makePostData("BASIS00202-form");
        KpackageOBJ.ajax.doSubmit("/basis/retrieveHsCodeDetail", params, (result) => {
            var data = result.value || {};
            $("#view_hs_code").html(data["hs_code"]);
            $("#view_hs_code_name").html(data["hs_code_name"]);
            $("#view_hs_code_desc").html(data["hs_code_desc"]);
        });

     	// AUIGrid 그리드를 생성합니다.
		BASIS00202.createAUIGrid();
		BASIS00202.retrieve_GridData();
    };
    
 // AUIGrid 를 생성합니다.
	this.createAUIGrid = function() {
		// 그리드 칼럼 레이아웃 설정
		const columnLayout = [
			{ dataField: "div_type",     	headerText: "구분", 			style: "aui-center",      width: 100, filter: { showIcon: true } },
			{ dataField: "item_code",     	headerText: "자재코드", 		style: "aui-center",      width: 100, filter: { showIcon: true } },
			{ dataField: "item_name",     	headerText: "자재명", 		style: "aui-left",        width: 200, filter: { showIcon: true } },
			{ dataField: "hs_code",     	headerText: "기존 HS CODE",  	style: "aui-center",      width: 100, filter: { showIcon: true } },
		    { dataField: "conv_hs_code",    headerText: "변경 HS CODE",  	style: "aui-center",      width: 100, filter: { showIcon: true } }
		];

		// 그리드 속성 설정
		const gridProps = {
			//추가속성이 필요한 경우 작성 
			//editable : true, // 그리드 수정 모드 
			fillColumnSizeMode: true,// 가로 스크롤 없이 현재 그리드 영역에 채우기 모드
			usePaging: false,   // 페이징 사용
			pageRowCount: 50,  // 페이지 행 개수 select UI 출력 여부 (기본값 : false)
			showPageRowSelect: true,	// 페이지 카운트 표시 여부				 
			
			enableFilter: true	// 필터 사용여부
		};

		// 실제로 #oAuiGrid_BASIS00202_01 에 그리드 생성
		// 파라메터 : Grid Div ID, 컬럼레이아웃, 그리드속성, 그리드타입(없음 : null or "", 행번호 : number ,체크박스 : check ,라디오 : radio)
		BASIS00202.grid_BASIS00202_01 = KpackageOBJ.auiGrid.create("oAuiGrid_BASIS00202_01", columnLayout, gridProps, "number");
	};
	
	this.retrieve_GridData = function(serachType){
		var params = KpackageOBJ.data.makePostData("BASIS00202-form");
		KpackageOBJ.auiGrid.retrieve(BASIS00202.grid_BASIS00202_01, "/basis/retrieveAgreementNationHsCodeList", params);
	}
};

$(document).ready(function() {
    pageSetUp();
    BASIS00202.Initialize_viewObject();
});
</script>
</html>