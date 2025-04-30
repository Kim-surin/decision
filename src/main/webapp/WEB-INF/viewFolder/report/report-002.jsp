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
	
	
</head>
<body>

	<section id="widget-grid-RPT002" class="">
		<form:form id="RPT002-form" class="s4-form" novalidate="novalidate" action="/report-RPT002" method="post">
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;" />
								<col style="width: 25%;" />
								<col style="width: 80px;" />
                                <col style="width: 15%;" />
								<col style="width: 80px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='기준일자' /></th>
									<td>
										<input type="text" id="CAL_SEARCH_FROM_DATE"  name="CAL_SEARCH_FROM_DATE" style="width:120px" class="inputText" searchfnc="RPT002.retrieve_RPT002List"/>
                                        <span class="fromTo-Dash">~</span>
										<input type="text" id="CAL_SEARCH_TO_DATE"  name="CAL_SEARCH_TO_DATE" style="width:120px" class="inputText" searchfnc="RPT002.retrieve_RPT002List"/>
										<input type="hidden" id="SEARCH_FROM_DATE"  name="SEARCH_FROM_DATE"/>
										<input type="hidden" id="SEARCH_TO_DATE"  name="SEARCH_TO_DATE"/>
									</td>
									<th><spring:message code='구분' /></th>
                                    <td>
                                        <select class="form-control searchSelect" id="RAWMTRL_SE" name="RAWMTRL_SE" style="width:170px"></select>
                                    </td>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:90px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:100px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText" searchfnc="RPT002.retrieve_RPT002List"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:RPT002.retrieve_RPT002List();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			
			</div>
		</form:form>
		
		
		<div class="row">
			
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<ul id="chart_Tab" class="nav nav-tabs bordered">
					<li class="active">
						<a href="#chart_01" data-toggle="tab" aria-expanded="true">양도자(수출자)별</a>
					</li>
					<li class="">
						<a href="#chart_02" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>자재코드 별</a>
					</li>
					<li class="">
						<a href="#chart_03" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>HS Code 별</a>
					</li>
				</ul>
				<div id="chart_TabContent" class="tab-content padding-10" style="background: #FFF;display: inline-block;width: 100%;height: 395px;">
					<div class="tab-pane fade active in" id="chart_01">
						<div class="col-sm-6">
							<div class="exporter_BalanceRate_PieChartdiv">
								<canvas id="exporter_BalanceRate_PieChart" height="150" data-rate-flag="true"></canvas>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="exporter_balanceQty_Barchartdiv">
								<canvas id="exporter_balanceQty_Barchart" height="150" ></canvas>
							</div>
						</div>
					
					</div>
					<div class="tab-pane fade" id="chart_02">
						<div class="col-sm-6">
							<div class="itemCode_balanceTax_Barchartdiv">
								<canvas id="itemCode_balanceTax_Barchart" height="150" ></canvas>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="itemCode_balanceQty_Barchartdiv">
								<canvas id="itemCode_balanceQty_BarchartChart" height="150" data-rate-flag="true"></canvas>
							</div>
						</div>
						
					</div>
					<div class="tab-pane fade" id="chart_03">
						<div class="col-sm-6">
							<div class="hsCode_balanceTax_Barchartdiv">
								<canvas id="hsCode_balanceTax_Barchart" height="150" ></canvas>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="hsCode_balanceQty_Barchartdiv">
								<canvas id="hsCode_balanceQty_BarchartChart" height="150"  data-rate-flag="true"></canvas>
							</div>
						</div>
					</div>
				
				</div>
			</div>
		</div>
		<div class="row">
			<article class="col-sm-12">
				<!-- Widget ID (each widget will need unique ID)-->
				<div class="jarviswidget" id="wid-id-1" data-widget-editbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false"  style="margin-bottom: 5px;">
					<header>
						<h2><i class="fa fa-lg fa-fw fa-bar-chart-o"></i>상세내역</h2>		
					</header>
					<!-- widget div-->
					<div>
						<!-- widget content -->
						<div class="widget-body" style="position: relative;">
							<div id="div_oTui_RPT002_03_List" name="div_oTui_RPT002_03_List" class="">
								<div id="oTui_RPT002_03_List" data-minus-height="755"></div>
								<div id="oTui_RPT002_03_List_paging"></div>
							</div>
						</div>
						<!-- end widget content -->
					</div>
					<!-- end widget div -->
				</div>
				<!-- end widget -->
			</article>
		</div>
		  <% /*
		<div class="row">
        <!-- 우측 영역 -->
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <ul id="toastGrid_01Tab" class="nav nav-tabs bordered">
                    <li class="active">
                        <a href="#tg01_01" data-toggle="tab" aria-expanded="true">기납증</a>
                    </li>
                    <li class="">
                        <a href="#tg01_02" data-toggle="tab" aria-expanded="false"><i class="fa fa-fw fa-lg fa-gear"></i>분증/환급신청서</a>
                    </li>
                </ul>
              
                <div id="toastGrid_01TabContent" class="tab-content padding-10" style="background: #FFF;display: inline-block;width: 100%">
                    <div class="tab-pane fade active in" id="tg01_01" >
                        <div class="col-sm-12">
                            <div id="div_oTui_RPT002_01_List" name="div_oTui_RPT002_01_List" class="tuigrid-resizable">
                                <div id="oTui_RPT002_01_List" data-fixed-height="270"></div>
                                <div id="oTui_RPT002_01_List_paging"></div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="tg01_02">
                        <div class="col-sm-12">
                            <div id="div_oTui_RPT002_02_List" name="div_oTui_RPT002_02_List" class="tuigrid-resizable">
                                <div id="oTui_RPT002_02_List" data-fixed-height="270"></div>
                                <div id="oTui_RPT002_02_List_paging"></div>
                            </div>
                        </div>
                    </div>
                </div>
               
            </div>
           
        </div>
        */%>
	</section>



<script>
	//양도자(수출자별) 차트
	var oPieChart_ExporterBalanceTax, pieExporterbalanceTaxData;
	var oBarChart_ExporterBalanceQty, barExporterBalanceQtyData;
	
	//자재코드 별 차트
	var oBarChart_ItemCodeBalanceTax, barItemCodebalanceTaxData;
	var oBarChart_ItemCodeBalanceQty, barItemCodeBalanceQtyData;
		
	//HS CODE 별 차트
	var oBarChart_HsCodeBalanceTax, barHsCodebalanceTaxData;
	var oPieChart_HsCodeBalanceQty, pieHsCodeBalanceQtyData;
	
	
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
	
	var RPT002 = new function(){

	
		this.Initialize_viewObject = function() {
	
			var fromDay = KpackageOBJ.date.getCurrMonth() + "01";
			var toDay = KpackageOBJ.date.getCurrDay();
			
			/* Test Code  Start */
			//fromDay = "20210101";
			//toDay = "20211231";
			/* Test Code  End */
			KpackageOBJ.calendar.create("RPT002-form", "CAL_SEARCH_FROM_DATE");
			KpackageOBJ.calendar.setValue("RPT002-form","CAL_SEARCH_FROM_DATE", fromDay);
			KpackageOBJ.object.setFormValue("RPT002-form","SEARCH_FROM_DATE", fromDay);
			
			KpackageOBJ.calendar.create("RPT002-form", "CAL_SEARCH_TO_DATE");
			KpackageOBJ.calendar.setValue("RPT002-form","CAL_SEARCH_TO_DATE", toDay);
			KpackageOBJ.object.setFormValue("RPT002-form","SEARCH_TO_DATE", toDay);
			
			
	
			/*Search Type Select Box Create */
			arrayItem = [{value:"ITEM_CODE", name:"<spring:message code='자재코드'/>"}
						,{value:"IMPDEC_NO", name:"<spring:message code='수입면장번호'/>"}
						];
			
			KpackageOBJ.selectbox.create("RPT002-form", "SEARCH_TYPE", "", null, "value", "name", arrayItem);
			
			/*Search Type Select Box Create */
			arrayItem = [{value:"CC", name:"<spring:message code='common.txt.contains'/>"}
			            ,{value:"EQ", name:"<spring:message code='common.txt.equalTo'/>"}
						,{value:"SW", name:"<spring:message code='common.txt.startsWithIs'/>"}];
			
			KpackageOBJ.selectbox.create("RPT002-form", "SEARCH_OPTION", "", null, "value", "name", arrayItem);
			
			
			KpackageOBJ.selectbox.create("RPT002-form", "RAWMTRL_SE",  "/common/retrieveComCdList", {"CATEGORY_CD":"LMC","OPTION_ALL":"Y"}, "CODE", "NAME");
			
			
			RPT002.renderTuiGrid();
			// 탭 클릭 이벤트 등록
			$("#toastGrid_01Tab.nav.nav-tabs li").click(function(){setTimeout(RPT002.resizengGridEvent, 300);});
		}
		
		
		this.resizengGridEvent = function(){
			/* 그리드 사이즈 불량 보완 */
			if(oneTimeKey){
				KpackageOBJ.tuiGrid.reSizingGrid("oTui_RPT002_02_List");
				oneTimeKey = false;
			}
			
		}
		
		/* 양도자 별 차트 */
		this.createExporterBalanceTaxPieChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT002-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt002_getExporterBalanceTax", postData, RPT002.drawExporterBalanceTaxPieChart, null, false);
		}
		
		this.drawExporterBalanceTaxPieChart = function(result){
			var data = result.value;
			var balanceTaxLabelData = [], 
				balanceTaxCodeData = [],
			    balanceQtyData = [],
			    balanceTooltipData = [],
			    sumData = 0;
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					balanceTaxLabelData.push(data[i]["VENDOR_NAME"]);
					balanceTaxCodeData.push(data[i]["VENDOR_CODE"]);
					balanceQtyData.push(Math.round(data[i]["SUM_VALUE"]));
					balanceTooltipData.push(data[i]["TOOLTIP_VAL"]);
				}
				
			}
			
			pieExporterbalanceTaxData = {
	            labels: balanceTaxLabelData,
	            datasets: [{
	                label: '잔량 세액',
	                data: balanceQtyData,
	                code_data: balanceTaxCodeData,
	                tooptip_data : balanceTooltipData,
	                backgroundColor: KpackageOBJ.pieChart.chartColor03
	            }]
			};		

			var salesPieChartId = $('.exporter_BalanceRate_PieChartdiv').find('canvas').prop('id');
			
			oPieChart_ExporterBalanceTax = new Chart(document.getElementById(salesPieChartId),{
				type: 'doughnut',
				data: pieExporterbalanceTaxData,
				options: {
					responsive: true,
	                title: {
						display: true,
						text: '잔량세액',
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
		                        return data.labels[tooltipItems.index] + ' : ' + KpackageOBJ.formatter.commas(data.datasets[tooltipItems.datasetIndex].tooptip_data[tooltipItems.index]);
		                    }
		                }
		            }
			        
				}
			});
			
			$("#exporter_BalanceRate_PieChart").click(
				function(evt){
					
					try{
						var activePointsIndex, indexValue;
						activePointsIndex = oPieChart_ExporterBalanceTax.tooltip._active[0]._index;
						indexValue = oPieChart_ExporterBalanceTax.data.datasets[0].code_data[activePointsIndex];
						RPT002.retrieveRpt0020XGrid(indexValue, "VENDOR","");
					}catch(e){}
				}
			);   
		}
		
		
		this.createExporterBalanceQtyBarChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT002-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt002_getExporterBalanceQty", postData, RPT002.drawExporterBalanceQtyChart, null, false, "05");
		}
		
		this.drawExporterBalanceQtyChart = function(result){
			
			var data = result.value;
			var balanceQtyLabelData = [], 
			    balanceQtyData = [],  
			    balanceTooltipData = [], 
			    balanceQtyCodeData = [];
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					balanceQtyLabelData.push((data[i].VENDOR_NAME).substring(0,8)+"...");
					balanceQtyData.push(Math.round(data[i]["SUM_VALUE"] / 1000000));
					balanceQtyCodeData.push(data[i].VENDOR_CODE);
					balanceTooltipData.push(data[i].VENDOR_NAME);
				}
			}
			
			barExporterBalanceQtyData = {
	            labels: balanceQtyLabelData,
	            tooptips:balanceTooltipData,
	            datasets: [{
	            	type: 'bar',
	                label: '잔량수량',
	                backgroundColor: '#0091da',
	                data: balanceQtyData,
	                code_data: balanceQtyCodeData
	            }]
			};


			var barChartId = $('.exporter_balanceQty_Barchartdiv').find('canvas').prop('id');
			
			oBarChart_ExporterBalanceQty = new Chart(document.getElementById(barChartId), {
	            type: 'bar',
	            data: barExporterBalanceQtyData,
	            options: {
	                responsive: true,
	                title: {
						display: true,
						text: '잔량수량',
						fontSize: 15,
						padding: 20
					},
					layout: {
						padding: {
							top: 25,
							bottom:25
						}
					},
					scales: {
						xAxes: [{
							display: true,
							maxBarThickness: 20 
							}],
						yAxes: [{
							display: true,
							position: 'left',
							scaleLabel: {
								display: true,
								labelString: '(기준: 1,000,000)'
							},						
							ticks: {
								callback: function(value, index, values) {
			                        return KpackageOBJ.formatter.commas(value);
			                    }
							}
						}]
					},
					tooltips :{
						callbacks : {
			                enabled: true,
			                mode: 'single',
							label : function(tooltipItems, data){
								return data.tooptips[tooltipItems.index]+ ' : ' + KpackageOBJ.formatter.commas(data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index]);
							}
						}
					},
					legend: {
						position: 'bottom'
			        }
	            }
	        });
			$("#exporter_balanceQty_Barchart").click(
				function(evt){
					try{
						var activePointsIndex, indexValue;
						
						activePointsIndex = oBarChart_ExporterBalanceQty.tooltip._active[0]._index;
						indexValue = oBarChart_ExporterBalanceQty.data.datasets[0].code_data[activePointsIndex];
							
						RPT002.retrieveRpt0020XGrid(indexValue, "VENDOR","");
					}catch(e){}
				}
			); 
		}
		
		/* 자재코드별 차트 */
		this.createItemCodeBalanceTaxBarChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT002-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt002_getItemCodeBalanceTax", postData, RPT002.drawItemCodeBalanceTaxChart, null, false, "05");
		}
		
		
		this.drawItemCodeBalanceTaxChart = function(result){
			
			var data = result.value;
			var balanceQtyLabelData = [], 
			    balanceQtyData = [], 
			    balanceTooltipData = [], 
			    balanceQtyCodeData = [];
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					balanceQtyLabelData.push((data[i].ITEM_NM).substring(0,5)+"...");
					balanceQtyData.push(Math.round(data[i]["SUM_VALUE"] / 1000000));
					balanceQtyCodeData.push(data[i].ITEM_CODE);
					balanceTooltipData.push(data[i].ITEM_NM);
				}
			}
			barItemCodebalanceTaxData = {
	            labels: balanceQtyLabelData,
	            tooptips:balanceTooltipData,
	            datasets: [{
	            	type: 'bar',
	                label: '잔량세액',
	                backgroundColor: '#0091da',
	                data: balanceQtyData,
	                code_data: balanceQtyCodeData
	            }]
			};

			var barChartId = $('.itemCode_balanceTax_Barchartdiv').find('canvas').prop('id');
			oBarChart_ItemCodeBalanceTax = new Chart(document.getElementById(barChartId), {
	            type: 'bar',
	            data: barItemCodebalanceTaxData,
	            options: {
	                responsive: true,
	                title: {
						display: true,
						text: '잔량세액',
						fontSize: 15,
						padding: 20
					},
					layout: {
						padding: {
							top: 25	
						}
					},
					responsive: true,
					scales: {
						xAxes: [{
							display: true,
							maxBarThickness: 20 
							}],
						yAxes: [{
							display: true,
							position: 'left',
							scaleLabel: {
								display: true,
								labelString: '(기준: 1,000,000)'
							},						
							ticks: {
								callback: function(value, index, values) {
			                        return KpackageOBJ.formatter.commas(value);
			                    }
							}
						}]
					},
					tooltips :{
						callbacks : {
							label : function(tooltipItems, data){
								return data.tooptips[tooltipItems.index]+ ' : ' + KpackageOBJ.formatter.commas(data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index]);
							}
						}
					},
					legend: {
						position: 'bottom'
			        }
	            }
	        });
			$("#itemCode_balanceTax_Barchart").click(
				function(evt){
					try{
						var activePointsIndex, indexValue, indexValueName;
						activePointsIndex = oBarChart_ItemCodeBalanceTax.tooltip._active[0]._index;
						indexValue = oBarChart_ItemCodeBalanceTax.data.datasets[0].code_data[activePointsIndex];
						indexValueName = oBarChart_ItemCodeBalanceTax.data.tooptips[activePointsIndex];
						
						
						RPT002.retrieveRpt0020XGrid(indexValue, "ITEM", indexValueName);
					}catch(e){}
				}
			);			
		}
		
		this.createItemCodeBalanceQtyPieChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT002-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt002_getItemCodeBalanceQty", postData, RPT002.drawItemCodeBalanceQtyPieChart, null, false);
		}
		
		this.drawItemCodeBalanceQtyPieChart = function(result){
			var data = result.value;
			var labelData = [], 
				codeData = [],
			    viewData = [],
			    full_labelData = [],
			    balanceTooltipData = [];
			    
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					
					labelData.push((data[i].ITEM_NM).substring(0,5)+"...");
					full_labelData.push(data[i].ITEM_NM);
					codeData.push(data[i].ITEM_CODE);
					viewData.push(Math.round(data[i]["SUM_VALUE"]));
					balanceTooltipData.push(data[i]["TOOLTIP_VAL"]);
						
				}
			}
			
			barItemCodeBalanceQtyData = {
	            labels: labelData,
	            full_labelData : full_labelData,
	            datasets: [{
	                label: '잔량 수량',
	                data: viewData,
	                code_data: codeData,
	                tooptip_data : balanceTooltipData,
	                backgroundColor: KpackageOBJ.pieChart.chartColor03
	            }]
			};		

			var barChartId = $('.itemCode_balanceQty_Barchartdiv').find('canvas').prop('id');
			
			
			oBarChart_ItemCodeBalanceQty = new Chart(document.getElementById(barChartId), {
	            type: 'bar',
	            data: barItemCodeBalanceQtyData,
	            options: {
	                responsive: true,
	                title: {
						display: true,
						text: '잔량수량',
						fontSize: 15,
						padding: 20
					},
					layout: {
						padding: {
							top: 25	
						}
					},
					scales: {
						xAxes: [{
							display: true,
							maxBarThickness: 20 
							}],
						yAxes: [{
							display: true,
							position: 'left',
							scaleLabel: {
								display: false,
								labelString: ''
							},						
							ticks: {
								callback: function(value, index, values) {
			                        return KpackageOBJ.formatter.commas(value);
			                    }
							}
						}]
					},
					tooltips :{
						callbacks : {
			                enabled: true,
			                mode: 'single',
							label : function(tooltipItems, data){
								return data.full_labelData[tooltipItems.index]+ ' : ' + KpackageOBJ.formatter.commas(data.datasets[tooltipItems.datasetIndex].tooptip_data[tooltipItems.index]);
							}
						}
					},
					legend: {
						position: 'bottom'
			        }
	            }
	        });
			
			
			
			$("#itemCode_balanceQty_BarchartChart").click(
					
				function(evt){
					try{
						var activePointsIndex, indexValue, indexValueName;
						activePointsIndex = oBarChart_ItemCodeBalanceQty.tooltip._active[0]._index;
						indexValue = oBarChart_ItemCodeBalanceQty.data.datasets[0].code_data[activePointsIndex];
						indexValueName = oBarChart_ItemCodeBalanceQty.data.full_labelData[activePointsIndex];
						
						RPT002.retrieveRpt0020XGrid(indexValue, "ITEM",indexValueName);
					}catch(e){}
				}
			);   
		}
		
		
		
		/* HS CODE 별 차트 */
		this.createHsCodeBalanceTaxBarChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT002-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt002_getHsCodeBalanceTax", postData, RPT002.drawHsCodeBalanceTaxChart, null, false, "05");
		}
		
		
		this.drawHsCodeBalanceTaxChart = function(result){
			
			var data = result.value;
			var label_ArrayData = [], 
			    value_ArrayData = [], 
			    code_ArrayData = [];
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					label_ArrayData.push(KpackageOBJ.formatter.hscode10(data[i].HS_CODE));
					value_ArrayData.push(Math.round(data[i]["SUM_VALUE"] /1000000));
					code_ArrayData.push(data[i].HS_CODE);
					
				}
			}
			barHsCodebalanceTaxData = {
	            labels: label_ArrayData,
	            datasets: [{
	            	type: 'bar',
	                label: '잔량세액',
	                backgroundColor: '#0091da',
	                data: value_ArrayData,
	                code_data: code_ArrayData
	            }]
			};

			var barChartId = $('.hsCode_balanceTax_Barchartdiv').find('canvas').prop('id');
			oBarChart_HsCodeBalanceTax = new Chart(document.getElementById(barChartId), {
	            type: 'bar',
	            data: barHsCodebalanceTaxData,
	            options: {
	                responsive: true,
	                title: {
						display: true,
						text: '잔량세액',
						fontSize: 15,
						padding: 20
					},
					layout: {
						padding: {
							top: 25	
						}
					},
					responsive: true,
					scales: {
						xAxes: [{
							display: true,
							maxBarThickness: 20 
							}],
						yAxes: [{
							display: true,
							position: 'left',
							scaleLabel: {
								display: true,
								labelString: '(기준: 1,000,000)'
							},						
							ticks: {
								callback: function(value, index, values) {
			                        return KpackageOBJ.formatter.commas(value);
			                    }
							}
						}]
					},
					legend: {
						position: 'bottom'
			        }
	            }
	        });
			$("#hsCode_balanceTax_Barchart").click(
					
				function(evt){
					try{
						var activePointsIndex, indexValue;
						activePointsIndex = oBarChart_HsCodeBalanceTax.tooltip._active[0]._index;
						indexValue = oBarChart_HsCodeBalanceTax.data.datasets[0].code_data[activePointsIndex];
						
						RPT002.retrieveRpt0020XGrid(indexValue, "HSCODE","");
					}catch(e){}
				}
			);			
		}
		
		this.createHsCodeBalanceQtyPieChart = function() {
			var postData = KpackageOBJ.data.makePostData("RPT002-form");
			KpackageOBJ.ajax.doSubmit("/report/rpt002_getHsCodeBalanceQty", postData, RPT002.drawHsCodeBalanceQtyPieChart, null, false);
		}
		
		this.drawHsCodeBalanceQtyPieChart = function(result){
			var data = result.value;
			var label_ArrayData = [], 
				code_ArrayData = [],
				tooltip_ArrayData = [],
			    value_ArrayData = [];
			    
			
			if(result.success){
				for(var i=0 ; i<data.length ; i++){
					
					label_ArrayData.push(data[i].HS_CODE);
					code_ArrayData.push(data[i].HS_CODE);
					value_ArrayData.push(Math.round(data[i]["SUM_VALUE"]));
					tooltip_ArrayData.push(data[i]["TOOLTIP_VAL"]);
						
				}
				
			}
			
			pieItemCodevalue_ArrayData = {
	            labels: label_ArrayData,
	            datasets: [{
	                label: '잔량 수량',
	                data: value_ArrayData,
	                code_data: code_ArrayData,
	                tooptip_data : tooltip_ArrayData,
	                backgroundColor: KpackageOBJ.pieChart.chartColor03
	            }]
			};		

			var salesPieChartId = $('.hsCode_balanceQty_Barchartdiv').find('canvas').prop('id');
			
			
			oPieChart_HsCodeBalanceQty = KpackageOBJ.chart.create("bar", salesPieChartId, pieItemCodevalue_ArrayData, "잔량수량");
			
			/*
			tooltips: {
                        enabled: true,
                        mode: 'single',
                        callbacks: {
                            label: function(tooltipItems, data) { 
                                //debugger;
                                return KpackageOBJ.formatter.hscode10(data.labels[tooltipItems.index]) + ' : ' + KpackageOBJ.formatter.commas(data.datasets[tooltipItems.datasetIndex].tooptip_data[tooltipItems.index]);
                            }
                        }
                    }
			*/
			$("#hsCode_balanceQty_BarchartChart").click(
				function(evt){
					try{
						var activePointsIndex, indexValue;
						activePointsIndex = oPieChart_HsCodeBalanceQty.tooltip._active[0]._index;
						indexValue = oPieChart_HsCodeBalanceQty.data.datasets[0].code_data[activePointsIndex];
						
						RPT002.retrieveRpt0020XGrid(indexValue, "HSCODE","");
					}catch(e){}
				}
			);   
		}
		
		
		
		
		
		
		
		
		
		
		this.renderTuiGrid = function() {
			 
			 var colArrayInfo = [
				 	{ header : '제출번호',     name: 'IMPDEC_NO', width : 120,align: "center", resizable: true, hidden:false  },
				 	{ header : '양도자',       name: 'VENDOR_NAME', width : 200,align: "left", resizable: true, hidden:false  },
				 	{ header : '양도일자',     name: 'EFECT_BGNDE', width : 100,align: "center", resizable: true, hidden:false ,formatter : KpackageOBJ.tuiGrid.dateFormatter  },
				 	{ header : '총수량',       name: 'QY', width : 100,align: "right", resizable: true, hidden:false ,formatter : KpackageOBJ.tuiGrid.commas  },
				 	{ header : '잔량',         name: 'REMNDR_QY', width : 100,align: "right", resizable: true, hidden:false ,formatter : KpackageOBJ.tuiGrid.commas  },
				 	{ header : '총 납부세액',  name: 'TOT_TAX', width : 100,align: "right", resizable: true, hidden:false ,formatter : KpackageOBJ.tuiGrid.commas  },
				 	{ header : '잔량세액',     name: 'REMND_TAX', width : 100,align: "right", resizable: true, hidden:false ,formatter : KpackageOBJ.tuiGrid.commas  },
				 	{ header : '만료일자',     name: 'EXPR_DATE', width : 100,align: "center", resizable: true, hidden:false ,formatter : KpackageOBJ.tuiGrid.dateFormatter  }
			    ];
			 /*
			 grid01 = KpackageOBJ.tuiGrid.create("oTui_RPT002_01_List", "/report/retrieveRpt00201List", colArrayInfo, "number", null);
			 grid02 = KpackageOBJ.tuiGrid.create("oTui_RPT002_02_List", "/report/retrieveRpt00202List", colArrayInfo, "number", null);
			 */
			 
			 colArrayInfo = [
				 	{ header : '제출번호',     	name: 'IMPDEC_NO'  , width : 120,align: "center", resizable: true, hidden:false  },
				 	{ header : '구분',        	name: 'RAWMTRL_SE_NAME'  , width : 120,align: "center", resizable: true, hidden:false  },
				 	{ header : '양도자',       	name: 'VENDOR_NAME'  , width : 200,align: "left", resizable: true, hidden:false  },
				 	{ header : '자재코드',     	name: 'ITEM_CODE'  , width : 180,align: "left", resizable: true, hidden:false  },
				 	{ header : '품명',         	name: 'ITEM_NM'    , width : 200,align: "left", resizable: true, hidden:false  },
				 	{ header : 'HS CODE',       	name: 'HS_CODE'    , width : 100,align: "center", resizable: true, hidden:false ,formatter : KpackageOBJ.tuiGrid.hscode10  },
				 	{ header : '양도일자',     	name: 'EFECT_BGNDE', width : 100,align: "center", resizable: true, hidden:false ,formatter : KpackageOBJ.tuiGrid.dateFormatter  },
				 	{ header : '만료일자',     	name: 'EXPR_DATE', width : 100,align: "center", resizable: true, hidden:false   ,formatter : RPT002.customize_TuiGrid_DateFormatter  },
				 	{ header : '공급가격',     	name: 'PO_AMOUNT'  , width : 100,align: "right", resizable: true, hidden:false  ,formatter : KpackageOBJ.tuiGrid.commas  },
				 	{ header : '총수량',       	name: 'QY'         , width : 100,align: "right", resizable: true, hidden:false  ,formatter : KpackageOBJ.tuiGrid.commas  },
				 	{ header : '잔량',         	name: 'REMNDR_QY'  , width : 100,align: "right", resizable: true, hidden:false  ,formatter : KpackageOBJ.tuiGrid.commas  },
				 	{ header : '총 납부세액',  	name: 'TOT_TAX'    , width : 100,align: "right", resizable: true, hidden:false  ,formatter : KpackageOBJ.tuiGrid.commas  },
				 	{ header : '잔량세액',     	name: 'REMND_TAX'  , width : 100,align: "right", resizable: true, hidden:false  ,formatter : KpackageOBJ.tuiGrid.commas },
				 	{ header : '단축고시 해당유무',     name: 'SHORTEN_HSCODE'  , width : 100,align: "center", hidden: true  }
			    ];
			 
			 KpackageOBJ.tuiGrid.create("oTui_RPT002_03_List", "/report/retrieveRpt0020XList", colArrayInfo, "number", null);
			 
			 
		}
		
		this.customize_TuiGrid_DateFormatter = function(rowData){
			
			
			var returnData = KpackageOBJ.date.makeDateFormat(rowData.value);
			if((rowData.row.EXPR_DATE - rowData.row.EFECT_BGNDE) <= 30 ){
				returnData = "<div style='font-weight: bold;border-color: #fd3995!important;background-color: #fd3995!important;color: #fff!important;position: relative;display: block;font-size: .85em;line-height: 2;border-radius: 3px;'>" + KpackageOBJ.date.makeDateFormat(rowData.value) +"</div>";	
			}
			
			return returnData;
		}
		
		this.retrieve_RPT002List = function() {
			
			//$.when(RPT002.retrieveExporterBalanceTaxPieChart()).done(RPT002.retrieveExporter_balanceQty_Barchart());
			//;
			
			
			
			$.when(RPT002.retrieveExporterBalanceTaxPieChart())
				.done($.when(RPT002.retrieveExporter_balanceQty_Barchart())
					.done($.when(RPT002.retrieveItemCodeBalanceTaxPieChart())
						.done($.when(RPT002.retrieveItemCodeBalanceQty_PieChart())
							.done($.when(RPT002.retrieveHsCodeBalanceTaxBarChart())
								.done(RPT002.retrieveHsCodeBalanceQty_Piechart())))
			));
			
			;
			KpackageOBJ.tuiGrid.clear("oTui_RPT002_03_List");
		}
		
		this.retrieveExporterBalanceTaxPieChart = function() {
			if(oPieChart_ExporterBalanceTax != undefined){
				oPieChart_ExporterBalanceTax.destroy();	
			}
			
			RPT002.createExporterBalanceTaxPieChart();
		}
		
		this.retrieveExporter_balanceQty_Barchart = function() {
			if(oBarChart_ExporterBalanceQty != undefined){
				oBarChart_ExporterBalanceQty.destroy();	
			}
			
			RPT002.createExporterBalanceQtyBarChart();
		}
		//
		this.retrieveItemCodeBalanceTaxPieChart = function() {
			if(oBarChart_ItemCodeBalanceTax != undefined){
				oBarChart_ItemCodeBalanceTax.destroy();	
			}
			
			RPT002.createItemCodeBalanceTaxBarChart();
		}
		
		this.retrieveItemCodeBalanceQty_PieChart = function() {
			if(oBarChart_ItemCodeBalanceQty != undefined){
				oBarChart_ItemCodeBalanceQty.destroy();	
			}
			
			RPT002.createItemCodeBalanceQtyPieChart();
		}
		//
		
		this.retrieveHsCodeBalanceTaxBarChart = function() {
			if(oBarChart_HsCodeBalanceTax != undefined){
				oBarChart_HsCodeBalanceTax.destroy();	
			}
			
			RPT002.createHsCodeBalanceTaxBarChart();
		}
		
		this.retrieveHsCodeBalanceQty_Piechart = function() {
			if(oPieChart_HsCodeBalanceQty != undefined){
				oPieChart_HsCodeBalanceQty.destroy();	
			}
			
			RPT002.createHsCodeBalanceQtyPieChart();
		}
		
		
		
		
		
		
		this.retrieveRpt002Grid = function(){
			var postData = KpackageOBJ.data.makePostData("RPT002-form");
			KpackageOBJ.tuiGrid.retrieve("oTui_RPT002_01_List", "/report/retrieveRpt00201List", postData);
			KpackageOBJ.tuiGrid.retrieve("oTui_RPT002_02_List", "/report/retrieveRpt00202List", postData);
		}
		
		this.retrieveRpt0020XGrid = function(arg, arg2, argDt){
			var postData = KpackageOBJ.data.makePostData("RPT002-form");
			postData["KEY_VENDOR_CODE"] = arg;
			postData["TAB_SEARCH_TYPE"] = arg2;
			postData["KEY_CODE_DETAIL"] = argDt;
			
			KpackageOBJ.tuiGrid.retrieve("oTui_RPT002_03_List", "/report/retrieveRpt0020XList", postData);
		}
		
		
	}
	
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		RPT002.Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다. 
	});
</script>
</body>
</html>