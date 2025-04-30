<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  
    
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form:form id="SM009-form" class="s4-form" novalidate="novalidate">
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 200px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th>사용자 ID</th>
									<td>
										<input type="text" id="SEARCH_ITEM_CODE" name="SEARCH_ITEM_CODE" style="width:300px" class="inputText" searchfnc="SM009.retrieve_gridData"/>
										<div class="note">
												<strong>Note:</strong> 패스워드를 초기화 할 사용자 ID를 입력합니다. 
										</div>
									</td>
									
								</tr>
								<tr>
									<th>패스워드 초기화 증빙 번호</th>
									<td>
										<input type="text" id="SEARCH_ITEM_NAME" name="SEARCH_ITEM_NAME" style="width:300px" class="inputText" searchfnc="SM009.retrieve_gridData">
										<div class="note"><strong>Note:</strong>  패스워드 초기화 관련 증빙 문서번호를 입력합니다.</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-3" type="button" onclick="javascript:SM009.retrieve_gridData();">
							<i class="fa fa-save"></i> 패스워드 초기화 
						</button>
					</div>
				</div>
			</div>
		</form:form>
	</section>
</div>
<script>
	var SM009 = new function() {
		
		// Page Object Initialize
		this.initialize_viewObject = function() {
	
		
		};
		
		this.initialize_TuiGrid = function(){
			
		};
	
		 
		this.retrieve_gridData = function(){
		};
	};
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		SM009.initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});

</script>
</body>
</html>