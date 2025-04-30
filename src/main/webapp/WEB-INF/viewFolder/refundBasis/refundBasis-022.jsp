<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form:form id="RB022-search-form" class="s4-form" novalidate="novalidate" action="/refundBasis-011" method="post">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;" />
								<col style="width: 30%;" />
								<col style="width: 120px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='매각일자' /></th>
									<td>
										<input type="text" id="CAL_SEARCH_FROM_DATE"  name="CAL_SEARCH_FROM_DATE" style="width:120px" class="inputText has-month-picker" searchfnc="RB022.retrieve_gridData"/>
										<input type="hidden" id="SEARCH_FROM_DATE"  name="SEARCH_FROM_DATE" style="width:120px" class="inputText"/>
										<span class="fromTo-Dash">~</span>
										<input type="text" id="CAL_SEARCH_TO_DATE"  name="CAL_SEARCH_TO_DATE" style="width:120px" class="inputText has-month-picker" searchfnc="RB022.retrieve_gridData"/>
										<input type="hidden" id="SEARCH_TO_DATE"  name="SEARCH_TO_DATE" style="width:120px" class="inputText"/>
									</td>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td colspan="5">
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="RB006.retrieve_salesList"/>
									</td>
								</tr>
								<tr>
									<th><spring:message code='매각번호' /></th>
									<td colspan="3">
										<input type="text" id="SEARCH_SALES_LEDGER_NO" name="SEARCH_SALES_LEDGER_NO" class="inputText" searchfnc="RB022.retrieve_gridData"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:RB022.retrieve_gridData();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_SalesLedger" name="div_oTui_SalesLedger" class="tuigrid-resizable">
					<div id="oTui_SalesLedger" data-minus-height="240"></div>
					<div id="oTui_SalesLedger_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>
	
	var RB022 = new function(){
		this.initialize_viewObject = function() {
			var fromDay = KpackageOBJ.date.getCurrMonth() + "01";
			var toDay = KpackageOBJ.date.getCurrDay();
			
			KpackageOBJ.calendar.create("RB022-search-form", "CAL_SEARCH_FROM_DATE");
			KpackageOBJ.calendar.setValue("RB022-search-form","CAL_SEARCH_FROM_DATE", fromDay);
			KpackageOBJ.object.setFormValue("RB022-search-form","SEARCH_FROM_DATE", fromDay);
			
			
			KpackageOBJ.calendar.create("RB022-search-form", "CAL_SEARCH_TO_DATE");
			KpackageOBJ.calendar.setValue("RB022-search-form","CAL_SEARCH_TO_DATE", toDay);	
			KpackageOBJ.object.setFormValue("RB022-search-form","SEARCH_TO_DATE", toDay);
	
			
			
			/*Search Type Select Box Create */
			var arrayItem = [
				             {value:"ITEM_CODE", name:"<spring:message code='자재코드'/>"}
				             ,{value:"ITEM_NAME", name:"<spring:message code='자재명'/>"}
				             ,{value:"HS_CODE", name:"<spring:message code='세번'/>"}
			                ];
			
			KpackageOBJ.selectbox.create("RB022-search-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			            ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("RB022-search-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
		}
		
		this.initialize_TuiGrid = function() {

			 var colArrayInfo = [
				 {"header" :"회사코드"        	, name :"COMPANY_CODE"       , width : 80,  	align:"center", hidden:true },
				 {"header" :"사업부 코드"     	, name :"DIVISION_CODE"      , width : 80,  	align:"center", hidden:true },
				 {"header" :"매각번호"        	, name :"SALES_LEDGER_NO"    , width : 100,  	align:"center", hidden:false },
				 {"header" :"매각년도"        	, name :"SALES_LEDGER_YEAR"  , width : 80,  	align:"center", hidden:false },
				 {"header" :"매각순번"        	, name :"SALES_LEDGER_SEQ"   , width : 80,  	align:"center", hidden:false },
				 {"header" :"매각일자"        	, name :"SALES_DATE"         , width : 90,  	align:"center", hidden:false , "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
				 {"header" :"이동유형"        	, name :"ITEM_MOVE_TYPE"     , width : 80,  	align:"center", hidden:true },
				 {"header" :"자산구분"        	, name :"ASSETS_TYPE"        , width : 80,  	align:"center", hidden:false },
				 {"header" :"자재코드"        	, name :"ITEM_CODE"          , width : 120,  	align:"center", hidden:false },
				 {"header" :"자재명"        	, name :"ITEM_NAME"          , width : 350,  	align:"left", hidden:false },
				 {"header" :"세번"        	, name :"HS_CODE"            , width : 100,  	align:"center", hidden:false, "formatter" : KpackageOBJ.tuiGrid.hscode10 },
				 {"header" :"고객사"        	, name :"CUSTOMER_CODE"      , width : 100,  	align:"center", hidden:true},
				 {"header" :"수량"        	, name :"QUANTITY"           , width : 100,  	align:"right", hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas },
				 {"header" :"단위"        	, name :"UNIT"               , width : 60,  	align:"center", hidden:false },
				 {"header" :"금액"        	, name :"AMOUNT"             , width : 130,  	align:"right", hidden:false , "formatter" : KpackageOBJ.tuiGrid.commas }
				 
			    ];
			   
			 KpackageOBJ.tuiGrid.create("oTui_SalesLedger", "/refundbasis/retrievSalesLedgerList", colArrayInfo, 'number', null);
			   
		}
		
		this.retrieve_gridData = function() {
			
			var param = { "SEARCH_FROM_DATE" : KpackageOBJ.object.getFormValue("RB022-search-form", "SEARCH_FROM_DATE")
						 ,"SEARCH_TO_DATE"   : KpackageOBJ.object.getFormValue("RB022-search-form","SEARCH_TO_DATE")
						 , "SEARCH_TYPE"     : KpackageOBJ.object.getFormValue("RB022-search-form","SEARCH_TYPE")
					 	 , "SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("RB022-search-form", "SEARCH_KEY_WORD")
					 	 , "SEARCH_OPTION"   : KpackageOBJ.object.getFormValue("RB022-search-form","SEARCH_OPTION")
						 ,"SEARCH_SALES_LEDGER_NO" : KpackageOBJ.object.getFormValue("RB022-search-form", "SEARCH_SALES_LEDGER_NO")
						};
			if(oUtil.isNull(param["SEARCH_FROM_DATE"]) || oUtil.isNull(param["SEARCH_TO_DATE"])){
				alert("조회조건 매각일자는 입력해주세요");
				return false;
			}
			
			KpackageOBJ.tuiGrid.retrieve("oTui_SalesLedger", "/refundBasis/retrievSalesLedgerList", param);
			
		}
	
	}
	
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		RB022.initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		RB022.initialize_TuiGrid();
	});
	
	
</script>
</body>
</html>