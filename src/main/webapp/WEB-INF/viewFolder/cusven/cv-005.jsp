<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form:form id="SV005-search-form" novalidate="novalidate" class="s4-form" onsubmit="return false;" method="post">
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;">
								<col style="width: 15%;">
								<col style="width: 80px;">
								<col style="width:">
							</colgroup>
							<tbody>
								<tr>
									<th>사용유무</th>
									<td> 
										<select class="form-control searchSelect" id="SEARCH_SYSTEM_BATCH_YN" name="SEARCH_SYSTEM_BATCH_YN" style="width:110px"></select>
									</td>
									<th>조회조건</th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText">
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:SV005.retrieve_gridData();">
							<i class="fa fa-search"></i> Search
						</button>
					</div>
				</div>
			</div>
			<div>
				<input type="hidden" name="_csrf" value="63062d27-85c7-46d3-bc64-05fc8b500248">
			</div>
		</form:form>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_InterfaceSchdule_Grid" name="div_oTui_InterfaceSchdule_Grid" class="tuigrid-resizable">
					
					<div id="oTui_InterfaceSchdule_Grid" data-minus-height="240"></div>
					<div id="oTui_InterfaceSchdule_Grid_paging"></div>
				</div>
			</div>
		</div>
		
	</section>
</div> 
<script type="text/javascript">
	
	var SV005 = new function(){
		
		// Page Object Initialize
		this.initialize_Object = function() {
			
			
		}
		


		
		this.initialize_TuiGrid = function() {
			
			
			
		}
		
		this.retrieve_gridData = function() {

		}
		
		/* Dbl Click Handler */
		this.dbl_Handler = function(p_GridId, p_RowKey, p_ColName){
			
			
		}
	}
	
	$(document).ready(function() {
		pageSetUp();				// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		SV005.initialize_Object(); 		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		SV005.initialize_TuiGrid();		 
		
		
	});
	
</script>
</body>
</html>