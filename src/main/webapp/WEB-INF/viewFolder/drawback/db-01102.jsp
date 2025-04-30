<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
/******************************************************************************************************
	Program Name : 과다환급금 자진신고서 작성
	Program Code : DB01102
******************************************************************************************************/
%>
<!DOCTYPE html>
<html>
<head>

	
	
	
	
</head>
<body>
<div id="content">
	<section id="widget-grid-DB01102" class="">
		<form:form id="DB01102-form" class="s4-form" novalidate="novalidate" onsubmit="return false;">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<input type="hidden" id="DIVISION_CODE" name="DIVISION_CODE" value=""/>
			<input type="hidden" id="SEARCH_PRESENTN_NO" name="SEARCH_PRESENTN_NO" value="${reqParam.SEARCH_PRESENTN_NO }"/>
			<input type="hidden" id="SEARCH_REGIST_RCEPT_NO" name="SEARCH_REGIST_RCEPT_NO" value="${reqParam.SEARCH_REGIST_RCEPT_NO }"/>
			<input type="hidden" id="REQST_SE" name="REQST_SE" value=""/>
			<input type="hidden" id="CSTMR_NM" name="CSTMR_NM" value=""/>
			<input type="hidden" id="RPRSNTV_NM" name="RPRSNTV_NM" value=""/>
			<input type="hidden" id="dataList" name="dataList" value=""/>
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 10px;margin-top: 15px;">
					<div class="table-responsive of-hidden">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:150px;" />
								<col style="width: " />
								<col style="width:150px;" />
								<col style="width: ;" />
							</colgroup>
							<tbody>
								<tr>
									<th>신청번호</th>
									<td>
										<span id="TXT_MCRTF_REGIST_RCEPT_NO"></span>
									</td>
									<th>처리기간</th>
									<td>
										<span id="PROCESS_TERM"> 즉시</span>
									</td>
								</tr>
								<tr>
									<th>신청구분</th>
									<td colspan="3">
										<input type="radio" id="RB_REQST_SE" name="RB_REQST_SE" value="1" onclick="javascript:DB01102.changeReqstSe();" checked/>정정
										<input type="radio" id="RB_REQST_SE" name="RB_REQST_SE" style="margin-left:20px;" value="2" onclick="javascript:DB01102.changeReqstSe();"/>취하
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 10px;margin-top: 15px;">
					<div class="table-responsive of-hidden">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:150px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th rowspan="2" style="text-align: center;vertical-align:middle;">신청인</th>
									<td>
										<section style="margin-bottom: 0px;">
											<label class="label">상호</label>
											<label class="input">
												<span id="TXT_CSTMR_NM"></span>
											</label>
										</section>
									</td>
								</tr>
								<tr>
									<td>
										<section style="margin-bottom: 0px;">
											<label class="label">대표자</label>
											<label class="input">
												<span id="TXT_RPRSNTV_NM"></span>
											</label>
										</section>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 10px;">
					<h5 style="text-align: center;margin: 10px 0px 10px 0px; font-weight: bold;">이전 발급받은 제증명서 내역</h5>
					<div class="table-responsive of-hidden">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:16%;;"/>
								<col style="width: ;" />
							</colgroup>
							<tbody>
								<tr>
									<th style="text-align: center">정정서류</th>
									<td>
										<input type="checkbox" id="ISSUE_TYPE_02" name="ISSUE_TYPE_02" disabled />기초원재료납세증명서
										<input type="checkbox" id="ISSUE_TYPE_04" name="ISSUE_TYPE_04" style="margin-left:20px;" disabled />분할증명서
									</td>
								</tr>
								<tr>
									<th style="text-align: center">증명번호</th>
									<td>
										<span id="TXT_REGIST_RCEPT_NO">${reqParam.SEARCH_REGIST_RCEPT_NO }</span>
									</td>
								</tr>
								<tr>
									<th style="text-align: center">증명일자</th>
									<td>
										<span id="TXT_CHIT_FRMTRM_DATE"></span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 10px;">
					<h6 style="text-align: center;margin: 10px 0px 10px 0px; font-weight: bold;">정정내용</h6>
					<div id="MCRTF_UPDT_WTHDRW_DTL" name="MCRTF_UPDT_WTHDRW_DTL" style="width:100%; height:100%;">
					<div id="div_oTui_DB01102_List" name="div_oTui_DB01102_List" class="tuigrid-resizable">
						<div id="oTui_DB01102_List" data-fixed-height="200"></div>
					</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-bottom: 10px;">
					<div class="table-responsive of-hidden">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:70%" />
								<col style="width: ;" />
							</colgroup>
							<tbody>
								<tr>
									<td>
										<section>
											<label class="label">정정 사유</label>
											<label class="textarea textarea-resizable"> 										
												<textarea id="UPDT_REASON" name="UPDT_REASON" rows="3" class="custom-scroll" style="width: 99%"></textarea> 
											</label>
										</section>
									</td>
									<td>
										<section>
											<label class="label">첨부서류</label>
											<div class="note">
												<strong>Note:</strong> 별도첨부
												<br>1. 내국인신용장 등 계약 관련서류 등 정정(취하)사유를 확인할 수 있는 자료
												<br>2. 기 발급 증명서 (전산확인 곤란 등으로 공무원기 요구하는 경우에 한정함)
											</div>
											<label class="textarea textarea-resizable"> 										
												 
											</label>
										</section>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<label class="label">「수출용원재료에 대한 관세 등 환급에 관한 특례법 시행령」 제 31조 제1항 및 「수출용원재료에 대한 관세 등 환급사무처리에 관한 고시」 제25조에 따라 과다환급 받은 사실을 신고합니다.</label>
										<label class="label" style="text-align: right;" >
											<span id="TXT_RECEIP_YYYYMMDD_FOOT">YYYY-MM-DD</span>
											
										</label>
										<label class="label" style="text-align: right;" >
											신고인<span id="RCEPT_RPRSNTV_NM_FOOTER" style="margin-left: 45px;margin-right: 30px;">홍길동</span> (서명 또는 인)
										</label>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="btn-group" style="width:100%; text-align: right;">
				<a href="javascript:DB01102.createDocument();" id="btn-next" class="btn btn-primary btn-xs" style="float: right;" ><i class="fa fa-chevron-right"></i> Save</a>
			</div>  
		</form:form>
	</section>
</div>

<script type="text/javascript">


	var DB01102 = new function() {
		
		this.initialize_viewObject = function(){

		}
		
		this.initialize_TuiGrid = function(){
			 
			 var colArrayInfo = [
				 
					{ header : "순번"				,name : "SEQ"		,width : 100, align: "left" ,hidden:true },
					{ header : "정정항목"			,name : "UPDT_IEM"	,width : 200, align: "left" ,hidden:false, editOptions: {type: "text"}, validation : {required : true} },
					{ header : "변경전"			,name : "BFCHG"		,width : 300, align: "left" ,hidden:false, editOptions: {type: "text"}, validation : {required : true} },
					{ header : "변경후"			,name : "AFTCH"		,width : 300, align: "left" ,hidden:false, editOptions: {type: "text"}, validation : {required : true} },
					{ header : "항목삭제"			,name : "DEL"		,width : 100, align: "left" ,hidden:false, "formatter" : DB01102.formatter_buttonDel }
			    ];
			 
			 
			 var tools = [ {icon:"add",   title:"추가"					,text:"추가"				    ,func:"DB01102.addRow"}
				];
			 KpackageOBJ.tuiGrid.setButton("oTui_DB01102_List", tools); // Toobar 생성

			 KpackageOBJ.tuiGrid.create("oTui_DB01102_List", "", colArrayInfo, "rowNum", "", "");
		};
		
		this.onDblClick_oTui_Grid = function(gridId, rowkey, colName){};
		
		<% // 해더정보 조회 %>
		this.retrieve_Mcrtf_Information = function(){
			var params = { "SEARCH_PRESENTN_NO"   : KpackageOBJ.object.getFormValue("DB01102-form","SEARCH_PRESENTN_NO")
					       ,"SEARCH_REGIST_RCEPT_NO"   : KpackageOBJ.object.getFormValue("DB01102-form","SEARCH_REGIST_RCEPT_NO")};
			KpackageOBJ.ajax.doSubmit("/drawback/retrieve_DB01102Detail", params, DB01102.retrieve_Information_callback);	
		}

		this.retrieve_Information_callback = function(result){
			var data = result.value;
			
			$("#DB01102-form #DIVISION_CODE").val(data["DIVISION_CODE"]);
			
			$("#DB01102-form #TXT_RPRSNTV_NM").html(data["RPRSNTV_NM"]);
			$("#DB01102-form #TXT_CSTMR_NM").html(data["CSTMR_NM"]);
			
			$("#DB01102-form #RPRSNTV_NM").val(data["RPRSNTV_NM"]);
			$("#DB01102-form #CSTMR_NM").val(data["CSTMR_NM"]);
			
			if(data["ISSUE_TYPE"] == "02"){
				$("#DB01102-form #ISSUE_TYPE_02").attr("checked", true);
				$("#DB01102-form #ISSUE_TYPE_04").attr("checked", false);	
			}else{
				$("#DB01102-form #ISSUE_TYPE_02").attr("checked", false);
				$("#DB01102-form #ISSUE_TYPE_04").attr("checked", true);
			}
			
			if(data["REGIST_RCEPT_NO"] != null){
				 $("#DB01102-form #REGIST_RCEPT_NO").html(data["REGIST_RCEPT_NO"]);
			}
			
			$("#DB01102-form #TXT_CHIT_FRMTRM_DATE").html(data["CHIT_FRMTRM_DATE"]);
		}
		
		this.createDocument = function(){
			var registRceptNo = $("#DB01102-form #REGIST_RCEPT_NO").html();
			
			if(oUtil.isNull(registRceptNo) == ""){
				alert("증명번호가 존재하지 않습니다.");
// 				return;
			}

			var reqstSe = $("#DB01102-form input[name='RB_REQST_SE']:checked").val();
			
			var data = KpackageOBJ.tuiGrid.getRowsData("oTui_DB01102_List");
			
			if(reqstSe == "1"){
				if(data.length < 1){
					alert("정정 내용은 필수입력 항목입니다.");
					return;
				}
				
				var errMsg = KpackageOBJ.tuiGrid.validation("oTui_DB01102_List");
				if(errMsg != ""){
					alert(errMsg);
					return;
				}
				$("#DB01102-form #dataList").val(JSON.stringify(data));
			}
			
			var params = KpackageOBJ.data.makePostData("DB01102-form");
			
			if("" == params.UPDT_REASON){
				alert("정정 사유는 필수입력 항목 입니다.");
				return;
			}
			
			
			$("#DB01102-form #REQST_SE").val(reqstSe);
			
			params = KpackageOBJ.data.makePostData("DB01102-form");
			
			KpackageOBJ.ajax.doSubmit("/drawback/create_DB01102Detail", params, DB01102.createDocument_CallBacHandler);
		}
		
		this.createDocument_CallBacHandler = function(result){
			if("" != result.message){
				alert(result.message);	
			}
			DB011.retrieve_DB011List();
            KpackageOBJ.dialog.close("dialog_DB01102");
		}
		
		this.addRow = function(){
			KpackageOBJ.tuiGrid.insertRow("oTui_DB01102_List");
		}
		
		this.formatter_buttonDel = function(rowData){
			return "<a class='btn grid-add-btn btn-primary btn-border tuiGrid-toolbar-button' style='padding: 2px 19px;'  href=\"javascript:DB01102.gridAction('"+rowData.row.rowKey+"','DEL');\">" + "DEL" + '</a>';
		}
		 
		this.gridAction = function(rKey,action){
			if("DEL" == action){
				
				var rowValue = KpackageOBJ.tuiGrid.getRowValues("oTui_DB01102_List", rKey);
				
				if (confirm("Are you sure you want to delete the " + rowValue["UPDT_IEM"] + "  )?\n* It will be reflected when you save.")) {
					KpackageOBJ.tuiGrid.removeRow("oTui_DB01102_List", rKey);
				}
				
				
			}
			
		}
		
		this.changeReqstSe = function(){
			var reqstSe = $("#DB01102-form input[name='RB_REQST_SE']:checked").val();
			
			if(reqstSe == "1"){
				$("#DB01102-form #MCRTF_UPDT_WTHDRW_DTL").show();
			}else{
				$("#DB01102-form #MCRTF_UPDT_WTHDRW_DTL").hide();
			}
		}
	}

	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB01102.initialize_viewObject();	// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		DB01102.initialize_TuiGrid();		// Toast Grid Render

		DB01102.retrieve_Mcrtf_Information();
		
	});

</script>
	
</body>
</html>