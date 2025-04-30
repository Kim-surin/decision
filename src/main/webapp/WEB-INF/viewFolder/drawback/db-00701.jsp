<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	/**********************************************************************************************
	* PGM ID : DB00701
	* PGM DESC : 매출확정(내수)
	* Remark : 
	*
	**********************************************************************************************/

%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<style>
	.db00701_column{
	background-color:#fff797;
	}
</style>
<body>
<div id="content">
	<section id="widget-grid-DB00701" class="">
		<form:form id="DB00701-form" class="s4-form" novalidate="novalidate" action="/db-002" method="post">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			
			<input type="hidden" id="P_SUPT_MONTH" name="P_SUPT_MONTH" value="${reqParam.P_SUPT_MONTH }"/>
			<input type="hidden" id="P_CUSTOMER_CODE" name="P_CUSTOMER_CODE" value="${reqParam.P_CUSTOMER_CODE }"/>
			<input type="hidden" id="P_HS_CODE10" name="P_HS_CODE10" value="${reqParam.P_HS_CODE10 }"/>
			<input type="hidden" id="P_ISSUE_TYPE" name="P_ISSUE_TYPE" value="${reqParam.P_ISSUE_TYPE }"/>
			<input type="hidden" id="P_ITEM_CODE" name="P_ITEM_CODE" value="${reqParam.P_ITEM_CODE }"/>
			<input type="hidden" id="P_DIVISION_CODE" name="P_DIVISION_CODE" value="${reqParam.P_DIVISION_CODE }"/>
		</form:form>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_DB00701_List" name="div_oTui_DB00701_List" class="tuigrid-resizable">
					<div id="oTui_DB00701_List" data-fixed-height="400"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>
	
	var DB00701 = new function(){
		
		this.Initialize_viewObject = function() {
			
		}
		
		this.renderTuiGrid = function() {
			 var colArrayInfo = [

					{ header : "매출월"    			,name : "SUPT_MONTH"     	,width : 80, align: "center" 	,hidden:false, "formatter" : KpackageOBJ.tuiGrid.monthFormatter},
					{ header : "판매처명"     		,name : "CUSTOMER_NAME"     ,width : 200, align: "left" 	,hidden:false, "formatter" : DB00701.setCodeNmColor  },				
					{ header : "근거서류번호"    		,name : "SUPT_DOC_CODE"     ,width : 150, align: "center" 	,hidden:false },				
					{ header : "근거서류구분"    		,name : "SUPT_DOC_SE"       ,width : 100, align: "center" 	,hidden:false },
					{ header : "발급문서번호"    		,name : "CREATE_PRESENTN_NO",width : 150, align: "center" 	,hidden:false },
					{ header : "HS CODE"    			,name : "HS_CODE10"         ,width : 100, align: "center" 	,hidden:false, "formatter" : KpackageOBJ.tuiGrid.hscode10},
					
					{ header : "대표품번"    			,name : "ITEM_CODE"     	,width : 150, align: "left" 	,hidden:false },
					{ header : "대표품명"    			,name : "ITEM_NM"       	,width : 200, align: "left" 	,hidden:false },
					{ header : "수량"    			    ,name : "QY"     			,width : 80,  align: "right" 	,hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas},
					{ header : "단가"                 ,name : "UNIT_PRICE"        ,width : 80,  align: "right"    ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas},
					{ header : "금액"    			    ,name : "AMOUNT"     		,width : 80,  align: "right" 	,hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas},
					
					{ header : "ISSUE_TYPE"  			,name : "ISSUE_TYPE"        ,width : 100, align: "center" 	,hidden:true  },
					{ header : "발급수량"             ,name : "CREATE_COUNT"      ,width : 80,  align: "right"    ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas},
					{ header : "발급금액"             ,name : "CREATE_AMOUNT"       ,width : 80,  align: "right"    ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.commas},
					{ header : "근거서류수취일" 		,name : "SUPT_DATE"        	,width : 100, align: "center" 	,hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter},
	                { header : "확정실패사유"         ,name : "CODE_NM"           ,width : 100, align: "left"   ,hidden:false },
	                { header : "최초확정시도일자"     ,name : "CREATE_DATE"           ,width : 100, align: "center"   ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter},
	                { header : "최종확정시도일자"     ,name : "UPDATE_DATE"           ,width : 100, align: "center"   ,hidden:false, "formatter" : KpackageOBJ.tuiGrid.dateFormatter},
	                
	                { header : "확정실패코드"  		,name : "FAIL_REASON_CODE"  ,width : 100, align: "center" 	,hidden:true  },
	                { header : "USE_TYPE" 		    ,name : "USE_TYPE"        	,width : 100, align: "center" 	,hidden:true  },
					{ header : "COMPANY_CODE"  		,name : "COMPANY_CODE"      ,width : 100, align: "center" 	,hidden:true  },
					{ header : "DIVISION_CODE"  		,name : "DIVISION_CODE"     ,width : 100, align: "center" 	,hidden:true  },
					{ header : "판매처코드"    		,name : "CUSTOMER_CODE"     ,width : 120, align: "left" 	,hidden:true  }
					
	                   /* { header : "기납/분증 발급번호"    ,name : "PRESENTN_NO"           ,width : 100, align: "center"   ,hidden:false },
                    { header : "양도일자"             ,name : "CHIT_FRMTRM_DATE"      ,width : 100, align: "center"   ,hidden:false },
                    { header : "발급 수량"            ,name : "ISSUE_CNT"             ,width : 100, align: "center"   ,hidden:false },
                    { header : "발급상태"             ,name : "USE_TYPE_NAME"         ,width : 100, align: "center"   ,hidden:false }, */
					/* { header : "발급구분"               ,name : "ISSUE_NAME"            ,width : 80, align: "center"    ,hidden:false }, */
			    ];
			   
			 
			 var tools = [ {icon:"excel", title:"엑셀다운로드" 	,text:"엑셀다운로드"	,func:"DB00701.excel_DB00701List"}
						  ,{icon:"save",  title:"확정" 			,text:"확정" 			,func:"DB00701.makeCofirmData"}
						  ,{icon:"save",  title:"확정취소" 		,text:"확정취소" 		,func:"DB00701.removeCofirmData"}
							];
			 KpackageOBJ.tuiGrid.setButton("oTui_DB00701_List", tools); // Toobar 생성

			 KpackageOBJ.tuiGrid.create("oTui_DB00701_List", "/drawback/retrieve_DB00701List", colArrayInfo, 'number', DB00701.oTui_DB00701_List_onClick_Handler, DB00701.oTui_DB00701_List_onDblclick_Handler );
			 
		}
		
		this.oTui_DB00701_List_onClick_Handler  = function(p_GridId, p_RowKey, p_ColName){}
		
		this.oTui_DB00701_List_onDblclick_Handler = function(p_GridId, p_RowKey, p_ColName){
			
		}
		
		/**  조회버튼 클릭 */
		this.retrieve_DB00701List = function() {
			var param = KpackageOBJ.data.makePostData("DB00701-form");  
			KpackageOBJ.tuiGrid.retrieve("oTui_DB00701_List", "", param);
			
		}
		
		/** 확정데이터 생성*/
		this.makeCofirmData = function(){
// 			var rowData = KpackageOBJ.tuiGrid.getCheckedRows("oTui_DB00701_List");
			var rowData = KpackageOBJ.tuiGrid.getRowValues("oTui_DB00701_List", 0, false);
			
			var rowArr = [];
			rowArr[0] = rowData;

			KpackageOBJ.ajax.doSubmit("/drawback/confirm_DB007_SelngList", rowArr, DB00701.makeCofirmData_callback);	
			
		}
		
		this.makeCofirmData_callback = function(result){
			alert(result.message);
			DB00701.retrieve_DB00701List();
		}
		
		/** 확정데이터 취소*/
		this.removeCofirmData = function(){
			//To Do. 신청이 들어가거나 완료되지 않은 건에 대해서 취소 해야하므로 체크로직 필요
			
		}
		
		this.excel_DB00701List = function(){
			
		}
		
		this.setCodeNmColor = function(rowData){
			//KpackageOBJ.tuiGrid.getGrid("oTui_DB00701_List").addCellClassName(rowData.row.rowKey,"CODE_NM","db00701_column");
			return rowData.value;
		}
		
	
	}
	
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB00701.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		DB00701.renderTuiGrid();
		DB00701.retrieve_DB00701List();
	});
	
	
</script>
</body>
</html>