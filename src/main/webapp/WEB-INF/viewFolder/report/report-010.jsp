<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style>

    </style>
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form:form id="R010-form" class="s4-form" novalidate="novalidate" action="/report-010" method="post">
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;" />
								<col style="width: 400px;" />
								<col style="width: 80px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='수입/수출' /></th>
									<td>   
										<select  class="form-control searchSelect" id="SEARCH_GUBUN" name="SEARCH_GUBUN" style="width:120px; padding:0px;" searchfnc="R010.retrieve_R010List"></select>
                                    </td>    	
                                	<th><spring:message code='자재/제품' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="R010.retrieve_R010List"/>
									</td>
                                </tr>    
								<tr>
									<th><spring:message code='수리일자' /></th>
									<td>
										<input type="text" id="CAL_SEARCH_FROM_DATE"  name="CAL_SEARCH_FROM_DATE" style="width:120px" class="inputText" searchfnc="R010.retrieve_R010List"/>
										<input type="hidden" id="SEARCH_FROM_DATE"  name="SEARCH_FROM_DATE" style="width:120px" class="inputText"/>
										<span class="fromTo-Dash">~</span>
										<input type="text" id="CAL_SEARCH_TO_DATE"  name="CAL_SEARCH_TO_DATE" style="width:120px" class="inputText" searchfnc="R010.retrieve_R010List"/>
										<input type="hidden" id="SEARCH_TO_DATE"  name="SEARCH_TO_DATE" style="width:120px" class="inputText"/>
									</td>	
									
									<th><spring:message code='신고번호' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE_NO" name="SEARCH_TYPE_NO" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION_NO" name="SEARCH_OPTION_NO" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD_NO" name="SEARCH_KEY_WORD_NO" class="inputText" searchfnc="R010.retrieve_R010List"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:R010.retrieve_R010List();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_R010_List" name="div_oTui_R010_List" class="tuigrid-resizable">
					<div id="oTui_R010_List" data-minus-height="250"></div>
					<div id="oTui_R010_List_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>
	
	var R010 = new function(){

	
		this.Initialize_viewObject = function() {
	
			/*Search Type Select Box Create */
			arrayItem = [{value:"I", name:"<spring:message code='수입'/>"}
					    ,{value:"E", name:"<spring:message code='수출'/>"}];
			KpackageOBJ.selectbox.create("R010-form", "SEARCH_GUBUN", "", null, "value", "name", arrayItem);
			
			arrayItem = [{value:"ITEM_CODE", name:"<spring:message code='자재코드'/>"}
						];
			
			KpackageOBJ.selectbox.create("R010-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			arrayItem = [{value:"IMPDEC_NO", name:"<spring:message code='신고번호'/>"}
						];
			
			KpackageOBJ.selectbox.create("R010-form", "SEARCH_TYPE_NO", "", null, "value", "name", arrayItem);
			
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			            ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("R010-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			KpackageOBJ.selectbox.create("R010-form", "SEARCH_OPTION_NO", "", null, "value", "name", arrayItem);

			/* Create Calender*/
			var fromDay = KpackageOBJ.date.getCurrMonth() + "01";
			var toDay = KpackageOBJ.date.getCurrMonth() + KpackageOBJ.date.lastDay(KpackageOBJ.date.getCurrMonth());
			
			KpackageOBJ.calendar.create("R010-form", "CAL_SEARCH_FROM_DATE");
			KpackageOBJ.calendar.setValue("R010-form","CAL_SEARCH_FROM_DATE", fromDay);
			KpackageOBJ.object.setFormValue("R010-form","SEARCH_FROM_DATE", fromDay);
			
			KpackageOBJ.calendar.create("R010-form", "CAL_SEARCH_TO_DATE");
			KpackageOBJ.calendar.setValue("R010-form","CAL_SEARCH_TO_DATE", toDay);
			KpackageOBJ.object.setFormValue("R010-form","SEARCH_TO_DATE",toDay);
			
			R010.renderTuiGrid();
		}
		
		this.renderTuiGrid = function() {
			 
			 var colArrayInfo = [
				 	{ header : "구분"				, name: "SEARCH_GUBUN"				, width : 60 , align: "center"   , resizable: true, hidden:false},
			        { header : "수입신고번호"			, name: "MANAGE_NO"					, width : 150, align: "left"     , resizable: true, hidden:false},
			        { header : "란"				, name: "LNE_NO"					, width : 100, align: "center"   , resizable: true, hidden:false},
			        { header : "행"				, name: "POUCH_NO"					, width : 100, align: "center"   , resizable: true, hidden:false},
			        { header : "수리일자"			, name: "ACPT_DATE"					, width : 120, align: "center"   , resizable: true, hidden:false},
			        { header : "HS_CODE"			, name: "HS_CODE"					, width : 120, align: "center"   , resizable: true, hidden:false },
			        { header : "자재코드"			, name: "ITEM_CODE"					, width : 100, align: "center"   , resizable: true, hidden:false},
			        { header : "품명"				, name: "ITEM_NM"					, width : 200, align: "left"     , resizable: true, hidden:false},
			        { header : "수량(단위)"			, name: "ITEM_QTY"					, width : 120, align: "right"    , resizable: true, hidden:false},
			        { header : "금액"				, name: "CVODV_KRW"					, width : 150, align: "right"    , resizable: true, hidden:false, formatter: KpackageOBJ.tuiGrid.commas}
			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_R010_List", "/report/retrieve_R010List", colArrayInfo, "number", null);
			 
		}
		
		this.retrieve_R010List = function() {
			
			var param = { "SEARCH_GUBUN" : KpackageOBJ.object.getFormValue("R010-form", "SEARCH_GUBUN")
						, "SEARCH_FROM_DATE" : KpackageOBJ.object.getFormValue("R010-form","SEARCH_FROM_DATE")
					 	, "SEARCH_TO_DATE" : KpackageOBJ.object.getFormValue("R010-form", "SEARCH_TO_DATE")
			         	, "SEARCH_TYPE" : KpackageOBJ.object.getFormValue("R010-form","SEARCH_TYPE")
			         	, "SEARCH_OPTION" : KpackageOBJ.object.getFormValue("R010-form","SEARCH_OPTION")
			         	, "SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("R010-form","SEARCH_KEY_WORD")
			         	, "SEARCH_TYPE_NO" : KpackageOBJ.object.getFormValue("R010-form","SEARCH_TYPE_NO")
			         	, "SEARCH_OPTION_NO" : KpackageOBJ.object.getFormValue("R010-form","SEARCH_OPTION_NO")
			         	, "SEARCH_KEY_WORD_NO" : KpackageOBJ.object.getFormValue("R010-form","SEARCH_KEY_WORD_NO")
			         	};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_R010_List", "/report/retrieve_R010List", param);
			
		}
		
		
		
	}
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		R010.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});
</script>
</body>
</html>