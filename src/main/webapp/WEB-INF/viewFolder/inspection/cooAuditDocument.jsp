<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>원산지 실사대응 서류</title>
</head>
<body>
<div class="container-fluid px-3 py-2">

	<div class="row">
		<div class="content-wrapper col-3">
            <h1 class="subheader-title mb-1">원산지 실사대응 서류</h1>
            <nav class="app-breadcrumb" aria-label="breadcrumb">
                <ol class="breadcrumb ms-0 text-muted mb-0">
                    <li class="breadcrumb-item">Home</li>
                    <li class="breadcrumb-item">FTA C/O 발급</li>
                    <li class="breadcrumb-item active" aria-current="page">원산지 실사대응 서류</li>
				</ol>
			</nav>
		</div>
		<div class="row col-9"></div>
    </div>
	<!-- 조회조건 + 상단 기능 버튼 -->
	<div class="card border shadow-sm mb-2">
	    <div class="card-body py-2 px-3">
	        <form:form id="COO_AUDIT_DOC-form" method="post" action="" novalidate="novalidate">
	            <input type="hidden" id="division_code" name="division_code"/>
	            <input type="hidden" id="export_flag" name="export_flag"/>
	            <input type="hidden" id="issue_from_date" name="issue_from_date"/>
	            <input type="hidden" id="issue_to_date" name="issue_to_date"/>
	            
	            <div class="row g-2 align-items-center">
	                <div class="col-md-2">
	                    <label for="coo_certify_no" class="form-label fw-semibold small mb-0">원산지증명번호</label>
	                </div>
	
	                <div class="col-md-4">
	                    <div class="input-group input-group-sm">
	                        <input type="text" id="coo_certify_no" name="coo_certify_no" class="form-control" value="${coo_certify_no}" readonly="readonly">
	                        <!-- 검색 팝업 호출 -->
	                        <button type="button" class="btn btn-outline-secondary" onclick="COO_AUDIT_DOC.openCooCertifySearchPopup();"> 
	                            <i class="sa sa-magnifier"></i>
	                        </button>
	
	                        <!-- 새로고침 -->
	                        <button type="button" class="btn btn-outline-secondary" onclick="COO_AUDIT_DOC.retrieveMainCooAuditDocumentInfo();"> 
	                        	<i class="sa sa-refresh"></i>
	                        </button>
	                    </div>
	                </div>
	                <div class="col-md-6">
	                    <div class="d-flex justify-content-end gap-2">
	                        <button type="button" class="btn btn-sm btn-outline-primary" onclick="COO_AUDIT_DOC.downloadFtaDocument('1')">서명대장</button>
	                        <button type="button" class="btn btn-sm btn-outline-primary" onclick="COO_AUDIT_DOC.downloadFtaDocument('2')">확인서 작성대장</button>
	                        <button type="button" class="btn btn-sm btn-outline-primary" onclick="COO_AUDIT_DOC.downloadFtaDocument('3')">원산지증명서 &amp; 원산지소명서</button>
	                    </div>
	                </div>
	            </div>
	        </form:form>
	    </div>
	</div>

    <!-- 기본 정보 -->
    <div class="card border shadow-sm mb-2">
        <div class="card-body p-0">
            <table class="table table-bordered align-middle mb-0">
                <tbody>
                <tr>
                    <th class="table-light text-center small" style="width: 14%;">원산지증명번호</th>
                    <td id="view_coo_certify_no" style="width: 22%;"></td>
                    <th class="table-light text-center small" style="width: 14%;">재발급원산지번호</th>
                    <td id="view_new_certify_no" style="width: 22%;"></td>
                    <th class="table-light text-center small" style="width: 10%;">서명권자</th>
                    <td id="view_signature_name" style="width: 18%;"></td>
                </tr>
                <tr>
                    <th class="table-light text-center small">플랜트명</th>
                    <td id="view_division_name"></td>
                    <th class="table-light text-center small">발행일자</th>
                    <td id="view_issue_date"></td>
                    <th class="table-light text-center small">포괄기간</th>
                    <td>
                        <span id="view_apply_date"></span>
                        ~
                        <span id="view_end_date"></span>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 공급하는자 -->
<div class="card border shadow-sm mb-2">
    <div class="card-body p-0">
        <table class="table table-bordered align-middle mb-0">
            <tbody>
                <tr>
                    <th class="table-light text-center fw-semibold" rowspan="2" style="width: 8%;">공급 하는자</th>
                    <th class="table-light text-center small" style="width: 8%;">상호</th>
                    <td id="view_exporter_name" style="width: 20%;"></td>

                    <th class="table-light text-center small" style="width: 8%;">대표자명</th>
                    <td id="view_exporter_representative_name" style="width: 16%;"></td>

                    <th class="table-light text-center small" style="width: 12%;">사업자등록번호</th>
                    <td id="view_exporter_biz_no" style="width: 12%;"></td>

                    <th class="table-light text-center small" style="width: 8%;">전화 / 팩스</th>
                    <td id="view_importer_tel_no" style="width: 18%;"></td>
                </tr>
                <tr>
                    <th class="table-light text-center small">주소 / 이메일</th>
                    <td id="view_exporter_address" colspan="3"></td>

                    <th class="table-light text-center small">원산지인증수출자 인증정보</th>
                    <td id="view_certification_no" colspan="3"></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- 공급받는자 -->
<div class="card border shadow-sm mb-2">
    <div class="card-body p-0">
        <table class="table table-bordered align-middle mb-0">
            <tbody>
                <tr>
                    <th class="table-light text-center fw-semibold" rowspan="2" style="width: 8%;">공급 받는자</th>
                    <th class="table-light text-center small" style="width: 8%;">상호</th>
                    <td id="view_importer_name" style="width: 20%;"></td>

                    <th class="table-light text-center small" style="width: 8%;">대표자명</th>
                    <td id="view_importer_representative_name" style="width: 16%;"></td>

                    <th class="table-light text-center small" style="width: 12%;">사업자등록번호</th>
                    <td id="view_importer_biz_no" style="width: 12%;"></td>

                    <th class="table-light text-center small" style="width: 8%;">전화 / 팩스</th>
                    <td id="view_importer_tel_no" style="width: 18%;"></td>
                </tr>
                <tr>
                    <th class="table-light text-center small">주소 / 이메일</th>
                    <td id="view_importer_address" colspan="7"></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

    <!-- 총건수 및 탭 -->
    <div class="d-flex justify-content-between align-items-center mb-2">
        <div class="fw-semibold text-primary small">
            총건수 :
            <span id="cooAuditDocument_Total_count">0</span>
        </div>
	 	<div class="d-flex justify-content-end gap-2 mb-2">
	        <button type="button" class="btn btn-sm btn-outline-primary">판정결과 상세</button>
	        <button type="button" class="btn btn-sm btn-outline-primary">소요부품 명세서</button>
	        <button type="button" class="btn btn-sm btn-outline-primary">협력사 원산지 확인서</button>
	    </div>
    </div>

    <!-- 그리드 -->
    <div class="card border shadow-sm">
        <div class="card-body p-1">
            <div id="oAuiGrid_COO_AUDIT_DOC_01" style="width: 100%; height: 480px;"></div>
        </div>
    </div>

</div>

<script>
var COO_AUDIT_DOC = new function() {

    this.grid_COO_AUDIT_DOC_01 = null;

    this.Initialize_viewObject = function() {
        this.createAUIGrid();
    };

    this.createAUIGrid = function() {
        var columnLayout = [
            {
                dataField: "checked",
                headerText: "선택",
                width: 60,
                renderer: {
                    type: "CheckBoxEditRenderer",
                    editable: true,
                    checkValue: "Y",
                    unCheckValue: "N"
                },
                style: "aui-center",
                headerStyle: "aui-center"
            },
            {
                dataField: "yyyymm",
                headerText: "전기월(매출)",
                width: 90,
                style: "aui-center",
                headerStyle: "aui-center"
            },
            {
                dataField: "customer_name",
                headerText: "납품처",
                width: 140
            },
            {
                dataField: "item_code",
                headerText: "자재 코드",
                width: 110,
                style: "aui-center",
                headerStyle: "aui-center"
            },
            {
                dataField: "item_name",
                headerText: "자재명",
                width: 140
            },
            {
                dataField: "hs_code",
                headerText: "HS코드",
                width: 90,
                style: "aui-center",
                headerStyle: "aui-center"
            },
            {
                dataField: "fta_name",
                headerText: "FTA명",
                width: 100,
                style: "aui-center",
                headerStyle: "aui-center"
            },
            {
                dataField: "rule_contents",
                headerText: "판정내용",
                width: 90,
                style: "aui-center",
                headerStyle: "aui-center"
            },
            {
                dataField: "origin_nation",
                headerText: "원산지",
                width: 70,
                style: "aui-center",
                headerStyle: "aui-center"
            },
            {
                dataField: "fta_coo_yn",
                headerText: "협정기준",
                width: 80,
                style: "aui-center",
                headerStyle: "aui-center"
            },
            {
                dataField: "company_coo_yn",
                headerText: "회사 기준",
                width: 80,
                style: "aui-center",
                headerStyle: "aui-center"
            }
        ];

        var gridProps = {
            editable: false,
            selectionMode: "singleRow",
            showRowNumColumn: false,
            enableFilter: true,
            usePaging: false,
            fillColumnSizeMode: true
        };

        COO_AUDIT_DOC.grid_COO_AUDIT_DOC_01 =
            KpackageOBJ.auiGrid.create("oAuiGrid_COO_AUDIT_DOC_01", columnLayout, gridProps);

        AUIGrid.bind(COO_AUDIT_DOC.grid_COO_AUDIT_DOC_01, "ready", function(event) {
            var list = AUIGrid.getGridData(COO_AUDIT_DOC.grid_COO_AUDIT_DOC_01) || [];
            $("#cooAuditDocument_Total_count").text(list.length.toLocaleString());
        });

        setTimeout(function() {
            $(window).trigger("resize");
        }, 200);
    };

    this.openCooCertifySearchPopup = function() {
        KpackageOBJ.dialog.open("dialog_COO_CERT_SEARCH_POPUP", "원산지확인서 작성이력", "/inspection/cooCertifyPopup", 1400, 700);
    };

    this.returnCheckedRow = function(selectObject) {
    	KpackageOBJ.dialog.close("dialog_COO_CERT_SEARCH_POPUP");  
    	
        var cooCertifyNo = selectObject && selectObject.coo_certify_no;
        var division_code = selectObject && selectObject.division_code;
        
        var export_flag = selectObject && selectObject.export_flag;
        var issue_from_date = selectObject && selectObject.apply_date;
        var issue_to_date = selectObject && selectObject.end_date;

        if (!cooCertifyNo) {
            alert("선택된 원산지확인서번호가 없습니다.");
            return;
        }

        KpackageOBJ.object.setFormValue("COO_AUDIT_DOC-form", "coo_certify_no", cooCertifyNo);
        KpackageOBJ.object.setFormValue("COO_AUDIT_DOC-form", "division_code", division_code);
        
        KpackageOBJ.object.setFormValue("COO_AUDIT_DOC-form", "export_flag", export_flag);
        KpackageOBJ.object.setFormValue("COO_AUDIT_DOC-form", "issue_from_date", issue_from_date);
        KpackageOBJ.object.setFormValue("COO_AUDIT_DOC-form", "issue_to_date", issue_to_date);
        
        

        if (typeof COO_AUDIT_DOC.retrieveMainCooAuditDocumentInfo === "function") {
            COO_AUDIT_DOC.retrieveMainCooAuditDocumentInfo();
        }
    };

    // 팝업으로 검색한 확인서 번호를 기준으로 데이터 조회
    this.retrieveMainCooAuditDocumentInfo = function() {
        var cooCertifyNo = KpackageOBJ.object.getFormValue("COO_AUDIT_DOC-form", "coo_certify_no");
        var division_code = KpackageOBJ.object.getFormValue("COO_AUDIT_DOC-form", "division_code");

        if (!cooCertifyNo) {
            alert("원산지확인서번호가 없습니다.");
            return;
        }

        var params = {
            coo_certify_no: cooCertifyNo
            ,division_code : division_code
        };

        // 1. 상단 기본정보 조회
        KpackageOBJ.ajax.doSubmit("/inspection/retrieveCooAuditDocumentInfo", params, function(result) {
            var value = result.value || {};
            var data = $.isArray(value) ? (value[0] || {}) : value;

            $("#view_coo_certify_no").text(data.coo_certify_no || "-");
            $("#view_new_certify_no").text(data.origin_coo_certify_no || "-");
            $("#view_signature_name").text(data.signature_name || "-");
            $("#view_division_name").text(data.division_name || "-");
            $("#view_issue_date").text(data.issue_date || "-");

            if (data.apply_date && data.end_date) {
                var applyDate = data.apply_date.length === 8
                    ? data.apply_date.substring(0, 4) + "-" + data.apply_date.substring(4, 6) + "-" + data.apply_date.substring(6, 8)
                    : data.apply_date;

                var endDate = data.end_date.length === 8
                    ? data.end_date.substring(0, 4) + "-" + data.end_date.substring(4, 6) + "-" + data.end_date.substring(6, 8)
                    : data.end_date;

                $("#view_apply_date").text(applyDate);
                $("#view_end_date").text(endDate);
            } else {
                $("#view_apply_date").text("-");
                $("#view_end_date").text("-");
            }

            $("#view_exporter_name").text(data.exporter_name || "-");
            $("#view_exporter_representative_name").text(data.exporter_representative_name || "-");
            $("#view_exporter_biz_no").text(data.exporter_biz_no || "-");
            $("#view_exporter_tel_no").text(data.exporter_tel_no || "-");
            $("#view_exporter_address").text(data.exporter_address || "-");
            $("#view_certification_no").text(data.certification_no || "-");

            $("#view_importer_name").text(data.producer_name || "-");
            $("#view_importer_representative_name").text(data.producer_representative_name || "-");
            $("#view_importer_biz_no").text(data.producer_biz_no || "-");
            $("#view_importer_tel_no").text(data.producer_tel_no || "-");
            $("#view_importer_address").text(data.producer_address || "-");

            // 2. 그리드 조회
            KpackageOBJ.auiGrid.retrieve(
                COO_AUDIT_DOC.grid_COO_AUDIT_DOC_01,
                "/inspection/retrieveCooAuditDocumentDetailList",
                params
            );
        });
    };
    
    
    this.downloadFtaDocument = function(docType) {
    	
    	var cooCertifyNo = KpackageOBJ.object.getFormValue("COO_AUDIT_DOC-form", "coo_certify_no");
        var division_code = KpackageOBJ.object.getFormValue("COO_AUDIT_DOC-form", "division_code");
        if (!cooCertifyNo) {
            alert("원산지증명번호가 없습니다.");
            return;
        }
        
        var url = "/ireport/downloadFtaDocument"
            + "?coo_certify_no=" + encodeURIComponent(cooCertifyNo)
            + "&division_code=" + encodeURIComponent(division_code)
            + "&P_DIRECT_DOWNLOAD=Y"
            + "&report_file_type=" + encodeURIComponent("pdf");
        
        
        var formId= "";
        var formFileName= "";
        var downFileName = "";
        
        if("1" == docType){
        	//서명 대장
        	formId = "DUMMY";
        	formFileName = "signature.jasper";
        	downFileName = "signature";
        	
        	/* 레포트별 추가 파라메터 */
        	url = url + "&P_PARAM1=" + "0" + "&P_PARAM2=&P_PARAM3=";
        }else if("2" == docType){
        	//확인서 작성대장
        	formId = "DUMMY";
        	formFileName = "coo_list_write.jasper";
        	downFileName = "coo_list_write";
        	/* 레포트별 추가 파라메터 */
        	url = url + "&P_PARAM1=" + KpackageOBJ.object.getFormValue("COO_AUDIT_DOC-form", "issue_from_date");
        	url = url + "&P_PARAM2=" + KpackageOBJ.object.getFormValue("COO_AUDIT_DOC-form", "issue_to_date");
        	url = url + "&P_PARAM3=SEARCH_COO_CERTIFY_NO";
        	url = url + "&P_PARAM4=" + encodeURIComponent(cooCertifyNo);
        }else if("3" == docType){
        	//원산지증명서 & 원산지소명서
        	formFileName = "signature.jasper";
        }else if("4" == docType){
        	formFileName = "signature.jasper";
        }else if("5" == docType){
        	formFileName = "signature.jasper";
        }
        
        
        url = url + "&form_id=" + encodeURIComponent(formId);
        url = url + "&form_file_name=" + encodeURIComponent(formFileName);
        url = url + "&p_download_file_name=" + encodeURIComponent(downFileName+"_"+cooCertifyNo);   // 다운로드할 파일명
                

        
        var iframe = document.getElementById("downloadFrame");
        if (!iframe) {
            iframe = document.createElement("iframe");
            iframe.id = "downloadFrame";
            iframe.style.display = "none";
            document.body.appendChild(iframe);
        }
        iframe.src = url;
        
        /* Toast Message*/
        MAINPAGE.showDownloadToast("다운로드가 시작되었습니다.");
        
    	
        
    };
    

};

$(document).ready(function() {
    COO_AUDIT_DOC.Initialize_viewObject();
});
</script>
</body>
</html>