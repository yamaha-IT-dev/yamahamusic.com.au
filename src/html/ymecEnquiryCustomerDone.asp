<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
	<title>Yamaha Music Australia - YMEC - Customer Registration Complete</title>

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
		<li><p>Participate in a free lesson</p></li>
		<li><p><strong>Login or register your details</strong></p></li>
		<li><p>Register your students</p></li>
		<li><p>Tell us your preferred contact</p></li>
		<li><p>Finish</strong></p></li>
	</ol>

</div>

<h1>Register Your Details</h1>

<h2>Customer Sign Up</h2>

<h3>Thanks <%= C._getCustomerFirstname() %>, your registration has been successful</h3>

<p>Could you please provide us with a few details about the prospective students who will be attending YMEC?</p>

<p><a href="<%= CONTROLLER %>?action=<%= ENQUIRY_STUDENT %>">Yeah Sure</a></p>

<p><a href="<%= CONTROLLER %>?action=<%= ENQUIRY_HOME %>">Cancel Enquiry </a></p>





<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>