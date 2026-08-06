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
				<h1 class="subheader-title mb-1">FTA별 INCOTERMS</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item">FTA 정보 관리</li>
						<li class="breadcrumb-item active" aria-current="page">FTA별 INCOTERMS</li>
					</ol>
				</nav>
			</div>
		</div>
		<div class="row">
			<form:form id="ftaIncoterms-form" class="s4-form" novalidate="novalidate" onsubmit="FTA_INCOTERMS.retrieve_GridData(); return false;">
				<input type="hidden" id="popParam"/>
				<div id="panel-4" class="panel panel-icon">
					<div class="panel-container show">
						<div class="panel-content">
							<div class="row">
								<div class="col-2">
									<div class="mb-3">
										<div class="row">
											<label class="form-label" for="example-input-border">기준연도</label>
										</div>
										<div class="col">
											<div class="year-picker-wrap">
											    <input type="text" id="searchStdYyyy" class="year-picker-input" readonly>
											</div>
										</div>
									</div>
								</div>
								<div class="col-6">
								</div>
								<div class="col-3">
								</div>
								<div class="col">
									<button type="button"
											onclick="javascript:FTA_INCOTERMS.retrieve_GridData();"
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
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div id="oAuiGrid_ftaIncoterms" class="w-full" style="height:600px; margin:0 auto;"></div>
			</div>
		</div>
	</div>
</body>				
	
<script type="text/javascript">
	var FTA_INCOTERMS = new function () {
		this.gridId = null;
		this.state  = { 
			comCdLoadCount : 0,
		};
						
		this.list = {
			CATEGIRIES : ["EF"], //카테고리 리스트
			COMMON_EF_LIST : [],     //내수/수출
		};
						
		// List Data Init
		this.Initialize_listObject = function () {
			FTA_INCOTERMS.state['comCdLoadCount'] = 0;
			
			FTA_INCOTERMS.list['CATEGIRIES'].forEach(function (category) {
				const sParam = { CATEGORY: category };
				KpackageOBJ.ajax.doSubmit("/common/retrieveComCdList", sParam, function (res) {FTA_INCOTERMS.Initialize_listObjectCallback(res, category);});
			});
		};
		
		// List Data Init Callback				
		this.Initialize_listObjectCallback = function (res, category) {
			var data = res.value;
			FTA_INCOTERMS.list['COMMON_' + category + '_LIST'] = data;
							
			FTA_INCOTERMS.state['comCdLoadCount']++;
		    
		    //비동기 호출시 시점 문제 발생 - 개수 체크
			if (FTA_INCOTERMS.state['comCdLoadCount'] === FTA_INCOTERMS.list['CATEGIRIES'].length) {
				FTA_INCOTERMS.Initialize_viewObject();
			}
		};
					
		//View Object CallBack
		this.Initialize_viewObject = function () {
			//연도 달력 CREATE
			KpackageOBJ.yearPicker.create( "searchStdYyyy", 1900 , "",  new Date().getFullYear());

			FTA_INCOTERMS.createAUIGrid();
			FTA_INCOTERMS.retrieve_GridData();
		}
		
		//GRID INIT
		this.createAUIGrid = function () {
			const columnLayout = [
				{
					dataField: "std_yyyy"
				  , dataType: "string"
				  , headerText: "기준연도"
				  , width: 120
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				  , editRenderer: {
				        type: "InputEditRenderer",
				        regExp: "^[0-9]*$",
				        maxlength: 4
				    }
				  , renderer: {
						type: "IconRenderer",
						iconWidth: 16, // icon 사이즈, 지정하지 않으면 rowHeight에 맞게 기본값 적용됨
						iconHeight: 16,
						altText: "달력 열기",
						iconPosition: "aisleRight",
						iconFunction: function (rowIndex, columnIndex, value, item) {
					      if (!KpackageOBJ.auiGrid.isAddedByRowIndex(FTA_INCOTERMS.gridId, rowIndex)) {
		                        return null;
		                    } else {
		                        return "/rcs/auigrid/images/calendar-icon.png";
		                    }
		                },
					},
				},
				{
				    dataField: "division_code"
				  , headerText: "사업장코드"
				  , width: 120
				  , filter: {showIcon: true}
				  , renderer: {
		                type: 'IconRenderer',
		                iconWidth: 16, // icon 가로 사이즈, 지정하지 않으면 24로 기본값 적용됨
		                iconHeight: 16,
		                iconPosition: 'aisleRight', // 아이콘 위치
		                iconFunction: function (rowIndex, columnIndex, value, item) {
		                    if (!KpackageOBJ.auiGrid.isAddedByRowIndex(FTA_INCOTERMS.gridId, rowIndex)) {
		                        return null;
		                    } else {
		                        return "/rcs/auigrid/images/icon-search.png";
		                    }
		                },
		                onClick: (e) => {
		                	FTA_INCOTERMS.fnOpenCompop("division");
		                },
		            },
				},
				{
					dataField: "incoterms_type"
				  , headerText: "내수/수출"
				  , width: 120
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				  , editRenderer : { // 편집 모드 진입 시 드랍다운리스트 출력하고자 할 때
			            type : "DropDownListRenderer",
				  		keyField : 'code',
				  		valueField : 'code_name',
				  		showEditorBtnOver : true,
				  		listFunction : function (rowIndex, columnIndex, item, dataField){
			  				return FTA_INCOTERMS.list['COMMON_EF_LIST'];
			  			}
		      		},
				  	labelFunction : function(rowIndex, columnIndex, value){
				  		var resStr = "";
				  		var list = FTA_INCOTERMS.list['COMMON_EF_LIST'];
				  		
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
					dataField: "nation_code"
				  , headerText: "국가코드"
				  , width: 120
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				  , renderer: {
		                type: 'IconRenderer',
		                iconWidth: 16, // icon 가로 사이즈, 지정하지 않으면 24로 기본값 적용됨
		                iconHeight: 16,
		                iconPosition: 'aisleRight', // 아이콘 위치
		                iconFunction: function (rowIndex, columnIndex, value, item) {
		                    if (!KpackageOBJ.auiGrid.isAddedByRowIndex(FTA_INCOTERMS.gridId, rowIndex)) {
		                        return null;
		                    } else {
		                        return "/rcs/auigrid/images/icon-search.png";
		                    }
		                },
		                onClick: (e) => {
		                	FTA_INCOTERMS.fnOpenCompop("nation");
		                },
		            },
				},
				{
					dataField: "nation_name"
				  , headerText: "국가명"
				  , width: 120
				  , style: "grid-left-text"
				  , filter: {showIcon: true}
				  , editable :false
				},
				{
					dataField: "exw_rate"
			      , dataType: "numeric"
				  , headerText: "EXW"
				  , width: 120
				  , style: "grid-right-text"
				  , filter: {showIcon: true}
				  , formatString: "#,##0.00"
				  , editRenderer: {
						type: "InputEditRenderer",
						textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
						autoThousandSeparator: true, // 천단위 구분자 삽입 여부
						regExp: '^[0-9]+\\.?[0-9]{0,2}?$'
					}			  
				},
				{
					dataField: "fca_rate"
				  , dataType: "numeric"
				  , headerText: "FCA"
				  , width: 120
				  , style: "grid-right-text"
				  , filter: {showIcon: true}
				  , formatString: "#,##0.00"
				  , editRenderer: {
						type: "InputEditRenderer",
						onlyNumeric: true, // 0~9만 입력가능
						textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
						autoThousandSeparator: true // 천단위 구분자 삽입 여부
					}
				  
				},
				{
					dataField: "fas_rate"
				  , dataType: "numeric"
				  , headerText: "FAS"
				  , width: 120
				  , style: "grid-right-text"
				  , filter: {showIcon: true}
				  , formatString: "#,##0.00"				
				  , editRenderer: {
						type: "InputEditRenderer",
						textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
						autoThousandSeparator: true, // 천단위 구분자 삽입 여부
						regExp: '^[0-9]+\\.?[0-9]{0,2}?$'
					}
				  
				},
				{
					dataField: "fob_rate"
				  , dataType: "numeric"
				  , headerText: "FOB"
				  , width: 120
				  , style: "grid-right-text"
				  , filter: {showIcon: true}
				  , formatString: "#,##0.00"
				  , editRenderer: {
						type: "InputEditRenderer",
						textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
						autoThousandSeparator: true, // 천단위 구분자 삽입 여부
						regExp: '^[0-9]+\\.?[0-9]{0,2}?$'
					}
				  
				},
				{
					dataField: "cfr_rate"
				  , dataType: "numeric"
				  , headerText: "CFR"
				  , width: 120
				  , style: "grid-right-text"
				  , filter: {showIcon: true}
				  , formatString: "#,##0.00"
				  , editRenderer: {
						type: "InputEditRenderer",
						textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
						autoThousandSeparator: true, // 천단위 구분자 삽입 여부
						regExp: '^[0-9]+\\.?[0-9]{0,2}?$'
					}
				  
				},
				{
					dataField: "cif_rate"
				  , dataType: "numeric"
				  , headerText: "CIF"
				  , width: 120
				  , style: "grid-right-text"
				  , filter: {showIcon: true}
				  , formatString: "#,##0.00"
				  , editRenderer: {
						type: "InputEditRenderer",
						textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
						autoThousandSeparator: true, // 천단위 구분자 삽입 여부
						regExp: '^[0-9]+\\.?[0-9]{0,2}?$'
					}
				  
				},
				{
					dataField: "cpt_rate"
				  , dataType: "numeric"
				  , headerText: "CPT"
				  , width: 120
				  , style: "grid-right-text"
				  , filter: {showIcon: true}
				  , formatString: "#,##0.00"
				  , editRenderer: {
						type: "InputEditRenderer",
						textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
						autoThousandSeparator: true, // 천단위 구분자 삽입 여부
						regExp: '^[0-9]+\\.?[0-9]{0,2}?$'
					}
				  
				},
				{
					dataField: "cip_rate"
				  , dataType: "numeric"
				  , headerText: "CIP"
				  , width: 120
				  , style: "grid-right-text"
				  , filter: {showIcon: true}
				  , formatString: "#,##0.00"
				  , editRenderer: {
						type: "InputEditRenderer",
						textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
						autoThousandSeparator: true, // 천단위 구분자 삽입 여부
						regExp: '^[0-9]+\\.?[0-9]{0,2}?$'
					}
				  
				},
				{
					dataField: "dap_rate"
			      , dataType: "numeric"
				  , headerText: "DAP"
				  , width: 120
				  , style: "grid-right-text"
				  , filter: {showIcon: true}
				  , formatString: "#,##0.00"
				  , editRenderer: {
						type: "InputEditRenderer",
						textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
						autoThousandSeparator: true, // 천단위 구분자 삽입 여부
						regExp: '^[0-9]+\\.?[0-9]{0,2}?$'
					}
				  
				},
				{
					dataField: "dpu_rate"
				  , dataType: "numeric"
				  , headerText: "DPU"
				  , width: 120
				  , style: "grid-right-text"
				  , filter: {showIcon: true}
				  , formatString: "#,##0.00"
				  , editRenderer: {
						type: "InputEditRenderer",
						textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
						autoThousandSeparator: true, // 천단위 구분자 삽입 여부
						regExp: '^[0-9]+\\.?[0-9]{0,2}?$'
					}
				  
				},
				{
					dataField: "ddp_rate"
				  , dataType: "numeric"
				  , headerText: "DDP"
				  , width: 120
				  , style: "grid-right-text"
				  , filter: {showIcon: true}
				  , formatString: "#,##0.00"
				  , editRenderer: {
						type: "InputEditRenderer",
						textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
						autoThousandSeparator: true, // 천단위 구분자 삽입 여부
						regExp: '^[0-9]+\\.?[0-9]{0,2}?$'
					}
				  
				},
											
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


			FTA_INCOTERMS.gridId = KpackageOBJ.auiGrid.create("oAuiGrid_ftaIncoterms", columnLayout, gridProps, "check");
			
			//Year Picker가 정상적으로 뜨지 않아서 CUSTOM으로 생성
			KpackageOBJ.auiGrid.bind(FTA_INCOTERMS.gridId, "cellClick", function (event) {
				if (event.dataField === "std_yyyy") {
					 if (!KpackageOBJ.auiGrid.isAddedByRowIndex(FTA_INCOTERMS.gridId, event.rowIndex)) {
						return false;						 
					 }
					
					 var $cell = $(event.orgEvent.target).closest(".aui-grid-renderer-base");
					
					 KpackageOBJ.yearPicker.open(
							 $cell[0],
					        "2000",
					        "",
					        event.value,
					        function (year) {
					    		KpackageOBJ.auiGrid.setCellValue(
					    			FTA_INCOTERMS.gridId,
					                event.rowIndex,
					                event.dataField,
					                year
					            );
					        }
					    );
			    }
			});
			
			// GRID 이벤트 바인드
			KpackageOBJ.auiGrid.bind(FTA_INCOTERMS.gridId, "cellEditBegin", function (event) {
				const disableCol = ["std_yyyy", "division_code", "incoterms_type"]
				
				if (disableCol.includes(event.dataField)) {
				 	if (!KpackageOBJ.auiGrid.isAddedByRowIndex(FTA_INCOTERMS.gridId, event.rowIndex)) {
						return false;						 
					}
			    }
				
				if(event.dataField === "nation_code"){
					KpackageOBJ.auiGrid.setCellValue(FTA_INCOTERMS.gridId, event.rowIndex, "nation_name", "");
				}
			});
			
			KpackageOBJ.auiGrid.bind(FTA_INCOTERMS.gridId, "cellEditEnd", function (event) {
				if (event.dataField === "std_yyyy") {
					KpackageOBJ.yearPicker.close();
			    }
				
				if(!oUtil.isNull(event.value)){
					if(event.dataField === "division_code"){
				    	FTA_INCOTERMS.fnOpenCompop("division");
				    }else if(event.dataField === "nation_code"){
				    	FTA_INCOTERMS.fnOpenCompop("nation");
				    }
				}
			});
			
			
		}

		//조회
		this.retrieve_GridData = function () {
			var params = {
				"searchStdYyyy": KpackageOBJ.object.getFormValue("ftaIncoterms-form", "searchStdYyyy")
			}
							
			KpackageOBJ.auiGrid.retrieve(FTA_INCOTERMS.gridId, "/origin/ftaInfo/ftaIncoterms/retrieveFtaIncotermsList", params);
		}
		
		// 행추가
		this.fnAddRow = function () {
			const item = {};
			KpackageOBJ.auiGrid.addRow(FTA_INCOTERMS.gridId, item);
		}
						
		// 행삭제
		this.fnDelRow = function () {
			const data = KpackageOBJ.auiGrid.getCheckedRowItemsAll(FTA_INCOTERMS.gridId);
			
			if(data.length == 0){
				KpackageOBJ.object.alert("데이터가 선택되지 않았습니다.");
				return false;
			}
							
			KpackageOBJ.auiGrid.removeCheckedRows(FTA_INCOTERMS.gridId);
		}
						

		//저장
		this.fnSave = function () {
			const data = KpackageOBJ.auiGrid.getGridCudData(FTA_INCOTERMS.gridId);
			const isValid = KpackageOBJ.auiGrid.validateGridData(FTA_INCOTERMS.gridId, ["std_yyyy", "division_code", "incoterms_type","nation_code"], "해당 값은 필수 입력값입니다.")
							
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
				KpackageOBJ.ajax.doSubmit("/origin/ftaInfo/ftaIncoterms/saveFtaIncotermsList", params, FTA_INCOTERMS.fnSaveCallBack);
			}

		}

		//저장 콜백
		this.fnSaveCallBack = function(res) {
			if(res.success){
				KpackageOBJ.object.alert("저장되었습니다.");
				FTA_INCOTERMS.retrieve_GridData();
			}else{
				KpackageOBJ.object.alert(res.message);
			}
		}
		
		//곧통팝업 오픈
		this.fnOpenCompop = function(popGubn) {
			const selRowIndex = KpackageOBJ.auiGrid.getSelectedIndex(FTA_INCOTERMS.gridId)[0];
			let popParam = {};
			let callbackFunc ="";	
			let popUrl = "";
			let popTitle = "";
			
			if(popGubn === "nation"){
				popUrl = "/origin/commonPop/comNation";
				popTitle = "국가코드 조회";
				popParam = {
		    			"searchText" : KpackageOBJ.auiGrid.getCellValue(FTA_INCOTERMS.gridId, selRowIndex, "nation_code")
		    	}
				callbackFunc =  "FTA_INCOTERMS.setComNationPopupData";
		    	
			
			}else if(popGubn === "division"){
				popUrl = "/origin/commonPop/comDivision";
				popTitle = "사업장 조회";
				popParam = {
		    			"searchText" : KpackageOBJ.auiGrid.getCellValue(FTA_INCOTERMS.gridId, selRowIndex, "division_code")
		    	}
				callbackFunc =  "FTA_INCOTERMS.setComDivisionPopupData";
			}
			
			
			window.commonPopupParam = {
	    			rowIndex : selRowIndex,
	    		    callback: callbackFunc,
	    		    data: popParam
	    		};
	    	
	    	KpackageOBJ.dialog.open('commonPop',popTitle,popUrl,1000,700);
		};
			
		
		//국가코드 팝업 세팅
	    this.setComNationPopupData = function(selectedData) {
			KpackageOBJ.auiGrid.setCellValue(FTA_INCOTERMS.gridId, selectedData["rowIndex"], "nation_code", selectedData["code"]);
	    	KpackageOBJ.auiGrid.setCellValue(FTA_INCOTERMS.gridId, selectedData["rowIndex"], "nation_name", selectedData["code_name"]);

	    };
	    
		//사업장코드 팝업 세팅
	    this.setComDivisionPopupData = function(selectedData) {
			KpackageOBJ.auiGrid.setCellValue(FTA_INCOTERMS.gridId, selectedData["rowIndex"], "division_code", selectedData["code"]);

	    };
	}

	$(document).ready(function () {
		FTA_INCOTERMS.Initialize_listObject();
	});
	

</script>
</html>