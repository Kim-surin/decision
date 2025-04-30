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
		<form:form id="R003-form" class="s4-form" novalidate="novalidate" action="/report-003" method="post">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='기준년월' /></th>
									<td>
										<input type="text" id="SEARCH_STDR_MT"  name="SEARCH_STDR_MT" class="inputText has-month-picker"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:R003.retrieve_R003List();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_R003_List" name="div_oTui_R003_List" class="tuigrid-resizable">
					<div id="oTui_R003_List" data-minus-height="250"></div>
					<div id="oTui_R003_List_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>
	
	var R003 = new function(){
		
		
		
		this.Initialize_viewObject = function() {
	
			var fromDay = KpackageOBJ.date.getCurrMonth();
			
			KpackageOBJ.monthPicker.create("R003-form", "SEARCH_STDR_MT");
			KpackageOBJ.monthPicker.setValue("R003-form","SEARCH_STDR_MT", fromDay);		
	
			R003.renderTuiGrid();
		}
		
		this.renderTuiGrid = function() {
			 
			 var colArrayInfo = [
				 	{ header : "기준년월"		, name: "STDR_MT"			, width : 80 , align: "center", resizable: true, hidden:false },
			        { header : "원재료코드"	, name: "ITEM_CODE"			, width : 150, align: "left"   ,resizable: true, hidden:false },
			        { header : "HS CODE"		, name: "HS_CODE"			, width : 100, align: "center" ,resizable: true, hidden:false ,formatter: KpackageOBJ.tuiGrid.dateFormatter  },
			        { header : "원재료구분"	, name: "RAWMTRL_SE"		, width : 80 , align: "center" ,resizable: true, hidden:false ,formatter: KpackageOBJ.tuiGrid.hscode10},
			        { header : "수입신고번호"	, name: "IMPDEC_NO"			, width : 150, align: "center" ,resizable: true, hidden:false},
			        { header : "란"			, name: "LNE_NO"			, width : 60 , align: "center" ,resizable: true, hidden:false},
			        { header : "행"			, name: "POUCH_NO"			, width : 60 , align: "center" ,resizable: true, hidden:false},
			        { header : "수량"			, name: "QY"				, width : 100, align: "right"  ,resizable: true, hidden:false ,formatter: KpackageOBJ.tuiGrid.commas},
			        { header : "관세"			, name: "CSTMS"				, width : 100, align: "right"  ,resizable: true, hidden:false ,formatter: KpackageOBJ.tuiGrid.commas},
			        { header : "관세금액"		, name: "CSTMS_AMOUNT"		, width : 150, align: "right"  ,resizable: true, hidden:false ,formatter: KpackageOBJ.tuiGrid.commas  },
			        { header : "단위"			, name: "CSTMS_AMOUNT_UNIT"	, width : 60 , align: "center" ,resizable: true, hidden:false},
			        { header : "출고수량"		, name: "DLIVY_QY"			, width : 100, align: "right"  ,resizable: true, hidden:false ,formatter: KpackageOBJ.tuiGrid.commas  },
			        { header : "출고금액"		, name: "DLIVY_AMOUNT"		, width : 100, align: "right"  ,resizable: true, hidden:false ,formatter: KpackageOBJ.tuiGrid.commas  },
			        { header : "기본단위"		, name: "BASS_UNIT"			, width : 60 , align: "center" ,resizable: true, hidden:false},
			        { header : "통화키"		, name: "ACPLC_CRNCY"		, width : 60 , align: "center" ,resizable: true, hidden:false}
			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_R003_List", "/report/retrieve_R003List", colArrayInfo, "number", null);
			 
		}
		
		this.retrieve_R003List = function() {
			
			var param = { "STDR_MT" : KpackageOBJ.object.getFormValue("R003-form", "SEARCH_STDR_MT") };
			
			KpackageOBJ.tuiGrid.retrieve("oTui_R003_List", "/report/retrieve_R003List", param);
			
		}
	
	}
	
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		R003.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});
	
	
</script>
</body>
</html>