<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>


</head>
<body>
	<div class="content-wrapper">
		<div class="row">
			<div class="content-wrapper col-3">
				<h1 class="subheader-title mb-1">SAMPLE PAGE 000</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item active" aria-current="page">SAMPLE-000</li>
					</ol>
				</nav>
			</div>
			<div class="row col-9">
				<div class="col-2 d-sm-flex align-items-center mb-3">
				</div>
				<div class="col-2 d-sm-flex align-items-center mb-3">
				</div>
				<div class="col-2 d-sm-flex align-items-center mb-3">
					<div class="p-2 me-2 me-xl-3 me-xxl-3 bg-warning-300 rounded">
				    	<span class="peity-bar"
				    	      data-peity="{ &quot;fill&quot;: [&quot;#fff&quot;], &quot;width&quot;: 27, &quot;height&quot;: 27 }">3,4,5,8,2</span>
				    </div>
				    <div class="d-flex flex-column align-items-start justify-content-center">
				        <label class="fs-xs mb-0">Bounce Rate</label>
				        <h5 class="fw-bold mb-0">37.56%</h5>
		 		   </div>
				</div>
				<div class="col-2 d-sm-flex align-items-center mb-3">
					<div class="p-2 me-2 me-xxl-3 bg-success-300 rounded">
		                <span class="peity-bar"
		                      data-peity="{ &quot;fill&quot;: [&quot;#fff&quot;], &quot;width&quot;: 27, &quot;height&quot;: 27 }">16,4,7,5,6</span>
	                </div>
	                <div class="d-flex flex-column align-items-start justify-content-center">
	                    <label class="fs-xs mb-0">Clickthrough</label>
	                    <h5 class="fw-bold mb-0">19.77%</h5>
	                </div>
				</div>
				<div class="col-2 d-sm-flex align-items-center mb-3">
					<div class="p-2 me-2 me-xxl-3 bg-primary-300 rounded">
						<span class="peity-bar" 
						      data-peity="{ &quot;fill&quot;: [&quot;#fff&quot;], &quot;width&quot;: 27, &quot;height&quot;: 27 }" style="display: none;">3,4,3,5,5</span>
					</div>
					<div class="d-flex flex-column align-items-start justify-content-center">
					    <label class="fs-xs mb-0">New Sessions</label>
					    <h5 class="fw-bold mb-0">12.17%</h5>
					</div>
				</div>		
				<div class="col-2 d-sm-flex align-items-center mb-3">
					<div class="p-2 me-2 me-xxl-3 bg-info-300 rounded">
						<span class="peity-bar" 
						      data-peity="{ &quot;fill&quot;: [&quot;#fff&quot;], &quot;width&quot;: 27, &quot;height&quot;: 27 }" style="display: none;">5,3,1,7,9</span>
					</div>
					<div class="d-flex flex-column align-items-start justify-content-center">
					    <label class="fs-xs mb-0">Actual Sessions</label>
					    <h5 class="fw-bold mb-0">56.34%</h5>
					</div>
				</div>	
			</div>
	    </div>
	    <div class="row">
	    	<form:form id="sample000-form" class="s4-form" novalidate="novalidate" action="" method="post">
		    	<div id="panel-4" class="panel panel-icon">
		    		<div class="panel-container show">
						<div class="panel-content">
				            <div class="row">
	                            <div class="col-lg-2">
	                                <div class="mb-3">
	                                    <label class="form-label" for="example-date">Date</label>
	                                    <input class="form-control" id="example-date" type="date" name="date" value="2023-07-23">
	                                </div>
	                            </div>
	                            <div class="col-lg-2">
                                        <label class="form-label" for="example-month">Month</label>
                                        <input class="form-control" id="example-month" type="month" name="month">
	                            </div>
	                            <div class="col-lg-2">
	                                <div class="mb-3">
	                                    <label class="form-label" for="example-select">Input Select</label>
	                                    <select class="form-select" id="example-select">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                        </select>
	                                </div>
	                            </div>
	                            <div class="col-lg-5">
	                            	<div class="row">
	                            		<label class="form-label" for="example-input-border">Border color</label>
	                            	</div>
	                                <div class="row mb-3">
	                                	<div class="col-3">
	                                		<select class="form-select" id="example-select">
	                                            <option>1</option>
	                                            <option>2</option>
	                                            <option>3</option>
	                                            <option>4</option>
	                                            <option>5</option>
	                                        </select>
	                                	</div>
	                                	<div class="col">
	                                		<input type="text" id="example-input-border" class="form-control" placeholder="Border colors">
	                                	</div>
	                                    
	                                </div>
	                            </div>
	                            <div class="col">
                                	<button type="button" class="btn btn-sm btn-search search-more waves-effect waves-themed">Search</button>
                                	<button type="button" class="btn btn-xs btn-search-more waves-effect waves-themed">More</button>
                                </div>
	                        </div>
					    </div>		    		
		    		</div>
				</div>
			</form:form>
	    </div>
	    <div class="row">
	   		<div class="col-12">
		        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		        <div id="oAuiGrid_Sample000_01" style="width:100%;height:480px; margin:0 auto;background-color: #FFA"></div>
		    </div>
	    </div>	

	</div>

</body>
<script>
	var SAMPLE000 = new function() {

		// AUIGrid 생성 후 반환 ID
		this.myGridID = null;
		this.myGridID2 = null;
		this.myGridID3 = null;

		// 시작점
		this.Initialize_viewObject = function() {
			
			
			/*우측 상단 차트 생성 */
			KpackageOBJ.perityChart.create("span.peity-bar", "bar");
			// AUIGrid 그리드를 생성합니다.
			SAMPLE000.createAUIGrid();
			AUIGrid.setGridData(SAMPLE000.myGridID, SAMPLE000.data);
		}

		this.data = [
			  {"id":"#Cust0","date":"2024-10-01","name":"스티브","country":"USA","flag":"auigrid/images/b_folder.png","product":"IPhone 16 Pro","color":"Green","quantity":3,"price":630700},
			  {"id":"#Cust1","date":"2024-09-30","name":"엠마","country":"Korea","flag":"korea.png","product":"Galaxy S25 Ultra","color":"Pink","quantity":1,"price":503800},
			  {"id":"#Cust2","date":"2024-09-29","name":"홍길동","country":"Japan","flag":"japan.png","product":"IPhone 16 Pro","color":"Yellow","quantity":7,"price":66900},
			  {"id":"#Cust3","date":"2024-09-28","name":"Emma","country":"UK","flag":"uk.png","product":"Galaxy Note21","color":"Orange","quantity":9,"price":458300},
			  {"id":"#Cust4","date":"2024-09-27","name":"Anna","country":"China","flag":"china.png","product":"Galaxy S25 Ultra","color":"Violet","quantity":10,"price":168100},
			  {"id":"#Cust5","date":"2024-09-26","name":"Anna","country":"USA","flag":"usa.png","product":"Galaxy S25","color":"Gray","quantity":3,"price":10400},
			  {"id":"#Cust6","date":"2024-09-25","name":"Lowrence","country":"Ireland","flag":"ireland.png","product":"Galaxy S25 Ultra","color":"Yellow","quantity":12,"price":696100},
			  {"id":"#Cust7","date":"2024-09-24","name":"Lowrence","country":"Ireland","flag":"ireland.png","product":"Galaxy Note21","color":"Yellow","quantity":12,"price":623600},
			  {"id":"#Cust8","date":"2024-09-23","name":"Kim","country":"Japan","flag":"japan.png","product":"IPhone 16 Pro","color":"Gray","quantity":7,"price":8000},
			  {"id":"#Cust9","date":"2024-09-22","name":"Kim","country":"UK","flag":"uk.png","product":"Galaxy S25","color":"Orange","quantity":9,"price":982600},
			  {"id":"#Cust10","date":"2024-09-21","name":"Jennifer","country":"UK","flag":"uk.png","product":"IPhone 16 Pro","color":"Green","quantity":9,"price":800400},
			  {"id":"#Cust11","date":"2024-09-20","name":"Steve","country":"Japan","flag":"japan.png","product":"Galaxy Note21","color":"Yellow","quantity":7,"price":740100},
			  {"id":"#Cust12","date":"2024-09-19","name":"Emma","country":"Singapore","flag":"singapore.png","product":"IPhone 16","color":"Green","quantity":20,"price":868400},
			  {"id":"#Cust13","date":"2024-09-18","name":"Anna","country":"Italy","flag":"italy.png","product":"Galaxy S25","color":"Violet","quantity":15,"price":266800},
			  {"id":"#Cust14","date":"2024-09-17","name":"Steve","country":"China","flag":"china.png","product":"IPhone 16 Pro","color":"Pink","quantity":10,"price":848100},
			  {"id":"#Cust15","date":"2024-09-16","name":"Emma","country":"Italy","flag":"italy.png","product":"IPhone 16 Pro","color":"Pink","quantity":15,"price":401900},
			  {"id":"#Cust16","date":"2024-09-15","name":"Anna","country":"Singapore","flag":"singapore.png","product":"IPhone 16 Pro","color":"Green","quantity":20,"price":969700},
			  {"id":"#Cust17","date":"2024-09-14","name":"Steve","country":"Japan","flag":"japan.png","product":"Galaxy S25 Ultra","color":"Orange","quantity":7,"price":204700},
			  {"id":"#Cust18","date":"2024-09-13","name":"Steve","country":"Korea","flag":"korea.png","product":"Galaxy S25 Ultra","color":"Orange","quantity":1,"price":808000},
			  {"id":"#Cust19","date":"2024-09-12","name":"Anna","country":"Japan","flag":"japan.png","product":"Galaxy S25","color":"Gray","quantity":7,"price":701800},
			  {"id":"#Cust20","date":"2024-09-11","name":"Kim","country":"UK","flag":"uk.png","product":"IPhone 16 Pro","color":"Pink","quantity":9,"price":31000},
			  {"id":"#Cust21","date":"2024-09-10","name":"Kim","country":"China","flag":"china.png","product":"Galaxy S25 Ultra","color":"Blue","quantity":10,"price":640200},
			  {"id":"#Cust22","date":"2024-09-09","name":"Anna","country":"Singapore","flag":"singapore.png","product":"IPhone 16 Pro","color":"Green","quantity":20,"price":149300},
			  {"id":"#Cust23","date":"2024-09-08","name":"Emma","country":"France","flag":"france.png","product":"IPhone 16","color":"Violet","quantity":0,"price":234800},
			  {"id":"#Cust24","date":"2024-09-07","name":"Kim","country":"USA","flag":"usa.png","product":"IPhone 16 Pro","color":"Gray","quantity":3,"price":269000},
			  {"id":"#Cust25","date":"2024-09-06","name":"Emma","country":"Korea","flag":"korea.png","product":"IPhone 16","color":"Blue","quantity":1,"price":917700},
			  {"id":"#Cust26","date":"2024-09-05","name":"Jennifer","country":"China","flag":"china.png","product":"Galaxy S25","color":"Yellow","quantity":10,"price":838900},
			  {"id":"#Cust27","date":"2024-09-04","name":"Jennifer","country":"Singapore","flag":"singapore.png","product":"Galaxy S25","color":"Violet","quantity":20,"price":93700},
			  {"id":"#Cust28","date":"2024-09-03","name":"Kim","country":"France","flag":"france.png","product":"IPhone 16 Pro","color":"Blue","quantity":0,"price":403500},
			  {"id":"#Cust29","date":"2024-09-02","name":"Steve","country":"UK","flag":"uk.png","product":"Galaxy Note21","color":"Yellow","quantity":9,"price":881000},
			  {"id":"#Cust30","date":"2024-09-01","name":"Lowrence","country":"Singapore","flag":"singapore.png","product":"Galaxy S25","color":"Pink","quantity":20,"price":348000},
			  {"id":"#Cust31","date":"2024-08-31","name":"Steve","country":"Japan","flag":"japan.png","product":"IPhone 16 Pro","color":"Gray","quantity":7,"price":871700},
			  {"id":"#Cust32","date":"2024-08-30","name":"Anna","country":"UK","flag":"uk.png","product":"IPhone 16","color":"Yellow","quantity":9,"price":653100},
			  {"id":"#Cust33","date":"2024-08-29","name":"Kim","country":"Korea","flag":"korea.png","product":"IPhone 16","color":"Gray","quantity":1,"price":873500},
			  {"id":"#Cust34","date":"2024-08-28","name":"Steve","country":"UK","flag":"uk.png","product":"IPhone 16 Pro","color":"Orange","quantity":9,"price":643600},
			  {"id":"#Cust35","date":"2024-08-27","name":"Emma","country":"Italy","flag":"italy.png","product":"IPhone 16","color":"Orange","quantity":15,"price":664200},
			  {"id":"#Cust36","date":"2024-08-26","name":"Lowrence","country":"China","flag":"china.png","product":"IPhone 16","color":"Orange","quantity":10,"price":736900},
			  {"id":"#Cust37","date":"2024-08-25","name":"Kim","country":"Italy","flag":"italy.png","product":"Galaxy S25","color":"Gray","quantity":15,"price":739300},
			  {"id":"#Cust38","date":"2024-08-24","name":"Lowrence","country":"Ireland","flag":"ireland.png","product":"Galaxy S25 Ultra","color":"Pink","quantity":12,"price":195600},
			  {"id":"#Cust39","date":"2024-08-23","name":"Lowrence","country":"Singapore","flag":"singapore.png","product":"IPhone 16","color":"Pink","quantity":20,"price":64500},
			  {"id":"#Cust40","date":"2024-08-22","name":"Lowrence","country":"Singapore","flag":"singapore.png","product":"IPhone 16","color":"Blue","quantity":20,"price":873400},
			  {"id":"#Cust41","date":"2024-08-21","name":"Steve","country":"USA","flag":"usa.png","product":"IPhone 16","color":"Orange","quantity":3,"price":821600},
			  {"id":"#Cust42","date":"2024-08-20","name":"Kim","country":"UK","flag":"uk.png","product":"Galaxy S25","color":"Yellow","quantity":9,"price":971100},
			  {"id":"#Cust43","date":"2024-08-19","name":"Kim","country":"China","flag":"china.png","product":"Galaxy Note21","color":"Blue","quantity":10,"price":165400},
			  {"id":"#Cust44","date":"2024-08-18","name":"Jennifer","country":"Italy","flag":"italy.png","product":"IPhone 16","color":"Yellow","quantity":15,"price":781600},
			  {"id":"#Cust45","date":"2024-08-17","name":"Kim","country":"Italy","flag":"italy.png","product":"Galaxy Note21","color":"Orange","quantity":15,"price":964400},
			  {"id":"#Cust46","date":"2024-08-16","name":"Jennifer","country":"USA","flag":"usa.png","product":"Galaxy S25 Ultra","color":"Violet","quantity":3,"price":441200},
			  {"id":"#Cust47","date":"2024-08-15","name":"Kim","country":"Singapore","flag":"singapore.png","product":"Galaxy S25 Ultra","color":"Yellow","quantity":20,"price":560900},
			  {"id":"#Cust48","date":"2024-08-14","name":"Lowrence","country":"France","flag":"france.png","product":"Galaxy S25","color":"Gray","quantity":0,"price":680000},
			  {"id":"#Cust49","date":"2024-08-13","name":"Steve","country":"UK","flag":"uk.png","product":"Galaxy S25","color":"Violet","quantity":9,"price":512100},
			  {"id":"#Cust50","date":"2024-08-12","name":"Jennifer","country":"Korea","flag":"korea.png","product":"IPhone 16 Pro","color":"Yellow","quantity":1,"price":572800},
			  {"id":"#Cust51","date":"2024-08-11","name":"Steve","country":"USA","flag":"usa.png","product":"Galaxy Note21","color":"Green","quantity":3,"price":345600},
			  {"id":"#Cust52","date":"2024-08-10","name":"Emma","country":"Ireland","flag":"ireland.png","product":"Galaxy S25 Ultra","color":"Violet","quantity":12,"price":287600},
			  {"id":"#Cust53","date":"2024-08-09","name":"Steve","country":"Ireland","flag":"ireland.png","product":"IPhone 16 Pro","color":"Pink","quantity":12,"price":307500},
			  {"id":"#Cust54","date":"2024-08-08","name":"Emma","country":"Korea","flag":"korea.png","product":"IPhone 16","color":"Yellow","quantity":1,"price":835200},
			  {"id":"#Cust55","date":"2024-08-07","name":"Lowrence","country":"Singapore","flag":"singapore.png","product":"IPhone 16 Pro","color":"Pink","quantity":20,"price":112800},
			  {"id":"#Cust56","date":"2024-08-06","name":"Anna","country":"Japan","flag":"japan.png","product":"IPhone 16 Pro","color":"Orange","quantity":7,"price":822200},
			  {"id":"#Cust57","date":"2024-08-05","name":"Lowrence","country":"Singapore","flag":"singapore.png","product":"Galaxy S25","color":"Violet","quantity":20,"price":694300},
			  {"id":"#Cust58","date":"2024-08-04","name":"Jennifer","country":"France","flag":"france.png","product":"Galaxy S25 Ultra","color":"Green","quantity":0,"price":197900},
			  {"id":"#Cust59","date":"2024-08-03","name":"Steve","country":"Japan","flag":"japan.png","product":"IPhone 16","color":"Blue","quantity":7,"price":955200},
			  {"id":"#Cust60","date":"2024-08-02","name":"Kim","country":"Korea","flag":"korea.png","product":"Galaxy Note21","color":"Yellow","quantity":1,"price":4400},
			  {"id":"#Cust61","date":"2024-08-01","name":"Emma","country":"UK","flag":"uk.png","product":"Galaxy S25","color":"Green","quantity":9,"price":517100},
			  {"id":"#Cust62","date":"2024-07-31","name":"Emma","country":"France","flag":"france.png","product":"Galaxy S25","color":"Violet","quantity":0,"price":128500},
			  {"id":"#Cust63","date":"2024-07-30","name":"Lowrence","country":"Ireland","flag":"ireland.png","product":"Galaxy Note21","color":"Pink","quantity":12,"price":468700},
			  {"id":"#Cust64","date":"2024-07-29","name":"Lowrence","country":"Singapore","flag":"singapore.png","product":"IPhone 16","color":"Green","quantity":20,"price":51100},
			  {"id":"#Cust65","date":"2024-07-28","name":"Emma","country":"Singapore","flag":"singapore.png","product":"Galaxy S25 Ultra","color":"Gray","quantity":20,"price":119300},
			  {"id":"#Cust66","date":"2024-07-27","name":"Lowrence","country":"China","flag":"china.png","product":"Galaxy S25 Ultra","color":"Yellow","quantity":10,"price":595800},
			  {"id":"#Cust67","date":"2024-07-26","name":"Anna","country":"Ireland","flag":"ireland.png","product":"IPhone 16 Pro","color":"Yellow","quantity":12,"price":745200},
			  {"id":"#Cust68","date":"2024-07-25","name":"Lowrence","country":"Singapore","flag":"singapore.png","product":"Galaxy S25 Ultra","color":"Gray","quantity":20,"price":681300},
			  {"id":"#Cust69","date":"2024-07-24","name":"Anna","country":"USA","flag":"usa.png","product":"Galaxy S25","color":"Orange","quantity":3,"price":344100},
			  {"id":"#Cust70","date":"2024-07-23","name":"Lowrence","country":"UK","flag":"uk.png","product":"Galaxy S25","color":"Blue","quantity":9,"price":69700},
			  {"id":"#Cust71","date":"2024-07-22","name":"Kim","country":"France","flag":"france.png","product":"Galaxy S25","color":"Violet","quantity":0,"price":379700},
			  {"id":"#Cust72","date":"2024-07-21","name":"Jennifer","country":"Italy","flag":"italy.png","product":"Galaxy S25","color":"Pink","quantity":15,"price":115300},
			  {"id":"#Cust73","date":"2024-07-20","name":"Jennifer","country":"Korea","flag":"korea.png","product":"Galaxy S25 Ultra","color":"Yellow","quantity":1,"price":535700},
			  {"id":"#Cust74","date":"2024-07-19","name":"Jennifer","country":"China","flag":"china.png","product":"IPhone 16 Pro","color":"Green","quantity":10,"price":517500},
			  {"id":"#Cust75","date":"2024-07-18","name":"Lowrence","country":"China","flag":"china.png","product":"IPhone 16 Pro","color":"Pink","quantity":10,"price":464900},
			  {"id":"#Cust76","date":"2024-07-17","name":"Jennifer","country":"Singapore","flag":"singapore.png","product":"Galaxy S25","color":"Gray","quantity":20,"price":70300},
			  {"id":"#Cust77","date":"2024-07-16","name":"Lowrence","country":"France","flag":"france.png","product":"Galaxy S25 Ultra","color":"Pink","quantity":0,"price":538000},
			  {"id":"#Cust78","date":"2024-07-15","name":"Emma","country":"USA","flag":"usa.png","product":"Galaxy Note21","color":"Violet","quantity":3,"price":409000},
			  {"id":"#Cust79","date":"2024-07-14","name":"Emma","country":"Italy","flag":"italy.png","product":"Galaxy S25 Ultra","color":"Pink","quantity":15,"price":595000},
			  {"id":"#Cust80","date":"2024-07-13","name":"Kim","country":"Singapore","flag":"singapore.png","product":"IPhone 16 Pro","color":"Blue","quantity":20,"price":764800},
			  {"id":"#Cust81","date":"2024-07-12","name":"Kim","country":"Ireland","flag":"ireland.png","product":"Galaxy Note21","color":"Orange","quantity":12,"price":694500},
			  {"id":"#Cust82","date":"2024-07-11","name":"Kim","country":"China","flag":"china.png","product":"Galaxy Note21","color":"Green","quantity":10,"price":712300},
			  {"id":"#Cust83","date":"2024-07-10","name":"Anna","country":"Ireland","flag":"ireland.png","product":"IPhone 16","color":"Blue","quantity":12,"price":863700},
			  {"id":"#Cust84","date":"2024-07-09","name":"Emma","country":"Ireland","flag":"ireland.png","product":"Galaxy S25 Ultra","color":"Violet","quantity":12,"price":918900},
			  {"id":"#Cust85","date":"2024-07-08","name":"Jennifer","country":"Japan","flag":"japan.png","product":"Galaxy Note21","color":"Pink","quantity":7,"price":849000},
			  {"id":"#Cust86","date":"2024-07-07","name":"Anna","country":"Italy","flag":"italy.png","product":"Galaxy S25","color":"Green","quantity":15,"price":896600},
			  {"id":"#Cust87","date":"2024-07-06","name":"Anna","country":"Korea","flag":"korea.png","product":"IPhone 16 Pro","color":"Yellow","quantity":1,"price":865100},
			  {"id":"#Cust88","date":"2024-07-05","name":"Emma","country":"Ireland","flag":"ireland.png","product":"Galaxy Note21","color":"Orange","quantity":12,"price":750900},
			  {"id":"#Cust89","date":"2024-07-04","name":"Lowrence","country":"France","flag":"france.png","product":"IPhone 16 Pro","color":"Violet","quantity":0,"price":345900},
			  {"id":"#Cust90","date":"2024-07-03","name":"Emma","country":"Korea","flag":"korea.png","product":"Galaxy Note21","color":"Pink","quantity":1,"price":930700},
			  {"id":"#Cust91","date":"2024-07-02","name":"Kim","country":"Singapore","flag":"singapore.png","product":"Galaxy S25 Ultra","color":"Violet","quantity":20,"price":692700},
			  {"id":"#Cust92","date":"2024-07-01","name":"Kim","country":"Ireland","flag":"ireland.png","product":"IPhone 16","color":"Violet","quantity":12,"price":979100},
			  {"id":"#Cust93","date":"2024-06-30","name":"Kim","country":"Korea","flag":"korea.png","product":"Galaxy S25 Ultra","color":"Gray","quantity":1,"price":28200},
			  {"id":"#Cust94","date":"2024-06-29","name":"Jennifer","country":"Italy","flag":"italy.png","product":"Galaxy Note21","color":"Pink","quantity":15,"price":283700},
			  {"id":"#Cust95","date":"2024-06-28","name":"Anna","country":"Japan","flag":"japan.png","product":"Galaxy Note21","color":"Pink","quantity":7,"price":940000},
			  {"id":"#Cust96","date":"2024-06-27","name":"Kim","country":"Italy","flag":"italy.png","product":"IPhone 16 Pro","color":"Pink","quantity":15,"price":822900},
			  {"id":"#Cust97","date":"2024-06-26","name":"Lowrence","country":"France","flag":"france.png","product":"Galaxy Note21","color":"Pink","quantity":0,"price":239400},
			  {"id":"#Cust98","date":"2024-06-25","name":"Lowrence","country":"Korea","flag":"korea.png","product":"Galaxy Note21","color":"Gray","quantity":1,"price":922600},
			  {"id":"#Cust99","date":"2024-06-24","name":"Steve","country":"USA","flag":"usa.png","product":"Galaxy Note21","color":"Violet","quantity":3,"price":701300}
			];

		// AUIGrid 를 생성합니다.
		this.createAUIGrid = function() {
			// 그리드 칼럼 레이아웃 설정
			const columnLayout = [ 
				{ dataField : "id",      headerText : "ID",          width : 120},
				{ dataField : "name",    headerText : "Name",        width : 140},
				{ dataField : "country", headerText : "Country",     width : 140},
				{ dataField : "flag",    headerText : "Flag IMG",    width : 100
					, prefix : "/rcs/", renderer : {type : "ImageRenderer",imgHeight : 24,altField : "country"}
				},
				{ dataField : "product", headerText : "Product",     width : 140},
				{ dataField : "color",   headerText : "Color",       width : 100},
				{ dataField : "price",   headerText : "Price",       width : 120
					, dataType : "numeric",    style : "my-column"
					, editRenderer : { 
						               type : "InputEditRenderer",
						  			   onlyNumeric : true, // 0~9만 입력가능
                                       textAlign : "right", // 오른쪽 정렬로 입력되도록 설정
                                       autoThousandSeparator : true  // 천단위 구분자 삽입 여부
                                     }
				}, 
				{ dataField : "quantity", headerText : "Quantity",   width : 100
					, dataType : "numeric", style : "my-column"
					, editRenderer : {
						type : "InputEditRenderer",
						onlyNumeric : true, // 0~9만 입력가능
						textAlign : "right", // 오른쪽 정렬로 입력되도록 설정
						autoThousandSeparator : true // 천단위 구분자 삽입 여부
						}
				},
				{ dataField : "date",    headerText : "Date"
					,    dataType : "date",    dateInputFormat : "yyyymmdd", 	formatString : "yyyy-mm-dd" 
 						                       // 데이터의 날짜 형식                 // 그리드에 보여줄 날짜 형식
			} ];

			// 그리드 속성 설정
			const gridProps = {
				//추가속성이 필요한 경우 작성 
				//editable : true,  // 그리드 수정 모드 
					
			};

			// 실제로 #oAuiGrid_Sample000_01 에 그리드 생성
			// 파라메터 : Grid Div ID, 컬럼레이아웃, 그리드속성, 그리드타입(없음 : null or "", 행번호 : number ,체크박스 : check ,라디오 : radio)
			
			SAMPLE000.myGridID = KpackageOBJ.auiGrid.create("oAuiGrid_Sample000_01", columnLayout, gridProps, "");
			
			
			// 클릭 이벤트
			AUIGrid.bind(SAMPLE000.myGridID, "cellClick", function( event ) {
				console.log("rowIndex : " + event.rowIndex + ", columnIndex : " + event.columnIndex + " clicked");
			});
			
			// 더블클릭 이벤트 
			AUIGrid.bind(SAMPLE000.myGridID, "cellDoubleClick", function( event ) {
				console.log("rowIndex : " + event.rowIndex + ", columnIndex : " + event.columnIndex + " dbl clicked");
			});
		};
	};
	
	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		SAMPLE000.Initialize_viewObject();
	});
</script>

</html>