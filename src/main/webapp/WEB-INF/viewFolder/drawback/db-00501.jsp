<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
/******************************************************************************************************
	Program Name : 환급신청서 상세조회
	Program Code : DB00501
******************************************************************************************************/
%>
<!DOCTYPE html>
<html>
<head>
<style>
caption {
	caption-side: top;
}
</style>
	
	
	
	
</head>
<body>
<div id="content">
	<section id="widget-grid-DB00501" class="">
		<form:form id="DB00501-form" class="s4-form" novalidate="novalidate" onsubmit="return false;">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<input type="hidden" id="P_PRESENTN_NO" name="P_PRESENTN_NO" value="${reqParam.PRESENTN_NO }"/>
			<input type="hidden" id="P_LF_PRICE_TRGT" name="P_LF_PRICE_TRGT" value="${reqParam.LF_PRICE_TRGT }"/>
			<input type="hidden" id="P_TAX_RATE_TRGT" name="P_TAX_RATE_TRGT" value="${reqParam.TAX_RATE_TRGT }"/>
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div class="table-responsive of-hidden" style="padding-right: 6px;">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:120px;" />
								<col style="width: ;" />
								<col style="width:120px;" />
								<col style="width: 15%;" />
								<col style="width:120px;" />
								<col style="width: 10%;" />
								<col style="width:120px;" />
								<col style="width: 10%;" />
								
							</colgroup>
							<tbody>
								<tr>
									<th>제출번호</th>
									<td colspan="3">
										<span id="PRESENTN_NO"></span>
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
									<th>결정일자</th>
									<td>
										<span id="DRWBAK_COMP_DATE"></span>
									</td>
                                    <th>개별소비세</th>
                                    <td style="text-align: right;">
                                        <span id="INTTAX"></span>
                                    </td>
                                    <th colspan="2" style="text-align:center;">환급금액</th>
								</tr>
								<tr>
									<th>제조업체</th>
									<td>
										<span id="MANUFAC_NAME"></span>
									</td>
									<th>환급은행</th>
									<td>
										<span id="BANK_NM"></span>
									</td>
                                    <th>교통세</th>
                                    <td style="text-align: right;">
                                        <span id="TRANTAX"></span>
                                    </td>
                                    <td rowspan="3" colspan="2" style="text-align:center; ">
                                        <span id="DRWBAK_AMOUNT" style="font-weight: bold; font-size: 20px; color: #ff730f;"></span>
                                    </td>
								</tr>
								<tr>
									<th>신청업체</th>
									<td>
										<span id="COMPANY_NM"></span>
									</td>
									<th>계좌번호</th>
									<td>
										<span id="ACNUTNO"></span>
									</td>
                                    <th>주세</th>
                                    <td style="text-align: right;">
                                        <span id="LQTX_AMOUNT"></span>
                                    </td>
								</tr>
                                <tr>
									<th>환급구분</th>
									<td>
										<span id="DRWBAK_SE"></span>
									</td>
									<th>소요량구분</th>
									<td>
										<span id="REQREQY_CALC_MTH"></span>
									</td>
                                    <th>교육세</th>
                                    <td style="text-align: right;">
                                        <span id="ECX_AMOUNT"></span>
                                    </td>
                                </tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		<div class ="row" style="margin-top:10px;">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<ul id="grid_Tab" class="nav nav-tabs bordered">
					<li class="active" id="tab01" >
						<a href="#grid_01" data-toggle="tab" aria-expanded="true"><i class="fa fa-fw fa-lg fa-gear"></i>수출입내역</a>
					</li>
					<li class=""  id="tab02">
						<a href="#grid_02" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>배제사유서</a>
					</li>
					<li class=""  id="tab03">
						<a href="#grid_03" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>제한배제사유서</a>
					</li>
				</ul>
				<div id="Grid_TabContent" class="tab-content" style="background: #FFF;display: inline-block;width: 100%;height:525px;">
					<div class="tab-pane fade active in" id="grid_01">
						<div class="widget-body col-xs-12 col-sm-12 col-md-12 col-lg-12" style="position: relative; ">
							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 30px;">
									<div id="div_oTui_DB00501_01" name="div_oTui_DB00501_01" class="tuigrid-resizable" style="margin:0 15px 0 15px;">
										<div id="oTui_DB00501_01" data-fixed-height="150"></div>
										<!-- <div id="oTui_DB00501_01_paging"></div> -->
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
									<div id="div_oTui_DB00501_02" name="div_oTui_DB00501_02" class="tuigrid-resizable" style="margin:0 15px 0 15px;">
										<div id="oTui_DB00501_02" data-fixed-height="200"></div>
										<!-- <div id="oTui_DB00501_01_paging"></div> -->
									</div>
								</div>
							</div>						
						</div>
					</div>
					
					<div class="tab-pane fade" id="grid_02">
						<div class="widget-body col-xs-12 col-sm-12 col-md-12 col-lg-12" style="position: relative; ">
							<div class="row">
								<table class="table table-bordered"  style="margin: 15px;">
									<colgroup>
										<col style="width:180px;" />
										<col style="width: ;" />
									</colgroup>
									<tbody>
										<tr>
											<th colspan="2" style="color:blue; font-weight: bold;">수입신고필증 유효기간 단축배제 사유</th>
										</tr>
										<tr>
											<th>관련규정</th>
											<td>
												<span>        
												「수입원재료에 대한 환급방법 조정에 관한 고시」 제5조
												</span>
											</td>
										</tr>
										<tr>
											<th>배제사유</th>
											<td>
												<span><input type="checkbox" readonly="readonly"  onClick="return false;"/> 1.(제5조제1호) 동질의 수입원재료를 모두 사용한경우</span><br>
												<span><input type="checkbox" readonly="readonly"  onClick="return false;"/> 2.(제5조제2호) 제조장 가동중단 또는 생산공정에 투입이 지연된경우</span><br>
												<span><input type="checkbox" readonly="readonly"  onClick="return false;"/> 3.(제5조제3호) 생산공정이 3월 이상 소요되는 경우</span><br>
												<span><input type="checkbox" readonly="readonly"  onClick="return false;"/> 4.(제5조제4호) 원재료를 개별법에 따라 관리하는 경우</span><br>
												<span><input type="checkbox" checked="checked"  readonly="readonly"  onClick="return false;"/> 5.(제5조제5호) 원재료를 선입선출법에 따라 관리하는 경우</span><br>
												<span><input type="checkbox" readonly="readonly"  onClick="return false;"/> 6.(제5조제6호) 그 밖의 사유로 유효기간 외의 수입원재료가 사용된 경우</span>
											</td>
										</tr>
										<tr>
											<th>증빙자료명</th>
											<td>
											</td>
										</tr>
									</tbody>
								</table>
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
									<div id="div_oTui_DB00501_03" name="div_oTui_DB00501_03" class="tuigrid-resizable" style="margin:0 15px 0 15px;">
										<div id="oTui_DB00501_03" data-fixed-height="180"></div>
										<!-- <div id="oTui_DB00501_01_paging"></div> -->
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="tab-pane fade" id="grid_03">
						<div class="widget-body col-xs-12 col-sm-12 col-md-12 col-lg-12" style="position: relative; ">
							<div class="row">
								<table class="table table-bordered" style="margin: 15px;">
									<colgroup>
										<col style="width:180px;" />
										<col style="width: ;" />
									</colgroup>
									<tbody>
										<tr>
											<th colspan="2"  style="color:blue; font-weight: bold;">세율별 환급사용물량제한 배제 사유</th>
										</tr>
										<tr>
											<th>관련규정</th>
											<td>
												<span>        
												「수입원재료에 대한 환급방법 조정에 관한 고시」 제9조
												</span>
											</td>
										</tr>
										<tr>
											<th>환급사용물량조정</th>
											<td>
												<span><input type="checkbox" readonly="readonly"/> 1.(제9조제1항)해당세율의 수입원재료를 모두 사용한경우</span><br>
											</td>
										</tr>
										<tr>
											<th>배제사유</th>
											<td>
												<span><input type="checkbox" readonly="readonly"  onClick="return false;"/> 1.(제9조제2항제1호) 세율별 동일한 질과 특성을 갖지 않아 생산에 구분 사용하는 경우</span><br>
												<span><input type="checkbox" readonly="readonly"  onClick="return false;"/> 2.(제9조제2항제2호) 단일세율로 수입하는 경우</span><br>
												<span><input type="checkbox" readonly="readonly"  onClick="return false;"/> 3.(제9조제2항제3호) 원재료를 개별법에 따라 관리하는 경우</span><br>
												<span><input type="checkbox" checked="checked" readonly="readonly"  onClick="return false;"/> 4.(제9조제2항제4호) 원재료를 선입선출법에 따라 관리하는 경우</span><br>
												<span><input type="checkbox" readonly="readonly"  onClick="return false;"/> 5.(제9조제2항제5호) 중소기업법에 따른 중소기업자</span><br>
												<span><input type="checkbox" readonly="readonly"  onClick="return false;"/> 6.(제9조제2항제6호) 그 밖의 사유로 실제생산에 사용된 수입원재료로로 환급등 신청하는 경우</span>
											</td>
										</tr>
										<tr>
											<th>증빙자료명</th>
											<td>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>
		</form:form>
	</section>
</div>

<script type="text/javascript">


	var oTui_DB00501_01, oTui_DB00501_02, oTui_DB00501_03;
	var pLfPriceTrgt, pTaxRateTrgt;
	
	var DB00501 = new function() {
		this.initialize_viewObject = function(){
			pTaxRateTrgt = "${reqParam.TAX_RATE_TRGT }"; //세율별환율
			pLfPriceTrgt = "${reqParam.LF_PRICE_TRGT }"; //단축고시대상
			
			if(pLfPriceTrgt == "N"){
				$("#tab02").hide();
			}

			if(pTaxRateTrgt == "N"){
				$("#tab03").hide();
			}	
			
			/* Create Tab Event*/
			$("#grid_Tab.nav.nav-tabs li").click(function(){
				//Search And ResizingGrid
				setTimeout(DB00501.reSizingGrid, 300);
			});
		}
		
		this.initialize_TuiGrid = function(){
			
			// 수출내역 정보 Grid
			var colArrayInfo = [
				
			    
				{ name :"XPORT_STTEMNT_NO",   header : "수출신고번호",        align :"center"    ,width : 120,hidden : false}, 
				{ name :"LNE_NO",             header : "란",                  align :"center"    ,width : 30,hidden : false}, 
				{ name :"POUCH_NO",           header : "행",                  align :"center"    ,width : 30,hidden : false}, 
				{ name :"ITEM_CODE",          header : "제품코드",            align :"center"      ,width : 100,hidden : false},
				{ name :"ITEM_NM",      		header : "제품명",         	align :"left"    ,width : 300,hidden : false},
				{ name :"DSPTH_DATE",         header : "수출신고수리일자",    align :"center"    ,width : 100,hidden : false, formatter : KpackageOBJ.tuiGrid.dateFormatter},
				{ name :"ACCMLT_ORDER_QY",    header : "수출수량",            align :"right"     ,width : 120,hidden : false, formatter : KpackageOBJ.tuiGrid.commas}, 
				{ name :"BASS_UNIT",          header : "단위",                align :"center"    ,width : 60,hidden : false}, 
				{ name :"STTEMNT_PC_KRW",     header : "수출금액",            align :"right"     ,width : 190,hidden : false, formatter : KpackageOBJ.tuiGrid.commas}, 
				{ name :"RAWMTRL_SUM_TAX",    header : "환급금액",            align :"right"     ,width : 190,hidden : true, formatter : KpackageOBJ.tuiGrid.commas}, 


				{ name :"PRESENTN_NO",        header : "수출신고번호",        align :"center"    ,width : 100,hidden : true},
				{ name :"THNG_SEQ",           header : "순번",                align :"center"    ,width : 100,hidden : true},
				{ name :"COMPANY_CODE",       header : "회사코드",              align :"center"    ,width : 100,hidden : true},
				{ name :"DIVISION_CODE",      header : "플랜트",              align :"center"    ,width : 100,hidden : true}
		    ];
			  
			
			KpackageOBJ.tuiGrid.setCaption("oTui_DB00501_01","수출내역");
			var tools = [{icon:"print", title:"환급신청취소"                ,text:"환급신청취소"                ,func:"DB00501.cancelConfirmProcess"}
			            ];
			KpackageOBJ.tuiGrid.setButton("oTui_DB00501_01", tools); // Toobar 생성
			
			oTui_DB00501_01 = KpackageOBJ.tuiGrid.create("oTui_DB00501_01","/drawback/retrieve_DB00501_trget", colArrayInfo, "check", null, DB00501.onDblClick_oTui_Grid);
	    	
			
			// 수입내역 정보 Grid
			colArrayInfo = [
				
			    { name :"IMPDEC_NO",        	header : "수입신고번호",         align :"center"    ,width : 120,hidden : false}, 
			    { name :"LNE_NO",          		header : "란",   				align :"center"    ,width : 30,hidden : false}, 
			    { name :"POUCH_NO",        		header : "행",         		  align :"center"    ,width : 30,hidden : false}, 
			    { name :"ITEM_CODE",      		header : "제품코드",         	align :"center"    ,width : 100,hidden : false},
			    { name :"RAWMTRL_CODE",      	header : "자재코드",       	align :"left"    ,width : 150,hidden : false},
			    { name :"RAWMTRL_SE",           header : "원재료구분",         align :"center"     ,width : 80,hidden : false}, 
			    { name :"ACPT_DATE",           	header : "수입신고수리일자",   align :"center"    ,width : 100,hidden : false, formatter : KpackageOBJ.tuiGrid.dateFormatter}, 
			    { name :"HS_CODE",         		header : "HS CODE",       		align :"right"     ,width : 100,hidden : false, formatter : KpackageOBJ.tuiGrid.hscode10}, 
			    { name :"USGQTY",         		header : "환급 사용량",        align :"right"     ,width : 80,hidden : false, formatter : KpackageOBJ.tuiGrid.commas},
			    { name :"BASS_UNIT",   			header : "단위",   			align :"center"     ,width : 60,hidden : false},
			    { name :"DRWBAK_AMOUNT",       	header : "환급액",       		align :"right"     ,width : 100,hidden : false, formatter : KpackageOBJ.tuiGrid.commas},
			    { name :"BY_PRODUCT_SE",        header : "부산물 구분",        align :"center"    ,width : 80,hidden : true},
			    
			    { name :"COMPANY_CODE",         header : "COMPANY_CODE",       align :"center"    ,width : 100,hidden : true},
			    { name :"PRESENTN_NO",          header : "PRESENTN_NO",        align :"center"    ,width : 100,hidden : true},
			    { name :"THNG_SEQ",             header : "THNG_SEQ",        	align :"center"    ,width : 100,hidden : true},
			    { name :"RAWMTRL_SEQ",          header : "RAWMTRL_SEQ",        align :"center"    ,width : 100,hidden : true},
				{ header : "거래구분"    		,name : "THNG_SE"            ,width : 80, align: "center" ,hidden : true }
			    
			    			
			    ];
			KpackageOBJ.tuiGrid.setCaption("oTui_DB00501_02","수입내역");
			oTui_DB00501_02 = KpackageOBJ.tuiGrid.create("oTui_DB00501_02","/drawback/retrieve_DB00501_trget", colArrayInfo, "number", null, DB00501.onDblClick_oTui_Grid);
			
			
			// 수입신고필증 유효기간 단축배제 사유 Grid
			colArrayInfo = [
				{ name :"IMPDEC_LP_NO",        	header : "수입신고번호-란-규격",      align :"center"    ,width : 300	,hidden : false}, 
			    { name :"ACPT_DATE",           	header : "수입신고수리일자",  		align :"center"    ,width : 150	,hidden : false, formatter : KpackageOBJ.tuiGrid.dateFormatter}, 
			    { name :"RAWMTRL_CODE",         	header : "품명 및 규격",       		align :"left"     ,width : 350	,hidden : false}, 
			    { name :"USGQTY",         		header : "사용량",       			align :"right"     ,width : 100	,hidden : false, formatter : KpackageOBJ.tuiGrid.commas}
			    ];
			
			//KpackageOBJ.tuiGrid.setCaption("oTui_DB00501_03","수입신고필증");
			oTui_DB00501_03 = KpackageOBJ.tuiGrid.create("oTui_DB00501_03","/drawback/retrieve_DB00501_RestrictRawmtrl", colArrayInfo, "number", null, null);
		};
		
		this.onDblClick_oTui_Grid = function(gridId, rowkey, colName){
			if(gridId == "oTui_DB00501_01"){
				var rowData = KpackageOBJ.tuiGrid.getSelectedRowlValue(gridId, rowkey);	
				KpackageOBJ.tuiGrid.retrieve("oTui_DB00501_02", "/drawback/retrieve_DB00501_rawmtrl", rowData);
			}
		};
		
		<% // 해더정보 조회 %>
		this.retrieve_Header_Information = function(){
			var params = { "P_PRESENTN_NO" : KpackageOBJ.object.getFormValue("DB00501-form","P_PRESENTN_NO")};
			KpackageOBJ.ajax.doSubmit("/drawback/retrieve_DB00501_header", params, DB00501.retrieve_Header_Information_callback);	
		}
		this.retrieve_Header_Information_callback = function(result){
			var data = result.value;
			
			$("#DB00501-form #PRESENTN_NO").html(data["PRESENTN_NO"]);
			$("#DB00501-form #REGIST_RCEPT_NO").html(data["REGIST_RCEPT_NO"]);
			
			KpackageOBJ.object.setFormValue("DB00501-form","CHK_REGIST_RCEPT_NO", data["REGIST_RCEPT_NO"]);  
			
			$("#DB00501-form #MANUFAC_NAME").html(data["MANUFAC_NAME"]);
			$("#DB00501-form #COMPANY_NM").html(data["COMPANY_NM"]);
//			$("#DB00501-form #GOVC_YYYYMMDD").html(data["GOVC_YYYYMMDD"]);
// 			$("#DB00501-form #DRWBAK_COMP_DATE").html(data["DRWBAK_COMP_DATE"]);
			$("#DB00501-form #BANK_NM").html(data["BANK_NM"]);
			$("#DB00501-form #ACNUTNO").html(data["ACNUTNO"]);
			$("#DB00501-form #DRWBAK_SE").html(data["DRWBAK_SE"]);
			$("#DB00501-form #REQREQY_CALC_MTH").html(data["REQREQY_CALC_MTH"]);

		    $("#DB00501-form #DRWBAK_COMP_DATE").html(KpackageOBJ.formatter.date(data["DRWBAK_COMP_DATE"]));
		    
		    $("#DB00501-form #CSTMS").html(KpackageOBJ.formatter.commas(data["CSTMS"]));
		    $("#DB00501-form #INTTAX").html(KpackageOBJ.formatter.commas(data["INTTAX"]));
		    $("#DB00501-form #ECX_AMOUNT").html(KpackageOBJ.formatter.commas(data["ECX_AMOUNT"]));
		    $("#DB00501-form #AGSPT").html(KpackageOBJ.formatter.commas(data["AGSPT"]));
		    $("#DB00501-form #TRANTAX").html(KpackageOBJ.formatter.commas(data["TRANTAX"]));
		    $("#DB00501-form #LQTX_AMOUNT").html(KpackageOBJ.formatter.commas(data["LQTX_AMOUNT"]));
		    $("#DB00501-form #DRWBAK_AMOUNT").html(KpackageOBJ.formatter.commas(data["DRWBAK_AMOUNT"]));

			DB00501.retrieve_List();
			DB00501.retrieve_RestrictList();
		}
		
		this.retrieve_List = function(){
			var param = KpackageOBJ.data.makePostData("DB00501-form");
			KpackageOBJ.tuiGrid.retrieve("oTui_DB00501_01", "/drawback/retrieve_DB00501_trget", param);
		}
		
		

		this.retrieve_RestrictList = function(){
			var param = KpackageOBJ.data.makePostData("DB00501-form");
			KpackageOBJ.tuiGrid.retrieve("oTui_DB00501_03", "/drawback/retrieve_DB00501_RestrictRawmtrl", param);
		}
		
		<% /*  환급신청 취소  */%>
		this.cancelConfirmProcess = function(){
			var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB00501_01");  
			
			if("" != KpackageOBJ.object.getFormValue("DB00501-form","CHK_REGIST_RCEPT_NO")){
				alert("확정 또는 접수 진행중인 데이터는 수정할 수 없습니다.");
				return;
			}
			if(rowData.length == 0){
                alert("선택된 데이터가 없습니다.");
                return;
            }
			if (confirm("선택하신 항목을 환급신청대상에서 제외하시겠습니까?") ) {
				KpackageOBJ.ajax.doSubmit("/drawback/cancel_DB00501_ConfirmProcess", rowData, DB00501.cancelConfirmProcess_callback);	
			}
			  
			
		}
		
		this.cancelConfirmProcess_callback = function(result){
            alert(result.message);
            DB00501.retrieve_Header_Information();
        }
		
		//grid resizing
		this.reSizingGrid = function(){
			KpackageOBJ.tuiGrid.reSizingGrid("oTui_DB00501_01");
			KpackageOBJ.tuiGrid.reSizingGrid("oTui_DB00501_02");
			KpackageOBJ.tuiGrid.reSizingGrid("oTui_DB00501_03");
		}
		
	}

	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB00501.initialize_viewObject();	// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		DB00501.initialize_TuiGrid();		// Toast Grid Render

		DB00501.retrieve_Header_Information();
		
		
	});

</script>
	
</body>
</html>