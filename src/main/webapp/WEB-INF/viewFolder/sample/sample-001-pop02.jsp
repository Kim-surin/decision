<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>


</head>
<body>
	<div class="modal-body">
		<div class="alert alert-danger m-0">드레그가능 팝업창 예시 입니다..</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" onclick="javascript:KpackageOBJ.dialog.close('previewPopup');" >Close</button>
		<button type="button" class="btn btn-primary">Save changes</button>
	</div>
</body>
<script>
	var SAMPLE001POP01 = new function() {

		// 시작점
		this.Initialize_viewObject = function() {
			
		}


		// AUIGrid 를 생성합니다.
		this.createAUIGrid = function() {
			
		};
		
		this.retrieve_GridData = function(){

		}
	};
	
	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		SAMPLE001POP01.Initialize_viewObject();
	});
</script>

</html>