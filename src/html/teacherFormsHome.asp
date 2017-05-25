<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
	<title>Yamaha Music Australia - YMEC - Teacher Network - Forms</title>

	<meta name="description" content="" />
	<meta name="keywords" content="" />

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

	<script type="text/javascript" src="/utility.js"></script>
	<style type="text/css" media="screen">@import "/yamahamusic.css";</style>
	<style type="text/css" media="print">@import "/yamahamusic.print.css";</style>
	<style type="text/css" media="screen">@import "/yamahamusic.nav.css";</style>

<!--#include file="global/navigationStylesheet.asp" -->

</head>

<body>
<!--#include file="global/globalHeader.asp" -->
<!--#include file="global/globalOuterContentStart.asp" -->
				<div id="left">
<!--#include file="global/navigationLeftShallow.asp" -->
				</div>
<!--#include file="global/globalMainContentStart.asp" -->


<h1>YMEC Teacher Network</h1>

<% 
	var boolCoordinator = true;
	var T = new Teacher();
		boolCoordinator = T._isCoordinator(Session("yma_userid"));

	if (boolCoordinator) {
	
%>
	<p>The following forms are to facilitate stronger knowledge sharing and traceability for teachers.</p>

	<h2>Teacher Absence</h2>
	<p>Complete this form to advise the people about a planned teacher absence and the teachers who will cover their classes while absent.
	<br/><a href="<%= CONTROLLER %>?action=<%= FORM_ABSENCE %>" class="form">Teacher Absence Form</a></p>

	<h2>Enquiry Capture</h2>
	<p>Complete this form to advise the relevant administrative people about a student registration enquiry that you have had
	<br/><a href="<%= CONTROLLER %>?action=<%= FORM_ENQUIRY %>" class="form">Enquiry Capture Form</a></p>

	<h2>Transfer</h2>
	<p>Complete this form to advise the national co-ordinator, and relevant colleagues of a student transfer from one class to another.
	<br/><a href="<%= CONTROLLER %>?action=<%= FORM_TRANSFER %>" class="form">Transfer Form</a></p>

	<h2>Discontinuation</h2>
	<p>Complete this form to advise the national co-ordinator, and relevant colleagues when a student / parents have decided not to pursue musical education with YMEC.
	<br/><a href="<%= CONTROLLER %>?action=<%= FORM_DISCONTINUE %>" class="form">Discontinuation Form</a></p>

	<h2>Leave of Absence</h2>
	<p>Complete this form to advise the national co-ordinator, and relevant colleagues if a student will not be attending classes.
	<br/><a href="<%= CONTROLLER %>?action=<%= FORM_LEAVE %>" class="form">Leave of Absense Form</a></p>

	<h2>Make Up Lesson</h2>
	<p>Complete this form to advise the national co-ordinator, and relevant colleagues when scheduling a make-up lesson for a student.
	<br/><a href="<%= CONTROLLER %>?action=<%= FORM_MAKEUP %>" class="form">Make Up Lesson Form</a></p>
<%
	} else {

%>
	<p>Sorry, at this time the forms available are for use by regional co-ordinators only.
<% 
	}
%>


<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>