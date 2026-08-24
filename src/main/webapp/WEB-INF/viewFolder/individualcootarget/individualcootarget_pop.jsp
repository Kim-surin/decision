<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

</head>
<body>

	<div class="content-wrapper">

	    <div class="row">
	    	<form:form id="individualCootargetPop-form" class="s4-form" novalidate="novalidate" action="" method="post">

	    		<input type="hidden" id="individualPopup_company_code" name="company_code" value="${sessionScope._sessionUser.company_code}">
				<input type="hidden" id="individualPopup_orderNo" name="orderNo" value="${param.orderNo}">
				<input type="hidden" id="individualPopup_orderSeq" name="orderSeq" value="${param.orderSeq}">
				<input type="hidden" id="individualPopup_vendorCode" name="vendorCode" value="${param.vendorCode}">
				<input type="hidden" id="individualPopup_divisionCode" name="divisionCode" value="${param.divisionCode}">
				<input type="hidden" id="individualPopup_userId" value="${sessionScope._sessionUser.user_id}">
				<input type="hidden" id="individualPopup_cooCertifyNoParam" value="${param.cooCertifyNo}">

		    	<div id="individualPopup_panel" class="panel panel-icon">

				    <div class="panel-container show">
				        <div class="panel-content" style="padding:20px 32px;">

				            <div style="display:flex; align-items:center; width:100%;">

							    <div style="display:flex; align-items:center; width:50%;">

							        <label class="form-label" for="individualPopup_cooCertifyNo" style="width:125px; margin:0;">
							        	원산지증명번호
							        </label>

							        <input class="form-control" id="individualPopup_cooCertifyNo" name="cooCertifyNo" type="text" style="width:200px;">

									<button type="button" id="individualPopup_duplicateBtn" class="btn btn-sm btn-secondary"
										onclick="IndividualCootargetPopup.checkDuplicate();"
										style="margin-left:6px; white-space:nowrap;">
										중복확인
									</button>

							        <label style="display:flex; align-items:center; margin:0 0 0 8px; white-space:nowrap;">
							            <input id="individualPopup_autoCreate" name="autoCreate" type="checkbox" style="margin-right:6px;">
							            자동생성
							        </label>

							    </div>

							    <div style="display:flex; align-items:center; width:50%;">

							        <label class="form-label" for="individualPopup_issueDate" style="width:125px; margin:0;">
							        	증명일자
							        </label>

							        <input class="form-control" id="individualPopup_issueDate" type="date"
							        	value="<%= java.time.LocalDate.now() %>"
							        	style="width:140px;">

							    </div>

							</div>

							<br>

					            <div style="display:flex; align-items:center; width:100%;">
								    <div style="display:flex; align-items:center; width:50%;">
								        <label class="form-label" style="width:120px; margin:0;">파일첨부</label>
								        <div style="display:flex; align-items:center; gap:8px;">
								            <input id="individualPopup_FILEUP" name="FILEUP" type="file" multiple style="display:none;" onchange="IndividualCootargetPopup.changeFileName(this);">
								            <button type="button" class="btn btn-sm btn-outline-primary" onclick="$('#individualPopup_FILEUP').click();" style="height:32px; min-width:90px;">파일 선택</button>
								            <input id="individualPopup_FILEUP_NAME" type="text" class="form-control" placeholder="선택된 파일 없음" readonly style="width:280px; height:32px; background:#fff;">
								        </div>
								        
								    </div>
								    
								</div>
								<div id="individualPopup_existingFiles" style="margin:0 0 0 31%;"></div>
							    <div style="display:flex; align-items:center; width:50%;">

							        <label class="form-label" style="width:125px; margin:25px 0 0 0 ;">
							        	증명서타입
							        </label>

							        <label style="display:flex; align-items:center; margin:25px 0 0 0 ; white-space:nowrap;">
							            개별
							        </label>

							    </div>

							</div>

				        </div>
				    </div>

				</div>

			</form:form>
	    </div>


	    <div class="row">

	    	<div class="col-7">

				<div class="frame-wrap">

				    <div class="demo" style="display:inline-flex; align-items:center; margin-left:10px;">

					    <span style="font-size:13px; color:#666; margin-right:10px;">총 건수</span>

					    <span id="individualPopup_totalCount"
					    	style="font-size:16px; font-weight:700; color:#333;">
					    	0
					    </span>

					    <span style="font-size:13px; color:#666; margin-left:3px;">건</span>

					</div>

				</div>

	    	</div>

	    	<div class="col-5">

			    <div class="frame-wrap">

			        <div class="demo" style="display:flex; justify-content:flex-end; align-items:center; gap:3px;">

			            <button type="button"
			            	class="btn btn-sm btn-secondary waves-effect waves-themed"
			            	onclick="IndividualCootargetPopup.excelDownload();"
			            	style="width:110px; color:#fff; background-color:#526d82; border:1px solid #526d82;">
			            	ExcelDown
			            </button>

			        	<button type="button" id="individualPopup_saveBtn" class="btn btn-sm btn-secondary waves-effect waves-themed" onclick="IndividualCootargetPopup.save();" style="width:110px; color:#fff; background-color:#526d82; border:1px solid #526d82;">증명서 등록</button>

			        </div>

			    </div>

			</div>

	    </div>


		<div class="row">

	   		<div class="col-12">

		        <div id="oAuiGrid_individualCootargetPopup_01"
		        	style="width:100%; height:480px; margin:0 auto;">
		        </div>

		    </div>

	    </div>

	</div>

</body>


<script>

var IndividualCootargetPopup = new function() {

	this.ruleData = [];
	this.nationCodeData = [];

	this.grid_IndividualCootargetPopup_01 = null;

	/* 수동입력 증명번호 중복확인 여부 */
	this.duplicateChecked = false;


	this.Initialize_viewObject = function() {

		IndividualCootargetPopup.createAUIGrid();
		IndividualCootargetPopup.bindEvents();

	};


	this.bindEvents = function() {

		/* 증명번호 직접 수정 시 중복확인 다시 필요 */
		$("#individualPopup_cooCertifyNo").on("input", function() {
			IndividualCootargetPopup.duplicateChecked = false;
		});


		/* 자동생성 체크 */
		$("#individualPopup_autoCreate").on("change", function() {

			var autoCreate = $(this).is(":checked");

			IndividualCootargetPopup.duplicateChecked = false;

			if (autoCreate) {

				$("#individualPopup_cooCertifyNo")
					.val("")
					.prop("readonly", true);

				$("#individualPopup_duplicateBtn")
					.prop("disabled", true);

			} else {

				$("#individualPopup_cooCertifyNo")
					.val("")
					.prop("readonly", false);

				$("#individualPopup_duplicateBtn")
					.prop("disabled", false);

			}

		});

	};


	this.createAUIGrid = function() {

		const columnLayout = [

			{
				dataField:"WAREHOUSING_NO",
				headerText:"입고번호",
				width:120,
				filter:{showIcon:false},
				style:"aui-center-align",
				cellMerge:true,
				editable:false
			},

			{
				dataField:"WAREHOUSING_DATE",
				headerText:"입고일자",
				width:120,
				filter:{showIcon:false},
				style:"aui-center-align",
				cellMerge:true,
				editable:false
			},

			{
				dataField:"ITEM_CODE",
				headerText:"자재코드",
				width:120,
				filter:{showIcon:true},
				style:"aui-center-align",
				cellMerge:true,
				editable:false
			},

			{
				dataField:"ITEM_SPEC",
				headerText:"자재내역",
				width:180,
				filter:{showIcon:true},
				style:"aui-left-align",
				cellMerge:true,
				editable:false
			},

			{
				dataField:"HS_CODE",
				headerText:"HsCode",
				width:100,
				filter:{showIcon:false},
				style:"aui-center-align",
				cellMerge:true,
				editable:false
			},

			{
				dataField:"FTA_NAME",
				headerText:"FTA명",
				width:120,
				filter:{showIcon:true},
				style:"aui-center-align",
				editable:false
			},

			{
				dataField:"FTA_CODE",
				headerText:"FTA_CODE",
				visible:false
			},

			{
				dataField:"WAREHOUSING_SEQ",
				headerText:"WAREHOUSING_SEQ",
				visible:false
			},

			{
				dataField:"ORDER_NO",
				headerText:"ORDER_NO",
				visible:false
			},

			{
				dataField:"ORDER_SEQ",
				headerText:"ORDER_SEQ",
				visible:false
			},

			{
				dataField:"PARAM_DIVISION_CODE",
				headerText:"PARAM_DIVISION_CODE",
				visible:false
			},

			{
				dataField:"COO_YN",
				headerText:"COO_YN",
				visible:false
			},

			{
				dataField:"COO_NATION",
				headerText:"COO_NATION",
				visible:false
			},

			{
				dataField:"COO_YN_NM",
				headerText:"충족여부",
				width:100,
				style:"aui-center-align",
				editRenderer:{
					type:"DropDownListRenderer",
					showEditorBtnOver:true,
					list:["충족", "불충족"]
				}
			},

			{
				dataField:"RULE_CODE",
				headerText:"결정기준",
				width:150,
				style:"aui-center-align",
				editRenderer:{
					type:"DropDownListRenderer",
					showEditorBtnOver:true,

					listFunction:function(rowIndex, columnIndex, item, dataField) {

						return IndividualCootargetPopup.ruleData
							.filter(function(r) {
								return r.FTA_CODE == item.FTA_CODE
									&& r.HS_CODE == item.HS_CODE;
							})
							.map(function(r) {
								return r.COMP_RULE;
							});

					}
				}
			},

			{
				dataField:"RVC_RATE",
				headerText:"부가가치비율",
				width:100,
				style:"aui-center-align"
			},

			{
				dataField:"COO_NATION_NM",
				headerText:"국가",
				width:120,
				style:"aui-center-align",

				editRenderer:{
					type:"DropDownListRenderer",
					showEditorBtnOver:true,

					listFunction:function() {

						return IndividualCootargetPopup.nationCodeData.map(function(r) {
							return r.CODE_NAME;
						});

					}
				}
			}

		];


		const gridProps = {
			editable:true,
			usePaging:true,
			pageRowCount:10,
			showPageRowSelect:true,
			enableFilter:true,
			enableCellMerge:true,
			rowIdField:"ROW_ID"
		};


		IndividualCootargetPopup.grid_IndividualCootargetPopup_01 =
			KpackageOBJ.auiGrid.create(
				"oAuiGrid_individualCootargetPopup_01",
				columnLayout,
				gridProps,
				"check"
			);


		AUIGrid.bind(
			IndividualCootargetPopup.grid_IndividualCootargetPopup_01,
			"cellEditEnd",
			function(event) {


				/* 결정기준 변경 */
				if (event.dataField == "RULE_CODE") {

					var rule = IndividualCootargetPopup.ruleData.find(function(r) {

						return r.FTA_CODE == event.item.FTA_CODE
							&& r.HS_CODE == event.item.HS_CODE
							&& r.COMP_RULE == event.value;

					});


					if (rule) {

						AUIGrid.updateRow(
							IndividualCootargetPopup.grid_IndividualCootargetPopup_01,
							{
								RVC_RATE:rule.RVC_RATE
							},
							event.rowIndex
						);

					}

				}


				/* 충족여부 변경 */
				if (event.dataField == "COO_YN_NM") {

					if (event.value == "충족") {

						AUIGrid.updateRow(
							IndividualCootargetPopup.grid_IndividualCootargetPopup_01,
							{
								COO_YN:"Y",
								COO_NATION:"KR",
								COO_NATION_NM:"대한민국"
							},
							event.rowIndex
						);

					} else {

						AUIGrid.updateRow(
							IndividualCootargetPopup.grid_IndividualCootargetPopup_01,
							{
								COO_YN:"N",
								COO_NATION:"ZZ",
								COO_NATION_NM:"비역내"
							},
							event.rowIndex
						);

					}

				}


				/* 국가 변경 */
				if (event.dataField == "COO_NATION_NM") {

					var nation = IndividualCootargetPopup.nationCodeData.find(function(r) {

						return r.CODE_NAME == event.value;

					});


					if (nation) {

						AUIGrid.updateRow(
							IndividualCootargetPopup.grid_IndividualCootargetPopup_01,
							{
								COO_NATION:nation.CODE
							},
							event.rowIndex
						);

					}

				}

			}
		);
		
		AUIGrid.bind(
			    IndividualCootargetPopup.grid_IndividualCootargetPopup_01,
			    "rowCheckClick",
			    function(event) {

			        var gridId = IndividualCootargetPopup.grid_IndividualCootargetPopup_01;

			        var warehousingNo = event.item.WAREHOUSING_NO;
			        var warehousingSeq = event.item.WAREHOUSING_SEQ;

			        var gridData = AUIGrid.getGridData(gridId);

			        var rowIds = [];

			        gridData.forEach(function(item) {

			            if (
			                String(item.WAREHOUSING_NO) === String(warehousingNo)
			                && String(item.WAREHOUSING_SEQ) === String(warehousingSeq)
			            ) {
			                rowIds.push(item.ROW_ID);
			            }

			        });

			        if (event.checked) {

			            AUIGrid.addCheckedRowsByIds(
			                gridId,
			                rowIds
			            );

			        } else {

			            AUIGrid.addUncheckedRowsByIds(
			                gridId,
			                rowIds
			            );
			        }
			    }
			);
		
		

	};


	this.retrieve_GridData = function() {

		var params = {

			COMPANY_CODE:$("#individualPopup_company_code").val(),

			PARAM_ORDER_NO:$("#individualPopup_orderNo").val(),
			PARAM_ORDER_SEQ:$("#individualPopup_orderSeq").val(),

			PARAM_VENDOR_CODE:$("#individualPopup_vendorCode").val(),
			PARAM_DIVISION_CODE:$("#individualPopup_divisionCode").val(),
			COO_CERTIFY_NO:$("#individualPopup_cooCertifyNoParam").val()

		};


		$.ajax({

			url:"/individual/retrieveIndividualCootargetPopup",
			type:"POST",
			contentType:"application/json",
			dataType:"json",

			data:JSON.stringify(params),


			success:function(res) {

			    if (typeof res === "string") {
			        res = JSON.parse(res);
			    }

			    var gridData = res.value || [];

			    AUIGrid.setGridData(
			        IndividualCootargetPopup.grid_IndividualCootargetPopup_01,
			        gridData
			    );

			    $("#individualPopup_totalCount").text(gridData.length);

			    var isRegistered = $("#individualPopup_cooCertifyNoParam").val() != "";

			    if (isRegistered) {

			        if (gridData.length > 0) {

			            var firstRow = gridData[0];

			            $("#individualPopup_cooCertifyNo").val(firstRow.COO_CERTIFY_NO);
			            $("#individualPopup_issueDate").val(firstRow.ISSUE_DATE);

			            IndividualCootargetPopup.retrieveExistingFiles();
			            IndividualCootargetPopup.setReadOnlyMode();
			        }

			        AUIGrid.setAllCheckedRows(
			            IndividualCootargetPopup.grid_IndividualCootargetPopup_01,
			            false
			        );

			    } else {

			        /* 신규 등록일 때만 결정기준 기본값 조회 */
			        IndividualCootargetPopup.retrieveRuleData(gridData);
			    }

			    /* 원산지 국가코드는 신규/기등록 둘 다 필요 */
			    IndividualCootargetPopup.retrieveNationCodeData();
			},


			error:function() {

				alert("증명서 등록대상 조회 중 오류가 발생했습니다.");

			}

		});

	};
	
	this.setReadOnlyMode = function() {

	    /* 증명번호 */
	    $("#individualPopup_cooCertifyNo").prop("readonly", true);

	    /* 발행일 */
	    $("#individualPopup_issueDate").prop("readonly", true);
	    $("#individualPopup_issueDate").prop("disabled", true);

	    /* 자동생성 */
	    $("#individualPopup_autoCreate").prop("disabled", true);

	    /* 중복확인 */
	    $("#individualPopup_duplicateBtn").prop("disabled", true).hide();

	    /* 파일 선택 */
	    $("#individualPopup_FILEUP").prop("disabled", true);

	    /* 저장 버튼 */
	    $("#individualPopup_saveBtn").hide();

	    /* 그리드 편집 금지 */
	    AUIGrid.setProp(
	        IndividualCootargetPopup.grid_IndividualCootargetPopup_01,
	        "editable",
	        false
	    );
	};


	this.retrieveRuleData = function(gridData) {

		var hsCodeArray = [];


		gridData.forEach(function(item) {

			if (item.HS_CODE && hsCodeArray.indexOf(item.HS_CODE) === -1) {

				hsCodeArray.push(item.HS_CODE);

			}

		});


		var hsCodes = hsCodeArray.join(",");


		if (!hsCodes) {

			IndividualCootargetPopup.ruleData = [];
			return;

		}


		$.ajax({

			url:"/individual/retrieveIndividualCootargetRule",
			type:"POST",
			contentType:"application/json",
			dataType:"json",

			data:JSON.stringify({
				hsCodes:hsCodes
			}),


			success:function(res) {

				if (typeof res === "string") {
					res = JSON.parse(res);
				}


				IndividualCootargetPopup.ruleData = res.value || [];


				var rows = AUIGrid.getGridData(
					IndividualCootargetPopup.grid_IndividualCootargetPopup_01
				);


				rows.forEach(function(item, index) {

					var rule = IndividualCootargetPopup.ruleData.find(function(r) {

						return r.FTA_CODE == item.FTA_CODE
							&& r.HS_CODE == item.HS_CODE;

					});


					if (rule) {

						AUIGrid.updateRow(
							IndividualCootargetPopup.grid_IndividualCootargetPopup_01,
							{
								RULE_CODE:rule.COMP_RULE,
								RVC_RATE:rule.RVC_RATE
							},
							index
						);

					}

				});


				AUIGrid.refresh(
					IndividualCootargetPopup.grid_IndividualCootargetPopup_01
				);

			}

		});

	};


	this.retrieveNationCodeData = function() {

		$.ajax({

			url:"/individual/retrieveIndividualCootargetNationCode",
			type:"POST",
			contentType:"application/json",
			dataType:"json",

			data:JSON.stringify({
				COMPANY_CODE:$("#individualPopup_company_code").val()
			}),


			success:function(res) {

				if (typeof res === "string") {
					res = JSON.parse(res);
				}


				IndividualCootargetPopup.nationCodeData = res.value || [];


				AUIGrid.refresh(
					IndividualCootargetPopup.grid_IndividualCootargetPopup_01
				);

			}

		});

	};


	this.excelDownload = function() {

		const exportProps = {

			fileName:"증명서등록_팝업",
			sheetName:"증명서등록",

			exportWithStyle:true,
			progressBar:true,
			showRowNumColumn:false

		};


		AUIGrid.exportToXlsx(
			IndividualCootargetPopup.grid_IndividualCootargetPopup_01,
			exportProps
		);

	};


	this.checkDuplicate = function() {

		var cooCertifyNo = $.trim(
			$("#individualPopup_cooCertifyNo").val()
		);


		if (!cooCertifyNo) {

			alert("원산지증명번호를 입력해주세요.");
			return;

		}


		$.ajax({

			url:"/individual/checkIndividualCootargetDuplicate",
			type:"POST",
			contentType:"application/json",
			dataType:"json",

			data:JSON.stringify({

				COMPANY_CODE:
					$("#individualPopup_company_code").val(),

				PARAM_DIVISION_CODE:
					$("#individualPopup_divisionCode").val(),

				PARAM_VENDOR_CODE:
					$("#individualPopup_vendorCode").val(),

				COO_CERTIFY_NO:
					cooCertifyNo

			}),


			success:function(res) {

				if (typeof res === "string") {
					res = JSON.parse(res);
				}


				var duplicate = res.value;


				if (duplicate > 0) {

					IndividualCootargetPopup.duplicateChecked = false;

					alert("이미 등록된 원산지증명번호입니다.");

				} else {

					IndividualCootargetPopup.duplicateChecked = true;

					alert("사용 가능한 원산지증명번호입니다.");

				}

			},


			error:function() {

				IndividualCootargetPopup.duplicateChecked = false;

				alert("중복확인 중 오류가 발생했습니다.");

			}

		});

	};


	this.save = function() {

	    var isRegistered = $("#individualPopup_cooCertifyNoParam").val() != "";

	    if (isRegistered) {
	        alert("이미 등록된 증명서입니다.");
	        return;
	    }

	    var checkedRows = AUIGrid.getCheckedRowItems(
	        IndividualCootargetPopup.grid_IndividualCootargetPopup_01
	    );

	    if (!checkedRows || checkedRows.length == 0) {
	        alert("등록할 자재를 선택해주세요.");
	        return;
	    }

	    var gridData = checkedRows.map(function(row) {
	        return row.item;
	    });

	    var autoCreate =
	        $("#individualPopup_autoCreate").is(":checked");

	    var cooCertifyNo =
	        $.trim($("#individualPopup_cooCertifyNo").val());

	    var issueDate =
	        $("#individualPopup_issueDate").val();

	    if (!issueDate) {
	        alert("증명일자를 입력해주세요.");
	        return;
	    }

	    if (!autoCreate && !cooCertifyNo) {
	        alert("원산지증명번호를 입력해주세요.");
	        return;
	    }

	    if (!autoCreate &&
	        !IndividualCootargetPopup.duplicateChecked) {

	        alert("원산지증명번호 중복확인을 해주세요.");
	        return;
	    }

	    var files =
	        $("#individualPopup_FILEUP")[0].files;

	    if (!files || files.length == 0) {
	        alert("파일을 첨부해주세요.");
	        return;
	    }

	    for (var i = 0; i < gridData.length; i++) {

	        if (!gridData[i].COO_YN_NM) {
	            alert("충족여부를 선택해주세요.");
	            return;
	        }

	        if (!gridData[i].RULE_CODE) {
	            alert("결정기준을 선택해주세요.");
	            return;
	        }

	        if (!gridData[i].COO_NATION_NM) {
	            alert("국가를 선택해주세요.");
	            return;
	        }
	    }

	    var param = {
	        COMPANY_CODE:$("#individualPopup_company_code").val(),
	        PARAM_DIVISION_CODE:$("#individualPopup_divisionCode").val(),
	        PARAM_VENDOR_CODE:$("#individualPopup_vendorCode").val(),
	        COO_CERTIFY_NO:cooCertifyNo,
	        AUTO_COO_CERTIFY_NO:autoCreate ? "true" : "false",
	        COO_CERTIFY_TYPE:"N",
	        ISSUE_DATE:issueDate.replace(/-/g, ""),
	        SUBMIT_STATUS:4,
	        SUBMIT_TYPE:"A",
	        INPUT_TYPE:"I",
	        DOCUMENT_TYPE:"F",
	        APPLY_TYPE:"A",
	        USER_ID:$("#individualPopup_userId").val(),
	        gridData:gridData
	    };

	    var formData = new FormData();

	    formData.append(
	        "data",
	        new Blob(
	            [JSON.stringify(param)],
	            {type:"application/json"}
	        )
	    );

	    for (var fileIndex = 0; fileIndex < files.length; fileIndex++) {
	        formData.append(
	            "FILEUP",
	            files[fileIndex]
	        );
	    }

	    $.ajax({
	        url:"/individual/insertExtCooCertify",
	        type:"POST",
	        data:formData,
	        processData:false,
	        contentType:false,
	        success:function(res) {

	            if (typeof res === "string") {
	                res = JSON.parse(res);
	            }

	            if (res.success) {

	                alert("정상적으로 등록되었습니다.");

	                individualCootargetList.retrieve_GridData();

	                KpackageOBJ.dialog.close("previewPopup");

	            } else {

	                alert(
	                    res.message ||
	                    "등록 중 오류가 발생했습니다."
	                );
	            }
	        },
	        error:function() {
	            alert("등록 중 오류가 발생했습니다.");
	        }
	    });
	};
	
	
	
	this.downloadExistingFile = function(fileSeq) {

	    var params = {
	        COMPANY_CODE:$("#individualPopup_company_code").val(),
	        PARAM_DIVISION_CODE:$("#individualPopup_divisionCode").val(),
	        PARAM_VENDOR_CODE:$("#individualPopup_vendorCode").val(),
	        COO_CERTIFY_NO:$("#individualPopup_cooCertifyNoParam").val(),
	        FILE_SEQ:fileSeq
	    };

	    window.location.href =
	        "/individual/extCooCertifyFileDownLoad?" + $.param(params);
	};
	
	
	this.retrieveExistingFiles = function() {

	    $.ajax({
	        url:"/individual/retrieveIndividualCootargetFileList",
	        type:"POST",
	        contentType:"application/json",
	        dataType:"json",
	        data:JSON.stringify({
	            COMPANY_CODE:$("#individualPopup_company_code").val(),
	            PARAM_DIVISION_CODE:$("#individualPopup_divisionCode").val(),
	            PARAM_VENDOR_CODE:$("#individualPopup_vendorCode").val(),
	            COO_CERTIFY_NO:$("#individualPopup_cooCertifyNoParam").val()
	        }),
	        success:function(res) {

	            if (typeof res === "string") {
	                res = JSON.parse(res);
	            }

	            var fileList = res.value || [];
	            var $fileList = $("#individualPopup_existingFiles");

	            $fileList.empty();

	            if (fileList.length == 0) {
	                return;
	            }

	            fileList.forEach(function(file) {

	                var fileName =
	                    file.ORIGIN_FILE_NAME ||
	                    file.FILE_NAME ||
	                    "";

	                var $row = $("<div>")
	                    .css({
	                        display:"flex",
	                        alignItems:"center",
	                        gap:"8px",
	                        marginTop:"4px"
	                    });

	                var $downloadButton = $("<button>")
	                    .attr("type", "button")
	                    .addClass("btn btn-link")
	                    .css({
	                        padding:"0",
	                        margin:"0",
	                        fontSize:"13px",
	                        color:"#0d6efd",
	                        textDecoration:"underline",
	                        cursor:"pointer"
	                    })
	                    .text(fileName)
	                    .on("click", function() {
	                        IndividualCootargetPopup.downloadExistingFile(
	                            file.FILE_SEQ
	                        );
	                    });

	                var $deleteButton = $("<button>")
	                    .attr("type", "button")
	                    .addClass("btn btn-sm btn-outline-danger")
	                    .css({
	                        padding:"2px 7px",
	                        fontSize:"11px"
	                    })
	                    .text("삭제")
	                    .on("click", function() {
	                        IndividualCootargetPopup.deleteExistingFile(
	                            file.FILE_SEQ,
	                            fileName
	                        );
	                    });

	                $row.append($downloadButton);
	                $row.append($deleteButton);

	                $fileList.append($row);
	            });
	        }
	    });
	};
	
	this.deleteExistingFile = function(fileSeq, fileName) {

	    if (!confirm("'" + fileName + "' 파일을 삭제하시겠습니까?")) {
	        return;
	    }

	    var params = {
	        COMPANY_CODE:$("#individualPopup_company_code").val(),
	        PARAM_DIVISION_CODE:$("#individualPopup_divisionCode").val(),
	        PARAM_VENDOR_CODE:$("#individualPopup_vendorCode").val(),
	        COO_CERTIFY_NO:$("#individualPopup_cooCertifyNoParam").val(),
	        FILE_SEQ:fileSeq
	    };

	    $.ajax({
	        url:"/individual/deleteExtCooCertifyFile",
	        type:"POST",
	        contentType:"application/json",
	        dataType:"json",
	        data:JSON.stringify(params),
	        success:function(res) {

	            if (typeof res === "string") {
	                res = JSON.parse(res);
	            }

	            if (res.success) {

	                alert("첨부파일이 삭제되었습니다.");

	                IndividualCootargetPopup.retrieveExistingFiles();

	            } else {

	                alert(
	                    res.message ||
	                    "첨부파일 삭제 중 오류가 발생했습니다."
	                );
	            }
	        },
	        error:function() {
	            alert("첨부파일 삭제 중 오류가 발생했습니다.");
	        }
	    });
	};

	this.changeFileName = function(obj) {

	    if (!obj.files || obj.files.length == 0) {
	        $("#individualPopup_FILEUP_NAME").val("");
	        return;
	    }

	    var fileNames = [];

	    for (var i = 0; i < obj.files.length; i++) {
	        fileNames.push(obj.files[i].name);
	    }

	    $("#individualPopup_FILEUP_NAME").val(
	        fileNames.join(", ")
	    );
	};

};


$(document).ready(function() {

	pageSetUp();

	IndividualCootargetPopup.Initialize_viewObject();

	IndividualCootargetPopup.retrieve_GridData();

});

</script>

</html>