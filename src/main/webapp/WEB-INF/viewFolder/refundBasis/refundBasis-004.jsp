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
		<form:form id="RB004-form" class="s4-form" novalidate="novalidate" action="/refundBasis-004" method="post">
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
										<input type="text" id="WAREHOUSING_DATE"  name="WAREHOUSING_DATE" class="inputText has-month-picker" searchfnc="RB004.retrieve_poList"/>
									</td>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="RB004.retrieve_poList"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:RB004.retrieve_poList();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_Po_List" name="div_oTui_Po_List" class="tuigrid-resizable">
					<div id="oTui_Po_List" data-minus-height="240"></div>
					<div id="oTui_Po_List_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>
	
	var RB004 = new function(){
		this.Initialize_viewObject = function() {
			var fromDay = KpackageOBJ.date.getCurrMonth();
			
			KpackageOBJ.monthPicker.create("RB004-form", "WAREHOUSING_DATE");
			KpackageOBJ.monthPicker.setValue("RB004-form","WAREHOUSING_DATE", fromDay);		
	
			/*Search Type Select Box Create */
			arrayItem = [{value:"VENDOR_CODE", name:"<spring:message code='공급업체코드'/>"}
						,{value:"ITEM_CODE", name:"<spring:message code='자재코드'/>"}];
			
			KpackageOBJ.selectbox.create("RB004-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			            ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("RB004-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
			RB004.renderTuiGrid();
		}
		
		this.renderTuiGrid = function() {
			
			 var colArrayInfo = [
				 {"header" : '회사코드'        , name : 'COMPANY_CODE'          , width : 80,  	align: "center", hidden:true },   
				 {"header" : '사업부코드'       , name : 'DIVISION_CODE'         , width : 80,  	align: "center", hidden:true },
				 {"header" : '입고번호'        , name : 'WAREHOUSING_NO'        , width : 120,  	align: "center", resizable: true, hidden:false },
				 {"header" : '순번'           , name : 'SEQ'                   , width : 80,  	align: "center", resizable: true, hidden:false },
				 {"header" : '입고연도'         , name : 'WAREHOUSING_YEAR'      , width : 80,  	align: "center", resizable: true, hidden:false },
				 {"header" : '입고일자'         , name : 'WAREHOUSING_DATE'      , width : 100,  	align: "center", resizable: true, hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
				 {"header" : '입고구분'         , name : 'WAREHOUSING_TYPE'      , width : 80,  	align: "center", resizable: true, hidden:false },
				 {"header" : 'PO'             , name : 'ORDER_NO'              , width : 120,  	align: "center", resizable: true, hidden:false },
				 {"header" : 'PO순번'          , name : 'ORDER_SEQ'             , width : 80,  	align: "center", resizable: true, hidden:false },
				 {"header" : '공급업체'     	 , name : 'VENDOR_CODE'            , width : 120,  	align: "center", resizable: true, hidden:false },
				 {"header" : '구입처명'         , name : 'MAKER_NAME'            , width : 250,  	align: "left"  , resizable: true, hidden:false },
				 {"header" : '자재코드'         , name : 'ITEM_CODE'             , width : 120,  	align: "center", resizable: true, hidden:false },
				 {"header" : '자재내역'         , name : 'ITEM_NAME'             , width : 250,  	align: "left"  , resizable: true, hidden:false },
				 {"header" : '란'              , name : 'LAN'                  , width : 80,  	align: "center", resizable: true, hidden:false },
				 {"header" : '규격(행)'        , name : 'POUCH'                 , width : 80,  	align: "center", resizable: true, hidden:false },
				 {"header" : '수입신고일자'   	 , name : 'PERMIT_DATE'           , width : 100,  	align: "center", resizable: true, hidden:false , "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
				 {"header" : '수입신고번호'      , name : 'CLEARLANCE_NO'         , width : 150,  	align: "center", resizable: true, hidden:false },
				 {"header" : '관세금액(부대비)'   , name : 'CSTMS'                 , width : 100,  	align: "right" , resizable: true, hidden:false , "formatter" : KpackageOBJ.tuiGrid.commas },  
				 {"header" : '세율'            , name : 'CSTMS_RATE'            , width : 100,  	align: "center", resizable: true, hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas },  
				 {"header" : '원산지국가코드'     , name : 'ORIGIN_NATION'         , width : 100,  	align: "center", resizable: true, hidden:false },
				 {"header" : '외화금액'         , name : 'AMOUNT_FOREIGN'        , width : 100,  	align: "right" , resizable: true, hidden:false , "formatter" : KpackageOBJ.tuiGrid.commas },  
				 {"header" : '외화단가'         , name : 'UNIT_PRICE_FOREIGN'    , width : 100,  	align: "right" , resizable: true, hidden:false , "formatter" : KpackageOBJ.tuiGrid.commas },  
				 {"header" : '환율일자'         , name : 'EXCHANGE_DATE'         , width : 100,  	align: "center", resizable: true, hidden:false , "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
				 {"header" : '환율'            , name : 'EXCHANGE_RATE'         , width : 100,  	align: "right" , resizable: true, hidden:false },
				 {"header" : 'BL_NO'          , name : 'BL_NO'                 , width : 150,  	align: "center", resizable: true, hidden:false },
				 {"header" : 'BL수량'          , name : 'BL_QUANTITY'           , width : 100,  	align: "right" , resizable: true, hidden:false , "formatter" : KpackageOBJ.tuiGrid.commas },  
				 {"header" : '입고수량'         , name : 'WAREHOUSING_QTY'       , width : 100,  	align: "right" , resizable: true, hidden:false , "formatter" : KpackageOBJ.tuiGrid.commas },  
				 {"header" : '입고금액'      	 , name : 'WAREHOUSING_AMOUNT'    , width : 100,  	align: "right" , resizable: true, hidden:false , "formatter" : KpackageOBJ.tuiGrid.commas },  
				 {"header" : '통화'			 , name : 'CURRENCY'              , width : 80,  	align: "center", resizable: true, hidden:false },
				 {"header" : '자산구분' 		 , name : 'ASSETS_TYPE'           , width : 150,  	align: "center", resizable: true, hidden:false },
				 {"header" : '단위'            , name : 'UNIT'                  , width : 80,  	align: "center", resizable: true, hidden:false },
				 {"header" : '단가'            , name : 'UNIT_PRICE'            , width : 100, 	align: "right" , resizable: true, hidden:false , "formatter" : KpackageOBJ.tuiGrid.commas },  
				 {"header" : '생성일자'         , name : 'CREATE_DATE'           , width : 120, 	align: "center", hidden:true , "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
				 {"header" : '수정일자'         , name : 'UPDATE_DATE'           , width : 120, 	align: "center", hidden:true, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_Po_List", "/refundbasis/selectPoList", colArrayInfo, 'number', null);
			 
		}
		
		this.retrieve_poList = function() {
			
			var param = { "WAREHOUSING_DATE" : KpackageOBJ.object.getFormValue("RB004-form", "WAREHOUSING_DATE")
						 ,"SEARCH_TYPE" : KpackageOBJ.object.getFormValue("RB004-form","SEARCH_TYPE")
						 ,"SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("RB004-form", "SEARCH_KEY_WORD")
				         ,"SEARCH_OPTION" : KpackageOBJ.object.getFormValue("RB004-form","SEARCH_OPTION")
						};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_Po_List", "/refundbasis/selectPoList", param);
			
		}
	
	}
	
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		RB004.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});
	
	
</script>
</body>
</html>