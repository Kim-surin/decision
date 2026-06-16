<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>KPMG - Draw Back System</title>

    <link rel="stylesheet" type="text/css" media="screen" href="/rcs/js/plugin/apexcharts-2.6.6/dist/apexcharts.css">
    <script src="/rcs/js/plugin/apexcharts-2.6.6/dist/apexcharts.js"></script>
	<script src="/rcs/js/polyfill.js"></script>
	<script src="/rcs/js/chartjs_v451/chart.js"></script>
	<script src="/rcs/js/package.chartjs.utils.js"></script>
	

    
    
<style type="text/css">
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
    
.dashboaard_wgt_header {
display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    background: #fff;
    min-height: 3rem;
    border-bottom: 1px solid rgba(0, 0, 0, 0.07);
    border-radius: 4px 4px 0 0;
    -webkit-transition: background-color 0.4s ease-out;
    transition: background-color 0.4s ease-out;
    }
    
.jarviswidget>header {
    color: #333;
    background: #FFF;
    border: 0px;
    border-bottom: 1px solid rgba(0, 0, 0, 0.07);
}
.jarviswidget>div {
    
    border-width: 0px 0px 0px;
    border-style: solid;
}
.btn-outline-info:hover {
    color: #fff !important;
}

.mainDownBtn{
	cursor:pointer;
	box-shadow: 0 4px 16px rgba(0, 0, 0, 0.25), 0 0px 0px rgba(0, 0, 0, 0.22);
}
.mainDownBtn:hover{
	cursor:pointer;
	box-shadow:  0 6px 4px rgba(0, 0, 0, 0.12), 0 2px 2px rgba(0, 0, 0, 0.24);
}

			
</style>
</head>
<div class="subheader" style="padding-top: 20px;">
    <h1 class="subheader-title" style="font-size: 20px;">
        <i class='subheader-icon fal fa-chart-area'></i> Analytics <span class='fw-300'>Dashboard</span>
        <small>
        </small>
    </h1>

</div>
<div class="row">
    <div class="col-lg-12 sortable-grid ui-sortable">
        <div id="panel-1" class="panel panel-locked panel-sortable" data-panel-lock="false" data-panel-close="false" data-panel-fullscreen="false" data-panel-collapsed="false" data-panel-color="false" data-panel-refresh="false" data-panel-reset="false" role="widget">
            <div class="panel-hdr" role="heading">
                <h2 class="ui-sortable-handle" style="font-size: 15px;">Monthly Drwaback Report</h2>

            </div>
            <div class="panel-container show" role="content">
                <div class="panel-content border-faded border-left-0 border-right-0 border-top-0">
                    <div class="row">
                        <div class="col-3">
                        	<canvas id="myChart1"></canvas>
                        </div>
                        <div class="col-3">
                        	<canvas id="myChart2"></canvas>
                        </div>
                        <div class="col-3">
                        	<canvas id="myChart3"></canvas>
                        </div>
                        <div class="col-3">
                        	<canvas id="myChart4"></canvas>
                        </div>
                        <div class="col-3">
                        	<canvas id="myChart5"></canvas>
                        </div>
                        <div class="col-3">
                        	<canvas id="myChart6"></canvas>
                        </div>
                        <div class="col-3">
                        	<canvas id="floatingBarChart"></canvas>
                        </div>
                        <div class="col-3">
                        	<canvas id="myChart8"></canvas>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</div><!-- row End -->


<script>
	

var HOME_DASHBOARD = new function () {

    /**
     * 페이지 초기화
     * ------------------------------------------------------------
     * [용도]
     * - 화면 진입 시 차트 생성
     */
    this.initPage = function () {
        this.createBasicCharts();
        this.createParsingChart();
        this.createMixedChart();
        this.createFloatingBarChart();
        this.bindEvents();
    };

    /**
     * 기본 차트(doughnut, bar, pie, line) 생성
     * ------------------------------------------------------------
     * [용도]
     * - 동일한 data 구조를 이용해 여러 타입 차트를 생성
     */
    this.createBasicCharts = function () {
        var data = {
            labels: ['Red', 'Blue', 'Yellow'],
            datasets: [{
                label: 'My First Dataset',
                data: [300, 50, 100],
                backgroundColor: [
                    'rgb(255, 99, 132)',
                    'rgb(54, 162, 235)',
                    'rgb(255, 205, 86)'
                ],
                hoverOffset: 4
            }]
        };

        ChartUtil.createDoughnut("myChart1", data);
        ChartUtil.createBar("myChart2", data);
        ChartUtil.createPie("myChart3", data);
        ChartUtil.createLine("myChart4", data);
    };

    /**
     * parsing 기반 bar chart 생성
     * ------------------------------------------------------------
     * [용도]
     * - object 배열을 parsing 방식으로 dataset 구성
     */
    this.createParsingChart = function () {
        var rows = [
            { x: 'Jan', net: 100, cogs: 50, gm: 50 },
            { x: 'Feb', net: 120, cogs: 55, gm: 75 }
        ];

        var chartData = ChartUtil.adapter.toParsingDatasets(rows, "x", [
            { key: "net", label: "Net sales" },
            { key: "cogs", label: "Cost of goods sold" },
            { key: "gm", label: "Gross margin" }
        ]);

        ChartUtil.createBar("myChart5", chartData);
    };

    /**
     * mixed chart 생성
     * ------------------------------------------------------------
     * [용도]
     * - bar + line 혼합 차트 생성
     */
    this.createMixedChart = function () {
        ChartUtil.createMixed("myChart6", {
            type: "bar",
            data: {
                labels: ['January', 'February', 'March', 'April'],
                datasets: [
                    {
                        label: 'Bar Dataset',
                        data: [10, 20, 30, 40],
                        order: 2
                    },
                    {
                        label: 'Line Dataset',
                        data: [10, 10, 30, 20],
                        type: 'line',
                        order: 1
                    }
                ]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: true
                    }
                }
            }
        });
    };

    /**
     * floating bar chart 생성
     * ------------------------------------------------------------
     * [용도]
     * - helper를 이용해 범위형 데이터 생성 후 floating bar 생성
     */
    this.createFloatingBarChart = function () {
        var labels = ['A', 'B', 'C', 'D', 'E', 'F'];
        var result = ChartUtil.helper.createFloatingRangeData(6, -100, 50, 100);

        ChartUtil.createFloatingBar("floatingBarChart", labels, result, {
            scales: {
                y: {
                    min: -100,
                    max: 100
                }
            }
        });
    };

    /**
     * 차트 이벤트 바인딩
     * ------------------------------------------------------------
     * [용도]
     * - 차트 클릭/hover 이벤트 처리
     */
    this.bindEvents = function () {

        // 예시: bar 차트 클릭 이벤트
        ChartUtil.bindClickEvent("myChart2", function (result, evt) {
            if (!result) return;

            console.log("[myChart2 click]");
            console.log("datasetLabel :", result.datasetLabel);
            console.log("label :", result.label);
            console.log("value :", result.value);
        });

        // 예시: mixed chart 더블클릭 이벤트
        ChartUtil.bindDblClickEvent("myChart6", function (result, evt) {
            if (!result) return;

            console.log("[myChart6 dblclick]");
            console.log("datasetLabel :", result.datasetLabel);
            console.log("label :", result.label);
            console.log("value :", result.value);
        });

        // 예시: floating bar hover 이벤트
        ChartUtil.bindHoverEvent("floatingBarChart", function (result, evt) {
            var canvas = document.getElementById("floatingBarChart");

            if (result) {
                canvas.style.cursor = "pointer";
            } else {
                canvas.style.cursor = "default";
            }
        });

        // 예시: floating bar 클릭
        ChartUtil.bindClickEvent("floatingBarChart", function (result, evt) {
            if (!result) return;

            console.log("[floatingBarChart click]");
            console.log("label :", result.label);
            console.log("start :", result.value[0]);
            console.log("end :", result.value[1]);
        });
    };
};

$(document).ready(function () {
    pageSetUp(); // 위젯 기능을 사용하기 위해 필수 호출
    HOME_DASHBOARD.initPage();
});
</script>
</body>
</html>