<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
	<title>Yamaha Music Australia - YMEC - Enquire about courses</title>

	<meta name="Title" content="Yamaha Music Australia - Music Education" />
	<meta name="Description" content="Yamaha Music Education Centres provide music lessons and online enrolment for children right accross Victoria, New South Wales and South Australia. Our Music Wonderland, Junior Music and Group Music Classes are perfect for children from 3 - 12 years of age." />
	<meta name="Keywords" content="music lessons, music education, keyboard lessons, piano lessons, solfege singing, kinder music classes, music for children, yamaha music education centre, yamaha music lessons, young musicians, junior music, music courses, music wonderland, free information sessions, yamaha music school, class timetable, enrolment, Balwyn North, Berwick, Blackburn, Brighton, Canterbury, Eltham North, Endeavour Hills, Glen Waverley, Malvern, Newport, Strathmore, Thornbury, Adelaide, Baulkham Hills, Chatswood, Dulwich Hill, Jannali, Wentworthville, Yamaha, Music, Education, Wonderland, Family, Music Days, Dreams, Musicians, Keyboards, Teachers, Teach, Learn, Passionate, Kindergarten, Prep, Children, Novice, Learner, Audio, Visual, HiFi Components, Musical, Instruments, Pianos, Grand Pianos, Upright Pianos, Disclavier, Guitars, Pacifica, Drums, Paiste, Cymbals, Brass, Woodwind, Clavinova, Electronic, Keyboards, Tyros, Synth, Synthesizers, Pro Audio, PA, Mixers, Desks, Mixing Desks, Power Amps, Rock, Roll, Swing, Jazz, Blues, Hip Hop, Latin, Country, Western, Oz Music, Trumpets, Trombones, Flutes, Saxaphones, Music Connect, YMEC, Music Education, YAYPC, Youth Piano Competition" />
	<meta name="Date" content="01/07/2006" />
	<meta name="Language" content="English" />
	<meta name="Publisher" content="Yamaha Music Australia Pty Ltd" />
	<meta name="Rights" content="Copyright 2006, Yamaha Music Australia." />

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

	<style type="text/css" media="screen">@import "/yamahamusic.css";</style>
	<style type="text/css" media="print">@import "/yamahamusic.print.css";</style>
	<style type="text/css" media="screen">@import "/yamahamusic.nav.css";</style>
	<style type="text/css" media="screen">@import "yamahamusic.ymec.css";

	#address_block {
		display : <%= E._getEnquirySendDVD()==1?"block":"none" %>;
		padding-left : 20px;
		margin-bottom : 20px;
		border : 1px #CCC solid;
	}

	</style>


	<script type="text/javascript" src="/prototype.js"></script>
	<script type="text/javascript" src="/utility.js"></script>
	<script>


	function showAddress() {
		if ($('send_dvd_y').checked) {
			var style = { display: 'block' };
			var h = $H(style);
			Element.setStyle($('address_block'), h);
		} else {
			var style = { display: 'none' };
			var h = $H(style);
			Element.setStyle($('address_block'), h);
		}
		calculate(null);
	}

	</script>

</head>

<body>
<!--#include file="global/globalHeader.asp" -->
<!--#include file="global/globalOuterContentStart.asp" -->
<div id="left">
<!--#include file="global/navigationLeftShallow.asp" -->
</div>
<div id="banner"><img src="images/pageBannerGeneral.jpg"/></div>
<!--#include file="global/globalMainContentStart.asp" -->


<h1>YMEC Enquiry</h1>
<h2>One of our Yamaha Music Education Teachers will happily respond to your questions.</h2>
<p>So we are able to direct your request to the appropriate area, please complete the following form.</p>

<%
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>
<form name="enquiryForm" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= ENQUIRY_SEND %>">

	<p><strong>Which course are you interested in?</strong>
	<br/><select name="courseid" id="courseid" style="width:200px;">
		<option value="">any course</option><%

	var EC = new EdCourse();
	var rsEC = EC._getAllCourses();
	if (rsEC && !rsEC.EOF) {
		while (!rsEC.EOF) {
			%><option value="<%= rsEC("id") %>"<%= parseInt(Request("courseid"))==parseInt(rsEC("id"))?" selected=\"selected\"":"" %>><%= rsEC("name") %></option><%
			rsEC.MoveNext();
		}
	}

	%></select></p>

	<p><strong>Which of the following locations is most convenient for you?</strong>
	<br/><select name="centreid" style="width:200px;">
<%
	var EC = new EdCentre();
	var rsEC = EC._getAllCentre(1, null);
	if (rsEC && !rsEC.EOF) {
		while (!rsEC.EOF) {
			%><option value="<%= rsEC("id") %>"<%= parseInt(E._getEnquiryCentreID())==parseInt(rsEC("id"))?" selected=\"selected\"":"" %>><%= rsEC("state") %> : <%= rsEC("name") %></option><%
			rsEC.MoveNext();
		}
	}

%></select></p>

	<p><strong>What is your name?</strong>
	<br/><input type="text" name="name" value="<%= E._getEnquiryName() %>" /></p>

	<p><strong>What is your family name?</strong>
	<br/><input type="text" name="family_name" value="<%= E._getEnquiryFamilyName() %>" /></p>

  <p><strong>What is your child's name?</strong>
	<br/><input type="text" name="childs_name" value="<%= E._getEnquiryChildsName() %>" /></p>

	<p><label for"date"><strong>What is your child's date of birth?</strong></label>
	<%

		var dRef = new String(E._getEnquiryChildsDOB());
		if (dRef.length != 0) {
			dRef = new Date(Date.parse(dRef));
		} else {
			dRef = new Date();
		}
		var refDay = dRef.getDate();
		var refMonth = dRef.getMonth();
		var refYear = dRef.getFullYear();
	%>
	<select name="fDay">
		<option value="0">day...</option><%
		for (var i=1; i <= 31; i++) {
			%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
		}
	%></select>&nbsp;
	<select name="fMonth">
		<option value="0">month...</option><%
		for (var i=0; i < 12; i++) {
			%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
		}
	%></select>&nbsp;
	<select name="fYear">
		<option value="0">year...</option><%
		for (var i=2006; i >= 1970; i--) {
			%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
		}
	%></select></p>

	<p><strong>What is your telephone number?</strong>
	<br/><input type="text" name="phone" value="<%= E._getEnquiryPhone() %>" /></p>

	<p><strong>Would you like a free copy of our promotional DVD?</strong><br/>
	<input type="radio" id="send_dvd_y" name="send_dvd" value="1" onclick="showAddress()" <%= E._getEnquirySendDVD()==1?" checked=\"checked\"":"" %>/>Yes &nbsp;&nbsp;
	<input type="radio" id="send_dvd_n" name="send_dvd" value="0" onclick="showAddress()" <%= E._getEnquirySendDVD()==0?" checked=\"checked\"":"" %>/>No</p>

	<fieldset id="address_block">

		<legend>Please provide your address details for shipping</legend>

		<p><strong>Address</strong>
		<br/><textarea name="address" rows="2" style="width:300px;"><%= E._getEnquiryAddress() %></textarea></p>

		<p><strong>Suburb</strong>
		<br/><input type="text" name="suburb" value="<%= E._getEnquirySuburb() %>" /></p>

		<p><strong>State</strong><br/>
		<select name="state" style="width:200px;" >
			<option value="">choose state...</option><%
			for (var i=0; i < GBL_STATES_SHORT.length; i++) {
				%><option value="<%= GBL_STATES_SHORT[i] %>"<%= E._getEnquiryState().indexOf(GBL_STATES_SHORT[i])==0?" selected=\"selected\"":"" %>><%= GBL_STATES_LONG[i] %></option><%
			}
		%></select></p>

		<p><strong>Postcode</strong>
		<br/><input type="text" name="postcode" value="<%= E._getEnquiryPostcode() %>" style="width:80px;" /></p>




	</fieldset>



	<p><strong>What is your preferred contact time?</strong>
	<br/><select name="time" style="width:200px;">
		<option value="">choose...</option><%
		for (var i=0; i < arrCsTimes.length; i++) {
			%><option value="<%= arrCsTimes[i] %>"<%= new String(E._getEnquiryTime()).indexOf(arrCsTimes[i])==0?" selected=\"selected\"":"" %>><%= arrCsTimes[i] %></option><%
		}
	%></select></p>

	<p><strong>Do you have any additional comments?</strong>
	<br/><textarea name="comments" rows="3" style="width:400px;"><%= E._getEnquiryComments() %></textarea></p>

	<p><input type="submit" name="submit" value="submit enquiry" class="button"/></p>

</form>





<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>