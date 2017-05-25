<%@LANGUAGE="JScript"%>
<!--#include file="../src/global.asp" -->
<!--#include file="../src/utility.asp" -->
<!--#include file="../src/classes/Customer.asp" -->
<!--#include file="../src/classes/Navigation.asp" -->
<!--#include file="../src/classes/Timetable.asp" -->
<% 


// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var AJAX_LOOKUP_TIMETABLE = "ajax_lookup_timetable";
var AJAX_LOOKUP_ENROL = "ajax_lookup_enrol";

// global variables & default values
var CONTROLLER = "ajax_timetable.asp";
var action = AJAX_LOOKUP_TIMETABLE;

// overide default values from request
if (new String(Request(ACTION)) != "undefined") {
	action = Request(ACTION);
}

// state machine
if (action == AJAX_LOOKUP_TIMETABLE) {

	drawTimetable(false);

} else if (action == AJAX_LOOKUP_ENROL) {
 
	drawTimetable(true);

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

function drawTimetable(radioform) {

	var intTerm = !isNaN(parseInt(Request("term")))?parseInt(Request("term")):null;
	var intCourseID = !isNaN(parseInt(Request("courseid")))?parseInt(Request("courseid")):null;
	var intCentreID = !isNaN(parseInt(Request("centreid")))?parseInt(Request("centreid")):null;
	var intDay = !isNaN(parseInt(Request("day")))?parseInt(Request("day")):null;
	var strState = new String(Request("state")).indexOf("undefined")!=0?new String(Request("state")):"";

	var T = new Timetable()
	var rsT = T._getTimetable(intCourseID, intCentreID, intDay, strState, intTerm);
	var strCentre = new String("");

	if (rsT && !rsT.EOF) {
		%><table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<% 
			if (radioform) {
				%><th>&nbsp;</th><% 
			}
			%>
			<th style="font-weight:normal;">Course</th>
			<th style="font-weight:normal;">Age</th>
			<th style="font-weight:normal;">Day</td>
			<th style="font-weight:normal;">Time</th>
			<th style="font-weight:normal;">Start Date</th>
		</tr>
		<%
		while (!rsT.EOF) {
			if (strCentre.indexOf(rsT("centre")) != 0) {
			%><tr>
				<th colspan="<%= radioform?6:5 %>"><%= rsT("state") %> : <%= rsT("centre") %></th>
			</tr><%
			}
			%><tr><% 
			if (radioform) {
				if (!parseInt(rsT("status")) == 0) {
					%><td><input type="radio" name="timetableid" id="timetableid_<%= rsT("id") %>" value="<%= rsT("id") %>" /></td><% 
				} else {
					%><td>&nbsp;</td><%
				}
			}
			%>
				<td><strong><%= rsT("course") %></strong></td>
				<td><%= rsT("age") %></td>
				<td><%= GBL_DAYS[rsT("day")] %></td>
				<td><%= rsT("time") %></td>
				<td><% 
				if (!parseInt(rsT("status")) == 0) {
					%><%= new String(rsT("datestart")).indexOf("null")==0?"<em>to be confirmed</em>":new Date(Date.parse(rsT("datestart"))).formatDate("j M Y") %><%
				} else {
					%><span style="color:#FF0000"><strong>sold out!</strong></span><%
				}
				%></td>
			</tr><%
			strCentre = new String(rsT("centre"));
			rsT.MoveNext();
		}
		%></table><%
	} else {
		%><p class="alert">Currently there aren't any classes scheduled. Please try another term or call <strong>1300 139 506</strong> to register your interest.</p><%
	}

}

%>
