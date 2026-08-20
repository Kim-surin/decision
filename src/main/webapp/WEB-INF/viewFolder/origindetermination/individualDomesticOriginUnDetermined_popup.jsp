<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>


</head>
<body>
	<div class="modal-header">
		<h5 class="modal-title h4">팝업페이지 테스트</h5>
		<button type="button" class="btn btn-system ms-auto" data-bs-dismiss="modal" aria-label="Close">
			<svg class="sa-icon sa-icon-2x">
                      <use href="/rcs/ui5x/img/sprite.svg#x"></use>
                  </svg>
		</button>
	</div>
	<div class="modal-body">
		<div class="alert alert-danger m-0">우측 팝업창 예시 입니다..</div>
		<div class="frame-wrap">
		    <div class="demo" style="text-align: right;">
		    	<button type="button" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="javascript:KpackageOBJ.dialog.open('previewPopup','우측 팝업 후 가운데 팝업','/sample-001-pop02',1000,700,false);">
		            가운데 팝업창(드래그 가능)
		        </button>
		    </div>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
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