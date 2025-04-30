<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <!-- chartJS -->
	<script type="text/javascript" src="/rcs/js/plugin/moment/moment.min.js"></script>
	<script type="text/javascript" src="/rcs/js/plugin/chartjs/chart.min.2_7_2.js"></script>
	
    <style>

		.panel{
		    display: -webkit-box;
		    display: -ms-flexbox;
		    display: flex;
		    -webkit-box-orient: vertical;
		    -webkit-box-direction: normal;
		    -ms-flex-direction: column;
		    flex-direction: column;
		    position: relative;
		    background-color: #fff;
		    -webkit-box-shadow: 0px 0px 13px 0px rgba(62, 44, 90, 0.08);
		    box-shadow: 0px 0px 13px 0px rgba(62, 44, 90, 0.08);
		    margin-bottom: 1.5rem;
		    border-radius: 4px;
		    border: 1px solid rgba(0, 0, 0, 0.09);
		    border-bottom: 1px solid #e0e0e0;
		    border-radius: 4px;
		    -webkit-transition: border 500ms ease-out;
		    transition: border 500ms ease-out;
		    }
    </style>
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form:form id="R012-form" class="s4-form" novalidate="novalidate" action="/report-012" method="post">
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;" />
								<col style="width: 430px;" />
								<col style="width: 110px;" />
								<col style="width: 430px;" />
								<col style="width: 100px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='제품' /></th>
									<td>   
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:100px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:100px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" style="width:130px" searchfnc="R012.retrieve_R012List"/>
									</td>    	
                                	<th><spring:message code='수출신고번호' /></th>
									<td colspan="3">
										<select class="form-control searchSelect" id="SEARCH_TYPE_NO" name="SEARCH_TYPE_NO" style="width:100px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION_NO" name="SEARCH_OPTION_NO" style="width:100px"></select>
										<input type="text" id="SEARCH_KEY_WORD_NO" name="SEARCH_KEY_WORD_NO" class="inputText" style="width:130px" searchfnc="R012.retrieve_R012List"/>
									</td>
                                </tr>    
								<tr>
									<th><spring:message code='수리일자' /></th>
									<td>
										<input type="text" id="CAL_SEARCH_FROM_DATE"  name="CAL_SEARCH_FROM_DATE" style="width:120px" class="inputText" searchfnc="R012.retrieve_R012List"/>
										<input type="hidden" id="SEARCH_FROM_DATE"  name="SEARCH_FROM_DATE" style="width:120px" class="inputText"/>
										<span class="fromTo-Dash">~</span>
										<input type="text" id="CAL_SEARCH_TO_DATE"  name="CAL_SEARCH_TO_DATE" style="width:120px" class="inputText" searchfnc="R012.retrieve_R012List"/>
										<input type="hidden" id="SEARCH_TO_DATE"  name="SEARCH_TO_DATE" style="width:120px" class="inputText"/>
									</td>	
									
									<th><spring:message code='제조자' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE_MAKER" name="SEARCH_TYPE_MAKER" style="width:100px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION_MAKER" name="SEARCH_OPTION_MAKER" style="width:100px"></select>
										<input type="text" id="SEARCH_KEY_WORD_MAKER" name="SEARCH_KEY_WORD_MAKER" class="inputText" style="width:130px" searchfnc="R012.retrieve_R012List"/>
									</td>
									<th><spring:message code='환급신청인' /></th>
									<td>
										<select class="form-control searchSelect" id="RQST_PRSN_CODE" name="RQST_PRSN_CODE" style="width:110px"></select>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:R012.retrieve_R012List();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			</div>
		</form:form>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="div_oTui_R012_List" name="div_oTui_R012_List" class="tuigrid-resizable">
					<div id="oTui_R012_List" data-minus-height="650"></div>
					<div id="oTui_R012_List_paging"></div>
				</div>
			</div>
		</div>
		
		<div class="row">
		   <div class="col-lg-12 sortable-grid ui-sortable">
            	<div class="col-sm-4">
            		<div class="jarviswidget panel" id="wid-id-Noti" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false" data-widget-custombutton="false">
				        <header class="dashboaard_wgt_header panel-hdr">
		                    <h2>수출금액</h2>    
		                </header>
						<div class="ExportAmount_Rate_PieChartdiv">
							<canvas id="ExportAmount_Rate_PieChart" height="200" data-rate-flag="true"></canvas>
						</div>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="jarviswidget panel" id="wid-id-Noti" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false" data-widget-custombutton="false">
						<header class="dashboaard_wgt_header panel-hdr">
		                    <h2>수출건수 </h2>    
		                </header>
						<div class="ExportQty_Rate_PieChartdiv">
							<canvas id="ExportQty_Rate_PieChart" height="200" data-rate-flag="true"></canvas>
						</div>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="jarviswidget panel" id="wid-id-Noti" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false" data-widget-custombutton="false">
						<header class="dashboaard_wgt_header panel-hdr">
		                    <h2>환급금액</h2>    
		                </header>
						<div class="DrwbAmount_Rate_PieChartdiv">
							<canvas id="DrwbAmount_Drwbak_Rate_PieChart" height="200" data-rate-flag="true"></canvas>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	</section>

</div>

<script>
	
	var R012 = new function(){
		var oPieChart_ExportAmount, oPieChart_ExportQty, oPieChart_DrwbAmount;
		var chartColor = ['#00338d','#005eb8','#0091da','#483698','#470a68','#85468d','#00a3a1','#009a44','#43b02a','#eaaa00','#f68d2e',
			'#c2345b','#e36877','#00338d','#0091da','#6d2077','#005eb8','#00a3a1','#eaaa00','#43b02a','#c6007e','#753f19',
			'#9b642e','#9d9375','#e3bc9f','#e36877'];
		

		Chart.plugins.register({
			afterDatasetsDraw: function(chart) {
				var ctx = chart.ctx;

				chart.data.datasets.forEach(function(dataset, i) {
					var meta = chart.getDatasetMeta(i);
					if (!meta.hidden) {
						
						meta.data.forEach(function(element, index) {

							
							if(meta.type=="bar"){
								ctx.fillStyle = 'rgb(0, 0, 0)';
								var fontSize = 12;
								var fontStyle = 'normal';
								var fontFamily = 'Arial';
								ctx.font = Chart.helpers.fontString(fontSize, fontStyle, fontFamily);

								var dataString;
								if(typeof(dataset.data[index]) == "number"){
									dataString = KpackageOBJ.formatter.commas(dataset.data[index].toString());	
								}else{
									dataString = dataset.data[index];
								}
								
								
								ctx.textAlign = 'center';
								ctx.textBaseline = 'middle';

								var padding = 5;
								var position = element.tooltipPosition();
								
								if($(element._chart.canvas).data("rateFlag")){
	                                dataString = dataString + "%";
	                            }
								ctx.fillText(dataString, position.x, position.y - (fontSize / 2) - padding);
								
							}else{
								ctx.fillStyle = '#f8f8f8';
								var fontSize = 15;
								var fontStyle = 'bold';
								var fontFamily = 'Arial';
								ctx.font = Chart.helpers.fontString(fontSize, fontStyle, fontFamily);

								var dataString = KpackageOBJ.formatter.commas(dataset.data[index].toString());

								ctx.textAlign = 'center';
								ctx.textBaseline = 'middle';

								var padding = -1;
								var position = element.tooltipPosition();
								if($(element._chart.canvas).data("rateFlag")){
	                                dataString = dataString + "%";
	                            }
								ctx.fillText(dataString, position.x, position.y - (fontSize / 2) + padding);
							}
							
						});
					}
				});
			}
		});

		
		this.Initialize_viewObject = function() {
	
			/*Search Type Select Box Create */
			arrayItem = [{value:"ITEM_CODE", name:"<spring:message code='제품코드'/>"}
						];
			
			KpackageOBJ.selectbox.create("R012-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			arrayItem = [{value:"EXPDECL_MANAGE_NO", name:"<spring:message code='수출신고번호'/>"}
						];
			
			KpackageOBJ.selectbox.create("R012-form", "SEARCH_TYPE_NO", "", null, "value", "name", arrayItem);

			arrayItem = [{value:"MANUFAC_NAME", name:"<spring:message code='제조자'/>"}
			];

			KpackageOBJ.selectbox.create("R012-form", "SEARCH_TYPE_MAKER", "", null, "value", "name", arrayItem);
	
			KpackageOBJ.selectbox.create("R012-form", "RQST_PRSN_CODE", "/common/retrieveComCdList", {"CATEGORY_CD":"RQST","OPTION_ALL":"Y"}, "CODE", "NAME");

			
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			            ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("R012-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			KpackageOBJ.selectbox.create("R012-form", "SEARCH_OPTION_NO", "", null, "value", "name", arrayItem);
			KpackageOBJ.selectbox.create("R012-form", "SEARCH_OPTION_MAKER", "", null, "value", "name", arrayItem);

			/* Create Calender*/
			var fromDay = KpackageOBJ.date.getCurrMonth() + "01";
			var toDay = KpackageOBJ.date.getCurrMonth() + KpackageOBJ.date.lastDay(KpackageOBJ.date.getCurrMonth());
			
			KpackageOBJ.calendar.create("R012-form", "CAL_SEARCH_FROM_DATE");
			KpackageOBJ.calendar.setValue("R012-form","CAL_SEARCH_FROM_DATE", fromDay);
			KpackageOBJ.object.setFormValue("R012-form","SEARCH_FROM_DATE", fromDay);
			
			KpackageOBJ.calendar.create("R012-form", "CAL_SEARCH_TO_DATE");
			KpackageOBJ.calendar.setValue("R012-form","CAL_SEARCH_TO_DATE", toDay);
			KpackageOBJ.object.setFormValue("R012-form","SEARCH_TO_DATE",toDay);
			
			R012.renderTuiGrid();
		}
		
		this.renderTuiGrid = function() {
			 
			 var colArrayInfo = [
				 	{ header : "구분"				, name: "GUBUN"						, width : 60 , align: "center"   , resizable: true, hidden:false},
			        { header : "수출신고번호"			, name: "EXPDECL_MANAGE_NO"			, width : 150, align: "left"     , resizable: true, hidden:false},
			        { header : "란"				, name: "LNE_NO"					, width : 80 , align: "center"   , resizable: true, hidden:false},
			        { header : "행"				, name: "POUCH_NO"					, width : 80 , align: "center"   , resizable: true, hidden:false},
			        { header : "제조자"				, name: "MANUFAC_NAME"				, width : 200, align: "left"     , resizable: true, hidden:false},
			        { header : "환급신청인"			, name: "RQST_PRSN_NAME"			, width : 100, align: "center"   , resizable: true, hidden:false},
				    { header : "수리일자"			, name: "DSPTH_DATE"				, width : 120, align: "center"   , resizable: true, hidden:false},
			        { header : "HS_CODE"			, name: "HS_CODE"					, width : 120, align: "center"   , resizable: true, hidden:false},
			        { header : "제품코드"			, name: "ITEM_CODE"					, width : 120, align: "center"   , resizable: true, hidden:false},
			        { header : "품명"				, name: "ITEM_NM"					, width : 250, align: "left"     , resizable: true, hidden:false},
			        { header : "수량(단위)"			, name: "ITEM_QTY"					, width : 120, align: "right"    , resizable: true, hidden:false},
			        { header : "금액"				, name: "ITEM_AMOUNT"				, width : 150, align: "right"    , resizable: true, hidden:false, formatter: KpackageOBJ.tuiGrid.commas},
			        { header : "환급금액"			, name: "DRWBACK_AMOUNT"			, width : 150, align: "right"    , resizable: true, hidden:false, formatter: KpackageOBJ.tuiGrid.commas}
				  ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_R012_List", "/report/retrieve_R012List", colArrayInfo, "number", null);
			 KpackageOBJ.tuiGrid.setCaption("oTui_R012_List","<spring:message code='제조자 or 환급신청인 기재오류'/>");
		}
		
		this.retrieve_R012List = function() {
			
			var param = { "SEARCH_FROM_DATE" : KpackageOBJ.object.getFormValue("R012-form","SEARCH_FROM_DATE")
					 	, "SEARCH_TO_DATE" : KpackageOBJ.object.getFormValue("R012-form", "SEARCH_TO_DATE")
			         	, "SEARCH_TYPE" : KpackageOBJ.object.getFormValue("R012-form","SEARCH_TYPE")
			         	, "SEARCH_OPTION" : KpackageOBJ.object.getFormValue("R012-form","SEARCH_OPTION")
			         	, "SEARCH_KEY_WORD" : KpackageOBJ.object.getFormValue("R012-form","SEARCH_KEY_WORD")
			         	, "SEARCH_TYPE_NO" : KpackageOBJ.object.getFormValue("R012-form","SEARCH_TYPE_NO")
			         	, "SEARCH_OPTION_NO" : KpackageOBJ.object.getFormValue("R012-form","SEARCH_OPTION_NO")
			         	, "SEARCH_KEY_WORD_NO" : KpackageOBJ.object.getFormValue("R012-form","SEARCH_KEY_WORD_NO")
			        
			         	, "SEARCH_TYPE_MAKER" : KpackageOBJ.object.getFormValue("R012-form","SEARCH_TYPE_MAKER")
			         	, "SEARCH_OPTION_MAKER" : KpackageOBJ.object.getFormValue("R012-form","SEARCH_OPTION_MAKER")
			         	, "SEARCH_KEY_WORD_MAKER" : KpackageOBJ.object.getFormValue("R012-form","SEARCH_KEY_WORD_MAKER")
			         	, "RQST_PRSN_CODE" : KpackageOBJ.object.getFormValue("R012-form","RQST_PRSN_CODE")
			         	         	
			};
			
			KpackageOBJ.tuiGrid.retrieve("oTui_R012_List", "/report/retrieve_R012List", param);
		
			R012.CreateChart();
		}
		
		this.CreateChart = function() {
			//R012.retrieveErrorByExportAmountRatePieChart();
			
			$.when(R012.retrieveErrorByExportAmountRatePieChart())
				.done($.when(R012.retrieveErrorByExportQtyRatePieChart()))
					.done($.when(R012.retrieveErrorByDrwbAmountRatePieChart()));
			
		}
		
		/**************************************************************************************
		수출금액 Chart
		**************************************************************************************/
		
		this.retrieveErrorByExportAmountRatePieChart = function() {
			if(oPieChart_ExportAmount != undefined){
				oPieChart_ExportAmount.destroy();	
			}
			
			var postData = KpackageOBJ.data.makePostData("R012-form");
			postData["LABEL_ID"] = "retrieveErrorByExportAmountRatePieChart";
			
			KpackageOBJ.ajax.doSubmit("/report/retrieveErrorByExportAmountRatePieChart", postData, R012.drawExportAmountRatePieChart, null, false);
			
		}
		
		
		this.drawExportAmountRatePieChart = function(result){
			var data = result.value;
			var labelData = [], 
				labelCodeData = [],
			    rateData = [],
			    tooltipData = [],
			    sumData = 0;
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					labelData.push(data[i]["LABEL_NAME"]);
					labelCodeData.push(data[i]["LABEL_VALUE"]);
					rateData.push(data[i]["RATE_VALUE"]);
					tooltipData.push(data[i]["DATA_VALUE"]);
				}
			}
			
			
			pieData = {
	            labels: labelData,
	            datasets: [{
	                //label: '',
	                data: rateData,
	                code_data: labelCodeData,
	                tooptip_data : tooltipData,
	                backgroundColor: KpackageOBJ.pieChart.chartColor03
	            }]
			};		
			
			var pieChartId = $('.ExportAmount_Rate_PieChartdiv').find('canvas').prop('id');
			debugger;
			oPieChart_ExportAmount = new Chart(document.getElementById(pieChartId),{
				type: 'doughnut',
				data: pieData,
				options: {
					responsive: true,
	                title: {
						display: true,
						text: '제조자 또는 환급신청인 오류 건 수출금액 /총 수출금액 * 100',
						fontSize: 12,
						padding: 5
					},
					legend: {
						display: true, 
						position: 'bottom',
						reverse: true
			        },
			        layout: {
			        	padding: {
			        		bottom : 10
			        	}
			        },
			        tooltips: {
		                enabled: true,
		                mode: 'single',
		                callbacks: {
		                    label: function(tooltipItems, data) { 
		                    	 return data.labels[tooltipItems.index] + ' : ' + KpackageOBJ.formatter.commas(data.datasets[tooltipItems.datasetIndex].tooptip_data[tooltipItems.index]);
		                    }
		                }
		            }
			        
				}
			});
		}
		
		/**************************************************************************************
		수출수량 Chart
		**************************************************************************************/
		this.retrieveErrorByExportQtyRatePieChart = function() {
			if(oPieChart_ExportQty != undefined){
				oPieChart_ExportQty.destroy();	
			}
			
			var postData = KpackageOBJ.data.makePostData("R012-form");
			postData["LABEL_ID"] = "retrieveErrorByExportQtyRatePieChart";
			
			KpackageOBJ.ajax.doSubmit("/report/retrieveErrorByExportQtyRatePieChart", postData, R012.drawExportQtyRatePieChart, null, false);
			
		}
		

		this.drawExportQtyRatePieChart = function(result){
			var data = result.value;
			var labelData = [], 
				labelCodeData = [],
			    rateData = [],
			    tooltipData = [],
			    sumData = 0;
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					labelData.push(data[i]["LABEL_NAME"]);
					labelCodeData.push(data[i]["LABEL_VALUE"]);
					rateData.push(data[i]["RATE_VALUE"]);
					tooltipData.push(data[i]["DATA_VALUE"]);
				}
			}
			
			
			pieData = {
	            labels: labelData,
	            datasets: [{
	                //label: '',
	                data: rateData,
	                code_data: labelCodeData,
	                tooptip_data : tooltipData,
	                backgroundColor: KpackageOBJ.pieChart.chartColor03
	            }]
			};		
			
			var pieChartId = $('.ExportQty_Rate_PieChartdiv').find('canvas').prop('id');
			
			oPieChart_ExportQty = new Chart(document.getElementById(pieChartId),{
				type: 'doughnut',
				data: pieData,
				options: {
					responsive: true,
	                title: {
						display: true,
						text: '제조자 또는 환급신청인 오류 건 수출건수 /총 수출건수 * 100',
						fontSize: 12,
						padding: 5
					},
					legend: {
						display: true, 
						position: 'bottom',
						reverse: true
			        },
			        layout: {
			        	padding: {
			        		bottom : 10
			        	}
			        },
			        tooltips: {
		                enabled: true,
		                mode: 'single',
		                callbacks: {
		                    label: function(tooltipItems, data) { 
		                    	 return data.labels[tooltipItems.index] + ' : ' + KpackageOBJ.formatter.commas(data.datasets[tooltipItems.datasetIndex].tooptip_data[tooltipItems.index]);
		                    }
		                }
		            }
			        
				}
			});
		}
	
	

		/**************************************************************************************
		환급금액 Chart
		**************************************************************************************/
		this.retrieveErrorByDrwbAmountRatePieChart = function() {
			if(oPieChart_DrwbAmount != undefined){
				oPieChart_DrwbAmount.destroy();	
			}
			
			var postData = KpackageOBJ.data.makePostData("R012-form");
			postData["LABEL_ID"] = "retrieveErrorByDrwbAmountRatePieChart";
			
			KpackageOBJ.ajax.doSubmit("/report/retrieveErrorByDrwbAmountRatePieChart", postData, R012.drawDrwbAmountRatePieChart, null, false);
			
		}
		

		this.drawDrwbAmountRatePieChart = function(result){
			var data = result.value;
			var labelData = [], 
				labelCodeData = [],
			    rateData = [],
			    tooltipData = [],
			    sumData = 0;
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					labelData.push(data[i]["LABEL_NAME"]);
					labelCodeData.push(data[i]["LABEL_VALUE"]);
					rateData.push(data[i]["RATE_VALUE"]);
					tooltipData.push(data[i]["DATA_VALUE"]);
				}
			}
			
			
			pieData = {
	            labels: labelData,
	            datasets: [{
	                //label: '',
	                data: rateData,
	                code_data: labelCodeData,
	                tooptip_data : tooltipData,
	                backgroundColor: KpackageOBJ.pieChart.chartColor03
	            }]
			};		
			
			var pieChartId = $('.DrwbAmount_Rate_PieChartdiv').find('canvas').prop('id');
			
			oPieChart_DrwbAmount = new Chart(document.getElementById(pieChartId),{
				type: 'doughnut',
				data: pieData,
				options: {
					responsive: true,
	                title: {
						display: true,
						text: '제조자 또는 환급신청인 오류 건 환급금액 /총 환급금액 * 100',
						fontSize: 12,
						padding: 5
					},
					legend: {
						display: true, 
						position: 'bottom',
						reverse: true
			        },
			        layout: {
			        	padding: {
			        		bottom : 10
			        	}
			        },
			        tooltips: {
		                enabled: true,
		                mode: 'single',
		                callbacks: {
		                    label: function(tooltipItems, data) { 
		                    	 return data.labels[tooltipItems.index] + ' : ' + KpackageOBJ.formatter.commas(data.datasets[tooltipItems.datasetIndex].tooptip_data[tooltipItems.index]);
		                    }
		                }
		            }
			        
				}
			});
		}
	}
	
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		R012.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});
</script>
</body>
</html>