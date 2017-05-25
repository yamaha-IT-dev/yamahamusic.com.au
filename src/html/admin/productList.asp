<!--#include file="_gblHeader.asp"-->

<div style="float:right;margin-right:200px;">

<h1>Add Products</h1>
<a class="button" href="<%= CONTROLLER %>?action=<%= NEW_PRODUCT %>">Add a new product</a>

</div>


<h1>List All Products</h1>
<form id="searchList" action="<%= CONTROLLER %>" method="post">
	<fieldset>
	<input type="hidden" name="action" value="<%= LIST_PRODUCTS %>" />
<p>Please choose Category:<br/>

<%
	var C = new ProductCategory();
	var rsAllCategories = C._getAllProductCategory();
		%><select name="categoryid" onchange="submitIt();">
		<option value="">Category...</option><%
		if (rsAllCategories && !rsAllCategories.EOF) {
			while (!rsAllCategories.EOF) {
				%><option value="<%= rsAllCategories("id") %>"<%= intCategoryID==parseInt(rsAllCategories("id"))?" selected=\"selected\"":"" %>><%= rsAllCategories("parent") %> : <%= rsAllCategories("name") %></option><%
				rsAllCategories.MoveNext()
			}
		}
		%></select>
		
		&nbsp;<input type="submit" value="go" class="button" style="display:inline;"/></p>
</p>
	</fieldset>
</form>
<script type="text/javascript">
function submitIt() {
	document.forms[0].submit();
}
</script>
<%
	if (rsAllProducts && !rsAllProducts.EOF) {

		%>
		<form action="<%= CONTROLLER %>" method="post">
			<input type="hidden" name="action" value="<%= SET_STATUS %>" />
		
		<table border="0" cellpadding="0" cellspacing="0" width="600px">
		<tr>
			<th></th>
			<th>Itemcode</th>
			<th>Name</th>
			<th>Status</th>
			<th></th>
		</tr>
		<%
		var count = 0;
		var bgcolor = "#FFFFFF";
		var rscount = rsAllProducts.RecordCount;
		while (!rsAllProducts.EOF) {
			%>
			<tr>
				<td style="background-color:<%= bgcolor %>;"><a href="<%= CONTROLLER %>?action=<%= EDIT_PRODUCT %>&productid=<%= rsAllProducts("id") %>" class="button">EDIT</a></td>
				<td style="background-color:<%= bgcolor %>;width:15%;"><strong><%= rsAllProducts("itemcode") %></strong></td>
				<td style="background-color:<%= bgcolor %>;width:85%;"><%= rsAllProducts("name") %></td>
				<td style="background-color:<%= bgcolor %>;text-align:center;">
					<input type="hidden" name="productid" value="<%= rsAllProducts("id") %>" />				
					<input type="checkbox" name="status_<%= rsAllProducts("id") %>" value="1"<%= parseInt(rsAllProducts("status"))==1?" checked=\"checked\"":"" %>
				</td>
				<td style="background-color:<%= bgcolor %>;"><a href="<%= CONTROLLER %>?action=<%= DELETE_PRODUCT %>&productid=<%= rsAllProducts("id") %>" class="button" onclick="return confirm('Are you sure you want to delete this resource?');">DELETE</a></td>
			</tr>
			<%
			bgcolor = bgcolor=="#FFFFFF"?"#EFEFEF":"#FFFFFF";
			count ++;
			rsAllProducts.MoveNext();
		}
		%>
		<tr>
			<td colspan="3" style="text-align:right;">Update product status<br/><em>Checked is active</em></td>
			<td style="text-align:center;"><input type="submit" name="submit" value="set" class="button"/></td>
			<td></td>
		</tr>
		</table>
		</form>
		<%
	} else {
		if (isNaN(intCategoryID)) {
			%><p>Please choose a category.</p><%
		} else {
			%><p>There are no resources.</p><%
		}
	}

%>
<!--#include file="_gblFooter.asp"-->
