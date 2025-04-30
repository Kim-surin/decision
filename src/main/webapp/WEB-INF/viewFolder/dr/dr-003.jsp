<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script type="text/javascript" src="/rcs/js/plugin/moment/moment.min.js"></script>
	<script type="text/javascript" src="/rcs/js/plugin/fullcalendar/jquery.fullcalendar.min.js"></script>
	<style type="text/css">
	
	.inbox-compose-footer, .inbox-download, .inbox-info-bar, .inbox-message {
    	margin-right: inherit;
    	position: relative;
	}
	</style>
</head>
<body>
	<div class="row">
		<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
			<h1 class="page-title txt-color-blueDark"><i class="fa-fw fa fa-puzzle-piece"></i> 일일업무 <span>> Schedule</span></h1>
		</div>
	</div>
<!-- widget grid -->
<section id="widget-grid" class="">
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-sm-12 col-md-12 col-lg-12">
			
			<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-3" data-widget-editbutton="false" data-widget-colorbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false">

				<header>
					<span class="widget-icon"> <i class="fa fa-calendar"></i> </span>
					<h2> My Events </h2>
					<div class="widget-toolbar">
						<!-- add: non-hidden - to disable auto hide -->
						<div class="btn-group" style="margin-top: 4px;">
							<button class="btn dropdown-toggle btn-xs btn-default" data-toggle="dropdown">
								Showing <i class="fa fa-caret-down"></i>
							</button>
							<ul class="dropdown-menu js-status-update pull-right">
								<li>
									<a href="javascript:void(0);" id="mt">Month</a>
								</li>
								<li>
									<a href="javascript:void(0);" id="ag">Agenda</a>
								</li>
								<li>
									<a href="javascript:void(0);" id="td">Today</a>
								</li>
							</ul>
						</div>
					</div>
				</header>

				<!-- widget div-->
				<div>
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">

						<input class="form-control" type="text">

					</div>
					<!-- end widget edit box -->

					<div class="widget-body no-padding">
						<!-- content goes here -->
						<div class="widget-body-toolbar">

							<div id="calendar-buttons">

								<div class="btn-group">
									<a href="javascript:void(0)" class="btn btn-default btn-xs" id="btn-prev"><i class="fa fa-chevron-left"></i></a>
									<a href="javascript:void(0)" class="btn btn-default btn-xs" id="btn-next"><i class="fa fa-chevron-right"></i></a>
								</div>
							</div>
						</div>
						<div id="calendar"></div>

						<!-- end content -->
					</div>

				</div>
				<!-- end widget div -->
			</div>
			<!-- end widget -->

		</article>

	</div>
	<!-- end row -->
</section>
<!-- end widget grid -->

<script type="text/javascript">
	$(document).ready(function() {
		pageSetUp();					// 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		initialize_viewObject();		// 화면에서 사용하는 Selelect Box, Calendar 등을 생성합니다.
	});
	
	// Page Object Initialize
	function initialize_viewObject() {
		setupCalendar();
	}
	
	


	function setupCalendar() {
	
	    if ($("#calendar").length) {
	        var date = new Date();
	        var d = date.getDate();
	        var m = date.getMonth();
	        var y = date.getFullYear();
	
	        calendar = $('#calendar').fullCalendar({
	
	            editable: true,
	            draggable: true,
	            selectable: false,
	            selectHelper: true,
	            unselectAuto: false,
	            disableResizing: false,
				height: "auto",
				
	            header: {
	                left: 'title', //,today
	                center: 'prev, next, today',
	                right: 'month, agendaWeek, agenDay' //month, agendaDay,
	            },
	
	            select: function (start, end, allDay) {
	                var title = prompt('Event Title:');
	                if (title) {
	                    calendar.fullCalendar('renderEvent', {
	                            title: title,
	                            start: start,
	                            end: end,
	                            allDay: allDay
	                        }, true // make the event "stick"
	                    );
	                }
	                calendar.fullCalendar('unselect');
	            },
	
	            events: [{
	                title: 'All Day Event',
	                start: new Date(y, m, 1),
	                description: 'long description',
	                className: ["event", "bg-color-greenLight"],
	                icon: 'fa-check'
	            }, {
	                title: 'Long Event',
	                start: new Date(y, m, d - 5),
	                end: new Date(y, m, d - 2),
	                className: ["event", "bg-color-red"],
	                icon: 'fa-lock'
	            }, {
	                id: 999,
	                title: 'Repeating Event',
	                start: new Date(y, m, d - 3, 16, 0),
	                allDay: false,
	                className: ["event", "bg-color-blue"],
	                icon: 'fa-clock-o'
	            }, {
	                id: 999,
	                title: 'Repeating Event',
	                start: new Date(y, m, d + 4, 16, 0),
	                allDay: false,
	                className: ["event", "bg-color-blue"],
	                icon: 'fa-clock-o'
	            }, {
	                title: 'Meeting',
	                start: new Date(y, m, d, 10, 30),
	                allDay: false,
	                className: ["event", "bg-color-darken"]
	            }, {
	                title: 'Lunch',
	                start: new Date(y, m, d, 12, 0),
	                end: new Date(y, m, d, 14, 0),
	                allDay: false,
	                className: ["event", "bg-color-darken"]
	            }, {
	                title: 'Birthday Party',
	                start: new Date(y, m, d + 1, 19, 0),
	                end: new Date(y, m, d + 1, 22, 30),
	                allDay: false,
	                className: ["event", "bg-color-darken"]
	            }, {
	                title: 'Meeting for VIP',
	                start: new Date(y, m, 28),
	                end: new Date(y, m, 29),
	                className: ["event", "bg-color-darken"]
	            }],
	
	            eventRender: function (event, element, icon) {
	                if (!event.description == "") {
	                    element.find('.fc-title').append("<br/><span class='ultra-light'>" + event.description + "</span>");
	                }
	                if (!event.icon == "") {
	                    element.find('.fc-title').append("<i class='air air-top-right fa " + event.icon + " '></i>");
	                }
	            }
	        });
	
	    };
	
	    /* hide default buttons */
	    $('.fc-toolbar .fc-right, .fc-toolbar .fc-center').hide();
	
	}
	
	// calendar prev
	$('#calendar-buttons #btn-prev').click(function () {
	    $('.fc-prev-button').click();
	    return false;
	});
	
	// calendar next
	$('#calendar-buttons #btn-next').click(function () {
	    $('.fc-next-button').click();
	    return false;
	});
	
	// calendar today
	$('#calendar-buttons #btn-today').click(function () {
	    $('.fc-button-today').click();
	    return false;
	});
	
	// calendar month
	$('#mt').click(function () {
	    $('#calendar').fullCalendar('changeView', 'month');
	});
	
	// calendar agenda week
	$('#ag').click(function () {
	    $('#calendar').fullCalendar('changeView', 'agendaWeek');
	});
	
	// calendar agenda day
	$('#td').click(function () {
	    $('#calendar').fullCalendar('changeView', 'agendaDay');
	});
	


</script>
	
</body>
</html>