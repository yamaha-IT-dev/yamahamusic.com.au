<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
	<title>Yamaha Music Australia - YMEC - Centres in your area</title>

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

<% 

	if (rsEdCentres && !rsEdCentres.EOF) {
		%>
			<h2>Success!</h2>
			<p>You’re in luck. We have determined that there is at least one Education Centre located nearby for your convenience.</p>
			<p>We would now like a few details so that we can contact you to provide further information and to invite you along to a Family Music Day.</p>

			<p>Would you like to continue with the enquiry?</p>
			<p>
				<a href="<%= CONTROLLER %>?action=<%= ENQUIRY_CUSTOMER %>">Yes - let's go!</a> | 
				<a href="<%= CONTROLLER %>?action=<%= ENQUIRY_HOME %>">No - I'm done</a>
			</p>

		<%
	} else {
		%>
			<h2>Sorry</h2>
			<p>Unfortunately we do not currently have an Education Centre in your area.<br/>
				However, we would be pleased to contact you when a new Centre opens in your area.</p>
			<p>
				<a href="<%= CONTROLLER %>?action=<%= ENQUIRY_CUSTOMER %>">Yes - let's go!</a> | 
				<a href="<%= CONTROLLER %>?action=<%= ENQUIRY_HOME %>">No - I'm done</a>
			</p>

		<%
	}

%>



<p><a href="<%= CONTROLLER %>?action=<%= ENQUIRY_FMD %>">Back to Family Music Day</a></p>





<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>