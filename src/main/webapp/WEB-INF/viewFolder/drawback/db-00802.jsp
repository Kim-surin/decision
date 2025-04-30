<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
/******************************************************************************************************
	Program Name : 환급신청서 상세조회
	Program Code : DB00802
******************************************************************************************************/
%>
<!DOCTYPE html>
<html>
<head>

	
	
	
	
</head>
<body>
<div id="content">
	<section id="widget-grid-DB00802" class="">
		<form:form id="DB00802-form" class="s4-form" novalidate="novalidate" onsubmit="return false;">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<input type="hidden" id="P_PRESENTN_NO" name="P_PRESENTN_NO" value="${reqParam.PRESENTN_NO }"/>
			<input type="hidden" id="P_ISSUE_TYPE" name="P_ISSUE_TYPE" value="${reqParam.ISSUE_TYPE }"/>
			<input type="hidden" id="P_DIVISION_CODE" name="P_DIVISION_CODE" value="${reqParam.DIVISION_CODE }"/>
			<input type="hidden" id="P_COMPANY_CODE" name="P_COMPANY_CODE" value="${reqParam.COMPANY_CODE }"/>
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div class="table-responsive of-hidden">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:150px;" />
								<col style="width: " />
								<col style="width:120px;" />
								<col style="width: ;" />
								<col style="width:120px;" />
								<col style="width: ;" />
								
							</colgroup>
							<tbody>
								<tr>
									<th>제출번호</th>
									<td>
										<span id="PRESENTN_NO"></span>
									</td>
									<th>등록(접수)번호</th>
									<td colspan="3">
										<span id="REGIST_RCEPT_NO"></span>
									</td>
								</tr>
								<tr>
									<th>고객사</th>
									<td>
										<span id="CSTMR_NM_1"></span>
									</td>
									<th>발급구분</th>
									<td>
										<span id="ISSUE_TYPE_NAME"></span>
									</td>
									<th>양도일자</th>
									<td>
										<span id="CHIT_FRMTRM_DATE"></span>
									</td>
								</tr>
								<tr>
									<th>고객 사업자등록번호</th>
									<td>
										<span id="CSTMR_BIZRNO"></span>
									</td>
									<th>고객사 전화번호</th>
									<td>
										<span id="CSTMR_TELNO"></span>
									</td>
									<th>국가코드</th>
									<td>
										<span id="NATION_CODE"></span>
									</td>
								</tr>
								<tr>
									<th>환급금액</th>
									<td colspan="5">
										<span id="DRWBAK_AMOUNT"></span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</form:form>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<p class="alert alert-info mb0">분할 증명서 아이템</p></div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_DB00802_01" name="div_oTui_DB00802_01" class="tuigrid-resizable">
					<div id="oTui_DB00802_01" data-fixed-height="350"></div>
					<div id="oTui_DB00802_01_paging"></div>
				</div>
			</div>
			
		</div>
	</section>
</div>

<script type="text/javascript">


	var oTui_DB00802_01;
	var DB00802 = new function() {
		this.initialize_viewObject = function(){
			
		}
		
		this.initialize_TuiGrid = function(){
			
			// 수출내역 정보 Grid
			var colArrayInfo = [
				
			    
				{ "name" :"BASIS_DOC_NO",   	"header" : "근거서류번호",   	"align" :"center"    ,"width" : 120,"hidden" : false}, 
			    { "name" :"SUPT_DOC_ITEM_SEQ",  "header" : "순번", 			  	"align" :"center"    ,"width" : 30,"hidden" : false},
			    { "name" :"ITEM_CODE",      	"header" : "제품코드",       	"align" :"left"      ,"width" : 150,"hidden" : false},
			    { "name" :"ITEM_NM",      		"header" : "제품명",       	    "align" :"left"      ,"width" : 200,"hidden" : false},
			    { "name" :"CHIT_FRMTRM_DATE",   "header" : "양도일자",   	    "align" :"center"    ,"width" : 100,"hidden" : false, formatter : KpackageOBJ.tuiGrid.dateFormatter},
			    { "name" :"ACCMLT_ORDER_QY",    "header" : "수량",               "align" :"right"     ,"width" : 100,"hidden" : false, formatter : KpackageOBJ.tuiGrid.commas}, 
			    { "name" :"BASS_UNIT",          "header" : "단위",           	"align" :"center"    ,"width" : 60,"hidden" : false}, 
			    { "name" :"STTEMNT_PC_KRW",     "header" : "판매금액",       	"align" :"right"     ,"width" : 100,"hidden" : false, formatter : KpackageOBJ.tuiGrid.commas}, 

			    
			    
			    { "name" :"LNE_NO",             "header" : "PRESENTN_NO",       "align" :"center"    ,"width" : 100,"hidden" : true},
                { "name" :"POUCH_NO",           "header" : "PRESENTN_NO",       "align" :"center"    ,"width" : 100,"hidden" : true},
                { "name" :"IMPDEC_NO",          "header" : "PRESENTN_NO",       "align" :"center"    ,"width" : 100,"hidden" : true},
			    { "name" :"PRESENTN_NO",        "header" : "PRESENTN_NO",       "align" :"center"    ,"width" : 100,"hidden" : true},
			    { "name" :"SEQ",           		"header" : "SEQ",               "align" :"center"    ,"width" : 100,"hidden" : true},
			    { "name" :"COMPANY_CODE",       "header" : "COMPANY_CODE",      "align" :"center"    ,"width" : 100,"hidden" : true},
			    { "name" :"DIVISION_CODE",      "header" : "DIVISION_CODE",     "align" :"center"    ,"width" : 100,"hidden" : true}
		    ];
			  
			KpackageOBJ.tuiGrid.setCaption("oTui_DB00802_01","매출내역");
            var tools = [ 
                {icon:"print", title:"환급신청취소"                ,text:"확정취소"                ,func:"DB00802.cancelConfirmProcess"}
            ];
			oTui_DB00802_01 = KpackageOBJ.tuiGrid.create("oTui_DB00802_01","/drawback/retrieve_DB00802_trget", colArrayInfo, "number", null, null);
	    	
		};
		
		
		<% // 해더정보 조회 %>
		this.retrieve_Header_Information = function(){
			var params = { "P_PRESENTN_NO"   : KpackageOBJ.object.getFormValue("DB00802-form","P_PRESENTN_NO")
					      ,"P_COMPANY_CODE"  : KpackageOBJ.object.getFormValue("DB00802-form","P_COMPANY_CODE")
					      ,"P_DIVISION_CODE" : KpackageOBJ.object.getFormValue("DB00802-form","P_DIVISION_CODE")
					      ,"P_ISSUE_TYPE"    : KpackageOBJ.object.getFormValue("DB00802-form","P_ISSUE_TYPE")
					     };
			KpackageOBJ.ajax.doSubmit("/drawback/retrieve_DB00801_header", params, DB00802.retrieve_Header_Information_callback);	
		}
		this.retrieve_Header_Information_callback = function(result){
			var data = result.value;
			
			$("#DB00802-form #REGIST_RCEPT_NO").html(data["REGIST_RCEPT_NO"]);
			$("#DB00802-form #PRESENTN_NO").html(data["PRESENTN_NO"]);
// 			$("#DB00802-form #CHIT_FRMTRM_DATE").html(data["CHIT_FRMTRM_DATE"]);
			$("#DB00802-form #CUSTOMER_CODE").html(data["CUSTOMER_CODE"]);
			$("#DB00802-form #CSTMR_ECTMRK").html(data["CSTMR_ECTMRK"]);
			$("#DB00802-form #CSTMR_NM_1").html(data["CSTMR_NM_1"]);
			$("#DB00802-form #CSTMR_ADRES_1").html(data["CSTMR_ADRES_1"]);
			$("#DB00802-form #CSTMR_BIZRNO").html(data["CSTMR_BIZRNO"]);
			$("#DB00802-form #CSTMR_TELNO").html(data["CSTMR_TELNO"]);
			$("#DB00802-form #CSTBRKR").html(data["CSTBRKR"]);
			$("#DB00802-form #NATION_CODE").html(data["NATION_CODE"]);
			$("#DB00802-form #ISSUE_TYPE_NAME").html(data["ISSUE_TYPE_NAME"]);
			$("#DB00802-form #CSTMS").html(KpackageOBJ.formatter.commas(data["CSTMS"]));
			$("#DB00802-form #INTTAX").html(KpackageOBJ.formatter.commas(data["INTTAX"]));
			$("#DB00802-form #ECX_AMOUNT").html(KpackageOBJ.formatter.commas(data["ECX_AMOUNT"]));
			$("#DB00802-form #AGSPT").html(KpackageOBJ.formatter.commas(data["AGSPT"]));
			$("#DB00802-form #DRWBAK_AMOUNT").html(KpackageOBJ.formatter.commas(data["DRWBAK_AMOUNT"]));

			$("#DB00802-form #CHIT_FRMTRM_DATE").html(KpackageOBJ.formatter.date(data["CHIT_FRMTRM_DATE"]));


			DB00802.retrieve_List();
		}
		this.retrieve_List = function(){
			var param = KpackageOBJ.data.makePostData("DB00802-form");
			KpackageOBJ.tuiGrid.retrieve("oTui_DB00802_01", "/drawback/retrieve_DB00802_trget", param);
		}
		
		<% /*  확정 취소  */%>
        this.cancelConfirmProcess = function(){
            var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB00802_01");  
            
            if("" != KpackageOBJ.object.getFormValue("DB00802-form","CHK_REGIST_RCEPT_NO")){
                alert("확정 또는 접수 진행중인 데이터는 수정할 수 없습니다.");
                return;
            }
            if(rowData.length == 0){
                alert("선택된 데이터가 없습니다.");
                return;
            }
            if (confirm("선택하신 항목을 환급신청대상에서 제외하시겠습니까?") ) {
                KpackageOBJ.ajax.doSubmit("/drawback/cancel_DB00802_ConfirmProcess", rowData, DB00802.cancelConfirmProcess_callback);   
            }
              
            
        }
        
        this.cancelConfirmProcess_callback = function(result){
            alert(result.message);
            DB00802.retrieve_Header_Information();
        }
		
		
	}

	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB00802.initialize_viewObject();	// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		DB00802.initialize_TuiGrid();		// Toast Grid Render

		DB00802.retrieve_Header_Information();
		
		
	});

</script>
	
</body>
</html>