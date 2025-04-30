<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- chartJS -->
<script type="text/javascript" src="/rcs/js/plugin/moment/moment.min.js"></script>
<script type="text/javascript"
	src="/rcs/js/plugin/chartjs/chart.min.2_7_2.js"></script>


</head>
<body>
	<div id="content">
		<section id="widget-grid-RPT008" class="">
			<form:form id="RPT008-form" class="s4-form" novalidate="novalidate"
				action="/report-RPT008" method="post">
				<div class="row-extends row">
					<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
						<div class="table-responsive">
							<table class="table table-bordered">
								<colgroup>
									<col style="width: 80px;" />
									<col style="width: 25%;" />
									<col style="width: 80px;" />
									<col style="width:" />
								</colgroup>
								<tbody>
									<tr>
										<th><spring:message code='기준일자' /></th>
										<td><input type="text" id="CAL_SEARCH_FROM_DATE"
											name="CAL_SEARCH_FROM_DATE" style="width: 120px"
											class="inputText" searchfnc="RPT008.retrieve_RPT008List" /> <span
											class="fromTo-Dash">~</span> <input type="text"
											id="CAL_SEARCH_TO_DATE" name="CAL_SEARCH_TO_DATE"
											style="width: 120px" class="inputText"
											searchfnc="RPT008.retrieve_RPT008List" /> <input
											type="hidden" id="SEARCH_FROM_DATE" name="SEARCH_FROM_DATE" />
											<input type="hidden" id="SEARCH_TO_DATE"
											name="SEARCH_TO_DATE" /></td>
										<th><spring:message code='common.title.searchCondition' /></th>
										<td><select class="form-control searchSelect"
											id="SEARCH_TYPE" name="SEARCH_TYPE" style="width: 110px"></select>
											<select class="form-control searchSelect" id="SEARCH_OPTION"
											name="SEARCH_OPTION" style="width: 110px"></select> <input
											type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD"
											class="inputText" searchfnc="RPT008.retrieve_RPT008List" /></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
						<div class="input-group-btn">
							<button
								class="btn btn-default btn-primary btn-custom-search search-row-1"
								type="button" onclick="javascript:RPT008.retrieve_RPT008List();">
								<i class="fa fa-search"></i>
								<spring:message code='TXT.ENG_SEARCH' />
							</button>
						</div>
					</div>

				</div>
			</form:form>

			<div class="row">

				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<ul id="chart_Tab" class="nav nav-tabs bordered">
						<li class="active"><a href="#chart_01" data-toggle="tab"
							aria-expanded="true">거래처</a></li>
						<li class=""><a href="#chart_02" data-toggle="tab"
							aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>제품코드</a>
						</li>
						<li class=""><a href="#chart_03" data-toggle="tab"
							aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>HS
								Code</a></li>
						<li class=""><a href="#chart_04" data-toggle="tab"
							aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>목적국</a>
						</li>

						<li class="" style="display: none"><a href="#chart_05"
							data-toggle="tab" aria-expanded="false"><i
								class="fa fa-fw fa-lg fa-gear"></i>기납증/분증 수취비율</a></li>

						<li class="" style="display: none"><a href="#chart_06"
							data-toggle="tab" aria-expanded="false"><i
								class="fa fa-fw fa-lg fa-gear"></i>기납증/분증 발급비율</a></li>
					</ul>
					<div id="chart_TabContent" class="tab-content padding-10"
						style="background: #FFF; display: inline-block; width: 100%; height: 375px;">
						<%// 거래처별 차트  %>
						<div class="tab-pane fade active in" id="chart_01">
							<div class="col-sm-4">
								<div class="vendor_Drwbak_Rate_PieChartdiv">
									<canvas id="vendor_Drwbak_Rate_PieChart" height="200"
										data-rate-flag="true"></canvas>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="vendor_Used_Rate_BarChartdiv">
									<canvas id="vendor_Used_Rate_BarChart" height="200"
										data-rate-flag="true"></canvas>
								</div>
							</div>

							<div class="col-sm-4">
								<div class="vendor_Tax_By_DrwBak_Rate_BarChartdiv">
									<canvas id="vendor_Tax_By_DrwBak_Rate_BarChart" height="200"
										data-rate-flag="true"></canvas>
								</div>
							</div>

						</div>
						<%// 제품코드 차트  %>
						<div class="tab-pane fade" id="chart_02">
							<div class="col-sm-4">
								<div class="itemCode_Drwbak_Rate_PieChartdiv">
									<canvas id="itemCode_Drwbak_Rate_PieChart" height="200"
										data-rate-flag="true"></canvas>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="itemCode_Used_Rate_BarChartdiv">
									<canvas id="itemCode_Used_Rate_BarChart" height="200"
										data-rate-flag="true"></canvas>
								</div>
							</div>

							<div class="col-sm-4">
								<div class="itemCode_Tax_By_DrwBak_Rate_BarChartdiv">
									<canvas id="itemCode_Tax_By_DrwBak_Rate_BarChart" height="200"
										data-rate-flag="true"></canvas>
								</div>
							</div>

						</div>
						<%// Hs Code 차트  %>
						<div class="tab-pane fade" id="chart_03">
							<div class="col-sm-4">
								<div class="hsCode_Drwbak_Rate_PieChartdiv">
									<canvas id="hsCode_Drwbak_Rate_PieChart" height="200"
										data-rate-flag="true"></canvas>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="hsCode_Used_Rate_BarChartdiv">
									<canvas id="hsCode_Used_Rate_BarChart" height="200"
										data-rate-flag="true"></canvas>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="hsCode_Tax_By_DrwBak_Rate_BarChartdiv">
									<canvas id="hsCode_Tax_By_DrwBak_Rate_BarChart" height="200"
										data-rate-flag="true"></canvas>
								</div>
							</div>
						</div>
						<%// 목적국 차트  %>
						<div class="tab-pane fade" id="chart_04">
							<div class="col-sm-4">
								<div class="nationCode_Drwbak_Rate_BarChartdiv">
									<canvas id="nationCode_Drwbak_Rate_BarChart" height="200"
										data-rate-flag="true"></canvas>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="nationCode_Used_Rate_BarChartdiv">
									<canvas id="nationCode_Used_Rate_BarChart" height="200"
										data-rate-flag="true"></canvas>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="nationCode_Tax_By_DrwBak_Rate_BarChartdiv">
									<canvas id="nationCode_Tax_By_DrwBak_Rate_BarChart"
										height="200" data-rate-flag="true"></canvas>
								</div>
							</div>
						</div>

						<%// 기납증/분증 수취비율  %>
						<div class="tab-pane fade" id="chart_05">
							<div class="col-sm-6">
								<div class="ccpy_Amount_Rate_PieChartdiv">
									<canvas id="ccpy_Amount_Rate_PieChart" height="140"></canvas>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="ccpy_Qty_Rate_PieChartdiv">
									<canvas id="ccpy_Qty_Rate_PieChart" height="140"></canvas>
								</div>
							</div>
						</div>

						<%// 기납증/분증 발급비율  %>
						<div class="tab-pane fade" id="chart_06">
							<div class="col-sm-6">
								<div class="ctrm_Amount_Rate_PieChartdiv">
									<canvas id="ctrm_Amount_Rate_PieChartdiv" height="140"
										data-rate-flag="true"></canvas>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="ctrm_Qty_Rate_PieChartdiv">
									<canvas id="ctrm_Qty_Rate_PieChartdiv" height="140"
										data-rate-flag="true"></canvas>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<article class="col-sm-12">
					<!-- Widget ID (each widget will need unique ID)-->
					<div class="jarviswidget" id="wid-id-1"
						data-widget-editbutton="false" data-widget-colorbutton="false"
						data-widget-deletebutton="false" style="margin-bottom: 5px;">
						<header>
							<h2>
								<i class="fa fa-lg fa-fw fa-bar-chart-o"></i>상세내역
							</h2>
						</header>
						<!-- widget div-->
						<div>
							<!-- widget content -->
							<div class="widget-body" style="position: relative;">
								<div id="div_oTui_RPT008_01_List" name="div_oTui_RPT008_01_List"
									class="tuigrid-resizable">
									<div id="oTui_RPT008_01_List" data-minus-height="755"></div>
									<div id="oTui_RPT008_01_List_paging"></div>
								</div>
							</div>
							<!-- end widget content -->
						</div>
						<!-- end widget div -->
					</div>
					<!-- end widget -->
				</article>
			</div>

		</section>

	</div>

	<script>
	//거래처별 차트
	var oPieChart_VendorDrwbakRate, pieVendorDrwbakRateData;
	var oBarChart_VendorDrwbakUsedQty, barVendorDrwbakUsedQtyData;
	var oBarChart_VendorTaxByDrwBakRate, barVendorTaxByDrwBakRateData;
	
	    
	
	//자재코드 별 차트
	var oPieChart_ItemCodeDrwbakRate, pieItemCodeDrwbakRateData;
	var oBarChart_ItemCodeDrwbakUsedQty, barItemCodeDrwbakUsedQtyData;
	var oBarChart_ItemCodeTaxByDrwBakRate, barItemCodeTaxByDrwBakRateData;
		
	//HS CODE 별 차트
	var oPieChart_HsCodeDrwbakRate, pieHsCodeDrwbakRateData;
	var oBarChart_HsCodeDrwbakUsedQty, barHsCodeDrwbakUsedQtyData;
	var oBarChart_HsCodeTaxByDrwBakRate, barHsCodeTaxByDrwBakRateData;
	
	//목적국 별 차트
	var oPieChart_NationCodeDrwbakRate, pieNationCodeDrwbakRateData;
	var oBarChart_NationCodeDrwbakUsedQty, barNationCodeDrwbakUsedQtyData;
	var oBarChart_NationCodeTaxByDrwBakRate, barNationCodeTaxByDrwBakRateData;
	
	//기납증/분증 수취비율
	var oPieChart_CcpyAmountRate, pieCcpyAmountRateData;
	var oPieChart_CcpyQtyRate, pieCcpyQtyRateData;
	
	//기납증/분증 발급비율
	var oPieChart_CtrmAmountRate, pieCtrmAmountRateData;
	var oPieChart_CtrmQtyRate, pieCtrmQtyRateData;
	
	
	var grid01, grid02, oneTimeKey = true;
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
							var fontSize = 12;
							var fontStyle = 'bold';
							var fontFamily = 'Arial';
							ctx.font = Chart.helpers.fontString(fontSize, fontStyle, fontFamily);

							var dataString 
							if(typeof(dataset.data[index]) == "number"){
								dataString = KpackageOBJ.formatter.commas(dataset.data[index].toString());	
							}else{
								dataString = dataset.data[index];
							}
							

							ctx.textAlign = 'center';
							ctx.textBaseline = 'middle';

							var padding = -5;
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
	
	var RPT008 = new function(){

	
		this.Initialize_viewObject = function() {
	
			var fromDay = KpackageOBJ.date.getCurrMonth() + "01";
			var toDay = KpackageOBJ.date.getCurrDay();
			
			/* Test Code  Start */
			//fromDay = "20210101";
			//toDay = "20211231";
			/* Test Code  End */
			KpackageOBJ.calendar.create("RPT008-form", "CAL_SEARCH_FROM_DATE");
			KpackageOBJ.calendar.setValue("RPT008-form","CAL_SEARCH_FROM_DATE", fromDay);
			KpackageOBJ.object.setFormValue("RPT008-form","SEARCH_FROM_DATE", fromDay);
			
			KpackageOBJ.calendar.create("RPT008-form", "CAL_SEARCH_TO_DATE");
			KpackageOBJ.calendar.setValue("RPT008-form","CAL_SEARCH_TO_DATE", toDay);
			KpackageOBJ.object.setFormValue("RPT008-form","SEARCH_TO_DATE", toDay);
			
			
	
			/*Search Type Select Box Create */
			arrayItem = [{value:"ITEM_CODE", name:"<spring:message code='자재코드'/>"}
						];
			
			
			KpackageOBJ.selectbox.create("RPT008-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			            ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("RPT008-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
			RPT008.renderTuiGrid();
			// 탭 클릭 이벤트 등록
			$("#toastGrid_01Tab.nav.nav-tabs li").click(function(){setTimeout(RPT008.resizengGridEvent, 300);});
		}
		
		
		this.resizengGridEvent = function(){
			/* 그리드 사이즈 불량 보완 */
			if(oneTimeKey){
				KpackageOBJ.tuiGrid.reSizingGrid("oTui_RPT008_02_List");
				oneTimeKey = false;
			}
			
		}
		
		<% //거래처별 차트 %>
		<% //01.수출액 대비 환급액 비율  %>
		this.createVendorDrwbakRatePieChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT008-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt008_getVendorDrwbak_Rate", postData, RPT008.drawVendorDrwbakRatePieChart, null, false);
			
		}
		
		this.drawVendorDrwbakRatePieChart = function(result){
			var data = result.value;
			var label_arrayData = [], 
				code_arrayData = [],
			    data_arrayData = [],
			    toolTip_ArrayData = [],
			    sumData = 0;
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					var tempLengthString = "";
					tempLengthString = data[i]["LABEL_VALUE"];
					
					label_arrayData.push(tempLengthString);
					code_arrayData.push(data[i]["CODE_VALUE"]);
					data_arrayData.push( data[i]["DATA_VALUE"]);
					toolTip_ArrayData.push(data[i]["TOOLTIP_VAL"]);
						
				}
				
			}
			
			pieVendorDrwbakRateData = {
	            labels: label_arrayData,
	            datasets: [{
	                label: '수출액대비 환급액비율',
	                data: data_arrayData,
	                code_data: code_arrayData,
	                tooptip_data : toolTip_ArrayData,
	                backgroundColor: KpackageOBJ.pieChart.chartColor03
	            }]
			};		
			var tgt_CanvasID = $('.vendor_Drwbak_Rate_PieChartdiv').find('canvas').prop('id');

			oPieChart_VendorDrwbakRate = new Chart(document.getElementById(tgt_CanvasID),{
				type: 'bar',
				data: pieVendorDrwbakRateData,
				options: {
					responsive: true,
	                title: {
						display: true,
						text: '수출액대비 환급액 비율',
						fontSize: 15,
						padding: 20
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
			        scales: {
						xAxes: [{
							display: true,
							maxBarThickness: 20 
							}],
						yAxes:[{
							display: true,
							position: 'left',
							scaleLabel: {
								display: true,
								labelString: '(기준: 100%)'
							},	
							ticks: {
								min: 0,
								callback: function(value, index, values) {
			                        return value;
			                    }
							}
							/*
					    	ticks: {
					    		display:true,
					    		min: 0.01,
					    		max: 1.00
					    	}*/
					   	}]
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
			
			
			
			$("#vendor_Drwbak_Rate_PieChart").click(
				function(evt){
					try{
						var activePointsIndex, indexValue;
						activePointsIndex = oPieChart_VendorDrwbakRate.tooltip._active[0]._index;
						indexValue = oPieChart_VendorDrwbakRate.data.datasets[0].code_data[activePointsIndex];
						RPT008.retrieveRpt0080XGrid(indexValue, "VENDOR_PIE_01");
					}catch(e){}
				}
			);   
			
		}
		<% //02. 환급사용 수량비율  %>
		this.createVendorDrwbakUsedQtyBarChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT008-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt008_getVendorDrwbakUsedQtyData", postData, RPT008.drawVendorDrwbakUsedQtyChart, null, false, "05");
		}
		
		this.drawVendorDrwbakUsedQtyChart = function(result){
			
			var data = result.value;
			var label_arrayData = [],
				fullLabel_arrayData = [],
				code_arrayData = [],
			    data_arrayData = [];
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					var tempLengthString = "";
					if(data[i]["LABEL_VALUE"].length > 10){
						tempLengthString = data[i]["LABEL_VALUE"].substring(0,7) + "...";
					}else{
						tempLengthString = data[i]["LABEL_VALUE"];
					}
					
					label_arrayData.push(tempLengthString);
					fullLabel_arrayData.push(data[i]["LABEL_VALUE"]);
					code_arrayData.push(data[i]["CODE_VALUE"]);
					data_arrayData.push(data[i]["DATA_VALUE"] );
						
				}
				
			}
			
			barVendorTaxByDrwBakRateData = {
	            labels: label_arrayData,
	            full_labels:fullLabel_arrayData,
	            datasets: [{
	            	type: 'bar',
	                label: '환급수량별 비율',
	                backgroundColor: KpackageOBJ.pieChart.chartColor03,
	                data: data_arrayData,
	                code_data: code_arrayData
	            }]
			};

			var tgt_CanvasID = $('.vendor_Used_Rate_BarChartdiv').find('canvas').prop('id');
			

			oBarChart_VendorDrwbakUsedQty = new Chart(document.getElementById(tgt_CanvasID),{
				type: 'bar',
				data: barVendorTaxByDrwBakRateData,
				options: {
					responsive: true,
	                title: {
						display: true,
						text: '환급수량별 비율',
						fontSize: 15,
						padding: 20
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
			        scales: {
						xAxes: [{
							display: true,
							maxBarThickness: 20 
							}]
					},
			        tooltips: {
		                enabled: true,
		                mode: 'single',
		                callbacks: {
		                    label: function(tooltipItems, data) { 
		                    	return data.full_labels[tooltipItems.index] + ' : ' + KpackageOBJ.formatter.commas(data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index]);
		                    }
		                }
		            }
			        
				}
			});
			
			
			$("#vendor_Used_Rate_BarChart").click(
				function(evt){
					try{
						var activePointsIndex, indexValue;
						
						activePointsIndex = oBarChart_VendorDrwbakUsedQty.tooltip._active[0]._index;
						indexValue = oBarChart_VendorDrwbakUsedQty.data.datasets[0].code_data[activePointsIndex];
							
						RPT008.retrieveRpt0080XGrid_IMPDEC(indexValue, "VENDOR");
					}catch(e){}
				}
			); 
		}
		
		<% //03. 납부세액 대비 환급비율  %>
		this.createVendorTaxByDrwBakRateBarChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT008-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt008_getVendorTaxByDrwBakRate", postData, RPT008.drawVendorTaxByDrwBakRateChart, null, false, "05");
		}
		
		
		
		this.drawVendorTaxByDrwBakRateChart = function(result){
			
			var data = result.value;
			var label_arrayData = [], 
				code_arrayData = [],
				fullLabel_arrayData = [],
			    data_arrayData = [];
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					var tempLengthString = "";
					if(data[i]["LABEL_VALUE"].length > 10){
						tempLengthString = data[i]["LABEL_VALUE"].substring(0,5) + "...";
					}else{
						tempLengthString = data[i]["LABEL_VALUE"];
					}
					
					label_arrayData.push(tempLengthString);
					fullLabel_arrayData.push(data[i]["LABEL_VALUE"]);
					code_arrayData.push(data[i]["CODE_VALUE"]);
					data_arrayData.push(data[i]["DATA_VALUE"] );
						
				}
				
			}
			barVendorTaxByDrwBakRateData = {
	            labels: label_arrayData,
	            full_labels:fullLabel_arrayData,
	            datasets: [{
	            	type: 'bar',
	                label: '환급비율',
	                backgroundColor: KpackageOBJ.pieChart.chartColor03,
	                data: data_arrayData,
	                code_data: code_arrayData
	            }]
			};

			var tgt_CanvasID = $('.vendor_Tax_By_DrwBak_Rate_BarChartdiv').find('canvas').prop('id');

			oBarChart_VendorTaxByDrwBakRate = new Chart(document.getElementById(tgt_CanvasID),{
				type: 'bar',
				data: barVendorTaxByDrwBakRateData,
				options: {
					responsive: true,
	                title: {
						display: true,
						text: '납부세액 대비 환급비율',
						fontSize: 15,
						padding: 20
					},
					legend: {
						display: true, 
						position: 'bottom',
						reverse: true
			        },
			        scales: {
						xAxes: [{
							display: true,
							maxBarThickness: 20 
							}]
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
		                    	return data.full_labels[tooltipItems.index] + ' : ' + KpackageOBJ.formatter.commas(data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index]);
		                    }
		                }
		            }
			        
				}
			});
			
			
			
			
			$("#vendor_Tax_By_DrwBak_Rate_BarChart").click(
				function(evt){
					try{
						var activePointsIndex, indexValue;
						
						activePointsIndex = oBarChart_VendorTaxByDrwBakRate.tooltip._active[0]._index;
						indexValue = oBarChart_VendorTaxByDrwBakRate.data.datasets[0].code_data[activePointsIndex];
							
						RPT008.retrieveRpt0080XGrid_IMPDEC(indexValue, "VENDOR");
					}catch(e){}
				}
			); 
		}
		
		
		this.retrieveVendorDrwbakRatePieChart = function() {
			if(oPieChart_VendorDrwbakRate != undefined){
				oPieChart_VendorDrwbakRate.destroy();	
			}
			
			RPT008.createVendorDrwbakRatePieChart();
		}
		
		this.retrieveVendorDrwbakUsedQtyBarchart = function() {
			if(oBarChart_VendorDrwbakUsedQty != undefined){
				oBarChart_VendorDrwbakUsedQty.destroy();	
			}
			
			RPT008.createVendorDrwbakUsedQtyBarChart();
		}
		
		this.retrieveVendorTaxByDrwBakRateBarChart = function() {
			if(oBarChart_VendorTaxByDrwBakRate != undefined){
				oBarChart_VendorTaxByDrwBakRate.destroy();	
			}
			
			RPT008.createVendorTaxByDrwBakRateBarChart();
		}
		
		<% //제품코드 별 차트 %>
		<% //01.수출액 대비 환급액 비율  %>
		this.createItemCodeDrwbakRatePieChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT008-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt008_getItemCodeDrwbak_Rate", postData, RPT008.drawItemCodeDrwbakRatePieChart, null, false);
			
		}
		
		this.drawItemCodeDrwbakRatePieChart = function(result){
			var data = result.value;
			var label_arrayData = [], 
				fullLabel_arrayData = [],
				code_arrayData = [],
				data_arrayData = [],
			    sumData = 0;
			
			/* 임시코드 시작*/
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					sumData += Number(data[i]["DATA_VALUE"]);
                    
                        
                }
                for(var i=0 ; i<data.length ; i++){
                    var tempLengthString = "";
					if(data[i]["LABEL_VALUE"].length > 10){
						tempLengthString = data[i]["LABEL_VALUE"].substring(0,5) + "...";
					}else{
						tempLengthString = data[i]["LABEL_VALUE"];
					}
                    
                    label_arrayData.push(tempLengthString);
                    fullLabel_arrayData.push(data[i]["LABEL_VALUE"]);
                    code_arrayData.push(data[i]["CODE_VALUE"]);
                    data_arrayData.push(Math.round(Number(data[i]["DATA_VALUE"])/sumData * 100)  );
                    
                }
                
            }
			/* 임시코드 끝*/
			/*
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					var tempLengthString = "";
					if(data[i]["LABEL_VALUE"].length > 10){
						tempLengthString = data[i]["LABEL_VALUE"].substring(0,7) + "...";
					}else{
						tempLengthString = data[i]["LABEL_VALUE"];
					}
					
					label_arrayData.push(tempLengthString);
					code_arrayData.push(data[i]["CODE_VALUE"]);
					data_arrayData.push(data[i]["DATA_VALUE"] );
						
				}
				
			}
			*/
			pieItemCodeDrwbakRateData = {
	            labels: label_arrayData,
	            fullLabels : fullLabel_arrayData,
	            datasets: [{
	                label: '환급사용 수량비율',
	                data: data_arrayData,
	                code_data: code_arrayData,
	                backgroundColor: KpackageOBJ.pieChart.chartColor03
	            }]
			};		

			var tgt_CanvasID = $('.itemCode_Drwbak_Rate_PieChartdiv').find('canvas').prop('id');
			

			oPieChart_ItemCodeDrwbakRate = new Chart(document.getElementById(tgt_CanvasID),{
				type: 'doughnut',
				data: pieItemCodeDrwbakRateData,
				options: {
					responsive: true,
	                title: {
						display: true,
						text: '수출액 대비 환급액 비율',
						fontSize: 15,
						padding: 20
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
		                    	//debugger;
		                        //return data.labels[tooltipItems.datasetIndex] + ' : ' + KpackageOBJ.formatter.commas(data.datasets[tooltipItems.datasetIndex].tooptip_data[tooltipItems.index]);
		                        return data.fullLabels[tooltipItems.index] + ' : ' + KpackageOBJ.formatter.commas(data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index]);
		                    }
		                }
		            }
			        
				}
			});
			
			
			$("#itemCode_Drwbak_Rate_PieChart").click(
				function(evt){
					try{
						var activePointsIndex, indexValue;
						activePointsIndex = oPieChart_ItemCodeDrwbakRate.tooltip._active[0]._index;
						indexValue = oPieChart_ItemCodeDrwbakRate.data.datasets[0].code_data[activePointsIndex];
						RPT008.retrieveRpt0080XGrid(indexValue, "ITEM_PIE_01");
					}catch(e){}
				}
			);   
			
		}
		<% //02. 환급사용 수량비율  %>
		this.createItemCodeDrwbakUsedQtyBarChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT008-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt008_getItemCodeDrwbakUsedQtyData", postData, RPT008.drawItemCodeDrwbakUsedQtyChart, null, false, "05");
		}
		
		this.drawItemCodeDrwbakUsedQtyChart = function(result){
			
			var data = result.value;
			var label_arrayData = [], 
				fullLabel_arrayData = [], 
			 	code_arrayData = [],
			    data_arrayData = [];
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					var tempLengthString = "";
					if(data[i]["LABEL_VALUE"].length > 10){
						tempLengthString = data[i]["LABEL_VALUE"].substring(0,7) + "...";
					}else{
						tempLengthString = data[i]["LABEL_VALUE"];
					}
					
					
					label_arrayData.push(tempLengthString);
					fullLabel_arrayData.push(data[i]["LABEL_VALUE"]);
					code_arrayData.push(data[i]["CODE_VALUE"]);
					data_arrayData.push(data[i]["DATA_VALUE"] );
						
				}
				
			}
			
			barItemCodeTaxByDrwBakRateData = {
	            labels: label_arrayData,
	            full_labels : fullLabel_arrayData,
	            datasets: [{
	            	type: 'bar',
	                label: '환급수량별 비율',
	                backgroundColor: KpackageOBJ.pieChart.chartColor03,
	                data: data_arrayData,
	                code_data: code_arrayData
	            }]
			};

			var tgt_CanvasID = $('.itemCode_Used_Rate_BarChartdiv').find('canvas').prop('id');
			

			oBarChart_ItemCodeDrwbakUsedQty = new Chart(document.getElementById(tgt_CanvasID),{
				type: 'bar',
				data: barItemCodeTaxByDrwBakRateData,
				options: {
					responsive: true,
	                title: {
						display: true,
						text: '환급사용 수량비율',
						fontSize: 15,
						padding: 20
					},
					legend: {
						display: true, 
						position: 'bottom',
						reverse: true
			        },
			        scales: {
						xAxes: [{
							display: true,
							maxBarThickness: 20 
							}]
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
		                    	return data.full_labels[tooltipItems.index] + ' : ' + KpackageOBJ.formatter.commas(data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index]);
		                    }
		                }
		            }
			        
				}
			});
			
			$("#itemCode_Used_Rate_BarChart").click(
				function(evt){
					try{
						var activePointsIndex, indexValue;
						
						activePointsIndex = oBarChart_ItemCodeDrwbakUsedQty.tooltip._active[0]._index;
						indexValue = oBarChart_ItemCodeDrwbakUsedQty.data.datasets[0].code_data[activePointsIndex];
							
						RPT008.retrieveRpt0080XGrid(indexValue, "ITEM_PIE_01");
					}catch(e){}
				}
			); 
		}
		
		<% //03. 납부세액 대비 환급비율  %>
		this.createItemCodeTaxByDrwBakRateBarChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT008-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt008_getItemCodeTaxByDrwBakRate", postData, RPT008.drawItemCodeTaxByDrwBakRateChart, null, false, "05");
		}
		
		
		
		this.drawItemCodeTaxByDrwBakRateChart = function(result){
			
			var data = result.value;
			var label_arrayData = [], 
				fullLabel_arrayData = [], 
				code_arrayData = [],
			    data_arrayData = [];
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					var tempLengthString = "";
					if(data[i]["LABEL_VALUE"].length > 10){
						tempLengthString = data[i]["LABEL_VALUE"].substring(0,5) + "...";
					}else{
						tempLengthString = data[i]["LABEL_VALUE"];
					}
					
					label_arrayData.push(tempLengthString);
					fullLabel_arrayData.push(data[i]["LABEL_VALUE"]);
					code_arrayData.push(data[i]["CODE_VALUE"]);
					data_arrayData.push(data[i]["DATA_VALUE"] );
						
				}
				
			}
			barItemCodeTaxByDrwBakRateData = {
	            labels: label_arrayData,
	            full_labels : fullLabel_arrayData,
	            datasets: [{
	            	type: 'bar',
	                label: "환급비율",
	                backgroundColor: KpackageOBJ.pieChart.chartColor03,
	                data: data_arrayData,
	                code_data: code_arrayData
	            }]
			};

			var tgt_CanvasID = $('.itemCode_Tax_By_DrwBak_Rate_BarChartdiv').find('canvas').prop('id');
			

			oBarChart_ItemCodeTaxByDrwBakRate = new Chart(document.getElementById(tgt_CanvasID),{
				type: 'bar',
				data: barItemCodeTaxByDrwBakRateData,
				options: {
					responsive: true,
	                title: {
						display: true,
						text: '납부세액 대비 환급비율',
						fontSize: 15,
						padding: 20
					},
					legend: {
						display: true, 
						position: 'bottom',
						reverse: true
			        },
			        scales: {
						xAxes: [{
							display: true,
							maxBarThickness: 20 
							}]
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
		                    	return data.full_labels[tooltipItems.index] + ' : ' + KpackageOBJ.formatter.commas(data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index]);
		                    }
		                }
		            }
			        
				}
			});
			
			
			$("#itemCode_Tax_By_DrwBak_Rate_BarChart").click(
				function(evt){
					try{
						var activePointsIndex, indexValue;
						
						activePointsIndex = oBarChart_ItemCodeTaxByDrwBakRate.tooltip._active[0]._index;
						indexValue = oBarChart_ItemCodeTaxByDrwBakRate.data.datasets[0].code_data[activePointsIndex];
							
						RPT008.retrieveRpt0080XGrid_IMPDEC(indexValue, "ITEM");
					}catch(e){}
				}
			); 
		}
		
		
		this.retrieveItemCodeDrwbakRatePieChart = function() {
			if(oPieChart_ItemCodeDrwbakRate != undefined){
				oPieChart_ItemCodeDrwbakRate.destroy();	
			}
			
			RPT008.createItemCodeDrwbakRatePieChart();
		}
		
		this.retrieveItemCodeDrwbakUsedQtyBarchart = function() {
			if(oBarChart_ItemCodeDrwbakUsedQty != undefined){
				oBarChart_ItemCodeDrwbakUsedQty.destroy();	
			}
			
			RPT008.createItemCodeDrwbakUsedQtyBarChart();
		}
		
		this.retrieveItemCodeTaxByDrwBakRateBarChart = function() {
			if(oBarChart_ItemCodeTaxByDrwBakRate != undefined){
				oBarChart_ItemCodeTaxByDrwBakRate.destroy();	
			}
			
			RPT008.createItemCodeTaxByDrwBakRateBarChart();
		}
		
		
		
		<% //HS Code 별 차트 %>
		<% //01.수출액 대비 환급액 비율  %>
		this.createHsCodeDrwbakRatePieChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT008-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt008_getHsCodeDrwbak_Rate", postData, RPT008.drawHsCodeDrwbakRatePieChart, null, false);
			
		}
		
		this.drawHsCodeDrwbakRatePieChart = function(result){
			var data = result.value;
			var label_arrayData = [], 
				code_arrayData = [],
			    data_arrayData = [],
			    sumData = 0;
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					var tempLengthString = "";
					label_arrayData.push(data[i]["LABEL_VALUE"]);
					code_arrayData.push(data[i]["CODE_VALUE"]);
					data_arrayData.push(data[i]["DATA_VALUE"] );
						
				}
				
			}
			
			pieHsCodeDrwbakRateData = {
	            labels: label_arrayData,
	            datasets: [{
	                label: '환급사용수량비율',
	                data: data_arrayData,
	                code_data: code_arrayData,
	                backgroundColor: KpackageOBJ.pieChart.chartColor03
	            }]
			
			
			};		

			var tgt_CanvasID = $('.hsCode_Drwbak_Rate_PieChartdiv').find('canvas').prop('id');

			oPieChart_HsCodeDrwbakRate = new Chart(document.getElementById(tgt_CanvasID),{
				type: 'doughnut',
				data: pieHsCodeDrwbakRateData,
				options: {
					responsive: true,
	                title: {
						display: true,
						text: '수출액 대비 환급액 비율',
						fontSize: 15,
						padding: 20
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
		                    	//debugger;
		                        //return data.labels[tooltipItems.datasetIndex] + ' : ' + KpackageOBJ.formatter.commas(data.datasets[tooltipItems.datasetIndex].tooptip_data[tooltipItems.index]);
		                        return data.labels[tooltipItems.index] + ' : ' + KpackageOBJ.formatter.commas(data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index]);
		                    }
		                }
		            }
			        
				}
			});
			
		
			$("#hsCode_Drwbak_Rate_PieChart").click(
				function(evt){
					try{
						var activePointsIndex, indexValue;
						activePointsIndex = oPieChart_HsCodeDrwbakRate.tooltip._active[0]._index;
						indexValue = oPieChart_HsCodeDrwbakRate.data.datasets[0].code_data[activePointsIndex];
						RPT008.retrieveRpt0080XGrid(indexValue, "HSCODE_PIE_01");
					}catch(e){}
				}
			);   
			
		}
		<% //02. 환급사용 수량비율  %>
		this.createHsCodeDrwbakUsedQtyBarChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT008-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt008_getHsCodeDrwbakUsedQtyData", postData, RPT008.drawHsCodeDrwbakUsedQtyChart, null, false, "05");
		}
		
		this.drawHsCodeDrwbakUsedQtyChart = function(result){
			
			var data = result.value;
			var label_arrayData = [], 
				code_arrayData = [],
			    data_arrayData = [];
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					var tempLengthString = "";
					label_arrayData.push(data[i]["LABEL_VALUE"]);
					code_arrayData.push(data[i]["CODE_VALUE"]);
					data_arrayData.push(data[i]["DATA_VALUE"] );
						
				}
				
			}
			
			barHsCodeTaxByDrwBakRateData = {
	            labels: label_arrayData,
	            datasets: [{
	            	type: 'bar',
	                label: '환급수량별 비율',
	                backgroundColor: KpackageOBJ.pieChart.chartColor03,
	                data: data_arrayData,
	                code_data: code_arrayData
	            }]
			};

			var tgt_CanvasID = $('.hsCode_Used_Rate_BarChartdiv').find('canvas').prop('id');
			
			oBarChart_HsCodeDrwbakUsedQty = KpackageOBJ.chart.create("bar", tgt_CanvasID, barHsCodeTaxByDrwBakRateData, "환급사용 수량비율");
			
			$("#hsCode_Used_Rate_BarChart").click(
				function(evt){
					try{
						var activePointsIndex, indexValue;
						
						activePointsIndex = oBarChart_HsCodeDrwbakUsedQty.tooltip._active[0]._index;
						indexValue = oBarChart_HsCodeDrwbakUsedQty.data.datasets[0].code_data[activePointsIndex];
							
						RPT008.retrieveRpt0080XGrid_IMPDEC(indexValue, "HSCODE");
						
					}catch(e){}
				}
			); 
		}
		
		<% //03. 납부세액 대비 환급비율  %>
		this.createHsCodeTaxByDrwBakRateBarChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT008-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt008_getHsCodeTaxByDrwBakRate", postData, RPT008.drawHsCodeTaxByDrwBakRateChart, null, false, "05");
		}
		
		
		
		this.drawHsCodeTaxByDrwBakRateChart = function(result){
			
			var data = result.value;
			var label_arrayData = [], 
				code_arrayData = [],
			    data_arrayData = [];
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					var tempLengthString = "";
					label_arrayData.push(data[i]["LABEL_VALUE"]);
					code_arrayData.push(data[i]["CODE_VALUE"]);
					data_arrayData.push(data[i]["DATA_VALUE"] );
						
				}
				
			}
			barHsCodeTaxByDrwBakRateData = {
	            labels: label_arrayData,
	            datasets: [{
	            	type: 'bar',
	                label: "환급비율",
	                backgroundColor: KpackageOBJ.pieChart.chartColor03,
	                data: data_arrayData,
	                code_data: code_arrayData
	            }]
			};

			var tgt_CanvasID = $('.hsCode_Tax_By_DrwBak_Rate_BarChartdiv').find('canvas').prop('id');
			oBarChart_HsCodeTaxByDrwBakRate = KpackageOBJ.chart.create("bar", tgt_CanvasID, barHsCodeTaxByDrwBakRateData, "납부세액 대비 환급비율");
			
			$("#hsCode_Tax_By_DrwBak_Rate_BarChart").click(
				function(evt){
					try{
						var activePointsIndex, indexValue;
						
						activePointsIndex = oBarChart_HsCodeTaxByDrwBakRate.tooltip._active[0]._index;
						indexValue = oBarChart_HsCodeTaxByDrwBakRate.data.datasets[0].code_data[activePointsIndex];
							
						RPT008.retrieveRpt0080XGrid_IMPDEC(indexValue, "HSCODE");
					}catch(e){}
				}
			); 
		}
		
		
		this.retrieveHsCodeDrwbakRatePieChart = function() {
			if(oPieChart_HsCodeDrwbakRate != undefined){
				oPieChart_HsCodeDrwbakRate.destroy();	
			}
			
			RPT008.createHsCodeDrwbakRatePieChart();
		}
		
		this.retrieveHsCodeDrwbakUsedQtyBarchart = function() {
			if(oBarChart_HsCodeDrwbakUsedQty != undefined){
				oBarChart_HsCodeDrwbakUsedQty.destroy();	
			}
			
			RPT008.createHsCodeDrwbakUsedQtyBarChart();
		}
		
		this.retrieveHsCodeTaxByDrwBakRateBarChart = function() {
			if(oBarChart_HsCodeTaxByDrwBakRate != undefined){
				oBarChart_HsCodeTaxByDrwBakRate.destroy();	
			}
			
			RPT008.createHsCodeTaxByDrwBakRateBarChart();
		}
		
		
		
		
		<% //목적국별 별 차트 %>
		<% //01.수출액 대비 환급액 비율  %>
		this.createNationCodeDrwbakRatePieChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT008-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt008_getNationCodeDrwbak_Rate", postData, RPT008.drawNationCodeDrwbakRatePieChart, null, false);
			
		}
		
		this.drawNationCodeDrwbakRatePieChart = function(result){
			var data = result.value;
			var label_arrayData = [], 
				code_arrayData = [],
			    data_arrayData = [],
			    sumData = 0;
			
			 if(result.success){
	                for(var i=0 ; i<data.length ; i++){
	                    sumData += Number(data[i]["DATA_VALUE"]);
	                                            
	                }
	                for(var i=0 ; i<data.length ; i++){
	                    var tempLengthString = "";
	                    if(data[i]["LABEL_VALUE"].length > 10){
	                        tempLengthString = data[i]["LABEL_VALUE"].substring(0,7) + "...";
	                    }else{
	                        tempLengthString = data[i]["LABEL_VALUE"];
	                    }
	                    
	                    label_arrayData.push(tempLengthString);
	                    code_arrayData.push(data[i]["CODE_VALUE"]);
	                    data_arrayData.push(Math.round(Number(data[i]["DATA_VALUE"])/sumData*100) );
	                        
	                }
	                
	            }
			 /*
			기존소스
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					var tempLengthString = "";
					if(data[i]["LABEL_VALUE"].length > 10){
						tempLengthString = data[i]["LABEL_VALUE"].substring(0,7) + "...";
					}else{
						tempLengthString = data[i]["LABEL_VALUE"];
					}
					
					label_arrayData.push(tempLengthString);
					code_arrayData.push(data[i]["CODE_VALUE"]);
					data_arrayData.push(data[i]["DATA_VALUE"] );
						
				}
				
			}
			 */
			
			pieNationCodeDrwbakRateData = {
	            labels: label_arrayData,
	            datasets: [{
	                label: '환급사용수량비율',
	                data: data_arrayData,
	                code_data: code_arrayData,
	                backgroundColor: KpackageOBJ.pieChart.chartColor03
	            }]
			};		

			var tgt_CanvasID = $('.nationCode_Drwbak_Rate_BarChartdiv').find('canvas').prop('id');

			oPieChart_NationCodeDrwbakRate = new Chart(document.getElementById(tgt_CanvasID),{
				type: 'doughnut',
				data: pieNationCodeDrwbakRateData,
				options: {
					responsive: true,
	                title: {
						display: true,
						text: '수출액 대비 환급액 비율',
						fontSize: 15,
						padding: 20
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
		                    	//debugger;
		                        //return data.labels[tooltipItems.datasetIndex] + ' : ' + KpackageOBJ.formatter.commas(data.datasets[tooltipItems.datasetIndex].tooptip_data[tooltipItems.index]);
		                        return data.labels[tooltipItems.index] + ' : ' + KpackageOBJ.formatter.commas(data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index]);
		                    }
		                }
		            }
			        
				}
			});
			
			$("#nationCode_Drwbak_Rate_BarChart").click(
				function(evt){
					try{
						var activePointsIndex, indexValue;
						activePointsIndex = oPieChart_NationCodeDrwbakRate.tooltip._active[0]._index;
						indexValue = oPieChart_NationCodeDrwbakRate.data.datasets[0].code_data[activePointsIndex];
						RPT008.retrieveRpt0080XGrid(indexValue, "NATION_PIE_01");
						       
					}catch(e){}
				}
			);   
			
		}
		<% //02. 환급사용 수량비율  %>
		this.createNationCodeDrwbakUsedQtyBarChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT008-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt008_getNationCodeDrwbakUsedQtyData", postData, RPT008.drawNationCodeDrwbakUsedQtyChart, null, false, "05");
		}
		
		this.drawNationCodeDrwbakUsedQtyChart = function(result){
			
			var data = result.value;
			var label_arrayData = [], 
				code_arrayData = [],
			    data_arrayData = [];
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					var tempLengthString = "";
					if(data[i]["LABEL_VALUE"].length > 10){
						tempLengthString = data[i]["LABEL_VALUE"].substring(0,7) + "...";
					}else{
						tempLengthString = data[i]["LABEL_VALUE"];
					}
					
					label_arrayData.push(tempLengthString);
					code_arrayData.push(data[i]["CODE_VALUE"]);
					data_arrayData.push(data[i]["DATA_VALUE"] );
						
				}
				
			}
			
			barNationCodeTaxByDrwBakRateData = {
	            labels: label_arrayData,
	            datasets: [{
	            	type: 'bar',
	                label: '환급수량별 비율',
	                backgroundColor: KpackageOBJ.pieChart.chartColor03,
	                data: data_arrayData,
	                code_data: code_arrayData
	            }]
			};

			var tgt_CanvasID = $('.nationCode_Used_Rate_BarChartdiv').find('canvas').prop('id');
			
			oBarChart_NationCodeDrwbakUsedQty = KpackageOBJ.chart.create("bar", tgt_CanvasID, barNationCodeTaxByDrwBakRateData, "환급사용 수량비율");
			
			$("#nationCode_Used_Rate_BarChart").click(
				function(evt){
					try{
						var activePointsIndex, indexValue;
						
						activePointsIndex = oBarChart_NationCodeDrwbakUsedQty.tooltip._active[0]._index;
						indexValue = oBarChart_NationCodeDrwbakUsedQty.data.datasets[0].code_data[activePointsIndex];
							
						RPT008.retrieveRpt0080XGrid_IMPDEC(indexValue, "NATION");
					}catch(e){}
				}
			); 
		}
		
		<% //03. 납부세액 대비 환급비율  %>
		this.createNationCodeTaxByDrwBakRateBarChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT008-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt008_getNationCodeTaxByDrwBakRate", postData, RPT008.drawNationCodeTaxByDrwBakRateChart, null, false, "05");
		}
		
		
		
		this.drawNationCodeTaxByDrwBakRateChart = function(result){
			
			var data = result.value;
			var label_arrayData = [], 
				code_arrayData = [],
			    data_arrayData = [];
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					var tempLengthString = "";
					if(data[i]["LABEL_VALUE"].length > 10){
						tempLengthString = data[i]["LABEL_VALUE"].substring(0,5) + "...";
					}else{
						tempLengthString = data[i]["LABEL_VALUE"];
					}
					
					label_arrayData.push(tempLengthString);
					code_arrayData.push(data[i]["CODE_VALUE"]);
					data_arrayData.push(data[i]["DATA_VALUE"] );
						
				}
				
			}
			barNationCodeTaxByDrwBakRateData = {
	            labels: label_arrayData,
	            datasets: [{
	            	type: 'bar',
	                label: "환급비율",
	                backgroundColor: KpackageOBJ.pieChart.chartColor03,
	                data: data_arrayData,
	                code_data: code_arrayData
	            }]
			};

			var tgt_CanvasID = $('.nationCode_Tax_By_DrwBak_Rate_BarChartdiv').find('canvas').prop('id');
			oBarChart_NationCodeTaxByDrwBakRate = KpackageOBJ.chart.create("bar", tgt_CanvasID, barNationCodeTaxByDrwBakRateData, "납부세액 대비 환급비율");
			
			$("#nationCode_Tax_By_DrwBak_Rate_BarChart").click(
				function(evt){
					try{
						var activePointsIndex, indexValue;
						
						activePointsIndex = oBarChart_NationCodeTaxByDrwBakRate.tooltip._active[0]._index;
						indexValue = oBarChart_NationCodeTaxByDrwBakRate.data.datasets[0].code_data[activePointsIndex];
							
						RPT008.retrieveRpt0080XGrid_IMPDEC(indexValue, "NATION");
					}catch(e){}
				}
			); 
		}
		
		
		this.retrieveNationCodeDrwbakRatePieChart = function() {
			if(oPieChart_NationCodeDrwbakRate != undefined){
				oPieChart_NationCodeDrwbakRate.destroy();	
			}
			
			RPT008.createNationCodeDrwbakRatePieChart();
		}
		
		this.retrieveNationCodeDrwbakUsedQtyBarchart = function() {
			if(oBarChart_NationCodeDrwbakUsedQty != undefined){
				oBarChart_NationCodeDrwbakUsedQty.destroy();	
			}
			
			RPT008.createNationCodeDrwbakUsedQtyBarChart();
		}
		
		this.retrieveNationCodeTaxByDrwBakRateBarChart = function() {
			if(oBarChart_NationCodeTaxByDrwBakRate != undefined){
				oBarChart_NationCodeTaxByDrwBakRate.destroy();	
			}
			
			RPT008.createNationCodeTaxByDrwBakRateBarChart();
		}
		
		
		
		
		
		
		<% //기납증/분증 수취비율 %>
		<% //01.수출액 대비 기납증/분증 수취 비율  %>
		
		
		this.createCcpyAmountRatePieChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT008-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt008_getCcpyAmountRate", postData, RPT008.drawCcpyAmountRatePieChart, null, false);
			
		}
		
		this.drawCcpyAmountRatePieChart = function(result){
			var data = result.value;
			var label_arrayData = [], 
				code_arrayData = [],
			    data_arrayData = [],
			    sumData = 0;
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					var tempLengthString = "";
					if(data[i]["LABEL_VALUE"].length > 10){
						tempLengthString = data[i]["LABEL_VALUE"].substring(0,7) + "...";
					}else{
						tempLengthString = data[i]["LABEL_VALUE"];
					}
					
					var data_value = data[i]["DATA_VALUE"]
					if(data_value != undefined){
						label_arrayData.push(tempLengthString);
	                    code_arrayData.push(data[i]["CODE_VALUE"]);
	                    data_arrayData.push(data[i]["DATA_VALUE"] );	
					}
					
						
				}
				
			}
			
			pieCcpyAmountRateData = {
	            labels: label_arrayData,
	            datasets: [{
	                label: '수출액 대비 기납증/분증 수취 비율',
	                data: data_arrayData,
	                code_data: code_arrayData,
	                backgroundColor: KpackageOBJ.pieChart.chartColor03
	            }]
			};		

			var tgt_CanvasID = $('.ccpy_Amount_Rate_PieChartdiv').find('canvas').prop('id');
			
			oPieChart_CcpyAmountRate = KpackageOBJ.chart.create("doughnut", tgt_CanvasID, pieCcpyAmountRateData, "수출액 대비 기납증/분증 수취 비율");
			
			/*
			$("#ccpy_Amount_Rate_PieChart").click(
				function(evt){
					try{
						var activePointsIndex, indexValue;
						activePointsIndex = oPieChart_CcpyAmountRate.tooltip._active[0]._index;
						indexValue = oPieChart_CcpyAmountRate.data.datasets[0].code_data[activePointsIndex];
						RPT008.retrieveRpt0080XGrid(indexValue, "HSCODE");
					}catch(e){}
				}
			);
			*/
			
		}
		
		this.retrieveCcpyAmountRatePieChart = function() {
			if(oPieChart_CcpyAmountRate != undefined){
				oPieChart_CcpyAmountRate.destroy();	
			}
			
			RPT008.createCcpyAmountRatePieChart();
		}
		
		
		<% //기납증/분증 수취비율 %>
		<% //02. 수량  %>
		
		
		this.createCcpyQtyRatePieChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT008-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt008_getCcpyQtyRate", postData, RPT008.drawCcpyQtyRatePieChart, null, false);
			
		}
		
		this.drawCcpyQtyRatePieChart = function(result){
			var data = result.value;
			var label_arrayData = [], 
				code_arrayData = [],
			    data_arrayData = [],
			    sumData = 0;

		   /* 임시 시작
            if(result.success){
                for(var i=0 ; i<data.length ; i++){
                    sumData += Number(data[i]["DATA_VALUE"]);
                                            
                }
                for(var i=0 ; i<data.length ; i++){
                    var tempLengthString = "";
                    if(data[i]["LABEL_VALUE"].length > 10){
                        tempLengthString = data[i]["LABEL_VALUE"].substring(0,7) + "...";
                    }else{
                        tempLengthString = data[i]["LABEL_VALUE"];
                    }
                    
                    label_arrayData.push(tempLengthString);
                    code_arrayData.push(data[i]["CODE_VALUE"]);
                    data_arrayData.push(Math.round(Number(data[i]["DATA_VALUE"])/sumData*100) );
                        
                }
                
            }
	 */
            if(result.success){
                for(var i=0 ; i<data.length ; i++){
                    var tempLengthString = "";
                    if(data[i]["LABEL_VALUE"].length > 10){
                        tempLengthString = data[i]["LABEL_VALUE"].substring(0,7) + "...";
                    }else{
                        tempLengthString = data[i]["LABEL_VALUE"];
                    }
                    
                    var data_value = data[i]["DATA_VALUE"];
                    if(data_value != undefined){
                        label_arrayData.push(tempLengthString);
                        code_arrayData.push(data[i]["CODE_VALUE"]);
                        data_arrayData.push(data[i]["DATA_VALUE"] );    
                    }
                        
                }
                
            }
			
			pieCcpyQtyRateData = {
	            labels: label_arrayData,
	            datasets: [{
	                label: '환급사용수량비율',
	                data: data_arrayData,
	                code_data: code_arrayData,
	                backgroundColor: KpackageOBJ.pieChart.chartColor03
	            }]
			};		

			var tgt_CanvasID = $('.ccpy_Qty_Rate_PieChartdiv').find('canvas').prop('id');
			
			oPieChart_CcpyQtyRate = KpackageOBJ.chart.create("doughnut", tgt_CanvasID, pieCcpyQtyRateData, "수출액 대비 환급액 비율");
			/*
			$("#ccpy_Qty_Rate_PieChart").click(
				function(evt){
					try{
						var activePointsIndex, indexValue;
						activePointsIndex = oPieChart_CcpyQtyRate.tooltip._active[0]._index;
						indexValue = oPieChart_CcpyQtyRate.data.datasets[0].code_data[activePointsIndex];
						RPT008.retrieveRpt0080XGrid(indexValue, "HSCODE");
					}catch(e){}
				}
			);   
			*/
			
		}
		
		this.retrieveCcpyQtyRatePieChart = function() {
			if(oPieChart_CcpyQtyRate != undefined){
				oPieChart_CcpyQtyRate.destroy();	
			}
			
			RPT008.createCcpyQtyRatePieChart();
		}
		
		
		
		
		<% //기납증/분증 발급비율 %>
		<% //01.구매확인서 대비 기납증/분증 발급 비율  %>
		
		
		this.createCtrmAmountRatePieChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT008-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt008_getCtrmAmountRate", postData, RPT008.drawCtrmAmountRatePieChart, null, false);
			
		}
		
		this.drawCtrmAmountRatePieChart = function(result){
			var data = result.value;
			var label_arrayData = [], 
				code_arrayData = [],
			    data_arrayData = [],
			    sumData = 0;
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					var tempLengthString = "";
					if(data[i]["LABEL_VALUE"].length > 10){
						tempLengthString = data[i]["LABEL_VALUE"].substring(0,7) + "...";
					}else{
						tempLengthString = data[i]["LABEL_VALUE"];
					}
					
					label_arrayData.push(tempLengthString);
					code_arrayData.push(data[i]["CODE_VALUE"]);
					data_arrayData.push(data[i]["DATA_VALUE"] );
						
				}
				
			}
			
			pieCtrmAmountRateData = {
	            labels: label_arrayData,
	            datasets: [{
	                label: '구매확인서 대비 기납증/분증 발급 비율',
	                data: data_arrayData,
	                code_data: code_arrayData,
	                backgroundColor: KpackageOBJ.pieChart.chartColor03
	            }]
			};		

			var tgt_CanvasID = $('.ctrm_Amount_Rate_PieChartdiv').find('canvas').prop('id');
			
			oPieChart_CtrmAmountRate = KpackageOBJ.chart.create("doughnut", tgt_CanvasID, pieCtrmAmountRateData, "구매확인서 대비 기납증/분증 발급 비율");
			
			/*
			$("#ccpy_Amount_Rate_PieChart").click(
				function(evt){
					try{
						var activePointsIndex, indexValue;
						activePointsIndex = oPieChart_CtrmAmountRate.tooltip._active[0]._index;
						indexValue = oPieChart_CtrmAmountRate.data.datasets[0].code_data[activePointsIndex];
						RPT008.retrieveRpt0080XGrid(indexValue, "HSCODE");
					}catch(e){}
				}
			);
			*/
			
		}
		
		this.retrieveCtrmAmountRatePieChart = function() {
			if(oPieChart_CtrmAmountRate != undefined){
				oPieChart_CtrmAmountRate.destroy();	
			}
			
			RPT008.createCtrmAmountRatePieChart();
		}
		
		
		<% //기납증/분증 발급비율 %>
		<% //02. 수량  %>
		this.createCtrmQtyRatePieChart = function() {
				var postData = KpackageOBJ.data.makePostData("RPT008-form");
				KpackageOBJ.ajax.doSubmit("/report/rpt008_getCtrmQtyRate",
						postData, RPT008.drawCtrmQtyRatePieChart, null, false);

			}

			this.drawCtrmQtyRatePieChart = function(result) {
				var data = result.value;
				var label_arrayData = [], code_arrayData = [], data_arrayData = [], sumData = 0;

				if (result.success) {
					for (var i = 0; i < data.length; i++) {
						var tempLengthString = "";
						if (data[i]["LABEL_VALUE"].length > 10) {
							tempLengthString = data[i]["LABEL_VALUE"]
									.substring(0, 7)
									+ "...";
						} else {
							tempLengthString = data[i]["LABEL_VALUE"];
						}

						label_arrayData.push(tempLengthString);
						code_arrayData.push(data[i]["CODE_VALUE"]);
						data_arrayData.push(data[i]["DATA_VALUE"]);

					}

				}

				pieCtrmQtyRateData = {
					labels : label_arrayData,
					datasets : [ {
						label : '환급사용수량비율',
						data : data_arrayData,
						code_data : code_arrayData,
						backgroundColor : KpackageOBJ.pieChart.chartColor03
					} ]
				};

				var tgt_CanvasID = $('.ctrm_Qty_Rate_PieChartdiv').find(
						'canvas').prop('id');

				oPieChart_CtrmQtyRate = KpackageOBJ.chart.create("doughnut",
						tgt_CanvasID, pieCtrmQtyRateData,
						"구매확인서 대비 기납/분증 환급액 비율");
				/*
				$("#ccpy_Qty_Rate_PieChart").click(
					function(evt){
						try{
							var activePointsIndex, indexValue;
							activePointsIndex = oPieChart_CtrmQtyRate.tooltip._active[0]._index;
							indexValue = oPieChart_CtrmQtyRate.data.datasets[0].code_data[activePointsIndex];
							RPT008.retrieveRpt0080XGrid(indexValue, "HSCODE");
						}catch(e){}
					}
				);   
				 */

			}

			this.retrieveCtrmQtyRatePieChart = function() {
				if (oPieChart_CtrmQtyRate != undefined) {
					oPieChart_CtrmQtyRate.destroy();
				}

				RPT008.createCtrmQtyRatePieChart();
			}

			this.renderTuiGrid = function() {
				var colArrayInfo = [ {
					header : '신고번호',
					name : 'STTEMNT_NO',
					width : 120,
					align : "center",
					hidden : false
				}, {
					header : '제조자',
					name : 'MANUFAC_NAME',
					width : 200,
					align : "left",
					hidden : false
				},
				/* { header : '수출자',			name: 'COMPANY_CODE'  , width : 100,align: "center", resizable: true, hidden:false  }, */
				{
					header : '제품코드',
					name : 'ITEM_CODE',
					width : 150,
					align : "left",
					hidden : false
				}, {
					header : '품명',
					name : 'ITEM_NM',
					width : 200,
					align : "left",
					hidden : false
				}, {
					header : 'HS CODE',
					name : 'HS_CODE',
					width : 100,
					align : "center",
					hidden : false,
					formatter : KpackageOBJ.tuiGrid.hscode10
				}, {
					header : '목적국',
					name : 'NATION_CODE',
					width : 80,
					align : "center",
					hidden : false
				}, {
					header : '제품수량',
					name : 'ACCMLT_ORDER_QY',
					width : 100,
					align : "right",
					hidden : false,
					formatter : KpackageOBJ.tuiGrid.commas
				}, {
					header : '환급사용수량',
					name : 'USGQTY',
					width : 100,
					align : "right",
					hidden : false,
					formatter : KpackageOBJ.tuiGrid.commas
				}, {
					header : '금액',
					name : 'STTEMNT_PC_KRW',
					width : 100,
					align : "right",
					hidden : false,
					formatter : KpackageOBJ.tuiGrid.commas
				}, {
					header : '총 납부세액',
					name : 'TOT_TAX',
					width : 100,
					align : "right",
					hidden : false,
					formatter : KpackageOBJ.tuiGrid.commas
				}, {
					header : '환급금액',
					name : 'DRWBAK_AMOUNT',
					width : 100,
					align : "right",
					hidden : false,
					formatter : KpackageOBJ.tuiGrid.commas
				} ];

				KpackageOBJ.tuiGrid.create("oTui_RPT008_01_List",
						"/report/retrieveRpt0080XList", colArrayInfo, "number",
						null);

			}

			this.retrieve_RPT008List = function() {
				$
						.when(RPT008.retrieveVendorDrwbakRatePieChart())
						.done(
								$
										.when($
												.when(
														RPT008
																.retrieveVendorDrwbakUsedQtyBarchart())
												.done(
														$
																.when($
																		.when(
																				RPT008
																						.retrieveVendorTaxByDrwBakRateBarChart())
																		.done(
																				$
																						.when(RPT008
																								.retrieveItemCodeDrwbakRatePieChart()))
																		.done(
																				$
																						.when(
																								RPT008
																										.retrieveItemCodeDrwbakUsedQtyBarchart())
																						.done(
																								$
																										.when(
																												RPT008
																														.retrieveItemCodeTaxByDrwBakRateBarChart())
																										.done(
																												$
																														.when(
																																RPT008
																																		.retrieveHsCodeDrwbakRatePieChart())
																														.done(
																																$
																																		.when(
																																				RPT008
																																						.retrieveHsCodeDrwbakUsedQtyBarchart())
																																		.done(
																																				$
																																						.when(
																																								RPT008
																																										.retrieveHsCodeTaxByDrwBakRateBarChart())
																																						.done(
																																								$
																																										.when(
																																												RPT008
																																														.retrieveNationCodeDrwbakRatePieChart())
																																										.done(
																																												$
																																														.when(
																																																RPT008
																																																		.retrieveNationCodeDrwbakUsedQtyBarchart())
																																														.done(
																																																$
																																																		.when(
																																																				RPT008
																																																						.retrieveNationCodeTaxByDrwBakRateBarChart())
																																																		.done(
																																																				$
																																																						.when(
																																																								RPT008
																																																										.retrieveCcpyAmountRatePieChart())
																																																						.done(
																																																								$
																																																										.when(
																																																												RPT008
																																																														.retrieveCcpyQtyRatePieChart())
																																																										.done(
																																																												$
																																																														.when(
																																																																RPT008
																																																																		.createCtrmAmountRatePieChart())
																																																														.done(
																																																																RPT008
																																																																		.createCtrmQtyRatePieChart()))))))))))))))));
			}

			this.retrieveRpt0080XGrid = function(arg, arg2) {
				var postData = KpackageOBJ.data.makePostData("RPT008-form");
				postData["DETAIL_CODE"] = arg;
				postData["TAB_SEARCH_TYPE"] = arg2;

				KpackageOBJ.tuiGrid.retrieve("oTui_RPT008_01_List",
						"/report/retrieveRpt0080XList", postData);

			}

			this.retrieveRpt0080XGrid_IMPDEC = function(arg, arg2) {
				var postData = KpackageOBJ.data.makePostData("RPT008-form");
				postData["DETAIL_CODE"] = arg;
				postData["TAB_SEARCH_TYPE"] = arg2;

				KpackageOBJ.tuiGrid.retrieve("oTui_RPT008_01_List",
						"/report/retrieveRpt0080XList_IMPDEC", postData);

			}

		}

		$(document).ready(function() {
			pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
			RPT008.Initialize_viewObject(); // 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
		});
	</script>
</body>
</html>