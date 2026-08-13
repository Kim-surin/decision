<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


</head>
<body>
	<form:form id="boadrDetailPop-form" class="s4-form h-full" novalidate="novalidate" onsubmit="return false;">
		<div class="modal-header h-10">
			<div class="d-flex justify-content-end align-items-center w-100">
				<button id="btnReply" type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" style="margin-right:5px" onclick="BOARD_DETAIL.fnReply()">답글등록하기</button>
				<button id="btnSave" type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="BOARD_DETAIL.fnSave()">저장</button>
			</div>
		</div>
		<div class="modal-body h-90">
			<div class="detail-card mb-3"  style="height:100%; display:flex; flex-direction:column;">
				<div class="detail-card-row">
					<div class="detail-card-label">게시물 번호</div>
					<input class="detail-card-value detail-input h-full" type="number" id="boardNo" class="form-control" disabled>
				</div>
				<div class="detail-card-row">
					<div class="detail-card-label">제목</div>
					<input class="detail-card-value detail-input h-full" type="text" id="subject" class="form-control">
				</div>
				<div class="detail-card-row">
					<div class="detail-card-label">게시글 유형</div>
					<select class="detail-card-value" id="boardType" name="boardType"></select>   
					<div class="detail-card-label">팝업표시 여부</div>
					<select class="detail-card-value" id="mainPopupYn" name="mainPopupYn"></select>        
				</div>
				<div class="detail-card-row-2">
					<div class="detail-card-label">게시기간</div>
					<div class="d-flex gap-2" style="align-items:center; margin-left:10px">
						<input class="form-control" id="startDate" name="startDate" type="date">
						<input class="form-control" id="endDate" name="endDate" type="date">
					</div>
				</div>
				<div class="detail-card-row-2" style="flex:1; min-height:0; overflow-y:auto;">
					<div class="detail-card-label">내용</div>
					<textarea id="contents"
							  class="detail-card-value detail-input form-control"
							  style="height:100%; resize:none;"></textarea>
				</div>
				<div class="detail-card-row-2" style="height:100px">
					<div id="boardFileAreaLabel" class="detail-card-label">첨부파일</div>
					<div id="boardFileArea" class="detail-card-value" style="display:block;"></div>
				</div>
			</div>
		</div>
	</form:form>

</body>
<script>
	var BOARD_DETAIL = new function() {
		this.gridId = "";
		
		this.state = {
			params : {}
		};
	
		// VIEW OBJECT INIT
		this.Initialize_viewObject = function() {
			KpackageOBJ.selectbox.create("boadrDetailPop-form", "boardType",  "/common/retrieveComCdList", {"CATEGORY":"BT", "OPTION_ALL":"Y", "OPTION_ALL_NAME": "선택"}, "code", "code_name");  
			KpackageOBJ.selectbox.create("boadrDetailPop-form", "mainPopupYn",  "/common/retrieveComCdList", {"CATEGORY":"YN", "OPTION_ALL":"N"}, "code", "code_name");  
			
			const fileTableInfo =  { downloadUrl: "/origin/board/boardMgnt/downloadBoardFile" , fileNameField: "origin_file_name", keyFields: ["company_code","board_no", "file_seq"]};
			KpackageOBJ.file.create("boadrDetailPop-form", "boardFileArea", "boardFileAreaLabel",fileTableInfo);	
			
			
			BOARD_DETAIL.state['params'] = JSON.parse('${params["data"]}');
			
			// 신규인 경우에 답글 숨김처리 
			if(BOARD_DETAIL.state["params"]["input_type"] === "I"){  
				$("#btnReply").hide();
				BOARD_DETAIL.fnResetValue()
			}else{ //수정
				$("#btnReply").show();
				BOARD_DETAIL.fnSearch();
			}
		};
		
		this.fnResetValue = function() {
			KpackageOBJ.object.setFormValue("boadrDetailPop-form", "boardNo", "");
			KpackageOBJ.object.setFormValue("boadrDetailPop-form", "subject", "");
			KpackageOBJ.object.setFormValue("boadrDetailPop-form", "boardType", "");
			KpackageOBJ.object.setFormValue("boadrDetailPop-form", "mainPopupYn", "N");
			KpackageOBJ.object.setFormValue("boadrDetailPop-form", "contents", "");
			KpackageOBJ.object.setFormValue("boadrDetailPop-form", "startDate", "");
			KpackageOBJ.object.setFormValue("boadrDetailPop-form", "endDate", "");
			KpackageOBJ.file.clear("boadrDetailPop-form", "boardFileArea");
		};
		
		this.fnSearch = function() {
			KpackageOBJ.ajax.doSubmit("/origin/board/boardMgnt/retrieveBoardMgntDetail", BOARD_DETAIL.state['params'], BOARD_DETAIL.fnSearch_CallBack);
		};
		
		this.fnSearch_CallBack = function(res) {
			if(res.success){
				
				//게시판 글 데이터 세팅
				const boardInfo = res.value["boardInfo"];
				KpackageOBJ.object.setFormValue("boadrDetailPop-form", "boardNo", boardInfo['board_no']);
				KpackageOBJ.object.setFormValue("boadrDetailPop-form", "subject", boardInfo['subject']);
				KpackageOBJ.object.setFormValue("boadrDetailPop-form", "boardType", boardInfo['board_type']);
				KpackageOBJ.object.setFormValue("boadrDetailPop-form", "mainPopupYn", boardInfo['main_popup_yn']);
				KpackageOBJ.object.setFormValue("boadrDetailPop-form", "contents", boardInfo['contents']);
				KpackageOBJ.object.setFormValue("boadrDetailPop-form", "startDate", boardInfo['start_date']);
				KpackageOBJ.object.setFormValue("boadrDetailPop-form", "endDate", boardInfo['end_date']);
				
				KpackageOBJ.file.setFiles("boadrDetailPop-form", "boardFileArea", res.value["fileList"]);
			}
		};
		
		this.fnSave = function() {
			var startDate = KpackageOBJ.object.getFormValue("boadrDetailPop-form", "startDate");
			startDate = oUtil.isNull(startDate) ? startDate : startDate.replace(/-/gi, "");
			var endDate = KpackageOBJ.object.getFormValue("boadrDetailPop-form", "endDate");
			endDate = oUtil.isNull(endDate) ? endDate : endDate.replace(/-/gi, "");
			
			const validTarget = [
				  {"targetId" : "subject" , "validMsg" : "제목을 입력해주세요."}
				, {"targetId" : "boardType" , "validMsg" : "게시글 유형을 선택해주세요."}
			];
			
			for(var i = 0; i< validTarget.length; i++){
				if(oUtil.isNull(KpackageOBJ.object.getFormValue("boadrDetailPop-form", validTarget[i]["targetId"]))){
					KpackageOBJ.object.alert(validTarget[i]["validMsg"]);
					return false;
				}
			}
			
			//날짜 유효성 체크
			if (
				(oUtil.isNull(startDate) && !oUtil.isNull(endDate)) ||
				(!oUtil.isNull(startDate) && oUtil.isNull(endDate))
			) {
				alert("게시기간의 시작일자와 종료일자를 모두 입력해주세요.");
				return false;
			}
			
			// 시작일자가 종료일자보다 큰 경우
			if (
				!oUtil.isNull(startDate) &&	!oUtil.isNull(endDate) && startDate > endDate
			) {
				alert("시작일자는 종료일자보다 클 수 없습니다.");
				return false;
			}
			
			
			if (!confirm("저장하시겠습니까?")) {
            	return;
        	}	
			
			var parentBoardNo = BOARD_DETAIL.state['params']["parentBoardNo"];
			parentBoardNo = oUtil.isNull(parentBoardNo)	? null : Number(parentBoardNo);
			var boardNo = KpackageOBJ.object.getFormValue("boadrDetailPop-form","boardNo");
			boardNo = oUtil.isNull(boardNo) ? null: Number(boardNo);
			
			var params = {
				   "inputType" : BOARD_DETAIL.state['params']["input_type"]
				  , "parentBoardNo" : parentBoardNo
				  , "boardNo" :	boardNo
				  , "subject" :	KpackageOBJ.object.getFormValue("boadrDetailPop-form", "subject")
				  , "boardType" :	KpackageOBJ.object.getFormValue("boadrDetailPop-form", "boardType")
				  , "mainPopupYn" :	KpackageOBJ.object.getFormValue("boadrDetailPop-form", "mainPopupYn")
				  , "startDate" :	startDate
				  , "endDate" :	endDate
				  , "contents" :	KpackageOBJ.object.getFormValue("boadrDetailPop-form", "contents")
			};
			
			var formData = KpackageOBJ.file.getFormData("boardFileArea");
			
			formData.append( "boardData", new Blob( [JSON.stringify(params)],{ type: "application/json" }));
			KpackageOBJ.ajax.doMultipartSubmit("/origin/board/boardMgnt/saveBoardMgntDetail", formData,BOARD_DETAIL.fnSaveCallBack);

		};

		this.fnSaveCallBack = function(res) {
			if(res.success){
				KpackageOBJ.object.alert("저장되었습니다.");
				
				BOARD_DETAIL.state['params']['board_no'] = res.value;
				BOARD_DETAIL.state['params']['input_type'] = "U";
				
				$("#btnReply").show();
				
				BOARD_DETAIL.fnSearch();
				BOARD_LIST.retrieve_GridData();
			}else{
				KpackageOBJ.object.alert(res.message);
			}
			
		};
		
		this.fnReply = function() {
			var parentBoardNo = BOARD_DETAIL.state['params']['board_no'];
		    var parentSubject = KpackageOBJ.object.getFormValue( "boadrDetailPop-form","subject");
			
			BOARD_DETAIL.fnResetValue();
			BOARD_DETAIL.state['params']['parentBoardNo'] = parentBoardNo;
			BOARD_DETAIL.state['params']['input_type'] = "I";
			BOARD_DETAIL.state['params']['board_no'] = null;
		    KpackageOBJ.object.setFormValue("boadrDetailPop-form","subject","RE: " + parentSubject);
		    $("#btnReply").hide();
		};

		
	};
	
	
	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		BOARD_DETAIL.Initialize_viewObject();
	});
</script>
</html>
