<!--#include file="global/pageHeader.asp" -->

<% 
	if (Session("yma_customerid") > 0) {
%>

		<h1>Hello <%= C._getCustomerTitle() %>&nbsp;<%= C._getCustomerFirstname() %>&nbsp;<%= C._getCustomerLastname() %></h1>

<p style="font-size:1.1em;">Now you can;
	<br/>maintain and <a href="<%= CONTROLLER %>?action=<%= EDIT_CUSTOMER %>">update your details</a>,
	<br/>view your <a href="warranty/default.asp?action=warranty_list">previous warranty registrations</a>, 
	<br/>or submit a <a href="warranty/default.asp">new product warranty</a>.
</p>
<% 
	if (C._getCustomerOptinteacher() == 1)
	{
		%><div id="teacher_resources">
		
			<h2>Teacher Resources</h2>
			<p>As a teacher you are welcome to access the following teaching resource<br/>
			<a href="products/musicalinstruments/JamesMorrisonWorksheet.pdf" class="pdf">James Morrison Worksheet</a> [PDF 750Kb]</p>
		
		</div><%
	}

%>

<%
if (strreferrer.indexOf("undefined")!=0 && !strreferrer.indexOf("/customer.asp") > 0 ) {
	%><h2>You can also return to the <a href="<%= strreferrer %>">last page you were viewing</a></h2><% 
} else {
	%><h2>Return to our <a href="home.asp">home page</a></h2><% 
}

%>
		<p>&nbsp;</p>

		<h3>It is great to have you visiting Yamaha Music Australia again.</h3>


<% 
	} else {

%>
<h1>Register as a Yamaha Music Australia Customer.</h1>

<h2>Take advantage of our online warranty registration, 
become a member of our online community and sign up to receive 
updates on your favourite products.</h2>

<p>There are many advantages to registering yourself as a 
customer, we've mentioned only a few, but once you're a part
of the huge Yamaha community of audiophiles, musicians and artists
you become part of a great tradition.</p>

<p><a href="customer.asp?action=new_customer" class="button">Register as a Yamaha Customer now</a></p>

<p>&nbsp;</p>

<h2>Existing Customer Log In</h2>
<% 
	if (message.length > 0 && action == CUSTOMER_LOGIN) {
		%><p class="alert"><%= message %></p><%
	}
%>
<form name="loginForm" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= CUSTOMER_LOGIN %>" />

	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>email address</td>
		<td><input type="text" name="email" value="<%= C._getCustomerEmail() %>" /></td>
	</tr>
	<tr>
		<td>password</td>
		<td><input type="password" name="password" value="<%= C._getCustomerPassword() %>" /></td>
	</tr>
	</table>
	
	<p><input type="submit" name="submit" value="log in" class="button" /></p>

</form>

<h2>Forgotten your password?</h2>
<% 
	if (message.length > 0 && action == SEND_PASSWORD) {
		%><p class="alert"><%= message %></p><%
	}
%>
<form name="loginForm" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= SEND_PASSWORD %>" />

	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>email address</td>
		<td><input type="text" name="email" value="<%= action==SEND_PASSWORD?Request("email"):"" %>" /></td>
	</tr>
	</table>
	
	<p><input type="submit" name="submit" value="send me my password" class="button" /></p>

</form>





<% 
	}
%>


<!--#include file="global/pageFooter.asp" -->
