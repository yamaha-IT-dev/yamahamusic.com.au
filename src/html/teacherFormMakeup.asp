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

<h2>Schedule a Make Up Lesson</h2>
<% 
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>
<form name="formTeacher" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= SEND_MAKEUP %>" />

	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><label for="region">Region</label></td>
		<td style="padding-right:20px;"><select name="region" style="width:100px;">
			<option value="">choose...</option><%
			for (var i=0; i < GBL_REGIONS.length; i++) {
				%><option value="<%= GBL_REGIONS[i] %>"<%= new String(F._getFormRegion()).indexOf(GBL_REGIONS[i])==0?" selected=\"selected\"":"" %>><%= GBL_REGIONS[i] %></option><%
			}
		%></select></td>
		<td>&nbsp;</td>
		<td><input name="city" type="hidden" value="city" /></td>
	</tr>
	<tr>
		<td><label for="student">Student</label></td>
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
		<th colspan="2" style="padding-top:10px;">Current Class</th>
		<th colspan="2" style="padding-top:10px;">Make Up Class</th>
	</tr>
	<tr>
		<td><label for="classcode">Class Code</label></td>
		<td><input name="classcode" type="text" value="<%= F._getFormClasscode() %>" style="width:100px;"/></td>
		<td><label for="newclasscode">Class Code</label></td>
		<td><input name="newclasscode" type="text" value="<%= F._getFormNewclasscode() %>" style="width:100px;"/></td>
	</tr>
	<tr>
		<td><label for="booklevel">Book Level</label></td>
		<td><input name="booklevel" type="text" value="<%= F._getFormBooklevel() %>" style="width:100px;"/></td>
		<td><label for="newbooklevel">Book Level</label></td>
		<td><input name="newbooklevel" type="text" value="<%= F._getFormNewbooklevel() %>" style="width:100px;"/></td>
	</tr>
	<tr>
		<td><label for="teachercode">Teacher Code</label></td>
		<td><select name="teachercode" style="width:150px;">
			<option value="">choose...</option><%
			var arrT = T._getAllTeachers();
			
			for (var i=0; i < arrT.length; i++) {
				T._loadTeacher(arrT[i]);
				%><option value="<%= T._getTeacherCode() %>"<%= new String(F._getFormTeachercode()).indexOf(T._getTeacherCode())==0?" selected=\"selected\"":"" %>><%= T._getTeacherCode() + " : " + T._getTeacherName() %></option><%
			}
		%></select></td>
		<td><label for="newteachercode">Teacher Code</label></td>
		<td><select name="newteachercode" style="width:150px;">
			<option value="">choose...</option><%
			var arrT = T._getAllTeachers();
			
			for (var i=0; i < arrT.length; i++) {
				T._loadTeacher(arrT[i]);
				%><option value="<%= T._getTeacherCode() %>"<%= new String(F._getFormNewteachercode()).indexOf(T._getTeacherCode())==0?" selected=\"selected\"":"" %>><%= T._getTeacherCode() + " : " + T._getTeacherName() %></option><%
			}
		%></select></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td><label for="newregion">Region</label></td>
		<td><select name="newregion" style="width:100px;">
			<option value="">choose...</option><%
			for (var i=0; i < GBL_REGIONS.length; i++) {
				%><option value="<%= GBL_REGIONS[i] %>"<%= new String(F._getFormNewregion()).indexOf(GBL_REGIONS[i])==0?" selected=\"selected\"":"" %>><%= GBL_REGIONS[i] %></option><%
			}
		%></select></td>
	</tr>
	<tr>
		<td><label for="date">Date missed</label></td>
		<td colspan="3"><%
		
			var dRef = new String(F._getFormDatemissed());
			if (dRef.length != 0) {
				dRef = new Date(Date.parse(dRef));
			} else {
				dRef = new Date();
			}
			var refDay = dRef.getDate();
			var refMonth = dRef.getMonth();
			var refYear = dRef.getFullYear();
		%>
		<select name="cDay">
			<option value="0">day...</option><%
			for (var i=1; i <= 31; i++) {
				%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>&nbsp;
		<select name="cMonth">
			<option value="0">month...</option><%
			for (var i=0; i < 12; i++) {
				%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
			}
		%></select>&nbsp;
		<select name="cYear">
			<option value="0">year...</option><%
			for (var i=curYear+2; i >= curYear-2; i--) {
				%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select></td>
	</tr>
	<tr>
		<td><label for="date">Date of make up</label></td>
		<td colspan="3"><%
		
			var dRef = new String(F._getFormDatemakeup());
			if (dRef.length != 0) {
				dRef = new Date(Date.parse(dRef));
			} else {
				dRef = new Date();
			}
			var refDay = dRef.getDate();
			var refMonth = dRef.getMonth();
			var refYear = dRef.getFullYear();
		%>
		<select name="mDay">
			<option value="0">day...</option><%
			for (var i=1; i <= 31; i++) {
				%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>&nbsp;
		<select name="mMonth">
			<option value="0">month...</option><%
			for (var i=0; i < 12; i++) {
				%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
			}
		%></select>&nbsp;
		<select name="mYear">
			<option value="0">year...</option><%
			for (var i=curYear+2; i >= curYear-2; i--) {
				%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select></td>
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