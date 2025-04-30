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
		<form:form id="search-form" class="s4-form" novalidate="novalidate">
			<fieldset>
				<div class="row">
					<section class="col col-6">
					    <label class="input"><strong><spring:message code='companyinfo.title.company_code' /></strong></label>
						<label class="input"> <i class="icon-prepend fa fa-barcode"></i>
							<input type="text" name="COMPANY_CODE" placeholder="<spring:message code='companyinfo.title.company_code' />">
						</label>
					</section>
					<section class="col col-6">
					    <label class="input"><strong><spring:message code='companyinfo.title.biz_no' /></strong></label>
						<label class="input"> <i class="icon-prepend fa fa-delicious"></i>
							<input type="text" name="BUSINESS_NO" placeholder="<spring:message code='companyinfo.title.biz_no' />">
						</label>
					</section>
				</div>
				
				<section>
					<label class="input"><strong><spring:message code='companyinfo.title.certification_no' /></strong></label>
					<label class="input">
						<input type="text" name="CERTIFICATION_NO" placeholder="ex) 123-03345-122">
					</label>
				</section>

			</fieldset>
			
			
			<table class="table table-bordered">
				<colgroup>
					<col style="width: 110px;" />
					<col style="width: " />
					<col style="width: 110px;" />
					<col style="width: " />
				</colgroup>
				<tbody>
					<tr>
						<th><spring:message code='TXT.ITEM,TXT.CODE' /></th>
						<td>
							
						</td>
						<th><spring:message code='TXT.HS_CODE' /></th>
						<td>
							<input type="text" name="CERTIFICATION_NO" class="inputText" placeholder="ex) 123-03345-122"/>
						</td>
					</tr>
					<tr>
						<th><spring:message code='TXT.ITEM,TXT.NAME' /></th>
						<td colspan="3">
							<input type="text" id="CAL_sampleDatePicker"  name="CAL_sampleDatePicker" />
							<input type="hidden" id="sampleDatePicker"  name="sampleDatePicker" />
						</td>
					</tr>
				</tbody>
			</table>
			<fieldset>
				<div class="row">
					<button class="btn btn-default btn-primary btn-custom-search search-row-3" type="button" onclick="javascript:retrieve_gridData();">
						<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
					</button>
					
					<button class="btn btn-default btn-primary btn-custom-search search-row-2" type="button" onclick="javascript:retrieve_gridData();">
						<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
					</button>
					
					<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:retrieve_gridData();">
						<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
					</button>
					
					<button type="button" class="btn blueButtonL ">
						<i class="fa fa-save"></i> <spring:message code='common.title.btn.save' />
					</button>
					
					<button type="button" class="btn grayButton ">
						<i class="fa fa-save"></i> <spring:message code='common.title.btn.save' />
					</button>
					
					<button type="button" class="btn blackButton ">
						<i class="fa fa-save"></i> <spring:message code='common.title.btn.save' />
					</button>
					
				</div>
			</fieldset>
		</form:form>
		
		<!-- -------------------------------------------------------------------------------------------------------------------- -->
		<article class="col-sm-12 col-md-12 col-lg-6 sortable-grid ui-sortable no-padding">
			<div class="jarviswidget" id="wid-id-1" 
						data-widget-colorbutton="false"	 	
						data-widget-editbutton="false"
						data-widget-deletebutton="false"
						data-widget-custombutton="false"
						data-widget-togglebutton="false"
						data-widget-fullscreenbutton="false"
						data-widget-sortable="false">
					<header>
						<h2>기본 위젯</h2>				
					</header>
					<!-- widget div-->
					<div>
						<!-- widget content -->
						<div class="widget-body">
							
							<p>여기에 각종 내용을 작성하세요 </p>
							<p>위젯의 사이즈는 상위 div의 width를 상속받습니다. </p>
							<p>class="jarviswidget" 클레스를 가지는 객체의 아이디는 중복되어선 안됩니다. </p>
							
						</div>
						<!-- end widget content -->
					</div>
					<!-- end widget div -->
			</div>
			<!-- end widget -->
		</article>
		<article class="col-sm-12 col-md-12 col-lg-6 sortable-grid ui-sortable">
			<div class="jarviswidget jarviswidget-color-blue" id="wid-id-2" data-widget-editbutton="false" data-widget-colorbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false">
				<header>
					<h2><strong>Title</strong> <i>색상 변경 위젯</i></h2>				
					
				</header>

				<!-- widget div-->
				<div>
					<!-- widget content -->
					<div class="widget-body">
						
						<h3 class="alert alert-info"> 강조 텍스트 넣기 스타일 1 </h3>
						<code>jarviswidget-color-blue</code> 와 같은 클레스로 변경
					</div>
					<!-- end widget content -->
					
				</div>
				<!-- end widget div -->
				
			</div>
			<!-- end widget -->
		</article>
		
		
		<article class="col-xs-12 col-sm-6 col-md-6 col-lg-6 no-padding">

			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget" id="wid-id-3" data-widget-editbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-arrows-v"></i> </span>
					<h2 class="font-md"><strong>상단 접기 </strong> <i>위젯</i></h2>				
					
				</header>

				<!-- widget div-->
				<div>
					
					<!-- widget content -->
					<div class="widget-body">
						
						<code>data-widget-togglebutton</code> 를 제거합니다.
						
					</div>
					<!-- end widget content -->
					
				</div>
				<!-- end widget div -->
				
			</div>
			<!-- end widget -->
			
			
		</article>
		
		<article class="col-sm-12 col-md-12 col-lg-6 sortable-grid ui-sortable">
			<div class="jarviswidget" id="wid-id-4" data-widget-editbutton="false" data-widget-colorbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false">
				<header>
					<h2><strong>전체화면</strong> <i>위젯</i></h2>				
					
				</header>

				<!-- widget div-->
				<div>
					<!-- widget content -->
					<div class="widget-body">
						
						<code>data-widget-fullscreenbutton="false"</code> 를 제거합니다.
						
					</div>
					<!-- end widget content -->
					
				</div>
				<!-- end widget div -->
				
			</div>
			<!-- end widget -->
		</article>
		
		
			
		

	</section>
</div>
<script>
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
		
	});
	
	// Page Object Initialize
	function Initialize_viewObject() {
		/* Calendar Type Object Create  */
		KpackageOBJ.calendar.create("search-form", "CAL_sampleDatePicker");
		KpackageOBJ.calendar.setValue("search-form","CAL_sampleDatePicker", "20140101");		
		
	}
	
	
	
	
</script>
</body>
</html>