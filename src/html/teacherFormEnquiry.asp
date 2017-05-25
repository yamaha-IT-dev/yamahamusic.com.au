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
	<style type="text/css" media="screen">@import "/yamahamusic.hideright.css";</style>
	<style type="text/css" media="screen">@import "/yamahamusic.discussion.css";</style>
	<style type="text/css" media="screen">
		
		#main {
			width : 760px;
		}
	
	</style>
	
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

<h2>Capture a New Student Enquiry</h2>
<% 
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>
<form name="formTeacher" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= SEND_ENQUIRY %>" />

	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><label for="region">Region</label></td>
		<td style="padding-right:20px;"><select name="region" style="width:100px;">
			<option value="">choose...</option><%
			for (var i=0; i < GBL_REGIONS.length; i++) {
				%><option value="<%= GBL_REGIONS[i] %>"<%= new String(F._getFormRegion()).indexOf(GBL_REGIONS[i])==0?" selected=\"selected\"":"" %>><%= GBL_REGIONS[i] %></option><%
			}
		%></select></td>
		<td><label for="city">City</label></td>
		<td><input name="city" type="text" value="<%= F._getFormCity() %>" style="width:100px;"/></td>
	</tr>
	<tr>
		<td><label for="student">Student Name</label></td>
		<td><input name="student" type="text" value="<%= F._getFormStudent() %>" style="width:100px;"/></td>
		<td><label for="date">Date</label></td>
		<td><%
		
			var dRef = new String(F._getFormDate());
			if (dRef.length != 0) {
				dRef = new Date(Date.parse(dRef));
			} else {
				dRef = new Date();
			}
			var refDay = dRef.getDate();
			var refMonth = dRef.getMonth();
			var refYear = dRef.getFullYear();
			var curYear = new Date().getFullYear();
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
			for (var i=curYear+2; i >= curYear-2; i--) {
				%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select></td>
	</tr>
	<tr>
		<td><label for="date">Date of Birth</label></td>
		<td colspan="3"><%
		
			var dRef = new String(F._getFormDate());
			if (dRef.length != 0) {
				dRef = new Date(Date.parse(dRef));
			} else {
				dRef = new Date();
			}
			var refDay = dRef.getDate();
			var refMonth = dRef.getMonth();
			var refYear = dRef.getFullYear();
		%>
		<select name="dDay">
			<option value="0">day...</option><%
			for (var i=1; i <= 31; i++) {
				%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>&nbsp;
		<select name="dMonth">
			<option value="0">month...</option><%
			for (var i=0; i < 12; i++) {
				%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
			}
		%></select>&nbsp;
		<select name="dYear">
			<option value="0">year...</option><%
			for (var i=2006; i >= 1970; i--) {
				%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select></td>
	</tr>
	<tr>
		<th colspan="4" style="padding-top:10px;">Parent Details</th>
	</tr>
	<tr>
		<td><label for="studentmumsname">Mothers Name</label></td>
		<td colspan="3"><input name="studentmumsname" type="text" value="<%= F._getFormStudentmumsname() %>" style="width:200px;"/></td>
	</tr>
	<tr>
		<td><label for="studentdadsname">Fathers Name</label></td>
		<td colspan="3"><input name="studentdadsname" type="text" value="<%= F._getFormStudentdadsname() %>" style="width:200px;"/></td>
	</tr>
	<tr>
		<td><label for="studentaddress">Address</label></td>
		<td colspan="3"><textarea name="studentaddress" rows="3" style="width:300px;"><%= F._getFormStudentaddress() %></textarea></td>
	</tr>
	<tr>
		<td><label for="studenthomephone">Phone - Home</label></td>
		<td><input name="studenthomephone" type="text" value="<%= F._getFormStudenthomephone() %>" style="width:100px;"/></td>
		<td><label for="studentmobilephone">Phone - Mobile</label></td>
		<td><input name="studentmobilephone" type="text" value="<%= F._getFormStudentmobilephone() %>" style="width:100px;"/></td>
	</tr>
	<tr>
		<td><label for="studentworkphone">Phone - Work</label></td>
		<td><input name="studentworkphone" type="text" value="<%= F._getFormStudentworkphone() %>" style="width:100px;"/></td>
		<td><label for="studentemail">Email Address</label></td>
		<td><input name="studentemail" type="text" value="<%= F._getFormStudentemail() %>" style="width:100px;"/></td>
	</tr>
	<tr>
		<th colspan="4" style="padding-top:10px;">Timetable / Course Selection</th>
	</tr>
	<tr>
		<td><label for="studentcourse">Course</label></td>
		<td colspan="3"><select name="studentcourse" style="width:150px;">
			<option value="">choose...</option><%
			for (var i=0; i < arrCourses.length; i++) {
				%><option value="<%= arrCourses[i] %>"<%= new String(F._getFormStudentcourse()).indexOf(arrCourses[i])==0?" selected=\"selected\"":"" %>><%= arrCourses[i] %></option><%
			}
		%></select></td>
	</tr>
	<tr>
		<td><label for="studentday">Day + Time</label></td>
		<td colspan="3"><select name="studentday" style="width:80px;">
			<option value="">choose...</option><%
			for (var i=0; i < GBL_DAYS.length; i++) {
				%><option value="<%= GBL_DAYS[i] %>"<%= new String(F._getFormStudentday()).indexOf(GBL_DAYS[i])==0?" selected=\"selected\"":"" %>><%= GBL_DAYS[i] %></option><%
			}
 		%></select>&nbsp;<input name="studenttime" type="text" value="<%= F._getFormStudenttime() %>" style="width:100px;"/></td>
	</tr>
	<tr>
		<td><label for="studentlocation">Location</label></td>
		<td colspan="3"><input name="studentlocation" type="text" value="<%= F._getFormStudentlocation() %>" style="width:150px;"/></td>
	</tr>
	<tr>
		<th colspan="4" style="padding-top:10px;">Nature of Enquiry</th>
	</tr>
	<tr>
		<td><label for="enquiry">Enquiry</label></td>
		<td colspan="3"><%
			var tmpEnquiry = F._getFormStudentenquiry().split(", ");
			for (var i=0; i < arrEnquiry.length; i++) {
				var checked = false;
				for (var j=0; j < tmpEnquiry.length; j++) {
					if (new String(arrEnquiry[i]).indexOf(tmpEnquiry[j]) == 0 && new String(tmpEnquiry[j]).length != 0) {
						checked = true;
						break;
					}
				}
				%><input type="checkbox" name="enquiry" value="<%= arrEnquiry[i] %>"<%= checked?" checked=\"checked\"":"" %>><%= arrEnquiry[i] %><br/><%
			}
		%></td>
	</tr>
	<tr>
		<td><label for="comments">Comments</label></td>
		<td colspan="3"><textarea name="comments" rows="3" style="width:300px;"><%= F._getFormComments() %></textarea></td>
	</tr>
	</table>
	
	<p><input type="submit" name="submit" value="submit" class="button" />



</form>







<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>