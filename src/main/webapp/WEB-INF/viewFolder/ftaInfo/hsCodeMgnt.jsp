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
				<h1 class="subheader-title mb-1">FTA HSCODE 결정기준</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item">FTA 정보 관리</li>
						<li class="breadcrumb-item active" aria-current="page">FTA HSCODE 결정기준</li>
					</ol>
				</nav>
			</div>
		</div>
		<div class="row">
			<form:form id="HS_CODE_MGNT-form" class="s4-form" novalidate="novalidate" onsubmit="HS_CODE_MGNT.retrieve_leftGridData(); return false;">
				<input type="hidden" id="popParam"/>
				<div id="panel-4" class="panel panel-icon">
					<div class="panel-container show">
						<div class="panel-content">
							<div class="row">
								<div class="col-4">
									<div class="mb-3">
										<div class="row">
											<label class="form-label" for="example-input-border">HS코드</label>
										</div>
										<div class="col">
											<input type="text" id="searchHsCode" class="form-control" >
										</div>
									</div>
								</div>
								<div class="col-4">
								</div>
								<div class="col-3">
								</div>
								<div class="col">
									<button type="button"
										onclick="javascript:HS_CODE_MGNT.retrieve_leftGridData();"
										class="btn btn-sm btn-search search-no-more waves-effect waves-themed">Search</button>
								</div>
							</div>
	
						</div>
					</div>
				</div>
			</form:form>
		</div>
		<div class="d-flex col-12 dual-grid-wrap" style="height: calc(100vh - 450px);" >
			<div class="w-30 left-grid-area h-full" >
				<div class="grid-title mb-2"><label>HS 코드 목록</label></div>
				<div id="oAuiGrid_hsCodeMgnt_L" class="w-100 h-95" ></div>
			</div>
			<div class="right-grid-area h-full" >
				<div class="w-100" >
			    	<div class="grid-title mb-1">HS 코드 정보</div>
			    	<div class="detail-card mb-3">
			    		<div class="detail-card-row">
							<div class="detail-card-label">HS 코드</div>
							<div id="selHsCode" class="detail-card-value"></div>
						</div>
						<div class="detail-card-row-2">
							<div class=" detail-card-label">HS 코드명</div>
							<div id="selHsCodeName" class="detail-card-value"></div>
						</div>
						<div class="detail-card-row-2">
							<div class="detail-card-label">HS 설명</div>
							<div id="selHsCodeDesc" class="detail-card-value"></div>
						</div>
			    	</div>
			    	<div class="subheader-title mb-1"><label>FTA 원산지 결정기준</label></div>
			    	<div id="oAuiGrid_hsCodeMgnt_R" class="w-100 h-95"></div>
					
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">

	var HS_CODE_MGNT = new function () {
		this.gridIdL = null;
		this.gridIdR = null;
		this.state = {
			masterRow : {}	
		};
		
	
		this.Initialize_viewObject = function () {
			HS_CODE_MGNT.createAUIGrid();
		    HS_CODE_MGNT.retrieve_leftGridData();
		}
		
		
		this.createAUIGrid = function () {
			
			const leftGridColumnLayout = [
				{
					dataField: "hs_code"
				  , headerText: "HS 코드"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
					dataField: "hs_code_name"
				  , headerText: "HS 코드명"
				  , width: 200
				  , style: "grid-left-text"
				  , filter: {showIcon: true}
				},
			];
			
			const rightGridColumnLayout = [
				{
					dataField: "fta_name"
				  , headerText: "FTA 명"
				  , width: 30
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				  , cellMerge: true 
				},
				{
					dataField: "rule_contents"
				  , headerText: "결정기준 표기"
				  , width: 30
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
					dataField: "rule_description"
				  , headerText: "판정 기준"
				  , width: 100
				  , filter: {showIcon: true}
				},
				{
					dataField: "exclusion_description"
				  , headerText: "예외 기준"
				  , width: 80
				  , filter: {showIcon: true}
				},
			];

			const gridProps = {
				selectionMode : "singleRow",
				usePaging: false,
				enableFilter: true,
				fillColumnSizeMode:true,
				showStateColumn:false,
			};


			HS_CODE_MGNT.gridIdL = KpackageOBJ.auiGrid.create("oAuiGrid_hsCodeMgnt_L", leftGridColumnLayout, gridProps, "");
			HS_CODE_MGNT.gridIdR = KpackageOBJ.auiGrid.create("oAuiGrid_hsCodeMgnt_R", rightGridColumnLayout, gridProps, "");
			
			
			//좌측GRID 이벤트 추가
			
			AUIGrid.bind(HS_CODE_MGNT.gridIdL, "selectionChange", function( event ) {
				HS_CODE_MGNT.state['masterRow'] = event.selectedItems[0].item;
				
				$("#selHsCode").text(HS_CODE_MGNT.state['masterRow']['hs_code']);
				$("#selHsCodeName").text(HS_CODE_MGNT.state['masterRow']['hs_code_name']);
				$("#selHsCodeDesc").text(HS_CODE_MGNT.state['masterRow']['hs_code_desc']);
				HS_CODE_MGNT.retrieve_rightGridData();
			});
			
			
		}

		//좌측그리드 조회
		this.retrieve_leftGridData = function () {
			KpackageOBJ.auiGrid.clearGridData(HS_CODE_MGNT.gridIdR);
			
			
			var params = {
				"searchHsCode": KpackageOBJ.object.getFormValue("HS_CODE_MGNT-form", "searchHsCode")
			}
			
			KpackageOBJ.auiGrid.retrieve(HS_CODE_MGNT.gridIdL, "/origin/ftaInfo/retrieveHsCodeList", params);
		}
		
		//우측그리드 조회
		this.retrieve_rightGridData = function () {
			var params = {
				"selHsCode": HS_CODE_MGNT.state['masterRow']['hs_code']
			}
			
			KpackageOBJ.auiGrid.retrieve(HS_CODE_MGNT.gridIdR, "/origin/ftaInfo/retrieveHsCodePsrList", params);
		}
	}


	$(document).ready(function () {
		HS_CODE_MGNT.Initialize_viewObject();

	});

</script>
</html>