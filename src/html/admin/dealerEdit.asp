<!--#include file="_gblHeader.asp"-->


<h1>Edit Dealer</h1>

<% 
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>

<form name="userEditForm" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= SAVE_DEALER %>" />
	<input type="hidden" name="dealerid" value="<%= D._getDealerID() %>" />

	<table border="0" cellpadding="0" cellspacing="0" style="float:left;">
	<tr>
		<td class="required">Name</td>
		<td class="required"><input type="text" name="name" value="<%= D._getDealerName() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td class="required">Address</td>
		<td class="required"><textarea name="address" rows="3" style="width:200px;"><%= D._getDealerAddress() %></textarea></td>
	</tr>
	<tr>
		<td class="required">City / Suburb / Town</td>
		<td class="required"><input type="text" name="city" value="<%= D._getDealerCity() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td class="required">State</td>
		<td class="required"><select name="state" style="width:200px;" >
			<option value="">choose state...</option><%
			for (var i=0; i < GBL_STATES_SHORT.length; i++) {
				%><option value="<%= GBL_STATES_SHORT[i] %>"<%= D._getDealerState().indexOf(GBL_STATES_SHORT[i])==0?" selected=\"selected\"":"" %>><%= GBL_STATES_LONG[i] %></option><%
			}
	%></select></td>
	</tr>
	<tr>
		<td class="required">Region</td>
		<td class="required">
			<input type="radio" name="region" value="M"<%= D._getDealerRegion().indexOf("M")==0?" checked=\"checked\"":"" %>/> Metropolitan &nbsp;&nbsp;
			<input type="radio" name="region" value="R"<%= D._getDealerRegion().indexOf("R")==0?" checked=\"checked\"":"" %>/> Regional
		</td>
	</tr>
	<tr>
		<td class="required">Country</td>
		<td class="required"><input type="text" name="country" value="<%= D._getDealerCountry() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td class="required">Postcode</td>
		<td class="required"><input type="text" name="postcode" value="<%= D._getDealerPostcode() %>" style="width:50px;" /></td>
	</tr>
	<tr>
		<td class="required">Phone</td>
		<td class="required"><input type="text" name="phone" value="<%= D._getDealerPhone() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td>Fascimile</td>
		<td><input type="text" name="fax" value="<%= D._getDealerFax() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td>Email Address</td>
		<td><input type="text" name="email" value="<%= D._getDealerEmail() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td>URL</td>
		<td><input type="text" name="url" value="<%= D._getDealerURL() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td></td>
		<td>
		
			<input type="checkbox" name="pronetwork" value="1"<%= D._getDealerPronetwork()==1?" checked=\"checked\"":"" %> />&nbsp;Pro Network Dealer? - Check for YES.<br/>
			
			<input type="checkbox" name="clavplatinum" value="1"<%= D._getDealerClavplatinum()==1?" checked=\"checked\"":"" %> />&nbsp;Clavinova Platinum Dealer? - Check for YES.<br/>

			<input type="checkbox" name="nirprogram" value="1"<%= D._getDealerNirprogram()==1?" checked=\"checked\"":"" %> />&nbsp;New Instrument Rental (Studio 19 Affiliate)? - Check for YES.<br/>
		
		</td>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" name="submit" value="save dealer" class="button" /></td>
	</tr> 
	</table>

	<div style="float:left;margin : 0 100px 50px 20px;"><strong class="required">Product Groups</strong><br/>
<%
		var P = new ProductCategory();
		var arrProducts = P._getAllProductCategorysByDealer(D._getDealerID());

		var rsAllProduct = P._getAllProductCategory();
		if (rsAllProduct && !rsAllProduct.EOF) {
			while (!rsAllProduct.EOF) {
				var blnCatMatch = false;
				for (var i=0; i < arrProducts.length; i++) {
					if (parseInt(arrProducts[i])==parseInt(rsAllProduct("id"))) {
						blnCatMatch = true;
						break;
					}
				}
				%><input type="checkbox" name="productid" value="<%= rsAllProduct("id") %>"<%= blnCatMatch?" checked=\"checked\"":"" %>>&nbsp;<%= rsAllProduct("parent") %> - <%= rsAllProduct("name") %><br/><%
				rsAllProduct.MoveNext()
			}
		}
%>
	</div>


</form>

<!--#include file="_gblFooter.asp"-->
