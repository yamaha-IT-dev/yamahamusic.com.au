<!--#include file="global/pageHeader.asp" -->

<h1>Hello <%= C._getCustomerTitle() %>&nbsp;<%= C._getCustomerFirstname() %>&nbsp;<%= C._getCustomerLastname() %></h1>
<% 
	if (message.length > 0) {
		%><%= message %><%
	}
%>
<p style="font-size:1.1em;">Now you can;
	<br/>maintain and <a href="<%= CONTROLLER %>?action=<%= EDIT_CUSTOMER %>">update your details</a>,
	<br/>view your <a href="warranty/default.asp">previous warranty registrations</a>, 
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

<h2>Thanks for joining Yamaha Music Australia</h2>


<!--#include file="global/pageFooter.asp" -->