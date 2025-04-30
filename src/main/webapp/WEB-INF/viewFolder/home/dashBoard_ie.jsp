<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>KPMG - Draw Back System</title>

    
    
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
<div class="subheader" style="padding-top: 10px;"></div>


<div class="row">
    <div class="col-lg-6 sortable-grid ui-sortable">
        <!-- Widget ID (each widget will need unique ID)-->
        <div class="jarviswidget panel" id="wid-id-CurRate" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false" data-widget-custombutton="false">
            <header class="dashboaard_wgt_header panel-hdr">
                <h2><strong>환율</strong> <i>정보</i></h2>

                <ul id="widget-tab-1" class="nav nav-tabs pull-right">
                    <li class="active">
                        <a data-toggle="tab" href="#hr1"> <span class="hidden-mobile hidden-tablet"> Export </span> </a>
                    </li>
                    <li>
                        <a data-toggle="tab" href="#hr2"> <span class="hidden-mobile hidden-tablet"> Import </span></a>
                    </li>
                </ul>
            </header>

            <!-- widget div-->
            <div>
                <!-- widget edit box -->
                <div class="jarviswidget-editbox"></div>
                <!-- widget content -->
                <div class="widget-body no-padding">
                    <!-- widget body text-->
                    <div class="tab-content padding-10">
                        <div class="tab-pane fade in active" id="hr1">
                            <div class="custom-scroll table-responsive" style="height:580px; overflow-y: scroll;">
                                <table class="table table-hover" style="font-size: 0.9em">
                                    <thead>
                                        <tr class="header">
                                            <th scope="col" data-number="">No</th>
                                            <th style="text-align: center;" scope="col">국가</th>
                                            <th style="text-align: center;" scope="col">통화명</th>
                                            <th style="text-align: center;" scope="col">환율</th>
                                            <th style="text-align: center;" scope="col">통화</th>
                                            <th style="text-align: center;" scope="col">적용일자</th>
                                        </tr>
                                    </thead>
                                    <tbody id="EXPORT_TAX_RATE"></tbody>
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="hr2">
                            <div class="custom-scroll table-responsive" style="height:580px; overflow-y: scroll;">
                                <table class="table table-hover">
                                    <thead>
                                        <tr class="header">
                                            <th scope="col" data-number="">No</th>
                                            <th style="text-align: center;" scope="col">국가</th>
                                            <th style="text-align: center;" scope="col">통화명</th>
                                            <th style="text-align: center;" scope="col">환율</th>
                                            <th style="text-align: center;" scope="col">통화</th>
                                            <th style="text-align: center;" scope="col">적용일자</th>
                                        </tr>
                                    </thead>
                                    <tbody id="IMPORT_TAX_RATE"></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end widget content -->
            </div>
            <!-- end widget div -->
        </div>
        <!-- end widget -->
    </div>
    <div class="col-lg-3 sortable-grid ui-sortable">
		<div class="p-3 bg-primary-300 rounded overflow-hidden position-relative text-white mb-g mainDownBtn" style="height: 80px;">
            <div class="">
                <h3 class="display-4 d-block l-h-n m-0 fw-500" style="font-size: 1.2em">
                    Unipass I/F client download
                    <small class="m-0 l-h-n" style="color: #FFF;font-size: 0.8em;">관세청 송/수신을 위한 프로그램을 다운로드 합니다.</small>
                </h3>
            </div>
            <i class="fal fa-user position-absolute pos-right pos-bottom opacity-15 mb-n1 mr-n1" style="font-size:6rem"></i>
        </div>
		<div class="card-deck">
			<div class="card">
			    <div class="w-100 bg-fusion-50 rounded-top" style="padding:2px 0 2px;"></div>
			    <div class="card-body" style="min-height: 115px;">
			        <h5 class="card-title">Site Link</h5>
			        <p class="card-text">관세법령정보포털 https://unipass.customs.go.kr/clip/index.do</p>
			    </div>
			    <div class="card-footer">
			        <small class="text-muted"><a href="https://unipass.customs.go.kr/clip/index.do" target="_blink">Go link site</a></small>
			    </div>
			</div>
			<div class="card">
			    <div class="w-100 bg-fusion-50 rounded-top" style="padding:2px 0 2px;"></div>
			    <div class="card-body" style="min-height: 115px;">
			        <h5 class="card-title">Site Link</h5>
			        <p class="card-text">관세청 https://www.customs.go.kr/kcs/main.do</p>
			    </div>
			    <div class="card-footer">
			        <small class="text-muted"><a href="https://www.customs.go.kr/kcs/main.do" target="_blink">Go link site</a></small>
			    </div>
			</div>
		</div>
    </div>
    <div class="col-lg-3 sortable-grid ui-sortable">
	    <div class="p-3 bg-info-200 rounded overflow-hidden position-relative text-white mb-g mainDownBtn" style="height: 80px;">
			<div class="">
	   			<h3 class="display-4 d-block l-h-n m-0 fw-500" style="font-size: 1.2em;">
	       		User guide download
	       		<small class="m-0 l-h-n" style="color: #FFF;font-size: 0.8em;">사용자 메뉴얼을 다운로드합니다. </small>
	   			</h3>
			</div>
			<i class="fal fa-globe position-absolute pos-right pos-bottom opacity-15 mb-n1 mr-n4" style="font-size: 6rem;"></i>
		</div>    
		<div class="card-deck">
			<div class="card">
			    <div class="w-100 bg-fusion-50 rounded-top" style="padding:2px 0 2px;"></div>
			    <div class="card-body" style="min-height: 115px;">
			        <h5 class="card-title">Site Link</h5>
			        <p class="card-text">KITA-한국무역협회 https://www.kita.net</p>
			    </div>
			    <div class="card-footer">
			        <small class="text-muted"><a href="https://www.kita.net/" target="_blink">Go link site</a></small>
			    </div>
			</div>
			<div class="card">
			    <div class="w-100 bg-fusion-50 rounded-top" style="padding:2px 0 2px;"></div>
			    <div class="card-body" style="min-height: 115px;">
			        <h5 class="card-title">Site Link</h5>
			        <p class="card-text">법제처-국가법령정보센터 https://www.law.go.kr/</p>
			    </div>
			    <div class="card-footer">
			        <small class="text-muted"><a href="https://www.law.go.kr/" target="_blink">Go link site</a></small>
			    </div>
			</div>
		</div>    
		
    </div>
</div>
	<script>
	
	var HOME_DASHBOARD = new function() {

	    this.initPage = function() {

	        var postData = {
	            "TARGET_TYPE": "1"
	        }; // // 1: 수출 2: 수입 	                
	        KpackageOBJ.ajax.doSubmit("/dashboard/retrieveCustomsTaxRate", postData, HOME_DASHBOARD.retrieveCustomsExportTaxRate, null, false);

	        postData = {
	            "TARGET_TYPE": "2"
	        }; // // 1: 수출 2: 수입
	        KpackageOBJ.ajax.doSubmit("/dashboard/retrieveCustomsTaxRate", postData, HOME_DASHBOARD.retrieveCustomsImportTaxRate, null, false);
	    }


	    this.retrieveCustomsExportTaxRate = function(result) {
	        if (result.success) {
	            var data = result.value;

	            var addTag = "";
	            for (var inx = 0; inx < data.length; inx++) {
	                var row = data[inx];
	                addTag = addTag + "<tr>";
	                addTag = addTag + "<td>" + (inx + 1) + "</td>";
	                addTag = addTag + "<td class=\"textCenter\" title=\"" + data[inx]["cntySgn"] + "\">" + data[inx]["cntySgn"] + "</td>";
	                addTag = addTag + "<td class=\"textLeft\" title=\"" + data[inx]["mtryUtNm"] + "\">" + data[inx]["mtryUtNm"] + "</td>";
	                addTag = addTag + "<td class=\"textRight textBold\" title=\"" + data[inx]["fxrt"] + "\">" + data[inx]["fxrt"] + "</td>";
	                addTag = addTag + "<td class=\"textCenter\" title=\"" + data[inx]["currSgn"] + "\">" + data[inx]["currSgn"] + "</td>";
	                addTag = addTag + "<td class=\"textCenter\" title=\"" + data[inx]["aplyBgnDt"] + "\">" + KpackageOBJ.formatter.date(data[inx]["aplyBgnDt"] + "") + "</td>";
	                addTag = addTag + "</tr>";
	            }

	            $("#EXPORT_TAX_RATE").html(addTag);

	        }
	    }

	    this.retrieveCustomsImportTaxRate = function(result) {
	        if (result.success) {
	            var data = result.value;

	            var addTag = "";
	            for (var inx = 0; inx < data.length; inx++) {
	                var row = data[inx];
	                addTag = addTag + "<tr>";
	                addTag = addTag + "<td>" + (inx + 1) + "</td>";
	                addTag = addTag + "<td class=\"textCenter\" title=\"" + data[inx]["cntySgn"] + "\">" + data[inx]["cntySgn"] + "</td>";
	                addTag = addTag + "<td class=\"textLeft\" title=\"" + data[inx]["mtryUtNm"] + "\">" + data[inx]["mtryUtNm"] + "</td>";
	                addTag = addTag + "<td class=\"textRight textBold\" title=\"" + data[inx]["fxrt"] + "\">" + data[inx]["fxrt"] + "</td>";
	                addTag = addTag + "<td class=\"textCenter\" title=\"" + data[inx]["currSgn"] + "\">" + data[inx]["currSgn"] + "</td>";
	                addTag = addTag + "<td class=\"textCenter\" title=\"" + data[inx]["aplyBgnDt"] + "\">" + KpackageOBJ.formatter.date(data[inx]["aplyBgnDt"] + "") + "</td>";
	                addTag = addTag + "</tr>";
	            }

	            $("#IMPORT_TAX_RATE").html(addTag);

	        }
	    }
	   
	}

	$(document).ready(function() {
	    pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
	    HOME_DASHBOARD.initPage();

	});
	</script>
</body>
</html>