<!--#include file="_gblHeader.asp"-->


<h1>Edit Service Centre</h1>

<% 
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>

<form name="userEditForm" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= SAVE_SERVICE %>" />
	<input type="hidden" name="serviceid" value="<%= S._getServiceID() %>" />

	<p><input type="checkbox" name="rctiflag" value="1"<%= S._getServiceRCTIflag()==1?" checked=\"checked\"":"" %> /><label for="rctiflag">Do we issue this Service Centre <acronym title="Recipient Created Tax Invoices">RCTI</acronym>'s ? - check for yes</label></p>

	<table border="0" cellpadding="0" cellspacing="0" style="float:left;">
	<tr>
		<td class="required">ABN</td>
		<td class="required"><input type="text" name="abn" value="<%= S._getServiceABN() %>" maxlength="50" style="width:200px;" /></td>
	</tr>
	<tr>
		<td class="required">Vendor Code</td>
		<td class="required"><input type="text" name="vendorcode" value="<%= S._getServiceVendorcode() %>" maxlength="8" style="width:200px;" /></td>
	</tr>
	<tr>
		<td class="required">Dealer Code</td>
		<td class="required"><input type="text" name="dealercode" value="<%= S._getServiceDealercode() %>" maxlength="10" style="width:200px;" /></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td class="required">Name</td>
		<td class="required"><input type="text" name="name" value="<%= S._getServiceName() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td class="required">Address</td>
		<td class="required"><textarea name="address" rows="3" style="width:200px;"><%= S._getServiceAddress() %></textarea></td>
	</tr>
	<tr>
		<td class="required">City / Suburb / Town</td>
		<td class="required"><input type="text" name="city" value="<%= S._getServiceCity() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td class="required">State</td>
		<td class="required"><select name="state" style="width:200px;" >
			<option value="">choose state...</option><%
			for (var i=0; i < GBL_STATES_SHORT.length; i++) {
				%><option value="<%= GBL_STATES_SHORT[i] %>"<%= S._getServiceState().indexOf(GBL_STATES_SHORT[i])==0?" selected=\"selected\"":"" %>><%= GBL_STATES_LONG[i] %></option><%
			}
	%></select></td>
	</tr>
	<tr>
		<td class="required">Country</td>
		<td class="required"><input type="text" name="country" value="<%= S._getServiceCountry() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td class="required">Postcode</td>
		<td class="required"><input type="text" name="postcode" value="<%= S._getServicePostcode() %>" style="width:50px;" /></td>
	</tr>
	<tr>
		<td class="required">Phone</td>
		<td class="required"><input type="text" name="phone" value="<%= S._getServicePhone() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td>Mobile</td>
		<td><input type="text" name="mobile" value="<%= S._getServiceMobile() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td>Fascimile</td>
		<td><input type="text" name="fax" value="<%= S._getServiceFax() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td>Email Address</td>
		<td><input type="text" name="email" value="<%= S._getServiceEmail() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td>URL</td>
		<td><input type="text" name="url" value="<%= S._getServiceURL() %>" style="width:200px;" /></td>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" name="submit" value="save service" class="button" /></td>
	</tr> 
	</table>

	<div style="float:left;margin : 0 100px 50px 20px;"><strong class="required">Product Groups</strong><br/>
<%
		var P = new ProductCategory();
		var arrProducts = P._getAllProductCategorysByService(S._getServiceID());

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
