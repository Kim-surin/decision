<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="content">

<form:form id="SAMPLE000-form" novalidate="novalidate" class="s4-form" onsubmit="return false;" method="post">
	<div class="row">
		<div class="card mb-g border shadow-0 col-11">
			<div class="card-body p-0">
			    <div class="row g-0 row-grid">
			        <!-- thread -->
		            <div class="col-12">
		                <div class="row g-0 row-grid align-items-stretch">
		                    <div class="col-1">
		                        <div class="p-3"><label class="form-label" for="aaa">날짜 달력</label></div>
		                    </div>
		                    <div class="col-3">
		                        <div class="p-3"><input type="date" id="aaa" class="form-control"></div>
		                    </div>
		                    <div class="col-1">
		                        <div class="p-3"><label class="form-label" for="bbb">월달력</label></div>
		                    </div>
		                    <div class="col-3">
		                        <div class="p-3"><input type="month" id="bbb" class="form-control"></div>
		                    </div>
		                    <div class="col-1">
		                        <div class="p-3"><label class="form-label" for="ccc">Text</label></div>
		                    </div>
		                    <div class="col-3">
		                        <div class="p-3"><input type="text" id="ccc" class="form-control"></div>
		                    </div>
		                </div>
		            </div>
		            <div class="col-12">
		                <div class="row g-0 row-grid align-items-stretch">
		                    <div class="col-1">
		                        <div class="p-3"><label class="form-label" for="simpleinput">Text</label></div>
		                    </div>
		                    <div class="col-2">
		                        <div class="p-3"><input type="text" id="simpleinput" class="form-control"></div>
		                    </div>
		                    <div class="col-1">
		                        <div class="p-3"><label class="form-label" for="simpleinput">Text</label></div>
		                    </div>
		                    <div class="col-2">
		                        <div class="p-3"><input type="text" id="simpleinput" class="form-control"></div>
		                    </div>
		                    <div class="col-1">
		                        <div class="p-3"><label class="form-label" for="simpleinput">Text</label></div>
		                    </div>
		                    <div class="col-2">
		                        <div class="p-3"><input type="text" id="simpleinput" class="form-control"></div>
		                    </div>
		                    <div class="col-1">
		                        <div class="p-3"><label class="form-label" for="simpleinput">Text</label></div>
		                    </div>
		                    <div class="col-2">
		                        <div class="p-3"><input type="text" id="simpleinput" class="form-control"></div>
		                    </div>
		                </div>
		            </div>
				</div>
			</div>
		</div>
		<div class="col-1">
			<div class="p_rem-0.3">
				<%/* class p-5의 숫자를 변경하여 사이즈 변경 */ %>
				<button data-toggle="button" class="p-5 btn btn-outline-danger waves-effect waves-themed" onclick="javascript:SAMPLE000.retrieve_gridData();">Search</button>
			</div>
		</div>
		
	</div>

	
</form:form>

	<div class="row">
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<div id="div_oTui_CsPurchase" name="div_oTui_CsPurchase" class="tuigrid-resizable">
				
				<div id="oTui_CsPurchase" data-minus-height="400"></div>
				<div id="oTui_CsPurchase_paging"></div>
			</div>
		</div>
	</div>
</div> 
<script type="text/javascript">
	
	var SAMPLE000 = new function(){
		
		// Page Object Initialize
		this.initialize_Object = function() {
			var fromDay = KpackageOBJ.date.getCurrMonth() + "01";
            var toDay = KpackageOBJ.date.getCurrMonth() + KpackageOBJ.date.lastDay(KpackageOBJ.date.getCurrMonth());
            
			KpackageOBJ.calendar.create("SAMPLE000-form", "CAL_SEARCH_FROM_DATE");
            KpackageOBJ.calendar.setValue("SAMPLE000-form","CAL_SEARCH_FROM_DATE", fromDay);
            KpackageOBJ.object.setFormValue("SAMPLE000-form","SEARCH_FROM_DATE", fromDay);
            
            KpackageOBJ.calendar.create("SAMPLE000-form", "CAL_SEARCH_TO_DATE");
            KpackageOBJ.calendar.setValue("SAMPLE000-form","CAL_SEARCH_TO_DATE", toDay);
            KpackageOBJ.object.setFormValue("SAMPLE000-form","SEARCH_TO_DATE",toDay);

			/* 기본 검색 구문 */
			KpackageOBJ.selectbox.create("SAMPLE000-form", "SEARCH_SYSTEM_BATCH_YN", "", null, "value", "name", arrayItem);
			
			var arrayItem = [{value:"SEARCH_TYPE_O1", name:"고객사 코드"}
						    ,{value:"SEARCH_TYPE_O2", name:"아이템 코드"}];

			KpackageOBJ.selectbox.create("SAMPLE000-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*
			arrayItem = [{value:"CC", name:"Contains"}
            			,{value:"EQ", name:"Equal To"}
			 			,{value:"SW", name:"Starts With Is"}];

			KpackageOBJ.selectbox.create("SAMPLE000-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			*/
		}
		


		
		this.initialize_TuiGrid = function() {
			
			var colArrayInfo = [
				
				{"header" :"플랜트"              ,"name" :"DIVISION_NAME"           ,"width" : 80      ,"align" : "center"    ,"hidden" : false},
				{"header" :"근거서류번호"        ,"name" :"SUPT_DOC_NO"             ,"width" : 100      ,"align" : "center"    ,"hidden" : false},
				{"header" :"근거서류일자"        ,"name" :"SUPT_DATE"               ,"width" : 100      ,"align" : "center"    ,"hidden" : false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
				{"header" :"고객사명"            ,"name" :"ATTRIBUTE01"             ,"width" : 250      ,"align" : "left"      ,"hidden" : false},
				{"header" :"근거서류구분"        ,"name" :"CODE_NM"                 ,"width" : 100      ,"align" : "center"    ,"hidden" : false},
				{"header" :"품목수"              ,"name" :"ITEM_CNT"                ,"width" : 80       ,"align" : "right"     ,"hidden" : false, "formatter" : KpackageOBJ.tuiGrid.commas },
				{"header" :"총 수량"             ,"name" :"SUM_QY"                  ,"width" : 80       ,"align" : "right"     ,"hidden" : false, "formatter" : KpackageOBJ.tuiGrid.commas },
				{"header" :"총 금액"             ,"name" :"SUM_AMOUNT"              ,"width" : 100      ,"align" : "right"     ,"hidden" : false, "formatter" : KpackageOBJ.tuiGrid.commas },
				{"header" :"신청인명"            ,"name" :"ACCEPTOR_NM"             ,"width" : 200      ,"align" : "left"      ,"hidden" : false},
				{"header" :"신청인주소"          ,"name" :"ACCEPTOR_ADDR"           ,"width" : 250      ,"align" : "left"      ,"hidden" : false},
				{"header" :"신청인 사업자번호"   ,"name" :"ACCEPTOR_BIZ_NO"         ,"width" : 110      ,"align" : "center"    ,"hidden" : false},
				/* 
				{"header" :"공급자명"            ,"name" :"PRODUCER_NM"             ,"width" : 100      ,"align" : "left"      ,"hidden" : false},
				{"header" :"공급자 주소"         ,"name" :"PRODUCER_ADDR"           ,"width" : 200      ,"align" : "left"      ,"hidden" : false}, 
				{"header" :"공급자 사업자번호"   ,"name" :"PRODUCER_BIZ_NO"         ,"width" : 100      ,"align" : "center"    ,"hidden" : false},
				*/
				{"header" :"근거서류구분"        ,"name" :"SUPT_DOC_SE"             ,"width" : 100      ,"align" : "center"    ,"hidden" : true},
				{"header" :"DIVISION_CODE"       ,"name" :"DIVISION_CODE"           ,"width" : 100      ,"align" : "center"    ,"hidden" : true},
				{"header" :"CUSTOMER_CODE"       ,"name" :"CUSTOMER_CODE"           ,"width" : 100      ,"align" : "center"    ,"hidden" : true},
				{"header" :"근거서류코드(내부)"  ,"name" :"SUPT_DOC_CODE"           ,"width" : 100      ,"align" : "center"    ,"hidden" : true}
		    ];
			
			var tools = [ 
			     {icon:"none",  title:"상세조회"        ,text:"상세조회"        ,func:"SAMPLE000.openDetailPage"}
			     ,{icon:"excel", title:"엑셀다운로드"    ,text:"엑셀다운로드"  ,func:"SAMPLE000.excel_SAMPLE000List"}

			  ];
			KpackageOBJ.tuiGrid.setButton("oTui_CsPurchase", tools); // Toobar 생성
			KpackageOBJ.tuiGrid.create("oTui_CsPurchase","/cusven/retrieve_SAMPLE000List", colArrayInfo, null, null, this.oTui_CsPurchase_onDblclick_Handler);
			
		}
		
		this.retrieve_gridData = function() {
			var param = KpackageOBJ.data.makePostData("SAMPLE000-form");
			KpackageOBJ.tuiGrid.retrieve("oTui_CsPurchase","", param);
		}
		
		/* Dbl Click Handler */
		this.oTui_CsPurchase_onDblclick_Handler = function(p_GridId, p_RowKey, p_ColName){
			SAMPLE000.openDetailPage(p_RowKey);
		}
		
		
		/** 상세페이지 호출 */
        this.openDetailPage = function(rowKey){
            var rowData = KpackageOBJ.tuiGrid.getRowValues("oTui_CsPurchase", rowKey);
            
            var getParams = "?DIALOG_ID="           + "dialog_SAMPLE00001"
                            + "&PGMID="             +  "SAMPLE00001"
                            + "&P_SUPT_DOC_NO="     +  rowData.SUPT_DOC_NO
                            + "&P_SUPT_DOC_CODE="   +  rowData.SUPT_DOC_CODE
                            + "&P_DIVISION_CODE="   +  rowData.DIVISION_CODE
                            + "&P_SUPT_DATE="       +  rowData.SUPT_DATE
                            + "&P_ATTRIBUTE01="     +  rowData.ATTRIBUTE01
                            + "&P_CODE_NM="         +  rowData.CODE_NM
                            + "&P_ITEM_CNT="        +  rowData.ITEM_CNT
                            + "&P_SUM_QY="          +  rowData.SUM_QY
                            + "&P_SUM_AMOUNT="      +  rowData.SUM_AMOUNT
                            ;
                            
            KpackageOBJ.dialog.open("dialog_SAMPLE00001", "고객사 구매확인서 상세", "/cv-00101" + getParams, 1145, 480);
            
        }
	}
	
	
	$(document).ready(function() {
		pageSetUp();				// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		//SAMPLE000.initialize_Object(); 		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		SAMPLE000.initialize_TuiGrid();		 
		
		
	});
	
</script>
</body>
</html>