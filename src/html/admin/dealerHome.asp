<!--#include file="_gblHeader.asp" -->

<h1>Yamaha Dealers</h1>


<h2>Dealer Search</h2>
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


	<input type="radio" name="region" value=""<%= strRegion==""?" checked=\"checked\"":"" %>/> All Areas &nbsp;&nbsp;
	<input type="radio" name="region" value="M"<%= strRegion=="M"?" checked=\"checked\"":"" %>/> Metropolitan &nbsp;&nbsp;
	<input type="radio" name="region" value="R"<%= strRegion=="R"?" checked=\"checked\"":"" %>/> Regional


	<input type="submit" name="submit" value="list dealers" class="button" />

</form>
<p>&nbsp;</p>
<% 

if (rsDealerSearch && !rsDealerSearch.EOF) {
	var rsRC = rsDealerSearch.RecordCount;
	var count = 0;
	if (rsRC == -1) {
		rsRC = 0;
		while (!rsDealerSearch.EOF) {
			rsRC++;
			rsDealerSearch.MoveNext();
		}
		rsDealerSearch.MoveFirst();
	}
	%><h2><%= rsRC %> Dealers Found</h2>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<th></th>
		<th style="width:25%;">Name</th>
		<th style="width:65%;">City, State</th>
		<th></th>
	</tr>
	<%
	while (!rsDealerSearch.EOF) { %>
		<tr>
			<td><a href="<%= CONTROLLER %>?action=<%= EDIT_DEALER %>&dealerid=<%= rsDealerSearch("id") %>" class="button">EDIT</a></td>
			<td><%= rsDealerSearch("name") %></td>
			<td><%= rsDealerSearch("address") %> - <%= rsDealerSearch("city") %>&nbsp;<%= rsDealerSearch("state") %></td>
			<td><a href="<%= CONTROLLER %>?action=<%= DELETE_DEALER %>&dealerid=<%= rsDealerSearch("id") %>" class="button" onclick="return confirm('Are you sure you want to delete this dealer?');">DELETE</a></td>
		</tr><%	
		rsDealerSearch.MoveNext();
	}
	%></table><%
}




%>


<!--#include file="_gblFooter.asp" -->


