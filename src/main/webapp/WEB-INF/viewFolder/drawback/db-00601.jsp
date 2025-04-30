<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
/******************************************************************************************************
	Program Name : 수출신고 조회 상세조회
	Program Code : DB00601
******************************************************************************************************/
%>
<!DOCTYPE html>
<html>
<head>
	
</head>
<style>
	.db00601_column{
	background-color:#fff797;
	}
</style>
<body>
<div id="content">
	<div class="widget-body">
		<form:form id="DB00601-form" class="s4-form" novalidate="novalidate" onsubmit="return false;">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<input type="hidden" id="P_CONFIRM_YN" name="P_CONFIRM_YN" value="${reqParam.CONFIRM_YN }"/>
			<input type="hidden" id="P_DIVISION_CODE" name="P_DIVISION_CODE" value="${reqParam.DIVISION_CODE }"/>
			<input type="hidden" id="P_EXPDECL_MANAGE_NO" name="P_EXPDECL_MANAGE_NO" value="${reqParam.EXPDECL_MANAGE_NO }"/>
			<input type="hidden" id="P_XPORT_STTEMNT_NO" name="P_XPORT_STTEMNT_NO" value="${reqParam.XPORT_STTEMNT_NO }"/>
			<input type="hidden" id="P_XPORT_STTEMNT_NO" name="P_HS_CODE" value="${reqParam.HS_CODE }"/>
			
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div class="table-responsive of-hidden">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:120px;" />
								<col style="width:300px;" />
								<col style="width:120px;" />
								<col style="width:300px;" />
								<col style="width:120px;" />
								<col style="width: ;" />
								
							</colgroup>
							<tbody>
								<tr>
									<th>수출신고번호</th>
									<td>
										<span id="XPORT_STTEMNT_NO"></span>
									</td>
									<th>제조자</th>
									<td>
										<span id="MANUFAC_NAME"></span>
									</td>
									<th>수출총건수</th>
									<td style="text-align:right; font-weight:bold;">
										<span id="ITEM_QTY"></span>
									</td>
								</tr>
								<tr>
									<th>수출신고수리일자</th>
									<td>
										<span id="DSPTH_DATE"></span>
									</td>
									<th>수출자</th>
									<td>
										<span id="COMPANY_NM"></span>
									</td>
									<th>확정건수</th>
									<td style="text-align:right; font-weight:bold;">
										<span id="CONFIRM_ITEM_QTY"></span>
									</td>
								</tr>
								<tr>
									<th>Invoice No.(대표)</th>
									<td>
										<span id="INV_NO"></span>
									</td>
									<th>목적국</th>
									<td>
										<span id="NATION_CODE"></span>
									</td>
									<th>미확정건수</th>
									<td style="text-align:right; font-weight:bold;">
										<span id="PENDING_ITEM_QTY"></span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</form:form>
		<div class="row" style="margin-top: 10px;">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_DB00601_List" name="div_oTui_DB00601_List" class="tuigrid-resizable">
					<div id="oTui_DB00601_List" data-fixed-height="280"></div>
					<!-- <div id="oTui_DB00601_01_paging"></div> -->
				</div>
			</div>
			
		</div>
	</div>
</div>

<script type="text/javascript">


// 	var oTui_DB00601_01
	var DB00601 = new function() {
		this.DIALOG_ID = "${reqParam.DIALOG_ID }";
		
		this.initialize_viewObject = function(){}
		
		this.initialize_TuiGrid = function(){
			
			// 수출내역 정보 Grid
			var colArrayInfo = [
				
				{ header : "란"               ,name :"LNE_NO"            ,width : 30      ,align :"center"     ,hidden: false, formatter : DB00601.setCodeNmColor },
				{ header : "행"               ,name :"POUCH_NO"          ,width : 30      ,align :"center"     ,hidden: false},
				{ header : "Invoice No"       ,name :"INV_NO"            ,width : 70      ,align :"center"     ,hidden: false},
				{ header : "HS CODE"          ,name :"HS_CODE"           ,width : 100     ,align :"center"     ,hidden: false, formatter : KpackageOBJ.tuiGrid.hscode10},
				{ header : "제품코드"         ,name :"ITEM_CODE"         ,width : 100     ,align :"left"       ,hidden: false},
				{ header : "제품명"           ,name :"ITEM_NM"           ,width : 200     ,align :"left"       ,hidden: false},
				{ header : "수출수량"         ,name :"ITEM_QTY"          ,width : 70      ,align :"right"      ,hidden: false, formatter : KpackageOBJ.tuiGrid.commas},
				{ header : "단위"             ,name :"SLE_UNIT"          ,width : 60      ,align :"center"     ,hidden: false},
				{ header : "수출신고금액"     ,name :"STTEMNT_PC_KRW"    ,width : 100     ,align :"right"      ,hidden: false, formatter : KpackageOBJ.tuiGrid.commas},
                                                                                                        
				{ header : "확정실패사유"     ,name :"CODE_NM"           ,width : 145     ,align :"left"       ,hidden: true },
				{ header : "최초확정시도일자" ,name :"CREATE_DATE"       ,width : 100     ,align :"center"     ,hidden: true, formatter : KpackageOBJ.tuiGrid.dateFormatter},
				{ header : "최종확정시도일자" ,name :"UPDATE_DATE"       ,width : 100     ,align :"center"     ,hidden: true, formatter : KpackageOBJ.tuiGrid.dateFormatter},
                                                                                                        
                                                                                                        
				{ header : "수출신고금액"     ,name :"FAIL_REASON_CODE"  ,width : 100     ,align :"right"      ,hidden: true},
				{ header : "수출신고번호"     ,name :"PRESENTN_NO"       ,width : 100     ,align :"center"     ,hidden: true},
				{ header : "수출신고번호"     ,name :"THNG_SEQ"          ,width : 100     ,align :"center"     ,hidden: true},
				{ header : "수출신고번호"     ,name : "XPORT_STTEMNT_NO" ,width : 150     ,align: "center"     ,hidden: true },
				{ header : "HS CODE"          ,name : "HS_CODE"          ,width : 100     ,align: "center"     ,hidden: true },
				{ header : "제조자"           ,name : "MANUFAC_NAME"     ,width : 200     ,align: "left"       ,hidden: true },
				{ header : "거래구분"         ,name : "XPORT_SE"         ,width : 100     ,align: "center"     ,hidden: true }
		    ];
			 
			 
			 /* var tools = [ {icon:"save",  title:"확정" 			,text:"확정" 			,func:"DB00601.makeCofirmData"}
						  ,{icon:"save",  title:"확정취소" 		,text:"확정취소" 		,func:"DB00601.removeCofirmData"}
				];
			 KpackageOBJ.tuiGrid.setButton("oTui_DB00601_List", tools); // Toobar 생성 */
			  
			KpackageOBJ.tuiGrid.create("oTui_DB00601_List","/drawback/retrieve_DB00601_exportList", colArrayInfo, "number", null, DB00601.onDblClick_oTui_Grid);
		};
		
		this.onDblClick_oTui_Grid = function(gridId, rowkey, colName){};
		
		<% // 해더정보 조회 %>
		this.retrieve_Header_Information = function(){
			var params = KpackageOBJ.data.makePostData("DB00601-form");
			KpackageOBJ.ajax.doSubmit("/drawback/retrieve_DB00601_header", params, DB00601.retrieve_Header_Information_callback);	
		}
		this.retrieve_Header_Information_callback = function(result){
			var data = result.value;
			
			$("#DB00601-form #XPORT_STTEMNT_NO").html(data["XPORT_STTEMNT_NO"]);
			$("#DB00601-form #MANUFAC_NAME").html(data["MANUFAC_NAME"]);
		    $("#DB00601-form #ITEM_QTY").html(KpackageOBJ.formatter.commas(data["ITEM_QTY"]));

		    $("#DB00601-form #DSPTH_DATE").html(KpackageOBJ.formatter.date(data["DSPTH_DATE"]));
			$("#DB00601-form #COMPANY_NM").html(data["COMPANY_NM"]);
		    $("#DB00601-form #CONFIRM_ITEM_QTY").html(KpackageOBJ.formatter.commas(data["CONFIRM_ITEM_QTY"]));
		    
			$("#DB00601-form #INV_NO").html(data["INV_NO"]);
			$("#DB00601-form #NATION_CODE").html(data["NATION_CODE"]);
		    $("#DB00601-form #PENDING_ITEM_QTY").html(KpackageOBJ.formatter.commas(data["PENDING_ITEM_QTY"]));

			DB00601.retrieve_DB00601List();
		}
		this.retrieve_DB00601List = function(){
			var param = KpackageOBJ.data.makePostData("DB00601-form");
			KpackageOBJ.tuiGrid.retrieve("oTui_DB00601_List", "/drawback/retrieve_DB00601_exportList", param);
		}
		
		/** 확정데이터 생성*/
		this.makeCofirmData = function(){
// 			var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB00601_List");
			var rowData = KpackageOBJ.tuiGrid.getRowValues("oTui_DB00601_List", 0, false);
			
			var rowArr = [];
			rowArr[0] = rowData;
			
			//KpackageOBJ.ajax.doSubmit("/drawback/confirm_DB006_xportList", rowArr, DB00601.makeCofirmData_callback);
			KpackageOBJ.ajax.doSubmit("/drawback/confirm_DB006_xportList_extn", rowArr, DB00601.makeCofirmData_callback);
			
		}
		
		this.makeCofirmData_callback = function(result){
			alert(result.message);
			DB006.retrieve_DB006List();
			KpackageOBJ.dialog.close(DB00601.DIALOG_ID);  
			
		}
		
		
		this.setCodeNmColor = function(rowData){
			//KpackageOBJ.tuiGrid.getGrid("oTui_DB00601_List").addCellClassName(rowData.row.rowKey,"CODE_NM","db00601_column");
			return rowData.value;
		}
		
		
	}

	$(document).ready(function() {
		pageSetUp();						// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB00601.initialize_viewObject();	// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		DB00601.initialize_TuiGrid();		// Toast Grid Render

		DB00601.retrieve_Header_Information();
		
		var tools = [{icon:"", title:"Save" ,text:"확정"	,func:"DB00601.makeCofirmData"}];
		KpackageOBJ.dialog.setButton(DB00601.DIALOG_ID, tools);
		
	});
</script>
	
</body>
</html>