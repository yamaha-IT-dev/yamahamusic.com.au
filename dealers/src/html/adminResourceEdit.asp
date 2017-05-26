<!--#include file="_adminHeader.asp"-->


<h1><%= R._getResourceID()>0?"Edit":"Add" %> Resource</h1>

<%
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>
<form name="userEditForm" action="<%= CONTROLLER %>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="action" value="<%= SAVE_RESOURCE %>" />
	<input type="hidden" name="resourceid" value="<%= R._getResourceID() %>" />
	<input type="hidden" name="userid" value="<%= R._getResourceUserID() %>" />


	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="required">Type</td>
		<td class="required"><select name="typeid" style="width:400px;">
			
<%
				var rsAllResourceTypes = R._getAllResourceTypes(R._getResourceDivision(), "");
				if (rsAllResourceTypes && !rsAllResourceTypes.EOF) {
					while (!rsAllResourceTypes.EOF) {
						%><option value="<%= rsAllResourceTypes("id") %>"<%= R._getResourceTypeID()==parseInt(rsAllResourceTypes("id"))?" selected=\"selected\"":"" %>><%= rsAllResourceTypes("name") %></option><%
						rsAllResourceTypes.MoveNext()
					}
				}
%>
		</select></td>
	</tr>
	<tr>
		<td class="required">Category</td>
		<td class="required"><select name="categoryid" style="width:400px;">
			
<%
		var C = new Category();
		var rsAllCategories = C._getAllCategories(R._getResourceDivision());
		if (rsAllCategories && !rsAllCategories.EOF) {
			while (!rsAllCategories.EOF) {
				%><option value="<%= rsAllCategories("id") %>"<%= R._getResourceCategoryID()==parseInt(rsAllCategories("id"))?" selected=\"selected\"":"" %>><%= rsAllCategories("title") %></option><%
				rsAllCategories.MoveNext()
			}
		}
%>
		</select></td>
	</tr>
	<tr>
		<td style="width:100px;" class="required">Division</td>
		<td class="required">
			<input type="radio" name="division" value="MPD" <%= R._getResourceDivision().indexOf("MPD") == 0?" checked=\"checked\"":"" %> /> MPD &nbsp;&nbsp;
			<input type="radio" name="division" value="TRAD" <%= R._getResourceDivision().indexOf("TRAD") == 0?" checked=\"checked\"":"" %> /> TRAD
		</td>
	</tr>
	<tr>
		<td style="width:100px;" class="required">Name</td>
		<td class="required"><textarea name="name" rows="1" style="width:400px;"><%= R._getResourceName() %></textarea></td>
	</tr>
	<tr>
		<td class="required">Description</td>
		<td class="required"><textarea name="description" rows="5" style="width:400px;"><%= R._getResourceDescription() %></textarea></td>
	</tr>
	<tr>
		<td><strong>Can a dealer request this item?</strong></td>
		<td>
			<input type="radio" name="onrequest" value="1"<%= R._getResourceOnrequest()==1?" checked=\"checked\"":"" %>/>YES &nbsp;&nbsp;&nbsp;
			<input type="radio" name="onrequest" value="0"<%= R._getResourceOnrequest()==0?" checked=\"checked\"":"" %>/>NO &nbsp;&nbsp;&nbsp;

		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td>File (Main / the big one)</td>
		<td>
			<% if (R._getResourceFilesrclg().indexOf("null") != 0 && R._getResourceFilesrclg().length != 0) { %><a href="<%= R._getResourceFilesrclg() %>" target="_blank">view this file - <%= R._getResourceFilesrclg() %><br/></a><% } %>
			<input type="file" name="filesrclg" value="" size="34" style="width:250px;"/><br/>
			<input type="checkbox" name="filesrclg_REMOVE" value="1">&nbsp;Remove this file? - check to have no file.<br/>
			<input type="checkbox" name="filesrclg_OVERWRITE" value="1" checked="checked">&nbsp;Overwrite existing file? - check for yes.</p>
		</td>
	</tr>
	<tr>
		<td>File (Preview / the little one!)</td>
		<td>
			<% if (R._getResourceFilesrcsm().indexOf("null") != 0 && R._getResourceFilesrcsm().length != 0) { %><a href="<%= R._getResourceFilesrcsm() %>" target="_blank">view this file - <%= R._getResourceFilesrcsm() %><br/></a><% } %>
			<input type="file" name="filesrcsm" value="" size="34" style="width:250px;"/><br/>
			<input type="checkbox" name="filesrcsm_REMOVE" value="1">&nbsp;Remove this file? - check to have no file.<br/>
			<input type="checkbox" name="filesrcsm_OVERWRITE" value="1" checked="checked">&nbsp;Overwrite existing file? - check for yes.</p>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	</table>


	<p><input type="submit" name="submit" value="save item" class="button" /></p>


</form>

<!--#include file="_adminFooter.asp"-->
