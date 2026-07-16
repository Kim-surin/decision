<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
</head>
<body>
    <div class="modal-header">
        <h5 class="modal-title h4">사용자 상세정보</h5>
        <button type="button" class="btn btn-system ms-auto" data-bs-dismiss="modal" aria-label="Close">
            <svg class="sa-icon sa-icon-2x">
                <use href="/rcs/ui5x/img/sprite.svg#x"></use>
            </svg>
        </button>
    </div>

    <div class="modal-body">
        <form:form id="BASIS00101-form" class="s4-form" novalidate="novalidate" action="" method="post">
            <input type="hidden" id="dialog_id" name="dialog_id" value="${dialog_id}"/>
            <input type="hidden" id="opener_pgm_id" name="opener_pgm_id" value="${opener_pgm_id}"/>
            <input type="hidden" id="param_user_id" name="param_user_id" value="${param_user_id}"/>
            <input type="hidden" id="seq" name="seq"/>

            <div class="container-fluid">
                <div class="row g-3">
                    <!-- 사용자ID -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold" for="user_id">사용자ID</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="user_id" name="user_id"
                                   onchange="javascript:BASIS00101.resetDuplicateCheck();">
                            <button type="button" class="btn btn-outline-secondary" id="btn_check_dup"
                                    style="height: 35px;"
                                    onclick="javascript:BASIS00101.checkDuplicateUserId();">중복확인</button>
                        </div>
                        <small class="text-muted">신규 등록 시 반드시 중복확인을 하셔야 합니다.</small>
                    </div>

                    <!-- 사원번호 -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold" for="emp_no">사원번호</label>
                        <input type="text" class="form-control" id="emp_no" name="emp_no"
                               onchange="javascript:BASIS00101.changeSignaturePreview();">
                    </div>

                    <!-- 사용자명 -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold" for="name_kor">사용자명</label>
                        <input type="text" class="form-control" id="name_kor" name="name_kor">
                    </div>

                    <!-- 사용자영문명 -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold" for="name_eng">사용자영문명</label>
                        <input type="text" class="form-control" id="name_eng" name="name_eng">
                    </div>

                    <!-- 비밀번호 -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold" for="password">비밀번호</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호 입력">
                    </div>

                    <!-- 비밀번호 확인 -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold" for="password_confirm">비밀번호 확인</label>
                        <input type="password" class="form-control" id="password_confirm" name="password_confirm"
                               placeholder="비밀번호 확인"
                               onchange="javascript:BASIS00101.checkPasswordMatch();">
                    </div>

                    <!-- 부서 -->
                    <div class="col-md-4">
                        <label class="form-label fw-bold" for="dept_name">부서</label>
                        <input type="text" class="form-control" id="dept_name" name="dept_name">
                    </div>

                    <!-- 직급 -->
                    <div class="col-md-4">
                        <label class="form-label fw-bold" for="position_name">직급</label>
                        <input type="text" class="form-control" id="position_name" name="position_name">
                    </div>

                    <!-- 직급 ENG -->
                    <div class="col-md-4">
                        <label class="form-label fw-bold" for="position_name_eng">직급 ENG</label>
                        <input type="text" class="form-control" id="position_name_eng" name="position_name_eng">
                    </div>

                    <!-- E-mail -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold" for="email">E-mail</label>
                        <input type="text" class="form-control" id="email" name="email">
                    </div>

                    <!-- 사무실번호 -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold" for="office_phone_no">사무실번호</label>
                        <input type="text" class="form-control" id="office_phone_no" name="office_phone_no">
                    </div>

                    <!-- 핸드폰 번호 -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold" for="cell_phone_no">핸드폰 번호</label>
                        <input type="text" class="form-control" id="cell_phone_no" name="cell_phone_no">
                    </div>

                    <!-- 팩스번호 -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold" for="fax_no">팩스번호</label>
                        <input type="text" class="form-control" id="fax_no" name="fax_no">
                    </div>

                    <!-- 기본언어 -->
                    <div class="col-md-4">
                        <label class="form-label fw-bold" for="default_language">기본언어</label>
                        <select class="form-select" id="default_language" name="default_language">
                            <option value="KOR">KOR</option>
                            <option value="ENG">ENG</option>
                        </select>
                    </div>

                    <!-- 상태 -->
                    <div class="col-md-4">
                        <label class="form-label fw-bold" for="status">사용상태</label>
                        <select class="form-select" id="status" name="status">
                            <option value="Y">사용</option>
                            <option value="R">대기</option>
                            <option value="N">미사용</option>
                        </select>
                    </div>
                </div>

                <hr class="my-4">

                <!-- 사용자 서명정보 -->
                <div class="row g-3">
                    <div class="modal-header">
                        <h5 class="modal-title h4">사용자 서명정보</h5>
                    </div>

                    <!-- 지정일자 -->
                    <div class="col-md-4">
                        <label class="form-label fw-bold" for="start_date">지정일자</label>
                        <input type="date" class="form-control" id="start_date" name="start_date">
                    </div>

                    <!-- 해지일자 -->
                    <div class="col-md-4">
                        <label class="form-label fw-bold" for="end_Date">해지일자</label>
                        <input type="date" class="form-control" id="end_Date" name="end_Date">
                    </div>

                    <!-- 플랜트 -->
                    <div class="col-md-4">
                        <label class="form-label fw-bold" for="division_code">플랜트</label>
                        <select class="form-select" id="division_code" name="division_code">
                            <c:forEach items="${division}" var="item">
                                <option value="${item.division_code}">${item.division_name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- 해지사유 -->
                    <div class="col-md-12">
                        <label class="form-label fw-bold" for="remark">해지사유</label>
                        <textarea class="form-control" id="remark" name="remark" rows="5"></textarea>
                    </div>

                    <!-- 서명 미리보기 -->
                    <div class="col-3">
                        <label class="form-label fw-bold">서명 미리보기</label>
                        <div class="border rounded d-flex align-items-center justify-content-center bg-light" style="height: 180px;">
                            <img id="signature_preview"
                                 name="signature_preview"
                                 src=""
                                 alt="서명 미리보기"
                                 style="max-width: 100%; max-height: 160px; object-fit: contain; display: none;">
                            <span id="signature_empty" class="text-muted">등록된 서명파일이 없습니다.</span>
                        </div>
                    </div>

                    <div class="col-9">
                        <div class="row">
                            <!-- 서명파일명 -->
                            <div class="col-md-9">
                                <label class="form-label fw-bold" for="sign_file_name">서명파일명</label>
                                <input type="text" class="form-control" id="sign_file_name" name="sign_file_name" readonly>
                            </div>

                            <!-- 서명파일 변경 버튼 -->
                            <div class="col-md-3 d-flex align-items-end">
                                <button type="button" class="btn btn-outline-primary" id="toggle_sign_file_btn"
                                        onclick="javascript:BASIS00101.toggleSignFileUpload(this);">
                                    서명파일 변경
                                </button>
                            </div>

                            <!-- 파일 업로드 -->
                            <div class="col-md-12" id="file1_wrap" style="display: none;">
                                <label class="form-label fw-bold" for="file1">서명파일 업로드</label>
                                <input type="file" class="form-control" id="file1" name="file1"
                                       accept="image/*"
                                       onchange="javascript:BASIS00101.previewUploadedSignature(this);">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form:form>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="javascript:BASIS00101.saveUserSignatureInfo();">Save changes</button>
        <button type="button" class="btn btn-danger me-auto" id="btn_cancel_signature"
            style="display: none;"
            onclick="javascript:BASIS00101.cancelSignature();">
        서명권자 해지
    </button>
    </div>
</body>

<script>
var BASIS00101 = new function() {

    this.Initialize_viewObject = function() {
        var params = KpackageOBJ.data.makePostData("BASIS00101-form");

        $("#user_id").data("dup-checked", "N");

        KpackageOBJ.ajax.doSubmit("/basis/retrieveUserinfoDetail", params, (result) => {
            var data = result.value || {};

            KpackageOBJ.data.setFormData("BASIS00101-form", data);

            var isEditMode = !oUtil.isNull($("#param_user_id").val());

            if (isEditMode) {
                BASIS00101.setEditMode(data);
            } else {
                BASIS00101.setCreateMode();
            }

            if (!oUtil.isNull(data.sign_file_name)) {
                BASIS00101.retrieveSignatureInfoDetail();
            } else {
                BASIS00101.changeSignaturePreview();
                BASIS00101.hideCancelSignatureButton();
            }
        });
    };

    this.showCancelSignatureButton = function() {
        $("#btn_cancel_signature").show();
    };

    this.hideCancelSignatureButton = function() {
        $("#btn_cancel_signature").hide();
    };
    
    
    this.cancelSignature = function() {
        var empNo = $("#emp_no").val().trim();
        var endDate = $("#end_Date").val().trim();
        var remark = $("#remark").val().trim();
        var signSeq = $("#seq").val();

        if (oUtil.isNull(signSeq) && oUtil.isNull($("#sign_file_name").val().trim())) {
            alert("해지할 서명권자 정보가 없습니다.");
            return;
        }

        if (oUtil.isNull(empNo)) {
            alert("사원번호 정보가 없습니다.");
            return;
        }

        if (oUtil.isNull(endDate)) {
            alert("해지일자를 입력해주세요.");
            $("#end_Date").focus();
            return;
        }

        if (oUtil.isNull(remark)) {
            alert("해지사유를 입력해주세요.");
            $("#remark").focus();
            return;
        }

        if (!confirm("서명권자 해지를 진행하시겠습니까?")) {
            return;
        }

        var params = KpackageOBJ.data.makePostData("BASIS00101-form");
        
        KpackageOBJ.ajax.doSubmit("/basis/cancelUserSignatureInfo", params, (result) => {
            var data = result.value || {};

            if(result.success){
            	alert("서명권자 해지가 완료되었습니다.");	
            	

                $("#sign_file_name").val("");
                $("#file1").val("");
                $("#file1_wrap").hide();
                $("#toggle_sign_file_btn").text("서명파일 변경");

                $("#signature_preview").attr("src", "").hide();
                $("#signature_empty").show();

                $("#seq").val("");

                BASIS00101.hideCancelSignatureButton();
                
            }else{
            	alert("서명권자 해지 중 오류가 발생했습니다.");
            }
            
        });
    };
    
    
    this.createAUIGrid = function() {
    };

    this.retrieve_GridData = function() {
    };

    this.setEditMode = function(data) {
        $("#user_id").prop("readonly", true);
        $("#emp_no").prop("readonly", true);
        $("#btn_check_dup").hide();

        $("#password").attr("placeholder", "변경 시에만 입력");
        $("#password_confirm").attr("placeholder", "변경 시에만 입력");

        $("#user_id").data("dup-checked", "Y");

        BASIS00101.changeSignaturePreview();
    };

    this.setCreateMode = function() {
        $("#user_id").prop("readonly", false);
        $("#emp_no").prop("readonly", false);
        $("#btn_check_dup").show();

        $("#password").attr("placeholder", "비밀번호 입력");
        $("#password_confirm").attr("placeholder", "비밀번호 확인");

        $("#user_id").data("dup-checked", "N");

        $("#signature_preview").attr("src", "").hide();
        $("#signature_empty").show();
    };

    this.retrieveSignatureInfoDetail = function() {
        var params = KpackageOBJ.data.makePostData("BASIS00101-form");

        KpackageOBJ.ajax.doSubmit("/basis/retrieveSignatureInfo", params, (result) => {
            var data = result.value || {};
            KpackageOBJ.data.setFormData("BASIS00101-form", data);

            if (!oUtil.isNull($("#emp_no").val())) {
                BASIS00101.changeSignaturePreview();
            }
        });
    };

    this.saveUserSignatureInfo = function() {
        var $form = $("#BASIS00101-form");
        var paramUserId = $("#param_user_id").val();
        var isEditMode = !oUtil.isNull(paramUserId);

        var userId = $("#user_id").val().trim();
        var empNo = $("#emp_no").val().trim();
        var nameKor = $("#name_kor").val().trim();
        var nameEng = $("#name_eng").val().trim();
        var deptName = $("#dept_name").val().trim();
        var positionName = $("#position_name").val().trim();
        var password = $("#password").val();
        var passwordConfirm = $("#password_confirm").val();
        var signFile = $("#file1")[0] ? $("#file1")[0].files[0] : null;

        if (!isEditMode && $("#user_id").data("dup-checked") !== "Y") {
            alert("사용자ID 중복확인을 해주세요.");
            return;
        }

        if (oUtil.isNull(userId)) {
            alert("사용자ID를 입력해주세요.");
            $("#user_id").focus();
            return;
        }

        if (oUtil.isNull(empNo)) {
            alert("사원번호를 입력해주세요.");
            $("#emp_no").focus();
            return;
        }

        if (oUtil.isNull(nameKor)) {
            alert("사용자명을 입력해주세요.");
            $("#name_kor").focus();
            return;
        }

        if (oUtil.isNull(nameEng)) {
            alert("사용자영문명을 입력해주세요.");
            $("#name_eng").focus();
            return;
        }

        if (oUtil.isNull(deptName)) {
            alert("부서를 입력해주세요.");
            $("#dept_name").focus();
            return;
        }

        if (oUtil.isNull(positionName)) {
            alert("직급을 입력해주세요.");
            $("#position_name").focus();
            return;
        }

        if (!isEditMode) {
            if (oUtil.isNull(password)) {
                alert("비밀번호를 입력해주세요.");
                $("#password").focus();
                return;
            }

            if (oUtil.isNull(passwordConfirm)) {
                alert("비밀번호 확인을 입력해주세요.");
                $("#password_confirm").focus();
                return;
            }
        }

        if (!oUtil.isNull(password) || !oUtil.isNull(passwordConfirm)) {
            if (password !== passwordConfirm) {
                alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
                $("#password_confirm").focus();
                return;
            }
        }

        if (signFile) {
            var fileType = signFile.type ? signFile.type.toLowerCase() : "";
            if (fileType.indexOf("image/") !== 0) {
                alert("이미지 파일만 업로드 가능합니다.");
                $("#file1").val("");
                return;
            }
        }

        var formData = new FormData($form[0]);

        $.ajax({
            url: "/basis/saveUserSignatureInfo",
            type: "POST",
            data: formData,
            processData: false,
            contentType: false,
            success: function(result) {
                alert("저장되었습니다.");

                $("#user_id").prop("readonly", true);
                $("#emp_no").prop("readonly", true);
                $("#btn_check_dup").hide();
                $("#user_id").data("dup-checked", "Y");

                BASIS00101.changeSignaturePreview();
            },
            error: function() {
                alert("저장 중 오류가 발생했습니다.");
            }
        });
    };

    this.checkDuplicateUserId = function() {
        var userId = $("#user_id").val().trim();

        if ($("#user_id").prop("readonly")) {
            return;
        }

        if (oUtil.isNull(userId)) {
            alert("사용자ID를 입력해주세요.");
            $("#user_id").focus();
            return;
        }

        $.ajax({
            url: "/basis/checkDuplicateUserId",
            type: "POST",
            data: { user_id: userId },
            success: function(result) {
                if (result.duplicateYn === "Y") {
                    alert("이미 사용중인 사용자ID입니다.");
                    $("#user_id").data("dup-checked", "N");
                    $("#user_id").focus();
                } else {
                    alert("사용 가능한 사용자ID입니다.");
                    $("#user_id").data("dup-checked", "Y");
                }
            },
            error: function() {
                alert("중복확인 중 오류가 발생했습니다.");
            }
        });
    };

    this.resetDuplicateCheck = function() {
        if (!$("#user_id").prop("readonly")) {
            $("#user_id").data("dup-checked", "N");
        }
    };

    this.checkPasswordMatch = function() {
        var password = $("#password").val();
        var passwordConfirm = $("#password_confirm").val();

        if (!oUtil.isNull(passwordConfirm) && password !== passwordConfirm) {
            alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            $("#password_confirm").focus();
            return false;
        }

        return true;
    };

    this.getSignatureImageUrl = function(empNo) {
        return "/basis/signature/" + empNo;
    };

    this.changeSignaturePreview = function() {
        const empNo = $("#emp_no").val().trim();
        const $img = $("#signature_preview");
        const $empty = $("#signature_empty");

        if (empNo === "") {
            $img.attr("src", "").hide();
            $empty.show();
            return;
        }

        const imageUrl = BASIS00101.getSignatureImageUrl(empNo);

        $img.off("error").on("error", function() {
            $img.attr("src", "").hide();
            $empty.show();
        });

        $img.attr("src", imageUrl).show();
        $empty.hide();
    };

    this.previewUploadedSignature = function(input) {
        const file = input.files[0];
        const $img = $("#signature_preview");
        const $empty = $("#signature_empty");

        if (!file) {
            BASIS00101.restoreOriginalSignaturePreview();
            return;
        }

        if (!file.type || file.type.toLowerCase().indexOf("image/") !== 0) {
            alert("이미지 파일만 업로드 가능합니다.");
            $("#file1").val("");
            BASIS00101.restoreOriginalSignaturePreview();
            return;
        }

        const reader = new FileReader();
        reader.onload = function(e) {
            $img.attr("src", e.target.result).show();
            $empty.hide();
        };
        reader.readAsDataURL(file);

        $("#sign_file_name").val(file.name);
    };

    this.restoreOriginalSignaturePreview = function() {
        const empNo = $("#emp_no").val().trim();
        const $img = $("#signature_preview");
        const $empty = $("#signature_empty");

        if (empNo === "") {
            $img.attr("src", "").hide();
            $empty.show();
            return;
        }

        const imageUrl = BASIS00101.getSignatureImageUrl(empNo);

        $img.off("error").on("error", function() {
            $img.attr("src", "").hide();
            $empty.show();
        });

        $img.attr("src", imageUrl).show();
        $empty.hide();
    };

    this.toggleSignFileUpload = function(button) {
        const $uploadWrap = $("#file1_wrap");
        const $signFileUpload = $("#file1");
        const $button = $(button);

        if ($uploadWrap.is(":visible")) {
            $uploadWrap.hide();
            $button.text("서명파일 변경");
            $signFileUpload.val("");
            BASIS00101.restoreOriginalSignaturePreview();
        } else {
            $uploadWrap.show();
            $button.text("서명파일 변경 취소");
        }
    };
};

$(document).ready(function() {
    pageSetUp();
    BASIS00101.Initialize_viewObject();
});
</script>
</html>