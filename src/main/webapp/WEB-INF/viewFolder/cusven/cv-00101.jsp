<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
/******************************************************************************************************
	Program Name : 수출신고 조회 상세조회
	Program Code : CV00101
******************************************************************************************************/
%>
<!DOCTYPE html>
<html>
<head>

	
	
	
	
</head>
<body>
<div id="content">
	<section id="widget-grid-CV00101" class="">
		<form:form id="CV00101-form" class="s4-form" novalidate="novalidate" onsubmit="return false;">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<input type="hidden" id="P_SUPT_DOC_NO"     name ="P_SUPT_DOC_NO"    value="${reqParam.P_SUPT_DOC_NO }"/>
			<input type="hidden" id="P_SUPT_DOC_CODE"   name ="P_SUPT_DOC_CODE"  value="${reqParam.P_SUPT_DOC_CODE }"/>
			<input type="hidden" id="P_DIVISION_CODE"   name ="P_DIVISION_CODE"  value="${reqParam.P_DIVISION_CODE }"/>
			
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div class="table-responsive of-hidden">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:120px;" />
								<col style="width: " />
								<col style="width:120px;" />
								<col style="width: ;" />
								<col style="width:120px;" />
								<col style="width: ;" />
								
							</colgroup>
							<tbody>
								<tr>
									<th>근거서류번호</th>
									<td colspan="5">
										[<c:out value="${reqParam.P_SUPT_DOC_CODE }"></c:out>] <c:out value="${reqParam.P_SUPT_DOC_NO }"></c:out> 
									</td>
									
								</tr>
								<tr>
									<th>근거서류일자</th>
									<td style="vertical-align:middle;">
										<span id="P_SUPT_DATE"></span>
										<%-- <c:out value="${reqParam.P_SUPT_DATE }"></c:out> --%>
									</td>
									<th>근거서류구분</th>
                                    <td style="vertical-align:middle;">
                                        <c:out value="${reqParam.P_CODE_NM }"></c:out>
                                    </td>
									<th>고객사 명</th>
									<td style="vertical-align:middle;">
										<c:out value="${reqParam.P_ATTRIBUTE01 }"></c:out>
									</td>
									
								</tr>
								<tr>
									<th>품목 수</th>
									<td style="vertical-align:middle;">
										<span id="P_ITEM_CNT"></span>
									</td>
									<th>총 수량</th>
									<td style="vertical-align:middle;">
										<span id="P_SUM_QY"></span>
									</td>
									<th>총 금액</th>
									<td style="vertical-align:middle;">
										<span id="P_SUM_AMOUNT"></span>
									</td>
								</tr>
							
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</form:form>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<p class="alert alert-info mb0">근거서류 품목</p></div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_CV00101_01" name="div_oTui_CV00101_01" class="tuigrid-resizable">
					<div id="oTui_CV00101_01" data-fixed-height="250"></div>
					<!-- <div id="oTui_CV00101_01_paging"></div> -->
				</div>
			</div>
			
		</div>
	</section>
</div>

<script type="text/javascript">


	var oTui_CV00101_01
	var CV00101 = new function() {
		this.initialize_viewObject = function(){

			$("#CV00101-form #P_SUPT_DATE").html(KpackageOBJ.formatter.date("<c:out value='${reqParam.P_SUPT_DATE }'></c:out>"));
			$("#CV00101-form #P_ITEM_CNT").html(KpackageOBJ.formatter.commas("<c:out value='${reqParam.P_ITEM_CNT }'></c:out>"));
			$("#CV00101-form #P_SUM_QY").html(KpackageOBJ.formatter.commas("<c:out value='${reqParam.P_SUM_QY }'></c:out>"));
			$("#CV00101-form #P_SUM_AMOUNT").html(KpackageOBJ.formatter.commas("<c:out value='${reqParam.P_SUM_AMOUNT }'></c:out>"));
			
            
		}
		
		this.initialize_TuiGrid = function(){
			
			// 수출내역 정보 Grid
			var colArrayInfo = [
				
				
				
				{ "name" :"SUPT_DOC_ITEM_SEQ",   	"header" : "순번",  			"align" :"center"    ,"width" : 30,"hidden" : false},
				{ "name" :"ITEM_CODE",   		    "header" : "품목코드",  		"align" :"left"    ,"width" : 150,"hidden" : false},
				{ "name" :"ITEM_NM",   		        "header" : "품목 명",  		"align" :"left"      ,"width" : 200,"hidden" : false},
				{ "name" :"QY",   		            "header" : "수량",  			"align" : "right"    ,"width" : 80,"hidden" : false, "formatter" : KpackageOBJ.tuiGrid.commas },
				{ "name" :"UNIT_PRICE",   		    "header" : "단가",  			"align" : "right"    ,"width" : 100,"hidden" : false, "formatter" : KpackageOBJ.tuiGrid.commas },
				{ "name" :"BASS_UNIT",   		    "header" : "단위",  			"align" :"center"    ,"width" : 60,"hidden" : false},
				{ "name" :"AMOUNT",   	            "header" : "총 금액",  		"align" : "right"    ,"width" : 100,"hidden" : false, "formatter" : KpackageOBJ.tuiGrid.commas },
				{ "name" :"HS_CODE10",              "header" : "HS Code",        "align" :"center"    ,"width" : 100,"hidden" : false, "formatter" : KpackageOBJ.tuiGrid.hscode10 },
				{ "name" :"USE_YN",   		        "header" : "유효성",  		"align" :"center"    ,"width" : 60,"hidden" : false},
				{ "name" :"CREATE_DATE",   		    "header" : "최초생성일",  	"align" :"center"    ,"width" : 100,"hidden" : false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
				{ "name" :"UPDATE_DATE",   		    "header" : "최종수정일",  	"align" :"center"    ,"width" : 100,"hidden" : false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter },
				
				{ "name" :"COMPANY_CODE",           "header" : "",           "align" :"center"    ,"width" : 100,"hidden" : true},
                { "name" :"DIVISION_CODE",          "header" : "",           "align" :"center"    ,"width" : 100,"hidden" : true},
				{ "name" :"SUPT_DOC_CODE",          "header" : "근거서류번호(내부)",             "align" :"center"    ,"width" : 100,"hidden" : true},
				{ "name" :"CREATE_BY",              "header" : "",           "align" :"center"    ,"width" : 100,"hidden" : true},
				{ "name" :"UPDATE_BY",              "header" : "",           "align" :"center"    ,"width" : 100,"hidden" : true}
				
				
		    ];
			  
			oTui_CV00101_01 = KpackageOBJ.tuiGrid.create("oTui_CV00101_01","/cusven/retrieve_CV00101_List", colArrayInfo, null, null, CV00101.onDblClick_oTui_Grid);
	    	
			
	    	
		};
		
		this.onDblClick_oTui_Grid = function(gridId, rowkey, colName){};
		
		
		this.retrieve_Header_Information_callback = function(result){
			var data = result.value;
			
			$("#CV00101-form #XPORT_STTEMNT_NO").html(data["XPORT_STTEMNT_NO"]);
			$("#CV00101-form #MANUFAC_NAME").html(data["MANUFAC_NAME"]);
			$("#CV00101-form #COMPANY_NM").html(data["COMPANY_NM"]);
			$("#CV00101-form #DSPTH_DATE").html(data["DSPTH_DATE"]);
			$("#CV00101-form #NATION_CODE").html(data["NATION_CODE"]);
			$("#CV00101-form #ITEM_QTY").html(data["ITEM_QTY"]);
			$("#CV00101-form #INV_NO").html(data["INV_NO"]);
          
			CV00101.retrieve_List();
		}
		this.retrieve_List = function(){
			var param = KpackageOBJ.data.makePostData("CV00101-form");
			KpackageOBJ.tuiGrid.retrieve("oTui_CV00101_01", "", param);
		}
		
		
	}

	$(document).ready(function() {
		pageSetUp();						// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		CV00101.initialize_viewObject();	// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		CV00101.initialize_TuiGrid();		// Toast Grid Render

		CV00101.retrieve_List();
		
		
	});

</script>
	
</body>
</html>