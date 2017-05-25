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

<h2>Teacher Absence</h2>
<% 
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>
<form name="formTeacher" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= SEND_ABSENCE %>" />

	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><label for="region">Location</label></td>
		<td style="padding-right:20px;"><select name="city" style="width:200px;">
			<option value="">choose...</option><%
			
			var rsEC = EC._getAllCentre(1, null); 
			if (rsEC) {
				while (!rsEC.EOF) {
			
					%><option value="<%= rsEC("id") %>"<%= parseInt(F._getFormCity())==rsEC("id")?" selected=\"selected\"":"" %>><%= rsEC("state") %> - <%= rsEC("name") %></option><%
				
					rsEC.MoveNext();
				}
			}
		%></select></td>
		<td rowspan="4"><label for="comments">Reasons for Absence</label><br/><%

			var tmpReasons = F._getFormReasons().split(", ");

			for (var i=0; i < arrAbsence.length; i++) {
				var checked = false;
				for (var j=0; j < tmpReasons.length; j++) {
					if (new String(arrAbsence[i]).indexOf(tmpReasons[j]) == 0 && new String(tmpReasons[j]).length != 0) {
						checked = true;
						break;
					}
				}
				%><input type="checkbox" name="reasons" value="<%= arrAbsence[i] %>"<%= checked?" checked=\"checked\"":"" %>><%= arrAbsence[i] %><br/><%
			}
			
			var strOther = tmpReasons[tmpReasons.length-1];
			
		%><input type="text" name="reasons" value="<%= strOther %>" style="width:100px;"/></td>
	</tr>
	<tr>
		<td><label for="date">Date</label></td>
		<td style="white-space:nowrap;"><%
		
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
		<td><label for="teachercode">Teacher Code</label></td>
		<td><select name="teachercode" style="width:150px;">
			<option value="">choose...</option><%
			var arrT = T._getAllTeachers();
			
			for (var i=0; i < arrT.length; i++) {
				T._loadTeacher(arrT[i]);
				%><option value="<%= T._getTeacherCode() %>"<%= new String(F._getFormTeachercode()).indexOf(T._getTeacherCode())==0?" selected=\"selected\"":"" %>><%= T._getTeacherCode() + " : " + T._getTeacherName() %></option><%
			}
		%></select></td>
	</tr>
	<tr>
		<td>Time of Absence</td>
		<td><label style="float:left;width:4em;">From </label><%
		
			var dRef = new String(F._getFormDatecommence());
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
		%></select><br/>
		<label style="float:left;width:4em;">Until</label><%
		
			var dRef = new String(F._getFormDaterecommence());
			if (dRef.length != 0) {
				dRef = new Date(Date.parse(dRef));
			} else {
				dRef = new Date();
			}
			var refDay = dRef.getDate();
			var refMonth = dRef.getMonth();
			var refYear = dRef.getFullYear();
		%>
		<select name="rcDay">
			<option value="0">day...</option><%
			for (var i=1; i <= 31; i++) {
				%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>&nbsp;
		<select name="rcMonth">
			<option value="0">month...</option><%
			for (var i=0; i < 12; i++) {
				%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
			}
		%></select>&nbsp;
		<select name="rcYear">
			<option value="0">year...</option><%
			for (var i=curYear+2; i >= curYear-2; i--) {
				%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select></td>
	</tr>
	</table>

	<h2>Replacement Teachers / Cancellations</h2>
	<table border="0" cellpadding="0" cellspacing="0" class="noborder">
	<tr>
		<th>Date</th>
		<th>Time</th>
		<th>Class</th>
		<th>Replacement</th>
		<th>Comments</th>
		<th>&nbsp;</th>
	</tr>
<% 




	for (a = 0; a < arrAbsentClasses.length; a++) {

		var tmpAC = arrAbsentClasses[a];

	%>
		<tr>
			<td><input type="hidden" name="absent" value="<%= a %>" />
			<%

				var dRef = new String(tmpAC.datescheduled);
				if (dRef.length != 0) {
					dRef = new Date(Date.parse(dRef));
				} else {
					dRef = new Date();
				}
				var refDay = dRef.getDate();
				var refMonth = dRef.getMonth();
				var refYear = dRef.getFullYear();
			%>
			<select name="cDay_<%= a %>">
				<option value="0">DD</option><%
				for (var i=1; i <= 31; i++) {
					%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
				}
			%></select><select name="cMonth_<%= a %>">
				<option value="0">MM</option><%
				for (var i=0; i < 12; i++) {
					%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= i+1 %></option><%
				}
			%></select><select name="cYear_<%= a %>">
				<option value="0">YYYY</option><%
				for (var i=curYear+2; i >= curYear-2; i--) {
					%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
				}
			%></select></td>
			<td><% 

			var intH = dRef.getHours();
			var intM = dRef.getMinutes();

			%>
			<select name="cHour_<%= a %>"><%
			for (i = 1; i <= 23; i++) {
				%><option value="<%= i %>"<%= intH==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
			%></select>
            <select name="cMinute_<%= a %>">
                <option value="00">00</option>
                <option value="15">15</option>
                <option value="30">30</option>
                <option value="45">45</option>
              </select>
            </td>
			<td><input name="classcode_<%= a %>" type="text" value="<%= tmpAC.classcode %>" style="width:50px;"/></td>
			<td><select name="teachercode_<%= a %>" style="width:150px;">
				<option value="">choose...</option>
				<option value="CANCEL">NONE : Cancel Class</option><%
				var arrT = T._getAllTeachers();

				for (var i=0; i < arrT.length; i++) {
					T._loadTeacher(arrT[i]);
					%><option value="<%= T._getTeacherCode() %>"<%= new String(tmpAC.teachercode).indexOf(T._getTeacherCode())==0?" selected=\"selected\"":"" %>><%= T._getTeacherCode() + " : " + T._getTeacherName() %></option><%
				}
			%></select></td>
			<td><input name="comments_<%= a %>" type="text" value="<%= tmpAC.comment %>" style="width:100px;"/></td>
			<td><% 
			if (a == arrAbsentClasses.length-1) {
				%><input type="submit" name="add" value="ADD ANOTHER" class="button" onclick="document.forms['formTeacher'].elements['action'].value='add_class';" /><% 
			} else {
				%>&nbsp;<%
			}
			%></td>
		</tr>
<% 
	}
%>
	</table>
	
	<p><input type="submit" name="submit" value="submit" class="button" />



</form>









<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>