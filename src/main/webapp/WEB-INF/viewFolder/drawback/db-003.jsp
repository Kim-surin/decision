<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
		<form:form id="DB003-search-form" novalidate="novalidate" class="s4-form" onsubmit="return false;" method="post">
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
								<col style="width: 150px;" />
								<col style="width: ;" />
							</colgroup>
							<tbody>
								<tr>
									<th>기준년월</th>
									<td>
										<input type="text" id="SEARCH_STDR_MT"  name="SEARCH_STDR_MT" class="inputText has-month-picker"/>
									</td>
									<th>등록(접수)번호-관세청</th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="DB003.retrieve_gridData">
									</td>
								</tr>
								<tr>
									<th>접수일자</th>
									<td>
										<input type="text" id="CAL_SEARCH_RCEPT_FROM_DATE"  name="CAL_SEARCH_RCEPT_FROM_DATE" style="width:120px" class="inputText" searchfnc="DB003.retrieve_gridData"/> ~
										<input type="text" id="CAL_SEARCH_RCEPT_TO_DATE"  name="CAL_SEARCH_RCEPT_TO_DATE" style="width:120px" class="inputText" searchfnc="DB003.retrieve_gridData"/>
									</td>
									<th>통보일자</th>
									<td>
										<input type="text" id="CAL_SEARCH_DSPTH_FROM_DATE"  name="CAL_SEARCH_DSPTH_FROM_DATE" style="width:120px" class="inputText" searchfnc="DB003.retrieve_gridData"/> ~
										<input type="text" id="CAL_SEARCH_DSPTH_TO_DATE"  name="CAL_SEARCH_DSPTH_TO_DATE" style="width:120px" class="inputText" searchfnc="DB003.retrieve_gridData"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-2" type="button" onclick="javascript:DB003.retrieve_gridData();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			</div>
			<div>
			<ul id="myTab1" class="nav nav-tabs bordered">
				<li class="active">
					<a href="#s1" data-toggle="tab" aria-expanded="true">환급/기납증발급<!-- <span class="badge bg-color-blue txt-color-white">12</span> --></a>
				</li>
				<li class="">
					<a href="#s2" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>환급</a>
				</li>
				<li class="">
					<a href="#s3" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>배제문서</a>
				</li>
				<li class="">
					<a href="#s4" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>보완통보서</a>
				</li>
				<li class="">
					<a href="#s5" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>접수통보</a>
				</li>
				<li class="">
					<a href="#s6" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>오류통보</a>
				</li>
				<li class="">
					<a href="#s7" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>완료통보</a>
				</li>
				<li class="">
					<a href="#s8" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>결정통보</a>
				</li>
				<li class="">
					<a href="#s9" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>환급자료제출요구</a>
				</li>
				<li class="">
					<a href="#s10" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>서류제출통보</a>
				</li>
				<li class="">
					<a href="#s11" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>제출자료</a>
				</li>
				<li class="pull-right">
					<a href="javascript:void(0);">
					<div class="sparkline txt-color-pinkDark text-align-right" data-sparkline-height="18px" data-sparkline-width="90px" data-sparkline-barwidth="7"><canvas width="52" height="18" style="display: inline-block; width: 52px; height: 18px; vertical-align: top;"></canvas></div> </a>
				</li>
			</ul>
			<div id="myTabContent1" class="tab-content padding-10 sadfsaf" style="background: #FFF;display: inline-block;">
				<div class="tab-pane fade active in" id="s1">
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_01" name="div_oTui_ToastGrid_01" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_01" data-minus-height="360"></div>
							<div id="oTui_ToastGrid_01_paging"></div>
						</div>

					</div>
				</div>
				<div class="tab-pane fade" id="s2">
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_0201" name="div_oTui_ToastGrid_0201" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_0201" data-minus-height="830"></div>
							<div id="oTui_ToastGrid_0201_paging"></div>
						</div>
						
						<div id="div_oTui_ToastGrid_0202" name="div_oTui_ToastGrid_0202" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_0202" data-minus-height="830"></div>
							<div id="oTui_ToastGrid_0202_paging"></div>
						</div>
						
						<div id="div_oTui_ToastGrid_0203" name="div_oTui_ToastGrid_0203" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_0203" data-minus-height="830"></div>
							<div id="oTui_ToastGrid_0203_paging"></div>
						</div>

					</div>
				</div>
				<div class="tab-pane fade" id="s3">
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_0301" name="div_oTui_ToastGrid_0301" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_0301" data-minus-height="710"></div>
							<div id="oTui_ToastGrid_0301_paging"></div>
						</div>
						<div id="div_oTui_ToastGrid_0302" name="div_oTui_ToastGrid_0302" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_0302" data-minus-height="710"></div>
							<div id="oTui_ToastGrid_0302_paging"></div>
						</div>

					</div>
				</div>
				<div class="tab-pane fade" id="s4">
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_04" name="div_oTui_ToastGrid_04" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_04" data-minus-height=360></div>
							<div id="oTui_ToastGrid_04_paging"></div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="s5">
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_05" name="div_oTui_ToastGrid_05" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_05" data-minus-height=360></div>
							<div id="oTui_ToastGrid_05_paging"></div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="s6">
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_0601" name="div_oTui_ToastGrid_0601" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_0601" data-minus-height="720"></div>
							<div id="oTui_ToastGrid_0601_paging"></div>
						</div>
						<div id="div_oTui_ToastGrid_0602" name="div_oTui_ToastGrid_0602" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_0602" data-minus-height="720"></div>
							<div id="oTui_ToastGrid_0602_paging"></div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="s7">
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_07" name="div_oTui_ToastGrid_07" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_07" data-minus-height="360"></div>
							<div id="oTui_ToastGrid_07_paging"></div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="s8">
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_08" name="div_oTui_ToastGrid_08" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_08" data-minus-height="360"></div>
							<div id="oTui_ToastGrid_08_paging"></div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="s9">
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_09" name="div_oTui_ToastGrid_09" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_09" data-minus-height="360"></div>
							<div id="oTui_ToastGrid_09_paging"></div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="s10">
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_10" name="div_oTui_ToastGrid_10" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_10" data-minus-height="360"></div>
							<div id="oTui_ToastGrid_10_paging"></div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="s11">
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_1101" name="div_oTui_ToastGrid_1101" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_1101" data-minus-height="830"></div>
							<div id="oTui_ToastGrid_1101_paging"></div>
						</div>
						<div id="div_oTui_ToastGrid_1102" name="div_oTui_ToastGrid_1102" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_1102" data-minus-height="830"></div>
							<div id="oTui_ToastGrid_1102_paging"></div>
						</div>
						<div id="div_oTui_ToastGrid_1103" name="div_oTui_ToastGrid_1103" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_1103" data-minus-height="830"></div>
							<div id="oTui_ToastGrid_1103_paging"></div>
						</div>
					</div>
				</div>
			</div>
		</form:form>
	</section>
</div> 
<script type="text/javascript">

	var currentTab = "s1";
	
	var DB003 = new function(){
		
		// Page Object Initialize
		this.initialize_viewObject = function() {
			KpackageOBJ.monthPicker.create("DB003-search-form", "SEARCH_STDR_MT");
			KpackageOBJ.monthPicker.setValue("DB003-search-form","SEARCH_STDR_MT", "${sessionScope._sessionUser.WORK_DATE}".replace(/-/gi, "").substring(0,6));
			KpackageOBJ.calendar.create("DB003-search-form", "CAL_SEARCH_RCEPT_FROM_DATE");
			KpackageOBJ.calendar.create("DB003-search-form", "CAL_SEARCH_RCEPT_TO_DATE");
			KpackageOBJ.calendar.create("DB003-search-form", "CAL_SEARCH_DSPTH_FROM_DATE");
			KpackageOBJ.calendar.create("DB003-search-form", "CAL_SEARCH_DSPTH_TO_DATE");

			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			             ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						 ,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("DB003-search-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
		};
		
		this.initialize_TuiGrid = function() {
			//환급/기납증 발급
			var colArrayInfo01 = [
				{"header" : "상태"               ,"name" : "attribute01"         ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "환급제출번호"       ,"name" : "PRESENTN_NO"         ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "행번"               ,"name" : "SEQ"                 ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "월"                 ,"name" : "STDR_MT"             ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "판매처"             ,"name" : "CUSTOMER_CODE"       ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "판매처명"           ,"name" : "CUSTOMER_NM"         ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "판매문서"           ,"name" : "SLE_PRIC_DOC"        ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "플랜트"             ,"name" : "DIVISION_CODE"       ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "자재"               ,"name" : "ITEM_CODE"           ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "고객자재번호"       ,"name" : "CSTMR_ITEM"          ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "판정유형"           ,"name" : "JDGMNT_TYPE"         ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "판정유형명"         ,"name" : "JDGMNT_TYPE_NM"      ,"width" : 100 ,"align" : "center" ,"hidden" : false},//공통코드
				{"header" : "로컬/수출"          ,"name" : "XPORT_AT"            ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "로컬/수출명"        ,"name" : "XPORT_AT_NM"         ,"width" : 100 ,"align" : "center" ,"hidden" : false},//공통코드
				{"header" : "사급구분"           ,"name" : "SA_SE"               ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "자재내역"           ,"name" : "ITEM_NM"             ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "자재그룹"           ,"name" : "ITEM_GROUP"          ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "수출거래구분"       ,"name" : "XPORT_SE"            ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "환급구분"           ,"name" : "DRWBAK_SE_CODE"      ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "HS CODE"            ,"name" : "HS_CODE"             ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "환급금액"           ,"name" : "DRWBAK_AMOUNT"       ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "환급금액(공제)"     ,"name" : "DRWBAK_DDC_AMOUNT"   ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "환급금액(절사금액)" ,"name" : "DRWBAK_TRMMG_AMOUNT" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "통화"               ,"name" : "ACPLC_CRNCY"         ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "환급번호(6)"        ,"name" : "DRWBAK_SEQ"          ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "등록번호"           ,"name" : "REGIST_RCEPT_NO"     ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "발급일자"           ,"name" : "DCSN_DATE"           ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "발급여부"           ,"name" : "EXECUT_AT"           ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "발급여부내역"       ,"name" : "EXECUT_AT_NM"        ,"width" : 100 ,"align" : "center" ,"hidden" : false},//공통코드
				{"header" : "상품여부"           ,"name" : "GOODS_AT"            ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "수출신고번호"       ,"name" : "XPORT_STTEMNT_NO"    ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "란(3)"              ,"name" : "LNE_NO"              ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "규격번호(환급)"     ,"name" : "ROW1"                ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "신고수리일자"       ,"name" : "DSPTH_DATE"          ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "Ctr"                ,"name" : "NATION_CODE"         ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "D/I"                ,"name" : "DELETE_DRCTR"        ,"width" : 100 ,"align" : "center" ,"hidden" : false}
		    ];
			//환급
			var colArrayInfo0201 = [
				{"header" : "등록번호"            , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "환급구분"            , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "환급구분내역"        , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수출거래구분"        , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수출거래구분내역"    , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "세관+년도"           , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "근거서류번호"        , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "환급계좌번호"        , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "은행코드"            , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "공급업체"            , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "공급업체사업자"      , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "공급업체주소"        , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "공급업체대표자"      , "name" : "attribute13" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신청인상호/대표자"   , "name" : "attribute14" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "회사부호(관세청)"    , "name" : "attribute15" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "제조자코드"          , "name" : "attribute16" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "제조자사업자"        , "name" : "attribute17" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "제조자주소"          , "name" : "attribute18" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수익자(공급자)상호"  , "name" : "attribute19" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "대표자"              , "name" : "attribute20" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "회사부호(관세청)"    , "name" : "attribute21" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "관세사"              , "name" : "attribute22" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "HS CODE"             , "name" : "attribute23" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "연산품부호"          , "name" : "attribute24" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자재"                , "name" : "attribute25" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자재내역"            , "name" : "attribute26" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "관세청조사란1"       , "name" : "attribute27" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "관세청조사란2"       , "name" : "attribute28" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "FOB금액"             , "name" : "attribute29" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "FOB통화키"           , "name" : "attribute30" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "BUn"                 , "name" : "attribute31" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "오더수량"            , "name" : "attribute32" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "을지건수"            , "name" : "attribute33" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "병지건수"            , "name" : "attribute34" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "관세"                , "name" : "attribute35" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "개별소비세"          , "name" : "attribute36" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "교통세"              , "name" : "attribute37" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "주세"                , "name" : "attribute38" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "교육세"              , "name" : "attribute39" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "농특세"              , "name" : "attribute40" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "총세액"              , "name" : "attribute41" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "등록번호"            , "name" : "attribute42" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "접수일자"            , "name" : "attribute43" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통보일자"            , "name" : "attribute44" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "결정일자"            , "name" : "attribute45" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "월"                  , "name" : "attribute46" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정일자"            , "name" : "attribute47" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "관세환급확정유무"    , "name" : "attribute48" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "환급보류여부"        , "name" : "attribute49" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "사후정산유무"        , "name" : "attribute50" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "정산일자"            , "name" : "attribute51" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "사후정산작업번호"    , "name" : "attribute52" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "추가환급작업번호"    , "name" : "attribute53" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "추가환급확정일자"    , "name" : "attribute54" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "작업번호"            , "name" : "attribute55" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "단축배제유무"        , "name" : "attribute56" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "세액계산시 고단가"   , "name" : "attribute57" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "공급업체전화번호"    , "name" : "attribute58" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "목적국코드"          , "name" : "attribute59" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "세관"                , "name" : "attribute60" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "세관직원부호"        , "name" : "attribute61" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "세관담당자명"        , "name" : "attribute62" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "다세율 조정고시 대"  , "name" : "attribute63" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통화"                , "name" : "attribute64" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정일자"            , "name" : "attribute65" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정여부(Y/N)"       , "name" : "attribute66" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			
			var colArrayInfo0202 = [
				{"header" : "등록(접수)번호-관세청" , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "행번"                  , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "작업번호"              , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수출신고번호"          , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "란번호"                , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신고수리일자"          , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "오더수량"              , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "단위"                  , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "FOB금액"               , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "오류구분(Y/N)"         , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "오류수정구분"          , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "재전송적용유무"        , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자재"                  , "name" : "attribute13" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "행번호"                , "name" : "attribute14" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "대상물품구분"          , "name" : "attribute15" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통화"                  , "name" : "attribute16" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			
			var colArrayInfo0203 = [
				{"header" : "등록(접수)번호-관세청"   , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "행번"                    , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "기납증/분증구분"         , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "재료참조"                , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자재"                    , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "HS CODE(원재료)"         , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수리일자"                , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수입면장번호"            , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "란번호"                  , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "부산물구분"              , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "부산물비율"              , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "단위"                    , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "구성부품수량(TOTAL)"     , "name" : "attribute13" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "단위"                    , "name" : "attribute14" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "잔여수량(사용가능수량)"  , "name" : "attribute15" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "정지건수"                , "name" : "attribute16" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "오더단가"                , "name" : "attribute17" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "금액(원화)"              , "name" : "attribute18" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "관세"                    , "name" : "attribute19" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "개별소비세"              , "name" : "attribute20" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "교통세"                  , "name" : "attribute21" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "주세"                    , "name" : "attribute22" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "교육세"                  , "name" : "attribute23" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "농특세"                  , "name" : "attribute24" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "총세액"                  , "name" : "attribute25" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "내국세구분"              , "name" : "attribute26" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "내국세"                  , "name" : "attribute27" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "작업번호"                , "name" : "attribute28" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "오류구분(Y/N)"           , "name" : "attribute29" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "오류수정구분"            , "name" : "attribute30" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "재전송적용유무"          , "name" : "attribute31" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자재"                    , "name" : "attribute32" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "원산지"                  , "name" : "attribute33" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "일자"                    , "name" : "attribute34" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "브랜드명"                , "name" : "attribute35" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "규격번호"                , "name" : "attribute36" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "다세율 조정고시 대"      , "name" : "attribute37" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통화"                    , "name" : "attribute38" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			//배제문서
			var colArrayInfo0301 = [
				{"header" : "등록번호"                   , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "전송구분"                   , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "환급신청구분"               , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "등록번호"                   , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신청인상호/대표자"          , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "대표자"                     , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "접수일자"                   , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "ID No."                     , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "성명"                       , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "ID No."                     , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "성명"                       , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "식별자 No."                 , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "일자"                       , "name" : "attribute13" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "시간"                       , "name" : "attribute14" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "전송상태"                   , "name" : "attribute15" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "일자"                       , "name" : "attribute16" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "시간"                       , "name" : "attribute17" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수신결과"                   , "name" : "attribute18" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "상태"                       , "name" : "attribute19" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "증빙자료명1"                , "name" : "attribute20" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "접수번호"                   , "name" : "attribute21" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "접수일자"                   , "name" : "attribute22" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "동질원재료전체사용여부"     , "name" : "attribute23" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "생산공정투입지연여부"       , "name" : "attribute24" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "생산공정3월이상소요여부"    , "name" : "attribute25" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "기타사유수입원재료사용여부" , "name" : "attribute26" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			
			var colArrayInfo0302 = [
				{"header" : "등록(접수)번호-관세청" , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "행번"                  , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수입면장번호"          , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "란번호"                , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수리일자"              , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자재"                  , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자재내역"              , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "단위"                  , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수량"                  , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "상태"                  , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "행번호"                , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			//보완통보서
			var colArrayInfo04 = [
				{"header" : "등록(접수)번호-관세청" , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신청인상호/대표자"     , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "대표자"                , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "담당자이름"            , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신고세관과"            , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "전화번호1"             , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "세관"                  , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신고세관과"            , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통보일자"              , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "제출기한"              , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "보완요구내역"          , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "비고"                  , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "등록(접수)번호-관세청" , "name" : "attribute13" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "문서번호"              , "name" : "attribute14" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "전자문서신청서코드"    , "name" : "attribute15" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정여부(Y/N)"         , "name" : "attribute16" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			//접수통보
			var colArrayInfo05 = [
				{"header" : "세관제출번호"             , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "접수번호"                 , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "접수구분"                 , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "접수문서구분"             , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "세관"                     , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신고세관과"               , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "담당자이름"               , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "담당자코드"               , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통보일자"                 , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통보시간"                 , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "접수일자"                 , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "접수시간"                 , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "접수결과1(서류제출사유)"  , "name" : "attribute13" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "접수결과2"                , "name" : "attribute14" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정여부(Y/N)"            , "name" : "attribute15" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "일자"                     , "name" : "attribute16" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "시간"                     , "name" : "attribute17" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수신결과"                 , "name" : "attribute18" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "상태"                     , "name" : "attribute19" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통보일자"                 , "name" : "attribute20" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "접수일자"                 , "name" : "attribute21" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "PL구분"                   , "name" : "attribute22" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			//오류통보
			var colArrayInfo0601 = [
				{"header" : "환급제출번호"               , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "오류문서타입(뒤3자리등록)"  , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신고수리일자"               , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신고(통보)시간"             , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "세관"                       , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신고세관과"                 , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "일자"                       , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "시간"                       , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "오류처리구분"               , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "EDI처리상태"                , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정여부(Y/N)"              , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정일자"                   , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정시간"                   , "name" : "attribute13" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "ID No."                     , "name" : "attribute14" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "식별자 No."                 , "name" : "attribute15" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "성명"                       , "name" : "attribute16" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "ID No."                     , "name" : "attribute17" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "식별자 No."                 , "name" : "attribute18" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "성명"                       , "name" : "attribute19" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "전자문서코드"               , "name" : "attribute20" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "전자문서구분"               , "name" : "attribute21" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			
			var colArrayInfo0602 = [
				{"header" : "신청번호"                   , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "오류문서타입(뒤3자리등록)"  , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "차수"                       , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "행번"                       , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "오류내역"                   , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "오류발생위치"               , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "오류발생란번호(제출차수)"   , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "오류문서KEY#1"              , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "오류문서KEY#2"              , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "오류문서KEY#3"              , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정여부(Y/N)"              , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "EAI STATUS"                 , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			//완료통보
			var colArrayInfo07 = [
				{"header" : "등록(접수)번호-관세청"  , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "오류문서타입"           , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "세관"                   , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "담당자이름"             , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통보일자"               , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통보시간"               , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "심사일자"               , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "결과내역1"              , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "결과내역2"              , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "접수번호"               , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정여부(Y/N)"          , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정Y미확정N"           , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "일자"                   , "name" : "attribute13" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "시간"                   , "name" : "attribute14" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수신결과"               , "name" : "attribute15" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "상태"                   , "name" : "attribute16" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "결과코드"               , "name" : "attribute17" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통보일자"               , "name" : "attribute18" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			//결정통보
			var colArrayInfo08 = [
				{"header" : "접수번호"           , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "세관제출번호"       , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신청인상호/대표자"  , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "대표자"             , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "은행코드"           , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "환급계좌번호"       , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "금액(원화)"         , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통보일자"           , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "결정일자"           , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정여부(Y/N)"      , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "정산여부(Y/N)"      , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "일자"               , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "시간"               , "name" : "attribute13" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수신결과"           , "name" : "attribute14" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "상태"               , "name" : "attribute15" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통보일자"           , "name" : "attribute16" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "지급지시번호"       , "name" : "attribute17" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "지급은행명"         , "name" : "attribute18" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통화"               , "name" : "attribute19" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			//환급자료제출요구
			var colArrayInfo09 = [
				{"header" : "등록(접수)번호-관세청"  , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "행번"                   , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통보일자"               , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "제출기한"               , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신청일자"               , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "등록(접수)번호-관세청"  , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신청구분"               , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수출신고번호"           , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "란번호"                 , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "행번호"                 , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자재"                   , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "비고"                   , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "비고"                   , "name" : "attribute13" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "세관과장명"             , "name" : "attribute14" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "담당자이름"             , "name" : "attribute15" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "전화번호1"              , "name" : "attribute16" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "세관"                   , "name" : "attribute17" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신고세관과"             , "name" : "attribute18" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신청자상호/대표자"      , "name" : "attribute19" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "대표자"                 , "name" : "attribute20" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정Y미확정N"           , "name" : "attribute21" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정여부(Y/N)"          , "name" : "attribute22" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "일자"                   , "name" : "attribute23" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "시간"                   , "name" : "attribute24" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수신결과"               , "name" : "attribute25" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "상태"                   , "name" : "attribute26" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			//서류제출통보
			var colArrayInfo10 = [
				{"header" : "등록(접수)번호-관세청"  , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "세관"                   , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신고세관과"             , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "담당자이름"             , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통보일자"               , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통보시간"               , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "서류변경처리일자"       , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "문서구분"               , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "서류제출사유코드"       , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "서류제출사유내용"       , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "등록(접수)번호-관세청"  , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정여부(Y/N)"          , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "일자"                   , "name" : "attribute13" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "시간"                   , "name" : "attribute14" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수신결과"               , "name" : "attribute15" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "상태"                   , "name" : "attribute16" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			//제출자료
			var colArrayInfo1101 = [
				{"header" : "환급제출번호(내부채번)"  , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자료요청번호"            , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자료요청순번"            , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자료제출문서구분"        , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "문서구분"                , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신고수리일자"            , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "세관"                    , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "등록(접수)번호-관세청"   , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "회사부호(관세청)"        , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "관세사"                  , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "전자문서코드"            , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "전자문서명"              , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "ID No."                  , "name" : "attribute13" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "식별자 No."              , "name" : "attribute14" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "성명"                    , "name" : "attribute15" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "ID No."                  , "name" : "attribute16" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "식별자 No."              , "name" : "attribute17" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "성명"                    , "name" : "attribute18" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "일자"                    , "name" : "attribute19" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "시간"                    , "name" : "attribute20" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "전송상태"                , "name" : "attribute21" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "일자"                    , "name" : "attribute22" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "시간"                    , "name" : "attribute23" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수신결과"                , "name" : "attribute24" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "상태"                    , "name" : "attribute25" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "등록(접수)번호-관세청"   , "name" : "attribute26" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "접수일자"                , "name" : "attribute27" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통화"                    , "name" : "attribute28" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정여부(Y/N)"           , "name" : "attribute29" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정일자"                , "name" : "attribute30" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			
			var colArrayInfo1102 = [
				{"header" : "환급제출번호(내부채번)"  , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자료요청번호"            , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자료요청순번"            , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자료제출문서구분"        , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "행번"                    , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수출신고번호"            , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "란번호"                  , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "행번호"                  , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자재"                    , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자재내역"                , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "규격"                    , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "단위"                    , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수량"                    , "name" : "attribute13" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "FOB금액"                 , "name" : "attribute14" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "HS Code"                 , "name" : "attribute15" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : " 자재"                   , "name" : "attribute16" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "BOM종류"                 , "name" : "attribute17" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "효력시작일"              , "name" : "attribute18" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "효력종료일"              , "name" : "attribute19" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "상태"                    , "name" : "attribute20" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "작업번호"                , "name" : "attribute21" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통화"                    , "name" : "attribute22" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			
			var colArrayInfo1103 = [
				{"header" : "환급제출번호(내부채번)"  , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자료요청번호"            , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자료요청순번"            , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자료제출문서구분"        , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "행번"                    , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "행번"                    , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신고수리일자"            , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "재료참조"                , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수입면장번호"            , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "란번호"                  , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "행번호"                  , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자재"                    , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자재내역"                , "name" : "attribute13" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "단위"                    , "name" : "attribute14" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "구성부품수량(TOTAL)"     , "name" : "attribute15" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "환급금액"                , "name" : "attribute16" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "구성부품수량(TOTAL)"     , "name" : "attribute17" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자재"                    , "name" : "attribute18" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "부산물공제구분"          , "name" : "attribute19" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "부산물공제비율"          , "name" : "attribute20" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "사용가능부산물비율"      , "name" : "attribute21" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "사용불가능부산물비율"    , "name" : "attribute22" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "비고"                    , "name" : "attribute23" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "상태"                    , "name" : "attribute24" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통화"                    , "name" : "attribute25" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_01","/drawback/", colArrayInfo01, null, null, null);		//환급/기납증발급
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_0201","/drawback/", colArrayInfo0201, null, null, this.dbl_Handler);	//환급
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_0202","/drawback/", colArrayInfo0202, null, null, null);
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_0203","/drawback/", colArrayInfo0203, null, null, null);
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_0301","/drawback/", colArrayInfo0301, null, null, this.dbl_Handler);	//배제문서
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_0302","/drawback/", colArrayInfo0302, null, null, null);
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_04","/drawback/", colArrayInfo04, null, null, null);		//보완통보서
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_05","/drawback/", colArrayInfo05, null, null, null);		//접수통보
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_0601","/drawback/", colArrayInfo0601, null, null, this.dbl_Handler);	//오류통보
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_0602","/drawback/", colArrayInfo0602, null, null, null);
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_07","/drawback/", colArrayInfo07, null, null, null);		//완료통보
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_08","/drawback/", colArrayInfo08, null, null, null);		//결정통보
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_09","/drawback/", colArrayInfo09, null, null, null);		//환급자료제출요구
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_10","/drawback/", colArrayInfo10, null, null, null);		//서류제출통보
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_1101","/drawback/", colArrayInfo1101, null, null, this.dbl_Handler);	//제출자료
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_1102","/drawback/", colArrayInfo1102, null, null, null);
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_1103","/drawback/", colArrayInfo1103, null, null, null);

			var tools01 = [{icon:"insert", title:"관세청전송" ,text:"관세청전송"	,func:"DB003.openPopup_Drwbak_Lmtt"}];
	    	KpackageOBJ.tuiGrid.setButton("oTui_ToastGrid_01", tools01); // Toobar 생성
			var tools06 = [{icon:"insert", title:"수정" ,text:"수정"	,func:"DB003.openPopup_Drwbak_Lmtt"}];
	    	KpackageOBJ.tuiGrid.setButton("oTui_ToastGrid_0601", tools06); // Toobar 생성
			var tools09 = [{icon:"insert", title:"조견표작성" ,text:"조견표작성"	,func:"DB003.openPopup_Drwbak_Lmtt"}
							,{icon:"insert", title:"소요량작성" ,text:"소요량작성"	,func:"DB003.openPopup_Drwbak_Lmtt"}
							,{icon:"insert", title:"BOM작성" ,text:"BOM작성"	,func:"DB003.openPopup_Drwbak_Lmtt"}];
	    	KpackageOBJ.tuiGrid.setButton("oTui_ToastGrid_09", tools09); // Toobar 생성
			
		};
		
		this.retrieve_gridData = function() {
			var param = {"SEARCH_STDR_MT":KpackageOBJ.object.getFormValue("DB003-search-form", "SEARCH_STDR_MT")
						,"SEARCH_OPTION":KpackageOBJ.object.getFormValue("DB003-search-form", "SEARCH_OPTION")
						,"SEARCH_KEY_WORD":KpackageOBJ.object.getFormValue("DB003-search-form", "SEARCH_KEY_WORD")
						,"SEARCH_RCEPT_FROM_DATE":KpackageOBJ.object.getFormValue("DB003-search-form", "SEARCH_RCEPT_FROM_DATE")
						,"SEARCH_RCEPT_TO_DATE":KpackageOBJ.object.getFormValue("DB003-search-form", "SEARCH_RCEPT_TO_DATE")
						,"SEARCH_DSPTH_FROM_DATE":KpackageOBJ.object.getFormValue("DB003-search-form", "SEARCH_DSPTH_FROM_DATE")
						,"SEARCH_DSPTH_TO_DATE":KpackageOBJ.object.getFormValue("DB003-search-form", "SEARCH_DSPTH_TO_DATE")};
			
			var searchTab = currentTab.replace("#","");
			
			if(searchTab == "s1"){
				KpackageOBJ.tuiGrid.retrieve("oTui_ToastGrid_01", "/drawback/retrieveDrawbackCtrmList", param);
			}/* else if(searchTab == "s2"){
				KpackageOBJ.tuiGrid.retrieve("oTui_ToastGrid_0201", "/drawback/retrieveCustomerList", param);
			}else if(searchTab == "s3"){
				KpackageOBJ.tuiGrid.retrieve("oTui_ToastGrid_0301", "/drawback/retrieveCustomerList", param);
			}else if(searchTab == "s4"){
				KpackageOBJ.tuiGrid.retrieve("oTui_ToastGrid_04", "/drawback/retrieveCustomerList", param);
			}else if(searchTab == "s5"){
				KpackageOBJ.tuiGrid.retrieve("oTui_ToastGrid_05", "/drawback/retrieveCustomerList", param);
			}else if(searchTab == "s6"){
				KpackageOBJ.tuiGrid.retrieve("oTui_ToastGrid_0601", "/drawback/retrieveCustomerList", param);
			}else if(searchTab == "s7"){
				KpackageOBJ.tuiGrid.retrieve("oTui_ToastGrid_07", "/drawback/retrieveCustomerList", param);
			}else if(searchTab == "s8"){
				KpackageOBJ.tuiGrid.retrieve("oTui_ToastGrid_08", "/drawback/retrieveCustomerList", param);
			}else if(searchTab == "s9"){
				KpackageOBJ.tuiGrid.retrieve("oTui_ToastGrid_09", "/drawback/retrieveCustomerList", param);
			}else if(searchTab == "s10"){
				KpackageOBJ.tuiGrid.retrieve("oTui_ToastGrid_10", "/drawback/retrieveCustomerList", param);
			}else if(searchTab == "s11"){
				KpackageOBJ.tuiGrid.retrieve("oTui_ToastGrid_1101", "/drawback/retrieveCustomerList", param);
			} */
		};
		
		/* Dbl Click Handler */
		this.dbl_Handler = function(p_GridId, p_RowKey, p_ColName){
			var rowData = KpackageOBJ.tuiGrid.getSelectedRowlValue(gridId, rowkey);
			
			var searchTab = currentTab.replace("#","");
			
			if(searchTab == "s2"){
				var param = {"INTG_INTERFACE_TRANS_ID" : rowData.INTG_INTERFACE_TRANS_ID};
				KpackageOBJ.tuiGrid.retrieve("oTui_ToastGrid_0202", "/drawback/retrieveCustomerList", param);
				KpackageOBJ.tuiGrid.retrieve("oTui_ToastGrid_0203", "/drawback/retrieveCustomerList", param);
			}else if(searchTab == "s3"){
				var param = {"INTG_INTERFACE_TRANS_ID" : rowData.INTG_INTERFACE_TRANS_ID};
				KpackageOBJ.tuiGrid.retrieve("oTui_ToastGrid_0302", "/drawback/retrieveCustomerList", param);
			}else if(searchTab == "s6"){
				var param = {"INTG_INTERFACE_TRANS_ID" : rowData.INTG_INTERFACE_TRANS_ID};
				KpackageOBJ.tuiGrid.retrieve("oTui_ToastGrid_0602", "/drawback/retrieveCustomerList", param);
			}else if(searchTab == "s11"){
				var param = {"INTG_INTERFACE_TRANS_ID" : rowData.INTG_INTERFACE_TRANS_ID};
				KpackageOBJ.tuiGrid.retrieve("oTui_ToastGrid_1102", "/drawback/retrieveCustomerList", param);
				KpackageOBJ.tuiGrid.retrieve("oTui_ToastGrid_1103", "/drawback/retrieveCustomerList", param);
			}
		};
	};
	
	$(document).ready(function() {
		pageSetUp();				// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB003.initialize_viewObject(); 		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		DB003.initialize_TuiGrid();		 
		

	    $('a[data-toggle="tab"]').on('shown.bs.tab', function(e){
	    	currentTab = $(e.target).attr("href");
	        
	        DB003.retrieve_gridData();
	    	//currentTab = $(e.target).text(); // get current tab
	        //var LastTab = $(e.relatedTarget).text(); // get last tab
 	        //$(".last-tab span").html(LastTab);
	    });
	});
	
</script>
</body>
</html>