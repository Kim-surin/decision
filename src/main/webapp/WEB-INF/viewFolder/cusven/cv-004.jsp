\<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	/**********************************************************************************************
	* PGM ID : CV004
	* PGM DESC : 양수자통보
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
	<section id="widget-grid" class="">
		<form id="CV004-search-form" class="s4-form" novalidate="novalidate" action="/cv-004" method="post">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;" />
								<col style="width: 25%;" />
								<col style="width: 100px;" />
								<col style="width: 15%;" />
								<col style="width: 80px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='양도일자' /></th>
									<td>
										<input type="text" id="CAL_SEARCH_FROM_DATE"  name="CAL_SEARCH_FROM_DATE" style="width:120px" class="inputText" searchfnc="CV004.retrieve_gridData"/>
										<input type="hidden" id="SEARCH_FROM_DATE"  name="SEARCH_FROM_DATE" style="width:120px" class="inputText"/>
                                        <span class="fromTo-Dash">~</span>
										<input type="text" id="CAL_SEARCH_TO_DATE"  name="CAL_SEARCH_TO_DATE" style="width:120px" class="inputText" searchfnc="CV004.retrieve_gridData"/>
										<input type="hidden" id="SEARCH_TO_DATE"  name="SEARCH_TO_DATE" style="width:120px" class="inputText"/>
									</td>
									<th><spring:message code='재증명구분' /></th>
									<td>
										<select class="form-control searchSelect" id="ISSUE_TYPE" name="ISSUE_TYPE" style="width:110px"></select>
									</td>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:80px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:80px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="CV004.retrieve_gridData"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:CV004.retrieve_gridData();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_CV004_grid_01" name="div_oTui_CV004_grid_01" class="tuigrid-resizable">
					<div id="oTui_CV004_grid_01" data-minus-height="310"></div>
					<div id="oTui_CV004_grid_01_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>

	var CV004 = new function(){
		
		// Page Object Initialize
		this.initialize_Object = function() {
			
			var fromDay = KpackageOBJ.date.getCurrMonth() + "01";
			var toDay = KpackageOBJ.date.getCurrDay();
			
			KpackageOBJ.calendar.create("CV004-search-form", "CAL_SEARCH_FROM_DATE");
			KpackageOBJ.calendar.setValue("CV004-search-form","CAL_SEARCH_FROM_DATE", fromDay);
			KpackageOBJ.object.setFormValue("CV004-search-form","SEARCH_FROM_DATE", fromDay);
			
			KpackageOBJ.calendar.create("CV004-search-form", "CAL_SEARCH_TO_DATE");
			KpackageOBJ.calendar.setValue("CV004-search-form","CAL_SEARCH_TO_DATE", toDay);
			KpackageOBJ.object.setFormValue("CV004-search-form","SEARCH_TO_DATE", toDay);
	
			/*Search Type Select Box Create */
			/*
				"00":수입신고필증,"02" : 기납증,"03" : 평세증,"04" : 분증,"05" : 부산물
			*/
			arrayItem = [{value:"04", name:"<spring:message code='분증'/>"}
					     ,{value:"02", name:"<spring:message code='기납증'/>"}
						];
			
			KpackageOBJ.selectbox.create("CV004-search-form", "ISSUE_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"REGIST_RCEPT_NO", name:"<spring:message code='접수번호'/>"}
						,{value:"RAWMTRL_CODE", name:"<spring:message code='원재료 코드'/>"}
						,{value:"ITEM_NAME", name:"<spring:message code='원재료 명'/>"}
						];
			
			KpackageOBJ.selectbox.create("CV004-search-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			            ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("CV004-search-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
		}
		
		this.initialize_TuiGrid = function(){ 
         
			 var colArrayInfo = [
				 {"header" :'회사코드',		name:'COMPANY_CODE',		width:100,			align:'center',		hidden:true},
				 {"header" :'플랜트 코드',		name:'DIVISION_CODE',		width:100,			align:'center',		hidden:true},
				 {"header" :'구분',			name:'ISSUE_TYPE_NAME',		width:100,			align:'center',		hidden:false},
				 {"header" :'접수번호',		name:'REGIST_RCEPT_NO',		width:100,			align:'center',		hidden:false},
				 {"header" :'제출번호',		name:'SUBMIT_NO',			width:100,			align:'center',		hidden:false},
				 {"header" :'통보구분',		name:'RECV_DOC_TYPE_NAME',	width:100,			align:'center',		hidden:false},
				 {"header" :'통보구분',		name:'RECV_DOC_TYPE',		width:100,			align:'center',		hidden:true},
				 {"header" :'양도일자',		name:'CHIT_FRMTRM_DATE',	width:100,			align:'center',		hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
				 {"header" :'양도자 상호',		name:'FROM_COMPANY_NAME',	width:100,			align:'center',		hidden:false},
				 {"header" :'양도자 통관고유부호',name:'FROM_ECTMRK',			width:130,			align:'center',		hidden:false},
				 {"header" :'양도 세액',		name:'TOT_TAX',				width:100,			align:'right',		hidden:false , "formatter" : KpackageOBJ.tuiGrid.commas },
				 {"header" :'HS CODE',		name:'HS_CODE',				width:100,			align:'center',		hidden:false, "formatter" : KpackageOBJ.tuiGrid.hscode10 },
				 {"header" :'구분코드',		name:'ISSUE_TYPE',			width:100,			align:'center',		hidden:true},
				 {"header" :'공급가격',		name:'STTEMNT_PC_KRW',		width:140,			align:'right',		hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas },
				 {"header" :'공급물량',		name:'ACCMLT_ORDER_QY',		width:140,			align:'right',		hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas },
				 {"header" :'단위',			name:'BASS_UNIT',			width:100,			align:'center',		hidden:false}
			    ];
			 var tools = [ 
							{icon:"none", title:"수신" 	,text:"수신" ,func:"CV004.receiveUnipass"}
			 ];
			 KpackageOBJ.tuiGrid.setButton("oTui_CV004_grid_01", tools); // Toobar 생성
			 KpackageOBJ.tuiGrid.create("oTui_CV004_grid_01", "/cusven/retrieveCV004Grid", colArrayInfo, 'number', null, CV004.onDblClick_oTui_CV004_grid_01);
			 
		}  
		  
		this.onDblClick_oTui_CV004_grid_01 = function(gridId, rowkey, colName){
			var rowData = KpackageOBJ.tuiGrid.getSelectedRowlValue(gridId, rowkey);
			var param = {	"COMPANY_CODE":rowData.COMPANY_CODE
							,"DIVISION_CODE":rowData.DIVISION_CODE
							,"ISSUE_TYPE":rowData.ISSUE_TYPE
							,"REGIST_RCEPT_NO":rowData.REGIST_RCEPT_NO
							,"SUBMIT_NO":rowData.SUBMIT_NO
							,"INPUT_FLAG":"U"	
						}
			var params = makeStringParameter(param, true);
			KpackageOBJ.dialog.open("CV004_Dtl", "양수자통보 상세", "/cv-00401?"+params, 1210, KpackageOBJ.prototype.pop_M_Height);
		};
		  
		this.retrieve_gridData = function() {
			
			var param = { "SEARCH_FROM_DATE" : KpackageOBJ.object.getFormValue("CV004-search-form", "SEARCH_FROM_DATE")
					 	 ,"SEARCH_TO_DATE" : KpackageOBJ.object.getFormValue("CV004-search-form","SEARCH_TO_DATE")
					 	 ,"ISSUE_TYPE" : KpackageOBJ.object.getFormValue("CV004-search-form","ISSUE_TYPE")
					 	 ,"SEARCH_TYPE" : KpackageOBJ.object.getFormValue("CV004-search-form","SEARCH_TYPE")
					 	 ,"SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("CV004-search-form", "SEARCH_KEY_WORD")
			         	 ,"SEARCH_OPTION" : KpackageOBJ.object.getFormValue("CV004-search-form","SEARCH_OPTION")
						};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_CV004_grid_01", "/cusven/retrieveCV004Grid", param);
		};
		
		
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
            
            CV004.retrieve_gridData();
		}
		
	} 
	
	$(document).ready(function() {
		
		pageSetUp();				// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		CV004.initialize_Object(); 		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		CV004.initialize_TuiGrid();		 
	});

</script>
</body>
</html>