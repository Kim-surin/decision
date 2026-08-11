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
				<h1 class="subheader-title mb-1">거래처 관리</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item">기초정보관리</li>
						<li class="breadcrumb-item active" aria-current="page">거래처 관리</li>
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
											<input type="text" id="searchCode" class="form-control"   onkeydown="if(event.key==='Enter'){VENDOR_MGNT.retrieve_Data(); return false;}">
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
				<div class="w-45 left-grid-area h-full" >
					<div class="d-flex grid-title mb-1">
						<div>업체 목록</div>
						<div class="radio-group" style="margin-left:auto; padding-right:30px;">
							<label class="radio-item">
								<input type="radio" id="searchGubn" name="searchGubn" value="V" onchange="VENDOR_MGNT.fnChangeSearchGubn(this)" checked>
								<span class="radio-circle"></span>
								<span>협력업체</span>
							</label>
						
							<label class="radio-item">
								<input type="radio" id="searchGubn" name="searchGubn" value="C" onchange="VENDOR_MGNT.fnChangeSearchGubn(this)">
								<span class="radio-circle"></span>
								<span>거래처</span>
							</label>
						</div>
					</div>
					<div id="oAuiGrid_vendorMgnt_L" class="w-100 h-95" ></div>
				</div>
				<div class="right-grid-area h-full" >
					<div class="w-100 h-100 d-flex flex-column">
						<div class="d-flex grid-title">
							<label>담당자 목록</label>
							<div class="demo" style="margin-left: auto;">
								<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="VENDOR_MGNT.fnSaveGridTop()">
									저장
								</button>
							</div>	
						</div>
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
								<select class="detail-card-value" id="selNation" name="selNation" disabled></select>   
								<div class="detail-card-label">팩스번호</div>
								<div id="selFaxNo" class="detail-card-value"></div>
							</div>
							<div class="detail-card-row-2">
								<div class="detail-card-label">집중관리여부</div>
								<select class="detail-card-value" id="selMgtYn" name="selMgtYn"></select>        
								<div class="detail-card-label">비고</div>
								<input class="detail-card-value detail-input h-full" type="text" id="selRemark" class="form-control">
							</div>
				    	</div>
				    	<div id="vndorInChargeDiv" style="flex:1; min-height:0;">
					    	<div class="d-flex subheader-title">
					    		<label>담당자 목록</label>
					    		<div class="demo" style="margin-left: auto;">
									<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="VENDOR_MGNT.fnAddRowGridBottom()">
										행추가
									</button>
									<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="VENDOR_MGNT.fnDelRowGridBottom()">
										행삭제
									</button>
									<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="VENDOR_MGNT.fnSaveGridBottom()">
										저장
									</button>
								</div>
					    	</div>
					    	<div id="oAuiGrid_vendorMgnt_R" class="w-full" style="flex:1; min-height:0;"></div>
				    	</div>
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
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
					dataField: "officer_name"
				  , headerText: "대표자명"
				  , width: 80
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
					dataField: "delete_yn"
				  , headerText: "삭제여부"
				  , width: 70
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
			KpackageOBJ.selectbox.create("VENDOR_MGNT-form", "searchMgtYn",  "/common/retrieveComCdList", {"CATEGORY":"YN", "OPTION_ALL":"Y", "OPTION_ALL_NAME": "전체"}, "code", "code_name");  
			KpackageOBJ.selectbox.create("VENDOR_MGNT-form", "selNation",  "/common/retrieveComCdList", {"CATEGORY":"NA", "OPTION_ALL":"Y", "OPTION_ALL_NAME": ""}, "code", "code_name");  
			KpackageOBJ.selectbox.create("VENDOR_MGNT-form", "selMgtYn",  "/common/retrieveComCdList", {"CATEGORY":"YN", "OPTION_ALL":"N"}, "code", "code_name");  
			
			VENDOR_MGNT.createAUIGrid();
		    VENDOR_MGNT.retrieve_Data();
		}
		
		// Grid Init
		this.createAUIGrid = function () {
			const leftGridProps = {
				selectionMode : "singleRow",
				usePaging: true,
				pageRowCount: 50,
				showPageRowSelect: true,
				enableFilter: true,
				fillColumnSizeMode:true,
				showStateColumn:false
			};
			
			const rightGridProps = {
					usePaging: true,
					pageRowCount: 50,
					showPageRowSelect: true,
					enableFilter: true,
					fillColumnSizeMode:true,
					showStateColumn:true,
					editable : true
				};


			VENDOR_MGNT.gridIdL = KpackageOBJ.auiGrid.create("oAuiGrid_vendorMgnt_L", VENDOR_MGNT.state["vendorLeftGridColumnLayout"], leftGridProps, "");
			VENDOR_MGNT.gridIdR = KpackageOBJ.auiGrid.create("oAuiGrid_vendorMgnt_R", VENDOR_MGNT.state["vendorRightGridColumnLayout"], rightGridProps, "check");
			
			
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
				$("#selRemark").val(VENDOR_MGNT.state['masterRow']['remark']);
				
				if(KpackageOBJ.object.getFormRadioValue("VENDOR_MGNT-form", "searchGubn") === "V"){
					VENDOR_MGNT.retrieve_rightVendorGridData();
				}
			});

		}
		
		//조회
		this.retrieve_Data = function () {
			const searchGubn = KpackageOBJ.object.getFormRadioValue("VENDOR_MGNT-form", "searchGubn");
			
			//우측 상세 데이터 초기화 
			VENDOR_MGNT.fnInitDetail();
			//우측 그리드 초기화
			KpackageOBJ.auiGrid.clearGridData(VENDOR_MGNT.gridIdR);
			
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
		
		
		//우측 상단 저장버튼
		this.fnSaveGridTop = function () {
		  	if(oUtil.isNull(VENDOR_MGNT.state['masterRow']['vc_code'])){
				KpackageOBJ.object.alert("업체를 먼저 선택해주세요.");
				return;
			}
	    	
			if (!confirm("저장하시겠습니까?")) {
	        	return;
	        }	
				
			
			const searchGubn = KpackageOBJ.object.getFormRadioValue("VENDOR_MGNT-form", "searchGubn");
			
			var params = {
				 "selVcCode": VENDOR_MGNT.state['masterRow']['vc_code']
				, "selMgtYn": KpackageOBJ.object.getFormValue("VENDOR_MGNT-form", "selMgtYn")
				, "selRemark": KpackageOBJ.object.getFormValue("VENDOR_MGNT-form", "selRemark")
			}
			
			
			switch(searchGubn){
				case "V":
					KpackageOBJ.ajax.doSubmit("/origin/basis/vendorMgnt/updateVendorData", params, VENDOR_MGNT.fnSaveGridTopCallBack);
					break;
				case "C":
					KpackageOBJ.ajax.doSubmit("/origin/basis/vendorMgnt/updateCustomerData", params, VENDOR_MGNT.fnSaveGridTopCallBack);
					break;	
				default: //VENDOR 검색이 DEFAULT 
					return;
					
			}
		
		};
		
		//우측 상단 저장버튼 콜백
		this.fnSaveGridTopCallBack = function (res) {
			const selectIndex = KpackageOBJ.auiGrid.getSelectedIndex(VENDOR_MGNT.gridIdL);
			
			if(res.success){
				//좌측 그리드 데이터 처리 
				KpackageOBJ.auiGrid.setCellValue(VENDOR_MGNT.gridIdL, selectIndex[0], "mgt_yn",  KpackageOBJ.object.getFormValue("VENDOR_MGNT-form", "selMgtYn"));
				KpackageOBJ.auiGrid.setCellValue(VENDOR_MGNT.gridIdL, selectIndex[0], "remark",  KpackageOBJ.object.getFormValue("VENDOR_MGNT-form", "selRemark"));
				
				
				KpackageOBJ.object.alert("저장되었습니다.");
			}else{
				KpackageOBJ.object.alert(res.message);
			}
		};
		
		
		
		//우측 하단 그리드 행추가
		this.fnAddRowGridBottom = function () {
	    	if(oUtil.isNull(VENDOR_MGNT.state['masterRow']['vc_code'])){
				KpackageOBJ.object.alert("업체를 먼저 선택해주세요.");
				return;
			}
	    	
			const item = {};
			KpackageOBJ.auiGrid.addRow(VENDOR_MGNT.gridIdR, item);
		};
		
		//우측 하단 그리드 행삭제
		this.fnDelRowGridBottom = function () {
			const data = KpackageOBJ.auiGrid.getCheckedRowItemsAll(VENDOR_MGNT.gridIdR);
			
	    	if(oUtil.isNull(VENDOR_MGNT.state['masterRow']['vc_code'])){
				KpackageOBJ.object.alert("업체를 먼저 선택해주세요.");
				return;
			}
	    	
			if(data.length == 0){
				KpackageOBJ.object.alert("데이터가 선택되지 않았습니다.");
				return false;
			}
							
			KpackageOBJ.auiGrid.removeCheckedRows(VENDOR_MGNT.gridIdR);
			
		};
		
		//우측 하단 그리드 담당자 저장
		this.fnSaveGridBottom = function () {
			if(oUtil.isNull(VENDOR_MGNT.state['masterRow']['vc_code'])){
				KpackageOBJ.object.alert("업체를 먼저 선택해주세요.");
				return;
			}
			
			const data = KpackageOBJ.auiGrid.getGridCudData(VENDOR_MGNT.gridIdR);
			const isValid = KpackageOBJ.auiGrid.validateGridData(VENDOR_MGNT.gridIdR, ["name_kor"], "해당 값은 필수 입력값입니다.")
							
			if(data.length === 0){
				KpackageOBJ.object.alert("저장할 데이터가 없습니다.");
				return;
			}

			if(isValid){
				if (!confirm("저장하시겠습니까?")) {
	            	return;
	        	}	
				
				
				var params = {
					 "SAVE_LIST" : data
					, "SEL_MASTER" : VENDOR_MGNT.state['masterRow']
				};
				KpackageOBJ.ajax.doSubmit("/origin/basis/vendorMgnt/saveVendorInchargeList", params, VENDOR_MGNT.fnSaveGridBottomCallBack);
			}
		};
		
		this.fnSaveGridBottomCallBack = function(res) {
			if(res.success){
				KpackageOBJ.object.alert("저장되었습니다.");
				VENDOR_MGNT.retrieve_rightVendorGridData();
			}else{
				KpackageOBJ.object.alert(res.message);
			}
		};
		
		//상세 정보 초기화
		this.fnInitDetail = function(){
			$("#selVcName").text("");
			$("#selVcNameEng").text("");
			$("#selAddress").text("");
			$("#selAddressEng").text("");
			$("#selNation").val("");
			$("#selFaxNo").text("");
			$("#selMgtYn").val("");
			$("#selRemark").text("");
		};
		
		
		//협력업체 거래처 변경 이벤트 
		this.fnChangeSearchGubn = function (obj) {
			
			if(obj.value === "C"){  //거래처
				$('#vndorInChargeDiv').hide(); 
			}else{
				$('#vndorInChargeDiv').show();
			}
			
			
			VENDOR_MGNT.retrieve_Data();
		};
		
		
	}


	$(document).ready(function () {
		VENDOR_MGNT.Initialize_viewObject();

	});

</script>
</html>