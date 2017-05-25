<!--#include file="_gblHeader.asp"-->

	<style type="text/css" media="screen">

	#main { 
		width : auto;
		padding : 0 0 0 0;
	}
	
	label {
		float : left;
		font-weight : bold;
		width : 16em;
		margin-right : 10px;
	}
	
	#timetable_search p {
		float : left;
	}
	
	
	</style>
<h1>List Timetable</h1>
<p><a href="#newentry">Add new entry</a></p>


<form action="<%= CONTROLLER %>" method="post">
	<h2>Filter classes</h2>
	<fieldset id="timetable_search">
	<input type="hidden" name="ajax_action" id="ajax_action" value="ajax_lookup_timetable" />

	<p>Choose Term
	<br/><select name="term" id="term">
		<option value="0">any term</option><% 

	for (i = 1; i <= 4; i++) {
		%><option value="<%= i %>"<%= parseInt(Request("term"))==i?" selected=\"selected\"":"" %>>Term <%= i %></option><%
	}
	
	%></select>&nbsp;</p>

	<p>Choose State
	<br/><select name="state" id="state">
		<option value="">any state</option><% 

	var arrS = new Array("VIC", "NSW", "SA");

	for (i = 0; i < arrS.length; i++) {
		%><option value="<%= arrS[i] %>"<%= Request("state")==arrS[i]?" selected=\"selected\"":"" %>><%= arrS[i] %></option><%
	}
	
	%></select>&nbsp;</p>
	
	<p>Choose centre
	<br/><select name="centreid" id="centreid">
		<option value="">any centre</option><% 

	var EC = new EdCentre();
	var rsEC = EC._getAllCentre(1, null);
	if (rsEC && !rsEC.EOF) {
		while (!rsEC.EOF) {
			%><option value="<%= rsEC("id") %>"<%= parseInt(Request("centreid"))==parseInt(rsEC("id"))?" selected=\"selected\"":"" %>><%= rsEC("state") %> : <%= rsEC("name") %></option><%
			rsEC.MoveNext();
		}
	}
	
	%></select>&nbsp;</p>

	<p>Choose Day
	<br/><select name="day" id="day">
		<option value="">any day</option><% 

	for (i = 1; i < 8; i++) {
		%><option value="<%= i %>"<%= parseInt(Request("day"))==i?" selected=\"selected\"":"" %>><%= GBL_DAYS[i] %></option><%
	}
	
	%></select>&nbsp;</p>

	<p>Choose course
	<br/><select name="courseid" id="courseid">
		<option value="">any course</option><% 

	var EC = new EdCourse();
	var rsEC = EC._getAllCourses();
	if (rsEC && !rsEC.EOF) {
		while (!rsEC.EOF) {
			%><option value="<%= rsEC("id") %>"<%= parseInt(Request("courseid"))==parseInt(rsEC("id"))?" selected=\"selected\"":"" %>><%= rsEC("name") %></option><%
			rsEC.MoveNext();
		}
	}
	
	%></select>&nbsp;</p>
	
	<p>&nbsp;
	<br/><input type="submit" value="go" class="button" /></p>
	</fieldset>
<div id="timetable" style="margin:10px 0 20px 0;">

</div>
	</fieldset>
</form>




<%
	if (rsT && !rsT.EOF) {
		%><table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<th style="font-weight:normal;">Edit</th>
			<th style="font-weight:normal;">Course</th>
			<th style="font-weight:normal;">Age</th>
			<th style="font-weight:normal;">Term</td>
			<th style="font-weight:normal;">Day</td>
			<th style="font-weight:normal;">Time</th>
			<th style="font-weight:normal;">Start Date</th>
			<th style="font-weight:normal;">Status</th>
			<th style="font-weight:normal;">Delete</th>
		</tr>
		<%
		while (!rsT.EOF) {
			if (strCentre.indexOf(rsT("centre")) != 0) {
			%><tr>
				<th colspan="9"><%= rsT("state") %> : <%= rsT("centre") %></th>
			</tr><%
			}
			if (action == EDIT_TIMETABLE && intTimetableID == parseInt(rsT("id"))) {
				%><tr>
					<td><a name="timetable_<%= rsT("id") %>"></a>
					<form action="<%= CONTROLLER %>" method="post">
						<fieldset>
						<input type="hidden" name="action" value="<%= SAVE_TIMETABLE %>" />
						<input type="hidden" name="timetableid" value="<%= rsT("id") %>" />
						<input type="hidden" name="centreid" value="<%= rsT("centreid") %>" />
						<input type="submit" name="submit" value="SAVE" class="button"/>
					</td>
					<td colspan="2"><select name="courseid"><% 
						while (!rsCourses.EOF) {
							%><option value="<%= rsCourses("id") %>" <%= parseInt(rsT("courseid"))==parseInt(rsCourses("id"))?" selected=\"selected\"":"" %>><%= rsCourses("name") %></option><%
							rsCourses.MoveNext();
						}
					%></select></td>
					<td><select name="term"><%
						for (var i = 1; i <= 4; i++) {
							%><option value="<%= i %>"<%= parseInt(rsT("term"))==i?" selected=\"selected\"":"" %>>Term <%= i %></option><%
						}
					%></select></td>
					<td><select name="day"><%
						for (var i = 1; i < GBL_DAYS.length; i++) {
							%><option value="<%= i %>"<%= parseInt(rsT("day"))==i?" selected=\"selected\"":"" %>><%= GBL_DAYS[i]%></option><%
						}
					%></select></td>
					<td style="white-space:nowrap;"><% 
						var arrT = new String(rsT("time")).split(" ");
						var strM = arrT[1];
						
						var arrT = new String(arrT[0]).split(".");
						var intH = parseInt(arrT[0]);
						var intM = parseInt(arrT[1]);

						%>
						<select name="hour"><%
						for (i = 1; i <= 12; i++) {
							%><option value="<%= i %>"<%= intH==i?" selected=\"selected\"":"" %>><%= i %></option><%
						}
						%></select><select name="minute"><%
						for (i = 0; i < 60; i++) {
							%><option value="<%= i %>"<%= intM==i?" selected=\"selected\"":"" %>><%= GBLLeadingZeros(i,2) %></option><%
						}
						%></select><select name="meridian">
							<option value="AM"<%= strM.indexOf("AM")==0?" selected=\"selected\"":"" %>>AM</option>
							<option value="PM"<%= strM.indexOf("PM")==0?" selected=\"selected\"":"" %>>PM</option>
						</select>&nbsp;</td>
					<td style="white-space:nowrap;"><%
							var dRef = new String(rsT("datestart"));
							if (dRef.length != 0 && dRef.indexOf("null") != 0) {
								dRef = new Date(Date.parse(dRef));
								var refDay = dRef.getDate();
								var refMonth = dRef.getMonth();
								var refYear = dRef.getFullYear();
							} else {
								dRef = new Date();
								var refDay = 0;
								var refMonth = -1;
								var refYear = 0;
							}
						%>
						<select name="openDay">
							<option value="0"></option><%
							for (var i=1; i <= 31; i++) {
								%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
							}
						%></select><select name="openMonth">
							<option value="0"></option><%
							for (var i=0; i < 12; i++) {
								%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
							}
						%></select><select name="openYear">
							<option value="0"></option><%
							for (var i=2010; i >= 2005; i--) {
								%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
							}
						%></select>
					</td>
					<td colspan="2">
						<input type="radio" name="status" value="1"<%= parseInt(rsT("status"))==1?" checked=\"checked\"":"" %>/>open&nbsp;&nbsp;&nbsp;
						<input type="radio" name="status" value="0"<%= parseInt(rsT("status"))==0?" checked=\"checked\"":"" %>/>closed
					
						</fieldset>
					</form>
					</td>
				</tr><%
			} else {
				%><tr>
					<td><a href="<%= CONTROLLER %>?action=<%= EDIT_TIMETABLE %>&amp;timetableid=<%= rsT("id") %>#timetable_<%= rsT("id") %>" class="button">EDIT</a></td>
					<td><strong><%= rsT("course") %></strong></td>
					<td><%= rsT("age") %></td>
		 			<td>Term <%= rsT("term") %></td>
		 			<td><%= GBL_DAYS[rsT("day")] %></td>
					<td><%= rsT("time") %></td>
					<td><%= new String(rsT("datestart")).indexOf("null")==0?"<em>to be confirmed</em>":new Date(Date.parse(rsT("datestart"))).formatDate("j F Y") %></td>
					<td><% 
					if (!parseInt(rsT("status")) == 0) {
						%><span style="color:green"><strong>still booking</strong></span><%
					} else {
						%><span style="color:#FF0000"><strong>sold out!</strong></span><%
					}
					%></td>
					<td><a href="<%= CONTROLLER %>?action=<%= DELETE_TIMETABLE %>&amp;timetableid=<%= rsT("id") %>" class="button" onclick="return confirm('Are you sure you want to delete this timetable entry?');">REMOVE</a></td>
				</tr><%
			}
			strCentre = new String(rsT("centre"));
			rsT.MoveNext();
		}
		%></table><%
	} else {
		%><p class="alert">Sorry, there are no classes matching your search.</p><%
	
	}


%>
	<p><a name="newentry"></a>&nbsp;<p>
	<h1>Add Timetable Entry</h1>
	
	<form action="<%= CONTROLLER %>" method="post">
		<fieldset>
		<input type="hidden" name="action" value="<%= SAVE_TIMETABLE %>" />
		<input type="hidden" name="timetableid" value="" />

	<p><strong>Choose Centre</strong>
	<br/><select name="centreid"><% 
		while (!rsCentres.EOF) {
			%><option value="<%= rsCentres("id") %>"><%= rsCentres("name") %></option><%
			rsCentres.MoveNext();
		}
	%></select></p>

	<p><strong>Choose Course</strong>
	<br/><select name="courseid"><% 
		rsCourses.MoveFirst();
		while (!rsCourses.EOF) {
			%><option value="<%= rsCourses("id") %>"><%= rsCourses("name") %> : <%= rsCourses("age") %></option><%
			rsCourses.MoveNext();
		}
	%></select></p>
	
	<p><strong>Choose Term</strong>
	<br/><select name="term"><%
		for (var i = 1; i <= 4; i++) {
			%><option value="<%= i %>">Term <%= i %></option><%
		}
	%></select></p>

	
	<p><strong>Set class day and time</strong>
	<br/><select name="day"><%
		for (var i = 1; i < GBL_DAYS.length; i++) {
			%><option value="<%= i %>"><%= GBL_DAYS[i]%></option><%
		}
	%></select>&nbsp;
	<select name="hour"><%
	for (i = 1; i <= 12; i++) {
		%><option value="<%= i %>"><%= i %></option><%
	}
	%></select>:
	<select name="minute"><%
	for (i = 0; i < 60; i++) {
		%><option value="<%= i %>"><%= i %></option><%
	}
	%></select>&nbsp;
	<select name="meridian">
		<option value="AM">AM</option>
		<option value="PM">PM</option>
	</select></p>


	<p><strong>Set start date</strong>
	<br/><%
			var dRef = new String("null");
			if (dRef.length != 0 && dRef.indexOf("null") != 0) {
				dRef = new Date(Date.parse(dRef));
			} else {
				dRef = new Date();
			}
			var refDay = dRef.getDate();
			var refMonth = dRef.getMonth();
			var refYear = dRef.getFullYear();
			var refHour = dRef.getHours();
			var refMinute = dRef.getMinutes()
		%>
		<select name="openDay">
			<option value="0"></option><%
			for (var i=1; i <= 31; i++) {
				%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>&nbsp;
		<select name="openMonth">
			<option value="0"></option><%
			for (var i=0; i < 12; i++) {
				%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
			}
		%></select>&nbsp;
		<select name="openYear">
			<option value="0"></option><%
			for (var i=2010; i >= 2005; i--) {
				%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select></p>
		
		<p><input type="submit" name="submit" value="ADD ENTRY" class="button"/></p>


		</fieldset>
	</form>



<!--#include file="_gblFooter.asp"-->
