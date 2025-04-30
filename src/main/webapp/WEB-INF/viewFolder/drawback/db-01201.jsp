<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
/******************************************************************************************************
	Program Name : 조견표 상세
	Program Code : db-01201
******************************************************************************************************/
%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<div id="content">
	<section class="widget-body">
		<form:form id="DB01201-form" class="s4-form" novalidate="novalidate" onsubmit="return false;">
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 10px;margin-top: 15px;">
					<div class="table-responsive of-hidden">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:180px;" />
								<col style="width: " />
								<col style="width:150px;" />
								<col style="width: ;" />
							</colgroup>
							<tbody>
								<tr>
									<th>내부관리번호</th>
									<td colspan="3">
										<input type="text" id="PRESENTN_NO" name="PRESENTN_NO" class="inputText ov_readonly" value="${reqParam.PRESENTN_NO}" style="background-color: #e6e6e6;" readonly="readonly"/>
									</td>
								</tr>		
								<tr>
									<th>제출번호</th>
									<td>
										<input type="text" id="REGIST_RCEPT_NO" name="REGIST_RCEPT_NO" class="inputText ov_readonly" style="background-color: #e6e6e6;" readonly="readonly"/>
									</td>
									<th>제출일자</th>
									<td>
										<input type="text" id="REGIST_RCEPT_DATE" name="REGIST_RCEPT_DATE" class="inputText ov_readonly" style="background-color: #e6e6e6;" readonly="readonly"/>
									</td>
								</tr>				
								<tr>
									<th>환급심사요구자료문서번호</th>
									<td>
										<input type="text" id="JUDGE_REQ_DOC_NO" name="JUDGE_REQ_DOC_NO" class="inputText" />
									</td>
									<th>요구자료문서_행번호</th>
									<td>
										<input type="text" id="JUDGE_REQ_DOC_SEQ" name="JUDGE_REQ_DOC_SEQ" class="inputText" />
									</td>
								</tr>						
								<tr>
									<th>신고대행관세사번호</th>
									<td>
										<input type="text" id="CSTBRKR_AGENCY" name="CSTBRKR_AGENCY" class="inputText"/>
									</td>
									<th>통관번호</th>
									<td>
										<input type="text" id="ECTMRK" name="ECTMRK" class="inputText ov_readonly" style="background-color: #e6e6e6;" readonly="readonly"/>
									</td>
								</tr>
								<tr>
									<th>서식구분</th>
									<td colspan="3">
										<select id="JUDGE_REQ_DOC_TYPE"  name="JUDGE_REQ_DOC_TYPE" class="form-control searchSelect"  style="width:120px" onchange="DB01201.onChagngeEvent();">
									</td>
								</tr>								
								<tr>
									<th>환급/기납 접수번호</th>
									<td colspan="3">
										<input type="text" id="REL_REGIST_RCEPT_NO" name="REL_REGIST_RCEPT_NO" class="inputText" />
										<button id="BTN_SEARCH" name="BTN_SEARCH" style="width:100px;" class="btn btn btn-primary" onclick="DB01201.retrieve_DB01201RegistRceptList();"><i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' /></button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row" style="margin-top:10px;">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div id="div_oTui_DB01201_List" name="div_oTui_DB01201_List" class="tuigrid-resizable">
						<div id="oTui_DB01201_List" data-minus-height="800"></div>
					</div>
				</div>
			</div>
			<div class="row" style="margin-top:10px;">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div id="div_oTui_DB01201_MaterialList" name="div_oTui_DB01201_MaterialList" class="tuigrid-resizable">
						<div id="oTui_DB01201_MaterialList" data-minus-height="800"></div>
					</div>
				</div>
			</div>
		</form:form>
	</section>
</div>

<script type="text/javascript">


	var DB01201 = new function() {
		this.DIALOG_ID = "${reqParam.DIALOG_ID}";
		this.PRESENTN_NO = "${reqParam.PRESENTN_NO}";
		
		this.SAVE_REL_REGIST_RCEPT_NO = "";
		
		this.initialize_viewObject = function(){

			KpackageOBJ.selectbox.create("DB01201-form", "JUDGE_REQ_DOC_TYPE", "/common/retrieveComCdList", {"CATEGORY_CD":"DOCTY","OPTION_ALL":"Y"}, "CODE", "NAME");

			//상세일경우 데이터 조회
			if(!oUtil.isNull(DB01201.PRESENTN_NO)){
				DB01201.retrieve_DB01201DetailList();
			}
		}
		
		this.initialize_TuiGrid = function(){
			 var colArrayInfo = [
				 	{ header : "CHECK_FLAG"			,name : "CHECK_FLAG"				,width : 450, align: "center" ,hidden:true},			
					{ header : "회사코드"				,name : "COMPANY_CODE"				,width : 100, align: "center" ,hidden:true},
					{ header : "플랜트코드"				,name : "DIVISION_CODE"				,width : 100, align: "center" ,hidden:true},
					{ header : "내부관리번호"				,name : "PARENT_PRESENTN_NO"		,width : 100, align: "center" ,hidden:true},
					{ header : "등록(접수)번호" 			,name : "REGIST_RCEPT_NO"			,width : 100, align: "center" ,hidden:true},
					{ header : "순번"					,name : "THNG_SEQ"					,width : 100, align: "center" ,hidden:true},
					{ header : "자재코드"				,name : "PRODUCT_CODE"				,width : 100, align: "center" ,hidden:false},
					{ header : "자재명"					,name : "PRODUCT_NAME"				,width : 350, align: "left"   ,hidden:false},				
					{ header : "신고(증명)번호"			,name : "REF_NO"					,width : 150, align: "center" ,hidden:false},				
					{ header : "신고(증명)번호 란번호"		,name : "REF_LNE_NO"				,width : 150, align: "center" ,hidden:false},				
					{ header : "신고(증명)번호 규격번호"	,name : "REF_POUCH_NO"				,width : 150, align: "center" ,hidden:false}				
					
			];
			 
			KpackageOBJ.tuiGrid.create("oTui_DB01201_List", "/drawback/retrieve_DB01201RegistRceptList", colArrayInfo, 'checkbox', DB01201.oTui_DB01201_List_onClick_Handler, null);
			KpackageOBJ.tuiGrid.setCaption("oTui_DB01201_List","<spring:message code='관련자재내역'/>");
			
			
			 var colArrayInfo2 = [
					{ header : "원재료코드"		,name : "RAWMTRL_CODE"			,width : 100, align: "center" ,hidden:false },
					{ header : "원재료명"		,name : "RAWMTRL_NAME"			,width : 350, align: "left"   ,hidden:false },
					{ header : "원재료구분"		,name : "RAWMTRL_SE"			,width : 100, align: "center" ,hidden:false },
					{ header : "수입신고번호"		,name : "IMPDEC_NO"				,width : 150, align: "center" ,hidden:false },
					{ header : "란번호"			,name : "LNE_NO"				,width : 100, align: "center" ,hidden:false },
					{ header : "행번호"			,name : "POUCH_NO"				,width : 100, align: "center" ,hidden:false },
					{ header : "수리일자"		,name : "ACPT_DATE"				,width : 150, align: "center" ,hidden:false,  formatter: KpackageOBJ.tuiGrid.dateFormatter},
					{ header : "사용량"			,name : "USGQTY"				,width : 100, align: "right"  ,hidden:false , formatter: KpackageOBJ.tuiGrid.commas},
					{ header : "사용량 단위"		,name : "BASS_UNIT"				,width : 100, align: "center" ,hidden:false},
					{ header : "관세"			,name : "CSTMS"					,width : 100, align: "right"  ,hidden:false }
			];
			
			KpackageOBJ.tuiGrid.create("oTui_DB01201_MaterialList", "/drawback/retrieve_DB01201RegistRcepMaterialtList", colArrayInfo2, 'number', null, null);
			KpackageOBJ.tuiGrid.setCaption("oTui_DB01201_MaterialList","<spring:message code='원재료 상세내역'/>");
		
		};
		
		this.oTui_DB01201_List_onClick_Handler = function(p_GridId, p_RowKey, p_ColName){
			if(p_ColName == "_button"){
				return false;
			}
			
			DB01201.retrieve_DB01201RegistRcepMaterialtList(p_RowKey);
		}
		
		/*상세정보 조회*/
		this.retrieve_DB01201DetailList = function(){
			var params = KpackageOBJ.data.makePostData("DB01201-form");  
			
			KpackageOBJ.ajax.doSubmit("/drawback/retrieve_DB01201DetailList", params, "DB01201.retrieve_DB01201DetailListCallBack");	
		}
		
		this.retrieve_DB01201DetailListCallBack = function(result){
			var data = result.value;
			
			KpackageOBJ.object.setFormValue("DB01201-form","PRESENTN_NO",data["PRESENTN_NO"]);
			KpackageOBJ.object.setFormValue("DB01201-form","REGIST_RCEPT_NO",data["REGIST_RCEPT_NO"]);
			KpackageOBJ.object.setFormValue("DB01201-form","REGIST_RCEPT_DATE",data["REGIST_RCEPT_DATE"]);
			KpackageOBJ.object.setFormValue("DB01201-form","JUDGE_REQ_DOC_NO",data["JUDGE_REQ_DOC_NO"]);
			KpackageOBJ.object.setFormValue("DB01201-form","JUDGE_REQ_DOC_SEQ",data["JUDGE_REQ_DOC_SEQ"]);
			KpackageOBJ.object.setFormValue("DB01201-form","CSTBRKR_AGENCY",data["CSTBRKR_AGENCY"]);
			KpackageOBJ.object.setFormValue("DB01201-form","REL_REGIST_RCEPT_NO",data["REL_REGIST_RCEPT_NO"]);
			KpackageOBJ.object.setFormValue("DB01201-form","JUDGE_REQ_DOC_TYPE",data["JUDGE_REQ_DOC_TYPE"]);
			KpackageOBJ.object.setFormValue("DB01201-form","ECTMRK",data["ECTMRK"]);
			DB01201.retrieve_DB01201RegistRceptList();
		}
		
		/*관련접수번호 리스트 조회*/
		this.retrieve_DB01201RegistRceptList = function(){
			var params = KpackageOBJ.data.makePostData("DB01201-form");  
			
			/*validation Check*/
			if(oUtil.isNull(params["JUDGE_REQ_DOC_TYPE"])){
				alert("서식구분을 선택해주세요.");
				return false;
			}

			if(oUtil.isNull(params["REL_REGIST_RCEPT_NO"])){
				alert("등록(접수)번호를 입력해주세요");
				return false;
			}
			// 조회후 값이 변경되는 경우 원래값을 저장하기 위함
			DB01201.SAVE_REL_REGIST_RCEPT_NO = params["REL_REGIST_RCEPT_NO"];
			KpackageOBJ.tuiGrid.retrieveWithCallBack("oTui_DB01201_List", "/drawback/retrieve_DB01201RegistRceptList", params,"", "DB01201.retrieve_DB01201RegistRceptListCallBack");
		}
		
		this.retrieve_DB01201RegistRceptListCallBack = function(){
			var gridData = KpackageOBJ.tuiGrid.getRowsData( "oTui_DB01201_List");
			
			for(var i =0; i < gridData.length; i++){
				if(gridData[i]["CHECK_FLAG"] == "1"){
					KpackageOBJ.tuiGrid.check( "oTui_DB01201_List", i );
				}
			}
		}
		
		/*원재료 리스트 조회*/
		this.retrieve_DB01201RegistRcepMaterialtList = function(rowKey){
			var params = KpackageOBJ.tuiGrid.getRowValues("oTui_DB01201_List", rowKey);
			params["JUDGE_REQ_DOC_TYPE"] = KpackageOBJ.object.getFormValue("DB01201-form","JUDGE_REQ_DOC_TYPE");  
			KpackageOBJ.tuiGrid.retrieve("oTui_DB01201_MaterialList", "/drawback/retrieve_DB01201RegistRcepMaterialtList", params);
		}
		
		/** 저장*/
		this.update_DB01201DetailList = function(){
			var params = KpackageOBJ.data.makePostData("DB01201-form");  
			var itemList = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB01201_List");

			
			if(oUtil.isNull(params["REL_REGIST_RCEPT_NO"])){
				alert("관련접수번호를 입력해주세요");
				return false;
			}
			
			if(itemList.length <= 0){
				alert("관련접수내용을 선택해주세요");
				return false;
			}
			
			params["ITEM_LIST"] = itemList;
			params["REL_REGIST_RCEPT_NO"] = DB01201.SAVE_REL_REGIST_RCEPT_NO;
			KpackageOBJ.ajax.doSubmit("/drawback/update_DB01201DetailList", params, "DB01201.update_DB01201DetailListCallBack");	
		}
		
		this.update_DB01201DetailListCallBack = function(){
			alert("저장되었습니다.");       
			DB012.retrieve_DB012List();
            KpackageOBJ.dialog.close(DB01201.DIALOG_ID);
		}
		
		this.onChagngeEvent = function(){
			KpackageOBJ.object.setFormValue("DB01201-form","REL_REGIST_RCEPT_NO","");
			KpackageOBJ.tuiGrid.clear( "oTui_DB01201_List" );
			KpackageOBJ.tuiGrid.clear( "oTui_DB01201_MaterialList" );
		}
		
	}
			
		

	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB01201.initialize_viewObject();
		DB01201.initialize_TuiGrid();

		/*dialog Button Create*/
		var tools = [	
					{icon:"", title:"Save" ,text:"저장"	,func:"DB01201.update_DB01201DetailList"}
					];
		KpackageOBJ.dialog.setButton(DB01201.DIALOG_ID, tools);
	});

</script>
	
</body>
</html>