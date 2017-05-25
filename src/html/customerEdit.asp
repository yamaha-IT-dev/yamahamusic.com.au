<!--#include file="global/pageHeaderWideBody.asp" -->

<h1>Edit Customer Details</h1>

<% 
	if (message.length > 0) {
		%><%= message %><%
	}
%>

<form name="userEditForm" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= SAVE_CUSTOMER %>" />
	<input type="hidden" name="return" value="<%= strReturn %>" />
	<input type="hidden" name="customerid" value="<%= C._getCustomerID() %>" />
	<input type="hidden" name="checkemail" value="<%= C._getCustomerEmail() %>" />

	<table border="0" cellpadding="0" cellspacing="0" style="float:left;width:350px;">
	<tr>
		<td style="width:110px;" class="required"><strong>Title, Firstname</strong></td>
		<td class="required"><select name="title" style="width:50px;">
			<option value="">...</option><%
			for (var i=1; i < GBL_TITLES.length; i++) {
				%><option value="<%= GBL_TITLES[i] %>"<%= C._getCustomerTitle().indexOf(GBL_TITLES[i])==0?" selected=\"selected\"":"" %>><%= GBL_TITLES[i] %></option><%
			}
		%></select>&nbsp;
		<input type="text" name="firstname" value="<%= C._getCustomerFirstname() %>" maxlength="100" style="width:143px;" /></td>
	</tr>
	<tr>
		<td class="required"><strong>Surname</strong></td>
		<td class="required"><input type="text" name="lastname" value="<%= C._getCustomerLastname() %>" maxlength="100" style="width:200px;" /></td>
	</tr>
	<tr>
		<td><strong>Address</strong></td>
		<td><textarea name="address" rows="3" style="width:200px;"><%= C._getCustomerAddress() %></textarea></td>
	</tr>
	<tr>
		<td><strong>City</strong></td>
		<td><input type="text" name="city" value="<%= C._getCustomerCity() %>" maxlength="250" style="width:200px;" /></td>
	</tr>
	<tr>
		<td><strong>State</strong></td>
		<td><select name="state" style="width:200px;">
			<option value="">Please select a state...</option><%
			for (var i=0; i < GBL_STATES_SHORT.length; i++) {
				%><option value="<%= GBL_STATES_SHORT[i] %>"<%= C._getCustomerState().indexOf(GBL_STATES_SHORT[i])==0?" selected=\"selected\"":"" %>><%= GBL_STATES_LONG[i] %></option><%
			}
		%></select></td>
	</tr>
	<tr>
		<td><strong>Country</strong></td>
		<td>
        <select name="country" style="width:200px;">
			<option value="">Please select a country...</option><%
			for (var i=0; i < GBL_COUNTRIES.length; i++) {
				%><option value="<%= GBL_COUNTRIES[i] %>"<%= C._getCustomerCountry().indexOf(GBL_COUNTRIES[i])==0?" selected=\"selected\"":"" %>><%= GBL_COUNTRIES[i] %></option><%
			}
		%></select>
        </td>
	</tr>
	<tr>
		<td class="required"><strong>Postcode</strong></td>
		<td class="required"><input type="text" name="postcode" value="<%= C._getCustomerPostcode() %>" style="width:50px;" maxlength="8" /></td>
	</tr>
		<tr>
			<td><strong>Phone No</strong></td>
			<td><input type="text" name="phone" value="<%= C._getCustomerPhone() %>" style="width:100px;" /></td>
		</tr>
	<tr>
		<td><strong>Date of Birth</strong></td>
		<td><%
		
			var dRef = C._getCustomerDateofbirth();
			if (dRef.length != 0) {
				dRef = new Date(Date.parse(dRef));
			} else {
				dRef = new Date();
			}
			var refDay = dRef.getDate();
			var refMonth = dRef.getMonth();
			var refYear = dRef.getFullYear();
		%>
		<select name="dobDay">
			<option value="0">day...</option><%
			for (var i=1; i <= 31; i++) {
				%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>&nbsp;
		<select name="dobMonth">
			<option value="0">month...</option><%
			for (var i=0; i < 12; i++) {
				%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
			}
		%></select>&nbsp;
		<select name="dobYear">
			<option value="0">year...</option><%
			for (var i=2006; i >= 1920; i--) {
				%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>
		</td>
	</tr>
	<tr>
		<td class="required"><strong>Email Address</strong></td>
		<td class="required"><input type="text" name="email" value="<%= C._getCustomerEmail() %>" style="width:200px;"  maxlength="250"/></td>
	</tr>
	<tr>
		<td class="required"><strong>Password</strong></td>
		<td class="required"><input type="password" name="password" value="<%= C._getCustomerPassword() %>"  maxlength="12" style="width:200px;" /></td>
	</tr>
	<tr>
		<td class="required" colspan="2">
			<h2>Email Updates</h2>
			From time to time Yamaha Music Australia might send out an email updating customers about Yamaha Music Australia news &amp events and the Yamaha product range. Do you wish to receive these notices?
		</td>
	</tr>
	<tr>
		<td class="required" colspan="2"><input type="checkbox" name="optinnews" style="float:left;margin:0 5px 20px 0;" value="1" <%= C._getCustomerOptinnews()==1?" checked=\"checked\"":"" %> /> Check this to be sent News and Event information about Yamaha Music Australia.</td>
	</tr>
	<tr>
		<td class="required" colspan="2"><input type="checkbox" name="optinproduct" style="float:left;margin:0 5px 20px 0;" value="1" <%= C._getCustomerOptinproduct()==1?" checked=\"checked\"":"" %> /> Check this to be notified of new Yamaha Product releases.</td>
	</tr>
	<tr>
		<td class="required" colspan="2"><input type="checkbox" name="optinteacher" style="float:left;margin:0 5px 20px 0;" value="1" <%= C._getCustomerOptinteacher()==1?" checked=\"checked\"":"" %> /> Check this to receive information regarding Yamaha band &amp; orchestral workshops, professional development sessions and band director workshops.</td>
	</tr>
	</table>

	<div style="float:left;margin : 0 10px 0px 10px;">
		<h2>Products</h2>
		<p>Choose the product areas which interest you<br/>
		the most, you can select more than one.</p>
<%
		var P = new ProductCategory();
		var arrProducts = P._getAllProductCategorysByCustomer(C._getCustomerID());

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
				%><input type="checkbox" name="productid" value="<%= rsAllProduct("id") %>"<%= blnCatMatch?" checked=\"checked\"":"" %>><%= rsAllProduct("name") %><br/><%
				rsAllProduct.MoveNext()
			}
		}
%>	
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	</div>
	
	<div class="clearing"></div>
	
	<p><input type="submit" name="submit" value="<%= C._getCustomerID()==0?"Save your details":"Update your details" %>" class="button" /></p>


</form>

<!--#include file="global/pageFooter.asp" -->