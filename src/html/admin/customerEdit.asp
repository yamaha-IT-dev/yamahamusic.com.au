<!--#include file="_gblHeader.asp"-->


<h1>Edit Customer</h1>

<% 
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>

<div style="float:right;margin : 0 10px 0px 10px;">
	<h2>Warranty Registrations</h2>
<% 
	var W = new Warranty();
	
	var intCustomerID = C._getCustomerID();
	var rsAllWarranties = W._getAllWarrantyByCustomer(intCustomerID);

	if (rsAllWarranties != null && !rsAllWarranties.EOF) {
		%><table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<th>Model Number</th>
			<th>Serial Number</th>
			<th>Place of Purchase</th>
			<th>Purchase Price</th>
			<th>Purchase Date</th>
		</tr><%
		while (!rsAllWarranties.EOF) {
			%>
			<tr>
				<td><%= rsAllWarranties("modelnumber") %></td>
				<td><%= rsAllWarranties("serialnumber") %></td>
				<td><%= rsAllWarranties("purchaseplace") %></td>
				<td><%= rsAllWarranties("purchaseprice") %></td>
				<td><%= new Date(rsAllWarranties("purchasedate")).formatDate("jS F Y") %></td>
			</tr><%
			rsAllWarranties.MoveNext();	
		}
		%></table><%
	} else {
		%><p>This customer has no previous warranty registrations</p><%
	}




%>
<p>&nbsp;</p>

</div>

<form name="userEditForm" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= SAVE_CUSTOMER %>" />
	<input type="hidden" name="customerid" value="<%= C._getCustomerID() %>" />
	<input type="hidden" name="checkemail" value="<%= C._getCustomerEmail() %>" />

	<h2>Customer Details</h2>

	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td style="width:150px;" class="required">Title, Firstname</td>
		<td class="required"><select name="title" style="width:50px;">
			<option value="">...</option><%
			for (var i=1; i < GBL_TITLES.length; i++) {
				%><option value="<%= GBL_TITLES[i] %>"<%= C._getCustomerTitle().indexOf(GBL_TITLES[i])==0?" selected=\"selected\"":"" %>><%= GBL_TITLES[i] %></option><%
			}
		%></select>&nbsp;
		<input type="text" name="firstname" value="<%= C._getCustomerFirstname() %>" style="width:143px;" /></td>
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
		<td>City / Suburb / Town</td>
		<td><input type="text" name="city" value="<%= C._getCustomerCity() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td><strong>State</strong></td>
		<td><select name="state" style="width:200px;" >
			<option value="">choose state...</option><%
			for (var i=0; i < GBL_STATES_SHORT.length; i++) {
				%><option value="<%= GBL_STATES_SHORT[i] %>"<%= C._getCustomerState().indexOf(GBL_STATES_SHORT[i])==0?" selected=\"selected\"":"" %>><%= GBL_STATES_LONG[i] %></option><%
			}
		%></select></td>
	</tr>
	<tr>
		<td>Country</td>
		<td><input type="text" name="country" value="<%= C._getCustomerCountry() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td class="required">Postcode</td>
		<td class="required"><input type="text" name="postcode" value="<%= C._getCustomerPostcode() %>" style="width:50px;" /></td>
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
		<td class="required">Email Address</td>
		<td class="required"><input type="text" name="email" value="<%= C._getCustomerEmail() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td class="required">Password</td>
		<td class="required"><input type="password" name="password" value="<%= C._getCustomerPassword() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td class="required" colspan="2">
			<h2>Email Updates</h2>
		</td>
	</tr>
	<tr>
		<td colspan="2"><input type="checkbox" name="optinnews" value="1" <%= C._getCustomerOptinnews()==1?" checked=\"checked\"":"" %> /> Check this to be sent News and Event information about Yamaha Music Australia.</td>
	</tr>
	<tr>
		<td colspan="2"><input type="checkbox" name="optinproduct" value="1" <%= C._getCustomerOptinproduct()==1?" checked=\"checked\"":"" %> /> Check this to be notified of new Yamaha Product releases.</td>
	</tr>
	<tr>
		<td colspan="2"><input type="checkbox" name="optinyaypc" value="1" <%= C._getCustomerOptinyaypc()==1?" checked=\"checked\"":"" %> /> Check this to be notified of announcements for the Yamaha Australia Youth Piano Competition.</td>
	</tr>
	</table>


	<p><input type="submit" name="submit" value="save customer" class="button" /><% 
	
	if (!isNaN(C._getCustomerID())) {
		%></form>&nbsp;
		
		<form name="customerToUser" action="ctrlUser.asp" method="post">
		<input type="hidden" name="action" value="promote_customer" />
		<input type="hidden" name="customerid" value="<%= C._getCustomerID() %>" />
		
		<p>If this individual is to gain access to certain privileged areas of<br/> 
		 the yamahamusic.com.au site they will need to be 'promoted' to users.<br/>
		 Their user type will determine which areas they are permitted to access.</p>
		<input type="submit" name="submit" value="create user account" class="button"/>
		
		</form><%
	}
	
	%></p>


</form>


<!--#include file="_gblFooter.asp"-->
