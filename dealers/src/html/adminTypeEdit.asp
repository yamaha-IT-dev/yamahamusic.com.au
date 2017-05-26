<!--#include file="_adminHeader.asp"-->


<h1>Edit Resource Type</h1>

<%
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>

<form name="userEditForm" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= SAVE_TYPE %>" />
	<input type="hidden" name="typeid" value="<%= T._getTypeID() %>" />

	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td style="width:100px;" class="required">Type</td>
		<td class="required"><select name="type" style="width:400px;">
			<option value="PRODUCT_INFORMATION"	<%= T._getTypeType().indexOf('PRODUCT_INFORMATION') ==0?" selected=\"selected\"":"" %>>Product Information</option>
			<option value="MARKETING_IDEAS"		<%= T._getTypeType().indexOf('MARKETING_IDEAS')     ==0?" selected=\"selected\"":"" %>>Marketing Ideas</option>
		</select></td>
	</tr>
	<tr>
		<td style="width:100px;" class="required">Division</td>
		<td class="required">
			<input type="radio" name="division" value="MPD" <%= T._getTypeDivision().indexOf("MPD") == 0?" checked=\"checked\"":"" %> /> MPD &nbsp;&nbsp;
			<input type="radio" name="division" value="TRAD" <%= T._getTypeDivision().indexOf("TRAD") == 0?" checked=\"checked\"":"" %> /> TRAD
		</td>
	</tr>
	<tr>
		<td style="width:100px;" class="required">Name</td>
		<td class="required"><input type="text" name="name" value="<%= T._getTypeName() %>" style="width:400px;" /></td>
	</tr>
	<tr>
		<td>Description</td>
		<td><textarea name="description" rows="3" style="width:400px;"><%= T._getTypeDescription() %></textarea></td>
	</tr>
	<tr>
		<td>Status</td>
		<td>
			<input type="radio" name="status" value="1"<%= T._getTypeStatus()==1?" checked=\"checked\"":"" %>/>Active &nbsp;&nbsp;&nbsp;
			<input type="radio" name="status" value="0"<%= T._getTypeStatus()==0?" checked=\"checked\"":"" %>/>Inactive &nbsp;&nbsp;&nbsp;

		</td>
	</tr>
	</table>


	<p><input type="submit" name="submit" value="save resource type" class="button" /></p>


</form>


<!--#include file="_adminFooter.asp"-->
