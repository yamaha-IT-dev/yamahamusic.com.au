<!--#include file="_gblHeader.asp"-->

<div style="float:left;width:400px;">

<h1><%= P._getProductID()>0?"Edit":"Add" %> Product</h1>

<% 
	if (message.length > 0 && action == SAVE_PRODUCT) {
		%><p class="alert"><%= message %></p><%
	}
%>
<form name="userEditForm" action="<%= CONTROLLER %>" method="post" enctype="multipart/form-data">

	<fieldset>

	<input type="hidden" name="action" value="<%= SAVE_PRODUCT %>" />
	<input type="hidden" name="productid" value="<%= P._getProductID() %>" />
	<input type="hidden" name="userid" value="<%= P._getProductUserID() %>" />

	
	<p><label for="categoryid" class="required">Category</label>
<%
	var C = new ProductCategory();
	var rsAllCategories = C._getAllProductCategory();
		%><select name="categoryid">
		<option value="0">Category...</option><%
		if (rsAllCategories && !rsAllCategories.EOF) {
			while (!rsAllCategories.EOF) {
				%><option value="<%= rsAllCategories("id") %>"<%= P._getProductCategoryID()==parseInt(rsAllCategories("id"))?" selected=\"selected\"":"" %>><%= rsAllCategories("parent") %> : <%= rsAllCategories("name") %></option><%
				rsAllCategories.MoveNext()
			}
		}
		%></select></p>
		
		<p><label for="classification" class="required">Classification</label>
		<select name="classification">
		<option value="">Category...</option><%
		for (i=0; i<ARR_CLASSIFICATION.length; i++)
		{
			%><option value="<%= ARR_CLASSIFICATION[i] %>"<%= P._getProductClassification().indexOf(ARR_CLASSIFICATION[i])==0?" selected=\"selected\"":"" %>><%= ARR_CLASSIFICATION[i] %></option><%
		}
		
		%></select></p>
		
		
		
		<p><label for="itemcode" class="required">Model / Itemcode</label>
		<input type="text" name="itemcode" value="<%= P._getProductItemcode() %>" style="width:200px;"></p>

		<p><label for="name" class="required">Name</label>
		<input type="text" name="name" value="<%= P._getProductName() %>" style="width:200px;"></p>

		<p><label for="descshort" class="required">Short Description</label>
		<textarea name="descshort" rows="2" style="width:300px;"><%= P._getProductDescshort() %></textarea></p>

		<p><label for="desclong" class="required">Long Description</label>
		<textarea name="desclong" rows="5" style="width:300px;"><%= P._getProductDesclong() %></textarea></p>

		<p><label for="filesrclg">File (Main / the big one)</label><div style="padding-left:8em;">
		<% if (P._getProductImagelg().indexOf("null") != 0 && P._getProductImagelg().length != 0) { %><a href="<%= P._getProductImagelg() %>" target="_blank">view this file - <%= P._getProductImagelg() %><br/></a><% } %>
		<input type="file" name="imagelg" value="" size="34" style="width:250px;"/><br/>
		<input type="checkbox" name="imagelg_REMOVE" value="1">&nbsp;Remove this file? - check to have no file.<br/>
		<input type="checkbox" name="imagelg_OVERWRITE" value="1" checked="checked">&nbsp;Overwrite existing file? - check for yes.</div></p>

		<p><label for="filesrclg">File (Preview / the little one!)</label><div style="padding-left:8em;">
		<% if (P._getProductImagesm().indexOf("null") != 0 && P._getProductImagesm().length != 0) { %><a href="<%= P._getProductImagesm() %>" target="_blank">view this file - <%= P._getProductImagesm() %><br/></a><% } %>
		<input type="file" name="imagesm" value="" size="34" style="width:250px;"/><br/>
		<input type="checkbox" name="imagesm_REMOVE" value="1">&nbsp;Remove this file? - check to have no file.<br/>
		<input type="checkbox" name="imagesm_OVERWRITE" value="1" checked="checked">&nbsp;Overwrite existing file? - check for yes.</div></p>

		<div class="clearing"></div>

		<p>&nbsp;</p>

		<p><label for="submit">&nbsp;</label><input type="submit" name="submit" value="save product" class="button" /></p>

	</fieldset>
</form>
</div>

<% 
	if (P._getProductID() > 0) {
%>

<div style="float:left;width:350px;">

<h1>Inventory</h1>

	
	<table border="0" cellpadding="0" cellspacing="0" class="noborder">
<% 
	if (message.length > 0 && action == SAVE_INVENTORY) {
		%><tr>
			<td colspan="7"><p class="alert"><%= message %></p></td>
		</tr><%
	}
%>	<tr>
		<th>Stock</th>
		<th>Itemcode</th>
		<th>Name</th>
		<th>RRP</th>
		<th>Discounted Price</th>
		<th>Promo Price</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
<% 	
	var rsInv = I._getAllInventoryByProduct(P._getProductID());
	var bgcolor = new String("#FFF");
	
	if (rsInv && !rsInv.EOF) {
		while (!rsInv.EOF) {

			if (intInventoryID == parseInt(rsInv("id"))) {
%>
<form action="<%= CONTROLLER %>" method="post">

	<fieldset>

	<input type="hidden" name="action" value="<%= SAVE_INVENTORY %>" />
	<input type="hidden" name="inventoryid" value="<%= rsInv("id") %>" />
	<input type="hidden" name="productid" value="<%= rsInv("productid") %>" />
	<input type="hidden" name="userid" value="<%= rsInv("userid") %>" />

	<tbody>
	<tr>
		<td style="background-color:<%= bgcolor %>;"><input type="text" name="instock" value="<%= rsInv("instock") %>" style="width:30px;" /></td>
		<td style="background-color:<%= bgcolor %>;"><input type="text" name="attribute" value="<%= rsInv("attribute") %>" style="width:50px;" /></td>
		<td style="background-color:<%= bgcolor %>;"><input type="text" name="name" value="<%= rsInv("name") %>" style="width:100px;" /></td>
		<td style="background-color:<%= bgcolor %>;"><input type="text" name="priceretail" value="<%= rsInv("priceretail") %>" style="width:50px;text-align:right;" /></td>
		<td style="background-color:<%= bgcolor %>;"><input type="text" name="pricediscount" value="<%= rsInv("pricediscount") %>" style="width:50px;text-align:right;" /></td>
		<td style="background-color:<%= bgcolor %>;"><input type="text" name="pricepromo" value="<%= rsInv("pricepromo") %>" style="width:50px;text-align:right;" /></td>
		<td><input type="submit" name="submit" value="SAVE" class="button" /></td>
	</tr>
	</tbody>
	</fieldset>
	</form>

<%
			} else {
%>
	<tbody>
	<tr>
		<td style="background-color:<%= bgcolor %>;text-align:right;"><%= rsInv("instock") %></td>
		<td style="background-color:<%= bgcolor %>;"><%= rsInv("attribute") %></td>
		<td style="background-color:<%= bgcolor %>;"><%= rsInv("name") %></td>
		<td style="background-color:<%= bgcolor %>;text-align:right;">$<%= parseFloat(rsInv("priceretail")).toFixed(2) %></td>
		<td style="background-color:<%= bgcolor %>;text-align:right;">$<%= parseFloat(rsInv("pricediscount")).toFixed(2) %></td>
		<td style="background-color:<%= bgcolor %>;text-align:right;">$<%= parseFloat(rsInv("pricepromo")).toFixed(2) %></td>
		<td><a class="button" href="<%= CONTROLLER %>?action=<%= EDIT_PRODUCT %>&amp;productid=<%= P._getProductID() %>&amp;inventoryid=<%= rsInv("id") %>">EDIT</a></td>
		<td><a class="button" href="<%= CONTROLLER %>?action=<%= DELETE_INVENTORY %>&amp;productid=<%= P._getProductID() %>&amp;inventoryid=<%= rsInv("id") %>">DELETE</a></td>
	</tr>
	</tbody>

<%			}
			rsInv.MoveNext();
			bgcolor = bgcolor.indexOf("#FFF")==0?"#EEE":"#FFF";
		}
	}
%>

<form action="<%= CONTROLLER %>" method="post">

	<fieldset>

	<input type="hidden" name="action" value="<%= SAVE_INVENTORY %>" />
	<input type="hidden" name="inventoryid" value="0" />
	<input type="hidden" name="productid" value="<%= P._getProductID() %>" />
	<input type="hidden" name="userid" value="<%= P._getProductUserID() %>" />

	<tbody>
	<tr>
		<th colspan="7">New Inventory Item</th>
	</tr>
<% 
	if (action == EDIT_PRODUCT) {
		I = new Inventory();
	}

%>	
	<tr>
		<td><input type="text" name="instock" value="<%= I._getInventoryInstock() %>" style="width:30px;" /></td>
		<td><input type="text" name="attribute" value="<%= I._getInventoryAttribute() %>" style="width:50px;" /></td>
		<td><input type="text" name="name" value="<%= I._getInventoryName() %>" style="width:100px;" /></td>
		<td><input type="text" name="priceretail" value="<%= I._getInventoryPriceretail() %>" style="width:50px;text-align:right;" /></td>
		<td><input type="text" name="pricediscount" value="<%= I._getInventoryPricediscount() %>" style="width:50px;text-align:right;" /></td>
		<td><input type="text" name="pricepromo" value="<%= I._getInventoryPricepromo() %>" style="width:50px;text-align:right;" /></td>
		<td><input type="submit" name="submit" value="SAVE" class="button" /></td>
	</tr>
	</tbody>
	</fieldset>
	</form>



	</table>

</div>
<% 
	}
%>

<div class="clearing"></div>

<p>&nbsp;</p>


<!--#include file="_gblFooter.asp"-->
