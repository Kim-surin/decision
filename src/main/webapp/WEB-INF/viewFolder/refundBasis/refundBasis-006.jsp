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
		<form:form id="RB006-form" class="s4-form" novalidate="novalidate" action="/refundBasis-006" method="post">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 100px;" />
								<col style="width: 25%;" />
								<col style="width: 100px;" />
								<col style="width: 25%;" />
								<col style="width: 100px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='기준년월' /></th>
									<td>
										<input type="text" id="SEARCH_PRIC_RQEST_DATE"  name="SEARCH_PRIC_RQEST_DATE"  class="inputText has-month-picker" searchfnc="RB006.retrieve_salesList"/>
									</td>
									<th><spring:message code='매출구분' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_EXPORT_FLAG" name="SEARCH_EXPORT_FLAG" style="width:110px"></select>
									</td>
									<th><spring:message code='고객사코드' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_CUSTOMER_TYPE" name="SEARCH_CUSTOMER_TYPE" style="width:110px"></select>
										<input type="text" id="SEARCH_CUSTOMER_TEXT"  name="SEARCH_CUSTOMER_TEXT"  class="inputText" searchfnc="RB006.retrieve_salesList"/>
									</td>
								</tr>
								<tr>
								<th><spring:message code='common.title.searchCondition' /></th>
									<td colspan="5">
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="RB006.retrieve_salesList"/>
									</td>

								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-2" type="button" onclick="javascript:RB006.retrieve_salesList();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_Sales_List" name="div_oTui_Sales_List" class="tuigrid-resizable">
					<div id="oTui_Sales_List" data-minus-height="240"></div>
					<div id="oTui_Sales_List_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>
	
	var RB006 = new function(){

	
		this.Initialize_viewObject = function() {
			var fromDay = KpackageOBJ.date.getCurrMonth();
			
			KpackageOBJ.monthPicker.create("RB006-form", "SEARCH_PRIC_RQEST_DATE");
			KpackageOBJ.monthPicker.setValue("RB006-form","SEARCH_PRIC_RQEST_DATE", fromDay);		
	
			/*Search Type Select Box Create */
			var arrayItem = [
				             {value:"ITEM_CODE", name:"<spring:message code='품목코드'/>"}
				             ,{value:"ITEM_NAME", name:"<spring:message code='품목명'/>"}
			                ];
			
			KpackageOBJ.selectbox.create("RB006-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			arrayItem = [{value:"NAME", name:"고객사명"}, {value:"CODE", name:"고객사 코드"}];
			KpackageOBJ.selectbox.create("RB006-form", "SEARCH_CUSTOMER_TYPE", "", null, "value", "name", arrayItem);
			
			arrayItem = [{value:"", name:"전체"},{value:"DOM", name:"내수"}, {value:"IMP", name:"수출"}];
			KpackageOBJ.selectbox.create("RB006-form", "SEARCH_EXPORT_FLAG", "", null, "value", "name", arrayItem);
			
			
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			            ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("RB006-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
			RB006.renderTuiGrid();
		}
		
		this.renderTuiGrid = function() {
			  
			 var colArrayInfo = [
				 { header :"메츨번호", 		name:"SALES_NO", width : 100,align:"center", resizable: true, hidden:false  },
				 { header :"매출순번", 		name:"SALES_SEQ", width : 100,align:"center", resizable: true, hidden:false  },
				 { header :"내수/수출", 		name:"EXPORT_FLAG_NAME", width : 100,align:"center", resizable: true, hidden:false  },
				 { header :"내수/수출", 		name:"EXPORT_FLAG", width : 100,align:"center", hidden:true  },
				 { header :"고객사코드", 	name:"CUSTOMER_CODE", width : 100,align:"center", resizable: true, hidden:false  },
				 { header :"고객사 명", 		name:"CUSTOMER_NAME", width : 200,align:"left", resizable: true, hidden:false  },
				 { header :"매출일자", 		name:"INVOICE_DATE", width : 100,align:"center", resizable: true, hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
				 { header :"세금계산서 번호", 	name:"TAX_INVOICE_NO"	, width : 100,align:"center", resizable: true, hidden:false  },
				 { header :"세금계산서 발행일", 	name:"TAX_INVOICE_DATE"	, width : 100,align:"center", resizable: true, hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
				 { header :"제품코드", 		name:"PRODUCT_CODE", width : 100,align:"center", resizable: true, hidden:false  },
				 { header :"제품 명", 		name:"ITEM_NAME", width : 200,align:"left", resizable: true, hidden:false  },
				 { header :"단위", 			name:"PRODUCT_UNIT", width : 70,align:"center", resizable: true, hidden:false  },
				 { header :"금액", 			name:"AMOUNT", width : 140,align:"right", resizable: true, hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas },
				 { header :"금액(외화)", 	name:"AMOUNT_FOREIGN", width : 100,align:"right", resizable: true, hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas },
				 { header :"통화", 			name:"CURRENCY", width : 100,align:"center", resizable: true, hidden:false  },
				 { header :"자산구분", 		name:"PRODUCT_ASSETS_TYPE", width : 70,align:"center", resizable: true, hidden:false  },
				 { header :"도착국가", 		name:"ARRIVAL_NATION", width : 120,align:"left", resizable: true, hidden:false  },
				 { header :"도착항", 		name:"ARRIVAL_PORT_NAME", width : 140,align:"left", resizable: true, hidden:false  },
				 { header :"B/L No", 		name:"BL_NO", width : 120,align:"center", resizable: true, hidden:false  },
				 { header :"거래조건", 		name:"INCOTERMS", width : 80,align:"center", resizable: true, hidden:false  },
				 { header :"Invoice No.", name:"INVOICE_NO", width : 100,align:"center", resizable: true, hidden:false  },
				 { header :"포장갯수", 		name:"PACKING_COUNT", width : 100,align:"right", resizable: true, hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas },
				 { header :"선적일자", 		name:"SHIPPING_DATE", width : 100,align:"center", resizable: true, hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
				 { header :"선(편)명", 		name:"VEHICLE_NAME", width : 100,align:"center", resizable: true, hidden:false  },
				 { header :"대금청구문서번호", 	name:"PAY_NO"			, width : 100,align:"center", resizable: true, hidden:false  },
				 { header :"영업문서 번호", 	name:"SALES_DOC_NO"		, width : 100,align:"center", resizable: true, hidden:false  }
				 
			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_Sales_List", "/refundbasis/selectSalesList", colArrayInfo, 'number', null);
			 
		}
		
		this.retrieve_salesList = function() {
			
			var param = { "PRIC_RQEST_DATE" : KpackageOBJ.object.getFormValue("RB006-form", "SEARCH_PRIC_RQEST_DATE")
						, "SEARCH_TYPE" : KpackageOBJ.object.getFormValue("RB006-form","SEARCH_TYPE")
					 	, "SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("RB006-form", "SEARCH_KEY_WORD")
					 	, "SEARCH_OPTION" : KpackageOBJ.object.getFormValue("RB006-form","SEARCH_OPTION")
			         	, "SEARCH_EXPORT_FLAG" : KpackageOBJ.object.getFormValue("RB006-form", "SEARCH_EXPORT_FLAG")
			         	, "SEARCH_CUSTOMER_TYPE" : KpackageOBJ.object.getFormValue("RB006-form","SEARCH_CUSTOMER_TYPE")
			         	, "SEARCH_CUSTOMER_TEXT" : KpackageOBJ.object.getFormValue("RB006-form","SEARCH_CUSTOMER_TEXT")
						};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_Sales_List", "/refundbasis/selectSalesList", param);
			
		}
		
		
		
	}
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		RB006.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});
</script>
</body>
</html>