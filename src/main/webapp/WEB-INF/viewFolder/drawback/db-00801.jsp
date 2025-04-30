<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
/******************************************************************************************************
	Program Name : 기납증/분증 상세조회
	Program Code : DB00801
******************************************************************************************************/
%>
<!DOCTYPE html>
<html>
<head>

	
	
	
	
</head>
<body>
<div id="content">
	<section id="widget-grid-DB00801" class="">
		<form:form id="DB00801-form" class="s4-form" novalidate="novalidate" onsubmit="return false;">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<input type="hidden" id="P_PRESENTN_NO" name="P_PRESENTN_NO" value="${reqParam.PRESENTN_NO }"/>
			<input type="hidden" id="P_ISSUE_TYPE" name="P_ISSUE_TYPE" value="${reqParam.ISSUE_TYPE }"/>
			<input type="hidden" id="P_DIVISION_CODE" name="P_DIVISION_CODE" value="${reqParam.DIVISION_CODE }"/>
			<input type="hidden" id="P_COMPANY_CODE" name="P_COMPANY_CODE" value="${reqParam.COMPANY_CODE }"/>
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div class="table-responsive of-hidden" style="padding-right: 6px;">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:120px;" />
								<col style="width: 20%;" />
								<col style="width:150px;" />
								<col style="width: ;" />
								<col style="width:120px;" />
								<col style="width: 10%;" />
								<col style="width:120px;" />
								<col style="width: 10%;" />
							</colgroup>
							<tbody>
								<tr>
									<th>제출번호</th>
									<td>
										<span id="PRESENTN_NO"></span>
									</td>
									<th>고객사</th>
									<td>
										<span id="CSTMR_NM_1"></span>
									</td>
                                    <th>관세</th>
                                    <td style="text-align: right;">
                                        <span id="CSTMS"></span>
                                    </td>
                                    <th>농특세</th>
                                    <td style="text-align: right;">
                                        <span id="AGSPT"></span>
                                    </td>
								</tr>
								<tr>
									<th>등록(접수)번호</th>
									<td>
										<span id="REGIST_RCEPT_NO"></span>
										<input type="hidden" id="CHK_REGIST_RCEPT_NO" name="CHK_REGIST_RCEPT_NO"/>
									</td>
									<th>고객 사업자등록번호</th>
									<td>
										<span id="CSTMR_BIZRNO"></span>
									</td>
                                    <th>개별소비세</th>
                                    <td style="text-align: right;">
                                        <span id="INTTAX"></span>
                                    </td>
                                    <th colspan="2" style="text-align:center;">양도세액</th>
								</tr>
								<tr>
									<th>발급구분</th>
									<td>
										<span id="ISSUE_TYPE_NAME"></span>
									</td>
									<th>고객사 전화번호</th>
									<td>
										<span id="CSTMR_TELNO"></span>
									</td>
									<th>교통세</th>
									<td style="text-align:right;">
										<span id="TRANTAX"></span>
									</td>
                                    <td rowspan="3" colspan="2" style="text-align:center; ">
                                        <span id="DRWBAK_AMOUNT" style="font-weight: bold; font-size: 20px; color: #ff730f;"></span>
                                    </td>
								</tr>
								<tr>
									<th>양도일자</th>
									<td>
										<span id="CHIT_FRMTRM_DATE"></span>
									</td>
									<th>관세사</th>
									<td>
										<span id="CSTBRKR"></span>
									</td>
									<th>주세</th>
									<td style="text-align:right;">
										<span id="LQTX_AMOUNT"></span>
									</td>
								</tr>
								<tr>
									<th>국가코드</th>
									<td>
										<span id="NATION_CODE"></span>
									</td>
									<th></th>
									<td></td>
									<th>교육세</th>
									<td style="text-align:right;">
										<span id="ECX_AMOUNT"></span>
									</td>
								</tr>
							
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</form:form>
		
		<div class="row" style="margin-top: 20px;">
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_DB00801_01" name="div_oTui_DB00801_01" class="tuigrid-resizable">
					<div id="oTui_DB00801_01" data-fixed-height="150"></div>
					<!-- <div id="oTui_DB00801_01_paging"></div> -->
				</div>
			</div>
			
		</div>
		
		<div class="row" style="margin-top: 20px;">
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_DB00801_02" name="div_oTui_DB00801_02" class="tuigrid-resizable">
					<div id="oTui_DB00801_02" data-fixed-height="200"></div>
					<!-- <div id="oTui_DB00801_01_paging"></div> -->
				</div>
			</div>
			
		</div>
	</section>
</div>

<script type="text/javascript">


	var oTui_DB00801_01, oTui_DB00801_02
	var DB00801 = new function() {
		this.initialize_viewObject = function(){
			
		}
		
		this.initialize_TuiGrid = function(){
			
			// 수출내역 정보 Grid
			var colArrayInfo = [
				
			    
				{ name :"BASIS_DOC_NO",   		header : "근거서류번호",   	align :"center"    ,width : 120,hidden : false}, 
			    { name :"SUPT_DOC_ITEM_SEQ",	header : "순번",  	align :"center"    ,width : 30,hidden : false}, 
			    { name :"ITEM_CODE",			header : "제품코드",       	align :"left"      ,width : 150,hidden : false},
			    { name :"ITEM_NM",				header : "제품명",       	align :"left"      ,width : 270,hidden : false},
			    { name :"CHIT_FRMTRM_DATE",		header : "양도일자",   		align :"center"    ,width : 100,hidden : false, formatter : KpackageOBJ.tuiGrid.dateFormatter},
			    { name :"ACCMLT_ORDER_QY",		header : "수량",           	align :"right"     ,width : 100,hidden : false, formatter : KpackageOBJ.tuiGrid.commas}, 
			    { name :"BASS_UNIT",			header : "단위",           	align :"center"    ,width : 60,hidden : false}, 
			    { name :"STTEMNT_PC_KRW",		header : "판매금액",       	align :"right"     ,width : 100,hidden : false, formatter : KpackageOBJ.tuiGrid.commas}, 
			    { name :"SUM_TAX",    header : "양도세액",            align :"right"     ,width : 190,hidden : false, formatter : KpackageOBJ.tuiGrid.commas},

			    
			    { name :"PRESENTN_NO",        header : "PRESENTN_NO",       align :"center"    ,width : 100,hidden : true},
			    { name :"SEQ",           		header : "SEQ",       align :"center"    ,width : 100,hidden : true},
			    { name :"COMPANY_CODE",       header : "COMPANY_CODE",       align :"center"    ,width : 100,hidden : true},
			    { name :"DIVISION_CODE",      header : "DIVISION_CODE",       align :"center"    ,width : 100,hidden : true}
		    ];
			  
			KpackageOBJ.tuiGrid.setCaption("oTui_DB00801_01","매출내역");
			oTui_DB00801_01 = KpackageOBJ.tuiGrid.create("oTui_DB00801_01","/drawback/retrieve_DB00801_trget", colArrayInfo, "check", null, DB00801.onDblClick_oTui_Grid);
	    	
			
			// 수입내역 정보 Grid
			colArrayInfo = [
				
			    { name :"IMPDEC_NO",            header : "신고번호",       	align :"center"    	,width : 120	,hidden : false}, 
			    { name :"LNE_NO",          		header : "란",   			align :"center"    	,width : 30		,hidden : false}, 
			    { name :"POUCH_NO",        		header : "행",         	align :"center"    	,width : 30		,hidden : false}, 
			    { name :"ITEM_CODE",      		header : "제품코드",       	align :"left"    	,width : 150	,hidden : false},
			    { name :"RAWMTRL_CODE",      	header : "자재코드",       	align :"left"    	,width : 167	,hidden : false},
			    { name :"RAWMTRL_SE",           header : "원재료구분",    	align :"center"     ,width : 60		,hidden : false}, 
			    { name :"ACPT_DATE",           	header : "수입신고수리일자", 	align :"center"    	,width : 100	,hidden : false, formatter : KpackageOBJ.tuiGrid.dateFormatter}, 
			    { name :"HS_CODE",         		header : "HS CODE",      align :"right"     	,width : 100	,hidden : false, formatter : KpackageOBJ.tuiGrid.hscode10}, 
			    { name :"USGQTY",         		header : "환급 사용량",    	align :"right"     	,width : 100	,hidden : false, formatter : KpackageOBJ.tuiGrid.commas},
			    { name :"BASS_UNIT",   			header : "단위",   		align :"right"     	,width : 60		,hidden : false},
			    { name :"DRWBAK_AMOUNT",       	header : "양도세액",    	align :"right"     	,width : 100	,hidden : false, formatter : KpackageOBJ.tuiGrid.commas},
			    { name :"BY_PRODUCT_SE",        header : "부산물 구분",   	align :"center"    	,width : 80		,hidden : false},
			    
			    { name :"COMPANY_CODE",         header : "COMPANY_CODE",	align :"center"    	,width : 100	,hidden : true},
			    { name :"PRESENTN_NO",          header : "PRESENTN_NO", 	align :"center"    	,width : 100	,hidden : true},
			    { name :"SEQ",                  header : "SEQ",        	align :"center"    	,width : 100	,hidden : true},
			    { name :"RAWMTRL_SEQ",          header : "RAWMTRL_SEQ", 	align :"center"    	,width : 100	,hidden : true},
			    
			    
			    			
			    ];
			  
			KpackageOBJ.tuiGrid.setCaption("oTui_DB00801_02","원재료 내역");
			oTui_DB00801_02 = KpackageOBJ.tuiGrid.create("oTui_DB00801_02","/drawback/retrieve_DB00801_trget", colArrayInfo, "number", null, DB00801.onDblClick_oTui_Grid);
	    	
		};
		
		this.onDblClick_oTui_Grid = function(gridId, rowkey, colName){
			if(gridId == "oTui_DB00801_01"){
				var rowData = KpackageOBJ.tuiGrid.getSelectedRowlValue(gridId, rowkey);	
				KpackageOBJ.tuiGrid.retrieve("oTui_DB00801_02", "/drawback/retrieve_DB00801_rawmtrl", rowData);
			}
			
			
		};
		
		<% // 해더정보 조회 %>
		this.retrieve_Header_Information = function(){
			var params = { "P_PRESENTN_NO"   : KpackageOBJ.object.getFormValue("DB00801-form","P_PRESENTN_NO")
					      ,"P_COMPANY_CODE"  : KpackageOBJ.object.getFormValue("DB00801-form","P_COMPANY_CODE")
					      ,"P_DIVISION_CODE" : KpackageOBJ.object.getFormValue("DB00801-form","P_DIVISION_CODE")
					      ,"P_ISSUE_TYPE"    : KpackageOBJ.object.getFormValue("DB00801-form","P_ISSUE_TYPE")
					     };
			KpackageOBJ.ajax.doSubmit("/drawback/retrieve_DB00801_header", params, DB00801.retrieve_Header_Information_callback);	
		}
		this.retrieve_Header_Information_callback = function(result){
			var data = result.value;
			
			$("#DB00801-form #REGIST_RCEPT_NO").html(data["REGIST_RCEPT_NO"]);
			
			KpackageOBJ.object.setFormValue("DB00801-form","CHK_REGIST_RCEPT_NO", data["REGIST_RCEPT_NO"]);
			
			$("#DB00801-form #PRESENTN_NO").html(data["PRESENTN_NO"]);
			
			$("#DB00801-form #CUSTOMER_CODE").html(data["CUSTOMER_CODE"]);
			$("#DB00801-form #CSTMR_ECTMRK").html(data["CSTMR_ECTMRK"]);
			$("#DB00801-form #CSTMR_NM_1").html(data["CSTMR_NM_1"]);
			$("#DB00801-form #CSTMR_ADRES_1").html(data["CSTMR_ADRES_1"]);
			$("#DB00801-form #CSTMR_BIZRNO").html(data["CSTMR_BIZRNO"]);
			$("#DB00801-form #CSTMR_TELNO").html(data["CSTMR_TELNO"]);
			$("#DB00801-form #CSTBRKR").html(data["CSTBRKR"]);
			$("#DB00801-form #NATION_CODE").html(data["NATION_CODE"]);
			$("#DB00801-form #ISSUE_TYPE_NAME").html(data["ISSUE_TYPE_NAME"]);
			
			$("#DB00801-form #CHIT_FRMTRM_DATE").html(KpackageOBJ.formatter.date(data["CHIT_FRMTRM_DATE"]));
			$("#DB00801-form #CSTMS").html(KpackageOBJ.formatter.commas(data["CSTMS"]));
			$("#DB00801-form #INTTAX").html(KpackageOBJ.formatter.commas(data["INTTAX"]));
			$("#DB00801-form #ECX_AMOUNT").html(KpackageOBJ.formatter.commas(data["ECX_AMOUNT"]));
			$("#DB00801-form #AGSPT").html(KpackageOBJ.formatter.commas(data["AGSPT"]));
			$("#DB00801-form #DRWBAK_AMOUNT").html(KpackageOBJ.formatter.commas(data["DRWBAK_AMOUNT"]));
			$("#DB00801-form #TRANTAX").html(KpackageOBJ.formatter.commas(data["TRANTAX"]));
			$("#DB00801-form #LQTX_AMOUNT").html(KpackageOBJ.formatter.commas(data["LQTX_AMOUNT"]));
			
			DB00801.retrieve_List();
		}
		this.retrieve_List = function(){
			var param = KpackageOBJ.data.makePostData("DB00801-form");
			KpackageOBJ.tuiGrid.retrieve("oTui_DB00801_01", "/drawback/retrieve_DB00801_trget", param);
		}
		
		<% /*  확정 취소  */%>
        this.cancelConfirmProcess = function(){
            var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB00801_01");  
            
            if("" != KpackageOBJ.object.getFormValue("DB00801-form","CHK_REGIST_RCEPT_NO")){
                alert("확정 또는 접수 진행중인 데이터는 수정할 수 없습니다.");
                return;
            }
            if(rowData.length == 0){
                alert("선택된 데이터가 없습니다.");
                return;
            }
            if (confirm("선택하신 항목을 환급신청대상에서 제외하시겠습니까?") ) {
                KpackageOBJ.ajax.doSubmit("/drawback/cancel_DB00801_ConfirmProcess", rowData, DB00801.cancelConfirmProcess_callback);   
            }
              
            
        }
        
        this.cancelConfirmProcess_callback = function(result){
            alert(result.message);
            DB00801.retrieve_Header_Information();
        }
	}

	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB00801.initialize_viewObject();	// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		DB00801.initialize_TuiGrid();		// Toast Grid Render

		DB00801.retrieve_Header_Information();
		
		
	});

</script>
	
</body>
</html>