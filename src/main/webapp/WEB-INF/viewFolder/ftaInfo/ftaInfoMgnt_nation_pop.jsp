<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>


</head>
<body>
	<form:form id="ftaNation-form" class="s4-form" novalidate="novalidate" onsubmit="return false;">
		<div class="modal-header" style="">
			<button type="button" class="btn btn-primary" style="margin-left: auto;" onclick="FTAINFO_NATION.fnSave()" >저장</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-12 dual-grid-wrap">
					<div class="w-45 h-full" >
						<div class="grid-title mb-1">협정 추가 가능 국가 목록</div>
						<div id="oAuiGrid_nationL" class="w-100 h-100"></div>
					</div>
					<div class="col-2 transfer-btn-area">
				        <button class="btn btn-primary mb-2" onclick="FTAINFO_NATION.fnTransferRight()">
				            &gt;
				        </button>
				
				        <button class="btn btn-primary" onclick="FTAINFO_NATION.fnTransferLeft()">
				            &lt;
				        </button> 
				    </div>
				    <div class="w-45 h-full" >
				    	<div class="grid-title mb-1">협정 국가 목록</div>
						<div id="oAuiGrid_nationR" class="w-100 h-100"></div>
					</div>
				</div>
			</div>		
		</div>
	</form:form>
</body>
<script>
	var FTAINFO_NATION = new function() {
		this.gridIdL = "";
		this.gridIdR = "";
		
		this.state = {
			params : {}
		}
		
		// View Object Init
		this.Initialize_viewObject = function() {
			FTAINFO_NATION.createAUIGrid();
			FTAINFO_NATION.retrieve_LeftGridData();
			FTAINFO_NATION.retrieve_RightGridData();
		}


		// Grid Init
		this.createAUIGrid = function() {
			const leftGridColumnLayout = [
				{
					dataField: "nation_code"
				  , headerText: "국가 코드"
				  , width: 120
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				  , editable: false
				},
				{
					dataField: "nation_name"
				  , headerText: "국가명"
				  , width: 120
				  , style: "grid-left-text"
				  , filter: {showIcon: true}
				  , editable: false
				},
			];
			
			const rightGridColumnLayout = [
				{
					dataField: "nation_code"
				  , headerText: "국가 코드"
				  , width: 120
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				  , editable: false
				},
				{
					dataField: "nation_name"
				  , headerText: "국가명"
				  , width: 120
				  , style: "grid-left-text"
				  , filter: {showIcon: true}
				  , editable: false
				},
				{
					dataField: "effect_date"
				  , headerText: "일자"
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
			];
			
			const gridProps = {
					usePaging: false,
					enableFilter: true,
					editable:true,
					fillColumnSizeMode:true,
					showStateColumn:true,
					enableDrag: true,
					// 셀에서 바로  드래깅 해 이동 가능 여부 (기본값 : false) - enableDrag=true 설정이 선행 
					enableDragByCellDrag: true,
					// 드랍 가능 여부 (기본값 : true)
					enableDrop: true,
					// 드랍을 받아줄 그리드가 다른 그리드에도 있는지 여부 (기본값 : false)
					// 즉, 드리드 간의 행 이동인지 여부
					dropToOthers: true
				};
			
			
			FTAINFO_NATION.gridIdL = KpackageOBJ.auiGrid.create("oAuiGrid_nationL", leftGridColumnLayout, gridProps, "check");
			FTAINFO_NATION.gridIdR = KpackageOBJ.auiGrid.create("oAuiGrid_nationR", rightGridColumnLayout, gridProps, "check");
		};
		
		//좌측 그리드 조회
		this.retrieve_LeftGridData = function(){
			KpackageOBJ.auiGrid.retrieve(FTAINFO_NATION.gridIdL, "/origin/ftaInfo/ftaNation/retrieveFtaNationAllList", FTAINFO_NATION.state["params"]);
		};
		
		//우측 그리드 조회
		this.retrieve_RightGridData = function(){
			KpackageOBJ.auiGrid.retrieve(FTAINFO_NATION.gridIdR, "/origin/ftaInfo/ftaNation/retrieveFtaNationApplyList", FTAINFO_NATION.state["params"]);
		};
		
		//오측 그리드 저장
		this.fnSave = function() {
			const data = KpackageOBJ.auiGrid.getGridDataWithState(FTAINFO_NATION.gridIdR);  //전체 삭제후 INSERT이므로 전처데이터
			const isValid = KpackageOBJ.auiGrid.validateGridData(FTAINFO_NATION.gridIdR, ["effect_date"], "해당 값은 필수 입력값입니다.")
		

			if(isValid){

				if (!confirm("저장하시겠습니까?")) {
					return;
				}	
				
				var params = FTAINFO_NATION.state["params"];
				params["SAVE_LIST"] = data;

				KpackageOBJ.ajax.doSubmit("/origin/ftaInfo/saveFtaNationList", params, FTAINFO_NATION.fnSaveCallBack);
			}

		}
		
		//우측 그리드 저장 콜백
		this.fnSaveCallBack = function(res) {
			if(res.success){
				KpackageOBJ.object.alert("저장되었습니다.");
				FTAINFO_NATION.retrieve_LeftGridData();
				FTAINFO_NATION.retrieve_RightGridData();
				FTA_INFO.retrieve_GridData();
			}else{
				KpackageOBJ.object.alert(res.message);
			}
		}
		
		//우측 이동버튼(>)
		this.fnTransferRight = function() {
			const data = KpackageOBJ.auiGrid.getCheckedRowItemsAll(FTAINFO_NATION.gridIdL);
			
			if (data.length <= 0) {
				KpackageOBJ.object.alert('체크된 내역이 없습니다.');
				return;
			}
			
			KpackageOBJ.auiGrid.addRow(FTAINFO_NATION.gridIdR, data, "last");
			KpackageOBJ.auiGrid.removeCheckedRows(FTAINFO_NATION.gridIdL);
		};

		//좌측 이동버튼(>)
		this.fnTransferLeft = function() {
			const data = KpackageOBJ.auiGrid.getCheckedRowItemsAll(FTAINFO_NATION.gridIdR);
			
			if (data.length <= 0) {
				KpackageOBJ.object.alert('체크된 내역이 없습니다.');
				return;
			}
			KpackageOBJ.auiGrid.addRow(FTAINFO_NATION.gridIdL, data, "last");
			KpackageOBJ.auiGrid.removeCheckedRows(FTAINFO_NATION.gridIdR);
		};
		
	
		
	};
	
	$(document).ready(function() {
		const newObj = JSON.parse(KpackageOBJ.object.getFormValue("ftaInfo-form", "popParam"));
		FTAINFO_NATION.state["params"] = JSON.parse(KpackageOBJ.object.getFormValue("ftaInfo-form", "popParam"));
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		FTAINFO_NATION.Initialize_viewObject();
	});
</script>
<style>

.transfer-btn-area {
    width: 52px;
    height: 500px;

    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;

    gap: 12px;
    flex-shrink: 0;
}

.transfer-btn {
    width: 42px;
    height: 42px;
    padding: 0;

    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 18px;
}
</style>
</html>
