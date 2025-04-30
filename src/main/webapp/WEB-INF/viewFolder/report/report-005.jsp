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
		<form:form id="R005-form" class="s4-form" novalidate="novalidate" action="/report-001" method="post">
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
									<th><spring:message code='기준월' /></th>
									<td>
										<input type="text" id="SEARCH_STDR_MT"  name="SEARCH_STDR_MT"  class="inputText has-month-picker"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:R005.retrieve_R005List();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_R005_List" name="div_oTui_R005_List" class="tuigrid-resizable">
					<div id="oTui_R005_List" data-minus-height="250"></div>
					<div id="oTui_R005_List_paging"></div>
				</div>
			</div>
		</div>

	
	</section>

</div>

<script>
	
	var R005 = new function(){

	
		this.Initialize_viewObject = function() {
			
			var fromDay = KpackageOBJ.date.getCurrMonth();
			
			KpackageOBJ.monthPicker.create("R005-form", "SEARCH_STDR_MT");
			KpackageOBJ.monthPicker.setValue("R005-form","SEARCH_STDR_MT", fromDay);		
	
			R005.renderTuiGrid();
		}
		
		this.renderTuiGrid = function() {
			 
			 var colArrayInfo = [
				 	{ header : '기준월', name: 'STDR_MT', width : 100,align: "center", resizable: true, hidden:false  },
			        { header : '플랜트', name: 'DIVISION_CODE', width : 80, align: "left" , resizable: true, hidden:false},
			        { header : '자재코드', name: 'ITEM_CODE', width : 150, align: "center" , resizable: true, hidden:false},
			        { header : '판매처', name: 'CUSTOMER_CODE', width : 80, align: "right" , resizable: true, hidden:false},
			        { header : '판매문서', name: 'SLE_PRIC_DOC', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '고객자재', name: 'CSTMR_ITEM', width : 100, align: "right", resizable: true, hidden:false },
			        { header : '대금청구일', name: 'PRIC_RQEST_DATE', width : 100, align: "right" , formatter: KpackageOBJ.tuiGrid.dateFormatter, resizable: true, hidden:false},
			        { header : '판정유형', name: 'JDGMNT_TYPE', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '로컬/수출', name: 'XPORT_AT', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '사급구분', name: 'SA_SE', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '자재내역', name: 'ITEM_NM', width : 150, align: "right" , resizable: true, hidden:false},
			        { header : '자재그룹', name: 'ITEM_GROUP', width : 200, align: "right" , resizable: true, hidden:false},
			        { header : '환급구분코드', name: 'DRWBAK_SE_CODE', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '상품여부', name: 'GOODS_AT', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '기본단위', name: 'BASS_UNIT', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '실제대금청구수량', name: 'REAL_PRIC_RQEST_QY', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '현지통화금액', name: 'ACPLC_CRNCY_AMOUNT', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '신고가격-원화', name: 'STTEMNT_PC_KRW', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '환급금액', name: 'DRWBAK_AMOUNT', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '환급금액(공제비율)', name: 'DRWBAK_DDC_AMOUNT', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '환급금액(절사금액)', name: 'DRWBAK_TRMMG_AMOUNT', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : 'HS CODE', name: 'HS_CODE', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '국가코드', name: 'NATION_CODE', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '통화키', name: 'ACPLC_CRNCY', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '원화콩화', name: 'KRW_CRNCY', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '접수여부', name: 'EXECUT_AT', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '수출신고관리번호', name: 'EXPDECL_MANAGE_NO', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '수출거래구분', name: 'XPORT_SE', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '수출신호번호', name: 'XPORT_STTEMNT_NO', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '란번호(4)', name: 'LNE_NO', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '행(4)', name: 'ROW1', width : 100, align: "right" , resizable: true, hidden:false},
			        { header : '신고일자', name: 'DSPTH_DATE', width : 100, align: "right" , resizable: true, hidden:false}
			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_R005_List", "/report/retrieve_R005List", colArrayInfo, "number", null);
			 
		}
		
		this.retrieve_R005List = function() {
			
			var param = { "STDR_MT" : KpackageOBJ.object.getFormValue("R005-form", "SEARCH_STDR_MT")
						};
			
			//KpackageOBJ.tuiGrid.retrieve("oTui_R005_List", "/report/retrieve_R005List", param);
			
		}
		
		
		
	}
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		R005.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});
</script>
</body>
</html>