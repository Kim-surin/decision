<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
				<h1 class="subheader-title mb-1">협력업체</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item">기초정보관리</li>
						<li class="breadcrumb-item active" aria-current="page">협력업체</li>
					</ol>
				</nav>
			</div>
		</div>
		<form:form id="VENDOR_MGNT-form" class="s4-form" novalidate="novalidate" onsubmit="VENDOR_MGNT.retrieve_Data(); return false;">
			<div class="row">
				<input type="hidden" id="popParam"/>
				<div id="panel-4" class="panel panel-icon">
					<div class="panel-container show">
						<div class="panel-content">
							<div class="row">
								<div class="col-3">
									<div class="mb-3">
										<div class="row">
											<label class="form-label" for="example-input-border">업체코드/명</label>
										</div>
										<div class="col">
											<input type="text" id="searchCode" class="form-control" >
										</div>
									</div>
								</div>
								<div class="col-3">
									<div class="mb-3">
										<div class="row">
											<label class="form-label" for="example-input-border">집중관리 여부</label>
										</div>
										<div class="col">
											<select class="form-control w-full" id="searchMgtYn" name="searchMgtYn" style="width:110px"></select>        
										</div>
									</div>
								</div>
								<div class="col-5">
								</div>
								<div class="col">
									<button type="button"
										onclick="javascript:VENDOR_MGNT.retrieve_Data();"
										class="btn btn-sm btn-search search-no-more waves-effect waves-themed">Search</button>
								</div>
							</div>
	
						</div>
					</div>
				</div>
			</div>
			<div class="d-flex col-12 dual-grid-wrap mt-2" style="height: calc(100vh - 350px);" >
				<div class="w-35 left-grid-area h-full" >
					<div class="d-flex grid-title mb-1">
						<div>업체 목록</div>
						<div class="radio-group" style="margin-left:auto; padding-right:30px;">
							<label class="radio-item">
								<input type="radio" id="searchGubn" name="searchGubn" value="V" checked>
								<span class="radio-circle"></span>
								<span>협력업체</span>
							</label>
						
							<label class="radio-item">
								<input type="radio" id="searchGubn" name="searchGubn" value="C">
								<span class="radio-circle"></span>
								<span>거래처</span>
							</label>
						</div>
					</div>
					<div id="oAuiGrid_vendorMgnt_L" class="w-100 h-95" ></div>
				</div>
				<div class="right-grid-area h-full" >
					<div class="w-100 h-100 d-flex flex-column">
				    	<div class="grid-title mb-1">업체 상세 정보</div>
				    	<div class="detail-card mb-3">
				    		<div class="detail-card-row">
								<div class="detail-card-label">업체명</div>
								<div id="selVcName" class="detail-card-value"></div>
								<div class=" detail-card-label">업체영문명</div>
								<div id="selVcNameEng" class="detail-card-value"></div>
							</div>
							<div class="detail-card-row">
								<div class="detail-card-label">주소</div>
								<div id="selAddress" class="detail-card-value"></div>
							</div>
							<div class="detail-card-row">
								<div class="detail-card-label">영문주소</div>
								<div id="selAddressEng" class="detail-card-value"></div>
							</div>
							<div class="detail-card-row-2">
								<div class="detail-card-label">국가명</div>
								<select class="detail-card-value" id="selNation" name="selMgtYn" disabled></select>   
								<div class="detail-card-label">팩스번호</div>
								<div id="selFaxNo" class="detail-card-value"></div>
							</div>
							<div class="detail-card-row-2">
								<div class="detail-card-label">집중관리여부</div>
								<select class="detail-card-value" id="selMgtYn" name="selMgtYn"></select>        
								<div class="detail-card-label">비고</div>
								<div id="selRemark" class="detail-card-value"></div>
							</div>
				    	</div>
				    	<div class="d-flex subheader-title mb-1">
				    		<label>담당자 목록</label>
				    		<div class="demo" style="margin-left: auto;">
								<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="FTA_INCOTERMS.fnAddRow()">
									행추가
								</button>
								<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="FTA_INCOTERMS.fnDelRow()">
									행삭제
								</button>
								<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="FTA_INCOTERMS.fnSave()">
									저장
								</button>
							</div>
				    		
				    	</div>
				    	<div id="oAuiGrid_vendorMgnt_R" class="w-100" style="flex:1; min-height:0;"></div>
						
					</div>
				</div>
			</div>
		</form:form>
	</div>
</body>

<script type="text/javascript">

	var VENDOR_MGNT = new function () {
		this.gridIdL = null;
		this.gridIdR = null;
		this.state = {
			masterRow : {},	
			vendorLeftGridColumnLayout : [
				{
					dataField: "vc_code"
				  , headerText: "업체코드"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
					dataField: "vc_name"
				  , headerText: "업체명"
				  , width: 150
				  , style: "grid-left-text"
				  , filter: {showIcon: true}
				},
				{
					dataField: "business_no"
				  , headerText: "사업자등록번호"
				  , width: 120
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
					dataField: "officer_name"
				  , headerText: "대표자명"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
					dataField: "tel_no"
				  , headerText: "전화번호"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
			],
			vendorRightGridColumnLayout : [
				{
					dataField: "name_kor"
				  , headerText: "담당자명"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
					dataField: "name_eng"
				  , headerText: "영문 담당자명"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
					dataField: "position"
				  , headerText: "직급"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
					dataField: "email"
				  , headerText: "이메일"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
					dataField: "tel_no"
				  , headerText: "전화번호"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
					dataField: "remark"
				  , headerText: "비고"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
			]
		};
		
		//View Object Init
		this.Initialize_viewObject = function () {
			KpackageOBJ.selectbox.create("VENDOR_MGNT-form", "searchMgtYn",  "/common/retrieveComCdList", {"CATEGORY":"YN", "OPTION_ALL":"Y"}, "code", "code_name");  
			KpackageOBJ.selectbox.create("VENDOR_MGNT-form", "selNation",  "/common/retrieveComCdList", {"CATEGORY":"NA", "OPTION_ALL":"Y", "OPTION_ALL_NAME": ""}, "code", "code_name");  
			KpackageOBJ.selectbox.create("VENDOR_MGNT-form", "selMgtYn",  "/common/retrieveComCdList", {"CATEGORY":"YN", "OPTION_ALL":"N"}, "code", "code_name");  
			
			VENDOR_MGNT.createAUIGrid();
		    VENDOR_MGNT.retrieve_Data();
		}
		
		// Grid Init
		this.createAUIGrid = function () {
			const gridProps = {
				selectionMode : "singleRow",
				usePaging: true,
				pageRowCount: 50,
				showPageRowSelect: true,
				enableFilter: true,
				fillColumnSizeMode:true,
				showStateColumn:true
			};


			VENDOR_MGNT.gridIdL = KpackageOBJ.auiGrid.create("oAuiGrid_vendorMgnt_L", VENDOR_MGNT.state["vendorLeftGridColumnLayout"], gridProps, "");
			VENDOR_MGNT.gridIdR = KpackageOBJ.auiGrid.create("oAuiGrid_vendorMgnt_R", VENDOR_MGNT.state["vendorRightGridColumnLayout"], gridProps, "check");
			
			
			// 좌측 GRID 이벤트 바인드
			KpackageOBJ.auiGrid.bind(VENDOR_MGNT.gridIdL, "selectionChange", function( event ) {
				VENDOR_MGNT.state['masterRow'] = event.selectedItems[0].item;
				
				$("#selVcName").text(VENDOR_MGNT.state['masterRow']['vc_name']);
				$("#selVcNameEng").text(VENDOR_MGNT.state['masterRow']['vc_name_eng']);
				$("#selAddress").text(VENDOR_MGNT.state['masterRow']['address']);
				$("#selAddressEng").text(VENDOR_MGNT.state['masterRow']['address_eng']);
				$("#selNation").val(VENDOR_MGNT.state['masterRow']['nation_code']);
				$("#selFaxNo").text(VENDOR_MGNT.state['masterRow']['fax_no']);
				$("#selMgtYn").val(VENDOR_MGNT.state['masterRow']['mgt_yn']);
				$("#selRemark").text(VENDOR_MGNT.state['masterRow']['remark']);
				
				if(KpackageOBJ.object.getFormRadioValue("VENDOR_MGNT-form", "searchGubn") === "V"){
					VENDOR_MGNT.retrieve_rightVendorGridData();
				}
			});

		}
		
		//조회
		this.retrieve_Data = function () {
			const searchGubn = KpackageOBJ.object.getFormRadioValue("VENDOR_MGNT-form", "searchGubn");
			
			switch(searchGubn){
				case "V":
					VENDOR_MGNT.retrieve_leftVendorGridData();
					break;
				case "C":
					VENDOR_MGNT.retrieve_leftCustomerGridData();
					break;	
				default: //VENDOR 검색이 DEFAULT 
					return;
					
			}
		};
		
		//좌측그리드 - VENDOR
		this.retrieve_leftVendorGridData = function () {
			
			var params = {
				"searchCode": KpackageOBJ.object.getFormValue("VENDOR_MGNT-form", "searchCode")
				, "searchMgtYn": KpackageOBJ.object.getFormValue("VENDOR_MGNT-form", "searchMgtYn")
			}
			
			KpackageOBJ.auiGrid.retrieve(VENDOR_MGNT.gridIdL, "/origin/basis/vendorMgnt/retrieveVendorList", params);
		}
		
		//좌측그리드 - VENDOR
		this.retrieve_leftCustomerGridData = function () {
			var params = {
				"searchCode": KpackageOBJ.object.getFormValue("VENDOR_MGNT-form", "searchCode")
				, "searchMgtYn": KpackageOBJ.object.getFormValue("VENDOR_MGNT-form", "searchMgtYn")
			}
			
			KpackageOBJ.auiGrid.retrieve(VENDOR_MGNT.gridIdL, "/origin/basis/vendorMgnt/retrieveCustomerList", params);
		}
		
		//우측그리드 조회 - VENDOR 담당자
		this.retrieve_rightVendorGridData = function () {
			KpackageOBJ.auiGrid.retrieve(VENDOR_MGNT.gridIdR, "/origin/basis/vendorMgnt/retrieveVendorInChargeList", VENDOR_MGNT.state['masterRow']);
		}
	}


	$(document).ready(function () {
		VENDOR_MGNT.Initialize_viewObject();

	});

</script>
</html>