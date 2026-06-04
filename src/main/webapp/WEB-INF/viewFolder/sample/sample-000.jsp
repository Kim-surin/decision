<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

</head>
<body>
	<button onclick="init()" style="width:150px; height:30px">Grid 생성</button>
    <div style="padding-top: 50px">
        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
        <div id="grid_wrap" style="width:100%;height:480px; margin:0 auto;"></div>
    </div>
</body>
<script>

	var data = [{
	    "id": "#Cust0",
	    "date": "2024-10-01",
	    "name": "Steve",
	    "country": "USA",
	    "flag": "usa.png",
	    "product": "IPhone 16 Pro",
	    "color": "Green",
	    "quantity": 3,
	    "price": 630700
	}, {
	    "id": "#Cust1",
	    "date": "2024-09-30",
	    "name": "Emma",
	    "country": "Korea",
	    "flag": "korea.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Pink",
	    "quantity": 1,
	    "price": 503800
	}, {
	    "id": "#Cust2",
	    "date": "2024-09-29",
	    "name": "Emma",
	    "country": "Japan",
	    "flag": "japan.png",
	    "product": "IPhone 16 Pro",
	    "color": "Yellow",
	    "quantity": 7,
	    "price": 66900
	}, {
	    "id": "#Cust3",
	    "date": "2024-09-28",
	    "name": "Emma",
	    "country": "UK",
	    "flag": "uk.png",
	    "product": "Galaxy Note21",
	    "color": "Orange",
	    "quantity": 9,
	    "price": 458300
	}, {
	    "id": "#Cust4",
	    "date": "2024-09-27",
	    "name": "Anna",
	    "country": "China",
	    "flag": "china.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Violet",
	    "quantity": 10,
	    "price": 168100
	}, {
	    "id": "#Cust5",
	    "date": "2024-09-26",
	    "name": "Anna",
	    "country": "USA",
	    "flag": "usa.png",
	    "product": "Galaxy S25",
	    "color": "Gray",
	    "quantity": 3,
	    "price": 10400
	}, {
	    "id": "#Cust6",
	    "date": "2024-09-25",
	    "name": "Lowrence",
	    "country": "Ireland",
	    "flag": "ireland.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Yellow",
	    "quantity": 12,
	    "price": 696100
	}, {
	    "id": "#Cust7",
	    "date": "2024-09-24",
	    "name": "Lowrence",
	    "country": "Ireland",
	    "flag": "ireland.png",
	    "product": "Galaxy Note21",
	    "color": "Yellow",
	    "quantity": 12,
	    "price": 623600
	}, {
	    "id": "#Cust8",
	    "date": "2024-09-23",
	    "name": "Kim",
	    "country": "Japan",
	    "flag": "japan.png",
	    "product": "IPhone 16 Pro",
	    "color": "Gray",
	    "quantity": 7,
	    "price": 8000
	}, {
	    "id": "#Cust9",
	    "date": "2024-09-22",
	    "name": "Kim",
	    "country": "UK",
	    "flag": "uk.png",
	    "product": "Galaxy S25",
	    "color": "Orange",
	    "quantity": 9,
	    "price": 982600
	}, {
	    "id": "#Cust10",
	    "date": "2024-09-21",
	    "name": "Jennifer",
	    "country": "UK",
	    "flag": "uk.png",
	    "product": "IPhone 16 Pro",
	    "color": "Green",
	    "quantity": 9,
	    "price": 800400
	}, {
	    "id": "#Cust11",
	    "date": "2024-09-20",
	    "name": "Steve",
	    "country": "Japan",
	    "flag": "japan.png",
	    "product": "Galaxy Note21",
	    "color": "Yellow",
	    "quantity": 7,
	    "price": 740100
	}, {
	    "id": "#Cust12",
	    "date": "2024-09-19",
	    "name": "Emma",
	    "country": "Singapore",
	    "flag": "singapore.png",
	    "product": "IPhone 16",
	    "color": "Green",
	    "quantity": 20,
	    "price": 868400
	}, {
	    "id": "#Cust13",
	    "date": "2024-09-18",
	    "name": "Anna",
	    "country": "Italy",
	    "flag": "italy.png",
	    "product": "Galaxy S25",
	    "color": "Violet",
	    "quantity": 15,
	    "price": 266800
	}, {
	    "id": "#Cust14",
	    "date": "2024-09-17",
	    "name": "Steve",
	    "country": "China",
	    "flag": "china.png",
	    "product": "IPhone 16 Pro",
	    "color": "Pink",
	    "quantity": 10,
	    "price": 848100
	}, {
	    "id": "#Cust15",
	    "date": "2024-09-16",
	    "name": "Emma",
	    "country": "Italy",
	    "flag": "italy.png",
	    "product": "IPhone 16 Pro",
	    "color": "Pink",
	    "quantity": 15,
	    "price": 401900
	}, {
	    "id": "#Cust16",
	    "date": "2024-09-15",
	    "name": "Anna",
	    "country": "Singapore",
	    "flag": "singapore.png",
	    "product": "IPhone 16 Pro",
	    "color": "Green",
	    "quantity": 20,
	    "price": 969700
	}, {
	    "id": "#Cust17",
	    "date": "2024-09-14",
	    "name": "Steve",
	    "country": "Japan",
	    "flag": "japan.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Orange",
	    "quantity": 7,
	    "price": 204700
	}, {
	    "id": "#Cust18",
	    "date": "2024-09-13",
	    "name": "Steve",
	    "country": "Korea",
	    "flag": "korea.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Orange",
	    "quantity": 1,
	    "price": 808000
	}, {
	    "id": "#Cust19",
	    "date": "2024-09-12",
	    "name": "Anna",
	    "country": "Japan",
	    "flag": "japan.png",
	    "product": "Galaxy S25",
	    "color": "Gray",
	    "quantity": 7,
	    "price": 701800
	}, {
	    "id": "#Cust20",
	    "date": "2024-09-11",
	    "name": "Kim",
	    "country": "UK",
	    "flag": "uk.png",
	    "product": "IPhone 16 Pro",
	    "color": "Pink",
	    "quantity": 9,
	    "price": 31000
	}, {
	    "id": "#Cust21",
	    "date": "2024-09-10",
	    "name": "Kim",
	    "country": "China",
	    "flag": "china.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Blue",
	    "quantity": 10,
	    "price": 640200
	}, {
	    "id": "#Cust22",
	    "date": "2024-09-09",
	    "name": "Anna",
	    "country": "Singapore",
	    "flag": "singapore.png",
	    "product": "IPhone 16 Pro",
	    "color": "Green",
	    "quantity": 20,
	    "price": 149300
	}, {
	    "id": "#Cust23",
	    "date": "2024-09-08",
	    "name": "Emma",
	    "country": "France",
	    "flag": "france.png",
	    "product": "IPhone 16",
	    "color": "Violet",
	    "quantity": 0,
	    "price": 234800
	}, {
	    "id": "#Cust24",
	    "date": "2024-09-07",
	    "name": "Kim",
	    "country": "USA",
	    "flag": "usa.png",
	    "product": "IPhone 16 Pro",
	    "color": "Gray",
	    "quantity": 3,
	    "price": 269000
	}, {
	    "id": "#Cust25",
	    "date": "2024-09-06",
	    "name": "Emma",
	    "country": "Korea",
	    "flag": "korea.png",
	    "product": "IPhone 16",
	    "color": "Blue",
	    "quantity": 1,
	    "price": 917700
	}, {
	    "id": "#Cust26",
	    "date": "2024-09-05",
	    "name": "Jennifer",
	    "country": "China",
	    "flag": "china.png",
	    "product": "Galaxy S25",
	    "color": "Yellow",
	    "quantity": 10,
	    "price": 838900
	}, {
	    "id": "#Cust27",
	    "date": "2024-09-04",
	    "name": "Jennifer",
	    "country": "Singapore",
	    "flag": "singapore.png",
	    "product": "Galaxy S25",
	    "color": "Violet",
	    "quantity": 20,
	    "price": 93700
	}, {
	    "id": "#Cust28",
	    "date": "2024-09-03",
	    "name": "Kim",
	    "country": "France",
	    "flag": "france.png",
	    "product": "IPhone 16 Pro",
	    "color": "Blue",
	    "quantity": 0,
	    "price": 403500
	}, {
	    "id": "#Cust29",
	    "date": "2024-09-02",
	    "name": "Steve",
	    "country": "UK",
	    "flag": "uk.png",
	    "product": "Galaxy Note21",
	    "color": "Yellow",
	    "quantity": 9,
	    "price": 881000
	}, {
	    "id": "#Cust30",
	    "date": "2024-09-01",
	    "name": "Lowrence",
	    "country": "Singapore",
	    "flag": "singapore.png",
	    "product": "Galaxy S25",
	    "color": "Pink",
	    "quantity": 20,
	    "price": 348000
	}, {
	    "id": "#Cust31",
	    "date": "2024-08-31",
	    "name": "Steve",
	    "country": "Japan",
	    "flag": "japan.png",
	    "product": "IPhone 16 Pro",
	    "color": "Gray",
	    "quantity": 7,
	    "price": 871700
	}, {
	    "id": "#Cust32",
	    "date": "2024-08-30",
	    "name": "Anna",
	    "country": "UK",
	    "flag": "uk.png",
	    "product": "IPhone 16",
	    "color": "Yellow",
	    "quantity": 9,
	    "price": 653100
	}, {
	    "id": "#Cust33",
	    "date": "2024-08-29",
	    "name": "Kim",
	    "country": "Korea",
	    "flag": "korea.png",
	    "product": "IPhone 16",
	    "color": "Gray",
	    "quantity": 1,
	    "price": 873500
	}, {
	    "id": "#Cust34",
	    "date": "2024-08-28",
	    "name": "Steve",
	    "country": "UK",
	    "flag": "uk.png",
	    "product": "IPhone 16 Pro",
	    "color": "Orange",
	    "quantity": 9,
	    "price": 643600
	}, {
	    "id": "#Cust35",
	    "date": "2024-08-27",
	    "name": "Emma",
	    "country": "Italy",
	    "flag": "italy.png",
	    "product": "IPhone 16",
	    "color": "Orange",
	    "quantity": 15,
	    "price": 664200
	}, {
	    "id": "#Cust36",
	    "date": "2024-08-26",
	    "name": "Lowrence",
	    "country": "China",
	    "flag": "china.png",
	    "product": "IPhone 16",
	    "color": "Orange",
	    "quantity": 10,
	    "price": 736900
	}, {
	    "id": "#Cust37",
	    "date": "2024-08-25",
	    "name": "Kim",
	    "country": "Italy",
	    "flag": "italy.png",
	    "product": "Galaxy S25",
	    "color": "Gray",
	    "quantity": 15,
	    "price": 739300
	}, {
	    "id": "#Cust38",
	    "date": "2024-08-24",
	    "name": "Lowrence",
	    "country": "Ireland",
	    "flag": "ireland.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Pink",
	    "quantity": 12,
	    "price": 195600
	}, {
	    "id": "#Cust39",
	    "date": "2024-08-23",
	    "name": "Lowrence",
	    "country": "Singapore",
	    "flag": "singapore.png",
	    "product": "IPhone 16",
	    "color": "Pink",
	    "quantity": 20,
	    "price": 64500
	}, {
	    "id": "#Cust40",
	    "date": "2024-08-22",
	    "name": "Lowrence",
	    "country": "Singapore",
	    "flag": "singapore.png",
	    "product": "IPhone 16",
	    "color": "Blue",
	    "quantity": 20,
	    "price": 873400
	}, {
	    "id": "#Cust41",
	    "date": "2024-08-21",
	    "name": "Steve",
	    "country": "USA",
	    "flag": "usa.png",
	    "product": "IPhone 16",
	    "color": "Orange",
	    "quantity": 3,
	    "price": 821600
	}, {
	    "id": "#Cust42",
	    "date": "2024-08-20",
	    "name": "Kim",
	    "country": "UK",
	    "flag": "uk.png",
	    "product": "Galaxy S25",
	    "color": "Yellow",
	    "quantity": 9,
	    "price": 971100
	}, {
	    "id": "#Cust43",
	    "date": "2024-08-19",
	    "name": "Kim",
	    "country": "China",
	    "flag": "china.png",
	    "product": "Galaxy Note21",
	    "color": "Blue",
	    "quantity": 10,
	    "price": 165400
	}, {
	    "id": "#Cust44",
	    "date": "2024-08-18",
	    "name": "Jennifer",
	    "country": "Italy",
	    "flag": "italy.png",
	    "product": "IPhone 16",
	    "color": "Yellow",
	    "quantity": 15,
	    "price": 781600
	}, {
	    "id": "#Cust45",
	    "date": "2024-08-17",
	    "name": "Kim",
	    "country": "Italy",
	    "flag": "italy.png",
	    "product": "Galaxy Note21",
	    "color": "Orange",
	    "quantity": 15,
	    "price": 964400
	}, {
	    "id": "#Cust46",
	    "date": "2024-08-16",
	    "name": "Jennifer",
	    "country": "USA",
	    "flag": "usa.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Violet",
	    "quantity": 3,
	    "price": 441200
	}, {
	    "id": "#Cust47",
	    "date": "2024-08-15",
	    "name": "Kim",
	    "country": "Singapore",
	    "flag": "singapore.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Yellow",
	    "quantity": 20,
	    "price": 560900
	}, {
	    "id": "#Cust48",
	    "date": "2024-08-14",
	    "name": "Lowrence",
	    "country": "France",
	    "flag": "france.png",
	    "product": "Galaxy S25",
	    "color": "Gray",
	    "quantity": 0,
	    "price": 680000
	}, {
	    "id": "#Cust49",
	    "date": "2024-08-13",
	    "name": "Steve",
	    "country": "UK",
	    "flag": "uk.png",
	    "product": "Galaxy S25",
	    "color": "Violet",
	    "quantity": 9,
	    "price": 512100
	}, {
	    "id": "#Cust50",
	    "date": "2024-08-12",
	    "name": "Jennifer",
	    "country": "Korea",
	    "flag": "korea.png",
	    "product": "IPhone 16 Pro",
	    "color": "Yellow",
	    "quantity": 1,
	    "price": 572800
	}, {
	    "id": "#Cust51",
	    "date": "2024-08-11",
	    "name": "Steve",
	    "country": "USA",
	    "flag": "usa.png",
	    "product": "Galaxy Note21",
	    "color": "Green",
	    "quantity": 3,
	    "price": 345600
	}, {
	    "id": "#Cust52",
	    "date": "2024-08-10",
	    "name": "Emma",
	    "country": "Ireland",
	    "flag": "ireland.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Violet",
	    "quantity": 12,
	    "price": 287600
	}, {
	    "id": "#Cust53",
	    "date": "2024-08-09",
	    "name": "Steve",
	    "country": "Ireland",
	    "flag": "ireland.png",
	    "product": "IPhone 16 Pro",
	    "color": "Pink",
	    "quantity": 12,
	    "price": 307500
	}, {
	    "id": "#Cust54",
	    "date": "2024-08-08",
	    "name": "Emma",
	    "country": "Korea",
	    "flag": "korea.png",
	    "product": "IPhone 16",
	    "color": "Yellow",
	    "quantity": 1,
	    "price": 835200
	}, {
	    "id": "#Cust55",
	    "date": "2024-08-07",
	    "name": "Lowrence",
	    "country": "Singapore",
	    "flag": "singapore.png",
	    "product": "IPhone 16 Pro",
	    "color": "Pink",
	    "quantity": 20,
	    "price": 112800
	}, {
	    "id": "#Cust56",
	    "date": "2024-08-06",
	    "name": "Anna",
	    "country": "Japan",
	    "flag": "japan.png",
	    "product": "IPhone 16 Pro",
	    "color": "Orange",
	    "quantity": 7,
	    "price": 822200
	}, {
	    "id": "#Cust57",
	    "date": "2024-08-05",
	    "name": "Lowrence",
	    "country": "Singapore",
	    "flag": "singapore.png",
	    "product": "Galaxy S25",
	    "color": "Violet",
	    "quantity": 20,
	    "price": 694300
	}, {
	    "id": "#Cust58",
	    "date": "2024-08-04",
	    "name": "Jennifer",
	    "country": "France",
	    "flag": "france.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Green",
	    "quantity": 0,
	    "price": 197900
	}, {
	    "id": "#Cust59",
	    "date": "2024-08-03",
	    "name": "Steve",
	    "country": "Japan",
	    "flag": "japan.png",
	    "product": "IPhone 16",
	    "color": "Blue",
	    "quantity": 7,
	    "price": 955200
	}, {
	    "id": "#Cust60",
	    "date": "2024-08-02",
	    "name": "Kim",
	    "country": "Korea",
	    "flag": "korea.png",
	    "product": "Galaxy Note21",
	    "color": "Yellow",
	    "quantity": 1,
	    "price": 4400
	}, {
	    "id": "#Cust61",
	    "date": "2024-08-01",
	    "name": "Emma",
	    "country": "UK",
	    "flag": "uk.png",
	    "product": "Galaxy S25",
	    "color": "Green",
	    "quantity": 9,
	    "price": 517100
	}, {
	    "id": "#Cust62",
	    "date": "2024-07-31",
	    "name": "Emma",
	    "country": "France",
	    "flag": "france.png",
	    "product": "Galaxy S25",
	    "color": "Violet",
	    "quantity": 0,
	    "price": 128500
	}, {
	    "id": "#Cust63",
	    "date": "2024-07-30",
	    "name": "Lowrence",
	    "country": "Ireland",
	    "flag": "ireland.png",
	    "product": "Galaxy Note21",
	    "color": "Pink",
	    "quantity": 12,
	    "price": 468700
	}, {
	    "id": "#Cust64",
	    "date": "2024-07-29",
	    "name": "Lowrence",
	    "country": "Singapore",
	    "flag": "singapore.png",
	    "product": "IPhone 16",
	    "color": "Green",
	    "quantity": 20,
	    "price": 51100
	}, {
	    "id": "#Cust65",
	    "date": "2024-07-28",
	    "name": "Emma",
	    "country": "Singapore",
	    "flag": "singapore.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Gray",
	    "quantity": 20,
	    "price": 119300
	}, {
	    "id": "#Cust66",
	    "date": "2024-07-27",
	    "name": "Lowrence",
	    "country": "China",
	    "flag": "china.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Yellow",
	    "quantity": 10,
	    "price": 595800
	}, {
	    "id": "#Cust67",
	    "date": "2024-07-26",
	    "name": "Anna",
	    "country": "Ireland",
	    "flag": "ireland.png",
	    "product": "IPhone 16 Pro",
	    "color": "Yellow",
	    "quantity": 12,
	    "price": 745200
	}, {
	    "id": "#Cust68",
	    "date": "2024-07-25",
	    "name": "Lowrence",
	    "country": "Singapore",
	    "flag": "singapore.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Gray",
	    "quantity": 20,
	    "price": 681300
	}, {
	    "id": "#Cust69",
	    "date": "2024-07-24",
	    "name": "Anna",
	    "country": "USA",
	    "flag": "usa.png",
	    "product": "Galaxy S25",
	    "color": "Orange",
	    "quantity": 3,
	    "price": 344100
	}, {
	    "id": "#Cust70",
	    "date": "2024-07-23",
	    "name": "Lowrence",
	    "country": "UK",
	    "flag": "uk.png",
	    "product": "Galaxy S25",
	    "color": "Blue",
	    "quantity": 9,
	    "price": 69700
	}, {
	    "id": "#Cust71",
	    "date": "2024-07-22",
	    "name": "Kim",
	    "country": "France",
	    "flag": "france.png",
	    "product": "Galaxy S25",
	    "color": "Violet",
	    "quantity": 0,
	    "price": 379700
	}, {
	    "id": "#Cust72",
	    "date": "2024-07-21",
	    "name": "Jennifer",
	    "country": "Italy",
	    "flag": "italy.png",
	    "product": "Galaxy S25",
	    "color": "Pink",
	    "quantity": 15,
	    "price": 115300
	}, {
	    "id": "#Cust73",
	    "date": "2024-07-20",
	    "name": "Jennifer",
	    "country": "Korea",
	    "flag": "korea.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Yellow",
	    "quantity": 1,
	    "price": 535700
	}, {
	    "id": "#Cust74",
	    "date": "2024-07-19",
	    "name": "Jennifer",
	    "country": "China",
	    "flag": "china.png",
	    "product": "IPhone 16 Pro",
	    "color": "Green",
	    "quantity": 10,
	    "price": 517500
	}, {
	    "id": "#Cust75",
	    "date": "2024-07-18",
	    "name": "Lowrence",
	    "country": "China",
	    "flag": "china.png",
	    "product": "IPhone 16 Pro",
	    "color": "Pink",
	    "quantity": 10,
	    "price": 464900
	}, {
	    "id": "#Cust76",
	    "date": "2024-07-17",
	    "name": "Jennifer",
	    "country": "Singapore",
	    "flag": "singapore.png",
	    "product": "Galaxy S25",
	    "color": "Gray",
	    "quantity": 20,
	    "price": 70300
	}, {
	    "id": "#Cust77",
	    "date": "2024-07-16",
	    "name": "Lowrence",
	    "country": "France",
	    "flag": "france.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Pink",
	    "quantity": 0,
	    "price": 538000
	}, {
	    "id": "#Cust78",
	    "date": "2024-07-15",
	    "name": "Emma",
	    "country": "USA",
	    "flag": "usa.png",
	    "product": "Galaxy Note21",
	    "color": "Violet",
	    "quantity": 3,
	    "price": 409000
	}, {
	    "id": "#Cust79",
	    "date": "2024-07-14",
	    "name": "Emma",
	    "country": "Italy",
	    "flag": "italy.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Pink",
	    "quantity": 15,
	    "price": 595000
	}, {
	    "id": "#Cust80",
	    "date": "2024-07-13",
	    "name": "Kim",
	    "country": "Singapore",
	    "flag": "singapore.png",
	    "product": "IPhone 16 Pro",
	    "color": "Blue",
	    "quantity": 20,
	    "price": 764800
	}, {
	    "id": "#Cust81",
	    "date": "2024-07-12",
	    "name": "Kim",
	    "country": "Ireland",
	    "flag": "ireland.png",
	    "product": "Galaxy Note21",
	    "color": "Orange",
	    "quantity": 12,
	    "price": 694500
	}, {
	    "id": "#Cust82",
	    "date": "2024-07-11",
	    "name": "Kim",
	    "country": "China",
	    "flag": "china.png",
	    "product": "Galaxy Note21",
	    "color": "Green",
	    "quantity": 10,
	    "price": 712300
	}, {
	    "id": "#Cust83",
	    "date": "2024-07-10",
	    "name": "Anna",
	    "country": "Ireland",
	    "flag": "ireland.png",
	    "product": "IPhone 16",
	    "color": "Blue",
	    "quantity": 12,
	    "price": 863700
	}, {
	    "id": "#Cust84",
	    "date": "2024-07-09",
	    "name": "Emma",
	    "country": "Ireland",
	    "flag": "ireland.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Violet",
	    "quantity": 12,
	    "price": 918900
	}, {
	    "id": "#Cust85",
	    "date": "2024-07-08",
	    "name": "Jennifer",
	    "country": "Japan",
	    "flag": "japan.png",
	    "product": "Galaxy Note21",
	    "color": "Pink",
	    "quantity": 7,
	    "price": 849000
	}, {
	    "id": "#Cust86",
	    "date": "2024-07-07",
	    "name": "Anna",
	    "country": "Italy",
	    "flag": "italy.png",
	    "product": "Galaxy S25",
	    "color": "Green",
	    "quantity": 15,
	    "price": 896600
	}, {
	    "id": "#Cust87",
	    "date": "2024-07-06",
	    "name": "Anna",
	    "country": "Korea",
	    "flag": "korea.png",
	    "product": "IPhone 16 Pro",
	    "color": "Yellow",
	    "quantity": 1,
	    "price": 865100
	}, {
	    "id": "#Cust88",
	    "date": "2024-07-05",
	    "name": "Emma",
	    "country": "Ireland",
	    "flag": "ireland.png",
	    "product": "Galaxy Note21",
	    "color": "Orange",
	    "quantity": 12,
	    "price": 750900
	}, {
	    "id": "#Cust89",
	    "date": "2024-07-04",
	    "name": "Lowrence",
	    "country": "France",
	    "flag": "france.png",
	    "product": "IPhone 16 Pro",
	    "color": "Violet",
	    "quantity": 0,
	    "price": 345900
	}, {
	    "id": "#Cust90",
	    "date": "2024-07-03",
	    "name": "Emma",
	    "country": "Korea",
	    "flag": "korea.png",
	    "product": "Galaxy Note21",
	    "color": "Pink",
	    "quantity": 1,
	    "price": 930700
	}, {
	    "id": "#Cust91",
	    "date": "2024-07-02",
	    "name": "Kim",
	    "country": "Singapore",
	    "flag": "singapore.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Violet",
	    "quantity": 20,
	    "price": 692700
	}, {
	    "id": "#Cust92",
	    "date": "2024-07-01",
	    "name": "Kim",
	    "country": "Ireland",
	    "flag": "ireland.png",
	    "product": "IPhone 16",
	    "color": "Violet",
	    "quantity": 12,
	    "price": 979100
	}, {
	    "id": "#Cust93",
	    "date": "2024-06-30",
	    "name": "Kim",
	    "country": "Korea",
	    "flag": "korea.png",
	    "product": "Galaxy S25 Ultra",
	    "color": "Gray",
	    "quantity": 1,
	    "price": 28200
	}, {
	    "id": "#Cust94",
	    "date": "2024-06-29",
	    "name": "Jennifer",
	    "country": "Italy",
	    "flag": "italy.png",
	    "product": "Galaxy Note21",
	    "color": "Pink",
	    "quantity": 15,
	    "price": 283700
	}, {
	    "id": "#Cust95",
	    "date": "2024-06-28",
	    "name": "Anna",
	    "country": "Japan",
	    "flag": "japan.png",
	    "product": "Galaxy Note21",
	    "color": "Pink",
	    "quantity": 7,
	    "price": 940000
	}, {
	    "id": "#Cust96",
	    "date": "2024-06-27",
	    "name": "Kim",
	    "country": "Italy",
	    "flag": "italy.png",
	    "product": "IPhone 16 Pro",
	    "color": "Pink",
	    "quantity": 15,
	    "price": 822900
	}, {
	    "id": "#Cust97",
	    "date": "2024-06-26",
	    "name": "Lowrence",
	    "country": "France",
	    "flag": "france.png",
	    "product": "Galaxy Note21",
	    "color": "Pink",
	    "quantity": 0,
	    "price": 239400
	}, {
	    "id": "#Cust98",
	    "date": "2024-06-25",
	    "name": "Lowrence",
	    "country": "Korea",
	    "flag": "korea.png",
	    "product": "Galaxy Note21",
	    "color": "Gray",
	    "quantity": 1,
	    "price": 922600
	}, {
	    "id": "#Cust99",
	    "date": "2024-06-24",
	    "name": "Steve",
	    "country": "USA",
	    "flag": "usa.png",
	    "product": "Galaxy Note21",
	    "color": "Violet",
	    "quantity": 3,
	    "price": 701300
	}];

    // AUIGrid 생성 후 반환 ID
    let myGridID;

    // 시작점
    function init() {
        // AUIGrid 그리드를 생성합니다.
        createAUIGrid();
        
        AUIGrid.setGridData(myGridID, data);
    }

    // AUIGrid 를 생성합니다.
    function createAUIGrid() {
    	// 그리드 칼럼 레이아웃 설정
		const columnLayout = [{
			dataField: "id",
			headerText: "ID",
			width: 120
		}, {
			dataField: "name",
			headerText: "Name",
			width: 140
		}, {
			dataField: "country",
			headerText: "Country",
			width: 140
		}, {
			dataField: "flag",
			headerText: "Flag IMG",
			editable: false,
			prefix: "./assets/",
			renderer: {
				type: "ImageRenderer",
				imgHeight: 24,
				altField: "country"
			},
			width: 100
		}, {
			dataField: "product",
			headerText: "Product",
			width: 140
		}, {
			dataField: "color",
			headerText: "Color",
			width: 100
		}, {
			dataField: "price",
			headerText: "Price",
			dataType: "numeric",
			style: "my-column",
			width: 120,
			editRenderer: {
				type: "InputEditRenderer",
				onlyNumeric: true, // 0~9만 입력가능
				textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
				autoThousandSeparator: true	// 천단위 구분자 삽입 여부
			}
		}, {
			dataField: "quantity",
			headerText: "Quantity",
			dataType: "numeric",
			style: "my-column",
			width: 100,
			editRenderer: {
				type: "InputEditRenderer",
				onlyNumeric: true, // 0~9만 입력가능
				textAlign: "right", // 오른쪽 정렬로 입력되도록 설정
				autoThousandSeparator: true	// 천단위 구분자 삽입 여부
			}
		}, {
			dataField: "date",
			headerText: "Date",
			dataType: "date",
			dateInputFormat: "yyyy-mm-dd", // 데이터의 날짜 형식
			formatString: "yyyy년 mm월 dd일" // 그리드에 보여줄 날짜 형식
		}];

		// 그리드 속성 설정
		const gridProps = {
			// 편집 가능 여부 (기본값 : false)
			editable: true,
			// 셀 병합 실행
			enableCellMerge: true,
			// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
			enterKeyColumnBase: true,
			// 셀 선택모드 (기본값: singleCell)
			selectionMode: "multipleCells",
			// 컨텍스트 메뉴 사용 여부 (기본값 : false)
			useContextMenu: true,
			// 필터 사용 여부 (기본값 : false)
			enableFilter: true,
			// 그룹핑 패널 사용
			useGroupingPanel: false,
			// 상태 칼럼 사용
			showStateColumn: true,
			// 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
			displayTreeOpen: true,
			noDataMessage: "출력할 데이터가 없습니다.",
			groupingMessage: "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
			headerHeight: 32,
			rowHeight: 32,
  			showRowNumColumn: true,
			rowNumHeaderText: "#"
		};

        // 실제로 #grid_wrap 에 그리드 생성
        myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridProps);
    }
</script>

</html>