<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	/**********************************************************************************************
	* PGM ID : DB010
	* PGM DESC : 가산금액 지급신청서 목록조회
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
	<section id="widget-grid-DB010" class="">
		<form:form id="DB010-form" class="s4-form" novalidate="novalidate" action="/db-002" method="post">
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
								<col style="width: 140px;" />
								<col style="width: 25%;" />
								<col style="width: 120px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='환급신청월' /></th>
									<td>
										<input type="text" id="DRWBAK_MONTH_FROM"  name="DRWBAK_MONTH_FROM" class="inputText has-month-picker" searchfnc="DB010.retrieve_DB010List"/>
										<span class="fromTo-Dash">~</span>
										<input type="text" id="DRWBAK_MONTH_TO"  name="DRWBAK_MONTH_TO" class="inputText has-month-picker" searchfnc="DB010.retrieve_DB010List"/>
									</td>
									<th><spring:message code='환급신청번호' /></th>
									<td>
										<input type="text" id="REGIST_RCEPT_NO"  name="REGIST_RCEPT_NO" style="width:99%" class="inputText" maxlength="20" searchfnc="DB010.retrieve_DB010List"/>
									</td>
									<td colspan="2">
										<section style="margin-bottom:0px;">
                                            <label class="checkbox"> 
                                            	<input type="checkbox" id="V_REGIST_ABLE_ONLY" name="V_REGIST_ABLE_ONLY"/> <i></i>신청가능건만 조회
                                            	<input type="hidden" id="REGIST_ABLE_ONLY" name="REGIST_ABLE_ONLY"/>
                                            </label> 
										</section>
									</td>
									
								</tr>
								<tr>
									<th><spring:message code='상태' /></th>
									<td>
										<select id="DOC_STATUS"  name="DOC_STATUS" class="form-control searchSelect"  style="width:120px">
									</td>
									<th><spring:message code='지급신청서 작성일자' /></th>
									<td>
										<input type="text" id="CAL_SEARCH_ADAMT_FROM_DATE"  name="CAL_SEARCH_ADAMT_FROM_DATE" style="width:120px" class="inputText" searchfnc="DB010.retrieve_DB010List"/>
										<input type="hidden" id="SEARCH_ADAMT_FROM_DATE"  name="SEARCH_ADAMT_FROM_DATE" />
										<span class="fromTo-Dash">~</span>
										<input type="text" id="CAL_SEARCH_ADAMT_TO_DATE"  name="CAL_SEARCH_ADAMT_TO_DATE" style="width:120px" class="inputText" searchfnc="DB010.retrieve_DB010List"/>
										<input type="hidden" id="SEARCH_ADAMT_TO_DATE"  name="SEARCH_ADAMT_TO_DATE" />
										
									</td>
									<th><spring:message code='전송상태' /></th>
										<td><select class="form-control searchSelect" id="EXECUT_STATUS" name="EXECUT_STATUS" style="width: 110px"></select></td>
								</tr>
									
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-2" type="button" onclick="javascript:DB010.retrieve_DB010List();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_DB010_List" name="div_oTui_DB010_List" class="tuigrid-resizable">
					<div id="oTui_DB010_List" data-minus-height="310"></div>
					<div id="oTui_DB010_List_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>
<div id="UNPS_RESULT_LAYER" title="" style="display: none;overflow: hidden;">
	<fieldset style="padding: 0px;">
		<section>
			<textarea id="UNPS_RESULT" rows="" cols="" style="height: 500px;width: 95%;margin-left: 18px;margin-top: 10px;" readonly="readonly"></textarea>
		</section>
	</fieldset>
</div>
<script>
	
	var DB010 = new function(){
		
		
		
		this.Initialize_viewObject = function() {
			
			var fromDay = KpackageOBJ.date.getCurrMonth() + "01";
			var toDay = KpackageOBJ.date.getCurrMonth() + KpackageOBJ.date.lastDay(KpackageOBJ.date.getCurrMonth());
			
			
			
			KpackageOBJ.monthPicker.create("DB010-form", "DRWBAK_MONTH_FROM");
			KpackageOBJ.monthPicker.setValue("DB010-form","DRWBAK_MONTH_FROM", KpackageOBJ.date.getCurrMonth("").replace(/-/gi, ""));
			
			KpackageOBJ.monthPicker.create("DB010-form", "DRWBAK_MONTH_TO");
			KpackageOBJ.monthPicker.setValue("DB010-form","DRWBAK_MONTH_TO", KpackageOBJ.date.getCurrMonth("").replace(/-/gi, ""));
			
						
			KpackageOBJ.calendar.create("DB010-form", "CAL_SEARCH_ADAMT_FROM_DATE");
			//KpackageOBJ.calendar.setValue("DB010-form","CAL_SEARCH_ADAMT_FROM_DATE", fromDay);
			//KpackageOBJ.object.setFormValue("DB010-form","SEARCH_ADAMT_FROM_DATE", fromDay);
			
			KpackageOBJ.calendar.create("DB010-form", "CAL_SEARCH_ADAMT_TO_DATE");
			//KpackageOBJ.calendar.setValue("DB010-form","CAL_SEARCH_ADAMT_TO_DATE", toDay);
			//KpackageOBJ.object.setFormValue("DB010-form","SEARCH_ADAMT_TO_DATE",toDay);
			
			
			
			var arrayItem = [{value:"", name:"전체"}
		    				,{value:"AA", name:"지급신청서 작성"}
		    				,{value:"BB", name:"지급신청서 미작성"}
		    				,{value:"CC", name:"지급신청서 제출완료"}
		    				,{value:"DD", name:"지급신청서 제출미완료"}
		    				,{value:"EE", name:"지급신청서 접수완료"}
		    				,{value:"FF", name:"지급신청서 접수미완료"}
		    				];

			KpackageOBJ.selectbox.create("DB010-form", "DOC_STATUS", "", null, "value", "name", arrayItem);

			KpackageOBJ.selectbox.create("DB010-form", "EXECUT_STATUS",  "/common/retrieveComCdList", {"CATEGORY_CD":"EXECUT_STATUS","OPTION_ALL":"Y"}, "CODE", "NAME");
			
		}
		
		this.renderTuiGrid = function() {
			 
			 var colArrayInfo = [
					{ header : "환급신청월"    			,name : "DRWBAK_MONTH"				,width : 60, align: "center" ,hidden:false, formatter : KpackageOBJ.tuiGrid.monthFormatter },
					{ header : "환급신청번호"				,name : "PRE_PRESENTN_NO"			,width : 120, align: "center" ,hidden:false },
					{ header : "최초 환급접수번호" 		,name : "PRE_REGIST_RCEPT_NO"		,width : 120, align: "center" ,hidden:false},					
					{ header : "추가 환급접수번호"    		,name : "OVER_DRWBAK_PRESENTN_NO"	,width : 120, align: "center" ,hidden:false },
					{ header : "과다환급금"  	 		,name : "PRE_DRWBAK_AMOUNT"			,width : 100, align: "right"  ,hidden:false, formatter : KpackageOBJ.tuiGrid.commas },					
					{ header : "가산금"   	 			,name : "PROPER_DRWBAK_AMOUNT"		,width : 100, align: "right"  ,hidden:false, formatter : KpackageOBJ.tuiGrid.commas },	
					{ header : "신청서 작성여부"  		,name : "ADAMT_WRITE_YN"			,width : 90, align: "center" ,hidden:false },
					{ header : "제출여부"		 		,name : "ADAMT_SEND_YN"				,width : 80, align: "center"  ,hidden:false },
					{ header : "접수여부"				,name : "ADAMT_RCEPT_YN"			,width : 80, align: "center" ,hidden:false},
					{ header : "과다환급 고지일자"			,name : "OVER_DRWBAK_NOTICE_DATE"	,width : 100, align: "center" ,hidden:false, formatter : KpackageOBJ.tuiGrid.dateFormatter },
					{ header : "과다환급금 수납일자"		,name : "IDV_PAMT_DATE"				,width : 110, align: "center"  ,hidden:false, formatter : KpackageOBJ.tuiGrid.dateFormatter },
					{ header : "신청기한"		 		,name : "RCEPT_LIMIT_DATE"			,width : 100, align: "center"  ,hidden:false, formatter : KpackageOBJ.tuiGrid.dateFormatter },
					{ header : "가산금액 수납일자"			,name : "IDV_PAMT_DATE"				,width : 100, align: "center"  ,hidden:false, formatter : KpackageOBJ.tuiGrid.dateFormatter },
					{ header : "상태코드"    			,name : "EXECUT_STATUS"				,width : 80, align: "center" ,hidden:true },
					{ header : "가산금지급신청서 관리번호" 	,name : "ADAMT_PRESENTN_NO"	        ,width : 100, align: "center" ,hidden:true},
					{ header : "OVER_REGIST_RCEPT_NO" ,name : "OVER_REGIST_RCEPT_NO"	    ,width : 100, align: "center" ,hidden:true},
					{ header : "전송상태"    			,name : "VALID_CODE"				,width : 200, align: "center" ,hidden:false, formatter : DB010.transStatus_CustomFormatter }
					
			    ];
			 
			 
			 var tools = [ {icon:"add",   title:"상세 / 지급신청서 작성" 	,text:"상세 / 지급신청서 작성"	,func:"DB010.openDetail"}
						  /* ,{icon:"none",  title:"출력" 						,text:"출력" 					,func:"DB010.printPdfFile"} */
						  ,{icon:"none",  title:"전송" 				,text:"전송" 	,func:"DB010.sendInterface"}
						  ,{icon:"none",  title:"수신" 				,text:"수신" ,func:"DB010.receiveUnipass"}
						  ,{icon : "none",header : "상태조회",text : "상태조회",func : "DB010.unipassStatusPopup"}
				];
			 KpackageOBJ.tuiGrid.setButton("oTui_DB010_List", tools); // Toobar 생성

			 KpackageOBJ.tuiGrid.create("oTui_DB010_List", "/drawback/retrieve_DB010List", colArrayInfo, 'checkbox', DB010.oTui_DB010_List_onClick_Handler, DB010.oTui_DB010_List_onDblclick_Handler );
			 
		}
		
		this.oTui_DB010_List_onClick_Handler  = function(p_GridId, p_RowKey, p_ColName){}
		
		this.oTui_DB010_List_onDblclick_Handler = function(p_GridId, p_RowKey, p_ColName){
			DB010.openDetailPage(p_RowKey);
		}
		
		/**  조회버튼 클릭 */
		this.retrieve_DB010List = function() {
			var param = KpackageOBJ.data.makePostData("DB010-form");  
			
			if($('input:checkbox[id="V_REGIST_ABLE_ONLY"]').is(":checked")){
				param["REGIST_ABLE_ONLY"] = "ABLE";
			}else{
				param["REGIST_ABLE_ONLY"] = "ALL";
			}
			
			KpackageOBJ.tuiGrid.retrieve("oTui_DB010_List", "", param);
			
		}
		
		this.fileDownload_CustomFormatter = function(value){
			var rowData = value.row;
			return "<a class='btn btn-primary btn-border tuiGrid-toolbar-button' style='padding: 2px 19px;background-color: #566284;border-color: #566284;'"  
			+ " href=\"javascript:DB010.openFilePopup('"+ rowData.OVER_DRWBAK_PRESENTN_NO +"');\" title=\"클릭하여 첨부파일을 확인 할 수 있습니다.\">" + "파일관리" + '</a>';
			
		}
		
		
		
		
		this.openDetail = function(){
			var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB010_List");
			if(rowData.length == 0){
				alert("선택된 데이터가 없습니다.");
				return;
			}
			if(rowData.length > 1){
				alert("1개의 데이터만 선택할 수 있습니다.");
				return;
			}
			var selectedRowKey = rowData[0].rowKey;
			DB010.openDetailPage(selectedRowKey);
		}
		
		/** 상세페이지 호출 */
		this.openDetailPage = function(rowKey){
			if(rowKey == null){
				rowKey = 0;
			}
			var rowData = KpackageOBJ.tuiGrid.getRowValues("oTui_DB010_List", rowKey);

			var getParams = "?DIALOG_ID="       		+ "dialog_DB01001"
					        + "&PGMID="         		+  "DB01001"
					        + "&P_OVER_DRWBAK_PRESENTN_NO="     +  rowData.OVER_DRWBAK_PRESENTN_NO
					        + "&P_PRE_REGIST_RCEPT_NO="     +  rowData.PRE_REGIST_RCEPT_NO
					        + "&P_OVER_REGIST_RCEPT_NO="     +  rowData.OVER_REGIST_RCEPT_NO
					        ;
			
			KpackageOBJ.dialog.open("dialog_DB01001", "가산금액 지급신청서 작성", "/db-01001" + getParams, 1200, 840);
			
		}
		
	
		this.sendInterface = function(){
		    var valid_UnipassStatus = false;
			var docWriteStatus = false;
			var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB010_List");
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
            
            KpackageOBJ.ajax.doSubmit("/drawbackDoc/createXml_Adamt", rowData, DB010.sendInterface_callback);
		}
		
		this.sendInterface_callback = function(result){
		    var data = result.value;

            if (data.length > 0) {
                KPMGUnipassObj.TransferDoc_Create(); //TransferDoc 객체 생성

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

                KpackageOBJ.ajax.doSubmit("/drawbackDoc/updateAdamtSubmitStatus", data, DB010.updateAdamtSubmitStatus_callback);

            } else {
                alert("생성된 XML 데이터를 확인할 수 없습니다.");
                return;
            }
		}
		
		this.updateAdamtSubmitStatus_callback = function(result){
			if(result.success){
				alert(result.message);
			}else{
			    DB010.unipassSendResult(result.message);
			}
			DB010.retrieve_DB010List();
			
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
            
            DB010.retrieve_DB010List();
		}
		
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
			+ " href=\"javascript:DB010.transStatusDetail('"+rowData["PRESENTN_NO"]+"');\" title=\"상세내용 확인하려면 클릭하세요\">" + buttonText + '</a>';	
		}
		
		this.transStatusDetail = function() {
			KpackageOBJ.tuiGrid.uncheckAll("oTui_DB010_List");
			KpackageOBJ.tuiGrid.check("oTui_DB010_List",KpackageOBJ.tuiGrid.getSelectedRowKey("oTui_DB010_List"));
			DB010.unipassStatusPopup();
		}
		
		this.unipassStatusPopup = function() {
            var rowDatas = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB010_List");

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

            var getParams = "?DIALOG_ID=" + "dialog_unipassStatusPopup" + "&PGMID=" + "unipassStatusPopup" + "&FORM_ID=" + "unipassStatusPopup" + "&EXECUT_STATUS=" + rowData.EXECUT_STATUS + "&SUBMIT_NO=" + rowData.SUBMIT_NO + "&PRESENTN_NO=" + rowData.OVER_DRWBAK_PRESENTN_NO;
            
            if(rowData.OVER_REGIST_RCEPT_NO !== undefined){
				getParams += "&REGIST_RCEPT_NO=" + rowData.REGIST_RCEPT_NO;
			}

            KpackageOBJ.dialog.open("dialog_unipassStatusPopup", "유니패스 전송상태", "/drawbackDoc/unipassStatusPopup" + getParams, 1000, 700);
        }		
	}
	
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB010.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		DB010.renderTuiGrid();
	});
	
	
</script>
</body>
</html>