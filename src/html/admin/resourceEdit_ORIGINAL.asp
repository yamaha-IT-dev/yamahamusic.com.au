<!--#include file="_gblHeader.asp"-->


<h1>Edit Resource</h1>

<% 
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>
<form name="userEditForm" action="<%= CONTROLLER %>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="action" value="<%= SAVE_RESOURCE %>" />
	<input type="hidden" name="resourceid" value="<%= R._getResourceID() %>" />
	<input type="hidden" name="userid" value="<%= R._getResourceUserID() %>" />
	<input type="hidden" name="order" value="<%= R._getResourceOrder() %>" />



	<div style="float:right;width:300px;"><strong class="required">Category</strong><br/>
<%
		var C = new Category();
		var arrCategories = C._getAllCategoriesByResource(R._getResourceID());
	/*
		var rsAllCategories = C._getAllCategories();
		if (rsAllCategories && !rsAllCategories.EOF) {
			while (!rsAllCategories.EOF) {
				var blnCatMatch = false;
				for (var i=0; i < arrCategories.length; i++) {
					if (parseInt(arrCategories[i])==parseInt(rsAllCategories("id"))) {
						blnCatMatch = true;
						break;
					}
				}
				%><input type="checkbox" name="categoryid" value="<%= rsAllCategories("id") %>"<%= blnCatMatch?" checked=\"checked\"":"" %>><%= rsAllCategories("title") %><br/><%
				rsAllCategories.MoveNext()
			}
		}
	*/
%>
		<% 
		C._drawCategoryCheckList(0, arrCategories, 0);
		%>
	</div>

	
	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="required">Type</td>
		<td class="required"><select name="resourcetypeid" style="width:400px;">
			<option value="0">please choose...</option>
<%
				var rsAllResourceTypes = R._getAllResourceTypes();
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
		<td style="width:100px;" class="required">Title</td>
		<td class="required"><textarea name="title" rows="1" style="width:400px;"><%= R._getResourceTitle() %></textarea></td>
	</tr>
	<tr>
		<td class="required">Body<br/><br/><em style="font-weight:normal;">A body or extract is required. If displaying a link to a pdf. Just include an extract.</em></td>
		<td class="required"><textarea name="body" rows="10" style="width:400px;"><%= R._getResourceBody() %></textarea></td>
	</tr>
	<tr>
		<td class="required">Extract</td>
		<td class="required"><textarea name="extract" rows="3" style="width:400px;"><%= R._getResourceExtract() %></textarea></td>
	</tr>
	<tr>
		<td>URL</td>
		<td><input type="text" name="url" value="<%= R._getResourceURL() %>" style="width:400px;" /></td>
	</tr>
	<tr>
		<td>Link Text</td>
		<td><input type="text" name="link" value="<%= R._getResourceLink() %>" style="width:400px;" /></td>
	</tr>
	<tr>
		<td>Background Color <em>Used for homepage promos only</em></td>
		<td><input type="text" name="bgcolor" value="<%= R._getResourceBGColor() %>" style="width:400px;" /></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td>Show From...</td>
		<td><%
		
			var dRef = R._getResourceDateopen();
			if (dRef.length != 0 && dRef.indexOf("null") != 0) {
				dRef = new Date(Date.parse(dRef));
			} else {
				dRef = new Date();
			}
			var refDay = dRef.getDate();
			var refMonth = dRef.getMonth();
			var refYear = dRef.getFullYear();
			var refHour = dRef.getHours();
			var refMinute = dRef.getMinutes()
		%>
		<select name="openDay">
			<option value="0">day...</option><%
			for (var i=1; i <= 31; i++) {
				%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>&nbsp;
		<select name="openMonth">
			<option value="0">month...</option><%
			for (var i=0; i < 12; i++) {
				%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
			}
		%></select>&nbsp;
		<select name="openYear">
			<option value="0">year...</option><%
			for (var i=2016; i >= 2012; i--) {
				%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>&nbsp;
		<select name="openHour">
			<option value="0">hour...</option><%
			for (var i=1; i <= 24; i++) {
				%><option value="<%= i %>"<%= refHour==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>&nbsp;
		<select name="openMinute">
			<option value="0">minute...</option><%
			for (var i=0; i <= 60; i++) {
				%><option value="<%= i %>"<%= refMinute==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>
		</td>
	</tr>
	<tr>
		<td>Until...</td>
		<td><%
		
			var dRef = R._getResourceDateclosed();
//Response.Write(dRef);
			if (dRef.length != 0 && dRef.indexOf("null") != 0) {
				dRef = new Date(Date.parse(dRef));
				var refDay = dRef.getDate();
				var refMonth = dRef.getMonth();
				var refYear = dRef.getFullYear();
			} else {
				dRef = new Date();
				var refDay = dRef.getDate();
				var refMonth = dRef.getMonth();
				var refYear = dRef.getFullYear()+1;
			}
		%>
		<select name="closedDay">
			<option value="0">day...</option><%
			for (var i=1; i <= 31; i++) {
				%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>&nbsp;
		<select name="closedMonth">
			<option value="0">month...</option><%
			for (var i=0; i < 12; i++) {
				%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
			}
		%></select>&nbsp;
		<select name="closedYear">
			<option value="0">year...</option><%
			for (var i=2020; i >= 2012; i--) {
				%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td>File (Main)</td>
		<td>
			<% if (R._getResourceFilesrclg().indexOf("null") != 0 && R._getResourceFilesrclg().length != 0) { %><a href="../<%= R._getResourceFilesrclg() %>" target="_blank">view this file - <%= R._getResourceFilesrclg() %><br/></a><% } %>
			<input type="file" name="filesrclg" value="" size="34" style="width:250px;"/><br/>
			<input type="checkbox" name="filesrclg_REMOVE" value="1">&nbsp;Remove this image? - check to have no image.<br/>
			<input type="checkbox" name="filesrclg_OVERWRITE" value="1" checked="checked">&nbsp;Overwrite existing image? - check for yes.</p>
		</td>
	</tr>
	<tr>
		<td>File (Preview)</td>
		<td>
			<% if (R._getResourceFilesrcsm().indexOf("null") != 0 && R._getResourceFilesrcsm().length != 0) { %><a href="../<%= R._getResourceFilesrcsm() %>" target="_blank">view this file - <%= R._getResourceFilesrcsm() %><br/></a><% } %>
			<input type="file" name="filesrcsm" value="" size="34" style="width:250px;"/><br/>
			<input type="checkbox" name="filesrcsm_REMOVE" value="1">&nbsp;Remove this image? - check to have no image.<br/>
			<input type="checkbox" name="filesrcsm_OVERWRITE" value="1" checked="checked">&nbsp;Overwrite existing image? - check for yes.</p>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	</table>


	<p><input type="submit" name="submit" value="save resource item" class="button" /></p>


</form>

<!--#include file="_gblFooter.asp"-->
