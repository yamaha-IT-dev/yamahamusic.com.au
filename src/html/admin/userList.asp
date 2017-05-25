<!--#include file="_gblHeader.asp"-->


<h1>List All Users</h1>

<form name="listUserForm" action="<%= CONTROLLER %>" method="post">

	<p><b>Filter by user type: </b>
	<select name="usertypeid">
		<option value="0">All</option>
<%
	if (rsAllUserTypes && !rsAllUserTypes.EOF) {
		while (!rsAllUserTypes.EOF) {
			%><option value="<%= rsAllUserTypes("id") %>"<%= intUserTypeID==parseInt(rsAllUserTypes("id"))?" selected=\"selected\"":"" %>><%= rsAllUserTypes("name") %></option><%
			rsAllUserTypes.moveNext();
		}
	}

%>
	</select>&nbsp;
	<input type="submit" name="submit" value="go" /><% 
	
	if (rsAllUsers && !rsAllUsers.EOF) {
		%> - <%= rsAllUsers.RecordCount %> records found.<% 
	}
	
	%></p>

</form> 

<%
	if (rsAllUsers && !rsAllUsers.EOF) {

		%><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<th></th>
			<th>Usertype</th>
			<th>Username</th>
			<th>Full Name</th>
			<th></th>
		</tr>
		<%
		while (!rsAllUsers.EOF) {
			%>
			<tr>
				<td><a href="<%= CONTROLLER %>?action=<%= EDIT_USER %>&userid=<%= rsAllUsers("id") %>" class="button">EDIT</a></td>
				<td><%= rsAllUsers("usertype") %></td>
				<td><%= rsAllUsers("username") %></td>
				<td><%= rsAllUsers("title") %>&nbsp;<%= rsAllUsers("firstname") %>&nbsp;<%= rsAllUsers("lastname") %></td>
				<td><a href="<%= CONTROLLER %>?action=<%= DELETE_USER %>&userid=<%= rsAllUsers("id") %>" class="button" onclick="return confirm('Are you sure you want to delete this user?');">DELETE</a></td>
			</tr>
			<%
			rsAllUsers.moveNext();
		}
		%></table><%
	} else {
		%><p>There were no records found.</p><%
	}

%>
<!--#include file="_gblFooter.asp"-->
