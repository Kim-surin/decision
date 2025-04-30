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
		<form:form id="R006-form" class="s4-form" novalidate="novalidate" action="/report-006" method="post">
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;" />
								<col style="width: 150px;" />
								<col style="width: 80px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='기준월' /></th>
									<td>
										<input type="text" id="SEARCH_STDR_MT"  name="SEARCH_STDR_MT"  class="inputText has-month-picker" searchfnc="R006.retrieve_R006List"/>
									</td>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="R006.retrieve_R006List"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:R006.retrieve_R006List();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_R006_List" name="div_oTui_R006_List" class="tuigrid-resizable">
					<div id="oTui_R006_List" data-minus-height="250"></div>
					<div id="oTui_R006_List_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>
	
	var R006 = new function(){

	
		this.Initialize_viewObject = function() {
			
			var fromDay = KpackageOBJ.date.getCurrMonth();
			
			KpackageOBJ.monthPicker.create("R006-form", "SEARCH_STDR_MT");
			KpackageOBJ.monthPicker.setValue("R006-form","SEARCH_STDR_MT", fromDay);		
	
			/*Search Type Select Box Create */
			arrayItem = [{value:"REPRSNT_CUSTOMER_CODE", name:"<spring:message code='대표고객사코드'/>"}
						,{value:"CSTMR_ITEM", name:"<spring:message code='고객사 자재코드'/>"}
						];
			
			KpackageOBJ.selectbox.create("R006-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			            ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("R006-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
			R006.renderTuiGrid();
		}
		
		this.renderTuiGrid = function() {
			 
			 var colArrayInfo = [
				 	{ header : "기준월"			, name: "STDR_MT"				, width : 60	, align: "center"	, resizable: true, hidden:false  },
			        { header : "고객사"			, name: "REPRSNT_CUSTOMER_CODE"	, width : 80	, align: "left"		, resizable: true, hidden:false},
			        { header : "공급업체"			, name: "VENDOR_CODE"			, width : 120	, align: "center"	, resizable: true, hidden:false},
			        { header : "서류구분"			, name: "PAPERS_SE"				, width : 80	, align: "center"	, resizable: true, hidden:false},
			        { header : "근거서류번호"		, name: "BASIS_DOC_NO"			, width : 120	, align: "center"	, resizable: true, hidden:false},
			        { header : "자재코드"			, name: "ITEM_CODE"				, width : 150	, align: "left"		, resizable: true, hidden:false },
			        { header : "고객자재코드"		, name: "CSTMR_ITEM"			, width : 150	, align: "left"		, resizable: true, hidden:false},
			        { header : "자재내역"			, name: "ITEM_NM"				, width : 200	, align: "left"		, resizable: true, hidden:false},
			        { header : "기본단위"			, name: "BASS_UNIT"				, width : 60	, align: "center"	, resizable: true, hidden:false},
			        { header : "수량"				, name: "QY"					, width : 100	, align: "right"	, resizable: true, hidden:false	, formatter: KpackageOBJ.tuiGrid.commas},
			        { header : "전표 전기일"		, name: "CHIT_FRMTRM_DATE"		, width : 100	, align: "center"	, resizable: true, hidden:false	, formatter: KpackageOBJ.tuiGrid.dateFormatter},
			        { header : "단가"				, name: "UNTPC"					, width : 100	, align: "right"	, resizable: true, hidden:false	, formatter: KpackageOBJ.tuiGrid.commas},
			        { header : "통화키"			, name: "ACPLC_CRNCY"			, width : 80	, align: "center"	, resizable: true, hidden:false},
			        { header : "현지통화금액"		, name: "ACPLC_CRNCY_AMOUNT"	, width : 100	, align: "right"	, resizable: true, hidden:false	, formatter: KpackageOBJ.tuiGrid.commas},
			        { header : "관세금액(개당)"	, name: "CSTMS_AMOUNT"			, width : 80	, align: "right"	, resizable: true, hidden:false	, formatter: KpackageOBJ.tuiGrid.commas}
			     
			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_R006_List", "/report/retrieve_R006List", colArrayInfo, "number", null);
			 
		}
		
		this.retrieve_R006List = function() {
			
			var param = { "STDR_MT" : KpackageOBJ.object.getFormValue("R006-form", "SEARCH_STDR_MT")
						, "SEARCH_TYPE" : KpackageOBJ.object.getFormValue("R006-form","SEARCH_TYPE")
					 	, "SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("R006-form", "SEARCH_KEY_WORD")
			         	, "SEARCH_OPTION" : KpackageOBJ.object.getFormValue("R006-form","SEARCH_OPTION")
						};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_R006_List", "/report/retrieve_R006List", param);
			
		}
		
		
		
	}
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		R006.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});
</script>
</body>
</html>