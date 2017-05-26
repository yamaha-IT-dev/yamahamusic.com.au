<!--#include file="_adminHeader.asp"-->


<h1>Edit Category</h1>

<%
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>

<form name="userEditForm" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= SAVE_CATEGORY %>" />
	<input type="hidden" name="categoryid" value="<%= C._getCategoryID() %>" />
	<input type="hidden" name="userid" value="<%= C._getCategoryUserID() %>" />

	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td style="width:100px;" class="required">Title</td>
		<td class="required"><input type="text" name="title" value="<%= C._getCategoryTitle() %>" style="width:400px;" /></td>
	</tr>
	<tr>
		<td style="width:100px;" class="required">Division</td>
		<td class="required">
			<input type="radio" name="division" value="MPD" <%= C._getCategoryDivision()=="MPD"?" checked=\"checked\"":"" %> /> MPD &nbsp;&nbsp;
			<input type="radio" name="division" value="TRAD" <%= C._getCategoryDivision()=="TRAD"?" checked=\"checked\"":"" %> /> TRAD
		</td>
	</tr>
	<tr>
		<td>Description</td>
		<td><textarea name="description" rows="3" style="width:400px;"><%= C._getCategoryDescription() %></textarea></td>
	</tr>
	</table>


	<p><input type="submit" name="submit" value="save category" class="button" /></p>


</form>


<!--#include file="_adminFooter.asp"-->
