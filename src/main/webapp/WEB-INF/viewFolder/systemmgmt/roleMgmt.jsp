<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>권한관리</title>
</head>
<body>
<div class="content-wrapper">
    <div class="row mb-2">
        <div class="col-12">
            <h1 class="subheader-title mb-1">권한관리</h1>
            <nav class="app-breadcrumb" aria-label="breadcrumb">
                <ol class="breadcrumb ms-0 text-muted mb-0">
                    <li class="breadcrumb-item">Home</li>
                    <li class="breadcrumb-item">시스템관리</li>
                    <li class="breadcrumb-item active">권한관리</li>
                </ol>
            </nav>
        </div>
    </div>

    <ul class="nav nav-tabs mb-3" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="role-menu-tab" data-bs-toggle="tab" data-bs-target="#role-menu-pane" type="button" role="tab">메뉴별</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="role-user-tab" data-bs-toggle="tab" data-bs-target="#role-user-pane" type="button" role="tab" onclick="ROLE000.openUserTab();">사용자별</button>
        </li>
    </ul>

    <div class="tab-content">
    <div class="tab-pane fade show active" id="role-menu-pane" role="tabpanel">
    <div class="row">
        <!-- 권한 목록 -->
        <div class="col-4">
            <div class="panel panel-icon">
                <div class="panel-container show">
                    <div class="panel-content">
                        <div class="d-flex align-items-center mb-2">
                            <h3 class="subheader-title mb-0" style="font-size:1.1rem;">권한 목록</h3>
                            <button type="button" class="btn btn-sm btn-secondary ms-auto" onclick="ROLE000.newRole();">신규등록</button>
                        </div>
                        <div id="oAuiGrid_ROLE000_01" style="width:100%;height:250px;"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 권한 상세 -->
        <div class="col-8">
            <div class="panel panel-icon">
                <div class="panel-container show">
                    <div class="panel-content">
                        <div class="d-flex align-items-center mb-2">
                            <h3 id="ROLE000_detail_title" class="subheader-title mb-0" style="font-size:1.1rem;">권한 상세</h3>
                            <div class="ms-auto">
                                <button type="button" class="btn btn-sm btn-danger" onclick="ROLE000.deleteRole();">삭제</button>
                                <button type="button" class="btn btn-sm btn-secondary" onclick="ROLE000.saveRole();">저장</button>
                            </div>
                        </div>
                        <form:form id="ROLE000-form" class="s4-form" novalidate="novalidate" action="" method="post">
                            <input type="hidden" id="role_save_type" name="save_type" value="U">
                            <div class="row">
                                <div class="mb-3 col-7">
                                    <label class="form-label" for="role_code">권한코드 <span class="text-danger">*</span></label>
                                    <input type="text" id="role_code" name="role_code" class="form-control" maxlength="20" required>
                                </div>
                                <div class="mb-3 col-7">
                                    <label class="form-label" for="role_name">권한명 <span class="text-danger">*</span></label>
                                    <input type="text" id="role_name" name="role_name" class="form-control" maxlength="100" required>
                                </div>
                                <div class="mb-0 col-12">
                                    <label class="form-label" for="role_desc">권한설명</label>
                                    <textarea id="role_desc" name="role_desc" class="form-control" rows="6" maxlength="2000"></textarea>
                                </div>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 메뉴 권한 -->
    <div class="panel panel-icon mt-3">
        <div class="panel-container show">
            <div class="panel-content">
                <div class="d-flex align-items-center mb-2">
                    <h3 class="subheader-title mb-0" style="font-size:1.1rem;">메뉴별 권한</h3>
                    <div class="ms-auto d-flex align-items-center">
                        <label class="form-label mb-0 me-2" for="role_menu_system_type">시스템 구분</label>
                        <select id="role_menu_system_type" class="form-select form-select-sm me-2" style="width:120px;">
                            <option value="" selected>전체</option>
                            <option value="I">내부</option>
                            <option value="V">협력사</option>
                        </select>
                        <button type="button" class="btn btn-sm btn-secondary" onclick="ROLE000.saveRoleMenu();">메뉴 권한 저장</button>
                    </div>
                </div>

                <div class="row">
                    <div class="col-5">
                        <div class="fw-bold mb-1">미부여 메뉴</div>
                        <div id="oAuiGrid_ROLE000_02" style="width:100%;height:430px;"></div>
                    </div>

                    <div class="col-1 d-flex flex-column align-items-center justify-content-center gap-2">
                        <button type="button" class="btn btn-sm btn-secondary" title="선택 메뉴 부여" onclick="ROLE000.assignSelected();">&gt;</button>
                        <button type="button" class="btn btn-sm btn-secondary" title="선택 메뉴 해제" onclick="ROLE000.unassignSelected();">&lt;</button>
                        <button type="button" class="btn btn-sm btn-secondary" title="전체 메뉴 부여" onclick="ROLE000.assignAll();">&gt;&gt;</button>
                        <button type="button" class="btn btn-sm btn-secondary" title="전체 메뉴 해제" onclick="ROLE000.unassignAll();">&lt;&lt;</button>
                    </div>

                    <div class="col-6">
                        <div class="d-flex align-items-center mb-1">
                            <span class="fw-bold">부여 메뉴 및 세부권한</span>
                            <div class="ms-auto">
                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="ROLE000.setAllAuth('Y');">전체 권한 부여</button>
                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="ROLE000.setAllAuth('N');">전체 권한 해제</button>
                            </div>
                        </div>
                        <div id="oAuiGrid_ROLE000_03" style="width:100%;height:430px;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>

    <!-- 사용자별 권한 -->
    <div class="tab-pane fade" id="role-user-pane" role="tabpanel">
    	<!-- 조회조건 -->	
		<div class="panel panel-icon mt-3">
			<div class="panel-container show">
				<div class="panel-content">
					<div class="row">
						<div class="col-2">
                            <label class="form-label" for="user_search_status">사용자 상태</label>
                            <select id="user_search_status" class="form-select">
                                <option value="">전체</option>
                                <option value="Y" selected>사용</option>
                                <option value="N">미사용</option>
                                <option value="R">퇴사</option>
                            </select>
                        </div>
                        <div class="col-2">
                            <label class="form-label" for="user_search_division">사업부</label>
                            <input type="text" id="user_search_division" class="form-control" maxlength="20" placeholder="사업부코드">
                        </div>
                        <div class="col-2">
                            <label class="form-label" for="user_search_role">권한그룹</label>
                            <select id="user_search_role" class="form-select role-select">
                                <option value="">전체</option>
                            </select>
                        </div>
                        <div class="col-2">
                            <label class="form-label" for="user_search_type">조회조건</label>
                            <select id="user_search_type" class="form-select">
                                <option value="NAME" selected>사용자명</option>
                                <option value="USER_ID">사용자 ID</option>
                                <option value="EMP_NO">사번</option>
                                <option value="DEPT">부서</option>
                            </select>
                        </div>
                        <div class="col-3">
                            <label class="form-label" for="user_search_keyword">검색어</label>
                            <input type="text" id="user_search_keyword" class="form-control" maxlength="100" onkeydown="if(event.keyCode===13){ROLE000.retrieveUserRoleList();}">
                        </div>
                        <div class="col-1 text-end">
                            <button type="button" class="btn btn-sm btn-search search-no-more waves-effect waves-themed" onclick="ROLE000.retrieveUserRoleList();">Search</button>
                        </div>
					</div>
				</div>
			</div>
		</div>
    	
    	<div class="d-flex align-items-end mb-2">
		    <div style="width:260px;">
		        <label class="form-label" for="user_apply_role">적용 권한그룹</label>
		        <select id="user_apply_role" class="form-select role-select">
		            <option value="">권한 해제</option>
		        </select>
		    </div>
		    <div class="ms-2">
		        <button type="button" class="btn btn-sm btn-secondary" onclick="ROLE000.saveUserRole();">선택 사용자 일괄적용</button>
		    </div>
		    <div class="ms-auto text-muted small">사용자를 체크한 후 적용할 권한그룹을 선택하세요.</div>
		</div>
		
		<div id="oAuiGrid_ROLE000_04" style="width:100%;height:570px;"></div>
    </div>
    </div>
</div>

<script>
var ROLE000 = new function() {

    this.grid_ROLE000_01 = null;
    this.grid_ROLE000_02 = null;
    this.grid_ROLE000_03 = null;
    this.grid_ROLE000_04 = null;
    this.selectedRoleCode = null;
    this.sourceData = [];
    this.assignedData = [];

    this.Initialize_viewObject = function() {
        ROLE000.createRoleGrid();
        ROLE000.createMenuGrids();
        ROLE000.createUserGrid();
        ROLE000.retrieveRoleList();

        $("#role_menu_system_type").on("change", function() {
            if (ROLE000.selectedRoleCode) {
                ROLE000.retrieveRoleMenuList();
            }
        });
    };

    this.createUserGrid = function() {
        var columns = [
            { dataField: "company_code", headerText: "법인", width: 110 },
            { dataField: "division_code", filter: {showIcon: true}, headerText: "사업부", width: 100 },
            { dataField: "user_id", filter: {showIcon: true}, headerText: "User ID", width: 120 },
            { dataField: "name_kor", filter: {showIcon: true}, headerText: "User Name", width: 120 },
            { dataField: "emp_no", filter: {showIcon: true}, headerText: "사번", width: 100 },
            { dataField: "dept_name", filter: {showIcon: true}, headerText: "부서", width: 220 },
            { dataField: "role_names", filter: {showIcon: true}, headerText: "권한그룹", width: 180 }
        ];
        var props = {
            editable: false,
            enableFilter: true,
            selectionMode: "multipleRows",
            usePaging: true,
            pageRowCount: 100,
            showPageRowSelect: false,
            rowIdField: "user_id"
        };
        ROLE000.grid_ROLE000_04 = KpackageOBJ.auiGrid.create("oAuiGrid_ROLE000_04", columns, props, "check");
    };

    this.createRoleGrid = function() {
        var columns = [
            { dataField: "role_code", headerText: "권한코드", width: 120 },
            { dataField: "role_name", headerText: "권한명", width: 180 }
        ];
        var props = {
            selectionMode: "singleRow",
            usePaging: false,
            fillColumnSizeMode: true,
            rowIdField: "role_code"
        };

        ROLE000.grid_ROLE000_01 = KpackageOBJ.auiGrid.create("oAuiGrid_ROLE000_01", columns, props, "number");
        AUIGrid.bind(ROLE000.grid_ROLE000_01, "cellClick", function(event) {
            ROLE000.selectRole(event.item.role_code);
        });
    };

    this.createMenuGrids = function() {
        var sourceColumns = [
            { dataField: "menu_id", headerText: "메뉴 ID", width: 100 },
            { dataField: "menu_name", headerText: "메뉴", width: 180 },
            { dataField: "menu_desc", headerText: "메뉴 설명", width: 240 }
        ];
        var authRenderer = {
            type: "CheckBoxEditRenderer",
            editable: true,
            checkValue: "Y",
            unCheckValue: "N"
        };
        var assignedColumns = [
            { dataField: "menu_id", headerText: "메뉴 ID", width: 90, editable: false },
            { dataField: "menu_name", headerText: "메뉴", width: 160, editable: false },
            { dataField: "reg_auth", headerText: "등록", width: 55, renderer: authRenderer },
            { dataField: "upd_auth", headerText: "수정", width: 55, renderer: authRenderer },
            { dataField: "del_auth", headerText: "삭제", width: 55, renderer: authRenderer },
            { dataField: "exc_auth", headerText: "실행", width: 55, renderer: authRenderer },
            { dataField: "fle_auth", headerText: "파일", width: 55, renderer: authRenderer }
        ];
        var sourceProps = {
            editable: false,
            selectionMode: "multipleRows",
            usePaging: false,
            rowIdField: "menu_id"
        };
        var assignedProps = {
            editable: true,
            selectionMode: "multipleRows",
            usePaging: false,
            rowIdField: "menu_id"
        };

        ROLE000.grid_ROLE000_02 = KpackageOBJ.auiGrid.create("oAuiGrid_ROLE000_02", sourceColumns, sourceProps, "check");
        ROLE000.grid_ROLE000_03 = KpackageOBJ.auiGrid.create("oAuiGrid_ROLE000_03", assignedColumns, assignedProps, "check");
    };

    this.retrieveRoleList = function() {
        KpackageOBJ.ajax.doSubmit(
            "/origin/systemmgmt/roleMgmt/retrieveRoleList",
            {},
            ROLE000.retrieveRoleList_Handler
        );
    };

    this.retrieveRoleList_Handler = function(result) {
        var list = result.value || [];
        ROLE000.setRoleSelectOptions(list);
        AUIGrid.setGridData(ROLE000.grid_ROLE000_01, list);
        if (list.length < 1) {
            ROLE000.newRole();
            return;
        }

        var index = 0;
        if (ROLE000.selectedRoleCode) {
            var indexes = AUIGrid.getRowIndexesByValue(ROLE000.grid_ROLE000_01, "role_code", ROLE000.selectedRoleCode);
            if (indexes && indexes.length > 0) {
                index = indexes[0];
            }
        }
        AUIGrid.setSelectionByIndex(ROLE000.grid_ROLE000_01, index, 0);
        ROLE000.selectRole(list[index].role_code);
    };

    this.setRoleSelectOptions = function(list) {
        var searchValue = $("#user_search_role").val() || "";
        var applyValue = $("#user_apply_role").val() || "";
        $("#user_search_role").empty().append('<option value="">전체</option>');
        $("#user_apply_role").empty().append('<option value="">권한 해제</option>');
        $.each(list, function(index, role) {
            var option = $("<option></option>").val(role.role_code).text(role.role_name + " (" + role.role_code + ")");
            $("#user_search_role").append(option.clone());
            $("#user_apply_role").append(option.clone());
        });
        $("#user_search_role").val(searchValue);
        $("#user_apply_role").val(applyValue);
    };

    this.openUserTab = function() {
        window.setTimeout(function() {
            KpackageOBJ.auiGrid.resize(ROLE000.grid_ROLE000_04);
            ROLE000.retrieveUserRoleList();
        }, 100);
    };

    this.retrieveUserRoleList = function() {
        KpackageOBJ.ajax.doSubmit(
            "/origin/systemmgmt/roleMgmt/retrieveUserRoleList",
            {
                status: $("#user_search_status").val(),
                division_code: $.trim($("#user_search_division").val()),
                role_code: $("#user_search_role").val(),
                search_type: $("#user_search_type").val(),
                search_keyword: $.trim($("#user_search_keyword").val())
            },
            function(result) {
                AUIGrid.setGridData(ROLE000.grid_ROLE000_04, result.value || []);
            }
        );
    };

    this.saveUserRole = function() {
        var checked = AUIGrid.getCheckedRowItems(ROLE000.grid_ROLE000_04);
        if (!checked || checked.length < 1) {
            alert("권한을 적용할 사용자를 체크해 주세요.");
            return;
        }

        var users = [];
        $.each(checked, function(index, checkedRow) {
            var item = checkedRow.item || checkedRow;
            users.push({ user_id: item.user_id });
        });

        var roleCode = $("#user_apply_role").val();
        var actionName = roleCode ? "선택한 권한을 적용" : "모든 권한을 해제";
        if (!confirm("선택한 " + users.length + "명의 사용자에게 " + actionName + "하시겠습니까?")) return;

        KpackageOBJ.ajax.doSubmit(
            "/origin/systemmgmt/roleMgmt/saveUserRole",
            { role_code: roleCode, user_list: users },
            function(result) {
                alert(result.message);
                if (result.success) ROLE000.retrieveUserRoleList();
            }
        );
    };

    this.selectRole = function(roleCode) {
        if (!roleCode) return;
        ROLE000.selectedRoleCode = roleCode;
        KpackageOBJ.ajax.doSubmit(
            "/origin/systemmgmt/roleMgmt/retrieveRoleDetail",
            { role_code: roleCode },
            ROLE000.retrieveRoleDetail_Handler
        );
        ROLE000.retrieveRoleMenuList();
    };

    this.retrieveRoleDetail_Handler = function(result) {
        var data = result.value;
        if (!data) return;
        KpackageOBJ.data.setFormData("ROLE000-form", data);
        $("#role_save_type").val("U");
        $("#role_code").prop("readonly", true);
        $("#ROLE000_detail_title").text(data.role_name + " (" + data.role_code + ")");
    };

    this.retrieveRoleMenuList = function() {
        KpackageOBJ.ajax.doSubmit(
            "/origin/systemmgmt/roleMgmt/retrieveRoleMenuList",
            {
                role_code: ROLE000.selectedRoleCode,
                system_type: $("#role_menu_system_type").val()
            },
            ROLE000.retrieveRoleMenuList_Handler
        );
    };

    this.retrieveRoleMenuList_Handler = function(result) {
        var list = result.value || [];
        ROLE000.sourceData = [];
        ROLE000.assignedData = [];

        $.each(list, function(index, row) {
            if (row.assigned_yn === "Y") {
                ROLE000.assignedData.push(row);
            } else {
                ROLE000.sourceData.push(row);
            }
        });
        ROLE000.refreshMenuGrids();
    };

    this.newRole = function() {
        document.getElementById("ROLE000-form").reset();
        $("#role_save_type").val("I");
        $("#role_code").prop("readonly", false).focus();
        $("#ROLE000_detail_title").text("신규 권한");
        ROLE000.selectedRoleCode = null;
        ROLE000.sourceData = [];
        ROLE000.assignedData = [];
        ROLE000.refreshMenuGrids();
    };

    this.saveRole = function() {
        if (!$.trim($("#role_code").val()) || !$.trim($("#role_name").val())) {
            alert("권한코드와 권한명을 입력해 주세요.");
            return;
        }
        var params = KpackageOBJ.data.makePostData("ROLE000-form");
        KpackageOBJ.ajax.doSubmit("/origin/systemmgmt/roleMgmt/saveRole", params, function(result) {
            alert(result.message);
            if (!result.success) return;
            ROLE000.selectedRoleCode = result.value.role_code;
            ROLE000.retrieveRoleList();
        });
    };

    this.deleteRole = function() {
        if (!ROLE000.selectedRoleCode) {
            alert("삭제할 권한을 선택해 주세요.");
            return;
        }
        if (!confirm("선택한 권한과 연결된 메뉴·사용자 권한을 모두 삭제하시겠습니까?")) return;
        KpackageOBJ.ajax.doSubmit(
            "/origin/systemmgmt/roleMgmt/deleteRole",
            { role_code: ROLE000.selectedRoleCode },
            function(result) {
                alert(result.message);
                if (!result.success) return;
                ROLE000.selectedRoleCode = null;
                ROLE000.retrieveRoleList();
            }
        );
    };

    this.saveRoleMenu = function() {
        if (!ROLE000.selectedRoleCode) {
            alert("권한을 먼저 저장하거나 선택해 주세요.");
            return;
        }
        var menuList = AUIGrid.getGridData(ROLE000.grid_ROLE000_03);
        KpackageOBJ.ajax.doSubmit(
            "/origin/systemmgmt/roleMgmt/saveRoleMenu",
            { role_code: ROLE000.selectedRoleCode, menu_list: menuList },
            function(result) {
                alert(result.message);
                if (result.success) ROLE000.retrieveRoleMenuList();
            }
        );
    };

    this.assignSelected = function() {
        ROLE000.moveChecked(ROLE000.grid_ROLE000_02, ROLE000.sourceData, ROLE000.assignedData);
    };
    this.unassignSelected = function() {
        ROLE000.moveChecked(ROLE000.grid_ROLE000_03, ROLE000.assignedData, ROLE000.sourceData);
    };
    this.assignAll = function() {
        ROLE000.assignedData = ROLE000.assignedData.concat(ROLE000.sourceData);
        ROLE000.sourceData = [];
        ROLE000.refreshMenuGrids();
    };
    this.unassignAll = function() {
        ROLE000.sourceData = ROLE000.sourceData.concat(ROLE000.assignedData);
        ROLE000.assignedData = [];
        ROLE000.refreshMenuGrids();
    };

    this.moveChecked = function(gridId, from, to) {
        var checked = AUIGrid.getCheckedRowItems(gridId);
        if (!checked || checked.length < 1) {
            alert("이동할 메뉴를 체크해 주세요.");
            return;
        }
        var ids = {};
        $.each(checked, function(index, checkedRow) {
            var item = checkedRow.item || checkedRow;
            ids[item.menu_id] = true;
            to.push(item);
        });
        var remain = $.grep(from, function(row) { return !ids[row.menu_id]; });
        if (gridId === ROLE000.grid_ROLE000_02) {
            ROLE000.sourceData = remain;
        } else {
            ROLE000.assignedData = remain;
        }
        ROLE000.refreshMenuGrids();
    };

    this.setAllAuth = function(value) {
        var rows = AUIGrid.getGridData(ROLE000.grid_ROLE000_03);
        $.each(rows, function(index, row) {
            row.reg_auth = value;
            row.upd_auth = value;
            row.del_auth = value;
            row.exc_auth = value;
            row.fle_auth = value;
        });
        ROLE000.assignedData = rows;
        AUIGrid.setGridData(ROLE000.grid_ROLE000_03, rows);
    };

    this.refreshMenuGrids = function() {
        ROLE000.sourceData.sort(ROLE000.menuSort);
        ROLE000.assignedData.sort(ROLE000.menuSort);
        AUIGrid.setGridData(ROLE000.grid_ROLE000_02, ROLE000.sourceData);
        AUIGrid.setGridData(ROLE000.grid_ROLE000_03, ROLE000.assignedData);
    };

    this.menuSort = function(a, b) {
        var levelA = Number(a.menu_level || 0);
        var levelB = Number(b.menu_level || 0);
        if (levelA !== levelB) return levelA - levelB;
        return String(a.menu_id).localeCompare(String(b.menu_id));
    };
};

$(document).ready(function() {
    pageSetUp();
    ROLE000.Initialize_viewObject();
});
</script>
</body>
</html>