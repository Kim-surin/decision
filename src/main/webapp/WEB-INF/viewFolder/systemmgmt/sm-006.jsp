<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
/******************************************************************************************************
	Program Name : 메뉴관리
	Program Code : SYS-00200
******************************************************************************************************/
%>
<!DOCTYPE html>
<html>
<head>
	<!-- Bootstrap Tree Plugin -->
	<script type="text/javascript" src="/rcs/js/plugin/bootstraptree/bootstrap-tree.min.js"></script>
	
</head>
<body>
<div class="row">
	<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
		<h1 class="page-title txt-color-blueDark"><i class="fa-fw fa fa-puzzle-piece"></i> 시스템관리 <span>> 메뉴관리</span></h1>
	</div>
</div>
<div id="content">
	<section id="widget-grid-SM006" class="">
		<form:form id="SM006-form" class="s4-form" novalidate="novalidate" onsubmit="return false;" action="/#/sm-006">
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
					<div class="table-responsive of-hidden">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;" />
								<col style="width:" />
							</colgroup>
							<tbody>
								<tr>
									<th>사용여부</th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_USE_YN" name="SEARCH_USE_YN" style="width:110px"></select>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:SM006.submitSave();">
							<i class="fa fa-add"></i> Save
						</button>
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:SM006.submitSearch();">
							<i class="fa fa-search"></i> Search
						</button>
					</div>
				</div>
			</div>
		</form:form>
		<!-- row -->
		<div class="row">
			<!-- NEW WIDGET START -->
			<article class="col-sm-12 col-md-12 col-lg-4">
	
				<!-- Widget ID (each widget will need unique ID)-->
				<div class="jarviswidget jarviswidget-color-blue" id="wid-id-SM006-1" data-widget-fullscreenbutton="false" data-widget-editbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-sitemap"></i> </span>
						<h2>메뉴구조</h2>
					</header>
	
					<!-- widget div-->
					<div>
	
						<!-- widget edit box -->
						<div class="jarviswidget-editbox">
							<!-- This area used as dropdown edit box -->
	
						</div>
						<!-- end widget edit box -->
	
						<!-- widget content -->
						<div class="widget-body"  style="height: 350px;overflow-y: scroll;">
							<div id="MENU_TREE" class="tree smart-form">

							</div>
	
						</div>
						<!-- end widget content -->
	
					</div>
					<!-- end widget div -->
	
				</div>
				<!-- end widget -->
	
			</article>
			<!-- WIDGET END -->
			<article class="col-sm-8 col-md-8 col-lg-8">
				<form:form id="SM006-form2" class="s4-form" novalidate="novalidate" onsubmit="return false;">
					<input type="hidden" id="SAVE_STATUS" name="SAVE_STATUS" value="U"/>
					<table class="table table-bordered" >
						<colgroup>
						    <col style="width: 15%; min-width: 70px;;">
						    <col>
						    <col style="width: 15%; min-width: 70px;;">
						    <col>
						</colgroup>
						<tbody>
							<tr>
								<th colspan="4">
									<button class="btn blackButton " type="button"  style="float:right;" onclick="javascript:SM006.submitAdd();">
										<i class="fa fa-add"></i> Add
									</button>
								</th>
							</tr>
							<tr>
								<th>상위메뉴 ID
								</th><td><input type="text" id="PARENT_MENU_ID" name="PARENT_MENU_ID" maxlength="10" class="form-control" readonly="readonly"></td>
								<th>메뉴ID
								</th><td><input type="text" id="MENU_ID" name="MENU_ID" maxlength="10" class="form-control" readonly="readonly"></td>
							</tr>
							<tr>
								<th>메뉴 명
								</th><td><input type="text" id="MENU_NAME" name="MENU_NAME" maxlength="100" class="form-control" ></td>
								<th>Link Url
								</th><td><input type="text" id="LINK_URL" name="LINK_URL" maxlength="200" class="form-control" ></td>
							</tr>
							<tr>
								<th>메뉴 설명
								</th><td colspan="3"><input type="text" id="MENU_DESC" name="MENU_DESC" maxlength="100" class="form-control" ></td>
							</tr>
							<tr>
								<th>사용여부
								</th><td><select id="USING_YN" name="USING_YN" class="form-control" style="width:110px">
										<option value="Y">Yes</option>
										<option value="N">No</option>
									</select>
								</td>
								<th>정렬순서
								</th>
								<td><input type="number" id="SORT_NO" name="SORT_NO" class="form-control" ></td>
							
							</tr>
						</tbody>
					</table>
				</form:form>
			</article>
	
		</div>
	</section>
</div>

<script type="text/javascript">

	var SM006 = new function() {
		this.initialize_viewObject = function(){
			var arrayItem = [{value:"", name:"All"}
								,{value:"Y", name:"Yes"}
 								,{value:"N", name:"No"}];

			KpackageOBJ.selectbox.create("SM006-form","SEARCH_USE_YN","", null,"value","name", arrayItem);
		}
		
		this.initialize_TuiGrid = function(){
		
	    	
		};
		
		this.onDblClick_oTui_Grid = function(gridId, rowkey, colName){
			
		};
		
		this.retrieve_List = function(){
			var param = KpackageOBJ.data.makePostData("SM006-form");
			
		}
		
		this.viewDetail = function(o){
			var dataValue = $(o).data();
			
			$("#PARENT_MENU_ID").attr("readonly", true);
			$("#MENU_ID").attr("readonly", true);
			$("#USING_YN").attr("disabled", false);

			KpackageOBJ.object.setFormValue("SM006-form2","PARENT_MENU_ID", nullToString(dataValue["parent_menu_id"]));
			KpackageOBJ.object.setFormValue("SM006-form2","MENU_ID", nullToString(dataValue["menu_id"]));
			KpackageOBJ.object.setFormValue("SM006-form2","MENU_NAME", nullToString(dataValue["menu_name"]));
			KpackageOBJ.object.setFormValue("SM006-form2","MENU_DESC", nullToString(dataValue["menu_desc"]));
			KpackageOBJ.object.setFormValue("SM006-form2","LINK_URL", nullToString(dataValue["link_url"]));
			KpackageOBJ.object.setFormValue("SM006-form2","USING_YN", nullToString(dataValue["using_yn"]));
			KpackageOBJ.object.setFormValue("SM006-form2","SORT_NO", nullToString(dataValue["sort_no"]));
			KpackageOBJ.object.setFormValue("SM006-form2","SAVE_STATUS", "U");
				
		}
		
		//ADD MENU
		this.submitAdd = function(){
			
			$("#PARENT_MENU_ID").attr("readonly", false);
			$("#MENU_ID").attr("readonly", false);
			$("#USING_YN").attr("disabled", true);

			KpackageOBJ.object.setFormValue("SM006-form2","PARENT_MENU_ID", "");
			KpackageOBJ.object.setFormValue("SM006-form2","MENU_ID", "");
			KpackageOBJ.object.setFormValue("SM006-form2","MENU_NAME", "");
			KpackageOBJ.object.setFormValue("SM006-form2","MENU_DESC", "");
			KpackageOBJ.object.setFormValue("SM006-form2","LINK_URL", "");
			KpackageOBJ.object.setFormValue("SM006-form2","USING_YN", "Y");
			KpackageOBJ.object.setFormValue("SM006-form2","SORT_NO", "");
			KpackageOBJ.object.setFormValue("SM006-form2","SAVE_STATUS", "I");
			
		}
		
		this.submitSave = function(){
			var params = KpackageOBJ.data.makePostData("SM006-form2");
			
			if(oUtil.isNull(params["MENU_ID"])){
				KpackageOBJ.object.alert("메뉴ID를 입력해주세요.");
				return;
			}
			
			if(oUtil.isNull(params["MENU_NAME"])){
				KpackageOBJ.object.alert("메뉴명을 입력해주세요.");
				return;
			}
		
			if(oUtil.isNull(params["SORT_NO"])){
				KpackageOBJ.object.alert("정렬순서를 입력해주세요.");
				return;
			}
			
			params["USING_YN"] = 	KpackageOBJ.object.getFormValue("SM006-form2","USING_YN");
			KpackageOBJ.ajax.doSubmit("/sys/updateSystemMenu", params, SM006.submitSaveCallback);   
		}
		
		this.submitSaveCallback = function(result){
			if (result.success) { // 성공시
				SM006.submitSearch();
				KpackageOBJ.object.alert("<spring:message code='common.msg.saveok'/>");
			} else { // 실패시
				KpackageOBJ.object.alert(result.message);
			}
		}
		
		
		this.submitSearch = function(){
			var params = {
					"SEARCH_USE_YN" : KpackageOBJ.object.getFormValue("SM006-form","SEARCH_USE_YN")
			};
			
			KpackageOBJ.ajax.doSubmit("/sys/retrieveSystemMenuTreeList", params, SM006.submitSearchCallback);   
		}
		
		this.submitSearchCallback = function(result){
			$("#MENU_TREE").empty();
			var html = "";
			html += "<ul>";
			html += "<li>";	
			html += "<span>";
			html += "<i class='fa fa-lg fa-folder-open'></i> K-DB System Menu Tree";
			html += "</span>";
			html += "<ul>";
			
			for(var i =0; i < result.value.length; i++){
				html += "<li>";
				html += "<span onclick='javascript:SM006.viewDetail(this);'";
				html += " data-MENU_DESC='"+ result.value[i]["MENU_DESC"] +"'  ";
				html += " data-MENU_NAME='"+ result.value[i]["MENU_NAME"] +"'  ";
				html += " data-LINK_URL='"+ result.value[i]["LINK_URL"] +"'  ";
				html += " data-MENU_SE='"+ result.value[i]["MENU_SE"] +"'  ";
				html += " data-USING_YN='"+ result.value[i]["USING_YN"] +"'  ";
				html += " data-SORT_NO='"+ result.value[i]["SORT_NO"] +"'  ";
				html += " data-MENU_ID='"+ result.value[i]["MENU_ID"] +"'  ";
				html += " data-PARENT_MENU_ID='"+ result.value[i]["PARENT_MENU_ID"] +"' > ";
				html += " <i class='fa fa-lg fa-plus-circle'></i> "+ result.value[i]["MENU_NAME"];
				html += "  [" +result.value[i]["MENU_ID"] + "] (" + result.value[i]["SUB_MENU"].length+") </span>";
				
				
				if(result.value[i]["SUB_MENU"].length > 0){
					html += "<ul>";

					for(var j=0; j < result.value[i]["SUB_MENU"].length; j++){
						html += "<li style='display:none; cursor: pointer;' onclick='javascript:SM006.viewDetail(this);' ";
						html += " data-MENU_DESC='"+ result.value[i]["SUB_MENU"][j]["MENU_DESC"] +"'  ";
						html += " data-MENU_NAME='"+ result.value[i]["SUB_MENU"][j]["MENU_NAME"] +"'  ";
						html += " data-LINK_URL='"+ result.value[i]["SUB_MENU"][j]["LINK_URL"] +"'  ";
						html += " data-MENU_SE='"+ result.value[i]["SUB_MENU"][j]["MENU_SE"] +"'  ";
						html += " data-USING_YN='"+ result.value[i]["SUB_MENU"][j]["USING_YN"] +"'  ";
						html += " data-SORT_NO='"+ result.value[i]["SUB_MENU"][j]["SORT_NO"] +"'  ";
						html += " data-MENU_ID='"+ result.value[i]["SUB_MENU"][j]["MENU_ID"] +"'  ";
						html += " data-PARENT_MENU_ID='"+ result.value[i]["SUB_MENU"][j]["PARENT_MENU_ID"] +"' > ";
						html += "<span> <i></i> " + result.value[i]["SUB_MENU"][j]["MENU_NAME"] ;
						html += "  [" + result.value[i]["SUB_MENU"][j]["MENU_ID"]   + "]</span>";
						html += "</li>";
						
					}
					html += "</ul>";
				}

				html += "</li>";
			}

			html += "</ul>";
			html += "</li>";
			html += "</ul>";
		
			$("#MENU_TREE").append(html);
	
			KpackageOBJ.tree.create("#wid-id-SM006-1");
		}
	}

	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		SM006.initialize_viewObject();	// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		SM006.initialize_TuiGrid();		// Toast Grid Render
		SM006.submitSearch();
	});

</script>
	
</body>
</html>