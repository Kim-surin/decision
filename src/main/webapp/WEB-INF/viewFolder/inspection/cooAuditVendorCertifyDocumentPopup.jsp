<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>협력사 원산지 확인서</title>
</head>
<body>
<div class="container-fluid p-2">
	<form:form id="COO_VENDOR_CERT_POPUP-form" method="post" action="" novalidate="novalidate">
		<input type="hidden" id="coo_certify_no" name="coo_certify_no" value="${coo_certify_no}" />
		<input type="hidden" id="division_code" name="division_code" value="${division_code}" />
		<input type="hidden" id="company_code" name="company_code" value="${company_code}" />
		<input type="hidden" id="sales_no" name="sales_no" value="${sales_no}" />
		<input type="hidden" id="sales_seq" name="sales_seq" value="${sales_seq}" />
		<input type="hidden" id="fta_code" name="fta_code" value="${fta_code}" />
	
	</form:form>
    <div class="d-flex justify-content-between align-items-center mb-2">
        <div class="fw-semibold text-primary small">
            총건수 :
            <span id="cooCertifyPipup_total_count">0</span>
        </div>
    </div>

    <!-- 3행 : 그리드 -->
    <div class="card border shadow-sm">
        <div class="card-body p-1">
            <div id="oAuiGrid_COO_VENDOR_CERT_POPUP_01" style="width: 100%; height: 320px;"></div>
        </div>
    </div>
</div>

<script>
var COO_VENDOR_CERT_POPUP = new function() {

    this.grid_COO_VENDOR_CERT_POPUP_01 = null;

    this.Initialize_viewObject = function() {
        this.createAUIGrid();
    };




    this.createAUIGrid = function() {
    	var columnLayout = [
    	   
    		{
                headerText: "다운로드",
                width: 190,
                renderer: {
                    type: "ButtonRenderer",
                    labelText: "⬇ Download",
                    onClick: function(event) {
                        var item = event.item;
                        if (!item) return;
                        doDownload(item);
                    }
                },
                style: "aui-center"
            },
            {
    	        dataField: "item_name",
    	        headerText: "품목명",
    	        width: 200
    	    },
    	    {
    	        dataField: "vendor_name",
    	        headerText: "협력사명",
    	        width: 120
    	    },
    	    {
    	        dataField: "origin_file_name",
    	        headerText: "원본파일명",
    	        width: 300
    	    },
    	    /* hidden column*/
    	    { dataField: "item_code",headerText: "품목코드",width: 120,visible:false},
    	    { dataField: "vendor_code", headerText: "협력사코드", width: 120, visible: false },
    	    { dataField: "coo_certify_no", headerText: "확인서번호", width: 180, visible: false },
    	    { dataField: "file_name", headerText: "파일명", width: 180, visible: false },
    	    { dataField: "file_path", headerText: "파일경로", width: 250, visible: false },
    	    { dataField: "file_seq", headerText: "파일순번", width: 80, dataType: "numeric", style: "aui-right", visible: false },
    	    { dataField: "division_code", headerText: "사업부코드", width: 120, visible: false },
    	    { dataField: "submit_status", headerText: "제출상태", width: 100, visible: false }
        ];

        var gridProps = {
            editable: false,
            selectionMode: "singleRow",
            showRowNumColumn: false,
            enableFilter: true,
            usePaging: false,
            fillColumnSizeMode: true
        };

        COO_VENDOR_CERT_POPUP.grid_COO_VENDOR_CERT_POPUP_01 =
            KpackageOBJ.auiGrid.create("oAuiGrid_COO_VENDOR_CERT_POPUP_01", columnLayout, gridProps, "number");

        
        //다운로드 함수
        function doDownload(item) {
            if (!item) return;
            var params = item;
            params = Object.keys(params).map(function(key) {
                return encodeURIComponent(key) + "=" + encodeURIComponent(params[key]);
            }).join("&");

            /* Toast Message*/
            MAINPAGE.showDownloadToast("다운로드가 시작되었습니다.");
            KpackageOBJ.ajax.doFileDownload("COO_AUDIT_DOC-form", "/inspection/retrieveVendorCertFile", params);
        }

        
     	// 버튼 클릭 이벤트
        AUIGrid.bind(COO_VENDOR_CERT_POPUP.grid_COO_VENDOR_CERT_POPUP_01, "cellClick", function(event) {
            // TemplateRenderer 버튼 클릭 감지
            if (event.target && $(event.target).hasClass("btn-download")) {
                var item = event.item;
                doDownload(item);
            }
        });
     
     	//행 더블클릭 이벤트 (기존 유지)
        AUIGrid.bind(COO_VENDOR_CERT_POPUP.grid_COO_VENDOR_CERT_POPUP_01, "cellDoubleClick", function(event) {
            var item = event.item;
            doDownload(item);
        });
        
        AUIGrid.bind(COO_VENDOR_CERT_POPUP.grid_COO_VENDOR_CERT_POPUP_01, "ready", function (event) {
        	var list = AUIGrid.getGridData(COO_VENDOR_CERT_POPUP.grid_COO_VENDOR_CERT_POPUP_01) || [];
            $("#cooCertifyPipup_total_count").text(list.length.toLocaleString());
		});

        setTimeout(function() {
            $(window).trigger("resize");
        }, 200);
    };

    this.retrieveGridData = function() {
        var params = KpackageOBJ.data.makePostData("COO_VENDOR_CERT_POPUP-form");

        KpackageOBJ.auiGrid.retrieve(
            COO_VENDOR_CERT_POPUP.grid_COO_VENDOR_CERT_POPUP_01,
            "/inspection/retrieveVendorCertFileList",
            params
        );
    };
};

$(document).ready(function() {
    COO_VENDOR_CERT_POPUP.Initialize_viewObject();
    COO_VENDOR_CERT_POPUP.retrieveGridData();
});
</script>
</body>
</html>