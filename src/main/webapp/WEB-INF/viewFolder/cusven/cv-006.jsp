<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	/**********************************************************************************************
	* PGM ID : CV006
	* PGM DESC : BOM 전송(환급)
	* Remark : 
	*
	**********************************************************************************************/
	String serverName = request.getServerName();
	String portNumber = request.getServerPort()+"";
	String serverFullUrl = serverName;
	if(!"80".equalsIgnoreCase(portNumber) && !"443".equalsIgnoreCase(portNumber)){
		serverFullUrl = serverFullUrl + "" +  portNumber;
	}
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<OBJECT style="display: none;" classid="clsid:{4190A3E7-2648-4FD5-A120-03F99F7B321E}" align=center hspace=0 vspace=0 id="KPMGUnipassObj"></OBJECT>
<div id="content">
	<section id="widget-grid-CV006" class="">
		<form:form id="CV006-form" class="s4-form" novalidate="novalidate" action="/db-002" method="post">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 130px;" />
								<col style="width: 25%;" />
								<col style="width: 130px;" />
								<col style="width: 25%;" />
								<col style="width: 130px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='환급신청월' /></th>
									<td>
										<input type="text" id="DRWBAK_MONTH_FROM"  name="DRWBAK_MONTH_FROM" class="inputText has-month-picker" searchfnc="CV006.retrieve_CV006List"/>
										<span class="fromTo-Dash">~</span>
										<input type="text" id="DRWBAK_MONTH_TO"  name="DRWBAK_MONTH_TO" class="inputText has-month-picker" searchfnc="CV006.retrieve_CV006List"/>
									</td>
									<th><spring:message code='환급결정일자' /></th>
									<td>
										<input type="text" id="CAL_SEARCH_COMP_FROM_DATE"  name="CAL_SEARCH_COMP_FROM_DATE" style="width:120px" class="inputText" searchfnc="CV006.retrieve_CV006List"/>
										<input type="hidden" id="SEARCH_COMP_FROM_DATE"  name="SEARCH_COMP_FROM_DATE" />
										<span class="fromTo-Dash">~</span>
										<input type="text" id="CAL_SEARCH_COMP_TO_DATE"  name="CAL_SEARCH_COMP_TO_DATE" style="width:120px" class="inputText" searchfnc="CV006.retrieve_CV006List"/>
										<input type="hidden" id="SEARCH_COMP_TO_DATE"  name="SEARCH_COMP_TO_DATE" />
										
									</td>
									<th><spring:message code='환급접수번호' /></th>
									<td>
										<input type="text" id="REGIST_RCEPT_NO"  name="REGIST_RCEPT_NO" style="width:99%" class="inputText" maxlength="20" searchfnc="CV006.retrieve_CV006List"/>
									</td>
								</tr>
								<tr>
									<th><spring:message code='환급제출번호' /></th>
									<td>
										<input type="text" id="SUBMIT_NO"  name="SUBMIT_NO" style="width:99%" class="inputText" maxlength="20" searchfnc="CV006.retrieve_CV006List"/>
									</td>
									<th><spring:message code='수출신고번호' /></th>
									<td>
										<input type="text" id="XPORT_STTEMNT_NO"  name="XPORT_STTEMNT_NO" style="width:99%" class="inputText" maxlength="20" searchfnc="CV006.retrieve_CV006List"/>
									</td>
									<th><spring:message code='전송상태' /></th>
										<td><select class="form-control searchSelect" id="EXECUT_STATUS" name="EXECUT_STATUS" style="width: 110px"></select></td>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-2" type="button" onclick="javascript:CV006.retrieve_CV006List();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_CV006_List" name="div_oTui_CV006_List" class="tuigrid-resizable">
					<div id="oTui_CV006_List" data-minus-height="310"></div>
					<div id="oTui_CV006_List_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>
<div id="REQ_JURGE_DOC_LAYER" title="수신 결과" style="display: none; overflow: hidden;">
	<form:form id="CV006-REQ_DOC-form" class="s4-form" novalidate="novalidate" method="post">
		<input type="hidden" id="FORM_TYPE" name="FORM_TYPE" value="10"/>
		<input type="hidden" id="BOM_PRESENTN_NO" name="BOM_PRESENTN_NO"/>
		<input type="hidden" id="PRESENTN_NO" name="PRESENTN_NO"/>
		<input type="hidden" id="XPORT_STTEMNT_NO" name="XPORT_STTEMNT_NO"/>
		<input type="hidden" id="LNE_NO" name="LNE_NO"/>
		<input type="hidden" id="POUCH_NO" name="POUCH_NO"/>
		<fieldset style="padding: 10px;">
			<section>
				<div class="form-group">
					<div class="row">
						<div class="col-sm-12 col-md-6">
							<label class="control-label">환급심사 요구자료 문서번호</label>
							<input type="text" id="xxxREQ_DOC_NO" name="xxxREQ_DOC_NO" class="form-control" value="sadfasdfsaf"/>
						</div>
						<div class="col-sm-12 col-md-6">
							<label class="control-label">요구자료문서 행번호</label>
							<input type="text" id="xxxREQ_DOC_LINE_NO" name="xxxREQ_DOC_LINE_NO" class="form-control"/>
						</div>
					</div>
				</div>
			</section>
		</fieldset>
		<div class="form-actions" style="margin: 0px;">
			<div class="row">
				<div class="col-md-12">
					<div style="width: 125px; float: right;">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:CV006.dataSaveFunction();">
							<i class="fa fa-save"></i> 저장
						</button>
					</div>
				</div>
			</div>
		</div>
	</form:form>
</div>
<div id="UNPS_RESULT_LAYER" title="" style="display: none;overflow: hidden;">
	<fieldset style="padding: 0px;">
		<section>
			<textarea id="UNPS_RESULT" rows="" cols="" style="height: 500px;width: 95%;margin-left: 18px;margin-top: 10px;" readonly="readonly"></textarea>
		</section>
	</fieldset>
</div>

<script>
	
	var CV006 = new function(){
		
		
		
		this.Initialize_viewObject = function() {
			
			var fromDay = KpackageOBJ.date.getCurrMonth() + "01";
			var toDay = KpackageOBJ.date.getCurrMonth() + KpackageOBJ.date.lastDay(KpackageOBJ.date.getCurrMonth());
			
			
			
			KpackageOBJ.monthPicker.create("CV006-form", "DRWBAK_MONTH_FROM");
			KpackageOBJ.monthPicker.setValue("CV006-form","DRWBAK_MONTH_FROM", KpackageOBJ.date.getCurrMonth("").replace(/-/gi, ""));
			
			KpackageOBJ.monthPicker.create("CV006-form", "DRWBAK_MONTH_TO");
			KpackageOBJ.monthPicker.setValue("CV006-form","DRWBAK_MONTH_TO", KpackageOBJ.date.getCurrMonth("").replace(/-/gi, ""));
			
						
			KpackageOBJ.calendar.create("CV006-form", "CAL_SEARCH_COMP_FROM_DATE");
			KpackageOBJ.calendar.create("CV006-form", "CAL_SEARCH_COMP_TO_DATE");
			
			
			var arrayItem = [{value:"DRWB", name:"환급신청서"}
							,{value:"INIT", name:"기납증"}];

			KpackageOBJ.selectbox.create("DB009-form", "DOC_STATUS", "", null, "value", "name", arrayItem);
			KpackageOBJ.selectbox.create("CV006-form", "EXECUT_STATUS",  "/common/retrieveComCdList", {"CATEGORY_CD":"EXECUT_STATUS","OPTION_ALL":"Y"}, "CODE", "NAME");
			
		}
		
		this.renderTuiGrid = function() {
			 
			var colArrayInfo = [
			     { header : "회사코드"    	,name : "COMPANY_CODE"		,width : 120, align: "center" ,hidden:true },
			     { header : "플랜트"    	,name : "DIVISION_CODE"		,width : 120, align: "center" ,hidden:true },
			     { header : "내부관리번호"   	,name : "PRESENTN_NO"		,width : 120, align: "center" ,hidden:true },
			     { header : "환급제출번호"    	,name : "SUBMIT_NO"			,width : 120, align: "center" ,resizable: true, hidden:false },
			     { header : "환급접수번호"    	,name : "REGIST_RCEPT_NO"	,width : 120, align: "center" ,resizable: true, hidden:false },
			     { header : "환급결정일자"   	,name : "DRWBAK_REQ_DATE"	,width : 120, align: "center" ,resizable: true, hidden:false },
			     { header : "HS Code"    	,name : "HS_CODE"			,width : 120, align: "center" ,resizable: true, hidden:false, "formatter" : KpackageOBJ.tuiGrid.hscode10 },
			     { header : "수출신고번호"   	,name : "XPORT_STTEMNT_NO"	,width : 120, align: "center" ,resizable: true, hidden:false },
			     { header : "수출-란"    	,name : "LNE_NO"			,width : 80,  align: "center" ,resizable: true, hidden:false },
			     { header : "수출-행"    	,name : "POUCH_NO"			,width : 80,  align: "center" ,resizable: true, hidden:false },
			     { header : "수출신고일자"   	,name : "DSPTH_DATE"		,width : 100, align: "center" ,resizable: true, hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
			     { header : "제품코드"    	,name : "ITEM_CODE"			,width : 100, align: "center" ,resizable: true, hidden:false },
			     { header : "제품명"    	,name : "ITEM_NM"			,width : 250, align: "left"   ,resizable: true, hidden:false },
			     { header : "수량"    		,name : "ACCMLT_ORDER_QY"	,width : 120, align: "right"  ,resizable: true, hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas },
			     { header : "단위"    		,name : "BASS_UNIT"			,width : 80, align: "center" ,resizable: true, hidden:false },
			     { header : "수출금액"    	,name : "STTEMNT_PC_KRW"	,width : 120, align: "right"  ,resizable: true, hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas },
			     { header : "통화코드"    	,name : "KRW_CRNCY"			,width : 80, align: "center" ,resizable: true, hidden:false },
			     { header : "신고서 작성여부" ,name : "DOC_WRITE_YN"		,width : 120, align: "center" ,resizable: true, hidden:false },
			     { header : "상태코드"    	,name : "EXECUT_STATUS"		,width : 80, align: "center" ,hidden:true },
			     { header : "요구자료번호"   	,name : "REQ_DOC_NO"		,width : 80, align: "center" ,hidden:true },
			     { header : "요구자료행번호" 	,name : "REQ_DOC_LINE_NO"	,width : 80, align: "center" ,hidden:true },
			     { header : "BOM제출 관리"  	,name : "BOM_PRESENTN_NO"	,width : 80, align: "center" ,hidden:true },
			     { header : "전송상태"		,name : "VALID_CODE"		,width : 200	, align : "center"	,hidden : false	,formatter : CV006.transStatus_CustomFormatter},
			     
			];
			 
			  
			 var tools = [{icon:"print", title:"자재명세서(BOM)" 		,text:"양식출력" 				,func:"CV006.openPrintReport"}
						  ,{icon:"none",  title:"입력" 				,text:"요구자료 정보입력" 		,func:"CV006.inputReqJurgeDocNo"}
						  ,{icon:"none",  title:"전송" 				,text:"전송" 					,func:"CV006.sendInterface"}
						  ,{icon:"none",  title:"수신" 				,text:"수신" ,func:"CV006.receiveUnipass"}
						  ,{icon : "none",header : "상태조회"			,text : "상태조회",func : "CV006.unipassStatusPopup"}
						  
				];
			 KpackageOBJ.tuiGrid.setButton("oTui_CV006_List", tools); // Toobar 생성
			 KpackageOBJ.tuiGrid.create("oTui_CV006_List", "/drawback/retrieve_CV006List", colArrayInfo, 'checkbox', CV006.oTui_CV006_List_onClick_Handler, CV006.oTui_CV006_List_onDblclick_Handler );
			 
		}
		
		this.oTui_CV006_List_onClick_Handler  = function(p_GridId, p_RowKey, p_ColName){}
		
		this.oTui_CV006_List_onDblclick_Handler = function(p_GridId, p_RowKey, p_ColName){
			//CV006.openDetailPage(p_RowKey);
		}
		
		/**  조회버튼 클릭 */
		this.retrieve_CV006List = function() {
			var param = KpackageOBJ.data.makePostData("CV006-form");  
			
			KpackageOBJ.tuiGrid.retrieve("oTui_CV006_List", "", param);
			
		}
		

		
		this.openDetail = function(){
		    /*
			var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_CV006_List");
			if(rowData.length == 0){
				alert("선택된 데이터가 없습니다.");
				return;
			}
			if(rowData.length > 1){
				alert("1개의 데이터만 선택할 수 있습니다.");
				return;
			}
			var selectedRowKey = rowData[0].rowKey;
			CV006.openDetailPage(selectedRowKey);*/
		}
		
		/** 상세페이지 호출 */
		this.openDetailPage = function(rowKey){
		    /*
			if(rowKey == null){
				rowKey = 0;
			}
			var rowData = KpackageOBJ.tuiGrid.getRowValues("oTui_CV006_List", rowKey);

			var getParams = "?DIALOG_ID="       		+ "dialog_CV00601"
					        + "&PGMID="         		+  "CV00601"
					        + "&SEARCH_PRESENTN_NO="     +  rowData.PRESENTN_NO
					        ;
			KpackageOBJ.dialog.open("dialog_CV00601", "과다환급금 자진신고서 작성", "/db-00901" + getParams, 1000, 600);
			*/
		}
		
		/** 출력 **/
		
		this.openPrintReport = function(){
		    
	    	var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_CV006_List");
	        
	    	if(rowData.length == 0){
	        	alert("선택된 데이터가 없습니다.");
	            return;
	        }
	       
	    	
	    	if(rowData.length > 1){
	        	alert("1개의 데이터만 선택할 수 있습니다.");
	           	return;
	        }
	 
	    	var getParams = "?DIALOG_ID="                     + "dialog_previewDocumentPage"
	                            + "&PGMID="                    + "previewDocumentPage"
	                            + "&FORM_ID="                  + "prt00500"
	                            + "&FORM_YYYYMMDD="            + KpackageOBJ.date.getCurrDay()
	                            + "&KEY_PARAM1="               + rowData[0].PRESENTN_NO
	                        ;
	        
	       KpackageOBJ.dialog.open("dialog_PreviewDocumentPage", "출력", "/viewPreviewDocumentPage" + getParams, 1000, 700);      
		}
		
	
		this.sendInterface = function(){
			var valid_UnipassStatus = false;
			var docWriteStatus = false;
			var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_CV006_List");
            if(rowData.length == 0){
                alert("선택된 데이터가 없습니다.");
                return;
            }
            
            
            for(var inx = 0; inx < rowData.length ; inx++){
                var rows = rowData[inx];
            	if("10" == rows["EXECUT_STATUS"]){
            		valid_UnipassStatus = true;
            		break;
            	}
            	if("N" == rows["DOC_WRITE_YN"]){
            	    docWriteStatus = true;
            	    break
            	}
            }
            
            if(docWriteStatus){
            	alert("작성되지 않은 문서는 송신 할 수 없습니다.");
            	return;
            }
            
            if(valid_UnipassStatus){
            	alert("상태가 접수상태일 경우 재송신 할 수 없습니다.");
            	return;
            }
            
            KpackageOBJ.ajax.doSubmit("/drawbackDoc/createXml_DrwbBom", rowData, CV006.sendInterface_callback);
		}
		
		this.sendInterface_callback = function(result){
		    var data = result.value;

            if (data.length > 0) {
                KPMGUnipassObj.TransferDoc_Create(); //TransferDoc 객체 생성

                alert("ID : " + data[0]["UNIPASS_ID"]);
                alert("BOX : " + data[0]["UNIPASS_DOC_BOX_CODE"]);
                for (var inx = 0; inx < data.length; inx++) {
                    KPMGUnipassObj.TransferDoc_InsertBuffer(data[inx]["rowKey"]);
                    KPMGUnipassObj.TransferDoc_SetUserID(data[inx]["UNIPASS_ID"]); //관세청유니패스에 등록되 아이디
                    KPMGUnipassObj.TransferDoc_SetCbtID(data[inx]["UNIPASS_DOC_BOX_CODE"]); //관세청유니패스에 등록되 문서함번호
                    KPMGUnipassObj.TransferDoc_SetDocCode(data[inx]["STTEMNT_DOC_STLE"]); //문서코드(FTA원산지증명서 코드)
                    KPMGUnipassObj.TransferDoc_SetConversationID(data[inx]["SUBMIT_NO"]); //Submit_No
                    KPMGUnipassObj.TransferDoc_SetReferenceID(data[inx]["STTEMNT_DOC_STLE"]); //XML 문서 코드
                    KPMGUnipassObj.TransferDoc_SetPayload("http://<%=serverFullUrl%>/rcs/unipass/send/" + data[inx]["PRESENTN_NO"] + ".xml", KpackageOBJ.prototype.unipass_local_dir + data[inx]["PRESENTN_NO"] + ".xml"); //XML 주소
                    
                }

                KPMGUnipassObj.TransferDoc_Call(); //문서 전송

                for (var inx = 0; inx < data.length; inx++) {

                    data[inx]["RTN_CODE"] = KPMGUnipassObj.TransferDoc_GetErrorCode(data[inx]["rowKey"]);
                    data[inx]["RTN_MESSAGE"] = KPMGUnipassObj.TransferDoc_GetErrorMessage(data[inx]["rowKey"]);

                }

                KpackageOBJ.ajax.doSubmit("/drawbackDoc/updateBomSubmitStatus", data, CV006.updateBomSubmitStatus_callback);

            } else {
                alert("생성된 XML 데이터를 확인할 수 없습니다.");
                return;
            }
		}
		
		
		this.updateBomSubmitStatus_callback = function(result){
			if(result.success){
				alert(result.message);
			}else{
			    CV006.unipassSendResult(result.message);
			}
			CV006.retrieve_CV006List();
			
		}
		
		this.unipassSendResult = function(resultMsg){
			
			$("#UNPS_RESULT").val(resultMsg);
			var targetDiv = $("#UNPS_RESULT_LAYER").html();
			KpackageOBJ.dialog.open("dialog_UNPS_RESULT", " 관세청 전송 결과", "", 650, 550, null, true, null, targetDiv);
			
		}
		
		
		
		this.receiveUnipass = function(){
			
            var receiveFile = "https://<%=serverFullUrl%>/common/unipassReceiveData";
            var addparameter = "COMPANY_CODE=${sessionScope._sessionUser.COMPANY_CODE}&DIVISION_CODE=${sessionScope._sessionUser.DIVISION_CODE}";
            KPMGUnipassObj.ReceiveDoc_Create(); //ReceiveDoc 객체 생성
            KPMGUnipassObj.ReceiveDoc_SetUserID("${sessionScope._sessionUser.UNIPASS_ID}"); //관세청유니패스에 등록되 아이디
            KPMGUnipassObj.ReceiveDoc_SetCbtID("${sessionScope._sessionUser.UNIPASS_DOC_BOX_CODE}"); //관세청유니패스에 등록되 문서함번호
            KPMGUnipassObj.ReceiveDoc_UploadURL(receiveFile+"?"+addparameter); //결과 XML 업로드
            
            KPMGUnipassObj.ReceiveDoc_Call();//결과 수신
            
            var code = KPMGUnipassObj.ReceiveDoc_GetErrorCode();//에러 코드
            var message = KPMGUnipassObj.ReceiveDoc_GetErrorMessage();//에러 메시지

            alert("코드["+code+"] : "+message);

            KPMGUnipassObj.ReceiveDoc_Delete(); //ReceiveDoc 객체 해제
            
            CV006.retrieve_CV006List();
		}
		
		
		/**
		 * 환급심사요구자료문서번호 입력
		*/
		this.inputReqJurgeDocNo = function(resultMsg) {
		    
		    var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_CV006_List");
			if(rowData.length == 0){
				alert("선택된 데이터가 없습니다.");
				return;
			}
			
			if(rowData.length > 1){
				alert("한개의 데이터만 선택할 수 있습니다.");
				return;
			}
			
		    var targetDiv = $("#REQ_JURGE_DOC_LAYER").html();
		    targetDiv = targetDiv.replace(/xxx/gi, "");
            KpackageOBJ.dialog.open("dialog_REQ_JURGE_DOC", "심사요구자료문서번호 입력", "", 500, 140, null, true, null, targetDiv);
            KpackageOBJ.object.setFormValue("CV006-REQ_DOC-form","REQ_DOC_NO", rowData[0]["REQ_DOC_NO"]);
			KpackageOBJ.object.setFormValue("CV006-REQ_DOC-form","REQ_DOC_LINE_NO", rowData[0]["REQ_DOC_LINE_NO"]);
        }
		
		this.dataSaveFunction = function() {
		    var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_CV006_List");
		    KpackageOBJ.object.setFormValue("CV006-REQ_DOC-form","BOM_PRESENTN_NO", rowData[0]["BOM_PRESENTN_NO"]);
		    KpackageOBJ.object.setFormValue("CV006-REQ_DOC-form","PRESENTN_NO", rowData[0]["PRESENTN_NO"]);
		    KpackageOBJ.object.setFormValue("CV006-REQ_DOC-form","XPORT_STTEMNT_NO", rowData[0]["XPORT_STTEMNT_NO"]);
		    KpackageOBJ.object.setFormValue("CV006-REQ_DOC-form","LNE_NO", rowData[0]["LNE_NO"]);
		    KpackageOBJ.object.setFormValue("CV006-REQ_DOC-form","POUCH_NO", rowData[0]["POUCH_NO"]);

		    var postData = KpackageOBJ.data.makePostData("CV006-REQ_DOC-form");
		    postData["REQ_DOC_NO"] = KpackageOBJ.object.getFormValue("CV006-REQ_DOC-form","REQ_DOC_NO");
		    postData["REQ_DOC_LINE_NO"] = KpackageOBJ.object.getFormValue("CV006-REQ_DOC-form","REQ_DOC_LINE_NO");
			KpackageOBJ.ajax.doSubmit("/drawbackDoc/createMerge_BomSubmitData", postData, "CV006.dataSaveFunction_CallbackHandler");
		};
		
		this.dataSaveFunction_CallbackHandler = function(result) {
			if (result.success) { // 성공시
			    CV006.retrieve_CV006List();
				alert("<spring:message code='common.msg.saveok'/>");
				KpackageOBJ.dialog.close("dialog_REQ_JURGE_DOC");
			} else { // 실패시
				alert("<spring:message code='common.msg.savefail'/>");
			}
		};
		
		
		this.transStatus_CustomFormatter = function(value){
			var buttonText = "미접수";
			var btnClass = "btn-primary";
			var btnStyle = "padding: 2px 28px; font-color:#ffffff;";		
			var rowData = value.row;
			/* EXECUT_AT 속성 존재 */		
			if(rowData.hasOwnProperty('EXECUT_AT')){
				
				/* EXECUT_AT 값 미존재 */
				if(oUtil.isNull(rowData["EXECUT_AT"])){		
					btnClass = "btn-default";
					btnStyle = "border-color: #ffb100; background-color: #ffb100; font-weight:bold;";
					
					return "<a class='btn "+btnClass+" btn-border tuiGrid-toolbar-freeColor-button' style='"+btnStyle+"'"  
								+ " href=\"javascript:void(0);\" title=\"상세내용 확인하려면 클릭하세요\">" + buttonText + '</a>';											
				}
			}
			
			switch(rowData["EXECUT_STATUS"]){
			case "00":
				buttonText = "전송";
				btnClass = "btn-info";
				btnStyle += "background-color:#0080a3;";
				break;
			case "10":
				buttonText = "접수";
				btnClass = "btn-info";
				btnStyle += "background-color:#0080a3;";
				break;
			case "20":
				buttonText = "오류통보";
				btnClass = "btn-danger ";
				btnStyle += "background-color:#d40000;";
				break;
			case "30":
				buttonText = "보완통보";
				btnClass = "btn-danger ";
				btnStyle += "background-color:#d40000;";	
				break;
			case "40":
				buttonText = "자료제출요청통보";
				btnClass = "btn-danger ";
				btnStyle += "background-color:#d40000;";
				break;
			case "50":
				buttonText = "완료통보";
				btnClass = "btn-success";
				btnStyle += "background-color:#49a900;";
				break;
			case "60":
				buttonText = "지급통보";
				btnClass = "btn-success";
				btnStyle += "background-color:#49a900;";
				break;
			default:
				btnClass = "btn-default";
				btnStyle = "border-color: #ffb100; background-color: #ffb100; font-weight:bold;";
				break;
			}
			
			return "<a class='btn "+btnClass+" btn-border tuiGrid-toolbar-freeColor-button' style='"+btnStyle+"'"  
			+ " href=\"javascript:CV006.transStatusDetail('"+rowData["PRESENTN_NO"]+"');\" title=\"상세내용 확인하려면 클릭하세요\">" + buttonText + '</a>';	
		}
		
		this.transStatusDetail = function() {
			KpackageOBJ.tuiGrid.uncheckAll("oTui_CV006_List");
			KpackageOBJ.tuiGrid.check("oTui_CV006_List",KpackageOBJ.tuiGrid.getSelectedRowKey("oTui_CV006_List"));
			CV006.unipassStatusPopup();
		}
		
		this.unipassStatusPopup = function() {
            var rowDatas = KpackageOBJ.tuiGrid.getCheckedRows("oTui_CV006_List");

            if (rowDatas.length == 0) {
                alert("선택된 데이터가 없습니다.");
                return;
            }

            if (rowDatas.length > 1) {
                alert("1개의 데이터만 선택할 수 있습니다.");
                return;
            }

            var rowData = rowDatas[0];
            if ("00" == rowData.EXECUT_STATUS) {
                alert("미접수, 전송 단계에서는 상태를 조회할 수 없습니다.");
                return;
            }

            var getParams = "?DIALOG_ID=" + "dialog_unipassStatusPopup" + "&PGMID=" + "unipassStatusPopup" + "&FORM_ID=" + "unipassStatusPopup" + "&EXECUT_STATUS=" + rowData.EXECUT_STATUS + "&SUBMIT_NO=" + rowData.BOM_SUBMIT_NO + "&PRESENTN_NO=" + rowData.BOM_PRESENTN_NO;
            
            if(rowData.REGIST_RCEPT_NO !== undefined){
				getParams += "&REGIST_RCEPT_NO=" + rowData.BOM_REGIST_RCEPT_NO;
			}

            KpackageOBJ.dialog.open("dialog_unipassStatusPopup", "유니패스 전송상태", "/drawbackDoc/unipassStatusPopup" + getParams, 1000, 700);
        }
	}
	
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		CV006.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		CV006.renderTuiGrid();
	});
	
	
</script>
</body>
</html>