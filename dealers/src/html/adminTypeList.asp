<!--#include file="_adminHeader.asp"-->


<h1>List All Resource Types</h1>
<%
	if (rsAllTypes && !rsAllTypes.EOF) {

		%><table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<th></th>
			<th>Type</th>
			<th>Name</th>
			<th>Description</th>
			<th></th>
		</tr>
		<%
		while (!rsAllTypes.EOF) {
			%>
			<tr>
				<td><a href="<%= CONTROLLER %>?action=<%= EDIT_TYPE %>&typeid=<%= rsAllTypes("id") %>" class="button">EDIT</a></td>
				<td><%= rsAllTypes("type") %></td>
				<td><strong><%= rsAllTypes("name") %></strong></td>
				<td><%= rsAllTypes("description") %></td>
				<td><a href="<%= CONTROLLER %>?action=<%= DELETE_TYPE %>&typeid=<%= rsAllTypes("id") %>" class="button" onclick="return confirm('Are you sure you want to delete this resource type?');">DELETE</a></td>
			</tr>
			<%
			rsAllTypes.MoveNext();
		}
		%></table><%
	} else {
		%><p>There are no users.</p><%
	}

%>

<!--#include file="_adminFooter.asp"-->
