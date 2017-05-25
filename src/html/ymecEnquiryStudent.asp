<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
	<title>Yamaha Music Australia - YMEC - Student Details</title>

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
		<li><p>Login or register your details</p></li>
		<li><p><strong>Register your students</strong></p></li>
		<li><p>Tell us your preferred contact</p></li>
		<li><p>Finish</strong></p></li>
	</ol>

</div>


<h1>YMEC Prospective Students</h1>



<h3>Okay <%= C._getCustomerFirstname() %>, please provide a few details about your students.</h3>

<h2>Student Details</h2>
<% 
	if (rsStudents && !rsStudents.EOF) {
		%><table border="0" cellpadding="0" cellspacing="0" style="margin-bottom:20px;">
		<tr>
			<th>Name</th>
			<th>Date of Birth</th>
			<th>School Level</th>
			<th>Previous Musical Education</th>
		</tr>
		<%
		while (!rsStudents.EOF) {
			%>
			<tr>
				<td><%= rsStudents("name") %></td>
				<td><%= new Date(Date.parse(rsStudents("dateofbirth"))).formatDate("d/m/Y") %></td>
				<td><%= rsStudents("schoollevel") %></td>
				<td><%= rsStudents("prevedu") %></td>
			</tr>
			<%
			rsStudents.MoveNext();
		}
		%></table><%
	}

%>


<form name="enquiryAddStudent" action="<%= CONTROLLER %>" method="get">
	<input type="hidden" name="action" value="<%= ENQUIRY_STUDENT_SAVE %>" />
	<input type="hidden" name="customerid" value="<%= Session("yma_customerid") %>" />
<%

if (message.length) {
	%><p class="alert"><%= message %><%
}

%>
	<p>Please enter the name, date of birth, school level and previous musical education (if any) of the prospective students hoping to start at a Yamaha Music Education Centre</p>

	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<th colspan="2">Prospective Student</th>
	</tr>
	<tr>
		<td>Student Name</td>
		<td><input type="text" name="name" value="<%= S._getStudentName() %>" style="width:100px;" /></td>
	</tr>
	<tr>
		<td>Date of Birth</td>
		<td><%

			var dRef = S._getStudentDateofbirth();
			if (dRef.length != 0) {
				dRef = new Date(Date.parse(dRef));
			} else {
				dRef = new Date();
			}
			var refDay = dRef.getDate();
			var refMonth = dRef.getMonth();
			var refYear = dRef.getFullYear();
		%>
		<select name="dobDay">
			<option value="0">day</option><%
			for (var i=1; i <= 31; i++) {
				%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>&nbsp;
		<select name="dobMonth">
			<option value="0">month</option><%
			for (var i=0; i < 12; i++) {
				%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
			}
		%></select>&nbsp;
		<select name="dobYear">
			<option value="0">year</option><%
			for (var i=2005; i >= 1920; i--) {
				%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select></td>
	</tr>
	<tr>
		<td>School Level</td>
		<td><select name="schoollevel">
			<option value="0">choose...</option><%
			for (var i=1; i < GBL_SCHOOLLEVEL.length; i++) {
				%><option value="<%= GBL_SCHOOLLEVEL[i] %>"<%= S._getStudentSchoolLevel().indexOf(GBL_SCHOOLLEVEL[i])==0?" selected=\"selected\"":"" %>><%= GBL_SCHOOLLEVEL[i] %></option><%
			}
		%></select></td>
	</tr>
	<tr>
		<td>Previous Musicical Education<br/><em>if any, please summarise</em></td>
		<td><textarea name="prevedu" rows="3" style="width:200px;"><%= S._getStudentPrevEdu() %></textarea></td>
	</tr>
	</table>
	
	
	<p><input type="submit" name="submit" value="add student" class="button"/></p>

</form>



<p>
	<a href="<%= CONTROLLER %>?action=<%= ENQUIRY_CHOOSE %>">Back to Course Summary</a> | 
	<a href="<%= CONTROLLER %>?action=<%= ENQUIRY_PREFERRED %>">Tell us your preferred contact?</a>
</p>





<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>