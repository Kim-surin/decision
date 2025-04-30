<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	/**********************************************************************************************
	* PGM ID : DB005
	* PGM DESC : 환급신청서 관리
	* Remark : 
	*
	**********************************************************************************************/
	
	String unipassXmlUrl = request.getScheme() + "://" +request.getServerName()+"/rcs/unipass/send/";

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
<OBJECT style="display: none;" classid="clsid:{4190A3E7-2648-4FD5-A120-03F99F7B321E}" align=center hspace=0 vspace=0 id = "KPMGUnipassObj"></OBJECT>
<div id="content">
	<section id="widget-grid-DB005" class="">
		<form:form id="DB005-form" class="s4-form" novalidate="novalidate" action="/db-002" method="post">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<input type="hidden" id="UNIPASS_ID" name="UNIPASS_ID" value="${sessionScope._sessionUser.UNIPASS_ID}"/>
			<input type="hidden" id="UNIPASS_DOC_BOX_CODE" name="UNIPASS_DOC_BOX_CODE" value="${sessionScope._sessionUser.UNIPASS_DOC_BOX_CODE}"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 120px;" />
								<col style="width: 25%;" />
								<col style="width: 80px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='수출신고수리일' /></th>
									<td>
										<input type="text" id="CAL_SEARCH_FROM_DATE"  name="CAL_SEARCH_FROM_DATE" style="width:120px" class="inputText" searchfnc="DB005.retrieve_DB005List"/>
										<input type="hidden" id="SEARCH_FROM_DATE"  name="SEARCH_FROM_DATE" style="width:120px" class="inputText"/>
										<span class="fromTo-Dash">~</span>
										<input type="text" id="CAL_SEARCH_TO_DATE"  name="CAL_SEARCH_TO_DATE" style="width:120px" class="inputText" searchfnc="DB005.retrieve_DB005List"/>
										<input type="hidden" id="SEARCH_TO_DATE"  name="SEARCH_TO_DATE" style="width:120px" class="inputText"/>
									</td>
									<th><spring:message code='common.title.searchCondition' /></th>
                                    <td>
                                        <select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
                                        <select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
                                        <input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="DB005.retrieve_DB005List"/>
                                    </td>
                                    <td class="no-pd">
                                       <div class="input-group-btn">
                                            <button class="btn-default btn-primary btn-custom-search" name="switchFilterBtn" style="padding: 8px 0px;" type="button" onclick="javascript:KpackageOBJ.object.switchFilter(this,'DB005');">
                                                <i class="fa fa-arrow-down"></i>
                                            </button>
                                        </div>
                                    </td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:DB005.retrieve_DB005List();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
			<div id="DB005-HIDDEN-FILTER" class="row-extends row switchFilter" >
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <colgroup>
                                <col style="width: 120px;" />
                                <col style="width: 25%;" />
                                <col style="width: 120px;" />
                                <col style="width: 25%;" />
                                <col style="width: 120px;" />
                                <col style="width: " />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th><spring:message code='전송상태' /></th>
                                    <td>
                                        <select class="form-control searchSelect" id="EXECUT_STATUS" name="EXECUT_STATUS" style="width:110px"></select>
                                    </td>
                                    <th><spring:message code='HS CODE' /></th>
                                    <td>
                                        <input type="text" id="HS_CODE"  name="HS_CODE" style="width:99%" class="inputText" searchfnc="DB005.retrieve_DB005List"/>
                                    </td>
                                    <th><spring:message code='제출번호' /></th>
                                    <td>
                                        <input type="text" id="REGIST_RCEPT_NO"  name="REGIST_RCEPT_NO" style="width:99%" class="inputText" searchfnc="DB005.retrieve_DB005List"/>
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <th><spring:message code='거래구분' /></th>
                                    <td>
                                        <select class="form-control searchSelect" id="THNG_SE" name="THNG_SE" style="width:110px"></select>
                                    </td>
                                    <th><spring:message code='관리번호(내부)' /></th>
                                    <td>
                                        <input type="text" id="PRESENTN_NO"  name="PRESENTN_NO" style="width:99%" class="inputText" searchfnc="DB005.retrieve_DB005List"/>
                                        
                                    </td>
                                    <th><spring:message code='단축고시대상여부' /></th>
                                    <td>
                                        <select class="form-control searchSelect" id="LF_PRICE_TRGT_YN" name="LF_PRICE_TRGT_YN" style="width:110px"></select>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_DB005_List" name="div_oTui_DB005_List" class="tuigrid-resizable">
					<div id="oTui_DB005_List" data-minus-height="280"></div>
					<div id="oTui_DB005_List_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<div id="UNPS_RESULT_LAYER" title="전송결과" style="display: none;overflow: hidden;">
	<fieldset style="padding: 0px;">
		<section>
			<textarea id="UNPS_RESULT" rows="" cols="" style="height: 500px;width: 95%;margin-left: 18px;margin-top: 10px;" readonly="readonly"></textarea>
		</section>
	</fieldset>
</div>
<iframe name="previewFrame1" id="previewFrame1" width="0%" style="display: none;"></iframe>
<iframe name="previewFrame2" id="previewFrame2" width="0%" style="display: none;"></iframe>
<iframe name="previewFrame3" id="previewFrame3" width="0%" style="display: none;"></iframe>
<form id="dir_reportFrame_Form" name="dir_reportFrame_Form" method="post">
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    <input type="hidden" name="_csrf_header" value="${_csrf.headerName}"/>
	<input type="hidden" id="REPORT_FILE_TYPE" 	name="REPORT_FILE_TYPE" 	value="pdf"/>
	<input type="hidden" id="REPORT_TYPE" 	name="REPORT_TYPE" 			value="pdf"/>   
	<input type="hidden" id="KEY_PARAM1"     name="KEY_PARAM1"/>
	<input type="hidden" id="KEY_PARAM2"     name="KEY_PARAM2"/>
	<input type="hidden" id="KEY_PARAM3"     name="KEY_PARAM3"/>
	<input type="hidden" id="KEY_PARAM4"     name="KEY_PARAM4"/>
	<input type="hidden" id="KEY_PARAM5"     name="KEY_PARAM5"/>
	<input type="hidden" id="P_FORM_ID"		name="P_FORM_ID"/>
	<input type="hidden" id="P_FILE_NAME"	name="P_FILE_NAME"/>
	<input type="hidden" id="P_FORM_YYYYMMDD"	name="P_FORM_YYYYMMDD"/>
	<input type="hidden" id="P_DIRECT_DOWNLOAD"	name="P_DIRECT_DOWNLOAD"	value="Y"/>
</form>

<script>
	
	var DB005 = new function(){
		
		
		
		this.Initialize_viewObject = function() {
			
			var fromDay = KpackageOBJ.date.getCurrMonth() + "01";
			var toDay = KpackageOBJ.date.getCurrMonth() + KpackageOBJ.date.lastDay(KpackageOBJ.date.getCurrMonth());
			
			KpackageOBJ.calendar.create("DB005-form", "CAL_SEARCH_FROM_DATE");
			KpackageOBJ.calendar.setValue("DB005-form","CAL_SEARCH_FROM_DATE", fromDay);
			KpackageOBJ.object.setFormValue("DB005-form","SEARCH_FROM_DATE", fromDay);
			
			KpackageOBJ.calendar.create("DB005-form", "CAL_SEARCH_TO_DATE");
			KpackageOBJ.calendar.setValue("DB005-form","CAL_SEARCH_TO_DATE", toDay);
			KpackageOBJ.object.setFormValue("DB005-form","SEARCH_TO_DATE",toDay);
			
			
			KpackageOBJ.selectbox.create("DB005-form", "EXECUT_STATUS",  "/common/retrieveComCdList", {"CATEGORY_CD":"EXECUT_STATUS","OPTION_ALL":"Y"}, "CODE", "NAME");  
			KpackageOBJ.selectbox.create("DB005-form", "THNG_SE",  "/common/retrieveComCdList", {"CATEGORY_CD":"ETC","OPTION_ALL":"Y"}, "CODE", "NAME");  
			
			
			var arrayItem = [
                {value:"ITEM_CODE", name:"<spring:message code='제품코드'/>"}
               , {value:"ITEM_NAME", name:"<spring:message code='제품명'/>"}
              ];

			KpackageOBJ.selectbox.create("DB005-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			var arrayItem = [
                {value:"", name:"<spring:message code='전체'/>"}
               , {value:"Y", name:"<spring:message code='대상'/>"}
               , {value:"N", name:"<spring:message code='비대상'/>"}
               
            ];

			KpackageOBJ.selectbox.create("DB005-form", "LF_PRICE_TRGT_YN", "", null, "value", "name", arrayItem);
						
			
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			          ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
			          ,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("DB005-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
		}
		
		this.renderTuiGrid = function() {
			 
			 var colArrayInfo = [
				 
			     	{ header : "전송상태"		,name : "VALID_CODE"         ,width : 200, align: "center" ,hidden:false, formatter : DB005.transStatus_CustomFormatter},
			     	{ header : "관리번호"    		,name : "PRESENTN_NO"        ,width : 210, align: "center" ,hidden:false },
					{ header : "수출신고건수"    	,name : "XPORT_STTEMNT_CNT"  ,width : 120, align: "right"  ,hidden:false, formatter : KpackageOBJ.tuiGrid.commas },
					{ header : "HS CODE"    		,name : "HS_CODE"            ,width : 120, align: "center" ,hidden:false, formatter : KpackageOBJ.tuiGrid.hscode10 },
					{ header : "거래구분"    		,name : "THNG_SE"            ,width : 80, align: "center" ,hidden:false },
					{ header : "신고금액"    		,name : "STTEMNT_PC_KRW"     ,width : 180, align: "right"  ,hidden:false, formatter : KpackageOBJ.tuiGrid.commas },
					{ header : "원화통화"    		,name : "KRW_CRNCY"          ,width : 100, align: "center" ,hidden:true },
					{ header : "수출수량"    		,name : "ACCMLT_ORDER_QY"    ,width : 120, align: "right"  ,hidden:false, formatter : KpackageOBJ.tuiGrid.commas },
					{ header : "단위"    			,name : "BASS_UNIT"          ,width : 80, align: "center" ,hidden:false },
					{ header : "환급금액"    		,name : "DRWBAK_AMOUNT"      ,width : 180, align: "right"  ,hidden:false, formatter : KpackageOBJ.tuiGrid.commas },
					{ header : "단축고시 대상"    ,name : "LF_PRICE_TRGT"      ,width : 120, align: "center" ,hidden:false },
					{ header : "세율별 비중 대상" ,name : "TAX_RATE_TRGT"      ,width : 120, align: "center" ,hidden:false },
					{ header : "개별환급 계산일"  ,name : "CREATE_DATE"        ,width : 120, align: "center" ,hidden:false, formatter : KpackageOBJ.tuiGrid.date },
					{ header : "DIVISION_CODE"   ,name : "DIVISION_CODE"      ,width : 120, align: "center" ,hidden:true},
					{ header : "유니패스ID"   ,name : "UNIPASS_ID"      ,width : 120, align: "center" ,hidden:true},
					{ header : "문서함코드"   ,name : "UNIPASS_DOC_BOX_CODE"      ,width : 120, align: "center" ,hidden:true},
					{ header : "문서형태코드"   ,name : "STTEMNT_DOC_STLE"      ,width : 120, align: "center" ,hidden:true},
					{ header : "전송 후 문서상태값"   ,name : "EXECUT_STATUS"      ,width : 120, align: "center" ,hidden:false},
					{ header : "접수번호"   ,name : "REGIST_RCEPT_NO"      ,width : 120, align: "center" ,hidden:false},
					{ header : "제출번호"   ,name : "SUBMIT_NO"      ,width : 120, align: "center" ,hidden:false},
					{ header : "전송여부"   ,name : "EXECUT_AT"      ,width : 120, align: "center" ,hidden:false}
					
					
			        
			    ];
			 
			 
			 var tools = [ {icon:"none", title:"환급신청" 	,text:"환급신청" ,func:"DB005.SendUnipassDrwb"}
						  ,{icon:"none", title:"상태조회" 	,text:"상태조회" ,func:"DB005.unipassStatusPopup"}
						  ,{icon:"none", title:"수신" 	,text:"수신" ,func:"DB005.receiveUnipass"}
						  ,{icon:"print", title:"양식출력"               ,text:"일괄다운로드"             ,func:"DB005.openDirectDownload"}
						  ,{icon:"print", title:"양식출력"               ,text:"양식출력"                ,func:"DB005.openPrintReport"}
						  , {icon:"print", title:"자재명세서(BOM)"        ,text:"자재명세서(BOM)"         ,func:"DB005.printPrt00500"}
                          , {icon:"print", title:"소요량계산서"           ,text:"소요량계산서"             ,func:"DB005.printPrt00600"}
						  
				];
			 KpackageOBJ.tuiGrid.setButton("oTui_DB005_List", tools); // Toobar 생성

			 KpackageOBJ.tuiGrid.create("oTui_DB005_List", "/drawback/retrieve_DB005List", colArrayInfo, 'checkbox', DB005.oTui_DB005_List_onClick_Handler, DB005.oTui_DB005_List_onDblclick_Handler );
			 
		}
		
		this.oTui_DB005_List_onClick_Handler  = function(p_GridId, p_RowKey, p_ColName){}
		
		this.oTui_DB005_List_onDblclick_Handler = function(p_GridId, p_RowKey, p_ColName){
			DB005.openDetailPage(p_RowKey);
		}
		
		this.SendUnipassDrwb = function(){
			var valid_UnipassStatus = false;
			var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB005_List");
            if(rowData.length == 0){
                alert("선택된 데이터가 없습니다.");
                return;
            }
            
            
            for(var inx = 0; inx < rowData.length ; inx++){
            	if("10" == rowData["EXECUT_STATUS"]){
            		valid_UnipassStatus = true;
            		break;
            	}
            }
            
            if(valid_UnipassStatus){
            	alert("상태가 접수상태일 경우 재송신 할 수 없습니다.");
            	return;
            }
            
            KpackageOBJ.ajax.doSubmit("/drawbackDoc/createXml_Drwb", rowData, DB005.SendUnipassDrwb_callback);

		}
		
		this.SendUnipassDrwb_callback = function(result){
			var data = result.value;
			if(data.length > 0){
				load_BlockUI2(true);
				KPMGUnipassObj.TransferDoc_Create(); //TransferDoc 객체 생성
/* 	            alert("ID : "  + data[0]["UNIPASS_ID"]);
	            alert("BOX : "  + data[0]["UNIPASS_DOC_BOX_CODE"]);
 */	            for(var inx = 0; inx < data.length; inx++){
	            	KPMGUnipassObj.TransferDoc_InsertBuffer(data[inx]["rowKey"]);
	                KPMGUnipassObj.TransferDoc_SetUserID(data[inx]["UNIPASS_ID"]); //관세청유니패스에 등록되 아이디
	                KPMGUnipassObj.TransferDoc_SetCbtID(data[inx]["UNIPASS_DOC_BOX_CODE"]); //관세청유니패스에 등록되 문서함번호
	                KPMGUnipassObj.TransferDoc_SetDocCode(data[inx]["STTEMNT_DOC_STLE"]); //문서코드(FTA원산지증명서 코드)
	                KPMGUnipassObj.TransferDoc_SetConversationID(data[inx]["SUBMIT_NO"]); //Submit_No
                    KPMGUnipassObj.TransferDoc_SetReferenceID(data[inx]["STTEMNT_DOC_STLE"]); //XML 문서 코드
	                KPMGUnipassObj.TransferDoc_SetPayload("http://<%=serverFullUrl%>/rcs/unipass/send/" + data[inx]["PRESENTN_NO"]+".xml", KpackageOBJ.prototype.unipass_local_dir + data[inx]["PRESENTN_NO"]+".xml"); //XML 주소
	                
	            }
	            
	            KPMGUnipassObj.TransferDoc_Call(); //문서 전송
	            load_BlockUI2(false);
	             
	            for(var inx = 0; inx < data.length; inx++){
					
	            	data[inx]["RTN_CODE"] = KPMGUnipassObj.TransferDoc_GetErrorCode(data[inx]["rowKey"]);
	            	data[inx]["RTN_MESSAGE"] = KPMGUnipassObj.TransferDoc_GetErrorMessage(data[inx]["rowKey"]);
					
	            }
                
	            
	            KpackageOBJ.ajax.doSubmit("/drawbackDoc/updateDrwbStatus", data, DB005.updateDrwbStatus_callback);

                
                
			}else{
				alert("생성된 XML 데이터를 확인할 수 없습니다.");
				return;
			}
			
		}
		
		this.updateDrwbStatus_callback = function(result){
			if(result.success){
				alert(result.message);
			}else{
				DB005.unipassSendResult(result.message);
			}
			DB005.retrieve_DB005List();
			
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
            
            DB005.retrieve_DB005List();
		}
		
		this.transStatus_CustomFormatter = function(value){
			var buttonText = "미접수";
			var btnClass = "btn-primary";
			var btnStyle = "padding: 2px 28px; font-color:#ffffff;";
			/* EXECUT_AT 값 미존재 */
			var rowData = value.row;
			if(oUtil.isNull(rowData["EXECUT_AT"])){
				btnClass = "btn-default";
				btnStyle = "border-color: #ffb100; background-color: #ffb100; font-weight:bold;";
				
				return "<a class='btn "+btnClass+" btn-border tuiGrid-toolbar-freeColor-button' style='"+btnStyle+"'"  
							+ " href=\"javascript:void(0);\" title=\"상세내용 확인하려면 클릭하세요\">" + buttonText + '</a>';											
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
			+ " href=\"javascript:DB005.transStatusDetail('"+rowData["PRESENTN_NO"]+"');\" title=\"상세내용 확인하려면 클릭하세요\">" + buttonText + '</a>';	
		}
		
		this.transStatusDetail = function() {
			KpackageOBJ.tuiGrid.uncheckAll("oTui_DB005_List");
			KpackageOBJ.tuiGrid.check("oTui_DB005_List",KpackageOBJ.tuiGrid.getSelectedRowKey("oTui_DB005_List"));
			DB005.unipassStatusPopup();
		}
		
		this.retrieve_DB005List = function() {
			
			var param = { "DSPTH_DATE_FROM" : KpackageOBJ.object.getFormValue("DB005-form", "SEARCH_FROM_DATE")
						 ,"DSPTH_DATE_TO" : KpackageOBJ.object.getFormValue("DB005-form","SEARCH_TO_DATE")
						 ,"HS_CODE" : KpackageOBJ.object.getFormValue("DB005-form", "HS_CODE")
				         ,"REGIST_RCEPT_NO" : KpackageOBJ.object.getFormValue("DB005-form","REGIST_RCEPT_NO")
				         ,"ITEM_CODE" : KpackageOBJ.object.getFormValue("DB005-form","ITEM_CODE")
				         ,"THNG_SE" : KpackageOBJ.object.getFormValue("DB005-form","THNG_SE")
				         ,"PRESENTN_NO" : KpackageOBJ.object.getFormValue("DB005-form","PRESENTN_NO")
				         , "SEARCH_TYPE" : KpackageOBJ.object.getFormValue("DB005-form","SEARCH_TYPE")
                         , "SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("DB005-form", "SEARCH_KEY_WORD")
                         , "SEARCH_OPTION" : KpackageOBJ.object.getFormValue("DB005-form","SEARCH_OPTION")
                         , "LF_PRICE_TRGT_YN" : KpackageOBJ.object.getFormValue("DB005-form","LF_PRICE_TRGT_YN")
                         , "EXECUT_STATUS" : KpackageOBJ.object.getFormValue("DB005-form", "EXECUT_STATUS")
						};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_DB005_List", "/drawback/retrieve_DB005List", param);

			
		}
		
		this.openDetailPage = function(rowKey){
			var rowData = KpackageOBJ.tuiGrid.getRowValues("oTui_DB005_List", rowKey);
			
			var getParams = "?DIALOG_ID="       + "dialog_DB00501"
					        + "&PGMID="         +  "DB00501"
					        + "&PRESENTN_NO="         +  rowData.PRESENTN_NO
					        + "&LF_PRICE_TRGT="       +  rowData.LF_PRICE_TRGT
					        + "&TAX_RATE_TRGT="       +  rowData.TAX_RATE_TRGT
					        ;
			KpackageOBJ.dialog.open("dialog_DB00501", "환급신청서 조회", "/db-00501" + getParams, 1225, 750);
			
		}
		
		
		this.openDirectDownload = function(){
			
			var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB005_List");
            if(rowData.length == 0){
                alert("선택된 데이터가 없습니다.");
                return;
            }
            if(rowData.length > 1){
                alert("1개의 데이터만 선택할 수 있습니다.");
                return;
            }
            

            /* 자재명세서 */
            KpackageOBJ.object.setFormValue("dir_reportFrame_Form","P_FORM_YYYYMMDD", rowData[0].CREATE_DATE);
            KpackageOBJ.object.setFormValue("dir_reportFrame_Form","KEY_PARAM1", rowData[0].PRESENTN_NO);
            KpackageOBJ.object.setFormValue("dir_reportFrame_Form","KEY_PARAM2", rowData[0].DIVISION_CODE);
            KpackageOBJ.object.setFormValue("dir_reportFrame_Form","KEY_PARAM3", rowData[0].PRESENTN_NO);
            KpackageOBJ.object.setFormValue("dir_reportFrame_Form","KEY_PARAM4", rowData[0].PRESENTN_NO);
            KpackageOBJ.object.setFormValue("dir_reportFrame_Form","KEY_PARAM5", rowData[0].PRESENTN_NO);
            KpackageOBJ.object.setFormValue("dir_reportFrame_Form","P_FORM_ID", "prt00500");
            KpackageOBJ.object.setFormValue("dir_reportFrame_Form","P_FILE_NAME", "BOM_"+rowData[0].SUBMIT_NO);
				            
			$("#dir_reportFrame_Form").prop("target", "previewFrame1");
			$('#dir_reportFrame_Form').prop('action','/thirdParty_ReportApplication');
			$('#dir_reportFrame_Form').submit();
			
			/* 환급신청서 */
		    KpackageOBJ.object.setFormValue("dir_reportFrame_Form","P_FORM_ID", "prt01000");
            KpackageOBJ.object.setFormValue("dir_reportFrame_Form","P_FILE_NAME", "requestForm_"+rowData[0].SUBMIT_NO);
				            
			$("#dir_reportFrame_Form").prop("target", "previewFrame2");
			$('#dir_reportFrame_Form').prop('action','/thirdParty_ReportApplication');
			$('#dir_reportFrame_Form').submit();
			
			/* 소요량계산서 */
		    KpackageOBJ.object.setFormValue("dir_reportFrame_Form","P_FORM_ID", "prt00600");
            KpackageOBJ.object.setFormValue("dir_reportFrame_Form","P_FILE_NAME", "requirement_statements_"+rowData[0].SUBMIT_NO);
				            
			$("#dir_reportFrame_Form").prop("target", "previewFrame3");
			$('#dir_reportFrame_Form').prop('action','/thirdParty_ReportApplication');
			$('#dir_reportFrame_Form').submit();
            
		}
		
		this.openPrintReport = function(){
            var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB005_List");
            if(rowData.length == 0){
                alert("선택된 데이터가 없습니다.");
                return;
            }
            if(rowData.length > 1){
                alert("1개의 데이터만 선택할 수 있습니다.");
                return;
            }
 
            
            var getParams = "?DIALOG_ID="                  + "dialog_previewDocumentPage"
                            + "&PGMID="                    + "previewDocumentPage"
                            + "&FORM_YYYYMMDD="            + rowData[0].CREATE_DATE
                            + "&KEY_PARAM1="               + rowData[0].PRESENTN_NO
                            + "&KEY_PARAM2="               + rowData[0].DIVISION_CODE
                            + "&FORM_ID="                  + "prt01000"
                        ;
            KpackageOBJ.dialog.open("dialog_PreviewDocumentPage", "출력", "/viewPreviewDocumentPage" + getParams, 1000, 700);
        }
		

		this.printPrt00600 = function(result){
	    	var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB005_List");
	        
	    	if(rowData.length == 0){
	        	alert("선택된 데이터가 없습니다.");
	            return;
	        }
	       
	    	
	    	if(rowData.length > 1){
	        	alert("1개의 데이터만 선택할 수 있습니다.");
	           	return;
	        }
	 
	            
	         var getParams = "?DIALOG_ID="                   + "dialog_previewDocumentPage"
	                            + "&PGMID="                  + "previewDocumentPage"
	                            + "&FORM_ID="                + "prt00600"
	                            + "&FORM_YYYYMMDD="          + KpackageOBJ.date.getCurrDay()
	                            + "&KEY_PARAM1="             + rowData[0].PRESENTN_NO
						       ;
	        
	        KpackageOBJ.dialog.open("dialog_PreviewDocumentPage", "출력", "/viewPreviewDocumentPage" + getParams, 1000, 700);        
		}
		
		

		this.printPrt00500 = function(result){
	    	var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB005_List");
	        
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
	
		
		this.unipassSendResult = function(resultMsg){
			
			$("#UNPS_RESULT").val(resultMsg);
			var targetDiv = $("#UNPS_RESULT_LAYER").html();
			KpackageOBJ.dialog.open("dialog_UNPS_RESULT", " 관세청 전송 결과", "", 650, 550, null, true, null, targetDiv);
			
		}
		
		
		
		this.unipassStatusPopup = function(){
	    	var rowDatas = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB005_List");
	        
	    	if(rowDatas.length == 0){
	        	alert("선택된 데이터가 없습니다.");
	            return;
	        }
	       
	    	
	    	if(rowDatas.length > 1){
	        	alert("1개의 데이터만 선택할 수 있습니다.");
	           	return;
	        }
	    	
	    	var rowData = rowDatas[0];
	    	if("00" == rowData.EXECUT_STATUS){
	    		alert("미접수, 전송 단계에서는 상태를 조회할 수 없습니다.");
	           	return;
	    	}
	    	
	    	var getParams = "?DIALOG_ID="                     + "dialog_unipassStatusPopup"
	                            + "&PGMID="                    + "unipassStatusPopup"
	                            + "&FORM_ID="                  + "unipassStatusPopup"
	                            + "&EXECUT_STATUS="            + rowData.EXECUT_STATUS
	                            + "&KEY_PARAM1="               + rowData.PRESENTN_NO
	                            + "&REGIST_RCEPT_NO="               + rowData.REGIST_RCEPT_NO
	                            + "&SUBMIT_NO="               + rowData.SUBMIT_NO
	                            + "&PRESENTN_NO="               + rowData.PRESENTN_NO
	                        ;
	    	
	    	if(rowData.REGIST_RCEPT_NO != undefined){
				getParams += "&REGIST_RCEPT_NO=" + rowData.REGIST_RCEPT_NO;
			}
	        
	       KpackageOBJ.dialog.open("dialog_unipassStatusPopup", "유니패스 전송상태", "/drawbackDoc/unipassStatusPopup" + getParams, 1000, 700);      
		}
	}
	
	
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB005.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		DB005.renderTuiGrid();
	});
	
	
</script>
</body>
</html>