<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<div class="content-wrapper">
		<div class="row">
			<div class="content-wrapper col-3">
				<h1 class="subheader-title mb-1">게시판</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item">게시판</li>
						<li class="breadcrumb-item active" aria-current="page">게시판</li>
					</ol>
				</nav>
			</div>
		</div>
		<div class="row">
			<form:form id="boardList-form" class="s4-form" novalidate="novalidate" onsubmit="BOARD_LIST.retrieve_GridData(); return false;">
				<input type="hidden" id="popParam"/>
				<div id="panel-4" class="panel panel-icon">
					<div class="panel-container show">
						<div class="panel-content">
							<div class="row">
								<div class="col-3">
									<div class="mb-3">
										<div class="row">
											<label class="form-label" for="example-input-border">제목/내용</label>
										</div>
										<div class="col">
											<input type="text" id="searchText" class="form-control" >
										</div>
									</div>
								</div>
								<div class="col-3">
									<div class="mb-3">
										<div class="row">
											<label class="form-label" for="example-input-border">게시글 유형</label>
										</div>
										<div class="col">
											<select class="form-control w-full" id="searchBoadrType" name="searchBoadrType" style="width:110px"></select>        
										</div>
									</div>
								</div>
								<div class="col-5">
								</div>
								<div class="col">
									<button type="button"
											onclick="javascript:BOARD_LIST.retrieve_GridData();"
											class="btn btn-sm btn-search search-no-more waves-effect waves-themed">Search</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form:form>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="d-flex frame-wrap" style="align-items: center;">
					<div class="demo" style="margin-left: auto;">
						<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="BOARD_LIST.fnWrite()">
							글쓰기
						</button>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div id="oAuiGrid_boardList" class="w-full" style="height:600px; margin:0 auto;"></div>
			</div>
		</div>
	</div>
</body>				
	
<script type="text/javascript">
	var BOARD_LIST = new function () {
		this.gridId = null;
		this.state  = { 
			comCdLoadCount : 0,
		};
						
		this.list = {
			CATEGIRIES : ["BT"], //카테고리 리스트
			COMMON_BT_LIST : [],     //게시글 유형코드
		};
						
		//List Data Init
		this.Initialize_listObject = function () {
			BOARD_LIST.state['comCdLoadCount'] = 0;
			
			BOARD_LIST.list['CATEGIRIES'].forEach(function (category) {
				const sParam = { CATEGORY: category };
				KpackageOBJ.ajax.doSubmit("/common/retrieveComCdList", sParam, function (res) {BOARD_LIST.Initialize_listObjectCallback(res, category);});
			});
		};
						
		//List Data Init Callback
		this.Initialize_listObjectCallback = function (res, category) {
			var data = res.value;
			BOARD_LIST.list['COMMON_' + category + '_LIST'] = data;
							
			BOARD_LIST.state['comCdLoadCount']++;
		    
		    //비동기 호출시 시점 문제 발생 - 개수 체크
			if (BOARD_LIST.state['comCdLoadCount'] === BOARD_LIST.list['CATEGIRIES'].length) {
				BOARD_LIST.Initialize_viewObject();
			}
		};
					
		//View Obejct Init
		this.Initialize_viewObject = function () {
			KpackageOBJ.selectbox.create("boardList-form", "searchBoadrType",  "/common/retrieveComCdList", {"CATEGORY":"BT", "OPTION_ALL":"Y", "OPTION_ALL_NAME": "전체"}, "code", "code_name");  
			
			BOARD_LIST.createAUIGrid();
			BOARD_LIST.retrieve_GridData();
		}
		
		//Grid Init
		this.createAUIGrid = function () {
			const columnLayout = [
				{
					dataField: "board_no"
				  , headerText: "NO."
				  , width: 80
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
					dataField: "board_type_name"
				  , headerText: "게시글 유형"
				  , width: 100
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
				    dataField: "subject"
				  , headerText: "제목"
				  , width: 350
				  , style: "grid-left-text"
				  , filter: {showIcon: true}
				  , labelFunction: function(rowIndex, columnIndex, value, headerText, item) {

				        if (item.parent_board_no != null) {
				            return "↳ " + value;
				        }
						return value;
			    	}
				},
				{
				    dataField: "create_by"
				  , headerText: "작성자"
				  , width: 120
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
				    dataField: "create_date"
				  , headerText: "작성일"
				  , width: 150
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
				{
				    dataField: "read_count"
				  , headerText: "조회수"
				  , width: 80
				  , style: "grid-center-text"
				  , filter: {showIcon: true}
				},
			];

			const gridProps = {
				usePaging: true,
				pageRowCount: 50,
				showPageRowSelect: true,
				enableFilter: true,
				fillColumnSizeMode:true,
				showStateColumn:false,
				enableSorting:false,
				
				rowIdField: "board_no",
				selectionMode: "singleRow",
				hoverMode: "singleRow",
				
				flat2tree: true,
				treeIdField: "board_no",
				treeIdRefField: "parent_board_no",
				treeColumnIndex: 2,
			    treeLevelIndent: 18
			};


			BOARD_LIST.gridId = KpackageOBJ.auiGrid.create("oAuiGrid_boardList", columnLayout, gridProps, "");
			
			
			KpackageOBJ.auiGrid.bind(BOARD_LIST.gridId, "cellDoubleClick", function (event) {
				var params = {
					  input_type : "U"	
					, board_no : event.item["board_no"]
				};
				
				KpackageOBJ.dialog.open('ftaNationPopup','게시판 상세','/origin/board/boardMgnt/boardMgntDetail', 1000, 700, true, JSON.stringify(params));
				
			});
			
			
		}

		//조회
		this.retrieve_GridData = function () {
			var params = {
				"searchText": KpackageOBJ.object.getFormValue("boardList-form", "searchText")
				, "searchBoadrType" : KpackageOBJ.object.getFormValue("boardList-form", "searchBoadrType")
			}
							
			KpackageOBJ.auiGrid.retrieve(BOARD_LIST.gridId, "/origin/board/boardMgnt/retrieveBoardMgntList", params);
		};
		
		//글쓰기
		this.fnWrite = function () {
			var params = {
				  input_type : "I"	
			};
			
			KpackageOBJ.dialog.open('ftaNationPopup','게시판 상세','/origin/board/boardMgnt/boardMgntDetail', 1000, 700, true, JSON.stringify(params));
		};
		
		
	}

	$(document).ready(function () {
		BOARD_LIST.Initialize_listObject();
	});

</script>
<style>
.aui-grid-tree-plus-icon,
.aui-grid-tree-minus-icon,
.aui-grid-tree-branch-icon,
.aui-grid-tree-branch-open-icon,
.aui-grid-tree-leaf-icon {
    display: none !important;
}
</style>

</html>