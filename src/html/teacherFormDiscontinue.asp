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

<h2>Student Discontinuation</h2>
<%
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>
<form name="formTeacher" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= SEND_DISCONTINUE %>" />

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
	</tr>
	<tr>
		<td><label for="student">Student</label></td>
		<td><input name="student" type="text" value="<%= F._getFormStudent() %>" style="width:100px;"/></td>
	</tr>
	<tr>
		<td><label for="date">Date of initial contact</label></td>
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
		<th colspan="2" style="padding-top:10px;">Current Class</th>
	</tr>
	<tr>
		<td><label for="classcode">Class Code</label></td>
		<td><input name="classcode" type="text" value="<%= F._getFormClasscode() %>" style="width:100px;"/></td>
	</tr>
	<tr>
		<td><label for="booklevel">Book Level</label></td>
		<td><input name="booklevel" type="text" value="<%= F._getFormBooklevel() %>" style="width:100px;"/></td>
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
		<td><label for="comments">Reasons for Discontinuation</label></td>
		<td><%

			var tmpReasons = F._getFormReasons().split(", ");
/*
			for (var i=0; i < arrReasons.length; i++) {
				var checked = false;
				for (var j=0; j < tmpReasons.length; j++) {
					if (new String(arrReasons[i]).indexOf(tmpReasons[j]) == 0 && new String(tmpReasons[j]).length != 0) {
						checked = true;
						break;
					}
				}
				%><input type="checkbox" name="reasons" value="<%= arrReasons[i] %>"<%= checked?" checked=\"checked\"":"" %>><%= arrReasons[i] %><br/><%
			}
*/
			a = (new VBArray(ARR_REASONS.Keys())).toArray();
			s = "";
			for (i = 0; i < a.length; i++)
			{
				var checked = false;
				for (var j=0; j < tmpReasons.length; j++) {
					if (new String(a[i]).indexOf(tmpReasons[j]) == 0 && new String(tmpReasons[j]).length != 0) {
						checked = true;
						break;
					}
				}
				//s += a[i] + "<br/>";
				//Response.Write(a[i] + " : " +  + "<br/>")
				%><input type="checkbox" name="reasons" value="<%= a[i] %>"<%= checked?" checked=\"checked\"":"" %>><%= ARR_REASONS(a[i]) %><br/>
				<%
			}

		%></td>
	</tr>

	<tr>
		<td><label for="why_fee_waived">Discontinuation Point</label><input name="informed_of_fee" type="hidden" value="Yes" /></td>
		<td><select name="why_fee_waived">
        		<option value="did-not-start">Did not start</option>
                <option value="1-week">1 week</option>
                <option value="1-4-weeks">1-4 weeks</option>
                <option value="5-10-weeks">5-10 weeks</option>
                <option value="11-15-weeks">11-15 weeks</option>
                <option value="full-semester">Full semester</option>
              </select>        
        </td>
	</tr>
	<tr>
		<td><label for="lessons_attended">How many lessons were attended?</label></td>
		<td><input name="lessons_attended" type="text" value="<%= F._getFormLessonsattended() %>" style="width:50px;"/></td>
	</tr>
	<tr>
		<td><label for="books_taken">Add to database?</label></td>
		<td>
			<input name="books_taken" type="radio" value="Yes" <%= F._getFormBookstaken().indexOf("Yes")==0?" checked=\"checked\"":"" %>/>Yes<br/>
			<input name="books_taken" type="radio" value="No"  <%= F._getFormBookstaken().indexOf("No") ==0?" checked=\"checked\"":"" %>/>No<br/>
		</td>
	</tr>



	<tr>
		<td><label for="comments">Comments</label></td>
		<td><textarea name="comments" rows="3" style="width:300px;"><%= F._getFormComments() %></textarea></td>
	</tr>
	
	</table>

	<p><input type="submit" name="submit" value="submit" class="button" />



</form>









<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>