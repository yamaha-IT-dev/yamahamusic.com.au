<!--#include file="global/pageHeaderLevelOneNav.asp" -->

<h1>Yamaha Service Centres</h1>

<div class="column" style="width:300px;">
	<h2>Service Centre Search</h2>
	<form name="searchForm" action="<%= CONTROLLER %>" method="post">
		<input type="hidden" name="action" value="<%= SERVICE_SEARCH %>" />
	
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td><select name="productid" id="productid">
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
			</select></td>
		</tr>
		<tr>
			<td><select name="state" id="state">
				<option value="all">choose state...</option>
				<option value="all"<%= strState=="all"?" selected=\"selected\"":"" %>>All states</option>
				<% 
				for (var i=0; i < GBL_STATES_SHORT.length; i++) {
					%><option value="<%= GBL_STATES_SHORT[i] %>"<%= strState==GBL_STATES_SHORT[i]?" selected=\"selected\"":"" %>><%= GBL_STATES_LONG[i] %></option><%
				}
			%></select></td>
		</tr>
		<tr>
			<td>
				<input type="text" name="postcode" value="<%= strPostcode %>" style="width:50px;" maxlength="4" /> Postcode
			</td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" name="submit" value="list service centres" class="button" /></td>
		</tr>
		</table>
	
	</form>
</div>
<!--<div class="column">
	
	<h2>New Zealand Customers</h2>
	<p>If you are searching for support and spare parts, please note that there are <a href="new_zealand.asp">local suppliers and service agents</a> for New Zealand.</p>
</div>-->

<% 

if (rsSearch && !rsSearch.EOF) {
	var rsRC = rsSearch.RecordCount;
	var count = 0;
	if (rsRC == -1) {
		rsRC = 0;
		while (!rsSearch.EOF) {
			rsRC++;
			rsSearch.MoveNext();
		}
		rsSearch.MoveFirst();
	}
	%>
 
 <% if (rsSearch("state") == "VIC") { %>
   <img style="margin: 1em 0;" src="../../support/images/banner_exceltech.jpg" 
     alt="Excel Technology: Yamaha's Platinum Authorised Service Centre for Victoria" />
 <% } %>
 
 <h2><%= rsRC %> Service Centres Found</h2><%
	while (!rsSearch.EOF) {
		%><div class="dealer">
		<h3><%= rsSearch("name") %><%= rsSearch("id") %></h3>
		<p><%= rsSearch("address") %><br/>
		<%= rsSearch("city") %>, <%= rsSearch("state") %>&nbsp;&nbsp;<%= rsSearch("postcode") %>
		<%= new String(rsSearch("phone")).indexOf("null")!=0&&new String(rsSearch("phone")).length!=0?"<br/><strong>Ph:</strong> " + rsSearch("phone"):"" %>
		<%= new String(rsSearch("mobile")).indexOf("null")!=0&&new String(rsSearch("mobile")).length!=0?"<br/><strong>Mobile:</strong> " + rsSearch("mobile"):"" %>
		<%= new String(rsSearch("fax")).indexOf("null")!=0&&new String(rsSearch("fax")).length!=0?"<br/><strong>Fax:</strong> " + rsSearch("fax"):"" %>
		<%= new String(rsSearch("email")).indexOf("null")!=0&&new String(rsSearch("email")).length!=0?"<br/><a href=\"mailto:" + rsSearch("email") + "\">" + rsSearch("email") + "</a>":"" %>
		<%= new String(rsSearch("url")).indexOf("null")!=0&&new String(rsSearch("url")).length!=0?"<br/><a href=\"http://" + rsSearch("url") + "\" target=\"_blank\">" + rsSearch("url") + "</a>":"" %>
<% 
	var arrStreet = new String(rsSearch("address")).split(" ");
	var strStreet = new String(arrStreet[0]).toLowerCase().indexOf("shop")==0?arrStreet[2]:arrStreet[1]
%>		
		<br/><a href="http://www.whereis.com/whereis/mapping/geocodeAddress.do?streetName=<%= strStreet %>&suburb=<%= rsSearch("city") %>&state=<%= rsSearch("state") %>" class="whereis" target="whereIs">Locate this service centre on a map</a>
		
		</p>
		</div><%	
		count++
		if (count == 2) {
			%><div class="clearing"></div><%
			count = 0;
		}		
		rsSearch.MoveNext();
	}
}




%>


<!--#include file="global/pageFooter.asp" -->


