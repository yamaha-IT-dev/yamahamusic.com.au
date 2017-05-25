<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
	<title>Yamaha Music Australia - YMEC - Courses</title>

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
		<li><p><strong>Learn about the courses</strong></p></li>
		<li><p>Participate in a free lesson</p></li>
		<li><p>Login or register your details</p></li>
		<li><p>Register your students</p></li>
		<li><p>Tell us your preferred contact</p></li>
		<li><p>Finish</p></li>
	</ol>
<!--	
	<div id="next">
		Next : <a href="<%= CONTROLLER %>?action=<%= ENQUIRY_FMD %>">Participate</a>
	</div>
-->
</div>


<h1>Music Courses</h1>

<p>One of the most important things you can do as a parent is to help your child reach their full potential.</p>
<p>At Yamaha, we encourage every child to achieve this potential by offering more than a dozen different courses to suit the particular age, ability and experience of each child.</p>

<p>To learn more about our courses, please choose the age group of the person you are enquiring about:</p>

<ul>
	<li><h2><a href="<%= CONTROLLER %>?action=<%= ENQUIRY_COURSE %>&course=one">3 years of age</a></h2></li> 
	<li><h2><a href="<%= CONTROLLER %>?action=<%= ENQUIRY_COURSE %>&course=two">4-5 years of age</a></h2></li> 
	<li><h2><a href="<%= CONTROLLER %>?action=<%= ENQUIRY_COURSE %>&course=three">6-8 years of age</a></h2></li>
	<li><h2><a href="<%= CONTROLLER %>?action=<%= ENQUIRY_COURSE %>&course=four">9-12 years of age</a></h2></li>
	<li><h2><a href="<%= CONTROLLER %>?action=<%= ENQUIRY_COURSE %>&course=four">Teenagers & Adults</a></h2></li>
</ul>

<p>
	<a href="<%= CONTROLLER %>?action=<%= ENQUIRY_FMD %>">Learn about Family Music Day</a>
</p>





<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>