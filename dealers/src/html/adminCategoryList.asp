<!--#include file="_adminHeader.asp"-->


<h1>List All Categories</h1>
<%
	if (rsAllCategories && !rsAllCategories.EOF) {

		%><table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<th></th>
			<th>Title</th>
			<th>Description</th>
			<th></th>
		</tr>
		<%
		while (!rsAllCategories.EOF) {
			%>
			<tr>
				<td><a href="<%= CONTROLLER %>?action=<%= EDIT_CATEGORY %>&categoryid=<%= rsAllCategories("id") %>" class="button">EDIT</a></td>
				<td><strong><%= rsAllCategories("title") %></strong></td>
				<td><%= rsAllCategories("description") %></td>
				<td><a href="<%= CONTROLLER %>?action=<%= DELETE_CATEGORY %>&categoryid=<%= rsAllCategories("id") %>" class="button" onclick="return confirm('Are you sure you want to delete this category?');">DELETE</a></td>
			</tr>
			<%
			rsAllCategories.moveNext();
		}
		%></table><%
	} else {
		%><p>There are categories .</p><%
	}

%>

<!--#include file="_adminFooter.asp"-->
