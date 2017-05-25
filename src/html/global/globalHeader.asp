<div id="header">
	<div id="customer">
<% 
	var intCustomerID = Session("yma_customerid");

	if (intCustomerID > 0) {
		var C = new Customer();
			C._loadCustomer(intCustomerID);
%>
		<p>Logged in as: <%= C._getCustomerFirstname() %> | <a href="teachers.asp?action=teacher_logout">Log out</a></p>
<% 	
	}
%>
	</div>
</div>