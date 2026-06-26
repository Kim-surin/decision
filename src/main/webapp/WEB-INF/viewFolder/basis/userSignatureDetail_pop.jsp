<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
			<input type="hidden" id="dialog_id"     name="dialog_id" value="${dialog_id}"/>
			<input type="hidden" id="opener_pgm_id" name="opener_pgm_id" value="${opener_pgm_id}"/>
			<input type="hidden" id="param_user_id" name="param_user_id" value="${param_user_id}"/>
			<div class="container-fluid">
		        <div class="row g-3">
		            <!-- 사용자ID -->
		            <div class="col-md-6">
		                <label class="form-label fw-bold">사용자ID</label>
		                <div class="input-group">
		                    <input type="text" class="form-control" id="user_id" name="user_id" >
		                    <button type="button" class="btn btn-outline-secondary" id="btn_check_dup" style="height: 35px;">중복확인</button>
		                </div>
		                <small class="text-muted">반드시 중복체크를 하셔야 합니다.</small>
		            </div>
		
		            <!-- 사원번호 -->
		            <div class="col-md-6">
		                <label class="form-label fw-bold">사원번호</label>
		                <input type="text" class="form-control" id="emp_no" name="emp_no" >
		            </div>
		
		            <!-- 사용자명 -->
		            <div class="col-md-6">
		                <label class="form-label fw-bold">사용자명</label>
		                <input type="text" class="form-control" id="name_kor" name="name_kor" >
		            </div>
		
		            <!-- 사용자명(영문) -->
		            <div class="col-md-6">
		                <label class="form-label fw-bold">사용자명(영문)</label>
		                <input type="text" class="form-control" id="name_eng" name="name_eng" >
		            </div>
		
		            <!-- 비밀번호 -->
		            <div class="col-md-6">
		                <label class="form-label fw-bold">비밀번호</label>
		                <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호 입력">
		            </div>
		
		            <!-- 비밀번호 확인 -->
		            <div class="col-md-6">
		                <label class="form-label fw-bold">비밀번호 확인</label>
		                <input type="password" class="form-control" id="password_confirm" name="password_confirm" placeholder="비밀번호 확인">
		            </div>
		
		            <!-- 부서 -->
		            <div class="col-md-4">
		                <label class="form-label fw-bold">부서</label>
		                <input type="text" class="form-control" id="dept_name" name="dept_name" >
		            </div>
		
		            <!-- 직급 -->
		            <div class="col-md-4">
		                <label class="form-label fw-bold">직급</label>
		                <input type="text" class="form-control" id="position_name" name="position_name" >
		            </div>
		
		            <!-- 직급 ENG -->
		            <div class="col-md-4">
		                <label class="form-label fw-bold">직급 ENG</label>
		                <input type="text" class="form-control" id="position_name_eng" name="position_name_eng" >
		            </div>
		
		            <!-- E-mail -->
		            <div class="col-md-6">
		                <label class="form-label fw-bold">E-mail</label>
		                <input type="text" class="form-control" id="email" name="email" >
		            </div>
		
		            <!-- 사무실번호 -->
		            <div class="col-md-6">
		                <label class="form-label fw-bold">사무실번호</label>
		                <input type="text" class="form-control" id="office_phone_no" name="office_phone_no" >
		            </div>
		
		            <!-- 핸드폰 번호 -->
		            <div class="col-md-6">
		                <label class="form-label fw-bold">핸드폰 번호</label>
		                <input type="text" class="form-control" id="cell_phone_no" name="cell_phone_no" >
		            </div>
		
		            <!-- 팩스번호 -->
		            <div class="col-md-6">
		                <label class="form-label fw-bold">팩스번호</label>
		                <input type="text" class="form-control" id="fax_no" name="fax_no" >
		            </div>
		
		            <!-- 기본언어 -->
		            <div class="col-md-4">
					    <label class="form-label fw-bold">기본언어</label>
					    <select class="form-select" id="default_language" name="default_language">
					        <option value="KOR">KOR</option>
					        <option value="ENG">ENG</option>
					    </select>
					</div>
		
		            <!-- 상태 -->
		            <div class="col-md-4">
					    <label class="form-label fw-bold">사용상태</label>
					    <select class="form-select" id="status" name="status">
					        <option value="Y">사용</option>
					        <option value="R">대기</option>
					        <option value="N">미사용</option>
					    </select>
					</div>
		        </div>
		
		        <hr class="my-4">
		
		        <!-- 서명 파일 영역 -->
		        <div class="row g-3">
		            <div class="col-12">
		                <h6 class="fw-bold mb-3">서명파일 정보</h6>
		            </div>
		
		            <!-- 서명파일명 -->
		            <div class="col-md-6">
		                <label class="form-label fw-bold">서명파일명</label>
		                <input type="text" class="form-control" id="sign_file_name" name="sign_file_name" >
		            </div>
		
		            <!-- 파일 업로드 -->
		            <div class="col-md-6">
		                <label class="form-label fw-bold">서명파일 업로드</label>
		                <input type="file" class="form-control" id="sign_file_upload" name="sign_file_upload" accept="image/*">
		            </div>
		
		            <!-- 서명 미리보기 -->
		            <div class="col-12">
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
		        </div>
		    </div>
		</form:form>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
		<button type="button" class="btn btn-primary">Save changes</button>
	</div>
</body>
<script>
	var BASIS00101 = new function() {

		// 시작점
		this.Initialize_viewObject = function() {
			var params = {
					"dummy" : "dummy"
			};
			
			KpackageOBJ.ajax.doSubmit("/basis/retrieveUserinfoDetail", params, (result) => {
			    var data = result.value
			    KpackageOBJ.data.setFormData("BASIS00101-form", data);
			});
		}
		
		
		// AUIGrid 를 생성합니다.
		this.createAUIGrid = function() {
			
		};
		
		this.retrieve_GridData = function(){

		}
	};
	
	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		BASIS00101.Initialize_viewObject();
	});
</script>

</html>