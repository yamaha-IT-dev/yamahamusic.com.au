<!--#include file="_gblHeader.asp" -->

<h1>Yamaha Service Centre</h1>


<h2>Service Search</h2>
<form name="searchForm" action="<%= CONTROLLER %>" method="post">

	<select name="productid">
			<option value="0">choose product category...</option>
			<option value="0"<%= parseInt(intProductID)==0?" selected=\"selected\"":"" %>>Any product category</option>
			<% 
			var rsAllProduct = P._getAllProductCategory();
			if (rsAllProduct && !rsAllProduct.EOF) {
				while (!rsAllProduct.EOF) {
					%><option value="<%= rsAllProduct("id") %>"<%= parseInt(intProductID)==rsAllProduct("id")?" selected=\"selected\"":"" %>><%= rsAllProduct("parent") %> - <%= rsAllProduct("name") %></option><%
					rsAllProduct.MoveNext();
				}
			}
		%>
	</select><br/>
	
	<select name="state">
			<option value="">choose state...</option><%
			for (var i=0; i < GBL_STATES_SHORT.length; i++) {
				%><option value="<%= GBL_STATES_SHORT[i] %>"<%= strState==GBL_STATES_SHORT[i]?" selected=\"selected\"":"" %>><%= GBL_STATES_LONG[i] %></option><%
			}
	%></select><br/>

	<p><input type="submit" name="submit" value="list services" class="button" /></p>

</form>
<p>&nbsp;</p>
<% 

if (rsServiceSearch && !rsServiceSearch.EOF) {
	var rsRC = rsServiceSearch.RecordCount;
	var count = 0;
	if (rsRC == -1) {
		rsRC = 0;
		while (!rsServiceSearch.EOF) {
			rsRC++;
			rsServiceSearch.MoveNext();
		}
		rsServiceSearch.MoveFirst();
	}
	%><h2><%= rsRC %> Services Found</h2>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<th></th>
		<th style="width:25%;">Name</th>
		<th style="width:65%;">City, State</th>
		<th></th>
	</tr>
	<%
	while (!rsServiceSearch.EOF) { %>
		<tr>
			<td><a href="<%= CONTROLLER %>?action=<%= EDIT_SERVICE %>&serviceid=<%= rsServiceSearch("id") %>" class="button">EDIT</a></td>
			<td><%= rsServiceSearch("name") %></td>
			<td><%= rsServiceSearch("address") %> - <%= rsServiceSearch("city") %>&nbsp;<%= rsServiceSearch("state") %></td>
			<td><a href="<%= CONTROLLER %>?action=<%= DELETE_SERVICE %>&serviceid=<%= rsServiceSearch("id") %>" class="button" onclick="return confirm('Are you sure you want to delete this service?');">DELETE</a></td>
		</tr><%	
		rsServiceSearch.MoveNext();
	}
	%></table><%
}




%>


<!--#include file="_gblFooter.asp" -->


