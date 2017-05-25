<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
	<title>Yamaha Music Australia - YMEC - Family Music Day</title>

	<meta name="description" content="" />
	<meta name="keywords" content="" />

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

	<script type="text/javascript" src="/utility.js"></script>
	<style type="text/css" media="screen">@import "/yamahamusic.css";</style>
	<style type="text/css" media="print">@import "/yamahamusic.print.css";</style>
	<style type="text/css" media="screen">@import "/yamahamusic.nav.css";</style>
	<style type="text/css" media="screen">@import "/yamahamusic.enquiry.css";</style>
	<style type="text/css" media="screen">@import "/yamahamusic.hideright.css";</style>

<!--#include file="global/navigationStylesheet.asp" -->

</head>

<body>
<!--#include file="global/globalHeader.asp" -->
<!--#include file="global/globalOuterContentStart.asp" -->
				<div id="left">
<!--#include file="global/navigationLeftShallow.asp" -->
				</div>
<!--#include file="global/globalMainContentStart.asp" -->

<div id="enquiry">
	<h3>Enquiry Steps</h3>
	<ol>
		<li><p>Enquiry Start</p></li>
		<li><p>Learn about the courses</p></li>
		<li><p><strong>Participate in a free lesson</strong></p></li>
		<li><p>Login or register your details</p></li>
		<li><p>Register your students</p></li>
		<li><p>Tell us your preferred contact</p></li>
		<li><p>Finish</p></li>
	</ol>
</div>


<h1>Family Music Day</h1>

<h2>There is no better way to find out about more about Yamaha Music Education Centres than to join us for a session at a Family Music Day.</h2>

<p>Groups of children and parents join one of our teachers and share a first lesson. It is an entertaining and educational hour for the children with lots of new experiences and activities – they will play their first keyboard piece, participate in activities to develop their aural and rhythm skills as well as reading and writing activities.</p>

<p>Parents will have the opportunity to join in, learning more about how music can play an important part in your child’s life. There’s also time to ask our teachers any questions and the opportunity to enrol into one of our courses.</p>

<p>Family Music Days are held throughout the year and are free and without obligation.</p>

<p>To book into a Family Music Day, or for further information about our courses, please enter your postcode below so that we can connect you to your closest Yamaha Music Education Centre</p>


<form name="enquiryFMDSearch" action="<%= CONTROLLER %>" method="get">
	<input type="hidden" name="action" value="<%= ENQUIRY_FMD_SEARCH %>" />
<%

if (message.length) {
	%><p class="alert"><%= message %><%
}

%>
	<p><strong>Enter your postcode</strong><br/>
	<input type="text" name="postcode" value="" style="width:50px" maxlength="4"></p>
	
	<p><input type="submit" name="submit" value="search" class="button"/></p>

</form>



<p><a href="<%= CONTROLLER %>?action=<%= ENQUIRY_CHOOSE %>">Back to Course Summary</a></p>





<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>