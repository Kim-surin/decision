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
				<h1 class="subheader-title mb-1">국가별 HS CODE(양허표)</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item">FTA 정보 관리</li>
						<li class="breadcrumb-item active" aria-current="page">국가별 HS CODE(양허표)</li>
					</ol>
				</nav>
			</div>
		</div>
		<div class="row">
			<form:form id="HSCODE_BY_NATION-form" class="s4-form" novalidate="novalidate" onsubmit="HSCODE_BY_NATION.retrieve_leftGridData(); return false;">
				<input type="hidden" id="popParam"/>
				<div id="panel-4" class="panel panel-icon">
					<div class="panel-container show">
						<div class="panel-content">
							<div class="row">
								<div class="col-3">
									<div class="mb-3">
										<div class="row">
											<label class="form-label" for="example-input-border">자재코드</label>
										</div>
										<div class="col">
											<input type="text" id="searchItemCode" class="form-control" >
										</div>
									</div>
								</div>
								<div class="col-3">
									<div class="mb-3">
										<div class="row">
											<label class="form-label" for="example-input-border">HS코드</label>
										</div>
										<div class="col">
											<input type="text" id="searchHsCode" class="form-control" >
										</div>
									</div>
								</div>
								<div class="col-5">
								</div>
								<div class="col">
									<button type="button"
										onclick="javascript:HSCODE_BY_NATION.retrieve_leftGridData();"
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
				<div class="grid-title mb-2"><label>국가 목록</label></div>
				<div id="oAuiGrid_hscodeByNation_L" class="w-100 h-95" ></div>
			</div>
			<div class="right-grid-area h-full" >
				<div class="w-100 h-full" >
				    <div class="d-flex subheader-title mb-1">
				    	<label>국가별 HS코드</label>
				    	<span style="margin-left:auto;">
					    	<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="HSCODE_BY_NATION.fnGridRTAddRow()">
								행추가
							</button>
							<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="HSCODE_BY_NATION.fnGridRTDelRow()">
								행삭제
							</button>
							<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="HSCODE_BY_NATION.fnGridRTSave()">
								저장
							</button>
						</span>
				    </div>
			    	<div id="oAuiGrid_hscodeByNation_RT" class="w-100 h-40"></div>
			    	<div class="d-flex subheader-title mb-1">
			    		<label>양허표 리스트</label>
			    		<span style="margin-left:auto;">
					    	<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="HSCODE_BY_NATION.fnGridRBAddRow()">
								행추가
							</button>
							<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="HSCODE_BY_NATION.fnGridRBDelRow()">
								행삭제
							</button>
							<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="HSCODE_BY_NATION.fnGridRBSave()">
								저장
							</button>
						</span>
			    	</div>
			    	<div id="oAuiGrid_hscodeByNation_RB" class="w-100 h-40"></div>
					
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">

	var HSCODE_BY_NATION = new function () {
		this.gridIdL = null;
		this.gridIdRT = null;
		this.gridIdRB = null;
		
		this.state = {
			masterRow : {}	
		};
		
		//View Object Init
		this.Initialize_viewObject = function () {
			HSCODE_BY_NATION.createAUIGrid();
		    HSCODE_BY_NATION.retrieve_leftGridData();
		}
		
		//Grid Init
		this.createAUIGrid = function () {
			
			const leftGridColumnLayout = [
				{
					dataField: "nation_code"
				  , headerText: "국가코드"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
					dataField: "nation_name"
				  , headerText: "국가명"
				  , width: 150
				  , style: "grid-left-text"
				  , filter: {showIcon: true}
				},
				{
					dataField: "fta_hs_cnt"
				  , headerText: "국가별 HS코드 수"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
					dataField: "rcep_cnt"
				  , headerText: "양허표 수"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
			];
			
			const rightTopGridColumnLayout = [
				{
					dataField: "item_code"
				  , headerText: "자재코드"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				  , renderer: {
					  type: 'IconRenderer',
	                  iconWidth: 16, // icon 가로 사이즈, 지정하지 않으면 24로 기본값 적용됨
	                  iconHeight: 16,
	                  iconPosition: 'aisleRight', // 아이콘 위치
	                  iconFunction: function (rowIndex, columnIndex, value, item) {
	                	  if (!KpackageOBJ.auiGrid.isAddedByRowIndex(HSCODE_BY_NATION.gridIdRT, rowIndex)) {
	                		  return null;
	                      } else {
	                    	  return "/rcs/auigrid/images/icon-search.png";
	                      }
	                  },
	                  onClick: (e) => {
	                	  HSCODE_BY_NATION.fnOpenCompop("top_item_code");
	                  },
	            	},
				},
				{
					dataField: "item_name"
				  , headerText: "자재명"
				  , width: 180
				  , style: "grid-left-text"
				  , filter: {showIcon: true}
				  , editable: false
				},
				{
					dataField: "hs_code"
				  , headerText: "기존 HS코드"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				  , editable:false
				},
				{
					dataField: "fta_hs_code"
				  , headerText: "국가별 HS코드"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				  , editRenderer: {
						type: "InputEditRenderer",
					 	onlyNumeric: true, // 0~9만 입력가능
						textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
						autoThousandSeparator: false, // 천단위 구분자 삽입 여부
						maxlength : 6
					}
				  , renderer: {
					  type: 'IconRenderer',
	                  iconWidth: 16, // icon 가로 사이즈, 지정하지 않으면 24로 기본값 적용됨
	                  iconHeight: 16,
	                  iconPosition: 'aisleRight', // 아이콘 위치
	                  iconFunction: function (rowIndex, columnIndex, value, item) {
	                	  if (!KpackageOBJ.auiGrid.isAddedByRowIndex(HSCODE_BY_NATION.gridIdRT, rowIndex)) {
	                		  return null;
	                      } else {
	                    	  return "/rcs/auigrid/images/icon-search.png";
	                      }
	                  },
	                  onClick: (e) => {
	                	  HSCODE_BY_NATION.fnOpenCompop("top_hs_code");
	                  },
	            	},
				},
				{
					dataField: "remarks"
				  , headerText: "비고"
				  , width: 80
				  , style: "grid-left-text"
				  , filter: {showIcon: true}
				},
			];
			
			const rightBottomGridColumnLayout = [
				{
					dataField: "fta_code"
				  , headerText: "FTA 코드"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				  , renderer: {
					  type: 'IconRenderer',
	                  iconWidth: 16, // icon 가로 사이즈, 지정하지 않으면 24로 기본값 적용됨
	                  iconHeight: 16,
	                  iconPosition: 'aisleRight', // 아이콘 위치
	                  iconFunction: function (rowIndex, columnIndex, value, item) {
	                	  if (!KpackageOBJ.auiGrid.isAddedByRowIndex(HSCODE_BY_NATION.gridIdRB, rowIndex)) {
	                		  return null;
	                      } else {
	                    	  return "/rcs/auigrid/images/icon-search.png";
	                      }
	                  },
	                  onClick: (e) => {
	                	  HSCODE_BY_NATION.fnOpenCompop("bottom_fta_code");
	                  },
	            	},
				},
				{
					dataField: "fta_name"
				  , headerText: "FTA 명"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				  , editable : false
				},
				{
					dataField: "hs_code"
				  , headerText: "HS 코드"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				  , editRenderer: {
						type: "InputEditRenderer",
					 	onlyNumeric: true, // 0~9만 입력가능
						autoThousandSeparator: false, // 천단위 구분자 삽입 여부
						maxlength : 6
					}
				  , renderer: {
					  type: 'IconRenderer',
	                  iconWidth: 16, // icon 가로 사이즈, 지정하지 않으면 24로 기본값 적용됨
	                  iconHeight: 16,
	                  iconPosition: 'aisleRight', // 아이콘 위치
	                  iconFunction: function (rowIndex, columnIndex, value, item) {
	                	  if (!KpackageOBJ.auiGrid.isAddedByRowIndex(HSCODE_BY_NATION.gridIdRB, rowIndex)) {
	                		  return null;
	                      } else {
	                    	  return "/rcs/auigrid/images/icon-search.png";
	                      }
	                  },
	                  onClick: (e) => {
	                	  HSCODE_BY_NATION.fnOpenCompop("bottom_hs_code");
	                  },
	            	},
				},
				{
					dataField: "apply_date"
				  , headerText: "적용일자"
				  , width: 100
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
						
						return { "validate": isValid, "message": "유효한 날짜 형식으로 입력해주세요." };
					 }
					}
				},
				{
					dataField: "end_date"
				  , headerText: "적용 정지일자"
				  , width: 100
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
						
						return { "validate": isValid, "message": "유효한 날짜 형식으로 입력해주세요." };
					  }
					}
				},
			];

			const gridPropsL = {
				selectionMode : "singleRow",
				usePaging: false,
				enableFilter: true,
				fillColumnSizeMode:true,
				showStateColumn:false,
			};
			

			const gridPropsR = {
				usePaging: false,
				enableFilter: true,
				fillColumnSizeMode:true,
				showStateColumn:false,
				editable: true,
			};


			HSCODE_BY_NATION.gridIdL = KpackageOBJ.auiGrid.create("oAuiGrid_hscodeByNation_L", leftGridColumnLayout, gridPropsL, "");
			HSCODE_BY_NATION.gridIdRT = KpackageOBJ.auiGrid.create("oAuiGrid_hscodeByNation_RT", rightTopGridColumnLayout, gridPropsR, "check");
			HSCODE_BY_NATION.gridIdRB = KpackageOBJ.auiGrid.create("oAuiGrid_hscodeByNation_RB", rightBottomGridColumnLayout, gridPropsR, "check");
			
			
			//좌측GRID 이벤트 추가
			AUIGrid.bind(HSCODE_BY_NATION.gridIdL, "selectionChange", function( event ) {
				HSCODE_BY_NATION.state['masterRow'] = event.selectedItems[0].item;
				HSCODE_BY_NATION.retrieve_rightTopGridData();
				HSCODE_BY_NATION.retrieve_rightBottomGridData();
			});
			
			//우측 TOP GRID 이벤트 추가 
			AUIGrid.bind(HSCODE_BY_NATION.gridIdRT, "cellEditBegin", function( event ) {
				const disableCol = ["item_code", "fta_hs_code"]
				
				if (disableCol.includes(event.dataField)) {
				 	if (!KpackageOBJ.auiGrid.isAddedByRowIndex(HSCODE_BY_NATION.gridIdRT, event.rowIndex)) {
						return false;						 
					}
			    }
				
				if(event.dataField === "item_code"){
					KpackageOBJ.auiGrid.setCellValue(HSCODE_BY_NATION.gridIdRT, event.rowIndex, "item_name", "");
					KpackageOBJ.auiGrid.setCellValue(HSCODE_BY_NATION.gridIdRT, event.rowIndex, "hs_code", "");
				}
			});
			
			AUIGrid.bind(HSCODE_BY_NATION.gridIdRT, "cellEditEnd", function (event) {
				if(!oUtil.isNull(event.value)){
					if(event.dataField === "item_code"){
						 HSCODE_BY_NATION.fnOpenCompop("top_item_code");
				    }else if(event.dataField === "fta_hs_code"){
				    	 HSCODE_BY_NATION.fnOpenCompop("top_hs_code");
				    }
				}

			});

			//우측 BOTTOM GRID 이벤트 추가 
			AUIGrid.bind(HSCODE_BY_NATION.gridIdRB, "cellEditBegin", function( event ) {
				const disableCol = ["fta_code", "hs_code"]
				
				if (disableCol.includes(event.dataField)) {
				 	if (!KpackageOBJ.auiGrid.isAddedByRowIndex(HSCODE_BY_NATION.gridIdRB, event.rowIndex)) {
						return false;						 
					}
			    }
			});
			

			AUIGrid.bind(HSCODE_BY_NATION.gridIdRB, "cellEditEnd", function (event) {
				if(!oUtil.isNull(event.value)){
					if(event.dataField === "bottom_fta_code"){
						 HSCODE_BY_NATION.fnOpenCompop("bottom_fta_code");
				    }else if(event.dataField === "bottom_hs_code"){
				    	 HSCODE_BY_NATION.fnOpenCompop("bottom_hs_code");
				    }
				}

			});
			
		}

		//좌측그리드 조회
		this.retrieve_leftGridData = function () {
			KpackageOBJ.auiGrid.clearGridData(HSCODE_BY_NATION.gridIdRT);
			KpackageOBJ.auiGrid.clearGridData(HSCODE_BY_NATION.gridIdRB);
			
			
			var params = {
				  "searchItemCode": KpackageOBJ.object.getFormValue("HSCODE_BY_NATION-form", "searchItemCode")
				, "searchHsCode": KpackageOBJ.object.getFormValue("HSCODE_BY_NATION-form", "searchHsCode")
			}
			
			KpackageOBJ.auiGrid.retrieve(HSCODE_BY_NATION.gridIdL, "/origin/ftaInfo/retrieveNationIncludeRcepCntList", params);
		}
		
		//우측 상단그리드 조회
		this.retrieve_rightTopGridData = function () {
			var params = {
				    "nationCode" : HSCODE_BY_NATION.state['masterRow']['nation_code']
				  , "searchItemCode": KpackageOBJ.object.getFormValue("HSCODE_BY_NATION-form", "searchItemCode")
				  , "searchHsCode": KpackageOBJ.object.getFormValue("HSCODE_BY_NATION-form", "searchHsCode")
			}
			
			KpackageOBJ.auiGrid.retrieve(HSCODE_BY_NATION.gridIdRT, "/origin/ftaInfo/retrieveHsCodeByNationList", params);
		}
		

		//우측 하단그리드 조회
		this.retrieve_rightBottomGridData = function () {
			var params = {
				    "nationCode" : HSCODE_BY_NATION.state['masterRow']['nation_code']
				  , "searchItemCode": KpackageOBJ.object.getFormValue("HSCODE_BY_NATION-form", "searchItemCode")
				  , "searchHsCode": KpackageOBJ.object.getFormValue("HSCODE_BY_NATION-form", "searchHsCode")
			}
			
			KpackageOBJ.auiGrid.retrieve(HSCODE_BY_NATION.gridIdRB, "/origin/ftaInfo/retrieveHsCodeRcepList", params);
		}
		
		
		
		//곧통팝업 오픈
		this.fnOpenCompop = function(popGubn) {
			let selRowIndex = 0;
			let popParam = {};
			let callbackFunc ="";	
			let popUrl = "";
			let popTitle = "";
			
			if(popGubn === "top_item_code"){
				selRowIndex = KpackageOBJ.auiGrid.getSelectedIndex(HSCODE_BY_NATION.gridIdRT)[0];
				popUrl = "/origin/commonPop/comItem";
				popTitle = "자재코드 조회";
				popParam = {
		    			"searchText" : KpackageOBJ.auiGrid.getCellValue(HSCODE_BY_NATION.gridIdRT, selRowIndex, "item_code")
		    	}
				callbackFunc =  "HSCODE_BY_NATION.setComItemPopupTopGridData";
		    } else if(popGubn === "top_hs_code"){
		    	selRowIndex = KpackageOBJ.auiGrid.getSelectedIndex(HSCODE_BY_NATION.gridIdRT)[0];
				popUrl = "/origin/commonPop/comHsCode";
				popTitle = "HS코드 조회";
				popParam = {
		    			"searchText" : KpackageOBJ.auiGrid.getCellValue(HSCODE_BY_NATION.gridIdRT, selRowIndex, "fta_hs_code")
		    	}
				callbackFunc =  "HSCODE_BY_NATION.setComHsCodePopupTopGridData";
		    } else if(popGubn === "bottom_hs_code"){
		    	selRowIndex = KpackageOBJ.auiGrid.getSelectedIndex(HSCODE_BY_NATION.gridIdRB)[0];
		    	popUrl = "/origin/commonPop/comHsCode";
				popTitle = "HS코드 조회";
				popParam = {
		    			"searchText" : KpackageOBJ.auiGrid.getCellValue(HSCODE_BY_NATION.gridIdRB, selRowIndex, "hs_code")
		    	}
				callbackFunc =  "HSCODE_BY_NATION.setComHsCodePopupBottomGridData";
		    } else if(popGubn === "bottom_fta_code"){
		    	selRowIndex = KpackageOBJ.auiGrid.getSelectedIndex(HSCODE_BY_NATION.gridIdRB)[0];
		    	popUrl = "/origin/commonPop/comFtaCode";
				popTitle = "FTA코드 조회";
				popParam = {
		    			"searchText" : KpackageOBJ.auiGrid.getCellValue(HSCODE_BY_NATION.gridIdRB, selRowIndex, "fta_code"),
		    			"searchNation" : KpackageOBJ.auiGrid.getCellValue(HSCODE_BY_NATION.gridIdRB, selRowIndex, "nation_code"),
		    			"searchNationView" : true
		    	}
				callbackFunc =  "HSCODE_BY_NATION.setComFtaCodePopupBottomGridData";
		    }
			
			
			window.commonPopupParam = {
	    			rowIndex : selRowIndex,
	    		    callback: callbackFunc,
	    		    data: popParam
	    		};
	    	
	    	KpackageOBJ.dialog.open('commonPop',popTitle,popUrl,1000,700);
		};
		
		//상단그리드 - 국가코드 팝업 세팅
	    this.setComItemPopupTopGridData = function(selectedData) {
			KpackageOBJ.auiGrid.setCellValue(HSCODE_BY_NATION.gridIdRT, selectedData["rowIndex"], "item_code", selectedData["code"]);
	    	KpackageOBJ.auiGrid.setCellValue(HSCODE_BY_NATION.gridIdRT, selectedData["rowIndex"], "item_name", selectedData["code_name"]);
	    	KpackageOBJ.auiGrid.setCellValue(HSCODE_BY_NATION.gridIdRT, selectedData["rowIndex"], "hs_code", selectedData["hs_code"]);
	    };
	    
	    //상단그리드 - 국가별 HS코드 세팅
	    this.setComHsCodePopupTopGridData = function(selectedData) {
			KpackageOBJ.auiGrid.setCellValue(HSCODE_BY_NATION.gridIdRT, selectedData["rowIndex"], "fta_hs_code", selectedData["code"]);
	    };
	    
	    //하단그리드 - HS코드 세팅
	    this.setComHsCodePopupBottomGridData = function(selectedData) {
			KpackageOBJ.auiGrid.setCellValue(HSCODE_BY_NATION.gridIdRB, selectedData["rowIndex"], "hs_code", selectedData["code"]);
	    };
	    
	    //하단그리드 - FTA코드 세팅
	    this.setComFtaCodePopupBottomGridData = function(selectedData) {
	    	KpackageOBJ.auiGrid.setCellValue(HSCODE_BY_NATION.gridIdRB, selectedData["rowIndex"], "fta_code", selectedData["code"]);
			KpackageOBJ.auiGrid.setCellValue(HSCODE_BY_NATION.gridIdRB, selectedData["rowIndex"], "fta_name", selectedData["code_name"]);
	    };
	    
	    
	    
	    //상단 행추가
	    this.fnGridRTAddRow = function() {
	    	
			if(oUtil.isNull(HSCODE_BY_NATION.state['masterRow']['nation_code'])){
				KpackageOBJ.object.alert("국가목록을 먼저 선택해주세요.");
				return;
			}
	    	
			const item = {"nation_code" : HSCODE_BY_NATION.state['masterRow']['nation_code']};
			KpackageOBJ.auiGrid.addRow(HSCODE_BY_NATION.gridIdRT, item);
	    };

	    //상단 행삭제
	    this.fnGridRTDelRow = function() {
			const data = KpackageOBJ.auiGrid.getCheckedRowItemsAll(HSCODE_BY_NATION.gridIdRT);
			
			if(data.length == 0){
				KpackageOBJ.object.alert("데이터가 선택되지 않았습니다.");
				return false;
			}
							
			KpackageOBJ.auiGrid.removeCheckedRows(HSCODE_BY_NATION.gridIdRT);
	    };
	    
	    //상단 저장
	    this.fnGridRTSave = function() {
	    	const data = KpackageOBJ.auiGrid.getGridCudData(HSCODE_BY_NATION.gridIdRT);
			const isValid = KpackageOBJ.auiGrid.validateGridData(HSCODE_BY_NATION.gridIdRT, ["item_code", "hs_code","fta_hs_code"], "해당 값은 필수 입력값입니다.")
							
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
				KpackageOBJ.ajax.doSubmit("/origin/ftaInfo/saveHsCodeByNationList", params, HSCODE_BY_NATION.fnGridRTSaveCallBack);
			}
		};
	    
	    //상단 저장 콜백
	    this.fnGridRTSaveCallBack = function(res) {
			if(res.success){
				KpackageOBJ.object.alert("저장되었습니다.");
				HSCODE_BY_NATION.retrieve_leftGridData()
			}else{
				KpackageOBJ.object.alert(res.message);
			}
	    	
	    };
	    
	    //하단 행추가
	    this.fnGridRBAddRow = function() {
	    	if(oUtil.isNull(HSCODE_BY_NATION.state['masterRow']['nation_code'])){
				KpackageOBJ.object.alert("국가목록을 먼저 선택해주세요.");
				return;
			}
	    	
	    	const item = {"nation_code" : HSCODE_BY_NATION.state['masterRow']['nation_code']};
			KpackageOBJ.auiGrid.addRow(HSCODE_BY_NATION.gridIdRB, item);
	    	
	    };
	    
	    //하단 행삭제
	    this.fnGridRBDelRow = function() {
			const data = KpackageOBJ.auiGrid.getCheckedRowItemsAll(HSCODE_BY_NATION.gridIdRB);
			
			if(data.length == 0){
				KpackageOBJ.object.alert("데이터가 선택되지 않았습니다.");
				return false;
			}
							
			KpackageOBJ.auiGrid.removeCheckedRows(HSCODE_BY_NATION.gridIdRB);
	    };
	    
	    //하단 저장
	    this.fnGridRBSave = function() {
			const data = KpackageOBJ.auiGrid.getGridCudData(HSCODE_BY_NATION.gridIdRB);
			const isValid = KpackageOBJ.auiGrid.validateGridData(HSCODE_BY_NATION.gridIdRB, ["hs_code", "apply_date", "end_date"], "해당 값은 필수 입력값입니다.")
							
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
				KpackageOBJ.ajax.doSubmit("/origin/ftaInfo/saveHsCodeRcepList", params, HSCODE_BY_NATION.fnGridRBSaveCallBack);
			}

	    };
	    
	    //하단 저장 콜백
	    this.fnGridRBSaveCallBack = function(res) {
			if(res.success){
				KpackageOBJ.object.alert("저장되었습니다.");
				HSCODE_BY_NATION.retrieve_leftGridData()
			}else{
				KpackageOBJ.object.alert(res.message);
			}
	    	
	    };
		
	}


	$(document).ready(function () {
		HSCODE_BY_NATION.Initialize_viewObject();

	});

</script>
</html>