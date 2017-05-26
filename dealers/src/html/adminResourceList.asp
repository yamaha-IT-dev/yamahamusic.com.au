<!--#include file="_adminHeader.asp"-->


<h1>List All Resources</h1>
<form action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= LIST_RESOURCE %>" />
	<input type="hidden" name="division" value="<%= _DIVISION %>" />

<p>Please choose Category and Type:<br/>

<%
	var C = new Category();
	var rsAllCategories = C._getAllCategories(_DIVISION);
		%><select name="categoryid">
		<option value="">Category...</option><%
		if (rsAllCategories && !rsAllCategories.EOF) {
			while (!rsAllCategories.EOF) {
				%><option value="<%= rsAllCategories("id") %>"<%= intCategoryID==parseInt(rsAllCategories("id"))?" selected=\"selected\"":"" %>><%= rsAllCategories("title") %></option><%
				rsAllCategories.MoveNext()
			}
		}
		%></select>&nbsp;<%

		var rsAllResourceTypes = R._getAllResourceTypes(_DIVISION, "");
			%><select name="typeid">
			<option value="">Type...</option><%
		if (rsAllResourceTypes && !rsAllResourceTypes.EOF) {
			while (!rsAllResourceTypes.EOF) {
				%><option value="<%= rsAllResourceTypes("id") %>"<%= intResourceTypeID==parseInt(rsAllResourceTypes("id"))?" selected=\"selected\"":"" %>><%= rsAllResourceTypes("name") %></option><%
				rsAllResourceTypes.MoveNext()
			}
		}
		%></select>

		&nbsp;<input type="submit" name="submit" value="go" class="button" style="display:inline;"/></p>
</p>
</form>

<%
	if (rsAllResources && !rsAllResources.EOF) {

		%>
		<form action="<%= CONTROLLER %>" method="post">
			<input type="hidden" name="action" value="<%= SET_STATUS %>" />

		<table border="0" cellpadding="0" cellspacing="0" width="600px">
		<tr>
			<th></th>
			<th>Title</th>
			<th>Status</th>
			<th></th>
		</tr>
		<%
		var count = 0;
		var bgcolor = "#FFFFFF";
		var rscount = rsAllResources.RecordCount;
		while (!rsAllResources.EOF) {
			%>
			<tr>
				<td style="background-color:<%= bgcolor %>;"><a href="<%= CONTROLLER %>?action=<%= EDIT_RESOURCE %>&resourceid=<%= rsAllResources("id") %>" class="button">EDIT</a></td>
				<td style="background-color:<%= bgcolor %>;width:85%;"><strong><%= rsAllResources("name") %></strong></td>
				<td style="background-color:<%= bgcolor %>;text-align:center;">
					<input type="hidden" name="resourceid" value="<%= rsAllResources("id") %>" />
					<input type="checkbox" name="status_<%= rsAllResources("id") %>" value="1"<%= parseInt(rsAllResources("status"))==1?" checked=\"checked\"":"" %>
				</td>
				<td style="background-color:<%= bgcolor %>;"><a href="<%= CONTROLLER %>?action=<%= DELETE_RESOURCE %>&resourceid=<%= rsAllResources("id") %>" class="button" onclick="return confirm('Are you sure you want to delete this resource?');">DELETE</a></td>
			</tr>
			<%
			bgcolor = bgcolor=="#FFFFFF"?"#EFEFEF":"#FFFFFF";
			count ++;
			rsAllResources.MoveNext();
		}
		%>
		<tr>
			<td colspan="2" style="text-align:right;">Update resource status<br/><em>Checked is active</em></td>
			<td style="text-align:center;"><input type="submit" name="submit" value="set" class="button"/></td>
			<td></td>
		</tr>
		</table>
		</form>
		<%
	} else {
		if (isNaN(intCategoryID)) {
			%><p>Please choose a category.</p><%
		} else {
			%><p>There are no resources.</p><%
		}
	}

%>
<!--#include file="_adminFooter.asp"-->
