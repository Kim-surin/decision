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
				<h1 class="subheader-title mb-1">FTA 협정 정보 관리</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item">FTA 정보 관리</li>
						<li class="breadcrumb-item active" aria-current="page">FTA 협정 정보 관리</li>
					</ol>
				</nav>
			</div>
		</div>
		<div class="row">
			<form:form id="ftaInfo-form" class="s4-form" novalidate="novalidate" onsubmit="FTA_INFO.retrieve_GridData(); return false;">
				<input type="hidden" id="popParam"/>
				<div id="panel-4" class="panel panel-icon">
					<div class="panel-container show">
						<div class="panel-content">
							<div class="row">
								<div class="col-4">
									<div class="mb-3">
										<div class="row">
											<label class="form-label" for="example-input-border">국가코드/명</label>
										</div>
										<div class="col">
											<input type="text" id="searchCountry" class="form-control" >
										</div>
									</div>
								</div>
								<div class="col-4">
								</div>
								<div class="col-3">
								</div>
								<div class="col">
									<button type="button"
											onclick="javascript:FTA_INFO.retrieve_GridData();"
											class="btn btn-sm btn-search search-no-more waves-effect waves-themed">Search</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form:form>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="d-flex frame-wrap" style="align-items: center;">
					<div class="demo" style="margin-left: auto;">
						<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="FTA_INFO.fnAddRow()">
							행추가
						</button>
						<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="FTA_INFO.fnDelRow()">
							행삭제
						</button>
						<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="FTA_INFO.fnSave()">
							저장
						</button>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div id="oAuiGrid_ftaInfo" class="w-full" style="height:600px; margin:0 auto;"></div>
			</div>
		</div>
	</div>
</body>				
	
<script type="text/javascript">
	var FTA_INFO = new function () {
		this.gridId = null;
		this.state  = { 
			comCdLoadCount : 0,
		};
						
		this.list = {
			CATEGIRIES : ["FS", "IC", "CI", "YN"], //카테고리 리스트
			COMMON_FS_LIST : [],     //FTA 협정상태
			COMMON_IC_LIST : [],     //판매가치산정기준
			COMMON_CI_LIST : [],     //발급구분
			COMMON_YN_LIST : [],  //Y/N
		};
						
		this.Initialize_listObject = function () {
			FTA_INFO.state['comCdLoadCount'] = 0;
			
			FTA_INFO.list['CATEGIRIES'].forEach(function (category) {
				const sParam = { CATEGORY: category };
				KpackageOBJ.ajax.doSubmit("/common/retrieveComCdList", sParam, function (res) {FTA_INFO.callback_retrieveComCdList(res, category);});
			});
		};
						
		this.callback_retrieveComCdList = function (res, category) {
			var data = res.value;
			FTA_INFO.list['COMMON_' + category + '_LIST'] = data;
							
			FTA_INFO.state['comCdLoadCount']++;
		    
		    //비동기 호출시 시점 문제 발생 - 개수 체크
			if (FTA_INFO.state['comCdLoadCount'] === FTA_INFO.list['CATEGIRIES'].length) {
				FTA_INFO.Initialize_viewObject();
			}
		};
					
		this.Initialize_viewObject = function () {
			FTA_INFO.createAUIGrid();
			FTA_INFO.retrieve_GridData();
		}
						
		this.createAUIGrid = function () {
			const columnLayout = [
				{
					dataField: "fta_code"
				  , headerText: "FTA 코드"
				  , width: 120
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
				    dataField: "fta_name"
				  , headerText: "FTA 명"
				  , width: 120
				  , filter: {showIcon: true}
				},
				{
					dataField: "effect_date"
				  , headerText: "발효일자"
				  , width: 120
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				  , dataType: "date"
				  , dateInputFormat: "yyyymmdd" // 실제 데이터의 형식 지정
				  , formatString: "yyyy-mm-dd" // 실제 데이터 형식을 어떻게 표시할지 지정
				  , editRenderer: {
						type: "CalendarRenderer",
						showExtraDays: false, // 지난 달, 다음 달 여분의 날짜(days) 출력 안함
						onlyCalendar: false, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
						defaultFormat: "yyyymmdd", // 달력 선택 시 데이터에 적용되는 날짜 형식
						showPlaceholder: true, // defaultFormat 설정된 값으로 플래스홀더 표시
						validator: function (oldValue, newValue, item) { // 에디팅 유효성 검사
							let m, d;
							let isValid = true;
							m = newValue.substring(4, 6);
							d = newValue.substring(6, 8);
							
							if (parseInt(m) > 12 || parseInt(d) > 31) { // 월은 12월, 일은 31일을 넘지 않게.
								isValid = false;
							} else {
								isValid = true;
							}
							// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
							return { "validate": isValid, "message": "유효한 날짜 형식으로 입력해주세요." };
						}
					}
				},
				{
					dataField: "fta_status"
				  , headerText: "협정상태"
				  , width: 120
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				  , editRenderer : { // 편집 모드 진입 시 드랍다운리스트 출력하고자 할 때
			            type : "DropDownListRenderer",
				  		keyField : 'code',
				  		valueField : 'code_name',
				  		showEditorBtnOver : true,
				  		listFunction : function (rowIndex, columnIndex, item, dataField){
				  			
				  			return FTA_INFO.list['COMMON_FS_LIST'];
				  		}
			      	},
				  	labelFunction : function(rowIndex, columnIndex, value){
				  		var resStr = "";
				  		var list = FTA_INFO.list['COMMON_FS_LIST'];
				  		
				  		for(i =0; i < list.length; i++){
				  			if(list[i]['code'] === value){
				  				resStr = list[i]['code_name'];
				  				break;
				  			}	
				  		}
				  		return resStr == '' ? value : resStr;
				  	}
				},
				{
					dataField: "fta_apply_cnt"
				  , headerText: "협정국수"
				  , width: 120
				  , style: "grid-center-text grid-link-text"
				  , filter: {showIcon: true}
				  , editable :false
				},
				{
					dataField: "co_issue_flag"
				  , headerText: "발급구분"
				  , width: 120
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				  , editRenderer : { // 편집 모드 진입 시 드랍다운리스트 출력하고자 할 때
			            type : "DropDownListRenderer",
				  		keyField : 'code',
				  		valueField : 'code_name',
				  		showEditorBtnOver : true,
				  		listFunction : function (rowIndex, columnIndex, item, dataField){
				  			
				  			return FTA_INFO.list['COMMON_CI_LIST'];
				  		}
			      	},
				  	labelFunction : function(rowIndex, columnIndex, value){
				  		var resStr = "";
				  		var list = FTA_INFO.list['COMMON_CI_LIST'];
				  		
				  		for(i =0; i < list.length; i++){
				  			if(list[i]['code'] === value){
				  				resStr = list[i]['code_name'];
				  				break;
				  			}	
				  		}
				  		return resStr == '' ? value : resStr;
				  	}
				  
				},
				{
					dataField: "de_minimis_rate"
				  , headerText: "미소기준비율"
				  , width: 120
				  , style: "grid-right-text"
				  , filter: {showIcon: true}
				  , editRenderer: {
						type: "InputEditRenderer",
						onlyNumeric: true, // 0~9만 입력가능
						textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
						autoThousandSeparator: true // 천단위 구분자 삽입 여부
					}
				},
				{
					dataField: "rvc_rate"
				  , headerText: "부가가치"
				  , width: 120
				  , style: "grid-right-text"
				  , filter: {showIcon: true}
				  , editRenderer: {
						type: "InputEditRenderer",
						onlyNumeric: true, // 0~9만 입력가능
						textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
						autoThousandSeparator: true // 천단위 구분자 삽입 여부
					}
				},
				{
					dataField: "delete_yn"
				  , headerText: "사용여부"
				  , width: 120
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				  , editRenderer : { // 편집 모드 진입 시 드랍다운리스트 출력하고자 할 때
			            type : "DropDownListRenderer",
				  		keyField : 'code',
				  		valueField : 'code_name',
				  		showEditorBtnOver : true,
				  		listFunction : function (rowIndex, columnIndex, item, dataField){
				  			
				  			return FTA_INFO.list['COMMON_YN_LIST'];
				  		}
			      	},
				  	labelFunction : function(rowIndex, columnIndex, value){
				  		var resStr = "";
				  		var list = FTA_INFO.list['COMMON_YN_LIST'];
				  		
				  		for(i =0; i < list.length; i++){
				  			if(list[i]['code'] === value){
				  				resStr = list[i]['code_name'];
				  				break;
				  			}	
				  		}
				  		return resStr == '' ? value : resStr;
				  	}
				},
				{
					dataField: "inkoterms_type"
				  , headerText: "판매가치산정기준"
				  , width: 120
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				  , editRenderer : { // 편집 모드 진입 시 드랍다운리스트 출력하고자 할 때
			            type : "DropDownListRenderer",
				  		keyField : 'code',
				  		valueField : 'code_name',
				  		showEditorBtnOver : true,
				  		listFunction : function (rowIndex, columnIndex, item, dataField){
				  			
				  			return FTA_INFO.list['COMMON_IC_LIST'];
				  		}
			      	},
				  	labelFunction : function(rowIndex, columnIndex, value){
				  		var resStr = "";
				  		var list = FTA_INFO.list['COMMON_IC_LIST'];
				  		
				  		for(i =0; i < list.length; i++){
				  			if(list[i]['code'] === value){
				  				resStr = list[i]['code_name'];
				  				break;
				  			}	
				  		}
				  		return resStr == '' ? value : resStr;
				  	}
				},
				{
					dataField: "cover_yn"
				  , headerText: "포괄발행여부"
				  , width: 120
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				  , editRenderer : { // 편집 모드 진입 시 드랍다운리스트 출력하고자 할 때
			            type : "DropDownListRenderer",
				  		keyField : 'code',
				  		valueField : 'code_name',
				  		showEditorBtnOver : true,
				  		listFunction : function (rowIndex, columnIndex, item, dataField){
				  			
				  			return FTA_INFO.list['COMMON_YN_LIST'];
				  		}
			      	},
				  	labelFunction : function(rowIndex, columnIndex, value){
				  		var resStr = "";
				  		var list = FTA_INFO.list['COMMON_YN_LIST'];
				  		
				  		for(i =0; i < list.length; i++){
				  			if(list[i]['code'] === value){
				  				resStr = list[i]['code_name'];
				  				break;
				  			}	
				  		}
				  		return resStr == '' ? value : resStr;
				  	}
				}							
			];

			const gridProps = {
				usePaging: true,
				pageRowCount: 50,
				showPageRowSelect: true,
				enableFilter: true,
				editable:true,
				fillColumnSizeMode:true,
				showStateColumn:true
			};


			FTA_INFO.gridId = KpackageOBJ.auiGrid.create("oAuiGrid_ftaInfo", columnLayout, gridProps, "check");
			
			//GRID 수정전 이벤트
			AUIGrid.bind(FTA_INFO.gridId, "cellEditBegin", function(event) {
				if(event.dataField === "fta_code"){
					if(!KpackageOBJ.auiGrid.isAddedByRowIndex(FTA_INFO.gridId,event.rowIndex)){
						return false;
					}
				}
			});
							
			//그리드 클릭 이벤트 
			AUIGrid.bind(FTA_INFO.gridId, "cellClick", function(event) {
				if(event.dataField === "fta_apply_cnt"){
					KpackageOBJ.object.setFormValue("ftaInfo-form", "popParam", JSON.stringify(event.item));
					KpackageOBJ.dialog.open('ftaNationPopup','협정별 국가지정 팝업','/origin/ftaInfo/ftaNation',1000,700);
				}
			});
		}

		//조회
		this.retrieve_GridData = function () {
			var params = {
				"searchCountry": KpackageOBJ.object.getFormValue("ftaInfo-form", "searchCountry")
			}
							
			KpackageOBJ.auiGrid.retrieve(FTA_INFO.gridId, "/origin/ftaInfo/retrieveFtaInfoList", params);
		}
		
		// 행추가
		this.fnAddRow = function () {
			const item = {"delete_yn" : "N"};
			KpackageOBJ.auiGrid.addRow(FTA_INFO.gridId, item);
		}
						
		// 행삭제
		this.fnDelRow = function () {
			const data = KpackageOBJ.auiGrid.getCheckedRowItemsAll(FTA_INFO.gridId);
			
			if(data.length == 0){
				KpackageOBJ.object.alert("데이터가 선택되지 않았습니다.");
				return false;
			}
							
			KpackageOBJ.auiGrid.removeCheckedRows(FTA_INFO.gridId);
		}
						

		//저장
		this.fnSave = function () {
			const data = KpackageOBJ.auiGrid.getGridCudData(FTA_INFO.gridId);
			const isValid = KpackageOBJ.auiGrid.validateGridData(FTA_INFO.gridId, ["fta_code", "fta_name", "effect_date","fta_status","co_issue_flag","de_minimis_rate","rvc_rate","delete_yn","inkoterms_type","cover_yn"], "해당 값은 필수 입력값입니다.")
							
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
				};
				KpackageOBJ.ajax.doSubmit("/origin/ftaInfo/saveFtaInfoList", params, FTA_INFO.fnSaveCallBack);
			}

		}

		//저장 콜백
		this.fnSaveCallBack = function(res) {
			if(res.success){
				KpackageOBJ.object.alert("저장되었습니다.");
				FTA_INFO.retrieve_GridData();
			}else{
				KpackageOBJ.object.alert(res.message);
			}
		}
	}

	$(document).ready(function () {
		FTA_INFO.Initialize_listObject();
	});

</script>
</html>