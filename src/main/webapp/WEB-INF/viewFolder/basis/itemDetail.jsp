<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <style>
        .modal-header {
            border-bottom: 1px solid #e9ecef;
            padding: 16px 20px;
        }

        .modal-title {
            font-size: 22px;
            font-weight: 700;
            color: #555;
        }

        .modal-body {
            padding: 24px 20px 30px 20px;
            background: #fff;
        }

        .form-label {
            font-size: 14px;
            font-weight: 600;
            color: #8d98a5;
            margin-bottom: 8px;
        }

        .form-control {
            height: 38px;
            border: 1px solid #e5e7eb;
            border-radius: 6px;
            color: #666;
            box-shadow: none;
        }

        .form-control[readonly] {
            background-color: #f1f3f5;
            opacity: 1;
        }

        .input-group .btn {
            min-width: 42px;
        }

        .btn-icon-purple {
            background-color: #7b61c9;
            border-color: #7b61c9;
            color: #fff;
        }

        .btn-icon-purple:hover {
            background-color: #694fb5;
            border-color: #694fb5;
            color: #fff;
        }

        .btn-system {
            border: none;
            background: transparent;
            padding: 0;
        }
    </style>
</head>
<body>
    <div class="modal-body">
        <form:form id="BASIS00201-form" class="s4-form" novalidate="novalidate" action="" method="post">
            <input type="hidden" id="dialog_id" name="dialog_id" value="${dialog_id}"/>
            <input type="hidden" id="opener_pgm_id" name="opener_pgm_id" value="${opener_pgm_id}"/>

            <div class="container-fluid">
                <div class="row g-3">

                    <!-- 아이템코드 -->
                    <div class="col-md-3">
                        <label class="form-label" for="item_code">아이템코드</label>
                        <input type="text" class="form-control" id="item_code" name="item_code" value="${item_code}" readonly>
                    </div>

                    <!-- 아이템명 -->
                    <div class="col-md-9">
                        <label class="form-label" for="item_name">아이템명</label>
                        <input type="text" class="form-control" id="item_name" name="item_name" readonly>
                    </div>

                    <!-- 중량 -->
                    <div class="col-md-3">
                        <label class="form-label" for="weight">중량</label>
                        <input type="text" class="form-control" id="weight" name="weight" readonly>
                    </div>

                    <!-- 단위 -->
                    <div class="col-md-3">
                        <label class="form-label" for="unit">단위</label>
                        <input type="text" class="form-control" id="unit" name="unit" readonly>
                    </div>

                    <!-- 제품군 -->
                    <div class="col-md-3">
                        <label class="form-label" for="product_code">제품군</label>
                        <input type="text" class="form-control" id="product_code" name="product_code" readonly>
                    </div>

                    <!-- HS Code -->
                    <div class="col-md-3">
                        <label class="form-label" for="hs_code">HS Code</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="hs_code" name="hs_code">
                            <button type="button" class="btn btn-icon-purple" onclick="javascript:BASIS00201.saveHsCode();">
                                <svg class="sa-icon sa-icon-1x">
                                    <use href="/rcs/ui5x/img/sprite.svg#save"></use>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form:form>
        <hr/>
		<div class="row">
	   		<div class="col-12">
		        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		        <div id="oAuiGrid_BASIS00201_01" style="width:100%;height:185px; margin:0 auto;"></div>
		    </div>
	    </div>	
    </div>
</body>
<script>
var BASIS00201 = new function() {
	
	this.grid_BASIS00201_01 = null;

    this.Initialize_viewObject = function() {
        var params = KpackageOBJ.data.makePostData("BASIS00201-form");
        KpackageOBJ.ajax.doSubmit("/basis/retrieveItemDetailMasterInfo", params, (result) => {
            var data = result.value || {};
            KpackageOBJ.data.setFormData("BASIS00201-form", data[0]);
        });

     	// AUIGrid 그리드를 생성합니다.
		BASIS00201.createAUIGrid();
		BASIS00201.retrieve_GridData();
    };
    
 // AUIGrid 를 생성합니다.
	this.createAUIGrid = function() {
		// 그리드 칼럼 레이아웃 설정
		const columnLayout = [
		    { dataField: "division_code",     headerText: "사업부코드", 	width: 110, filter: { showIcon: true } },
		    { dataField: "division_name",     headerText: "사업부명",   	width: 150, visible: false, filter: { showIcon: true } },
		    { dataField: "assets_type",       headerText: "HS코드",   	width: 120, filter: { showIcon: true } },
		    { dataField: "importance_mgt_yn", headerText: "주요자제관리", 	width: 110, filter: { showIcon: true } },
		    { dataField: "mail_send_yn",      headerText: "메일발송",   	width: 100, filter: { showIcon: true } }
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

		// 실제로 #oAuiGrid_BASIS00201_01 에 그리드 생성
		// 파라메터 : Grid Div ID, 컬럼레이아웃, 그리드속성, 그리드타입(없음 : null or "", 행번호 : number ,체크박스 : check ,라디오 : radio)
		BASIS00201.grid_BASIS00201_01 = KpackageOBJ.auiGrid.create("oAuiGrid_BASIS00201_01", columnLayout, gridProps, "number");
	};
	
	this.retrieve_GridData = function(){
		var params = KpackageOBJ.data.makePostData("BASIS00201-form");
		KpackageOBJ.auiGrid.retrieve(BASIS00201.grid_BASIS00201_01, "/basis/retrieveItemDetailList", params);
				
	}
	
	this.saveHsCode = function(){
		var params = KpackageOBJ.data.makePostData("BASIS00201-form");
	    var hsCode = $.trim($("#hs_code").val());

	    // 1. 필수값 체크
	    if (!hsCode) {
	        alert("HS Code를 입력하세요.");
	        $("#hs_code").focus();
	        return;
	    }

	    // 2. 숫자 6자리 체크
	    if (!/^\d{6}$/.test(hsCode)) {
	        alert("HS Code는 숫자 6자리로 입력해야 합니다.");
	        $("#hs_code").focus();
	        return;
	    }

	    // 3. HS_CODE 테이블 존재 여부 체크
	    KpackageOBJ.ajax.doSubmit("/basis/checkHsCodeExists", params, function(result) {
	        var data = result.value || {};
	        var existsYn = data || "N";

	        if (existsYn !== "Y") {
	            alert("존재하지 않는 HS Code 입니다.");
	            $("#hs_code").focus();
	            return;
	        }

	        // 4. 모두 통과 시 저장
	        KpackageOBJ.ajax.doSubmit("/basis/updateItemHsCode", params, function(saveResult) {
	            alert(saveResult.message);
	            if(saveResult.success){
	            	//부모창 재조회
	            	BASIS002.retrieve_GridData();
	            }
	        });
	    });
	}
};

$(document).ready(function() {
    pageSetUp();
    BASIS00201.Initialize_viewObject();
});
</script>
</html>