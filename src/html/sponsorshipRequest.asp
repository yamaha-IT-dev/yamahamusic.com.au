<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
	<title>Yamaha Music Australia - Sponsorship</title>

	<meta name="Title" content="Yamaha Music Australia - Music Education" />
	<meta name="Description" content="" />
	<meta name="Keywords" content="music lessons, music education, keyboard lessons, piano lessons, solfege singing, kinder music classes, music for children, yamaha music education centre, yamaha music lessons, young musicians, junior music, music courses, music wonderland, free information sessions, yamaha music school, class timetable, enrolment, Balwyn North, Berwick, Blackburn, Brighton, Canterbury, Eltham North, Endeavour Hills, Glen Waverley, Malvern, Newport, Strathmore, Thornbury, Adelaide, Baulkham Hills, Chatswood, Dulwich Hill, Jannali, Wentworthville, Yamaha, Music, Education, Wonderland, Family, Music Days, Dreams, Musicians, Keyboards, Teachers, Teach, Learn, Passionate, Kindergarten, Prep, Children, Novice, Learner, Audio, Visual, HiFi Components, Musical, Instruments, Pianos, Grand Pianos, Upright Pianos, Disclavier, Guitars, Pacifica, Drums, Paiste, Cymbals, Brass, Woodwind, Clavinova, Electronic, Keyboards, Tyros, Synth, Synthesizers, Pro Audio, PA, Mixers, Desks, Mixing Desks, Power Amps, Rock, Roll, Swing, Jazz, Blues, Hip Hop, Latin, Country, Western, Oz Music, Trumpets, Trombones, Flutes, Saxaphones, Music Connect, YMEC, Music Education, YAYPC, Youth Piano Competition" />
	<meta name="Date" content="01/07/2006" />
	<meta name="Language" content="English" />
	<meta name="Publisher" content="Yamaha Music Australia Pty Ltd" />
	<meta name="Rights" content="Copyright 2006, Yamaha Music Australia." />

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

	<script type="text/javascript" src="/utility.js"></script>
	<style type="text/css" media="screen">@import "/yamahamusic.css";</style>
	<style type="text/css" media="print">@import "/yamahamusic.print.css";</style>
	<style type="text/css" media="screen">@import "/yamahamusic.nav.css";</style>
	<style type="text/css" media="screen">@import "yamahamusic.sponsorship.css";</style>
	<style type="text/css" media="screen">
	

	fieldset.text {
		margin : 10px 0 10px 0;
	}

	fieldset.text label {
		float : left;
		width : 8em;
	}
	
	</style>

</head>

<body>
<!--#include file="global/globalHeader.asp" -->
<!--#include file="global/globalOuterContentStart.asp" -->
<div id="left">
	<!--#include file="global/navigationLeftShallow.asp" -->
</div>
<!--#include file="global/globalMainContentStart.asp" -->

<h1>Yamaha Music Australia Sponsorship Application</h1>

<h2>Please complete all details below to ensure your application is processed promptly.</h2>
<p><strong>All fields must be completed.</strong></p>
<% 
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>
<form action="<%= CONTROLLER %>" method="post" enctype="multipart/form-data">
	<fieldset class="text">
	<input type="hidden" name="action" value="<%= REQUEST_SEND %>" />

	<p><label for"name">Name</label>
	<input type="text" name="name" style="width:180px;" value="<%= R._getRequestName() %>" /></p>

	<p><label for"organisation">Organisation</label>
	<input type="text" name="organisation" style="width:180px;" value="<%= R._getRequestOrganisation() %>" /></p>

	<p><label for"email">Email</label>
	<input type="text" name="email" style="width:180px;" value="<%= R._getRequestEmail() %>" /></p>

	<p><label for"date">Event date or deadline</label>
		<%
		
		var dRef = new String(R._getRequestDate());
		if (dRef.length != 0) {
			dRef = new Date(Date.parse(dRef));
		} else {
			dRef = new Date();
		}
		var this_year = dRef.getFullYear();
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
		for (var i=this_year; i < this_year+5; i++) {
			%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
		}
	%></select></p>

	</fieldset>
	<fieldset>

	<p><label for"location">Organisation or Event Location</label><br/>
	<textarea name="location" rows="2" style="width:300px;"><%= R._getRequestLocation() %></textarea></p>

	<p><label for"venue">Event Venue</label><br/>
	<textarea name="venue" rows="2" style="width:300px;"><%= R._getRequestVenue() %></textarea></p>

	<p><label for"purpose">What is the purpose of your event?</label><br/>
	<textarea name="purpose" rows="4" style="width:300px;"><%= R._getRequestPurpose() %></textarea></p>

	<p><label for"requirements">What do you require from Yamaha Music Australia? </label><br/>
	<textarea name="requirements" rows="4" style="width:300px;"><%= R._getRequestRequirements() %></textarea></p>

	<p><label for"benefits">How will Yamaha Music Australia benefit from this sponsorship?</label><br/>
	<textarea name="benefits" rows="4" style="width:300px;"><%= R._getRequestBenefits() %></textarea></p>

	<p><label for"information">Please add any additional information that will assist in processing your sponsorship request.</label><br/>
	<textarea name="information" rows="4" style="width:300px;"><%= R._getRequestInformation() %></textarea></p>

	<p>Feel welcome to attach any documentation / supporting files to assist your application.<br/>
	<input type="file" name="attachment" size="40" /><br/>
	<small>If you have multiple files you may, collate them in a .ZIP archive<br/>
	We will not accept attachments larger than 5.0Mb</small></p>

	<p><input type="submit" name="submit" value="submit request" class="button"/></p>

	</fieldset>
</form>




<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>