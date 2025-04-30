<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form:form id="RB007-form" class="s4-form" novalidate="novalidate" action="/refundBasis-007" method="post">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;" />
								<col style="width: 25%;" />
								<col style="width: 80px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='기준년월' /></th>
									<td>
										<input type="text" id="SEARCH_STDR_MT"  name="SEARCH_STDR_MT" class="inputText has-month-picker" searchfnc="RB007.retrieve_mtrlList"/>
									</td>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="RB007.retrieve_mtrlList"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:RB007.retrieve_mtrlList();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_Material_List" name="div_oTui_Material_List" class="tuigrid-resizable">
					<div id="oTui_Material_List" data-minus-height="240"></div>
					<div id="oTui_Material_List_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>
	
	var RB007 = new function(){
	

		this.Initialize_viewObject = function() {
			var fromDay = KpackageOBJ.date.getCurrMonth();
			
			KpackageOBJ.monthPicker.create("RB007-form", "SEARCH_STDR_MT");
			KpackageOBJ.monthPicker.setValue("RB007-form","SEARCH_STDR_MT", fromDay);		
	
			/*Search Type Select Box Create */
			arrayItem = [{value:"ITEM_CODE", name:"<spring:message code='품목코드'/>"}];
			
			KpackageOBJ.selectbox.create("RB007-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			            ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("RB007-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
			RB007.renderTuiGrid();
		}
		
		this.renderTuiGrid = function() {
			
			
			 var colArrayInfo = [
				 	{ header :'회사 코드'		, name:'COMPANY_CODE'		, width : 80, align: "center" , hidden:true},
					{ header :'기준년월'			, name:'YYYYMM'				, width : 80, align: "center" , resizable: true, hidden:false},
					{ header :'플랜트'			, name:'DIVISION_CODE'		, width : 100, align: "center" , hidden:true},
					{ header :'자재'			, name:'ITEM_CODE'			, width : 100, align: "center" , resizable: true, hidden:false},
					{ header :'자재 내역'		, name:'ITEM_NAME'			, width : 250, align: "left"   , resizable: true, hidden:false},
					{ header :'브랜드그룹'		, name:'BR_GROUP'			, width : 100, align: "center" , resizable: true, hidden:false},
					{ header :'브랜드코드'		, name:'BR_CODE'			, width : 100, align: "center" , resizable: true, hidden:false},
					{ header :'자재 유형'		, name:'ASSETS_TYPE'		, width : 100, align: "center" , resizable: true, hidden:false},
					{ header :'평가클래스'		, name:'P_CLASS'			, width : 100, align: "center" , resizable: true, hidden:false},
					{ header :'손익 센터'		, name:'F_CENTER'			, width : 100, align: "center" , resizable: true, hidden:false},
					{ header :'통화'			, name:'CURRENCY'			, width : 100, align: "center" , resizable: true, hidden:false},
					{ header :'단위'			, name:'UNIT'				, width : 100, align: "center" , resizable: true, hidden:false},
					{ header :'기초재고 수량'	, name:'INITIAL_QTY'		, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'기초재고 금액'	, name:'INITIAL_AMOUNT'		, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'기초재고 단가'	, name:'INITIAL_PRICE'		, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'입고수량'			, name:'INPUT_QTY'			, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'입고금액'			, name:'INPUT_AMOUNT'		, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'구매입고 단가'	, name:'INPUT_PRICE'		, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'생산입고 수량'	, name:'PROD_INPUT_QTY'		, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'생산입고 금액'	, name:'PROD_INPUT_AMOUNT'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'생산입고 단가'	, name:'PROD_INPUT_PRICE'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'재고이동입고 수량'	, name:'TRANS_INPUT_QTY'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'재고이동입고 금액'	, name:'TRANS_INPUT_AMOUNT'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'재고이동입고 단가'	, name:'TRANS_INPUT_PRICE'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'판매반품 수량'	, name:'SALES_RETURN_QTY'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'판매반품 금액'	, name:'SALES_RETURN_AMOUNT', width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'판매반품 단가'	, name:'SALES_RETURN_PRICE'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'잡출반품 수량'	, name:'OTHER_RETURN_QTY'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'잡출반품 금액'	, name:'OTHER_RETURN_AMOUNT', width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'잡출반품 단가'	, name:'OTHER_RETURN_PRICE'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'기타입고 수량'	, name:'ETC_INPUT_QTY'		, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'기타입고 금액'	, name:'ETC_INPUT_AMOUNT'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false},
					{ header :'기타입고 단가'	, name:'ETC_INPUT_PRICE'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'판매출고 수량'	, name:'SALES_ISSUE_QTY'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'판매출고 금액'	, name:'SALES_ISSUE_AMOUNT'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'판매출고 단가'	, name:'SALES_ISSUE_PRICE'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'잡출 수량'		, name:'OTHER_ISSUE_QTY'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'잡출 금액'		, name:'OTHER_ISSUE_AMOUNT'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'잡출 단가'		, name:'OTHER_ISSUE_PRICE'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'생산출고 수량'	, name:'PROD_ISSUE_QTY'		, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'생산출고 금액'	, name:'PROD_ISSUE_AMOUNT'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'생산출고 단가'	, name:'PROD_ISSUE_PRICE'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'재고이동출고 수량'	, name:'STOCK_ISSUE_QTY'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'재고이동출고 금액'	, name:'STOCK_ISSUE_AMOUNT'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'재고이동출고 단가'	, name:'STOCK_ISSUE_PRICE'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'기타출고 수량'	, name:'ETC_ISSUE_QTY'		, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'기타출고 금액'	, name:'ETC_ISSUE_AMOUNT'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'기타출고 단가'	, name:'ETC_ISSUE_PRICE'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'원가차이'			, name:'COST_DISC'			, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'재료비차이조정'	, name:'MATERIAL_ADJ'		, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'기말재고 수량'	, name:'INVENTORY_QTY'		, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'기말재고 금액'	, name:'INVENTORY_AMOUNT'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}, 
					{ header :'기말재고 단가'	, name:'INVENTORY_PRICE'	, width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas, resizable: true, hidden:false}
			        
			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_Material_List", "/refundbasis/selectMaterialList", colArrayInfo, 'number', null);
			 
		}
		
		this.retrieve_mtrlList = function() {
			
			var param = { "STDR_MT" : KpackageOBJ.object.getFormValue("RB007-form", "SEARCH_STDR_MT")
						, "SEARCH_TYPE" : KpackageOBJ.object.getFormValue("RB007-form","SEARCH_TYPE")
					 	, "SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("RB007-form", "SEARCH_KEY_WORD")
			         	, "SEARCH_OPTION" : KpackageOBJ.object.getFormValue("RB007-form","SEARCH_OPTION")
						};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_Material_List", "/refundbasis/selectMaterialList", param);
			
		}
	
	}
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		RB007.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});
</script>
</body>
</html>