<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<div class="content-wrapper">
	    <div class="row">
			<div class="content-wrapper col-3">
				<h1 class="subheader-title mb-1">회사추가</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item">시스템관리</li>
						<li class="breadcrumb-item active" aria-current="page">회사추가</li>
					</ol>
				</nav>
			</div>
		</div>
	    <div class="row">
			<div id="panel-4" class="panel panel-icon">
				<div class="panel-container show">
					<div class="panel-content">
						<div class="row">
							<div class="col-2">
								<div class="mb-3">
									<div class="row">
										<label class="form-label" for="company_search_use_yn">사용 여부</label>
									</div>
									<div class="col">
										<select id="company_search_use_yn" class="form-select">
				                            <option value="">전체</option>
				                            <option value="Y" selected>사용</option>
				                            <option value="N">미사용</option>
				                        </select>
									</div>
								</div>
		                    </div>
		                    <div class="col-2">
		                    	<div class="mb-3">
									<div class="row">
										<label class="form-label" for="company_search_type">검색조건</label>
									</div>
									<div class="col">
										<select id="company_search_type" class="form-select">
				                            <option value="COMPANY_NAME" selected>회사명</option>
				                            <option value="COMPANY_CODE">회사코드</option>
				                            <option value="BUSINESS_NO">사업자등록번호</option>
				                        </select>
									</div>
								</div>
		                    </div>
		                    <div class="col">
		                    	<div class="mb-3">
									<div class="row">
										<label class="form-label" for="company_search_keyword">검색어</label>
									</div>
									<div class="col">
										<input type="text" id="company_search_keyword" class="form-control" maxlength="200"
		                               			onkeydown="if(event.keyCode===13){COMPANY000.retrieveCompanyList();}">
									</div>
								</div>
								
		                    </div>
							<div class="col-1 text-end">
								<button type="button"
										onclick="javascript:COMPANY000.retrieveCompanyList();"
										class="btn btn-sm btn-search search-no-more waves-effect waves-themed">Search</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="d-flex frame-wrap" style="align-items: center;">
					<div class="demo" style="margin-left: auto;">
						<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="COMPANY000.newCompany()">
							회사추가
						</button>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div id="oAuiGrid_COMPANY000_01" class="w-full" style="height:600px; margin:0 auto;"></div>
			</div>
		</div>
	</div>

	<!-- 회사 등록/수정 Modal -->
	<div class="modal fade" id="COMPANY000-modal" tabindex="-1" aria-hidden="true">
	    <div class="modal-dialog modal-xl modal-dialog-scrollable">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 id="COMPANY000-modal-title" class="modal-title">회사 추가</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">
	                <form:form id="COMPANY000-form" class="s4-form" novalidate="novalidate" action="" method="post">
	                    <input type="hidden" id="company_save_type" name="save_type" value="I">
	
	                    <h6 class="mb-3">기본정보</h6>
	                    <div class="row">
	                        <div class="mb-3 col-4">
	                            <label class="form-label" for="TMP_COMPANY_CODE">회사코드 <span class="text-danger">*</span></label>
	                            <input type="text" id="TMP_COMPANY_CODE" name="TMP_COMPANY_CODE" class="form-control" maxlength="20" required>
	                        </div>
	                        <div class="mb-3 col-4">
	                            <label class="form-label" for="hr_company_code">회사코드(HR)</label>
	                            <input type="text" id="hr_company_code" name="hr_company_code" class="form-control" maxlength="20">
	                        </div>
	                        <div class="mb-3 col-4">
	                            <label class="form-label" for="company_use_yn">회사 사용 여부 <span class="text-danger">*</span></label>
	                            <select id="company_use_yn" name="company_use_yn" class="form-select">
	                                <option value="Y">사용</option>
	                                <option value="N">미사용</option>
	                            </select>
	                        </div>
	                        <div class="mb-3 col-4">
	                            <label class="form-label" for="company_name">회사명 <span class="text-danger">*</span></label>
	                            <input type="text" id="company_name" name="company_name" class="form-control" maxlength="200" required>
	                        </div>
	                        <div class="mb-3 col-4">
	                            <label class="form-label" for="company_name_eng">회사명(영문)</label>
	                            <input type="text" id="company_name_eng" name="company_name_eng" class="form-control" maxlength="200">
	                        </div>
	                        <div class="mb-3 col-4">
	                            <label class="form-label" for="company_name_loc">회사명(로컬)</label>
	                            <input type="text" id="company_name_loc" name="company_name_loc" class="form-control" maxlength="200">
	                        </div>
	                        <div class="mb-3 col-2">
	                            <label class="form-label" for="zip_code">우편번호</label>
	                            <input type="text" id="zip_code" name="zip_code" class="form-control" maxlength="7">
	                        </div>
	                        <div class="mb-3 col-5">
	                            <label class="form-label" for="address">주소</label>
	                            <input type="text" id="address" name="address" class="form-control" maxlength="200">
	                        </div>
	                        <div class="mb-3 col-5">
	                            <label class="form-label" for="address_eng">영문주소</label>
	                            <input type="text" id="address_eng" name="address_eng" class="form-control" maxlength="500">
	                        </div>
	                        <div class="mb-3 col-3">
	                            <label class="form-label" for="city_name">도시명</label>
	                            <input type="text" id="city_name" name="city_name" class="form-control" maxlength="100">
	                        </div>
	                        <div class="mb-3 col-3">
	                            <label class="form-label" for="city_name_eng">영문 도시명</label>
	                            <input type="text" id="city_name_eng" name="city_name_eng" class="form-control" maxlength="100">
	                        </div>
	                        <div class="mb-3 col-3">
	                            <label class="form-label" for="com_phone_no">회사 전화번호</label>
	                            <input type="text" id="com_phone_no" name="com_phone_no" class="form-control" maxlength="20">
	                        </div>
	                        <div class="mb-3 col-3">
	                            <label class="form-label" for="com_fax_no">회사 팩스번호</label>
	                            <input type="text" id="com_fax_no" name="com_fax_no" class="form-control" maxlength="20">
	                        </div>
	                    </div>
	
	                    <hr>
	                    <h6 class="mb-3">사업자 및 담당자 정보</h6>
	                    <div class="row">
	                        <div class="mb-3 col-3">
	                            <label class="form-label" for="business_no">사업자등록번호</label>
	                            <input type="text" id="business_no" name="business_no" class="form-control" maxlength="15">
	                        </div>
	                        <div class="mb-3 col-3">
	                            <label class="form-label" for="officer_name">담당자명(대표자명)</label>
	                            <input type="text" id="officer_name" name="officer_name" class="form-control" maxlength="50">
	                        </div>
	                        <div class="mb-3 col-3">
	                            <label class="form-label" for="officer_name_eng">담당자 영문명</label>
	                            <input type="text" id="officer_name_eng" name="officer_name_eng" class="form-control" maxlength="50">
	                        </div>
	                        <div class="mb-3 col-3">
	                            <label class="form-label" for="officer_phone_no">담당자 전화번호</label>
	                            <input type="text" id="officer_phone_no" name="officer_phone_no" class="form-control" maxlength="20">
	                        </div>
	                        <div class="mb-3 col-4">
	                            <label class="form-label" for="officer_email">담당자 이메일</label>
	                            <input type="email" id="officer_email" name="officer_email" class="form-control" maxlength="50">
	                        </div>
	                        <div class="mb-3 col-4">
	                            <label class="form-label" for="send_receive_identifier_code">송수신 식별코드</label>
	                            <input type="text" id="send_receive_identifier_code" name="send_receive_identifier_code" class="form-control" maxlength="50">
	                        </div>
	                        <div class="mb-3 col-4">
	                            <label class="form-label" for="default_language">기본 언어</label>
	                            <select id="default_language" name="default_language" class="form-select">
	                                <option value="KOR">한국어</option>
	                                <option value="ENG">English</option>
	                                <option value="LOC">Local</option>
	                            </select>
	                        </div>
	                    </div>
	
	                    <hr>
	                    <h6 class="mb-3">원산지 및 회사 옵션</h6>
	                    <div class="row">
	                        <div class="mb-3 col-3">
	                            <label class="form-label" for="co_certified_exporter_yn">인증수출자 여부 <span class="text-danger">*</span></label>
	                            <select id="co_certified_exporter_yn" name="co_certified_exporter_yn" class="form-select" onchange="COMPANY000.changeCertifiedExporter();">
	                                <option value="N">아니오</option>
	                                <option value="Y">예</option>
	                            </select>
	                        </div>
	                        <div class="mb-3 col-3">
	                            <label class="form-label" for="certification_type">인증타입</label>
	                            <select id="certification_type" name="certification_type" class="form-select">
	                                <option value="">선택</option>
	                                <option value="C">사업장별 인증</option>
	                                <option value="I">품목별 인증</option>
	                            </select>
	                        </div>
	                        <div class="mb-3 col-6">
	                            <label class="form-label" for="certification_no">인증수출자 번호</label>
	                            <input type="text" id="certification_no" name="certification_no" class="form-control" maxlength="50">
	                        </div>
	                        <div class="mb-3 col-3">
	                            <label class="form-label" for="material_use_yn">수불부 사용 여부</label>
	                            <select id="material_use_yn" name="material_use_yn" class="form-select">
	                                <option value="N">미사용</option>
	                                <option value="Y">사용</option>
	                            </select>
	                        </div>
	                        <div class="mb-3 col-3">
	                            <label class="form-label" for="basic_aging_period">기초 재고회전 기간</label>
	                            <input type="number" id="basic_aging_period" name="basic_aging_period" class="form-control" min="0" step="1" value="0">
	                        </div>
	                        <div class="mb-3 col-3">
	                            <label class="form-label" for="inventory_valuation_method">재고평가방법</label>
	                            <select id="inventory_valuation_method" name="inventory_valuation_method" class="form-select">
	                                <option value="">선택</option>
	                                <option value="A">이동평균</option>
	                                <option value="F">선입선출</option>
	                                <option value="L">후입선출</option>
	                            </select>
	                        </div>
	                        <div class="mb-3 col-3">
	                            <label class="form-label" for="ctc_decision_only_yn">세번변경 판정만 수행</label>
	                            <select id="ctc_decision_only_yn" name="ctc_decision_only_yn" class="form-select">
	                                <option value="N">아니오</option>
	                                <option value="Y">예</option>
	                            </select>
	                        </div>
	                        <div class="mb-3 col-3">
	                            <label class="form-label" for="com_de_minimis_rate">미소기준 버퍼율(%) <span class="text-danger">*</span></label>
	                            <input type="number" id="com_de_minimis_rate" name="com_de_minimis_rate" class="form-control" min="0" max="999.99" step="0.01" value="0.00">
	                        </div>
	                        <div class="mb-3 col-3">
	                            <label class="form-label" for="com_rvc_rate">부가가치 버퍼율(%) <span class="text-danger">*</span></label>
	                            <input type="number" id="com_rvc_rate" name="com_rvc_rate" class="form-control" min="0" max="999.99" step="0.01" value="0.00">
	                        </div>
	                    </div>
	                </form:form>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	                <button type="button" class="btn btn-primary" onclick="COMPANY000.saveCompany();">저장</button>
	            </div>
	        </div>
	    </div>
	</div>

<script>
var COMPANY000 = new function() {

    this.grid_COMPANY000_01 = null;
    this.selectedCompanyCode = null;

    this.Initialize_viewObject = function() {
        COMPANY000.createCompanyGrid();
        COMPANY000.retrieveCompanyList();
    };

    this.createCompanyGrid = function() {
        var columns = [
            { dataField: "company_code", headerText: "회사코드", width: 130 },
            { dataField: "company_name", headerText: "회사명", width: 230 },
            { dataField: "company_name_eng", headerText: "회사명(영문)", width: 230 },
            { dataField: "business_no", headerText: "사업자등록번호", width: 140 },
            { dataField: "officer_name", headerText: "대표자명", width: 120 },
            { dataField: "material_use_yn", headerText: "수불부 사용", width: 100 },
            { dataField: "company_use_yn", headerText: "회사 사용", width: 90 }
        ];
        var props = {
            editable: false,
            selectionMode: "singleRow",
            usePaging: true,
            pageRowCount: 100,
            showPageRowSelect: false,
            rowIdField: "company_code"
        };

        COMPANY000.grid_COMPANY000_01 = KpackageOBJ.auiGrid.create(
            "oAuiGrid_COMPANY000_01", columns, props, "number"
        );

        AUIGrid.bind(COMPANY000.grid_COMPANY000_01, "cellDoubleClick", function(event) {
            COMPANY000.retrieveCompanyDetail(event.item.company_code);
        });
    };

    this.retrieveCompanyList = function() {
        KpackageOBJ.ajax.doSubmit(
            "/origin/systemmgmt/companyMgmt/retrieveCompanyList",
            {
                company_use_yn: $("#company_search_use_yn").val(),
                search_type: $("#company_search_type").val(),
                search_keyword: $.trim($("#company_search_keyword").val())
            },
            function(result) {
                var list = result.value || [];
                AUIGrid.setGridData(COMPANY000.grid_COMPANY000_01, list);
            }
        );
    };

    this.retrieveCompanyDetail = function(companyCode) {
        KpackageOBJ.ajax.doSubmit(
            "/origin/systemmgmt/companyMgmt/retrieveCompanyDetail",
            { TMP_COMPANY_CODE: companyCode },
            function(result) {
                var data = result.value;
                if (!data) {
                    alert("회사 정보를 찾을 수 없습니다.");
                    return;
                }
                document.getElementById("COMPANY000-form").reset();
                KpackageOBJ.data.setFormData("COMPANY000-form", data);
                $("#TMP_COMPANY_CODE").val(data.company_code).prop("readonly", true);
                $("#company_save_type").val("U");
                $("#COMPANY000-modal-title").text(data.company_name + " (" + data.company_code + ")");
                COMPANY000.changeCertifiedExporter();
                COMPANY000.openModal();
            }
        );
    };

    this.newCompany = function() {
        document.getElementById("COMPANY000-form").reset();
        $("#company_save_type").val("I");
        $("#TMP_COMPANY_CODE").prop("readonly", false);
        $("#company_use_yn").val("Y");
        $("#co_certified_exporter_yn").val("N");
        $("#material_use_yn").val("N");
        $("#ctc_decision_only_yn").val("N");
        $("#default_language").val("KOR");
        $("#basic_aging_period").val("0");
        $("#com_de_minimis_rate").val("0.00");
        $("#com_rvc_rate").val("0.00");
        $("#COMPANY000-modal-title").text("회사 추가");
        COMPANY000.changeCertifiedExporter();
        COMPANY000.openModal();
        window.setTimeout(function() { $("#TMP_COMPANY_CODE").focus(); }, 200);
    };

    this.saveCompany = function() {
        if (!COMPANY000.validateForm()) return;

        var params = KpackageOBJ.data.makePostData("COMPANY000-form");
        // disabled 된 인증수출자 항목도 MyBatis에 항상 전달한다.
        if ($("#co_certified_exporter_yn").val() === "N") {
            params.certification_type = "";
            params.certification_no = "";
        }
        KpackageOBJ.ajax.doSubmit(
            "/origin/systemmgmt/companyMgmt/saveCompany",
            params,
            function(result) {
                alert(result.message);
                if (!result.success) return;
                COMPANY000.closeModal();
                COMPANY000.selectedCompanyCode = result.value.company_code;
                COMPANY000.retrieveCompanyList();
            }
        );
    };

    this.validateForm = function() {
        if (!$.trim($("#TMP_COMPANY_CODE").val())) {
            alert("회사코드를 입력해 주세요.");
            $("#TMP_COMPANY_CODE").focus();
            return false;
        }
        if (!$.trim($("#company_name").val())) {
            alert("회사명을 입력해 주세요.");
            $("#company_name").focus();
            return false;
        }
        if ($("#co_certified_exporter_yn").val() === "Y"
                && !$.trim($("#certification_no").val())) {
            alert("인증수출자 번호를 입력해 주세요.");
            $("#certification_no").focus();
            return false;
        }

        var deMinimis = Number($("#com_de_minimis_rate").val());
        var rvc = Number($("#com_rvc_rate").val());
        if (isNaN(deMinimis) || deMinimis < 0 || deMinimis > 999.99
                || isNaN(rvc) || rvc < 0 || rvc > 999.99) {
            alert("버퍼율은 0부터 999.99 사이로 입력해 주세요.");
            return false;
        }
        return true;
    };

    this.changeCertifiedExporter = function() {
        var enabled = $("#co_certified_exporter_yn").val() === "Y";
        $("#certification_type, #certification_no").prop("disabled", !enabled);
        if (!enabled) {
            $("#certification_type, #certification_no").val("");
        }
    };

    this.openModal = function() {
        if (window.bootstrap && bootstrap.Modal) {
            bootstrap.Modal.getOrCreateInstance(document.getElementById("COMPANY000-modal")).show();
        } else {
            $("#COMPANY000-modal").modal("show");
        }
    };

    this.closeModal = function() {
        if (window.bootstrap && bootstrap.Modal) {
            bootstrap.Modal.getOrCreateInstance(document.getElementById("COMPANY000-modal")).hide();
        } else {
            $("#COMPANY000-modal").modal("hide");
        }
    };
};

$(document).ready(function() {
    pageSetUp();
    COMPANY000.Initialize_viewObject();
});
</script>
</body>
</html>