<!--#include file="_gblHeader.asp"-->


<h1>List All Teachers</h1>

<%
	if (rsAllTeachers && !rsAllTeachers.EOF) {

		%><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<th></th>
			<th>Code</th>
			<th>Name</th>
			<th>State</th>
			<th></th>
		</tr>
		<%
		while (!rsAllTeachers.EOF) {
			%>
			<tr>
				<td><a href="<%= CONTROLLER %>?action=<%= EDIT_TEACHER %>&teacherid=<%= rsAllTeachers("id") %>" class="button">EDIT</a></td>
				<td><%= rsAllTeachers("code") %></td>
				<td><%= rsAllTeachers("name") %></td>
				<td><%= rsAllTeachers("state") %></td>
				<td><a href="<%= CONTROLLER %>?action=<%= DELETE_TEACHER %>&teacherid=<%= rsAllTeachers("id") %>" class="button" onclick="return confirm('Are you sure you want to delete this teacher?');">DELETE</a></td>
			</tr>
			<%
			rsAllTeachers.moveNext();
		}
		%></table><%
	} else {
		%><p>There were no records found.</p><%
	}

%>
<p>&nbsp;</p>
<% 


	if (rsAllUnassigned && !rsAllUnassigned.EOF) {

		%><h2>Unassigned</h2>
		
		<p>The following teachers are yet to be assigned their codes and regions for the website.<br/>
		Choose a name from below to add them to the list above.</p>
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<th></th>
			<th>Name</th>
		</tr>
		<%
		while (!rsAllUnassigned.EOF) {
			%>
			<tr>
				<td><a href="<%= CONTROLLER %>?action=<%= ADD_TEACHER %>&userid=<%= rsAllUnassigned("userid") %>" class="button">ASSIGN</a></td>
				<td><%= rsAllUnassigned("title") %>&nbsp;<%= rsAllUnassigned("firstname") %>&nbsp;<%= rsAllUnassigned("lastname") %></td>
			</tr>
			<%
			rsAllUnassigned.moveNext();
		}
		%></table><%
	} else {
		%><p>There were no records found.</p><%
	}


%>


<!--#include file="_gblFooter.asp"-->
