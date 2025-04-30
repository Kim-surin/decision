<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script type="text/javascript" src="/rcs/js/plugin/ckeditor/ckeditor.js"></script>

	<style type="text/css">
		#cke_ckeditor{
			margin-left: 14px;
    		margin-right: 14px;
		}
	</style>
</head>
<body>
	<div class="row">
		<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
			<h1 class="page-title txt-color-blueDark"><i class="fa-fw fa fa-puzzle-piece"></i> 일일업무 <span>> 업무일지 작성</span></h1>
		</div>
	</div>
<!-- widget grid -->
<section id="widget-grid" class="">
	<div class="well">
		<div class="input-group">
			<div class="row">
				<form action="" id="searchForm" class="s4-form" novalidate="novalidate" style="margin-left: 14px;margin-right: 8px;">
					<section class="col col-5">
						<label class="select">
							<select name="country">
								<option value="0" selected="" disabled="">Country</option>
								<option value="244">Aaland Islands</option>
								<option value="1">Afghanistan</option>
								<option value="2">Albania</option>
								<option value="3">Algeria</option>
								<option value="4">American Samoa</option>
								<option value="5">Andorra</option>
								<option value="6">Angola</option>
								<option value="7">Anguilla</option>
							</select> <i></i> </label>
					</section>
	
					<section class="col col-4">
						<label class="input">
							<input type="text" name="city" placeholder="City">
						</label>
					</section>
	
					<section class="col col-3">
						<label class="input">
							<input type="text" name="code" placeholder="Post code">
						</label>
					</section>
				</form>
			</div>
			<div class="input-group-btn">
				<button class="btn btn-default btn-primary" type="button">
					<i class="fa fa-search"></i> Search
				</button>
			</div>
		</div>
	</div>	
	<div class="row">
		<form action="" id="checkout-form" class="s4-form" novalidate="novalidate" style="margin-left: 14px;margin-right: 8px;">
			<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div class="well">
					<fieldset>
						<div class="row">
							<section class="col col-6">
								<label class="input"> <i class="icon-prepend fa fa-user"></i>
									<input type="text" name="fname" placeholder="First name">
								</label>
							</section>
							<section class="col col-6">
								<label class="input"> <i class="icon-prepend fa fa-user"></i>
									<input type="text" name="lname" placeholder="Last name">
								</label>
							</section>
						</div>
					</fieldset>
					<textarea name="ckeditor">
					&lt;h1&gt;&lt;img alt="Saturn V carrying Apollo 11" class="right" src="img/demo/sample.jpg"/&gt; Apollo 11&lt;/h1&gt; &lt;p&gt;&lt;b&gt;Apollo 11&lt;/b&gt; was the spaceflight that landed the first humans, Americans &lt;a href="http://en.wikipedia.org/wiki/Neil_Armstrong" title="Neil Armstrong"&gt;Neil Armstrong&lt;/a&gt; and &lt;a href="http://en.wikipedia.org/wiki/Buzz_Aldrin" title="Buzz Aldrin"&gt;Buzz Aldrin&lt;/a&gt;, on the Moon on July 20, 1969, at 20:18 UTC. Armstrong became the first to step onto the lunar surface 6 hours later on July 21 at 02:56 UTC.&lt;/p&gt; &lt;p&gt;Armstrong spent about &lt;strike&gt;three and a half&lt;/strike&gt; two and a half hours outside the spacecraft, Aldrin slightly less; and together they collected 47.5 pounds (21.5&amp;nbsp;kg) of lunar material for return to Earth. A third member of the mission, &lt;a href="http://en.wikipedia.org/wiki/Michael_Collins_(astronaut)" title="Michael Collins (astronaut)"&gt;Michael Collins&lt;/a&gt;, piloted the &lt;a href="http://en.wikipedia.org/wiki/Apollo_Command/Service_Module" title="Apollo Command/Service Module"&gt;command&lt;/a&gt; spacecraft alone in lunar orbit until Armstrong and Aldrin returned to it for the trip back to Earth.&lt;/p&gt; &lt;h2&gt;Broadcasting and &lt;em&gt;quotes&lt;/em&gt; &lt;a id="quotes" name="quotes"&gt;&lt;/a&gt;&lt;/h2&gt; &lt;p&gt;Broadcast on live TV to a world-wide audience, Armstrong stepped onto the lunar surface and described the event as:&lt;/p&gt; &lt;blockquote&gt;&lt;p&gt;One small step for [a] man, one giant leap for mankind.&lt;/p&gt;&lt;/blockquote&gt; &lt;p&gt;Apollo 11 effectively ended the &lt;a href="http://en.wikipedia.org/wiki/Space_Race" title="Space Race"&gt;Space Race&lt;/a&gt; and fulfilled a national goal proposed in 1961 by the late U.S. President &lt;a href="http://en.wikipedia.org/wiki/John_F._Kennedy" title="John F. Kennedy"&gt;John F. Kennedy&lt;/a&gt; in a speech before the United States Congress:&lt;/p&gt; &lt;blockquote&gt;&lt;p&gt;[...] before this decade is out, of landing a man on the Moon and returning him safely to the Earth.&lt;/p&gt;&lt;/blockquote&gt; &lt;h2&gt;Technical details &lt;a id="tech-details" name="tech-details"&gt;&lt;/a&gt;&lt;/h2&gt; &lt;table align="right" border="1" bordercolor="#ccc" cellpadding="5" cellspacing="0" style="border-collapse:collapse;margin:10px 0 10px 15px;"&gt; &lt;caption&gt;&lt;strong&gt;Mission crew&lt;/strong&gt;&lt;/caption&gt; &lt;thead&gt; &lt;tr&gt; &lt;th scope="col"&gt;Position&lt;/th&gt; &lt;th scope="col"&gt;Astronaut&lt;/th&gt; &lt;/tr&gt; &lt;/thead&gt; &lt;tbody&gt; &lt;tr&gt; &lt;td&gt;Commander&lt;/td&gt; &lt;td&gt;Neil A. Armstrong&lt;/td&gt; &lt;/tr&gt; &lt;tr&gt; &lt;td&gt;Command Module Pilot&lt;/td&gt; &lt;td&gt;Michael Collins&lt;/td&gt; &lt;/tr&gt; &lt;tr&gt; &lt;td&gt;Lunar Module Pilot&lt;/td&gt; &lt;td&gt;Edwin &amp;quot;Buzz&amp;quot; E. Aldrin, Jr.&lt;/td&gt; &lt;/tr&gt; &lt;/tbody&gt; &lt;/table&gt; &lt;p&gt;Launched by a &lt;strong&gt;Saturn V&lt;/strong&gt; rocket from &lt;a href="http://en.wikipedia.org/wiki/Kennedy_Space_Center" title="Kennedy Space Center"&gt;Kennedy Space Center&lt;/a&gt; in Merritt Island, Florida on July 16, Apollo 11 was the fifth manned mission of &lt;a href="http://en.wikipedia.org/wiki/NASA" title="NASA"&gt;NASA&lt;/a&gt;&amp;#39;s Apollo program. The Apollo spacecraft had three parts:&lt;/p&gt; &lt;ol&gt; &lt;li&gt;&lt;strong&gt;Command Module&lt;/strong&gt; with a cabin for the three astronauts which was the only part which landed back on Earth&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Service Module&lt;/strong&gt; which supported the Command Module with propulsion, electrical power, oxygen and water&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Lunar Module&lt;/strong&gt; for landing on the Moon.&lt;/li&gt; &lt;/ol&gt; &lt;p&gt;After being sent to the Moon by the Saturn V&amp;#39;s upper stage, the astronauts separated the spacecraft from it and travelled for three days until they entered into lunar orbit. Armstrong and Aldrin then moved into the Lunar Module and landed in the &lt;a href="http://en.wikipedia.org/wiki/Mare_Tranquillitatis" title="Mare Tranquillitatis"&gt;Sea of Tranquility&lt;/a&gt;. They stayed a total of about 21 and a half hours on the lunar surface. After lifting off in the upper part of the Lunar Module and rejoining Collins in the Command Module, they returned to Earth and landed in the &lt;a href="http://en.wikipedia.org/wiki/Pacific_Ocean" title="Pacific Ocean"&gt;Pacific Ocean&lt;/a&gt; on July 24.&lt;/p&gt; &lt;hr/&gt; &lt;p style="text-align: right;"&gt;&lt;small&gt;Source: &lt;a href="http://en.wikipedia.org/wiki/Apollo_11"&gt;Wikipedia.org&lt;/a&gt;&lt;/small&gt;&lt;/p&gt;
	       			</textarea>		
				</div>
			</article>
		</form>
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
		preferencesCKEditor();
	}
	
	function preferencesCKEditor(){
		CKEDITOR.replace( 'ckeditor', { height: '580px', startupFocus : true} );
	}
		
	


</script>
	
</body>
</html>