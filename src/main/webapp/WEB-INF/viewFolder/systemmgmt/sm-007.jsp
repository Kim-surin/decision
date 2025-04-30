<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
/************************************************************************************************************
    PGM Name : 잔량사용이력 조회
    PGM Code : SM007
    DESC     :  
    History  -----------------------------------------------------------------------------------------------  
                2019.07.10    Init Version                                                         D.Cat
************************************************************************************************************/
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form:form id="SM007-search-form" class="s4-form" novalidate="novalidate" action="/refundBasis-009" method="post">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;" />
								<col style="width: 35%;" />
								<col style="width: 80px;" />
                                <col style="width: ;" />
								<col style="width: 80px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='기준일자' /></th>
									<td>
										<input type="text" id="CAL_SEARCH_FROM_DATE"  name="CAL_SEARCH_FROM_DATE" style="width:120px" class="inputText"/>
										<span class="fromTo-Dash">~</span>
										<input type="text" id="CAL_SEARCH_TO_DATE"  name="CAL_SEARCH_TO_DATE" style="width:120px" class="inputText"/>
									</td>
									<th>사용구분</th>
                                    <td>
                                        <select class="form-control searchSelect" id="USE_TYPE" name="USE_TYPE" style="width:110px"></select>
                                    </td>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:SM007.retrieve_gridData();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_SM007_grid_01" name="div_oTui_SM007_grid_01" class="tuigrid-resizable">
					<div id="oTui_SM007_grid_01" data-minus-height="250"></div>
					<div id="oTui_SM007_grid_01_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>

	var SM007 = new function(){
		
		// Page Object Initialize
		this.initialize_Object = function() {
			
			var fromDay = KpackageOBJ.date.getCurrMonth() + "01";
			var toDay = KpackageOBJ.date.getCurrDay();
			
			KpackageOBJ.calendar.create("SM007-search-form", "CAL_SEARCH_FROM_DATE");
			KpackageOBJ.calendar.setValue("SM007-search-form","CAL_SEARCH_FROM_DATE", fromDay);
			
			KpackageOBJ.calendar.create("SM007-search-form", "CAL_SEARCH_TO_DATE");
			KpackageOBJ.calendar.setValue("SM007-search-form","CAL_SEARCH_TO_DATE", toDay);
	
			
			arrayItem = [{value:"", name:"<spring:message code='All'/>"}
            ,{value:"01", name:"<spring:message code='환급신청서'/>"}
            ,{value:"02", name:"<spring:message code='기납증'/>"}
            ,{value:"03", name:"<spring:message code='분증'/>"}
            ];

		    KpackageOBJ.selectbox.create("SM007-search-form", "USE_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [
				        {value:"IMPDEC_NO", name:"<spring:message code='신고번호'/>"}
                        ,{value:"USE_PRESENTN_NO", name:"<spring:message code='사용관리번호'/>"}
						,{value:"ITEM_CODE", name:"<spring:message code='자재코드'/>"}
						];
			
			KpackageOBJ.selectbox.create("SM007-search-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			            ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("SM007-search-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
		}
		
		this.initialize_TuiGrid = function(){

			 var colArrayInfo = [
				 {name:"IMPDEC_NO"       ,title:"신고번호"          ,width:150,		align:'center',		hidden:false},
				 {name:"LNE_NO"          ,title:"란"                ,width:50,		align:'center',		hidden:false},
				 {name:"POUCH_NO"        ,title:"행"                ,width:50,		align:'center',		hidden:false},
				 {name:"ITEM_CODE"       ,title:"자재코드"          ,width:140,		align:'center',		hidden:false},
				 {name:"USGQTY"          ,title:"사용량"            ,width:120,		align:'right',		hidden:false},
				 {name:"USE_TYPE_NAME"   ,title:"사용구분"          ,width:100,		align:'center',		hidden:false},
				 {name:"USE_PRESENTN_NO" ,title:"사용관리번호"      ,width:150,		align:'center',		hidden:false},
				 {name:"USE_THNG_SEQ"    ,title:"사용[을] 순번"     ,width:120,		align:'center',		hidden:false},
				 {name:"USE_RAWMTRL_SEQ" ,title:"사용[병] 순번"     ,width:120,		align:'center',		hidden:false},
				 {name:"CREATE_DATE"     ,title:"사용일시"          ,width:140,		align:'center',		hidden:false}
			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_SM007_grid_01", "/sys/retrieve_IncmeLocalBntHstry", colArrayInfo, 'number', null, SM007.onDblClick_oTui_SM007_grid_01);

		}
		 
		this.onDblClick_oTui_SM007_grid_01 = function(gridId, rowkey, colName){
			
		};
		
		this.retrieve_gridData = function() {
			
			var param = { "CAL_SEARCH_FROM_DATE" : KpackageOBJ.object.getFormValue("SM007-search-form", "CAL_SEARCH_FROM_DATE")
					 	 ,"CAL_SEARCH_TO_DATE" : KpackageOBJ.object.getFormValue("SM007-search-form","CAL_SEARCH_TO_DATE")
					 	 ,"USE_TYPE" : KpackageOBJ.object.getFormValue("SM007-search-form","USE_TYPE")
					 	 ,"SEARCH_TYPE" : KpackageOBJ.object.getFormValue("SM007-search-form","SEARCH_TYPE")
					 	 ,"SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("SM007-search-form", "SEARCH_KEY_WORD")
			         	 ,"SEARCH_OPTION" : KpackageOBJ.object.getFormValue("SM007-search-form","SEARCH_OPTION")
						};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_SM007_grid_01", "", param);
		};
		
	} 
	
	$(document).ready(function() {
		
		pageSetUp();				// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		SM007.initialize_Object(); 		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		SM007.initialize_TuiGrid();		 
	});

</script>
</body>
</html>