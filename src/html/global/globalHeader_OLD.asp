<div id="header">
	<div id="customer">
<% 

	var intCustomerID = Session("yma_customerid");

	if (intCustomerID > 0) {
		var C = new Customer();
			C._loadCustomer(intCustomerID);
%>
		<h1 style="color:#000">Hello <%= C._getCustomerFirstname() %></h1>
		Welcome back to the Yamaha Music Australia website<br/>
		<a href="/warranty/default.asp">Register your warranties</a>, <a href="/customer.asp?action=edit_customer">Update your details</a>, <a href="/customer.asp?action=customer_logout">Log out</a>
<% 
	} else {
%>
		<form id="loginForm" action="/customer.asp" method="post">
			<fieldset>
			<input type="hidden" name="action" value="customer_login" />
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="2"><h1>Login</h1></td>
			</tr>
			<tr>
				<td>Email address</td>
				<td>Password</td>
			</tr>
			<tr>
				<td><input type="text" name="email" value="" maxlength="250" style="width:120px" disabled="disabled" /></td>
				<td><input type="password" name="password" value="" maxlength="12" style="width:50px;" disabled="disabled" /></td>
				<td><input type="submit" name="submit" value="go" class="button" disabled="disabled" /></td>
			</tr>
			</table>
			</fieldset>
		</form>
<% 
	}
%>
	</div>
</div>