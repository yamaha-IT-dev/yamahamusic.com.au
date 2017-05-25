<!--#include file="_gblHeader.asp"-->


<h1>Edit Teacher Details</h1>

<% 
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>

<form name="userEditForm" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= SAVE_TEACHER %>" />
	<input type="hidden" name="teacherid" value="<%= T._getTeacherID() %>" />

	<input type="hidden" name="userid" value="<%= U._getUserID() %>" />

	<h2><%= C._getCustomerTitle() %>&nbsp;<%= C._getCustomerFirstname() %>&nbsp;<%= C._getCustomerLastname() %></h2>
	
	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td style="width:100px;" class="required">Code</td>
		<td class="required"><input type="text" name="code" value="<%= T._getTeacherCode() %>" style="width:100px;" /></td>
	</tr>
	<tr>
		<td class="required">State</td>
		<td><select name="state" style="width:200px;" >
			<option value="">choose state...</option><%
			for (var i=0; i < GBL_STATES_SHORT.length; i++) {
				%><option value="<%= GBL_STATES_SHORT[i] %>"<%= C._getCustomerState().indexOf(GBL_STATES_SHORT[i])==0?" selected=\"selected\"":"" %>><%= GBL_STATES_LONG[i] %></option><%
			}
		%></select></td>
	</tr>
	<tr>
		<td class="required"><label for="region">Region</label></td>
		<td style="padding-right:20px;"><select name="region" style="width:100px;">
			<option value="">choose...</option><%
			for (var i=0; i < GBL_REGIONS.length; i++) {
				%><option value="<%= GBL_REGIONS[i] %>"<%= new String(T._getTeacherRegion()).indexOf(GBL_REGIONS[i])==0?" selected=\"selected\"":"" %>><%= GBL_REGIONS[i] %></option><%
			}
		%></select></td>	</tr>
	<tr>
		<td class="required">Email Address</td>
		<td class="required"><input type="text" name="email" value="<%= T._getTeacherEmail() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td class="required" colspan="2"><input type="checkbox" name="coordinator" value="1" <%= T._getTeacherCoordinator()==1?" checked=\"checked\"":"" %> /> Check this box if this teacher is a regional coordinator.</td>
	</tr>
	</table>


	<p><input type="submit" name="submit" value="save teacher" class="button" /></p>


</form>

<!--#include file="_gblFooter.asp"-->
