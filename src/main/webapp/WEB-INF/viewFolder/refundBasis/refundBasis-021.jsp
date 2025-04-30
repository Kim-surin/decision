<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="content">
	<div class="row">
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<ul id="chart_Tab" class="nav nav-tabs bordered">
				<li class="active">
					<a href="#importUploadLayer" data-toggle="tab" aria-expanded="true"><i class="fa fa-fw fa-lg fa-gear"></i>수입자료 업로드</a>
				</li>
			</ul>
			<div id="chart_TabContent" class="tab-content padding-10" style="background: #FFF;display: inline-block;width: 100%;height: 170px;">
				<div class="tab-pane fade active in" id="importUploadLayer">
					<form:form id="RB021-import-form" class="s4-form" novalidate="novalidate" onsubmit="return false;" enctype="multipart/form-data">
						<input type="hidden" id="WORK_TYPE" name="WORK_TYPE" value="IMP"/>
						<input type="hidden" id="CAL_IMP_UPLOAD_MONTH"  name="CAL_IMP_UPLOAD_MONTH" class="inputText has-month-picker"/>
						<table class="table table-bordered" style="margin-bottom: 10px; margin-left: 7px; width: 99%">
			                <colgroup>
			                    <col style="width: 150px;" />
			                    <col style="width:" />
			                </colgroup>
			                <tbody>
			                    <tr>
			                        <th>UpLoad 파일 선택</th>
			                        <td>
			                        	<label for="file" class="input input-file" >
											<div class="button"><input type="file" name="file1" onchange="this.parentNode.nextSibling.value = this.value">Browse</div><input type="text" id="tmpFileView" name="tmpFileView" placeholder="첨부파일을을 선택해주세요"  readonly="">
										</label>
										<div class="note">
											<strong>Note #1:</strong> 첨부파일 선택 후 반드시 실행버튼을 눌러주세요
										</div>
										<div class="note">
											<strong>Note #2:</strong> xlsx 형식의 파일만 업로드 가능합니다.
										</div>
										
			                        </td>
			                    </tr>
			                </tbody>
			            </table>
			            <div class="tuiGrid-toobar-group btn-group" style="float: right;">
                            <a title="저장" class="btn btn-primary btn-border tuiGrid-toolbar-button"  style="padding: 10px 60px;" href='javascript:RB021.doUploadProcess("IMP");' >
                            	<i class="glyphicon glyphicon-upload"></i> <span>실행</span>
                            </a>
                        </div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<ul id="chart_Tab" class="nav nav-tabs bordered">
				<li class="active">
					<a href="#exportUploadLayer" data-toggle="tab" aria-expanded="true"><i class="fa fa-fw fa-lg fa-gear"></i>수출자료 업로드</a>
				</li>
			</ul>
			<div id="chart_TabContent2" class="tab-content padding-10" style="background: #FFF;display: inline-block;width: 100%;height: 170px;">
				<div class="tab-pane fade active in" id="exportUploadLayer">
					<form:form id="RB021-export-form" class="s4-form" novalidate="novalidate" onsubmit="return false;" enctype="multipart/form-data">
						<input type="hidden" id="WORK_TYPE" name="WORK_TYPE" value="EXP"/>
						<input type="hidden" id="CAL_EXP_UPLOAD_MONTH"  name="CAL_EXP_UPLOAD_MONTH" class="inputText has-month-picker"/>
						<table class="table table-bordered" style="margin-bottom: 10px; margin-left: 7px; width: 99%">
			               <colgroup>
			                    <col style="width: 150px;" />
			                    <col style="width:" />
			                </colgroup>
			                <tbody>
			                    <tr>
			                        <th>UpLoad 파일 선택</th>
			                        <td>
			                        	<label for="file" class="input input-file" >
											<div class="button"><input type="file" name="file1" onchange="this.parentNode.nextSibling.value = this.value">Browse</div><input type="text" id="tmpFileView" name="tmpFileView" placeholder="첨부파일을을 선택해주세요"  readonly="">
										</label>
										<div class="note">
											<strong>Note #1:</strong> 첨부파일 선택 후 반드시 실행버튼을 눌러주세요
										</div>
										<div class="note">
											<strong>Note #2:</strong> xlsx 형식의 파일만 업로드 가능합니다.
										</div>
										
			                        </td>
			                    </tr>
			                </tbody>
			            </table>
			            <div class="tuiGrid-toobar-group btn-group" style="float: right;">
                            <a title="저장" class="btn btn-primary btn-border tuiGrid-toolbar-button"  style="padding: 10px 60px;" href='javascript:RB021.doUploadProcess("EXP")' >
                            	<i class="glyphicon glyphicon-upload"></i> <span>실행</span>
                            </a>
                        </div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	
</div>

<script>

	var RB021 = new function(){
		this.workType = "";
		// Page Object Initialize
		this.initialize_Object = function() {
			//KpackageOBJ.monthPicker.create("RB021-import-form", "CAL_IMP_UPLOAD_MONTH");
			//KpackageOBJ.monthPicker.create("RB021-export-form", "CAL_EXP_UPLOAD_MONTH");

		}
		
		
		<%/* 업로드전 정합성 체크*/%>
		this.retrievePreDataCheck = function(workType){
			RB021.workType = workType;
			var fakeFilePath = "";
			var workFormName = "";
			var workUrl = "";
			var workMonth ="";
			
			var extn = ""; 
			var extnArrType = ['xls', 'xlsx'];
			var fileExtnFlag = true;
			
			<%-- <%/* 업로드 월 체크 */%>
			if("IMP" == RB021.workType ){
				fakeFilePath = KpackageOBJ.object.getFormValue("RB021-import-form","file1");
				workMonth = KpackageOBJ.object.getFormValue("RB021-import-form", "CAL_IMP_UPLOAD_MONTH"); 
			}else if("EXP" == RB021.workType ){
				fakeFilePath = KpackageOBJ.object.getFormValue("RB021-export-form","file1");
				workMonth = KpackageOBJ.object.getFormValue("RB021-export-form", "CAL_EXP_UPLOAD_MONTH"); 
			}
				
			if(oUtil.isNull(workMonth)){ 
				alert("업로드 월을 입력해주세요");
				return false;
			} --%>
			
			<%/* 확장자 체크 */%>
			if(!oUtil.isNull(fakeFilePath)){ 
				extn = KpackageOBJ.object.getExtension(fakeFilePath).toLowerCase(); 
			}else{
				alert("업로드 할 파일이 없습니다.");
				return false;
			}
			
			for(var inx = 0; inx < extnArrType.length; inx++){
				if(extn == extnArrType[inx]){
					fileExtnFlag = false;
				}
			}
			
			if(fileExtnFlag){
				alert("첨부파일은 ['xls','xlsx'] 형식의 파일만 업로드 가능합니다.");
				return;
			}
			
			
			var params = { "WORK_TYPE" : workType ,"WORK_MONTH" : workMonth}; 
			//KpackageOBJ.ajax.doSubmit("/refundbasis/retrievePreDataCheck", params, RB021.retrievePreDataCheck_CallbackHandler);
			KpackageOBJ.ajax.doSubmit("/refundbasis/uploadImportExcelProcess", params, RB021.retrievePreDataCheck_CallbackHandler);
			
			
		}
		
		this.retrievePreDataCheck_CallbackHandler= function(result) {
			if(result.success){
				if("Y" == result.value){
					RB021.doUploadProcess();	
				}else{
					alert("기존에 업로드 된 데이터의 사용이 발견되었습니다. 데이터를 업로드 할 수 없습니다.");
				}
			}else{
				alert(result.message);	
			}
		}
		
		this.doUploadProcess = function(argWorkType){
		    RB021.workType = argWorkType;
		    
		    var fileYn = false;
		    var fakeFilePath = null;
		    var extn = null;
		    var extnArrType = ['xls', 'xlsx'];
			var fileExtnFlag = true;
		    
			if("IMP" == argWorkType ){
				workFormName = "RB021-import-form";
				fakeFilePath = KpackageOBJ.object.getFormValue("RB021-import-form","file1");
				workUrl = "/refundbasis/uploadImportExcelProcess";
			}else if("EXP" == argWorkType ){
				workFormName = "RB021-export-form";
				fakeFilePath = KpackageOBJ.object.getFormValue("RB021-export-form","file1");
				workUrl = "/refundbasis/uploadExportExcelProcess";
			}
		    
			<%/* 확장자 체크 */%>
			if(!oUtil.isNull(fakeFilePath)){ 
				extn = KpackageOBJ.object.getExtension(fakeFilePath).toLowerCase(); 
			}else{
				alert("업로드 할 파일이 없습니다.");
				return false;
			}
			
			
			for(var inx = 0; inx < extnArrType.length; inx++){
				if(extn == extnArrType[inx]){
					fileExtnFlag = false;
				}
			}
			
			if(fileExtnFlag){
				alert("첨부파일은 ['xls','xlsx'] 형식의 파일만 업로드 가능합니다.");
				return;
			}
		    
			
			
			KpackageOBJ.ajax.doFormSubmit(workFormName, workUrl, "RB021.doUploadProcess_CallbackHandler");
		}
		 
		this.doUploadProcess_CallbackHandler = function(result) {
			alert(result.message);
			
			if(!result.success){
			    KpackageOBJ.dialog.open("dialog_RB02101", "엑셀업로드 오류내역", "/refundBasis-02101", 1150, 780);  
			}
		};
		
	} 
	
	$(document).ready(function() {
		
		pageSetUp();				// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		RB021.initialize_Object(); 		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		 
	});

</script>
</body>
</html>