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
		<form:form id="RB02101-form" class="s4-form" novalidate="novalidate" action="/refundBasis-004" method="post">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_ExcelUploadErrorList" name="div_oTui_ExcelUploadErrorList" class="tuigrid-resizable">
					<div id="oTui_ExcelUploadErrorList" data-minus-height="240"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>
	
	var RB02101 = new function(){
		this.Initialize_viewObject = function() {
			
			RB02101.renderTuiGrid();
			RB02101.retrieve_ExcelUploadErrorList();
		}
		
		this.renderTuiGrid = function() {
		    var colArrayInfo = null;
		    
		    if("EXP" == RB021.workType){
		        colArrayInfo = [
				     {"header" : '오류내용'			,name : 'ERROR_MESSAGE' ,width : 220,  	align: 'left', hidden:false },
				     {"header" : '에러여부'			,name : 'ERROR_YN' 	 	,width : 120,  	align: 'left', hidden:true },
				     {"header" : '상품코드(수출)'  		,name : 'ATTR00'        ,width : 120,  	align: 'left', hidden:false },
				     {"header" : '신고번호'       		,name : 'ATTR01'        ,width : 120,  	align: 'left', hidden:false },
				     {"header" : '란번호'        		,name : 'ATTR02'        ,width : 120,  	align: 'left', hidden:false },
				     {"header" : '규격번호'       		,name : 'ATTR03'        ,width : 120,  	align: 'left', hidden:false },
				     {"header" : '수출대행자상호'   	,name : 'ATTR04'        ,width : 120,  	align: 'left', hidden:false },
				     {"header" : '수출대화주사업자번호'	,name : 'ATTR05'        ,width : 120,  	align: 'left', hidden:false },
				     {"header" : '수출자구분'        	,name : 'ATTR06'        ,width : 120,  	align: 'left', hidden:false },
				     {"header" : '수출화주상호'       	,name : 'ATTR07'        ,width : 120,  	align: 'left', hidden:false },
				     {"header" : '제조자상호'        	,name : 'ATTR08'        ,width : 120,  	align: 'left', hidden:false },
				     {"header" : '해외구매자상호'      	,name : 'ATTR09'        ,width : 120,  	align: 'left', hidden:false },
				     {"header" : '해외구매자부호'      	,name : 'ATTR10'        ,width : 130,  	align: 'left', hidden:false },
				     {"header" : '신청세관'        	,name : 'ATTR11'        ,width : 130,  	align: 'left', hidden:false },
				     {"header" : '신청세관의과부호'     	,name : 'ATTR12'        ,width : 130,  	align: 'left', hidden:false },
				     {"header" : '거래구분'        	,name : 'ATTR13'        ,width : 130,  	align: 'left', hidden:false },
				     {"header" : '수출종류'        	,name : 'ATTR14'        ,width : 130,  	align: 'left', hidden:false },
				     {"header" : '결제방법'        	,name : 'ATTR15'        ,width : 130,  	align: 'left', hidden:false },
				     {"header" : '목적국코드'        	,name : 'ATTR16'        ,width : 130,  	align: 'left', hidden:false },
				     {"header" : '환급신청인'        	,name : 'ATTR17'        ,width : 130,  	align: 'left', hidden:false },
				     {"header" : '총중량'        		,name : 'ATTR18'        ,width : 130,  	align: 'left', hidden:false },
				     {"header" : '단위'        		,name : 'ATTR19'        ,width : 130,  	align: 'left', hidden:false },
				     {"header" : '총포장갯수'        	,name : 'ATTR20'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '총포장종류'        	,name : 'ATTR21'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '총신고금액'        	,name : 'ATTR22'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '총신고금액미화'      	,name : 'ATTR23'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '인도조건'        	,name : 'ATTR24'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '총결제통화'        	,name : 'ATTR25'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '총결제금액'        	,name : 'ATTR26'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '미화환율'        	,name : 'ATTR27'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '결제환율'        	,name : 'ATTR28'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '수출수리일자'       	,name : 'ATTR29'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '총란수'        		,name : 'ATTR30'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '세번부호'        	,name : 'ATTR31'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '표준품명'        	,name : 'ATTR32'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '거래품명'        	,name : 'ATTR33'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '송품장부호'        	,name : 'ATTR34'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '상표명'        		,name : 'ATTR35'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '신고가격원화'       	,name : 'ATTR36'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '신고가격미화'      	,name : 'ATTR37'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '결제통화'        	,name : 'ATTR38'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '인도조건_1'        	,name : 'ATTR39'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '결제금액'        	,name : 'ATTR40'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '순중량'        		,name : 'ATTR41'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '순중량단위'        	,name : 'ATTR42'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '포장갯수'        	,name : 'ATTR43'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '포장단위'        	,name : 'ATTR44'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '원산지국가부호'       ,name : 'ATTR45'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '품명규격1'        	,name : 'ATTR46'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '품명규격2'        	,name : 'ATTR47'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '품명규격3'        	,name : 'ATTR48'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '품명규격4'        	,name : 'ATTR49'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '품명규격5'        	,name : 'ATTR50'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '품명규격6'        	,name : 'ATTR51'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '품명규격7'        	,name : 'ATTR52'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '품명규격8'        	,name : 'ATTR53'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '성분1'        		,name : 'ATTR54'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '성분2'        		,name : 'ATTR55'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '수량_1'        		,name : 'ATTR56'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '수량단위_1'        	,name : 'ATTR57'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '단가'        		,name : 'ATTR58'        ,width : 140,  	align: 'left', hidden:false },
				     {"header" : '금액'        		,name : 'ATTR59'        ,width : 140,  	align: 'left', hidden:false }

				    ];
		    }else if("IMP" == RB021.workType){
		        colArrayInfo = [
		            {"header" : '오류내용'			,name : 'ERROR_MESSAGE' ,width : 220,  	align: 'left', hidden:false },
				    {"header" : '에러여부'			,name : 'ERROR_YN' 	 	,width : 120,  	align: 'left', hidden:true },
		            {"header" : '신고번호',           	name : 'ATTR00'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '수리일자',           	name : 'ATTR01'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '세관',             	name : 'ATTR02'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '과',         		name : 'ATTR03'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : 'MasterB/L번호',             name : 'ATTR04'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : 'B/L(AWB)번호',             name : 'ATTR05'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '수입자상호',             name : 'ATTR06'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '납세의무자상호',             name : 'ATTR07'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '납세의무자대표자',             name : 'ATTR08'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '납세의무자사업번호',             name : 'ATTR09'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '해외거래처상호',             name : 'ATTR10'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '해외거래처부호',             name : 'ATTR11'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '해외거래처국가',             name : 'ATTR12'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '신고구분부호',             name : 'ATTR13'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '거래구분부호',             name : 'ATTR14'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '수입종류부호',             name : 'ATTR15'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '총중량',             name : 'ATTR16'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '총포장갯수',             name : 'ATTR17'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '총포장종류',             name : 'ATTR18'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '적출국부호',             name : 'ATTR19'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '총란수',             name : 'ATTR20'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '인도조건',             name : 'ATTR21'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '결제통화',             name : 'ATTR22'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '결제환율',             name : 'ATTR23'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '미화환율',             name : 'ATTR24'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '결제총금액',             name : 'ATTR25'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '결재방법',             name : 'ATTR26'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '결제금액',             name : 'ATTR27'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '총과세가격미화',             name : 'ATTR28'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '총과세가격원화',             name : 'ATTR29'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '총세액합계',             name : 'ATTR30'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '란번호',             name : 'ATTR31'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '세번부호',             name : 'ATTR32'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '품명',             name : 'ATTR33'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '거래품명',             name : 'ATTR34'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '자재코드&품명',             name : 'ATTR35'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '신고가격',             name : 'ATTR36'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '과세가격(원화)',             name : 'ATTR37'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '과세가격미화',             name : 'ATTR38'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '순중량',             name : 'ATTR39'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '순중량단위',             name : 'ATTR40'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '수량',             name : 'ATTR41'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '수량단위',             name : 'ATTR42'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '환급물량',             name : 'ATTR43'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '환급물량단위',             name : 'ATTR44'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '원산지국가부호',             name : 'ATTR45'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '관세율',             name : 'ATTR46'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '관세액',             name : 'ATTR47'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '총규격수',             name : 'ATTR48'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '규격번호',             name : 'ATTR49'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '자재코드',             name : 'ATTR50'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '규격1',             name : 'ATTR51'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '규격2',             name : 'ATTR52'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '규격3',             name : 'ATTR53'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '성분1',             name : 'ATTR54'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '성분2',             name : 'ATTR55'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '규격수량',             name : 'ATTR56'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '규격단위',             name : 'ATTR57'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '규격단가',             name : 'ATTR58'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '규격금액',             name : 'ATTR59'        ,width : 120,  	align: 'left', hidden:false },
			        {"header" : '규격별관세',             name : 'ATTR59'        ,width : 120,  	align: 'left', hidden:false }
	            ];
		    }
			
			 
			 KpackageOBJ.tuiGrid.create("oTui_ExcelUploadErrorList", "/refundbasis/excelUpload_ErrorList", colArrayInfo, 'number', null);
			 
		}
		
		this.retrieve_ExcelUploadErrorList = function() {
			
			var param = { "DUMMY" : "DUMMY"};
			KpackageOBJ.tuiGrid.retrieve("oTui_ExcelUploadErrorList", "/refundbasis/excelUpload_ErrorList", param);
			
		}
	
	}
	
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		RB02101.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});
	
	
</script>
</body>
</html>