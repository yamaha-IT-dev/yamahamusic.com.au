<!--#include file="_gblHeader.asp"-->


<h1>Edit User Details</h1>

<% 
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>

<form name="userEditForm" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= SAVE_USER %>" />
	<input type="hidden" name="userid" value="<%= U._getUserID() %>" />
	<input type="hidden" name="customerid" value="<%= C._getCustomerID() %>" />

	<input type="hidden" name="checkusername" value="<%= U._getUserUsername() %>" />
	<input type="hidden" name="checkemail" value="<%= C._getCustomerEmail() %>" />
	
	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td style="width:100px;" class="required">Username</td>
		<td class="required"><input type="text" name="username" value="<%= U._getUserUsername() %>" style="width:100px;" /></td>
	</tr>
	<tr>
		<td class="required">Password</td>
		<td class="required"><input type="password" name="password" value="<%= U._getUserPassword() %>" style="width:100px;" /></td>
	</tr>
	<tr>
		<td class="required">Usertype</td>
		<td class="required"><select name="usertypeid" style="width:200px;">
			<option value="0">please choose...</option>
			<option value="0">Ordinary User</option>
<%
				var UT = new UserType();
				var rsAllUserTypes = UT._getAllUserTypes();
				if (rsAllUserTypes && !rsAllUserTypes.EOF) {
					while (!rsAllUserTypes.EOF) {
						%><option value="<%= rsAllUserTypes("id") %>"<%= U._getUserUsertypeID()==parseInt(rsAllUserTypes("id"))?" selected=\"selected\"":"" %>><%= rsAllUserTypes("name") %></option><%
						rsAllUserTypes.MoveNext()
					}
				}
%>
		</select></td>
	</tr>
<% 
	if (U._getUserUsertypeID() == 6) {
		// user belongs to a service centre
		var SC = new Service();
		var rsService = SC._getAllService();
		var intUserServiceID = SC._getServiceByUser(U._getUserID());
%>
	<tr>
		<td class="required">Service Centre</td>
		<td class="required"><select name="servicecentreid" style="width:200px;">
			<option value="0">please choose...</option>
<%
				if (rsService && !rsService.EOF) {
					while (!rsService.EOF) {
						%><option value="<%= rsService("id") %>"<%= intUserServiceID==parseInt(rsService("id"))?" selected=\"selected\"":"" %>><%= rsService("state") %> - <%= rsService("name") %></option><%
						rsService.MoveNext()
					}
				}
%>
		</select></td>
	</tr>

<%
	}
%>	
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td class="required">Title</td>
		<td class="required"><select name="title" style="width:200px;">
			<option value="">please choose...</option><%
			for (var i=1; i < GBL_TITLES.length; i++) {
				%><option value="<%= GBL_TITLES[i] %>"<%= C._getCustomerTitle().indexOf(GBL_TITLES[i])==0?" selected=\"selected\"":"" %>><%= GBL_TITLES[i] %></option><%
			}
		%></select></td>
	</tr>
	<tr>
		<td class="required">Firstname</td>
		<td class="required"><input type="text" name="firstname" value="<%= C._getCustomerFirstname() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td class="required">Surname</td>
		<td class="required"><input type="text" name="lastname" value="<%= C._getCustomerLastname() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td>Address</td>
		<td><textarea name="address" rows="3" style="width:200px;"><%= C._getCustomerAddress() %></textarea></td>
	</tr>
	<tr>
		<td>City</td>
		<td><input type="text" name="city" value="<%= C._getCustomerCity() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td>State</td>
		<td><input type="text" name="state" value="<%= C._getCustomerState() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td>Country</td>
		<td><input type="text" name="country" value="<%= C._getCustomerCountry() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td>Postcode</td>
		<td><input type="text" name="postcode" value="<%= C._getCustomerPostcode() %>" style="width:50px;" /></td>
	</tr>
	<tr>
		<td>Date of Birth</td>
		<td><%
		
			var dRef = C._getCustomerDateofbirth();
			if (dRef.length != 0) {
				dRef = new Date(Date.parse(dRef));
			} else {
				dRef = new Date();
			}
			var refDay = dRef.getDate();
			var refMonth = dRef.getMonth();
			var refYear = dRef.getFullYear();
		%>
		<select name="dobDay">
			<option value="0">day...</option><%
			for (var i=1; i <= 31; i++) {
				%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>&nbsp;
		<select name="dobMonth">
			<option value="0">month...</option><%
			for (var i=0; i < 12; i++) {
				%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
			}
		%></select>&nbsp;
		<select name="dobYear">
			<option value="0">year...</option><%
			for (var i=2006; i >= 1920; i--) {
				%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td class="required">Email Address</td>
		<td class="required"><input type="text" name="email" value="<%= C._getCustomerEmail() %>" style="width:200px;" /></td>
	</tr>
	</table>


	<p><input type="submit" name="submit" value="save user" class="button" /></p>


</form>

<!--#include file="_gblFooter.asp"-->
