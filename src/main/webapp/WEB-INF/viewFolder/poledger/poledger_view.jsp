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
		                        <div class="p-3"><label class="form-label" for="simpleinput">플랜트</label></div>
		                    </div>
		                    <div class="col-2">
		                       <select class="form-select" aria-label="Default select example" id = "inv_org">
										<option value="" selected>ALL</option>
										<!-- <option value="DKS101" selected>동광특수고무</option> -->
										 
								</select>
		                    </div>
		                    <div class="col-1">
		                        <div class="p-3"><label class="form-label" for="aaa">입고일자</label></div>
		                    </div>
		                    <div class="col-2">
									<input type="date" id="start_date" name="start_date" class="form-control">
									<input type="date" id="end_date" name="end_date" class="form-control">
							</div>								
							
		            </div>
		            <div class="col-12">
		                <div class="row g-0 row-grid align-items-stretch">
		                    <div class="col-1">
		                        <div class="p-3"><label class="form-label" for="simpleinput">검색조건</label></div>
		                    </div>
		                        <div class="col-2">
									<select class="form-select" aria-label="Default select example" id = "schKeyField">
										<option value="item_code" selected>자재코드</option>
										<option value="item_name">자재명</option>
										<option value="vendor_code">구매처코드</option>
										<option value="vendor_name">구매처</option>
										<option value="order_no">주문번호</option>
									</select>
									<input type="text" id="schKeyWord" name="schKeyWord" class="form-control">
		                    </div>
		                    
		                    <div class="col-1">
		                        <div class="p-3"><label class="form-label" for="simpleinput">구매형태</label></div>
		                    </div>
		                    <div class="col-2">
		                        <select class="form-select" aria-label="Default select example" id = "warehousing_type">
										<option value="" selected>ALL</option>
										<!-- <option value="item_name">외자</option>
										<option value="vendor_code">내자</option>
										<option value="vendor_name">공장간 대체</option>
										<option value="order_no">위탁</option> 
										<option value="order_no">기타</option> 
										-->
									</select>
		                    </div>
		                </div>
		            </div>
				</div>
			</div>
		</div>
		<div class="col-1">
			<div class="p_rem-0.3">
				<%/* class p-5의 숫자를 변경하여 사이즈 변경 */ %>
				<button data-toggle="button" class="p-5 btn btn-outline-danger waves-effect waves-themed" onclick="javascript:SAMPLE000.retrieve_master_Data();">Search</button>
			</div>
		</div>
		
	</div>
</form:form>

	<div class="row">
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<div id="div_oTui_CsPurchase" name="div_oTui_CsPurchase" class="tuigrid-resizable">
				
				<div id="oTui_CsPurchase" data-minus-height="200"></div>
				<div id="oTui_CsPurchase_paging"></div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<div id="div_oTui_CsPurchaseDetail" name="div_oTui_CsPurchaseDetail" class="tuigrid-resizable">
				
				<div id="oTui_CsPurchaseDetail" data-minus-height="200"></div>
				<div id="oTui_CsPurchaseDetail_paging"></div>
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
            
			var calendar = KpackageOBJ.calendar;

			calendar.create("SAMPLE000-form", "start_date");
            calendar.setValue("SAMPLE000-form","start_date", fromDay);
            calendar.setFormValue("SAMPLE000-form","start_date", fromDay);
            
            calendar.create("SAMPLE000-form", "end_date");
            calendar.setValue("SAMPLE000-form","end_date", toDay);
            calendar.setFormValue("SAMPLE000-form","end_date",toDay);

			/* 기본 검색 구문 */
			// KpackageOBJ.selectbox.create("SAMPLE000-form", "SEARCH_SYSTEM_BATCH_YN", "", null, "value", "name", arrayItem);
			
			// var arrayItem = [{value:"SEARCH_TYPE_O1", name:"고객사 코드"}
			// 			    ,{value:"SEARCH_TYPE_O2", name:"아이템 코드"}];

			// KpackageOBJ.selectbox.create("SAMPLE000-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*
			arrayItem = [{value:"CC", name:"Contains"}
            			,{value:"EQ", name:"Equal To"}
			 			,{value:"SW", name:"Starts With Is"}];

			KpackageOBJ.selectbox.create("SAMPLE000-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			*/
		}
		


		
		this.initialize_TuiGrid = function() 
		{
			this.initialize_master_grid();
			this.initialize_detail_grid();						
		}

		this.initialize_master_grid = function(){
var colArrayInfo = [
				
				{"header" :"협력사 코드"           ,"name" :"division_code"           ,"width" : 80      ,"align" : "center"    ,"hidden" : false},
				{"header" :"협력사명"        ,"name" :"division_name"             ,"width" : 100      ,"align" : "center"    ,"hidden" : false},
				{"header" :"자재 코드"        ,"name" :"item_code"               ,"width" : 100      ,"align" : "center"    ,"hidden" : false },
				{"header" :"자재명"            ,"name" :"item_name"             ,"width" : 250      ,"align" : "left"      ,"hidden" : false},
				{"header" :"발주번호"        ,"name" :"order_no"                 ,"width" : 100      ,"align" : "center"    ,"hidden" : false},
				{"header" :"일련번호"              ,"name" :"order_seq"                ,"width" : 80       ,"align" : "right"     ,"hidden" : false },
				{"header" :"구매형태"             ,"name" :"warehousing_type_name"                  ,"width" : 80       ,"align" : "right"     ,"hidden" : false },
				{"header" :"입고금액"             ,"name" :"amount"              ,"width" : 100      ,"align" : "right"     ,"hidden" : false, "formatter" : KpackageOBJ.tuiGrid.commas },
				{"header" :"원산지증명번호"            ,"name" :"coo_certify_no"             ,"width" : 200      ,"align" : "left"      ,"hidden" : false},
				{"header" :"원산지누락건수"          ,"name" :"noncoo_cnt_bu"           ,"width" : 250      ,"align" : "left"      ,"hidden" : false},
		    ]; 
			
			var tools = [ 
			     {icon:"none",  title:"상세조회"        ,text:"상세조회"        ,func:"SAMPLE000.openDetailPage"}
			     ,{icon:"excel", title:"엑셀다운로드"    ,text:"엑셀다운로드"  ,func:"SAMPLE000.excel_SAMPLE000List"}

			  ];
			KpackageOBJ.tuiGrid.setButton("oTui_CsPurchase", tools); // Toobar 생성
			KpackageOBJ.tuiGrid.create("oTui_CsPurchase","/origin/compliance/poledger/poledgerList", colArrayInfo, null, this.retrieve_detail_Data);
		}

		this.initialize_detail_grid = function(){
			var colArrayInfo = [
				
				{"header" :"입고번호"           ,"name" :"order_no"           ,"width" : 80      ,"align" : "center"    ,"hidden" : false},
				{"header" :"일련번호"        ,"name" :"order_seq"             ,"width" : 100      ,"align" : "center"    ,"hidden" : false},
				{"header" :"자재 코드"        ,"name" :"item_code"               ,"width" : 100      ,"align" : "center"    ,"hidden" : false },
				{"header" :"자재명"            ,"name" :"item_name"             ,"width" : 250      ,"align" : "left"      ,"hidden" : false},
				{"header" :"단위"        ,"name" :"unit"                 ,"width" : 100      ,"align" : "center"    ,"hidden" : false},
				{"header" :"수량"              ,"name" :"warehousing_qty"                ,"width" : 80       ,"align" : "right"     ,"hidden" : false },
				{"header" :"단가"             ,"name" :"unit_price"                  ,"width" : 80       ,"align" : "right"     ,"hidden" : false, "formatter" : KpackageOBJ.tuiGrid.commas },
				{"header" :"입고금액"             ,"name" :"warehousing_amount"              ,"width" : 100      ,"align" : "right"     ,"hidden" : false, "formatter" : KpackageOBJ.tuiGrid.commas },
				{"header" :"입고일자"            ,"name" :"warehousing_date"             ,"width" : 200      ,"align" : "left"      ,"hidden" : false},
		    ]; 

			KpackageOBJ.tuiGrid.create("oTui_CsPurchaseDetail","/origin/compliance/poledger/poLedgerDtlList", colArrayInfo, null, null);
		}
		
		this.retrieve_master_Data = function() {
			var param = KpackageOBJ.data.makePostData("SAMPLE000-form");
			KpackageOBJ.tuiGrid.retrieve("oTui_CsPurchase","", param);
		}

		this.retrieve_detail_Data = function(p_GridId, p_RowKey, p_ColName) {
			var rowData = KpackageOBJ.tuiGrid.getRowValues("oTui_CsPurchase", p_RowKey);
			var formData = KpackageOBJ.data.makePostData("SAMPLE000-form");

			var param = {
				order_no: rowData.order_no,
				order_seq: rowData.order_seq,
				item_code: rowData.item_code,
				...formData
			};

			KpackageOBJ.tuiGrid.retrieve("oTui_CsPurchaseDetail","", param);
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
		SAMPLE000.initialize_Object(); 		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		SAMPLE000.initialize_TuiGrid();		 
		
		
	});
	
</script>
</body>
</html>