<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
/******************************************************************************************************
	Program Name : 가산금액 지급신청서 작성
	Program Code : DB01001
******************************************************************************************************/
%>
<!DOCTYPE html>
<html>
<head>

	
	<style type="text/css">
		input.ov_readonly{
			background: #d6dde7;
    		border: 1px solid #d6dde7;
		}
	</style>
	
	
</head>
<body>

<div id="content">
	<section id="widget-grid-DB01001" class=""> 
		<form:form id="DB01001-form" class="s4-form" novalidate="novalidate" onsubmit="return false;">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<input type="hidden" id="P_OVER_DRWBAK_PRESENTN_NO" name="P_OVER_DRWBAK_PRESENTN_NO" value="${reqParam.P_OVER_DRWBAK_PRESENTN_NO }"/>
			<input type="hidden" id="WORK_TYPE" name="WORK_TYPE"/>
			<input type="hidden" id="ADAMT_PRESENTN_NO" name="ADAMT_PRESENTN_NO"/>
			<input type="hidden" id="PRE_REGIST_RCEPT_NO" name="PRE_REGIST_RCEPT_NO" value="${reqParam.P_PRE_REGIST_RCEPT_NO }"/>
			<input type="hidden" id="OVER_REGIST_RCEPT_NO" name="OVER_REGIST_RCEPT_NO" value="${reqParam.P_OVER_REGIST_RCEPT_NO }"/>
			<div class="row" style="display: none;">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 10px;margin-top: 15px;">
					<div class="table-responsive of-hidden">
						<table class="table table-bordered">
							<colgroup>
								<col/>
								<col style="width:100px;" />
								<col style="width:70px;" />
								<col style="width:80px;" />
								<col style="width:100px;" />
								<col style="width:100px" />
								<col style="width: 80px;" />
							</colgroup>
							<tbody>
								<tr>
									<th>제출번호</th>
									<th>신청관세사</th>
									<th colspan="3">접수번호</th>
									<td rowspan="2" style="padding-top: 15px;">
										<label class="label" style="margin-bottom: 15px;">접수일자</label>
										<label class="input">
											<input type="text" id="ADAMT_RCEPT_DATE"  name="ADAMT_RCEPT_DATE" style="width:99%;background: #d6dde7;" class="inputText" value="" readonly="readonly"/>
										</label>
									</td>
									
									<td rowspan="2" style="padding-top: 15px;">
										<label class="label">처리기간</label>
										<label class="input">3일</label>
										
									</td>
								</tr>
								<tr>
									<td><input type="text" id="ADAMT_SEND_RCEPT_NO"  name="ADAMT_SEND_RCEPT_NO" style="width:99%;height: 41px;background: #d6dde7;" class="inputText" value="" readonly="readonly"/></td>
									<td><input type="text" id="RCEPT_CSTBRKR"  name="RCEPT_CSTBRKR" style="width:99%;height: 41px;background: #d6dde7;" class="inputText" value="" readonly="readonly"/></td>
									<td>
										<label class="label" style="font-size: 11px;margin-bottom: 0px;">세관부호</label>
										<label class="input">
											<input type="text" id="RCEPT_CSMHSE_CODE"  name="RCEPT_CSMHSE_CODE" style="width:99%;height: 22px;background: #d6dde7;" class="inputText" value="" readonly="readonly"/>
										</label>
									</td>
									<td>
										<label class="label" style="font-size: 11px;margin-bottom: 0px;">연도</label>
										<label class="input">
											<input type="text" id="RCEPT_YYYY"  name="RCEPT_YYYY" style="width:99%;height: 22px;background: #d6dde7;" class="inputText" value="" readonly="readonly"/>
										</label>
									</td>
									<td>
										<label class="label" style="font-size: 11px;margin-bottom: 0px;">일련번호</label>
										<label class="input">
											<input type="text" id="RCEPT_SEQ"  name="RCEPT_SEQ" style="width:99%;height: 22px;background: #d6dde7;" class="inputText" value="" readonly="readonly"/>
										</label>
									</td>
	
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row" style="margin-top: 15px;">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 10px;">
					<div class="table-responsive of-hidden">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:100px;" />
								<col style="width:" />
								<col style="width:" />
								<col style="width: ;" />
							</colgroup>
							<tbody>
								<tr>
									<th rowspan="2" style="vertical-align: middle;">신고인</th>
									<td>
										<section style="margin-bottom: 0px;">
											<label class="label">상호</label>
											<label class="input">
												<input type="text" id="RCEPT_COMPANY_NAME"  name="RCEPT_COMPANY_NAME" style="width:99%;background: #d6dde7;" class="inputText" readonly="readonly"/>
											</label>
										</section>
									</td>
									<td>
										<section style="margin-bottom: 0px;">
											<label class="label">대표자</label>
											<label class="input">
												<input type="text" id="RCEPT_RPRSNTV_NM"  name="RCEPT_RPRSNTV_NM" style="width:99%;background: #d6dde7;" class="inputText" placeholder="홍길동" readonly="readonly"/>
											</label>
										</section>
									</td>
									<td>
										<section style="margin-bottom: 0px;">
											<label class="label">통관고유번호</label>
											<label class="input">
												<input type="text" id="ECTMRK"  name="ECTMRK" style="width:99%;background: #d6dde7;" class="inputText" placeholder="1234567" readonly="readonly"/>
											</label>
										</section>
									</td>
								</tr>
								<tr>
									<td>
										<section style="margin-bottom: 0px;">
											<label class="label">사업자등록번호</label>
											<label class="input">
												<input type="text" id="BIZRNO"  name="BIZRNO" style="width:99%;background: #d6dde7;" class="inputText" placeholder="1438500115" readonly="readonly"/>
											</label>
										</section>
									</td>
									<td>
										<section style="margin-bottom: 0px;">
											<label class="label">주소</label>
											<label class="input">
												<input type="text" id="ADDRESS"  name="ADDRESS" style="width:99%;background: #d6dde7;" class="inputText" placeholder="서울특별시 중구 세종대로 110" readonly="readonly"/>
											</label>
										</section>
										
									</td>
									
									<td>
										<section style="margin-bottom: 0px;">
											<label class="label">관세사 부호(필수)</label>
											<label class="input">
												<input type="text" id="CSTBRKR"  name="CSTBRKR" style="width:99%;background: #d6dde7;" class="inputText" placeholder="관세사부호를 입력해주세요"/>
											</label>
										</section>
										
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row" style="display: none;">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 10px;">
					<h5 style="text-align: center;margin: 10px 0px 10px 0px; font-weight: bold;">지급신청 가산금액 합계</h5>
					<div class="table-responsive of-hidden">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:14%;"/>
								<col style="width:14%;"/>
								<col style="width:14%;"/>
								<col style="width:14%;"/>
								<col style="width:14%;"/>
								<col style="width:14%;"/>
								<col style="width: ;" />
							</colgroup>
							<tbody>
								<tr>
									<th style="text-align: center">관세 가산금</th>
									<th style="text-align: center">개소세 가산금</th>
									<th style="text-align: center">교통세 가산금</th>
									<th style="text-align: center">교육세 가산금</th>
									<th style="text-align: center">주세 가산금</th>
									<th style="text-align: center">농특세 가산금</th>
									<th style="text-align: center">합계</th>
								</tr>
								<tr>
									<td class="info" style="height:30px;text-align: center;padding: 8px 5px 0px 4px;">
										<input type="text" id="OVER_CSTMS"  name="OVER_CSTMS" style="width:99%;text-align:right;" class="inputText ov_readonly" readonly="readonly"/>
									</td>
									<td class="info" style="height:30px;text-align: center;padding: 8px 5px 0px 4px;">
										<input type="text" id="OVER_INTTAX"  name="OVER_INTTAX" style="width:99%;text-align:right;" class="inputText ov_readonly" readonly="readonly"/>
									</td>
									<td class="info" style="height:30px;text-align: center;padding: 8px 5px 0px 4px;">
										<input type="text" id="OVER_TRANTAX"  name="OVER_TRANTAX" style="width:99%;text-align:right;" class="inputText ov_readonly" readonly="readonly"/>
									</td>
									<td class="info" style="height:30px;text-align: center;padding: 8px 5px 0px 4px;">
										<input type="text" id="OVER_ECX_AMOUNT"  name="OVER_ECX_AMOUNT" style="width:99%;text-align:right;" class="inputText ov_readonly" readonly="readonly"/>
									</td>
									<td class="info" style="height:30px;text-align: center;padding: 8px 5px 0px 4px;">
										<input type="text" id="OVER_LQTX_AMOUNT"  name="OVER_LQTX_AMOUNT" style="width:99%;text-align:right;" class="inputText ov_readonly" readonly="readonly"/>
									</td>
									<td class="info" style="height:30px;text-align: center;padding: 8px 5px 0px 4px;">
										<input type="text" id="OVER_AGSPT"  name="OVER_AGSPT" style="width:99%;text-align:right;" class="inputText ov_readonly" readonly="readonly"/>
									</td>
									<td class="info" style="height:30px;text-align: center;padding: 8px 5px 0px 4px;">
										<input type="text" id="OVEER_SUM"  name="OVEER_SUM" style="width:99%;text-align:right;" class="inputText ov_readonly" readonly="readonly"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 10px;">
					<h5 style="text-align: center;margin: 10px 0px 10px 0px; font-weight: bold;">지급신청 가산금액 상세 내역</h5>
					<div id="div_oTui_DB01001_01" name="div_oTui_DB01001_01" class="tuigrid-resiz
					able">
						<div id="oTui_DB01001_01" data-fixed-height="400"></div>
						<!-- <div id="oTui_DB01001_01_paging"></div> -->
					</div>
					<div class="note">
						<strong>※ </strong> 지급신청 간이 추가로 있을 경우 가산금액 지급신청서 (을)지에 기재
					</div>
				</div>
			</div>
			<div class="row" style="display: none;">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 10px;">
					<div class="table-responsive of-hidden">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:70px" />
								<col style="width: ;" />
								<col style="width: ;" />
							</colgroup>
							<tbody>
								<tr>
									<th rowspan="2">지급은행</th>
									<td>
										<section style="margin-bottom: 0px;">
											<label class="label">은행명</label>
											<label class="input">
												<input type="text" id="BANK_NM"  name="BANK_NM" style="width:99%;" class="inputText" value=""/>
											</label>
										</section>
									</td>
									<td>
										<section style="margin-bottom: 0px;">
											<label class="label">은행코드번호</label>
											<label class="input">
												<input type="text" id="BANK_CODE"  name="BANK_CODE" style="width:99%;" class="inputText" value=""/>
											</label>
										</section>
									</td>
								</tr>
								
								<tr>
									<td colspan="2">
										<section style="margin-bottom: 0px;" >
											<label class="label">온라인 구좌번호</label>
											<label class="input">
												<input type="text" id="ACNUTNO"  name="ACNUTNO" style="width:99%;" class="inputText" value=""/>
											</label>
										</section>
									</td>
									
								</tr>
								
								
								<tr>
									<td colspan="3">
										<label class="label">「수출용원재료에 대한 관세 등 환급에 관한 특례법 시행령」 제 21조 제6항에 따라 같은 법 제 14조 제1항 제3호에 따라7 환급금에 해당하는 가산금액을 지급신청합니다.</label>
										<label class="label" style="text-align: right;" >
											<span id="TXT_RECEIP_YYYYMMDD_FOOT">YYYY-MM-DD</span>
											
										</label>
										<label class="label" style="text-align: right;" >
											신고인<span id="SPAN_RPRSNTV_NM" style="margin-left: 25px;"></span> (서명 또는 인)
										</label>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="btn-group" style="width:100%; text-align: right;">
				<a href="javascript:DB01001.createDocument();" id="btn-next" class="btn btn-primary btn-xs" style="float: right;" ><i class="fa fa-chevron-right"></i> Save</a>
			</div>  
		</form:form>
	</section>
</div>

<script type="text/javascript">


	var oTui_DB01001_01;
	var DB01001 = new function() {
		
		this.initialize_viewObject = function(){

		}
		
		this.initialize_TuiGrid = function(){
			
			var complexColumns =  [
	            
	            {
	                title: "추징내역",
	                name: "mergeColumn1",
	                childNames: ["IDV_PAMT_NO", "IDV_PAMT_DATE","TAX_TYPE","PRE_DRWBAK_AMOUNT","ADAMT"]
	            },
	            {
	                title: "추가환급내역",
	                name: "mergeColumn2",
	                childNames: ["OVER_REGIST_RCEPT_NO", "PROPER_REGIST_RCEPT_NO", "PROPER_DRWBAK_AMOUNT"]
	            }
	        ];
			
			

			var colArrayInfo = [
				{ "name" : "PRE_REGIST_RCEPT_NO",   "header" : "최초환급 접수번호",  "align" :"center"    ,"width" : 140,"hidden" : false
				    , editOptions: {type: 'select',listItems: [{text: KpackageOBJ.object.getFormValue("DB01001-form","PRE_REGIST_RCEPT_NO"), value: KpackageOBJ.object.getFormValue("DB01001-form","PRE_REGIST_RCEPT_NO")}]}
				},
				{ "name" : "IDV_PAMT_NO",          	"header" : "개별납부 고지서번호","align" :"center"    ,"width" : 120,"hidden" : false, editOptions: {type: "text"}},
				{ "name" : "IDV_PAMT_DATE",         "header" : "개별납부일자",     	"align" :"center"    ,"width" : 110,"hidden" : false, editOptions: {type: "text"}},
				{ "name" : "TAX_TYPE",          	"header" : "세목",     			"align" :"center"    ,"width" : 110,"hidden" : false
				    , editOptions: {type: 'select',listItems: [{text: '관세', value: "111"}
				    											,{text: '개별소비세', value: "522"}
				    											,{text: '교통세', value: "611"}
				    											,{text: '주세', value: "531"}
				    											,{text: '교육세', value: "621"}
				    											,{text: '농특세', value: "631"}
				    										   ]
		                            }
				},
				{ "name" : "PRE_DRWBAK_AMOUNT",     "header" : "과다환급금",     	"align" :"right"    ,"width" : 110,"hidden" : false, editOptions: {type: "text"}},
				{ "name" : "ADAMT",          		"header" : "가산금",     		"align" :"right"    ,"width" : 110,"hidden" : false, editOptions: {type: "text"}},
				{ "name" : "OVER_REGIST_RCEPT_NO",  "header" : "과다환급 접수번호",      "align" :"center"    ,"width" : 150,"hidden" : false
				    , editOptions: {type: 'select',listItems: [{text: KpackageOBJ.object.getFormValue("DB01001-form","OVER_REGIST_RCEPT_NO"), value: KpackageOBJ.object.getFormValue("DB01001-form","OVER_REGIST_RCEPT_NO")}]}
				},
				{ "name" : "PROPER_REGIST_RCEPT_NO",  "header" : "추가환급접수번호",       "align" :"right"    ,"width" : 110,"hidden" : false, editOptions: {type: "text"}},
				{ "name" : "PROPER_DRWBAK_AMOUNT",  "header" : "추가환급금액",       "align" :"right"    ,"width" : 110,"hidden" : false, editOptions: {type: "text"}},
				{ "name" : "PAMT_REQ_ADAMT",        "header" : "지급신청 가산금액",  "align" :"right"    ,"width" : 110,"hidden" : false, editOptions: {type: "text"}},
				{ "name" : "PRESENTN_NO",     "header" : "가산금액 지급신청서(내부채번)",     "align" :"center"    ,"width" : 100,"hidden" : true}
			    
			    ];
			oTui_DB01001_01 = KpackageOBJ.tuiGrid.create("oTui_DB01001_01","/drawback/retrieve_adamtDetailData", colArrayInfo, "check", null, DB01001.onDblClick_oTui_Grid, null, null, complexColumns);
		       	
			var tools = [{icon:"insert", title:"행추가" ,text:"행추가"	,func:"DB01001.addRow_DB01001_01"}
						,{icon:"glyphicon glyphicon-ban-circle", title:"행삭제" ,text:"행삭제"	,func:"DB01001.deleteRow_DB01001_01"}];
	    	KpackageOBJ.tuiGrid.setButton("oTui_DB01001_01", tools); // Toobar 생성 */
		};
		
		
		this.addRow_DB01001_01 = function(){
		    KpackageOBJ.tuiGrid.appendRow("oTui_DB01001_01", 1);    
		}
		
		this.deleteRow_DB01001_01 = function(){
		    var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB01001_01");  
		    for(var inx = 0; inx <rowData.length; inx++){
		        KpackageOBJ.tuiGrid.removeRow("oTui_DB01001_01", rowData[inx]["rowKey"]);    
		    }
		    
		}
		
		this.onDblClick_oTui_Grid = function(gridId, rowkey, colName){};
		
		<% // 해더정보 조회 %>
		this.retrieve_Adamt_Information = function(){
			var params = { "P_OVER_DRWBAK_PRESENTN_NO"   : KpackageOBJ.object.getFormValue("DB01001-form","P_OVER_DRWBAK_PRESENTN_NO") };
			KpackageOBJ.ajax.doSubmit("/drawback/retrieve_01001Detail", params, DB01001.retrieve_Information_callback);	
		}

		this.retrieve_Information_callback = function(result){
			var data = result.value;
			
			if(data.ADAMT_PRESENTN_NO == undefined){
				KpackageOBJ.object.setFormValue("DB01001-form","WORK_TYPE", "I");
				
			}else{
				KpackageOBJ.object.setFormValue("DB01001-form","WORK_TYPE", "U");
				KpackageOBJ.object.setFormValue("DB01001-form", "ADAMT_PRESENTN_NO",data["ADAMT_PRESENTN_NO"]);
			}
			
			
			if(data["REGIST_RCEPT_NO"] != null){
				 $("#DB01001-form #REGIST_RCEPT_NO").html(data["REGIST_RCEPT_NO"]);
			}
			

			KpackageOBJ.object.setFormValue("DB01001-form", "ADAMT_PRESENTN_NO",data["ADAMT_PRESENTN_NO"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "DIVISION_CODE",data["DIVISION_CODE"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "ADAMT_SEND_RCEPT_NO",data["ADAMT_SEND_RCEPT_NO"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "RCEPT_CSTBRKR",data["RCEPT_CSTBRKR"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "RCEPT_CSMHSE_CODE",data["RCEPT_CSMHSE_CODE"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "RCEPT_YYYY",data["RCEPT_YYYY"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "RCEPT_SEQ",data["RCEPT_SEQ"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "ADAMT_RCEPT_DATE",data["ADAMT_RCEPT_DATE"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "OVER_CSTMS",data["OVER_CSTMS"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "OVER_INTTAX",data["OVER_INTTAX"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "OVER_ECX_AMOUNT",data["OVER_ECX_AMOUNT"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "OVER_AGSPT",data["OVER_AGSPT"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "OVER_TRANTAX",data["OVER_TRANTAX"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "OVER_LQTX_AMOUNT",data["OVER_LQTX_AMOUNT"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "BANK_CODE",data["BANK_CODE"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "BANK_NM",data["BANK_NM"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "ACNUTNO",data["ACNUTNO"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "RCEPT_COMPANY_NAME",data["RCEPT_COMPANY_NAME"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "RCEPT_RPRSNTV_NM",data["RCEPT_RPRSNTV_NM"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "ECTMRK",data["ECTMRK"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "BIZRNO",data["BIZRNO"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "ADDRESS",data["ADDRESS"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "OVER_DRWBAK_PRESENTN_NO",data["OVER_DRWBAK_PRESENTN_NO"]);
			KpackageOBJ.object.setFormValue("DB01001-form", "CSTBRKR",data["CSTBRKR"]);
			//KpackageOBJ.object.setFormValue("DB01001-form", "PRE_REGIST_RCEPT_NO",data["PRE_REGIST_RCEPT_NO"]);
			$("#SPAN_RPRSNTV_NM").html(data["RPRSNTV_NM"]);
			
			
			if(!oUtil.isNull(KpackageOBJ.object.getFormValue("DB01001-form", "ADAMT_PRESENTN_NO"))){
			    
			    var param = {
			            "PRESENTN_NO" : KpackageOBJ.object.getFormValue("DB01001-form", "ADAMT_PRESENTN_NO")
			    };
			    KpackageOBJ.tuiGrid.retrieve("oTui_DB01001_01", "", param);
			}
		}
		
		this.createDocument = function(){
		    var rowData = KpackageOBJ.tuiGrid.getRowsData("oTui_DB01001_01");
		    var validationFlag = false;

		    if(rowData.length < 1){
		        alert("저장할 데이터가 없습니다. 지급신청 가산금액 상세 내역을 작성해주세요 ");
		        return;
		    }
		    
		    if("" == KpackageOBJ.object.getFormValue("DB01001-form", "CSTBRKR")){
		        alert("신청 관세사 코드는 필수 입력항목입니다.");
		        return;
		    }
		    
		    
		    for(var inx = 0; inx < rowData.length; inx++){
		        if("" == rowData[inx]["PRE_REGIST_RCEPT_NO"]){
		            alert("최초환급 접수번호를 입력해주세요");
		            validationFlag =  true;
		            break;
		        }
		        if("" == rowData[inx]["IDV_PAMT_NO"]){
		            alert("개별납부 고지서번호를 입력해주세요");
		            validationFlag =  true;
		            break;
		        }
		        if("" == rowData[inx]["IDV_PAMT_DATE"]){
		            alert("개별납부일자를 입력해주세요");
		            validationFlag =  true;
		            break;
		        }
		        if(8 != rowData[inx]["IDV_PAMT_DATE"].length){
		            alert("개별납부일자를 날짜형식에 맞춰 올바르게 입력해주세요. ex) 20241231");
		            validationFlag =  true;
		            break;
		        }
		        
		        if("" == rowData[inx]["TAX_TYPE"]){
		            alert("세목을 입력해주세요");
		            validationFlag =  true;
		            break;
		        }
		        if("" == rowData[inx]["PRE_DRWBAK_AMOUNT"]){
		            alert("과다환급금을 입력해주세요");
		            validationFlag =  true;
		            break;
		        }
		        
		        if("" == rowData[inx]["ADAMT"]){
		            alert("가산금을 입력해주세요");
		            validationFlag =  true;
		            break;
		        }
		        if("" == rowData[inx]["OVER_REGIST_RCEPT_NO"]){
		            alert("환급 접수번호를 입력해주세요");
		            validationFlag =  true;
		            break;
		        }
		        
		        if("" == rowData[inx]["PROPER_REGIST_RCEPT_NO"]){
		            alert("추가환급접수번호를 입력해주세요");
		            validationFlag =  true;
		            break;
		        }
		        
		        if("" == rowData[inx]["PROPER_DRWBAK_AMOUNT"]){
		            alert("추가환급금액를 입력해주세요");
		            validationFlag =  true;
		            break;
		        }
		        if("" == rowData[inx]["지급신청 가산금액"]){
		            alert("지급신청 가산금액을 입력해주세요");
		            validationFlag =  true;
		            break;
		        }
		    }
			
			if(validationFlag){
			    return;
			}
		    var postData = { 
		            			"PRESENTN_NO" : KpackageOBJ.object.getFormValue("DB01001-form", "ADAMT_PRESENTN_NO")
		            			,"WORK_TYPE" :  KpackageOBJ.object.getFormValue("DB01001-form", "WORK_TYPE")
		            			,"ADAMT_LIST" : rowData
		                   }
			
			KpackageOBJ.ajax.doSubmit("/drawback/merge_adamtData", postData, DB01001.createDocument_CallBacHandler);
		}
		
		this.createDocument_CallBacHandler = function(result){
			if("" != result.message){
				alert(result.message);	
			}
			DB01001.retrieve_Adamt_Information();
			KpackageOBJ.dialog.close("dialog_DB01001");    
			
			
		}
	}

	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB01001.initialize_viewObject();	// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		DB01001.initialize_TuiGrid();		// Toast Grid Render

		DB01001.retrieve_Adamt_Information();
		
	});

</script>
	
</body>
</html>