<!--#include file="_gblHeader.asp"-->


<h1>Recent / Active Resources</h1>
<form>
<%
	if (rsRecentResources && !rsRecentResources.EOF) {

		%><table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td valign="top" style="width:170px;padding-right:10px;"><%
			
			var tmpCategoryID = 0;
			var count = 0
			while (!rsRecentResources.EOF) {

				if (tmpCategoryID != parseInt(rsRecentResources("categoryid")) && count > 0) {
					%></td><td valign="top" style="width:170px;padding-right:10px;"><%
				}
				if (tmpCategoryID != parseInt(rsRecentResources("categoryid"))) {
					%><h2><%= rsRecentResources("category") %></h2><%
				}
				
				var d = new Date(Date.parse(rsRecentResources("datecreated")));
				%>
				<h3><a href="<%= CONTROLLER %>?action=<%= EDIT_RESOURCE %>&resourceid=<%= rsRecentResources("id") %>"><%= rsRecentResources("title") %></a></h3>
				<p>created on <%= d.formatDate("jS F Y, g:i A") %><br/>by <strong><%= rsRecentResources("username") %></strong></p>
				<%
				tmpCategoryID = parseInt(rsRecentResources("categoryid"));
				count++;
				rsRecentResources.moveNext();
			}
			
		%></td>
		</tr>
		</table><%
	} else {
		%><p>There are no resources.</p><%
	}

%>
</form>
<!--#include file="_gblFooter.asp"-->
