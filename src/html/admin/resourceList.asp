<!--#include file="_gblHeader.asp"-->


<h1>List All Resources</h1>
<form action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= LIST_RESOURCE %>" />
<p>Please choose Category and Type:<br/>

<%
		var C = new Category();
		%><select name="categoryid">
			<option value="">Category...</option>
			<% C._drawCategoryOptionList(0, intCategoryID, 1); %>
		%></select>&nbsp;<%
%>
<%
		var rsAllResourceTypes = R._getAllResourceTypes();
		if (rsAllResourceTypes && !rsAllResourceTypes.EOF) {
			%><select name="resourcetypeid">
			<option value="">Type...</option><%
			while (!rsAllResourceTypes.EOF) {
				%><option value="<%= rsAllResourceTypes("id") %>"<%= intResourceTypeID==parseInt(rsAllResourceTypes("id"))?" selected=\"selected\"":"" %>><%= rsAllResourceTypes("name") %></option><%
				rsAllResourceTypes.MoveNext()
			}
			%></select>&nbsp;<%
		}
%><input type="submit" name="submit" value="go" class="button" style="display:inline;"/></p>
</p>
</form>

<%
	if (rsAllResources && !rsAllResources.EOF) {

		%>
		<form action="<%= CONTROLLER %>" method="post">
			<input type="hidden" name="action" value="<%= SET_STATUS %>" />
		
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
<!--
			<th></th>
-->
			<th></th>
<!--			<th colspan="2">Re-Order</th> -->
			<th>Title</th>
			<th>Extract</th>
			<th>Date published</th>
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
<!--
				<td style="background-color:<%= bgcolor %>;"><%= rsAllResources("order") %></td>
-->
				<td style="background-color:<%= bgcolor %>;"><a href="<%= CONTROLLER %>?action=<%= EDIT_RESOURCE %>&resourceid=<%= rsAllResources("id") %>" class="button">EDIT</a></td>
<!--
				<td style="background-color:<%= bgcolor %>;"><% 
				if (count != 0) {
					%><a href="<%= CONTROLLER %>?action=<%= MOVE_RESOURCE_UP %>&resourceid=<%= rsAllResources("id") %>" class="button">UP</a><%
				}
				%></td>
				<td style="background-color:<%= bgcolor %>;"><% 
				if (count != rscount-1) {
					%><a href="<%= CONTROLLER %>?action=<%= MOVE_RESOURCE_DOWN %>&resourceid=<%= rsAllResources("id") %>" class="button">DN</a><%
				}	
				%></td>
-->
				<td style="background-color:<%= bgcolor %>;width:45%;"><strong><%= rsAllResources("title") %></strong></td>
				<td style="background-color:<%= bgcolor %>;width:45%;"><%= cleanForText(rsAllResources("extract")) %></td>
				<td style="background-color:<%= bgcolor %>;width:45%;"><%= new Date(Date.parse(rsAllResources("dateopen"))).formatDate("j M Y") %></td>
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
			<td colspan="4" style="text-align:right;">Update resource status<br/><em>Checked is active</em></td>
			<td><input type="submit" name="submit" value="set" class="button"/></td>
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
<!--#include file="_gblFooter.asp"-->
