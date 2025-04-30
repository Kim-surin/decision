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
		<form:form id="DB004-search-form" novalidate="novalidate" class="s4-form" onsubmit="return false;" method="post">
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
								<col style="width: 150px;" />
								<col style="width: ;" />
							</colgroup>
							<tbody>
								<tr>
									<th>기준년월</th>
									<td>
										<input type="text" id="CAL_SEARCH_DATE"  name="CAL_SEARCH_DATE" class="inputText has-month-picker" searchfnc="DB004.retrieve_gridData"/>
									</td>
									<th>등록(접수)번호-관세청</th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="DB004.retrieve_gridData"/>
									</td>
								</tr>
								<tr>
									<th>접수일자</th>
									<td>
										<input type="text" id="CAL_SEARCH_RCEPT_FROM_DATE"  name="CAL_SEARCH_RCEPT_FROM_DATE" style="width:120px" class="inputText" searchfnc="DB004.retrieve_gridData"/> ~
										<input type="text" id="CAL_SEARCH_RCEPT_TO_DATE"  name="CAL_SEARCH_RCEPT_TO_DATE" style="width:120px" class="inputText" searchfnc="DB004.retrieve_gridData"/>
									</td>
									<th>통보일자</th>
									<td>
										<input type="text" id="CAL_SEARCH_DSPTH_FROM_DATE"  name="CAL_SEARCH_DSPTH_FROM_DATE" style="width:120px" class="inputText" searchfnc="DB004.retrieve_gridData"/> ~
										<input type="text" id="CAL_SEARCH_DSPTH_TO_DATE"  name="CAL_SEARCH_DSPTH_TO_DATE" style="width:120px" class="inputText" searchfnc="DB004.retrieve_gridData"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-2" type="button" onclick="javascript:DB004.retrieve_gridData();">
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
					<a href="#s2" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>기납증/분증</a>
				</li>
				<li class="">
					<a href="#s3" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>배제문서</a>
				</li>
				<li class="">
					<a href="#s4" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>정정/취하</a>
				</li>
				<li class="">
					<a href="#s5" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>보완통보서</a>    
				</li>                                                                                                        
				<li class="">                                                                                                
					<a href="#s6" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>접수통보</a>     
				</li>                                                                                                        
				<li class="">                                                                                                
					<a href="#s7" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>오류통보</a>     
				</li>                                                                                                        
				<li class="">                                                                                                
					<a href="#s8" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>완료통보</a>     
				</li>                                                                                                        
				<li class="">                                                                                                
					<a href="#s9" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>결정통보</a>     
				</li>                                                                                                        
				<li class="">                                                                                                
					<a href="#s10" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>환급자료제출요구</a> 
				</li>                                                                                                        
				<li class="">                                                                                                
					<a href="#s11" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>서류제출통보</a>  
				</li>
				<li class="">
					<a href="#s12" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>제출자료</a>
				</li>
				<li class="pull-right">
					<a href="javascript:void(0);">
					<div class="sparkline txt-color-pinkDark text-align-right" data-sparkline-height="18px" data-sparkline-width="90px" data-sparkline-barwidth="7"><canvas width="52" height="18" style="display: inline-block; width: 52px; height: 18px; vertical-align: top;"></canvas></div> </a>
				</li>
			</ul>
			<div id="myTabContent1" class="tab-content padding-10 sadfsaf" style="background: #FFF;display: inline-block;">
			<!--     width: -moz-available;
    width: -webkit-fill-available;
    width: fill-available; -->
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

							<div id="oTui_ToastGrid_0201" data-minus-height="720"></div>
							<div id="oTui_ToastGrid_0201_paging"></div>
						</div>
						
					</div>
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_0202" name="div_oTui_ToastGrid_0202" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_0202" data-minus-height="720"></div>
							<div id="oTui_ToastGrid_0202_paging"></div>
						</div>
						
					</div>
				</div>
				<div class="tab-pane fade" id="s3">
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_0301" name="div_oTui_ToastGrid_0301" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_0301" data-minus-height="710"></div>
							<div id="oTui_ToastGrid_0301_paging"></div>
						</div>
					</div>
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_0302" name="div_oTui_ToastGrid_0302" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_0302" data-minus-height="710"></div>
							<div id="oTui_ToastGrid_0302_paging"></div>
						</div>

					</div>
				</div>
				<div class="tab-pane fade" id="s4">
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_0401" name="div_oTui_ToastGrid_0401" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_0401" data-minus-height="710"></div>
							<div id="oTui_ToastGrid_0401_paging"></div>
						</div>
						
						<div id="div_oTui_ToastGrid_0402" name="div_oTui_ToastGrid_0402" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_0402" data-minus-height="710"></div>
							<div id="oTui_ToastGrid_0402_paging"></div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="s5">
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_05" name="div_oTui_ToastGrid_05" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_05" data-minus-height="360"></div>
							<div id="oTui_ToastGrid_05_paging"></div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="s6">
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_06" name="div_oTui_ToastGrid_06" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_06" data-minus-height="360"></div>
							<div id="oTui_ToastGrid_06_paging"></div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="s7">
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_0701" name="div_oTui_ToastGrid_0701" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_0701" data-minus-height="720"></div>
							<div id="oTui_ToastGrid_0701_paging"></div>
						</div>
						<div id="div_oTui_ToastGrid_0702" name="div_oTui_ToastGrid_0702" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_0702" data-minus-height="720"></div>
							<div id="oTui_ToastGrid_0702_paging"></div>
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
						<div id="div_oTui_ToastGrid_11" name="div_oTui_ToastGrid_11" class="tuigrid-resizable">

							<div id="oTui_ToastGrid_11" data-minus-height="360"></div>
							<div id="oTui_ToastGrid_11_paging"></div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="s12">
					<div class="col-sm-12">
						<div id="div_oTui_ToastGrid_1201" name="div_oTui_ToastGrid_1201" class="tuigrid-resizable">
							<div id="oTui_ToastGrid_1201" data-minus-height="830"></div>
							<div id="oTui_ToastGrid_1201_paging"></div>
						</div>
						<div id="div_oTui_ToastGrid_1202" name="div_oTui_ToastGrid_1202" class="tuigrid-resizable">
							<div id="oTui_ToastGrid_1202" data-minus-height="830"></div>
							<div id="oTui_ToastGrid_1202_paging"></div>
						</div>
						<div id="div_oTui_ToastGrid_1203" name="div_oTui_ToastGrid_1203" class="tuigrid-resizable">
							<div id="oTui_ToastGrid_1203" data-minus-height="830"></div>
							<div id="oTui_ToastGrid_1203_paging"></div>
						</div>
					</div>
				</div>
			</div>
		</form:form>
	</section>
</div> 
<script type="text/javascript">
	
	var DB004 = new function(){
		
		// Page Object Initialize
		this.initialize_viewObject = function() {
			KpackageOBJ.monthPicker.create("DB004-search-form", "CAL_SEARCH_DATE");
			KpackageOBJ.monthPicker.setValue("DB004-search-form","CAL_SEARCH_DATE", "${sessionScope._sessionUser.WORK_DATE}".replace(/-/gi, "").substring(0,6));
			KpackageOBJ.calendar.create("DB004-search-form", "CAL_SEARCH_RCEPT_FROM_DATE");
			KpackageOBJ.calendar.create("DB004-search-form", "CAL_SEARCH_RCEPT_TO_DATE");
			KpackageOBJ.calendar.create("DB004-search-form", "CAL_SEARCH_DSPTH_FROM_DATE");
			KpackageOBJ.calendar.create("DB004-search-form", "CAL_SEARCH_DSPTH_TO_DATE");

			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			             ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						 ,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("DB004-search-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
		};
		
		this.initialize_TuiGrid = function() {
			//환급/기납증 발급
			var colArrayInfo01 = [
				{"header" : "상태"               ,"name" : "attribute01" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "환급제출번호"       ,"name" : "attribute02" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "행번"               ,"name" : "attribute03" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "월"                 ,"name" : "attribute04" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "판매처"             ,"name" : "attribute05" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "판매처명"           ,"name" : "attribute06" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "판매문서"           ,"name" : "attribute07" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "플랜트"             ,"name" : "attribute08" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "자재"               ,"name" : "attribute09" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "고객자재번호"       ,"name" : "attribute10" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "판정유형"           ,"name" : "attribute11" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "판정유형명"         ,"name" : "attribute12" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "로컬/수출"          ,"name" : "attribute13" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "로컬/수출명"        ,"name" : "attribute14" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "사급구분"           ,"name" : "attribute15" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "자재내역"           ,"name" : "attribute16" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "자재그룹"           ,"name" : "attribute17" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "수출거래구분"       ,"name" : "attribute18" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "환급구분"           ,"name" : "attribute19" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "HS CODE"            ,"name" : "attribute20" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "환급금액"           ,"name" : "attribute21" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "환급금액(공제)"     ,"name" : "attribute22" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "환급금액(절사금액)" ,"name" : "attribute23" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "통화"               ,"name" : "attribute24" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "환급번호(6)"        ,"name" : "attribute25" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "등록번호"           ,"name" : "attribute26" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "발급일자"           ,"name" : "attribute27" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "발급여부"           ,"name" : "attribute28" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "발급여부내역"       ,"name" : "attribute29" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "상품여부"           ,"name" : "attribute30" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "수출신고번호"       ,"name" : "attribute31" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "란(3)"              ,"name" : "attribute32" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "규격번호(환급)"     ,"name" : "attribute33" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "신고수리일자"       ,"name" : "attribute34" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "Ctr"                ,"name" : "attribute35" ,"width" : 100 ,"align" : "center" ,"hidden" : false},
				{"header" : "D/I"                ,"name" : "attribute36" ,"width" : 100 ,"align" : "center" ,"hidden" : false}
		    ];
			//기납증/분증
			var colArrayInfo0201 = [
				{"header" : "등록(접수)번호"             , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "정정/취하작성"              , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "정정신청구분"               , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "정정신청구분내역"           , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "발급여부"                   , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "발급여부내역"               , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "기납증/분증구분"            , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "양도일자"                   , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "기납증증명구분"             , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "분증증명구분"               , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "품명기재여부"               , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "세관+년도"                  , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "근거서류번호"               , "name" : "attribute13" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "공급업체"                   , "name" : "attribute14" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "사업자등록번호"             , "name" : "attribute15" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "주소1"                      , "name" : "attribute16" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "대표자"                     , "name" : "attribute17" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신청인상호/대표자"          , "name" : "attribute18" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통관고유부호"               , "name" : "attribute19" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "제조자코드"                 , "name" : "attribute20" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "사업자등록번호"             , "name" : "attribute21" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "주소1"                      , "name" : "attribute22" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수익자(공급자)상호/대표자"  , "name" : "attribute23" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "대표자"                     , "name" : "attribute24" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통관고유부호"               , "name" : "attribute25" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "관세사"                     , "name" : "attribute26" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "HS CODE(원재료)"            , "name" : "attribute27" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "연산품부호"                 , "name" : "attribute28" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "관세청조사란1"              , "name" : "attribute29" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "관세청조사란2"              , "name" : "attribute30" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "FOB금액"                    , "name" : "attribute31" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "FOB통화키"                  , "name" : "attribute32" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통화"                       , "name" : "attribute33" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "단위"                       , "name" : "attribute34" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수량"                       , "name" : "attribute35" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "을지건수"                   , "name" : "attribute36" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수입면장번호"               , "name" : "attribute37" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "란번호"                     , "name" : "attribute38" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신고일자"                   , "name" : "attribute39" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "단위"                       , "name" : "attribute40" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수량"                       , "name" : "attribute41" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "금액(원화)"                 , "name" : "attribute42" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "관세"                       , "name" : "attribute43" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "개별소비세"                 , "name" : "attribute44" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "교통세"                     , "name" : "attribute45" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "주세"                       , "name" : "attribute46" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "교육세"                     , "name" : "attribute47" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "농특세"                     , "name" : "attribute48" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "총세액"                     , "name" : "attribute49" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "내국세구분"                 , "name" : "attribute50" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "내국세"                     , "name" : "attribute51" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "접수번호"                   , "name" : "attribute52" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "접수일자"                   , "name" : "attribute53" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통보일자"                   , "name" : "attribute54" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "결정일자"                   , "name" : "attribute55" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "월"                         , "name" : "attribute56" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자재"                       , "name" : "attribute57" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자재내역"                   , "name" : "attribute58" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정일자"                   , "name" : "attribute59" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정여부(Y/N)"              , "name" : "attribute60" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "작업번호"                   , "name" : "attribute61" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "일자"                       , "name" : "attribute62" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "플랜트"                     , "name" : "attribute63" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "정정취하구분(1.취하2.정정)" , "name" : "attribute64" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "ID No."                     , "name" : "attribute65" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "식별자 No."                 , "name" : "attribute66" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "성명"                       , "name" : "attribute67" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "ID No."                     , "name" : "attribute68" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "성명"                       , "name" : "attribute69" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "식별자 No."                 , "name" : "attribute70" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "일자"                       , "name" : "attribute71" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "시간"                       , "name" : "attribute72" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "전송상태"                   , "name" : "attribute73" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "일자"                       , "name" : "attribute74" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "시간"                       , "name" : "attribute75" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수신결과"                   , "name" : "attribute76" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "상태"                       , "name" : "attribute77" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "단축배제유무"               , "name" : "attribute78" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "세액계산시 고단가 적용유무" , "name" : "attribute79" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "세관"                       , "name" : "attribute80" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "담당자코드"                 , "name" : "attribute81" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "담당자이름"                 , "name" : "attribute82" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "전화번호1"                  , "name" : "attribute83" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "다세율조정고시대상여부"     , "name" : "attribute84" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정여부(Y/N)"              , "name" : "attribute85" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "확정일자"                   , "name" : "attribute86" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			
			var colArrayInfo0202 = [
				{"header" : "환급제출번호(내부채번)" , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "행번"                   , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자재"                   , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자재내역"               , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "규격"                   , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수량"                   , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "단위"                   , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "단가"                   , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "단가"                   , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "현지통화금액"           , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "현지통화금액"           , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "관세"                   , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "개별소비세"             , "name" : "attribute13" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "교통세"                 , "name" : "attribute14" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "주세"                   , "name" : "attribute15" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "교육세"                 , "name" : "attribute16" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "농특세"                 , "name" : "attribute17" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "총세액"                 , "name" : "attribute18" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "내국세구분"             , "name" : "attribute19" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "내국세"                 , "name" : "attribute20" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "금액(원화)"             , "name" : "attribute21" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "자재내역"               , "name" : "attribute22" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "작업번호"               , "name" : "attribute23" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "상태"                   , "name" : "attribute24" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "제품식별번호"           , "name" : "attribute25" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "문서번호"               , "name" : "attribute26" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수출신고번호"           , "name" : "attribute27" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "란번호"                 , "name" : "attribute28" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신고일자"               , "name" : "attribute29" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "순번"                   , "name" : "attribute30" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "원산지"                 , "name" : "attribute31" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "원재료구분"             , "name" : "attribute32" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "일자"                   , "name" : "attribute33" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "브랜드명"               , "name" : "attribute34" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "다세율조정고시대상여부" , "name" : "attribute35" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통화"                   , "name" : "attribute36" , "width" : 100 , "align" : "center" , "hidden" : false}
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
			//정정/취하
			var colArrayInfo0401 = [
				{"header" : "세관제출번호"              , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "문서구분"                  , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "정정신청구분"              , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신청일자"                  , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "신청사유"                  , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "제조자(양도자)"            , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "협력업체사등"              , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "주소1"                     , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "수익자(공급자)상호/대표자" , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "대표자"                    , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통관고유부호"              , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "접수번호"                  , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "YEAR"                      , "name" : "attribute13" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "ID No."                    , "name" : "attribute14" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "식별자 No."                , "name" : "attribute15" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "성명"                      , "name" : "attribute16" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "ID No."                    , "name" : "attribute17" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "성명"                      , "name" : "attribute18" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "식별자 No."                , "name" : "attribute19" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "접수일자"                  , "name" : "attribute20" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "통보일자"                  , "name" : "attribute21" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "관세사"                    , "name" : "attribute22" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "세관"                      , "name" : "attribute23" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			
			var colArrayInfo0402 = [
				{"header" : "환급제출번호(내부채번)"     , "name" : "attribute01" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "행번"                       , "name" : "attribute02" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "정정항목구분"               , "name" : "attribute03" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "정정구분"                   , "name" : "attribute04" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "물품행번호"                 , "name" : "attribute05" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "부산물행번호(기납증만해당)" , "name" : "attribute06" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "행(4)"                      , "name" : "attribute07" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "정정항목코드"               , "name" : "attribute08" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "정정전내역"                 , "name" : "attribute09" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "정정후내역"                 , "name" : "attribute10" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "부산물수입행번호"           , "name" : "attribute11" , "width" : 100 , "align" : "center" , "hidden" : false},
				{"header" : "배제내역행번호"             , "name" : "attribute12" , "width" : 100 , "align" : "center" , "hidden" : false}
			];
			//보완통보서
			var colArrayInfo05 = [
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
			var colArrayInfo06 = [
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
			var colArrayInfo0701 = [
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
			
			var colArrayInfo0702 = [
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
			var colArrayInfo08 = [
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
			var colArrayInfo09 = [
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
			var colArrayInfo10 = [
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
			var colArrayInfo11 = [
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
			var colArrayInfo1201 = [
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
			
			var colArrayInfo1202 = [
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
			
			var colArrayInfo1203 = [
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
			
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_01","/drawback/", colArrayInfo01, null, null, this.dbl_Handler);		//환급/기납증발급
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_0201","/drawback/", colArrayInfo0201, null, null, this.dbl_Handler);	//기납증/분증
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_0202","/drawback/", colArrayInfo0202, null, null, this.dbl_Handler);
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_0301","/drawback/", colArrayInfo0301, null, null, this.dbl_Handler);	//배제문서
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_0302","/drawback/", colArrayInfo0302, null, null, this.dbl_Handler);	
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_0401","/drawback/", colArrayInfo0401, null, null, this.dbl_Handler);	//정정/취하
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_0402","/drawback/", colArrayInfo0402, null, null, this.dbl_Handler);
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_05","/drawback/", colArrayInfo05, null, null, this.dbl_Handler);		//보완통보서
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_06","/drawback/", colArrayInfo06, null, null, this.dbl_Handler);		//접수통보
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_0701","/drawback/", colArrayInfo0701, null, null, this.dbl_Handler);	//오류통보
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_0702","/drawback/", colArrayInfo0702, null, null, this.dbl_Handler);
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_08","/drawback/", colArrayInfo08, null, null, this.dbl_Handler);		//완료통보
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_09","/drawback/", colArrayInfo09, null, null, this.dbl_Handler);		//결정통보
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_10","/drawback/", colArrayInfo10, null, null, this.dbl_Handler);		//환급자료제출요구
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_11","/drawback/", colArrayInfo11, null, null, this.dbl_Handler);		//서류제출통보
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_1201","/drawback/", colArrayInfo1201, null, null, this.dbl_Handler);	//제출자료
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_1202","/drawback/", colArrayInfo1202, null, null, this.dbl_Handler);
			KpackageOBJ.tuiGrid.create("oTui_ToastGrid_1203","/drawback/", colArrayInfo1203, null, null, this.dbl_Handler);
			
			var tools01 = [{icon:"insert", title:"관세청전송" ,text:"관세청전송"	,func:"DB004.openPopup_Drwbak_Lmtt"}];
	    	KpackageOBJ.tuiGrid.setButton("oTui_ToastGrid_01", tools01); // Toobar 생성
			var tools02 = [{icon:"insert", title:"정정/취하작성" ,text:"정정/취하작성"	,func:"DB004.openPopup_Drwbak_Lmtt"}
						,{icon:"insert", title:"정정전송" ,text:"정정전송"	,func:"DB004.openPopup_Drwbak_Lmtt"}
						,{icon:"insert", title:"취하전송" ,text:"취하전송"	,func:"DB004.openPopup_Drwbak_Lmtt"}];
			KpackageOBJ.tuiGrid.setButton("oTui_ToastGrid_0201", tools02); // Toobar 생성
			var tools07 = [{icon:"insert", title:"수정" ,text:"수정"	,func:"DB004.openPopup_Drwbak_Lmtt"}];
	    	KpackageOBJ.tuiGrid.setButton("oTui_ToastGrid_07", tools07); // Toobar 생성
			var tools10 = [{icon:"insert", title:"조견표작성" ,text:"조견표작성"	,func:"DB003.openPopup_Drwbak_Lmtt"}
						,{icon:"insert", title:"소요량작성" ,text:"소요량작성"	,func:"DB003.openPopup_Drwbak_Lmtt"}
						,{icon:"insert", title:"BOM작성" ,text:"BOM작성"	,func:"DB003.openPopup_Drwbak_Lmtt"}];
			KpackageOBJ.tuiGrid.setButton("oTui_ToastGrid_10", tools10); // Toobar 생성
			
		};
		
		this.retrieve_gridData = function() {
			
		};
		
		/* Dbl Click Handler */
		this.dbl_Handler = function(p_GridId, p_RowKey, p_ColName){
			
		};
	};
	
	$(document).ready(function() {
		pageSetUp();				// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		DB004.initialize_viewObject(); 		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		DB004.initialize_TuiGrid();		 
		
		
	});
	
</script>
</body>
</html>