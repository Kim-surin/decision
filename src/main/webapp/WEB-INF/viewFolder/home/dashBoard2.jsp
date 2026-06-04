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
                        <div class="col-lg-6 col-xl-9" style="padding: 10px; height: 360px; overflow: hidden;">
                            <div id="MAIN_CHART_DIV" class="position-relative" style="width: 100%">
                                <div class="custom-control custom-switch position-absolute pos-top pos-left ml-5 mt-3 z-index-cloud"></div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-xl-3">
                        
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div><!-- row End -->


	<script>
	
	var HOME_DASHBOARD = new function() {

	    this.initPage = function() {

	    }

	}


	$(document).ready(function() {
	    pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
	    HOME_DASHBOARD.initPage();

	});
	</script>
</body>
</html>