<!--#include file="_gblHeader.asp"-->


<h1>List All Customers</h1>

	<p><a href="<%= CONTROLLER %>?year=<%= year-1 %>"><%= year-1 %></a> | <strong><%= year %></strong> | <a href="<%= CONTROLLER %>?year=<%= year+1 %>"><%= year+1 %></a><br/>
<%

	if (rsAllCustomers && !rsAllCustomers.EOF) {

		var intRecordCount = rsAllCustomers.RecordCount;
		var intStart = !isNaN(parseInt(Request("start")))?parseInt(Request("start")):0;
		var intPageSize = 10;
		var intCount = 0
		var intPageCount = Math.ceil(intRecordCount/intPageSize);
		
		rsAllCustomers.MoveFirst();
		var intFirstWeek = new Number(rsAllCustomers("week"));
		rsAllCustomers.MoveLast();
		var intLastWeek = new Number(rsAllCustomers("week"));

		var intWeek = !isNaN(parseInt(Request("week")))?parseInt(Request("week")):intFirstWeek;

		rsAllCustomers.Filter = "week=" + intWeek;

// Response.Write("newest week = " + intFirstWeek + "<br/>");
// Response.Write("oldest week = " + intLastWeek + "<br/>");

		var dateWeekBeg = getDateFromWeek(intWeek);

Response.Write("week beginning : " + dateWeekBeg + "<br/>");

//Response.Write("week beginning : " + new Date() + "<br/>");

/*
Response.Write("intRecordCount = " + intRecordCount + "<br/>");
Response.Write("intStart = " + intStart + "<br/>");
Response.Write("intPageSize = " + intPageSize + "<br/>");
Response.Write("intCount = " + intCount + "<br/>");
Response.Write("intPageCount = " + intPageCount + "<br/>");
*/
		%>Go to week : <%
		for (var i=intFirstWeek; i>=intLastWeek; i--) {
			var strBold = intWeek==i?" style=\"font-weight:bold;\"":"";
			%><a href="<%= CONTROLLER %>?week=<%= i %>&amp;year=<%= year %>"<%= strBold %>><%= i %></a>&nbsp;&nbsp;<%
		}

/*
		%><p>Go to page : <%
		for (var i=0; i<intPageCount; i++) {
			var strBold = Math.floor(intStart/intPageSize)==i?" style=\"font-weight:bold;\"":"";
			%><a href="<%= CONTROLLER %>?start=<%= i*intPageSize %>"<%= strBold %>><%= i+1 %></a>&nbsp;&nbsp;<%
		}
		if (Math.floor(intStart/intPageSize)+1 != intPageCount) {
			%><a href="<%= CONTROLLER %>?start=<%= intStart+intPageSize %>">[next]</a><% 
		}
*/
		%></p><%

		if (rsAllCustomers && !rsAllCustomers.EOF) {

			rsAllCustomers.Move(intStart);

			%>
			<form name="followUp" action="<%= CONTROLLER %>" method="post" style="padding:0;margin:0;">
				<input type="hidden" name="action" value="<%= SET_FOLLOWUP %>" />
			
			
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<th style="width:50px;"></th>
				<th style="width:250px;">Full Name</th>
				<th>State</th>
				<th>Followed Up?</th>
	<!--
				<th style="width:15%;">Joined</th>
				<th style="width:15%;">Changed</th>
	-->
			</tr>
			<%
			while (!rsAllCustomers.EOF) {
				%>
				<tr>
					<td><a href="ctrlCustomer.asp?action=<%= EDIT_CUSTOMER %>&customerid=<%= rsAllCustomers("id") %>" class="button">EDIT</a></td>
					<td><%= new String(rsAllCustomers("lastname")).toUpperCase() %>,&nbsp;<%= rsAllCustomers("title") %>&nbsp;<%= rsAllCustomers("firstname") %></td>
					<td><%= rsAllCustomers("state") %></td>
					<td><% 
					if (parseInt(rsAllCustomers("followup"))==0) {
					%>
						<input type="hidden" name="customerid" value="<%= rsAllCustomers("id") %>" />				
						<input type="checkbox" name="followup_<%= rsAllCustomers("id") %>" value="1" />
						<%= parseInt(rsAllCustomers("followup"))==1?" checked=\"checked\"":"Not yet." %>
					<%
					} else {
					%>
						<strong>YES</strong> : <%= new Date(Date.parse(rsAllCustomers("datefollowup"))).formatDate("jS F Y") %>
					<%
					}
					%>
					
					
					</td>
	<!--
					<td><%= new Date(Date.parse(rsAllCustomers("datecreated"))).formatDate("d/m/Y") %></td>
					<td><%
						if (new String(rsAllCustomers("datemodified")) != "null") {
							Response.Write(new Date(Date.parse(rsAllCustomers("datemodified"))).formatDate("d/m/Y"));
						}
					%></td>
	-->
				</tr>
				<%
				rsAllCustomers.moveNext();
				intCount++;
				if (intCount == intPageSize) {
					break;
				}
			}
			%>
			<tr>
				<td colspan="3" style="text-align:right;vertical-align:middle;">Click to update this follow-up list</td>
				<td style="vertical-align:middle;">
						
						<input type="submit" name="submit" value="save followups" class="button"/>
				</td>
			</tr>
			</table>
			</form>
			<%
		} else {
			%><p>There were no enquiries for this week.</p><%
		}
	} else {
		%><p>There are no users.</p><%
	}

%>
<!--#include file="_gblFooter.asp"-->
