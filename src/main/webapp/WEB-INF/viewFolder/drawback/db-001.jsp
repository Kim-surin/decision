<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.sadfsaf{
	width: 100%;
    width: -moz-available;          /* WebKit-based browsers will ignore this. */
    width: -webkit-fill-available;  /* Mozilla-based browsers will ignore this. */
    width: fill-available;
    }	
</style>
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form:form id="DB001-search-form" novalidate="novalidate" class="s4-form" onsubmit="return false;" method="post">
			<input type="hidden" id="SEARCH_DATE"  name="SEARCH_DATE"/>
			<input type="hidden" id="SEARCH_RCEPT_FROM_DATE"  name="SEARCH_RCEPT_FROM_DATE"/>
			<input type="hidden" id="SEARCH_RCEPT_TO_DATE"  name="SEARCH_RCEPT_TO_DATE"/>
			<input type="hidden" id="SEARCH_DSPTH_FROM_DATE"  name="SEARCH_DSPTH_FROM_DATE"/>
			<input type="hidden" id="SEARCH_DSPTH_TO_DATE"  name="SEARCH_DSPTH_TO_DATE"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 100px;" />
								<col style="width: ;" />
								<col style="width: 100px;" />
								<col style="width: ;" />
							</colgroup>
							<tbody>
								<tr>
									<th>기준년월</th>
									<td>
										<input type="text" id="CAL_SEARCH_DATE"  name="CAL_SEARCH_DATE" class="inputText has-month-picker"/>
									</td>
									<th>선택사항</th>
									<td>
										<input type="radio" id ="DELETE_DRCTR" name="DELETE_DRCTR" value="" />일반판매
										<input type="radio" id ="DELETE_DRCTR" name="DELETE_DRCTR" value="" />사급판매
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:DB001.retrieve_tab1List();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			</div>
			<div>
			<ul id="myTab1" class="nav nav-tabs bordered">
				<li class="active">
					<a href="#s1" data-toggle="tab" aria-expanded="true">준비<!-- <span class="badge bg-color-blue txt-color-white">12</span> --></a>
				</li>
				<li class="">
					<a href="#s2" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>환급 임시산출</a>
				</li>
				<li class="">
					<a href="#s3" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>최종산출</a>
				</li>
				<li class="">
					<a href="#s4" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>전송 및 발급</a>
				</li>
				<li class="">
					<a href="#s5" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>잔량 관리</a>
				</li>
				<li class="pull-right">
					<a href="javascript:void(0);">
					<div class="sparkline txt-color-pinkDark text-align-right" data-sparkline-height="18px" data-sparkline-width="90px" data-sparkline-barwidth="7"><canvas width="52" height="18" style="display: inline-block; width: 52px; height: 18px; vertical-align: top;"></canvas></div> </a>
				</li>
			</ul>
			<div id="myTabContent1" class="tab-content padding-10 sadfsaf" style="background: #FFF;display: inline-block;">
				<div class="tab-pane fade active in" id="s1">
					<div class="col-sm-12">
						<div id="div_oTui_DB001_Grid_0101" name="div_oTui_DB001_Grid_0101" class="tuigrid-resizable">

							<div id="oTui_DB001_Grid_0101" data-minus-height="550"></div>
							<div id="oTui_DB001_Grid_0101_paging"></div>
						</div>
						
						<div id="div_oTui_DB001_Grid_0102" name="div_oTui_DB001_Grid_0102" class="tuigrid-resizable">

							<div id="oTui_DB001_Grid_0102" data-minus-height="750"></div>
							<div id="oTui_DB001_Grid_0102_paging"></div>
						</div>

					</div>
				</div>
				<div class="tab-pane fade" id="s2">
					<div class="col-sm-12">
						<div id="div_oTui_DB001_Grid_0201" name="div_oTui_DB001_Grid_0201" class="tuigrid-resizable">

							<div id="oTui_DB001_Grid_0201" data-minus-height="550"></div>
							<div id="oTui_DB001_Grid_0201_paging"></div>
						</div>
						
						<div id="div_oTui_DB001_Grid_0202" name="div_oTui_DB001_Grid_0202" class="tuigrid-resizable">

							<div id="oTui_DB001_Grid_0202" data-minus-height="750"></div>
							<div id="oTui_DB001_Grid_0202_paging"></div>
						</div>

					</div>
				</div>
				<div class="tab-pane fade" id="s3">
					<div class="col-sm-12">
						<div id="div_oTui_DB001_Grid_0301" name="div_oTui_DB001_Grid_0301" class="tuigrid-resizable">

							<div id="oTui_DB001_Grid_0301" data-minus-height="550"></div>
							<div id="oTui_DB001_Grid_0301_paging"></div>
						</div>
						<div id="div_oTui_DB001_Grid_0302" name="div_oTui_DB001_Grid_0302" class="tuigrid-resizable">

							<div id="oTui_DB001_Grid_0302" data-minus-height="750"></div>
							<div id="oTui_DB001_Grid_0302_paging"></div>
						</div>

					</div>
				</div>
				<div class="tab-pane fade" id="s4">
					<div class="col-sm-12">
						<div id="div_oTui_DB001_Grid_04" name="div_oTui_DB001_Grid_04" class="tuigrid-resizable">

							<div id="oTui_DB001_Grid_04" data-minus-height="300"></div>
							<div id="oTui_DB001_Grid_04_paging"></div>
						</div>

					</div>
				</div>
				<div class="tab-pane fade" id="s5">
					<div class="col-sm-12">
						<div id="div_oTui_DB001_Grid_05" name="div_oTui_DB001_Grid_05" class="tuigrid-resizable">

							<div id="oTui_DB001_Grid_05" data-minus-height="300"></div>
							<div id="oTui_DB001_Grid_05_paging"></div>
						</div>

					</div>
				</div>
			</div>
			</div>
		</form:form>
	</section>
</div> 
<script type="text/javascript">
	
	var DB001 = new function(){
		
		// Page Object Initialize
		this.initialize_viewObject = function() {
			KpackageOBJ.monthPicker.create("DB001-search-form", "CAL_SEARCH_DATE");
			//KpackageOBJ.monthPicker.setValue("DB001-search-form","CAL_SEARCH_DATE", "${sessionScope._sessionUser.WORK_DATE}".replace(/-/gi, "").substring(0,6));
			KpackageOBJ.monthPicker.setValue("DB001-search-form","CAL_SEARCH_DATE", "201802");
			KpackageOBJ.calendar.create("DB001-search-form", "CAL_SEARCH_RCEPT_FROM_DATE");
			KpackageOBJ.calendar.create("DB001-search-form", "CAL_SEARCH_RCEPT_TO_DATE");
			KpackageOBJ.calendar.create("DB001-search-form", "CAL_SEARCH_DSPTH_FROM_DATE");
			KpackageOBJ.calendar.create("DB001-search-form", "CAL_SEARCH_DSPTH_TO_DATE");
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			             ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						 ,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("DB001-search-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
		}
		
		this.initialize_TuiGrid = function() {
			
			// 준비 헤더
			var colArrayInfo0101 = [
				{"header" :'검증상태'   						,name:'STATUS'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'상태'   							,name:'STATUS1'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'진행상태'   						,name:'STATUS2'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판정유형'   						,name:'JDGMNT_TYPE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판정유형'   						,name:'JDGMNT_TYPE1'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'대금청구일'   						,name:'PRIC_RQEST_DATE'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'플랜트'   						,name:'DIVISION_CODE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'자재 번호'   						,name:'ITEM_CODE'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'자재 그룹'   						,name:'ITEM_GROUP'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'고객에 속한 자재'   					,name:'CSTMR_ITEM'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'로컬/수출'   						,name:'XPORT_AT'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'로컬/수출'   						,name:'XPORT_AT1'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판매처'   						,name:'CUSTOMER_CODE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판매처명'   						,name:'ATTRIBUTE01'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'대금청구문서'   					,name:'SLE_PRIC_DOC'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'대금청구품목'   					,name:'SLE_PRIC_DOC_PRDLST'  	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'유통 경로'   						,name:'DISTB_COURS'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'수출신고관리번호'   					,name:'EXPDECL_MANAGE_NO'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'수출거래구분'   					,name:'XPORT_SE'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'수출신고번호'   					,name:'XPORT_STTEMNT_NO'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'란(4)'   						,name:'LNE_NO'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'행(4)'   						,name:'ROW1'  					,width:100    ,align:'center'   ,hidden:false},
				{"header" :'월'   							,name:'STDR_MT'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'상품여부'   						,name:'GOODS_AT'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'사급구분'   						,name:'SA_SE'  					,width:100    ,align:'center'   ,hidden:false},
				{"header" :'HSCODE'   						,name:'HS_CODE'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'국가키'   						,name:'NATION_CODE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'대금청구수량'   					,name:'REAL_PRIC_RQEST_QY'  	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'기본단위'   						,name:'BASS_UNIT'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'통화금액'   						,name:'ACPLC_CRNCY_AMOUNT'  	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'신고가격-원화'   					,name:'STTEMNT_PC_KRW'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'통화 키'   						,name:'ACPLC_CRNCY'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'원화통화'   						,name:'KRW_CRNCY'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'인도조건'   						,name:'DELY_CND'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'손익 센터'   						,name:'PRFLOS_CNTER'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'BOM변경일'   						,name:'BOM_CHANGE_DATE'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'BOM범주'   						,name:'BOM_CTGRY'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'BOM'   							,name:'BOM_SE'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'대체 BOM'   						,name:'ALTRTV_BOM'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'메시지 유형'   						,name:'MSSAGE_TYPE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'메시지 텍스트'   					,name:'MSSAGE_TEXT'  			,width:100    ,align:'center'   ,hidden:false}
		    ];
			
			// 준비 아이템
			var colArrayInfo0102 = [
				{"header" :'5자리순번'         	,name:'SEQ'    				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'플랜트'         		,name:'DIVISION_CODE'    	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'레벨'   				,name:'BOM_LEVEL'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'원재료코드'         	,name:'BOM_PRDLST'    		,width:150    ,align:'center'   ,hidden:false},
				{"header" :'자재내역'         		,name:'ITEM_NM'    			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'구성부품수량'         	,name:'QY'    				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'기본단위'         		,name:'BASS_UNIT'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'사용량'         		,name:'USGQTY'    			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'공제비율 생산'         	,name:'DDC_RATE_PRDCTN'    	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'특별자재타입'         	,name:'SPECL_ITEM_TYPE'    	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'사급구분'         		,name:'SA_SE'    			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'대체품목:그룹'         	,name:'ALTRTV_PRDLST_GROUP' ,width:100    ,align:'center'   ,hidden:false}
		    ];
			
			//환급 임시산출 헤더
			var colArrayInfo0201 = [
				{"header" :'상태'   							,name:'STATUS'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'분석기간-월'   					,name:'STDR_MT'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판매처'   						,name:'CUSTOMER_CODE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판매처명'   						,name:'ATTRIBUTE01'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판매 문서/대금청구문서'   				,name:'SLE_PRIC_DOC'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판매 문서/대금청구문서 품목'   			,name:'SLE_PRIC_DOC_PRDLST'  	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'플랜트'   						,name:'DIVISION_CODE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'자재 번호'   						,name:'ITEM_CODE'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'고객사자재'   						,name:'CSTMR_ITEM'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'대금청구일'   						,name:'PRIC_RQEST_DATE'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판정유형'   						,name:'JDGMNT_TYPE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판정유형'   						,name:'JDGMNT_TYPE1'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'로컬/수출'   						,name:'XPORT_AT'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'로컬/수출'   						,name:'XPORT_AT1'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'사급구분'   						,name:'SA_SE'  					,width:100    ,align:'center'   ,hidden:false},
				{"header" :'자재 그룹'   						,name:'ITEM_GROUP'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급구분 코드'   					,name:'DRWBAK_SE_CODE'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'상품여부'   						,name:'GOODS_AT'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'기본단위'   						,name:'BASS_UNIT'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'대금청구수량'   					,name:'REAL_PRIC_RQEST_QY'  	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'통화금액'   						,name:'ACPLC_CRNCY_AMOUNT'  	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'신고가격-원화'   					,name:'STTEMNT_PC_KRW'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급금액'   						,name:'DRWBAK_AMOUNT'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급금액(공제비율)'   				,name:'DRWBAK_AMOUNT1'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급금액(절사금액)'   				,name:'DRWBAK_TRMMG_AMOUNT'  	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'HScode'   						,name:'HS_CODE'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'국가키'   						,name:'NATION_CODE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'통화 키'   						,name:'ACPLC_CRNCY'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'원화통화'   						,name:'KRW_CRNCY'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'수출신고 관리번호'   				,name:'EXPDECL_MANAGE_NO'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'수출거래구분'   					,name:'XPORT_SE'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'수출신고번호'   					,name:'XPORT_STTEMNT_NO'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'란(4)'   						,name:'LNE_NO'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'행(4)'   						,name:'ROW1'  					,width:100    ,align:'center'   ,hidden:false},
				{"header" :'신고(통보)일자'   					,name:'DSPTH_DATE'  			,width:100    ,align:'center'   ,hidden:false}
			];
			
			//환급 임시산출 아이템
			var colArrayInfo0202 = [
				{"header" :'HScode'  			,name:'HS_CODE'    			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'5자리순번'         	,name:'SEQ'    				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'레벨(다중레벨BOM전개)'   ,name:'BOM_LEVEL'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'플랜트'         		,name:'DIVISION_CODE'    	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'원재료코드'         	,name:'ITEM_CODE'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'자재내역'         		,name:'ITEM_NM'    			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'구성부품수량'         	,name:'QY'    				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'사용량'         		,name:'USGQTY'    			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급수량'         		,name:'USGQTY1'    			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'기본단위'         		,name:'BASS_UNIT'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'공제비율 생산'         	,name:'DDC_RATE_PRDCTN'    	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'관세금액(개당)'			,name:'ATTRIBUTE1'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'관세가격단위'			,name:'ATTRIBUTE2'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급금액'   			,name:'DRWBAK_AMOUNT'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급금액(공제비율)'   	,name:'DRWBAK_AMOUNT1'  	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급금액(절사금액)'   	,name:'DRWBAK_TRMMG_AMOUNT' ,width:100    ,align:'center'   ,hidden:false},
				{"header" :'통화 키'   			,name:'ACPLC_CRNCY'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'재료참조'				,name:'ATTRIBUTE3'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'재료참조(Text)'		,name:'ATTRIBUTE4'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'BOM범주'   			,name:'BOM_CTGRY'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'BOM'   				,name:'BOM_SE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급버퍼(%)'			,name:'ATTRIBUTE5'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'수입면장번호'			,name:'ATTRIBUTE6'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'란(4)'   			,name:'LNE_NO'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'행(4)'   			,name:'ROW1'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'수리일자'   			,name:'DSPTH_DATE'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'단축배제대상'         	,name:'TRGET_AT'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'조정고시'				,name:'ATTRIBUTE7'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'공급업체'				,name:'ATTRIBUTE8'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'공급업체명'			,name:'ATTRIBUTE9'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'대체 품목'				,name:'DRCTR_ALTRTV_PRDLST' ,width:100    ,align:'center'   ,hidden:false}
			];
			
			// 최종산출 헤더
			var colArrayInfo0301 = [
				{"header" :'상태'   							,name:'STATUS'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'분석기간-월'   					,name:'STDR_MT'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판매처'   						,name:'CUSTOMER_CODE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판매처명'   						,name:'ATTRIBUTE01'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판매 문서/대금청구문서'   				,name:'SLE_PRIC_DOC'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판매 문서/대금청구문서 품목'   			,name:'SLE_PRIC_DOC_PRDLST'  	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'플랜트'   						,name:'DIVISION_CODE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'자재 번호'   						,name:'ITEM_CODE'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'고객사자재'   						,name:'CSTMR_ITEM'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'대금청구일'   						,name:'PRIC_RQEST_DATE'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판정유형'   						,name:'JDGMNT_TYPE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판정유형'   						,name:'JDGMNT_TYPE1'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'로컬/수출'   						,name:'XPORT_AT'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'로컬/수출'   						,name:'XPORT_AT1'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'사급구분'   						,name:'SA_SE'  					,width:100    ,align:'center'   ,hidden:false},
				{"header" :'자재내역'         					,name:'ITEM_NM'    				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'상품여부'   						,name:'GOODS_AT'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'기본단위'   						,name:'BASS_UNIT'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'대금청구수량'   					,name:'REAL_PRIC_RQEST_QY'  	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'통화금액'   						,name:'ACPLC_CRNCY_AMOUNT'  	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'원화통화'   						,name:'KRW_CRNCY'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'신고가격-원화'   					,name:'STTEMNT_PC_KRW'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급금액'   						,name:'DRWBAK_AMOUNT'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급금액(공제비율)'   				,name:'DRWBAK_AMOUNT1'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급금액(절사금액)'   				,name:'DRWBAK_TRMMG_AMOUNT'  	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'HScode'   						,name:'HS_CODE'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'수출신고 관리번호'   				,name:'EXPDECL_MANAGE_NO'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'수출거래구분'   					,name:'XPORT_SE'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'수출신고번호'   					,name:'XPORT_STTEMNT_NO'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'란(4)'   						,name:'LNE_NO'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'행(4)'   						,name:'ROW1'  					,width:100    ,align:'center'   ,hidden:false},
				{"header" :'신고(통보)일자'   					,name:'DSPTH_DATE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'통화 키'   						,name:'ACPLC_CRNCY'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'발급여부'   						,name:'ATTRIBUTE02'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'국가키'   						,name:'NATION_CODE'  			,width:100    ,align:'center'   ,hidden:false}
			];
			
			// 최종산출 아이템
			var colArrayInfo0302 = [
				{"header" :'HScode'  			,name:'HS_CODE'    			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'5자리순번'         	,name:'SEQ'    				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'레벨(다중레벨BOM전개)'   ,name:'BOM_LEVEL'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'플랜트'         		,name:'DIVISION_CODE'    	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'원재료코드'         	,name:'ITEM_CODE'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'자재내역'         		,name:'ITEM_NM'    			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'구성부품수량'         	,name:'QY'    				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'사용량'         		,name:'USGQTY'    			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급수량'         		,name:'USGQTY1'    			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'기본단위'         		,name:'BASS_UNIT'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'공제비율 생산'         	,name:'DDC_RATE_PRDCTN'    	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'관세금액(개당)'			,name:'ATTRIBUTE1'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'관세가격단위'			,name:'ATTRIBUTE2'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급금액'   			,name:'DRWBAK_AMOUNT'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급금액(공제비율)'   	,name:'DRWBAK_AMOUNT1'  	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급금액(절사금액)'   	,name:'DRWBAK_TRMMG_AMOUNT' ,width:100    ,align:'center'   ,hidden:false},
				{"header" :'통화 키'   			,name:'ACPLC_CRNCY'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'재료참조'				,name:'ATTRIBUTE3'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'재료참조(Text)'		,name:'ATTRIBUTE4'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'BOM범주'   			,name:'BOM_CTGRY'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'BOM'   				,name:'BOM_SE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급버퍼(%)'			,name:'ATTRIBUTE5'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'수입면장번호'			,name:'ATTRIBUTE6'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'란(4)'   			,name:'LNE_NO'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'행(4)'   			,name:'ROW1'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'수리일자'   			,name:'DSPTH_DATE'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'단축배제대상'         	,name:'TRGET_AT'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'조정고시'				,name:'ATTRIBUTE7'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'공급업체'				,name:'ATTRIBUTE8'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'공급업체명'			,name:'ATTRIBUTE9'    		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'대체 품목'				,name:'DRCTR_ALTRTV_PRDLST' ,width:100    ,align:'center'   ,hidden:false}
			];
			
			// 전송 및 발급
			var colArrayInfo04 = [
				{"header" :'상태'   							,name:'STATUS'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'실행GUID-근거번호'   				,name:'GU_ID_NO'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'행번'         					,name:'SEQ'    				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'월'   							,name:'STDR_MT'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판매처'   						,name:'CUSTOMER_CODE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판매처명'   						,name:'ATTRIBUTE01'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'대금청구문서'   					,name:'SLE_PRIC_DOC'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'플랜트'   						,name:'DIVISION_CODE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'자재 번호'   						,name:'ITEM_CODE'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'고객사 자재'   						,name:'CSTMR_ITEM'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판정유형'   						,name:'JDGMNT_TYPE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'판정유형'   						,name:'JDGMNT_TYPE1'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'로컬/수출'   						,name:'XPORT_AT'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'로컬/수출'   						,name:'XPORT_AT1'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'사급구분'   						,name:'SA_SE'  					,width:100    ,align:'center'   ,hidden:false},
				{"header" :'자재내역'         					,name:'ITEM_NM'    			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'자재 그룹'   						,name:'ITEM_GROUP'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'수출거래구분'   					,name:'XPORT_SE'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급구분 코드'   					,name:'DRWBAK_SE_CODE'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'HScode'   						,name:'HS_CODE'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급금액'   						,name:'DRWBAK_AMOUNT'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급금액(공제비율)'   				,name:'DRWBAK_AMOUNT1'  	,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급금액(절사금액)'   				,name:'DRWBAK_TRMMG_AMOUNT' ,width:100    ,align:'center'   ,hidden:false},
				{"header" :'통화 키'   						,name:'ACPLC_CRNCY'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'환급번호'   						,name:'ATTRIBUTE02'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'등록번호'   						,name:'ATTRIBUTE03'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'발급일자'   						,name:'PRIC_RQEST_DATE'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'발급여부'   						,name:'ATTRIBUTE04'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'발급여부내역'   					,name:'ATTRIBUTE05'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'상품여부'   						,name:'GOODS_AT'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'수출신고번호'   					,name:'XPORT_STTEMNT_NO'  		,width:100    ,align:'center'   ,hidden:false},
				{"header" :'란(3)'   						,name:'LNE_NO'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'규격번호'   						,name:'ATTRIBUTE06'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'신고(통보)일자'   					,name:'DSPTH_DATE'  			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'국가키'   						,name:'NATION_CODE'  			,width:100    ,align:'center'   ,hidden:false}				
				
			];
			
			// 잔량관리
			var colArrayInfo05 = [
				{"header" :'원재료코드'   						,name:'ITEM_CODE'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'수입면장번호'						,name:'ATTRIBUTE1'    			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'란(4)'   						,name:'LNE_NO'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'행(4)'   						,name:'ROW1'  					,width:100    ,align:'center'   ,hidden:false},
				{"header" :'자재내역'         					,name:'ITEM_NM'    				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'HScode'   						,name:'HS_CODE'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'수량'   							,name:'STDR_QY'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'관세'								,name:'ATTRIBUTE2'    			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'출고수량'							,name:'ATTRIBUTE3'    			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'출고금액'							,name:'ATTRIBUTE4'    			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'잔량관리'							,name:'ATTRIBUTE5'    			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'잔여금액'							,name:'ATTRIBUTE6'    			,width:100    ,align:'center'   ,hidden:false},
				{"header" :'기본단위'   						,name:'BASS_UNIT'  				,width:100    ,align:'center'   ,hidden:false},
				{"header" :'통화'   							,name:'ACPLC_CRNCY'  			,width:100    ,align:'center'   ,hidden:false}
				
			];
			
			KpackageOBJ.tuiGrid.create("oTui_DB001_Grid_0101","/sys/", colArrayInfo0101, null, null, this.dbl_Handler);
			var grid1_tools = [  {icon:"update", title:"Ready" 	,text:"환급준비"			,func:"DB001.openPopup_Drwbak_Lmtt"}
								,{icon:"update", title:"Calc" 	,text:"금액산출(시뮬레이션)"	,func:"DB001.openPopup_Drwbak_Lmtt"}
								];
	    	KpackageOBJ.tuiGrid.setButton("oTui_DB001_Grid_0101", grid1_tools); // Toobar 생성	    	
			KpackageOBJ.tuiGrid.create("oTui_DB001_Grid_0102","/sys/", colArrayInfo0102, null, null, this.dbl_Handler);
	    	
			KpackageOBJ.tuiGrid.create("oTui_DB001_Grid_0201","/sys/", colArrayInfo0201, null, null, this.dbl_Handler);
			var grid2_tools = [  {icon:"update", title:"Calc" 	,text:"금액산출확정"		,func:"DB001.openPopup_Drwbak_Lmtt"}
								];
			KpackageOBJ.tuiGrid.setButton("oTui_DB001_Grid_0201", grid2_tools); // Toobar 생성	 
			KpackageOBJ.tuiGrid.create("oTui_DB001_Grid_0202","/sys/", colArrayInfo0202, null, null, this.dbl_Handler);
			
			KpackageOBJ.tuiGrid.create("oTui_DB001_Grid_0301","/sys/", colArrayInfo0301, null, null, this.dbl_Handler);
			var grid3_tools = [  {icon:"update", title:"Calc" 	,text:"환급대상 집계"		,func:"DB001.openPopup_Drwbak_Lmtt"}
								];
			KpackageOBJ.tuiGrid.setButton("oTui_DB001_Grid_0301", grid3_tools); // Toobar 생성	 
			KpackageOBJ.tuiGrid.create("oTui_DB001_Grid_0302","/sys/", colArrayInfo0302, null, null, this.dbl_Handler);
			
 			KpackageOBJ.tuiGrid.create("oTui_DB001_Grid_04","/sys/", colArrayInfo04, null, null, this.dbl_Handler);
 			var grid4_tools = [  {icon:"update", title:"Ready" 	,text:"환급문서 발급"		,func:"DB001.openPopup_Drwbak_Lmtt"}
								,{icon:"update", title:"Calc" 	,text:"조견표 관리"			,func:"DB001.openPopup_Drwbak_Lmtt"}
								];
			KpackageOBJ.tuiGrid.setButton("oTui_DB001_Grid_04", grid4_tools); // Toobar 생성
 			
 			KpackageOBJ.tuiGrid.create("oTui_DB001_Grid_05","/sys/", colArrayInfo05, null, null, this.dbl_Handler);
			
		}
		
		this.retrieve_tab1List = function() {
			
			var param = { "CAL_SEARCH_DATE" : KpackageOBJ.object.getFormValue("DB001-search-form", "CAL_SEARCH_DATE")
						 ,"DELETE_DRCTR" : KpackageOBJ.object.getFormValue("DB001-search-form","DELETE_DRCTR")
						};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_DB001_Grid_0101", "/drawback/selectTab1List", param);
			
		}
		
		/* Dbl Click Handler */
		this.dbl_Handler = function(p_GridId, p_RowKey, p_ColName){
			var rowData = KpackageOBJ.tuiGrid.getSelectedRowlValue(p_GridId, p_RowKey);
			var param = {"ITEM_CODE" : rowData.ITEM_CODE
						,"PRIC_RQEST_DATE" : rowData.PRIC_RQEST_DATE
						}
			
			KpackageOBJ.tuiGrid.retrieve("oTui_DB001_Grid_0102", "/drawback/selectTab1BomList", param);
			
		}
	}
	
	$(document).ready(function() {
		pageSetUp();				// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB001.initialize_viewObject(); 		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		DB001.initialize_TuiGrid();		 
		
		
	});
	
</script>
</body>
</html>