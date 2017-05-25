<% 

if (!Session("yma_customerid")
	&& new String(Request("action")).indexOf("edit_customer") == 0 
	) {

	Response.Redirect("customer.asp");
}


%>

