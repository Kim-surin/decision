<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form:form id="SM002-form" class="s4-form" novalidate="novalidate">
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
								<col style="width:" />
							</colgroup>
							<tbody>
								<tr>
									<th>사용유무</th>
									<td> 
										<select class="form-control searchSelect" id="SEARCH_USING_YN" name="SEARCH_USING_YN" style="width:110px"></select>
									</td>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:130px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="SM002.retrieve_gridData"/>
										
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:SM002.retrieve_bomList();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
				<div id="div_oTui_Intg_master" name="div_oTui_Intg_master" class="tuigrid-resizable">
					<div id="oTui_Intg_master" data-minus-height="270"></div>
					<div id="oTui_Intg_master_paging"></div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-12 col-md-8 col-lg-8">
				<div id="div_oTui_Intg_detail" name="div_oTui_Intg_detail" class="tuigrid-resizable">
					<div id="oTui_Intg_detail" data-minus-height="270"></div>
					<div id="oTui_Intg_detail_paging"></div>
				</div>
			</div>
		</div>
		
	
	</section>

</div>

<script>


	var SM002 = new function(){
	
		this.Initialize_viewObject = function() {
			
			
			var arrayItem = [{value:"", name:"ALL"}
							,{value:"Y", name:"Yes"}
							,{value:"N", name:"No"}];

			KpackageOBJ.selectbox.create("SM002-form","SEARCH_USING_YN","", null,"value","name", arrayItem);
			
	
			/*Search Type Select Box Create */
			arrayItem = [{value:"SEARCH_TYPE_O1", name:"<spring:message code='인터페이스 코드'/>"}
						,{value:"SEARCH_TYPE_O2", name:"<spring:message code='인터페이스 명'/>"}];
			
			KpackageOBJ.selectbox.create("SM002-form","SEARCH_TYPE","", null,"value","name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			             ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						 ,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("SM002-form","SEARCH_OPTION","", null,"value","name", arrayItem);
			
			SM002.renderTuiGrid();
		}
		
		this.renderTuiGrid = function() {
			 
			 var colArrayInfo = [
				 {"header" :"인터페이스_코드"    , name:"IF_CODE"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"회사 코드"    , name:"COMPANY_CODE"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"인터페이스 명"    , name:"IF_NAME"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"소스 테이블"    , name:"SOURCE_TABLE"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"대상 테이블"    , name:"TARGET_TABLE"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"이력 테이블"    , name:"HISTORY_TABLE"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"검증 프로그램 명"    , name:"VRIFY_PROGRAM_NAME"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"소스 프로그램명"    , name:"SOURCE_PROGRAM_NAME"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"인터페이스 유형"    , name:"INTERFACE_TYPE"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"결과 항목명"    , name:"RETURN_COLUMN_NAME"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"결과 항목 값"    , name:"RETURN_COLUMN_VALUE"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"결과 메시지 항목명"    , name:"RETURN_MSG_COLUMN_NAME"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"비고"    , name:"REMARK"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"사용 여부"    , name:"USING_YN"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"ATTRIBUTE01"    , name:"ATTRIBUTE01"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"ATTRIBUTE02"    , name:"ATTRIBUTE02"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"ATTRIBUTE03"    , name:"ATTRIBUTE03"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"ATTRIBUTE04"    , name:"ATTRIBUTE04"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"ATTRIBUTE05"    , name:"ATTRIBUTE05"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"생성 일자"    , name:"CREATE_DATE"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"생성 자"    , name:"CREATE_BY"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"수정 일자"    , name:"UPDATE_DATE"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"수정 자"    , name:"UPDATE_BY"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"이관프로그램명"    , name:"TRANS_PROGRAM_NAME"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"이관회사코드여부"    , name:"TRANS_COMPANY_CODE_YN"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"이관사업부코드여부"    , name:"TRANS_DIVISION_CODE_YN"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"엑셀 업로드 여부"    , name:"EXCEL_UPLOAD_YN"    , width: 80    ,align:"center"    ,hidden:false}, 
				 {"header" :"인터페이스방법"    , name:"ITEM_TYPE"    , width: 80    ,align:"center"    ,hidden:false}
			        
			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_Intg_master","/sys/retrieveInterfaceItemMaster", colArrayInfo, null, null, SM002.dbl_Handler);
			 KpackageOBJ.tuiGrid.setCaption("oTui_Intg_master","<spring:message code='인터페이스 아이템 마스터'/>");
			 
			 var colInfoArray1 = [
				 {"header" :"인터페이스 항목 id"       ,name:"INTERFACE_ITEM_DTL_ID"    ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"인터페이스 코드"          ,name:"IF_CODE"                  ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"회사 코드"                ,name:"COMPANY_CODE"             ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"컬럼 전송유형"            ,name:"COLUMN_TRANS_TYPE"        ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"대상 컬럼"                ,name:"TARGET_COLUMN"            ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"소스 컬럼"                ,name:"SOURCE_COLUMN"            ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"이력 컬럼"                ,name:"HISTORY_COLUMN"           ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"컬럼명"                   ,name:"COLUMN_NAME"              ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"컬럼 type"                ,name:"COLUMN_TYPE"              ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"컬럼 길이"                ,name:"COLUMN_LENGTH"            ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"컬럼 소수점 길이"         ,name:"COLUMN_DCMLPOINT_LENGTH"  ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"컬럼 포맷 형식"           ,name:"COLUMN_FORMAT_FORM"       ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"컬럼 디폴트 값"           ,name:"COLUMN_DFLT_VALUE"        ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"컬럼 검증 프로그램 명"    ,nAME:"COLUMN_VRIFY_PROGRAM_NAME",width:80    ,align:"center"    ,hidden:false},
				 {"header" :"컬럼 필수 여부"           ,name:"COLUMN_REQUIRED_YN"       ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"pk 여부"                  ,name:"PK_YN"                    ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"사용 여부"                ,name:"USING_YN"                 ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"정렬순번"                 ,name:"ATTRIBUTE01"              ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"ATTRIBUTE02"              ,name:"ATTRIBUTE02"              ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"ATTRIBUTE03"              ,name:"ATTRIBUTE03"              ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"ATTRIBUTE04"              ,name:"ATTRIBUTE04"              ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"ATTRIBUTE05"              ,name:"ATTRIBUTE05"              ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"생성 일자"                ,name:"CREATE_DATE"              ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"생성 자"                  ,name:"CREATE_BY"                ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"수정 일자"                ,name:"UPDATE_DATE"              ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"수정 자"                  ,name:"UPDATE_BY"                ,width:80    ,align:"center"    ,hidden:false},
				 {"header" :"샘플 데이터"              ,name:"SAMPLE_DATA"              ,width:80    ,align:"center"    ,hidden:false}

			 ];

			var params = {"DUMMY" :"" };
				retrieveURL ="";
				/* 그리드 생성 */
				KpackageOBJ.tuiGrid.create("oTui_Intg_detail","/sys/retrieveInterfaceItemDetail", colInfoArray1, null, null );
				KpackageOBJ.tuiGrid.setCaption("oTui_Intg_detail","<spring:message code='인터페이스 아이템 상세'/>");
				
				
		}
		
		this.dbl_Handler = function(gridId, rowkey, colName){
			var rowData = KpackageOBJ.tuiGrid.getSelectedRowlValue(gridId, rowkey);
			var param = {"IF_CODE" : rowData.IF_CODE};
		
			KpackageOBJ.tuiGrid.retrieve("oTui_Intg_detail","/sys/retrieveInterfaceItemDetail", param);
		}
		
		
		this.retrieve_bomList = function(){
			
			var param = {"SEARCH_USING_YN" : KpackageOBJ.object.getFormValue("SM002-form","SEARCH_USING_YN")
						,"SEARCH_TYPE"     : KpackageOBJ.object.getFormValue("SM002-form","SEARCH_TYPE")
					 	,"SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("SM002-form","SEARCH_KEY_WORD")
			         	,"SEARCH_OPTION"   : KpackageOBJ.object.getFormValue("SM002-form","SEARCH_OPTION")
						};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_Intg_master","/sys/retrieveInterfaceItemMaster", param);
			
		}
	
	}
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		SM002.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});
</script>
</body>
</html>