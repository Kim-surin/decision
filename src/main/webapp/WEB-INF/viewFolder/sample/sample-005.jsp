<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    
    <!-- Flot Chart Plugin: Flot Engine, Flot Resizer, Flot Tooltip -->
    <script src="/rcs/js/plugin/flot/jquery.flot.cust.min.js"></script>
    <script src="/rcs/js/plugin/flot/jquery.flot.resize.min.js"></script>
    <script src="/rcs/js/plugin/flot/jquery.flot.fillbetween.min.js"></script>
    <script src="/rcs/js/plugin/flot/jquery.flot.orderBar.min.js"></script>
    <script src="/rcs/js/plugin/flot/jquery.flot.pie.min.js"></script>
    <script src="/rcs/js/plugin/flot/jquery.flot.time.min.js"></script>
    <script src="/rcs/js/plugin/flot/jquery.flot.tooltip.min.js"></script>
    <script src="/rcs/js/plugin/flot/jquery.colorhelpers.min.js"></script>
  
    
</head>
<body>
<div id="content">
	<section id="widget-grid" class="">
		<form:form id="search-form" class="s4-form" novalidate="novalidate">
			<input type="hidden" id="headers" name="headers"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="sheetname" name="sheetname"/>
			<div class="row-extends row">
				<div class="col-xs-12 col-sm-11 col-md-11 col-lg-11">
					<div class="table-responsive">
						<table class="table table-bordered">
							<colgroup>
								<col style="width: 80px;" />
								<col style="width: 15%;" />
								<col style="width: 80px;" />
								<col style="width: " />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code='common.title.useYn' /></th>
									<td>
										<select class="form-control searchSelect" id="DELETE_YN" name="DELETE_YN" style="width:110px"></select>
									</td>
									<th><spring:message code='common.title.searchCondition' /></th>
									<td>
										<select class="form-control searchSelect" id="SEARCH_TYPE" name="SEARCH_TYPE" style="width:110px"></select>
										<select class="form-control searchSelect" id="SEARCH_OPTION" name="SEARCH_OPTION" style="width:110px"></select>
										<input type="text" id="SEARCH_KEY_WORD" name="SEARCH_KEY_WORD" class="inputText">
									</td>
								</tr>
							</tbody>
						</table>
					</div>				
				</div>
				<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
					<div class="input-group-btn">
						<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:retrieve_gridData();">
							<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
						</button>
					</div>
				</div>
			</div>
		</form:form>
		<div class="row">
            <!-- NEW WIDGET START -->
                        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

                            <!-- Widget ID (each widget will need unique ID)-->
                            <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false" data-widget-attstyle="jarviswidget-color-white">
                                <!-- widget options:
                                usage: <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false">

                                data-widget-colorbutton="false"
                                data-widget-editbutton="false"
                                data-widget-togglebutton="false"
                                data-widget-deletebutton="false"
                                data-widget-fullscreenbutton="false"
                                data-widget-custombutton="false"
                                data-widget-collapsed="true"
                                data-widget-sortable="false"

                                -->
                                <header style="height: 54px;padding: 10px 0px;">
                                    <span class="widget-icon"> <i class="fa fa-bar-chart-o"></i> </span>
                                    <h2 style="font-weight: bold">Bar Chart</h2>

                                </header>

                                <!-- widget div-->
                                <div>

                                    <!-- widget edit box -->
                                    <div class="jarviswidget-editbox">
                                        <!-- This area used as dropdown edit box -->

                                    </div>
                                    <!-- end widget edit box -->

                                    <!-- widget content -->
                                    <div class="widget-body" style="">

                                        <div id="bar-chart" class="chart"></div>

                                    </div>
                                    <!-- end widget content -->

                                </div>
                                <!-- end widget div -->

                            </div>
                            <!-- end widget -->

                            <!-- Widget ID (each widget will need unique ID)-->
                            <div class="jarviswidget" id="wid-id-1" data-widget-editbutton="false">
                                <!-- widget options:
                                usage: <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false">

                                data-widget-colorbutton="false"
                                data-widget-editbutton="false"
                                data-widget-togglebutton="false"
                                data-widget-deletebutton="false"
                                data-widget-fullscreenbutton="false"
                                data-widget-custombutton="false"
                                data-widget-collapsed="true"
                                data-widget-sortable="false"

                                -->
                                <header>
                                    <span class="widget-icon"> <i class="fa fa-bar-chart-o"></i> </span>
                                    <h2>Sin Chart</h2>

                                </header>

                                <!-- widget div-->
                                <div>

                                    <!-- widget edit box -->
                                    <div class="jarviswidget-editbox">
                                        <!-- This area used as dropdown edit box -->

                                    </div>
                                    <!-- end widget edit box -->

                                    <!-- widget content -->
                                    <div class="widget-body no-padding">

                                        <div id="sin-chart" class="chart has-legend"></div>

                                    </div>
                                    <!-- end widget content -->

                                </div>
                                <!-- end widget div -->

                            </div>
                            <!-- end widget -->

                        </article>
                        <!-- WIDGET END -->
		</div>
		<div class="row">
            <!-- NEW WIDGET START -->
                        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

                            <!-- Widget ID (each widget will need unique ID)-->
                            <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false" data-widget-attstyle="jarviswidget-color-white">
                                <!-- widget options:
                                usage: <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false">

                                data-widget-colorbutton="false"
                                data-widget-editbutton="false"
                                data-widget-togglebutton="false"
                                data-widget-deletebutton="false"
                                data-widget-fullscreenbutton="false"
                                data-widget-custombutton="false"
                                data-widget-collapsed="true"
                                data-widget-sortable="false"

                                -->
                                <header style="height: 54px;padding: 10px 0px;">
                                    <span class="widget-icon"> <i class="fa fa-bar-chart-o"></i> </span>
                                    <h2 style="font-weight: bold">Bar Chart</h2>

                                </header>

                                <!-- widget div-->
                                <div>

                                    <!-- widget edit box -->
                                    <div class="jarviswidget-editbox">
                                        <!-- This area used as dropdown edit box -->

                                    </div>
                                    <!-- end widget edit box -->

                                    <!-- widget content -->
                                    <div class="widget-body">

                                        <div id="flot-toggles" class="chart"></div>

                                    </div>
                                    <!-- end widget content -->

                                </div>
                                <!-- end widget div -->

                            </div>
                            <!-- end widget -->

                            <!-- Widget ID (each widget will need unique ID)-->
                            <div class="jarviswidget" id="wid-id-1" data-widget-editbutton="false">
                                <!-- widget options:
                                usage: <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false">

                                data-widget-colorbutton="false"
                                data-widget-editbutton="false"
                                data-widget-togglebutton="false"
                                data-widget-deletebutton="false"
                                data-widget-fullscreenbutton="false"
                                data-widget-custombutton="false"
                                data-widget-collapsed="true"
                                data-widget-sortable="false"

                                -->
                                <header>
                                    <span class="widget-icon"> <i class="fa fa-bar-chart-o"></i> </span>
                                    <h2>Sin Chart</h2>

                                </header>

                                <!-- widget div-->
                                <div>

                                    <!-- widget edit box -->
                                    <div class="jarviswidget-editbox">
                                        <!-- This area used as dropdown edit box -->

                                    </div>
                                    <!-- end widget edit box -->

                                    <!-- widget content -->
                                    <div class="widget-body no-padding">

                                        <div id="sin-chart" class="chart has-legend"></div>

                                    </div>
                                    <!-- end widget content -->

                                </div>
                                <!-- end widget div -->

                            </div>
                            <!-- end widget -->

                        </article>
                        <!-- WIDGET END -->
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="grid_1stGrid" name="grid_1stGrid" class="jqgrid-resizable"></div>
					<div id="p_grid_1stGrid"></div>
			</div>
		</div>
		
		<div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
			<div class="input-group-btn">
				<button class="btn btn-default btn-primary btn-custom-search search-row-1" type="button" onclick="javascript:retrieve_sample();">
					<i class="fa fa-search"></i> <spring:message code='TXT.ENG_SEARCH' />
				</button>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="p_testGrid_03" name="p_testGrid_03" class="jqgrid-resizable"></div>
				<div id="p_testGrid_03_paging"></div>
			</div>
		</div>				
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="p_testGrid_02" name="p_testGrid_02" class="jqgrid-resizable"></div>
			</div>
		</div>
		

	</section>
</div>
<script type="text/javascript">
var gridData = [
    {    id: 549731,    name: '가나다라마바사',    artist: 'Birdy',    release: '2016.03.26',    type: 'Deluxe',    typeCode: '1',    genre: 'Pop',    genreCode: '1',    grade: '4',    price: 10000,    downloadCount: 1000,    listenCount: 5000},
	{    id: 436461,    name: 'X',    artist: 'Ed Sheeran',    release: '2014.06.24',    type: 'Deluxe',    typeCode: '1',    genre: 'Pop',    genreCode: '1',    grade: '5',    price: 20000,    downloadCount: 1000,    listenCount: 5000},
	{    id: 295651,    name: 'Moves Like Jagger',    release: '2011.08.08',    artist: 'Maroon5',    type: 'Single',    typeCode: '3',    genre: 'Pop,Rock',    genreCode: '1,2',    grade: '2',    price: 7000,    downloadCount: 1000,    listenCount: 5000},
	{    id: 541713,    name: 'A Head Full Of Dreams',    artist: 'Coldplay',    release: '2015.12.04',    type: 'Deluxe',    typeCode: '1',    genre: 'Rock',    genreCode: '2',    grade: '3',    price: 25000,    downloadCount: 1000,    listenCount: 5000},
	{    id: 265289,    name: '21',    artist: 'Adele',    release: '2011.01.21',    type: 'Deluxe',    typeCode: '1',    genre: 'Pop,R&B',    genreCode: '1,3',    grade: '5',    price: 15000,    downloadCount: 1000,    listenCount: 5000},
	{    id: 555871,    name: 'Warm On A Cold Night',    artist: 'HONNE',    release: '2016.07.22',    type: 'EP',    typeCode: '1',    genre: 'R&B,Electronic',    genreCode: '3,4',    grade: '4',    price: 11000,    downloadCount: 1000,    listenCount: 5000},
	{    id: 550571,    name: 'Take Me To The Alley',    artist: 'Gregory Porter',    release: '2016.09.02',    type: 'Deluxe',    typeCode: '1',    genre: 'Jazz',    genreCode: '5',    grade: '3',    price: 30000,    downloadCount: 1000,    listenCount: 5000},
	{    id: 544128,    name: 'Make Out',    artist: 'LANY',    release: '2015.12.11',    type: 'EP',    typeCode: '2',    genre: 'Electronic',    genreCode: '4',    grade: '2',    price: 12000,    downloadCount: 1000,    listenCount: 5000},
	{    id: 366374,    name: 'Get Lucky',    artist: 'Daft Punk',    release: '2013.04.23',    type: 'Single',    typeCode: '3',    genre: 'Pop,Funk',    genreCode: '1,5',    grade: '3',    price: 9000,    downloadCount: 1000,    listenCount: 5000},
	{    id: 8012747,    name: 'Valtari',    artist: 'Sigur Rós',    release: '2012.05.31',    type: 'EP',    typeCode: '3',    genre: 'Rock',    genreCode: '2',    grade: '5',    price: 10000,    downloadCount: 1000,    listenCount: 5000},
	{    id: 502792,    name: 'Bush',    artist: 'Snoop Dogg',    release: '2015.05.12',    type: 'EP',    typeCode: '2',    genre: 'Hiphop',    genreCode: '5',    grade: '5',    price: 18000,    downloadCount: 1000,    listenCount: 5000},
	{    id: 294574,    name: '4',    artist: 'Beyoncé',    release: '2011.07.26',    type: 'Deluxe',    typeCode: '1',    genre: 'Pop',    genreCode: '1',    grade: '3',    price: 12000,    downloadCount: 1000,    listenCount: 5000},
	{    id: 317659,    name: 'I Won\'t Give Up',    artist: 'Jason Mraz',    release: '2012.01.03',    type: 'Single',    typeCode: '3',    genre: 'Pop',    genreCode: '1',    grade: '2',    price: 7000,    downloadCount: 1000,    listenCount: 5000},
	{    id: 583551,    name: 'Following My Intuition',    artist: 'Craig David',    release: '2016.10.01',    type: 'Deluxe',    typeCode: '1',    genre: 'R&B,Electronic',    genreCode: '3,4',    grade: '5',    price: 15000,    downloadCount: 1000,    listenCount: 5000},
	{    id: 490500,    name: 'Blue Skies',    release: '2015.03.18',    artist: 'Lenka',    type: 'Single',    typeCode: '3',    genre: 'Pop,Rock',    genreCode: '1,2',    grade: '5',    price: 6000,    downloadCount: 1000,    listenCount: 5000},
	{    id: 587871,    name: 'This Is Acting',    artist: 'Sia',    release: '2016.10.22',    type: 'EP',    typeCode: '2',    genre: 'Pop',    genreCode: '1',    grade: '3',    price: 20000,    downloadCount: 1000,    listenCount: 5000	},
	{    id: 504288,    name: 'Blurryface',    artist: 'Twenty One Pilots',    release: '2015.05.19',    type: 'EP',    typeCode: '2',    genre: 'Rock',    genreCode: '2',    grade: '1',    price: 13000,    downloadCount: 1000,    listenCount: 5000	},
	{    id: 450720,    name: 'I\'m Not The Only One',    artist: 'Sam Smith',    release: '2014.09.15',    type: 'Single',    typeCode: '3',    genre: 'Pop,R&B',    genreCode: '1,3',    grade: '4',    price: 8000,    downloadCount: 1000,    listenCount: 5000},
	{    id: 498896,    name: 'The Magic Whip',    artist: 'Blur',    release: '2015.04.27',    type: 'EP',    typeCode: '2',    genre: 'Rock',    genreCode: '2',    grade: '3',    price: 15000,    downloadCount: 1000,    listenCount: 5000},
	{    id: 491379,    name: 'Chaos And The Calm',    artist: 'James Bay',    release: '2015.03.23',    type: 'EP',    typeCode: '2',    genre: 'Pop,Rock',    genreCode: '1,2',    grade: '5',    price: 12000,    downloadCount: 1000,    listenCount: 5000}
];

var tGrid = new tui.Grid({
    el: $('#grid_1stGrid'),
    data: gridData,
    scrollX: false,
    scrollY: true,
    bodyHeight : 100,
    columns: [
        { header : '이름', name: 'name' },
        { header : 'Artist', name: 'artist' },
        { header : 'Type', name: 'type' },
        { header : 'Release', name: 'release' },
        { header : 'Genre', name: 'genre' }
    ]
});




</script>

<script>

	var imsi = [{"name":"1"},{"name":"2"},{"name":"3"}];
	var net;
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		Initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
		
		
		
		
	});
	
	// Page Object Initialize
	function Initialize_viewObject() {
		
		renderTuiGrid();
		
		retrieve_sample();
		test1();
		
		
		//bar chart(flot)
		flot_bar_chart();
		
		
	}
	
	 function renderTuiGrid(){
		 
		 var colArrayInfo = [
			 	{ header : '이름', name: 'a', width : 100, hidden:false },
		        { header : '입력 왼쪽', name: 'b1', width : 200,editOptions: {type: 'text',useViewMode: true}, align: "left" },
		        { header : '입력 중간', name: 'b2', width : 200,editOptions: {type: 'text',useViewMode: true}, align: "center" },
		        { header : '입력 오른쪽', name: 'b3', width : 200,editOptions: {type: 'text',useViewMode: true}, align: "right" },
		        { header : '체크박스', name: 'c', width : 200,editOptions: {type: 'checkbox',listItems: [{text: 'IE 9', value: 1},{text: 'IE 10', value: 2},{text: 'IE 11', value: 3},{text: 'Firefox', value: 4},{text: 'Chrome', value: 5}]} },
		        { header : '셀렉트박스', name: 'd', width : 200,editOptions: {type: 'select',listItems: [{text: 'IE 9', value: 1},{text: 'IE 10', value: 2},{text: 'IE 11', value: 3},{text: 'Firefox', value: 4},{text: 'Chrome', value: 5}]} }
		    ];
		 
		 KpackageOBJ.tuiGrid.create("p_testGrid_02", "22222222", colArrayInfo, true, true);
		 var colArrayInfo = [
			 	{ header : '컬럼1', name: 'COL_01', width : 100, align: "center", hidden:false },
			 	{ header : '컬럼2', name: 'COL_02', width : 100, align: "center", hidden:false },
			 	{ header : '컬럼3', name: 'COL_03', width : 100, align: "center", hidden:false }
		    ];
		 
		 KpackageOBJ.tuiGrid.create("p_testGrid_03", "/sample/retrieveToastData", colArrayInfo, null, onClick_p_testGrid_03).setBodyHeight(300);
	 }
	 
	function onClick_p_testGrid_03(gridId, rowkey, colName){
		console.log(gridId, rowkey, colName);
	}
	 
	function test1(){
		var d = KpackageOBJ.tuiGrid.getGrid("p_testGrid_02");
		d.setBodyHeight(300);
		
		d.setData([{},{},{}]);
		//d.setWidth(300);
	}
	 
	function retrieve_sample(){
		var param = {"dummy" : "dummy"};
	}
	
	
	var dataTargetProfit = [
        [1354586000000, 153],
        [1364587000000, 658],
        [1374588000000, 198],
        [1384589000000, 663],
        [1394590000000, 801],
        [1404591000000, 1080],
        [1414592000000, 353],
        [1424593000000, 749],
        [1434594000000, 523],
        [1444595000000, 258],
        [1454596000000, 688],
        [1464597000000, 364]
    ]

	var flot_toggle = function(){
		var data = [
			            {
			                label: "Target Profit",
			                data: dataTargetProfit,
			                color: myapp_get_color.info_400,
			                bars:
			                {
			                    show: true,
			                    align: "center",
			                    barWidth: 30 * 30 * 60 * 1000 * 80,
			                    lineWidth: 0,
			                    /*fillColor: {
			                        colors: [myapp_get_color.primary_500, myapp_get_color.primary_900]
			                    },*/
			                    fillColor:
			                    {
			                        colors: [
			                        {
			                            opacity: 0.9
			                        },
			                        {
			                            opacity: 0.1
			                        }]
			                    }
			                },
			                highlightColor: 'rgba(255,255,255,0.3)',
			                shadowSize: 0
			            }
            ];

            var options = {
                grid:
                {
                    hoverable: true,
                    clickable: true,
                    tickColor: '#f2f2f2',
                    borderWidth: 1,
                    borderColor: '#f2f2f2'
                },
                tooltip: true,
                tooltipOpts:
                {
                    cssClass: 'tooltip-inner',
                    defaultTheme: false
                },
                xaxis:
                {
                    mode: "time"
                },
                yaxes:
                {
                    tickFormatter: function(val, axis)
                    {
                        return "$" + val;
                    },
                    max: 1200
                }

            };
            
            var data1 = [];
            for (var i = 0; i <= 12; i += 1){
                data1.push([i, parseInt(Math.random() * 30)]);
            }
            
            $.plot($("#flot-toggles"), data1, options);
	}
	flot_toggle();
    
		function flot_bar_chart(){
			if ($("#bar-chart").length) {
	
	            var data1 = [];
	            for (var i = 0; i <= 12; i += 1)
	                data1.push([i, parseInt(Math.random() * 30)]);
	
	            /*
	            var data2 = [];
	            for (var i = 0; i <= 12; i += 1)
	                data2.push([i, parseInt(Math.random() * 30)]);
	
	            var data3 = [];
	            for (var i = 0; i <= 12; i += 1)
	                data3.push([i, parseInt(Math.random() * 30)]);
	*/
	            var ds = new Array();
	
	            ds.push({
	                data : data1,
	                bars : {
	                	show: true,
	                    align: "center",
	                    barWidth: 0.4,  //막대기 사이즈
	                    lineWidth: 0,
	                    colors: [
	                        {
	                        	opacity: 0.9
	                        },
	                        {
	                        	opacity: 0.1
	                        }]
	            /*
	                    fillColor:      //막대기 색상
	                    {
	                        colors: [myapp_get_color.info_300, myapp_get_color.info_50]
	                    },
	                    */
	                    
	                },
	                highlightColor: 'rgba(255,255,255,0.3)',    // 마우스 오버시 막대기 색상
	                shadowSize: 0
	            });
	            /*
	            ds.push({
	                data : data2,
	                bars : {
	                    show : true,
	                    barWidth : 0.2,
	                    order : 2
	                }
	            });
	            ds.push({
	                data : data3,
	                bars : {
	                    show : true,
	                    barWidth : 0.2,
	                    order : 3
	                }
	            });
	            */
	
	            //Display graph
	            $.plot($("#bar-chart"), ds, {
	                //colors : [$chrt_second, $chrt_fourth, "#666", "#BBB"],
	                colors : [myapp_get_color.info_50, myapp_get_color.info_300],
	                grid : {
	                    hoverable: true,
	                    clickable: true,
	                    tickColor: '#f2f2f2',
	                    borderWidth: 1,
	                    borderColor: '#f2f2f2'
	                },
	                legend : true,
	                tooltip : true,
	                tooltipOpts : {
	                    content : "<b>%x</b> = <span>%y</span>",
	                    defaultTheme : false
	                    
	                }
	
	            });
	
	        }
		}


</script>
</body>
</html>