<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	/**********************************************************************************************
	* PGM ID : DB012
	* PGM DESC : 조견표
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
	<section id="widget-grid-DB012" class="">
		<form:form id="DB012-form" class="s4-form" novalidate="novalidate" action="/db-002" method="post">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 140px;" />
								<col style="width: 28%;" />
								<col style="width: 200px;" /> 
								<col style="width: 24%;" />
								<col style="width: 100px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='작성일자' /></th>
									<td>
										<input type="text" id="CAL_SEARCH_REGIST_RCEPT_FROM_DATE"  name="CAL_SEARCH_REGIST_RCEPT_FROM_DATE" style="width:120px" class="inputText" searchfnc="DB012.retrieve_DB012List"/>
										<input type="hidden" id="SEARCH_REGIST_RCEPT_FROM_DATE"  name="SEARCH_REGIST_RCEPT_FROM_DATE" />
										<span class="fromTo-Dash">~</span>
										<input type="text" id="CAL_SEARCH_REGIST_RCEPT_TO_DATE"  name="CAL_SEARCH_REGIST_RCEPT_TO_DATE" style="width:120px" class="inputText" searchfnc="DB012.retrieve_DB012List"/>
										<input type="hidden" id="SEARCH_REGIST_RCEPT_TO_DATE"  name="SEARCH_REGIST_RCEPT_TO_DATE" />
									</td>
									<th><spring:message code='신고증명번호(수출신고번호)' /></th>
									<td>
										<input type="text" id="SEARCH_REF_NO" name="SEARCH_REF_NO" class="inputText" />
									</td>
									<th><spring:message code='제품코드' /></th>
									<td>
										<input type="text" id="SEARCH_PRODUCT_CODE" name="SEARCH_PRODUCT_CODE" class="inputText" />
									</td>
								</tr>
								<tr>
									<th><spring:message code='환급/기납 접수번호' /></th>
									<td>
										<input type="text" id="SEARCH_REL_REGIST_RCEPT_NO" name="SEARCH_REL_REGIST_RCEPT_NO" class="inputText" />
									</td>
									<th><spring:message code='문서구분' /></th>
									<td>
										<select id="SEARCH_JUDGE_REQ_DOC_TYPE"  name="SEARCH_JUDGE_REQ_DOC_TYPE" class="form-control searchSelect"  style="width:120px">
									</td>
									<th><spring:message code='전송상태' /></th>
									<td>
										<select id="EXECUT_STATUS"  name="EXECUT_STATUS" class="form-control searchSelect"  style="width:120px">
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-2" type="button" onclick="javascript:DB012.retrieve_DB012List();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_DB012_List" name="div_oTui_DB012_List" class="tuigrid-resizable">
					<div id="oTui_DB012_List" data-minus-height="345"></div>
					<div id="oTui_DB012_List_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<div id="UNPS_RESULT_LAYER" title="수신 결과" style="display: none; overflow: hidden;">
		<fieldset style="padding: 0px;">
			<section>
				<textarea id="UNPS_RESULT" rows="" cols="" style="height: 500px; width: 95%; margin-left: 18px; margin-top: 10px;" readonly="readonly"></textarea>
			</section>
		</fieldset>
	</div>

<script>
	
	var DB012 = new function(){
		
		
		
		this.Initialize_viewObject = function() {
			
			var fromDay = KpackageOBJ.date.getCurrMonth() + "01";
			var toDay = KpackageOBJ.date.getCurrMonth() + KpackageOBJ.date.lastDay(KpackageOBJ.date.getCurrMonth());
			
			
			KpackageOBJ.calendar.create("DB012-form", "CAL_SEARCH_REGIST_RCEPT_FROM_DATE");
			KpackageOBJ.calendar.setValue("DB012-form","CAL_SEARCH_REGIST_RCEPT_FROM_DATE", fromDay);
			KpackageOBJ.object.setFormValue("DB012-form","SEARCH_REGIST_RCEPT_FROM_DATE", fromDay);
			
			KpackageOBJ.calendar.create("DB012-form", "CAL_SEARCH_REGIST_RCEPT_TO_DATE");
			KpackageOBJ.calendar.setValue("DB012-form","CAL_SEARCH_REGIST_RCEPT_TO_DATE", toDay);
			KpackageOBJ.object.setFormValue("DB012-form","SEARCH_REGIST_RCEPT_TO_DATE",toDay);
			
			KpackageOBJ.selectbox.create("DB012-form", "EXECUT_STATUS",  "/common/retrieveComCdList", {"CATEGORY_CD":"EXECUT_STATUS","OPTION_ALL":"Y"}, "CODE", "NAME");  
			
			KpackageOBJ.selectbox.create("DB012-form", "SEARCH_JUDGE_REQ_DOC_TYPE", "/common/retrieveComCdList", {"CATEGORY_CD":"DOCTY","OPTION_ALL":"Y"}, "CODE", "NAME");
		}
		
		this.renderTuiGrid = function() {
			 
			 var colArrayInfo = [
					{ header : "회사코드"			,name : "COMPANY_CODE"			,width : 100, align: "center" ,hidden:true },
					{ header : "DIVISION_CODE"	,name : "DIVISION_CODE"			,width : 100, align: "center" ,hidden:true },
					{ header : "STTEMNT_DOC_STLE" ,name : "STTEMNT_DOC_STLE"		,width : 100, align: "center" ,hidden:true },
					{ header : "구분"				,name : "JUDGE_REQ_DOC_TYPE"	,width : 100, align: "center" ,hidden:true },
					{ header : "관련접수번호"			,name : "REL_REGIST_RCEPT_NO"	,width : 150, align: "left" ,hidden:false },
					{ header : "내부관리번호"			,name : "PRESENTN_NO"			,width : 200, align: "center" ,hidden:false },
					{ header : "구분"				,name : "JUDGE_REQ_DOC_NAME"	,width : 130, align: "center" ,hidden:false },
					{ header : "환급심사요구자료문서번호",name : "JUDGE_REQ_DOC_NO"		,width : 200, align: "left" ,hidden:false },
					{ header : "요구자료문서_행번호"	,name : "JUDGE_REQ_DOC_SEQ"		,width : 150, align: "center" ,hidden:false },
					{ header : "제출번호"			,name : "REGIST_RCEPT_NO"		,width : 100, align: "center" ,hidden:false},				
					{ header : "제출일자"			,name : "REGIST_RCEPT_DATE"		,width : 100, align: "center" ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
					{ header : "전송상태"			,name : "VALID_CODE"			,width : 200, align: "center" ,hidden:false, formatter : DB012.transStatus_CustomFormatter}			
				];
			 
			 
			 var tools = [ {icon:"add",   title:"조견표 작성"	,text:"작성"	    	,func:"DB012.openCreatePopup"}
				          ,{icon:"add",   title:"상세"		,text:"상세"	    	,func:"DB012.openDetail"}
				          ,{icon:"add",   title:"PDF 생성"	,text:"PDF 생성"	    ,func:"DB012.printPrt01200"}
				          ,{icon : "none",header : "전송"		,text : "전송"		,func: "DB012.quickRef_Send"}
				          ,{icon:"none",  title:"수신" 				,text:"수신" ,func:"DB012.receiveUnipass"}
				          , {icon : "none",header : "상태조회",text : "상태조회",func : "DB012.unipassStatusPopup"}
				];
			 KpackageOBJ.tuiGrid.setButton("oTui_DB012_List", tools); // Toobar 생성

			 KpackageOBJ.tuiGrid.create("oTui_DB012_List", "/drawback/retrieve_DB012List", colArrayInfo, 'checkbox', null, DB012.oTui_DB012_List_onDblclick_Handler );
			 
		}
		
		/*Double Click Event*/
		this.oTui_DB012_List_onDblclick_Handler = function(p_GridId, p_RowKey, p_ColName){
			DB012.openDetailPopup(p_RowKey);
		}
		
		/* 작성버튼*/
		this.openCreatePopup = function(){
			var getParams = "?DIALOG_ID="       		+ "dialog_DB01201"
	        			  + "&PGMID="         		    +  "DB01201" ;	        
			KpackageOBJ.dialog.open("dialog_DB01201", "조견표 작성", "/db-01201" + getParams, 1000, 700);
		}
		
		/* 상세버튼*/
		this.openDetail = function(){
			var rowkey = KpackageOBJ.tuiGrid.getSelectedRowKey("oTui_DB012_List");
			this.openDetailPopup(rowkey);
		}
		
		/* 상세 팝업 호출*/
		this.openDetailPopup = function(rowKey){
			var rowData = KpackageOBJ.tuiGrid.getRowValues("oTui_DB012_List", rowKey);
			
			var getParams = "?DIALOG_ID="       		+ "dialog_DB01201"
					      + "&PGMID="         		    +  "DB01201" 
					      + "&PRESENTN_NO="             + rowData["PRESENTN_NO"];	        
			
			
			KpackageOBJ.dialog.open("dialog_DB01201", "조견표", "/db-01201" + getParams, 1000, 700);
		}
		
		/* 조회버튼 */
		this.retrieve_DB012List = function() {
			var param = KpackageOBJ.data.makePostData("DB012-form");
			console.log(param); 
			
			KpackageOBJ.tuiGrid.retrieve("oTui_DB012_List", "", param);
		}
		
		this.printPrt01200 = function(result){
	    	var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB012_List");
			var getParams = ""    ;   
	    	
			if(rowData.length == 0){
	        	alert("선택된 데이터가 없습니다.");
	            return;
	        }
	       
	    	
	    	if(rowData.length > 1){
	        	alert("1개의 데이터만 선택할 수 있습니다.");
	           	return;
	        }
	 
	    	
	    	if(rowData[0].JUDGE_REQ_DOC_TYPE =="10"){   //환급신청서
		    	getParams = "?DIALOG_ID="                     + "dialog_previewDocumentPage"
			                + "&PGMID="                    + "previewDocumentPage"
			                + "&FORM_ID="                  + "prt01200"
			                + "&FORM_YYYYMMDD="            + KpackageOBJ.date.getCurrDay()
			                + "&KEY_PARAM1="               + rowData[0].DIVISION_CODE
			                + "&KEY_PARAM2="               + rowData[0].PRESENTN_NO
			                + "&KEY_PARAM3="               + rowData[0].REL_REGIST_RCEPT_NO
			            ;
	    		
	    	}else{  //기납증
		    	getParams = "?DIALOG_ID="                     + "dialog_previewDocumentPage"
			                + "&PGMID="                    + "previewDocumentPage"
			                + "&FORM_ID="                  + "prt01201"
			                + "&FORM_YYYYMMDD="            + KpackageOBJ.date.getCurrDay()
			                + "&KEY_PARAM1="               + rowData[0].DIVISION_CODE
			                + "&KEY_PARAM2="               + rowData[0].PRESENTN_NO
			                + "&KEY_PARAM3="               + rowData[0].REL_REGIST_RCEPT_NO
			            ;
			}
	    	

	       KpackageOBJ.dialog.open("dialog_PreviewDocumentPage", "출력", "/viewPreviewDocumentPage" + getParams, 1000, 700);      
		}
		
		this.quickRef_Send = function() {
            
            var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB012_List");

            if (rowData.length == 0) {
                alert("선택된 데이터가 없습니다.");
                return;
            }

           /*  for (var inx = 0; inx < rowData.length; inx++) {
                if ("10" == rowData[inx]["UNIPASS_STATUS"]) {
                    alert("상태가 접수상태일 경우 재송신 할 수 없습니다.");
                    return;
                }
            } */

            KpackageOBJ.ajax.doSubmit("/drawbackDoc/createXml_quickRef", rowData, DB012.SendUnipassQuickRef_callback);
        }
		
		this.SendUnipassQuickRef_callback = function(result) {
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

                KpackageOBJ.ajax.doSubmit("/drawbackDoc/updateQuickRefStatus", data, DB012.updateQuickRefStatus_callback);

            } else {
                alert("생성된 XML 데이터를 확인할 수 없습니다.");
                return;
            }

        }

        this.updateQuickRefStatus_callback = function(result) {
            if (result.success) {
                alert(result.message);
            } else {
                DB012.unipassSendResult(result.message);
            }

            DB012.retrieve_DB012List();

        }

        this.unipassSendResult = function(resultMsg) {
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
			+ " href=\"javascript:DB012.transStatusDetail('"+rowData["PRESENTN_NO"]+"');\" title=\"상세내용 확인하려면 클릭하세요\">" + buttonText + '</a>';	
		}
		
		this.transStatusDetail = function() {
			KpackageOBJ.tuiGrid.uncheckAll("oTui_DB012_List");
			KpackageOBJ.tuiGrid.check("oTui_DB012_List",KpackageOBJ.tuiGrid.getSelectedRowKey("oTui_DB012_List"));
			DB012.unipassStatusPopup();
		}
		
		this.unipassStatusPopup = function() {
            var rowDatas = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB012_List");

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

            var getParams = "?DIALOG_ID=" + "dialog_unipassStatusPopup" + "&PGMID=" + "unipassStatusPopup" + "&FORM_ID=" + "unipassStatusPopup" + "&EXECUT_STATUS=" + rowData.EXECUT_STATUS + "&SUBMIT_NO=" + rowData.SUBMIT_NO + "&PRESENTN_NO=" + rowData.PRESENTN_NO;
            
            if(rowData.REGIST_RCEPT_NO !== undefined){
				getParams += "&REGIST_RCEPT_NO=" + rowData.REGIST_RCEPT_NO;
			}

            KpackageOBJ.dialog.open("dialog_unipassStatusPopup", "유니패스 전송상태", "/drawbackDoc/unipassStatusPopup" + getParams, 1000, 700);
        }
		
	}
	
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB012.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		DB012.renderTuiGrid();
		DB012.retrieve_DB012List();
	});
	
	
</script>
</body>
</html>