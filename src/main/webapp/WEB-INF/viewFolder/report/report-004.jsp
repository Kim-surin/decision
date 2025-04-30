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
		<form:form id="R004-form" class="s4-form" novalidate="novalidate" action="/report-004" method="post">
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
									<th><spring:message code='기준년월' /></th>
									<td>
										<input type="text" id="SEARCH_ACPT_DATE"  name="SEARCH_ACPT_DATE"  class="inputText has-month-picker" searchfnc="R004.retrieve_R004List"/>
									</td>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="R004.retrieve_R004List"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:R004.retrieve_R004List();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_R004_List" name="div_oTui_R004_List" class="tuigrid-resizable">
					<div id="oTui_R004_List" data-minus-height="250"></div>
					<div id="oTui_R004_List_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>
	
	var R004 = new function(){

	
		this.Initialize_viewObject = function() {
			var fromDay = KpackageOBJ.date.getCurrMonth()
			
			KpackageOBJ.monthPicker.create("R004-form", "SEARCH_ACPT_DATE");
			KpackageOBJ.monthPicker.setValue("R004-form","SEARCH_ACPT_DATE", fromDay);		
	
			/*Search Type Select Box Create */
			arrayItem = [{value:"VENDOR_CODE", name:"<spring:message code='공급업체'/>"}
						,{value:"ITEM_CODE", name:"<spring:message code='자재코드'/>"}
						];
			
			KpackageOBJ.selectbox.create("R004-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			            ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("R004-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
			R004.renderTuiGrid();
		}
		
		this.renderTuiGrid = function() {
			 
			 var colArrayInfo = [
				 	{ header : "근거자료 관리번호", name: "BASIS_DTA_MANAGE_NO"	, width : 120, align: "center" , resizable: true, hidden:false  },
			        { header : "란"				, name: "LNE_NO"				, width : 60 , align: "center" , resizable: true, hidden:false},
			        { header : "행"				, name: "POUCH_NO"				, width : 60 , align: "center" , resizable: true, hidden:false},
			        { header : "공급업체"			, name: "VENDOR_CODE"			, width : 120, align: "left"   , resizable: true, hidden:false},
			        { header : "원재료 구분"		, name: "RAWMTRL_SE"			, width : 80 , align: "center" , resizable: true, hidden:false},
			        { header : "기납증 등록번호"	, name: "CTRM_REGIST_NO"		, width : 120, align: "center" , resizable: true, hidden:false },
			        { header : "수리일자"			, name: "ACPT_DATE"				, width : 100, align: "center" , resizable: true, hidden:false , formatter: KpackageOBJ.tuiGrid.dateFormatter},
			        { header : "양도일자"			, name: "TRNSFR_DATE"			, width : 100, align: "center" , resizable: true, hidden:false , formatter: KpackageOBJ.tuiGrid.dateFormatter},
			        { header : "서류 구분"		, name: "PAPERS_SE"				, width : 80 , align: "center" , resizable: true, hidden:false},
			        { header : "근거서류 번호"	, name: "BASIS_DOC_NO"			, width : 120, align: "center" , resizable: true, hidden:false},
			        { header : "자재코드"			, name: "ITEM_CODE"				, width : 150, align: "left"   , resizable: true, hidden:false},
			        { header : "자재내역"			, name: "ITEM_NM"				, width : 200, align: "left"   , resizable: true, hidden:false},
			        { header : "HS CODE"			, name: "HS_CODE"				, width : 100, align: "center" , resizable: true, hidden:false , formatter: KpackageOBJ.tuiGrid.hscode10},
			        { header : "수량"				, name: "QY"					, width : 100, align: "right"  , resizable: true, hidden:false , formatter: KpackageOBJ.tuiGrid.commas},
			        { header : "기본단위"			, name: "BASS_UNIT"				, width : 60 , align: "right"  , resizable: true, hidden:false},
			        { header : "관세율(수입)"		, name: "INCME_TARRATE"			, width : 100, align: "right"  , resizable: true, hidden:false},
			        { header : "관세"				, name: "CSTMS"					, width : 100, align: "right"  , resizable: true, hidden:false , formatter: KpackageOBJ.tuiGrid.commas},
			        { header : "교육세"			, name: "ECX_AMOUNT"			, width : 100, align: "right"  , resizable: true, hidden:false , formatter: KpackageOBJ.tuiGrid.commas},
			        { header : "개별소비세"		, name: "INTTAX"				, width : 100, align: "right"  , resizable: true, hidden:false , formatter: KpackageOBJ.tuiGrid.commas},
			        { header : "농특세"			, name: "AGSPT"					, width : 100, align: "right"  , resizable: true, hidden:false , formatter: KpackageOBJ.tuiGrid.commas},
			        { header : "교통세"			, name: "TRANTAX"				, width : 100, align: "right"  , resizable: true, hidden:false , formatter: KpackageOBJ.tuiGrid.commas},
			        { header : "주세"				, name: "LQTX_AMOUNT"			, width : 100, align: "right"  , resizable: true, hidden:false , formatter: KpackageOBJ.tuiGrid.commas},
			        { header : "총세액"			, name: "TOT_TAXAMT"			, width : 100, align: "right"  , resizable: true, hidden:false , formatter: KpackageOBJ.tuiGrid.commas},
			        { header : "통화키"			, name: "ACPLC_CRNCY"			, width : 60 , align: "right"  , resizable: true, hidden:false}
			       
			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_R004_List", "/report/retrieve_R004List", colArrayInfo, "number", null);
			 
		}
		
		this.retrieve_R004List = function() {
			
			var param = { "ACPT_DATE" : KpackageOBJ.object.getFormValue("R004-form", "SEARCH_ACPT_DATE")
						, "SEARCH_TYPE" : KpackageOBJ.object.getFormValue("R004-form","SEARCH_TYPE")
					 	, "SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("R004-form", "SEARCH_KEY_WORD")
			         	, "SEARCH_OPTION" : KpackageOBJ.object.getFormValue("R004-form","SEARCH_OPTION")
						};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_R004_List", "/report/retrieve_R004List", param);
			
		}
		
		
		
	}
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		R004.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});
</script>
</body>
</html>