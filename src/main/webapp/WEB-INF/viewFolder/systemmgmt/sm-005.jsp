<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<!-- Dual List Select Box Plugin -->
	<script type="text/javascript" src="/rcs/js/plugin/bootstrap-duallistbox/jquery.bootstrap-duallistbox.min.js"></script>
	
	
</head>
<body>
<div class="row">
	<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
		<h1 class="page-title txt-color-blueDark"><i class="fa-fw fa fa-puzzle-piece"></i> 시스템관리 <span>> 권한관리</span></h1>
	</div>
</div>

<div id="content">
	
	<section id="widget-grid-SM005">
		
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
				<div id="div_oTui_SM005_01" name="div_oTui_SM005_01" class="tuigrid-resizable">
					<div id="oTui_SM005_01" data-minus-height="" data-fixed-height="250"></div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-8">
				<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-SM005-0" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
						<h2>권한 상세 </h2>
					</header>

					<!-- widget div-->
					<div role="content">
	
						<!-- widget edit box -->
						<div class="jarviswidget-editbox">
							<!-- This area used as dropdown edit box -->
	
						</div>
						<!-- end widget edit box -->
	
						<!-- widget content -->
						<div class="widget-body">
							
							<div class="widget-body-toolbar">
								<div class="row">
									<div class="col-sm-12 text-right">
										<button id="BTN_AUTHOR_ADD" name="BTN_AUTHOR_ADD" class="btn btn btn-primary" onclick="SM005.addComAuthorGroup();">추가</button>
										<!-- <button id="BTN_AUTHOR_NEW"  name="BTN_AUTHOR_NEW"  class="btn btn btn-primary">신규등록</button> -->
										<button id="BTN_AUTHOR_SAVE" name="BTN_AUTHOR_SAVE" class="btn btn btn-primary" onclick="SM005.saveComAuthorGroup();">저장</button>
										<!-- <button id="BTN_AUTHOR_DEL"  name="BTN_AUTHOR_DEL"  class="btn btn btn-primary">삭제</button> -->
									</div>
								</div>
							</div>
							<form:form id="SM005-form" class="s4-form" novalidate="novalidate" onsubmit="return false;">
							<input type="hidden" id="SAVE_STATUS"  naem="SAVE_STATUS" value="" />
							<table class="table table-bordered">  
			            		<thead></thead>
			            		<tbody>
									<tr>
						                <th style="width: 14%">권한그룹 코드</td>
						                <td><input type="text" id="AUTHOR_GROUP_CODE" name="AUTHOR_GROUP_CODE" class="inputText" style="width: 100%" readonly="readonly"></td>
						                <th>권한그룹 명</td>
						                <td><input type="text" id="AUTHOR_GROUP_NM" name="AUTHOR_GROUP_NM" class="inputText" style="width: 100%"></td>
			              			</tr>
									<tr>
						                <th>사용여부</td>
						                <td>
						                	<select class="form-control searchSelect" id="USE_AT" name="USE_AT" style="width:110px">
												<option value="N">No</option>	          									
												<option value="Y">Yes</option>
											</select>
						                </td>
						                <th>시작 Page Url</td>
						                <td><input type="text" id="START_PAGE_URL" name="START_PAGE_URL" class="inputText" style="width: 100%"></td>
			              			</tr>
									<tr>
						                <th>권한그룹 설명</td>
						                <td colspan="3">
						                	<textarea name="AUTHOR_GROUP_DC" id="AUTHOR_GROUP_DC" style="width: 100%;" rows="5"></textarea>
						                </td>
			              			</tr>
			            		</tbody>
			          		</table>
							</form:form>
						</div>
						<!-- end widget content -->
	
					</div>
					<!-- end widget div -->

				</div>
				<!-- end widget -->
			</div>
			
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div class="jarviswidget jarviswidget-color-darken" id="wid-id-SM005-2" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
						<h2>권한별 메뉴 등록</h2>
						
					</header>
	
					<!-- widget div-->
					<div role="content">
	
						<!-- widget edit box -->
						<div class="jarviswidget-editbox">
							<!-- This area used as dropdown edit box -->
	
						</div>
						<!-- end widget edit box -->
	
						<!-- widget content -->
						<div class="widget-body">
							<form:form  id="SM005-form2" name="SM005-form2" class="s4-form" novalidate="novalidate" onsubmit="return false;">
								<input type="hidden" id="PARAM_AUTHOR_GROUP_CODE" name="PARAM_AUTHOR_GROUP_CODE" />
								<select multiple="multiple" size="10" name="SM005-DualListBox" id="SM005-DualListBox">
								</select>
							</form:form>
						</div>
						<!-- end widget content -->
	
					</div>
					<!-- end widget div -->
	
				</div>
				<!-- end widget -->
			
			</div>			
			
		</div>
		
	</section>
	
</div>

<!-- end widget grid -->

<script type="text/javascript">

/*
 * BOOTSTRAP DUALLIST BOX
 */


	var oDualList;
	var SM005 = new function() {
		this.initialize_viewObject = function(){
			
			var dualList_Option = {
					nonSelectedListLabel: '메뉴 목록',
					selectedListLabel: '권한에 부여된 메뉴',
					preserveSelectionOnMove: 'moved',
					moveOnSelect: false,
					nonSelectedFilter: ""};
			
			oDualList = $('#SM005-DualListBox').bootstrapDualListbox(dualList_Option);
			SM005.initObject_EventHandler();
		}
		
		this.initObject_EventHandler = function(){
			
			$("#SM005-form2 select#SM005-DualListBox").change(function(e){
				SM005.changeAuthorMenuList($(this).val());           
			});
		}
		
		this.initialize_TuiGrid = function(){
			var colArrayInfo = [
					{"header" :"권한그룹코드"	,"name" :"AUTHOR_GROUP_CODE" 	,"width" : 100   ,"align" :"center"    ,"hidden" : false},
					{"header" :"권한그룹명"		,"name" :"AUTHOR_GROUP_NM"    		             ,"align" :"left"      ,"hidden" : false},
					{"header" :"권한그룹명"		,"name" :"AUTHOR_GROUP_DC"    		             ,"align" :"center"    ,"hidden" : true},
					{"header" :"사용여부"		,"name" :"USE_AT"    		             		 ,"align" :"left"      ,"hidden" : true},
					{"header" :"시작페이지"		,"name" :"START_PAGE_URL"    		             ,"align" :"left"      ,"hidden" : true}
			    ];
			 
			KpackageOBJ.tuiGrid.create("oTui_SM005_01","/sys/retrieveComAuthorGroupList", colArrayInfo, "", null, SM005.onDblClick_oTui_Grid);
	    	
		};
		
		this.onDblClick_oTui_Grid = function(gridId, rowkey, colName){
			var rowData = KpackageOBJ.tuiGrid.getSelectedRowlValue(gridId, rowkey);
			

			$("#AUTHOR_GROUP_CODE").attr("readonly", true);
			KpackageOBJ.object.setFormValue("SM005-form","AUTHOR_GROUP_CODE" ,rowData["AUTHOR_GROUP_CODE"]);
			KpackageOBJ.object.setFormValue("SM005-form","AUTHOR_GROUP_NM",rowData["AUTHOR_GROUP_NM"]);
			KpackageOBJ.object.setFormValue("SM005-form","AUTHOR_GROUP_DC",rowData["AUTHOR_GROUP_DC"]);
			KpackageOBJ.object.setFormValue("SM005-form","USE_AT",rowData["USE_AT"]);
			KpackageOBJ.object.setFormValue("SM005-form","START_PAGE_URL",rowData["START_PAGE_URL"]);
			KpackageOBJ.object.setFormValue("SM005-form","SAVE_STATUS", "U");
			
			KpackageOBJ.object.setFormValue("SM005-form2","PARAM_AUTHOR_GROUP_CODE",KpackageOBJ.object.getFormValue("SM005-form","AUTHOR_GROUP_CODE"));
			if(KpackageOBJ.object.getFormValue("SM005-form2","PARAM_AUTHOR_GROUP_CODE") == ""){
				KpackageOBJ.object.alert("권한그룹코드가 없습니다.");
				return false;
			}
			SM005.reloadMultiSelect(KpackageOBJ.object.getFormValue("SM005-form2","PARAM_AUTHOR_GROUP_CODE"));
		};
		
		this.retrieve_List = function(){
			var param = KpackageOBJ.data.makePostData("SM005-form");
			KpackageOBJ.tuiGrid.retrieve("oTui_SM005_01", "", param);
		}
		
		this.addComAuthorGroup = function(){
			$("#AUTHOR_GROUP_CODE").attr("readonly", false);
			KpackageOBJ.object.setFormValue("SM005-form","AUTHOR_GROUP_CODE", "");
			KpackageOBJ.object.setFormValue("SM005-form","AUTHOR_GROUP_NM", "");
			KpackageOBJ.object.setFormValue("SM005-form","AUTHOR_GROUP_DC", "");
			KpackageOBJ.object.setFormValue("SM005-form","USE_AT", "Y");
			KpackageOBJ.object.setFormValue("SM005-form","START_PAGE_URL", "");
			KpackageOBJ.object.setFormValue("SM005-form","SAVE_STATUS", "I");
		}
		
		this.saveComAuthorGroup = function(){
			if(KpackageOBJ.object.getFormValue("SM005-form","AUTHOR_GROUP_CODE") == ""){
				KpackageOBJ.object.alert("저장할 권한데이터가 없습니다.");
				return false;
			}
			
			var params = {
					"AUTHOR_GROUP_CODE" : KpackageOBJ.object.getFormValue("SM005-form","AUTHOR_GROUP_CODE")
					,"AUTHOR_GROUP_NM"  : KpackageOBJ.object.getFormValue("SM005-form","AUTHOR_GROUP_NM")
					,"AUTHOR_GROUP_DC"  : KpackageOBJ.object.getFormValue("SM005-form","AUTHOR_GROUP_DC")
					,"USE_AT"           : KpackageOBJ.object.getFormValue("SM005-form","USE_AT")
					,"START_PAGE_URL"   : KpackageOBJ.object.getFormValue("SM005-form","START_PAGE_URL")
					,"SAVE_STATUS"      : KpackageOBJ.object.getFormValue("SM005-form","SAVE_STATUS")
					
			};
			
			KpackageOBJ.ajax.doSubmit("/sys/updateComAuthorGroup", params, SM005.updateComAuthorGroupCallback);	
			
			
		}
		
		this.updateComAuthorGroupCallback = function(result){
			SM005.retrieve_List();
			KpackageOBJ.object.alert(result.message);
				
		}
		
		this.formData_Handler = function(result){
			KpackageOBJ.object.alert(result.message);
		}
		
		this.reloadMultiSelect = function(authorCode){
			var params = {
					"AUTHOR_GROUP_CODE" : authorCode
			};
			KpackageOBJ.ajax.doSubmit("/sys/retrieveExistsMenuList", params, SM005.reloadMultiSelect_Handler);
		}
		
		this.reloadMultiSelect_Handler = function(result){
			var data = result.value;
			$("select#SM005-DualListBox option").remove();
			for(var inx = 0; inx < data.length; inx++){
				var row = data[inx];
				$("#SM005-form2 select#SM005-DualListBox").append(row["DATA_TAG"]);
			}
			oDualList.bootstrapDualListbox("refresh",true);
		}
		
		this.changeAuthorMenuList = function(selectedArray) {
			var listParams = [];
			
			if(selectedArray != undefined && selectedArray.length > 0 ){
				for(var inx=0; inx < selectedArray.length; inx++){
					listParams.push({"MENU_ID" : selectedArray[inx]});
				}
			}
			
			
			var params = {
					"AUTHOR_GROUP_CODE" : KpackageOBJ.object.getFormValue("SM005-form2","PARAM_AUTHOR_GROUP_CODE")
					, "MENU_ID_LIST" : listParams
					
			};
			if("" == params["AUTHOR_GROUP_CODE"]){
				return;
			}
			
			KpackageOBJ.ajax.doSubmit("/sys/changeAuthorMenuList", params, SM005.changeAuthorMenuList_Handler);
		}
		
		
		this.changeAuthorMenuList_Handler = function(result){
		
		}
	}

	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		SM005.initialize_viewObject();	// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		SM005.initialize_TuiGrid();		// Toast Grid Render
		
		SM005.retrieve_List();
	});

</script>
	
</body>
</html>