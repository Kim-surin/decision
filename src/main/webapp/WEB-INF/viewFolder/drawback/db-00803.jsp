<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
/******************************************************************************************************
	Program Name : 기납증 연관매출 조회
	Program Code : DB00803
******************************************************************************************************/
%>
<!DOCTYPE html>
<html>
<head>

	
	
	
	
</head>
<body>
<div id="content">
	<section id="widget-grid-DB00803" class="">
		<form:form id="DB00803-form" class="s4-form" novalidate="novalidate" onsubmit="return false;">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<input type="hidden" id="PRESENTN_NO" name="PRESENTN_NO" value="${reqParam.PRESENTN_NO }"/>
		</form:form>
		
		<div class="row" style="margin-top: 10px;">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<p class="alert alert-info mb0">기납증 연관 매출 정보 </p></div>
		</div>
		<div class="row" style="margin-top: 20px;">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_DB00803_01" name="div_oTui_DB00803_01" class="tuigrid-resizable">
					<div id="oTui_DB00803_01" data-fixed-height="350"></div>
				</div>
			</div>
			
		</div>
	</section>
</div>

<script type="text/javascript">


	var oTui_DB00803_01;
	var DB00803 = new function() {
		this.initialize_viewObject = function(){
			
		}
		
		this.initialize_TuiGrid = function(){
			
			// 수출내역 정보 Grid
			var colArrayInfo = [

				{ "name" :"COMPANY_CODE",   	"header" : "회사코드",   	"align" :"center"   ,"width" : 100,"hidden" : false}, 
				{ "name" :"DIVISION_CODE",   	"header" : "사업부코드",   	"align" :"center"   ,"width" : 100,"hidden" : false}, 
				{ "name" :"PRESENTN_NO",	   	"header" : "내부관리번호", 	"align" :"center"   ,"width" : 100,"hidden" : false},
				{ "name" :"SUBMIT_NO",   		"header" : "제출번호",   	"align" :"center"   ,"width" : 100,"hidden" : false},
				{ "name" :"REGIST_RCEPT_NO",   	"header" : "접수번호",   	"align" :"center"   ,"width" : 100,"hidden" : false},
				{ "name" :"INVOICE_DATE",   	"header" : "매출일자",   	"align" :"center"   ,"width" : 100,"hidden" : false}, 
				{ "name" :"CUSTOMER_CODE",   	"header" : "고객사코드",   	"align" :"center"   ,"width" : 100,"hidden" : false}, 
				{ "name" :"CUSTOMER_NAME",   	"header" : "고객사 명",   	"align" :"center"   ,"width" : 100,"hidden" : false}, 
				{ "name" :"SALES_NO",   		"header" : "매출번호",   	"align" :"center"   ,"width" : 100,"hidden" : false}, 
				{ "name" :"SALES_SEQ",   		"header" : "매출순번",   	"align" :"center"   ,"width" : 100,"hidden" : false},
				{ "name" :"TAX_INVOICE_NO",   	"header" : "세금계산서번호",	"align" :"right"    ,"width" : 100,"hidden" : false},
				{ "name" :"SALES_DOC_NO",   	"header" : "영업문서번호",	"align" :"right"    ,"width" : 100,"hidden" : false},
				{ "name" :"PAY_NO",			   	"header" : "전표번호",		"align" :"right"    ,"width" : 100,"hidden" : false},
				{ "name" :"PDI_NO",			   	"header" : "PDI번호",		"align" :"right"    ,"width" : 100,"hidden" : false},
				{ "name" :"ITEM_CODE",   		"header" : "제품코드",   	"align" :"center"   ,"width" : 100,"hidden" : false}, 
				{ "name" :"ITEM_NM",   			"header" : "품명",   		"align" :"left"    	,"width" : 100,"hidden" : false}, 
				{ "name" :"ACCMLT_ORDER_QY",   	"header" : "신청 수량",   	"align" :"right"    ,"width" : 100,"hidden" : false}, 
				{ "name" :"BASS_UNIT",   		"header" : "단위",   		"align" :"center"   ,"width" : 100,"hidden" : false}, 
				{ "name" :"REG_AMOUNT",   		"header" : "신청 금액",   	"align" :"right"    ,"width" : 100,"hidden" : false}, 
				{ "name" :"SALES_AMOUNT",   	"header" : "매출 금액",   	"align" :"right"    ,"width" : 100,"hidden" : false}
				

		    ];
			  
            var tools = [ 
                {icon:"print", title:"엑셀다운로드"                ,text:"엑셀다운로드"                ,func:"DB00803.downloadExcelData"}
            ];
            KpackageOBJ.tuiGrid.setButton("oTui_DB00803_01", tools); // Toobar 생성
			oTui_DB00803_01 = KpackageOBJ.tuiGrid.create("oTui_DB00803_01","/drawback/retrieve_DB00803_trget", colArrayInfo, "number", null, null);
	    	
		};
		
		
		
		this.retrieve_List = function(){
			var param = KpackageOBJ.data.makePostData("DB00803-form");
			KpackageOBJ.tuiGrid.retrieve("oTui_DB00803_01", "/drawback/retrieve_DB00803_trget", param);
		}
		
		this.downloadExcelData = function(){
			var gridDataList = KpackageOBJ.tuiGrid.getRowsData("oTui_DB00803_01");
			
			if(gridDataList.length > 0){
				KpackageOBJ.tuiGrid.exportXlsx("oTui_DB00803_01");
			}else{
				alert("다운로드할 데이터가 없습니다.");
			}
			
		}
		
		
		
		
	}

	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB00803.initialize_viewObject();	// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		DB00803.initialize_TuiGrid();		// Toast Grid Render
		DB00803.retrieve_List();
		
	});

</script>
	
</body>
</html>