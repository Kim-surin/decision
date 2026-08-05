<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


</head>
<body>
	<form:form id="comFtaCodePop-form" class="s4-form h-full" novalidate="novalidate" onsubmit="return false;">
		<div class="modal-header h-20">
			<div class="row h-full w-full"   style="position:relative; margin:0; padding-right:110px;">
				<div class="d-flex w-full" style="vertical-align:middle;  align-items: center;">
					<label class="form-label w-15 p-2" id="searchNationLabel" for="example-input-border">국가코드</label>
					<select class="form-control w-35" id="searchNation" name="searchNation" style="width:110px" disabled></select>        
					<label class="form-label w-15 p-2" for="example-input-border">기준일자</label>
					<input type="date" id="searchEffectDate"  
					       class="form-control w-30" 
					       onkeydown="if(event.key==='Enter'){COM_FTACODE_POPUP.retrieve_GridData(); return false;}">

				</div>
				<div class="d-flex mb-3 w-full" style="vertical-align:middle">
					<label class="form-label w-15 p-2" for="example-input-border">코드/명</label>
					<input type="text" id="searchText"  
					       class="form-control w-80" 
					       onkeydown="if(event.key==='Enter'){COM_FTACODE_POPUP.retrieve_GridData(); return false;}"
					        >		
				</div>
				<div class="h-70" style="position:absolute; right:0;top:43%; transform:translateY(-50%); width:130px;">
					<button type="button" 
					        onclick="javascript:COM_FTACODE_POPUP.retrieve_GridData();" style=""
							class="btn btn-sm btn-search search-no-more waves-effect waves-themed w-100 h-90">Search</button>
								
				</div>
			</div>
		</div>
		<div class="modal-body h-60">
			<div class="row h-full">
				<div class="col-12 dual-grid-wrap">
					<div class="w-full h-full" >
						<div id="oAuiGrid_comFtaCodePop" class="w-100 h-95"></div>
					</div>
				</div>
			</div>		
		</div>
		<div class="modal-footer h-10">
			<button type="button" class="btn btn-primary" style="margin-right:5px;"  onClick="COM_FTACODE_POPUP.fnSelectCode()">Select</button>
		</div>
	</form:form>

</body>
<script>
	var COM_FTACODE_POPUP = new function() {
		this.gridId = "";
		
		this.state = {
			params : {}
		}
		
		// 시작점
		this.Initialize_viewObject = function() {
			const popupConfig = parent.commonPopupParam;
			COM_FTACODE_POPUP.state['params'] = parent.commonPopupParam['data'];
			KpackageOBJ.object.setFormValue("comFtaCodePop-form", "searchText", COM_FTACODE_POPUP.state['params']['searchText']);
			KpackageOBJ.object.setFormValue("comFtaCodePop-form", "searchEffectDate", KpackageOBJ.date.getCurrDay('-'));
			
			if(COM_FTACODE_POPUP.state['params']['searchNationView']){
				KpackageOBJ.selectbox.create("comFtaCodePop-form", "searchNation",  "/common/retrieveComCdList", {"CATEGORY":"NA", "OPTION_ALL":"Y"}, "code", "code_name");  
				KpackageOBJ.object.setFormValue("comFtaCodePop-form", "searchNation", COM_FTACODE_POPUP.state['params']['searchNation']);
				$('#comFtaCodePop-form #searchNation').show();      
				$('#comFtaCodePop-form #searchNationLabel').show();      
			}else{
				$('#comFtaCodePop-form #searchNation').hide();
				$('#comFtaCodePop-form #searchNationLabel').hide();      
			}
			
			COM_FTACODE_POPUP.createAUIGrid();
			COM_FTACODE_POPUP.retrieve_data();
		}


		// AUIGrid 를 생성합니다.
		this.createAUIGrid = function() {
			const columnLayout = [
				{
					dataField: "code"
				  , headerText: "코드"
				  , width: 150
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
					dataField: "code_name"
				  , headerText: "코드명"
				  , width: 200
				  , style: "grid-left-text"
				  , filter: {showIcon: true}
				},
				{
					dataField: "effect_date"
				  , headerText: "발효일자"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
			];
			
			const gridProps = {
					usePaging: false,
					enableFilter: true,
					fillColumnSizeMode:true,
					showStateColumn:false,
					selectionMode : "singleRow",
				};
			
			
			COM_FTACODE_POPUP.gridId = KpackageOBJ.auiGrid.create("oAuiGrid_comFtaCodePop", columnLayout, gridProps, "radio");
			
			AUIGrid.bind(COM_FTACODE_POPUP.gridId, "cellDoubleClick", function (event) {
				COM_FTACODE_POPUP.selectData(event.item)
			});
			
			
		};
		
		this.retrieve_GridData = function(){
			const params = {
				  "searchText" : KpackageOBJ.object.getFormValue("comFtaCodePop-form", "searchText")
				, "searchEffectDate" : KpackageOBJ.object.getFormValue("comFtaCodePop-form", "searchEffectDate").replace(/-/g, "")
				, "searchNation" : KpackageOBJ.object.getFormValue("comFtaCodePop-form", "searchNation")
			};
			
			KpackageOBJ.auiGrid.retrieve(COM_FTACODE_POPUP.gridId, "/origin/commonPop/retrieveComFtaCodePopList", params);
		};
		
		this.retrieve_data = function(){
			const params = {
				  "searchText" : KpackageOBJ.object.getFormValue("comFtaCodePop-form", "searchText")
				, "searchEffectDate" : KpackageOBJ.object.getFormValue("comFtaCodePop-form", "searchEffectDate").replace(/-/g, "")
				, "searchNation" : KpackageOBJ.object.getFormValue("comFtaCodePop-form", "searchNation")
			};
			
			KpackageOBJ.ajax.doSubmit("/origin/commonPop/retrieveComFtaCodePopList", params, COM_FTACODE_POPUP.retrieve_dataCallback);
		};
		
		this.retrieve_dataCallback = function(res){
			if(res.success){
				if(res.value.length === 1){
					COM_FTACODE_POPUP.selectData(res.value[0]);
				}else{
					KpackageOBJ.auiGrid.setGridData(COM_FTACODE_POPUP.gridId, res.value);
				}
			}
		
		};
		
		
		this.selectData = function (selectedData) {

		    var callback = parent.commonPopupParam["callback"];

		    if (!callback) {
		        console.error("callback 정보가 없습니다.");
		        return;
		    }

		    var path = callback.split(".");

		    var target = parent;

		    // 마지막 함수 전까지 객체 탐색
		    for (var i = 0; i < path.length - 1; i++) {
		        target = target[path[i]];

		        if (!target) {
		            console.error("객체를 찾을 수 없습니다. : " + path[i]);
		            return;
		        }
		    }

		    var fn = target[path[path.length - 1]];

		    if (typeof fn !== "function") {
		        console.error("콜백 함수가 존재하지 않습니다. : " + callback);
		        return;
		    }

		    selectedData['rowIndex'] = parent.commonPopupParam["rowIndex"];
		    fn.call(target, selectedData);

		    
		    
		    KpackageOBJ.dialog.close("commonPop");
		};
		
		this.fnSelectCode = function() {
			const data = KpackageOBJ.auiGrid.getCheckedRowItemsAll(COM_FTACODE_POPUP.gridId);
			
			if(data.length === 0){
				KpackageOBJ.object.alert("선택된 데이터가 없습니다.");
				return;
			}
			
			COM_FTACODE_POPUP.selectData(data[0]);		
		}
		
	};
	
	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		COM_FTACODE_POPUP.Initialize_viewObject();
	});
</script>
</html>
