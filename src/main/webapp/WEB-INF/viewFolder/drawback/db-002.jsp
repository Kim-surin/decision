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
		<form:form id="DB002-form" class="s4-form" novalidate="novalidate" action="/db-002" method="post">
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
									<th><spring:message code='기준월' /></th>
									<td>
										<input type="text" id="SEARCH_CHIT_FRMTRM_DATE"  name="SEARCH_CHIT_FRMTRM_DATE" class="inputText has-month-picker"/>
									</td>
									<th><spring:message code='판매구분' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_YN" name="SEARCH_YN" style="width:110px"></select>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:DB002.retrieve_DB002List();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_DB002_List" name="div_oTui_DB002_List" class="tuigrid-resizable">
					<div id="oTui_DB002_List" data-minus-height="240"></div>
					<div id="oTui_DB002_List_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>
	
	var DB002 = new function(){
		
		
		
		this.Initialize_viewObject = function() {
			
			KpackageOBJ.monthPicker.create("DB002-form", "SEARCH_CHIT_FRMTRM_DATE");
			KpackageOBJ.monthPicker.setValue("DB002-form","SEARCH_CHIT_FRMTRM_DATE", "201606");		
	
			var arrayItem = [{value:"", name:"<spring:message code='common.title.all'/>"}
							,{value:"Y", name:"<spring:message code='일반판매'/>"}
							,{value:"N", name:"<spring:message code='사급판매'/>"}];

			KpackageOBJ.selectbox.create("DB002-form", "SEARCH_YN", "", null, "value", "name", arrayItem);

			DB002.renderTuiGrid();
		}
		
		this.renderTuiGrid = function() {
			 
			 var colArrayInfo = [
				 	{ header : '자재연도', name: 'ITEM_DOC_YEAR', width : 80, align: "center", hidden:false },
			        { header : '자재문서', name: 'ITEM_DOC_NO', width : 100, align: "center" ,hidden:false },
			        { header : '입고일자', name: 'CHIT_FRMTRM_DATE', width : 100, align: "center" , formatter: KpackageOBJ.tuiGrid.dateFormatter,   hidden:false},
			        { header : '플랜트', name: 'DIVISION_CODE', width : 80, align: "right" ,hidden:false},
			        { header : '공급업체', name: 'VENDOR_CODE', width : 100, align: "center" ,hidden:false},
			        { header : '자재코드', name: 'ITEM_CODE', width : 150, align: "center" ,hidden:false},
			        { header : '구매문서범주', name: 'PURCHS_DOC_CTGRY', width : 100, align: "right" ,hidden:false},
			        { header : '구매 문서의 품목 범주', name: 'PURCHS_PRDLST_CTGRY', width : 100, align: "right" ,hidden:false},
			        { header : '계정 지정 범주', name: 'ACNT_APPN_CTGRY', width : 100, align: "right" ,hidden:false},
			        { header : '수량', name: 'QY', width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas   ,hidden:false},
			        { header : '기본단위', name: 'BASS_UNIT', width : 100, align: "right" ,hidden:false},
			        { header : '현지 통화 금액', name: 'ACPLC_CRNCY_AMOUNT', width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas   ,hidden:false},
			        { header : '구매 문서의 단가', name: 'UNTPC', width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas   ,hidden:false},
			        { header : '이동 유형', name: 'MVMN_TYPE', width : 100, align: "right" ,hidden:false},
			        { header : '차변/대변 지시자', name: 'BUKIP_SYMBL', width : 100, align: "right" ,hidden:false},
			        { header : '순 오더 금액', name: 'SLE_ORDER_AMOUNT', width : 100, align: "right" ,formatter: KpackageOBJ.tuiGrid.commas   ,hidden:false}
			        
			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_DB002_List", "/drawback/retrieve_DB002List", colArrayInfo, true, true);
			 
		}
		
		this.retrieve_DB002List = function() {
			
			var param = { "CHIT_FRMTRM_DATE" : KpackageOBJ.object.getFormValue("DB002-form", "SEARCH_CHIT_FRMTRM_DATE")
						 ,"SEARCH_TYPE" : KpackageOBJ.object.getFormValue("DB002-form","SEARCH_TYPE")
						 ,"SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("DB002-form", "SEARCH_KEY_WORD")
				         ,"SEARCH_OPTION" : KpackageOBJ.object.getFormValue("DB002-form","SEARCH_OPTION")
						};
			
			//KpackageOBJ.tuiGrid.retrieve("oTui_DB002_List", "/drawback/retrieve_DB002List", param);
			
		}
	
	}
	
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB002.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});
	
	
</script>
</body>
</html>