<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메뉴관리</title>
</head>
<body>
<div class="content-wrapper">
    <div class="row mb-2">
        <div class="col-12">
            <h1 class="subheader-title mb-1">메뉴관리</h1>
            <nav class="app-breadcrumb" aria-label="breadcrumb">
                <ol class="breadcrumb ms-0 text-muted mb-0">
                    <li class="breadcrumb-item">Home</li>
                    <li class="breadcrumb-item">시스템관리</li>
                    <li class="breadcrumb-item active" aria-current="page">메뉴관리</li>
                </ol>
            </nav>
        </div>
    </div>

    <!-- 조회조건 -->	
	<div class="row">
		<form:form id="MENU000-form-search" class="s4-form" novalidate="novalidate" onsubmit="MENU000.retrieveMenuList(); return false;">
			<input type="hidden" id="popParam"/>
			<div id="panel-4" class="panel panel-icon">
				<div class="panel-container show">
					<div class="panel-content">
						<div class="row">
							<div class="col-3">
								<div class="mb-3">
									<div class="row">
										<label class="form-label" for="search_using_yn">사용 여부</label>
									</div>
									<div class="col">
										<select id="search_using_yn" class="form-select">
					                        <option value="">전체</option>
					                        <option value="Y" selected>사용</option>
					                        <option value="N">미사용</option>
					                    </select>
									</div>
								</div>
							</div>
							<div class="col-3">
								<div class="mb-3">
									<div class="row">
										<label class="form-label" for="search_system_type">시스템 구분</label>
									</div>
									<div class="col">
										<select id="search_system_type" class="form-select">
					                        <option value="">전체</option>
					                        <option value="I" selected>내부</option>
					                        <option value="V">협력사</option>
					                    </select>
									</div>
								</div>
							</div>
							<div class="col-5">
							</div>
							<div class="col">
								<button type="button"
									onclick="javascript:MENU000.retrieveMenuList();"
									class="btn btn-sm btn-search search-no-more waves-effect waves-themed">Search</button>
							</div>
						</div>

					</div>
				</div>
			</div>
		</form:form>
	</div>
	

    <div class="row">
        <!-- 메뉴 Tree -->
        <div class="col-3">
            <div class="panel panel-icon">
                <div class="panel-container show">
                    <div class="panel-content">
                        <div class="d-flex align-items-center mb-2">
                            <h3 class="subheader-title mb-0" style="font-size:1.1rem;">메뉴 목록</h3>
                            <div class="ms-auto">
                                <button type="button" class="btn btn-sm btn-secondary" onclick="MENU000.addRootMenu();">
                                    메뉴 추가
                                </button>
                                <button type="button" class="btn btn-sm btn-secondary" onclick="MENU000.addChildMenu();">
                                    하위메뉴 추가
                                </button>
                            </div>
                        </div>
                        <div id="oAuiGrid_MENU000_01" style="width:100%;height:500px;margin:0 auto;"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 메뉴 상세 -->
        <div class="col-9">
            <div class="d-flex align-items-center mb-2">
                <h3 id="MENU000_detail_title" class="subheader-title mb-0" style="font-size:1.3rem;">메뉴 상세정보</h3>
                <div class="ms-auto">
                    <button type="button" class="btn btn-sm btn-secondary" onclick="MENU000.saveMenu();">
                        변경사항 저장
                    </button>
                </div>
            </div>

            <form:form id="MENU000-form" class="s4-form" novalidate="novalidate" action="" method="post">
                <input type="hidden" id="menu_save_type" name="save_type" value="U">
                <input type="hidden" id="menu_parent_menu_id" name="parent_menu_id">
                <input type="hidden" id="menu_level" name="menu_level">

                <div class="panel panel-icon">
                    <div class="panel-container show">
                        <div class="panel-content">
                            <div class="row">
                                <div class="mb-3 col-4">
                                    <label class="form-label" for="menu_id">메뉴 ID <span class="text-danger">*</span></label>
                                    <input type="text" id="menu_id" name="menu_id" class="form-control" maxlength="10" required>
                                </div>
                                <div class="mb-3 col-4">
                                    <label class="form-label" for="menu_parent_name">상위 메뉴</label>
                                    <input type="text" id="menu_parent_name" name="parent_menu_name" class="form-control" readonly>
                                </div>
                                <div class="mb-3 col-4">
                                    <label class="form-label" for="menu_sort_no">정렬 순서 <span class="text-danger">*</span></label>
                                    <input type="number" id="menu_sort_no" name="sort_no" class="form-control" min="0" required>
                                </div>

                                <div class="mb-3 col-4">
                                    <label class="form-label" for="menu_name">메뉴명 <span class="text-danger">*</span></label>
                                    <input type="text" id="menu_name" name="menu_name" class="form-control" maxlength="100" required>
                                </div>
                                <div class="mb-3 col-4">
                                    <label class="form-label" for="menu_name_eng">메뉴 영문명</label>
                                    <input type="text" id="menu_name_eng" name="menu_name_eng" class="form-control" maxlength="100">
                                </div>
                                <div class="mb-3 col-4">
                                    <label class="form-label" for="menu_name_loc">메뉴 로컬명</label>
                                    <input type="text" id="menu_name_loc" name="menu_name_loc" class="form-control" maxlength="100">
                                </div>

                                <div class="mb-3 col-12">
                                    <label class="form-label" for="menu_desc">메뉴 설명</label>
                                    <textarea id="menu_desc" name="menu_desc" class="form-control" rows="4" maxlength="2000"></textarea>
                                </div>

                                <div class="mb-3 col-4">
                                    <label class="form-label d-block">사용 여부 <span class="text-danger">*</span></label>
                                    <select id="using_yn" name="using_yn" class="form-select" required>
                                        <option value="Y">사용</option>
                                        <option value="N">미사용</option>
                                    </select>
                                </div>

                                <div class="mb-3 col-4">
                                    <label class="form-label" for="menu_type">메뉴 유형 <span class="text-danger">*</span></label>
                                    <select id="menu_type" name="menu_type" class="form-select" required>
                                        <option value="I">내부 링크</option>
                                        <option value="E">외부 링크</option>
                                        <option value="P">파라미터 적용</option>
                                    </select>
                                </div>

                                <div class="mb-3 col-4">
                                    <label class="form-label" for="menu_system_type">시스템 구분 <span class="text-danger">*</span></label>
                                    <select id="menu_system_type" name="system_type" class="form-select" required>
                                        <option value="I">내부</option>
                                        <option value="V">협력사</option>
                                    </select>
                                </div>

                                <div class="mb-3 col-12">
                                    <label class="form-label" for="menu_link_url">URL</label>
                                    <input type="text" id="menu_link_url" name="link_url" class="form-control" maxlength="200">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form:form>
        </div>
    </div>
</div>

<script>
var MENU000 = new function() {

    this.grid_MENU000_01 = null;
    this.selectedMenuId = null;

    this.Initialize_viewObject = function() {
        MENU000.createAUIGrid_01();
        MENU000.retrieveMenuList();
    };

    this.createAUIGrid_01 = function() {
        const columnLayout = [
            {
                dataField: "menu_name",
                headerText: "메뉴명",
                width: 220
            },
            {
                dataField: "menu_id",
                headerText: "메뉴 ID",
                width: 100
            }
        ];

        const gridProps = {
            selectionMode: "singleRow",
            displayTreeOpen: true,
            treeColumnIndex: 0,
            flat2tree: true,                  // 핵심 추가
            rowIdField: "menu_id",
            treeIdField: "menu_id",
            treeIdRefField: "parent_menu_id",
            usePaging: false,
            showPageRowSelect: false,
            fillColumnSizeMode: true
        };

        MENU000.grid_MENU000_01 = KpackageOBJ.auiGrid.create(
            "oAuiGrid_MENU000_01",
            columnLayout,
            gridProps,
            ""
        );

        AUIGrid.bind(MENU000.grid_MENU000_01, "cellClick", function(event) {
            if (!event.item || !event.item.menu_id) {
                return;
            }
            MENU000.selectedMenuId = event.item.menu_id;
            MENU000.retrieveMenuDetail(event.item.menu_id);
        });

        AUIGrid.bind(MENU000.grid_MENU000_01, "ready", function(event) {
            var rowCount = AUIGrid.getRowCount(event.pid);
            if (rowCount < 1) {
                MENU000.addRootMenu();
                return;
            }

            var targetIndex = 0;
            if (MENU000.selectedMenuId) {
                var rowIndex = AUIGrid.rowIdToIndex(event.pid, MENU000.selectedMenuId);
                if (rowIndex >= 0) {
                    targetIndex = rowIndex;
                }
            }

            AUIGrid.setSelectionByIndex(event.pid, targetIndex, 0);
            var data = KpackageOBJ.auiGrid.getSelectRowData(MENU000.grid_MENU000_01);
            if (data && data.menu_id) {
                MENU000.selectedMenuId = data.menu_id;
                MENU000.retrieveMenuDetail(data.menu_id);
            }
        });
    };

    this.retrieveMenuList = function() {
        var params = {
            using_yn: $("#search_using_yn").val(),
            system_type: $("#search_system_type").val()
        };

        KpackageOBJ.ajax.doSubmit(
            "/system/menu/menuMgnt/retrieveMenuList",
            params,
            MENU000.retrieveMenuList_Handler
        );
    };
    
    this.retrieveMenuList_Handler = function(result) {
        var data = result.value || [];

        AUIGrid.setGridData(
       	    MENU000.grid_MENU000_01,
       	    data
       	);

        if (data.length < 1) {
            MENU000.selectedMenuId = null;
            MENU000.addRootMenu();
            return;
        }

        var targetIndex = 0;

        if (MENU000.selectedMenuId) {
            var rowIndexes =
                AUIGrid.getRowIndexesByValue(
                    MENU000.grid_MENU000_01,
                    "menu_id",
                    MENU000.selectedMenuId
                );

            if (rowIndexes && rowIndexes.length > 0) {
                targetIndex = rowIndexes[0];
            }
        }

        AUIGrid.setSelectionByIndex(
            MENU000.grid_MENU000_01,
            targetIndex,
            0
        );

        var selected =
            KpackageOBJ.auiGrid.getSelectRowData(
                MENU000.grid_MENU000_01
            );

        if (selected && selected.menu_id) {
            MENU000.selectedMenuId = selected.menu_id;
            MENU000.retrieveMenuDetail(selected.menu_id);
        }
    };

    this.retrieveMenuDetail = function(menuId) {
        if (!menuId) {
            return;
        }

        KpackageOBJ.ajax.doSubmit(
            "/system/menu/menuMgnt/retrieveMenuDetail",
            { menu_id: menuId },
            MENU000.retrieveMenuDetail_Handler
        );
    };

    this.retrieveMenuDetail_Handler = function(result) {
        var data = result.value;
        if (!data) {
            alert("메뉴 정보를 찾을 수 없습니다.");
            return;
        }

        KpackageOBJ.data.setFormData("MENU000-form", data);
        $("#menu_save_type").val("U");
        $("#menu_id").prop("readonly", true);
        $("#MENU000_detail_title").text(data.menu_name + " (" + data.menu_id + ")");
    };

    this.addRootMenu = function() {
        MENU000.clearForm();
        $("#menu_save_type").val("I");
        $("#menu_level").val(1);
        $("#menu_system_type").val($("#search_system_type").val() || "I");
        $("#MENU000_detail_title").text("신규 최상위 메뉴");
        $("#menu_id").focus();
    };

    this.addChildMenu = function() {
        var selected = KpackageOBJ.auiGrid.getSelectRowData(MENU000.grid_MENU000_01);
        if (!selected || !selected.menu_id) {
            alert("상위 메뉴를 먼저 선택해 주세요.");
            return;
        }

        MENU000.clearForm();
        $("#menu_save_type").val("I");
        $("#menu_parent_menu_id").val(selected.menu_id);
        $("#menu_parent_name").val(selected.menu_name + " (" + selected.menu_id + ")");
        $("#menu_level").val(Number(selected.menu_level || 0) + 1);
        $("#menu_system_type").val(selected.system_type || "I");
        $("#MENU000_detail_title").text("신규 하위 메뉴");
        $("#menu_id").focus();
    };

    this.clearForm = function() {
        var form = document.getElementById("MENU000-form");
        form.reset();

        $("#menu_id").prop("readonly", false);
        $("#menu_save_type").val("I");
        $("#menu_parent_menu_id").val("");
        $("#menu_parent_name").val("");
        $("#menu_level").val("");
        $("#menu_sort_no").val(1);
        $("#using_yn").val("Y");
        $("#menu_type").val("I");
        $("#menu_system_type").val("I");
    };

    this.saveMenu = function() {
        if (!MENU000.validateForm()) {
            return;
        }

        var params = KpackageOBJ.data.makePostData("MENU000-form");

        KpackageOBJ.ajax.doSubmit(
            "/system/menu/menuMgnt/saveMenu",
            params,
            MENU000.saveMenu_Handler
        );
    };

    this.saveMenu_Handler = function(result) {
        alert(result.message);

        if (!result.success) {
            return;
        }

        MENU000.selectedMenuId = result.value.menu_id;
        MENU000.retrieveMenuList();
    };

    this.validateForm = function() {
        var menuId = $.trim($("#menu_id").val());
        var menuName = $.trim($("#menu_name").val());
        var sortNo = $.trim($("#menu_sort_no").val());
        var menuType = $("#menu_type").val();
        var linkUrl = $.trim($("#menu_link_url").val());

        if (!menuId) {
            alert("메뉴 ID를 입력해 주세요.");
            $("#menu_id").focus();
            return false;
        }
        if (!menuName) {
            alert("메뉴명을 입력해 주세요.");
            $("#menu_name").focus();
            return false;
        }
        if (sortNo === "" || Number(sortNo) < 0) {
            alert("정렬 순서를 올바르게 입력해 주세요.");
            $("#menu_sort_no").focus();
            return false;
        }
        if ((menuType === "I" || menuType === "E") && !linkUrl) {
            alert("링크 메뉴는 URL을 입력해 주세요.");
            $("#menu_link_url").focus();
            return false;
        }
        return true;
    };
};

$(document).ready(function() {
    pageSetUp();
    MENU000.Initialize_viewObject();
});
</script>
</body>
</html>